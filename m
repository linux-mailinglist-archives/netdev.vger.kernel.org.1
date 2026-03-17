Return-Path: <netdev+bounces-268453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGZVL0T6uGkumgEAu9opvQ
	(envelope-from <netdev+bounces-268453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:52:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9FE2A4797
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 285243008A60
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 06:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA4F347505;
	Tue, 17 Mar 2026 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRBZ5bTi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE020346FB0
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730281; cv=none; b=CCKpjvg8Huh8WsgiLrtzuYN7Np7+uAJjVg4IUtI3mIP6uBhfX2Bie28esqGSo+LPalBYG1Pu56VHh+lUhiiHxwESEOagxmMAjp9BOK7nLatCM+aabaZuEYcMcdo4zFkYp7d59+mSBlAwmQIbciCau8CBDD7butFllZVl/IY5sZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730281; c=relaxed/simple;
	bh=P6QOj79uGqUUTmFWWCgwizDSXV2Y8VLx9ZssNjQzs/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/6XPQdW54UO/nw/I2RDCkqzwemP1x4qfrVws5ZbJ35juonH0wzLAChY6JXfe8c6quX51NulQRqfl1lhXa7irS+9Wan7Xe+Qnm5qg+20DCjNkIdvOO2dXebh58BcTvrc8HWalkdyPQTlhGtXGBq0MMgM8nTxHUKx0KEod5iqi4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRBZ5bTi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so31992245e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773730278; x=1774335078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRFgjjgGVyYNyHCeB8CPE6JtG10vzKcx3Yh72acI/E8=;
        b=bRBZ5bTinHZsmVbc8rWAL2V6q6cxKX+NwI5I6nSXGTtnA0jN/hb3sBRwO3cLakRdP2
         OP0CqW82q9Of+dhxsqPL3J/H6WC57mXGf1WvfTSqgXyacoAKFuL7KHRBEeqJGi84M2FI
         PeAGQFPVOQUnUtF7YpzYN46S+GxmvjtffC7FGDw/3b15Id9cWSihd//BoNV+GIYrnlqN
         e1oXRA9cf5ufiyzVKgyEQTV51+9nIrJX8QC2HfBr1sXQzpN7Fydb0FXx09VjbRXACgLM
         TEUAv6BziXtqMNRM7Vv0A2cg8eNc3t8Yi9Y2gUswn7kGXdJV8lEXdZUKk/UafPFSrO/f
         NHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773730278; x=1774335078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRFgjjgGVyYNyHCeB8CPE6JtG10vzKcx3Yh72acI/E8=;
        b=T1jrixwHrIeexAYScdeRUk47vg6+CpqSS21m0MDJNXopA82p4vvgMnAAIjeBFB+M+L
         bgzcS439z5H21pdIbwjenEsIa97smbkiO3jB3rPz9+cfcql/f+8N/RzCCo6wjvjpV2Q9
         Xt2kRwWps+kaioshB/jYGQ8R/bz0X+Ss1sVj+EdfTx9chMf5dW+gU4pWE8GWoEeW7SVO
         o+jmcXDjrhZc//TQfZ7n4AWPlFIqGMyQyYusIq67CvpdloH7inMAyoBC/AnQEXSKct/Y
         EIpBQ7+0g4j5zUizLoDxSUlmyEDKH6/S71vtHb6Z1FJZW6sZpSSo+usIghINMEltdOcH
         9akg==
X-Forwarded-Encrypted: i=1; AJvYcCXFVlLCP5T7JH6YO5oHDDD7k7kiGzkSBHkbn360cqWzxqqxesljJo4uBfJiNV+hDWdiLZ+BdCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPwnmHT9IqRfixMAqssgD4/vxkvAdUhti28MYuLBrQp2IH4BQ
	cS699ZH4RxsxZg0IPrI9rmgtRRHKCv/ew6v8UmjJcMlfKMXOI6JGR0WU
X-Gm-Gg: ATEYQzx2Jo3fV7ciSn4RMAyVZ1ZluYuAs96r4P5vfEuT09EXUx9c00oCkk7x8EbngUx
	31zR2QW4Gnl4C8eM8cyXqHyepdS2d34Xqp/09+VQMYngbxpvPD3g93QKEMp/gDyVx+IE6wojQJ3
	b7iGu5ScqbkzMfYEPA7OZrYu8NyxvO5tTlfyL27oKom+tQpqFJ6QiV3K89YYi2PlJyBQYnMwpFp
	Fji0ja1MEAfGee2vAWRnJ0urHN4362Ah/wg+rd2QbwY6M6Z2e/RORpGB60Hl8BM2qvIjhWbLztK
	QB93bHba7XsaDSLWmlV7QVs7NExAxiIm7NXk8gzzWR2v5ogC9b3JxdGUxPiS5ciwzaRiN4WA+7x
	kdZDP7bt2ZoHoHJXhvqt9GVf22379y95zwjsPPTRZZLa8OGDxpwOsKuBEuelybsdgdu9XQ7bMvq
	JAn2R+GkYs0NdeFvODUswjCus19QuQhhrVZyhGvPXNBnifc34LeywediAfFZQ8W8S7SbRZmb882
	Cl8UhxsPUxEITbUScTBD6HGe++75gjsgMxiZMjbHQq+P0wGFaTmibf4lJz1IGHNTQ==
X-Received: by 2002:a05:600c:8b28:b0:485:a4de:f4f9 with SMTP id 5b1f17b1804b1-485a4def6dbmr14764955e9.27.1773730278003;
        Mon, 16 Mar 2026 23:51:18 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f31:8700:fc4e:d1e5:d744:5c14? (p200300ea8f318700fc4ed1e5d7445c14.dip0.t-ipconnect.de. [2003:ea:8f31:8700:fc4e:d1e5:d744:5c14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eae3396sm46175465e9.9.2026.03.16.23.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 23:51:17 -0700 (PDT)
Message-ID: <c630aa45-0904-4b3c-a1f6-90b167741d27@gmail.com>
Date: Tue, 17 Mar 2026 07:51:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v1] r8169: Fix PHY lookup for mdiobus_get_phy() and
 improve error reporting during probe
To: Anand Moon <linux.amoon@gmail.com>,
 "maintainer:8169 10/100/1000 GIGABIT ETHERNET DRIVER"
 <nic_swsd@realtek.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Shawn Lin
 <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>,
 Niklas Cassel <cassel@kernel.org>,
 "open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Danilo Krummrich <dakr@kernel.org>
References: <20260317061700.7734-1-linux.amoon@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260317061700.7734-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-268453-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rock-chips.com,163.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B9FE2A4797
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17.03.2026 07:16, Anand Moon wrote:
> The driver currently assumes the PHY is always at address 0. On some
> hardware or buggy BIOS implementations, the PHY may reside at a
> different address on the MDIO bus. Update r8169_mdio_register()
> to scan the bus for the first available PHY instead of hardcoding
> address 0.

No. The PHY always shows up at (virtual) address 0, due to the
MAC register based way of accessing the internal PHY.
Do you have any concrete example of such a "hardware or buggy bios"?

> 
> Additionally, switch to dev_err_probe() in the main probe path to
> provide standardized error handling and cleaner log output for
> registration failures.
> 
> Link: https://lore.kernel.org/all/87bc37ee-234c-4568-b72e-955c130a6838@arm.com/
> Fixes: ec392abc9593 ("PCI: dw-rockchip: Enable async probe by default")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 34 ++++++++++++++++-------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 791277e750ba..0fd735beff92 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5427,7 +5427,8 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>  {
>  	struct pci_dev *pdev = tp->pci_dev;
>  	struct mii_bus *new_bus;
> -	int ret;
> +	struct phy_device *phydev;
> +	int ret, addr;
>  
>  	/* On some boards with this chip version the BIOS is buggy and misses
>  	 * to reset the PHY page selector. This results in the PHY ID read
> @@ -5462,18 +5463,31 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>  	if (ret)
>  		return ret;
>  
> -	tp->phydev = mdiobus_get_phy(new_bus, 0);
> -	if (!tp->phydev) {
> +	/* find the first (lowest address) PHY on the current MAC's MII bus */
> +	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
> +		struct phy_device *tmp = mdiobus_get_phy(new_bus, addr);
> +
> +		if (tmp) {
> +			phydev = tmp;
> +			break;
> +		}
> +	}
> +
> +	if (!phydev) {
> +		dev_err(&pdev->dev, "no PHY found on bus\n");
>  		return -ENODEV;
> -	} else if (!tp->phydev->drv) {
> -		/* Most chip versions fail with the genphy driver.
> -		 * Therefore ensure that the dedicated PHY driver is loaded.
> -		 */

This check is needed. It's seems your actual intention is something completely
different from what you state in the commit message. You try to find a workaround
for the issues with request_module() from async contect, caused by the referenced
change to Rockchip PCI.

> +	}
> +
> +	/* Most chip versions fail with the genphy driver.
> +	 * Therefore ensure that the dedicated PHY driver is loaded.
> +	 */
> +	if (!phydev->drv) {
>  		dev_err(&pdev->dev, "no dedicated PHY driver found for PHY ID 0x%08x, maybe realtek.ko needs to be added to initramfs?\n",
> -			tp->phydev->phy_id);
> +			phydev->phy_id);
>  		return -EUNATCH;
>  	}
>  
> +	tp->phydev = phydev;
>  	tp->phydev->mac_managed_pm = true;
>  	if (rtl_supports_eee(tp))
>  		phy_support_eee(tp->phydev);
> @@ -5790,11 +5804,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	rc = r8169_mdio_register(tp);
>  	if (rc)
> -		return rc;
> +		return dev_err_probe(&pdev->dev, rc, "mdio register failure\n");
>  
>  	rc = register_netdev(dev);
>  	if (rc)
> -		return rc;
> +		return dev_err_probe(&pdev->dev, rc, "register newdev failure\n");
>  
>  	if (IS_ENABLED(CONFIG_R8169_LEDS)) {
>  		if (rtl_is_8125(tp))
> 
> base-commit: 95c541ddfb0815a0ea8477af778bb13bb075079a


