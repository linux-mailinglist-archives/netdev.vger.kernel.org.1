Return-Path: <netdev+bounces-286915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOJTI86LAmrzuAEAu9opvQ
	(envelope-from <netdev+bounces-286915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:09:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E6518B4A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFC8D3007B06
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719B92E8B81;
	Tue, 12 May 2026 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjzbkxdA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D81A3029;
	Tue, 12 May 2026 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551728; cv=none; b=jgDCsjLF6b3KLjwrpapXu0oaaCy2lkywoTg+kShPW3sRv3i3OaXNFXJuIt5zmnaYnZyjIfhLpUSy6wEKGT8z30osZRSER60D6IOfar8XBdVVlw48/44Ndob5VTuaDWH7w7j1XNjOoAZkqS9e5Bjfbs3p/HF2t+nldG+ndphl5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551728; c=relaxed/simple;
	bh=lBZP5QpmSCXCKWcyIqiWPDW3A8meH7aym7gPU5t7gsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCivsM4/JWpgv4GZKFuT7nOzxDjQYlzYELkjh4c3sC5YvN5FeBj6V9QwieVexRZ0RES8djRWrt67AZL5hhbeUV5+pLuh5pB/6k21Cvih8cXwrnR6JmIv6tidSk+G2FiRNPWi1zuJCXdhV9sPtqCOC8zhsrj4mxY51ufv1GB4pgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjzbkxdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69876C2BCB0;
	Tue, 12 May 2026 02:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778551727;
	bh=lBZP5QpmSCXCKWcyIqiWPDW3A8meH7aym7gPU5t7gsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjzbkxdAWPjuRJeHvDth2Khd2ZSyMuBLnbAFtNvGAU6idtlg+oS6tXpsRZ/TaruTD
	 svh2IfJG1xTNxPfzOjo6SiI3VwQA5WvNbd6yz1Hxv/UVm5JXHN1TaRI47WfX9dYHEd
	 1/dsuuCyxjPK1ayozjXDDSQY1OFjHgG/7BASwceV7gU43GPpEmYE7G7nU4EsDuD9VG
	 POiWrxP3Be6PbNPEIPqK93AVuRJnDWzpw80o+vHRlB+QnK9J7zaVqSLe+V3EOfy1Ju
	 C9qrtaY+IWT0dbTFt+ybyTK1qQRAWX47VeXal6mwCVtqJvzGt37WuY4JMlDDIWcUFD
	 czNgAVkTN13Rg==
From: Jakub Kicinski <kuba@kernel.org>
To: thangaraj.s@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/5] net: lan743x: read SFP straps from PCI11x1x device
Date: Mon, 11 May 2026 19:08:42 -0700
Message-ID: <20260512020842.838975-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508052150.11852-3-thangaraj.s@microchip.com>
References: <20260508052150.11852-3-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8C5E6518B4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286915-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: lan743x: read SFP straps from PCI11x1x device

This commit reads SFP enable bits from the PCI11x1x strap registers and
stores the result in a new adapter->is_sfp_support_en flag, with a
validation message when SFP support appears to be requested without SGMII.

> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index fad4a246e06e..867310dbe9ba 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -62,6 +62,12 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
>  			adapter->is_pcs_en = true;
>  		else
>  			adapter->is_pcs_en = false;
> +
> +		if ((strap & STRAP_SFP_USE_EN_) && (strap & STRAP_SFP_EN_))
> +			adapter->is_sfp_support_en = true;
> +		else
> +			adapter->is_sfp_support_en = false;
> +

[Low]
Is there a reason STRAP_SFP_USE_EN_ and STRAP_SFP_EN_ are only evaluated
inside the branch gated by (strap & STRAP_READ_USE_SGMII_EN_) (or the A0
workaround)?

If a board is strapped with STRAP_SFP_USE_EN_=1 but
STRAP_READ_USE_SGMII_EN_=0, the SFP straps are silently ignored,
is_sfp_support_en keeps its default of false, and no diagnostic is
emitted.

The two "use strap" gate bits look independent (one for SGMII, one for
SFP); nesting the SFP decode inside the SGMII decode appears to conflate
them.  The "SFP_EN without SGMII_EN" validation block below will also
never fire in this configuration because is_sfp_support_en is forced to
false.

>  	} else {
>  		fpga_rev = lan743x_csr_read(adapter, FPGA_REV);
>  		if (fpga_rev) {
> @@ -73,8 +79,17 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
>  			adapter->is_pcs_en = false;
>  		}
>  	}

[Low]
In the else (FPGA/non-strap) branch, adapter->is_sfp_support_en is never
assigned, while adapter->is_pcs_en is written in every sub-branch.  The
code relies on the one-time initialization of is_sfp_support_en = false
in lan743x_pcidev_probe().

Today pci11x1x_strap_get_status() is only called once from
lan743x_hardware_init() during probe, so the current behavior is well
defined.  Would it be worth setting adapter->is_sfp_support_en = false in
this else branch as well to mirror is_pcs_en and keep the function
idempotent if it is ever called from a reset, resume, or error-recovery
path later?

> +
> +	if (adapter->is_pci11x1x && !adapter->is_pcs_en &&
> +	    adapter->is_sfp_support_en) {
> +		netif_err(adapter, drv, adapter->netdev,
> +			  "Invalid EEPROM configuration: SFP_EN strap specified without SGMII_EN strap\n");
> +	}

[Medium]
The commit message describes this as:

    Add a validation check to ensure PCS is enabled when SFP support
    is requested, as SFP operation requires the PCS interface.

Does this block actually enforce that invariant?  It logs the invalid
combination but leaves adapter->is_sfp_support_en set to true and does
not propagate an error out of pci11x1x_strap_get_status() or
lan743x_hardware_init().

Later patches in the same series (for example "net: lan743x: Add PCS/XPCS
support for SFP on PCI11x1x") gate lan743x_pcs_mdiobus_init() and the
swnodes/SFP platform-device registration on is_sfp_support_en alone,
without an is_pcs_en check.  With a misconfigured EEPROM the driver would
then attempt PCS/XPCS MDIO operations on hardware whose PCS is disabled.

Would it be preferable to either force adapter->is_sfp_support_en = false
when the invalid combination is detected, or return an error from
pci11x1x_strap_get_status() so lan743x_hardware_init() can fail probe?

> +
>  	netif_dbg(adapter, drv, adapter->netdev,
>  		  "PCS I/F %s\n", str_enable_disable(adapter->is_pcs_en));
> +	netif_dbg(adapter, drv, adapter->netdev,
> +		  "SFP support %s\n", str_enable_disable(adapter->is_sfp_support_en));
>  }

[Low]
The commit message says:

    Refactor debug logging to use the str_enable_disable() helper for
    consistency with modern kernel standards.

Is this description accurate?  The existing "PCS I/F %s" netif_dbg()
already uses str_enable_disable() prior to this patch (it was introduced
by the earlier "net: lan743x: rename is_sgmii_en to is_pcs_en" commit).

This patch only adds a new netif_dbg() for is_sfp_support_en using the
same helper; no existing debug line is refactored.  Could the bullet be
reworded to reflect that a new debug line was added rather than an
existing one refactored?

> diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
> index f0fa0580b04e..26c30dc2e55c 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.h
> +++ b/drivers/net/ethernet/microchip/lan743x_main.h
> @@ -37,6 +37,8 @@
>  
>  #define STRAP_READ			(0x0C)
>  #define STRAP_READ_USE_SGMII_EN_	BIT(22)
> +#define STRAP_SFP_USE_EN_              BIT(31)
> +#define STRAP_SFP_EN_                  BIT(15)
>  #define STRAP_READ_SGMII_EN_		BIT(6)

[Low]
The two new STRAP_SFP_*_ macros use spaces for alignment while every
surrounding STRAP_* definition uses tabs.  Was this intentional, or
should they be tab-aligned to match the rest of the file (and avoid a
checkpatch warning)?

>  #define STRAP_READ_SGMII_REFCLK_	BIT(5)
>  #define STRAP_READ_SGMII_2_5G_		BIT(4)
> @@ -1081,6 +1083,7 @@ struct lan743x_adapter {
>  	u8			max_tx_channels;
>  	u8			used_tx_channels;
>  	u8			max_vector_count;
> +	bool                    is_sfp_support_en;

[Low]
Same question here: the new is_sfp_support_en field uses spaces for
alignment while the surrounding struct members use tabs.  Should this be
tab-aligned for consistency with the rest of struct lan743x_adapter?

>  
>  #define LAN743X_ADAPTER_FLAG_OTP		BIT(0)
>  	u32			flags;
-- 
pw-bot: cr

