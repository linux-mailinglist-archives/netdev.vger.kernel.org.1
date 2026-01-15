Return-Path: <netdev+bounces-250311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23894D285C5
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 21:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFE54308E643
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B22D839C;
	Thu, 15 Jan 2026 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNYQmETF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3F288C22
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768508137; cv=none; b=sS/5g3rVwSYLA5Em7XbAiYGF1GbBeh3B/dp13xEhX5xLPWk8gM30Y4yoU5dvOm4ikLt7KScANyCL3G/dMGToA2OJ3dnxni7WbejH2vkp9HgkYz4Xj0+nm4tFN6Km3ZDme8PEjNh4rH8A4xpOIQ0Hh23w/hOmhPoTH4DFqP3zfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768508137; c=relaxed/simple;
	bh=4PNGwBU5YSMhv45nkFwMj2z1cusCWBlvRq5aGIkc4Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0N5by9tHeELeCscmS7t5IFP+ON/2GUYmbDeB0+qGqc8TvlNz5r8e0UAYvQgAOGnYraELSntPtoto6yo416PgQ2RkcagolzRb7DBx727SqncsvIk2QSE8IT5Oxc4MS7mRXec4bY3+BikoknDwhn/+wat6xIoDdS9gi/kPyLmWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNYQmETF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so1198393f8f.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 12:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768508134; x=1769112934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rgKDMu3qwYONwv5y36JveagjeRRhmswZzOojgz2Ips=;
        b=DNYQmETFfOBvMC5QaRJRbzd/v7/FYoINux/0HyuRv9Oxbn+jJqQH3+6SqYv6s0vj78
         S2Ko9D8VgHGLBfkWefWXNstRT48zxslYp37Eit4Axurl47ouwqkmJOMksTL9ufiTIeby
         jNDfvv6vdROciFOOtmJBqv7g1rNOWM/MVvq2LjJi7OUrTRvy5ojMnIUWCQKFRTYZfotn
         yZ7tWOirhXU12HviTU34ebUjG9zkW6FFdbqx2+pmN8PN28zxEzdFnN/VPCVRxyM6sfLy
         SGoFV7zhaSFA6PJsg7nCtWGC3lTykWLw86wKSj7d5IoBhOHertR9tx5SyeQEbpxbKrt1
         LsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768508134; x=1769112934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rgKDMu3qwYONwv5y36JveagjeRRhmswZzOojgz2Ips=;
        b=O4vnooSXdU5ek/GvUkx3WHHvPWRxEcpU1FCiCOV/X69muGEW/QrUZJpMngttgw73Xq
         xuXUFoHruBhbsj2MbAQRoHvG0tajbbMPsjJ6y4UGGZfxeuwKTK8PsaocAgcmXaklxoR0
         VzqSLFx7jIMKyYUYy7aWTNkUAmOUPoI+pMggGNH2O77ldtKz54kzFzik3sh3hewWZ9Qs
         b7NtcGXruoNEV1qLoYpGUgNO5P0RiQ+WwjrxPwmjwENFJ9rlHhbZxxS094152FPza8Ir
         bFk8US6VYBu2rM93SpqngDGl5WZPt+tlX9vqY2l0F05yQWnRlHoPnOYxLRVRyMe6YqKY
         X94w==
X-Gm-Message-State: AOJu0Yz/gNyBGOIxSks8oghuFcqnKn24FOpLMUfhUCNkZvkX7b3ad4SY
	Ja79yFk7agsd7sametIO1ASRHSugpq1RmR+Nqexr4Y8Ck2Yr6/kf+qkJlwlEWQ==
X-Gm-Gg: AY/fxX7kcB8YBl2EQL4cy5xz4D7pj/XbQ7wMm1ytnk2xNXvaz4c64FHk0GDQUvAsXBL
	tPACM6vyVZqKS6nShCh2S8VYbUivzzPzvm5v0pxQKN99EoLadpyjrc0CBY2CkaR8p4Mw1Xqj94B
	bb5CDiYWpZMktlbPFrqAo8tVGVDdjIO/BYqkNSkZO8NdYxcSCe0QFGoAcgofDzev8aopVyhBX5B
	jld/1rRs5pM63s90wE3RemhvX3wBlUdOVHQ3Ammf7DeL3vEyeYIeLtdKbGMrdiIL8dEgSQUo086
	1ChLimLvHqhjP3xERVGFAqLfdL3Vw8/fjFTcXKyG38H4G5W4PVbskxVVaLFRFlRPsVQxeRXmwLV
	I/gNRDjPHYs2Ka1v7JGVzeWp/NMDKoiin33wSryAzevN6ftj+8x3vIo1wh63Zoxqm21HFHm+pJw
	99HUG/ceh3KwIWSeNk/CJ5jsAuw+QOMznFbM1YhgMG1cNVeQbhvRrpiqS0Z5euViV2WxD2emgVL
	zFXdiNqDEW4IzSbmb60mmggWN6vWUoZR0la7ZlOZTGXXGdlGP1odA==
X-Received: by 2002:a05:6000:220d:b0:431:808:2d45 with SMTP id ffacd0b85a97d-4356a0331e7mr545213f8f.2.1768508133539;
        Thu, 15 Jan 2026 12:15:33 -0800 (PST)
Received: from ?IPV6:2003:ea:8f35:5e00:e4bd:38e4:a449:14b2? (p200300ea8f355e00e4bd38e4a44914b2.dip0.t-ipconnect.de. [2003:ea:8f35:5e00:e4bd:38e4:a449:14b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997ed8bsm877427f8f.36.2026.01.15.12.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 12:15:32 -0800 (PST)
Message-ID: <366b3ffc-c88a-4b04-baa5-a05725f1d01f@gmail.com>
Date: Thu, 15 Jan 2026 21:15:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 3/3] r8169: add support for chip RTL9151AS
To: Paolo Abeni <pabeni@redhat.com>, javen <javen_xu@realsil.com.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
References: <20260112024541.1847-1-javen_xu@realsil.com.cn>
 <20260112024541.1847-4-javen_xu@realsil.com.cn>
 <02c00a95-34c6-4b01-8f0a-7dbd113e26ba@gmail.com>
 <a244b2c5-b3d6-4150-b9ab-8be20d72bf23@redhat.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <a244b2c5-b3d6-4150-b9ab-8be20d72bf23@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/2026 11:51 AM, Paolo Abeni wrote:
> On 1/12/26 11:20 PM, Heiner Kallweit wrote:
>> On 1/12/2026 3:45 AM, javen wrote:
>>> From: Javen Xu <javen_xu@realsil.com.cn>
>>>
>>> This patch adds support for chip RTL9151AS. Since lacking of Hardware
>>> version IDs, we use TX_CONFIG_V2 to recognize RTL9151AS and coming chips.
>>> rtl_chip_infos_extend is used to store IC information for RTL9151AS and
>>> coming chips. The TxConfig value between RTL9151AS and RTL9151A is 
>>>
>>> different.
>>>
>>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>>> ---
>>>  drivers/net/ethernet/realtek/r8169.h      |  3 ++-
>>>  drivers/net/ethernet/realtek/r8169_main.c | 28 +++++++++++++++++++++--
>>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
>>> index 2c1a0c21af8d..f66c279cbee6 100644
>>> --- a/drivers/net/ethernet/realtek/r8169.h
>>> +++ b/drivers/net/ethernet/realtek/r8169.h
>>> @@ -72,7 +72,8 @@ enum mac_version {
>>>  	RTL_GIGA_MAC_VER_70,
>>>  	RTL_GIGA_MAC_VER_80,
>>>  	RTL_GIGA_MAC_NONE,
>>> -	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1
>>> +	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1,
>>> +	RTL_GIGA_MAC_VER_CHECK_EXTEND
>>>  };
>>>  
>>>  struct rtl8169_private;
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 9b89bbf67198..164ad6570059 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -95,8 +95,8 @@
>>>  #define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
>>>  
>>>  static const struct rtl_chip_info {
>>> -	u16 mask;
>>> -	u16 val;
>>> +	u32 mask;
>>> +	u32 val;
>>>  	enum mac_version mac_version;
>>>  	const char *name;
>>>  	const char *fw_name;
>>> @@ -205,10 +205,20 @@ static const struct rtl_chip_info {
>>>  	{ 0xfc8, 0x040,	RTL_GIGA_MAC_VER_03, "RTL8110s" },
>>>  	{ 0xfc8, 0x008,	RTL_GIGA_MAC_VER_02, "RTL8169s" },
>>>  
>>> +	/* extend chip version*/
>>> +	{ 0x7cf, 0x7c8, RTL_GIGA_MAC_VER_CHECK_EXTEND },
>>> +
>>>  	/* Catch-all */
>>>  	{ 0x000, 0x000,	RTL_GIGA_MAC_NONE }
>>>  };
>>>  
>>> +static const struct rtl_chip_info rtl_chip_infos_extend[] = {
>>> +	{ 0x7fffffff, 0x00000000, RTL_GIGA_MAC_VER_64, "RTL9151AS", FIRMWARE_9151A_1},
>>> +
>>
>> Seems all bits except bit 31 are used for chip detection. However register is
>> named TX_CONFIG_V2, even though only bit 31 is left for actual tx configuration.
>> Is the register name misleading, or is the mask incorrect?
> 
> @Heiner (double checking to avoid more confusion on my side): are you
> fine with the register name? It's unclear to me if you are fine with
> just the 2 merged patches or even with this one.
> 

I understand their motivation for the register name, even though I don't find it ideal.
But if their datasheet calls it like this, then ok.

So yes, patch is fine with me.

> Thanks,
> 
> Paolo
> 


