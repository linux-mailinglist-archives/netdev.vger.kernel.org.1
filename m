Return-Path: <netdev+bounces-258070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IFHESgdi2nSPwAAu9opvQ
	(envelope-from <netdev+bounces-258070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:57:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E17F911A798
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30E1530053FF
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54F7327BF6;
	Tue, 10 Feb 2026 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXV1y0a6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSyXo4fA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695DE314B6D
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724638; cv=none; b=Mbf7rb/e/EydP3yhcerbsDJ3/bl1y60ETGgAwN56sbtLQkVm59n9SiER6qs6AXPxsukXrYxCukLxSYiEuPbaGra28blIMAZgB8yu2GIXBoB8wyI8D7kFBV+DKBG1dkDfItI5+gD9ugkQ7QkjnjWPFnmSJoyY/Is4NpIg7zIrMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724638; c=relaxed/simple;
	bh=UhAXskVkg0AIPDRxYGMX4k6MVNHYWQm2hpDjwCRC0/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHnlfCXFL8jCv/VRmuoAoaI3d3IgkbXFSwfwnhCGjpzVr3xYjohh+JIoird+QLY7CpnB9qbZWd1PUZHct+eb4agOBO9ZsGw9GZUGif13D7uRTAlsuLboaoiE4BikdcTOPomeo1fB3KFvCdsQaB23jXkjO6r6wcn2PAkl0+9VHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXV1y0a6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSyXo4fA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/eaijsng0kyvJNwb0+SCg+kE9O/EnI5Cg5o58i4Yqg=;
	b=fXV1y0a62NKErBqUc0BdatZTSYY1rURUeApZYIe5U0PQuXegMyzUdEvgieAGxYW2abfMsN
	t3OQ5wXk7OiRUJg1+iFDw0QT25h+RomkhKjRPrgu8xysBdxVlqe/mZawdO/qdbpfuZRCzY
	tpa18fmR97tBYDGK7vP/t+pZLgkzY6s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-nYD2NCigMMKJHk1MjZPJrA-1; Tue, 10 Feb 2026 06:57:15 -0500
X-MC-Unique: nYD2NCigMMKJHk1MjZPJrA-1
X-Mimecast-MFC-AGG-ID: nYD2NCigMMKJHk1MjZPJrA_1770724634
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435ab907109so4082633f8f.3
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 03:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724634; x=1771329434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/eaijsng0kyvJNwb0+SCg+kE9O/EnI5Cg5o58i4Yqg=;
        b=TSyXo4fAd89nHo9AO/nyDmITmi5cc9ntm/EZyZNAc8bmiwBmoaJn1gE5fcB1XTSAKk
         YNNODVrjsnYv/4O0E657zaWLFWNmSU0PiuRmPNhgQ5rqt68SeytE/DAQSLBZPkrjPx/H
         NQkltQPhzT/hzmVJgm2ZxtHeqlpnOTVKEw3oi3onwreXxgTytDBl5kJZvT3SoAnQjuUP
         Yejj1xk8cnOSlGYDyhNpDsTNpYepNtsCAMSkJv+XB6GmiX5Ke6MeeaxmVY/99kH1H8Z8
         xKjm/nKyY3nVV16Z30/m7H5XYD0eSnvmGzTpViMKIrPlgzDwFmFr++39BgAVXbyCdsnB
         J/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724634; x=1771329434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/eaijsng0kyvJNwb0+SCg+kE9O/EnI5Cg5o58i4Yqg=;
        b=kw24Fd1kbbzT8O4Zy+l1h54ndpgHZSmz68jXLSteafNOeOxic7qgGyOlo83HJlUbkm
         HmbZUCWTyP291JIGX7ioNJuU/7Twxjl1jX9uZOwnTVuJzKrTBVqUj2Nw6qNe8GQIkNpL
         KURd6WTBdaXlM/rHhuTr0iQGmmkGlzmO94yYj+s6+uUjePHugKtkt0ejMpSK5bcziHj7
         CjEkqQO1dR9a9NeAnS9gn/esnB2i5cHk0Erhfpx+YqtCDRkvSY6LD7bbzZ4glLPuyZqa
         JW6WSmw/doSO9y9K0syuzHWS+3BWM5gab8cNt0oejcQ/K8KT4VzJj08hWTrMjUI8giYU
         9lOg==
X-Forwarded-Encrypted: i=1; AJvYcCUVlvO14cZdMnd4QVLtj2zgE728Ozq22EGJYdR97PZhDjMW1DCvQjbTq8KaAoUC0JeFIvyRZNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+SgfMChkGrdR65m8Xx3/2VuLqDw32lP6ABpGH1Dj2zEpy9YM
	IG/kAwJpK3lL9QWswN/8sVpfFZe+Gyt+j0NTVmFk8E7fll+i8qDj/LPuwp6+T1XMQ4cW4j3ZARh
	U+VUlaxFYN2XefIST70oEn/TLzFt+upu7RwgjjeV8ht8xVOu5hBb9lrcnKLW/RGKibg==
X-Gm-Gg: AZuq6aJnnY0b3lDdfPNcfAJZH3ytRLXualLSt8cg2YkV1HGUf3JiUX7GW3FmT9kKOHy
	Q4IxnABfUTS3yUN6hjN28+wYBjp5dKx+UbrQK3k4onH08hy+XMcdh7AGfGR2dcS4btIBreESHNo
	IvX6R7H4RJhY1Q2iac0Xr2SQfyW6M/lYMP8625uQoir4hVl8JVCCov8ziwiIXoXb2c9WvahjA6u
	E2lj6tK4dWzwwQllo29Lh8+csmEzxTQDQe4gCUdPbL8j3eXRUkkArMFsiRwZCVV5nNIAwQR6/X2
	Dr9wVrH2rfAH0J//gOBA6oAk/4d+8ZXj1OZSd5b73MhJK8QUenbbH/sisWegJM6a01TK1Z36g7J
	fbJ0CJKDXrsRTTMf7apISMFY=
X-Received: by 2002:a05:6000:200e:b0:435:aecf:9674 with SMTP id ffacd0b85a97d-43629691c17mr19796743f8f.55.1770724633881;
        Tue, 10 Feb 2026 03:57:13 -0800 (PST)
X-Received: by 2002:a05:6000:200e:b0:435:aecf:9674 with SMTP id ffacd0b85a97d-43629691c17mr19796712f8f.55.1770724633435;
        Tue, 10 Feb 2026 03:57:13 -0800 (PST)
Received: from [192.168.88.32] ([150.228.25.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4375087753bsm19281930f8f.24.2026.02.10.03.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 03:57:13 -0800 (PST)
Message-ID: <8545d888-5b66-421e-b755-9cfe39c8a98a@redhat.com>
Date: Tue, 10 Feb 2026 12:57:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sunhme: Fix sbus regression
To: Sean Anderson <seanga2@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Rebe?=
 <rene@exactco.de>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Cc: andrew+netdev@lunn.ch, netdev@vger.kernel.org
References: <20260205.170959.89574674688839340.rene@exactco.de>
 <cc269d9f-9a06-6623-e412-d04ecb7b4f74@gmail.com>
 <20260206.100514.85172532893288505.rene@exactco.de>
 <8d2fdbf6-abec-218e-1d07-fb08fb0772fe@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <8d2fdbf6-abec-218e-1d07-fb08fb0772fe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,exactco.de,davemloft.net,gaisler.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258070-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_PROHIBIT(0.00)[0.0.0.2:email];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1f:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,exactco.de:email]
X-Rspamd-Queue-Id: E17F911A798
X-Rspamd-Action: no action

On 2/6/26 3:49 PM, Sean Anderson wrote:
> On 2/6/26 04:05, René Rebe wrote:
>> On Thu, 5 Feb 2026 20:41:11 -0500, Sean Anderson <seanga2@gmail.com> wrote:
>>
>>> On 2/5/26 11:09, René Rebe wrote:
>>>> Commit cc216e4b44ce ("net: sunhme: Switch SBUS to devres") changed
>>>> explicit sized of_ioremap with BMAC_REG_SIZEs to
>>>> devm_platform_ioremap_resource mapping all the resource. However,
>>>> this does not work on my Sun Ultra 2 with SBUS HMEs:
>>>> hme f0072f38: error -EBUSY: can't request region for resource [mem
>>>> 0x1ffe8c07000-0x1ffe8c0701f]
>>>> hme f0072f38: Cannot map TCVR registers.
>>>> hme f0072f38: probe with driver hme failed with error -16
>>>> hme f007ab44: error -EBUSY: can't request region for resource [mem
>>>> 0x1ff28c07000-0x1ff28c0701f]
>>>> hme f007ab44: Cannot map TCVR registers.
>>>> hme f007ab44: probe with driver hme failed with error -16
>>>> Turns out the open-firmware resources overlap, at least on this
>>>> machines and PROM version:
>>>> hexdump /proc/device-tree/sbus@1f,0/SUNW,hme@2,8c00000/reg:
>>>> 00 00 00 02 08 c0 00 00  00 00 01 08
>>>> 00 00 00 02 08 c0 20 00  00 00 20 00
>>>> 00 00 00 02 08 c0 40 00  00 00 20 00
>>>> 00 00 00 02 08 c0 60 00  00 00 20 00
>>>> 00 00 00 02 08 c0 70 00  00 00 00 20
>>>> And the driver previously explicitly mapped way smaller mmio regions:
>>>> /proc/iomem:
>>>> 1ff28c00000-1ff28c00107 : HME Global Regs
>>>> 1ff28c02000-1ff28c02033 : HME TX Regs
>>>> 1ff28c04000-1ff28c0401f : HME RX Regs
>>>> 1ff28c06000-1ff28c0635f : HME BIGMAC Regs
>>>> 1ff28c07000-1ff28c0701f : HME Tranceiver Regs
>>>> Quirk this specific issue by truncating the previous resource to not
>>>> overlap into the TCVR registers.
>>>> Fixes: cc216e4b44ce ("net: sunhme: Switch SBUS to devres")
>>>> Signed-off-by: René Rebe <rene@exactco.de>
>>>> ---
>>>> Tested on Sun Ultra 2 running T2/Linux.
>>>> Alternatively we could explicitly size all regions, or check overlap
>>>> in startup code (I also already have a patch for that, too).
>>>
>>> What does this look like?
>>
>> This only checks for "sorted" overlaps w/ the previous res, but given
>> they probably usually are and it catches this case, ...
>>
>> The downside is, it may break other devices, I only test booted this
>> on an Ultra 2 and Ultra 30. On the U2 it fixes the hme ethernet,
>> too. On the U30 it causes an eprom region to be truncated. I probably
>> should investiage that and test boot on all my SPARC systems before we
>> consider this. That's why I sent the trivial hme driver hotfix first.
>> Alternatively we could also overwrite all sbus res in the hme driver
>> with the previously used known good sizes. I can send a patch for
>> that, too if you like:
> 
> I'm not really familiar enough with SPARC to say whether this is reasonable
> or not. I've added the SPARC maintainers to CC so maybe they can comment.

FTR, I think we are better off applying this patch as quick fix and
eventually follow-up with the more complete/less trivial solution.

/P


