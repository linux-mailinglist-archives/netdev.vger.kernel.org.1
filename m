Return-Path: <netdev+bounces-269556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLs4M5QrvGn4twIAu9opvQ
	(envelope-from <netdev+bounces-269556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:00:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A32CF453
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C089F32B1BD4
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE0A3ED5CE;
	Thu, 19 Mar 2026 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2zq92Xp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3A3ED121;
	Thu, 19 Mar 2026 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939085; cv=none; b=dHSAfjERD8FlPQ8g7ZaSTAo0hHl7Vhf7BZJShWmyz1xFPHxD0h6jS6Ggkvm/7ihMyqvWx9Bf1OSGVtOF2bwZaQOUlXMtqmZYs3QQhdMPc/hKA7LTOeQuWAAfk4LOHzNHmXS1ndfOzQ9U100GEdTwNnOWvef4UBVReWM23ZvBZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939085; c=relaxed/simple;
	bh=qXGdfuU2IWvRMJ+ampR0qN7gIHjvWV67g9w8g1u3QRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2G28fuXXq4VbItEkKwuGOlHYEepNFWxzWxbnMAb3h97TlQEgOymUWlQdeqygBmpf2o4W5Whtr9CUy7O/I5iOq2bR8R5z7529gFvzPWzj2u5e1c060D4UEdehpWDM1oc21RILumznhtjfmTpIxmpq12st2bhom7FqKqVF9641Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2zq92Xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757B5C19424;
	Thu, 19 Mar 2026 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773939085;
	bh=qXGdfuU2IWvRMJ+ampR0qN7gIHjvWV67g9w8g1u3QRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2zq92XpdjBDPhhnMRlSWq4Cnq2bAos4ffZHCTCFwO/ocPaY5vRqpN3i1AJjbjb28
	 FiKK9xe8nxMQBISYvHAYlg3+ECyi3E8O1Ta2C4IVU9ysbDxlX3BGLquPO4wOnbhFzj
	 vRXSilz0lY9bBn8RcZIEWjqKUpIqdj2q0vggTexujBYOVZvlisAOAYtVhEE/BkYeO+
	 iMKuQJ3w2ERpZ5iWTf0vT+bgCzsON8dKgMpJAG+kQZlEiGSJFXisF2zMrmiLu9x2UQ
	 pqUYyDDNLbie3KbtU01d4nUMj/c1jkAgaIBcFkTU5yORMg0XspxDtESV7MDT5JCxoa
	 rjFbHPotuHlgg==
From: Simon Horman <horms@kernel.org>
To: mail@birger-koblitz.de
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net
Subject: Re: [PATCH net-next v2 2/2] r8152: Add support for the RTL8157 hardware
Date: Thu, 19 Mar 2026 16:51:18 +0000
Message-ID: <20260319165118.1988383-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317-rtl8157_next-v2-2-10ea1fa488d1@birger-koblitz.de>
References: <20260317-rtl8157_next-v2-2-10ea1fa488d1@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269556-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url]
X-Rspamd-Queue-Id: 4F8A32CF453
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
r8152: Add support for the RTL8157 hardware

The RTL8157 uses a different packet descriptor format compared to the
previous generation of chips. The commit adds support for the new format,
SRAM and ADV access interfaces, and consolidates RTL8156/RTL8156B/RTL8157
initialization into a single function.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index bab8e10e5f99..05531ea43791 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -6151,15 +6562,24 @@ static void rtl8156_enable(struct r8152 *tp)
>  	u32 ocp_data;
>  	u16 speed;
>
> +	if (tp->version <= RTL_VER_16)
> +		return rtl_enable(tp);
> +
>  	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4);

Does this early return make the code after line 6581 unreachable for all
current versions? RTL_VER_16 has the value 17 in the enum (the highest
defined version), so 'tp->version <= RTL_VER_16' is always true for
VER_10, VER_11, VER_12, VER_13, VER_15, and VER_16 (all versions
assigned to use rtl8156_enable).

This skips several hardware configuration steps for existing RTL8156 and
RTL8156B devices that the old rtl8156_enable and rtl8156b_enable functions
performed:

1. PLA_MAC_PWR_CTRL4 IDLE_SPDWN_EN configuration (speed-dependent idle
   power management)
2. PLA_EEE_TXTWSYS configuration for VER_10/11 (EEE TX timer values)
3. USB_L1_CTRL L1 NYET HIRD configuration when USB speed is USB_SPEED_HIGH
4. USB_FW_TASK FC_PATCH_TASK clear/set cycle (firmware patch task toggle)

Before this patch, both rtl8156_enable (VER_10/11) and rtl8156b_enable
(VER_12/13/15) executed all of these operations unconditionally.

> @@ -6167,10 +6587,12 @@ static void rtl8156_enable(struct r8152 *tp)
>
>  	if (is_flow_control(speed))
>  		ocp_data |= IDLE_SPDWN_EN;
> +	else
> +		ocp_data &= ~IDLE_SPDWN_EN;
>
>  	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, ocp_data);
>
> -	if (tp->version == RTL_VER_10 || tp->version == RTL_VER_11)
> +	if (tp->version <= RTL_VER_11)
>  		ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x11);
>  	else
>  		ocp_write_word(tp, MCU_TYPE_PLA, 0xd4d4, 0);
> @@ -6183,12 +6605,9 @@ static void rtl8156_enable(struct r8152 *tp)
>  	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_L1_CTRL, L1_NYET_HIRD_MASK);
>
>  	if (tp->udev->speed == USB_SPEED_HIGH) {
> -		u16 val = L1_NYET_HIRD_DEFAULT;
> -
>  		/* Bits [3:0] HIRD */
> -		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_L1_CTRL);
> -		ocp_data &= ~L1_NYET_HIRD_MASK;
> -		ocp_data |= val & L1_NYET_HIRD_MASK;
> +		ocp_data = L1_NYET_HIRD_DEFAULT & L1_NYET_HIRD_MASK;
> +		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_L1_CTRL, ocp_data);
>  		ocp_write_byte(tp, MCU_TYPE_USB, USB_L1_CTRL, ocp_data);
>  	}

[ ... ]

> @@ -8252,25 +8725,27 @@ static int r8156b_init(struct r8152 *tp)
>  		}
>  	}
>
> -	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
> -	ocp_data &= ~PLA_MCU_SPDWN_EN;
> -	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
> +	if (tp->version != RTL_VER_16)
> +		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);

Is ocp_byte_clr_bits() the correct function here? PLA_MCU_SPDWN_EN is
defined as BIT(14) (0x4000), which requires 16-bit access. ocp_byte_clr_bits()
performs an 8-bit read/modify/write via ocp_read_byte/ocp_write_byte,
accessing only bits 0-7 of the register. Bit 14 is outside the byte range.

All other call sites that manipulate PLA_MCU_SPDWN_EN in this file use
ocp_read_word/ocp_write_word or ocp_word_clr_bits for 16-bit access:

drivers/net/usb/r8152.c:rtl8156_down() {
    ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
    ocp_data |= PLA_MCU_SPDWN_EN;
    ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
}

The old r8156_init code (and r8156b_init before consolidation) used
ocp_read_word/ocp_write_word.

This affects RTL_VER_12, RTL_VER_13, and RTL_VER_15 (RTL8156B) during
initialization, leaving the MCU speed-down feature incorrectly enabled.

[ ... ]

> @@ -8147,42 +8508,33 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  	rtl_phy_patch_request(tp, true, true);
>
>  	ret = r8153_phy_status(tp, 0);
> +	if (ret < 0)
> +		return;

Can this error check work correctly? r8153_phy_status() is declared as
returning u16:

drivers/net/usb/r8152.c:
static u16 r8153_phy_status(struct r8152 *tp, u16 desired)

but r8157_hw_phy_cfg() stores the result in 'int ret' and checks
'if (ret < 0)'. A u16 value assigned to int is always non-negative
(0-65535), so the condition can never be true.

drivers/net/usb/r8157_hw_phy_cfg() {
    int ret;
    ...
    ret = r8153_phy_status(tp, 0);
    if (ret < 0)  /* never true for u16 -> int */
        return;
    ...
    ret = r8153_phy_status(tp, PHY_STAT_LAN_ON);
    if (ret < 0)  /* never true for u16 -> int */
        return;
}

The other hw_phy_cfg functions (r8156_hw_phy_cfg, r8156b_hw_phy_cfg)
use 'u16 data' and don't attempt error handling on r8153_phy_status().

If the device becomes inaccessible during r8153_phy_status(), the function
continues to program PHY registers with potentially invalid values instead
of returning early.

[ ... ]

> @@ -8191,59 +8543,180 @@ static int r8156_init(struct r8152 *tp)
>
>  	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
>  	if (ocp_data & PCUT_STATUS) {

[ ... ]

> +	if (tp->version != RTL_VER_16)
> +		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);

Same issue as above - is ocp_byte_clr_bits() the correct function for
clearing BIT(14)? PLA_MCU_SPDWN_EN is 0x4000, which exceeds the 8-bit range.

The bit clear operation will fail silently because the 8-bit value read by
ocp_byte_clr_bits() cannot represent bit 14. This leaves PLA_MCU_SPDWN_EN
set when it should be cleared for VER_10, VER_11, VER_12, VER_13, and
VER_15.

Should this be:
    ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);

[ ... ]

> @@ -9541,6 +10056,7 @@ static void rtl_ops_init(struct r8152 *tp)
>  	case RTL_VER_12:
>  	case RTL_VER_13:
>  	case RTL_VER_15:
> +		ops->init		= r8156_init;
>  		ops->enable		= rtl8156_enable;
>  		ops->disable		= rtl8153_disable;

The ops->enable assignment changes from rtl8156b_enable to rtl8156_enable
for RTL_VER_12/13/15 (RTL8156B). Does the new rtl8156_enable provide the
same functionality?

As noted in the earlier issue, rtl8156_enable has an early return at line
6581 that causes it to skip the PLA_MAC_PWR_CTRL4, USB_L1_CTRL, and
FC_PATCH_TASK configuration for all current versions. The old
rtl8156b_enable performed these operations.

This could affect power management behavior, USB link stability at high
speed, and firmware flow-control configuration for RTL8156B devices.

