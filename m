Return-Path: <netdev+bounces-72971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132385A753
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 16:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B882840C0
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB65138393;
	Mon, 19 Feb 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyjussgh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB339850
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356404; cv=none; b=XQv/slfIgt/3bUs2O6ky1n8go04ygleykL0PvcsmLlvHjtKBrENKX1JSrCgzrWvgMk7EAKlTZqsaN7wvIPmUUPA5INPr5XvDLsipeiRTNZWHruZ8wg4HmOMPrHUzTUbgjvSLmVsXs4+9AyJGABI96Z7hEP5z4u26IX/l8eiqYoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356404; c=relaxed/simple;
	bh=pAK1t4wRqngIw0oljKvsMjj/6jOG+WYqOJAUyk7v1JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZYEYaBN537uwtvUE6p3Q+PXFdZWS1wUSQxjJHLHPm+sIzqVcw0IEsSVBShJ1d6x70cvK8hj/vl7cyZDyOQZDY5o8m9HE6TXgtBTy9H/hmC/32Q6GH0muxJSPVvddJDSr1VqxUMuT+2xXoapfjSjViVDnIt2IMUP8F81vtw9h6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyjussgh; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so5979848a12.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 07:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708356401; x=1708961201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=td88DtzzwfrAstuuCmQjwaOpk7jBlcJOdUOr3a8U8hE=;
        b=dyjussghzv/rxvac+Tozn7b98/32r7hSaCzombW7mzWPN6XOhbhzKOVwujZv2+9CdY
         PyGBOBEySjeHw9SzxB+xyeaEeeatN2DW8eHjvN9VWIPnFInVmefES1SECztp2GZ5JNwP
         UkDTFEjEXE4NCz7V6BbhmxbKC/91Lm8l8GPmhzsoaIb7LtyMzBhN5m6q2EnEqV+asV5y
         On4mypf+r8LelLSH3IpTJrmFnb6ez9zlloTPyWJ7FvGk+i1c1cmL0DlqHi0p6cREa30l
         G8aZT6otkX2zjOtwheYKIdAn7H3UiBQpAVGi7ByfWzg3jjQDPZZ7l2KFL8yS5aLa8zhw
         irDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708356401; x=1708961201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=td88DtzzwfrAstuuCmQjwaOpk7jBlcJOdUOr3a8U8hE=;
        b=U7vrZhR7Quf2OOhNZ0axbHz7J2fLwGIZn1y9QQnwDmZFbmaTdnAEyKDwrxJyavzIXE
         ek3rWM5FfVSNAr9LZ+9OAqmPMyAh2n9b/bLRPOG8bg6wmPtMlR+/pGkIO0FtzATxkRqI
         qXgRb/6C1zSQPeJeCb8eelaMZmoEWkmqbx2CZZH4xRjcX2GcSDryZgljmLpaPQucV25t
         4eTBnwdrHIOpC8m91UOK5tFgxhtIxEssuhGhzHS+NnrLzCeTaXaNExs39lpSGUYvLBTA
         rn1/N8pLz67BNLWwd9AMFZ2hCmb9Daa1Ed+E+YqThLbF24qEd0DIYHbtxlTFnAyaWOPM
         cN1A==
X-Forwarded-Encrypted: i=1; AJvYcCXy9E3BZylM5D1rgPeeDF16I5fiQcoF68krMQbF1cEEttautooR+hx68TWSIbfttb6cPYXKHpmaqENW5EHnI0JcQr6kouW+
X-Gm-Message-State: AOJu0YyuGNO6DsNCe3bbjUyPo9AUHqDNry38y6Gg4Cp33mlTUucrsatS
	b+MqR1AZcqydbHAxJuDdPSYrB4/0vkOtfO4mgfVhlfQgt5621hMP
X-Google-Smtp-Source: AGHT+IH1wp4VXlLpBD2GeiPd1UBdRDFCA7YmqeskqrkD2TSfNV9vxvh9ZXaYrwApAI+5jJuNhA2p0A==
X-Received: by 2002:a17:906:3c09:b0:a3e:cdae:7aa2 with SMTP id h9-20020a1709063c0900b00a3ecdae7aa2mr1287971ejg.35.1708356400469;
        Mon, 19 Feb 2024 07:26:40 -0800 (PST)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n14-20020a170906378e00b00a3be730d63fsm3082692ejc.13.2024.02.19.07.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 07:26:40 -0800 (PST)
Message-ID: <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
Date: Mon, 19 Feb 2024 17:26:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
References: <20240215030814.451812-1-saeed@kernel.org>
 <20240215030814.451812-16-saeed@kernel.org>
 <20240215212353.3d6d17c4@kernel.org>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240215212353.3d6d17c4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/02/2024 7:23, Jakub Kicinski wrote:
> On Wed, 14 Feb 2024 19:08:14 -0800 Saeed Mahameed wrote:
>> +The advanced Multi-PF NIC technology enables several CPUs within a multi-socket server to

Hi Jakub,

> 
> There are multiple devlink instances, right?

Right.

> In that case we should call out that there may be more than one.
> 

We are combining the PFs in the netdev level.
I did not focus on the parts that we do not touch.
That's why I didn't mention the sysfs for example, until you asked.

For example, irqns for the two PFs are still reachable as they used to, 
under two distinct paths:
ll /sys/bus/pci/devices/0000\:08\:00.0/msi_irqs/
ll /sys/bus/pci/devices/0000\:09\:00.0/msi_irqs/

>> +Currently the sysfs is kept untouched, letting the netdev sysfs point to its primary PF.
>> +Enhancing sysfs to reflect the actual topology is to be discussed and contributed separately.
> 
> I don't anticipate it to be particularly hard, let's not merge
> half-baked code and force users to grow workarounds that are hard
> to remove.
> 

Changing sysfs to expose queues from multiple PFs under one path might 
be misleading and break backward compatibility. IMO it should come as an 
extension to the existing entries.

Anyway, the interesting info exposed in sysfs is now available through 
the netdev genl.

Now, is this sysfs part integral to the feature? IMO, no. This in-driver 
feature is large enough to be completed in stages and not as a one shot.

> Also could you add examples of how the queue and napis look when listed
> via the netdev genl on these devices?
> 

Sure. Example for a 24-cores system:

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml 
--dump queue-get --json '{"ifindex": 5}'
[{'id': 0, 'ifindex': 5, 'napi-id': 539, 'type': 'rx'},
  {'id': 1, 'ifindex': 5, 'napi-id': 540, 'type': 'rx'},
  {'id': 2, 'ifindex': 5, 'napi-id': 541, 'type': 'rx'},
  {'id': 3, 'ifindex': 5, 'napi-id': 542, 'type': 'rx'},
  {'id': 4, 'ifindex': 5, 'napi-id': 543, 'type': 'rx'},
  {'id': 5, 'ifindex': 5, 'napi-id': 544, 'type': 'rx'},
  {'id': 6, 'ifindex': 5, 'napi-id': 545, 'type': 'rx'},
  {'id': 7, 'ifindex': 5, 'napi-id': 546, 'type': 'rx'},
  {'id': 8, 'ifindex': 5, 'napi-id': 547, 'type': 'rx'},
  {'id': 9, 'ifindex': 5, 'napi-id': 548, 'type': 'rx'},
  {'id': 10, 'ifindex': 5, 'napi-id': 549, 'type': 'rx'},
  {'id': 11, 'ifindex': 5, 'napi-id': 550, 'type': 'rx'},
  {'id': 12, 'ifindex': 5, 'napi-id': 551, 'type': 'rx'},
  {'id': 13, 'ifindex': 5, 'napi-id': 552, 'type': 'rx'},
  {'id': 14, 'ifindex': 5, 'napi-id': 553, 'type': 'rx'},
  {'id': 15, 'ifindex': 5, 'napi-id': 554, 'type': 'rx'},
  {'id': 16, 'ifindex': 5, 'napi-id': 555, 'type': 'rx'},
  {'id': 17, 'ifindex': 5, 'napi-id': 556, 'type': 'rx'},
  {'id': 18, 'ifindex': 5, 'napi-id': 557, 'type': 'rx'},
  {'id': 19, 'ifindex': 5, 'napi-id': 558, 'type': 'rx'},
  {'id': 20, 'ifindex': 5, 'napi-id': 559, 'type': 'rx'},
  {'id': 21, 'ifindex': 5, 'napi-id': 560, 'type': 'rx'},
  {'id': 22, 'ifindex': 5, 'napi-id': 561, 'type': 'rx'},
  {'id': 23, 'ifindex': 5, 'napi-id': 562, 'type': 'rx'},
  {'id': 0, 'ifindex': 5, 'napi-id': 539, 'type': 'tx'},
  {'id': 1, 'ifindex': 5, 'napi-id': 540, 'type': 'tx'},
  {'id': 2, 'ifindex': 5, 'napi-id': 541, 'type': 'tx'},
  {'id': 3, 'ifindex': 5, 'napi-id': 542, 'type': 'tx'},
  {'id': 4, 'ifindex': 5, 'napi-id': 543, 'type': 'tx'},
  {'id': 5, 'ifindex': 5, 'napi-id': 544, 'type': 'tx'},
  {'id': 6, 'ifindex': 5, 'napi-id': 545, 'type': 'tx'},
  {'id': 7, 'ifindex': 5, 'napi-id': 546, 'type': 'tx'},
  {'id': 8, 'ifindex': 5, 'napi-id': 547, 'type': 'tx'},
  {'id': 9, 'ifindex': 5, 'napi-id': 548, 'type': 'tx'},
  {'id': 10, 'ifindex': 5, 'napi-id': 549, 'type': 'tx'},
  {'id': 11, 'ifindex': 5, 'napi-id': 550, 'type': 'tx'},
  {'id': 12, 'ifindex': 5, 'napi-id': 551, 'type': 'tx'},
  {'id': 13, 'ifindex': 5, 'napi-id': 552, 'type': 'tx'},
  {'id': 14, 'ifindex': 5, 'napi-id': 553, 'type': 'tx'},
  {'id': 15, 'ifindex': 5, 'napi-id': 554, 'type': 'tx'},
  {'id': 16, 'ifindex': 5, 'napi-id': 555, 'type': 'tx'},
  {'id': 17, 'ifindex': 5, 'napi-id': 556, 'type': 'tx'},
  {'id': 18, 'ifindex': 5, 'napi-id': 557, 'type': 'tx'},
  {'id': 19, 'ifindex': 5, 'napi-id': 558, 'type': 'tx'},
  {'id': 20, 'ifindex': 5, 'napi-id': 559, 'type': 'tx'},
  {'id': 21, 'ifindex': 5, 'napi-id': 560, 'type': 'tx'},
  {'id': 22, 'ifindex': 5, 'napi-id': 561, 'type': 'tx'},
  {'id': 23, 'ifindex': 5, 'napi-id': 562, 'type': 'tx'}]

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml 
--dump napi-get --json='{"ifindex": 5}'
[{'id': 562, 'ifindex': 5, 'irq': 84},
  {'id': 561, 'ifindex': 5, 'irq': 83},
  {'id': 560, 'ifindex': 5, 'irq': 82},
  {'id': 559, 'ifindex': 5, 'irq': 81},
  {'id': 558, 'ifindex': 5, 'irq': 80},
  {'id': 557, 'ifindex': 5, 'irq': 79},
  {'id': 556, 'ifindex': 5, 'irq': 78},
  {'id': 555, 'ifindex': 5, 'irq': 77},
  {'id': 554, 'ifindex': 5, 'irq': 76},
  {'id': 553, 'ifindex': 5, 'irq': 75},
  {'id': 552, 'ifindex': 5, 'irq': 74},
  {'id': 551, 'ifindex': 5, 'irq': 73},
  {'id': 550, 'ifindex': 5, 'irq': 72},
  {'id': 549, 'ifindex': 5, 'irq': 71},
  {'id': 548, 'ifindex': 5, 'irq': 70},
  {'id': 547, 'ifindex': 5, 'irq': 69},
  {'id': 546, 'ifindex': 5, 'irq': 68},
  {'id': 545, 'ifindex': 5, 'irq': 67},
  {'id': 544, 'ifindex': 5, 'irq': 66},
  {'id': 543, 'ifindex': 5, 'irq': 65},
  {'id': 542, 'ifindex': 5, 'irq': 64},
  {'id': 541, 'ifindex': 5, 'irq': 63},
  {'id': 540, 'ifindex': 5, 'irq': 39},
  {'id': 539, 'ifindex': 5, 'irq': 36}]

