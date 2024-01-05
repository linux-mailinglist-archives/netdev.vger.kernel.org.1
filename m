Return-Path: <netdev+bounces-61772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E19824DB7
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 05:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB83283640
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 04:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766C21FDB;
	Fri,  5 Jan 2024 04:44:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from anchovy3.45ru.net.au (anchovy3.45ru.net.au [203.30.46.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9AC5228
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 04:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electromag.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electromag.com.au
Received: (qmail 14818 invoked by uid 5089); 5 Jan 2024 04:38:07 -0000
Received: by simscan 1.2.0 ppid: 14648, pid: 14649, t: 0.4312s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Level: 
Received: from unknown (HELO ?192.168.2.4?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 5 Jan 2024 04:38:05 -0000
Message-ID: <9e371efe-8759-4e4a-bbd6-8ec2a12620a1@electromag.com.au>
Date: Fri, 5 Jan 2024 12:37:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/1] Prevent DSA tags from breaking COE
Content-Language: en-US
To: Romain Gantois <romain.gantois@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
  Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,
  Maxime Coquelin <mcoquelin.stm32@gmail.com>,
  Miquel Raynal <miquel.raynal@bootlin.com>,
  Maxime Chevallier <maxime.chevallier@bootlin.com>,
  Sylvain Girard <sylvain.girard@se.com>,
  Pascal EBERHARD <pascal.eberhard@se.com>, netdev@vger.kernel.org,
  linux-stm32@st-md-mailman.stormreply.com,
  linux-arm-kernel@lists.infradead.org
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <f4166144-4874-4b10-96f8-fc3e03f94904@lunn.ch>
 <cdc38cdf-536c-c23b-46c1-abadf14001a2@bootlin.com>
From: Richard Tresidder <rtresidd@electromag.com.au>
In-Reply-To: <cdc38cdf-536c-c23b-46c1-abadf14001a2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit





Richard Tresidder


Hi All
    Just wondering if from a custom platform point of view it might be better to use vlan tagging instead of DSA in the case where the MAC can't handle DSA tags in the header.
The marvel chip can use VLAN tagging to perform basically the same thing is my understanding, you just have to nominate a vlan id (untag outbound) to a port and trunk on cpu interface..
Just considering this as from my understanding the STMMAC does understand VLAN tags and will correctly generate the CRC.
I don't think this would stop us using VLAN for the ports in general, they'd just have a "default" tag for each port thats used for untagged packets on the port.
You could still apply additional VLAN's over those same ports..

I don't suppose anyone has some CPU usage info on software CRC vs this method?
I'm not sure if this is just an IP CRC issue or a TCP CRC issue also ( can the stmmac offload the TCP CRC also? )
If this is only an IP issue and the TCP CRC is never offloaded then it probably won't make much difference in reality..

Thanks
    Richard Tresidder

On 19/12/2023 5:50 pm, Romain Gantois wrote:

> On Mon, 18 Dec 2023, Andrew Lunn wrote:
> ...
>> Probably a dumb question.... Does this COE also perform checksum
>> validation on receive? Is it also getting confused by the DSA header?
>>
>> You must of tested receive, so it works somehow, but i just wounder if
>> something needs to be done to be on the safe side?
> That's a good point, I just investigated the RX path a bit more and the MAC
> indeed has IP/TCP/UDP RX checksum offloading enabled. However, the
> external switch in my setup uses EDSA tags, which displace the "true" ethertype
> field to the end of the DSA header and replaces the "normal" ethertype with
> ETH_P_EDSA (0xdada). So to the MAC controller, the ethernet frame has an unknown
> ethertype, and so it doesn't see it as an IP frame at all. All of the
> ethtool counters related to IP stuff are at 0, which supports this.
>
> This explains why checksum offloading doesn't break the RX path in my case.
> However, other maybe other DSA switches using different frame formats could
> cause different behavior? Considering this, I think it would be safer to change
> the dsa_breaks_tx_coe flag to a general dsa_breaks_coe flag. It makes sense to
> me to assume that if DSA tags break TX COE, then RX COE will also not work.
>
> I'll take this into account when I send a v2.
>
> Best Regards,
>

