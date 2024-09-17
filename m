Return-Path: <netdev+bounces-128684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B7597AF3E
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 13:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D18283031
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 11:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E514E2CF;
	Tue, 17 Sep 2024 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUoXUAL3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0526281
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571191; cv=none; b=gX8VBLjS5icdKafs/n7gxWTleCRvVEjLeVURyuHMK0kdH63rl4psfrMNT5lLU3kGY7ZnPGIjGI6boRwYgS43Dh+yPGduq5l+tCoOpZum0VPCKe0AHwuFK2cl+8tUMLWszO0oDm+VesTUILfeCwBb12b9GRUS2AGdi5lVfaFyQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571191; c=relaxed/simple;
	bh=FbD2bNTKWCF72+MiPL0NW4uS8pKG8HlbXq17j+7DGNo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fIdr/3bBgSN5VubVUp9NVn4vNjarnKzGcCbGqe+aqp5fZ9OqWpwEY+BuvrPKtDScIq8h0jtwNqITKTHIhsgTc+a/jUygib90M0zfkQaMh/F2Ywgc4RXzcsH2gXoF20ZSYjS3P42E32fyU6+s9Gc28ahVjJFYYFWpMK01Msk3RkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUoXUAL3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so56637365e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726571188; x=1727175988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Op3/E2Ha3IfZUYxc5YpBqbA+pLWwELFTlGtmVyQnFTU=;
        b=RUoXUAL3cX4Q+5xVs5M4xs5vwvshDaXGNcKoKJ2oxj202T9bpbLZ4lE99Z5YDmYRdk
         R88IGms205oTtqXRYlTtnaJwTIwQ0xZnOIkLNjIKmm0YRg6xdPcCjAf11VkgVPwAsvrR
         5CWo5xKUNuEaCmoKevOesNqNnz1aviIpaJt0e1lzX0IFG0RotRD2jpsdYQ2giKTs53Zf
         7X6Jn3CyzxnLDvfz95+t6oOrspPIwcGGrpC74CPoAcMRCzWTgCxGRnEoOu2qY7l08rqR
         TCcTWBk1e7GAyo+yNleRw3GHUbyCgkdG/VuBRQWghkRvgCOx/XvgIKnEA2hxLtj8b0y2
         wmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726571188; x=1727175988;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Op3/E2Ha3IfZUYxc5YpBqbA+pLWwELFTlGtmVyQnFTU=;
        b=E3U+0bz734K822Y9u7F+TES96sd2yKaRkTHvrJLbeZENIdoR9W8uN3zieX2H1sUfwQ
         ubEmX997xzrWPHHo9EIPCnSGvxZ63qWBwWjZ51YPHaxiJiQ3QNd3tbAFvB1UEEY3upJJ
         jnfSqQbRdzdlAdVKOhfp/h+0NobBvY/kDljEOZ8AIMXK8JgTKtXiRmrIR6uMR0WHj+ih
         JiwqQ30JM7EFdheVK3BJ4SMJmGikE4vCARPaOfQbILAZMQLalK1hgqva5n3xBUN5gv23
         UiOxswaCrpEtpg3ud1zO6iYwp1t7eY/eEJE+y6nm8qlI1/xxgsGIgog12VCGy2eSuveg
         7Efg==
X-Forwarded-Encrypted: i=1; AJvYcCUpZofh2UlSiJjh4WfONwmam7XuL9f7P2RYFp6BdT4ZzA+l05O+GnQWErtxKPMI6gkZoVKJ5Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDdsDVePNWzrPNyNeNDS38Tw81lxZOKOFpwKuBfuKNl8iqOjLu
	eGzs7++0npA+BGX8UF34CqQezInHTTxMmyi3Ihr7oW2TEmn5Hlmj
X-Google-Smtp-Source: AGHT+IHNSs8AqflUe6fqLxToRLTxx46+x3UZ2NVLrxhSSMemKAwr6am/QV3gURlzgSxbg5X1xJEG2A==
X-Received: by 2002:adf:fac9:0:b0:376:f482:8fdf with SMTP id ffacd0b85a97d-378d61d4b43mr11359168f8f.4.1726571187538;
        Tue, 17 Sep 2024 04:06:27 -0700 (PDT)
Received: from [127.0.0.1] ([193.252.226.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b38f4sm429603866b.132.2024.09.17.04.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 04:06:26 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <3e2420e7-02ae-4957-ab6c-12d2442e0a99@orange.com>
Date: Tue, 17 Sep 2024 13:06:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 Simon Horman <horms@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "Knitter, Konrad" <konrad.knitter@intel.com>, nicolas.dichtel@6wind.com
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
 <20240916140130.GB415778@kernel.org>
 <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com>
 <0df1bf91-7473-4ab4-9a96-8eec4c7fa5c8@intel.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <0df1bf91-7473-4ab4-9a96-8eec4c7fa5c8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2024 08:40, Przemek Kitszel wrote:
> On 9/17/24 00:05, Alexandre Ferrieux wrote:
>> Now, what shall we do:
>> 
>>   1. Ignore this corner case and carve the "few netns" assumption in stone;
>> 
>>   2. Migrate netns IDs to xarrays (not to mention other leftover uses of IDR).
>> 
>> Note that this funny workload of mine is a typical situation where the "DPDK
>> beats Linux" myth gets reinforced. I find this pretty disappointing, as it
>> implies reinventing the whole network stack in userspace. All the more so, as
>> the other typical case for DPDK is now moot thanks to XDP.
>> 
>> What do you think ?
> 
> I would describe (here) more what is this typical scenario where users
> bother to set up DPDK for perf gains.

Two cases from my experience:

(1) "Bump-in-the-wire" rx/tx on same port, trying to reach line-rate on one or
several 100Gbps interfaces. On this one, Linux performs beautifully, with "no
fat", just use XDP (verdict XDP_TX) along with some packet tweaking in a kfunc.
Of course you need to get queue number, coalescence, IRQ and NUMA right. And you
need a well-written native-XDP mode in the driver (not all NICs have one).
Here, the "DPDK advantage" is a lie.

(2) "Many-tunnels" as in my CGNAT tester case. Due to the limitations we are
talking about, people are right (so far) to turn to DPDK, as they do for example
in TRex https://trex-tgn.cisco.com/ .


> With that I think that is a legitimate reason to rewrite parts of netns,
> if only to allow companies to shuffle engineers out from DPDK-support
> teams into upstream-related ones :) [in the long term ofc]

I violently agree :)

