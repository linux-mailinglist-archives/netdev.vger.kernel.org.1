Return-Path: <netdev+bounces-295029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /l0sFeriIGqI8wAAu9opvQ
	(envelope-from <netdev+bounces-295029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:28:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE17663C827
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:28:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ctVzrtCU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295029-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295029-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 784B430015BE
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED323EAB4;
	Thu,  4 Jun 2026 02:27:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84A379C5F;
	Thu,  4 Jun 2026 02:27:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540071; cv=none; b=fIoHxs04tNUnTBTZk4/quEpwpODE8zlP3+udaRmDvjaLsEc4kQHuWL8Z63qQpoy6KX6VwkSB1JeOnR+vygok+0+HNxiyEH8VIy/NT+LgMAWHumK8qJkmC0JrE6TaGszZs7S/0n89u/K2EY5Iujyg255FZClRP4fkC7bh0W/xVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540071; c=relaxed/simple;
	bh=//ycdR9j666aB+3laQyvxqliimkNigFli/rTv0dJYlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lW6vKiW7d5/djptAqUDF0LDTMOrDWrJih/on9Z+3wN3yjQfJyf2BvAueBWTFNYp5PLivlvaydI7Qx1eXNmioq6Edz6cEHaSxvkIA7AvvzM+9fdtsFGjLTt5Ildtbb+h2aBrOia5GuWnGcD0hNlm7Kf5Pdr7xPoAq+PeyMXGzohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctVzrtCU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508D71F00893;
	Thu,  4 Jun 2026 02:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780540067;
	bh=OsaDkSdZoV/McZV7BLdMAnT/Q/15j5KgU6rySIlZccY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ctVzrtCUrS8/cvpyBFFEXlhRoSWY/002kp9vsyPD1O4FyqNzGbkYgxjAGp06HBJN8
	 tWxJ3PO8WN4CvJ6sGXz4ubWSeAEY1zqIwEpvDczvpNqqPeyqCZWHCaQrndiwuyovbc
	 K+ehveaek/iveDKzsZknnjgE5xe8liRs+FmOLSzk4KRORO8iiu/AhMg1wWRKXMXZDx
	 NG2uI6kcWanG6u1D9crQ9zE5F3WWszVbxjmi8C41pzaFa5uCl2cfbjmj6vaKZQcMaY
	 +E40ZiGnQS+iRsZBstLmEOKmwbJkE/MoG71HdPEkkwcF5py+ODQ+Wb2pkkwO6fpJ58
	 rLLCOK5IFZZQw==
From: Jakub Kicinski <kuba@kernel.org>
To: maxime.chevallier@bootlin.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net v2 3/3] net: phy: don't try to setup PHY-driven SFP cages when using genphy
Date: Wed,  3 Jun 2026 19:27:30 -0700
Message-ID: <20260604022729.2925198-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601084029.815461-4-maxime.chevallier@bootlin.com>
References: <20260601084029.815461-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com];
	TAGGED_FROM(0.00)[bounces-295029-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE17663C827

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: phy: don't try to setup PHY-driven SFP cages when using genphy

This change skips phy_sfp_probe() when the genphy driver is bound,
avoiding an RTNL deadlock in sfp_bus_add_upstream() since genphy
binding runs under RTNL while non-genphy driver binding does not.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index a171cbe2a74a..8eace58e9f12 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3512,9 +3512,14 @@ static int phy_setup_ports(struct phy_device *phydev)
>  	if (ret)
>  		return ret;
>  
> -	ret = phy_sfp_probe(phydev);
> -	if (ret)
> -		goto out;
> +	/* We don't support SFP with genphy drivers. Also, genphy driver binding
> +	 * occurs with RTNL help, wich will deadlock the sfp_bus_add_upstream().
                          ^^^^

[Low]
There is a typo in the new comment, "wich" should be "which".

> +	 */
> +	if (!phydev->is_genphy_driven) {
> +		ret = phy_sfp_probe(phydev);
> +		if (ret)
> +			goto out;
> +	}
>  
>  	if (phydev->n_ports < phydev->max_n_ports) {
>  		ret = phy_default_setup_single_port(phydev);

