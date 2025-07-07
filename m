Return-Path: <netdev+bounces-204609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E71AFB75D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAEE11AA41A2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E722E3394;
	Mon,  7 Jul 2025 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="j1pWe0rB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80DC2E336D
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902162; cv=none; b=LdAqRf4cDGffXtW1XSaHRH+l4eO1eDPnLI+i4Grhwby3CD+V+UN2FJUscQIXglhEadg6U7INXKL/6AJ32JHWfnA+MH4g484Gry8spKPE+W4CXl5ljgvAzJMdOj4PJL8saMDYCL7AJ7hHmfHz3h+DneqWnoxc68nHmEWlF/82EZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902162; c=relaxed/simple;
	bh=m8H0ULdbJ8jHkYqq+C6UljYy5F/UGJU2zP+ye3MpbBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZinrDA5naROhvXzEGbRrRueR7nQe4JBwavOY9EFWo0FRv6tPfjvEh7hRy2Y921Nwpb3vR9XXwjJJZRnYt40ewobktPKfb/qlsOweXX/XDPK+oiQawoug8Hd1lQdEtS+HqTx8To+29BRXCHO3ODjlyFC5R3pAQMfOc+8Vi1H4LEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=j1pWe0rB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453442d3a15so1095095e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1751902159; x=1752506959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EMFHU+dA97rkmxgkbzmBDm7ndl2Ec9MUhuSaGtPZEAY=;
        b=j1pWe0rB2Ls62jHLW4290O2U8bPSJ5tZFV3W6nV+LsTNP7i2ytUKfLB32QVw2oKpLP
         9dsZ0cNKDHXl+d3U1tVSaiXTkE0H67cOzfNS95LqI3ytR1RgDBPjlEdQ/yT7AJrqiSRt
         2fSWo7m1r+wNY56QZMK1ULuzVmmVupE6JKwJGn59jZ4bRRhz9BHR6oThiCGo1uLaaUrH
         pZbW9pGH/hzGdswZ5Eo8Xw2+0RjaORE4dh7bEW2ELss6J35+m9Zt9jjtdWafpHmgmWNn
         I7y4JEYSLEUW2DsoQPh3cu1n+liH5BhM9jTbXMP8M7uOzr7xvVEFyQOtzSzcFD0QYlGb
         5vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902159; x=1752506959;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMFHU+dA97rkmxgkbzmBDm7ndl2Ec9MUhuSaGtPZEAY=;
        b=YHKlcHRooIv7gJuBBiGf3XeNyil3qFx1vtil5sLZ9h751YSMH0w7VQYiYIZYtykoWW
         5tj2df0zVdlBad1XvtQdRnGXy/Y2Wu1Eb/q17XL06T6Z/nYCIUYZ2bAOLLa4gh9fZnrM
         sUJuxTcYbuLHOXQ7ICH2Nl6PnZBm5zxjtfPVQk3zUfeq2m5eve/RH5EHaa/JzaFMdVBJ
         MEzosJg3TzCQaA+pfgdKNyFmiU8RRXgxDCce7MroZABciCjg+P2NBC4tie9h5FwmKIvf
         OJX8+GJxCH4OQ5uNWBWm/XLUq320YcMrwHDd0lcm+n/fYbQ/2Oa1WRlW13rcC+keG/nD
         mO1g==
X-Gm-Message-State: AOJu0Yxz4n/iCkNAVzwPE3iIui+krdiHfF/FRoEQmM+7O252494URNyg
	0yV/xj7WO3CqCgn5h1ucDwmDVgftyAsBQYuXG0O3cj/FsUbB2r485Fv3SzO4lNHSK/ZdBgxQUlR
	1o2SdWTQ=
X-Gm-Gg: ASbGncuRCS1Ri3mbe22h2kqg0zokCKYI6JPUpLQ9wUchhFVC8w+CYLvnMKWn0Jmf38b
	qnNrRBkLutTyjsNilu7JZea6nGF3ZQ5fbO313dMqgSLC+JYQMH8bYJ0MgMrn783b+VlpZKF6j/0
	rQ3fWMrU4FgD3UwjbZty36EnEjmYDbbKmPKqZZfFqJwmVwXRDZzZaoc9xi1PJ0RlGn6C0PxbWW5
	CGApu5RBkf5p3GKV+qzVm54pK3MZ30kdlWsQn8s4n0gBCtmsWKCmRE1Xz6xY2LXkSKJIN6Rg/s6
	b6IbHELjNtFkXE62kqnPLwSO7PkUd/1U9Oj7+LpUSzkYHApSvT+FNAac/oDeYqJvErvZynamkrS
	4HYZ6rx1fehiEuCJbd+WcDKrLYU79c8Iqj+M4y1I=
X-Google-Smtp-Source: AGHT+IGKebV8E4EnA7t55PON6APQeMax4Qk+HjyzcFLok9rczjr1cjwmPmWX20487WziMMXLlS4ZLA==
X-Received: by 2002:a05:600c:64ce:b0:453:8ab4:1b50 with SMTP id 5b1f17b1804b1-454b3096aefmr39191445e9.3.1751902159060;
        Mon, 07 Jul 2025 08:29:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:bfd2:635a:f707:acde? ([2a01:e0a:b41:c160:bfd2:635a:f707:acde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a99693fesm145125845e9.7.2025.07.07.08.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 08:29:18 -0700 (PDT)
Message-ID: <00783d46-96a4-4653-a09f-4bed48fb2cee@6wind.com>
Date: Mon, 7 Jul 2025 17:29:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v5] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
To: Gabriel Goller <g.goller@proxmox.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250707094307.223975-1-g.goller@proxmox.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250707094307.223975-1-g.goller@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 07/07/2025 à 11:43, Gabriel Goller a écrit :
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
> Introduce a new sysctl flag `force_forwarding`, which can be set on every
> interface. The ip6_forwarding function will then check if the global
> forwarding flag OR the force_forwarding flag is active and forward the
> packet.
> 
> To preserver backwards-compatibility reset the flag (on all interfaces)
> to 0 if the net.ipv6.conf.all.forwarding flag is set to 0.
> 
> Add a short selftest that checks if a packet gets forwarded with and
> without `force_forwarding`.
> 
> [0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> 
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

