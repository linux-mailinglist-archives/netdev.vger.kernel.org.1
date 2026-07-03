Return-Path: <netdev+bounces-304386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id COLfHHxgR2pTXQAAu9opvQ
	(envelope-from <netdev+bounces-304386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:10:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9EE6FF6BA
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:10:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ne1OqxBV;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304386-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304386-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7135300B0A2
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2843C38A729;
	Fri,  3 Jul 2026 07:10:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756CD1F91F6
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 07:10:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062647; cv=none; b=UMIQRB1tMOaS549PHtg+BpVeBAgCRN64YA7t46u5le8XrZpiM+XhDfIXBhCAXO2e9xqr03TxMawLINicHqyHeBB3LWt0ypVnsL7PXAIiVCQnMtHZQNERA0CsNbM/osJAaCRMfu42wYa80YUCLNZtZ/WxV5YX4eu6oOq8SLtNA9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062647; c=relaxed/simple;
	bh=U5nyzFTmlpJ68+jf4DrIr+X3xJZTQseOjYustIBfTuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWc3YFEIpDpUiCkidihOu7nGHUxipV5+7+bU+l6949aLSraku4CVfvAAOabV4HSlgA+FdIxFZG1u8+K2CbxNfsZYlC6YNP5ZNVZar+MleBwGr9KBjL1qoY40U3EeXbtVok4VYCcA7AG072y+Ymu+RxX1F8NTBQ4CeV0C+4e1sjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ne1OqxBV; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783062644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gryOfj1tZLtQ1QQDkM4pRd7lM0RAXrmRG+VMuPIwIN8=;
	b=Ne1OqxBVxz6VzZ4TNDbQtHtYG1fg3FU6ahwq/lECB1yTeiF6i61GW4920qc3RAqrgDjN37
	ZtzkQU3g1Eta8LZsMaOnvrmrMg35CWfe3WA9udGpYWQ/Mxmt9qrArC7KWYJGrfLmaD6V9+
	jHnWN78gXkM1qLwsp/0KPmAky2Zpiao=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-2oL0ciYXMWSU6-0nqtHH6g-1; Fri,
 03 Jul 2026 03:10:41 -0400
X-MC-Unique: 2oL0ciYXMWSU6-0nqtHH6g-1
X-Mimecast-MFC-AGG-ID: 2oL0ciYXMWSU6-0nqtHH6g_1783062639
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A432C196C43E;
	Fri,  3 Jul 2026 07:10:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.68])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1851536F2F;
	Fri,  3 Jul 2026 07:10:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corey@leavitt.info,
	jelonek.jonas@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio hook
Date: Fri,  3 Jul 2026 09:10:25 +0200
Message-ID: <20260703071025.100797-1-pabeni@redhat.com>
In-Reply-To: <20260630091125.3162481-4-github@szelinsky.de>
References: <20260630091125.3162481-4-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,leavitt.info,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304386-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:github@szelinsky.de,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corey@leavitt.info,m:jelonek.jonas@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,leavitt.info:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D9EE6FF6BA

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
Now I have all the information I need. Let me produce the report.

commit da23b745f9e416f319d1edba4054506a8dabbe37
Author: Corey Leavitt <corey@leavitt.info>
Subject: net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio hook

This patch moves ownership of phydev->psec from fwnode_mdio into the phy
subsystem via a PSE notifier, defers the final pse_control_put() from
phy_device_remove() to phy_device_release(), and adds a
phy_device_register_locked() variant for callers that already hold rtnl.

Link: https://lore.kernel.org/netdev/e00048dd-1ed3-40c3-9912-59bccf015ad5@gmail.com/

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 0615228459ef..f5febff4b00b 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -223,8 +223,19 @@ static void phy_mdio_device_free(struct mdio_device *mdiodev)
>
>  static void phy_device_release(struct device *dev)
>  {
> +	struct phy_device *phydev = to_phy_device(dev);
> +
> +	/* bus_for_each_dev() holds get_device() across each iteration
> +	 * step, deferring this release callback until any in-flight PSE
> +	 * notifier walk has advanced past this phy. pse_control_put()
> +	 * takes pse_list_mutex, so this path must run in sleepable
> +	 * context.
> +	 */
> +	might_sleep();
> +	pse_control_put(phydev->psec);
> +
>  	fwnode_handle_put(dev->fwnode);
> -	kfree(to_phy_device(dev));
> +	kfree(phydev);
>  }

[High]
Can this combine with the PSE_UNREGISTERED walk to leave a use-after-free
window for phys that have already been device_del()'d but still have an
outstanding reference?

The notifier walks the bus klist:

  case PSE_UNREGISTERED:
      rtnl_lock();
      bus_for_each_dev(&mdio_bus_type, NULL, data,
                       phy_pse_detach_one);
      rtnl_unlock();

bus_for_each_dev() iterates subsys_private's klist_devices, and
device_del() -> bus_remove_device() -> klist_del() unlinks the device
from that klist. A phy that has been removed from the bus but is still
pinned (for example by a netdev that took get_device() via
phy_attach_direct()) is no longer reachable from this walk, so
phy_pse_detach_one() will not clear its phydev->psec.

> @@ -1152,8 +1299,6 @@ EXPORT_SYMBOL(phy_device_register);
>  void phy_device_remove(struct phy_device *phydev)
>  {
>  	unregister_mii_timestamper(phydev->mii_ts);
> -	pse_control_put(phydev->psec);
> -
>  	device_del(&phydev->mdio.dev);
>
>  	/* Assert the reset signal */

[High]
Previously phy_device_remove() performed pse_control_put() synchronously
before device_del(), so the put always ran while phydev->psec still
pointed at a live pcdev. After this change the put is deferred to
phy_device_release(), which only runs when the last device reference is
dropped.

Consider this sequence on two CPUs:

  CPU A (phy teardown)              CPU B (rmmod PSE driver)
  --------------------------------  -----------------------------------
  phy_detach()
    /* netdev still pins phydev */
  phy_device_remove()
    device_del()  /* off klist */
                                    pse_controller_unregister()
                                      blocking_notifier_call_chain(
                                        PSE_UNREGISTERED)
                                        phy_pse_notifier_event()
                                          bus_for_each_dev(mdio_bus_type,
                                            ..., phy_pse_detach_one)
                                          /* phydev not on klist,
                                           * phydev->psec not cleared */
                                      pse_release_pis()
                                        kfree(pcdev->pi)
  /* later, last ref dropped */
  phy_device_release()
    pse_control_put(phydev->psec)
      __pse_control_release()
        pcdev->pi[psec->id].admin_state_enabled
        /* UAF: pcdev->pi already freed */
        module_put(psec->pcdev->owner)

Does the commit message paragraph

  "The final pse_control_put() of phydev->psec moves from
   phy_device_remove() to phy_device_release(), so it runs only after
   every reference on the device -- including the bus-iterator
   references taken by bus_for_each_dev() in the notifier walk -- has
   been dropped."

cover the case where a phy is already off the bus klist before the
notifier fires? bus_for_each_dev() only holds get_device() on devices
it can reach via the klist, so a phy that has been device_del()'d but
is still pinned by some other holder (an attached netdev being the
typical case) is invisible to phy_pse_detach_one().

Similarly, when an MDIO bus is torn down (mdiobus_unregister() walks
its phys and calls phy_device_remove() on each), is there any guarantee
that no consumer is still holding a reference that would carry the
phy past device_del() and into a later phy_device_release()?

If this race is reachable, would it be safer to keep the
pse_control_put() in phy_device_remove() (or somewhere else that runs
before device_del() returns), so the put cannot outlive any
pcdev->pi[] that PSE_UNREGISTERED is about to free?
-- 
This is an AI-generated review.


