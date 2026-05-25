Return-Path: <netdev+bounces-291367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNdcOmJzFGokNgcAu9opvQ
	(envelope-from <netdev+bounces-291367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:05:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E0D5CC98F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8DF53004906
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71E330662;
	Mon, 25 May 2026 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpNy/mTC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6E93195F0
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725152; cv=none; b=a+RLScwmL8PS3ouSUbw0iAA/6na6cpsXYOWPLYOqVeRlOcLUuN2RH0Mfa3AN+JgKZt9SzHzukG8o5XP2CZWato1m4UVQlBK15Kf5sspD7bbOBV/Gcme8rjBh240BEsmua6SqhZHwGjcp2Cew5OlDgFV3Y11iKiqR4VB7rH693Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725152; c=relaxed/simple;
	bh=GEQN/LnKWNHPeI0wPO35AE0mRnby6lVycjH+bzP7ImM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zk+tI2TtvvNogqtKKI+idIYZtQmCBw7SYs+cQlFey9m0djQz8CicWHkSPD6j3hTTUFDjhtoxIjD7bNT01F2q7GmKmyvZ5+rQQFDWl7zz8xvoVY67fuQoLUwIYlGXlb8aGG42/rwmXjcYzZsKErwx4KeczPnEghF7yJx+cu4qoKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpNy/mTC; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c801b30188dso4270611a12.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779725151; x=1780329951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsqob+RiDvjbp6q4NSt4Su76R5qsKRpEXNucdGH7HTM=;
        b=NpNy/mTCxb6ekZBgvqFD0Cy/Nznci7mZjQcxinV4H++DfEC3+WFd/QRgnfK49Dkrir
         ezwEftiYm1e3jyOrdm55GECpgr/OlmkW9MLsqfTykvoWSkF66xXIzAoO+t44xpKDMOVg
         fTiwYhB+fQy5EPys/ltChXOUMNH7DwXzdNVycldtImVNCqlX1k5atoXGezkVJYOi+RO8
         Yd8Hz827PvRB6IWdZpoY+V6uD0VkMoAhxDcpmY/W6VEGNKPqDgQL9p0IlNyr9wlkejZB
         JK9Q9gQcGKVJNHzTsMNzlf0hISbTG+Gu10n/5GVcZKBVgSKDvBaEVF7+e6ZZjfV6/S6z
         aLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779725151; x=1780329951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsqob+RiDvjbp6q4NSt4Su76R5qsKRpEXNucdGH7HTM=;
        b=KQ05xN0HDBR1BxdhMAoGkm2Z+LWrOEhLH+EH0xhmXJCDzbNlPOJFIaZLTZwKukT4w6
         5Jod5NbAHo/FvFMK1lpdvtBgPzIo/Bcphub3VGTfG3bK1BKc/v7LhrLiYA5E7WA4tIgj
         WUWlb1kgwbYawG8vb8YkUrnlLdhBt3IfzoWvkEKNKUQfmLYnA6FiBvHLNnglUK4l1CEM
         ubcZ6rVXEvBsEf5oU0jVlxqde5NJr6iFmOT22h/vc9igHgTRmTZAaynsrEv06DpY1h6V
         7Nvqw9c2Gba6skSOAqjTiyr7qVR88JfQgE7+tfWedQ4Nh8n6IJQGl0Cz+degBoVgjFEl
         Hgcg==
X-Gm-Message-State: AOJu0Yykai5AUK5Cbb+pW8itlNq+oxzM4eULGyDEQU9Z3Cl4Y+Jh6eSG
	NANtjptGc1Yl+gSN3aoQ1uq1XRoLV5H56+tYO47FEXGvhMzephmydg1a
X-Gm-Gg: Acq92OGYzMTSLIUsbLEiaq8r/XeW4O/Eb+CpBUJQlImgNRGJNh+8D2wmbk/aQ4EWi0E
	jiZteTCVsyv/MnlW/t8vlYBqgMc90P5S80GNmPhgyQmuvXhGofVql8fNgzPCT9K5NxSWtonlGfx
	sLETs1D7hNImBMcUQ7UVifLxj4Ydz8jHmhPcHGW9HFcG0dGcLl4Ek7ur3YZEoPJUscUp3EcUNsJ
	nScfB3QW91Aq8cdisIPULsIAq2+oMqQBVP+5ft1E6JNGeNh1HO7Yey99QXULL5IUEs1LQMTCA0j
	SgRDjBFmeRCQBukM4uVAyr14mAThUGyS5C+tqLRi2Oii21QszMmrMCC5tNXndy4jryYNSmpExJ4
	3b0TwZF9M5RaHhOK0LESniSLuNbL3yB6se5El7aj1JrBNK3ptgtD23HwGFJyBDdfXgh5cNZDhV6
	xviEgDvCQO/g4juhEL3tcXlb7YZMZy4g==
X-Received: by 2002:a17:90b:2246:b0:364:edd2:812 with SMTP id 98e67ed59e1d1-36a6789ac27mr14909417a91.25.1779725150447;
        Mon, 25 May 2026 09:05:50 -0700 (PDT)
Received: from [192.168.89.2] ([119.214.48.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36ac208877fsm1934386a91.7.2026.05.25.09.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 09:05:49 -0700 (PDT)
Message-ID: <82d0e4a5-76b1-4c86-a153-2500c60e8063@gmail.com>
Date: Tue, 26 May 2026 01:05:46 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: airoha: bind WLAN-bound flows on PPE driver
 L2 cache miss
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260524224330.3995807-1-hurryman2212@gmail.com>
 <ahQDon-nio0STA4E@lore-desk> <a08289e7-641c-489e-8d89-6eae9f092f90@gmail.com>
 <ahRonGRDCqdFTBQm@lore-desk>
Content-Language: en-US
From: Jihong Min <hurryman2212@gmail.com>
In-Reply-To: <ahRonGRDCqdFTBQm@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291367-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bridge.data:url]
X-Rspamd-Queue-Id: 89E0D5CC98F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/26 00:19, Lorenzo Bianconi wrote:
>>
>>
>> On 5/25/26 17:09, Lorenzo Bianconi wrote:
>>>> The Linux bridge FDB can resolve a destination station to WDMA even when
>>>> the Airoha PPE driver's L2 offload cache has no entry for that MAC pair.
>>>> The normal bind path only checks the PPE driver's L2 offload cache, so an
>>>> unbound PPE hit for WLAN egress can stay unbound even though the bridge
>>>> already knows the right output path, unless a later offload event fills
>>>> that PPE driver cache.
>>>>
>>>> This matters for bridge-visible WLAN egress, such as wired-to-WLAN
>>>> forwarding or WLAN peer forwarding across another BSS, radio or MLO link.
>>>> Same-link or same-radio intra-BSS forwarding can stay inside the WLAN
>>>> datapath and is not covered.
>>>
>>> Hi Jihong,
>>
>> Hi, Lorenzo.
>>
>>>
>>> In order to offload L2 flows, I assume you are using the OpenWrt bridger
>>> package, right?
>>
>> Actually, no.
>>
>> I am using Fanboy's OpenWrt `test` build for the Lumen W1700K2,
>> together with several of my other patches. It does not include the
>> bridger package specifically. It now uses native nft-based offloading
>> with `kmod-br-netfilter`.
> 
> according to my understanding this is not merged yet, right? I guess the
> patches should be based on official/accepted code.
> 

Yes, you are right. I just checked current net-next and realized that the
bridge/L2 nft_flow_offload pieces used in my test environment are not
merged upstream yet. Sorry, I should have checked this before submitting
the patch.

Since I cannot properly test the current upstream code plus bridger at the
moment, I will put this patch on hold.

I will also check whether this should instead be fixed on the
nft_flow_offload side.


Sincerely,
Jihong Min

>>
>>> IIUC the issue you want to resolve is we are not adding PPE L2 entries for
>>> the specified cases (same-link or same-radio intra-BSS forwarding), correct?
>>
>> No. As written in the patch message, this specifically addresses
>> bridge-visible WLAN egress, such as:
>>
>> 1. wired-to-WLAN forwarding
>> 2. WLAN peer forwarding across another BSS, radio, or MLO link
>>
>> Same-link or same-radio intra-BSS forwarding can stay inside the WLAN
>> datapath and is not covered by this patch, although it did show poor
>> performance, whether that is due to shared airtime or not. That case
>> appears to belong to the Wi-Fi stack/driver datapath, such as the
>> mac80211/mt76/mt7996 path, rather than to this Airoha PPE fallback path.
> 
> according to my understanding the l2 nft-based offloading solution should
> add the missing info to PPE flow-table. As I pointed out, it should be
> in-sync with hw flow-table. It seems a bug in the nft code to me.
> 
>>
>>> Using this approach, we are breaking the assumption PPE flow-table and hw
>>> flow-table are in sync. If the issue is the one described above, why not
>>> fixing the problem directly in the bridger package?
>>
>> Again, this problem exists in an environment without bridger.
> 
> In order to offload L2 traffic bridger is mandatory. Do you mean the issue
> occurs even on L3 scenario?
> 
>>
>>> Moreover, I see you developed the patch using Codex:gpt-5.5. Have you tested it
>>> on a real hw?
>>
>> Yes. This has been tested on my Lumen W1700K2 with the environment
>> described above. MLO Wi-Fi P2P communication and some wired-to-WLAN
>> cases were indeed left unbound by PPE. CPU usage was high, and the
>> unbound throughput was close to 50% of what this patch achieves now.
> 
> ack
> 
> Regards,
> Lorenzo
> 
>>
>>>
>>> Some comments inline.
>>>
>>> Regards,
>>> Lorenzo
>>>>>
>>>> Before touching the PPE table, resolve the destination MAC through the
>>>> bridge device above the ingress netdev. If the PPE driver's L2 offload
>>>> cache lookup misses, bind the hardware flow to the resolved CDM4/WDMA
>>>> path.
>>>>
>>>> Assisted-by: Codex:gpt-5.5
>>>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
>>>> ---
>>>>  drivers/net/ethernet/airoha/airoha_ppe.c | 138 +++++++++++++++++++----
>>>>  1 file changed, 119 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
>>>> index 26da519236bf..ea932e6d87f6 100644
>>>> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
>>>> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
>>>> @@ -803,65 +803,163 @@ static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
>>>>  }
>>>>  
>>>>  static int
>>>> -airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
>>>> -				    struct airoha_flow_table_entry *e,
>>>> -				    u32 hash, bool rx_wlan)
>>>> +airoha_ppe_foe_commit_subflow(struct airoha_ppe *ppe,
>>>> +			      const struct airoha_foe_entry *bridge,
>>>
>>> maybe l2_hwe instead of bridge?
>>>
>>>> +			      u32 hash, bool rx_wlan)
>>>>  {
>>>>  	u32 mask = AIROHA_FOE_IB1_BIND_PACKET_TYPE | AIROHA_FOE_IB1_BIND_UDP;
>>>>  	struct airoha_foe_entry *hwe_p, hwe;
>>>> -	struct airoha_flow_table_entry *f;
>>>>  	int type;
>>>>  
>>>>  	hwe_p = airoha_ppe_foe_get_entry_locked(ppe, hash);
>>>>  	if (!hwe_p)
>>>>  		return -EINVAL;
>>>>  
>>>> -	f = kzalloc_obj(*f, GFP_ATOMIC);
>>>> -	if (!f)
>>>> -		return -ENOMEM;
>>>> -
>>>> -	hlist_add_head(&f->l2_subflow_node, &e->l2_flows);
>>>> -	f->type = FLOW_TYPE_L2_SUBFLOW;
>>>> -	f->hash = hash;
>>>> -
>>>>  	memcpy(&hwe, hwe_p, sizeof(*hwe_p));
>>>> -	hwe.ib1 = (hwe.ib1 & mask) | (e->data.ib1 & ~mask);
>>>> +	hwe.ib1 = (hwe.ib1 & mask) | (bridge->ib1 & ~mask);
>>>>  
>>>>  	type = FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, hwe.ib1);
>>>>  	if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T) {
>>>> -		memcpy(&hwe.ipv6.l2, &e->data.bridge.l2, sizeof(hwe.ipv6.l2));
>>>> -		hwe.ipv6.ib2 = e->data.bridge.ib2;
>>>> +		memcpy(&hwe.ipv6.l2, &bridge->bridge.l2,
>>>> +		       sizeof(hwe.ipv6.l2));
>>>> +		hwe.ipv6.ib2 = bridge->bridge.ib2;
>>>>  		/* setting smac_id to 0xf instruct the hw to keep original
>>>>  		 * source mac address
>>>>  		 */
>>>>  		hwe.ipv6.l2.src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID,
>>>>  						    0xf);
>>>>  	} else {
>>>> -		memcpy(&hwe.bridge.l2, &e->data.bridge.l2,
>>>> +		memcpy(&hwe.bridge.l2, &bridge->bridge.l2,
>>>>  		       sizeof(hwe.bridge.l2));
>>>> -		hwe.bridge.ib2 = e->data.bridge.ib2;
>>>> +		hwe.bridge.ib2 = bridge->bridge.ib2;
>>>>  		if (type == PPE_PKT_TYPE_IPV4_HNAPT)
>>>>  			memcpy(&hwe.ipv4.new_tuple, &hwe.ipv4.orig_tuple,
>>>>  			       sizeof(hwe.ipv4.new_tuple));
>>>>  	}
>>>>  
>>>> -	hwe.bridge.data = e->data.bridge.data;
>>>> -	airoha_ppe_foe_commit_entry(ppe, &hwe, hash, rx_wlan);
>>>> +	hwe.bridge.data = bridge->bridge.data;
>>>> +
>>>> +	return airoha_ppe_foe_commit_entry(ppe, &hwe, hash, rx_wlan);
>>>> +}
>>>> +
>>>> +static int
>>>> +airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
>>>> +				    struct airoha_flow_table_entry *e,
>>>> +				    u32 hash, bool rx_wlan)
>>>> +{
>>>> +	struct airoha_flow_table_entry *f;
>>>> +	int err;
>>>> +
>>>> +	f = kzalloc_obj(*f, GFP_ATOMIC);
>>>> +	if (!f)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	err = airoha_ppe_foe_commit_subflow(ppe, &e->data, hash, rx_wlan);
>>>> +	if (err) {
>>>> +		kfree(f);
>>>> +		return err;
>>>> +	}
>>>> +
>>>> +	hlist_add_head(&f->l2_subflow_node, &e->l2_flows);
>>>> +	f->type = FLOW_TYPE_L2_SUBFLOW;
>>>> +	f->hash = hash;
>>>>  
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +static bool
>>>> +airoha_ppe_foe_prepare_wdma_subflow_dev(struct airoha_ppe *ppe,
>>>> +					struct net_device *dev,
>>>> +					struct airoha_flow_data *data,
>>>> +					struct airoha_foe_entry *hwe)
>>>> +{
>>>> +	u32 pse_port;
>>>> +	int err;
>>>> +
>>>> +	err = airoha_ppe_foe_entry_prepare(ppe->eth, hwe, dev,
>>>> +					   PPE_PKT_TYPE_BRIDGE, data, 0);
>>>> +	if (err)
>>>> +		return false;
>>>> +
>>>> +	pse_port = FIELD_GET(AIROHA_FOE_IB2_PSE_PORT, hwe->bridge.ib2);
>>>> +	if (pse_port != FE_PSE_PORT_CDM4)
>>>> +		return false;
>>>> +
>>>> +	return true;
>>>
>>> 	return pse_port == FE_PSE_PORT_CDM4;
>>>
>>>> +}
>>>> +
>>>> +static struct net_device *
>>>> +airoha_ppe_foe_get_bridge_master(struct net_device *dev)
>>>> +{
>>>> +	struct net_device *master = NULL;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	master = netdev_master_upper_dev_get_rcu(dev);
>>>> +	if (master && netif_is_bridge_master(master))
>>>> +		dev_hold(master);
>>>> +	else
>>>> +		master = NULL;
>>>> +	rcu_read_unlock();
>>>> +
>>>> +	return master;
>>>> +}
>>>> +
>>>> +static bool
>>>> +airoha_ppe_foe_prepare_wdma_subflow(struct airoha_ppe *ppe,
>>>> +				    struct sk_buff *skb,
>>>> +				    struct airoha_foe_entry *hwe)
>>>> +{
>>>> +	struct ethhdr *eh = eth_hdr(skb);
>>>> +	struct airoha_flow_data data = {};
>>>> +	struct net_device *master;
>>>> +
>>>> +	if (!is_valid_ether_addr(eh->h_source) ||
>>>> +	    !is_valid_ether_addr(eh->h_dest))
>>>> +		return false;
>>>> +
>>>> +	ether_addr_copy(data.eth.h_dest, eh->h_dest);
>>>> +	ether_addr_copy(data.eth.h_source, eh->h_source);
>>>> +
>>>> +	if (!skb->dev)
>>>> +		return false;
>>>> +
>>>> +	/* WLAN egress unbound hits can arrive before flowtable creates the
>>>> +	 * L2 master flow normally used for subflow binding. Resolve only
>>>> +	 * through the bridge master so dev_fill_forward_path() must use the
>>>> +	 * bridge FDB for the destination MAC. Calling the ingress AP netdev
>>>> +	 * directly can describe the source station's WDMA path and would
>>>> +	 * corrupt Wi-Fi-to-wired flows whose real egress is not WDMA.
>>>> +	 */
>>>> +	master = airoha_ppe_foe_get_bridge_master(skb->dev);
>>>> +	if (!master)
>>>> +		return false;
>>>> +
>>>> +	if (airoha_ppe_foe_prepare_wdma_subflow_dev(ppe, master, &data,
>>>> +						    hwe)) {
>>>> +		dev_put(master);
>>>> +		return true;
>>>> +	}
>>>> +
>>>> +	dev_put(master);
>>>> +	return false;
>>>
>>> maybe something like:
>>>
>>> 	ret = airoha_ppe_foe_prepare_wdma_subflow_dev();
>>> 	dev_put(master);
>>>
>>> 	return ret;
>>>
>>>> +}
>>>> +
>>>>  static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
>>>>  					struct sk_buff *skb,
>>>>  					u32 hash, bool rx_wlan)
>>>>  {
>>>> +	struct airoha_foe_entry wdma_hwe = {};
>>>>  	struct airoha_flow_table_entry *e;
>>>>  	struct airoha_foe_bridge br = {};
>>>>  	struct airoha_foe_entry *hwe;
>>>>  	bool commit_done = false;
>>>> +	bool wdma_ready = false;
>>>>  	struct hlist_node *n;
>>>>  	u32 index, state;
>>>>  
>>>> +	wdma_ready = airoha_ppe_foe_prepare_wdma_subflow(ppe, skb,
>>>> +							 &wdma_hwe);
>>>> +
>>>>  	spin_lock_bh(&ppe_lock);
>>>>  
>>>>  	hwe = airoha_ppe_foe_get_entry_locked(ppe, hash);
>>>> @@ -899,6 +997,8 @@ static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
>>>>  				   airoha_l2_flow_table_params);
>>>>  	if (e)
>>>>  		airoha_ppe_foe_commit_subflow_entry(ppe, e, hash, rx_wlan);
>>>> +	else if (wdma_ready)
>>>> +		airoha_ppe_foe_commit_subflow(ppe, &wdma_hwe, hash, rx_wlan);
>>>>  unlock:
>>>>  	spin_unlock_bh(&ppe_lock);
>>>>  }
>>>> -- 
>>>> 2.53.0
>>>>
>>
>> All inline code-style review comments will be addressed in the next
>> submission of the patch set, together with the responses to Sashiko's
>> review, if any.


