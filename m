Return-Path: <netdev+bounces-255075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGe3Cxx2fGmWNAIAu9opvQ
	(envelope-from <netdev+bounces-255075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:13:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5406FB8C4B
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08CF53003BF2
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AAF34EF1E;
	Fri, 30 Jan 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kZ65059O"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6451334DCE3
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764374; cv=none; b=gHV9FHomo2JTiW12rQPhwG3wFNvG6b5xvTCxQz/YIXIl7Za7G7Nncuxou0pk2j0V+4RzMj3CZ6TY5zEogfxq2/sRaD0t7U2bBrZ/quMkB33oAqsYgZPVASYcsrLVt3uY6g+gZ9qLiA/0aksy6Kd0G7oNSCmOFT2Vw8pRLDimfR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764374; c=relaxed/simple;
	bh=o4qpJAfiNyeL6Fj9BGIqCCcCv4uIJ4uVIS/X4VFGV64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+hczmk2ON6EQStIQVBxnHuJ1SiNkNF3g+LfV00X4zkM71ozUOM2dlf+4sV21Zm8eGgOAMPnCs75Jw6DU8KhgHAw3xN4wVFr+QmOMCuSwoVKHmOiKZoNocqRy+I3VQMa5p+upj+3OFABQxwOTRETf/GaA7jLDuFcU3BtagbU+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kZ65059O; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C29034E42340;
	Fri, 30 Jan 2026 09:12:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 944CF6075A;
	Fri, 30 Jan 2026 09:12:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8D95119A8884;
	Fri, 30 Jan 2026 10:12:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769764368; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7Z16KRUuvvver/+C25LTNG/C+Q38nHHdfZUCB5foSSU=;
	b=kZ65059O4gt6+PeWcYsv5PEpVuCXbD6Re1yntra0/GSQDtgvYup9hlwb9WZK/KoU9vIOWq
	MoTWngAqbmZFpyhy26iQ9HhTmHBMVfV5nJwvXvub12qnez4O/zScYiVND5UybdaxfJW4ab
	v75QCHZqML3qCqA1XFz6p7g1K9UrLLOu2meH+g/NM0V9FX0fvDqBRsc9JoVL0cVXEDkLAv
	NZvxrjMZNfjUi4dpca/8l2/iW/TDZv892cbWt8pdJt6s8fxzPnSUEiAf9QvvccYqQuaK2A
	NUZ9gHvNmtkWNvxJA0h+A4s4XC4sab4jg9vRbEZGafdY+zZ4zUjh6Y6gO6Ak8A==
Message-ID: <7fc065e8-c85b-4faf-9104-1b6b54327a02@bootlin.com>
Date: Fri, 30 Jan 2026 10:12:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: add device link between MAC device and MDIO
 device
To: Wei Fang <wei.fang@nxp.com>, Russell King <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
 "xiaolei.wang" <xiaolei.wang@windriver.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "quic_abchauha@quicinc.com" <quic_abchauha@quicinc.com>,
 "quic_sarohasa@quicinc.com" <quic_sarohasa@quicinc.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260126104409.1070403-1-wei.fang@nxp.com>
 <20260128201501.04bb6e5c@kernel.org> <aXsxJa0D0bohafRs@shell.armlinux.org.uk>
 <PAXPR04MB85106B63AF43DE0830B4C362889FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <PAXPR04MB85106B63AF43DE0830B4C362889FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,broadcom.com,windriver.com,davemloft.net,google.com,redhat.com,quicinc.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255075-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5406FB8C4B
X-Rspamd-Action: no action

Hi again,

On 30/01/2026 04:41, Wei Fang wrote:
[...]
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 81984d4ebb7c..c48335bfc7b6 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1771,9 +1771,17 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>          * another mac interface, so we should create a device link between
>          * phy dev and mac dev.
>          */
> -       if (dev && phydev->mdio.bus->parent && dev->dev.parent != phydev->mdio.bus->parent)
> -               phydev->devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
> -                                                 DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +       if (dev && bus->parent && dev->dev.parent != bus->parent) {
> +               if (phydev->sfp_bus_attached)
                      ^ assuming we replace with phy_on_sfp()
> +                       phydev->devlink = device_link_add(dev->dev.parent,
> +                                                         bus->parent,
> +                                                         DL_FLAG_PM_RUNTIME |
> +                                                         DL_FLAG_STATELESS);
> +               else
> +                       device_link_add(dev->dev.parent, bus->parent,
> +                                       DL_FLAG_PM_RUNTIME |
> +                                       DL_FLAG_AUTOREMOVE_SUPPLIER);
> +       }

I think we should let the phy_on_sfp() case alone for now. The lifetime
of the SFP phydev and the MAC are completely independent here, the PHY
can be probed/removed without the MAC being there, and vice versa.

The MDIO bus that controls that SFP PHY's lifetime is the same as the
PHY itself, the mdio bus in that case exists solely to drive that single
PHY, and in can't be shared between multiple PHYs even if we have
multiple SFP ports in the entire system.

The logical thing to do IMO is not to tie the MAC and the MDIO Bus
itself, but rather the MAC and the PHY as was done before. As you state,
we couldn't set DL_FLAG_AUTOREMOVE_SUPPLIER because of SFP PHYs, but
if we add the check on "phy_on_sfp()", it should now be fine.

Maxime




