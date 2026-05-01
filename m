Return-Path: <netdev+bounces-283053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AC3H9L+82n99QEAu9opvQ
	(envelope-from <netdev+bounces-283053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:16:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D804A9833
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34EED300988D
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B6A18FDDE;
	Fri,  1 May 2026 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPQp3cCL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D4340DFBB;
	Fri,  1 May 2026 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598158; cv=none; b=EdpvsHD4Z+mUQb+XiEZQ1qQPiSjz5ljyv3IWf2cNdJ+CLWLKJQR6zbsnicvdMwB2nt0ig5b0FSnRppkG/t9OFLPqAPd1m2YewSNGKbhkBn5wnLt6AlKPpOMKxQk3Vbe6ceC9FyJXNd0bmXJPbTAiE25tIJWAMmLyPoE3rCMB3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598158; c=relaxed/simple;
	bh=qPYC6I4jdwxetpCzBkZHKnFeFY+d8UGLLlB7ID60jFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnCA/63HgBoDbrwUgk65sJPVG5y2QMOyxOtvFR1eUL/F9yKu18GK/1ZUQ+ny7DzTqqS2+6TvTJsdRAbCIsCa1iQH93Qm0lUCPgen6vbD2+6U6MZ5DshkZm65DOt9eFZpfpqSIzEE6D3EcLrOWRw90w3QgMJZoe+3lqKN3xN3KJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPQp3cCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFF6C2BCB3;
	Fri,  1 May 2026 01:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777598158;
	bh=qPYC6I4jdwxetpCzBkZHKnFeFY+d8UGLLlB7ID60jFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPQp3cCLR4LEkj41hd0e5IrG8grOiTBZ3AbtUoyTOpwFa6QwGMPv71njCzwBz8C8S
	 6CHolbVmOKtVJajRUceV8enNUyiHBuOGx2+FlRfQww5IrRWhKhdR9kGQWRULsAS2wf
	 iUQ9f3fJ/nRhOgxIznCzA55tws/nKVy6yQ2WRJS1/GI0dd5qgCVvLZICIM4JSMt6Da
	 tR4kTGRW8PRS7t3YMnuAtdhcflzy45ibjIT6P1r9vQ24iq+6TS3dxTCARrArs1EZm8
	 QxuF/eBu1DhOzsmbW4duSgWzhmPLtNoqxBlAxE4bxicFcLMpDT9D9KpQQQB1IauGYc
	 y8pNmjjgMXipA==
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
Subject: Re: [PATCH net-next v2 1/4] r8152: Add support for 10Gbit Link Speeds and EEE
Date: Thu, 30 Apr 2026 18:15:56 -0700
Message-ID: <20260501011556.3154166-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429-rtl8159_net_next-v2-1-bab3cd4e4c66@birger-koblitz.de>
References: <20260429-rtl8159_net_next-v2-1-bab3cd4e4c66@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 28D804A9833
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283053-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
r8152: Add support for 10Gbit Link Speeds and EEE

This change adds support for 10 Gbit link speeds on RTL8159 via the
ethtool link_ksettings interface and adds 10 Gbit EEE advertisement
handling alongside the existing 2.5G/5G paths.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 7337bf1b7d6a..01e65d845f87 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -5773,6 +5779,11 @@ static void r8156_eee_en(struct r8152 *tp, bool enable)
>  	else
>  		config &= ~MDIO_EEE_5GT;
>  
> +	if (enable && (tp->eee_adv2 & MDIO_EEE_10GT))
> +		config |= MDIO_EEE_10GT;
> +	else
> +		config &= ~MDIO_EEE_10GT;
> +
>  	ocp_reg_write(tp, OCP_EEE_ADV2, config);
>  }

Is MDIO_EEE_10GT actually a bit of the EEE advertisement 2 register
(7.62, cap2 / OCP_EEE_ADV2)?

MDIO_EEE_10GT is defined by IEEE 802.3 as a bit of the EEE advertisement
register 7.60 (cap1 / OCP_EEE_ADV), not of register 7.62. The existing
10G EEE advertisement already flows through tp->eee_adv (populated by
linkmode_to_mii_eee_cap1_t() in r8152_set_eee()) and is written to
OCP_EEE_ADV by rtl_eee_enable().

tp->eee_adv2 is populated only by linkmode_to_mii_eee_cap2_t() in
r8152_set_eee(), which covers 2500baseT and 5000baseT and cannot set
MDIO_EEE_10GT, plus the chip-init assignments in rtl_ops_init() which
also do not set this bit.

With that in mind, is the enable && (tp->eee_adv2 & MDIO_EEE_10GT)
condition ever true?  The else branch will then unconditionally clear
bit 3 of OCP_EEE_ADV2 on every call, which is a cap1 bit being written
into the cap2 register.

[ ... ]

> @@ -8968,6 +9008,13 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>  			linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, common);
>  	}
>  
> +	if (tp->support_10000full) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, eee->supported);
> +
> +		if (speed & _10000bps)
> +			linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, common);
> +	}
> +
>  	eee->eee_enabled = tp->eee_en;

Should this hunk also extend the earlier gating inside r8153_get_eee()?

A few lines above, the cap2 register reads are still gated on:

	if (tp->support_2500full || tp->support_5000full) {
		val = ocp_reg_read(tp, OCP_EEE_ADV2);
		mii_eee_cap2_mod_linkmode_adv_t(eee->advertised, val);

		val = ocp_reg_read(tp, OCP_EEE_LPABLE2);
		mii_eee_cap2_mod_linkmode_adv_t(eee->lp_advertised, val);
	}

The equivalent disjunction in rtl8152_set_speed() and
rtl8152_get_link_ksettings() was updated to include support_10000full,
but r8153_get_eee() (and r8152_set_eee() at the analogous spot) still
only checks support_2500full || support_5000full.

A hypothetical chip that sets only support_10000full would bypass the
OCP_EEE_ADV2 / OCP_EEE_LPABLE2 reads and never reflect 10G EEE into
eee->advertised.  Should the condition be made consistent with the
other sites?

> @@ -9982,6 +10029,11 @@ static int rtl8152_probe_once(struct usb_interface *intf,
>  			tp->speed = SPEED_5000;
>  			tp->advertising |= RTL_ADVERTISED_5000_FULL;
>  		}
> +		if (tp->support_10000full &&
> +		    tp->udev->speed >= USB_SPEED_SUPER) {
> +			tp->speed = SPEED_10000;
> +			tp->advertising |= RTL_ADVERTISED_10000_FULL;
> +		}
>  		tp->advertising |= RTL_ADVERTISED_1000_FULL;
>  	}
>  	tp->duplex = DUPLEX_FULL;

Is USB_SPEED_SUPER the correct gate for defaulting to a 10 Gbit link?

USB_SPEED_SUPER is USB 3.0 SuperSpeed at 5 Gbit/s signaling, which
cannot carry a 10 Gbit Ethernet link.  The minimum bus rate that can
sustain 10GBASE-T is USB_SPEED_SUPER_PLUS (USB 3.1 Gen 2, 10 Gbit/s).

With this check, a 10G-capable RTL8159 plugged into a USB 3.0 host
will still default to tp->speed = SPEED_10000 and advertise
RTL_ADVERTISED_10000_FULL, so the Ethernet link may negotiate at 10G
while the USB bus is bottlenecked well below that, leading to
misleading ethtool speed reporting and back-pressure on the bus.

The same >= USB_SPEED_SUPER gate is reused from the 2.5G and 5G
defaults, which fit inside the USB 3.0 envelope; should the 10G
default instead use >= USB_SPEED_SUPER_PLUS?
-- 
pw-bot: cr

