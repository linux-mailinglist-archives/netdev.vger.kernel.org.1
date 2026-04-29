Return-Path: <netdev+bounces-282542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCYjAlCS8mlhsgEAu9opvQ
	(envelope-from <netdev+bounces-282542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:20:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 172BF49B543
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2C463023361
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B6537EFE8;
	Wed, 29 Apr 2026 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBcmS0ix"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC183242B8
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504832; cv=none; b=BuvIsqmcrjm1dP3RROqAb7L+d/olK69gdrs+ATcUF0RcPNLx1v0b6k+wJbKjg3lK82ZuSvUszLA719nYC/HwnF/zWDzvb8nujS2EuCjx/bT/mIQIU5dML/3UxCArM2R8IaXr6djKTC26xs2lG3tCeCexyYMZXILlfXruuV7s6U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504832; c=relaxed/simple;
	bh=PmrBehyeFmpkVRCjvpx3z0u+kGD8cpUpKFIPLgBS2s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/gVDQXrCkRqgC4RwBRx3wfIG7+/pFlPfNNnx6rcSrVdvQJT6MD44hl+tO4byFYW4XhySJESUH19vqcodtA7G7Cb6eq66LDKxdiQkXVhZtKFMrijPS93JmLN+NCxVxfJ7Eg67Kxu5dpTnrLvpCj11lmTwBlxnbjsj4L1NI9fvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBcmS0ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEBDC19425;
	Wed, 29 Apr 2026 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777504831;
	bh=PmrBehyeFmpkVRCjvpx3z0u+kGD8cpUpKFIPLgBS2s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBcmS0ix9EWRUXlf6xlu6eqUkGhypD3e+CkNeVUrkQqmrQSIKVbk+uVjzn2J5hIqc
	 waGttYg1Txp4xJR0YXCGcBahm7Q9z8cZwthPrbIWIuf7r+GtOcrtdhuUjKmNJr4azm
	 VpN8JeNSK7qn0dPJUTOofcJb0OpfHIVIjC8lWVoEjRPIsgJKVKnoEBQ+Y5dTjCjjgn
	 1r6yP3fihhUt2u7zqaNCFq+Y4WeWzHSSwHCTfu4OCB/cGirszpwNEk04CysY8tRLUQ
	 4oCuZZhZyk8veCO0qb/QnP1i+41D/dezTW1CSoMIVsi3jvoFtXll/fyc4uks1IbMYn
	 XoDbxsv0WtEwQ==
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
Subject: Re: [PATCH net-next 2/2] net: bcmasp: Keep PHY link during WoL sleep cycle
Date: Wed, 29 Apr 2026 16:20:30 -0700
Message-ID: <20260429232030.2187222-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428220858.2076469-3-justin.chen@broadcom.com>
References: <20260428220858.2076469-3-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 172BF49B543
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282542-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email says "Blindly sending out since there will be a repost,
anyway."
---
net: bcmasp: Keep PHY link during WoL sleep cycle

We currently more or less restart all the HW on resume. Since we also
stop the PHY, it takes a while for the PHY link to be re-negotiated on
resume. Instead of doing a full restart, we keep the HW state and the
PHY link, that way we can resume network traffic with a much smaller
delay.

> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> index aff0a6d84126..bab2a4f82e4e 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
[ ... ]
> @@ -1383,15 +1384,20 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
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
>  
>  		/* If Wake-on-LAN is disabled, we can safely
> @@ -1400,9 +1406,6 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
>  		bcmasp_core_clock_set_intf(intf, false);
>  	}
>  
> -	if (device_may_wakeup(kdev) && intf->wolopts)
> -		bcmasp_suspend_to_wol(intf);
> -
>  	clk_disable_unprepare(intf->parent->clk);

If wake is true, phy_stop() is skipped during bcmasp_netif_deinit().
This leaves the phylib state machine active and polling on its delayed
workqueue.

At the end of bcmasp_interface_suspend(), the main MAC clock is
unconditionally disabled via clk_disable_unprepare(intf->parent->clk).

If the PHY state machine executes while this clock is disabled, will it
attempt to access PHY registers over the MDIO bus, resulting in a
synchronous external abort (bus fault) or kernel panic?

Could the active state machine also concurrently invoke the MAC's
adjust_link callback while bcmasp_interface_resume() is executing,
causing a data race on MAC registers?

>  	return 0;
>  }
> @@ -1426,8 +1429,11 @@ static void bcmasp_resume_from_wol(struct bcmasp_intf *intf)
>  
>  int bcmasp_interface_resume(struct bcmasp_intf *intf)
>  {
[ ... ]
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

If wake is true but the MAC hardware was reset (reg & UMC_CMD_RX_EN
is false), the code branches to the else block and skips calling
bcmasp_resume_from_wol().

Since bcmasp_resume_from_wol() is responsible for reversing the WoL
configuration applied during suspend (like restoring the EEE fixup state
and masking the wakeup interrupt), does skipping this teardown leave the
wakeup interrupt unmasked during normal operation and risk an interrupt
storm?

>  	bcmasp_netif_init(dev);
>  
> -	phy_start(dev->phydev);
> +	/* If HW was reset, we need to force a link re-negotiation */
> +	if (wake && !(reg & UMC_CMD_RX_EN)) {
> +		phy_restart_aneg(dev->phydev);

If the user has explicitly configured forced speed and duplex with
autonegotiation disabled, will this unconditional call to
phy_restart_aneg() override the user's configuration? It appears to
enable autonegotiation without checking if phydev->autoneg ==
AUTONEG_ENABLE.

Also, because phy_stop() was skipped during suspend, the PHY state
machine is still actively running in the background. Does calling
phy_restart_aneg() without holding phydev->lock create a data race
with the concurrent PHY state machine?

> +		phy_trigger_machine(dev->phydev);
> +	} else if (!wake) {
> +		phy_start(dev->phydev);
> +	}
>  
>  	netif_device_attach(dev);

