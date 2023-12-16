Return-Path: <netdev+bounces-58187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF99815801
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 07:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88501C23ABA
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 06:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0502F12B68;
	Sat, 16 Dec 2023 06:23:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from anchovy2.45ru.net.au (anchovy2.45ru.net.au [203.30.46.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667F199AD
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electromag.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electromag.com.au
Received: (qmail 2195 invoked by uid 5089); 16 Dec 2023 06:16:15 -0000
Received: by simscan 1.2.0 ppid: 1962, pid: 1963, t: 0.4050s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Level: 
Received: from unknown (HELO ?192.168.1.24?) (rtresidd@electromag.com.au@202.90.244.20)
  by anchovy3.45ru.net.au with ESMTPA; 16 Dec 2023 06:16:14 -0000
Message-ID: <624fc854-a8cf-43d5-9be0-6c2c0dccad1f@electromag.com.au>
Date: Sat, 16 Dec 2023 14:15:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DSA tags seem to break checksum offloading on DWMAC100
To: Romain Gantois <romain.gantois@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
  Florian Fainelli <f.fainelli@gmail.com>,
  Vladimir Oltean <olteanv@gmail.com>,
  Alexandre Torgue <alexandre.torgue@foss.st.com>,
  Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
  Maxime Chevallier <maxime.chevallier@bootlin.com>,
  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Linus Walleij <linus.walleij@linaro.org>
References: <c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com>
Content-Language: en-US
From: Richard Tresidder <rtresidd@electromag.com.au>
In-Reply-To: <c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/12/2023 5:54 pm, Romain Gantois wrote:

> A similar issue was just reported for a different MAC driver:
>
> https://lore.kernel.org/netdev/20231215-new-gemini-ethernet-regression-v1-2-93033544be23@linaro.org/T/#u
>
> Hello everyone,
>
> I was rebasing on net-next an out-of-tree stmmac driver for the RZN1 GMAC
> IP, and I noticed that something broke all TCP transmissions going through the
> GMAC1 Ethernet controller. This MAC controller was connected to a 88E6352
> Marvell switch through its CPU port. Further investigation revealed that
> egressing packets had an invalid TCP checksum, which caused them to be dropped
> at the receiving side's kernel.
>
> A bisection on the transmitting side's kernel showed that the commit that caused
> the bug was:
>
>      6b2c6e4a938f (net: stmmac: propagate feature flags to vlan, 2023-04-17)
>
> This stmmac patch makes it so that most of the feature flags of stmmac net
> devices are copied to its vlan features. Some of these flags are then
> transmitted to DSA user devices. The NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM flags
> that control checksum offloading, are responsible for the bug.
>
> Relevant call chain:
> dsa_user_xmit -> ...[packet is tagged] -> __dev_queue_xmit \
> -> validate_xmit_skb and stmmac_xmit
>
> If checksum offloading is enabled, stmmac will set it in hardware at the
> following location:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/enh_desc.c#L322
>
> Then the hardware computes an incorrect checksum. I believe that this is caused
> by the presence of DSA tags in the frames, although I can't be 100% sure of
> this.
>
> So it seems like a solution is needed to prevent checksum offloading by Ethernet
> drivers when DSA tags are in used. I'm not sure how this would be done, since
> DSA is purposefully kept quite separate from CPU port drivers. What are your
> thoughts on this?
>
> Best Regards,
I'm working through a very similar issue in this conversation:
https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
It's the same commit that I found when bisecting that caused the issue.
We have this same stmmac interfacing with a 88E6352 running with the DSA 
driver.

Cheers
     Richard Tresidder


