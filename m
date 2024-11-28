Return-Path: <netdev+bounces-147769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8669DBAF7
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 17:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA74B20EFB
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8E91BD9DB;
	Thu, 28 Nov 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URehtVuM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8272829406
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809677; cv=none; b=Mk0YHwlBeh8JnbzrIMkfaMThYkLBc2gYloHweuWQlP2vytoz37oVYIIzWE+DeOkZvbK1tSy7GQsZHwvX9n/WWkdTtsSNeNvxu8FgWZbQ8ekdEgFt2Ih8E6J66Nj1Zk7nuoBdwjOXqLFxDNeP2NOseeYKAZ7JgjaVkQmMy9G6qJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809677; c=relaxed/simple;
	bh=xNwLFOiaktqkdOudFbfy/3IrYA5qb4kuNOGwYSAq204=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vs9EAOoPX0/5W9+QMEdvbtl6p29e9nimR41doaJVbo5slth3Zfs4aUVUT0skQutjCWgh7UIShIMrCqT+W00aTRcJlt6YAQhKarSu+W9SC3FUUhFcsWBNP9E2yUVmKa4Aqt1Qc4lQYkp5RouqoKaCCfyNOiUCh4e4wE/l1Mrcu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=URehtVuM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732809674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/snLliwdrOrvrRkcmLpKV0p5kB2MTqjZDsVsrRSzH5c=;
	b=URehtVuMPovy6BXejdyKgxIwMTWepDNP7XsYxFlX7hQDPGFGEIQLMx2Czoe6ilJo+43HJU
	UvdPdtieXN7SZieFmYtDoDJ3e/EtG2W7U6XDbu4+EJLfoQYWRthoOgTr694qDiGcUV8c3C
	WTjrbxB3H2cZpK7nx0UlGQDiwXqGBYc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-cqdAx4M8NdGgAKRNvo85nA-1; Thu, 28 Nov 2024 11:01:13 -0500
X-MC-Unique: cqdAx4M8NdGgAKRNvo85nA-1
X-Mimecast-MFC-AGG-ID: cqdAx4M8NdGgAKRNvo85nA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d123aa38so281092f8f.2
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 08:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732809672; x=1733414472;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/snLliwdrOrvrRkcmLpKV0p5kB2MTqjZDsVsrRSzH5c=;
        b=d+Ic1g4gKYWNgRO88lUu74CUkeZulDyUhfHxlPalYaYZRIzKmEtI7BAnSILe67Wvqp
         7PEDN0vzl676WfLMN2lwumnvmIK4yVFGazP1iStUg8XN/WI1VDYZljWwApG/lBexRlCF
         cSJv1qlVzD3QSqMQuapsx57AVMjg6RFq9Ttl5GNa7OGw4uz9d1sOH8oj8aXKVFYWy7kE
         bQmBhff5mH/eNW9QfDEPCM3tZrdsVZgmY9L+VJtvff2SCO/SWkLm9O2jCpso08osmWBQ
         EnVlgdyIvojZ58vO8Jcs5WcS3CDTEBKyzMKQm44+1b/L7PFDGFa6TvgtW1KLSk0QGlYy
         NYWA==
X-Forwarded-Encrypted: i=1; AJvYcCUO+Zi/puyI6akUO3Z9fINtVGBawg9OsZ0IBGV42eWy1yDJFrbtVM6MCyKW8YgBsGPlJ41okSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7mE0wabzFNR1J5Az7FSzrKKFtiIqGPIYah5OX7mtOd5G4SfNu
	cTWb9381T2rIVcT2kdFlJcv1BbM65PzVpRVWwSKnwZih25RY6zy7fAvURbaIn70QrPIawOUQ0BG
	Snlx0VOhIXEnmdOHzbQnhAWA60tyhHzOQ71isytMiw0G13WKWSXmfZg==
X-Gm-Gg: ASbGncuMNqU2T6ofAgbC98QAhPWgk8jhZoha1B6eIMnwwY366ZSdtmQZ35jCC7RTKNK
	zY57x6SVp0Ij3cJlP4ruTEFOrLRq30X/+qwFY8wQMdYrSOYDlVrOVyRdczZPWuUSgBSq/Lqae0D
	dNc2GMgeYPJR9Wbn/ojH+cxfl4FPS/GKVyW1hR3bgjC9YTsXxDDFCdFbGH4nE+WhQz+DcjX2RaG
	GbeZrv6saGnweTBaciGXNAElZ4McBSIWDCVxKo504ayHto6/hYVANYLj2VnVAbufnHzxNTGd4Yw
X-Received: by 2002:a05:6000:188c:b0:381:b68f:d14b with SMTP id ffacd0b85a97d-385c6edb164mr6773110f8f.45.1732809670519;
        Thu, 28 Nov 2024 08:01:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDMfgarNqWf7Ko8HtUjuOqir5qCf1R9Ml7TTy0ZO/N8evzPXPbgUXgXwPzPKKwhAmOvvl6mA==
X-Received: by 2002:a05:6000:188c:b0:381:b68f:d14b with SMTP id ffacd0b85a97d-385c6edb164mr6772842f8f.45.1732809668345;
        Thu, 28 Nov 2024 08:01:08 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36855sm1963119f8f.36.2024.11.28.08.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 08:01:07 -0800 (PST)
Message-ID: <29c9e4c9-9d94-41ee-96a3-990e65b2b47d@redhat.com>
Date: Thu, 28 Nov 2024 17:01:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.13-rc1
From: Paolo Abeni <pabeni@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128142738.132961-1-pabeni@redhat.com>
 <Z0iC2DuUf9boiq_L@sashalap> <a4213a79-dd00-4d29-9215-97eb69f75f39@redhat.com>
Content-Language: en-US
In-Reply-To: <a4213a79-dd00-4d29-9215-97eb69f75f39@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 16:46, Paolo Abeni wrote:
> On 11/28/24 15:48, Sasha Levin wrote:
>> On Thu, Nov 28, 2024 at 03:27:38PM +0100, Paolo Abeni wrote:
>>>      ipmr: add debug check for mr table cleanup
>>
>> When merging this PR into linus-next, I've noticed it introduced build
>> errors:
>>
>> /builds/linux/net/ipv4/ipmr.c:320:13: error: function 'ipmr_can_free_table' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
>>    320 | static bool ipmr_can_free_table(struct net *net)
>>        |             ^~~~~~~~~~~~~~~~~~~
>> 1 error generated.
>>
>> The commit in question isn't in linux-next and seems to be broken.
> 
> My fault, I'm sorry.
> 
> I can't reproduce the issue here. 

I see it now. It's clang with CONFIG_DEBUG_NET=n. Apparently clang is
too smart with BUILD_BUG_ON_INVALID().

A trivial fix would be:
---
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 383ea8b91cc7..c5b8ec5c0a8c 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -437,7 +437,7 @@ static void ipmr_free_table(struct mr_table *mrt)
 {
 	struct net *net = read_pnet(&mrt->net);

-	DEBUG_NET_WARN_ON_ONCE(!ipmr_can_free_table(net));
+	WARN_ON_ONCE(!ipmr_can_free_table(net));

 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 4147890fe98f..7f1902ac3586 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -416,7 +416,7 @@ static void ip6mr_free_table(struct mr_table *mrt)
 {
 	struct net *net = read_pnet(&mrt->net);

-	DEBUG_NET_WARN_ON_ONCE(!ip6mr_can_free_table(net));
+	WARN_ON_ONCE(!ip6mr_can_free_table(net));

 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |


