Return-Path: <netdev+bounces-33314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC9279D5D7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9373281AE4
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9918C3B;
	Tue, 12 Sep 2023 16:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0D168CB
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:10:15 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7BA10F2;
	Tue, 12 Sep 2023 09:10:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 714D1240003;
	Tue, 12 Sep 2023 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1694535013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DT8iGeDItdtWzaedjFGa4m53NfWAlQ4+8otdLECzuho=;
	b=PnoY2ckTZmkESHjnuiBZzsNYU8+9I/M7/DFM3hDegKEZIkY66s7GOATe2qgCi4iJT3CDJc
	YJ3NCGAKB7C3ZHrFCfsrvDS6WNbkrZHvIfojkIjbCqTK3bQbAEJFE0+OhwkW9KD1J32vn4
	V73Nvjem4WcchpXoCRTCHJlmvucUOEJdtABoVcOK2Ty5gcYZwUQsV4otx3s+dbAifJF83J
	djDIm2CwkB1WA/lYQRshJ8Fbq28OxB0C/UMJlYAlryHzScmaoNzLhFgtsq7u9kiwSEzl/1
	/utBFWgQyBN/YZZ7AzJ8jEQdXx0L3DCRyK5ZLhex2XN3EEm5bVGYQaBRtQ7Y7w==
Date: Tue, 12 Sep 2023 18:10:10 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <linux@rempel-privat.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 1/7] net: phy: introduce phy numbering and
 phy namespaces
Message-ID: <20230912181010.615d6b79@fedora>
In-Reply-To: <d0a4c2c5-2d2b-42b6-a15c-06f9dc3c1e04@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
	<20230907092407.647139-2-maxime.chevallier@bootlin.com>
	<d0a4c2c5-2d2b-42b6-a15c-06f9dc3c1e04@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Tue, 12 Sep 2023 17:41:31 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > Introduce a numbering scheme allowing to enumerate PHY devices that
> > belong to any netdev, which can in turn allow userspace to take more
> > precise decisions with regard to each PHY's configuration.  
> 
> A minor point, and i know naming is hard, but i keep reading _ns_ and
> think namespace, as in ip netns. Maybe we should think of something
> other than ns.

Yeah that was the initial idea, to imply that the numering is
independent between netdevices... I thought about "phy_list", "phys",
"phy_devices" but none of that felt correct :(

Any idea here would be welcome :D

Maxime

>       Andrew


