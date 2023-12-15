Return-Path: <netdev+bounces-57847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AE9814502
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105B22846C8
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3008618AF9;
	Fri, 15 Dec 2023 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="keXYR0sr"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC261945E
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id CE73FC4D10
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 09:54:16 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2F7820013;
	Fri, 15 Dec 2023 09:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702634048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nw/hzCkFH5eYrDqILxAbbkPBHxaHykr2NPyZgucV/cs=;
	b=keXYR0srC8NuJlisEqKTGw57TVkT7DXd+xt9JmSZAEMPolh96RiZPsiRvcyhZ540EQOTUU
	0xLsRhi5BEA0uxYfG5AAr8BIAngFCTwNa/KPyE4TmI4Y8E457Q0eQyFznvNbMrfnKkJdWI
	8UE1gzuH3agI+/j6yTWDXkwHxNdhsiZGBhmny2ReeYgEdRtVIWFvoh7QqKtbmIO5R+tx12
	nB55gTC5s+iBM5ruBqUM0QBC7+1FBVg4ZI1/x4cOtMkVvLM0eH0IIddMbYBLemebZlirog
	WOYkB+LXQ1Kmthe1B0zSx+h1ObldR+UEfl7YNl3WwsEP0hTCwY+E7lXzEsQ5LQ==
Date: Fri, 15 Dec 2023 10:54:27 +0100 (CET)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
    Vladimir Oltean <olteanv@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>
cc: "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>, 
    Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
    Linus Walleij <linus.walleij@linaro.org>
Subject: DSA tags seem to break checksum offloading on DWMAC100 
Message-ID: <c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com


A similar issue was just reported for a different MAC driver:

https://lore.kernel.org/netdev/20231215-new-gemini-ethernet-regression-v1-2-93033544be23@linaro.org/T/#u

Hello everyone,

I was rebasing on net-next an out-of-tree stmmac driver for the RZN1 GMAC
IP, and I noticed that something broke all TCP transmissions going through the
GMAC1 Ethernet controller. This MAC controller was connected to a 88E6352
Marvell switch through its CPU port. Further investigation revealed that
egressing packets had an invalid TCP checksum, which caused them to be dropped
at the receiving side's kernel.

A bisection on the transmitting side's kernel showed that the commit that caused
the bug was:

    6b2c6e4a938f (net: stmmac: propagate feature flags to vlan, 2023-04-17)

This stmmac patch makes it so that most of the feature flags of stmmac net
devices are copied to its vlan features. Some of these flags are then
transmitted to DSA user devices. The NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM flags 
that control checksum offloading, are responsible for the bug.

Relevant call chain: 
dsa_user_xmit -> ...[packet is tagged] -> __dev_queue_xmit \
-> validate_xmit_skb and stmmac_xmit

If checksum offloading is enabled, stmmac will set it in hardware at the
following location:

https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/enh_desc.c#L322

Then the hardware computes an incorrect checksum. I believe that this is caused
by the presence of DSA tags in the frames, although I can't be 100% sure of
this.

So it seems like a solution is needed to prevent checksum offloading by Ethernet
drivers when DSA tags are in used. I'm not sure how this would be done, since
DSA is purposefully kept quite separate from CPU port drivers. What are your
thoughts on this?

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

