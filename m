Return-Path: <netdev+bounces-238788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E38EBC5F6D7
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7F064E3DEF
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020C5302142;
	Fri, 14 Nov 2025 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck58+xfa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C292F7456
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156888; cv=none; b=Fckb0Tse7a0ZjgTBlF7gj+i5gNYmug5VI9QsnN1ZRvFSySXddbf/9SexMnh6sEDxMb9N4JorKoYvYsYSu+J21MFH9QyhUklZ4NBXFFl2ivtpRbxm4WlteXa634mstZA3K6hA9hZ1OKgdPJgFMIkqN/bRuUMfVqzYclnzTJLaCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156888; c=relaxed/simple;
	bh=qcxHIl3eJNcjKPwXvgB1OEh1kpfHHertbtutjHP8Bd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOe4zkPDb/8Ighxq3ry1wvaiJt1tRfmVRR8q70oX+jS36cm6hWhKioViRg1RASqwDbj8SM9RXkpiUnnHQI6VakIltmGKJW1PQYnfg26Z4+koKJxDiUGigmAGSFQB8Tjvhn/bSuvbX8O+OtEUr+ld00Ac+si/yq4TrufcR0/gbNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck58+xfa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so2237266b3a.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763156883; x=1763761683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndWlFPbjxzRxRxDcI3I/Qsa3cvxWeCbP+0DJwpTI8QY=;
        b=Ck58+xfaNnYqNoI04woOAroxHxFj+kLesyD/g6IhTBJcROA0upLVnGDJ7AIXXvo5gQ
         TbUhgVyH5hrswGpgynBjjYYP0zlRNR3tct/v5QgF3zazBESZ0Ii2OLEZLr+zurarpm3e
         TrT4N7sDxk2pz5LVpbk7bYDffr1WcRO4cuIRYI4sp6u6NwE1c5VvcF5CANfTKr0q0+RO
         M3MQ04RgyS52h5vdkXxxh05Qa/1i1PVsVU1jXOxxS0x3a4NfBxeC97JgBvps0SE+HmEo
         d6j0I2WYIGp/XFwmnEfIy2vpJ77Si/a6Cbg6MFhMduyu/nJ5tulxsKHT6cuVeqJd8WLM
         U6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763156883; x=1763761683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndWlFPbjxzRxRxDcI3I/Qsa3cvxWeCbP+0DJwpTI8QY=;
        b=niV5HXXWWk8FLC3f0Y+507BOApM2+szvBx9it+mp2pZKBuXneK6vhjtmVpwYTZxGM4
         pxhh8jlmJ2wrw9sS89uz8cfdSxkJQb5ZpgFctY7BXN2G4Xt5Py7Tfp1xYhrMjljX3yx0
         BlMyE2VtjOnIfsOQRj+Ihk7PvEwIULmcVLXLGNB3djL6WpvJC+6su9YcVLIkJZyU0TBf
         D+yxYjGhFMhg/IIqrIuEhn9l67bF05uiBzczh8Z4O0K50XjQ36xMercQ+2iz1DTDr73Z
         5l3G5ebfkWW2/JZ3ECDYOTbMMxiUX3m64uMoNgciayFZaa8F7KfUVWYHDtcflZwqWg0e
         X9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0UKugyaJ7H3Kjd2vKSB0ew08IekmMshucvxpMcG91E8OsLlLfSgpodH4kcG4x58yPUAP2v+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaBbHKKi9vfSXphB6SZjZcdxOvQ1t9nQLJoMpFkQ1pIuZ/lja1
	+QBjnpbfkT+2wFwsiIRZNd6+46bITeUmluMMe7MWKc9315xIk/EohN5t
X-Gm-Gg: ASbGnct7KEchPI9qf2q9dRPaWfs8nTNZ1BOsAq6YsgbLQI1R91Nb1UBAfoVC7ZNDy26
	0nx4RdfA95gSNcOZ4HxamW1yXgicNxV0TTTNHPG43epzja8qQdgo96pHzK+yyQcNKmyTYDEbEPY
	bZ9I5rS86Dq/+wffSPZfmqB5e5sQbwM4kmoTtxHwDtx8KqiTUpXffQRBKc3jiJvWf40SsOdOJA5
	gGu493bs3/43J0/Ps5ecP5nPaDITRcTE7psh1IN5tFEyj/wOdIkzreZQOruq/ap83lV3rn7/xMd
	dlHatPQLVBPO5K8fIBzz+4I9KGf9UuIgZAZ4zJowu94UNcBVQxtPr3zcwq6GinHdAs9vfpVyvCu
	ZbdlkErMtbnhDX4VKJjPHuA7I0kdYlOoT5Vuvyy4i+NwsxxZqHquymNENEwDQSUrJzAbiN4B9Zk
	Sd1y2W5G7kZVAJoMK0WS8bYx9yB1c=
X-Google-Smtp-Source: AGHT+IFk2x7IEtAE2pW3ym3rkCFWB6IEtl35YOk+cFtHho6dgH5SfU1vSAmzp4x4mGkmdZkQZBx1Hg==
X-Received: by 2002:a05:6a00:234b:b0:7ad:1e4:bef0 with SMTP id d2e1a72fcca58-7ba39ce56c7mr5152569b3a.4.1763156882938;
        Fri, 14 Nov 2025 13:48:02 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927150b13sm6144036b3a.46.2025.11.14.13.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 13:48:02 -0800 (PST)
Message-ID: <11991339-711b-442d-a1e4-8c3393b12b0a@gmail.com>
Date: Fri, 14 Nov 2025 13:48:01 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on
 i.MX6Q
To: Heiner Kallweit <hkallweit1@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 edumazet <edumazet@google.com>, netdev <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch>
 <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
 <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/14/25 13:33, Heiner Kallweit wrote:
> On 11/14/2025 10:15 PM, Fabio Estevam wrote:
>> Hi Andrew,
>>
>> On Thu, Nov 13, 2025 at 7:35 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>>> Maybe dump all 32 registers when genphy and smsc driver are being used
>>> and compare them?
>>
>> The dump of all the 32 registers are identical in both cases:
>>
>> ./mii-diag -vvv
>> mii-diag.c:v2.11 3/21/2005 Donald Becker (becker@scyld.com)
>>   http://www.scyld.com/diag/index.html
>> Using the default interface 'eth0'.
>>    Using the new SIOCGMIIPHY value on PHY 0 (BMCR 0x3100).
>>   The autonegotiated capability is 01e0.
>> The autonegotiated media type is 100baseTx-FD.
>>   Basic mode control register 0x3100: Auto-negotiation enabled.
>>   You have link beat, and everything is working OK.
>>     This transceiver is capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
>>     Able to perform Auto-negotiation, negotiation complete.
>>   Your link partner advertised cde1: Flow-control 100baseTx-FD
>> 100baseTx 10baseT-FD 10baseT, w/ 802.3X flow control.
>>     End of basic transceiver information.
>>
>> libmii.c:v2.11 2/28/2005  Donald Becker (becker@scyld.com)
>>   http://www.scyld.com/diag/index.html
>>   MII PHY #0 transceiver registers:
>>     3100 782d 0007 c0f1 05e1 cde1 0009 ffff
>>     ffff ffff ffff ffff ffff ffff ffff 0000
>>     0040 0002 60e0 ffff 0000 0000 0000 0000
>>     ffff ffff 0000 000a 0000 00c8 0000 1058.
>>   Basic mode control register 0x3100: Auto-negotiation enabled.
>>   Basic mode status register 0x782d ... 782d.
>>     Link status: established.
>>     Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
>>     Able to perform Auto-negotiation, negotiation complete.
>>   Vendor ID is 00:01:f0:--:--:--, model 15 rev. 1.
>>     No specific information is known about this transceiver type.
>>   I'm advertising 05e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT
>>     Advertising no additional info pages.
>>     IEEE 802.3 CSMA/CD protocol.
>>   Link partner capability is cde1: Flow-control 100baseTx-FD 100baseTx
>> 10baseT-FD 10baseT.
>>     Negotiation  completed.
>>
>> After pinging with the Generic PHY driver:
>>
>> # ethtool -S eth0 | grep error
>>       tx_crc_errors: 0
>>       rx_crc_errors: 0
>>       rx_xdp_tx_errors: 0
>>       tx_xdp_xmit_errors: 0
>>
>> After pinging with the SMSC PHY driver:
>>
>> # ethtool -S eth0 | grep err
>>       tx_crc_errors: 0
>>       IEEE_tx_macerr: 0
>>       IEEE_tx_cserr: 0
>>       rx_crc_errors: 19

The CRC errors should be a clear sign that you have a serious electrical 
issue here as the MAC is not capable of de-framing what is coming out of 
the PHY properly.

Given that you use RMII this would indicate that your PHY's TX CLK, 
which is a RX CLK on the MAC side may not be stable, do you have a scope 
you could use to check that it looks correct? Anything on the PCB itself 
that could hinder the clock signal quality?

Given that you don't see it at 10Mbits/sec, this would suggest you have 
an issue with data sampling and rise/fall times of the clock being 
misaligned with when the data is present on the data lines.
-- 
Florian

