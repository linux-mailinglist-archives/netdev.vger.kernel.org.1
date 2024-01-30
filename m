Return-Path: <netdev+bounces-67069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC3B841F84
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87404287C21
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0900E605AC;
	Tue, 30 Jan 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="LTC8vNC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0AB45BE7
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606957; cv=none; b=rePWLuP0z5ec03Vm0msdbngS9B5h+wKTeMmNPku139ZQ+TaCn1SIXLG87FMRzpxxA/U1hFjzaCsLRjjFRO5lsSj/eA8LEZHIE+muKIt6yBbtgh0Idw3A21iCpE45RlAko714sUjGMwmuzRUS3bQv9gnQfriBBk52uEn5Qi80g2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606957; c=relaxed/simple;
	bh=g7/Tw40iurYfKeZa/xZvbogA0Dz7AsysUvBEQywxNgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yw3sEOAE7Aa4SAWSfzV2rOeq2z3RNFaIMiAba9C504c9KOdn2Na0rrJpQXhHQyLhmzU3rjKa8UQT4rDLMEGVswpFHooLHFdReKHKsvrxpQkCWD0fV0MVYqikX81HEb53xp/mFWLByD4rpza/qE7kOzll8GmbOfG9S/U78XGOnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=LTC8vNC5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5110c166d70so3504603e87.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1706606953; x=1707211753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvgkqrVhgwAp9eomtc6oUrzhXKUHKI4dKXoGY8fDTwo=;
        b=LTC8vNC55UBhWEq0pXzMViaOEpxTBpx8oevdKBkPJ7Qu8z/+2W8LRUwCLydB8VDgwK
         bjI0VtiE5T2L/gJIeXW7k568DO5qvCfX9BDFs5EU23bqX8XqnoASkGRPxmEILQioai98
         vK+Vl2oAfeo7mArQm3Y9/hXsr+s4R64INoOb25dv46J36C54TRSs2hqfyyjmo5kzl5ZK
         i3wJOshkeYy1sunnO78ZPQhPq2KBhDrdBG1QhasqcvXY4zfDn8ylQ4Rqku3z75vTUjid
         W/KdktUGfXR+3hyLm6pbe9tjg+2FlwD7fbbrzvoqVynVm9u2ityoCeVjrvbp7VUHVb6H
         iokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606953; x=1707211753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvgkqrVhgwAp9eomtc6oUrzhXKUHKI4dKXoGY8fDTwo=;
        b=CQ26/g965NLwJ6OsrR0Q4Iahpxu2JfDL1oqRibqTzC1u5ENZ4og85vfdt11KnJZlGL
         T16EmbXhyD6jN00ScKeDrYP6WK0Rp9YTy9Q3gYjwNJxxp0pI7g/GiOrUpjFiegQ3/O9p
         0Z6dWcz+PhNa3QhxS51VviKHObs9idnXm/MutVmjDBKoyf0V/5EdcAjA9QAnICnf1m2q
         tOO2093Ivd+RfH9SoGa9g9tLXRrb28JM/6Fs1mziRvFudQVOTdXVLKWq4hiMEQ2BG/j8
         a7CiJ+qEODYAsZvtLRid+C2ASIgEasRqwzCWlvwu7zPveb4VgtgdFphV048mwt1Bo0VV
         N/AQ==
X-Gm-Message-State: AOJu0Yxy/EwSUu2tVzo9Me6kfhYQp4nHO6eZUSrTMD2ogejIPOccGezU
	PcUpxTTMB8sE8CDT5KS18ZsE69PkPbZFX3BYUG6Dumzm0DnOLsSXR79mC/i3jbA=
X-Google-Smtp-Source: AGHT+IFKOierXNs5R8QtY/OftsfX1IkVkKVPMFcsF71RjOLl9Nbv1Fck3f+sLCr3SUy88diadJDN8Q==
X-Received: by 2002:a05:6512:34d2:b0:50e:af9d:9b1 with SMTP id w18-20020a05651234d200b0050eaf9d09b1mr4522166lfr.14.1706606952959;
        Tue, 30 Jan 2024 01:29:12 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b0040e4733aecbsm12370438wmq.15.2024.01.30.01.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 01:29:12 -0800 (PST)
Message-ID: <4c073b12-c1b7-44fd-8f46-d901a4cd403c@blackwall.org>
Date: Tue, 30 Jan 2024 11:29:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: Use KMEM_CACHE instead of
 kmem_cache_create
Content-Language: en-US
To: Kunwu Chan <chentao@kylinos.cn>, roopa@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130092536.73623-1-chentao@kylinos.cn>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240130092536.73623-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 11:25, Kunwu Chan wrote:
> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> introduces a new macro.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  net/bridge/br_fdb.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index c622de5eccd0..c77591e63841 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -35,10 +35,7 @@ static struct kmem_cache *br_fdb_cache __read_mostly;
>  
>  int __init br_fdb_init(void)
>  {
> -	br_fdb_cache = kmem_cache_create("bridge_fdb_cache",
> -					 sizeof(struct net_bridge_fdb_entry),
> -					 0,
> -					 SLAB_HWCACHE_ALIGN, NULL);
> +	br_fdb_cache = KMEM_CACHE(net_bridge_fdb_entry, SLAB_HWCACHE_ALIGN);
>  	if (!br_fdb_cache)
>  		return -ENOMEM;
>  

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


