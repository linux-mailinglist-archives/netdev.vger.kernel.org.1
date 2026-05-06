Return-Path: <netdev+bounces-284628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dZOSIIaK+mnUPgMAu9opvQ
	(envelope-from <netdev+bounces-284628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:25:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBB64D4F6C
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9E3330398A3
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E519DF6A;
	Wed,  6 May 2026 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq0PNfWc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE555695
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778027138; cv=none; b=ZzKR8dXfPJITKsUYCs/JkO9AYno8mOZ86FjxMAWEb1XIdnIM2cRzcPgaCrBFYOTdPiiwDF94PbtE/z3ZF1TM2FEyLTd2i1TkseHQNMMTxoV9K5aRcim/kwiBsU6Ifdjdk+rdiiulng4p3Zdr9B78T7eIj77wJv5uNVPpJRogbPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778027138; c=relaxed/simple;
	bh=cuEqOetTZuB0HIWofiudwIYYZOVFyDzMgCs5BUL2W0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZT1/mDdJBKt+9SlJZveAe4Z3lLCpav3DD1hHFhrwXTqAkRDqLORLiBh1oqV4WpsAlgxVMmREWSXsqGw7SQww/MvudfRvkm6BD1hb5bG88b4LjSZahxDD6Q17EmR3RCJZ47/Q3PO8KVp8PP5M3l75jQnbG5/lhTwug0ToEjYCX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq0PNfWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7EBC2BCB4;
	Wed,  6 May 2026 00:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778027138;
	bh=cuEqOetTZuB0HIWofiudwIYYZOVFyDzMgCs5BUL2W0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aq0PNfWc27J0OjxsVui7ob9zuLLxRa+occsjgAeLn1nG2TAc+FXoWjojcq3CGSrie
	 ctMygXSi7cUAiuZdYqsdDxRXlU0Urn4lH8YqCQMpSlsEBV97gwkbCbmh7xChoolw02
	 eo4VcUgRUPO+vKmbILZ+YREVFdpZ8j8QhPZhwoGRkUKiuhXgDDvCOkcEMMQGxX8RK/
	 XlAANXhrTK865J+8Sndt25ZYryiML5dP7zsXc5smRRuR9WSL162UFJAhZNrXRkGyxt
	 5Kc7gHt2zgH52IDsiFiSRoG1sR7v7Sc1PrtW7WUGIGMkoZcWDc5/k4TV1SlmztXGR9
	 xmRdhjLYosk4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: justin.chen@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v2 2/2] net: bcmasp: Keep PHY link during WoL sleep cycle
Date: Tue,  5 May 2026 17:25:36 -0700
Message-ID: <20260506002536.1521518-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501185625.422361-3-justin.chen@broadcom.com>
References: <20260501185625.422361-3-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECBB64D4F6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284628-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: bcmasp: Keep PHY link during WoL sleep cycle

This patch splits the suspend/resume paths so that when WoL is enabled
the PHY is left running and the MAC is only partially re-initialized on
resume. phy_stop() is skipped during suspend and phy_start() is replaced
with a forced relink via phy_trigger_machine() when the MAC was reset.

> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> index e2b51ec903af..9ffd0dfa5969 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c

[ ... ]

> @@ -946,7 +946,8 @@ static void bcmasp_netif_deinit(struct net_device *dev)
>  
>  	umac_enable_set(intf, UMC_CMD_TX_EN, 0);
>  
> -	phy_stop(dev->phydev);
> +	if (stop_phy)
> +		phy_stop(dev->phydev);

Skipping phy_stop() in the WoL path means phy_stop_machine() and the
cancel_delayed_work_sync() on phydev->state_queue are no longer executed
before the ASP clock is disabled in bcmasp_interface_suspend().

The PHY state machine runs on system_power_efficient_wq, which is not
WQ_FREEZABLE, so task freeze does not stop it.  If a PHY IRQ fires (or
the polling timer expires) between clk_disable_unprepare(intf->parent->clk)
and the matching clk_prepare_enable() on resume, the state machine can
reach bcmasp_adj_link() via phy_check_link_status() ->
phy_link_up()/phy_link_down() -> phydev->adjust_link.

bcmasp_adj_link() reads and writes UMC_CMD, UMC_EEE_LPI_TIMER,
UMC_EEE_CTRL and RGMII_OOB_CNTRL, which sit behind the disabled ASP
clock.  Can those accesses hang the bus or return 0xffffffff on these
SoCs?

bcmgenet pins phydev->state = PHY_READY during WoL suspend specifically
to freeze the state machine in a no-op state.  Is an equivalent
protection needed here?

> @@ -1385,15 +1386,20 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
>  {
>  	struct device *kdev = &intf->parent->pdev->dev;
>  	struct net_device *dev = intf->ndev;
> +	bool wake;
>  
>  	if (!netif_running(dev))
>  		return 0;
>  
>  	netif_device_detach(dev);
>  
> -	bcmasp_netif_deinit(dev);
> +	wake = device_may_wakeup(kdev) && intf->wolopts;
>  
> -	if (!intf->wolopts) {
> +	bcmasp_netif_deinit(dev, !wake);
> +
> +	if (wake) {
> +		bcmasp_suspend_to_wol(intf);
> +	} else {
>  		bcmasp_phy_hw_unprepare(intf);

[ ... ]

> @@ -1438,17 +1444,34 @@ int bcmasp_interface_resume(struct bcmasp_intf *intf)
>  	if (ret)
>  		return ret;
>  
> -	bcmasp_core_clock_set_intf(intf, true);
> -
> -	bcmasp_resume_from_wol(intf);
> +	wake = device_may_wakeup(kdev) && intf->wolopts;
>  
> -	bcmasp_phy_hw_prepare(intf);
> +	bcmasp_core_clock_set_intf(intf, true);
>  
> -	umac_reset_and_init(intf, dev->dev_addr);
> +	/* The interface might be HW reset in some suspend modes, so we may
> +	 * need to restore the UNIMAC/PHY if that is the case.
> +	 */
> +	reg = umac_rl(intf, UMC_CMD);
> +	if (wake && (reg & UMC_CMD_RX_EN)) {
> +		umac_enable_set(intf, UMC_CMD_TX_EN, 1);
> +		bcmasp_resume_from_wol(intf);
> +	} else {
> +		bcmasp_phy_hw_prepare(intf);
> +		umac_reset_and_init(intf, dev->dev_addr);
> +	}

In the wake && !(reg & UMC_CMD_RX_EN) branch (MAC was HW reset during
suspend), bcmasp_resume_from_wol() is not called.

bcmasp_suspend_to_wol() unconditionally does two things that live in
the shared parent register block, not the per-interface UMC block:

	wakeup_intr2_core_wl(intf->parent, 0xffffffff,
			     ASP_WAKEUP_INTR2_MASK_CLEAR);

	if (ndev->phydev && ndev->phydev->eee_cfg.eee_enabled &&
	    intf->parent->eee_fixup)
		intf->parent->eee_fixup(intf, true);

The wakeup interrupt mask and the EEE fixup bits (phy_lpi_overwrite in
ASP_EDPKT_SPARE_REG) are not cleared by a reset that only wipes UMC_CMD.

In this branch the wakeup IRQ remains unmasked (bcmasp_isr_wol would
then fire on subsequent MPD/FILT events during normal traffic) and the
EEE fixup stays asserted.  Should this branch also invoke the parts of
bcmasp_resume_from_wol() / eee_fixup(false) that live in the shared
register block?

Separately, bcmasp_suspend_to_wol() explicitly programs
UMC_CMD_PROMISC:

	reg |= UMC_CMD_RX_EN | UMC_CMD_PROMISC;
	umac_wl(intf, reg, UMC_CMD);

In the wake && (reg & UMC_CMD_RX_EN) fast-resume branch, the only
writes to UMC_CMD are:

	umac_enable_set(intf, UMC_CMD_TX_EN, 1);

and whatever bcmasp_resume_from_wol() does, which only touches
UMC_MPD_CTRL and ASP_WAKEUP_INTR2_MASK_SET.  bcmasp_netif_init() calls
bcmasp_set_rx_mode() which manages ASP_RX_FILTER_MDA but not
UMC_CMD_PROMISC, and bcmasp_adj_link() only reprograms PROMISC inside
its if (reg & UMC_CMD_SW_RESET) branch (not taken here).  Since
old_link/old_duplex/old_pause are preserved across the fast path,
adj_link's changed flag stays zero and it returns without rewriting
UMC_CMD.

Does this leave the MAC stuck in UMC_CMD_PROMISC after every WoL
resume, until the interface is toggled down/up?

>  
>  	bcmasp_netif_init(dev);
>  
> -	phy_start(dev->phydev);
> +	/* If HW was reset, we need to force a relink */
> +	if (wake && !(reg & UMC_CMD_RX_EN)) {
> +		mutex_lock(&dev->phydev->lock);
> +		if (dev->phydev->state == PHY_RUNNING)
> +			dev->phydev->state = PHY_UP;
> +		mutex_unlock(&dev->phydev->lock);
> +		phy_trigger_machine(dev->phydev);
> +	} else if (!wake) {
> +		phy_start(dev->phydev);
> +	}

The forced-relink branch only demotes PHY_RUNNING -> PHY_UP before
phy_trigger_machine().  Since phy_stop() was skipped during suspend,
phydev->state is whatever it was at suspend time, which may instead be
PHY_NOLINK (cable was unplugged), PHY_HALTED or PHY_ERROR.

For PHY_NOLINK, _phy_state_machine() runs phy_check_link_status() +
phy_update_stats() only; it does not trigger _phy_start_aneg() (that is
the PHY_UP case).  If the HW reset that cleared UMC_CMD_RX_EN also
touched the PHY chip (shared reset/power domain), autoneg may need to
be restarted.

Does this path handle states other than PHY_RUNNING, and does it
guarantee the PHY is reinitialized and autoneg restarted when the MAC
has been reset?

> +
>  	netif_device_attach(dev);
>  
>  	return 0;

