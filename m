Return-Path: <netdev+bounces-31763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC827790094
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 18:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7F01C20908
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B7EC141;
	Fri,  1 Sep 2023 16:14:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B38F5F
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 16:14:50 +0000 (UTC)
X-Greylist: delayed 443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Sep 2023 09:14:48 PDT
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:101:465::204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28FFE5F;
	Fri,  1 Sep 2023 09:14:48 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4RcjbZ09hHz9sQm;
	Fri,  1 Sep 2023 18:07:22 +0200 (CEST)
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
Subject: [PATCH v1 1/1] xfrm: Use skb_mac_header_was_set() to check for MAC header presence
Date: Fri,  1 Sep 2023 18:07:10 +0200
Message-ID: <acb58c1adc02d0b949d8371933b2afe3c056c33f.1693583786.git.sylv@sylv.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Marcello Sylvester Bauer <sylv@sylv.io>

Replace skb->mac_len with skb_mac_header_was_set() in
xfrm4_remove_tunnel_encap() and xfrm6_remove_tunnel_encap() to detect
the presence of a MAC header. This change prevents a kernel page fault
that could occur when a MAC address is added to an L3 interface using
xfrm.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 net/xfrm/xfrm_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index d5ee96789d4b..afa1f1052065 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -250,7 +250,7 @@ static int xfrm4_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)

 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
-	if (skb->mac_len)
+	if (skb_mac_header_was_set(skb))
 		eth_hdr(skb)->h_proto = skb->protocol;

 	err = 0;
@@ -287,7 +287,7 @@ static int xfrm6_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)

 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
-	if (skb->mac_len)
+	if (skb_mac_header_was_set(skb))
 		eth_hdr(skb)->h_proto = skb->protocol;

 	err = 0;
--
2.42.0


