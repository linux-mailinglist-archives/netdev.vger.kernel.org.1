Return-Path: <netdev+bounces-267017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPoEGziasmnENwAAu9opvQ
	(envelope-from <netdev+bounces-267017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:49:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4542707D4
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92A9030B100B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C70835A3A5;
	Thu, 12 Mar 2026 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFJrRQbs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EBB40DFAB
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312477; cv=none; b=W2Wuk0fwnVm0Tdfuk9XxU5sd4xeeuJVwpKIeB46c2uLFbAvkcVWi1p7G8GxWdGB8RQ9fDixh1mW9+x3G07Ld+m8w3RP8pYYtVzahognUPWNWiHxNzEcMqD69qAn9FoepGNQl20UiCJ5CVzC46+zz6s+caBFGk/kbDSHiHM44TVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312477; c=relaxed/simple;
	bh=QOAYlKY2ktlcr7XMTFUwqIc4yokPnge21rSdMx9K+sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjMTLhMLKITuL20TGFczNtYj/EYTfh2OmSgGk5/QySmDr04/VBhY1sVaDLWD8s7+Agyyuf6nvMx7fzIqWHq/ASpLVbIz1gMKH+w8KIxazill2269VSL1/eRqLANL8hp0trdCCn4hwpWhxi/2UGAnDFqKLhE6d0gU/i6V054GeYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFJrRQbs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773312474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBbA1/ik/0YTVocgfvCpWjmzc9hPTwxow3U+iCUGirM=;
	b=VFJrRQbsUu1wjYaCACdgALHuLi6nk8rn45mP+iwgR5HNIIQGqHO02FzYSWFl4ndV/Fmm6s
	pqdJ0S0yxMQNqHzIi0EXnhDhl8Oj10jA6qB7P9XFNGQtEuFB4SXSOW3r8eGiHtuSM7+zad
	QoWo1sxud29TflAE6Gip5bQQa1S67z4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-G5hOaZNGOPiTzdGLMwCCeA-1; Thu,
 12 Mar 2026 06:47:51 -0400
X-MC-Unique: G5hOaZNGOPiTzdGLMwCCeA-1
X-Mimecast-MFC-AGG-ID: G5hOaZNGOPiTzdGLMwCCeA_1773312468
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39AFD197768A;
	Thu, 12 Mar 2026 10:47:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.34.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2F2119540C2;
	Thu, 12 Mar 2026 10:47:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: maxime.chevallier@bootlin.com
Cc: o.rempel@pengutronix.de,
	herve.codina@bootlin.com,
	andrew@lunn.ch,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	hkallweit1@gmail.com,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	romain.gantois@bootlin.com,
	f.fainelli@gmail.com,
	christophe.leroy@csgroup.eu,
	kory.maincent@bootlin.com,
	mwojtas@chromium.org,
	dimitri.fedrau@liebherr.com,
	nicveronese@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@makrotopia.org,
	kabel@kernel.org,
	linux@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	davem@davemloft.net,
	thomas.petazzoni@bootlin.com,
	bjorn@kernel.org
Subject: Re: [net-next,v7,05/10] net: phy: Represent PHY-less SFP modules with phy_port
Date: Thu, 12 Mar 2026 11:47:33 +0100
Message-ID: <20260312104733.87688-1-pabeni@redhat.com>
In-Reply-To: <20260309152747.702373-6-maxime.chevallier@bootlin.com>
References: <20260309152747.702373-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267017-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,bootlin.com,lunn.ch,google.com,vger.kernel.org,gmail.com,kernel.org,csgroup.eu,chromium.org,liebherr.com,redhat.com,makrotopia.org,armlinux.org.uk,nxp.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA4542707D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: Represent PHY-less SFP modules with phy_port

Now that the SFP bus infrastructure notifies when PHY-less modules are
connected, we can create a phy_port to represent it. Instead of letting
the SFP subsystem handle that, the Bus' upstream is in charge of
maintaining that phy_port and register it to the topology, as the
upstream (in this case a phy device) is directly interacting with the
underlying net_device.

Add a phy_caps helper to get the achievable modes on this module based
on what the phy_port representing the bus supports.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 4b06644866b2..faa58a780477 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1483,6 +1483,8 @@ static int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
>  	struct phy_device *phydev = upstream;
>  	struct net_device *dev = phydev->attached_dev;
>
> +	phydev->has_sfp_mod_phy = true;
> +
>  	if (dev)
>  		return phy_link_topo_add_phy(dev, phy, PHY_UPSTREAM_PHY, phydev);

If phy_link_topo_add_phy() fails, does has_sfp_mod_phy get cleaned up
correctly?

Looking at the SFP framework, when phy_link_topo_add_phy() fails here,
sfp_sm_probe_phy() in sfp.c will free the PHY but won't call
disconnect_phy (because sfp->mod_phy was not set). This leaves
has_sfp_mod_phy stuck as true.

On a subsequent SFP module insertion, phy_sfp_module_start() checks
!phydev->has_sfp_mod_phy:

drivers/net/phy/phy_device.c:phy_sfp_module_start() {
	if (!phydev->has_sfp_mod_phy)
		return phy_add_sfp_mod_port(phydev);
}

Seeing has_sfp_mod_phy is true (stale), it skips creating the mod_port
for a PHY-less module. The module then won't be represented in the link
topology.

Would it be better to either set has_sfp_mod_phy after
phy_link_topo_add_phy() succeeds, or clear it in an error path?


