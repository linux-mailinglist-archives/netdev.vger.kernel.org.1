Return-Path: <netdev+bounces-105019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B264F90F71E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6D32844B7
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF98158D8E;
	Wed, 19 Jun 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ2whtI5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60026156C6A;
	Wed, 19 Jun 2024 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718826159; cv=none; b=paBuw7yK5rdfurjd7EDcDfMTdLgpCEnGDqUXraJim625s/HIj5Ul8+jXIeUBl4DeyFKenIBSmjr+2cWgzh8M2CR22fM5wpgWVKdw2xXQQULT+cjWSKJW+N4kQ24LFnDRwjRkwTIBno35PuFyvDTuOsbaOVVj+YaCDOebC9kHmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718826159; c=relaxed/simple;
	bh=lQJgX2kqtpucEStoylm9bVUxglT3Ct/aEDAVENKWZwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEFFHvKvmY1ZDEZjz4cRfrdbJoqDTFP5Bgsql39g9P3uHLRWXIq+h166mUzWcKj7ABzt8AfCGCyz3XvKmpx1KUxJP1USdcj7/2tjFKGtH9Cb0uCiGBR9Cj8jzZFNbtXL8giW+4spNkg7KfxEdhwtrNxkGB2KSZ2V0UKEjhabSHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ2whtI5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4218008c613so1551715e9.2;
        Wed, 19 Jun 2024 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718826157; x=1719430957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/mbiCPrwheVnyKx6Tn1g8ggM05xq8FHv37NW2n7TXw=;
        b=mQ2whtI51oWtLJRn+bEoyoE8891+P91EIGuL4LezIYh3/0+v9AGVKa4g0hO6R535k+
         bCuWkWCPRdho1/DkerVj1PRtDoPYMvWBV2B//8ObceCZKGVPaxC52eWR/lGjjU1D8Jse
         CCQ1eGGBf2w+INaqxBj/Ur3CWoVfC5EGhq1mNJSyplEinq4QXWw83HaT7eGv2MpZu3F7
         uPglPy2/iG3mG0YXxuPDHhlP+fRE3ZOoK4Z6RC4ppY99e+UL0E35yq140H/DFtSlLu3f
         JdZQILagxapwQTLG2HhDvfAdKf1w1sp909Sx0EAw5E0QPGTlhELQf5DXgKh64Z2h+ypT
         lpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718826157; x=1719430957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/mbiCPrwheVnyKx6Tn1g8ggM05xq8FHv37NW2n7TXw=;
        b=fjiCqk6+pFwx5s+8MJ2LXwGayPY/deTZLZItol3+3iRyStFKr/EcDgvzneMKc+6zsX
         fE0JkdBbsJ1BewcGuf0DqVkkKU11lsW8LxbhraiyapHiP6KfQhQfZBC/s/STzSit2UWC
         c+ovK1aNqkeP1/iftOhVp49RuUGFNxpFHITq+RluqarINpg2gT8Du0ERK6jIoTrldRU7
         xYib1z6MtE8vXxjSeDOS35B0q8w5IasYZK6LL4tN+SEnGcShOMWdmAny/aNoEKpPTj5Z
         OcSa/18pQ4QPAdLXmhbrJnvuV3qAI/ldeuz20iJ5wh16EBJ9x34DspOhVeBu+LYlbubv
         UltA==
X-Forwarded-Encrypted: i=1; AJvYcCXIicP9LcwSY7RXj/oSthqDqn60QNKufNquFqf15MtmnEI/Py2aE14mHpIlwgB2BpA3ttYnkOCJYyMHDzjPZs+0+AOt1mdvjGi6uuKTniznrQm1Vjhuy4RmR6wJte309DXl0oTd
X-Gm-Message-State: AOJu0Yz5XJ3UqbDT2JEUlrcPAbeufTK2SoI0OkC7G5JQ+t0IiYMr1UV7
	elVSuCffui7M9SFcvreZTz0qBDEVibQT0HB0mGBsMAPXdT33I6So
X-Google-Smtp-Source: AGHT+IF2IxtLOJA3h18fOwP9xgKYFMBwoIc2Z3TKZGsCnjv0rzAia+DYIAtwysGmCydG9zU41wq9jw==
X-Received: by 2002:a05:600c:2252:b0:424:798a:f808 with SMTP id 5b1f17b1804b1-424798afec4mr15726325e9.5.1718826156363;
        Wed, 19 Jun 2024 12:42:36 -0700 (PDT)
Received: from [192.168.0.5] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d1f6dbasm341025e9.43.2024.06.19.12.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 12:42:35 -0700 (PDT)
Message-ID: <98ca94c3-d37c-4145-95a8-b2d9a36775c8@gmail.com>
Date: Wed, 19 Jun 2024 22:43:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1] net: wwan: t7xx: Add debug port
To: Jinjian Song <songjinjian@hotmail.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 davem@davemloft.net, edumazet@google.com, haijun.liu@mediatek.com,
 jinjian.song@fibocom.com, johannes@sipsolutions.net, kuba@kernel.org,
 linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
 m.chetan.kumar@linux.intel.com, netdev@vger.kernel.org, pabeni@redhat.com,
 ricardo.martinez@linux.intel.com
References: <9f934dc7-bfd6-4f3f-a52c-a33f7a662cae@gmail.com>
 <SYBP282MB3528E219E1B7A579EE58A2B1BBCF2@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <SYBP282MB3528E219E1B7A579EE58A2B1BBCF2@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jinjian,

On 19.06.2024 13:23, Jinjian Song wrote:
> I think I need add an ADB(Android Debug Bridge) port and a MIPC port
> (debug for antenna tuner and noise profile) to WWAN.

Yep. For now it is a best option what we have. You can do this in a 
similar way as you already introduced the fastboot port type. And a bit 
of documentation would be a good option as already suggested by Jakub.

--
Sergey

