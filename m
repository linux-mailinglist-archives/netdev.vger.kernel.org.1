Return-Path: <netdev+bounces-272859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ma3M9mxyGm6owUAu9opvQ
	(envelope-from <netdev+bounces-272859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 07:00:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5222350C73
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 07:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE77430097F4
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 05:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F10D286400;
	Sun, 29 Mar 2026 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4dDySjW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017792EB10
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774760405; cv=none; b=glOI2chKlcV3qGQoLMF+o+7RkpgQZlq7v1XUjWCNAHQR537+MFZv2WY7e6Kkv9Yp6yEZzk8LK2K5FT/IWBYJ0NJHgl14a4BqWiBjQb3nSMOK1ZBnClx3y4daS64+WByMvurvxix2dAtyzAuBj9KN3G4/4K271icHwHwByEyAYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774760405; c=relaxed/simple;
	bh=LOtH3S8qYAKpoSp7FFj6apFYxHA7wWRgd48/9/MpHjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGsxlIMoSl3969uwD/K8wX8XZow3mJh+e6RCHhcRGZy8s7YKMFLLBQkLWnIpGX6/jRRHUr8timpTAA0hWISQM/HQQyt+W0tCEGG28ag03YEE3CuI8Qd+KI92wuXZr2qcjccQwUrTi0jk2Hk8sOViVI7DxAlh+jkrkdpozZrjFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4dDySjW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab077e3f32so14595245ad.3
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 22:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774760403; x=1775365203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlCtCV3bo5lFe242o6uj0fTlU+XxEfIY7TYvULOn41o=;
        b=d4dDySjW8f+9xq8Md5HUMSTLiIG+x+7fiKGJC4VJl4qTKl+ONuyYEWJVHbQN+euNPL
         gTHHc+Ojgx1STqu2/TkeVKI4LK4Y1nTjFOBNEIT09tmqHsmMCmVd4nuniyfNf0Gxpgts
         nxTUMLZeUffA1KdWyIzD0Ui6DUqNRmk4DGIfqJOLEKOQTr/F5KlziasZhn1ZEP2sO7Z9
         bSoPDrDdYJwAAoPN+Okq5AzNAmnYIlCIKBJ/IHHaylzTUzIv7Jjsy4qxgmHUl2ReNUuR
         rtt6/t125C+KHT0DSTRLPtJE43bMQXickAFxgKSZYFf9B9eLUUt/5Ylwrnd7dyeWLDzG
         ehxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774760403; x=1775365203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlCtCV3bo5lFe242o6uj0fTlU+XxEfIY7TYvULOn41o=;
        b=QPTTpF0LO3yjt309xa7H1Us0Ybgu3WJhlSZfkOrcdvglRs+kr7Fhc/0Z+RjCmKAszL
         LCbGe6PUa9wdo5fNJ2jzyqOercDoM0HZgBJEpeDvQusSImIbJBmkmnU8bk/Kue3P7kTr
         CrYnOeA2PGtttuHxhKY0Cq5eBkVl5qHTV58ezVdOHuN5t30/n2MLnKWgVK/2TJuXLcne
         1Y8Q7WuoE5XWW2kaldxX2E/N8YndOZFERNSGqmZ0Xif9KzoQVdEBh2apHAqUf1KIbKPU
         fpNJutO8hEXXaUbnsti1lbNpV1/GFaWcZpmPMaeZoavUbG6zLrmnY3nbmEaZHAf6N+yU
         W5Og==
X-Forwarded-Encrypted: i=1; AJvYcCUCgZXLQSo+rINxj4fo5RKsrC5Y2s6gxVTzgkaVjPoPLj5T1hUVHERNd2OXDUKP8BQwp/9f5Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZLEY7nNcpxZTspH2CAYn9/Uw2tD7EO7ZlT2dIkvKCo56b/0Td
	XLm+u2OK8Tx2hONDqsAZSpMyf+0ogv4oTKTJ5XHPffwm2YJmlRcZYH9/
X-Gm-Gg: ATEYQzzkpchiVpH40PAZ5I0D2hDjH7zrYm8wUEFuoFyKyr3bVkQAlPNCy6Fpf4M34K6
	IGxi0wdS6Nycwg3vfFaLosXGEh2LdQ6m5qgpwwuXaYWSDU4D+9nPzQ/kzRhw9senqcvfWbWVB+K
	F1c/BCNDBaSC67B5zR4iehFWxr3O3WdyJCPQPo92nsZaoK1fih5kYgdDhuNzBt15iF0+eE4whkw
	KXcXCQD80Y74ldfRfXaetIwO9FAcCgDp6QMSishFyqx+J0d6NihD/GhHxANqkxVT15zQY6sd/Bn
	xMXfuizApHip3huaD9Z/FZYA81YTyIKQWIo/OrmoQCGjuJ6YzMEOIA4x4iIzPpSMHEJWqgEGKia
	wst1Goo5PfROuCFy7f+uxZlDlB9MgBKDsPVcUNx2sR8IRajZ0ZGZMvCT45fwssbdneudH9B1Kaf
	I9HjAlPK47WoQVxqyWfM1laAs1XFyvbnngACXWsMTi0z2LRnrjNCKRZokkUFqprS17e+AQLxyPI
	J+IQ2xl8xo=
X-Received: by 2002:a17:903:1a2f:b0:2b0:6a3d:36e9 with SMTP id d9443c01a7336-2b0cdcb73d7mr82282055ad.33.1774760403187;
        Sat, 28 Mar 2026 22:00:03 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24276689asm38292635ad.38.2026.03.28.22.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 22:00:02 -0700 (PDT)
Message-ID: <3ea0140a-4805-4fd1-a311-695f38d8bdef@gmail.com>
Date: Sun, 29 Mar 2026 12:59:58 +0800
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
 <d59bfdca-08cb-4595-8583-eec61e282599@gmail.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <d59bfdca-08cb-4595-8583-eec61e282599@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272859-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[public-files.de,makrotopia.org,airoha.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: C5222350C73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Eric Woudstra 於 2026/3/27 上午 04:00 寫道:
>
> On 3/26/26 4:35 PM, Lucien.Jheng wrote:
>> AN8811HB needs a MCU soft-reset cycle before firmware loading begins.
>> Assert the MCU (hold it in reset) and immediately deassert (release)
>> via a dedicated PBUS register pair (0x5cf9f8 / 0x5cf9fc), accessed
>> through the PHY-addr+8 MDIO bus node rather than the BUCKPBUS indirect
>> path.  This clears the MCU state before the firmware loading sequence
>> starts.
> Perhapse you can register this extra device in the probe() function:
>
> struct mdio_device *mdiodev;
>
> mdiodev = mdio_device_create(phydev->mdio.bus,
> 			     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);
> if (IS_ERR(mdiodev))
> 	return PTR_ERR(mdiodev);
>
> ret = mdio_device_register(mdiodev);
> if (ret) {
> 	mdio_device_free(mdiodev);
> 	return ret;
> }
>
> priv->pbusdev = mdiodev;
>
> In the define part add:
>
> #define EN8811H_PBUS_ADDR_OFFS	8
>
> Add to struct en8811h_priv:
>
> struct mdio_device	*pbusdev;
>
> And in the remove function:
>
> mdio_device_remove(priv->pbusdev);
> mdio_device_free(priv->pbusdev);
>
> Then you can use the device:
>
> ret = en8811hb_some_neat_function(priv->pbusdev);

Thank you for the feedback

I will handle the registration of this extra device within the probe 
function in the next version.


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

