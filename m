Return-Path: <netdev+bounces-249953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E0D219F9
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8177301965F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBCA26CE3B;
	Wed, 14 Jan 2026 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed8/hl5G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBB3A89C7
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430236; cv=none; b=J0/c0PBvemuUDEBoyVD7GYoA7I7qwHx+cbmqmZ1ym7Dw6pQpAFwy4oyHZxJjlfXEBVvh0yX1U5ZYqq0Z5KhxvxYFfa6AGRMqDYtdea4Ruga34S7qetxbS77hQIU0ruhBdR98lcQzyd/4SJs+2LkgRgWcJSMi42EqNWRb3J6yB84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430236; c=relaxed/simple;
	bh=Pap9Hrw9sCOWF6kQ/n3lacCHfMkKgmDgfgqp3WjtKLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufPLpsA+jXCeUOAkHABtjof8Bc+/GQXuGfkw19aAwVJUn2+JpsByteGRLy6pVuEAceLEtsGH/VQpmmpn7b5LoH9ntYGS3B6yhQD2zvbzgCLNoy2YKmQ0Hb0450HlplAwNgaXMw64e7cw2b/HBc9PLUbvIdshsZdYj/I63yGksC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed8/hl5G; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6505d1420daso46139a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 14:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768430229; x=1769035029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=11kECEzSebBpOV9cxC6Ool0wSvyZx2KWiMTg0SiIkhU=;
        b=ed8/hl5Gi4mdLF2b9YXsKYZL3s4dH0FymKGamqBHU/AvYYgE8jMPFeEEnEguK+OFO8
         t/NIxX5RAMRSqpEG6nFxwDAh51UuaDD5LvUjlRc9W7jtsVX4eKqMfV6/mv2pbd1cipJ9
         l3NvQYec9xcdeQHoVgc4XYviU6ngWKc4gDTkYJAMqL7ZUga2u4Lss8TglTyAepSp5V1x
         NeJudN0OkfPqvN/deydXb+R2JqeM72i1AzTb4ut4AdAkgKB4vNr11V1OtDu0Xaqjkg/X
         0wEZoMdCX4PTfZpItSwFY3EGAAA8kJSf94S2uw3Jc87CL2fjIn3dcQCEoPS2lxc6nR37
         nWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768430229; x=1769035029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11kECEzSebBpOV9cxC6Ool0wSvyZx2KWiMTg0SiIkhU=;
        b=ZnVWQOR8Hc1Z9zRVz5yYRekcaI5Qvt/P9DtExu2uSVJMjmLjciOyuU6JB+qwpcvzQW
         TkxVClc20MTIHiLDSzsFKeTunm6VcKOIpdnfUg3bKEjOvVVdwzBZyMoINpX+pEHQB+VI
         t/jAi8ixn5Myh+BicRElHR3wGEql3KwpRLfT9QeE9hh2CbZdRSiOyabQs13a9pGr/KYv
         Oa+BDLzom1PsjbxJ3V1qCUopMvUB6rJa1USU3T1FMI1FTheYT+FCbZavnXBk9yJktgy0
         ToIAaSJGpCOpsmvIo1mS0YJbv3SlecwWDQJUTIHGlm+qlEDdw85DH6rxsgH/sheeiqVl
         VfyA==
X-Forwarded-Encrypted: i=1; AJvYcCUU6YQUPRZtJSTXR5Yh/x0WZNFyOw5EfOcsz3YX6xO5KVhAhlMLgF7eSM0b0+vbldG1RVv+H3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Nk6h3qO71fVnmbcBeSxCkoz7mTnYrpiCvccSHHKAHlb+6Si8
	1EMk3Yxjt4RX19JTNYzDVtsxUSZNT/gsBFruzmup7rDNQ6K5AP35UbCj
X-Gm-Gg: AY/fxX6EhgSQ2iMDxAYpZ3vLF+7b/c9jfhCLcs7EIwIGTz0E3K3dhsM7AWR502dP2s1
	uFkuRLl5gO0Z/o9m8AsKL/+aExzf7Cvc3TDSuEadEOETkbxL7WZaN+/V/mVGuwyM+Yv/XAHZ/l7
	ByJyhldVSc2p96fejVo8Vq4Rwlkytv+U+ZeFvsrysamMuzs9qJA79Z/H0yr0ejtezHRE0KJZ+23
	VTxBZYjie134XLSdkSzm+/E1SO2Y+wlzzvLHAj9CiUxZmQtzR9S9lBuzjUmA7cwvFswFKeZ9UUK
	313ikWa2p7PPOuW0iRFwUqnQ+oT7xQo4vvA0QEGuIlFaysoP4bDPhbbVkXTFmnva661DSKTj1VP
	tONQ+XXBQY0chRMt+Sdy12KqVUk0qoS3JkIal8v2NCHMKhFv0tG6uc1DPjnd8IGnrofZP8ZpTGv
	A/jA==
X-Received: by 2002:a05:6402:1441:b0:640:abd5:8646 with SMTP id 4fb4d7f45d1cf-653ec459b14mr2127866a12.4.1768430229105;
        Wed, 14 Jan 2026 14:37:09 -0800 (PST)
Received: from skbuf ([2a02:2f04:d703:5400:d5b0:b41:b5b3:8c4d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882412sm737757a12.14.2026.01.14.14.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:37:07 -0800 (PST)
Date: Thu, 15 Jan 2026 00:37:04 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen Minqiang <ptpt52@gmail.com>,
	Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: lantiq: allow arbitrary MII
 registers
Message-ID: <20260114223704.7qbcfop4fs67fqtm@skbuf>
References: <cover.1768273936.git.daniel@makrotopia.org>
 <78d3c0cca783d11ecbf837c959ff18b132bdf104.1768273936.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d3c0cca783d11ecbf837c959ff18b132bdf104.1768273936.git.daniel@makrotopia.org>

On Tue, Jan 13, 2026 at 03:25:16AM +0000, Daniel Golle wrote:
> The Lantiq GSWIP and MaxLinear GSW1xx drivers are currently relying on a
> hard-coded mapping of MII ports to their respective MII_CFG and MII_PCDU
> registers and only allow applying an offset to the port index.
> 
> While this is sufficient for the currently supported hardware, the very
> similar Intel GSW150 (aka. Lantiq PEB7084) cannot be described using
> this arrangement.
> 
> Introduce two arrays to specify the MII_CFG and MII_PCDU registers for
> each port, replacing the current bitmap used to safeguard MII ports as
> well as the port index offset.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
> index 8fc4c7cc5283a..b87a68a1b3b67 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.h
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
> @@ -253,8 +253,8 @@ struct gswip_pce_microcode {
>  struct gswip_hw_info {
>  	int max_ports;
>  	unsigned int allowed_cpu_ports;
> -	unsigned int mii_ports;
> -	int mii_port_reg_offset;
> +	s16 mii_cfg[8];
> +	s16 mii_pcdu[8];

Why [8] and not [7] (the larger of GSW150_PORTS and GSW1XX_PORTS)?
I would prefer to see a macro holding the largest port count of the
supported switches, and the "7" also expressed as that value - 1.

>  	bool supports_2500m;
>  	const struct gswip_pce_microcode (*pce_microcode)[];
>  	size_t pce_microcode_size;

