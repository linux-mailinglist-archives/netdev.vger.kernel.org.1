Return-Path: <netdev+bounces-231647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38FFBFBFBA
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB33018C3DE9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 12:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702DF347BCD;
	Wed, 22 Oct 2025 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="lAVCRzdS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E895C347BA9
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137517; cv=none; b=mGhxLgpApTKiVYgxMybkkgz0tjzpsb5HJVZUiyeo8H+R+eQc7tA0SnFikgqVGi8FQcOuHMwuMRKyKinTL/7IuhxnAJYGO/jG7PHwJk8qGkel7ccnpuw43a8J45awcyl6xDc5DF8OxUfK3CRcfPi3jgHiwzYKiWam94zPVZZ9ONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137517; c=relaxed/simple;
	bh=mzrVBGSngClRb9VIP/ej4j6oFQp5mVzc748Ppxzbeys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSmqLOp/4fgTyCmyy1jOaCw//IOoKt3ruqAsD+FIiho1rqv6CHBFGvEP0j4ZJ6mDEwfWJ3e+qxPbG61GWT0YMzb5Rj38if9eo4ta2+5WcVjY2m1HMZBttYSaaknXP0EuH5uGJ4zj/Dzv+Z2mFjm/P0ZN7zrbvzKexDOqykHWRKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=lAVCRzdS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso1742360a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761137508; x=1761742308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6rGYgkFqZMyeKkM9CWxrN6/zkNVAr0RwTWj6Y0/e+E=;
        b=lAVCRzdSQbjclst11IUwOwVzzDCxhou24aWRDQGxAAyrY8b9bR0LT5THj97ZdmAWj1
         gpQSbqOCmd9MHOaOt+A3QymqmE4xewg7NAqR9GFsMqZmFQbZnMMNLTbqIZeumtBwX2Aa
         skA4LqUNh+H1yoZtu7MZ6dwUT5EZLuiLfTXRxn9Nx43CyulvySYZxTmPhCApAZ/QH6Ju
         0AWOucMCZTxu1646zuIDjs8v9b11br/X7GcfFTYiyvSV66o4eDE/EcwPQNOMW4FK+pJJ
         hmGvrlOQxxwIOZV+wrn5VzDfLHHHTGBD8Tz0xmCiruVmOfhssPSfCQg8hiCn4qRehc/f
         6yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137508; x=1761742308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6rGYgkFqZMyeKkM9CWxrN6/zkNVAr0RwTWj6Y0/e+E=;
        b=xSx2pZGaBy0eQPzEVNmO2B3u4HZ+8mdkBzle9gcdh9WCA6xNz+U/hO0Xg1/1ilcBlj
         6SrJXSt4oBwVtXcuPwxxxXtm70/G6hxJm1Ruuor70aqqt8ToJpC2LfUBYzhsAhm3sNUG
         2XIGOlf0Fp2ayfjPp12ulf4dbjD9n4wCXlTl9LebIcjBOXajfEOz7E08GZyV80a6i4+D
         Um4umU0UT5jt9IY2xhf4tzll8ePAs8NoZU5XEXaf7ZPRphLx7DM6SHtp+2MjSrPnCCEh
         Q2fJXJVfKWCrpwquyIg+AdwOdLiFqGtdlsck8yVYoXV2cQ2Dch8JezA1Lft7J0U8Su+H
         1wuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHPmeLVFvOGY3XU8cs4VapwXC6k5egfA4rW6UfgL+7okHRcXkmSmblamYAqW7C8NoGzEJhZ9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfVEsBk7btol2MI2t8eFnv8NQpeu2nT89NaM3OYaOHZo5r21XL
	22LIimDUuY/rPCdmWh759QHBkXaw1Kh03zL0wZqAbsUxV1JqjUC843YDGTYzpSCpVtc=
X-Gm-Gg: ASbGncvr3Xlb1vyJ/jF6URE2+IZv7/7DDqUyE+/tfIZOhqyWoR6etOHLUZ58B5Qvv9o
	gY0jkp3fSyhLdW8QvUgBr+uWp7Bo7FQwxP+C/EptxL7PPbd2zW2FsBPj6N/4/NXrDFXnCan/o+j
	1BmRLxXAzfIsv+GQhafUOMaeucdmOG0rHScHaWCM8Pg6GBpXMOJqR5ajBqjrTkoBFp6hYY8LZjv
	1LdZKHWRi8rtijdg4xkMMW3NLeFLPwRxxOm/XpGA2bkuH61Qx7d9YIbaUTAZWR/hJQ3l03CEND+
	k1TJ5kJSdqY9R2LJ0m66Mp1ZvNy/89u+C+O+tvBCAIZ/NuhGSPuWfeGtQNKL+Jd/DdcPMCtoX3H
	5KGm7UlwbKAiv8hdw/MDqHzbBA8Hojk5QedzZOxtEnqwlLWoHYkrR1W8R2z6n2yyI5BKXMUMe0F
	PC2KzMr/RQODnxze73g5AlyPklVEWOI1w9
X-Google-Smtp-Source: AGHT+IGEvaj2arhMJNqpkIacGCGSpwCCmyDSBkx64VqNMr6Y6jMdC3l4n7s/h6EMTkg7OkTdvHLrtQ==
X-Received: by 2002:a05:6402:460d:20b0:63c:12dc:59e3 with SMTP id 4fb4d7f45d1cf-63e173d315cmr2980332a12.19.1761137508048;
        Wed, 22 Oct 2025 05:51:48 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48a93998sm11636602a12.4.2025.10.22.05.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 05:51:47 -0700 (PDT)
Message-ID: <eafd519b-1bb7-4d59-bf2d-8bc0dba59129@blackwall.org>
Date: Wed, 22 Oct 2025 15:51:46 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 06/15] xsk: Move NETDEV_XDP_ACT_ZC into
 generic header
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-7-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-7-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> Move NETDEV_XDP_ACT_ZC into xdp_sock_drv.h header such that external code
> can reuse it, and rename it into more generic NETDEV_XDP_ACT_XSK.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  include/net/xdp_sock_drv.h | 4 ++++
>  net/xdp/xsk_buff_pool.c    | 6 +-----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 4f2d3268a676..242e34f771cc 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -12,6 +12,10 @@
>  #define XDP_UMEM_MIN_CHUNK_SHIFT 11
>  #define XDP_UMEM_MIN_CHUNK_SIZE (1 << XDP_UMEM_MIN_CHUNK_SHIFT)
>  
> +#define NETDEV_XDP_ACT_XSK	(NETDEV_XDP_ACT_BASIC |		\
> +				 NETDEV_XDP_ACT_REDIRECT |	\
> +				 NETDEV_XDP_ACT_XSK_ZEROCOPY)
> +
>  struct xsk_cb_desc {
>  	void *src;
>  	u8 off;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index aa9788f20d0d..26165baf99f4 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -158,10 +158,6 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
>  	}
>  }
>  
> -#define NETDEV_XDP_ACT_ZC	(NETDEV_XDP_ACT_BASIC |		\
> -				 NETDEV_XDP_ACT_REDIRECT |	\
> -				 NETDEV_XDP_ACT_XSK_ZEROCOPY)
> -
>  int xp_assign_dev(struct xsk_buff_pool *pool,
>  		  struct net_device *netdev, u16 queue_id, u16 flags)
>  {
> @@ -203,7 +199,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		/* For copy-mode, we are done. */
>  		return 0;
>  
> -	if ((netdev->xdp_features & NETDEV_XDP_ACT_ZC) != NETDEV_XDP_ACT_ZC) {
> +	if ((netdev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK) {
>  		err = -EOPNOTSUPP;
>  		goto err_unreg_pool;
>  	}

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


