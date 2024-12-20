Return-Path: <netdev+bounces-153644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AE39F8F0B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 10:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACA0169231
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085A31AA1F2;
	Fri, 20 Dec 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="QHeX8rbD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BC82582
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734687225; cv=none; b=M6B6hrFCpjrkh9pDVstDX60IHiaZGL5KcWpyAMf7Fw002fdnPjk7AO4jWrVSydt6aYHD+D2upKmhjmquU7ORpQ5OulURjZF+SlHMbQli7/WGnP0fyh1WWRzYBO7ZffY8ueQ9fkX3YyewhP8/SWncQZ6Vc9T1sAuJIqa7r3EcavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734687225; c=relaxed/simple;
	bh=ql2cvojNhDoLyvf6JrsgSjwAgndqbWMG7FrdjDf+I+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxxPeygh7pHlh+t3pq5OVNaUNaY3KOPSXEbaYJk//5QfhWAJ9rzPGQUZ3xZYtqDsXDFAFm4RCMZksjAKQE8I5yD5TsOQox5kubp6FTHFA52A0CaQ27yWz6O5OjeZ6k7293J7gh+9w/KpD1CGPJ+5G/FrnGGQ6Xv+snrABA2vvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=QHeX8rbD; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30036310158so15561511fa.0
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 01:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1734687222; x=1735292022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jo8fLuZk//T+YU0KgoC3pp0THGZOK8etrF75WPNYpLU=;
        b=QHeX8rbDomFRsno+nFUj2Hz39d6BAH8JdJI756pCZoMfTU2LofTPvrlXw4ltHfnnsC
         zSfABc+8cBLxE/MuuAs+uBDrOg7YjHDz7IKyfCecOWC2gcfm7OysqMkPhbPu/RTfAD5N
         eESyahyQwR8l7QXMGDNNt8EWyfHHiOVIR7ZGnGkXZDlFNR+km8LQO+9aWBQFFTvLSq1C
         DGlgDp+lnyz6xyzx7wF0K8+zlwOVpbWYJOuLvLNnFGH4rFdMr3LBErhX4TUBlRr7MvYk
         c/LNdjGabePLAfNECfWGHo3Bu+hP/cbvBTCVBTRz9/dCA/0oHh+ACJSy78lhHnz5VJBp
         9JHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734687222; x=1735292022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo8fLuZk//T+YU0KgoC3pp0THGZOK8etrF75WPNYpLU=;
        b=RtqE0DkZ1NdqCOeyyFNfZ/HvidU7pUfsZ+mFBeFamT1mV1msIOr58m7MJoanLc5DnS
         gxOZxO5Fg1ghrm9Hg2Jx14x++VsKVvlKmMSJRCMNoTb+TO1gt/kzlNLAuKyC0T9hJ3Fu
         aHt7/Od8WrOKBsgrKIY8NeFTN2zatkxas7dPNn72oQfTaBrBckBhg8/rv+0HvTVoAX3g
         3GjTXeWiis0MDW0UPdPR2ld8+gljsNF5X48kyvnmQpvhbyBGe8pWeG9bootYttQf9G5O
         NziGkSVReZbwUQ/k6JXcD6DmXwU/6d+hy5mlRtXVOet6c5LR5UsO5vMN1oozXj4Vm+vS
         KgzA==
X-Forwarded-Encrypted: i=1; AJvYcCUIJhw/Rh9Pma5cF2LY81XMXuIwvhJ4qzaHdNIMHuhBe/Bb18zPi3U3IrrOcC0nSivJz5bsJPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxqFF19a+gqj71sCqBVAN8DwVNAxNA5aw2qcJrlz0wF7RlQDQ
	XTpsyo2g94nU3ee7vrypxR9er092MyObbrmH/OssTkcIaKYRSZEinq+kDx4xxnI=
X-Gm-Gg: ASbGncuGxxgB0s8P4Q3T2UBKVc0iOhpeQRkdddOFZ6dX18nmg9FLWeHZFHN+lRETkUK
	Ddg+6KY1KVV/7HdpEzFZXOxqsvYMMObKuYqF5s5s/x3lB812A14mymDbO0QISTpxFJzl1vhmTnz
	ckJvPoHiGRN5qTIpVdnW5mSO7BDyTWFMR0QA7Cz7rxkaOzSR4OVeYu0V1Ppd/BjT5OMuRWTQiyv
	6S2UTFsXKW//gBqA2mcBvV88XLpIy/x+G5/jh1YxZYHzXwtllUpjuKFOUW1yDvDcUZDX4fBPzDT
X-Google-Smtp-Source: AGHT+IFH9+g2ADiqcDjxY+wSn3OVVD0jTbeD93+8HhtUP/uu4l9Lapa834iXKgUP2D0TTAaABdYTIQ==
X-Received: by 2002:a05:651c:1544:b0:302:3003:97e with SMTP id 38308e7fff4ca-304686087c4mr7366591fa.30.1734687222506;
        Fri, 20 Dec 2024 01:33:42 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad9c093sm4687421fa.49.2024.12.20.01.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 01:33:42 -0800 (PST)
Message-ID: <21f0aa0e-9df3-4b5a-957a-dcf68399cdce@cogentembedded.com>
Date: Fri, 20 Dec 2024 14:33:39 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: renesas: rswitch: use per-port irq
 handlers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241220041659.2985492-1-nikita.yoush@cogentembedded.com>
 <20241220041659.2985492-2-nikita.yoush@cogentembedded.com>
 <1f4b60ec-544c-49c5-b939-89882e1311ed@lunn.ch>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <1f4b60ec-544c-49c5-b939-89882e1311ed@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



20.12.2024 14:19, Andrew Lunn wrote:
> On Fri, Dec 20, 2024 at 09:16:58AM +0500, Nikita Yushchenko wrote:
>> Instead of handling all possible data interrupts in the same handler,
>> switch to per-port handlers.
>>
>> This significantly simplifies handling: when the same interrupt is used
>> for several ports, system calls all handlers, and each handler only has
>> to check interrupts for one port's tx and rx queues.
>>
>> But it is not required to use the same interrupt for all ports - GWCA
>> provides 8 data interrupts and allows arbitrary per-queue assignment
>> of those. Support that by reading interrupt index for each port from
>> optional 'irq-index' device tree property.
> 
> It has been pointed out that adding this property breaks backwards
> compatibility with older DT blobs. 

It does not break backwards compatibility.

Current behavior is that everything is serviced by interrupt 0.
And in case of irq-index not defined, the fallback is exactly that.

(physically there is code that assigns interrupts per chain index, but in the current driver chains that 
get non-zero interrupts assigned are never used; anso currently multiple interrupts are just multiple 
entries to the exactly same handler that always services everything)

> I don't know this hardware...
> 
> How many ports are there? Less than 9? Can you just do a static
> allocation, port 0 gets interrupt 0, port 1 interrupt 1...

There are only 3 physical ports, however the use case I'm targeting is - virtual ports serving virtual 
machines (with offloading features making hardware directly L2-forward or L3-route most traffic between 
outside world and VM-owned virtual port frontends). In this setup, some of 8 GWCA irqs will be given to 
VMs and thus there are definitely not enough to per-consumer allocation.

Nikita

