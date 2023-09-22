Return-Path: <netdev+bounces-35908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A70B7ABAD6
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 23:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C26C7281F85
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 21:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEB047360;
	Fri, 22 Sep 2023 21:04:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1E0323E
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 21:04:47 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67349AC;
	Fri, 22 Sep 2023 14:04:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9AAC4C0002;
	Fri, 22 Sep 2023 21:04:40 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Madhu Koriginja <madhu.koriginja@nxp.com>,
	Frode Nordahl <frode.nordahl@canonical.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net] ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling
Date: Fri, 22 Sep 2023 23:04:58 +0200
Message-ID: <20230922210530.2045146-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 300
X-GND-Status: SPAM
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit b0e214d21203 ("netfilter: keep conntrack reference until
IPsecv6 policy checks are done") is a direct copy of the old
commit b59c270104f0 ("[NETFILTER]: Keep conntrack reference until
IPsec policy checks are done") but for IPv6.  However, it also
copies a bug that this old commit had.  That is: when the third
packet of 3WHS connection establishment contains payload, it is
added into socket receive queue without the XFRM check and the
drop of connection tracking context.

That leads to nf_conntrack module being impossible to unload as
it waits for all the conntrack references to be dropped while
the packet release is deferred in per-cpu cache indefinitely, if
not consumed by the application.

The issue for IPv4 was fixed in commit 6f0012e35160 ("tcp: add a
missing nf_reset_ct() in 3WHS handling") by adding a missing XFRM
check and correctly dropping the conntrack context.  However, the
issue was introduced to IPv6 code afterwards.  Fixing it the
same way for IPv6 now.

Fixes: b0e214d21203 ("netfilter: keep conntrack reference until IPsecv6 policy checks are done")
Link: https://lore.kernel.org/netdev/d589a999-d4dd-2768-b2d5-89dec64a4a42@ovn.org/
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/ipv6/tcp_ipv6.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3a88545a265d..44b6949d72b2 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1640,9 +1640,12 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		struct sock *nsk;
 
 		sk = req->rsk_listener;
-		drop_reason = tcp_inbound_md5_hash(sk, skb,
-						   &hdr->saddr, &hdr->daddr,
-						   AF_INET6, dif, sdif);
+		if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
+			drop_reason = SKB_DROP_REASON_XFRM_POLICY;
+		else
+			drop_reason = tcp_inbound_md5_hash(sk, skb,
+							   &hdr->saddr, &hdr->daddr,
+							   AF_INET6, dif, sdif);
 		if (drop_reason) {
 			sk_drops_add(sk, skb);
 			reqsk_put(req);
@@ -1689,6 +1692,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			}
 			goto discard_and_relse;
 		}
+		nf_reset_ct(skb);
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
-- 
2.41.0


