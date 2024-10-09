Return-Path: <netdev+bounces-133812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBFB9971CA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD33281A6D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BAC1E47A8;
	Wed,  9 Oct 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YT9Iakmh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155A1311AC
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491565; cv=none; b=kOJubW8jdD+piPm4b7z2jp1NwzkGv8TvYzf1VoDZB0Oz3ejeqwpiHKPvfevAJ622UVReAvO2VRZhU4hr+Bxu+aaTKreEzaUiMCHu0esBdYtbNut0ZiBJEVDeHRW4JDbNykW68YTtGxMB9/S+FP8cBuF+35LDb2MrPPJ6aUcF1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491565; c=relaxed/simple;
	bh=qaQixhuwLIikdSFP8Lc/q7fT/ooLAsq7WT3k3IkixUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhsqpMDqg8PUPzQ0kQbaONI6GO3jfvypbfXFKMd8beeixrIEjuYbt87Ex9TOCCkPwtk2aURu41upClWB8e55bwmAfrRYAKY7nKkVr9LCdEWmm/JktC1It0f4Jz7woME6MzIpjqtb58KH+rHPP1zEmDWR1itB08v+iE+XocnGqIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YT9Iakmh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728491562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsmJarmkb+eUvOZfdr4ZWVZI9jzrARuYBuLJ/6l/+6Q=;
	b=YT9Iakmh/qBTN0PhpxboPCxUZ49tctq9is++ZFRtfkAzIwF3KWZfU+czBlWzGp7Dxb949T
	va/4m8IrvA5bZEYYzQjopi7sUF9PFjKb85Ap925y3B/8Gqcc+LcUABLMCqKKoBk0VgMZhD
	3BBGahuk93dIKuQIMMWS9ny9r7qz27w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-MnmlaVMPOJyUA92Y-AdeZA-1; Wed, 09 Oct 2024 12:32:38 -0400
X-MC-Unique: MnmlaVMPOJyUA92Y-AdeZA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cae209243so45460565e9.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 09:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728491557; x=1729096357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsmJarmkb+eUvOZfdr4ZWVZI9jzrARuYBuLJ/6l/+6Q=;
        b=lMfDsWWoFI60m2uCy2IFiTeyahWop5sHEXcVdS4xVPV12pc0RwEEZeO4xzvATAdOwL
         mfqQsY8xjvwSl2TH9xVN8PdSSqK8b8nOdzR53OEy3eLq9tUds42OKezGzX3Bv90Up/mt
         VR6OjFwfumozn9EpL+aDeowAZuaRlP8m9xPdyXUlhbAJtfDIxHpUwgd8m0NhUqMxxzSG
         F5HSO7PNXnm1AuFM2BE+QgBWyVQoH+ldCN4DlpXzGuA8NVjzqncIt9fxA3YZ1oP7eNpN
         /X1f0+FjfFawPLe9QdEhRam2asJyYvYlAptCr50yMBL/bqpPvlRTMVnF3aqH/czwRpyS
         WAWA==
X-Forwarded-Encrypted: i=1; AJvYcCVTmQ0J5fHKw19ZMk85SkBX0Ju2VZVRyVQn1hbV5zD+xOIgvOUBDPpfGJrRuGVlNq6OlALIwlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXDQKxaJSVtksK3qhJ1KdQqECt+Qg7IYDgqbJdrknuu3xMaK4j
	rE51CBHy8vwTtwwDZiw8vsMrqDqucSi+82ZHGU8VPnFVwKY2ZPiB+4ID309+PpIGo289sTImvmJ
	ZTPH2IKvypbroxpK2705uPgKmjNb2/AdGuyizGs8T9+wWDEdaxnxKFQ==
X-Received: by 2002:a05:600c:3543:b0:430:5819:7585 with SMTP id 5b1f17b1804b1-430ccf50fc6mr20583155e9.18.1728491557496;
        Wed, 09 Oct 2024 09:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgAtVz7a0GcP4x49OMbkuuqnX4Wns7sjAolEw0Y21+aNP2bd+EmH8lJYgCuWlis1C2+PUPjA==
X-Received: by 2002:a05:600c:3543:b0:430:5819:7585 with SMTP id 5b1f17b1804b1-430ccf50fc6mr20582965e9.18.1728491557040;
        Wed, 09 Oct 2024 09:32:37 -0700 (PDT)
Received: from [192.168.88.248] (146-241-42-55.dyn.eolo.it. [146.241.42.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d7487c4csm24983965e9.32.2024.10.09.09.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 09:32:36 -0700 (PDT)
Message-ID: <be4be68a-caff-4657-9a49-67b3eaefe478@redhat.com>
Date: Wed, 9 Oct 2024 18:32:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 14/14] mm: page_frag: add an entry in
 MAINTAINERS for page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-15-linyunsheng@huawei.com>
 <20241008174350.7b0d3184@kernel.org>
 <a3f94649-9880-4dc0-a8ab-d43fab7c9350@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a3f94649-9880-4dc0-a8ab-d43fab7c9350@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/9/24 06:01, Yunsheng Lin wrote:
> On 2024/10/9 8:43, Jakub Kicinski wrote:
>> On Tue, 8 Oct 2024 19:20:48 +0800 Yunsheng Lin wrote:
>>> +M:	Yunsheng Lin <linyunsheng@huawei.com>
>>
>> The bar for maintaining core code is very high, if you'd
>> like to be a maintainer please start small.
> 
> I did start small with the page_pool case, as mentioned in
> [1] of a similar comment, and the page_frag is a small
> subsystem/library as mentioned in commit log.
> 
> I think I still might need a second opinion here.
> 
> 1. https://lore.kernel.org/linux-kernel/dea82ac3-65fc-c941-685f-9d4655aa4a52@huawei.com/

Please note that the 'small' part here does not refer strictly to code 
size. Any core networking code has the bar significantly higher than 
i.e. NIC drivers - even if the latter could count order of magnitude 
more LoC.
AFAICS there is an unwritten convention that people are called to 
maintain core code, as opposed to people appointing themself to maintain 
driver code.

Cheers,

Paolo


