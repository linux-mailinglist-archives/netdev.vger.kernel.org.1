Return-Path: <netdev+bounces-132621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3469927E4
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F75B1F22276
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C518DF88;
	Mon,  7 Oct 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEPMYj8U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iw/bEKIx"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F618C326;
	Mon,  7 Oct 2024 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728292497; cv=none; b=OHq8qguVxUHFr0R5CDqUI9l7/4Rn4YW1aS0lR23F1k3hJtps6CTxsXIPg0xZQPFow+pDlh6UIUC9hRbGTa9dEeFDNTK8SyD+LejlZ7/LWTAcV+V61fBfkR+9yfdWxBwPLI4gurmCOU32VTwW9YbMB7U0MoqBoEyp2TCUG85r4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728292497; c=relaxed/simple;
	bh=W3hDRAYPSXIkW9gYM4sT+DAxCx8yaov54LZrcMTrwuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cII+N/CDlixDs+y1k6akClsbhgjDqIHYKUGBthSdU6Ze0hkWe6TY3oDuivUkyXAt9c/oxV7FfN//xxZNBzEPNI8a4MlrHsPjK82WFn71et3xMJYvOtclkRelwmGHEajJSGjBGQPCGIqQEFB8RkX6e2Soz3XvnLZmdbjJrDkPkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEPMYj8U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iw/bEKIx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728292493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ILhejzyvsn9kCBk/pLYqb1pHNvOKTywyx34p8dgeWWo=;
	b=UEPMYj8U8PeoCIDMxrM9YIBlbJQ+LGt6Dear3XCNWOJgJRS4o0gI6rFb3omUQaDXQQ8lso
	kpm7AddJjyESCchyMLoQ1o73X/uZT0RP1jATKDV2oxTsxLe6Ie7xTbTQQXiqzIJe7ZRgCB
	yT+SwYjDjet6m4HUguyyoZZdrQqHJRNqcamJVWl+bZhbVdqdoG0P90OmKpgoyHg//W46q8
	qY/yP2Em0u7/PF0kATyuhaCIwYegxhYhFdXAF0WtYp9BhhTI1dLoQQQ5KNi+AH+IVmtGXX
	LI00PUuZJKagKRvs9DX3vNhPzQQff7495ylcC87kfiXp/z68Z8yP2TozEfeYUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728292493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ILhejzyvsn9kCBk/pLYqb1pHNvOKTywyx34p8dgeWWo=;
	b=Iw/bEKIxzy+PzeYK32U1OyNVFCDn4052LD0tJJ8oC4ZYEtIyChQCVP+FOasBkjg7C/SNDO
	mfEDG6GggTG4F5CQ==
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "moderated list:INTEL ETHERNET DRIVERS"
 <intel-wired-lan@lists.osuosl.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 2/2] igc: Link queues to NAPI instances
In-Reply-To: <20241003233850.199495-3-jdamato@fastly.com>
References: <20241003233850.199495-1-jdamato@fastly.com>
 <20241003233850.199495-3-jdamato@fastly.com>
Date: Mon, 07 Oct 2024 11:14:51 +0200
Message-ID: <87msjg46lw.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Joe,

On Thu Oct 03 2024, Joe Damato wrote:
> Link queues to NAPI instances via netdev-genl API so that users can
> query this information with netlink:
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json=3D'{"ifindex": 2}'
>
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
>
> Since igc uses only combined queues, you'll note that the same NAPI ID
> is present for both rx and tx queues at the same index, for example
> index 0:
>
> {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 30 ++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethe=
rnet/intel/igc/igc_main.c
> index 7964bbedb16c..b3bd5bf29fa7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -4955,6 +4955,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
>  void igc_up(struct igc_adapter *adapter)
>  {
>  	struct igc_hw *hw =3D &adapter->hw;
> +	struct napi_struct *napi;
>  	int i =3D 0;
>=20=20
>  	/* hardware has been reset, we need to reload some things */
> @@ -4962,8 +4963,17 @@ void igc_up(struct igc_adapter *adapter)
>=20=20
>  	clear_bit(__IGC_DOWN, &adapter->state);
>=20=20
> -	for (i =3D 0; i < adapter->num_q_vectors; i++)
> -		napi_enable(&adapter->q_vector[i]->napi);
> +	for (i =3D 0; i < adapter->num_q_vectors; i++) {
> +		napi =3D &adapter->q_vector[i]->napi;
> +		napi_enable(napi);
> +		/* igc only supports combined queues, so link each NAPI to both
> +		 * TX and RX
> +		 */

igc has IGC_FLAG_QUEUE_PAIRS. For example there may be 2 queues
configured, but 4 vectors active (and 4 IRQs). Is your patch working
with that?  Can be tested easily with `ethtool -L <inf> combined 2` or
by booting with only 2 CPUs.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmcDposTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgkVmD/9qaFbTuNtod2nGZcKugdGzZE7UPryI
vjNn7+3IRXDCkRsCXqZpU+Ay4i78xFdFH3z4C8r1YK8Idl7xWvNYbSHicN1/dFea
zCGVkCyDr2cG/Nen2ty1+BaMyY3xVkmPKsO3/i5bTwJ8iLHr1RI20SQl7AlDdj4w
ZzrtmH28A12Vt6zf+Jw3cKHCCzP+V44Qkd6yeYL8W7Tqyu4nefLnmkGC4pL1aAKm
5Hck67WdesDYi3QmzVfB8WcUbtG/SIAheYz80rIA+1YGgxXJ163slMis458w2gxQ
t3vqFLHAxcDVq39DUhJOqFA6821BGUGzebA/2nq7vjnti8JA9lIn6hbzTj2Ficwi
AezoP1W6G1vyMlha7q4+AKcHfY0L6CelU5fF1PVkCFcld4HEMM5CmZ6yeOKHCQ8s
P5ylfIJJPO1l8GrKJrtuY8bshBz4yHv8aKoepydkO/VgFnfQ+x/orzcYrAYSBOoC
8VkQdadBeoD8qCvttQv1GbDUM+3My1exs3k0lB836+bYfz29Yi+Rj3KKuzPPzw5D
44ic3S0Qv84pydQBNxiXH0/Nmc+GhZRfIURSV1BwLqluwImh4xaC89W+4ltypwhL
gA/V3nipKhx2nzx3NAsAhm8sk+17B11j1Ba5G+lmLv8JG4Bv+GirXVlmraiYruhK
LfqS6xN2o9s2GQ==
=LMbF
-----END PGP SIGNATURE-----
--=-=-=--

