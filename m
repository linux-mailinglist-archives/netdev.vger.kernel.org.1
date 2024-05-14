Return-Path: <netdev+bounces-96434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5F78C5C73
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 22:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672351C2108B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9715E1DFF8;
	Tue, 14 May 2024 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJp1a0/g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3E91DFD1
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719677; cv=none; b=dX6oMcK86jiimJowMWIll+v36OBEM/OSRxLq6IuJpjhdG+Df8Wi7ZcVvuMZG0Uz4PJaSvFT5gJU+H2WQvGMc9aX1xXEozJe5ffxh1suNRxRZTbxwbAXEfJ6DSwK+hn/NP0dwqAWnZNMg0MaGP48UMH360qKfmvd4tDRG7o5b8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719677; c=relaxed/simple;
	bh=I8XQF3WNnn6XC2IA4i+p1Rf5LWJG6e1yzrkyUwRD/Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiKupAF2JZy7vz68tgAKQDa/6swXL+5CBG62ZhNBhIf3Fl2FeM8zVCg8vHhW1NIkSbpXJ8tRX5rSiG4qRNmLky9wOzKwFJTSzYso71QQVgqgxQPEQTmDk5HztUD4cx7h4YQebDRPqqDufQyVbTVeZsv/R2KPMq/aLq/hn7MBS50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJp1a0/g; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34f7d8bfaa0so4216908f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715719673; x=1716324473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8XQF3WNnn6XC2IA4i+p1Rf5LWJG6e1yzrkyUwRD/Mc=;
        b=VJp1a0/g+CqK3uMw5i+vUtE2rqwXQVx0rV2BkIAfgONeZ9U8o0Ho/HoebwQtoRpupi
         aGKIJrVZMSNf0lDH7WMP5tCvwiPbao13Z3KuFgXZs2i1YdCS/o04Y6Hbf+iEf/YZWolK
         uZQZiaTQAJZVhvlCKHe61KXv4yh0yZavbNhG2b1vG2cwNnPRKwLNEshfEHcQQmXG/lGe
         DAxyeY626LbtGt6/n1WCcEUwzcGQONA6ubZ8kGqBcAuWn3i//gF6oYc14Cetp+shAmee
         Vf5Wm793wTv3rLbRYtXzNk+qD2vGO+vm89Qgb7GPQuhbMAtnIZqFMAx6LXVpsfNFMnQE
         UpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715719673; x=1716324473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8XQF3WNnn6XC2IA4i+p1Rf5LWJG6e1yzrkyUwRD/Mc=;
        b=b7Nsfnps4vSwKgUUzuUOSj2K3iDlQrRebFvD3m8vHdQWJ7kbPWuATxvtZYaOeZ8CvI
         7J8sVgghRXqt3pX1lgAJNgJtgnaxTvvUtVlDmrZqI7uUKL3h2f+2tPj9R9sp2z7BZwwx
         RkegJkYTS9wpYjT2+gesd4FLxkMnjEes6nrPO1htUgksmsH+nvFG9QQaD5/5BFe0MNJE
         CV3rDblvqkjWl+hRnM56XQZfMKvuHVxvIEtW4tEwAK2XKWKcsQ1Z5sSmR6db6db3QC1O
         eVCzcij0U1E1E8fQxOYIDj7lDuiqmgMzLwxgLa59ZmjbX0CXU/Ty5GMtQTtfiw5XE9t3
         hgHg==
X-Gm-Message-State: AOJu0YxMZqQnJZ9AJQZRn+YoChlFMBaKz5badPPvozUvLKICmbhPDqxz
	eMGO5ryBbQ/FgbQkzm+8oYyngFa4pAeju3DPpiYo3sacHMFihqP84wba8Acu
X-Google-Smtp-Source: AGHT+IGO08zYHwc/FA5AvKI5El3Q9aDSrdNIJPWhlC+o7SicdOmzryE2C/k9nQI1j2LU3AvdQgFeJw==
X-Received: by 2002:a05:6000:1845:b0:351:ad5e:488a with SMTP id ffacd0b85a97d-351ad5e4aaemr8639583f8f.41.1715719673280;
        Tue, 14 May 2024 13:47:53 -0700 (PDT)
Received: from [192.168.1.58] (186.28.45.217.dyn.plus.net. [217.45.28.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3504660753esm12872606f8f.8.2024.05.14.13.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 13:47:52 -0700 (PDT)
Message-ID: <a1aac418-bdd4-48f4-ad12-68ba82dafcd6@gmail.com>
Date: Tue, 14 May 2024 21:47:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for GRO-scheduled
 NAPI
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
 <ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
 <CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
 <e8f548f8-6d16-4a30-9408-80e4212afe9c@intel.com>
 <CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
 <20240514071100.70fcca3e@kernel.org>
 <78fb284b-f78a-4dde-8398-d4f175e49723@gmail.com>
 <20240514094908.61593793@kernel.org>
 <cdaf9e9a-881c-4324-a886-0ed38e2de72e@gmail.com>
 <20240514104739.2d06fb10@kernel.org> <20240514104915.500fc7ad@kernel.org>
Content-Language: en-GB
From: Ken Milmore <ken.milmore@gmail.com>
In-Reply-To: <20240514104915.500fc7ad@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It seems to me that these chips are known for being badly-documented and quirky,
so maybe an empirical approach is called for.

I have briefly surveyed various driver sources available from the vendor and
from the BSDs, and AFAICT they all follow the pattern of unconditionally
masking interrupts, then clearing the status bits, then processing the rings
and then re-enabling interrupts in that order. In this respect, the Linux
driver may have become an outlier in that it doesn't *always* mask interrupts
before acking them, and that it may process the rings while IRQs are unmasked.
I'm not saying that these are necessarily problems, but...

There are some differences in how the drivers work: the FreeBSD one masks
interrupts straight away but defers writing the status register to the bottom
half, the OpenBSD driver seems to do everything in the IRQ handler. These
drivers also tend to flip between using "hard IRQs" and the built-in timer,
which complicates things. But in terms of the "mask first" approach, I think
they all look equivalent.

https://sources.debian.org/src/r8168/8.053.00-1/src/r8168_n.c/
https://sources.debian.org/src/r8125/9.011.00-4/src/r8125_n.c/
https://github.com/openbsd/src/blob/master/sys/dev/ic/re.c
https://github.com/openbsd/src/blob/master/sys/dev/pci/if_rge.c
https://cgit.freebsd.org/src/tree/sys/dev/re/if_re.c


I also found this ancient netdev thread which looks startlingly familiar to the
behaviour in the present issue. It seems that people have been here before...

https://lore.kernel.org/netdev/1242328457.32579.12.camel@lap75545.ornl.gov/
"I added some code to print the irq status when it hangs, and it shows
0x0085, which is RxOK | TxOK | TxDescUnavail, which makes me think we've
lost an MSI-edge interrupt somehow."

https://lore.kernel.org/netdev/1243042174.3580.23.camel@obelisk.thedillows.org/
"The 8169 chip only generates MSI interrupts when all enabled event
sources are quiescent and one or more sources transition to active. If
not all of the active events are acknowledged, or a new event becomes
active while the existing ones are cleared in the handler, we will not
see a new interrupt."

