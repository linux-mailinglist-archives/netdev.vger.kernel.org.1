Return-Path: <netdev+bounces-223027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AC8B57990
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3DC161B22
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D2E2FD7DD;
	Mon, 15 Sep 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tcarey.uk header.i=@tcarey.uk header.b="uLQav3Oh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDC3009E7
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937524; cv=none; b=mAsGgyo6UB4xRODRwgJBM3IXw7HhHEKBMP/2blEazFAfWB7iZZ3SJc+qAqe7wt6r38aiZimilwgJHd/NZ92AIc/n3BaTvsA/7Hc0vEjK1HluBrW5R24VxGYZFXlogmVQgN7HSyr5mLBJjpfOc026q1zTt286Wx9OwxHxlQK5nFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937524; c=relaxed/simple;
	bh=n9NDKjcJnS8ZyenWeoSequo4p01+vgPSe2A2lsLaNMU=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ffX3LaxDM4rTCOVlulgkV1fQO/EZ9A7L8/SnMiRGv1cQEk8RRh1P1dsOdX5nij4QCDxwZW3XWiN6ssIMGiRptc2VLnLU0ErFGCZ8t9REc174FgN32nvY4Malg8JQofEK4jUxug2ibyWCPu0ITtZcKko1TS4Vb8g5po99ZUyBLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tcarey.uk; spf=pass smtp.mailfrom=tcarey.uk; dkim=pass (2048-bit key) header.d=tcarey.uk header.i=@tcarey.uk header.b=uLQav3Oh; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tcarey.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tcarey.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tcarey.uk;
	s=protonmail; t=1757937518; x=1758196718;
	bh=n9NDKjcJnS8ZyenWeoSequo4p01+vgPSe2A2lsLaNMU=;
	h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uLQav3OhCSeIaLIbej5hQbagiONKHlR5f7BBDTQbn6lUmecS9VPeS17vy96s/clAD
	 uogqxQ0SfnG4kLCup5UUjg4L8K3beJ9952JwgR+OnXn3x8GPBeVwmUxt/agpJ+sO0B
	 r4kwbfcVhDi0PIhvEJ68r0I+T/7s50ZLiOSeYgOLa9PMfWSwJLYrjxtMn9O3TNQWtb
	 uVnu/+Km8MjXJ2SN3KklswH2Vt23NqHaqbF1DEMXO12YlwUKO2ape0n2FVBBh1sIlT
	 f0eSykoWf+HEozUVMoqOKFSrF5ttW2hrKTEKPbV0Ne+JupMzW1zt+ZrhvbRnL0bTsd
	 G2YMwjlV96nGA==
Date: Mon, 15 Sep 2025 11:58:34 +0000
From: Torin Carey <torin@tcarey.uk>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org
Subject: [PATCH] wireguard: do not use sin6_scope_id if not needed
Message-ID: <aMf_ZORMji8eiHpH@omega.tcarey.uk>
Feedback-ID: 43460779:user:proton
X-Pm-Message-ID: d7cdfb9e0fdac2cd82cf4244fd72ce05e77958fb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

sin6_scope_id should only be used if the address is link-local and
otherwise ignored.

Currently send6 uses the sin6_scope_id for flowi6_oif without a check of
whether this is needed, so this can cause non-link local endpoints to
use an incorrect device.

Signed-off-by: Torin Carey <torin@tcarey.uk>
---
 drivers/net/wireguard/netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlin=
k.c
index 67f962eb8b46..738041f72c2b 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -453,6 +453,8 @@ static int set_peer(struct wg_device *wg, struct nlattr=
 **attrs)
 =09=09=09wg_socket_set_peer_endpoint(peer, &endpoint);
 =09=09} else if (len =3D=3D sizeof(struct sockaddr_in6) && addr->sa_family=
 =3D=3D AF_INET6) {
 =09=09=09endpoint.addr6 =3D *(struct sockaddr_in6 *)addr;
+=09=09=09if (!__ipv6_addr_needs_scope_id(ipv6_addr_type(&endpoint.addr6.si=
n6_addr)))
+=09=09=09=09endpoint.addr6.sin6_scope_id =3D 0;
 =09=09=09wg_socket_set_peer_endpoint(peer, &endpoint);
 =09=09}
 =09}

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
--=20
2.48.1



