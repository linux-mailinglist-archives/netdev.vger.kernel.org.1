Return-Path: <netdev+bounces-272372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEBWEJcKxmlxFgUAu9opvQ
	(envelope-from <netdev+bounces-272372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 05:41:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D433F26C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 05:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27D7D3042D48
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7637379998;
	Fri, 27 Mar 2026 04:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDxUzo4L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C4F35E92E
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 04:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774586499; cv=none; b=HVDJDL89PWCrtQQnqW4eUF4/yMw2zGbPqXMq0mwdGSS261SjQL6T4WK1qwbf0ikPvaGdk/kmTGRP4YLvfxfp9DbBSFjouSh1e5EuuzInZ0h0PN0kSJdG2tS11dOegGnjYoBxl5djwEdi5+9U3cQCgK0/5ffDm0et2PIC0+uP0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774586499; c=relaxed/simple;
	bh=Scua9GPZsRXj0stK9B9V9bKR3VeiqeC09MIzJurqBy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCZKJN6P0QMlQi2yCOehJnWOoB/V2KGlaH/fX4yIVd2cWO4u1WMQY/YWNMw0hvjvXLsnlEa1yV94clmjcKgV5FHCRvwGrvry7g5poih1GFK5Z6Co2FzvhkZlhI8yl3ir5kTWny9hC+1rr7IBhTpC63A4KYR/2ctslW5Y8lPbLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDxUzo4L; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b886fc047d5so265296566b.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 21:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774586496; x=1775191296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tML2KJbSCfggZr859jR0LN8Mp7QLraD7QpaCCvMrtro=;
        b=eDxUzo4Lcwq+YUxVi6jYHVHrLkixGAvMHNyuFdRWrhMxY3LAWg1UgBik6R+Jk+MlOb
         3AvrYAB7SG2JuhedsoUh9YqrpOroZbDGBGb6cfjEru0/0ybRq8xB/xn1sCJ1kdq4cSH3
         4MSahRhBaUlYHuV7pujVMfbMwMe9MXSIZfp7W/Rx7OqwAmeDc5RyjBtuaaDX5CF0SjZD
         HFPod0vlvv06GzioS+t3l+Bs5weAXz66YqFGnrRg+Fk6oppw6LX9LeHlCWEVkho0pLgA
         3BuFF1SQkL3OfSpXr1DVCiYfaHHg0iSxVNUl7d+EPaOrUJOV5Wa6WD57oQVk+GkPzZ6p
         mccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774586496; x=1775191296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tML2KJbSCfggZr859jR0LN8Mp7QLraD7QpaCCvMrtro=;
        b=FB/R2UyoBt7iP/+zRpMDg22u3MsoACx3VrNvuk0YWgrUpy94H1KV0H6yGXXO/pxH2/
         xsWBwTM/gML0O4pAC2XIdJZwjcNcaP4NTPClAc8uzJBFwuXo0BZ4M4Voo2H2wS7ISePL
         KtzOsT5NdvEVqdxKQBYVVtKi3o31x/5LSO8hg4vDJfTAptxfg3dB6GXYQR6UAHjTIpaF
         SmBF8l2zkac0vjTZQzrBQF3tYp6tCCbLUjEGCOiN7rs1gfQneSBW/CQhBVIUTE74CtUd
         GgcH6kbQ6JfXTPmzln+EOmYcKQd6hDevIz1UprRXt4wiSkUHgrnORCtlm80cssaeAK8c
         NGtg==
X-Forwarded-Encrypted: i=1; AJvYcCVQbjLSGr2TAJ0SmyTcT/1MsyGHVUXhyLZMPnZCSgr4IgvqMklVANIC0qVPodEXT1bkqgNsiKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSX4kjAlBpZkMS93gZZQG7FzwTxoh/HVVAK4oK7D0MufpykGgE
	NWHxFuorUYDvwgiwE9Cnb4BvG0Q+blYvUj60sxsG7Y22JhLeQDJYFuLi
X-Gm-Gg: ATEYQzxgQQ3IW9oqEcypDck1yPZOMFM/tMhe5fsZzqYrpKZKlWd1cUDNFpMZ/dfCQuw
	PIvAmxqskso2uolgY36rmDqeiUgec4COUCzGqDUbLUj39O0Tr8GBdAi88Z6eHIG0TNbEdFPI9ll
	7WfOYj0LzMSVMn0UQbv0TKrc6QSjhrJpRj5k+h4WotF8YvLB775oFxC+zGdzb5UPqSqk1SM4mdp
	oqmYCD1equMG7Xhp81a6k4ZBzGf0R5vvnr+0FI57k9irDU5BfL163L5CmPoG8iD8Gizyu2TGfJK
	z8RePU0UcNYoL/hw5yL5tv/UAaR1Adlm/NSORDNgM7rFLvONEPHukd/oh8v1wcNkLQCJXMxlkLE
	qY/thWllhvsY0I8yGWpVMRMsuHm2RUt3itcCrkUoagW2uCw44C/mlbV8N81lcZSZURK39/HMU3K
	pJjbclqaOdwlBkvxpqV4TvzbJSrr+W2ONTUegSba5f1pFeVuS4xlQEUlciU6Yc1Y2to6tsCAD4R
	YGUu6ahbDZiynyYXwGARbi6m1J0xgGl2RqoXI3SlOdVbVdVNuWTsc5FFz5yBeBVm4pHMAYj6yrF
	CIyQA19QXwNJuREYJetmwfpCZUJYH1Fi3w==
X-Received: by 2002:a17:907:9411:b0:b87:173f:61b with SMTP id a640c23a62f3a-b9b50175810mr59303366b.9.1774586496016;
        Thu, 26 Mar 2026 21:41:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b2021866csm200665366b.11.2026.03.26.21.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 21:41:35 -0700 (PDT)
Message-ID: <edeee8e5-0de3-48ea-aeb5-cc705fdcd469@gmail.com>
Date: Fri, 27 Mar 2026 05:41:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
To: "Lucien.Jheng" <lucienzx159@gmail.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no
Cc: frank-w@public-files.de, daniel@makrotopia.org, lucien.jheng@airoha.com
References: <20260326153518.8387-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <20260326153518.8387-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272372-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[public-files.de,makrotopia.org,airoha.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB9D433F26C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/26/26 4:35 PM, Lucien.Jheng wrote:
> AN8811HB needs a MCU soft-reset cycle before firmware loading begins.
> Assert the MCU (hold it in reset) and immediately deassert (release)
> via a dedicated PBUS register pair (0x5cf9f8 / 0x5cf9fc), accessed
> through the PHY-addr+8 MDIO bus node rather than the BUCKPBUS indirect
> path.  This clears the MCU state before the firmware loading sequence
> starts.
> 
> Add __air_pbus_reg_write() as a low-level helper for this access, then
> implement an8811hb_mcu_assert() / _deassert() on top of it.  Wire both
> into an8811hb_load_firmware() and en8811h_restart_mcu() so every
> firmware load or MCU restart on AN8811HB correctly sequences the reset
> control registers.
> 
> Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB support")
> Signed-off-by: Lucien Jheng <lucienzx159@gmail.com>
> ---
> Changes in v2:
> - Rewrite commit message: The previous wording was ambiguous,
>   as it suggested the MCU remains asserted during the entire
>   firmware loading process, rather than a quick reset cycle
>   before it starts.
>   Clarify that assert and deassert is an immediate soft-reset
>   cycle to clear MCU state before firmware loading begins.
> - Add Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB
>   support").
> - Change phydev_info() to phydev_dbg() in an8811hb_mcu_assert() and
>   an8811hb_mcu_deassert() to avoid noise during normal boot.
> 
>  drivers/net/phy/air_en8811h.c | 105 ++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
> index 29ae73e65caa..01fce1b93618 100644
> --- a/drivers/net/phy/air_en8811h.c
> +++ b/drivers/net/phy/air_en8811h.c
> @@ -170,6 +170,16 @@
>  #define   AN8811HB_CLK_DRV_CKO_LDPWD		BIT(13)
>  #define   AN8811HB_CLK_DRV_CKO_LPPWD		BIT(14)
> 
> +#define AN8811HB_MCU_SW_RST		0x5cf9f8
> +#define   AN8811HB_MCU_SW_RST_HOLD		BIT(16)
> +#define   AN8811HB_MCU_SW_RST_RUN		(BIT(16) | BIT(0))
> +#define AN8811HB_MCU_SW_START		0x5cf9fc
> +#define   AN8811HB_MCU_SW_START_EN		BIT(16)
> +
> +/* MII register constants for PBUS access (PHY addr + 8) */
> +#define AIR_PBUS_ADDR_HIGH		0x1c
> +#define AIR_PBUS_DATA_HIGH		0x10
> +
>  /* Led definitions */
>  #define EN8811H_LED_COUNT	3
> 
> @@ -254,6 +264,36 @@ static int air_phy_write_page(struct phy_device *phydev, int page)
>  	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
>  }
> 
> +static int __air_pbus_reg_write(struct phy_device *phydev,
> +				u32 pbus_reg, u32 pbus_data)
> +{
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int pbus_addr = phydev->mdio.addr + 8;
> +	int ret;
> +
> +	ret = __mdiobus_write(bus, pbus_addr, AIR_EXT_PAGE_ACCESS,
> +			      upper_16_bits(pbus_reg));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __mdiobus_write(bus, pbus_addr, AIR_PBUS_ADDR_HIGH,
> +			      (pbus_reg & GENMASK(15, 6)) >> 6);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __mdiobus_write(bus, pbus_addr, (pbus_reg & GENMASK(5, 2)) >> 2,
> +			      lower_16_bits(pbus_data));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __mdiobus_write(bus, pbus_addr, AIR_PBUS_DATA_HIGH,
> +			      upper_16_bits(pbus_data));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +

Maybe you can use mutex_lock() and mutex_unlock() here also, like so:

static int __air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
				u32 pbus_data)
{
	int ret;

	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_EXT_PAGE_ACCESS,
			      (u16)(pbus_address >> 6));
	if (ret < 0)
		return ret;

	ret = __mdiobus_write(mdio->bus, mdio->addr, (pbus_address >> 2) & 0xf,
			      (u16)pbus_data);
	if (ret < 0)
		return ret;

	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_PBUS_DATA_HIGH,
			      (u16)(pbus_data >> 16));
	if (ret < 0)
		return ret;

	return 0;
}

static int air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
			      u32 pbus_data)
{
	int ret;

	mutex_lock(&mdio->bus->mdio_lock);

	ret = __air_pbus_reg_write(mdio, pbus_address, pbus_data);
	if (ret < 0)
		dev_err(&mdio->dev, "%s 0x%08x failed: %d\n", __func__,
			pbus_address, ret);

	mutex_unlock(&mdio->bus->mdio_lock);

	return ret;
}

static int __air_pbus_reg_read(struct mdio_device *mdio, u32 pbus_address,
			       u32 *pbus_data)
{
	int ret, pbus_data_low;

	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_EXT_PAGE_ACCESS,
			      (u16)(pbus_address >> 6));
	if (ret < 0)
		return ret;

	ret = __mdiobus_read(mdio->bus, mdio->addr, (pbus_address >> 2) & 0xf);
	if (ret < 0)
		return ret;
	pbus_data_low = ret;

	ret = __mdiobus_read(mdio->bus, mdio->addr, AIR_PBUS_DATA_HIGH);
	if (ret < 0)
		return ret;

	*pbus_data = (ret << 16) + pbus_data_low;

	return 0;
}

static int air_pbus_reg_read(struct mdio_device *mdio, u32 pbus_address,
			     u32 *pbus_data)
{
	int ret;

	mutex_lock(&mdio->bus->mdio_lock);

	ret = __air_pbus_reg_read(mdio, pbus_address, pbus_data);
	if (ret < 0)
		dev_err(&mdio->dev, "%s 0x%08x failed: %d\n", __func__,
			pbus_address, ret);

	mutex_unlock(&mdio->bus->mdio_lock);

	return ret;
}

With:

#define AIR_PBUS_DATA_HIGH		0x10


>  static int __air_buckpbus_reg_write(struct phy_device *phydev,
>  				    u32 pbus_address, u32 pbus_data)
>  {
> @@ -570,10 +610,65 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
>  	return ret;
>  }
> 
> +static int an8811hb_mcu_assert(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
> +				   AN8811HB_MCU_SW_RST_HOLD);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START, 0);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	msleep(50);
> +	phydev_dbg(phydev, "MCU asserted\n");
> +
> +unlock:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}
> +
> +static int an8811hb_mcu_deassert(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START,
> +				   AN8811HB_MCU_SW_START_EN);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
> +				   AN8811HB_MCU_SW_RST_RUN);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	msleep(50);
> +	phydev_dbg(phydev, "MCU deasserted\n");
> +
> +unlock:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}
> +
>  static int an8811hb_load_firmware(struct phy_device *phydev)
>  {
>  	int ret;
> 
> +	ret = an8811hb_mcu_assert(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = an8811hb_mcu_deassert(phydev);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>  				     EN8811H_FW_CTRL_1_START);
>  	if (ret < 0)
> @@ -662,6 +757,16 @@ static int en8811h_restart_mcu(struct phy_device *phydev)
>  {
>  	int ret;
> 
> +	if (phy_id_compare_model(phydev->phy_id, AN8811HB_PHY_ID)) {
> +		ret = an8811hb_mcu_assert(phydev);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = an8811hb_mcu_deassert(phydev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>  				     EN8811H_FW_CTRL_1_START);
>  	if (ret < 0)
> --
> 2.34.1
> 


