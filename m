Return-Path: <netdev+bounces-204227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7725AF9A33
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 19:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FBE7B5437
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CDE2DAFB2;
	Fri,  4 Jul 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="YsIQHX6P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A132D8374
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651810; cv=none; b=eOnv3pvU+N7+FuMC8ZEWSdehQmroTu7aXheU65vPVEqsmrsXmUFsywt5cKiCA4QoIV1GYPjRGyk0hrsQHKIP4Rn+Aa/0NpDTP8Dbp3NBE74ZVv5nwbcxbhySjJqyuSMsZBqDZHjKtdJSbnjz+WHrrQR/Vbmb2FQ+Hv7oavPxk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651810; c=relaxed/simple;
	bh=RKPVMYwlIXXGLv5KkIATm3Cf3vqnlU/H4tKoDr3YVqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EP1w9LqTEEvHzK5XWNYScPH4aBPH57/lQm/E2ZEca++tLY20fmO40m2t4XMALW7ZQhu/MPP8tcsdMHrstvsgafX+9/O5oZkrLBv6a48F/nwHzXcOfpY3gyAkNQ7cuknoxPw2noi1aFS0899uI4Hm6OskqSfW7ezXTpw+PFAZbJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=YsIQHX6P; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso2188026a12.2
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1751651807; x=1752256607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6n6hbn9caysKhPeEP/I9KvzM0cAThA7k26sM9u1aLk=;
        b=YsIQHX6PVONxqknKgVzzeHXo7oId/leAKFmgWGgk9dmiz+ckS2b2Fj+aodXZbT0R5S
         CNcqlcTw4bFBbelcJWTZLc/7EQ6tRBc9kO+1dlLz2B3gs30pFrzCmifN0DHpppyQuGpB
         91wwZ2Y2gnlvsk+EaF/I18Z7bM13K+5GfD8gCK96vPvEVm8WST60RsXCd1ErYIGdyVLA
         Qqeexa4HnURjwfYWxAENs2sVbK1WYmO/2KVNbY4RmBbIDnBjhAi0O/EVF2wGk4bZnp0j
         mdrjPLkoD5EmjmEUmAdOjPz1YqtU1p4ENJ9rAX9m7hTIrfB7B1EGejcPtoabehQqH3+U
         Msbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751651807; x=1752256607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6n6hbn9caysKhPeEP/I9KvzM0cAThA7k26sM9u1aLk=;
        b=e2AatJ7bGNMUzK+tYzVmX5NzzbqX1Ux2RXPTsLlZ4wXIRYNTaGFFZQJi/ggnr9K2xQ
         OHmi/Tw4Kj1/KopcC/jqTNCprlPYA2tzT+H4YjVIqd3ZgNW1/0W460zcFgAebU2q0FHl
         We/XWL6vvVLF4QPK161kl6fLx0UwpPDp6yDts7ZVLlEP0Ly8DLh90VUuhsQzlHGQgvIB
         RJbuUwkVOS9XZaeKyhIS/ybQzmXU+VSY0UVrvYO8nV5zFLmm6d1ioaZ5wt/OHUQlfarm
         78LuUdie9Rn7Apa/c6bF465EUO/KUhAWVil+dpOy3mzLaTl90aXKg8o98MYq5UVmxVbT
         RTxA==
X-Forwarded-Encrypted: i=1; AJvYcCUQRTYQBugXGC7wkEizTCgMOhHtRITiD80mC5UtYSFoRXuqlzKLw97bzBoT2EIdLbGb+SB+C7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YycUXgAoN8g49JVwvNWRziqPRocV5QYcXKpRktj4dU2P+kopHl5
	5L6EVflOVQg0ws6GwkfdnVRPGxq2GMpfSQrXUsSh9Q1fmYUaYXzFvLQ+uHgspNtquAw=
X-Gm-Gg: ASbGnctCfNcul/OhpeB9/gvmttT7mx16XH8VawMdXLtbN83IdxJYOQiEI0a3L0t5kyL
	EuLd0Z9fFA9/JxajZtg3xFJ7PGKp78lspt4piYKXuKrModu4uXLona/jqFHsVWLX/pQkAdskX7x
	0c9nbmEFAgZYaimc/rAhYm1N6JOezpnThzglaOMh5VMHSusC8K8nF5MhXe0zlaqQhW5XQCAYhHB
	wX1DB9S2lmvpNeosh3hrf8wke5zQy3O3wm4bGZtgDnRxnzeYARc09VRwGfeQYVq2miqZZP07VYv
	EmTMMEjh7dAzWoPSPsRiymuDj7pyd7MP1HNUA6X2CM3wyJdn7J17rtIHIr9ltv0q/TcRzFpySLi
	vJx1Qa5en1wezuJ8CVONfBN8=
X-Google-Smtp-Source: AGHT+IGoshS6MZusfjRaRJaVsMhxqzjeYCxj2P6UK+ArpuRluCl7/5NTB3tt7deN/8EfRsinNgpEIg==
X-Received: by 2002:a05:6402:3591:b0:607:5987:5ba1 with SMTP id 4fb4d7f45d1cf-60fd3370b41mr3071724a12.20.1751651806823;
        Fri, 04 Jul 2025 10:56:46 -0700 (PDT)
Received: from ?IPV6:2a02:810a:b98:a000::f225? ([2a02:810a:b98:a000::f225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca696ec5sm1648446a12.25.2025.07.04.10.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 10:56:46 -0700 (PDT)
Message-ID: <79dca2df-1126-4d94-bab9-761a982090b6@cogentembedded.com>
Date: Fri, 4 Jul 2025 19:56:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net: renesas: rswitch: R-Car S4 add HW offloading for
 layer 2 switching
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michael Dege <michael.dege@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-add_l2_switching-v1-0-ff882aacb258@renesas.com>
 <4310ae08-983a-49bb-b9fe-4292ca1c6ace@lunn.ch>
 <79a57427-fd4a-4b9a-a081-cf09b649a20e@cogentembedded.com>
 <27047e61-8307-472d-96dd-1e5b89dc427f@lunn.ch>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <27047e61-8307-472d-96dd-1e5b89dc427f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



04.07.2025 19:53, Andrew Lunn wrote:
> On Fri, Jul 04, 2025 at 11:05:14AM +0200, Nikita Yushchenko wrote:
>>> Looking at the code, it is not clear to me what would happen with:
>>>
>>> ip link add name br0 type bridge
>>> ip link set dev tsn0 master br0
>>> ip link set dev br0 up
>>> ip link set dev tsn0 up
>>> ip link add name br1 type bridge
>>> ip link set dev tsn1 master br1
>>> ip link set dev br1 up
>>> ip link set dev tsn1 up
>>
>> Per design, it shall enable hardware forwarding when two ports are in the same brdev.
> 
> So in this case, the hardware offload has been reserved by br0, but is
> in fact never used, since there is only one port in the bridge. If i
> was to then do
> 
> ip link set dev tsn2 master br1
> ip link set dev tsn2 up
> 
> br1 would not be offloaded, but done in software.

rswitch_update_offload_brdev() calculates which brdev to offload, and it only considers brdev having at 
least two rswitch ports. So in this case br1 shall get offloaded.

Nikita

