Return-Path: <netdev+bounces-201623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F3EAEA1DC
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B487F4A1E5F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63002EF9A4;
	Thu, 26 Jun 2025 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="NGjfB4kl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE22EF675
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949501; cv=none; b=D7bWTULuCrarYtPpHrFBxLpZSISY7ml1V15PTnV4R/mESjVoKs5X9XrYVz0PyUwEHTYh+KmQFR+hh8ElwXawXomE6//KVzFVI+QjVSImK7qForMnp3gqQQ+ylJ/xPXFm/Yx6BauPXJ/9iecz9AVAV2IrUkxH6hS9wXA9w5y7Klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949501; c=relaxed/simple;
	bh=JF07pNpobx+eiQCknDKHloi8lwhYrfONSzZq4yCierc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcBpBWYDAe+eAoEvY6XRJPUv2wg8hqc6HyBbtI+RWL08WbkYmR4WTIdLi2rxKwCbH3o72LpZUpoApKoY1EkN961j0V3HdYTswlpwk3m5YGroU1jl6U1ICDc5jUYDK/YDCQgnxoVltly/u8BFiAJqscYevuvIQEDU8u3F6kZnNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=NGjfB4kl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-453486940fdso630835e9.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1750949497; x=1751554297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XCxrgMw5dH3wwRotvabG0epD5GWPSRw6BRqG3JMXTG4=;
        b=NGjfB4kl6jpcIAsJ0/Bx8XDQVMQtaf1iE+IrAQFcwiPuf+kIQawMK8UC/OvscE50dd
         x1KvUf9TBYXTdNTSkNk0IgtUKOPPLu1wY+xAl0fWp6TkwnShx7xasxBmlKJwheLeiLy6
         /q+AcF+T5UwqtvadYHVhwf5bflNvAL8/EVwoXB2rDM3jpbWA7jYBxoP++N2I+LcL5zdc
         RGFgLsNQtllkWY6DxyVrmudyWkek35dbWO7+ofsHKdiR0wc7szN45q1vflEYlOBBRLYh
         jbBmFQFH81eFPZNdEZZPNJtcA9efIK1JVJLIYvvnHn9b2FrgqzuTuUQ3hCCgJtryxUsQ
         L2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949497; x=1751554297;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCxrgMw5dH3wwRotvabG0epD5GWPSRw6BRqG3JMXTG4=;
        b=GGYXpK8hhz5XzbnC1WtBWagCrr2SphgxNxr8aXH4hhTRGxdxgapRZFWJdWgYtEUOn7
         omM+TgK/4t/v9JTRXCfUZ+2zG+jHlkG5QFDaGD4EC0fdiBJ7Gb8Ne409U4DNstbjFXSi
         zqZ4/DHhRxFsW2BM5jgWi3G/1Kwo5YhFUYkI6H6Gk8yN2dIPGgZfogSl/+NX34S8h7e5
         T26j58Fr5Jlk+4S1xEwZnCfe5RLvK+Z1Klydgiwlz2AeY/yCp3DM8MqtWAsSxsAR11Vv
         jsTLXENksuOKMV4Al5Hc3gmhD+FnXsv8CTrD1zyetrrc0yav3BoPy7yB18lDaQ6wIYlu
         JE9Q==
X-Gm-Message-State: AOJu0YwklL0HL+USXGehJA90xXpJa7pA6ztb3hVpRszv3/VqFOtj3QGU
	zOShCy0dbr3JPp4F4C4l5gX1QFegjc+kJEhPMbOZTPeC7RoiV7JA9eU+6zxALxYOOS0=
X-Gm-Gg: ASbGncviLwtqnmV75rL3bUESFHfKj41tKoOgiF31SGgzpyQ4mLS1Yj+9fpHePPpLiq+
	bt3DVuImVrmLTST3pe4VZtBUYmHONW/O0ReZ5TX/rXEG3UplLSNfG4NTqPf1Y+IZOjpYW0+w6L0
	xxN6YnnUYs5g0AHH4oeGB7YeqNd0kT/jb5SqON2CbJsK4GbDWRZcicp8sFUuEjtkyFA/YFQOTzs
	3Ehy7olcasbs3fCpJK79Pf6VGsONa3hwDyj67uLPigeP9nX4kd5fKR/K6ZkEhwM0v7Xx+sSQJOV
	vJaSAH2HnV7INgmh9K5VNOvI8p0WDpWJxOSldJviYmGZaKkJMixz34bzidCB0KHrTDTdlOcBjKP
	1phQw7b3/l4sczfZvxIpM+IjJO0ILBLRTCV29zqg=
X-Google-Smtp-Source: AGHT+IGEqw+vHiOtazisTlthFJURpuJo0I3wC2xWaJSrVLuPouGSp44NESRPywzoYZsbj5JBnRucLA==
X-Received: by 2002:a05:600c:1f0e:b0:439:9a40:aa27 with SMTP id 5b1f17b1804b1-45381b0e6d6mr27342225e9.5.1750949496818;
        Thu, 26 Jun 2025 07:51:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:fc93:9188:755b:45d1? ([2a01:e0a:b41:c160:fc93:9188:755b:45d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad0fesm54189615e9.25.2025.06.26.07.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 07:51:35 -0700 (PDT)
Message-ID: <f674f8ac-8c4a-4c1c-9704-31a3116b56d6@6wind.com>
Date: Thu, 26 Jun 2025 16:51:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] ipv6: add `do_forwarding` sysctl to enable per-interface
 forwarding
To: Gabriel Goller <g.goller@proxmox.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250625142607.828873-1-g.goller@proxmox.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250625142607.828873-1-g.goller@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 25/06/2025 à 16:26, Gabriel Goller a écrit :
> It is currently impossible to enable ipv6 forwarding on a per-interface
> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
> enable it on all interfaces and disable it on the other interfaces using
> a netfilter rule. This is especially cumbersome if you have lots of
> interface and only want to enable forwarding on a few. According to the
> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
> for all interfaces, while the interface-specific
> `net.ipv6.conf.<interface>.forwarding` configures the interface
> Host/Router configuration.
> 
> Introduce a new sysctl flag `do_forwarding`, which can be set on every
> interface. The ip6_forwarding function will then check if the global
> forwarding flag OR the do_forwarding flag is active and forward the
> packet. To preserver backwards-compatibility also reset the flag on all
> interfaces when setting the global forwarding flag to 0.
> 
> [0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> 
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
Please, export this sysctl via a NETCONFA_DO_FORWARDING attribute also.

> ---
> 
> * I don't have any hard feelings about the naming, Nicolas Dichtel
>   proposed `fwd_per_iface` but I think `do_forwarding` is a better fit.
What about force_forwarding?

> * I'm also not sure about the reset when setting the global forwarding
>   flag; don't know if I did that right. Feedback is welcome!
It seems correct to me.

> * Thanks for the help!
Maybe you could align ipv6.all.do_forwarding on ipv4.all.forwarding, ie setting
all existing ipv6.*.do_forwarding.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv4/devinet.c#n2423

Regards,
Nicolas

