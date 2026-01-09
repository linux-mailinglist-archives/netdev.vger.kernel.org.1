Return-Path: <netdev+bounces-248407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F54D0840A
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA7A302CF77
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DA6332EB8;
	Fri,  9 Jan 2026 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE7gX+gq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A542FBDF5
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951238; cv=none; b=qAmN8iGjDH/UeSc8BtH+uXaX+uS3WITDaQCtl04lOcOyT9aougTQ3yyw5RgVgP0l4Y7FdN7lPyTlIiz2V8mTGT3YH4vSWLrbNg+T4sBIE2xqpLTCRl7GvszwS3Lgw/DgoEP9k6mVnTNAjX3lC05lVhmuP6H25FSylF4ZNhhPUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951238; c=relaxed/simple;
	bh=LqMfhFsx34G5fyRzdDh6shoD9QjerKt/rKh74ytdLgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp6cn9thFAGLEouFKHQ2kfWleBoeJZks2Of7a9+sWxiwoZYY/66FJtzcVIgWq5sh/buEaFXA+oMdFgyDbKDTMInN6/CDukKIDX1ohVUxuFDLVqBKy5Wn8mftG3Dwdd2RZ2GZDyqhc+u7G8CHqbofjpZEvhixrs3CjU5YBEVq6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE7gX+gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF199C4CEF1;
	Fri,  9 Jan 2026 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767951238;
	bh=LqMfhFsx34G5fyRzdDh6shoD9QjerKt/rKh74ytdLgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WE7gX+gq0wx1Wq7wrOV3RGcgOvIMiiEmJkoV65bLh1b2zfCAnZ+ToFhKyyP7yS5i3
	 AoxZXl4g8UbrSs27/1hL3F5OawlyhdGHab7zvIW45/xn7wHtw3Za/LXQiuyKRMbxkL
	 4pOR70OO/1JwvbkianUddqbqxYyW+v4JYdsRxsCZDGd66T9kuQVfWcfRKWndLEEt5t
	 pyY68F0TMXRVpuV5QFTwWTaaVgUdKo1fNY0rp9VSvwgQsNDNvK6z+wu0FfHSXWmLPe
	 Y1Q7WGzGrH3LUWtMB8kKapgrxkOayIOP57Fwq1/SFMjT6kNtG1pO0mZT2LgBujuJsX
	 +fiTnEg+37QCQ==
Date: Fri, 9 Jan 2026 10:33:55 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: Fix schedule while atomic in
 airoha_ppe_deinit()
Message-ID: <aWDLg6RzI4s2VgIH@lore-desk>
References: <20260105-airoha-fw-ethtool-v2-1-3b32b158cc31@kernel.org>
 <20260108132218.GG345651@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qg/4Vam8mbknzqoZ"
Content-Disposition: inline
In-Reply-To: <20260108132218.GG345651@kernel.org>


--qg/4Vam8mbknzqoZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Jan 05, 2026 at 09:43:31AM +0100, Lorenzo Bianconi wrote:
> > airoha_ppe_deinit() runs airoha_npu_ppe_deinit() in atomic context.
> > airoha_npu_ppe_deinit routine allocates ppe_data buffer with GFP_KERNEL
> > flag. Rely on rcu_replace_pointer in airoha_ppe_deinit routine in order
> > to fix schedule while atomic issue in airoha_npu_ppe_deinit() since we
> > do not need atomic context there.
>=20
> Hi Lorenzo,

Hi Simon,

>=20
> If I understand things correctly the key problem here is that
> an allocation with GFP_KERNEL implies GFP_RECLAIM and thus may sleep.
> But RCU read-side critical sections are not allowed to sleep in non-RT
> kernels.

yes, right, RCU section is atomic.

>=20
> If so, I think it would be clearer to describe the problem along those
> lines. But maybe it is just me.

This patch is already in Linus's tree.

Regards,
Lorenzo

>=20
> >=20
> > Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support=
")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v2:
> > - Update commit log.
> > - Link to v1: https://lore.kernel.org/r/20251223-airoha-fw-ethtool-v1-1=
-1dbd1568c585@kernel.org
>=20
> ...

--qg/4Vam8mbknzqoZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWDLgwAKCRA6cBh0uS2t
rIB3AP0a1KHAx3razHj4kPIvhW1x66e1t9N5r9lmaYx8cGtOIAEAxyyu/zyv/K1O
eZDfQKJdH04RONQj1O6W3ginvMBLPAw=
=bX6O
-----END PGP SIGNATURE-----

--qg/4Vam8mbknzqoZ--

