Return-Path: <netdev+bounces-239712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F4EC6BBCD
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 256A329DE7
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599EB305067;
	Tue, 18 Nov 2025 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBgtOmBs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F63702EE
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502191; cv=none; b=lkXQNcPoed/ptg83JLCqqKAORVmgPUN45GyvZySYF1a5VOSHbaSIFqgRsEOAPO7ES7t+vsrxiKfmsNFkvc3ZKWBZZr2ygHbPiHFT1l2wYpfOe9pZpxdWxjNMr0GcK5MryEyddtwGmy/aA00DA2IfZIlwT0JjpLnsc/iuQ8lN9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502191; c=relaxed/simple;
	bh=7XN+8w3NWv5CIgxr9frrAmMEY4zZ2Ww+CNE+UHCbaSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRYjIEBQmVeGC8tVK8QOA0JF1egg3sy0T5R768cCfzyfQAwn2FRFXBq8JU5itRojjCo8S5UOttEe4fEeHJA8NqLIW1Ue1Pqvl5Zs/KXzYvqCr8C/nnBydT52fhHQPUcF3rT1cw5oy/jSxoKzde3eLEhOqa8hl8/1JlENyIBqsIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBgtOmBs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so60725355e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 13:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763502188; x=1764106988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUkVwdGzVQ7q0OYPtHv5zvws/AG+rq7G9PwmbeyAvwQ=;
        b=NBgtOmBskChMSzJW4Jtkz7lowF2AKUXDbYRFxJEl0Iwu8DGHzO/PcaD0MUBy7yApNR
         gLwtej4kfo6MvhWg6ua0vOvunu2czyBV27H47JEfr5lXtODSFbIfXWm2cxmrpWNIsIl4
         vCncSVF2Yoqu8EGCQXMEhh9bcwX9ygmZwnkwVoN1jP+VgZ1ey+VRG7m4W7TXNwL5x4SN
         t4W3SCWSwPxcoxGvUzVFp9NTC2EaHOOr3oOj1zLToO5dnnumpH8oL8MJ+22MjC6RUNdx
         wtwd6uOFexAsEQndXdr4rKnc/WbsCjYhhpRgvWxAdT6w+1GClrdHjpKJmkvfLe4sAwMf
         1kBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763502188; x=1764106988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUkVwdGzVQ7q0OYPtHv5zvws/AG+rq7G9PwmbeyAvwQ=;
        b=oPNYPeVwAQj9NVdUhbdWhmnoAmsN0RftZ2TBZat6SqmGh3Sj697vlww0VUSW98GdtB
         4DQv2hb9xVAUJPfeoz+1cGc63u1qC7CGhS5onfDhhTyW9g6S3FPCXc4MrFu4us/3gQL8
         pPQb6c7f4YpoDjUdOUI1OCh2mR/vKIAjG97tpfxg1nuesrh1tZJxU1LkJAcMxCz1CH2y
         cO6+Iy45ZXZuKIK0zr+QYC4BVb7cxQue/8vKAEvOsYz+hIyN+HQe27GhYMlqWwQeja8j
         Yo84lNSj4nuiQeE7Vf+IIBKqGuQH6Y3tyV/RlzOchG9umqQ1d7grlPWKOOc3JNOg9AHD
         WnlA==
X-Gm-Message-State: AOJu0Ywe7mDOJMxLX5H1iB8oGHVGXaBAQZXCIoecq9mi9zolJaszERK7
	GBZQ64VoqC426yawYw4ydAmIvdQ1Scu2lRFDXc7zJ1tmeB0aGgVwRq+g
X-Gm-Gg: ASbGncvdhssxsL+8NwZXJ6tkNVLkP1SdsqP5xAcbYYLXyDMoAJllZkFO4dp8mHPt/ef
	dSU0VhZJohbIEiAp5Nh3o77ECJMYVD7I4FdKobvFXSXmozhtMwcMvXabmpLEB0hhbAcXEBcc276
	bkW67Owmx7T7FcE2ULCqp7p4hnmNw9psNI2z/BdWg703ufWTTvIkMl2W7UV/U/jvBcXLVOouwVT
	P3oP2XMCtXdcLOcEGBhL02xcPqvocpBhIpgOydOGbUrUkzvnYRdrG8vATJslKZUobqn2504SCNR
	j+zeK3r6ZDiWCBLiU83bpIGw3WjCCS29ww8sIZfeKpZ+eGh7wb+N3ircKF+mjwDwfBJfefyq0Wt
	/CsfOLzQbcF/KUdB+80QcGO6ASdzrtgRNXQQVX8uwtgvy0N9CXLeC/Ovgd5F7kHiPtgQnNNI5I3
	fa09KZNWQsV7ivCV4kiasrjPG9EcGyLdzb9KcNWGlf8v3j+gYqGdqsrv92gG0lXwH2lVsnF2cSG
	uzNBr9nXsigjWAqx21abDSYTRL/r+DucWCVApUF3z1mqm6tUuE=
X-Google-Smtp-Source: AGHT+IHg3V+RqTj21DBPLKCHvRfQnSaDtMWAXbMel11BLrYXN8CyGyQPU+OHp+0S1f8SYH8QcVsLdQ==
X-Received: by 2002:a05:600c:1f86:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-4778fea17bemr150756395e9.32.1763502187690;
        Tue, 18 Nov 2025 13:43:07 -0800 (PST)
Received: from ?IPV6:2003:ea:8f37:1a00:5d3:6147:37fb:5feb? (p200300ea8f371a0005d3614737fb5feb.dip0.t-ipconnect.de. [2003:ea:8f37:1a00:5d3:6147:37fb:5feb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b0ffd37bsm11673145e9.3.2025.11.18.13.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 13:43:07 -0800 (PST)
Message-ID: <cc1c8d30-fda0-4d3d-ad61-3ff932ef0222@gmail.com>
Date: Tue, 18 Nov 2025 22:43:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Realtek 8127 disappears from PCI bus after shutdown
To: Jason Lethbridge <lethbridgejason@gmail.com>, nic_swsd@realtek.com
Cc: netdev@vger.kernel.org
References: <6411b990f83316909a2b250bb3372596d7523ebb.camel@gmail.com>
 <3a8e5e57-6a64-4245-ab92-87cb748926b5@gmail.com>
 <de12662baa7219b4c8e376a9d571869675a9a631.camel@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <de12662baa7219b4c8e376a9d571869675a9a631.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/18/2025 10:09 PM, Jason Lethbridge wrote:
> 
>> - How is it after a suspend-to-ram / resume cycle?
> This machine is having trouble resuming from suspend-to-ram. I doubt
> that it's a problem relating to r8169 however since suspend-to-ram
> doesn't work properly even with r8169 blacklisted.
> 
>> - Does enabling Wake-on-LAN work around the issue?
> r8169 behaves the same regardless of if Wake-on-LAN is enable or
> disabled in UEFI.
> 
Thanks for the feedback. Enabling WoL in UEFI isn't sufficient.
It has to be enabled also on the chip:

ethtool -s <if-name> wol g


>> - Issue also occurs with r8127 vendor driver?
> The "10G Ethernet LINUX driver r8127 for kernel up to 6.15 11.015.00"
> from 'https://www.realtek.com/Download/List?cate_id=584' builds and
> runs flawlessly on 6.17.8. The issue is not occurring when the NICs are
> driven by the r8127 module.
> 
> Drivers SHA-256:
> ab21bf69368fb9de7f591b2e81cf1a815988bbf086ecbf41af7de9787b10594b 
> r8127-11.015.00.tar.bz2
> 
> On Tue, 2025-11-18 at 20:49 +0100, Heiner Kallweit wrote:
>> On 11/18/2025 6:07 PM, Jason Lethbridge wrote:
>>> Hi all,
>>>
>>> I’m reporting a reproducible issue with the r8169 driver on kernel
>>> 6.17.8.
>>>
>>> I recently got a Minisform MS-S1 which has two RTL8127 NICs built
>>> in.
>>> The r8169 driver works perfectly well with these on kernel 6.17.8
>>> until
>>> the device is powered off.
>>>
>>> If the device has not been disconnected from wall power then the
>>> next
>>> time it's turned on both NICs appear to stay powered down. There's
>>> no
>>> LED illuminated on the NIC or the switch they're connected to nor
>>> are
>>> they listed by lspci. The only way to recover the NICs from this
>>> state
>>> is to disconnect the power then plug it back in.
>>>
>> - How is it after a suspend-to-ram / resume cycle?
>> - Does enabling Wake-on-LAN work around the issue?
>> - Issue also occurs with r8127 vendor driver?
>>
>>> - The bug occurs after graceful shutdown
>>> - The bug occurs after holding the power button to force off
>>> - The bug occurs even if `modprobe -r r8169` is run before shutdown
>>> - The bug does NOT occur when Linux is rebooting the machine
>>> - The bug does NOT occur when the r8169 module is blacklisted
>>> - The bug is indifferent to either NIC being connected or not
>>> - The bug is indifferent to CONFIG_R8169 being in-built or a module
>>> - The bug is indifferent to CONFIG_R8169_LEDS being set on or off
>>>
>>> Attachments include `dmesg`, `lspci -vvv`, and `/proc/config.gz`
>>> from
>>> the system exhibiting the bug.
>>>
>>> I'll be happy to try any patches if that helps.
>>>
>>> Thanks
>>> -Jason


