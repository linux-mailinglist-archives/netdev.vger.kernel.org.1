Return-Path: <netdev+bounces-213250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C5B243DA
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43AD2A7EAE
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D9A2D8767;
	Wed, 13 Aug 2025 08:13:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC612EBBAB
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072814; cv=none; b=mbXJRp1b7i+sB9GF6yIlEtp8wNmO2/7SRjRJFzGclEZPi79pjcYe+RvMHn9Vnfvn/q9DVuK5qMTWfpHMORCXAxBsLivTZSAfOkzRJ6NqHntUNnCAIIvFx7IhANqZYAH33E72KhmKku1onXW/PeiKfFwzEgVb89HmZWMuNgoLmrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072814; c=relaxed/simple;
	bh=NhKcZaeGN5x3+Z8+w2Rz40aXXLogT2mDzysg1DpqVtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd3eazhsaz991RVgH70Tx7aPr0XsKO5PjxQj2bvMPwtYB6PK4ynRBW+EsTRTvDX9JoKpZr8PARlbyGXXoTuc4PxxmWvAL2VWxUc5htMgb1ItkmlP2DZ+9XFVwVQHszevA/LZ527jVRVyFdOeWkdhsakSBW0bfpzIOFLed5Fwxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6bu-00024l-5n; Wed, 13 Aug 2025 10:13:26 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6bt-0003lY-2n;
	Wed, 13 Aug 2025 10:13:25 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 92D52456873;
	Wed, 13 Aug 2025 08:13:25 +0000 (UTC)
Date: Wed, 13 Aug 2025 10:13:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, socketcan@esd.eu, 
	Simon Horman <horms@kernel.org>, Olivier Sobrie <olivier@sobrie.be>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 4/6] can: esd_usb: Add watermark handling for TX jobs
Message-ID: <20250813-chubby-lizard-from-asgard-fb7867-mkl@pengutronix.de>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
 <20250811210611.3233202-5-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mvd6jfqqmko5gpg5"
Content-Disposition: inline
In-Reply-To: <20250811210611.3233202-5-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--mvd6jfqqmko5gpg5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/6] can: esd_usb: Add watermark handling for TX jobs
MIME-Version: 1.0

On 11.08.2025 23:06:09, Stefan M=C3=A4tje wrote:
> The driver tried to keep as much CAN frames as possible submitted to the
> USB device (ESD_USB_MAX_TX_URBS). This has led to occasional "No free
> context" error messages in high load situations like with
> "cangen -g 0 -p 10 canX".
>=20
> This patch now calls netif_stop_queue() already if the number of active
> jobs reaches ESD_USB_TX_URBS_HI_WM which is < ESD_USB_MAX_TX_URBS.
> The netif_start_queue() is called in esd_usb_tx_done_msg() only if
> the number of active jobs is <=3D ESD_USB_TX_URBS_LO_WM.
>=20
> This change eliminates the occasional error messages and significantly
> reduces the number of calls to netif_start_queue() and
> netif_stop_queue().
>=20
> The watermark limits have been chosen with the CAN-USB/Micro in mind to
> not to compromise its TX throughput. This device is running on USB 1.1
> only with its 1ms USB polling cycle where a ESD_USB_TX_URBS_LO_WM
> value below 9 decreases the TX throughput.
>=20
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>

Please add a Fixes tag.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mvd6jfqqmko5gpg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicSSIACgkQDHRl3/mQ
kZxbIAgAsizV5ESiPLb1GnbM5zUVlKDLgKELDgzDCQ2yB+gGx3l5WXfugjIBuYj1
ZAoGsyZLZ33XpSAavT4Ap4pQNSn3n71XZjCPFwDks1zK2z0qtz6eBQ42jI+bZM7R
bFXTzRcSkZ/gB/LvLw4aZbQ1LHiJm0vZSCEQS/AM8G8ALCFSO+R5+7oNxKTyksK/
zbpaDYDvTE/0UbAx53W+8+EHjKsBzgfglF41vZLGI+teEYfJWDvbgfqJOJNO8gCm
/EI4LlrIvnm0CEVnlYvQT9uffbfVQuEEFaG/bcVlagr7D1y5I+b7q9H+oBZSqr8Q
CT7WVdfICapExzqxKBm+xD45Vj7k5w==
=GfRI
-----END PGP SIGNATURE-----

--mvd6jfqqmko5gpg5--

