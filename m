Return-Path: <netdev+bounces-202313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1C4AED244
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 03:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A64957A408E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 01:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239D146D45;
	Mon, 30 Jun 2025 01:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="vMSIkeEA"
X-Original-To: netdev@vger.kernel.org
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF160A59
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751247880; cv=pass; b=GIrpFDydtekwwLIsY2aWyv2OaoHaywSujRffsLvWZ6CHCEdv5NzeapZPsZOmzI1C27YHI9zNKq4XFQjJHKvWeBZ4H56BuTo+yuCDMDNhUNbh9mlwzzP9+J/zmoOmRp6/kcQt7mgYY6ekXF7OGzu7SqkYKcuHmoFIhry5L6hrnOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751247880; c=relaxed/simple;
	bh=CyLCFRW+/VB5ttZnJ0vadGCQcPVkO1t0xVDLMFE+E6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHM6iMRWtRwuRT03scJX5Y29r+BWXpA51w7f5SrStiyuMGiKuWswfKI9vwmPMYzpi0ecPmtMak4dnbZDVwHtCShD7BBtFqLFmcBwyiQWIpFYhqgWKUJo1Pt4oACzuPcUSTULtUdbHgFAtbOEHJnZeaBIvwkyvsCZIYdV8ZshNAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=vMSIkeEA; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4bVpqm4glLz3cw1;
	Mon, 30 Jun 2025 01:44:36 +0000 (UTC)
	(envelope-from kevans@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4bVpqm0Md2z3nrK;
	Mon, 30 Jun 2025 01:44:36 +0000 (UTC)
	(envelope-from kevans@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1751247876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzJjEC/x9ioEfe3j2AbF1kKalwiBIgCk5VccCH1HORQ=;
	b=vMSIkeEACsxLlGFn1E7axuKtdoyoEn7ToBqhUBh9ngVpMNVyUAXIG/wYnoaTOBzv4YudXY
	gHwUyWOe+pnxJc2MDHY3yxRWe09mrJIyejoc/mQROhwEj8knvMrM0iPab6hsl+jkDtk23/
	iyu94A8rbUXRxZ0/14L4YWrIVCipE/kK6q4Itj07q4KBKbnZ8j4hVcrIun5YL7ZaDPjrDS
	6NI3GAAcvKnFOJMnsfB1Mm8cXrnlA7j7uUwy2YyGKY3wREGbAUV2hlcmYtcVK9cVZUZZ9V
	0lQw2DRiuXKlm8CabGJm6nduyb67jVPewEOJ95pfKyYDMp+dPt+PkydWyh2EmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1751247876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzJjEC/x9ioEfe3j2AbF1kKalwiBIgCk5VccCH1HORQ=;
	b=yeBM1T2ul5bcm7s38ZckeQpDZfzZacsZYExD9u8s1+34Gfw7e58QnimldcDTbgXUdZEUHk
	B727uO+j89lOdPKmqNJvX0VmTiezxYuaMRVTRz+j882DwuTUajdJhRrquwYC1K+ypbbYyh
	I45sCy65CP7RUJXsTMpP96d3zs0368dN7Dzj9+Lfw/TJSUIKEtRpjWYR3WkIarkWFdYBQZ
	OW7VeJHCarAg1s1kzCuqbsSMSefptNEnzohy07NmRwImtwtjFpqtM+GEFkX2xUpT4/QCcv
	dWJj/M7Kvt1c6VOXIpLv6eBDtgYnfSFMo241JN7eOnT3c+y6+X9GqFYz8vQDoQ==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1751247876; a=rsa-sha256; cv=none;
	b=peXUm/vLfKeaYpDGcWQf5MDqZOiqGkAaR5eMX5QM13YyoQn5wWmr5oKMFHnhDqFBrOMUZH
	opa/ck+lk+ul6459GlsQ8tk3VYo/tmzTl9HhK6f0Iz0NQl63ZxMKHBZOjHpVLVv+cZF98B
	bgwS9IMSrw/AAvyzhcfPlpbz3V4ee1fLNqcj4b4J6n/G7t+FjabZgRTOSF0Jh0Eeb0IOaL
	AyAu9WZztdym1w9FBPj4BB+OdtzUCAQoz4wNKHt+PGzo+X80RcdP6Q20iMGgaNSJgASUO+
	yTm4hdIQC/dxeYJkgrmoKE8VNV/z7X4nGOhVEvOzWuzIr28z9HFm/EEsJ+lJlg==
Received: from [10.9.4.95] (unknown [209.182.120.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: kevans/mail)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4bVpql2clgzBD3;
	Mon, 30 Jun 2025 01:44:35 +0000 (UTC)
	(envelope-from kevans@FreeBSD.org)
Message-ID: <2d9b26c6-2512-4031-bce5-afacfdb780c2@FreeBSD.org>
Date: Sun, 29 Jun 2025 20:44:33 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1 wireguard-tools] ipc: linux: Support incremental
 allowed ips updates
To: Jordan Rife <jordan@jrife.io>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20250517192955.594735-1-jordan@jrife.io>
 <aCzirk7xt3K-5_ql@zx2c4.com> <aCzvxmD5eHRTIoAF@zx2c4.com>
 <vq4hbaffjqdgdvzszf5j56mikssy2v2qtqn2s5vxap3q5gi4kz@ydrbhsdfeocr>
 <CAHmME9rbRpNZ1pP-y_=EzPxRMqBbPobjpBazec+swr+2wwDCWg@mail.gmail.com>
 <d309fd3a-daf1-4fd5-98aa-2920f50146fd@FreeBSD.org>
 <hxqd4mhg6wir7oaatgtdshimtzdwkhlhdje2xet7mcj25g7zzt@jyhmin2ovram>
Content-Language: en-US
From: Kyle Evans <kevans@FreeBSD.org>
In-Reply-To: <hxqd4mhg6wir7oaatgtdshimtzdwkhlhdje2xet7mcj25g7zzt@jyhmin2ovram>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/28/25 11:05, Jordan Rife wrote:
> On Wed, Jun 25, 2025 at 10:37:55PM -0500, Kyle Evans wrote:
>> On 5/21/25 18:51, Jason A. Donenfeld wrote:
>>> On Thu, May 22, 2025 at 1:02 AM Jordan Rife <jordan@jrife.io> wrote:
>>>>>> Merged here:
>>>>>> https://git.zx2c4.com/wireguard-tools/commit/?id=0788f90810efde88cfa07ed96e7eca77c7f2eedd
>>>>>>
>>>>>> With a followup here:
>>>>>> https://git.zx2c4.com/wireguard-tools/commit/?id=dce8ac6e2fa30f8b07e84859f244f81b3c6b2353
>>>>>
>>>>> Also,
>>>>> https://git.zx2c4.com/wireguard-go/commit/?id=256bcbd70d5b4eaae2a9f21a9889498c0f89041c
>>>>
>>>> Nice, cool to see this extended to wireguard-go as well. As a follow up,
>>>> I was planning to also create a patch for golang.zx2c4.com/wireguard/wgctrl
>>>> so the feature can be used from there too.
>>>
>>> Wonderful, please do! Looking forward to merging that.
>>>
>>> There's already an open PR in FreeBSD too.
>>
>> FreeBSD support landed as of:
>>
>> https://cgit.freebsd.org/src/commit/?id=f6d9e22982a
>>
>> It will be available in FreeBSD 15.0 and probably 14.4 (to be released next
>> year) as well.  I have pushed a branch, ke/fbsd_aip, to the wireguard-tools
>> repository for your consideration.
>>
>> Aside: this is a really neat feature.
>>
>> Thanks!
>>
>> Kyle Evans
> 
> That's great news. It's nice to see this feature percolating through
> the WireGuard ecosystem.
> 
> I was working on adding support for direct IP removal to wgctrl-go too,
> a Go library for controlling WireGuard devices:
> 
> https://github.com/WireGuard/wgctrl-go/pull/156
 >

Ah, neat!

> While I'm at it, I'll try to add native support for IP removal on
> FreeBSD if I can get a dev build working with the latest and greatest
> ( I am a FreeBSD noob :) ).
> 
Feel free to shoot me an e-mail off-list if you need any assistance 
there, more than happy to lend a hand for the cause.

Thanks,

Kyle Evans

