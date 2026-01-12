Return-Path: <netdev+bounces-249212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7CAD158CE
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 23:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D32013025150
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9F62848AF;
	Mon, 12 Jan 2026 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQNbEixX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DCE2B2D7
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768256453; cv=none; b=PKP9kN6mj95dmA6YYcW0j1Afc1HEe372TcKfcyDm3ImevhQTd40Nnzt7OFTAABKLmzjv50ABs2U1qCSNtk2Hi08tzVF4QSLlDBmPcyoIR+3p/CXhW4g8uQ8RvfYD8Be9Qj+UrjP+xDLRBiY690nJNS4EbFxd1+dzDC02Z5LD5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768256453; c=relaxed/simple;
	bh=e5FYB1/fNb6nF+yLadcL2PHiL4zqdhkQQsF154x8X3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvNttw3Bcozgi5uLirh0GPLho3EwErbagFaABjy3rFijYM0oT4NDXKd/0VXj+/0x1nuhW8XU16rKjkl9gNwpkyFieKX7mIjvMb9QY0aWOZrNCJPbmW+QrgiPtty5kiL1y8TnavCxJJw9oymBiCnYydJ+ewBV/nCl+4KfRYYTQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQNbEixX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so55173065e9.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768256450; x=1768861250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tavby8+pMgV102dUySp64AZu6BS/ycSLvR5aVdpuOo=;
        b=WQNbEixXxHjvBFwUylCkVDQ0Sc7MwB2P/BsiIh/8p1ydvSvbngP31yaDBNV8V05vHR
         GkZFaRS/FY5BgwjEUIrQEuzOZJ6IZX6lGx9qSM9FdIk9TbyreYyB6tDrKHpDtHUtKNV2
         O9FsVpkmJzsOxV6txkwFojB8WCMAsQdVXSZJ6jmrmV0iAmQrmyigR+DTgfMMZ7I7buYP
         rgGtxUAnUsC5PnUmie+K3ZstAGvH0coc/eeDhrBMRa2+FvAq2CvCmhatpEY9oDSfLWkS
         f86Lam+GyxuNYLm5d8VBJmaLfIxoUvAFEyP5Ybk+oBSsLWGYRVFzl2e/p1Qpb3R9pb7w
         pg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768256450; x=1768861250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tavby8+pMgV102dUySp64AZu6BS/ycSLvR5aVdpuOo=;
        b=JDNIZ2ryq3kW89I9pNYEu54zcyZIaKJkuvDhtea+yU0ZXFYoEAaIoNW446h3C45psz
         ziE3JI+8XmicWl/nLT5AriQa6bUv/wSXRxLy71dI3o77YqrAcc886yAFUiYxMt8Ux7zL
         KRCF1wW2wOI6fUXGmRQJVzMgClEd7FQF6agl0y4pIg3pKX0yktGQxz1QmYPufWuXEBn6
         XIy4j8TxrWCIdnXG6p9IgWKs4QRDQXqoTwSfC1ypuadoSEhomK0Zyq1Q+/vbwSmIb4Yd
         FEu4h2U7qD2G40q87Hs8gA+lV+CjTS8iJLP8gEjCPNqsNmXEBseMrOle+y0cypH7SAUH
         8VTA==
X-Gm-Message-State: AOJu0YzsJsnbB9CsMzLdG33n5PgAmlmUB9/2DxSBYbagjkihXBQ/IIdA
	xeDRYxZrKB9WBbammQnT6G5JLR5ltCxk6WpuZFfGkCd1ut5obN84PyblFnl7OQ==
X-Gm-Gg: AY/fxX5m/hveDvktJN/Y2V8Y7cU9QqrTSPwfrNEu7xQlcMl62z9S8utH4e7hos6zSkr
	r7byvQvGNuxewIZAVk5b876vFjtuJIBoflZ10sEDNbdui2iom/SDUQ4KSGoFCDQgCWU4/qDp3ru
	bTCNBspVusyX5GBUn+bJ2OksCGO5WQM2p5zLXr1Hfybv0Z+KE+eYVbjNmnEb68mDuBHoR7MxL0e
	6Le8R3IRVbaE+XkoPHyGe5OO7NDZ84vIfK3LK9iY55rTOGdvMGogea9EWzCv0d75Qj4VwPyraSd
	goUwj87yreVe7ObYn6Ai9U912k/mvc/F8hTM53naryXlyyR4bwGpHlCcjdyKB1hsIJsEyOuifZ/
	e4X4QSXc8pLX8QGOTBLa6HGG9xIi7Q7WP5pdo9AGcff13tjP9gstrvJVOGK0usq+mq9HaCmyczY
	m6PNtedNucau1BLuvAlOfwWSHdrOweFcz2E2JnxGacwnicak8sjxBJVttsmEOEIaKG50COnEOX0
	tm7UoQHX/ajWIqF2aX6yCFihG4sbfIRPIuwKlgyzLDbVQQF
X-Google-Smtp-Source: AGHT+IEdHOJMYG5Hjr+5zqDTQhemfmkcWxA2a8ZhuGcngvkjYDX9v8veBXXD4MghZAuW4aj9q5ZNtQ==
X-Received: by 2002:a05:600c:3114:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47d84b18954mr193511765e9.2.1768256449862;
        Mon, 12 Jan 2026 14:20:49 -0800 (PST)
Received: from ?IPV6:2003:ea:8f0b:c700:d3d:9a2:daf4:1e10? (p200300ea8f0bc7000d3d09a2daf41e10.dip0.t-ipconnect.de. [2003:ea:8f0b:c700:d3d:9a2:daf4:1e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e13bsm377275975e9.7.2026.01.12.14.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 14:20:49 -0800 (PST)
Message-ID: <02c00a95-34c6-4b01-8f0a-7dbd113e26ba@gmail.com>
Date: Mon, 12 Jan 2026 23:20:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 3/3] r8169: add support for chip RTL9151AS
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260112024541.1847-1-javen_xu@realsil.com.cn>
 <20260112024541.1847-4-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260112024541.1847-4-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/2026 3:45 AM, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for chip RTL9151AS. Since lacking of Hardware
> version IDs, we use TX_CONFIG_V2 to recognize RTL9151AS and coming chips.
> rtl_chip_infos_extend is used to store IC information for RTL9151AS and
> coming chips. The TxConfig value between RTL9151AS and RTL9151A is 
> 
> different.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169.h      |  3 ++-
>  drivers/net/ethernet/realtek/r8169_main.c | 28 +++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
> index 2c1a0c21af8d..f66c279cbee6 100644
> --- a/drivers/net/ethernet/realtek/r8169.h
> +++ b/drivers/net/ethernet/realtek/r8169.h
> @@ -72,7 +72,8 @@ enum mac_version {
>  	RTL_GIGA_MAC_VER_70,
>  	RTL_GIGA_MAC_VER_80,
>  	RTL_GIGA_MAC_NONE,
> -	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1
> +	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1,
> +	RTL_GIGA_MAC_VER_CHECK_EXTEND
>  };
>  
>  struct rtl8169_private;
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 9b89bbf67198..164ad6570059 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -95,8 +95,8 @@
>  #define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
>  
>  static const struct rtl_chip_info {
> -	u16 mask;
> -	u16 val;
> +	u32 mask;
> +	u32 val;
>  	enum mac_version mac_version;
>  	const char *name;
>  	const char *fw_name;
> @@ -205,10 +205,20 @@ static const struct rtl_chip_info {
>  	{ 0xfc8, 0x040,	RTL_GIGA_MAC_VER_03, "RTL8110s" },
>  	{ 0xfc8, 0x008,	RTL_GIGA_MAC_VER_02, "RTL8169s" },
>  
> +	/* extend chip version*/
> +	{ 0x7cf, 0x7c8, RTL_GIGA_MAC_VER_CHECK_EXTEND },
> +
>  	/* Catch-all */
>  	{ 0x000, 0x000,	RTL_GIGA_MAC_NONE }
>  };
>  
> +static const struct rtl_chip_info rtl_chip_infos_extend[] = {
> +	{ 0x7fffffff, 0x00000000, RTL_GIGA_MAC_VER_64, "RTL9151AS", FIRMWARE_9151A_1},
> +

Seems all bits except bit 31 are used for chip detection. However register is
named TX_CONFIG_V2, even though only bit 31 is left for actual tx configuration.
Is the register name misleading, or is the mask incorrect?


> +	/* Catch-all */
> +	{ 0x00000000, 0x00000000, RTL_GIGA_MAC_NONE }
> +};
> +
>  static const struct pci_device_id rtl8169_pci_tbl[] = {
>  	{ PCI_VDEVICE(REALTEK,	0x2502) },
>  	{ PCI_VDEVICE(REALTEK,	0x2600) },
> @@ -255,6 +265,8 @@ enum rtl_registers {
>  	IntrStatus	= 0x3e,
>  
>  	TxConfig	= 0x40,
> +	/* Extend version register */
> +	TX_CONFIG_V2	= 0x60b0,
>  #define	TXCFG_AUTO_FIFO			(1 << 7)	/* 8111e-vl */
>  #define	TXCFG_EMPTY			(1 << 11)	/* 8111e-vl */
>  
> @@ -2351,6 +2363,15 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
>  	.get_eth_ctrl_stats	= rtl8169_get_eth_ctrl_stats,
>  };
>  
> +static const struct rtl_chip_info *rtl8169_get_extend_chip_version(u32 txconfigv2)
> +{
> +	const struct rtl_chip_info *p = rtl_chip_infos_extend;
> +
> +	while ((txconfigv2 & p->mask) != p->val)
> +		p++;
> +	return p;
> +}
> +
>  static const struct rtl_chip_info *rtl8169_get_chip_version(u16 xid, bool gmii)
>  {
>  	/* Chips combining a 1Gbps MAC with a 100Mbps PHY */
> @@ -5543,6 +5564,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	/* Identify chip attached to board */
>  	chip = rtl8169_get_chip_version(xid, tp->supports_gmii);
> +
> +	if (chip->mac_version == RTL_GIGA_MAC_VER_CHECK_EXTEND)
> +		chip = rtl8169_get_extend_chip_version(RTL_R32(tp, TX_CONFIG_V2));
>  	if (chip->mac_version == RTL_GIGA_MAC_NONE)
>  		return dev_err_probe(&pdev->dev, -ENODEV,
>  				     "unknown chip XID %03x, contact r8169 maintainers (see MAINTAINERS file)\n",


