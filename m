Return-Path: <netdev+bounces-224428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E33B84980
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA3B4A5ECB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5AF3594E;
	Thu, 18 Sep 2025 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tcarey.uk header.i=@tcarey.uk header.b="A66hdy3/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01C281371
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198794; cv=none; b=vD+rXrigmt93o53cR3mcmY3zvrDBngKf9wG64gRLL4lf0hvbzbYxlzXRLf4MDh+KThLC01ndYbrKBr8Rg+uIfQ0ColkVP/Zy4BVdBHDT1fq+aC8xzoi3ggT0CaOpRKSpCQoTxeKNbHgxqURkPL742pYdAifyeSvpX5BU/dnGlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198794; c=relaxed/simple;
	bh=Z79SWd7Wal6W9/KWCx3RZiECEOyPbz1111YYFpTWN+s=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TJG012kuh/xnEAN/CFna9igzqoUiU9Y4LBiWrBgdDyEptdoN752NQjNZAlScRl8Tht9RGzsJf15wYCABWGpetXWFr7ArCToi+TrXzp2UYH/Gr0Det7bIrfMeOm0t3ktohrbBb2kkiGsIMtiwXs3YM35hOe5DZw+cy+Xfd+2KdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tcarey.uk; spf=pass smtp.mailfrom=tcarey.uk; dkim=pass (2048-bit key) header.d=tcarey.uk header.i=@tcarey.uk header.b=A66hdy3/; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tcarey.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tcarey.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tcarey.uk;
	s=protonmail; t=1758198782; x=1758457982;
	bh=Dhuee6i8nQUqCAQxEyGKAbtdRVAOo3Kgp8kTj/RP8x8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=A66hdy3/ExMj0GZWCn6nDxMqio2EzLOa19BpTtdyxXzBx0cUyUKgj4WKUOIn0GJWR
	 ye66Lsj2kagWchPlD6l3GJK0ozHdibtCo2b0sJ3MAX+CBc2jirvag/6K1+W6MeKah6
	 yBI/KjKcRZM9FWRuDgWqg+3ofi0AW7KS1nOBEQnCz2Qt3TdD9afoGMm5ONBZixgkC9
	 Tg7n6hI+vl63u07kpc9U4bv+hoVatwHwzv4fbwRike0Hevs4bu76c3sNSBe9WuTx7T
	 sWPzAYmjksLM1yKrH+vXxI7Ki+uYRa7VgHitU4hW/iLjj2N7c8oypKV3Jzjd07AS0+
	 MubMxxIokfE0A==
Date: Thu, 18 Sep 2025 12:32:58 +0000
To: wireguard@lists.zx2c4.com
From: Torin Carey <torin@tcarey.uk>
Cc: netdev@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] wireguard: remove unnecessary use of ipv6_stub
Message-ID: <20250918123234.297856-1-torin@tcarey.uk>
Feedback-ID: 43460779:user:proton
X-Pm-Message-ID: fce568dd48d251d9349f9357e3a00c789e048133
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ipv6_stub is required for cases where ipv6 may be compiled as a module
and might not be loaded from a given context.

wireguard has a Kconfig dependence of IPV6 || !IPV6 so will also be compile=
d
as a module if ipv6 is, and wireguard already accesses a symbol of this mod=
ule
via ipv6_mod_enabled, so already has a module dependence on ipv6.

Removal is desireable since it removes an unnecessary indirect branch, but
also reduces the effort needed should ipv6_stub ever be modified/replaced.

Signed-off-by: Torin Carey <torin@tcarey.uk>
---
 drivers/net/wireguard/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.=
c
index 253488f8c00f..593324d564d2 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -136,8 +136,8 @@ static int send6(struct wg_device *wg, struct sk_buff *=
skb,
 =09=09=09if (cache)
 =09=09=09=09dst_cache_reset(cache);
 =09=09}
-=09=09dst =3D ipv6_stub->ipv6_dst_lookup_flow(sock_net(sock), sock, &fl,
-=09=09=09=09=09=09      NULL);
+=09=09dst =3D ip6_dst_lookup_flow(sock_net(sock), sock, &fl,
+=09=09=09=09=09  NULL);
 =09=09if (IS_ERR(dst)) {
 =09=09=09ret =3D PTR_ERR(dst);
 =09=09=09net_dbg_ratelimited("%s: No route to %pISpfsc, error %d\n",

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
--=20
2.48.1



