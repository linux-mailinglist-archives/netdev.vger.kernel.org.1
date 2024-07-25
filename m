Return-Path: <netdev+bounces-112966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA31193C08E
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 13:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B03BB21394
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E9A1991CF;
	Thu, 25 Jul 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrEHCewf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B21991B4
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905598; cv=none; b=h/CZQsSu2+Bx7ibXykEUDKSfw+1YeHzXxyyBl4cH8YmLr2OFgYwoArQTrnLa0WPWbaeSo9EjUPLGhRxn6SWRgK8sKcbHkpdzjql4CuZejMTZIvoOWP7qUsDwdtfVqQbgStfQBZakNriQaf+LTVrSpzV9mUk/G7aWzRAPeRR5vws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905598; c=relaxed/simple;
	bh=Z+/cf+NofFzA35SddKTJMioN4/UdboRja1QQUFeoI2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZQfVIda7NVpsinvmHBTI28ZBythajHGxkRoA4LdQJ2paLYyIfMKcgsZXgLP41wCUFBSVctTduoQKkKs/podofnDr6hwikR09o9Gt16lmePLQg0Kb5Cu7YLzZOMiACq7kRdxJVprmYw9hE/eGYgeoFR6lZrEVBFv6l6/AQ9CHAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XrEHCewf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721905594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WN1T7ImyHgIlrYMLiebMiQokg+VGDY2/N/KmNsun8Ek=;
	b=XrEHCewfXMZt5pyDHYzLdjC+FBjjVBe/gRZwojK4SX2XE2XjdX11ynzsqCm4p5saKEgzd8
	nKn859LJv6JhQvvkgufxiKa7LKm7JhzxEKHUBhP/scs4DXMTA4lmpBHh+x1Ai2l+WEAsbE
	r5mef35Zc1OSbGtlQo+x+fu3pbNsIKc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-Vu9HUkqgNkq5hAxW9ASABQ-1; Thu, 25 Jul 2024 07:06:33 -0400
X-MC-Unique: Vu9HUkqgNkq5hAxW9ASABQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4267378f538so1458625e9.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 04:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721905592; x=1722510392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WN1T7ImyHgIlrYMLiebMiQokg+VGDY2/N/KmNsun8Ek=;
        b=pw/4h1zBjfgVzmBKyyb+pYfMpoNodXMvFH+EOKPgE2LaV29fdYoUOyMxMe/K8CikeP
         NFfRQaa/eioGs0MSCa5JnzuMDhMK0NZj6ay89VgcYQjM+HOMDBS135UzXzesTukMjWoG
         GuCm+1kyjahqNP53EXNX5lGV5agQ9coUZjxRQApt2MLlzu2K3kCfEqQYyZ3K8NZdaxTp
         xXzHwYEmEYPrt+Apw0l2m5HHUdphbNYJ48xy4EhO+UooPXm79jmOw5ldIkaKpeE3S4XO
         B9V8obWYLTP4tYW6IFmnjht0S4KV7vi8h5gtlKZPl/ThCYFRvJNnNF0VkSAR8MoySKLi
         vPPg==
X-Forwarded-Encrypted: i=1; AJvYcCV/hz60wzrMQCqATKkHmlreitp06+YxAcvTQTjcOj8luvAazvTgosyRCPMf33L/wBFZwE5FTiKAZmVFtnZSy5Tt4mh0FWzP
X-Gm-Message-State: AOJu0Yz5tkB8Egmo18/wN2AHa8bnx2Z+WeS62J3lLbnkoTRHFq7UoBbP
	Iis2jpCwHl0WcCBqm4Yuvg6HPjtt9rq8uSMhFr7c3mMqvh3QWGETsHceWAgZrNQQ1SLGLicyZaz
	WV8ZwSxtiKEWgrnVCyYt08LpcUCPt018ji+iNUgDWc37vCWpCD3SEGg==
X-Received: by 2002:a05:600c:35ca:b0:427:9f71:16bb with SMTP id 5b1f17b1804b1-42805713a1emr8546025e9.6.1721905591986;
        Thu, 25 Jul 2024 04:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBatNBk5gs/dWyR7c2T51W0nIxSSE/Dn9TTMdkHW3H4iQrQEZARNdPQXiwOCI42zCxVqSW5A==
X-Received: by 2002:a05:600c:35ca:b0:427:9f71:16bb with SMTP id 5b1f17b1804b1-42805713a1emr8545885e9.6.1721905591458;
        Thu, 25 Jul 2024 04:06:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b231:be10::f71? ([2a0d:3341:b231:be10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574b21dsm29367305e9.27.2024.07.25.04.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 04:06:30 -0700 (PDT)
Message-ID: <b399e0bf-07fd-4da6-9ab4-19cd1ceaa456@redhat.com>
Date: Thu, 25 Jul 2024 13:06:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tcp: Expand goo.gl link
To: Simon Horman <horms@kernel.org>, linux@treblig.org
Cc: edumazet@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kennetkl@ifi.uio.no
References: <20240724172508.73466-1-linux@treblig.org>
 <20240724191215.GJ97837@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240724191215.GJ97837@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/24/24 21:12, Simon Horman wrote:
> On Wed, Jul 24, 2024 at 06:25:08PM +0100, linux@treblig.org wrote:
>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>
>> The goo.gl URL shortener is deprecated and is due to stop
>> expanding existing links in 2025.
>>
>> Expand the link in Kconfig.
>>
>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Both the motivation and updated link look correct to me.
> I also checked that there is no other usage of goo.gl in this file.
> 
> Not sure if this should be for net or net-next.

I also think this should go via net-next.

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after July 29th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


