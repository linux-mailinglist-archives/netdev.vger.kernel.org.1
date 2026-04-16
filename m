Return-Path: <netdev+bounces-279079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI68CLv/4Gk7oQAAu9opvQ
	(envelope-from <netdev+bounces-279079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:26:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED1B410B9B
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0FA13012C6D
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C5022A80D;
	Thu, 16 Apr 2026 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3GI0mFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E842E2852
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353087; cv=none; b=WhUaEfvnGhq8t/Ni42rx2zOd8BJI1CRSPC3nX9R1CuUN20F1nCk9DZ0Sl8n6PQBiS8C4B1Umeck2dov1Fm4zs6caLOrtun/X0kfiObAjXBh969FgJQ8D57/LNGOVu3/8lWLnOJLfDj16rS+QvoWZp5F7jT2ivXDBX6oWhH9spOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353087; c=relaxed/simple;
	bh=4DeLBmD1OSKMnPIdsxTE7sOiplVTnV+dW0Mi0n77Jag=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=owuWPQcIgX3VoOxu7vRbWA8Ma/H3PiMjlpTcscTNHn5iiERBjnVSrYyogblRcx5UwhZ8gLCGwdxrqaMZVmlYgwX9/ThjEB+3b9hCYtS6HdHYjoJpXKDFBBU4TYWJL3XCe1R9HyMxiVzGIpWBA318Y2iwf/rqCB+A4PHGlxqbcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3GI0mFX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-823c56765fdso4533923b3a.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776353085; x=1776957885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H+34z2zcygJjLXaoojeshR97PIrdaKevh+94pYFmkcE=;
        b=G3GI0mFXEU0cXUysoXGJl5SBUg5exPfMxqQSBmoAbMMTXz9ZXSaSofmm6bbNbeSAJQ
         jtNmUIWppupHKS02hj7hYZBDqLhR+KUuZ53IOgsnDtAuvnCRp8FdcU0KRQZT4onLrmoA
         TxCnnTD2dDsoMwfG82McrzRzXXjAvgtOoazZNnW3Me/yCXMaX8kCXmTzRuw3/6t4GTHR
         HTNqNfgpdnNGFS6LlyyVfMfvfgsLgENo660mHtZOEp4ovdj0lruiFGaGnx6NyzQNHbpl
         b2F581IECgltJagusP+id6L31M+6jZqMr5ngo2YWrZzA2kp11mJrp/qsqHcgTTYpYme4
         dIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353085; x=1776957885;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+34z2zcygJjLXaoojeshR97PIrdaKevh+94pYFmkcE=;
        b=J9A2GVDDWIc9NZe/NhgNr3deyI3Jk1JKWAuayaVv0xtG+S0u8PUIWMOCfwb5NsXg7c
         qXIrp7mfnESlzD57j8Mlfn5Bd3ZqM3nQ3RASAz8DhPNeY0neuIAhzyGDHaeHDEx1LjB+
         h+e3KottwNxmXzeYMGohGYf7DEp/5jyp63058MniP7t4PuigUKpe59MOogOsggLQjPtu
         CddkmMXnBxXR27iy1LiMmadignyvE+UwPUEjv7d9fbua5A4hqncGq4iwFjI4fcwKX8la
         6Gtlj/V+ej3jmPdwQayjz7mSdjvWBGslEgaaPJ+ghkvv5j0Um9LcmsX7x+m3RnHYBfP3
         sTRA==
X-Forwarded-Encrypted: i=1; AFNElJ9Y2nKH8FDcnNrFch75Ubyhr0F2E8ZOxIAaGAWjRKEudJKaQQEWHpZDVIZggdUIl9BWe12ylFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx309nNww3H5ldNizCbwjASStvd2OBo1C9fQaXTKx+yDHLk4+uQ
	533/0r6lYicPVnDzi1vEbvSByeCF4NVUYcfWUkk0sbvoJGzdHl44MJsY
X-Gm-Gg: AeBDiesn/6aiBhuqQ+KoOaEJzsjK7VSPbtKGG6VcycCKkyGqZQj51TxOyZ2bgznMCpK
	hbMEQc0h9m5lyqGgggkxWvKbGcuvgK+nG++HTcGcaEIMYBT3ogDc4s6s9yCB0qguurmNjKpMVc1
	VP7Labgfd+fAsbnnnj9PqhtOcn3xfD1oCiz3nl4rFKnd36/lzpdmJMOVt4ORYxm/ppvaunDdQ2R
	B29POlMxPr7BeGxw9v+xc8QmCH5kagvHBt/6uJfCVNMwQEpI5GA/Fcw3emhPcOPRKqIR14GpzZm
	JNqarorfrHYZZIl1En7Dbsa1ksB+np9e2bYTmI0FIHDEUBW/7NrokpPdYy/OcqFZ3SQs7e6I88q
	kkN+egOt65Yakc8jJBTDkaU7XxU2fKvSlZpzPXCs6QbWZza2lRPNRgUMcD4EUw9FHExW5Wl7Yj/
	PKXEVfCzfs4AiPTm8JBijqvD2G9UcngCadju3U1MqJVlcEzFeUhwqWnsKilMQMTDhJQtm+efjq3
	zs+Z1IIYiE0hI/lhN/6Ag==
X-Received: by 2002:a05:6a00:bd8a:b0:82a:5d55:5807 with SMTP id d2e1a72fcca58-82f0c1c8bbdmr25895974b3a.6.1776353084917;
        Thu, 16 Apr 2026 08:24:44 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67085562sm6075675b3a.24.2026.04.16.08.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 08:24:44 -0700 (PDT)
Message-ID: <b44c8f7c-edd6-4d82-ad7d-df8ea907d682@gmail.com>
Date: Thu, 16 Apr 2026 23:24:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: Eric Woudstra <ericwouds@gmail.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no
Cc: frank-w@public-files.de, daniel@makrotopia.org, lucien.jheng@airoha.com
References: <20260326153518.8387-1-lucienzx159@gmail.com>
 <edeee8e5-0de3-48ea-aeb5-cc705fdcd469@gmail.com>
 <5de3f9ca-ffe7-40ca-93a7-fb7e8e513ec2@gmail.com>
Content-Language: en-US
In-Reply-To: <5de3f9ca-ffe7-40ca-93a7-fb7e8e513ec2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279079-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[public-files.de,makrotopia.org,airoha.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienzx159@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7ED1B410B9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Eric

Lucien.Jheng 於 2026/3/29 下午 01:04 寫道:
>
> Eric Woudstra 於 2026/3/27 下午 12:41 寫道:
>>
>> On 3/26/26 4:35 PM, Lucien.Jheng wrote:
>>> AN8811HB needs a MCU soft-reset cycle before firmware loading begins.
>>> Assert the MCU (hold it in reset) and immediately deassert (release)
>>> via a dedicated PBUS register pair (0x5cf9f8 / 0x5cf9fc), accessed
>>> through the PHY-addr+8 MDIO bus node rather than the BUCKPBUS indirect
>>> path.  This clears the MCU state before the firmware loading sequence
>>> starts.
>>>
>>> Add __air_pbus_reg_write() as a low-level helper for this access, then
>>> implement an8811hb_mcu_assert() / _deassert() on top of it. Wire both
>>> into an8811hb_load_firmware() and en8811h_restart_mcu() so every
>>> firmware load or MCU restart on AN8811HB correctly sequences the reset
>>> control registers.
>>>
>>> Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB 
>>> support")
>>> Signed-off-by: Lucien Jheng <lucienzx159@gmail.com>
>>> ---
>>> Changes in v2:
>>> - Rewrite commit message: The previous wording was ambiguous,
>>>    as it suggested the MCU remains asserted during the entire
>>>    firmware loading process, rather than a quick reset cycle
>>>    before it starts.
>>>    Clarify that assert and deassert is an immediate soft-reset
>>>    cycle to clear MCU state before firmware loading begins.
>>> - Add Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB
>>>    support").
>>> - Change phydev_info() to phydev_dbg() in an8811hb_mcu_assert() and
>>>    an8811hb_mcu_deassert() to avoid noise during normal boot.
>>>
>>>   drivers/net/phy/air_en8811h.c | 105 
>>> ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 105 insertions(+)
>>>
>>> diff --git a/drivers/net/phy/air_en8811h.c 
>>> b/drivers/net/phy/air_en8811h.c
>>> index 29ae73e65caa..01fce1b93618 100644
>>> --- a/drivers/net/phy/air_en8811h.c
>>> +++ b/drivers/net/phy/air_en8811h.c
>>> @@ -170,6 +170,16 @@
>>>   #define   AN8811HB_CLK_DRV_CKO_LDPWD        BIT(13)
>>>   #define   AN8811HB_CLK_DRV_CKO_LPPWD        BIT(14)
>>>
>>> +#define AN8811HB_MCU_SW_RST        0x5cf9f8
>>> +#define   AN8811HB_MCU_SW_RST_HOLD        BIT(16)
>>> +#define   AN8811HB_MCU_SW_RST_RUN        (BIT(16) | BIT(0))
>>> +#define AN8811HB_MCU_SW_START        0x5cf9fc
>>> +#define   AN8811HB_MCU_SW_START_EN        BIT(16)
>>> +
>>> +/* MII register constants for PBUS access (PHY addr + 8) */
>>> +#define AIR_PBUS_ADDR_HIGH        0x1c
>>> +#define AIR_PBUS_DATA_HIGH        0x10
>>> +
>>>   /* Led definitions */
>>>   #define EN8811H_LED_COUNT    3
>>>
>>> @@ -254,6 +264,36 @@ static int air_phy_write_page(struct phy_device 
>>> *phydev, int page)
>>>       return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
>>>   }
>>>
>>> +static int __air_pbus_reg_write(struct phy_device *phydev,
>>> +                u32 pbus_reg, u32 pbus_data)
>>> +{
>>> +    struct mii_bus *bus = phydev->mdio.bus;
>>> +    int pbus_addr = phydev->mdio.addr + 8;
>>> +    int ret;
>>> +
>>> +    ret = __mdiobus_write(bus, pbus_addr, AIR_EXT_PAGE_ACCESS,
>>> +                  upper_16_bits(pbus_reg));
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    ret = __mdiobus_write(bus, pbus_addr, AIR_PBUS_ADDR_HIGH,
>>> +                  (pbus_reg & GENMASK(15, 6)) >> 6);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    ret = __mdiobus_write(bus, pbus_addr, (pbus_reg & GENMASK(5, 
>>> 2)) >> 2,
>>> +                  lower_16_bits(pbus_data));
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    ret = __mdiobus_write(bus, pbus_addr, AIR_PBUS_DATA_HIGH,
>>> +                  upper_16_bits(pbus_data));
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    return 0;
>>> +}
>>> +
>> Maybe you can use mutex_lock() and mutex_unlock() here also, like so:

After checking, I decided not to implement mutex_lock in pbus_read/write.

This is because these functions are only used within 
an8811hb_mcu_assert/deassert.

Since these sequences cannot be interrupted, a mutex lock is not required.

Thanks

>>
>> static int __air_pbus_reg_write(struct mdio_device *mdio, u32 
>> pbus_address,
>>                 u32 pbus_data)
>> {
>>     int ret;
>>
>>     ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_EXT_PAGE_ACCESS,
>>                   (u16)(pbus_address >> 6));
>>     if (ret < 0)
>>         return ret;
>>
>>     ret = __mdiobus_write(mdio->bus, mdio->addr, (pbus_address >> 2) 
>> & 0xf,
>>                   (u16)pbus_data);
>>     if (ret < 0)
>>         return ret;
>>
>>     ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_PBUS_DATA_HIGH,
>>                   (u16)(pbus_data >> 16));
>>     if (ret < 0)
>>         return ret;
>>
>>     return 0;
>> }
>>
>> static int air_pbus_reg_write(struct mdio_device *mdio, u32 
>> pbus_address,
>>                   u32 pbus_data)
>> {
>>     int ret;
>>
>>     mutex_lock(&mdio->bus->mdio_lock);
>>
>>     ret = __air_pbus_reg_write(mdio, pbus_address, pbus_data);
>>     if (ret < 0)
>>         dev_err(&mdio->dev, "%s 0x%08x failed: %d\n", __func__,
>>             pbus_address, ret);
>>
>>     mutex_unlock(&mdio->bus->mdio_lock);
>>
>>     return ret;
>> }
>>
>> static int __air_pbus_reg_read(struct mdio_device *mdio, u32 
>> pbus_address,
>>                    u32 *pbus_data)
>> {
>>     int ret, pbus_data_low;
>>
>>     ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_EXT_PAGE_ACCESS,
>>                   (u16)(pbus_address >> 6));
>>     if (ret < 0)
>>         return ret;
>>
>>     ret = __mdiobus_read(mdio->bus, mdio->addr, (pbus_address >> 2) & 
>> 0xf);
>>     if (ret < 0)
>>         return ret;
>>     pbus_data_low = ret;
>>
>>     ret = __mdiobus_read(mdio->bus, mdio->addr, AIR_PBUS_DATA_HIGH);
>>     if (ret < 0)
>>         return ret;
>>
>>     *pbus_data = (ret << 16) + pbus_data_low;
>>
>>     return 0;
>> }
>>
>> static int air_pbus_reg_read(struct mdio_device *mdio, u32 pbus_address,
>>                  u32 *pbus_data)
>> {
>>     int ret;
>>
>>     mutex_lock(&mdio->bus->mdio_lock);
>>
>>     ret = __air_pbus_reg_read(mdio, pbus_address, pbus_data);
>>     if (ret < 0)
>>         dev_err(&mdio->dev, "%s 0x%08x failed: %d\n", __func__,
>>             pbus_address, ret);
>>
>>     mutex_unlock(&mdio->bus->mdio_lock);
>>
>>     return ret;
>> }
>>
>> With:
>>
>> #define AIR_PBUS_DATA_HIGH        0x10
>>
> Thank you for your feedback.
>
> I should add mutex_lock() and mutex_unlock() to protect these operations.
>
> I will include this in the next version.
>
>>>   static int __air_buckpbus_reg_write(struct phy_device *phydev,
>>>                       u32 pbus_address, u32 pbus_data)
>>>   {
>>> @@ -570,10 +610,65 @@ static int an8811hb_load_file(struct 
>>> phy_device *phydev, const char *name,
>>>       return ret;
>>>   }
>>>
>>> +static int an8811hb_mcu_assert(struct phy_device *phydev)
>>> +{
>>> +    int ret;
>>> +
>>> +    phy_lock_mdio_bus(phydev);
>>> +
>>> +    ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
>>> +                   AN8811HB_MCU_SW_RST_HOLD);
>>> +    if (ret < 0)
>>> +        goto unlock;
>>> +
>>> +    ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START, 0);
>>> +    if (ret < 0)
>>> +        goto unlock;
>>> +
>>> +    msleep(50);
>>> +    phydev_dbg(phydev, "MCU asserted\n");
>>> +
>>> +unlock:
>>> +    phy_unlock_mdio_bus(phydev);
>>> +    return ret;
>>> +}
>>> +
>>> +static int an8811hb_mcu_deassert(struct phy_device *phydev)
>>> +{
>>> +    int ret;
>>> +
>>> +    phy_lock_mdio_bus(phydev);
>>> +
>>> +    ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START,
>>> +                   AN8811HB_MCU_SW_START_EN);
>>> +    if (ret < 0)
>>> +        goto unlock;
>>> +
>>> +    ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
>>> +                   AN8811HB_MCU_SW_RST_RUN);
>>> +    if (ret < 0)
>>> +        goto unlock;
>>> +
>>> +    msleep(50);
>>> +    phydev_dbg(phydev, "MCU deasserted\n");
>>> +
>>> +unlock:
>>> +    phy_unlock_mdio_bus(phydev);
>>> +    return ret;
>>> +}
>>> +
>>>   static int an8811hb_load_firmware(struct phy_device *phydev)
>>>   {
>>>       int ret;
>>>
>>> +    ret = an8811hb_mcu_assert(phydev);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    ret = an8811hb_mcu_deassert(phydev);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>>       ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>>>                        EN8811H_FW_CTRL_1_START);
>>>       if (ret < 0)
>>> @@ -662,6 +757,16 @@ static int en8811h_restart_mcu(struct 
>>> phy_device *phydev)
>>>   {
>>>       int ret;
>>>
>>> +    if (phy_id_compare_model(phydev->phy_id, AN8811HB_PHY_ID)) {
>>> +        ret = an8811hb_mcu_assert(phydev);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +
>>> +        ret = an8811hb_mcu_deassert(phydev);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +    }
>>> +
>>>       ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>>>                        EN8811H_FW_CTRL_1_START);
>>>       if (ret < 0)
>>> -- 
>>> 2.34.1
>>>

