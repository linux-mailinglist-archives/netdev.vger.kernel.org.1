Return-Path: <netdev+bounces-130289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC62989F17
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1FC1C219E1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D20F1741D1;
	Mon, 30 Sep 2024 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="pSN4td9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A160558BA
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690790; cv=none; b=QvFuUg12Cy6mAzle/1qWMStZgZQlxKs3ANUMI5Iy3Fokh3dB/KFBPKmu6QLXIEHxCQfNkmH+UZ/+k+FtmJmXvgqG+Rcq5HevtlvBK/g9F1NnPamgkBbDoausZRgfcwIsUgnzOf7gJ/iRXK3MgLCw+BDcGjNUnnNSwRVAxX8A5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690790; c=relaxed/simple;
	bh=wQenqqC5rFf6LNvtPngLZ2vPjI6ubNFAVrQv2EewOoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONaP6jcMLuOpILmtfAGCil7+Xox4klUAOfrH22nZSaIGNM5TePAu3zD/yrXUWp8EfNkUt5jCM8AWLtVQWkfs8ukC/8xq2vOeKSddH1I7+lHNZpzLnTg8kZdXl4rG26piQDTsHFIUzFMSwblJYmiH2CV8vBiuuGQRMuSbfomKDDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=pSN4td9s; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53994aadb66so714604e87.2
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 03:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1727690786; x=1728295586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LK/6hIFc6R+Q+3qL3TGrc7l6PDeV/3Luhg3R8QTWgLU=;
        b=pSN4td9ssM6Q1MIIDildV04767sILnaqvmMYR9XTbN7yjF+JsQgxbHMj2Ok6+97g2m
         AfmoPynIvUPDCS56DXkalEIJY4U8VxAEWvk9bIjvcTCMzRh3ZB6eDhppHTKR9PhB6hJm
         32J83GV6Xz+tWNGCBhzxjP8IgT2HO0PhwfG7xPpIXe1WcXjO/YWrVYFD9fug/83yn8SC
         VzKCuzWwQBbvG69C63/pEqeRdzrOslah4V9Z5nLCu208muYchnqo/p3CEBGgKd0lYRS6
         gXWV4yCadAh6fcwNDvY10ucwsXaZPYiA5okcfod8x46kBVjkib+66k1a1GY+f+AWLkQC
         T2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727690786; x=1728295586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LK/6hIFc6R+Q+3qL3TGrc7l6PDeV/3Luhg3R8QTWgLU=;
        b=MS8FD4zq1MI7cmMv1hWCPICL0K3TvbWnXoS+6zak5OhDmo+sDPUkm8f0jq4S6YmucO
         DkXWYxe+zTR8VkIRSzZnTf3G/QeWWg5rueGMDCDFj7lnR3iR5hXAiGrVbArsv45uRBHj
         yg7rankZUpisXiSmE6ZgRq68ReozRDVA00xx4LneQANEdTgvkzaFB0UJl/yGho8rtEMC
         vtNg9guwlsNkr59/0gNG8B84CNF3kWRb4DIwyY6+Lp2qePEKXnh+01eLzi72REivhPU6
         M6u2ZaQ1LqvICUCK7rpZ6pjbCb8WQwcURvQGNbc5QsdtsTkFoaZ4nwxaN382+p0HTYkt
         uegA==
X-Forwarded-Encrypted: i=1; AJvYcCUcy/fhmmDEypkqhA+8KzRdAtKouD0GbTTTyU6FrQ8Ti0U0KAnVV2xDr5UPLKRtZpS3yzaXUvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCKi05jEZry+/74m5pTiG7784VVs1uFm0pd9Kg6Dvw9Stnm7oN
	OzSxm7JvyWeyKCS0WXF8PeWXuE/SIey8SCskk6GV/Cm9fZK84kT1B7ijsLALAwmx4PVD43TKNjb
	4
X-Google-Smtp-Source: AGHT+IGAHgFxCQCJq1B5VvaJKWcHBh8e9dNIeWpP4myTAS2i0+MebsS7UNOcWE2YO2bCvp4aR252VQ==
X-Received: by 2002:a05:6512:3c8f:b0:531:4c6d:b8ef with SMTP id 2adb3069b0e04-5389fc34548mr6133879e87.6.1727690785629;
        Mon, 30 Sep 2024 03:06:25 -0700 (PDT)
Received: from [192.168.1.18] (176.111.185.181.kyiv.nat.volia.net. [176.111.185.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a04399d3sm1189833e87.191.2024.09.30.03.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 03:06:24 -0700 (PDT)
Message-ID: <7ff94e87-1b9d-41e6-82a0-c13ff986adf5@blackwall.org>
Date: Mon, 30 Sep 2024 13:06:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: mcast: Fail MDB get request on empty entry
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, bridge@lists.linux.dev,
 jamie.bainbridge@gmail.com
References: <20240929123640.558525-1-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240929123640.558525-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/24 15:36, Ido Schimmel wrote:
> When user space deletes a port from an MDB entry, the port is removed
> synchronously. If this was the last port in the entry and the entry is
> not joined by the host itself, then the entry is scheduled for deletion
> via a timer.
> 
> The above means that it is possible for the MDB get netlink request to
> retrieve an empty entry which is scheduled for deletion. This is
> problematic as after deleting the last port in an entry, user space
> cannot rely on a non-zero return code from the MDB get request as an
> indication that the port was successfully removed.
> 
> Fix by returning an error when the entry's port list is empty and the
> entry is not joined by the host.
> 
> Fixes: 68b380a395a7 ("bridge: mcast: Add MDB get support")
> Reported-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> Closes: https://lore.kernel.org/netdev/c92569919307749f879b9482b0f3e125b7d9d2e3.1726480066.git.jamie.bainbridge@gmail.com/
> Tested-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index bc37e47ad829..1a52a0bca086 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -1674,7 +1674,7 @@ int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
>  	spin_lock_bh(&br->multicast_lock);
>  
>  	mp = br_mdb_ip_get(br, &group);
> -	if (!mp) {
> +	if (!mp || (!mp->ports && !mp->host_joined)) {
>  		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
>  		err = -ENOENT;
>  		goto unlock;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


