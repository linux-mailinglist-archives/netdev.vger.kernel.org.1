Return-Path: <netdev+bounces-201630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A855AEA20B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 203097B59D2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2DE2E7623;
	Thu, 26 Jun 2025 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW/zDQE5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F472E6133
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950719; cv=none; b=oyMrV72AG9yf/DME8x1lxPy5f3anORw6T7v4AJzRqdB328m5b95ohUe3MW+Do4za9+X3DSx9gxW5+qSHRrdzvhgPZ7v6y5eSLoR008I/VH4FaKMPy4oATVTBt5uO2xdSQCdmSv9JFSG+u/PL6fn5RRiqXu6IutNSFlAW6/nMY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950719; c=relaxed/simple;
	bh=d+QfPkx/v3aqy4lCtkbHbNfk94Rwa682MI4Rcan1b3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LshLYuUkeg3wmJ7nduWUID8J2L7FUSNuy9wj0XkXHGG/vTwQo0tl2mOc91nCT5fFLh2bFWbNAQouINf09keBt8rwsRfAPWKySOU9p42xuY5/jlVu/amZb3weQgfRBJe5mbwJ22coNpzkT7zwyIX9+O+zotFmUdE3gmGpKq5fJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW/zDQE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EB6C4CEEB;
	Thu, 26 Jun 2025 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750950718;
	bh=d+QfPkx/v3aqy4lCtkbHbNfk94Rwa682MI4Rcan1b3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JW/zDQE5Pcc0xtauK3ivVpMqmtyashCrQ29KoAYX9JhVQc0NL6NvEkDNiIcgR4+xN
	 YtRwBZhp2jVgoTFDsUiopkomcae4lVIlqezKtP+dN0Kf9A/PVKWdQlWtTjdU1E3nbJ
	 x9Sbnt2p0uX5VpGqGcsREmPvCsG5LLlPMeYQ6B14WPQivpSW4Py+aCk9ZkDKo6upSz
	 lOBJ4mG2eG6gbtAH5C4kG1FDDg87hkUBZ6Hl5i+umumGx47uh5RTmg4FPKFxSTEvqu
	 3H/J1CELiXNJ17SAfUCEPTU7/NIuTys2USM21Fjs7lDliFGxyZqNQbsVzvdZanFNIl
	 nh51bqCfXBZ2A==
Date: Thu, 26 Jun 2025 08:11:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem
 de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 02/17] psp: base PSP device support
Message-ID: <20250626081156.475c14d2@kernel.org>
In-Reply-To: <685d5847a57d7_2de3952949b@willemb.c.googlers.com.notmuch>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
	<20250625135210.2975231-3-daniel.zahka@gmail.com>
	<685c8c553072b_2a5da429429@willemb.c.googlers.com.notmuch>
	<20250626070047.6567609c@kernel.org>
	<685d5847a57d7_2de3952949b@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 10:25:11 -0400 Willem de Bruijn wrote:
> Preferable over the following?
> 
> 	struct psphdr {
> 		u8      nexthdr;
> 		u8      hdrlen;
> 		u8      crypt_offset;
> 
> 		u8      sample:1;
> 		u8      drop:1;
> 		u8	version:4;
> 		u8	vc_present:1;
> 		u8	reserved:1;
> 
> 		__be32  spi;
> 		__be64  iv;
> 		__be64  vc[]; /* optional */
> 	};
> 
> I suppose that has an endianness issue requiring
> variants with __LITTLE_ENDIAN_BITFIELD and
> __BIG_ENDIAN_BITFIELD.

Right, this part. Always gives me pause :(

> > > This makes sense with a single physical device plus optional virtual
> > > (vlan, bonding, ..) devices.
> > > 
> > > It may also be possible for a single physical device (with single
> > > device key) to present multiple PFs and/or VFs. In that case, will
> > > there be multiple struct psp_dev, or will one PF be the "main".  
> > 
> > AFAIU we have no ability to represent multi-PCIe function devices 
> > in the kernel model today. So realistically I think psp_dev per
> > function and then propagate the rotation events.  
> 
> IDPF does support multiple "vports" (num_alloc_vports), and with that
> struct net_device, from a single BDF.

Upstream? If yes then I'm very bad at reviewing code :D

