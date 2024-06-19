Return-Path: <netdev+bounces-104702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE490E0FA
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56961C222F6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA07D193;
	Wed, 19 Jun 2024 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="LJM1UQo1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777BD4C74
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757998; cv=none; b=esbPw7Tc3X0WFzKRwAcdaBzvkS7XSd1CCPZtNA8nCQF+Ku1g+lJKYwiIYsFMFDhA+73Yv0SqOvnka3SA0j6hQPqXRQ4RAO//66ahjxJvKkDWyamG7ppSkKptK7VvvLynApOcuBSpJ+NYmGa7Sw/eFUK6EC7p0CQBgmGYzIepofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757998; c=relaxed/simple;
	bh=R8++SWEZD8xeCDEJFNDUMqNhphENPOs7GFb5b/0/hyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQaFtZ9CHSPFcjvDBI6+j2OFNAzA4j6pMHvcxSd9FZdJyx4fHlWCp33p71WoKYHvK+6L4H9uhzxZSJG4/bGtd2VQltwukkcIlVgI7SMuEGotkzPnuz6DPNlTVM3XTmw0+fSml3oZmg4C65MyzoHSNDvJ1fa/ez5usqVSBhc+LTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=LJM1UQo1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-711b1512aeaso3871a12.3
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 17:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718757997; x=1719362797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNPPzDwIaYRBggHb+O1Ebf0xLNwNHlI7Y7bBUzVWZZo=;
        b=LJM1UQo1KDXUbwUkofqMQghGSmcjE1OigEl0kswWpPKhCMl18OILBdNY84u+W4W1RW
         9uq40q30/LzDM//Bw5kzfnN/wZt3kF9o1Fh1UPi7GZDVLr7IdJHTM+2mcEWDysDvfq20
         6yIATodPdrT7huD1Y+cCVLUkQGVO510pYPsLDR9gTTIOSKaRZJxoot+WNOjnRab+kUBP
         yjdaAIkGQf1zwqdFVfmewqCtgTLoZvla9G9e+IOE/AWiou0mAr9hhnxcUMr9fIuDib+D
         Xy0aUASIhtoe6Yf9LA5lyeMlH3wJUeGHaOEwCgbXyU7/29YbDflwOcie2ixAkO6nFd2s
         bqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718757997; x=1719362797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNPPzDwIaYRBggHb+O1Ebf0xLNwNHlI7Y7bBUzVWZZo=;
        b=w3fCcN4PpDcuWOf1Oj33tnk848NSihA/JiuyPYYDBjK9hxOX/mAMBltSKrcXx25CgE
         qjN4+FGfAMwgnJrZGiGoW6HXvHYcFxnp9I5JaX7ZuEadpxviQg94rO8eBMdLBtSySEpL
         MgQIthQDMBKTW/WwZmWsc6+Sfp0biLJtXXE0jlwZ96K1FwUQBVgW68TkMfvPtF0K1kL0
         VpM6MY5YRxWEvt7wW3a9A6deUbUOMP0IMo3GcTIbcNxxcNh9WJSZf8zXpupXd3FIUM+S
         5+S2/qyLGgUtsJC+AA2qyktiWHBA4PxpIUNNLXStM60YywsZtSTmca0JuKGdE2d9yDKm
         pZ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXFLl3oeWtySmbjvGkNwF/dtDywMavYpdIfPOsQkDh25E8zBcZ9YBziPnehOlYuGl3FMlFjgJ2M9pBq+2Lsk3osEtPkrWAN
X-Gm-Message-State: AOJu0Yym3AWq4iUh9huTmv+XFf3ZbFuNgs15WlCGiy+vwL9X5VY78gD1
	aHo/hQzqFdf2pZm0tdiGIlGBRyMFlp+/724R4LQpXXDQAeCX3gJERbT3/3Xl+wc=
X-Google-Smtp-Source: AGHT+IGAwe6lNZ2iJEBNh+m5U9TVb4PB10Lk69iEuIjOzNenngl5PWVZrcjWjusC8on95fpMXaOCsw==
X-Received: by 2002:a17:903:1211:b0:1f2:fb02:3dfd with SMTP id d9443c01a7336-1f9aa3adda5mr15034555ad.11.1718757996753;
        Tue, 18 Jun 2024 17:46:36 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::6:95e4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e7248esm103903905ad.94.2024.06.18.17.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 17:46:36 -0700 (PDT)
Message-ID: <6d697584-d860-4ee2-a2de-cbfca81600b2@davidwei.uk>
Date: Tue, 18 Jun 2024 17:46:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/7] net: ethtool: record custom RSS contexts
 in the XArray
Content-Language: en-GB
To: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
Cc: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
 jdamato@fastly.com, mw@semihalf.com, linux@armlinux.org.uk,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org,
 jacob.e.keller@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
 <889f665fc8a0943de4aeaaa4278298a9eba8df84.1718750587.git.ecree.xilinx@gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <889f665fc8a0943de4aeaaa4278298a9eba8df84.1718750587.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-18 15:44, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Since drivers are still choosing the context IDs, we have to force the
>  XArray to use the ID they've chosen rather than picking one ourselves,
>  and handle the case where they give us an ID that's already in use.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  include/linux/ethtool.h | 14 ++++++++
>  net/ethtool/ioctl.c     | 74 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index a68b83a6d61f..5bef46fdcb94 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -199,6 +199,17 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
>  	return (u8 *)(ethtool_rxfh_context_indir(ctx) + ctx->indir_size);
>  }
>  
> +static inline size_t ethtool_rxfh_context_size(u32 indir_size, u32 key_size,
> +					       u16 priv_size)
> +{
> +	size_t indir_bytes = array_size(indir_size, sizeof(u32));
> +	size_t flex_len;
> +
> +	flex_len = size_add(size_add(indir_bytes, key_size),
> +			    ALIGN(priv_size, sizeof(u32)));
> +	return struct_size((struct ethtool_rxfh_context *)0, data, flex_len);

ctx->data is [ priv | indir_tbl | key ] but only priv and indir_tbl are
aligned to sizeof(u32). Why does key not need to be aligned? Is it
guaranteed to be 40 bytes?

bnxt has key_size = HW_HASH_KEY_SIZE = 40

mlx5 has key_size = mlx5e_rss_params_hash::toeplitz_hash_key = u8[40]

