Return-Path: <netdev+bounces-85886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E0089CBF8
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 20:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BB61F28CB4
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A11428F3;
	Mon,  8 Apr 2024 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLq8I/t1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8885B04F
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602163; cv=none; b=nSQk1TxxVbCa9u+rgcjsjBsqUZo7NLO9TLMzvHxcwQwjbX+ngSqqxfQklYFq5Nd8y7BCdT4C5v35msYFaf0nV0TE7WQ2oXdEJYyTxr3WuOjcE1o0LOsKq7zvxUmD5MGfkf2hXS6TPKr/g9Hj2EYNS+BNTHit3pSytQa4OUHtidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602163; c=relaxed/simple;
	bh=Yf0j7QmpvmnN2ug2gLephb6KmJItDOoY+whQ/jf5e2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hSR0XsLEump0keSb4ynfwdM2YijkPlrIJXihjLSToyQYJmVnSrscUz2e3UwtE5w1MBdmSU3ky5sUKNGle5tbYXSBdMIbNkvIh5H5PiSst02fgCIO7oxuupDd9yw023WJ+nKpanAa71ZSdhR58/BWqD8mZr6NCJDxRu9rd93HQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLq8I/t1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51aac16b6eso191571766b.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712602160; x=1713206960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lZg16ulOOFP5JM1C31ZlEDfpKsS7Mn/OdF4Zz8oBUAI=;
        b=BLq8I/t1WP6A0b0hjJ1YnKIrBDfLtezs5xTkd9t9jTKNHOn0srHgjBmd9cTlVwjmE9
         MfdFDonX3T0nDDQ4nyFiHCuAEZA+lbdnv0vWPzEj3LFiiuiW5/yZ5+gSOM9ONnqju597
         UyyCufOTLvE6v+xx6fMaotTjohhP+HhyCE/pNaxOODQ3XrBYPzWYvaqKxhRMn6P6bkQZ
         QgV1rTTogqBgtt8mjAEOAEp/nwYFFfrX3k/GBcrSC18jMyK5Vr104GWiTzvpMWOcv8jU
         tZw67HJcvyhT5EH1PqBpfn0kpU4XTWalXdanBQYJcvfh/ko0w9l99UGzontZNmGhLq95
         QMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712602160; x=1713206960;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZg16ulOOFP5JM1C31ZlEDfpKsS7Mn/OdF4Zz8oBUAI=;
        b=n3nw/m3LGB7jtIqC7Tv55GYhyWC4CyN96CvqbNgLp7uK7fnm0OKyL/o/PSNB8AaqKl
         eDGGMq9RMmEoRU0Ezyv2QFXffbxqDEm5jR7WvBM2Jwj8CD23EnsjmGz3xDR1OYxMOlyZ
         UtwCvpvgFiG6mk8Z3b7MDcaP1rSjMo4Jh3XDqIZN4n0SankjjTcsLC8z9J1r9/hLI+9z
         a1MLQrljAhp2aTk2mWTGCUymSqQ7IXj/6zvROkdBsjX7p5bUss5p+YtXxVQl5fkyJpTt
         Gd3HBw1FzWz9TjFIHJ6OFb82XXRjbyFFyT+jlprRFhsRftNYLftojyQUwwG850w3Z0Ou
         AmIw==
X-Forwarded-Encrypted: i=1; AJvYcCUL50qo+dvdgjxG5rzPfjLBkZNXDBBFcQT9tCILBOCkS2vcD/nGZhRzt+iIuSFwfSbK52c1ZDGAJ3ieLpRD1IxkSolsNTNi
X-Gm-Message-State: AOJu0YxKogENlUQKcjsNGU/6wPteqLx/JWqTM26DfjONpDKujXyqPBi7
	ZaANmsP9jB6X0SHx1UcMvC093yChn21SCrwYqOjsR+27nI26gzGDlIuiutT9
X-Google-Smtp-Source: AGHT+IH/Voooeqh1trBSVtLd8MFR4Y5GtqbMCdblGLLs1ljYjHsuiSlSS1UcXIFiGXqiwcFsd5GVSA==
X-Received: by 2002:a50:8ad1:0:b0:56b:d1c2:9b42 with SMTP id k17-20020a508ad1000000b0056bd1c29b42mr9714423edk.29.1712602159766;
        Mon, 08 Apr 2024 11:49:19 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c089:d500:a874:5bd3:c0b7:2ae1? (dynamic-2a01-0c23-c089-d500-a874-5bd3-c0b7-2ae1.c23.pool.telefonica.de. [2a01:c23:c089:d500:a874:5bd3:c0b7:2ae1])
        by smtp.googlemail.com with ESMTPSA id b13-20020a0564021f0d00b0056e6c477230sm434450edb.16.2024.04.08.11.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 11:49:19 -0700 (PDT)
Message-ID: <ac3f0e3a-ccb2-4426-9140-72c23913b4ed@gmail.com>
Date: Mon, 8 Apr 2024 20:49:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: r8169: unknown chip XID 6c0
To: =?UTF-8?B?0JXQstCz0LXQvdC40Lk=?= <octobergun@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <CAF0rF3oUX0rb8eKTc94D-fF5EWM7nVAAFJM_VbH_wte8FGcJQg@mail.gmail.com>
 <8bacfc9f-7194-4376-acf7-38a935d735be@gmail.com>
 <CAF0rF3piNHcjwQt3ufV4nqavYopo67rr2phFFEYMygHjgp9N5g@mail.gmail.com>
 <CAF0rF3r24zSthFg1OU=gaFA=4DKYQ67+_7Tb+375_JSEntxmKw@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CAF0rF3r24zSthFg1OU=gaFA=4DKYQ67+_7Tb+375_JSEntxmKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08.04.2024 20:35, Евгений wrote:
> Thank you for your answer.
> Apply the patch, kernel 6.8.4, ethernet works.
> 
> dmesg | grep r8169
> [    4.020210] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have
> ASPM control
> [    4.033148] r8169 0000:02:00.0 eth0: RTL8168h/8111h,
> 00:e0:4c:08:93:00, XID 6c0, IRQ 130
> [    4.033154] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194
> bytes, tx checksumming: ko]
> [    4.048581] r8169 0000:02:00.0 enp2s0: renamed from eth0
> [   12.854689] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY
> driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
> [   12.998007] r8169 0000:02:00.0 enp2s0: Link is Down
> [   15.717414] r8169 0000:02:00.0 enp2s0: Link is Up - 1Gbps/Full -
> flow control rx/tx
> 

Patch has been applied and will show up in 6.10.

> сб, 6 апр. 2024 г. в 23:15, Heiner Kallweit <hkallweit1@gmail.com>:
>>
>> On 06.04.2024 12:15, Евгений wrote:
>>> Hello.
>>>
>>> lspci -v
>>> 2:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 2b)
>>> Subsystem: Realtek Semiconductor Co., Ltd. Device 0123
>>> Flags: fast devsel, IRQ 17
>>> I/O ports at 3000 [size=256]
>>> Memory at 80804000 (64-bit, non-prefetchable) [size=4K]
>>> Memory at 80800000 (64-bit, non-prefetchable) [size=16K]
>>> Capabilities: [40] Power Management version 3
>>> Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>>> Capabilities: [70] Express Endpoint, IntMsgNum 1
>>> Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
>>> Capabilities: [100] Advanced Error Reporting
>>> Capabilities: [140] Virtual Channel
>>> Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
>>> Capabilities: [170] Latency Tolerance Reporting
>>> Capabilities: [178] L1 PM Substates
>>> Kernel modules: r8169
>>>
>>> dmesg | grep r8169
>>> [1.773646] r8169 0000:02:00.0: error -ENODEV: unknown chip XID 6c0, contact r8169 maintainers (see MAINTAINERS file)
>>
>> Thanks for the report. Realtek calls this chip version RTL8168M,
>> but handling seems to be identical to RTL8168H. Could you please
>> test whether ethernet on your system works with the following patch?
>>
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index fc8e6771e..2c91ce847 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -2227,6 +2227,8 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
>>                  * the wild. Let's disable detection.
>>                  * { 0x7cf, 0x540,      RTL_GIGA_MAC_VER_45 },
>>                  */
>> +               /* Realtek calls it RTL8168M, but it's handled like RTL8168H */
>> +               { 0x7cf, 0x6c0, RTL_GIGA_MAC_VER_46 },
>>
>>                 /* 8168G family. */
>>                 { 0x7cf, 0x5c8, RTL_GIGA_MAC_VER_44 },
>> --
>> 2.44.0
>>
>>
> 


