Return-Path: <netdev+bounces-256007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id M2ymIUAOgWnmDwMAu9opvQ
	(envelope-from <netdev+bounces-256007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:51:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA1FD14C3
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FB1730160DA
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 20:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E572A30EF80;
	Mon,  2 Feb 2026 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0xx1qsv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B642E645
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065435; cv=none; b=nsIqAlLfBaIDV50ExZfUsCk5wj3z8wcX9WhWH59h0isgsUTIZ0jepATY+eQ5LpRvuGvZXkPIZ1lPM1af7nYEZtAr0gvTxfb5cXB75PK4KQA7vg/M7i3BsSzJn6psrWIKe1iY3ZokDE6mpKc81PXQKeA2TrNQciAIb1GRn4O2wJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065435; c=relaxed/simple;
	bh=0Mv2UnXKNuE61lNLIpRpGZBoya+eYa2OWZrEI4bK9zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFmVB1QHJB1YKCiP1hBoiAJEzPijmCH8enZto6swHDddHxO4K/XjYnheSM64Me5yv4+S30mKD6qt9w8oOPFzhTbrxrZb3dMhO/7Dvsv1z/EkRfiYUJRAKGYZs6gyB+0gdF4DolB2qwvrah8mjBG85LbjJ8u00F7lc2Tlv2T18yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0xx1qsv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso41928975e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 12:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770065433; x=1770670233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79ZaT7+tLNQJBFox4Qi/6GxwY40SpKIsixlC4sAkdgA=;
        b=e0xx1qsv1WFASSCJ+g9oYLMoc7jSow1kyRpShLqIMgWqWH/L45CKnrXm8rMVNdOfCp
         VvdbMAy3wjuH7ELq/7RG97RziyDaSmsxuXWc5n8cY8EiOqGOE59ZQE7po8iEszvYp+ZY
         GM1Dsuc57PErAHQqpkYcZQWto6jzUfdGBCK6LMBrx/MwRaUKpVWHUjOcdCpzM9N8dZh8
         kzY3eTxWkvvpz+hK0ugg66PbKVs13OvIleaRdc6AYMsnyhcpB3h8FN7S3OBA41cSmYSL
         oparjcwWqu1JfS/hV8it5Wf5V0gFsXyhxEiFVaAgg2WD3ce5ZmmLvA/ExfcCZLZaDG27
         XClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770065433; x=1770670233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79ZaT7+tLNQJBFox4Qi/6GxwY40SpKIsixlC4sAkdgA=;
        b=JPSvNyOZpc+RelI48Rx/BGt78fBTgTpRiUuftnUbn9FOMJtM7cJKz0cULldviPIq4z
         +im78ylJtW+6dvXdwjQy0Uf/bxlI+VQKl6gdRDuUQLQmUkYjPriMCkLoq45ZvZvwFXmr
         Eb+iMQdnPNMXKJ5MUBWHQd730BBfdAxfgYfC2wgxgStB7Ti3md6wU2sfkkTPGkNYLiWc
         Ydpasged5rRdeqf6K5VgfVUBegFye8AgYvVjdtG8fSYW2nHwTaMHICjEmTPaRXsVUhWh
         IuXmw0wWjabEdNu1Q380JOJL8q7xNRwQvq+ip1zcojFAivk6JS3BK1Zx5EEYxSVSR+id
         c34g==
X-Gm-Message-State: AOJu0Yw/rzZ6UhIQqsmCqZ1UN08ODYhrLvXBkItUZmaSGuDg84lrQ6n8
	HpZFrk4XYlDQ5GbHNccCRTQ5Ib7Q7qm7L+KuIgOZhvJHLYyp2Dpm7Npy
X-Gm-Gg: AZuq6aK3aEs34mSJYzFC8DHAZb595rD7gk5yszDXgxncVa0meOfqxkkh8PRVuVKFhyx
	Wy/VTazycf/EGb5vjRb7c1+chUbK3XlHtE+vC27er9/OL7+WG5EDuMLxykaYyrV89vsP6MY401K
	dPtBhggse1ZMCWjOw2cb3AFfr0G154e7sASEyoezoMIvtnn1YWEaczfrQVFEBAiHPRdrQ5eGoYN
	bONngeBUsDT+WyAhFNHX3+DrbQ3omcsZwzceVzv+r8IvO6IZy54YuW8Vp58zVa02s/eJj28FVOj
	JhDUriIHliWqXZe9pWXxVC+DSI2YOhU/P9bpfK2+ZQ1hI0asPG4gEvFxhMRBbWGR/w/9O3OoObF
	KukjdlwiMCcI3a6LVxjQV9Q6maA9Tk3pTUKPNsqQodEdv8C7Map/UOGOEVehFm7JrZcAq1VqzRi
	LIPY2gkkDDUXe8GmoAQMce1JVl6fg+lPb/E2ixBqtrYc85ESF4IGGrbAm/g/PMj593FRbaSuOGb
	a8unzIiTM9uiZ+CfgJVdtg+CmHj0q+nXULynSVqueqb4Hvn
X-Received: by 2002:a05:600c:3e0b:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-482db47cda9mr168299265e9.19.1770065432448;
        Mon, 02 Feb 2026 12:50:32 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4b:2a00:742c:21a1:3b90:f2? (p200300ea8f4b2a00742c21a13b9000f2.dip0.t-ipconnect.de. [2003:ea:8f4b:2a00:742c:21a1:3b90:f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e266fbefsm98485695e9.14.2026.02.02.12.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 12:50:31 -0800 (PST)
Message-ID: <f54e4d2a-666c-444a-a79e-0df2ddec97d9@gmail.com>
Date: Mon, 2 Feb 2026 21:50:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] r8169: add support for RTL8125cp
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260202105828.54-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260202105828.54-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256007-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CA1FD14C3
X-Rspamd-Action: no action

On 2/2/2026 11:58 AM, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for chip RTL8125cp. Its XID is 0x708. We apply
> different and firmware for RTL8125cp.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> 
> ---
> v2: This patch fix one mistake on phy_modify_paged(phydev, 0xa43, 0x10,
> 0x0000, 0x1001) which is phy_modify_paged(phydev, 0xa43, 0x00, 0x0000, 0x1001) on patch v1.
> 
> v3: Set phy_modify_paged(phydev, 0xa43, 0x10, 0x0000, 0x0003), bit 0
> means 'link speed 10m PLL OFF', bit 1 means 'ALDPS PLL OFF', bit 2 means
> 'ENABLE ALDPS', bit 12 means 'ALDPS XTAL OFF'.

ALDPS is disabled two lines later in rtl8125cp_hw_phy_config().
So why bother with ALDPS settings if ALDPS is disabled anyway?

And a formal note:
A new version of a patch should be submitted >=24h later, to leave
time for further review comments.

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
> index 032d9d2cfa2a..a880df7c1f70 100644
> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
> @@ -1102,6 +1102,27 @@ static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
>  	rtl8125_config_eee_phy(phydev);
>  }
>  
> +static void rtl8125cp_hw_phy_config(struct rtl8169_private *tp,
> +				   struct phy_device *phydev)
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
> +	phy_modify_paged(phydev, 0xa43, 0x10, 0x0000, 0x0003);
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


