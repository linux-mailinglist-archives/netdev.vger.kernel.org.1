Return-Path: <netdev+bounces-227110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7CBA8703
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 10:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118CE1890FBE
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64418DB01;
	Mon, 29 Sep 2025 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ST/ESEZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1585E219A89
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135524; cv=none; b=jE2GmXdCmhmdGrBhQ2v64SLID7tijcnx1USWHy9BbbiK2tTBvcfc8VwPe3lxLNtld8DTG7m/c5Dig+mZwp/yePpL/yMwc2tiVn93zTQEo6aBhUdB6eUSf3pCwpj2DJnUgVFJsHIc+kx0z+2oyRIAm+LwnntJWsb+7aEnDdCW5Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135524; c=relaxed/simple;
	bh=JA5RcchFYlhuPWUk0QU0LXC1hOJDFmGNvkc+GbXI3SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmvifkCX6e3vpddqbo2bH5dGA8MmU7pkjbu4HztFldjNHeL02agy+vSYZjpVVWRgpP7xdKS3CybWLe7lk2tIylFlukx0ux533/kJLhhw131nCi1u9vQIN73RuSuNmMAyyQL3JZne741aeRXCunMIRA4f1/pSoPMqCYwQaJuUjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ST/ESEZu; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62fbfeb097eso6184449a12.2
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759135520; x=1759740320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzgdahQX7CpJGFCwerveyZDbQ9cci5T/X+7S64lDTAg=;
        b=ST/ESEZuHtRKND2eHFIjgGbniHnBJ819SB+lliLLxqNrGtp+6ifk8tyMBZC/Pxjoqz
         4sD9SJ2PExnnhlkcdMH3KDN9Qgb0gcleKb8XK2POebZyb6ILKdkhcWo9s9uFKOIkuvAG
         tG7yNaGmPmhhZ19qg9YlG/gPRm5e3nBiZzmLTgybtOk/Bl3XerCQKHxJD9hxPF0qSVON
         T+3nGi921CFFNsvpc5P2zyQRnd7mvCgb9aX9YHO0wcInxs+hXgKcHlYCOMlLL2B3Aj8L
         SBmM+PrTpgdpRpM4N9ZPTfmQ21bQiXgw/+Vzo8Ry76crmlgQF/4GofqMavj7hrS3P3XZ
         dQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759135520; x=1759740320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzgdahQX7CpJGFCwerveyZDbQ9cci5T/X+7S64lDTAg=;
        b=mmDgcyE4Tw6XTki0Ify2J7pRHXFdlTg4Qv6f/yXna89+UAT/fZovBL+Rk0FPr0chVP
         +T+V+yN4Ydhi/oti0CuCikzQTQ8Hqj9tTn73P1i/2mamhurQzEumEnAaVGIO6BRQjPfl
         39gKNDZrPlJVg/nS5da1Kr+3j605WDKTOp3kSTfePpSRQF3YzBPFYrdK3gbG1TqfeaF4
         63bf9avuZ4kYDOQg0bVkruVb8wSqPL1pH8/s50zEoK8j5cpFzGy57X+Rui5l5BKg+kGY
         jB8HLlsFAV6pIR3RukNazxprjuXeNlgv4kUlkQqUJX0CPYeYFoCRYD76dNCxtInphDRC
         275g==
X-Forwarded-Encrypted: i=1; AJvYcCU/s+VN+fbw9Pe4N5VXX51RuAp7ojOn2iv0sMMt3+5t24mbBjExA+HkyKbZzaec0MAxjmzr0SM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu4+zt4mhQnBHyXuXRjbhMOfLyjR3xRFS+R8ehd6HukQAj3Tk1
	wNDOlmMhfdePKTKTpNW9gdmxp9AaTqJ3OYbkX8+YYRf7C0rVIY1Si2qbMQirdypzOTw=
X-Gm-Gg: ASbGnctGgm0YoG1P6z/L4s5k6RQD6N2UrBWMvTL4Jjn3zKllQBCU8udX+WddmhE3mFC
	tfvYr4JDKlqU6QkgScJCIrcUT2MgONizFatVgQ7yxpiVXwIXLlhRhfdQ+BFHSZ3WYNtMr13MXGG
	EUCFAaZmtWmaf5Suiqjqu721yuy4V+LiK+mWpc/av5nr94RRXUH2OkIzv2Xff/szDl5bHojyNX2
	WYd3YdqTGgvEqd5iN3kbvS4N562ODe1iMvxV6kDN6KgvXuUHEpmCIj3P+6Sth28Dth065A3/iDf
	TsUu1pynOWOyZa9hWIXOLNDP54c2zoeWV0aJbH3cbjUMe8NegaadagDLatvGpC6DY3oJw8WVeOi
	rL2LDN8M/t+1eae9dX6ZVGagaZWDAWPYIM3iXdkrrU9/oBvzs5mV8T2Iu3M99nXKScfTLt/NYI6
	PxSQ==
X-Google-Smtp-Source: AGHT+IEv4AziFZ1Nh8lMEPO0Ww5j1EhMHxyQUOxBTv+gGU/fjEeiR6fpWcDmVWpjseN1umlDr3eTdA==
X-Received: by 2002:a17:907:7b9e:b0:b04:6546:347e with SMTP id a640c23a62f3a-b34baf43cd6mr1653315966b.51.1759135520413;
        Mon, 29 Sep 2025 01:45:20 -0700 (PDT)
Received: from ?IPV6:2001:a61:13a1:1:4136:3ce:cdaa:75d2? ([2001:a61:13a1:1:4136:3ce:cdaa:75d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a98300sm862948966b.106.2025.09.29.01.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 01:45:20 -0700 (PDT)
Message-ID: <c9e14156-6b98-4eda-8b31-154f89030244@suse.com>
Date: Mon, 29 Sep 2025 10:45:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: usb: support quirks in usbnet
To: yicongsrfy@163.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: marcan@marcan.st, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, yicong@kylinos.cn
References: <20250928014631.2832243-1-yicongsrfy@163.com>
 <20250928014631.2832243-2-yicongsrfy@163.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250928014631.2832243-2-yicongsrfy@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 28.09.25 03:46, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> Some vendors' USB network interface controllers (NICs) may be compatible
> with multiple drivers.
And here is the basic problem. This issue is not an issue specific to
usbnet. It arises everywhere we have a specific and a general
driver. Hence it ought to be solved in generic way in usbcore.

Nor can we do this with a simple list of devices, as we cannot
assume that the more specific driver is compiled in all systems.
An unconditional quirk is acceptable _only_ if usbnet would
not work.

Please get in contact with the core USB developers. The problem
needs to be solved, but this is not a solution.

	Regards
		Oliver

Nacked-by: Oliver Neukum <oneukum@suse.com>


