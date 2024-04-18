Return-Path: <netdev+bounces-89238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E889F8A9CF0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7628DB2346D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F4716D9D7;
	Thu, 18 Apr 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b="oTjjfvXP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.a16n.net (smtp-out.a16n.net [87.98.181.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C8816D9BD
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.181.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450147; cv=none; b=gKgZ1Hc9lpQsu/mnZwpwzgpeLF4H/DNeb53uNvQTZVaDZN1R8bFbw+zfWH1ttOONJ1gvVNrvaKXA8zeBfJ6m+u4OmUE2Pjh635HB1fiGZhKtXEcgitkHNte64F4HoKlmuVa/L+NpbVxv543H0wRR6v6PabMWU3vQ7ZWx7Gm9uP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450147; c=relaxed/simple;
	bh=RdbR132h6hWbO4LDil5d71OUP4F4j5GsTiTwHOuX/d4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NxksUyJVzPSGMZ3ruW5FL++U7LUlae7CIsGzZq9TYQjEf4K25xDE2/0Ac78YxKId+zHxSX5EM0IWhStrgO22ER7EsN2XAB8EEEKw2Wd52YxMnIQQZz1+4lk4kem+r36ZydrntadiSL/duiC4Lekxm4IFi0mwwWENau2ica2Mfxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net; spf=pass smtp.mailfrom=a16n.net; dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b=oTjjfvXP; arc=none smtp.client-ip=87.98.181.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a16n.net
Received: from server.a16n.net (server.a16n.net [82.65.98.121])
	by smtp-out.a16n.net (Postfix) with ESMTP id 4958A460491
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:12:35 +0200 (CEST)
Received: from ws.localdomain (unknown [192.168.13.254])
	by server.a16n.net (Postfix) with ESMTPSA id 5C95580105E
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:12:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=a16n.net; s=a16n;
	t=1713449555; bh=lBqDa7fF+sWS66DUvlcFyqflfppNFc71CpZQGR3SRxQ=;
	h=From:To:Subject:Date;
	b=oTjjfvXP1l6ofQ64TOrBM1XoD9EAkPN5mLcZ/2izwm0Wk1ZUwlrSYDr9Zdaczh0/n
	 L7n9y4ql0xj2XJkeZJHaNuZJshQWa3hzTwqGOv6L3UpTx1NyL/ZK1SlK/P29fUYAZr
	 jak23OLc1vZ/jCq3gjmtzH+cQu+2oURtx05LMvvC63daJNezfPpXwYLAWHsE3ZgVte
	 l+Cm9umrljomzyjpgICV0lmBJSmQ0CSMBtPdAoOI3BGEo6uKddmlOm5QPGHiIB1AvT
	 yweSIx9UhMXuro0Bx4ZmwGtbt/g0BZOll8YvPZtwaTEBmslcNpCivFY+agOp7Retij
	 m08lzIca2J4cQ==
Received: by ws.localdomain (Postfix, from userid 1000)
	id 3A85F20707; Thu, 18 Apr 2024 16:12:35 +0200 (CEST)
From: =?utf-8?Q?Peter_M=C3=BCnster?= <pm@a16n.net>
To: netdev@vger.kernel.org
Subject: [PATCH net] net: b44: set pause params only when interface is up
Date: Thu, 18 Apr 2024 16:12:34 +0200
Message-ID: <871q72ahf1.fsf@a16n.net>
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
Could you please apply it to linux-5.15.y?

TIA and kind regards,
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
index 485d32dda56f..ce370ef641f0 100644
=2D-- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -2029,12 +2029,14 @@ static int b44_set_pauseparam(struct net_device *de=
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

iGoEARECACoWIQS/5hHRBUjla4uZVXU6jitvQ7HLaAUCZiEqUgwccG1AYTE2bi5u
ZXQACgkQOo4rb0Oxy2jEwwCaA117SI8Ch/vL7oneXk/9rlUU+6cAoL4ssvWJJT/f
Zf+QHIT21SkUkRUe
=PMFa
-----END PGP SIGNATURE-----
--==-=-=--

