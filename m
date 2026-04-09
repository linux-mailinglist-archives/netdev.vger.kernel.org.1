Return-Path: <netdev+bounces-276892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNitJP1l12myNggAu9opvQ
	(envelope-from <netdev+bounces-276892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:40:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C93C7DA8
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61FEC3008250
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA413A3E6B;
	Thu,  9 Apr 2026 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ulCKhMG/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F12EAD1B
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724026; cv=none; b=sgjIdShEu2B2yc/iaPPpYf6TqRyr3kfSErFeJkPA3M7m1IzwulJ3P2Ivuxd/3ssQ71Dr+HU3wKoNJ/DFvv81vkAHbyZnVxTCA8Hi5L5E5a6yG9GdRSxuVP1oKZd5syxp3YWogF1/KdP3opvHdWVR7zm9dM0sY4XyPdZU0GR8/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724026; c=relaxed/simple;
	bh=rtao9N9/Zr6M6atUlSC7Uf3NJjJsFhoS0cSwJqwdQGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0f2qeoeNXCwEMFHm80PxfI+O8a9jpy7532FArvdGSR9upaSZwA/RzTcc+0wcEB32BbN3TovFJp0TBr0CpoW/+Aji6YtUCvlRlsM6qp97wEe7lNz+9YWb4OG3a33OzQi+VIV0w7KdW66h+MMPNVCym3GHpJpGmurq7TD4Mm/cnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ulCKhMG/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C5A4A1A3230;
	Thu,  9 Apr 2026 08:40:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96E975FDEB;
	Thu,  9 Apr 2026 08:40:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CECEF104500A8;
	Thu,  9 Apr 2026 10:40:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775724021; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=uROhnwnHliOgM+Qmr3h9fZz3BgpvJO5hwrCBupSyy5s=;
	b=ulCKhMG/xHNUs28wb39v3ofJV+4Ajt03BAUdcxoh0ZYwHCofP5ewtFtUnWSxdGIIOZHB6y
	mufbilUuGFk8/gFpqVcpW4Azdr4c+S7hZfMlgQXU/WWtOZRiqlj4E3JgFYSwSlvH90mbCM
	qf/fOk9PBRbXVuZ82ZZy/1BSK7JkhqdKfkH7tiPlFWERXBr0X+n64QWnnKGsBwQkB7kulK
	2igavCR/4s1y66wcRrFoSOMqOA68/vz36sgRARItdJVXout+mIwS1aLkWpj8oUb9VmGQ2C
	te4VPRYZatJxzbOAo5oiQaRt+a4LMFZ6NbH2cNX745+SKnyX6LTM5jTAfloYfw==
Message-ID: <e6380e63-52b1-4d49-b639-ca638bf21225@bootlin.com>
Date: Thu, 9 Apr 2026 10:40:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 00/10] net: phy_port: SFP modules
 representation and phy_port listing
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
 <76e290cd-22bd-4ed3-b2b3-036e1edff140@redhat.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <76e290cd-22bd-4ed3-b2b3-036e1edff140@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276892-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,davemloft.net,lunn.ch,kernel.org,google.com,armlinux.org.uk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 365C93C7DA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09/04/2026 09:35, Paolo Abeni wrote:
> @Maxime: I went over sashiko feedback and I *think* it ranges from
> orthogonal to wrong, but it would be useful if you could go over it.

Yeah I've looked at its feedback, and indeed most of it is incorrect or
irrelevant :(

Let's see if the PHY crew have things to say on the overall approach :)

Thanks for pinging on this,

Maxime

> 
> Thanks,
> 
> Paolo


