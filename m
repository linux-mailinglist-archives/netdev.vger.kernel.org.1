Return-Path: <netdev+bounces-298254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6xCmC7fxKmpKzwMAu9opvQ
	(envelope-from <netdev+bounces-298254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:34:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D88667406D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:34:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=DsapDA2P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298254-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298254-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 151C93184ECB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1324968F8;
	Thu, 11 Jun 2026 17:27:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C147A0C4
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:27:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198870; cv=none; b=nCgYkp8Pipr6XiZKYPbhKkzIKXDzdYDsmJjxIxSle8AH8bWhXYyV87ah9HpqT+ROZW/gwM59dMuoFgYg+gu2wdp8nVdYauZXRGy1xhLC1+ZKim7KVw+CKkTdntkT+IK2iVisPO3/R645zZocYkS0D4tstjl+fxYnFOYl4cwXk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198870; c=relaxed/simple;
	bh=BUtR5MZqv1EIA3dOo5fZmgYJOLCSX7+idufuoPL6GL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mb0kMW6A9j5tzuIM4JRqiEa1sYU/VEDF+RTAcELoX9Ff3K56Wr3uTGaD1o4No9Jcb0ph9BHxBc4lzPnFGXcWJ2VGpLi3MXsNAcpApa2fh+egY2UExxnwF4b+DsygV4wh9ononHbRdnHuK1uTw096+YF7ciJFG2iXIzjqpZwnzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DsapDA2P; arc=none smtp.client-ip=209.85.214.225
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2c0c2a68d01so929725ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198866; x=1781803666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Beizeq6ASxmWY7LEEw/Tb2oGDEMddZUWMtOPsvA8Iig=;
        b=o95HIWjYWOaSEipBzrlei8ebykLve3mABNpwW+ekjDthMcuKkE9+/xB1d67rbXW//Q
         iCM3EWUFeP6I6aVFVabsUAmvI7UNnJloHnhOEq4KceGY4DaEtndGAs8Wq8GT1jLlRw5V
         NhnWl1fgZ2bCi1t8CpE6j3hy/Fw4LIGpVX3/6fb6ofXK2yYyGJ7Df8q8Q7/4W+0qJMeg
         rUaJbxXViCJvVY7Hirs4/b5aoAjDalgbZcPIIyLQEhgpl0ZygzMS4RMoJunqtp+tJ+DU
         GAdvbiZyDlqlpaC3/Kd45YMQAz+13q96IbqoImSuKgecW6OimKQ3t2H0HzF5V2V87MmJ
         KBcw==
X-Forwarded-Encrypted: i=1; AFNElJ+X4hQE4n2tSnLaNZz9Tc0i+zbP3qpBROssH8oDYZA5BrKxNL0UDQDOIHGHGH2+C3yPtVgY9dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCoTQ9uBc1yFgGiMrIMEYV3I8iNGTlHLEgYOi6Cm1noCjppjFF
	LE4+TQ6dEMp626wTucWb4hxti/JfvyoeK4nwAojQUGEaBhoe4DG+EOBjpZVGYKWIS/QuCzLP0v+
	iHRZPhByPE30jqbRh+1TRdNC5xIPBeBbNKiQPwfgjKLphyk96FJhd8g/39t+Zp+/n69os9U16z5
	P5hxuxD9P+EmOU/zhVW+SQnw3A2lXskG5rDM8GkkNX8loyMOxd/1Uh5J+mTqyo70PGbUUN8+1a5
	dw7P+AJVA==
X-Gm-Gg: Acq92OGniqE3QAevPnbtO0nNStBkS0Qs6MwCArpfAQwSEkzuLxJul77G5PA5wXCFnMn
	1LBkrEfCHDntWv969Qz5Sinj6vGy/kcNP1IX5U8qeuHCFmF6MqtbKyr9WrreEBNVG5S1sZfC8cw
	jZqNz3fPnD4RBeyk6BuYPsIMWhYHLiv7ze6epDmTZzCNWh2WqjiN7oeLOef6UOXrRMPClrLG5cx
	OBBncX9muJeF1/SbZAESaACgUOfFXOlXoKqQKjXOXp5JgMRVE41xO7g1fsRgy2tgAvDo25P56ns
	pmd70HCaT7rZoa0ApjzXjY2UAZ9KZOP9pnU/Pak/Z15YFw662EyM/JdpYDOTfn2YpXkRv/X57Wz
	TWa+mQJrIMvoZriYOAK4GCyAJ5180zme2gVIRk0dpyXkqzWXbUOCd03zYQE1G+gmAhmkO/dpkwz
	rGPs7wkgsgGBCbCxd8KtoDw+ta+yNY6QV7FTv4mZngusalI9G7Xh3AjNSSnw==
X-Received: by 2002:a17:903:2385:b0:2c0:a373:89b9 with SMTP id d9443c01a7336-2c2f07317dfmr50083835ad.6.1781198866039;
        Thu, 11 Jun 2026 10:27:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c16648f2dfsm26789645ad.47.2026.06.11.10.27.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2026 10:27:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5a1912d5c85so35819e0c.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781198865; x=1781803665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Beizeq6ASxmWY7LEEw/Tb2oGDEMddZUWMtOPsvA8Iig=;
        b=DsapDA2Phl3tXFnUeLa5gJmp6mVLShhl35owQHvf1yAcJUnhUcO1VQ6FPo1ghP/9hM
         u+a3ichHsH0YNF0ORz675xVCThjxATOEdFt8+vyNbhLxmDdTNUo61ml4lyEw6zJhNuVu
         1WC2duM+FCxoVK5tQIypdZDxDojlojeGr9e+g=
X-Forwarded-Encrypted: i=1; AFNElJ8V+Vrf2jMQOvw9/yUe2PzMSMczp7UwKoZhq5itdkjitN2AKW8VUfmxgcmXY+9XP/j+MvRTRt4=@vger.kernel.org
X-Received: by 2002:a05:6122:208a:b0:5ab:2fb:2dfb with SMTP id 71dfb90a1353d-5bb02415945mr2399231e0c.8.1781198864670;
        Thu, 11 Jun 2026 10:27:44 -0700 (PDT)
X-Received: by 2002:a05:6122:208a:b0:5ab:2fb:2dfb with SMTP id 71dfb90a1353d-5bb02415945mr2399209e0c.8.1781198864121;
        Thu, 11 Jun 2026 10:27:44 -0700 (PDT)
Received: from [10.14.7.225] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96662efcae2sm1518244241.1.2026.06.11.10.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 10:27:42 -0700 (PDT)
Message-ID: <d700f8b0-b315-468d-8681-b97653ed76e8@broadcom.com>
Date: Thu, 11 Jun 2026 10:27:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: Use weighted round-robin TX DMA
 arbitration
To: Nicolai Buchwitz <nb@tipi-net.de>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260610085238.56300-1-ovidiu.panait.rb@renesas.com>
 <2f7e70123887fcfd8bbf4ce92f73574d@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <2f7e70123887fcfd8bbf4ce92f73574d@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298254-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:ovidiu.panait.rb@renesas.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,renesas.com:email];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D88667406D



On 6/11/26 1:08 AM, Nicolai Buchwitz wrote:
> Hi Ovidiu
> 
> This seems to be a good follow-up to Justin's earlier series [1].
> 
> On 10.6.2026 10:52, Ovidiu Panait wrote:
>> Under heavy network traffic, we observed sporadic TX queue timeouts on 
>> the
>> Raspberry Pi 4. The timeouts can be reproduced by stress testing the TX
>> path with multiple concurrent iperf UDP streams:
>>
>>     iperf3 -c <ip> -u -b0 -P16 -t60
>>     NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 2044 ms
>>     NETDEV WATCHDOG: CPU: 3: transmit queue 0 timed out 2004 ms
>>
>> Investigation showed that the timeouts are caused by the priority-based
>> arbiter. Under heavy load the highest priority queue starves the lower
>> priority ones, causing timeouts. The TX strict priority arbiter is not
>> suitable for the default use case where all the traffic gets spread
>> across all the TX queues.
>>
>> Therefore, to fix this, switch the TX DMA arbiter to Weighted Round- 
>> Robin,
>> which services all queues, so they do not stall. The weights were chosen
>> to follow the existing priority scheme: q0 gets the smallest weight, 
>> while
>> q1-4 get the bulk of the TX bandwidth.
>>
>> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
>> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
>> ---
> 
> AFAIK the existing queue mechanism dates back to the STB QoS use cases 
> Florian
> had in mind when he wrote the driver, so let's hear what he has to say 
> on this.
> 
> The change itself looks correct to me. My concern is the targeting. This
> flips the default policy for every GENET user rather than fixing a specific
> defect, and Justin's series already called the persistent timeouts a design
> issue rather than a bug.
> 
> So isn't this more net-next material than net with a broad Fixes: tag?
> Please also add to the commit message that it drops the existing priority
> handling for rings 1-4.
> 

I'm ok with these changes. Internally we no longer require priority 
queues. It is a legacy use case we no longer have. My idea was to remove 
the queues entirely and have one big queue. But I figured I would wait 
for Nicolai's XDP changes so we do not need to remove and re-add queues 
for XDP. This could be a stop-gap solution until that is done.

Justin

>>  .../net/ethernet/broadcom/genet/bcmgenet.c    | 23 +++++++------------
>>  1 file changed, 8 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/ 
>> net/ethernet/broadcom/genet/bcmgenet.c
>> index 7c11cf916762..ad08c67269be 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> @@ -40,9 +40,8 @@
>>
>>  #include "bcmgenet.h"
>>
>> -/* Default highest priority queue for multi queue support */
>> -#define GENET_Q1_PRIORITY    0
>> -#define GENET_Q0_PRIORITY    1
>> +#define GENET_Q0_WEIGHT        1
>> +#define GENET_Q1_WEIGHT        4
>>
>>  #define GENET_Q0_RX_BD_CNT    \
>>      (TOTAL_DESC - priv->hw_params->rx_queues * priv->hw_params- 
>> >rx_bds_per_q)
>> @@ -2129,13 +2128,6 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff 
>> *skb, struct net_device *dev)
>>      int i;
>>
>>      index = skb_get_queue_mapping(skb);
>> -    /* Mapping strategy:
>> -     * queue_mapping = 0, unclassified, packet xmited through ring 0
>> -     * queue_mapping = 1, goes to ring 1. (highest priority queue)
>> -     * queue_mapping = 2, goes to ring 2.
>> -     * queue_mapping = 3, goes to ring 3.
>> -     * queue_mapping = 4, goes to ring 4.
>> -     */
>>      ring = &priv->tx_rings[index];
>>      txq = netdev_get_tx_queue(dev, index);
>>
>> @@ -2881,8 +2873,9 @@ static int bcmgenet_rdma_disable(struct 
>> bcmgenet_priv *priv)
>>
>>  /* Initialize Tx queues
>>   *
>> - * Queues 1-4 are priority-based, each one has 32 descriptors,
>> - * with queue 1 being the highest priority queue.
>> + * Queues 1-4 are the priority queues, each one has 32 descriptors.
>> + * The weighted round-robin arbiter gives them a larger share of TX
>> + * bandwidth than the default queue 0.
>>   *
>>   * Queue 0 is the default Tx queue with
>>   * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 = 128 descriptors.
>> @@ -2900,8 +2893,8 @@ static void bcmgenet_init_tx_queues(struct 
>> net_device *dev)
>>      unsigned int start = 0, end = GENET_Q0_TX_BD_CNT;
>>      u32 i, ring_mask, dma_priority[3] = {0, 0, 0};
>>
>> -    /* Enable strict priority arbiter mode */
>> -    bcmgenet_tdma_writel(priv, DMA_ARBITER_SP, DMA_ARB_CTRL);
>> +    /* Enable Weighted Round-Robin arbiter mode */
>> +    bcmgenet_tdma_writel(priv, DMA_ARBITER_WRR, DMA_ARB_CTRL);
>>
>>      /* Initialize Tx priority queues */
>>      for (i = 0; i <= priv->hw_params->tx_queues; i++) {
>> @@ -2909,7 +2902,7 @@ static void bcmgenet_init_tx_queues(struct 
>> net_device *dev)
>>          start = end;
>>          end += priv->hw_params->tx_bds_per_q;
>>          dma_priority[DMA_PRIO_REG_INDEX(i)] |=
>> -            (i ? GENET_Q1_PRIORITY : GENET_Q0_PRIORITY)
>> +            (i ? GENET_Q1_WEIGHT : GENET_Q0_WEIGHT)
>>              << DMA_PRIO_REG_SHIFT(i);
>>      }
> 
> [1] https://lore.kernel.org/netdev/20260406175756.134567-1- 
> justin.chen@broadcom.com/
> 
> Thanks
> Nicolai


