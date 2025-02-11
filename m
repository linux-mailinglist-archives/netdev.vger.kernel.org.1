Return-Path: <netdev+bounces-165266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC30A31526
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00CC3A71B9
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C692690E5;
	Tue, 11 Feb 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4Pn1/jr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359812690E1
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301824; cv=none; b=se9UQQcV7Gda3DMCprsnYu6EGGx49dV4K8XkRXcMHuiu6QNaZG9C9Snn2J6Zxg0GzVA32sqGTpCRoJ1H0bsIRQluJMpOOqrghbRaeXYcmm+3DSt2GZfl/MG96T+JhWTqzAj6BOxQa6nz8eyJYHeYRq3219OcoV4sVDM9NT3E0Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301824; c=relaxed/simple;
	bh=DV/Q7KAZ0bgfQua6q+GISGhhoM+Y4ieW81dOxb0xvMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miq9ncpnbTiOTvMSxb+IRInYhenYOyTtNGgTCYw5l4u/34UnldDwgbeQEvOu5edvhXfPYUb9wUqMRRA2BeNeF/2Vc9MQPCF74eSwSDmlY6ZS5qb9HyGrelmvPy0EsZ7j9pE12u52P95jDgkxRXtSrLS5rd4UIQgbgHH1Rr44IDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4Pn1/jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F7AC4CEDD;
	Tue, 11 Feb 2025 19:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739301821;
	bh=DV/Q7KAZ0bgfQua6q+GISGhhoM+Y4ieW81dOxb0xvMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D4Pn1/jrY1I/yhX7FEcFZ6Truu5IcvZ6QQRpRlmMRo8WZ1uAm+mtiCBWa/F0Jv/G/
	 fVzIQTJQfv1hSRQWwIhI1YmPE9spQYIXNLh5f74GRl0Xjr8oRmUgxRpFoxXEaF6hbl
	 SbHj4r1xMdcgXkPyJh2gApWl71mQaZ+2h5UIlIM+3qCLAPp6dEfv8/pSqd91qFBbEj
	 SpIr3jHd1UBwpH6PfOvhYD1/z/CHcBM8bhi/xpNV786+M98PadikbJzFw/fkldLwjL
	 NSwImEns+ixXxgQnAZjHuiz4NTOc8+3ldiCVePs0Nuy3ym1RW1zn1grlBaBQoygw/r
	 /iOvvf69fIWOQ==
Date: Tue, 11 Feb 2025 11:23:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
Subject: Re: [PATCH net-next 1/4] eth: mlx4: create a page pool for Rx
Message-ID: <20250211112340.619ae409@kernel.org>
In-Reply-To: <587688ee-2e81-49f5-a1a2-4198c14ac184@gmail.com>
References: <20250205031213.358973-1-kuba@kernel.org>
	<20250205031213.358973-2-kuba@kernel.org>
	<76129ce2-37a7-4e97-81f6-f73f72723a17@gmail.com>
	<20250206150434.4aff906b@kernel.org>
	<18dc77ac-5671-43ed-ac88-1c145bc37a00@gmail.com>
	<20250211110635.16a43562@kernel.org>
	<ed868c30-d5e5-4496-8ea2-b40f6111f8ad@gmail.com>
	<587688ee-2e81-49f5-a1a2-4198c14ac184@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Feb 2025 21:21:13 +0200 Tariq Toukan wrote:
> >> The ring size is in *pages*. Frag is also somewhat irrelevant, given
> >> that we're talking about full pages here, not 2k frags. So I think
> >> I'll go with:
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0pp.pool_size =3D
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size * DIV_ROUND_UP(MLX4_EN=
_EFF_MTU(dev->mtu), PAGE_SIZE); =20
> >  =20
>=20
> Can use priv->rx_skb_size as well, it hosts the eff mtu value.

Missed this before hitting send, I'll repost tomorrow, I guess.

