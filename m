Return-Path: <netdev+bounces-252782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI1LKPlRc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:48:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5207491F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D51E331F46B0
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AA53793CD;
	Fri, 23 Jan 2026 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqzHGOu8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138037AA6A
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769164974; cv=none; b=MxaOuXwQ1GcMk0H7e95II4v282QiwvKo3Cq0EEHeOgUvvS9RIEYdronxCByO+mTCh+2XvfQf7EMsqU1kzZVPX/hRsKeHcsfS6QzfYNlvvBKxpBJdD2JPEqsladx+oIMehXSiMerHH2P0eE1G6Zxn61wftf5fgt/IN6G+rulmpOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769164974; c=relaxed/simple;
	bh=qVVLNJ7YXu9WNPO4RkV73hHgmEFOPSz6GfdeQZ4051U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBV6RdRlSEdpaw+RD1FV0abCftf4iSo9WNIkTxho67x96+tnB5Dg0QxNdUqDuS01cPqRI+bA/7r4IjUDwvubiH7sHdZCnQWFIdcy6YX/EDAuMgyO0nFmPuiTMwslIfdsGZLPTqBXCu0aZDKU28FgbKmyql4C6WJnhTCOqX785V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqzHGOu8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so1575247b3a.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 02:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769164971; x=1769769771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/cJzMSeJBm/TCcIoSkUUB8qr/tXilSOEhL8O9TYXtqM=;
        b=UqzHGOu88FL4chPQ9P3cfZjx4p3OvTq7W0+YeMkIoAE1iNZACa+s5DLtaKtgVzde4K
         JgM+tSJxS0nYxGwJAyzlKxGdb78ZW2IjTFZPKU/ccQFj8129GelgiUSNhlDxTbg7z7/e
         zvdl5zPqVRxWD7RrxLZ555T7LR+/LilWe8VniOjR8XFFS5dx0crq9TYPB3Vqjjr/FKt6
         m5yoHqsjaiL0P88rr2S+trr9kSPF27aU3WLkV3KO7ZaqMtA9+KCYemzFNkcq5asXLpxR
         u8NyXBry4GaCN17EKzslng2qM5wjDCijclUGEt/ls+hypNt3IKQbLdzFOX1RYGEAUdzA
         JdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769164971; x=1769769771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cJzMSeJBm/TCcIoSkUUB8qr/tXilSOEhL8O9TYXtqM=;
        b=ok6Cy2bKn5g8pv3v7kcSgRIUE+I90rT1bqawrQM+jodLzyNfUaVJZcrICTBpn4RvpA
         Tq4HzkF7gqmltZklvqrSz9zxg10H61+QAXuYDiWG9g6z/lwm5zj3kXRWp0DUh9Jhpz8R
         U7Lp9ZFH761lzAB6DGwG7T/pTO+2aVl2EcXBl6tJvUdHDmP/QPlZKKp81ctPp3MyqoZJ
         /E2lqsyWKscCIOJe262fhg4tNdemucZ+EFBvcIcnwZ1f0FAKvnBMb3LxwNP/65AwEL/a
         R/7fXUIdyBC9/hiDtOdgCUqq4lWXKohFen3oVS8i6m4FFzNK9WlYdPlJzkkHMnBqHIKp
         eMzw==
X-Forwarded-Encrypted: i=1; AJvYcCUWxUcdKv2rBuNr6rlenuGzrRe43mh+Y1a8anrGtVRXjoJUNPhKYqYDgdIFHAuLPd4/HooVR9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2TyBSI0HrTPfERTz37uOc7ji9JPfkyK7eXNa/wRJ0kAvZADC
	8Nbsea2gGDZgTynkbNkwicpbOgNg6XxHKQuMIqwJolsisVWFj7prc7jV
X-Gm-Gg: AZuq6aLVxLMK28oan6hqjsyplsBiCtcLkFfm74CAut+jB+enn37EL0cpzZozHhTj+mC
	U404MkUIwnGYtcGRvDtyloZvWtp5+CgEvAekmhp2FQcP2cE4VlA1haIlCBAaczkLLpS74ZSkQ92
	6TIS3m+jGf5wg9MtOuHl8Unjd5l7W5l96OrU5EQxNTdU61J1FNRYXsqNhb39277wzZVo6tNL5Bt
	FTz3u/OojKRNGUC5KrJvQUjyeOmG4ef0OGjdJ3S4Wiq6sSghnLEGDBXrHQDNd/dKjp3u+mYoPv9
	PntbtzNSISFl3g6waMdd+W8gWm7B10h+v3jmffs6zmgjrOUiRfs+fDsg/0H6CHHHJZ7hrIJYW+i
	CQnvsKWx/iCQBXQeDmkXmYyjjB51V23NdcB9I7d7dO3TZt4ZAR/VnGoiMPy19ZQ7PNJg4c7FxJK
	iP/Hy3UGdppXwXbg==
X-Received: by 2002:a05:6a21:1507:b0:354:dcc0:8c0f with SMTP id adf61e73a8af0-38e6266c26bmr5654764637.12.1769164971008;
        Fri, 23 Jan 2026 02:42:51 -0800 (PST)
Received: from [192.168.1.131] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a141fc4sm1743148a12.8.2026.01.23.02.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 02:42:50 -0800 (PST)
Message-ID: <43923bf9-6202-4147-8eac-5bd7bb653fd4@gmail.com>
Date: Fri, 23 Jan 2026 02:47:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock sampling
 control
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
 <308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com>
 <59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.ch>
 <4e2a55e7.3662.19be8cb9c3c.Coremail.lizhi2@eswincomputing.com>
 <c5c0bfdb-316d-4796-afa0-f6f018ceb414@lunn.ch>
 <abf12a3f-9cdd-472d-a02e-af4da594b84f@gmail.com>
 <e6f7da45-3dec-4af6-a5b1-a72210bf24f4@kernel.org>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <e6f7da45-3dec-4af6-a5b1-a72210bf24f4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252782-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ganboing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C5207491F
X-Rspamd-Action: no action

Hi Krzysztof,

On 1/23/26 02:07, Krzysztof Kozlowski wrote:
> On 23/01/2026 08:39, Bo Gan wrote:
>>> I assume the address of the interface is fixed. So you can just key
>>> off that to distinguish the two instances.
>>>
>>> Since this is an internal property, not a board property, it is not
>>> clear it actually belongs on DT.
>>>
>>>       Andrew
>>
>> IMO, they should be in DT to provide maximum flexibility. The SoC .dtsi
> 
> This is not the purpose of DT. Please rather use arguments in terms of
> DT rules (see docs, presentations).
> 
Any examples? links? Thank you for your patience.

I'd say if the board .dts never overrides the eswin,rx-clk-invert, (E.g.,
the SoC .dtsi has rx-clk-invert, later the board /delete-property/'s it)
then yes, it can be treated as something inherent to the mac, and then
"use arguments in terms of DT rules". I was thinking about use cases like:
https://lore.kernel.org/all/20230714104521.18751-3-samin.guo@starfivetech.com/

> We really do not care about maximum flexibility.
> 
> Best regards,
> Krzysztof

Bo

