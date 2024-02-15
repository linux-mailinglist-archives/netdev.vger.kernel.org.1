Return-Path: <netdev+bounces-72075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B598567DE
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 16:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E401F2D48A
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B00134CC2;
	Thu, 15 Feb 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjruMFXZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D913475D
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011115; cv=none; b=bpD/Yox98SGyMrWX9jvJtpc0AA3fFP98R3Ud0C2I3Y7UFl0JZJekLsVEM/SKmvpfjammbki7Cox4hBS76daAPf+6NzE+I24LnuX2xFg0aF9LJVm6xcLv6na6Y3LFR/5Hv4wJa498qf9qmfeWMgFSfvly6QmHeA7lEQ6nY+AO5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011115; c=relaxed/simple;
	bh=5CMsVyXfgK+Pboaj0i/IYYizUIL+ptbdl0pl6qPJGjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnM3fUHMGHHke9QiaXlz0sgkRTrLpUoZS0T98eSopuUsuXh8tfvPu+EEht0YtJcWwMoDvaiVpL5AUk7624uZ/h63DZBVzvnCrnHxXR0rm+Kg9+kpH3CCXIK/ePyRKpVJbg1+nEaknTMaZMlQ9yuSgd+1hu2XJHy16rHgz5HeUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjruMFXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41924C433C7;
	Thu, 15 Feb 2024 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708011114;
	bh=5CMsVyXfgK+Pboaj0i/IYYizUIL+ptbdl0pl6qPJGjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjruMFXZq8YD3I39WiC3FCkmzPHkhyADk9Sw5unoLtpGDvqXbqMJwl3MEVsF8T+2s
	 0lAxiIUwdiLx0oYB0YxNPqq/qOcT74Ph7h1xRL+QFMuFdiOukAPJHE+iRrNhsZFKIq
	 irSlXTMgSSmGuTxLF62TfWaUabcwW0FSH5eosSx8W7mhwx7bTBx4yduFXNXfhcWUYl
	 NyXgpREP2wHoSvQlo6bd6qKWqw+TWioh79obVoP7Uy+QhcWMaBVPzfk4wKOevy1Xv5
	 nesOYaGU+Lu+HGW57YxRrkh0Y4Qco0h1MU13YLu3Qo67JYMqZUuQ0bpy7+JRO4g58M
	 Z1TGx8BIEg0Bw==
Date: Thu, 15 Feb 2024 16:31:50 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	hawk@kernel.org, ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com, toke@redhat.com
Subject: Re: [RFC net-next] net: page_pool: fix recycle stats for percpu
 page_pool allocator
Message-ID: <Zc4uZucrtv5dNt_1@lore-desk>
References: <e56d630a7a6e8f738989745a2fa081225735a93c.1707933960.git.lorenzo@kernel.org>
 <bff45ab9-2818-4b37-837e-f18ffcab8f47@intel.com>
 <20240215070414.4d522c88@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mErLHErWZ0B8Dba3"
Content-Disposition: inline
In-Reply-To: <20240215070414.4d522c88@kernel.org>


--mErLHErWZ0B8Dba3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 15 Feb 2024 14:41:52 +0100 Alexander Lobakin wrote:
> > For example, if I have an Rx queue always pinned to one CPU, I might
> > want to create a PP for this queue with the cpuid set already to save
> > some cycles when recycling. We might also reuse cpuid later for some
> > more optimizations or features.
>=20
> You say "pin Rx queue to one CPU" like that's actually possible to do
> reliably :)
>=20
> > Maybe add a new PP_FLAG indicating that system percpu PP stats should be
> > used?
>=20
> Part of me feels like checking the dev pointer would be good enough.
> It may make sense to create more per CPU pools for particular devices
> further down, but creating more pools without no dev / DMA mapping
> makes no sense, right?
>=20
> Dunno if looking at dev is not too hacky, tho, flags are cheap.

I would vote for a dedicated flag ;)

Regards,
Lorenzo

--mErLHErWZ0B8Dba3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZc4uZgAKCRA6cBh0uS2t
rLvTAQCLgcKS/sSIPrrkRJTqa3XlZMf45GJpvYaaE+Aqz+GyJgEAqnk1aCzPR0m9
JeUf6fSM9p877ceWIT+DyqkRvPUB6A8=
=fBwR
-----END PGP SIGNATURE-----

--mErLHErWZ0B8Dba3--

