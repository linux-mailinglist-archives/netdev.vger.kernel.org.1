Return-Path: <netdev+bounces-285116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fcVjI6/1+2lNJQAAu9opvQ
	(envelope-from <netdev+bounces-285116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:15:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD444E2335
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D72F300F120
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A5829827E;
	Thu,  7 May 2026 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uB8rTF/M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E122173D;
	Thu,  7 May 2026 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778120107; cv=none; b=P3XL22kIuDEV++WlAJgt/AD00wOQlxfUV3VsK4ngs4ECcIDaJ3JtKtyUGkFbMswf9NDWdz63aqLO9dyTe7Ob5/4uLjvBmE2PMA+Vdm+BcxyENw1ZTp8UsIvplcXvYX1eHXq/EE81UaHCIiTCoqOVLlPdgudRB+VXtXK9V3t8mE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778120107; c=relaxed/simple;
	bh=XXnfg3Egf/xizqpxi5tqAsC+JRKwFvCCVuI4f/mTprI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsTJgBbzXdvcZ25Xmz5lk5IEQStEwr5+wBmRvdnCEda5Eim2WEAPc0bPIpknXqWaA/XjpIZG/HhsOua06TIluHacd8DW/ARaPiP3tHUaIV68FiftulHwntyq2fdMLA0lhP94O5uPkDZ4NA83fjNR5ouXd4DkGrD9rp8QA6ADWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uB8rTF/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C263FC2BCB0;
	Thu,  7 May 2026 02:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778120107;
	bh=XXnfg3Egf/xizqpxi5tqAsC+JRKwFvCCVuI4f/mTprI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uB8rTF/MGtz/7/yNleMg07HFtPXDfF5EoxCB+jKKW3JdihygCHGFa92iSIQvVk+uJ
	 VPaR0eMEnBoSl8IlWm4pqs/lpq8GTBDPahBuK7sWVQVMkzq2SfxmEZBpdn6ERsDPAP
	 fvwZ9j25/Zc9g/yeLJBWoaaHYfHVys1lRHdRDljmSgtMIeqsIzihRbV0jaxkC2hMFO
	 lm3syAM7grYIpU0iAXFWnTHB9SJ0ggarRQKlVdFP7So1Jn5R7r+H/K2IjgIBBCCnB+
	 7xzAoLxf6gfbbRJLmq9A/PFJMqsKL5od2drfou4EssujfFnoUgX5C7vPkMFemOANfq
	 adCDQueHdU7PQ==
From: Jakub Kicinski <kuba@kernel.org>
To: Markus.Baier@soslab.tu-darmstadt.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	o.rempel@pengutronix.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	enelsonmoore@gmail.com,
	linmq006@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: usb: asix: ax88772: replace usbnet_link_change() with queue_work() and usbnet_unlink_rx_urbs()
Date: Wed,  6 May 2026 19:15:05 -0700
Message-ID: <20260507021505.2271095-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506010344.184636-1-Markus.Baier@soslab.tu-darmstadt.de>
References: <20260506010344.184636-1-Markus.Baier@soslab.tu-darmstadt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DBD444E2335
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-285116-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: usb: asix: ax88772: replace usbnet_link_change() with queue_work() and usbnet_unlink_rx_urbs()

This patch replaces the usbnet_link_change() calls in the ax88772
phylink mac_link_up()/mac_link_down() callbacks with direct
queue_work(system_bh_wq, &dev->bh_work) and usbnet_unlink_rx_urbs(),
with the stated rationale that phylink already manages the carrier
state. It is tagged Fixes: 36bdc0e815b4 ("net: usb: asix: ax88772:
re-add usbnet_link_change() in phylink callbacks").

> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> index 293ef80c4e30..4230ff611c4b 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c

[ ... mac_link_down hunk snipped, not relevant to the comment below ... ]

> @@ -787,7 +791,11 @@ static void ax88772_mac_link_up(struct phylink_config *config,
>  		m |= AX_MEDIUM_RFC;
>  
>  	asix_write_medium_mode(dev, m, 0);
> -	usbnet_link_change(dev, true, false);
> +
> +	/* Phylink will call netif_carrier_on(), but we need to explicitly
> +	 * kick off RX URB submission in usbnet.
> +	 */
> +	queue_work(system_bh_wq, &dev->bh_work);
>  }

Can this reintroduce the "no RX until first TX" symptom that commit
805206e66fab ("net: asix: fix 'can't send until first packet is send'
issue") and the Fixes: target 36bdc0e815b4 addressed?

Looking at the ordering in phylink_link_up() in drivers/net/phy/phylink.c,
the mac_link_up() callback is invoked before netif_carrier_on():

	pl->mac_ops->mac_link_up(pl->config, pl->phydev, pl->act_link_an_mode,
				 pl->cur_interface, speed, duplex,
				 !!(link_state.pause & MLO_PAUSE_TX), rx_pause);

	if (pl->mac_supports_eee && pl->phy_enable_tx_lpi)
		phylink_activate_lpi(pl);

	if (ndev)
		netif_carrier_on(ndev);

So when ax88772_mac_link_up() runs queue_work(system_bh_wq, &dev->bh_work),
the netdev carrier is still off.

system_bh_wq is a WQ_BH workqueue, so queue_work() on it raises
TASKLET_SOFTIRQ, which can be serviced on the next hard-IRQ exit (or by
ksoftirqd) before phylink_link_up() reaches netif_carrier_on().

When bh_work runs, usbnet_bh() in drivers/net/usb/usbnet.c gates RX URB
submission on netif_carrier_ok():

	} else if (netif_running (dev->net) &&
		   netif_device_present (dev->net) &&
		   netif_carrier_ok(dev->net) &&
		   ...
		   !test_bit(EVENT_RX_HALT, &dev->flags)) {
		...
		if (temp < RX_QLEN(dev)) {
			if (rx_alloc_submit(dev, GFP_ATOMIC) == -ENOLINK)
				return;
			...
			if (dev->rxq.qlen < RX_QLEN(dev))
				queue_work(system_bh_wq, &dev->bh_work);
		}

If carrier is still off when usbnet_bh() runs, the rx_alloc_submit()
branch is skipped and bh_work does not reschedule itself. Once phylink
eventually calls netif_carrier_on(), nothing kicks bh_work again: the
in-flight RX URBs were unlinked by the prior ax88772_mac_link_down(),
so there are no URB completions to re-queue work either.

Does the previous usbnet_link_change() path avoid this race because
__handle_link_change() in drivers/net/usb/usbnet.c flips the carrier
before queuing work?

	if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
		netif_carrier_on(dev->net);

	if (!netif_carrier_ok(dev->net)) {
		/* kill URBs for reading packets to save bus bandwidth */
		unlink_urbs(dev, &dev->rxq);
		...
	} else {
		/* submitting URBs for reading packets */
		queue_work(system_bh_wq, &dev->bh_work);
	}

Here bh_work only runs after carrier_ok() is already true, so the gate
in usbnet_bh() cannot close on it.

Given the Fixes: tag targets -stable, is there a concern that this
patch partly reintroduces the original "RX silent until first TX or
link bounce" regression?

Would scheduling bh_work from a phylink_resolve() follow-up, or keeping
the usbnet_link_change() path (which sets EVENT_LINK_CARRIER_ON and
lets __handle_link_change() order carrier-on before queue_work), be a
safer sequencing?

As a side note, the comment added by this hunk states "Phylink will
call netif_carrier_on(), but we need to explicitly kick off RX URB
submission in usbnet." Should the comment reflect that phylink calls
netif_carrier_on() after this callback returns, rather than before, so
the ordering assumption is explicit?
-- 
pw-bot: cr

