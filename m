Return-Path: <netdev+bounces-231107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DC1BF5303
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E763A168E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF982EFD89;
	Tue, 21 Oct 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jylajQiN"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34802ECE92
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761034178; cv=none; b=BpChXXPZ4zr8PVTEMlRT4q3E8tcFBRk0qUXf0ojR7Ji6WlNTLIZQMptGRpA6EyGG44Ofyo/0GrSKd3YWLfTyfc9xm0ALCHyD1oMVq0LD/jpIWWmYtUziY7AxY0hkrcs8o4s9Pb+rJ8W3fcvf1+kSSCgaL1fuBg5kK0Zho8bOXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761034178; c=relaxed/simple;
	bh=2RdxWgIsanqm/sfNnjLv7GBwDmpGRLZbb1yuEaSRVlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEW1HG4RA0sWEwoJk13O0YcBjyRIz2wjT9rcaJH1r9xPX/bmz9M6RyaJI0K9hhjEzFW4PxlPrlCNTuCiWhbxyJaEV/aiwCw1SQz36Oz3jtgcPt+2iH9IV0Vf66BoxVf7xU9CDl7zenbAKYzpIHxn28sLCn5lwkXuikB7Yd7RcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jylajQiN; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0E0A3C0B88F;
	Tue, 21 Oct 2025 08:09:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9610860680;
	Tue, 21 Oct 2025 08:09:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66C00102F23E8;
	Tue, 21 Oct 2025 10:09:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761034169; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=uaJdoHn0NXDruimCAXmm8uA1Fs0q8Xm1i44RzkSnJK0=;
	b=jylajQiNswkpvpiLrpRh5lrXTaTqojw5jEJqLhUpL/ZqFUrnBRcvcO934JwKAlNNYApAXd
	Sa6UwGEwL9e7y7wlca6U8b/EFgTvmvkMJVHolpYSLiKOPISIh+A1ls3iURh15zFbPzjOu+
	XPZYQBSdnp9dDMWl/ocXovDmJw7NSZe/lsy3KhCehdtTUqhpdUsOf48DKEO5LRmS4EiS5V
	AxxsyDVpFYgG13bX5wjCFfPkuhjz12m7mTIg3OtJtfr4P4eDUthaIBQP4U1m2l7Irn8T/4
	4dNS7GVGHbn9Ynvqgg2jAHkA+XFZjHhCzL/OG2wBsHsoHbLo5zwAWywiJObqZQ==
Message-ID: <29322269-6d27-48da-a58b-1d2053369833@bootlin.com>
Date: Tue, 21 Oct 2025 10:09:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 00/16] net: phy: Introduce PHY ports
 representation
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Antoine Tenart <atenart@kernel.org>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20251013143146.364919-1-maxime.chevallier@bootlin.com>
 <20251020185249.32d93799@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251020185249.32d93799@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 21/10/2025 03:52, Jakub Kicinski wrote:
> On Mon, 13 Oct 2025 16:31:26 +0200 Maxime Chevallier wrote:
>> Hi everyone,
>>
>> Here is a V14 for the phy_port work, aiming at representing the
>> connectors and outputs of PHY devices.
> 
> I can't help but read the lack of replies from PHY maintainers
> here as a tacit rejection. Not entirely sure what to do here.
> Should we discuss this at the netdev call tomorrow (8:30am PT)?
> Would any PHY maintainer be willing to share their opinion?

I can definitely be there to discuss this, thanks for organizing this.

Maxime

