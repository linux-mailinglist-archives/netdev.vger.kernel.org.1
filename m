Return-Path: <netdev+bounces-250100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2BFD24041
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A93F63015952
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D71350D6D;
	Thu, 15 Jan 2026 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZN8gCAdX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrjMD6tT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E53624C4
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768474270; cv=none; b=P3XeYBna//XF0morgzpTBsZcpLpV+8Ye+TcvWSCndk9vB+OoBFe3eXbrEZccD4KCBNGFK/YKfFvm3jT6AsRScsdXgZ02xO5OvP4iMWgAw06OfzX/lGD5s5/gkWVsLQiJ2WkPSrMQ+tOJ21VxTTvKyTFkSYEk8BQcxYNWWYF/9rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768474270; c=relaxed/simple;
	bh=Q+KLBbZ16TUaA1787P+mOMgNkluhjhudjmGs8dpd4kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNqt41201iajfUkdJtB8QP82sErAfz8gcYvi9agnkvInXeH+qLp9uOWH1DZK1gd+Hj31eedoeYLKnkz61O23KoLJXuH+dReZL7E/O7OSNi3IYgqncbk6H2+0YXyQWGfJOy75hnHrw5K5AiDkSZbWLaNzhOcmd8yKsXjMKfAakbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZN8gCAdX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrjMD6tT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768474268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njNgE+RwR9mMomW5fKh66rUzToYPjNKP431ct4v3hs0=;
	b=ZN8gCAdXyEM71ADxQOYzaak6LKZgdk9iUAyqyCcCPgZZdkvlkmEP/P2p3ubsu4VYZ6SKTl
	Pr4+a8TQFuy9SGpigRn52TMkldnTk+UwTJhZ06RLgYXfZNdn5svuAt4FH7QIHLvGXJHAOw
	LRhw/EaOtxfITU3Qla+CDvZjpRAz0NQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-hB2WPCVMO7aEtaVUnv1reA-1; Thu, 15 Jan 2026 05:51:07 -0500
X-MC-Unique: hB2WPCVMO7aEtaVUnv1reA-1
X-Mimecast-MFC-AGG-ID: hB2WPCVMO7aEtaVUnv1reA_1768474266
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42fd46385c0so381369f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 02:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768474266; x=1769079066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njNgE+RwR9mMomW5fKh66rUzToYPjNKP431ct4v3hs0=;
        b=KrjMD6tTutllDAWzoLjJmisN62nuPsJIG1AgymEjYrey+TqrhzMp/5fFDjYyGYGfnf
         jF8QwBlMwt9RAmBUusKlqw3kZM2GxryaFLcWDQLWuq0XmBEXxuCjEp7ysA3QMgN4CPln
         ZJ8zBeiOFlxuH7zT2FDlMK3P2pzSXLrCaftSCFb+2tzjt8Zq0+aiG0C6EZJAjVEKQkFX
         3F/xUJ00gt7dWHn7mNTMSIuaotIBqYnBRU44xB6iSiknqM/z2c7ITqvum6Wtefjcg77Y
         d5//M4zLjvigtZIa/Y95aDrYob3NOxTlkhJKyydAWyqgQQuMwmzPeIAUX4tEXR3d0prE
         6NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768474266; x=1769079066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njNgE+RwR9mMomW5fKh66rUzToYPjNKP431ct4v3hs0=;
        b=vOquOceqmgf9GS3dAv+2lx1ZbsgjhDsAb4NqWXnV87HoNR92ZeKRPPfuVALkdiynK3
         AyIDnmkt1jFaCOw4rKi15GZowteH7Ny7E6G3IupJ3EdGYtydrM+Tsf/vF2PkKJCRsckc
         XaHV1QFxydhTnCKy4Ji7mhQe+SuPH6rN2gEvmsLhIyL2+5rZUX8pcuTl1aWuHdkFxoOf
         xPM3i6MnI0r1faewNxiFucdbazh9gRA4LVyh6BNLGBzqJA+FLnwvoYMrMsduFEFPLGle
         fBbIRImogsOVfKWpHDl1BoazNSV93mxvHqvmKlVw6UlEJ5Qv219Sduq4ySqTLW/A58g6
         hdGQ==
X-Gm-Message-State: AOJu0YyIz87idZ3gNjNf5lFlBEkiqrUWNpb4/IIDX7UL8fUCqw9tdzkV
	9rfsCikGvk/dfyNvsTwlGLjBl2ilrFp8baSS5qT5qSDd8iGFa0o58BPugbwd9/+6MlZxQcBjD0n
	z9nM/J6vPKNv1tdWjdfILslGw3nk/CZpKpO94abIhyiT/jUFeayU59zOAwA==
X-Gm-Gg: AY/fxX4SxpESAIFxAbVEHYaUBtjoGHYLF/HvOwzR4KtmgQTULk0og5mixmRKz+G3gzD
	6RTirMxt+xDshR1oWP2BPePY/5boCxr5uNoQeiFbU0IuVsNXmicFQCtCNknZVWH2ueHegOMWTfB
	0YqmkeiFsIkJsc45/UuSV7NVx2Ccdrtyw3jQX9UBn5P/aC/SQom861L3ZaKSKObzAISSPESa//+
	9aUhpylCLFpQowsH/x/iQtPYHcAhcThq51CwKwwbnU5lTvW6ceH3I4GZ31ovqvR+0yaDjCKP6WM
	Q/jqrDptBUGQCrJ1PYYYPata76Htbt/DmeXYQu4LYrQim+g8IwALr9TGRqqMz7gaDXnV7EPp2+t
	9k/1FBRS2uh22vg==
X-Received: by 2002:a05:600c:8b67:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-47ff952d2dcmr20777335e9.19.1768474265752;
        Thu, 15 Jan 2026 02:51:05 -0800 (PST)
X-Received: by 2002:a05:600c:8b67:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-47ff952d2dcmr20777155e9.19.1768474265381;
        Thu, 15 Jan 2026 02:51:05 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6b143fsm5107759f8f.25.2026.01.15.02.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 02:51:04 -0800 (PST)
Message-ID: <a244b2c5-b3d6-4150-b9ab-8be20d72bf23@redhat.com>
Date: Thu, 15 Jan 2026 11:51:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 3/3] r8169: add support for chip RTL9151AS
To: Heiner Kallweit <hkallweit1@gmail.com>, javen <javen_xu@realsil.com.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
References: <20260112024541.1847-1-javen_xu@realsil.com.cn>
 <20260112024541.1847-4-javen_xu@realsil.com.cn>
 <02c00a95-34c6-4b01-8f0a-7dbd113e26ba@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <02c00a95-34c6-4b01-8f0a-7dbd113e26ba@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 11:20 PM, Heiner Kallweit wrote:
> On 1/12/2026 3:45 AM, javen wrote:
>> From: Javen Xu <javen_xu@realsil.com.cn>
>>
>> This patch adds support for chip RTL9151AS. Since lacking of Hardware
>> version IDs, we use TX_CONFIG_V2 to recognize RTL9151AS and coming chips.
>> rtl_chip_infos_extend is used to store IC information for RTL9151AS and
>> coming chips. The TxConfig value between RTL9151AS and RTL9151A is 
>>
>> different.
>>
>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>> ---
>>  drivers/net/ethernet/realtek/r8169.h      |  3 ++-
>>  drivers/net/ethernet/realtek/r8169_main.c | 28 +++++++++++++++++++++--
>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
>> index 2c1a0c21af8d..f66c279cbee6 100644
>> --- a/drivers/net/ethernet/realtek/r8169.h
>> +++ b/drivers/net/ethernet/realtek/r8169.h
>> @@ -72,7 +72,8 @@ enum mac_version {
>>  	RTL_GIGA_MAC_VER_70,
>>  	RTL_GIGA_MAC_VER_80,
>>  	RTL_GIGA_MAC_NONE,
>> -	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1
>> +	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1,
>> +	RTL_GIGA_MAC_VER_CHECK_EXTEND
>>  };
>>  
>>  struct rtl8169_private;
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 9b89bbf67198..164ad6570059 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -95,8 +95,8 @@
>>  #define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
>>  
>>  static const struct rtl_chip_info {
>> -	u16 mask;
>> -	u16 val;
>> +	u32 mask;
>> +	u32 val;
>>  	enum mac_version mac_version;
>>  	const char *name;
>>  	const char *fw_name;
>> @@ -205,10 +205,20 @@ static const struct rtl_chip_info {
>>  	{ 0xfc8, 0x040,	RTL_GIGA_MAC_VER_03, "RTL8110s" },
>>  	{ 0xfc8, 0x008,	RTL_GIGA_MAC_VER_02, "RTL8169s" },
>>  
>> +	/* extend chip version*/
>> +	{ 0x7cf, 0x7c8, RTL_GIGA_MAC_VER_CHECK_EXTEND },
>> +
>>  	/* Catch-all */
>>  	{ 0x000, 0x000,	RTL_GIGA_MAC_NONE }
>>  };
>>  
>> +static const struct rtl_chip_info rtl_chip_infos_extend[] = {
>> +	{ 0x7fffffff, 0x00000000, RTL_GIGA_MAC_VER_64, "RTL9151AS", FIRMWARE_9151A_1},
>> +
> 
> Seems all bits except bit 31 are used for chip detection. However register is
> named TX_CONFIG_V2, even though only bit 31 is left for actual tx configuration.
> Is the register name misleading, or is the mask incorrect?

@Heiner (double checking to avoid more confusion on my side): are you
fine with the register name? It's unclear to me if you are fine with
just the 2 merged patches or even with this one.

Thanks,

Paolo


