Return-Path: <netdev+bounces-83128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14064890ED9
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 01:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3EC1F23A76
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 00:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AA518E;
	Fri, 29 Mar 2024 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEF2NdTI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032541FA3
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711670786; cv=none; b=rmzhC5110UfpKtnjJ7m2hQPg0zsYGQNKUE+hF6wlrAJd/Y/vSoKAxKYhmibLTCblnLC/61i6pUVOMPDbTN3Yyul1UqAcemB82FYpBWEoteYnsnVXgjRfcyJq6FtveyVbB7gAnmi1roKfV26/WK8b7EwC2WTVgxlewUJa7fGjVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711670786; c=relaxed/simple;
	bh=ClE3qOreK042iesHi7S+MXYd37c2sBr/poszq9VUVhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFStg2VrTWnrA6BnrgSfPbBv0JzKnfBA25On7EN9QWuuoKL3YcsdbAQks6J4Diak/JbXcjr7sMOPudKqbS4CVQNqRvh0WFI41TqbmTa9XSwaD3clobn5mGzMKh8OTHwlP6GJ7d311Chg+JrtKyGnsHvvG5L50ZZkav0W0O7cxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEF2NdTI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711670784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHY9uei06JjqVWX+k0rhW6PoeFL+iq7Oo89Epwh8fro=;
	b=HEF2NdTI7DRkAPp21Mwjitq88f880/x9oFW7aITCOyURyed2OaQ/jOzJHErGl6u7C4w8NA
	dS6TcfB5TOH3IuTgaI73Ei1ve06GsCFfYNwrmBwdMAwARnQnPbO42LaEC7g9uRfFz1v7jN
	zOw5X/czeDntfGYlJYmADLQHpSeb6Xk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-IgGYMQizOP6Qv7DbUfHnEw-1; Thu, 28 Mar 2024 20:06:21 -0400
X-MC-Unique: IgGYMQizOP6Qv7DbUfHnEw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e6b15967daso1464118b3a.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711670781; x=1712275581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHY9uei06JjqVWX+k0rhW6PoeFL+iq7Oo89Epwh8fro=;
        b=wD/El/gkgB2ojKjxex1bM+h0A2GkFbGjorB2+aYSRt6xYpNSWddsh+bewHIJ0s1Puw
         eXnXm1WID56m2D6NTr0/eEn8c3hs55KiesuoYAFBu572i3w5RkICW3+S0eP9xx1RL2y7
         KMp1Y5Pqg+BlElil++OBNhiGoCVCtUgX1/czDHRoVTHp2Gf/O4aNJ9BW09sa2mtufm+H
         Smwc9JM2N1+rhVRXAhMxiZJE9FqsZj8cTS+KqtXgv+LRJMlpLREE8Y0JQUyOwdqUsNYa
         LHYe7zS3+6cx7PwByYObLJzRe22OvbZ6QfXnOZIltujozPSQcV8HIROPPq+ixjDJUnbD
         TaFg==
X-Forwarded-Encrypted: i=1; AJvYcCXePjYnW/1TdvqaiQ8NsrmbCXo2YJiS8yfhj0zn63OtrLEJXu6X9W5CTcy80kIwO4mHgH54Lc4Ev5KJynk9UjbUtFFq6ffE
X-Gm-Message-State: AOJu0Yx3HeAoxYESZ1lh2x6JFlg7bPxNV4URcQlP2hbJ47JkbQc1yYDP
	Jv88o/YuDknhKpIYff74JM9W7njsSmQtMdnT+AmOCJ5XmRxqqWiEuSUEaE8rbcDjcMp0etWoeW+
	jGGo4xgdwrhCt3NSODfYN2C+gfINwkaAA4OYCl2DsvyKSKYNenG5O2Q==
X-Received: by 2002:a05:6a00:1d91:b0:6ea:7b62:8e6a with SMTP id z17-20020a056a001d9100b006ea7b628e6amr890209pfw.3.1711670780679;
        Thu, 28 Mar 2024 17:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG28zfJ9JzCjVEKSbcw6s9d1QtV/vjfv4wjAj8ag9KiEynxNesL1GOjadgj+xrHyH8SWoSU3A==
X-Received: by 2002:a05:6a00:1d91:b0:6ea:7b62:8e6a with SMTP id z17-20020a056a001d9100b006ea7b628e6amr890185pfw.3.1711670780355;
        Thu, 28 Mar 2024 17:06:20 -0700 (PDT)
Received: from [10.72.112.41] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j23-20020aa78d17000000b006e681769ee0sm2020583pfe.145.2024.03.28.17.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 17:06:20 -0700 (PDT)
Message-ID: <a305940d-723a-4f7e-a54e-cbd84ef8354a@redhat.com>
Date: Fri, 29 Mar 2024 08:06:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] libceph: avoid clang out-of-range warning
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 Ilya Dryomov <idryomov@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Milind Changire <mchangir@redhat.com>, Patrick Donnelly
 <pdonnell@redhat.com>, Christian Brauner <brauner@kernel.org>,
 ceph-devel@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
References: <20240328143051.1069575-1-arnd@kernel.org>
 <20240328143051.1069575-3-arnd@kernel.org>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240328143051.1069575-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/28/24 22:30, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang-14 points out that on 64-bit architectures, a u32
> is never larger than constant based on SIZE_MAX:
>
> net/ceph/osdmap.c:1425:10: error: result of comparison of constant 4611686018427387891 with expression of type 'u32' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>          if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
>              ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/ceph/osdmap.c:1608:10: error: result of comparison of constant 2305843009213693945 with expression of type 'u32' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>          if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
>              ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The code is correct anyway, so just shut up that warning.
>
> Fixes: 6f428df47dae ("libceph: pg_upmap[_items] infrastructure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   fs/ceph/snap.c    | 2 +-
>   net/ceph/osdmap.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index c65f2b202b2b..521507ea8260 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -374,7 +374,7 @@ static int build_snap_context(struct ceph_mds_client *mdsc,
>   
>   	/* alloc new snap context */
>   	err = -ENOMEM;
> -	if (num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
> +	if ((size_t)num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
>   		goto fail;
>   	snapc = ceph_create_snap_context(num, GFP_NOFS);
>   	if (!snapc)
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 295098873861..8e7cb2fde6f1 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1438,7 +1438,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
>   	ceph_decode_32_safe(p, end, len, e_inval);
>   	if (len == 0 && incremental)
>   		return NULL;	/* new_pg_temp: [] to remove */
> -	if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
> +	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
>   		return ERR_PTR(-EINVAL);
>   
>   	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
> @@ -1621,7 +1621,7 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
>   	u32 len, i;
>   
>   	ceph_decode_32_safe(p, end, len, e_inval);
> -	if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
> +	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
>   		return ERR_PTR(-EINVAL);
>   
>   	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);


Reviewed-by: Xiubo Li <xiubli@redhat.com>

Thanks

- Xiubo



