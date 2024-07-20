Return-Path: <netdev+bounces-112302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04CD9382B0
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 21:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E921C20D76
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 19:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F4714885C;
	Sat, 20 Jul 2024 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="YYPh87h+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E97A8489
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721503524; cv=none; b=EJS8nZhQ+6bKCGotBkoaW3i4ZN6qi0WcVEqu2B0sFq5Rl//HYelukMqjje0lQtXb5vi20Vq4nWMiDJ1UpahxEsZadnirTe7vxvzEPPkXHyHzFrAnC/7TFSZrUptUGp1M9CpOvGNpdqg9bOS1nXlVDQ6yBDt3CZnjWjmTseNOEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721503524; c=relaxed/simple;
	bh=VEU2wW2CNQWp8qy7HJWV6PWRDd2jLh3bbohr2W6pt1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0UdGx94L2KHen+y19+X2TNpjJWY+9HZWyriOW+bMpmzturw1I0+XTjCbO3YCMELKdXIxPZjB6Vi9Xn9NHhape+o0D+sQ5covkOgTnVgUnd9PCYz0AkEOS2YDKrMxitMpjaF51Q7JQAw7vxdh7XjGprX1xQGJ5fpl4D63Yg/RnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=YYPh87h+; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-260f81f7fb5so1398354fac.0
        for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 12:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1721503522; x=1722108322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0B1/j2S9YNCbXOf1SbkalG6laXdSW5w2tqTb+E6OajE=;
        b=YYPh87h+RjuSx1lV6LRuo1C1rjGQaeGnPWo+s9sfUTmsrUdjwPvOeNCGMDAgRqKEXu
         Nz6gg9/NUU3tHUhZs8rCa34YTvgQ2hF4IUCRNsvn6RKaq2DPAbYJcQ3Yx8fmRmMeIY5w
         JvRgcbfnhK3FxEOiKDrayR6UhXEpn88T98vco3WsEkkbWpTUf3aq0ULwHmumG1sbMAKQ
         FzO5sQwi6NU2v1SZIJSasWSxo8skp/nQnjDOnuzYal7dPysXQ/rxwG3OMtnadAV9h4cj
         oJmdtSICx0yB8Ip3pbN5e6RpDC44WcYUrev6Hqhy4jVLDdR+N35iDbxyoO6cdfeTi/T8
         t9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721503522; x=1722108322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0B1/j2S9YNCbXOf1SbkalG6laXdSW5w2tqTb+E6OajE=;
        b=irkzy23Sal38OQsA7CIeXavHOGhL0GzSZQu/CFRdr2kOjw1SxvjYVJm1fXMH1Y+OGA
         VTC0MrvDBvFwZsn9aF+/4LEQvz6mEAkpyoBkK8C/MpQZlTMjCpT/wNJBv79CicJBQSVK
         5q4+QY+JgEMeK85iSFWjlV2Mg/oAeNOaBVnOu21IhYsQrOiMuwcJTHH+OfDumW0YZY2b
         sNywuNqVGYfLG3fjPnZbDlNpNJaGwKaBg/xiPOHwXyKLtJw8qXJNLaCVPFjYzV60u3TN
         +4Y8L3cieK8PGPZkG0JHbYYfQtBeASsJy9yvCBnp6k+4mqii/jyqyYxilMluuMCYN0Sw
         DD3A==
X-Forwarded-Encrypted: i=1; AJvYcCVWQ7ALJYrvO9Dz5RA2PFOE1x9jQPwfJK/iXjmJjoCiruH+nOgRFcmuerOGmUvcBJOCXUdWtuRaRmh+Jzek8NYiaUJ1XFV3
X-Gm-Message-State: AOJu0Yyrg7ETSjxLyM6rmn3f/OZkohmZIl7K7vEP7Kl+dMO9LoYFZqo/
	btCC7WH3QmvWbm++KgD9oQQmJopGvStlif++WYmUh+5P2UdmzbHD3WdF+S4ZngY=
X-Google-Smtp-Source: AGHT+IE6nOiiMCHIhVmF7v55luSs/74wKNhm3JBn76ZhsMZRVw06pB/V0iQxbYpv9EMerga/hsjaeg==
X-Received: by 2002:a05:6870:972c:b0:261:1af1:ee9e with SMTP id 586e51a60fabf-261213a4f3emr2928937fac.14.1721503522559;
        Sat, 20 Jul 2024 12:25:22 -0700 (PDT)
Received: from [192.168.1.13] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a0de7abd43sm829256a12.23.2024.07.20.12.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 12:25:22 -0700 (PDT)
Message-ID: <6b8e2001-7f4a-40aa-a760-a4c709675fb6@davidwei.uk>
Date: Sat, 20 Jul 2024 12:25:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/10] PCIe TPH and cache direct injection support
Content-Language: en-GB
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com
References: <20240717205511.2541693-1-wei.huang2@amd.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240717205511.2541693-1-wei.huang2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-17 13:55, Wei Huang wrote:
> Hi All,
> 
> TPH (TLP Processing Hints) is a PCIe feature that allows endpoint devices to
> provide optimization hints for requests that target memory space. These hints,
> in a format called steering tag (ST), are provided in the requester's TLP
> headers and allow the system hardware, including the Root Complex, to
> optimize the utilization of platform resources for the requests.
> 
> Upcoming AMD hardware implement a new Cache Injection feature that leverages
> TPH. Cache Injection allows PCIe endpoints to inject I/O Coherent DMA writes
> directly into an L2 within the CCX (core complex) closest to the CPU core that
> will consume it. This technology is aimed at applications requiring high
> performance and low latency, such as networking and storage applications.

This sounds very exciting Wei and it's good to see bnxt support. When
you say 'upcoming AMD hardware' are you able to share exactly which? I
would like to try this out.

