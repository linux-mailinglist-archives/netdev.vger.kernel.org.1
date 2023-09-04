Return-Path: <netdev+bounces-31911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1EF7915B7
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 12:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8B6280ABC
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8798AA45;
	Mon,  4 Sep 2023 10:32:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB4381
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 10:32:42 +0000 (UTC)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:101:465::204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956AF0;
	Mon,  4 Sep 2023 03:32:41 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4RfQ1v5SXSz9snZ;
	Mon,  4 Sep 2023 12:32:35 +0200 (CEST)
From: Marcello Sylvester Bauer <email@web.codeaurora.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Marcello Sylvester Bauer <sylv@sylv.io>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] xfrm: Use skb_mac_header_was_set() to check for MAC header presence
Date: Mon,  4 Sep 2023 12:32:08 +0200
Message-ID: <0490137bbc24e95eadf01bed9c31eb1d0a856a21.1693823464.git.sylv@sylv.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RfQ1v5SXSz9snZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Marcello Sylvester Bauer <sylv@sylv.io>

Add skb_mac_header_was_set() in xfrm4_remove_tunnel_encap() and
xfrm6_remove_tunnel_encap() to detect the presence of a MAC header.
This change prevents a kernel page fault on a non-zero mac_len when the
mac_header is not set.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 net/xfrm/xfrm_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index d5ee96789d4b..6d74bfa1e6e8 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -250,7 +250,7 @@ static int xfrm4_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)

 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
-	if (skb->mac_len)
+	if (skb->mac_len && skb_mac_header_was_set(skb))
 		eth_hdr(skb)->h_proto = skb->protocol;

 	err = 0;
@@ -287,7 +287,7 @@ static int xfrm6_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)

 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
-	if (skb->mac_len)
+	if (skb->mac_len && skb_mac_header_was_set(skb))
 		eth_hdr(skb)->h_proto = skb->protocol;

 	err = 0;
--
2.42.0


