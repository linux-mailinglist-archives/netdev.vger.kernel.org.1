Return-Path: <netdev+bounces-90934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9353F8B0B85
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965B6B23D00
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2454415B98B;
	Wed, 24 Apr 2024 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b="kSRbJLQ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.a16n.net (smtp-out.a16n.net [87.98.181.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598BB15AABA
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.181.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966725; cv=none; b=W0gCO1mQydTBlLfqB02ej69Ftwq7+q5UOx7mMhhYIhawvuZ1IsKGpPa+UtseXtMbKYqik24acZpYwKrXh798Za6cbIw/F27673ny31HT93G1arL/h9YIF9TpFm9G5RCaY0Azpn5OK9Tt+EmltBGobOji2RwNr4trXLq9dzzKlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966725; c=relaxed/simple;
	bh=KTYYQ8j5CLPv8tozKnVkKESKgn7gaLXPAxFXAFJivWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+MuKI9CgjdgOqaF/GB1zE+2ULE0MM39WUiddDcexNLovMMWLmLPJkBLAmYsQDKPXrtpbyK79kM2FZhhMRfHXjpzlkaT+TtZLds4BRjyxhNisFmaXRL/b4FXmChIXOQYtutdyQsWIulYi/KX9pWksWQ25AeobibdejgqjRD2CCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net; spf=pass smtp.mailfrom=a16n.net; dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b=kSRbJLQ3; arc=none smtp.client-ip=87.98.181.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a16n.net
Received: from server.a16n.net (server.a16n.net [82.65.98.121])
	by smtp-out.a16n.net (Postfix) with ESMTP id 108D1460491;
	Wed, 24 Apr 2024 15:51:53 +0200 (CEST)
Received: from ws.localdomain (unknown [192.168.13.254])
	by server.a16n.net (Postfix) with ESMTPSA id 110E480108D;
	Wed, 24 Apr 2024 15:51:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=a16n.net; s=a16n;
	t=1713966713; bh=bxhurYWm6qsGSgE5rKmIlSEbbtMYfIQohp8bPEmTf2Q=;
	h=From:To:Cc:Subject:Date;
	b=kSRbJLQ3VGMiDYkEPumgVy0DWaEpomcwEinzv00scs4ymKJ9M0z12GevhyTj+UXwi
	 uD4kVhlPrzTxi/ckUsON1fwiQhSuIE5eU4j/xs2Xz/qNY/TkkEYUvMJF7GCOSA+oAT
	 ji1EWfNFXTh2UNVGt5X6OBkK1Tfvaj3KqSBZX411iYVSLON4XvravRxyATPO3J+eXu
	 rfS7nD+J/KJ+wweoSAwtWqBdN1J9L8CbkCKfGC2d2OA3YfD3sN+Fxm8SpFMqAKh0im
	 C0QIRlhVKVjaykXBRjjD97xwIXoIpfdqX1BGCDC3/dxrhUi02/JoAMW1WPkXRs049n
	 iOKfY6tAu+fCg==
Received: by ws.localdomain (Postfix, from userid 1000)
	id EAF50209FA; Wed, 24 Apr 2024 15:51:52 +0200 (CEST)
From: Peter =?utf-8?Q?M=C3=BCnster?= <pm@a16n.net>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net v4] net: b44: set pause params only when interface is up
Date: Wed, 24 Apr 2024 15:51:52 +0200
Message-ID: <87y192oolj.fsf@a16n.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

b44_free_rings() accesses b44::rx_buffers (and ::tx_buffers)
unconditionally, but b44::rx_buffers is only valid when the
device is up (they get allocated in b44_open(), and deallocated
again in b44_close()), any other time these are just a NULL pointers.

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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGoEARECACoWIQS/5hHRBUjla4uZVXU6jitvQ7HLaAUCZikOeAwccG1AYTE2bi5u
ZXQACgkQOo4rb0Oxy2jZEwCgmZwsJpxcVTA6AgWFnWRPzd9NJ0AAoM4RhfyNZuAr
hBXPR2q4XLfiLGzn
=PThL
-----END PGP SIGNATURE-----
--=-=-=--

