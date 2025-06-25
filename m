Return-Path: <netdev+bounces-201364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9514DAE9315
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 01:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DE67B7789
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD24B2BDC34;
	Wed, 25 Jun 2025 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHDOJ03w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ECA2F1FEA
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895704; cv=none; b=b1K09kz35vHZZmymTZyd4WjTV26zR24eKZqE8E6YJyY2C6aXkMZq+R6WOYk9Tgxb5ZmcDtq7913bd2JRtviwZCZMIkA0y/nhS7vXZf1BCWN1rNkuJxFHPbI2qGEiai/DDF4bLjNs1VyMLxCZuelJHJ07mKKkcPXgX2iGX5Ow9Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895704; c=relaxed/simple;
	bh=46qic1KDI5RKO8v178K8Bv9wUbZbi2XlhZKi77oZSyk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=R9sxCfcOal8AT8I9F21T4RkCLOLByc/Vom5zP+kr7EhHA+LGwTbE7HKCaQyKDyoZrx0GdFHctfl4VV09LqJwNfUeBk+0Q1ZL/DGLHDtUwBzmgMNMmPdiojdxy/99BZp/62AjuWP+L0T/d04pWt28ovzre4UNktV56qbQl5Pv4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHDOJ03w; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70f94fe1e40so17941967b3.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750895702; x=1751500502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yT9kiIoE1/9t7SeJWxjyrcEPed9XGx/yWIlgmM1Zjk=;
        b=gHDOJ03wPWdMFba4I1o6h85Gv/5CzpvelQ04Ob2iDilYCIRbEYA9/FWDgEU0A0yZVa
         0qUC/HldhIvv5cigsKIkEEHMJDeQW0+CuezH5SJJTR/5A9wgXPaNmeeRv/mGcl8qYWzq
         flxdxjYzsWiftpziCXJc6aVyyApS6q8O84Bl6lHBA92n3aCswxA6TouzfxbFG6sRBDlV
         hfhF4w6w3Xo1PfjkkxVbEPqNRdyY11ZTiGAkX+K0n5OMLUmobdZWIkKb+O1hzSQcI3vC
         FvepHb5TazV1LXpdBCDyFQL+W5v1A/8fNFw/C/7P9J3iTm+vYZol9wBHhCVTNW/R3h/m
         NpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750895702; x=1751500502;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7yT9kiIoE1/9t7SeJWxjyrcEPed9XGx/yWIlgmM1Zjk=;
        b=LQhXZl/jBAqmrWxbGvKjq7DApyqsn1+BxNXAGt710r01z1ghN3k2RqlRTBvAiw90Qx
         OG+jhZbij8dc46EBTXi09GnvcHNjIViuSTCkB6ee5cD1wv3DKzbPbz9u++/f7zeNaHOf
         xuu0kgjaZl10Cr7wj57TEHzNf/QX0tC3OQ9AcrKMhH0tSgrtxZdX59UtyiS3DwS/hEmZ
         XItSu6U/M6JZg5hVMxGLv7xv5UwwJgcfe8epUow2AaFE8Me2b+Z9YqXPj+m/GFhXLwps
         6yZyx3dU2Q9lI0svHgpJVUo49bbmzjRwoEgiZsza4suvdvD5zzcMTXzo2EHlE4KcOT2c
         SeZA==
X-Forwarded-Encrypted: i=1; AJvYcCWVFg2LPX6mZHPrlXrxGi+67V7o6skn1Q/AEm7eqi9fSGi+g3c4Aa2NpNkqRQui7spxkEixcns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKiJ7R5xxKr9TxhwYq5aYK1nkuTSy9C1RPFWk7QYCts1i+4RZ
	NWbataxCx5+bPgaJunJcuVjveReMOHrQ+cdF30ch3zMDSyUtvLci4+Tz
X-Gm-Gg: ASbGncuNevVf4gnzT5xzMiLoJAF2/ClpMRuYPrCG3bqQUyW2wEVwpK4lkJC54tRP/Mo
	XJo2twQxVrFdJQsZUJtTHh7zI5xU8EZO7YL9gEx0sh7X8tXlEiUu5sIFMjuRjlgz5upM6z+cA1x
	bDsxfrlPSav5iSxOr4sM8oX+WndG6gz7LS54bC01/MrThYJRMRC2D+J6MfgGcuz7I85XQN/uKCE
	9tISusQg7dhKX7shEIAtVuf4WTsTcYyybCTG/MebibYpS8YsKLM83HizjZT3x8/qdy7hSDPUtoi
	L47EYQLDKwsx2S/DmqpYFWmC3SgWjQVo3eYps4U9zpqb7q713O6gg4Guy2rgz47aAZvwCq9Gmd9
	I4TxdQW0IB0MYQRyQfmo8dJKG/lS1jZ6EmHUCPUEeJA==
X-Google-Smtp-Source: AGHT+IGlvrvkwLjKntJnGxNKn3k6NALFwhUyCrGdeEB+OhtSrrdZaPFiVHM9iJQzrudnxJT+MhVeSg==
X-Received: by 2002:a05:690c:4d43:b0:713:ff19:d046 with SMTP id 00721157ae682-7150947f1a6mr24346137b3.6.1750895702070;
        Wed, 25 Jun 2025 16:55:02 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4be3757sm26490017b3.92.2025.06.25.16.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:55:01 -0700 (PDT)
Date: Wed, 25 Jun 2025 19:55:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <685c8c553072b_2a5da429429@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250625135210.2975231-3-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-3-daniel.zahka@gmail.com>
Subject: Re: [PATCH v2 02/17] psp: base PSP device support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Add a netlink family for PSP and allow drivers to register support.
> 
> The "PSP device" is its own object. This allows us to perform more
> flexible reference counting / lifetime control than if PSP information
> was part of net_device. In the future we should also be able
> to "delegate" PSP access to software devices, such as *vlan, veth
> or netkit more easily.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

> diff --git a/include/net/psp/types.h b/include/net/psp/types.h
> new file mode 100644
> index 000000000000..dbc5423a53df
> --- /dev/null
> +++ b/include/net/psp/types.h
> @@ -0,0 +1,102 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __NET_PSP_H
> +#define __NET_PSP_H
> +
> +#include <linux/mutex.h>
> +#include <linux/refcount.h>
> +
> +struct netlink_ext_ack;
> +
> +#define PSP_DEFAULT_UDP_PORT	1000
> +
> +struct psphdr {
> +	u8	nexthdr;
> +	u8	hdrlen;
> +	u8	crypt_offset;
> +	u8	verfl;
> +	__be32	spi;
> +	__be64	iv;
> +	__be64	vc[]; /* optional */
> +};
> +
> +#define PSP_SPI_KEY_ID		GENMASK(30, 0)
> +#define PSP_SPI_KEY_PHASE	BIT(31)
> +
> +#define PSPHDR_CRYPT_OFFSET	GENMASK(5, 0)
> +
> +#define PSPHDR_VERFL_SAMPLE	BIT(7)
> +#define PSPHDR_VERFL_DROP	BIT(6)
> +#define PSPHDR_VERFL_VERSION	GENMASK(5, 2)
> +#define PSPHDR_VERFL_VIRT	BIT(1)
> +#define PSPHDR_VERFL_ONE	BIT(0)

Use bitfields in struct psphdr rather than manual bit twiddling?

Or else just consider just calling it flags rather than verfl
(which stands for version and flags?).

> +
> +/**
> + * struct psp_dev_config - PSP device configuration
> + * @versions: PSP versions enabled on the device
> + */
> +struct psp_dev_config {
> +	u32 versions;
> +};
> +
> +/**
> + * struct psp_dev - PSP device struct
> + * @main_netdev: original netdevice of this PSP device

This makes sense with a single physical device plus optional virtual
(vlan, bonding, ..) devices.

It may also be possible for a single physical device (with single
device key) to present multiple PFs and/or VFs. In that case, will
there be multiple struct psp_dev, or will one PF be the "main".


