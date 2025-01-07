Return-Path: <netdev+bounces-155741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66066A03861
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 08:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CECF37A2391
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5E91DFE38;
	Tue,  7 Jan 2025 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI7slvyT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9731DED45
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233613; cv=none; b=B/81ukVXLaBNqCRkb54EbLHLth7HY1MCGBa1NQGkEsHv2cj8EvFXssTz88q65ZxW14/CHFUG2HdrStEa5+zY0J4x3inTVpcevcBi/DQsovyWA3VO5Z+vnGUAJ8H00697SbcoJSKWtCqKLscv1BWJ0bVwL5UEuOvZiiXlYiLbDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233613; c=relaxed/simple;
	bh=GtfQIbvO49GcETEFYIN0xryMxvlwxXA/CiUe4nMiLkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oG1/dQbpsCgSLyQGB8ARpasvI83h4KnEZVrw362FeMy/gg5iAzTIn1ZaYf3wTVw2IWdGtBe3qpDJwSmIC8WowUT40NXOw80UdK2p8XB3YfvV8GUXftgHbRXETRqRNIHghtM5yDox2PT0PKoeii0S/RrWPoMs+S5lxkGnKZt6Q94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dI7slvyT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso2125190366b.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 23:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736233610; x=1736838410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uwn6UZODwYrDf0Fve9lZCKc65thxDgHo8jjFX79RDhI=;
        b=dI7slvyTx5yJKD48mk8unTygJ+CJwE4ROm82BoWiO39LXISDzwoWmCsoUxGZqh3mOS
         aHHZvdbOrvWvgV7cmmrGc8xRzcZ/xaJ58MsLqUqMeQDYmfmrd/EvV4kYsh5VWSNtqn8r
         EwTIAzSpHK5X5F1JyzlmSjHNonzUIZSc12SuNIRu+DE/engLHreCVOfyxzGbp+sxQz9D
         4lPPYTZCoP4A31nuqXassIgc5tf6n5a7l/JovYb9xaNnHarZppSfYxthUQAaAzmmjdeh
         KhENgdNnU5ZfauJ095qkJ8dYkvUi3Z5YGnxzWbx44FdslGWqtUIB76ZNDEKAwT76CgAs
         4pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736233610; x=1736838410;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uwn6UZODwYrDf0Fve9lZCKc65thxDgHo8jjFX79RDhI=;
        b=PnzkBbrMfukdxtcTSDbLPD1+jIAYDHk6Fr6qe20s5KBdCwcCmfHu5ITvMdn4Ic92Bi
         SIclZcv+BCTSulxS+flf0Vc6Xhdz01yw9clDiP2nTbk7LopBZ4DlEbRBsnMu29wfYiy1
         z6akMbjAcYuflc8hQyGKITobqNpo2i1IEniocy3a38boQf7vDRAaRgFG63JIdD6+cUDB
         sClVx+q63Gx7cWB/qyJRm2RJq1SCd8QwwcsVUUNAkiQdzBOHJXPt1272KvSrUSVTj018
         LiMdd4R1ViW9hFf7TT9kYKHfdt3i59hxyxhY6jDd7sBocC+dvQ87j6Ccr4jd27ukE3KE
         RCFg==
X-Forwarded-Encrypted: i=1; AJvYcCXiVMAPGW7Vkx7+COgENkVj5Ejvciixibsof2hLT7YR3bLEg6FERnh93WA90nfJu+NELdhkKZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLhD/aBJT4ew/ogsERAyvpU4Y8dgKRyD9y+VLdrj87THgB9+v
	LghbSjNoVaI5MPLLoYXd/tkkOJJoJNQzDtfsN3DAhgzDCbkS7u7H
X-Gm-Gg: ASbGncuTqKy39eoWddCLZUsBKCNoy4bC9682WwllvBALqes7+FvE20W6RPbDPsb/UnB
	BgdcFax4Y1RWXpUQQjaqlNiT79hQCqLWGotYnoCJ/HEni9YPCjpvRR75PSOyQSGmvbyU1nB0VkG
	B/9INj1CDlcaqeVZswZx3756JqlBryPzZcWvGjSvrfSlLPywjYAP8d3z1ekOfdKAyNpe3Wc8pug
	HJ21GBBN/+SRXMJOIBAZoUinsbBIAdTalUtHhm/TV4AOjitJrwOSjt8nfFwg1d2cKipzLp+NJ9/
	gzOg19+E6lT+kMTzUEbmFkAVIylFUjfkhbQvK1Z5bDPciCtve+xeGn8C50Cks/zye+zlWZxpsRs
	sJF1wNlgUXwRbQSN6AQ+DaH7slf4QWmJKfq5OVulYQzMhSA4w
X-Google-Smtp-Source: AGHT+IHWsE5i++b3gV2jSghm9nOZtS0NS2G/FZMr3ho3ZYQke+9+VgoNl5TtB8L37VHzieKri7Sh5A==
X-Received: by 2002:a05:6402:2693:b0:5d6:688d:b683 with SMTP id 4fb4d7f45d1cf-5d81dd9c716mr137684881a12.9.1736233610124;
        Mon, 06 Jan 2025 23:06:50 -0800 (PST)
Received: from ?IPV6:2a02:3100:a00f:1000:151b:257e:13b5:4e14? (dynamic-2a02-3100-a00f-1000-151b-257e-13b5-4e14.310.pool.telefonica.de. [2a02:3100:a00f:1000:151b:257e:13b5:4e14])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aae9c3eb987sm2093825066b.110.2025.01.06.23.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 23:06:49 -0800 (PST)
Message-ID: <d78ee41f-ca6c-4dd9-8266-c55993ca1313@gmail.com>
Date: Tue, 7 Jan 2025 08:06:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] r8169: add support for reading over-temp
 threshold
To: Andrew Lunn <andrew@lunn.ch>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
 <f3e07026-8219-4b36-b230-7f7ddd71c7ab@gmail.com>
 <4535017c-10a8-47e8-8a8e-67c5db62bb16@lunn.ch>
 <088501b8-1c55-4d20-95b3-ed635865b470@gmail.com>
 <b040f19f-2c26-412e-b074-238e284573aa@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <b040f19f-2c26-412e-b074-238e284573aa@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.01.2025 00:16, Andrew Lunn wrote:
>>> Does it reduce the speed in the same way as downshift? Can the user
>>> tell it has happened, other than networking is slower?
>>>
>> It internally disables 2.5G/5G advertisement and triggers an autoneg.
>> So you get the usual message on console/dmesg indicating the new speed.
>> This internal action sets a register bit, and it can also trigger an interrupt.
>> So it should be possible to check in the link_change_notify() callback
>> whether an over-temp event occurred. The silent change of the advertisement
>> may also result in the phylib-cached advertisement being out-of-sync.
>> So we would have to re-sync it. But I didn't fully test this yet.
>>
>> This patch only allows to read the over-temp threshold set as power-on default
>> or by the boot loader. It doesn't change the existing behavior.
> 
> Thanks for the details. So it does seem to be different to downshift,
> where generally advertised link modes in the registers is not changed,
> and the speed indicated in BMSR generally does not indicate the
> downshifted speed, you need vendor registers to get the actual
> speed. But downshift happens at link up, not latter when the device
> starts to overheat.
> 
> Does it restore advertisement to 2.5G/5G when it cools down? There is
> an interesting policy decision here. Do you want 1s downtime very so
> often as it speeds up and slows down, or should it keep at the slower
> speed until the user kicks it back up to the higher speed?
> 
I will do more testing and provide an update.

> 	Andrew
> 
Heiner

