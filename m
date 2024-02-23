Return-Path: <netdev+bounces-74416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E6786134A
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200921F24564
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8734F7F7C5;
	Fri, 23 Feb 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="XW3y4eUF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A822EF5
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696277; cv=none; b=Tq7sCLHxDZ7PkacJCJ7t22R5m8A3raf3S88dkibfbcxyHn0UTyewbjIixtiFetxAw2OCdd84HsX73y1xP2gN/PSTpNU3EWkDxhcxnigZNRIvP8Ml+z01L9Z0LdR5foqWaQ3T32ViE0SuVKPGKPBAYYuyqoIxvoDF80XJ46V29G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696277; c=relaxed/simple;
	bh=z5TGGrjN4MAuMZNQnPuUQ9zY3sa+KXraw5MLFoXxZlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mp74W24UCL2WmMkeDSnHv4IZV1hZr2perH8nzq/2lP+bOvKX06kZbMaNY3Wxfi9YTaF04DeY7AGug95CfmSYdtBhoqqbypvbdO6ym7qT76dctXZ7/4zn//7euFzD8KYMuhP+kxUJfMRMR8cWixSMc2/6D7j60f6uTFBDEvZdegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=XW3y4eUF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412934b98b8so4466805e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708696273; x=1709301073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iZwGg30Qhe3RHP/o4rUKd+UtwwoSLo/P5Q4i2I0lgOA=;
        b=XW3y4eUFqVqjA33wy9ACKbsgYlz3Fx8+e9Qz9NTnygBtBMZaw0wErK2watW0jC2Ry6
         uKvAVV1bGB8ZMklWGWFjBQskEx786SuXXdcdVzLSOObhgskorqsJRglUQuEi2jxVwTKk
         9DgDF5PgHUrereu+0jr19L7JN+s3FYMACuEnXzqWK+2Va8M+Et3jLEtc8jLq4usckGuR
         AkLhdjgeVCaKk3WjzWxQ8zDF9bWzFf6u4SCuZs2kzJqn072eI4/qBAVA1TS1p+Pg676J
         A07D2zOuepDYJ2I+J7p15XFay+q4h0UuN9kX/SpjgPxR6oIgdE7rIu2ZsWDTP0kIoHY3
         t01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708696273; x=1709301073;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZwGg30Qhe3RHP/o4rUKd+UtwwoSLo/P5Q4i2I0lgOA=;
        b=DiYXjm25cKlgLu4ZRudYPT+Cl7c4TCFXChKkwCKZxhBUu2FjOR0z+Jh857ZaVm206c
         e2ZXFyU9fQt8/Oh9jZXrOH3RujchkQsXiW+FS3GWB3Q9UE00uLvkegjYCkTQFRN5eTBc
         MzXFR8s72vYC9I7p24FQUE/8Xprom8itlVf/gYIsuDOv5AzA9EWZGvcCPb/E2OLSs8+2
         2wGNW8stMGAg4cIPTl5evlijsTcseoEklaBWende+jnUZTyE/iJWj8RLLiVoDhOK4Cv6
         l8EXmpfG75MxL8ot/q10h9Nd/ADxuJRdatoS0nhmteAbKObbhObhmMAp/DERg7mCpjyw
         naMA==
X-Gm-Message-State: AOJu0Yxzz8vUlaz2PfGrvx3x2DYZdPqPI8syZSMKLQjVroJ4dY9rCmde
	UGAwib8zifkBmeBO+73pimfvDiTD6guc++QXuuO0aUb5+1KzY2jlL4gjQA/UGR4=
X-Google-Smtp-Source: AGHT+IHiw99S4qG6gWIeegnW/TakczwiFNVeqM6daVwBWYbQnt7HaHILBSrH0wkxFwtezWAmWEVtsA==
X-Received: by 2002:a05:6000:910:b0:33d:6ca1:3058 with SMTP id cw16-20020a056000091000b0033d6ca13058mr1521453wrb.56.1708696273535;
        Fri, 23 Feb 2024 05:51:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033b406bc689sm2894162wrb.75.2024.02.23.05.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 05:51:13 -0800 (PST)
Message-ID: <5ec74f4d-5dbd-4c2d-ab11-d00b0208b138@6wind.com>
Date: Fri, 23 Feb 2024 14:51:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 01/15] tools: ynl: give up on libmnl for
 auto-ints
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-2-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> The temporary auto-int helpers are not really correct.
> We can't treat signed and unsigned ints the same when
> determining whether we need full 8B. I realized this
> before sending the patch to add support in libmnl.
> Unfortunately, that patch has not been merged,
> so time to fix our local helpers. Use the mnl* name
> for now, subsequent patches will address that.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>> ---
>  tools/net/ynl/lib/ynl-priv.h | 45 ++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
> index 7491da8e7555..eaa0d432366c 100644
> --- a/tools/net/ynl/lib/ynl-priv.h
> +++ b/tools/net/ynl/lib/ynl-priv.h
> @@ -125,20 +125,47 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
>  void ynl_error_unknown_notification(struct ynl_sock *ys, __u8 cmd);
>  int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg);
>  
> -#ifndef MNL_HAS_AUTO_SCALARS
> -static inline uint64_t mnl_attr_get_uint(const struct nlattr *attr)
> +/* Attribute helpers */
> +
> +static inline __u64 mnl_attr_get_uint(const struct nlattr *attr)
>  {
> -	if (mnl_attr_get_payload_len(attr) == 4)
> +	switch (mnl_attr_get_payload_len(attr)) {
> +	case 4:
>  		return mnl_attr_get_u32(attr);
> -	return mnl_attr_get_u64(attr);
> +	case 8:
> +		return mnl_attr_get_u64(attr);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static inline __s64 mnl_attr_get_sint(const struct nlattr *attr)
> +{
> +	switch (mnl_attr_get_payload_len(attr)) {
> +	case 4:
> +		return mnl_attr_get_u32(attr);
> +	case 8:
> +		return mnl_attr_get_u64(attr);
> +	default:
> +		return 0;
> +	}
>  }
mnl_attr_get_uint() and mnl_attr_get_sint() are identical. What about
#define mnl_attr_get_sint mnl_attr_get_uint
?

>  
>  static inline void
> -mnl_attr_put_uint(struct nlmsghdr *nlh, uint16_t type, uint64_t data)
> +mnl_attr_put_uint(struct nlmsghdr *nlh, __u16 type, __u64 data)
Is there a reason to switch from uint*_t to __u* types?

>  {
> -	if ((uint32_t)data == (uint64_t)data)
> -		return mnl_attr_put_u32(nlh, type, data);
> -	return mnl_attr_put_u64(nlh, type, data);
> +	if ((__u32)data == (__u64)data)
> +		mnl_attr_put_u32(nlh, type, data);
> +	else
> +		mnl_attr_put_u64(nlh, type, data);
> +}
> +
> +static inline void
> +mnl_attr_put_sint(struct nlmsghdr *nlh, __u16 type, __s64 data)
> +{
> +	if ((__s32)data == (__s64)data)
> +		mnl_attr_put_u32(nlh, type, data);
> +	else
> +		mnl_attr_put_u64(nlh, type, data);
>  }
>  #endif
> -#endif

