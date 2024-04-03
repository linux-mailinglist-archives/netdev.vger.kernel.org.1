Return-Path: <netdev+bounces-84552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1291289747D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 17:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C220D292D82
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A497D14A4E4;
	Wed,  3 Apr 2024 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b="dfog4gel"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.a16n.net (smtp-out.a16n.net [87.98.181.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF005146A96
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.181.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159432; cv=none; b=WXSLgNXm2FAeHazC9P5chrGH7fAZezV/z6tRlgLRQ1Iu0Lt0boLtAxZcRSdEHouF8ijI6cIOtBvq87M5nB90+d4mRop18rVnuJyHTjsnQV9It/LqNiDvkPhu64cr9XK91gFpUDIWl6wrrYG2uxjVfCD+R06uFkx9Fzqipkswxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159432; c=relaxed/simple;
	bh=w2zZrsI5miqTAX2EAvtEo8kByLni0+KvGsn7OYh9OKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HuL7th9DmeMhVQGugDUDup+nf4Ew+/5Gxxf3puhiCYJxhSg8QVSmWKbXJQsHVpZ6S3buIrR47Srqn4j03qsM+GtKOP2R4CRBmWFxtuB0WHCzsHEQ4P1RrXjyWaoZPMlAWqmpfGk+x4SeLShXShyg2lwimyeqWpizedMlY/sSnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net; spf=pass smtp.mailfrom=a16n.net; dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b=dfog4gel; arc=none smtp.client-ip=87.98.181.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a16n.net
Received: from server.a16n.net (ml.a16n.net [82.65.98.121])
	by smtp-out.a16n.net (Postfix) with ESMTP id 02E9846058A;
	Wed,  3 Apr 2024 17:50:24 +0200 (CEST)
Received: from ws.localdomain (unknown [192.168.13.254])
	by server.a16n.net (Postfix) with ESMTPSA id D27AF801188;
	Wed,  3 Apr 2024 17:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=a16n.net; s=a16n;
	t=1712159424; bh=y8T6zG96w3X6IvRIYHBWoL9d7WXW8OTFpQhSpDQlwJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dfog4gel0J2JmVRmBvskErDt0UE90CRoV4R4yEOkqWXLmWERJkjmDpZLjNAYXPIVK
	 ZjBA1qLJKB4qgHJk5jCjTuFVleYHOXgEpZAiqIFWAsfrxb+1m7EEHcOwyXB1icOdF1
	 RRkerUMlIpev6ujkW2UgXj65lAzlqIV00kYBXJnAgQpHjwhGgg/PYsaRQ7P9fChfm5
	 HVwKkWA4yLU0rRcfclxcXP/P7KpKiwP6kXMiC2aztafcaOtb7rpuJpZW5wlninN4bC
	 GtLA5U/BKxqly7EOOGHOjiMy3qAFjUMzfiGhfhO1tB2s5EP49TGkSUx3r4TLwr+zl6
	 duhEWdqb3ocnA==
Received: by ws.localdomain (Postfix, from userid 1000)
	id B204820A07; Wed,  3 Apr 2024 17:50:24 +0200 (CEST)
From: =?utf-8?Q?Peter_M=C3=BCnster?= <pm@a16n.net>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org
Subject: Re: kernel panic with b44 and netifd
In-Reply-To: <CACKFLikqEyAQf-2DxbAnKSFbvTP9Wj=X1Yr1ff6LzZ13T6OZ6w@mail.gmail.com>
	(Michael Chan's message of "Wed, 3 Apr 2024 07:53:09 -0700")
References: <878r1ufs9p.fsf@a16n.net>
	<CACKFLikqEyAQf-2DxbAnKSFbvTP9Wj=X1Yr1ff6LzZ13T6OZ6w@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 03 Apr 2024 17:50:24 +0200
Message-ID: <87il0ye98f.fsf@a16n.net>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03 2024, Michael Chan wrote:

> please post the patch to netdev for review.

Ok, please find it here attached.

And please consider also KanjiMonster=E2=80=99s comment here:
https://github.com/openwrt/openwrt/issues/13789#issuecomment-2034601851

=2D-=20
           Peter

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=b44.patch
Content-Transfer-Encoding: quoted-printable

=2D-- build_dir/target-mipsel_mips32_musl/linux-bcm47xx_legacy/linux-5.15.1=
53/drivers/net/ethernet/broadcom/b44.c~	2024-04-03 10:04:09.177021530 +0200
+++ build_dir/target-mipsel_mips32_musl/linux-bcm47xx_legacy/linux-5.15.153=
/drivers/net/ethernet/broadcom/b44.c	2024-04-03 10:46:42.267884445 +0200
@@ -2056,12 +2056,14 @@
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

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGoEARECACoWIQS/5hHRBUjla4uZVXU6jitvQ7HLaAUCZg16wAwccG1AYTE2bi5u
ZXQACgkQOo4rb0Oxy2hSCQCglFdpIpdgtgXnoeH8DiXmReXIshIAn0Ro5N5Ut5OE
lYqqtIjyJ9Hw6NBn
=TbYR
-----END PGP SIGNATURE-----
--==-=-=--

