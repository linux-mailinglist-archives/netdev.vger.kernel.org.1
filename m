Return-Path: <netdev+bounces-239699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD20C6B7D6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7855129D51
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C162DC780;
	Tue, 18 Nov 2025 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVjtr8J3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544752D77E2
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763495390; cv=none; b=E7Z6rW5kdPzNS9SJojAoLT0aLkfTfx9GKIHn+g4l2PyF4+elv69NRmubynusB931l8vAK/lKNpd4MJVjpyc3u4cKoCJtYf2MB14I22LiVj1VqLhHQSWt1qgc76DwcEdXJUiX0TDbmjKALUeH1OPgSUp9IkwHQOY4JZHXyU9rp3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763495390; c=relaxed/simple;
	bh=YXVbZ/G3o1cijroYiYeiYfEdMJm4koHra21dxqxfjfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwOgR/ah2C4yIdvpHKJYxRQldjcuZnmVF/+nW9tqKTCcV/TCA9gzhUEr+w3jlJseqOGnjIsH5xZZt8qcLcJNxcUoxyCYioe7GXKH+trHM7l18JUDvu/4JWUqxP8nqznSH/UQSQoYG1cKc+OhxPaSZIHMgy+J7NcLS8xa4osNvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVjtr8J3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47778b23f64so40251315e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 11:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763495388; x=1764100188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAPnBDlR63cqO9sTYisaUI8jjHrzFG7MKIEFc9ORWmQ=;
        b=kVjtr8J3JtvEkqhBTIRf8vso3zpGICQjvNTrJTepQzdrFynjRU9wgQlsY3weDJjzu7
         AfOc9m9DFCTY4x337dOMFaZwUFJlt5wLeqrW0r0K6HN36u8X6SmPsp/tlPfLibEmafyY
         IbujlHqF5o6cHasyH0QPv72ShKbfk27E7h0OPBNMBYuCPMt3qtRPktGdXCQ9KoA2s91x
         X1uDi0uZApo1Lzmqw3NeqKNEXwwNFPYKHY500rS9zuGgnyuHaUsK7YnojTNlp4xf558n
         WmDTgHT298dK0vR04o08CUAnZuNnNPHlEpWuVpnXYKlaISyqbNT5gec8tXal9vttt+KA
         OMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763495388; x=1764100188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAPnBDlR63cqO9sTYisaUI8jjHrzFG7MKIEFc9ORWmQ=;
        b=gI/+dXKBH3MFLm7NY5d/K8yO59uRN8H/Cnahwb+cBRiRZXbIlrgM5DTWTMYoPVfiIh
         gmzgGzGxv0PtLcxTezDp66/9zqNF7J4ZhrDyXalQzL4gOIKRaSnLozh2UP8y1+n/WZ21
         y6cJiQEZ8x9CcxE8siQ0w2vrpgH/E91MWNJyYpCtkrLBAOs2v9fE3OabcyPv9YyzPhT1
         0gNtlw9lPWpI8w3DeqBaYrqwaq8KAMXsOhbUEvn8iIvu8unWEgGUMsLZhDFfABJkgwmN
         ocUB08HSAc0M2bldglsRj0SMOx3PXOMi6m7fS7DfwHobo9TliABWuqyApsuT8pU4NCQM
         5GRw==
X-Gm-Message-State: AOJu0YylCzkXTTROYvTp/yXqqlXeB3opAuK8QusSHnOl0lZRla5i151o
	cBvizicuLoW2YjZtAHbfMDpKCTqPhq4UXgc+SefXF7lA05Ql0Ee71bJxJuOrkw==
X-Gm-Gg: ASbGncvM8N+lCpEO9euOXaWV05IT/Dhln5+b3RMPLJ3Sw+l0DOZydkAeYTzQUSF1APg
	lIyTrEVNJpY74ar17CD3hrofq6FikqGlK7CuWE/Nfu5oxi74jYHMbmPgNqUeQI793+er+D0cEO2
	e4lSBI4wOOcjESLyQL7uQxZooPHvhn4/uJ4BFKzLp8ye7hw63HITGs081WH8CZY79hnkbu3gGlg
	W7i1hMRkI4KdLtvOFuL7GAhLUr00UVB13dL5mOO+1LlFYSTyPVjvzcSYOK7elstXVZ9REZHGCO/
	ZRYGjwGr+fo5G2OmymnvuBC+bi0a3bgh5KGUwjCL6OiWeHHubHcSgkdgerBNUR1IkR5+1Ld64gm
	9uGxWkSmyoHS+9Obyh+XQmDwgpoJMyjVjOiHNRimpzBku/X3RB8iwOWMIJF9h2GJUm9P+XLUQYa
	Om+B+Tiien/EM7UPfIjNO+cABhaCDYDCIb/lu7ftyQOUgNpvgMqusLX+dsvgNlbpcMzqK/XiVLj
	oTaOkztvSJqSfEvWbKy3heG69KyCgBcfJvUurMgxDFdAGfABVJJ+bD/WEyRtQ==
X-Google-Smtp-Source: AGHT+IEDPi2F8wic3ro4PplHeDssdUxjnPfGxlNEnFL0oouSXhp4b8emTYX8c6CAWwg+WX9vS3wmVA==
X-Received: by 2002:a05:600c:4744:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4778fea8ab2mr179464195e9.33.1763495387365;
        Tue, 18 Nov 2025 11:49:47 -0800 (PST)
Received: from ?IPV6:2003:ea:8f37:1a00:5d3:6147:37fb:5feb? (p200300ea8f371a0005d3614737fb5feb.dip0.t-ipconnect.de. [2003:ea:8f37:1a00:5d3:6147:37fb:5feb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b0ffc90fsm7723805e9.2.2025.11.18.11.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 11:49:46 -0800 (PST)
Message-ID: <3a8e5e57-6a64-4245-ab92-87cb748926b5@gmail.com>
Date: Tue, 18 Nov 2025 20:49:49 +0100
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
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <6411b990f83316909a2b250bb3372596d7523ebb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/18/2025 6:07 PM, Jason Lethbridge wrote:
> Hi all,
> 
> I’m reporting a reproducible issue with the r8169 driver on kernel
> 6.17.8.
> 
> I recently got a Minisform MS-S1 which has two RTL8127 NICs built in.
> The r8169 driver works perfectly well with these on kernel 6.17.8 until
> the device is powered off.
> 
> If the device has not been disconnected from wall power then the next
> time it's turned on both NICs appear to stay powered down. There's no
> LED illuminated on the NIC or the switch they're connected to nor are
> they listed by lspci. The only way to recover the NICs from this state
> is to disconnect the power then plug it back in.
> 
- How is it after a suspend-to-ram / resume cycle?
- Does enabling Wake-on-LAN work around the issue?
- Issue also occurs with r8127 vendor driver?

> - The bug occurs after graceful shutdown
> - The bug occurs after holding the power button to force off
> - The bug occurs even if `modprobe -r r8169` is run before shutdown
> - The bug does NOT occur when Linux is rebooting the machine
> - The bug does NOT occur when the r8169 module is blacklisted
> - The bug is indifferent to either NIC being connected or not
> - The bug is indifferent to CONFIG_R8169 being in-built or a module
> - The bug is indifferent to CONFIG_R8169_LEDS being set on or off
> 
> Attachments include `dmesg`, `lspci -vvv`, and `/proc/config.gz` from
> the system exhibiting the bug.
> 
> I'll be happy to try any patches if that helps.
> 
> Thanks
> -Jason


