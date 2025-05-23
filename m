Return-Path: <netdev+bounces-193057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBABAC240C
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A5B544689
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F187293443;
	Fri, 23 May 2025 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXWwc1Or"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DE292927
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007091; cv=none; b=FK47JzcMj/iK6pqR2iHKVcUkPVHNSVdTgFyVUnkGUZ1cTx2Ro3S3z2OKxbZjuI4lJ4oLusNEaXiJ0a6mqx/HTd+tWXsMAtqSLccswxv26PQHgHXxOcvxTqTNexfOlcfS3rNQwe8F+GBiX/sYCt0SqsBHqkZtbcWp+EyCp3DxFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007091; c=relaxed/simple;
	bh=U9D1pby8xK+C6gOYWJJ4wogm9CeACMWsTXzSqquT3uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnb4GMmIjPnRMtGZTWN25r3G2jwV4l+zyY6RXKzeY3uSLxTt9+bNM7XTInvl2/PhXVc/sVchodn1stHZl5zXzIHSubY75IW+vagKt0TPeVSEPwFih4U8NdiYDSqM0y81LKsQH1ix1A+w6BkE487kucNCVenpo8fNiBLIt2Yav+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXWwc1Or; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748007087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7IQJzIY0RbKcl762mcRQGpgwa1SyI4pkk5Ubsv8VBM=;
	b=AXWwc1OrI0E/ZxTzKpEKPwP2HyNUcQgw3vN0wxOx+TyNbGV1+E5KJpGONFDhCfu24mwQFu
	pLjm5nvSkTWb6QhrBS84DJr6XJ5mwvQOz3IlZBpmICd7W4DtRTBquStvv3rybfM0X5IlC5
	iTSmHiOcrskPcqoUGER4NuZSCd96of4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-XBCTXvWUNmymsf63Zv7ROg-1; Fri, 23 May 2025 09:31:26 -0400
X-MC-Unique: XBCTXvWUNmymsf63Zv7ROg-1
X-Mimecast-MFC-AGG-ID: XBCTXvWUNmymsf63Zv7ROg_1748007085
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a375938404so3752570f8f.0
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 06:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007085; x=1748611885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7IQJzIY0RbKcl762mcRQGpgwa1SyI4pkk5Ubsv8VBM=;
        b=dfM+IE5ttYn7z+s6Fs6ZVBA8STxWYRCMFCRPb/7CkFFHsC/UjzRXglWYHDbsu5DURJ
         8iy+3XAO8j3vSckDcRCUs5+ioq70bavMM/qwsgoxxcYSrAVAkZJ4OwYkSnnpePeR+ek3
         RzUR768gIXntXulMfPEcAkl04wQHT4f3UAlxezS4jaj/h6rZBv7evasAhalqjQnBT4Al
         +D1Yfo1azwOuZMSurUy5bVLQK/BweDIy00yvj+bDvhkISfzPDEV6FJUgrxl3H+Yyo6P6
         V+wbQ8xnVn29kv8O1NNr8ihnsCZgRpUYkaXypkepqTggoOUHZXf8s6+ybS0nB7k0yyf5
         hIKw==
X-Gm-Message-State: AOJu0YxgK3AhEyvOoOBvoaL6aRNmuu28Gs8xpBXy5PZgkHIKpc0kSk65
	Rlqt6ltEKLi/qMUXReYaWqOk7NHfGpcZ5a3uHQg3V5wzd2TEL4cDnxNW/bBRnsUKjqX9E5VAsS6
	/WPCW1selD6hFg5Bn5QTpko6TIekAV1JyupuEsSkplQo8SzHThB3VjEOAlA==
X-Gm-Gg: ASbGnctmw0px7GwRfFGaTmIRinXSumU2S1j7z45j2ibI1FFXIDtmhDIubLcKbPxs72q
	ch74gMfcx5EejUMWpvffcHgsaCTwtXZf0BN3bVE0w7Sd6yvak2TTvwqW+4JuJSUSU4c1tyubRUH
	zVS5yFJD7rA+kwqslcVYJ4WVCnCfa0Ep3J4Bhg20n4PiLk9KfJGBLjbvcmW63iiod6/04s/WTyI
	MjFK7O5l52VBGVs7u5xA8SFznNMxaQejtbTRozdlu5EOfDpLrhxWUJiAjImEq++Z2JuHo4w7VJS
	m/clnB4/6NEeZshQiUo=
X-Received: by 2002:a05:6000:178c:b0:39c:30cd:352c with SMTP id ffacd0b85a97d-3a35fe5c5c4mr24055830f8f.8.1748007084922;
        Fri, 23 May 2025 06:31:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhrdMB+LiVIpu3Aj+Mc9yuQMuVgyy9qtyFckGeXteyhBS+WYAjEdff975Ix8KdVMFe7BPmTw==
X-Received: by 2002:a05:6000:178c:b0:39c:30cd:352c with SMTP id ffacd0b85a97d-3a35fe5c5c4mr24055780f8f.8.1748007084275;
        Fri, 23 May 2025 06:31:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f3dd99edsm139493015e9.36.2025.05.23.06.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 06:31:23 -0700 (PDT)
Message-ID: <af41c789-9e0d-4310-ae28-055beef73f10@redhat.com>
Date: Fri, 23 May 2025 15:31:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] page_pool: Fix use-after-free in
 page_pool_recycle_in_ring
To: Dong Chenchen <dongchenchen2@huawei.com>, hawk@kernel.org,
 ilias.apalodimas@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, almasrymina@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangchangzhong@huawei.com,
 syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com
References: <20250523064524.3035067-1-dongchenchen2@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250523064524.3035067-1-dongchenchen2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/23/25 8:45 AM, Dong Chenchen wrote:
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 7745ad924ae2..08f1b000ebc1 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -707,19 +707,16 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
>  
>  static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
>  {
> +	bool in_softirq;
>  	int ret;
>  	/* BH protection not needed if current is softirq */
> -	if (in_softirq())
> -		ret = ptr_ring_produce(&pool->ring, (__force void *)netmem);
> -	else
> -		ret = ptr_ring_produce_bh(&pool->ring, (__force void *)netmem);
> -
> -	if (!ret) {
> +	in_softirq = page_pool_producer_lock(pool);
> +	ret = !__ptr_ring_produce(&pool->ring, (__force void *)netmem);
> +	if (ret)
>  		recycle_stat_inc(pool, ring);
> -		return true;
> -	}

Does not build in our CI:

net/core/page_pool.c: In function ‘page_pool_recycle_in_ring’:
net/core/page_pool.c:750:45: error: suggest braces around empty body in
an ‘if’ statement [-Werror=empty-body]
  750 |                 recycle_stat_inc(pool, ring);
      |                                             ^

/P


