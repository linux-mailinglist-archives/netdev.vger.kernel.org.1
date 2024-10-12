Return-Path: <netdev+bounces-134874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC1299B6D8
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 21:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6039DB21F0C
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 19:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10BC18453C;
	Sat, 12 Oct 2024 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XASu1wEf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8074418
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728762812; cv=none; b=V0tXwzkgPCT10gxHX6qx23orJEVY4jsNeJbPcR4EIkz8J60SqPlpptQxm2unFhVx5XcLA3jzBLI1xwqOeGfQi+LSwYLCha4BWhUmAM6oaBYNzMzGhL91cMEQW8bL97FrkHvV1P/mGQRH5irSEDgdkF8CVpf6fhDDI8WL2TqN9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728762812; c=relaxed/simple;
	bh=f3ak9CuQ08tnIbCe+lT+4jIIwy1YLSMSo5U07PheiAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j3PzukRDuHwjuSVOcohTvRjH3q7aIbv5dWdBWxhxF2vxxuf5MaF/uJxPQWPptUfqWR7Rlc8qwGOzmki8p8BwEHbQIIjJpGiZiF/JLkzaRHnpadNKO+uybBqaw2Te2TqE9O6mypOxhKk7yhy7h1ZsI5Z2VaWgf3SOFDiJeUQZG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XASu1wEf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c721803a89so4292589a12.1
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 12:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728762809; x=1729367609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gsuV4kC+4mF/ZDT9Hp0bvpVTDjQyse49pv4tn0XfoGQ=;
        b=XASu1wEf31B9lHh2A2b6ONMu6FsDW96SFPIGTaym5DfNHGR3h/4aJ6VIRPIAShQhKg
         XPLArhbhx+PGGS9bMFacYhuMzsioOOe3J92RhJ6RlIRrefxcuGymP7di6GhM/cBT0NBU
         WF5r8/jFiWO4JZGC9lZkCxdF/EYEN9ukiDRMmNEKzL3IZh+uTMvjFcUGP1byinFiKsEo
         k7PDjbW/bWcdhec+WoAzjQJTL6ANgt9IVdb087THAp919QiBvOQnt+OQ1KwrJTfq0Btu
         OXMlbUbWVwsRigb3lLs59Z1QNHRt8uV2DJTas55QMxUqemEN3JZpEK1eNDiboei047oS
         wcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728762809; x=1729367609;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsuV4kC+4mF/ZDT9Hp0bvpVTDjQyse49pv4tn0XfoGQ=;
        b=ee/Q3dDAM+Scfzeo2s16rHmOAt92ziFk9WRFj6NQbPUTvYvBz2WKZ9dFCeSWQ53LE2
         Se8IgM5pitAfMxspvVx7NTxDVTcr+fWHN/frbbj1tXt5N2Kpq3PTkrgSDsgqBIzKKNQH
         bX8tDWFzhGP6reaH6enwjqvtQVSyuN1hqC23GcphZCVqOWob6dhm9cFrHIqVV7NvNHzi
         43+2Ry6hg9rrfVsAQWrW5dIQOXtvuTYf3v+xMOUK6Jh0ui8V0HAROWPt2dkfVJtZGvtM
         S+kDcgcT+2BRkjGkoQx3iv3unc96bDQByM43d9YL20vmfLMMAsdxuMWGwtCkREahkFX5
         uIvw==
X-Forwarded-Encrypted: i=1; AJvYcCWmFPZpJ/GuL9jbhq0WFuKxp6sVjHl+dZDOJX2mfnlJRFJoSvB2t67QJSJnTT1K8akBubgqycM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJl5+DhpkOnC6g7liDLZtH2ABRJtJgvqQwz2dA5UhKqZI+opFR
	OQF7Vi1/5niu23KUALrA6L4dPVh5zJrFLuvHudJ0nU4NmsSNYPtfvsLk+A==
X-Google-Smtp-Source: AGHT+IGDmGJY7I9PSOGvp1nM/IMHawWjMP/k6PUMOzwErw5T/TewFePeJQpCDfiC7moUMbBf6Rjngw==
X-Received: by 2002:a05:6402:210b:b0:5c9:69d8:6329 with SMTP id 4fb4d7f45d1cf-5c969d86695mr1366549a12.20.1728762809050;
        Sat, 12 Oct 2024 12:53:29 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9cf5:9500:7452:8738:f913:7c31? (dynamic-2a02-3100-9cf5-9500-7452-8738-f913-7c31.310.pool.telefonica.de. [2a02:3100:9cf5:9500:7452:8738:f913:7c31])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c937153939sm3150696a12.47.2024.10.12.12.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 12:53:27 -0700 (PDT)
Message-ID: <3c5d532a-d817-4fcd-bdad-bd476e495be4@gmail.com>
Date: Sat, 12 Oct 2024 21:53:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169 unknown chip XID 688
To: Luc Willems <luc.willems@t-m-m.be>, netdev@vger.kernel.org
References: <CAHJ97wTDiqgOHfLJc3pEjz=ZwpWP4LJV7sxUfYxQmkryi-rv0A@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CAHJ97wTDiqgOHfLJc3pEjz=ZwpWP4LJV7sxUfYxQmkryi-rv0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.10.2024 21:03, Luc Willems wrote:
> using new gigabyte X870E AORUS ELITE WIFI7 board, running proxmox pve kernel
> 
> Linux linux-s05 6.8.12-2-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.12-2
> (2024-09-05T10:03Z) x86_64 GNU/Linux
> 
> 11:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
> 2.5GbE Controller (rev 0c)
>         Subsystem: Gigabyte Technology Co., Ltd RTL8125 2.5GbE Controller
>         Flags: fast devsel, IRQ 43, IOMMU group 26
>         I/O ports at e000 [size=256]
>         Memory at dd900000 (64-bit, non-prefetchable) [size=64K]
>         Memory at dd910000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>         Capabilities: [70] Express Endpoint, MSI 01
>         Capabilities: [b0] MSI-X: Enable- Count=64 Masked-
>         Capabilities: [d0] Vital Product Data
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [148] Virtual Channel
>         Capabilities: [164] Device Serial Number 01-00-00-00-68-4c-e0-00
>         Capabilities: [174] Transaction Processing Hints
>         Capabilities: [200] Latency Tolerance Reporting
>         Capabilities: [208] L1 PM Substates
>         Capabilities: [218] Vendor Specific Information: ID=0002 Rev=4
> Len=100 <?>
>         Kernel modules: r8169
> 
> root@linux-s05:/root# dmesg |grep r8169
> [    6.353276] r8169 0000:11:00.0: error -ENODEV: unknown chip XID
> 688, contact r8169 maintainers (see MAINTAINERS file)
> 
Thanks for the report!
Vendor driver r8125 mentions a firmware rtl8125d-1.fw for this new chip
version, which hasn't been submitted yet to linux-firmware by Realtek.
I'll ask my contact at Realtek to take care of this.
Can you build an own kernel? If yes, then I'd provide you with an experimental
patch with support for the new chip version once I have it ready.


