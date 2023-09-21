Return-Path: <netdev+bounces-35593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A167A9D9B
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD511C20A70
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4AB182BB;
	Thu, 21 Sep 2023 19:42:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC6B18058
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:42:29 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C061481D;
	Thu, 21 Sep 2023 12:42:27 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32ABE1BF203;
	Thu, 21 Sep 2023 19:42:22 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next v2] openvswitch: reduce stack usage in do_execute_actions
Date: Thu, 21 Sep 2023 21:42:35 +0200
Message-ID: <20230921194314.1976605-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

do_execute_actions() function can be called recursively multiple
times while executing actions that require pipeline forking or
recirculations.  It may also be re-entered multiple times if the packet
leaves openvswitch module and re-enters it through a different port.

Currently, there is a 256-byte array allocated on stack in this
function that is supposed to hold NSH header.  Compilers tend to
pre-allocate that space right at the beginning of the function:

     a88:       48 81 ec b0 01 00 00    sub    $0x1b0,%rsp

NSH is not a very common protocol, but the space is allocated on every
recursive call or re-entry multiplying the wasted stack space.

Move the stack allocation to push_nsh() function that is only used
if NSH actions are actually present.  push_nsh() is also a simple
function without a possibility for re-entry, so the stack is returned
right away.

With this change the preallocated space is reduced by 256 B per call:

     b18:       48 81 ec b0 00 00 00    sub    $0xb0,%rsp

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---

Version 2:
  - Added 'noinline_for_stack' to avoid potential inlining. [Eric]

 net/openvswitch/actions.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 5f8094acd056..6fcd7e2ca81f 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -311,11 +311,18 @@ static int push_eth(struct sk_buff *skb, struct sw_flow_key *key,
 	return 0;
 }
 
-static int push_nsh(struct sk_buff *skb, struct sw_flow_key *key,
-		    const struct nshhdr *nh)
+static noinline_for_stack int push_nsh(struct sk_buff *skb,
+				       struct sw_flow_key *key,
+				       const struct nlattr *a)
 {
+	u8 buffer[NSH_HDR_MAX_LEN];
+	struct nshhdr *nh = (struct nshhdr *)buffer;
 	int err;
 
+	err = nsh_hdr_from_nlattr(a, nh, NSH_HDR_MAX_LEN);
+	if (err)
+		return err;
+
 	err = nsh_push(skb, nh);
 	if (err)
 		return err;
@@ -1439,17 +1446,9 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			err = pop_eth(skb, key);
 			break;
 
-		case OVS_ACTION_ATTR_PUSH_NSH: {
-			u8 buffer[NSH_HDR_MAX_LEN];
-			struct nshhdr *nh = (struct nshhdr *)buffer;
-
-			err = nsh_hdr_from_nlattr(nla_data(a), nh,
-						  NSH_HDR_MAX_LEN);
-			if (unlikely(err))
-				break;
-			err = push_nsh(skb, key, nh);
+		case OVS_ACTION_ATTR_PUSH_NSH:
+			err = push_nsh(skb, key, nla_data(a));
 			break;
-		}
 
 		case OVS_ACTION_ATTR_POP_NSH:
 			err = pop_nsh(skb, key);
-- 
2.41.0


