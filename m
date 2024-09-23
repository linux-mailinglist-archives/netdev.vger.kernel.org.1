Return-Path: <netdev+bounces-129384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A264497F1DC
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 23:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540821F21FD9
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276E81AB4;
	Mon, 23 Sep 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="U0RXpVQP"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735F7F490
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727125714; cv=none; b=tzUEo1Qsukfg3m9sCr17z6T7sIb5QFM5op/KMqMMTFkfM5ZsPmkLyDydS++pXcjyTro4TWMuQNJCo7bSQOtg+zKgNN6YZFylnkmmRMA2eiGidrhHZT8SXoMz6uEL6ciIh2QuFeWI96wJEmK1ZH/mwAGyboK81tdyfyRtSC8zBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727125714; c=relaxed/simple;
	bh=q2VNMEaGRUapkndcG6AUoD7G9HUpmDWA3ormQAoufHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YlemJPcfk9EUKbfrljvi4D6O9ccXIX0StNjNbvK7Qdt/Bo9jMQhdBazg1p8I7Y+DMEreCEuKcpqq2+ppoeV4qv/2Yd8vy1baMVhHElWRUvV83isrfr5fgpXy0vk1EVi3JdSdWfac9KPcHG4B4TGOjIxphh0v3Ao/RFSHtbG3KVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=U0RXpVQP; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 48861 invoked from network); 23 Sep 2024 23:08:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1727125701; bh=lOrGp1Hu/W97GmSdIxxTTa5x6kv5D629Kv4Pg1JkF6k=;
          h=Subject:To:From;
          b=U0RXpVQPtsFsm1ywPKIe7iFeQzq5fVnCDuyL4UujRijqFtBg/RgvHyg/GHUvlTRAR
           2ef9FDXHb2azU/LfaXfQ4QJDx4nqHUZj6b67PfluVM85w7ufVihBK8Y1rCG33Ix9gF
           9JVuMpIx++PJFPpSQ43G4BlhcRH3qnKE8t9/MFmk=
Received: from 83.24.122.130.ipv4.supernova.orange.pl (HELO [192.168.3.100]) (olek2@wp.pl@[83.24.122.130])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <f.fainelli@gmail.com>; 23 Sep 2024 23:08:21 +0200
Message-ID: <991dc2b6-12ef-458d-b37f-562c15a73a07@wp.pl>
Date: Mon, 23 Sep 2024 23:08:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: ethernet: lantiq_etop: fix memory
 disclosure
To: Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, andrew@lunn.ch, horms@kernel.org,
 john@phrozen.org, ralph.hempel@lantiq.com, ralf@linux-mips.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240921105801.14578-1-olek2@wp.pl>
 <20240921105801.14578-2-olek2@wp.pl>
 <0a9830fe-790d-4ccd-bec9-3fbb32f18aa8@gmail.com>
Content-Language: en-US
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <0a9830fe-790d-4ccd-bec9-3fbb32f18aa8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 52fc65f06f3f95fc4676c694512f82ab
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [0YO0]                               

Hi Florian,


On 23.09.2024 20:21, Florian Fainelli wrote:
> On 9/21/24 03:58, Aleksander Jan Bajkowski wrote:
>> When applying padding, the buffer is not zeroed, which results in memory
>> disclosure. The mentioned data is observed on the wire. This patch uses
>> skb_put_padto() to pad Ethernet frames properly. The mentioned function
>> zeroes the expanded buffer.
>>
>> In case the packet cannot be padded it is silently dropped. Statistics
>> are also not incremented. This driver does not support statistics in the
>> old 32-bit format or the new 64-bit format. These will be added in the
>> future. In its current form, the patch should be easily backported to
>> stable versions.
>>
>> Ethernet MACs on Amazon-SE and Danube cannot do padding of the packets
>> in hardware, so software padding must be applied.
>>
>> Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
>> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
>> ---
>>   drivers/net/ethernet/lantiq_etop.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/lantiq_etop.c 
>> b/drivers/net/ethernet/lantiq_etop.c
>> index 3c289bfe0a09..36f1e3c93ca5 100644
>> --- a/drivers/net/ethernet/lantiq_etop.c
>> +++ b/drivers/net/ethernet/lantiq_etop.c
>> @@ -477,11 +477,11 @@ ltq_etop_tx(struct sk_buff *skb, struct 
>> net_device *dev)
>>       struct ltq_etop_priv *priv = netdev_priv(dev);
>>       struct ltq_etop_chan *ch = &priv->ch[(queue << 1) | 1];
>>       struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
>> -    int len;
>>       unsigned long flags;
>>       u32 byte_offset;
>>   -    len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
>> +    if (skb_put_padto(skb, ETH_ZLEN))
>> +        return NETDEV_TX_OK;
>
> You should consider continuing to use the temporary variable 'len' 
> here, and just re-assign it after the call to skb_put_padto() and 
> avoid introducing potential user-after-free near the point where you 
> program the buffer length into the HW. This also minimizes the amount 
> of lines to review.

To the best of my knowledge, the skb is not released until the DMA 
finishes the transfer.
Then the ltq_etop_poll_tx() function is called, which releases the skb. 
Can you explain
what sequence of events can lead to a use-after-free error?

-->ltq_etop_tx()
      |
      | (dma irq fires)
      |
      -->ltq_etop_dma_irq()
           |
           | (napi task schedule)
           |
           -->ltq_etop_poll_tx()
                |
                |
                |
                -->dev_kfree_skb_any()

Regards


