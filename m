Return-Path: <netdev+bounces-37973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F250F7B81EB
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 16:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 128271C20837
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 14:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A729171B0;
	Wed,  4 Oct 2023 14:14:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33495168AF
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 14:14:20 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A848C6;
	Wed,  4 Oct 2023 07:14:18 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qo2dh-0002LQ-9N; Wed, 04 Oct 2023 16:14:13 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	David Ward <david.ward@ll.mit.edu>
Subject: [PATCH net 1/6] netfilter: nft_payload: rebuild vlan header on h_proto access
Date: Wed,  4 Oct 2023 16:13:45 +0200
Message-ID: <20231004141405.28749-2-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004141405.28749-1-fw@strlen.de>
References: <20231004141405.28749-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

nft can perform merging of adjacent payload requests.
This means that:

ether saddr 00:11 ... ether type 8021ad ...

is a single payload expression, for 8 bytes, starting at the
ethernet source offset.

Check that offset+length is fully within the source/destination mac
addersses.

This bug prevents 'ether type' from matching the correct h_proto in case
vlan tag got stripped.

Fixes: de6843be3082 ("netfilter: nft_payload: rebuild vlan header when needed")
Reported-by: David Ward <david.ward@ll.mit.edu>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_payload.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 8cb800989947..120f6d395b98 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -154,6 +154,17 @@ int nft_payload_inner_offset(const struct nft_pktinfo *pkt)
 	return pkt->inneroff;
 }
 
+static bool nft_payload_need_vlan_copy(const struct nft_payload *priv)
+{
+	unsigned int len = priv->offset + priv->len;
+
+	/* data past ether src/dst requested, copy needed */
+	if (len > offsetof(struct ethhdr, h_proto))
+		return true;
+
+	return false;
+}
+
 void nft_payload_eval(const struct nft_expr *expr,
 		      struct nft_regs *regs,
 		      const struct nft_pktinfo *pkt)
@@ -172,7 +183,7 @@ void nft_payload_eval(const struct nft_expr *expr,
 			goto err;
 
 		if (skb_vlan_tag_present(skb) &&
-		    priv->offset >= offsetof(struct ethhdr, h_proto)) {
+		    nft_payload_need_vlan_copy(priv)) {
 			if (!nft_payload_copy_vlan(dest, skb,
 						   priv->offset, priv->len))
 				goto err;
-- 
2.41.0


