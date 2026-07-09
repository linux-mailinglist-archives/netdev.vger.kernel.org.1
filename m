Return-Path: <netdev+bounces-306151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id degdOZVyT2qtgwIAu9opvQ
	(envelope-from <netdev+bounces-306151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:06:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6856972F576
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:06:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=RnpOXyE1;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306151-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306151-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3B523083912
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC5A403B1A;
	Thu,  9 Jul 2026 09:57:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B1404BF4
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:57:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591064; cv=none; b=J5hOeq2afyMonmuH9vZbcNTeznFkmiB1h3UDrSdPjfZIDDhDe7RKA6U2rEzVx5tUgdsh73KF5UP/or1jjbspzHDVloTH7lZ76Es/a17EV43LeAVWfu38iBVxxi1UX8wUVh4O+kyRZk1vSauQ9HJzpnn5nwE6wtMunIqbZfKi9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591064; c=relaxed/simple;
	bh=Pzovs7+ceuL9Gbq7CF1bSTvbNZrIKxrZaUVNj+KFrLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLV7TWbblELnKC1ZOcqvlTX558iskJjq2FQ5vmUBON3acCqyCcluCyMPVS3mElZ5I8alV9wSNWqNjYZ4y/dQlxoSrOFm84NoAU/6hMprfNM+Rjw41anXWZ3qG1fCLrPw/5GkrwKKdNsRlcr9CsOpScHRKmVHlHdt8wflNGQSSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RnpOXyE1; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4B0C8C2F4C0
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:57:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB2A35FF03;
	Thu,  9 Jul 2026 09:57:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 04C9311BC372F;
	Thu,  9 Jul 2026 11:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783591054; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/gkI1MXnCEYH3Di825+Sh3B3L9iCOKimmTxO6EW759A=;
	b=RnpOXyE16ndyZJ/dMZSZ7JBLpKIqyfsthPU6taRnVRv7UodYqcjYd6Q9uCpZHoD/xQ2bQl
	a9YLpVXww/on8k8TZIut0aEvyMo2D+YGgbmxq8ikCx34FQcROgiEqgiJ0WGV5Kr3xKKSeg
	Mk3ah6yzyZjaR2O4aGsrZAEfQao2P3VcIPck2WOSjIXgHFCuItRqK3H2+RNwzpNiwbflG1
	OLatsWGIC/HCthDIGz1vFrqB3LzTluYTUYpTBaV+tYx5Gq0gTOkc48RaMgrz81utbI959i
	Rs1mcFIdJpW9tyv2ySb/Hhts4rS0zFllMtLoiW5a2nnVYbby8e0TAbIjTBq9zQ==
Message-ID: <9d4bab68-6383-4b8d-a9d0-144b348e937c@bootlin.com>
Date: Thu, 9 Jul 2026 11:57:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question: net: phy: realtek: RTL8211FS SGMII bridge mode support
To: Jacky Huang <jackyhuang@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260709035244.3008436-1-jackyhuang@nvidia.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260709035244.3008436-1-jackyhuang@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jackyhuang@nvidia.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,lunn.ch,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306151-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6856972F576

Hi,

On 7/9/26 05:52, Jacky Huang wrote:
> Hi,
> 
> RTL8211FS is the SGMII-capable variant of RTL8211F. Besides the standard
> copper/RGMII mode, it supports hardware-strapped RGMII-to-SGMII bridge mode,
> where the MAC side uses RGMII and the line side uses SGMII.
> 
> The in-tree realtek driver currently does not handle this mode. RTL8211FS
> shares the same PHY ID as RTL8211F (0x001cc916), so the driver binds it
> as a standard RTL8211F and follows the existing copper/RGMII path. In
> RGMII-to-SGMII bridge mode, this means read_status() does not observe the
> SGMII-side link and the link stays down.
> 
> We have discussed this with Realtek. They confirmed that the current mode
> can be detected from a vendor mode-selection register shared by RTL8211F
> variants, and that this case is application-dependent rather than generic
> copper PHY behavior.
> 
> Our plan is to add RTL8211FS bridge mode support inside the realtek
> driver, gated on the detected mode. The driver would only read this
> register for detection and would not use it to override the hardware
> strapping. For that mode, config_init() would program the SGMII side as
> needed, and read_status() would read the SGMII-side link status instead
> of relying on the copper path. The existing RTL8211F copper/RGMII behavior
> would be left unchanged.
> 
> Does this approach sound acceptable for upstream? If you prefer a
> different model, or if there is already related work that we should build
> on, please let me know.

If you can tell the mode based on the straps, that's OK :) There are other drivers
that do the same, for example the TI dp83869 (it's not based on a strap value,
but rather a custom DT property, but it's the same idea), or some broadcom
drivers that read strap state from registers and switch to fiber mode.

What's missing is proper support for what comes after the SGMII bridge, if you
have an SFP after for example, there's all the plumbing to support handling that
SFP module, however there's no way (yet) to handle the PHY within that module,
as you'll have :

MAC - RGMII - PHY - SGMII - PHY
                             ^
                             |
     nothing handles the state machine of that
     one PHY

If you have a DSA switch on that SGMII link though, it may "just work" as long as
you correctly read the status and configure inband aned on the SGMII side.

Maxime

