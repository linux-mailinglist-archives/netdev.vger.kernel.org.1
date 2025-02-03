Return-Path: <netdev+bounces-162217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9EA2638D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC5A7A0F6E
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376FF211A36;
	Mon,  3 Feb 2025 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRwpoliA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37233211711;
	Mon,  3 Feb 2025 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610134; cv=none; b=Ev0Rj2o3tEaMUNN+Yj7U0cJZRXhkLz6vnRBF0Qc+MatfE9+gIKtIsNTJt6SyM8KgtnCc6tRkpU9n3DF/hokRzFRAEyIvVbCy15EUgoyO/dkpDAkLFdI/fnwBpOSAszT/qLhngxtlw+iLGYeZSs4I5qM2JAjdh8VQxCMv3IrtAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610134; c=relaxed/simple;
	bh=yJLaDaJbvBCJ5deh7pOKRobdenJvk6Jb4hU6B4/8YW4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TCwU3kJQyRD4uQkxFH74yNhUT0vWStEshiIqAJIOFnfmcOmLI4FvCOxN0bo8o/4NVl+LBmEO+9+fz9oXuDd70B6mGa3pDkixPQCH+T4sWKF0cu8M9rsrPzPZsRIpdrrqeHGCqKTZVjnZ5VAeaWNtVOPDjGMOaOojjTnlCvCsU+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRwpoliA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385df53e559so3499280f8f.3;
        Mon, 03 Feb 2025 11:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738610130; x=1739214930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6LL5X5fvkK6jGtdywWodIwxp+6C6qkyq1s+zBLD+A0=;
        b=bRwpoliA6TIM+YMk/DMT88g2USVZbbml8irSvqUsmux6FlAG5WhPzdifcJWQo/aSyr
         MhE9jADxsqYAcXqnao+NspSvyvWtcqWkRF2+fJdTVOGijPbr0V/3LAXbIeaoDXDpfTmD
         Z5D0WJBi0hSg4PLKkjaW+l7SNjyzbOR4Xi/W7DKluSAd5uP0jr+jS0/iqAAsA+XEUj2v
         Ltku+aRjXrUEZNhfNIJUHK5irYkl9Iedy/hkKNV7lOa8S6cUJ4b3c9e4oO1BDH7JeybR
         IvWWRYMq23DWToBy0wr93/PRZo5rivw6tmUfSYBT3u7adPxSqRQ6tGS0nauAAhkn6FJL
         vZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738610130; x=1739214930;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6LL5X5fvkK6jGtdywWodIwxp+6C6qkyq1s+zBLD+A0=;
        b=WIv6aQou2GIKy6tlXEJffS5ovoGwOEmhWfHVbkQkQ14HVeqJHWcFqxA+Z/VENDMiqz
         5KCxsraL2eNV+Eu580EJt/EAuPMCTdMbpjiHdQ6jf3VHHZXF/SwQLZa/FgMLju5Me5RU
         XMuhXUmWzRyYUc6y2/pWeJtPQm4Y4Vmn2SY7o6piB/9qJ3ncl3isdoLjrRQceGXV81tl
         k7cxBpVpipY+oXIhQbPUzjGKZXkk8eDuWc3Fht9WfuFHem3EgdEdg7BaviZseR6Tyz5a
         BFc1BEM09sK6eRQwSZsMjEV++j6X4TOyBtpZ7wkuT5hokQkx8wGCjLwlzeh/gh5jtiMR
         dMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvyiInYcqTrqBy7Qefw25nC8sXBoh5TbU7ACsgZr4/DyIGMX43UDJO55HNh9vHqML2LsabMSo2tqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk66NliVM6MEqohbx1rGppqi3Du3BF80OvQ1dMdCOatNgB4hRz
	KExicrCseyS3x+gaIx00F0cB2PplRYRnpgqGpECOVgsST+vgNi6P
X-Gm-Gg: ASbGnct8XVdgXxPKouC0IdfwMaKy6bmVCt7rOGDLYrz/PashIJJGWgVQ95x/2Hs4aiS
	l81zJX9o9JIDV/CXTsqfJs383kUMKAd7tyF1NJ3gYOwdJe3Ald2XnMlb/a7g6nEqTqlgI8jAJku
	TKjupv/qAy5lCmKVq3V+pHf5P25LjYxCun7/QWGezPLFWZdkvxjJ3FavQSc9UuTNxAVD9jfvLu8
	gWh5Bn513G/RehpupghM+1520Rh7o3zl/BWKyiM9in8hO5Nnb90p0GOhfKRwcTgSSF2zCmDtIKh
	jJvSkq5G0pPC8sn1Jq59P9SrcI7xqCg9eR8PlS3vYB46nSvRUspj1Qs4V0EXDLH2MEmTp8H5FdP
	eFtk=
X-Google-Smtp-Source: AGHT+IELe33TOMTobFl2OBs6wvBGqwR2vFk2VZPKToAuO6yTZzITHfa6Lmk5tOvRSY9AfCqIMsbbBA==
X-Received: by 2002:a05:6000:1365:b0:38a:888c:a727 with SMTP id ffacd0b85a97d-38c5195dd2amr16738009f8f.25.1738610130159;
        Mon, 03 Feb 2025 11:15:30 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc27125sm197797275e9.15.2025.02.03.11.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 11:15:29 -0800 (PST)
Subject: Re: [PATCH net-next 1/2] ethtool: Symmetric OR-XOR RSS hash
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, linux-doc@vger.kernel.org,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <20250203150039.519301-1-gal@nvidia.com>
 <20250203150039.519301-2-gal@nvidia.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <08135b32-c516-7f6b-f7a1-e5179840281c@gmail.com>
Date: Mon, 3 Feb 2025 19:15:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250203150039.519301-2-gal@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/02/2025 15:00, Gal Pressman wrote:
> Add an additional type of symmetric RSS hash type: OR-XOR.
> The "Symmetric-OR-XOR" algorithm transforms the input as follows:
> 
> (SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)
> 
> Change 'cap_rss_sym_xor_supported' to 'supported_input_xfrm', a bitmap
> of supported RXH_XFRM_* types.
> 
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  Documentation/networking/ethtool-netlink.rst   |  2 +-
>  Documentation/networking/scaling.rst           | 14 ++++++++++----
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  2 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c   |  2 +-
>  include/linux/ethtool.h                        |  5 ++---
>  include/uapi/linux/ethtool.h                   |  7 ++++---
>  net/ethtool/ioctl.c                            |  8 ++++----
>  7 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index 3770a2294509..aba83d97ff90 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -1934,7 +1934,7 @@ ETHTOOL_A_RSS_INDIR attribute returns RSS indirection table where each byte
>  indicates queue number.
>  ETHTOOL_A_RSS_INPUT_XFRM attribute is a bitmap indicating the type of
>  transformation applied to the input protocol fields before given to the RSS
> -hfunc. Current supported option is symmetric-xor.
> +hfunc. Current supported option is symmetric-xor and symmetric-or-xor.

"options are"?

> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index d1089b88efc7..b10ecc503b26 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2263,12 +2263,13 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>  #define WOL_MODE_COUNT		8
>  
>  /* RSS hash function data
> - * XOR the corresponding source and destination fields of each specified
> - * protocol. Both copies of the XOR'ed fields are fed into the RSS and RXHASH
> - * calculation. Note that this XORing reduces the input set entropy and could
> + * XOR/OR the corresponding source and destination fields of each specified
> + * protocol. Both copies of the XOR/OR'ed fields are fed into the RSS and RXHASH
> + * calculation. Note that this operation reduces the input set entropy and could
>   * be exploited to reduce the RSS queue spread.
>   */
>  #define	RXH_XFRM_SYM_XOR	(1 << 0)
> +#define	RXH_XFRM_SYM_OR_XOR	(1 << 1)
>  #define	RXH_XFRM_NO_CHANGE	0xff

I think this should be two separate comments, one on RXH_XFRM_SYM_XOR and
 one on RXH_XFRM_SYM_OR_XOR, so that you can untangle the phrasing a bit.
E.g. there isn't such a thing as "Both copies of the XOR/OR'ed fields"; one
 has two copies of XOR and the other has a XOR and an OR.
Second comment could be something like "Similar to SYM_XOR except that one
 copy of the XOR'ed fields is replaced by an OR of the same fields."

Apart from this, patch LGTM.

