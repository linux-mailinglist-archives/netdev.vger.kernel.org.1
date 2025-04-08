Return-Path: <netdev+bounces-180502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14B3A8190F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6BE3AEB41
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE4F255247;
	Tue,  8 Apr 2025 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrTv7IPY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD42254872
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152891; cv=none; b=mlhuB3oPgMhOabOSmyqYODm4S5ZYHiqOAUfXdjHyj6er2T9dtBu+D0pAUZ/t3OcjEame0vxRxWLX8h9ApHdxvadLXt2DgCJ6fxcpZUbHblE1OTCMI2rKdug7A9d9m1VGGk+SE7fWHmmOnr36AgVeUXBvqhK9OrWeLDE5OWCn288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152891; c=relaxed/simple;
	bh=hpQpod7dJ19FCqCA7ULsaw9W9YKDpeqR+rpRTosUPvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtWJhUtVspnxQOYhnXHSiu1agVUUr73YkRe8vjPl7AkyseYzGPDBbomRawk28NO9pa+b4nPaJThPqg1MtBAxM0wCN9vyL5bgVpaW5qA2BcrtuosLrZQiVdW5WikeVNk9i97W5ZXPQ1SC2tele9sW9LVOjgljbAw10rHxZcdtfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrTv7IPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AA5C4CEE5;
	Tue,  8 Apr 2025 22:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744152891;
	bh=hpQpod7dJ19FCqCA7ULsaw9W9YKDpeqR+rpRTosUPvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrTv7IPYgNZEzrxhfJn5SEO9OsPwJm2zDsJ8jD/sGC8U/9mlfZNFI41W8XtL/cFb+
	 EEXPQ9mEUVDioKafuVGq+rXx1LfS4fVIZMdAaWqXEjtaRONIy37w7/ANWZYscR8emw
	 ZoIhxoxr6wC3Z299vkT+2cHLgeJD/22PrkcQJDDE403xmzz1+M9my0XXw7mShyWKoi
	 F3xOHY1vfZwFcLi0bbfMysCrgz2MpntuFO+DLRfG/vesH0z/sKNDc4PhcCdmnYHOmK
	 Tu2LyAH/2Z6+CHkB1bIkIbFfeRp4KQNX947EB4GkNMgQYy30IIp3uT5dzXZt4pmLv3
	 h+2/vejLXx0Xw==
Date: Wed, 9 Apr 2025 00:54:48 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michal Kubiak <michal.kubiak@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: airoha: Add l2_flows rhashtable
Message-ID: <Z_WpOIGugyLnc99N@lore-desk>
References: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
 <20250407-airoha-flowtable-l2b-v1-1-18777778e568@kernel.org>
 <Z/VCYwQS5hWqe/y0@localhost.localdomain>
 <Z_VTpBhntxXPncsv@lore-desk>
 <20250408115727.6b7468b3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xnN5FBJtbR+nAVlX"
Content-Disposition: inline
In-Reply-To: <20250408115727.6b7468b3@kernel.org>


--xnN5FBJtbR+nAVlX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 8 Apr 2025 18:49:40 +0200 Lorenzo Bianconi wrote:
> > > I didn't find any usage of L4 flow type in the series.
> > > Is that reserved for future series? Shouldn't it be added together wi=
th
> > > its usage then? =20
> >=20
> > FLOW_TYPE_L4 is equal to 0 so it is the default value for
> > airoha_flow_table_entry type when not set explicitly.
> > It is done this way to reduce code changes.
>=20
> That seems quite unintuitive. Could you init explicitly for the
> benefit of people reading this code?

ack, I will do in v2.

Regards,
Lorenzo

--xnN5FBJtbR+nAVlX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ/WpOAAKCRA6cBh0uS2t
rPhJAP9tJumh66ALD7Mi9Lq67Q0zkiY3AAxsC78L/bK7hPMQFQD8CfrrTsGIVd2b
/YSRGiDILJJyG34/g8CbrhR6aFdaywo=
=k4nT
-----END PGP SIGNATURE-----

--xnN5FBJtbR+nAVlX--

