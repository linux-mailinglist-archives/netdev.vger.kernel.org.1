Return-Path: <netdev+bounces-237039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB4C43BE8
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 11:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1EB04E409A
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 10:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709F62D5C6C;
	Sun,  9 Nov 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="n8/o6YJv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571A2874FA
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762684798; cv=none; b=TnIliz1R5d5vv7B2CWmYn5fTbuGqBHYfJJDI3vhRMdA0TnuZ6XUhKsy6u8+8ATmqq77bxlLGR3hE+zT12JI09feUZj3aavBT+zD0yczr8bkFggtSc/0BG/q7+1YRAcr2Wieav1RXY69ygYflBIuQnCFtnNSdgkLuqF+axcvJFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762684798; c=relaxed/simple;
	bh=GWv7Yx0foUQULYjiBsrLoexN62ZpupZwV+SSKDZSTAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm5calyMwEkESSCh7/69NhDYpyY4nR/Yun2NwGrFIHRNurgw5+y3G4JUKxVvIupjk4L+sjFhkevUC4pWVI7YmzL2UFajWTplcHGaCQhz5ZVr6RyTwvksfyhI+Z6HA6j3Qyh7t9DI886onPc5zfUghVLZEhOuYwntUrzmnWlYbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=n8/o6YJv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b72134a5125so305237566b.0
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 02:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1762684795; x=1763289595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9k5NU9CvPXHOQFjRFf4cyiGap0OxcUU7zGSG67KNV0=;
        b=n8/o6YJv6xt348UZQWCazGHg2q1OqiXq3gR7JRCK3HEk0scr1LCmQi+0cAJqH275+i
         lingcDtNQduxWVmM7Fa+AtnvM9hZXSiMR3ZgwutviZW3UVooqZX1HLf57+1xyfH8whOz
         ZmbHGW48qrzZyMtktbeSBrbZNcwVtdER1yTUSH8lfsrJ9mLoBcvx3czHC63wDmRySAr4
         oyaB1KhInmHOI4Zpiaf/s+m32XBRB5+Ui9GJ2GaqrvFKYw1n7jPcC3deEK4dh9y/3dbI
         zBz48Hrz1y1vQlsa1XSbEt8fF6Q/uzzNUtvS7H27e+m6pbVoSlCSBCGg+o8hbv7ELNuE
         pV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762684795; x=1763289595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9k5NU9CvPXHOQFjRFf4cyiGap0OxcUU7zGSG67KNV0=;
        b=eRIi8Q1B6SAsEjalM8L2PSDo3ZUqUjUR0R+hDMu4z+1mKM5KodkMyjIzcVZgG5NE0p
         k8Osq592CRiYeM51pBom5213AZwckobdYQGn4KNtbVSgEPEkVB2/z/XRfERk/poFsLO3
         JvVlqJsBwnygKfMcOt7oONnGpKE8Wlv0tGU55tohxVGRMBnFppkx5dJmeIBiwZJwyPS6
         vT9S9w8yHtLzzLA8dFOqOapwCtR7vg3NYVx3osGI1NJIazMw4+Wt5M2aTMrx4WTsc1cz
         tARYkT8jwaHZG6fXJ2tzM5cKUi5+tObp82+qyu5eoNkMkrL/7mPUB72DNcdYCMKd7BWC
         hZow==
X-Forwarded-Encrypted: i=1; AJvYcCVVTmKBzd5GCoXEOJ43DnLVV2qo9y5X0rmVpKhkGSQtDrSyJNoCbEHqSAOOEhMqjAaeGG2Z8PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/iSRrfg0qAC8xuExkq5hnKTFcBGcyA8eAv+zn0dLGHQch7Yq
	s/b5H/DgWOs27eUA1yGRhm7yfpPtnVPlkS/neonzp9d08i9H6HCW1TuZXrHNEfaFeAI=
X-Gm-Gg: ASbGncujAqfUywIsRsOJKwUaiMjfacAxokXBWnmorX8hSwSwJhJIQI3MBgwheP2S12I
	HesNH9LNpmcEzU7Zqhqj/KbFtpLtHpT9dau6S3JxME2Jg8kJpO/DnT9gEmfbzKdlF0lJjngEZrh
	MtnoCNVy4+ROvOla+QOPXwIdsihiktWuiJS2JoU/jou0296MS/3rj+N9qhz60Kc3xD96FsqoAmE
	XstUcdjFoSoz6OVAvVZvf/kH6h2VOr5tz+858cImq8lnZhTOel5CHdX2Om0sMJFxQxzW4DIJjQx
	HtKOb39HqW/GFYrr3xhyts6BgcTkgEfmeTLQeGRByUKBkGG2PmmsEHdnV1+DDg8TFzsN+oKHY7T
	EdcsYNr+JddRpYb4pxfnXQxDoVlqq6zkoe0jibMyTIcFL208W/QDwmxQh8CSdk3WM/DHW59ZO/L
	vbsap6/1tMgkTJNsBX
X-Google-Smtp-Source: AGHT+IGiAUMWo+QvSERmjIIMyP89hGQRiOZTK4ZUYS5n6Hi8A+5UCIsgg27hL+sayFE1WTxmR9XApA==
X-Received: by 2002:a17:906:6a08:b0:b70:b83a:73d5 with SMTP id a640c23a62f3a-b72e0591f8dmr463037266b.46.1762684795103;
        Sun, 09 Nov 2025 02:39:55 -0800 (PST)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d0f3sm813415066b.48.2025.11.09.02.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 02:39:54 -0800 (PST)
Date: Sun, 9 Nov 2025 11:39:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Srujana Challa <schalla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Dave Ertman <david.m.ertman@intel.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
Message-ID: <mfuluoi4nebyc4avj52gkfs4nqikn6uwhqnkf4o6xfswtpceuq@zhpokcx6bb6l>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
 <20251107204347.4060542-3-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107204347.4060542-3-daniel.zahka@gmail.com>

Fri, Nov 07, 2025 at 09:43:46PM +0100, daniel.zahka@gmail.com wrote:
>swp_l4_csum_mode controls how L4 transmit checksums are computed when
>using Software Parser (SWP) hints for header locations.
>
>Supported values:
>  1. device_default: use device default setting.
>  2. full_csum: calculate L4 checksum with the pseudo-header.
>  3. l4_only: calculate L4 checksum without the pseudo-header. Only
>     available when swp_l4_csum_mode_l4_only is set in
>     mlx5_ifc_nv_sw_offload_cap_bits.
>
>The l4_only setting is a dependency for PSP initialization in
>mlx5e_psp_init().
>
>Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Daniel, I asked twice if this could be a non-driver param. Jakub asked
for clearer definition of this know in that context.

Not sure why you are ignoring this :/


