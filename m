Return-Path: <netdev+bounces-283054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDbXG9v+82n99QEAu9opvQ
	(envelope-from <netdev+bounces-283054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:16:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7254A984A
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47FE73011CB5
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BBF2D780A;
	Fri,  1 May 2026 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSeBcLSK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A7A2D7386;
	Fri,  1 May 2026 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598160; cv=none; b=NYsbxIyliGZJEKDfMlWlWHxzhSaYhdPLrCBwxR5xmXkSfnxpx1Fv2jQLNnUZLzCcXkVVQgT2mXEVFqdJB6p4HeFDoHTfSLIZkbsGYKMDvKRiNaewXUe8dWjmBYWVZdPzhwm/vSnbC12wtSCkbH7/fRZx8HUCMB5fFp2xVsuQlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598160; c=relaxed/simple;
	bh=6HJrdyZsi1s6lefwQXRWGrBfmACXYLd2R623zVVeHkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzPd/a9mzJwV5q8vB7z9PTitwLhsX71VjQc7UhKuPhalrTcJtfum7wRUaAl5Wq3b+DXRaWvA6ifjqcdrJbob8Qj2E8qCwN5EGo0SE5Y4dz0TRccJd7/59L+YT0yIVZVq/nbZyLew7zZ9CGSXr1KoifT4furC5PsPcUODyfiQ0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSeBcLSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71405C2BCB3;
	Fri,  1 May 2026 01:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777598159;
	bh=6HJrdyZsi1s6lefwQXRWGrBfmACXYLd2R623zVVeHkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSeBcLSKxEpg8t4tIjiBNskBN0BIqM0c0hUMOIVeBPYS2fjVBXpKkyV7fLx0ZQadx
	 Z8boATkyOXUXjMvcnmoMV4GrSCvUAjHzrvOPWFZyl1b1jTeptn1DPRO2Jgfy7RAXI3
	 +USzavHOE9eKqT7P4domiV9mEzuC1R2A4fm6/P/YB9N7JYpM/Rb2Krzjgbx1Zc4hHp
	 dojbrDfplA3JEp9QliXu28Z+euQLxtWOXxb7YO8SjG+jJGsSk05ftuNbDh8KFA6F5j
	 6/LyOmdR/lkwimc+p7Dj47QhhSSj9MUmPDB4T14rUUbZZm2N8q/ZYf39OzgoCp8sqs
	 +91rryCClQF1g==
From: Jakub Kicinski <kuba@kernel.org>
To: mail@birger-koblitz.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hsu.chih.kai@realtek.com
Subject: Re: [PATCH net-next v2 2/4] r8152: Add support for the RTL8159 chip
Date: Thu, 30 Apr 2026 18:15:58 -0700
Message-ID: <20260501011558.3154185-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429-rtl8159_net_next-v2-2-bab3cd4e4c66@birger-koblitz.de>
References: <20260429-rtl8159_net_next-v2-2-bab3cd4e4c66@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C7254A984A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283054-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8152: Add support for the RTL8159 chip

This patch adds support for the Realtek RTL8159 as RTL_VER_17, reusing
large portions of the existing RTL8157 (RTL_VER_16) initialization and
USB power management paths. The bulk of the new code configures the
RTL8159 PHY inside r8157_hw_phy_cfg(), and a new USB product id 0x815a
is added to the device table.

>     r8152: Add support for the RTL8159 chip
>     
>     The RTL8157 re-uses the packet descriptor format introduced with the
>     RTL8157 and other hardware features of the RTL8157 (RTL_VER_16) such
>     as the SRAM access. The support therefore consists in expanding the
>     existing RTL8157 code for initialization and USB power management
>     to also be used for the RTL8159 (RTL_VER_17).

The commit subject says RTL8159 is being added, but the body reads
"The RTL8157 re-uses the packet descriptor format introduced with the
RTL8157 ..." and later "Add support for the USB device ID of Realtek
RTL8157-based adapters." Should these occurrences of RTL8157 actually
be RTL8159?

>     Most of the addiitonal code is added in r8157_hw_phy_cfg() to configure
                ^^^^^^^^^^

Typo: addiitonal.

>     Add support for the USB device ID of Realtek RTL8157-based adapters. Detect
>     the RTL8159 as RTL_VER_17 and set it up.

The new entry in rtl8152_table is 0x815a, which breaks the earlier
0x815N-for-RTL815N naming convention (0x8157 for RTL8157, etc.). Could
the commit message explain why the RTL8159 ships with product id
0x815a?

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 01e65d845f87..2a07dde289e2 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -6894,7 +6903,7 @@ static void rtl8156_down(struct r8152 *tp)
>  			  PLA_MCU_SPDWN_EN);
>  
>  	r8153b_u1u2en(tp, false);
> -	if (tp->version != RTL_VER_16) {
> +	if (tp->version < RTL_VER_16) {
>  		r8153_u2p3en(tp, false);
>  		r8153b_power_cut_en(tp, false);
>  	}

rtl8156_down() is converted from "!= RTL_VER_16" to "< RTL_VER_16" so
that RTL_VER_17 takes the same path as RTL_VER_16. rtl8156_up() is
wired as ops->up for RTL_VER_17 in rtl_ops_init() but still uses
"!= RTL_VER_16" / "== RTL_VER_16" checks that were not converted.

In rtl8156_up():

	r8153b_u1u2en(tp, false);
	if (tp->version != RTL_VER_16)
		r8153_u2p3en(tp, false);
	...
	if (tp->version == RTL_VER_16)
		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
	...
	if (tp->version != RTL_VER_16)
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
				  RG_PWRDN_EN | ALL_SPEED_OFF);
	...
	r8153_aldps_en(tp, true);
	if (tp->version != RTL_VER_16)
		r8153_u2p3en(tp, true);

	if (tp->version != RTL_VER_16 && tp->udev->speed >= USB_SPEED_SUPER)
		r8153b_u1u2en(tp, true);

Should these checks also be "< RTL_VER_16" for RTL_VER_17?

On RTL_VER_17 the up path will call r8153_u2p3en() (USB_U2P3_CTRL)
while r8156_init() and rtl8157_runtime_enable() route through
r8157_u2p3en() (USB_U2P3_V2_CTRL) - is that intentional, or should
RTL_VER_17 go through r8157_u2p3en() on up/down too?

Similarly, is the PLA_RCR1 BIT(3) clear needed on RTL_VER_17, and is
the re-enabling of r8153b_u1u2en(true) on up intended for the new
chip given the init path deliberately skips it for RTL_VER_16?

[ ... ]

> @@ -8140,6 +8149,190 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  		sram2_write_w0w1(tp, 0x807c, 0xff00, 0x5000);
>  		sram2_write_w0w1(tp, 0x809d, 0xff00, 0x5000);
>  		break;
> +
> +	case RTL_VER_17:

[ ... snipped, PHY register table ... ]

> +		break;
> +
>  	default:
>  		break;
>  	}
> @@ -8175,6 +8368,18 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  	set_bit(PHY_RESET, &tp->flags);
>  }
>  
> +static int r8159_wait_backup_restore(struct r8152 *tp)
> +{
> +	u32 ocp_data;
> +
> +	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
> +	if (!(ocp_data & PCUT_STATUS))
> +		return 0;
> +
> +	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
> +			       ocp_data & BACKUP_RESTRORE, 200, 2000, false);
> +}

The rest of the driver organizes helpers by chip family (r8152_,
r8153_, r8156_, r8157_) and the commit message describes the RTL8159
as reusing the RTL8157 scaffolding. Is the r8159_ prefix on this
single helper intentional, or would r8157_wait_backup_restore() (or
similar) fit better?

Also, poll_timeout_us() is invoked with a 200 us poll interval and a
2000 us overall timeout, giving roughly ten iterations before the
error path fires. Other GPHY-related waits in the driver allow up to
the order of seconds. Is 2 ms known to be sufficient for the
backup-restore handshake on RTL8159 across suspend/resume and on
slower hosts?

> @@ -8184,14 +8389,14 @@ static void r8156_init(struct r8152 *tp)
>  	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>  		return;
>  
> -	if (tp->version == RTL_VER_16) {
> +	if (tp->version == RTL_VER_16 || tp->version == RTL_VER_17) {
>  		ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xcffe, BIT(3));
>  		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(0));
>  	}
>  
>  	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
>  
> -	if (tp->version != RTL_VER_16)
> +	if (tp->version < RTL_VER_16)
>  		ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);

Later in the same function:

	if (tp->version != RTL_VER_16)
		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
				  PLA_MCU_SPDWN_EN);

Was this site meant to be converted to "< RTL_VER_16" along with the
others? As written, RTL_VER_17 clears PLA_MCU_SPDWN_EN during init,
while RTL_VER_16 does not.

[ ... ]

> @@ -8294,7 +8505,10 @@ static void r8156_init(struct r8152 *tp)
>  	set_bit(GREEN_ETHERNET, &tp->flags);
>  
>  	/* rx aggregation / 16 bytes Rx descriptor */
> -	if (tp->version == RTL_VER_16)
> +	if (tp->version == RTL_VER_17)
> +		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> +				  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
> +	else if (tp->version == RTL_VER_16)
>  		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_DESC_16B);

Every other USB_USB_CTRL bit written in this driver uses a named
macro (CDC_ECM_EN, RX_AGG_DISABLE, RX_ZERO_EN, RX_DESC_16B). Could
BIT(11) be given a symbolic name so future multi-version handling of
this register stays self-describing?

[ ... ]

> @@ -9690,6 +9904,29 @@ static int rtl_ops_init(struct r8152 *tp)
>  		r8157_desc_init(tp);
>  		break;
>  
> +	case RTL_VER_17:
> +		tp->eee_en		= true;
> +		tp->eee_adv		= MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
> +		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
> +		ops->init		= r8156_init;
> +		ops->enable		= rtl8156_enable;
> +		ops->disable		= rtl8153_disable;
> +		ops->up			= rtl8156_up;
> +		ops->down		= rtl8156_down;

ops->up is wired to rtl8156_up() here, but rtl8156_up() still checks
for RTL_VER_16 exclusively at the sites noted above. See the
rtl8156_down() hunk for the pattern that appears to be intended.

> +		ops->unload		= rtl8153_unload;
> +		ops->eee_get		= r8153_get_eee;
> +		ops->eee_set		= r8152_set_eee;
> +		ops->in_nway		= rtl8153_in_nway;
> +		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
> +		ops->autosuspend_en	= rtl8157_runtime_enable;
> +		ops->change_mtu		= rtl8156_change_mtu;
> +		tp->rx_buf_sz		= 48 * 1024;
> +		tp->support_2500full	= 1;
> +		tp->support_5000full	= 1;
> +		tp->support_10000full	= 1;
> +		r8157_desc_init(tp);
> +		break;

RTL_VER_17 sets rx_buf_sz to 48 KiB and enables support_10000full,
but the max_mtu switch in rtl8152_probe() does not include
RTL_VER_17:

	case RTL_VER_12:
	case RTL_VER_13:
	case RTL_VER_15:
	case RTL_VER_16:
		netdev->max_mtu = size_to_mtu(16 * 1024);
		break;
	...
	default:
		netdev->max_mtu = ETH_DATA_LEN;
		break;

Should RTL_VER_17 also select the 16 KiB max_mtu case so jumbo frames
are available on the new 10 Gbit chip?

Separately, rtl8156_enable() is set as ops->enable for RTL_VER_17 but
the USB_RX_AGGR_NUM reset is guarded by
"tp->version >= RTL_VER_12 && tp->version <= RTL_VER_16", so
RTL_VER_17 does not execute it. Is that intended given RTL_VER_17
otherwise shares the RTL_VER_16 descriptor/aggregation plumbing
(r8157_desc_init(), and the USB_USB_CTRL aggregation bits cleared in
r8156_init() for RTL_VER_17)?

[ ... ]

