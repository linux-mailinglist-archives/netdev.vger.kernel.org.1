Return-Path: <netdev+bounces-272860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fUh9JhizyGm1pAUAu9opvQ
	(envelope-from <netdev+bounces-272860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 07:05:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D6D350C96
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 07:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5255300BDAB
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 05:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E569E23A984;
	Sun, 29 Mar 2026 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYbhE9DS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473F1E5B63
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 05:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774760695; cv=none; b=HERC/n+OWz4usl6MJA8NyUCqBKoKgTEvMsPznyea5aMhR7GhThupvJznJTZAT+PxImsrRX6C803G8rSiv08F/LCtBNv2HaqSVRBQXmpkuF+0nICJ8T43Hw0ip6LFmbRZjsekcWvYKtGNYoiqGQQWRNwIQ/j7YcBroRBInrWoUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774760695; c=relaxed/simple;
	bh=YsmQIxTiRjmI+JRHgsQd4RviKt0EcrsKyidXL2UsypQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgSvC5MufcpfI/jQE0QO1hcGFMDo8DBr3mHXNjd9GwugZzn453lEiVBlWJW8+jzd4GIkD6HYAbC5DFw4XnbVaIEMMD2K8ml9CLMbSMYetFVaKZHqSUWLHtLkLVVGR5IDwrd6Jsjvlnv0XXp37qPdw6d5vKlqgmpmEjTHHZTYiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYbhE9DS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82a67ce6969so2617949b3a.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 22:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774760694; x=1775365494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGypEvtCOYQMr1Ct5ICI/amTFZd7Yh8geLd8yNwqV00=;
        b=JYbhE9DSeJ1Ejx0XRl9jIcJiQTvS//UpztS5gtOjyLAG33sM/NhaAQ/iitMBSYPssY
         uY7tGIcHvfYK2GYk9DNZmvUOAB+hzvbi8Pvg35k0DR/xGJ3ehGbxZ/LUlMilR8mMzpCi
         QuO9039/M49JKN26lyP79yTmDwVwyvsHxva34cGB/x96fZBve9yrFYZIr7Ssp+nHUl9h
         8IAAVVuESEWp01aCrNC4ASmlcUGY+p18lgCsUbeLhYqcmmliEQBFvg1u81t6RXb7HMsi
         wUTNiuzAUlUXEN2KQVvO5qtzqne0GVxwP/MfaEun1G0MKFAAWHbJ4AdiCvUY1N6tE3bM
         KIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774760694; x=1775365494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGypEvtCOYQMr1Ct5ICI/amTFZd7Yh8geLd8yNwqV00=;
        b=TmmIVxxWBkMHf+JmrYfn8pRoO3f0rR3sPN+OvlLEBkU7Z838nFL77ybZuldDTHP4AO
         RcYkYx3i1hrqSCkOyMPr1LAj/NhNe2Ov9Dznw4pj1pySr4ias4cfhouhTlh+5SKWltzY
         PR57PNM30tzVHWGLs8X+C3XQUF5CndlUGit8xxpqIApPDZwVlNaFrkY9fusNnCB7+deU
         M5W/lTN6YdXeuOko92OXAYmu8+wruXy5b91I3FdZjDyOGvGt0Q9/4r+nUnPEgFPH6odI
         6U0hkugHbJwafCv1CN/Y5Z8q5pPLVmvtSN3sEg94DqEaM9CPgYNJeMGAW7YxvJP07WB6
         rQZg==
X-Forwarded-Encrypted: i=1; AJvYcCVNm/qc5SSs7JnwtlRufXGA4iQxdgXsO+Q3Ia33mmie/fSXLzzRUF2XtCoaN+EEolZogE3bPR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygdmVpzYReYcRf2t7ZlpcQQ2jYEuP5jeWSw/zo03Z1QVzYm96E
	QAxd9EA24d2rwz7rzZyQHbIqqgXvjxNG1TtkhaejMxr9KnDloRiNRf8C
X-Gm-Gg: ATEYQzwQWKaAFkD1RbWgbZFXiyuAvK7nIlO4/Fh+Y8goRHWYn64FP0NGBq8By6kC8y2
	eIaYyFOqZAw1lJZzwPrTXHbVr3CwS2Xmj76btaXF7cLaqWlfbmTzKejRaGcDW24H4C634mLSfIE
	8bxOM8/VYEOtd6FA8R0FkAvBHjoCmAs3nePZIC/uMaBZ5T+wgeYfK1zhU4uuZrsFne+uNeue204
	673pSAWQBj0FwNn37GEVViZJ0FB+ZfgditCmTxipMEDJiZBJFa9aI/xHZtk0pge9HLwpMG3H65h
	5cg8IFZ4zqwAkN/y2Niscn+/clrCdMR/ZYDTHEGSpHpTNWWiTeuF7SJylHsX9FZy1qT0N2NmoOd
	iXZdjS61x/Eds49687irvS6yyZR8ae3xO3gMk8yY6z/cf9BsLbsiCAESVQ4L1bFSnbxulPVHnun
	qHEe36J1awfl6kEfQU26epTHNdYVODh7fXW/gHBg5hPGbhJV7t9QWVkqcasxljBichFq/XCAh0d
	E71Ps99FAE=
X-Received: by 2002:a05:6a00:bc0b:b0:82a:7893:e14f with SMTP id d2e1a72fcca58-82c95ee41bfmr7022672b3a.41.1774760693576;
        Sat, 28 Mar 2026 22:04:53 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8467824sm3520330b3a.17.2026.03.28.22.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 22:04:52 -0700 (PDT)
Message-ID: <5de3f9ca-ffe7-40ca-93a7-fb7e8e513ec2@gmail.com>
Date: Sun, 29 Mar 2026 13:04:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
To: Eric Woudstra <ericwouds@gmail.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no
Cc: frank-w@public-files.de, daniel@makrotopia.org, lucien.jheng@airoha.com
References: <20260326153518.8387-1-lucienzx159@gmail.com>
 <edeee8e5-0de3-48ea-aeb5-cc705fdcd469@gmail.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <edeee8e5-0de3-48ea-aeb5-cc705fdcd469@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272860-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E4D6D350C96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Eric Woudstra 於 2026/3/27 下午 12:41 寫道:
>
> On 3/26/26 4:35 PM, Lucien.Jheng wrote:
>> AN8811HB needs a MCU soft-reset cycle before firmware loading begins.
>> Assert the MCU (hold it in reset) and immediately deassert (release)
>> via a dedicated PBUS register pair (0x5cf9f8 / 0x5cf9fc), accessed
>> through the PHY-addr+8 MDIO bus node rather than the BUCKPBUS indirect
>> path.  This clears the MCU state before the firmware loading sequence
>> starts.
>>
>> Add __air_pbus_reg_write() as a low-level helper for this access, then
>> implement an8811hb_mcu_assert() / _deassert() on top of it.  Wire both
>> into an8811hb_load_firmware() and en8811h_restart_mcu() so every
>> firmware load or MCU restart on AN8811HB correctly sequences the reset
>> control registers.
>>
>> Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB support")
>> Signed-off-by: Lucien Jheng <lucienzx159@gmail.com>
>> ---
>> Changes in v2:
>> - Rewrite commit message: The previous wording was ambiguous,
>>    as it suggested the MCU remains asserted during the entire
>>    firmware loading process, rather than a quick reset cycle
>>    before it starts.
>>    Clarify that assert and deassert is an immediate soft-reset
>>    cycle to clear MCU state before firmware loading begins.
>> - Add Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB
>>    support").
>> - Change phydev_info() to phydev_dbg() in an8811hb_mcu_assert() and
>>    an8811hb_mcu_deassert() to avoid noise during normal boot.
>>
>>   drivers/net/phy/air_en8811h.c | 105 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 105 insertions(+)
>>
>> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
>> index 29ae73e65caa..01fce1b93618 100644
>> --- a/drivers/net/phy/air_en8811h.c
>> +++ b/drivers/net/phy/air_en8811h.c
>> @@ -170,6 +170,16 @@
>>   #define   AN8811HB_CLK_DRV_CKO_LDPWD		BIT(13)
>>   #define   AN8811HB_CLK_DRV_CKO_LPPWD		BIT(14)
>>
>> +#define AN8811HB_MCU_SW_RST		0x5cf9f8
>> +#define   AN8811HB_MCU_SW_RST_HOLD		BIT(16)
>> +#define   AN8811HB_MCU_SW_RST_RUN		(BIT(16) | BIT(0))
>> +#define AN8811HB_MCU_SW_START		0x5cf9fc
>> +#define   AN8811HB_MCU_SW_START_EN		BIT(16)
>> +
>> +/* MII register constants for PBUS access (PHY addr + 8) */
>> +#define AIR_PBUS_ADDR_HIGH		0x1c
>> +#define AIR_PBUS_DATA_HIGH		0x10
>> +
>>   /* Led definitions */
>>   #define EN8811H_LED_COUNT	3
>>
>> @@ -254,6 +264,36 @@ static int air_phy_write_page(struct phy_device *phydev, int page)
>>   	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
>>   }
>>
>> +static int __air_pbus_reg_write(struct phy_device *phydev,
>> +				u32 pbus_reg, u32 pbus_data)
>> +{
>> +	struct mii_bus *bus = phydev->mdio.bus;
>> +	int pbus_addr = phydev->mdio.addr + 8;
>> +	int ret;
>> +
>> +	ret = __mdiobus_write(bus, pbus_addr, AIR_EXT_PAGE_ACCESS,
>> +			      upper_16_bits(pbus_reg));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = __mdiobus_write(bus, pbus_addr, AIR_PBUS_ADDR_HIGH,
>> +			      (pbus_reg & GENMASK(15, 6)) >> 6);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = __mdiobus_write(bus, pbus_addr, (pbus_reg & GENMASK(5, 2)) >> 2,
>> +			      lower_16_bits(pbus_data));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = __mdiobus_write(bus, pbus_addr, AIR_PBUS_DATA_HIGH,
>> +			      upper_16_bits(pbus_data));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
> Maybe you can use mutex_lock() and mutex_unlock() here also, like so:
>
> static int __air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
> 				u32 pbus_data)
> {
> 	int ret;
>
> 	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_EXT_PAGE_ACCESS,
> 			      (u16)(pbus_address >> 6));
> 	if (ret < 0)
> 		return ret;
>
> 	ret = __mdiobus_write(mdio->bus, mdio->addr, (pbus_address >> 2) & 0xf,
> 			      (u16)pbus_data);
> 	if (ret < 0)
> 		return ret;
>
> 	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_PBUS_DATA_HIGH,
> 			      (u16)(pbus_data >> 16));
> 	if (ret < 0)
> 		return ret;
>
> 	return 0;
> }
>
> static int air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
> 			      u32 pbus_data)
> {
> 	int ret;
>
> 	mutex_lock(&mdio->bus->mdio_lock);
>
> 	ret = __air_pbus_reg_write(mdio, pbus_address, pbus_data);
> 	if (ret < 0)
> 		dev_err(&mdio->dev, "%s 0x%08x failed: %d\n", __func__,
> 			pbus_address, ret);
>
> 	mutex_unlock(&mdio->bus->mdio_lock);
>
> 	return ret;
> }
>
> static int __air_pbus_reg_read(struct mdio_device *mdio, u32 pbus_address,
> 			       u32 *pbus_data)
> {
> 	int ret, pbus_data_low;
>
> 	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_EXT_PAGE_ACCESS,
> 			      (u16)(pbus_address >> 6));
> 	if (ret < 0)
> 		return ret;
>
> 	ret = __mdiobus_read(mdio->bus, mdio->addr, (pbus_address >> 2) & 0xf);
> 	if (ret < 0)
> 		return ret;
> 	pbus_data_low = ret;
>
> 	ret = __mdiobus_read(mdio->bus, mdio->addr, AIR_PBUS_DATA_HIGH);
> 	if (ret < 0)
> 		return ret;
>
> 	*pbus_data = (ret << 16) + pbus_data_low;
>
> 	return 0;
> }
>
> static int air_pbus_reg_read(struct mdio_device *mdio, u32 pbus_address,
> 			     u32 *pbus_data)
> {
> 	int ret;
>
> 	mutex_lock(&mdio->bus->mdio_lock);
>
> 	ret = __air_pbus_reg_read(mdio, pbus_address, pbus_data);
> 	if (ret < 0)
> 		dev_err(&mdio->dev, "%s 0x%08x failed: %d\n", __func__,
> 			pbus_address, ret);
>
> 	mutex_unlock(&mdio->bus->mdio_lock);
>
> 	return ret;
> }
>
> With:
>
> #define AIR_PBUS_DATA_HIGH		0x10
>
Thank you for your feedback.

I should add mutex_lock() and mutex_unlock() to protect these operations.

I will include this in the next version.

>>   static int __air_buckpbus_reg_write(struct phy_device *phydev,
>>   				    u32 pbus_address, u32 pbus_data)
>>   {
>> @@ -570,10 +610,65 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
>>   	return ret;
>>   }
>>
>> +static int an8811hb_mcu_assert(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +
>> +	phy_lock_mdio_bus(phydev);
>> +
>> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
>> +				   AN8811HB_MCU_SW_RST_HOLD);
>> +	if (ret < 0)
>> +		goto unlock;
>> +
>> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START, 0);
>> +	if (ret < 0)
>> +		goto unlock;
>> +
>> +	msleep(50);
>> +	phydev_dbg(phydev, "MCU asserted\n");
>> +
>> +unlock:
>> +	phy_unlock_mdio_bus(phydev);
>> +	return ret;
>> +}
>> +
>> +static int an8811hb_mcu_deassert(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +
>> +	phy_lock_mdio_bus(phydev);
>> +
>> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START,
>> +				   AN8811HB_MCU_SW_START_EN);
>> +	if (ret < 0)
>> +		goto unlock;
>> +
>> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
>> +				   AN8811HB_MCU_SW_RST_RUN);
>> +	if (ret < 0)
>> +		goto unlock;
>> +
>> +	msleep(50);
>> +	phydev_dbg(phydev, "MCU deasserted\n");
>> +
>> +unlock:
>> +	phy_unlock_mdio_bus(phydev);
>> +	return ret;
>> +}
>> +
>>   static int an8811hb_load_firmware(struct phy_device *phydev)
>>   {
>>   	int ret;
>>
>> +	ret = an8811hb_mcu_assert(phydev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = an8811hb_mcu_deassert(phydev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>>   	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>>   				     EN8811H_FW_CTRL_1_START);
>>   	if (ret < 0)
>> @@ -662,6 +757,16 @@ static int en8811h_restart_mcu(struct phy_device *phydev)
>>   {
>>   	int ret;
>>
>> +	if (phy_id_compare_model(phydev->phy_id, AN8811HB_PHY_ID)) {
>> +		ret = an8811hb_mcu_assert(phydev);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		ret = an8811hb_mcu_deassert(phydev);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>>   	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>>   				     EN8811H_FW_CTRL_1_START);
>>   	if (ret < 0)
>> --
>> 2.34.1
>>

