Return-Path: <netdev+bounces-255509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /QUmNr9wfmkrZAIAu9opvQ
	(envelope-from <netdev+bounces-255509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:14:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D0C3F69
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE92530136B5
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 21:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85134378D87;
	Sat, 31 Jan 2026 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPx56WoV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB13783D8
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769894074; cv=none; b=CFvEGN4DmcT2VKslkdZluMSHjLtKIVRpKWBXQ7J5hoUq6H8lM5TmcAvc3LGB1J1hNarGFAw/27vsgj+MO2WLne6gKhgQaaZQwRUcRUiJoz41n9j75kbkxOO8I3390+LusgyFphhrhwS2PJ++6uG2EWw7D4Fhqr9CKSCOzD3O8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769894074; c=relaxed/simple;
	bh=YimQ5Gpsk7AV+Xg0nqprhCWbGTKfYP+i4UufQlaYyD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hr1sSilIoRJfYCzzIkZL4asCF5KktlUppgRxWTkPlttbCsKoVc8VIFJmJoE9hZb5cTSveOqFqN+v1UW4l5bc32UVk46CzjznKbHDW0uNX0Mvec6lonoPnQVuBS1wu76m7LC+7zfHDlmZJnMtsikB0gr3nyjnxWUA9QRsLq+9xdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPx56WoV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so2749576f8f.2
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 13:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769894071; x=1770498871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DSRmhSOWMyQaoOst4wqmyyGez5fQcxTCcSuSIom8eOk=;
        b=gPx56WoVLG32/jyFfqCfplWpBHwSBueeUKWIXcGV++P2oV9d4b2FhJ6FwlS3VUfaLs
         9uSDXlt+smg8g4KJq4dyTXyRAWvlojpx5H6T9LVkaUf796Q/JjZAF3VyvEWk12w3cDYZ
         GS85MoVh6B5sRcW5aXUNTJJNub5UCWrIzhrTXy6aBIy7853tqndZKCC/FBhZKeKg7Vrz
         ZAtZHRCmVR9KQT7ARdJyrc8CD13WdbyrAAPD5H2k6GsVDA1suvZZQAaYcQtfRwoZ0NO9
         QpvdWa8aui9V0ilNEpkJgra5q/O/Fti6DV95ADSdt64TDxEFFPjD6mQ8OFfVG//i1Z0T
         jjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769894071; x=1770498871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSRmhSOWMyQaoOst4wqmyyGez5fQcxTCcSuSIom8eOk=;
        b=a4Ipnl/yYF1vxu6MfK2GGGuTzGuDMNU9N57viodMKmo1//B7kxqN0L1WHS0yrU7Ys8
         Y97DNcIxub/2qDEgtR6z7E/Y0DtzGyOuPuCU9xDrDMjvam7R4SkZU/WeXBf1j0nmNkz0
         lJ9ce7U3a6EhufjcS/+fCk0Er2qihfCnnlpRrJ/Mg2BT8Gd+1Brrv2jxd2awwBBK+47l
         krxP2HbnStDUY8sONsvqJh1AB8G1NR4u5pZ65GGDUh2CfxP/O8CDC/R29A6DihQKnpVi
         ucKgzfb6oTAKEwtn2OPFalM9SeqUxQpBq3vLMT2YZ4/WsjvU7fOPPD2B8mRz9OvtscVe
         P3pw==
X-Gm-Message-State: AOJu0YxLO+pboc5kPbe5gIuuMMKbsw8se2X1aXM2v6qdILxJ+WrMcjHj
	f3p7fnZ1xChU8vP6kWmrXUxRVYbzItlPjjoinSKcOfGCHBDF46VkyPUp
X-Gm-Gg: AZuq6aICZdvsSgZL0UvZVoRWDQEtOaPAos4P0LY4B9LtrIDMRR+9CvFSyZ+5BYatUOi
	vZRzw4m8TXkTlCiEe3cZ85Y20bSj7QEQ+ACofAIyKOHriY61hf5UUL68tdSpITs5FizYlWmuqg0
	2RZyse4M0w+Ybq7d/MIvksb161bULmcu3w698O8Yrqh8eMPnb1CdQakb1d+dv1CQ4ihPqWal28s
	JKOobwPa//u04EcnJWzpnxT9ZkOqwXcYeb6vSu6P29gnRtSfnG+IB4Ecp+6LRy8BQ+mx/+1wcs6
	wiQKgjt4LwWbpVR99DJoUgeWY+J/8pVxtPqCvUyiZwztTA6Z3I4i4h1ZfaGzyM8NaTazSRHU5un
	PTIfyrQyDUsQHtMOGgKxk8GyphzgdW1x3Ax0FJ7j/R8uTf3mf3/A8GikK7hWcZp2ka+Ff6CacVp
	qq+ArCy2w56J+kEYctUSi/Xnm9x4bRgdGmgQOlXKT0/SrX0Bjbw2Em214iZQj66emetcRG4YmWF
	EUSeC4a6oOhu+kB+NbWFZlAW3zMeaOo8HBi2hIUw2HQUnIRtg1ohw==
X-Received: by 2002:a05:6000:1acf:b0:430:fc5a:40ac with SMTP id ffacd0b85a97d-435f3ab2d5bmr10642148f8f.54.1769894071028;
        Sat, 31 Jan 2026 13:14:31 -0800 (PST)
Received: from ?IPV6:2003:ea:8f06:cc00:7c9c:29ad:3b80:4973? (p200300ea8f06cc007c9c29ad3b804973.dip0.t-ipconnect.de. [2003:ea:8f06:cc00:7c9c:29ad:3b80:4973])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354205sm32350593f8f.41.2026.01.31.13.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 13:14:29 -0800 (PST)
Message-ID: <0960233e-d0aa-4819-8a5b-ed43b2b08aed@gmail.com>
Date: Sat, 31 Jan 2026 22:14:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] r8169: add support for RTL8125cp
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130093545.1753-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260130093545.1753-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255509-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C4D0C3F69
X-Rspamd-Action: no action

On 1/30/2026 10:35 AM, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for chip RTL8125cp. Its XID is 0x708. We apply
> different and firmware for RTL8125cp.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169.h          |  1 +
>  drivers/net/ethernet/realtek/r8169_main.c     |  6 +++++
>  .../net/ethernet/realtek/r8169_phy_config.c   | 22 +++++++++++++++++++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
> index aed4cf852091..0b9c1d4eb48b 100644
> --- a/drivers/net/ethernet/realtek/r8169.h
> +++ b/drivers/net/ethernet/realtek/r8169.h
> @@ -68,6 +68,7 @@ enum mac_version {
>  	RTL_GIGA_MAC_VER_61,
>  	RTL_GIGA_MAC_VER_63,
>  	RTL_GIGA_MAC_VER_64,
> +	RTL_GIGA_MAC_VER_65,
>  	RTL_GIGA_MAC_VER_66,
>  	RTL_GIGA_MAC_VER_70,
>  	RTL_GIGA_MAC_VER_80,
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 2f7d9809c373..d040f2074db6 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -60,6 +60,7 @@
>  #define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
>  #define FIRMWARE_8125K_1	"rtl_nic/rtl8125k-1.fw"
>  #define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
> +#define FIRMWARE_8125CP_1	"rtl_nic/rtl8125cp-1.fw"
>  #define FIRMWARE_9151A_1	"rtl_nic/rtl9151a-1.fw"
>  #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
>  #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
> @@ -112,6 +113,9 @@ static const struct rtl_chip_info {
>  	/* 8125BP family. */
>  	{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66, "RTL8125BP", FIRMWARE_8125BP_2 },
>  
> +	/* 8125CP family*/
> +	{ 0x7cf, 0x708, RTL_GIGA_MAC_VER_65, "RTL8125CP", FIRMWARE_8125CP_1 },
> +
>  	/* 8125D family. */
>  	{ 0x7cf, 0x68b, RTL_GIGA_MAC_VER_64, "RTL9151A", FIRMWARE_9151A_1 },
>  	{ 0x7cf, 0x68a, RTL_GIGA_MAC_VER_64, "RTL8125K", FIRMWARE_8125K_1 },
> @@ -802,6 +806,7 @@ MODULE_FIRMWARE(FIRMWARE_8125D_1);
>  MODULE_FIRMWARE(FIRMWARE_8125D_2);
>  MODULE_FIRMWARE(FIRMWARE_8125K_1);
>  MODULE_FIRMWARE(FIRMWARE_8125BP_2);
> +MODULE_FIRMWARE(FIRMWARE_8125CP_1);
>  MODULE_FIRMWARE(FIRMWARE_9151A_1);
>  MODULE_FIRMWARE(FIRMWARE_8126A_2);
>  MODULE_FIRMWARE(FIRMWARE_8126A_3);
> @@ -4021,6 +4026,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
>  		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
>  		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
>  		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
> +		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
>  		[RTL_GIGA_MAC_VER_80] = rtl_hw_start_8127a,
> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
> index 032d9d2cfa2a..1896d0ce42ac 100644
> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
> @@ -1102,6 +1102,27 @@ static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
>  	rtl8125_config_eee_phy(phydev);
>  }
>  
> +static void rtl8125cp_hw_phy_config(struct rtl8169_private *tp,
> +				    struct phy_device *phydev)
> +{
> +	r8169_apply_firmware(tp);
> +	rtl8168g_enable_gphy_10m(phydev);
> +
> +	phy_modify_paged(phydev, 0xad0, 0x17, 0x007f, 0x000b);
> +	phy_modify_paged(phydev, 0xad7, 0x14, 0x0000, BIT(4));
> +	rtl8125_phy_param(phydev, 0x807f, 0xff00, 0x5300);
> +	r8168g_phy_param(phydev, 0x81b8, 0xffff, 0x00b4);
> +	r8168g_phy_param(phydev, 0x81ba, 0xffff, 0x00e4);
> +	r8168g_phy_param(phydev, 0x81c5, 0xffff, 0x0104);
> +	r8168g_phy_param(phydev, 0x81d0, 0xffff, 0x054d);
> +	phy_modify_paged(phydev, 0xa43, 0x00, 0x0000, 0x1001);

This looks weird. In case of paged access the register usually
is in the range 0x10 .. 0x17.

> +	phy_modify_paged(phydev, 0xa44, 0x11, 0x0000, BIT(7));
> +
> +	rtl8125_legacy_force_mode(phydev);
> +	rtl8168g_disable_aldps(phydev);
> +	rtl8125_config_eee_phy(phydev);
> +}
> +
>  static void rtl8125bp_hw_phy_config(struct rtl8169_private *tp,
>  				    struct phy_device *phydev)
>  {
> @@ -1344,6 +1365,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
>  		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
> +		[RTL_GIGA_MAC_VER_65] = rtl8125cp_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_66] = rtl8125bp_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_80] = rtl8127a_1_hw_phy_config,


