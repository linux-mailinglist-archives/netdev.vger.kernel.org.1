Return-Path: <netdev+bounces-288693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKRJG7BkCWqBYAQAu9opvQ
	(envelope-from <netdev+bounces-288693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:48:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C519E55F8F8
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BE25300A8FC
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 06:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0D3238C36;
	Sun, 17 May 2026 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL+Gn/K9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5078F3A
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779000492; cv=none; b=hVIE8BHyXnPHCqS8XEJd7IZRQvZKftcTQ50EPooe0aO4WxB1rOWFgUgfDdCFQMfJnxsBKubabNrUXjhj3XrJaqxyOKC3HXWX9TwnUlyaBGdC23duPMF8PQ71UdqCpwfjqv/kTOIkLrcs6lEOHGThUEVjAUEBMDZTJEZb1sTlUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779000492; c=relaxed/simple;
	bh=IMG/TtO815y4DUvbCmam26fel7GYnVBHf3uVjSR/nA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFI2sfR/3cQc5Sp7ITGOuZntLAhSqJUo+MaGIKUxvdM47cxkXS/aX9yFgC6Qt4Jr0xPSsVz1TPaRc6AQVad/jmuTvyt/GlxixPvKdkgu6ZYsKN7dTS5rQ/WzvGEkJmZHO64ZY46YAbuZbxi3qaEk/c0E4JxHEuuKNgidbR2YCnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aL+Gn/K9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c795f441ff7so914491a12.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 23:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779000490; x=1779605290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBQkF6hC6Hi/wZoekZhkOQHLAGZeapuCWopFYLJNkbw=;
        b=aL+Gn/K9IGUHcHiG5hY/WvZ1oOgJGUP8QvCPDwUy1zBRYX5KhPXK7FnQj8lEG+5b6m
         HHvuGEKXcrwYQrqHGQDZ/PmQy9rv287hHK7TC4rb2TBXQiClf6Qts+WA/qGKdUcmpKzX
         Ma12HqpxpjbhS3Xfc5g9NR0PWV2uQvSwrJ8VMlnRnDdGCd/khTPK/Y0letsxUqFuTBnU
         ynVvMbO4b3X5ieAiMRMl0KWMJVU05+yd1keBY7ljEbHCRYZPTt5JlwmP33R2GwaBMztO
         ApK3FYxfqsAb6T7tKsMVqQv1A8ym88PREv6txu9HNkzHvu9RBXtrtGK58QhsS1+JvWZa
         RlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779000490; x=1779605290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBQkF6hC6Hi/wZoekZhkOQHLAGZeapuCWopFYLJNkbw=;
        b=jb2vKOK1V9Vxb3ZToSK/lq/U3i5pYqEd8STtD3trcdQHYgw8qx0qXHmPxww/NeB0UV
         1I1W3J37MI3xhIz6Iq1IOJe18ouBfnDdC4KlUIOg26/TxYMO+EqikJPjQeqT1K2mJ+FB
         +JhL6rB4iI3IdKDx2eshYnfwyJULJdhuKCR4g/xGygPzGNv5go67b1e4okZgg+2rWj2w
         0GAm+QtyTnFQPfpAcJ+7BiLURcp9NkDYTloQBEtZJ9BXEgKNgPB10V+FM5fwKMOM2UUG
         n7RWwzkas0/Pr1JytNcN7r1s/GIP68hslvWkF4+7hoWfoegYF7Sxvc6SPl6qDrzDofsB
         uuvg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ly2SO+SAxUELFF+WjMME4oC9XGUNcl1yBJfs6fyULnE14MF3Cpw4YsJfI2ngU8cwC80JGp5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+rFT5Ft+Pk+K9MpKLXY1gAXjWBkLolk4TkHbFUOVC9PF/kV4
	6l0wwOp91SAYurUyO/W7rhnUR3Dh08rvDRDKDc+yWVmzvTF+93GpkB+b
X-Gm-Gg: Acq92OHHhowQq9dCG03zp5Klc07jzZjRoHCG1knWN+oYsr4bKsw3N0LYTQbrwaN9rvU
	+zEDzHm6TnN4MeNmY0hsGC6o36W0jTcpfUQZT7YN++9PEFQ4r0x5GPjbpxY9LH3VqJqt/v78Us7
	W2WDoEzqNe/IZ7Yp0UY66GQ5Qgwbu9tqRL6x0sPy4l3397V5DI2w+SaUVZIU0S3+A7n8I6eZSAM
	ZCcN3CzYOzZAId5FGg3DCkNo0vkvD1tMX+wWlFopXcMl5U2aAy6j3QdKta+jidmav8+/6i6DP6q
	n9ow4RmH7fkYSW5hu2B7uOor094Jg1DGfIcQOwAMcbpbEHIz2AoVa7CZkcFCkHiQr6S7keAfCmy
	S9THRO9yt9YFyraBvsYFmyIyULCJIb8irLiY9YuRg0jEKX2/qCpc9suSygJsEWBVMGSHvUqG0Hk
	1t3wNOWM+8iHoRj+0gFp9ThjL3haR/oLmqqf4BbfwCmK5B+/yuplzVsAQrSk7/A3ObEEPq4ARWv
	jcpqZjizHE=
X-Received: by 2002:a05:6a00:428c:b0:835:6173:dd2 with SMTP id d2e1a72fcca58-83f33f14d60mr11668190b3a.44.1779000490459;
        Sat, 16 May 2026 23:48:10 -0700 (PDT)
Received: from [192.168.0.6] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664a59sm10927066b3a.1.2026.05.16.23.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 23:48:10 -0700 (PDT)
Message-ID: <53ff3526-6811-41dc-adc4-b7e678bff4c4@gmail.com>
Date: Sun, 17 May 2026 14:48:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
To: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn@mork.no
Cc: ericwouds@gmail.com, frank-w@public-files.de, daniel@makrotopia.org,
 lucien.jheng@airoha.com, albert-al.lee@airoha.com
References: <20260517064254.49216-1-lucienzx159@gmail.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <20260517064254.49216-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C519E55F8F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,public-files.de,makrotopia.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	TAGGED_FROM(0.00)[bounces-288693-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienzx159@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi all

I accidentally included the changelog in the commit message. I will 
correct this in the upcoming v5 patchset.

Please ignore the v4 patch.

Thanks.

Lucien.Jheng 於 2026/5/17 下午 02:42 寫道:
> AN8811HB needs a MCU soft-reset cycle before firmware loading begins.
> Assert the MCU (hold it in reset) and immediately deassert (release)
> via a dedicated PBUS register pair (0x5cf9f8 / 0x5cf9fc), accessed
> through a registered mdio_device at PHY-addr+8.
>
> Add __air_pbus_reg_write() as a low-level helper taking a struct
> mdio_device *, create and register the PBUS mdio_device in
> an8811hb_probe() and store it in priv->pbusdev, then implement
> an8811hb_mcu_assert() / _deassert() on top of it. Add
> an8811hb_remove() to unregister the PBUS device on teardown. Wire
> both calls into an8811hb_load_firmware() and en8811h_restart_mcu()
> so every firmware load or MCU restart on AN8811HB correctly sequences
> the reset control registers.
>
> Fixes: 5afda1d734ed ("net: phy: air_en8811h: add Airoha AN8811HB support")
> Signed-off-by: Lucien Jheng <lucienzx159@gmail.com>
>
> Changes in v4:
> - Correct Fixes tag to 5afda1d734ed.
> - Refine an8811hb_probe() error paths: split cleanup into err_dev_free and
>    err_dev_create so an unregistered PBUS mdio_device is only freed, while a
>    registered one is removed then freed. Simplify with fallthrough pattern.
>
> Changes in v3:
> - Register a dedicated mdio_device for the PBUS node (addr+8) in
>    an8811hb_probe() and store it in priv->pbusdev, replacing the
>    inline addr+8 computation in v2.
> - Change __air_pbus_reg_write() to take struct mdio_device * instead
>    of struct phy_device *.
> - Add an8811hb_remove() to unregister and free the PBUS device.
> - Fix error handling in an8811hb_probe() with goto error paths to
>    ensure the PBUS device is always cleaned up on failure.
>
> Changes in v2:
> - Rewrite commit message: The previous wording was ambiguous,
>    as it suggested the MCU remains asserted during the entire
>    firmware loading process, rather than a quick reset cycle
>    before it starts.
>    Clarify that assert and deassert is an immediate soft-reset
>    cycle to clear MCU state before firmware loading begins.
> - Add Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB
>    support").
> - Change phydev_info() to phydev_dbg() in an8811hb_mcu_assert() and
>    an8811hb_mcu_deassert() to avoid noise during normal boot.
> ---
>   drivers/net/phy/air_en8811h.c | 143 +++++++++++++++++++++++++++++++++-
>   1 file changed, 139 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
> index 29ae73e65..07978979d 100644
> --- a/drivers/net/phy/air_en8811h.c
> +++ b/drivers/net/phy/air_en8811h.c
> @@ -170,9 +170,21 @@
>   #define   AN8811HB_CLK_DRV_CKO_LDPWD		BIT(13)
>   #define   AN8811HB_CLK_DRV_CKO_LPPWD		BIT(14)
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
>   /* Led definitions */
>   #define EN8811H_LED_COUNT	3
>   
> +#define EN8811H_PBUS_ADDR_OFFS	8
> +
>   /* Default LED setup:
>    * GPIO5 <-> LED0  On: Link detected, blink Rx/Tx
>    * GPIO4 <-> LED1  On: Link detected at 2500 or 1000 Mbps
> @@ -201,6 +213,7 @@ struct en8811h_priv {
>   	struct clk_hw		hw;
>   	struct phy_device	*phydev;
>   	unsigned int		cko_is_enabled;
> +	struct mdio_device	*pbusdev;
>   };
>   
>   enum {
> @@ -254,6 +267,31 @@ static int air_phy_write_page(struct phy_device *phydev, int page)
>   	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
>   }
>   
> +static int __air_pbus_reg_write(struct mdio_device *mdiodev,
> +				u32 pbus_reg, u32 pbus_data)
> +{
> +	int ret;
> +
> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_EXT_PAGE_ACCESS,
> +			      upper_16_bits(pbus_reg));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_ADDR_HIGH,
> +			      (pbus_reg & GENMASK(15, 6)) >> 6);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr,
> +			      (pbus_reg & GENMASK(5, 2)) >> 2,
> +			      lower_16_bits(pbus_data));
> +	if (ret < 0)
> +		return ret;
> +
> +	return __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_DATA_HIGH,
> +			       upper_16_bits(pbus_data));
> +}
> +
>   static int __air_buckpbus_reg_write(struct phy_device *phydev,
>   				    u32 pbus_address, u32 pbus_data)
>   {
> @@ -570,10 +608,67 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
>   	return ret;
>   }
>   
> +static int an8811hb_mcu_assert(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	ret = __air_pbus_reg_write(priv->pbusdev, AN8811HB_MCU_SW_RST,
> +				   AN8811HB_MCU_SW_RST_HOLD);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = __air_pbus_reg_write(priv->pbusdev, AN8811HB_MCU_SW_START, 0);
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
> +	struct en8811h_priv *priv = phydev->priv;
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	ret = __air_pbus_reg_write(priv->pbusdev, AN8811HB_MCU_SW_START,
> +				   AN8811HB_MCU_SW_START_EN);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = __air_pbus_reg_write(priv->pbusdev, AN8811HB_MCU_SW_RST,
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
>   static int an8811hb_load_firmware(struct phy_device *phydev)
>   {
>   	int ret;
>   
> +	ret = an8811hb_mcu_assert(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = an8811hb_mcu_deassert(phydev);
> +	if (ret < 0)
> +		return ret;
> +
>   	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>   				     EN8811H_FW_CTRL_1_START);
>   	if (ret < 0)
> @@ -662,6 +757,16 @@ static int en8811h_restart_mcu(struct phy_device *phydev)
>   {
>   	int ret;
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
>   	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>   				     EN8811H_FW_CTRL_1_START);
>   	if (ret < 0)
> @@ -1166,6 +1271,7 @@ static int en8811h_leds_setup(struct phy_device *phydev)
>   
>   static int an8811hb_probe(struct phy_device *phydev)
>   {
> +	struct mdio_device *mdiodev;
>   	struct en8811h_priv *priv;
>   	int ret;
>   
> @@ -1175,10 +1281,21 @@ static int an8811hb_probe(struct phy_device *phydev)
>   		return -ENOMEM;
>   	phydev->priv = priv;
>   
> +	mdiodev = mdio_device_create(phydev->mdio.bus,
> +				     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);
> +	if (IS_ERR(mdiodev))
> +		return PTR_ERR(mdiodev);
> +
> +	ret = mdio_device_register(mdiodev);
> +	if (ret)
> +		goto err_dev_free;
> +
> +	priv->pbusdev = mdiodev;
> +
>   	ret = an8811hb_load_firmware(phydev);
>   	if (ret < 0) {
>   		phydev_err(phydev, "Load firmware failed: %d\n", ret);
> -		return ret;
> +		goto err_dev_create;
>   	}
>   
>   	en8811h_print_fw_version(phydev);
> @@ -1191,22 +1308,29 @@ static int an8811hb_probe(struct phy_device *phydev)
>   
>   	ret = en8811h_leds_setup(phydev);
>   	if (ret < 0)
> -		return ret;
> +		goto err_dev_create;
>   
>   	priv->phydev = phydev;
>   	/* Co-Clock Output */
>   	ret = an8811hb_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
>   	if (ret)
> -		return ret;
> +		goto err_dev_create;
>   
>   	/* Configure led gpio pins as output */
>   	ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
>   				      AN8811HB_GPIO_OUTPUT_345,
>   				      AN8811HB_GPIO_OUTPUT_345);
>   	if (ret < 0)
> -		return ret;
> +		goto err_dev_create;
>   
>   	return 0;
> +
> +err_dev_create:
> +	mdio_device_remove(mdiodev);
> +
> +err_dev_free:
> +	mdio_device_free(mdiodev);
> +	return ret;
>   }
>   
>   static int en8811h_probe(struct phy_device *phydev)
> @@ -1561,6 +1685,16 @@ static int en8811h_suspend(struct phy_device *phydev)
>   	return genphy_suspend(phydev);
>   }
>   
> +static void an8811hb_remove(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +
> +	if (priv->pbusdev) {
> +		mdio_device_remove(priv->pbusdev);
> +		mdio_device_free(priv->pbusdev);
> +	}
> +}
> +
>   static struct phy_driver en8811h_driver[] = {
>   {
>   	PHY_ID_MATCH_MODEL(EN8811H_PHY_ID),
> @@ -1587,6 +1721,7 @@ static struct phy_driver en8811h_driver[] = {
>   	PHY_ID_MATCH_MODEL(AN8811HB_PHY_ID),
>   	.name			= "Airoha AN8811HB",
>   	.probe			= an8811hb_probe,
> +	.remove			= an8811hb_remove,
>   	.get_features		= en8811h_get_features,
>   	.config_init		= an8811hb_config_init,
>   	.get_rate_matching	= en8811h_get_rate_matching,

