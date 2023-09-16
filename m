Return-Path: <netdev+bounces-34205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 379427A2C96
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 02:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647521C2260E
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43010374;
	Sat, 16 Sep 2023 00:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7F1376
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 00:40:24 +0000 (UTC)
X-Greylist: delayed 682 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Sep 2023 17:37:25 PDT
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDFD02D46
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 17:37:25 -0700 (PDT)
Received: from stubbs.local.chopps.org (unknown [213.61.58.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id EE7B67D082;
	Sat, 16 Sep 2023 00:24:48 +0000 (UTC)
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org,
        Christian Hopps <chopps@labn.net>,
        Christian Hopps <chopps@chopps.org>
Subject: [PATCH ipsec-next] xfrm: add comments in the xfrm mtu calc function
Date: Fri, 15 Sep 2023 20:15:17 -0400
Message-ID: <m2il8bq81d.fsf@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Document the [p]mtu values used by, and calculated for xfrms.

Signed-off-by: Christian Hopps <chopps@chopps.org>
---
 net/xfrm/xfrm_policy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 5c61ec04b839..2480717654b6 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3858,15 +3858,19 @@ static void xfrm_init_pmtu(struct xfrm_dst **bundle, int nr)
 		u32 pmtu, route_mtu_cached;
 		struct dst_entry *dst;

+		/* Get the xfrm's dst [p]mtu (i.e., the xfrm's intf/route). */
 		dst = &xdst->u.dst;
 		pmtu = dst_mtu(xfrm_dst_child(dst));
 		xdst->child_mtu_cached = pmtu;

+		/* Subtract the xfrm mode overhead. */
 		pmtu = xfrm_state_mtu(dst->xfrm, pmtu);

+		/* Get the inner traffic route's MTU. */
 		route_mtu_cached = dst_mtu(xdst->route);
 		xdst->route_mtu_cached = route_mtu_cached;

+		/* Update the xfrm's dst MTU to the minimum of these. */
 		if (pmtu > route_mtu_cached)
 			pmtu = route_mtu_cached;

--
2.41.0

