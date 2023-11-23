Return-Path: <netdev+bounces-50572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33EE7F6268
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A864B281AA2
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58736241F1;
	Thu, 23 Nov 2023 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhI1xV5d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956FDA4
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 07:13:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-548ce28fd23so1345312a12.3
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 07:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700752381; x=1701357181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DD5UuAJFhjK2Jmpwb2pC3r5jQFzpFPXlT5b4YPvWmO0=;
        b=RhI1xV5dB7LGpSj96hVxvXokfSszQy7wbgjJ47yayR7F7aW+h7Ji6DaRuVlkxRRhNx
         DUEdy2Jvkd1QExZhQP41CRe19y/5lT7BUPuV1eT5Ckmodr7MZuh09z/RvF7no5iJOsB1
         dPRGU+mrINhhWvsiIJZpUnvsHlbPQXDmkPOOPMZItmZoHXkwWM/IUndhFQ6n0t014Xyu
         2+by53SgEjkzLqwnDVU1NOohWDVzc1dzF1gBKI9HI6GrWc3GHwyraFPTzs6sOIiyopue
         zhICaLiWdrrAhMx4sK7fx0aQepka6Df72JURoX3TViuN4Cq5t0+83w7yISUffBND/wEb
         +hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700752381; x=1701357181;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DD5UuAJFhjK2Jmpwb2pC3r5jQFzpFPXlT5b4YPvWmO0=;
        b=dii85LLnpu6PiWH2vBtZDZoSaf89rUlFegvtzBHHW4EfZL+ADFijx1mpBKc1S1iPfE
         eKUkk7rxTOEVSXsyI7p4GmZ/eTN3vhTqEVq6Jsu2cebHje0QaGYHFPAMjI0n30qysETb
         kL8uDsTu2m7sNgQ9F/8S198zwqtrqbcgFysANreCQCu33RqRKnjV3O6xXWl68Gi/7zfX
         bOffzL0VCE0aCaKPZGiTIXbzZwUCM7CSOa70ZEQ7KwKFF4d2nOH7FaxtL6ICP0V2Dr2l
         /Xy4mk9hTx8A10g+zM7z5HWtxrQuPr8qARLvFC3+JDHnzereRP5M6g6xcTX2nM4wqE9R
         jxxQ==
X-Gm-Message-State: AOJu0Yzjv4XjoYlwfU5dMDMm7zJcJasKPuJwBi2yl1zhrqvMIRQVT+oE
	AG7z93A3oMt0csJWsZMgIAo=
X-Google-Smtp-Source: AGHT+IEX39IKRrkkcDJ/HJp0Hf2SzXAUUzGCbqWOiFHMhh//IUTP/0DP26ZCo3yMr3Ol9pDRiGkQHA==
X-Received: by 2002:a05:6402:2d8:b0:53f:731a:e513 with SMTP id b24-20020a05640202d800b0053f731ae513mr4287905edx.25.1700752380775;
        Thu, 23 Nov 2023 07:13:00 -0800 (PST)
Received: from ?IPV6:2a01:c23:c0f2:3200:e5ab:822:2062:12fd? (dynamic-2a01-0c23-c0f2-3200-e5ab-0822-2062-12fd.c23.pool.telefonica.de. [2a01:c23:c0f2:3200:e5ab:822:2062:12fd])
        by smtp.googlemail.com with ESMTPSA id t24-20020aa7d718000000b0053ff311f388sm750895edq.23.2023.11.23.07.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 07:13:00 -0800 (PST)
Message-ID: <65832d7e-2880-4883-92b9-033e48c24d25@gmail.com>
Date: Thu, 23 Nov 2023 16:12:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: remove not needed check in
 rtl_fw_write_firmware
To: Simon Horman <horms@kernel.org>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <52f09685-47ba-4cfe-8933-bf641c3d1b1d@gmail.com>
 <20231123145407.GK6339@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231123145407.GK6339@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.11.2023 15:54, Simon Horman wrote:
> On Thu, Nov 23, 2023 at 10:53:26AM +0100, Heiner Kallweit wrote:
>> This check can never be true for a firmware file with a correct format.
>> Existing checks in rtl_fw_data_ok() are sufficient, no problems with
>> invalid firmware files are known.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/ethernet/realtek/r8169_firmware.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_firmware.c b/drivers/net/ethernet/realtek/r8169_firmware.c
>> index cbc6b846d..ed6e721b1 100644
>> --- a/drivers/net/ethernet/realtek/r8169_firmware.c
>> +++ b/drivers/net/ethernet/realtek/r8169_firmware.c
>> @@ -151,9 +151,6 @@ void rtl_fw_write_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
>>  		u32 regno = (action & 0x0fff0000) >> 16;
>>  		enum rtl_fw_opcode opcode = action >> 28;
>>  
>> -		if (!action)
>> -			break;
>> -
> 
> Hi Heiner,
> 
> I could well be wrong, but this does seem to guard against the following case:
> 
> 1. data = 0
> 2. regno = 0
> 3. opcode = 0 (PHY_READ)
> 
> Which does not seem to be checked in rtl_fw_data_ok().
> 
> It's unclear to me if there is any value in this guard.
> 
Value 0 is used with a special meaning in two places:
1. Newer firmwares with some meta data before the actual firmware
   have first dword 0 to be able to differentiate old and new fw format.
2. Typically (not always) fw files in new format have a trailing dword 0.

A potential problem (as you mention) is that value 0 isn't really a
sentinel value because reading PHY register 0 is a valid command.
It's just never used in their firmwares.

There's no need to guard from reading PHY reg 0. It does no harm.
I *think* they once added this check to detect end of file.
But that's not needed because the actual firmware length is
part of the meta data. Therefore reading data from the firmware
will stop before reaching the training zero(s).

>>  		switch (opcode) {
>>  		case PHY_READ:
>>  			predata = fw_read(tp, regno);
>> -- 
>> 2.43.0
>>


