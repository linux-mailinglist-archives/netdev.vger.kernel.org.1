Return-Path: <netdev+bounces-295200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0+hyO7tlIWoFFwEAu9opvQ
	(envelope-from <netdev+bounces-295200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:47:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5A763F8B4
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:47:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BBdLi4IP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295200-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295200-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BD6A300A7C4
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 11:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE54279F7;
	Thu,  4 Jun 2026 11:45:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49F425CE6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:45:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573529; cv=none; b=jtZbn4qQC3JvBXclWxaBGTDdFOgBIlGeEZQbepxVGrU3X/3HphjoD2/7m8G/2iv+zNF0TLHUQ02WH2nBtlH6mOd9u9jD3f6un5RRzNwcaoq3ghCeB4q+E0s5pKEDJnAT8rCgp3vvHFMfGiWAHbiacBjFyOEoiu9qHAGyFi9sFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573529; c=relaxed/simple;
	bh=0Y+TeetPK1sXCb/1u7pnHcRDWAB6amzW7kUDqeN3Whs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeO7AVGCtHH/wxx6mDyHjK19fChmryCcBsRfqBPb8/es60IHL5ph0NKKQimkHSlzDS/OP9rnn6v2s6SFnQ/bfuC30suijWGoRLPq/xo4nu+ldV8mZDykcJi+y8zCckE+jScyGYicOIE7LjFEa9mPhLHt9qXWN3KvK7TAIT9VpsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBdLi4IP; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780573526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGeL7NiuE1trFM+DToRpd6ciMCeQVr8e9ns4mRVJyio=;
	b=BBdLi4IPCYd3i3k7F/GhQVI1LE0QoS4iwaYgXrHf6m3PjX+9rKBsxLkzb6/SRqEtdRVv+w
	pAnH3b+dgdslNUbDXgO9PT/F1Xu+41eSij/a/1PC9t6WqMdEfffAxqK3VauNBGovPp/RCd
	zFVmCLu/o6iew0YN7jnt3HabXdoyyx0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-9I4vO23_OJOGvjjFqNya4g-1; Thu,
 04 Jun 2026 07:45:22 -0400
X-MC-Unique: 9I4vO23_OJOGvjjFqNya4g-1
X-Mimecast-MFC-AGG-ID: 9I4vO23_OJOGvjjFqNya4g_1780573520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E716180034E;
	Thu,  4 Jun 2026 11:45:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 375F41955BC0;
	Thu,  4 Jun 2026 11:45:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: lawson.fidelio@gmail.com
Cc: woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	marex@denx.de,
	maxime.chevallier@bootlin.com,
	horms@kernel.org,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Tristram.Ha@microchip.com,
	Woojung.Huh@microchip.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nb@tipi-net.de,
	fidelio.lawson@exotec.com,
	marex@nabladev.com
Subject: Re: [PATCH net-next v9 3/3] net: phy: micrel: expose KSZ87xx low-loss cable tunables
Date: Thu,  4 Jun 2026 13:41:33 +0200
Message-ID: <20260604114133.170770-1-pabeni@redhat.com>
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v9-3-fdbbb15592cb@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v9-3-fdbbb15592cb@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk,vger.kernel.org,tipi-net.de,exotec.com,nabladev.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295200-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lawson.fidelio@gmail.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:marex@denx.de,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:Tristram.Ha@microchip.com,m:Woojung.Huh@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:fidelio.lawson@exotec.com,m:marex@nabladev.com,m:lawsonfidelio@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C5A763F8B4

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net: phy: micrel: expose KSZ87xx low-loss cable tunables

This commit adds support for the KSZ87xx low-loss cable PHY tunables in the
Micrel PHY driver. It implements the get_tunable and set_tunable callbacks
to control receiver behavior. These callbacks are forwarded via standard
phy_read() and phy_write() operations.

> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index e211a523c2584..bb8f3054e2574 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c

[ ... ]

> @@ -6961,6 +7013,8 @@ static struct phy_driver ksphy_driver[] = {
>  	/* PHY_BASIC_FEATURES */
>  	.config_init	= kszphy_config_init,
>  	.match_phy_device = ksz8795_match_phy_device,
> +	.get_tunable	= ksz8795_get_tunable,
> +	.set_tunable	= ksz8795_set_tunable,

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the addition
of these callbacks, I noticed a pre-existing issue in the ethtool core.

In net/ethtool/ioctl.c:set_phy_tunable(), the capability check wrongly examines
phydev->drv->get_tunable instead of set_tunable:

	phy_drv_tunable = phydev && phydev->drv && phydev->drv->get_tunable;
	if (!phy_drv_tunable && !dev->ethtool_ops->set_phy_tunable)
		return -EOPNOTSUPP;
...
	if (phy_drv_tunable) {
		mutex_lock(&phydev->lock);
		ret = phydev->drv->set_tunable(phydev, &tuna, data);

Since the capability check looks at get_tunable but unconditionally calls
set_tunable, could this lead to a NULL pointer dereference if a PHY driver
were to implement only read-only tunables by providing just get_tunable?

>  	.suspend	= genphy_suspend,
>  	.resume		= genphy_resume,
>  }, {
-- 
This is an AI-generated review.


