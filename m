Return-Path: <netdev+bounces-89739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117018AB616
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 22:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713A72817BC
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 20:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C084129CE4;
	Fri, 19 Apr 2024 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b="l4IWr7k9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.a16n.net (smtp-out.a16n.net [87.98.181.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6ED10A2C
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.181.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713559476; cv=none; b=I271B0CCMwpk0MLpFQa3vGX+bXV0ZiFuGUpxIHxebjhrVkfI6EYSMvDRgGIEHj1wQn9cxyY+vThMyHqS1J3fqai1YKIAFNCGrXpvoI0HG2kB3vk0Ou3U91KQhbwwomwJZZCUWvM2Nw4ujVcqDIqqdPE0tG9gWy0YxF2VKW3xVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713559476; c=relaxed/simple;
	bh=LFUrNakum0XVuxhZRBSWcBRIV6r3vy12+r8Qv84ueKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DAMdnAjt8YgjdGLyzLUBf81tBSzCZ8v3P53Mi5lvIjU48j2P6m4Cr5Yz/2/sRPWz0iaKfAXN4D5xSfHaqDFE3SreJoOAEEcC6QOVhPzLRL5KFYZH4Db0kZV2676m3CAGkSRGQxYhNG4AVn0yTZE+6szVt+3k6CO0i9KAXuo6yFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net; spf=pass smtp.mailfrom=a16n.net; dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b=l4IWr7k9; arc=none smtp.client-ip=87.98.181.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a16n.net
Received: from server.a16n.net (server.a16n.net [82.65.98.121])
	by smtp-out.a16n.net (Postfix) with ESMTP id 5BCFD4604B0;
	Fri, 19 Apr 2024 22:44:29 +0200 (CEST)
Received: from ws.localdomain (unknown [192.168.13.254])
	by server.a16n.net (Postfix) with ESMTPSA id 688A3800E2D;
	Fri, 19 Apr 2024 22:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=a16n.net; s=a16n;
	t=1713559469; bh=Iig9dPdFfv3mgbHamMTPFFLz2+4tCtmVkqfZ6IiCEgI=;
	h=From:To:Cc:Subject:Date;
	b=l4IWr7k9dqbct+Sn4MuD09CAKuBdZ+SvPw5Xo23Kxy5ZqOCmqMmJNSAWKVyOcHmaX
	 l7WXRn5QpdNTJLI9vMr6E9egeYH+m/TIcT8UfAhT0soohjfsHdw9m3s8dbGq5u5wZ8
	 nMPWg8LjITvJT18PEHbGum1B6ZHTCSks9VLIFmXtXAODPdg5YPaXh5AF100N0+VAbG
	 moYZc2PY+4h0CY7gdWDlGMa6Bw29bFHxk8HOXwk+D5pGWRyTZQLKCkucLuVlMrVHZC
	 BWDTf9V67nSnnEF8Zj9SyZr59xrV4yEoPKb25jVG2YXTiENmJrd9Js89I/R1567aot
	 8GpDeuAInhdhA==
Received: by ws.localdomain (Postfix, from userid 1000)
	id 3A0DB20682; Fri, 19 Apr 2024 22:44:29 +0200 (CEST)
From: Peter =?utf-8?Q?M=C3=BCnster?= <pm@a16n.net>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net v3] net: b44: set pause params only when interface is up
Date: Fri, 19 Apr 2024 22:44:28 +0200
Message-ID: <87o7a5yteb.fsf@a16n.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

This patch fixes a kernel panic when using netifd.

Kind regards,
=2D-=20
           Peter

--=-=-=
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: inline;
 filename=0001-net-b44-set-pause-params-only-when-interface-is-up.patch
Content-Transfer-Encoding: quoted-printable

b44_free_rings() accesses b44::rx_buffers (and ::tx_buffers)
unconditionally, but b44::rx_buffers is only valid when the
device is up (they get allocated in b44_open(), and deallocated
again in b44_close()), any other time these is just a NULL pointers.

So if you try to change the pause params while the network interface
is disabled/administratively down, everything explodes (which likely
netifd tries to do).

Link: https://github.com/openwrt/openwrt/issues/13789
Fixes: 1da177e4c3f4 (Linux-2.6.12-rc2)
Cc: stable@vger.kernel.org
Reported-by: Peter M=C3=BCnster <pm@a16n.net>
Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Vaclav Svoboda <svoboda@neng.cz>
Tested-by: Peter M=C3=BCnster <pm@a16n.net>
Signed-off-by: Peter M=C3=BCnster <pm@a16n.net>
=2D--
 drivers/net/ethernet/broadcom/b44.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/bro=
adcom/b44.c
index 3e4fb3c3e834..1be6d14030bc 100644
=2D-- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -2009,12 +2009,14 @@ static int b44_set_pauseparam(struct net_device *de=
v,
 		bp->flags |=3D B44_FLAG_TX_PAUSE;
 	else
 		bp->flags &=3D ~B44_FLAG_TX_PAUSE;
=2D	if (bp->flags & B44_FLAG_PAUSE_AUTO) {
=2D		b44_halt(bp);
=2D		b44_init_rings(bp);
=2D		b44_init_hw(bp, B44_FULL_RESET);
=2D	} else {
=2D		__b44_set_flow_ctrl(bp, bp->flags);
+	if (netif_running(dev)) {
+		if (bp->flags & B44_FLAG_PAUSE_AUTO) {
+			b44_halt(bp);
+			b44_init_rings(bp);
+			b44_init_hw(bp, B44_FULL_RESET);
+		} else {
+			__b44_set_flow_ctrl(bp, bp->flags);
+		}
 	}
 	spin_unlock_irq(&bp->lock);
=20
=2D-=20
2.35.3


--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGoEARECACoWIQS/5hHRBUjla4uZVXU6jitvQ7HLaAUCZiLXrQwccG1AYTE2bi5u
ZXQACgkQOo4rb0Oxy2gxAQCdGrH+apVzFaOFIXm81xhcKmTOD70AniZAsDyRoTzi
wZaF8jirYOsn/kfu
=vkzG
-----END PGP SIGNATURE-----
--==-=-=--

