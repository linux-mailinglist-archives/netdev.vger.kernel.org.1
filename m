Return-Path: <netdev+bounces-261300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBbjERowoGmLgAQAu9opvQ
	(envelope-from <netdev+bounces-261300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:35:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A571A5279
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9DCA30C73B6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85978374736;
	Thu, 26 Feb 2026 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHIgb3r2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D237416E
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105655; cv=none; b=qNGulKxChMujB5fWNPmS7bXtrdymKHSjSbdFbb7W1B2o4Ukysl/WiqPm48Rr1rCfZTJCYS2t9wlCSsITfE0zcd2wj906FnIv1MXP2yiD/6oLkgbtr1cXRUkn9XypCuvq1SOrk9FrcKO+vOGVZ7Zt7rxo/Cw08kMThzk2mUfil/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105655; c=relaxed/simple;
	bh=vzLjgUo8sEzeWsoG/ZrURZKNZ3wEdOprVFXTzgadt3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWcVwJvHLer0BHRsWuYokc2XaVPWRtmMOaLZVOX2fQOjmh76GOC/x89ZCSTQjRgKloirlcbaKZlIk6tEUKqjSsewETDqtoGFZE/R0X8jOmSlOW6msCr5p5mdzyOghncY0ty29etJHA/wOJbqYuZTHmT3jBv1gN0rqYhUArpORBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHIgb3r2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772105653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKKbKDKeeGzX9hOTv641TR8mAiL2GCNqFtF0g7/bl6Y=;
	b=fHIgb3r2YfgaXwpoeX76SgCC6qo7hKM2CuqTKN5sM4ZISlNDLLuNvQF7Os4zQr4C9AfdpT
	X2nelMBVQUHu0mi29TlClYJEELxngb3Sp8yc1Ps8XiWNUAZWjP6Vb505cjia24MBs0bflt
	faCLYjziim22pCHQzAae1IHdmIYmbLE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-CQwMgTzbNQey5SHIhrM51Q-1; Thu,
 26 Feb 2026 06:34:09 -0500
X-MC-Unique: CQwMgTzbNQey5SHIhrM51Q-1
X-Mimecast-MFC-AGG-ID: CQwMgTzbNQey5SHIhrM51Q_1772105648
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EA8F19560A7;
	Thu, 26 Feb 2026 11:34:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.206])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E131D1800671;
	Thu, 26 Feb 2026 11:34:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: javen_xu@realsil.com.cn
Cc: kuba@kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	horms@kernel.org,
	edumazet@google.com,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v5] r8169: add support for RTL8125cp
Date: Thu, 26 Feb 2026 12:33:50 +0100
Message-ID: <20260226113350.119833-1-pabeni@redhat.com>
In-Reply-To: <20260224025335.298-1-javen_xu@realsil.com.cn>
References: <20260224025335.298-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,lunn.ch,vger.kernel.org,google.com,gmail.com,realtek.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-261300-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.993];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: B8A571A5279
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
r8169: add support for RTL8125cp

This patch adds support for chip RTL8125cp with XID 0x708, applying
different firmware (rtl8125cp-1.fw) and a dedicated PHY configuration
function.

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

[ ... ]

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 2f7d9809c373..d040f2074db6 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -4021,6 +4026,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
>  		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
>  		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
>  		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
> +		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
>  		[RTL_GIGA_MAC_VER_80] = rtl_hw_start_8127a,

RTL_GIGA_MAC_VER_65 (RTL8125CP) maps to rtl_hw_start_8125d, which is also
used by VER_64 and VER_66. However, these versions need special handling in
rtl_hw_start_8125():

static void rtl_hw_start_8125(struct rtl8169_private *tp)
{
	...
	switch (tp->mac_version) {
	case RTL_GIGA_MAC_VER_61:
	case RTL_GIGA_MAC_VER_64:
	case RTL_GIGA_MAC_VER_66:
	case RTL_GIGA_MAC_VER_80:
		for (i = 0xa00; i < 0xb00; i += 4)
			RTL_W32(tp, i, 0);
		if (tp->mac_version == RTL_GIGA_MAC_VER_80)
			RTL_W16(tp, INT_CFG1_8125, 0x0000);
		break;
	default:
		break;
	}
	...
}

Should RTL_GIGA_MAC_VER_65 be added to this case group? Both VER_64 and
VER_66, which share the same rtl_hw_start_8125d function as VER_65, are
explicitly listed here to disable interrupt coalescing (clearing registers
0xa00-0xb00). Without this, the RTL8125CP may operate with stale interrupt
coalescing settings, potentially causing incorrect interrupt delivery.

> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
> index 032d9d2cfa2a..f78c3dd36483 100644
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
> +	phy_modify_paged(phydev, 0x0a43, 0x10, 0x0000, 0x0003);
                                                           ^^^^^^

Andrew Lunn suggested in v4 review that magic bit values should be replaced
with named constants. The value 0x0003 sets bits for 'link speed 10m PLL
OFF' (bit 0) and 'ALDPS PLL OFF' (bit 1). This would improve code
readability and maintainability. Andrew suggested defines like
RTL8125CP_LINK_SPEED_10M_PLL_OFF BIT(0), RTL8125CP_ALDPS_PLL_OFF BIT(1),
etc.

Reference: https://lore.kernel.org/netdev/1a36b013-ae9b-4d51-8259-92728644ceab@lunn.ch/

> +	phy_modify_paged(phydev, 0x0a44, 0x11, 0x0000, BIT(7));
> +
> +	rtl8125_legacy_force_mode(phydev);
> +	rtl8168g_disable_aldps(phydev);
> +	rtl8125_config_eee_phy(phydev);
> +}
> +
>  static void rtl8125bp_hw_phy_config(struct rtl8169_private *tp,
>  				    struct phy_device *phydev)
>  {

[ ... ]


