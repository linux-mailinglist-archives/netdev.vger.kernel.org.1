Return-Path: <netdev+bounces-291335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL1MOxJZFGofMwcAu9opvQ
	(envelope-from <netdev+bounces-291335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:13:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED125CB9DC
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 208DE3018585
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D915F399013;
	Mon, 25 May 2026 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qX68Y5FL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4D397AFF
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779718415; cv=none; b=jn0ZruF63H+MW82hoXLRmCt+MfMrYRyW+uuWjxCAY4ufLjEBVRkfalH1U9FakgGdI/IoDTTMdoWM/zYB1UKS7h7bJGNaSJckaAowQnQvIf1Hsr9/JfAtcacxhUxaeslguKMDBBmA5qMVyVTSb/7u6124PICHdolJRtBMNhGFakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779718415; c=relaxed/simple;
	bh=JQeeaH8GDUrD4I2W6d1CLXZmfHbC3prbkej/TD+xWAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzoOGwXENwDoJ9FEW+L3N7iyg6U9cdRgCievqMCZDzsAn8Ik+wnMxOcWr25NlBbp03OxYiKqabqmhtw1DQnl43qpPloEE3vuakyLyW3m2zGgt03vqrJfprQYU+yKhuN8r+Rbh+fAfzNmzLYdnQ+PFNrsd4/iku/st/2IQhPMnmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qX68Y5FL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b458ca2296so70768315ad.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779718412; x=1780323212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXek9nCqxBos4vZVBDAOXMfSUabKZ1nUxWxUgnDm8Os=;
        b=qX68Y5FL4bFYfh7fV+bc9Tesd0keEU4FWve5HEaAPd2XgG3Ez3tWdxIdMF9KHRHlPp
         z9GivAIi0XvOYwZ+5DZYJUjx2TNah493p2ywWMs7ebNNYQnvK5sFL5FoyaaIoKDIxVOI
         5yn/BPze7LIf9Q+z3iBsdZ9wu58zYLGI2O0xVRqCoc2ry3pczDUBDsSNUOTrF+yTIRgK
         pSjRaAs9Qisp9ucXXm9MOiZ6CbCzIMetxuGk0eAzRUrsGPQG7xTrbrW1UTDwh0rbjQWY
         GePnW1vQeqh3FC3CaW0E/XHKvV4SJpIezQHkNu9ZByrzlZqE26oUNcVmhJchlw+K7ehZ
         q4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779718412; x=1780323212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXek9nCqxBos4vZVBDAOXMfSUabKZ1nUxWxUgnDm8Os=;
        b=AkQWa0iBjNVELsLWEJfZVTbc4Jl2bA0H34E+Xnbqrhr6gbFlkc6PAxO1aiklOtKcl5
         iSL8hNhMedxWWnS1D2klOY9f3eIQkQCqT2n/DKJAp4KT3Q84dA7abCt0Ko5rog5mDOPb
         tJIp8M+mMDvX9S4YkguMk3U00W/DvBx70k+7inzAHQ6vuXoBAH7olf93jCQWqrQABm7E
         iO+sWRkplgftXBUY3cwpRcL/Wmlr1NKbXr2CEpPZwL4v8iJnJqKjsLnc3NttksVSOU5J
         /oL6KaO2JGfwpGJdtOyDbgOZSWMBTuavsV3cAvROAiLJI+L5sQjqg4FNMw+mn6s35KJr
         U+Pw==
X-Gm-Message-State: AOJu0YxSdG3ZANyH7UmYcVTdJ50oisP7/CbKpuqbothyM2SBYSpFsEBC
	WHSB6qud1cSKwm2aFknD6xBTxeo8ENG1MmHxw4zvNYYiFOuuWM+U8SPx
X-Gm-Gg: Acq92OHvkJFqocG5n3bzSU7NcuQCuUifkHn9Y+Lje8lmlJV25TTeOurAQUp+RIbWwKH
	7bY45vjuwPKiTHqoFCr8Qct5jAFDfB0AldUrP/bJQGNQLnX3H6bPiuxVita9Mm0CCpBiss50VE6
	tqK1ok9u56OcAHlIxZQ8rihWP/jC6FgPDZ+M3qn1YHa/wJwnDgyyB2EGH39I4qwgN+it+UCzgIG
	/OkGASMHceA3TfqcPIquVcZGksF/rdYy40FtGekVPJ/cs5r+UCVz1p88ZczXg5+R8D98ocZ6fJJ
	At6O1ZrFVF/nRn00xuEEPR7gdWRCjOqkyn3MMa0Hgp3CnY1GMmTYFMXuqjpxz0iaEhu7sGx7NJw
	zZjNHYfH4A2cQ1WbplaEqIcWlgI7Bf+pZ/5Gl6eP0CI0dVniCGpYRhKZnp6YDMOcHy2SmFrypy+
	NWOiQByhnFVXDQ/2N/NUFFPcbgL9hmjMkDWIh6fn7aVqcf
X-Received: by 2002:a17:903:11c6:b0:2bd:3bfd:7512 with SMTP id d9443c01a7336-2beb065b6edmr161039305ad.29.1779718412299;
        Mon, 25 May 2026 07:13:32 -0700 (PDT)
Received: from [192.168.89.2] ([112.179.160.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f54sm100830745ad.10.2026.05.25.07.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 07:13:31 -0700 (PDT)
Message-ID: <a08289e7-641c-489e-8d89-6eae9f092f90@gmail.com>
Date: Mon, 25 May 2026 23:13:28 +0900
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
 <ahQDon-nio0STA4E@lore-desk>
Content-Language: en-US
From: Jihong Min <hurryman2212@gmail.com>
In-Reply-To: <ahQDon-nio0STA4E@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291335-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6ED125CB9DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/26 17:09, Lorenzo Bianconi wrote:
>> The Linux bridge FDB can resolve a destination station to WDMA even when
>> the Airoha PPE driver's L2 offload cache has no entry for that MAC pair.
>> The normal bind path only checks the PPE driver's L2 offload cache, so an
>> unbound PPE hit for WLAN egress can stay unbound even though the bridge
>> already knows the right output path, unless a later offload event fills
>> that PPE driver cache.
>>
>> This matters for bridge-visible WLAN egress, such as wired-to-WLAN
>> forwarding or WLAN peer forwarding across another BSS, radio or MLO link.
>> Same-link or same-radio intra-BSS forwarding can stay inside the WLAN
>> datapath and is not covered.
> 
> Hi Jihong,

Hi, Lorenzo.

> 
> In order to offload L2 flows, I assume you are using the OpenWrt bridger
> package, right?

Actually, no.

I am using Fanboy's OpenWrt `test` build for the Lumen W1700K2,
together with several of my other patches. It does not include the
bridger package specifically. It now uses native nft-based offloading
with `kmod-br-netfilter`.

> IIUC the issue you want to resolve is we are not adding PPE L2 entries for
> the specified cases (same-link or same-radio intra-BSS forwarding), correct?

No. As written in the patch message, this specifically addresses
bridge-visible WLAN egress, such as:

1. wired-to-WLAN forwarding
2. WLAN peer forwarding across another BSS, radio, or MLO link

Same-link or same-radio intra-BSS forwarding can stay inside the WLAN
datapath and is not covered by this patch, although it did show poor
performance, whether that is due to shared airtime or not. That case
appears to belong to the Wi-Fi stack/driver datapath, such as the
mac80211/mt76/mt7996 path, rather than to this Airoha PPE fallback path.

> Using this approach, we are breaking the assumption PPE flow-table and hw
> flow-table are in sync. If the issue is the one described above, why not
> fixing the problem directly in the bridger package?

Again, this problem exists in an environment without bridger.

> Moreover, I see you developed the patch using Codex:gpt-5.5. Have you tested it
> on a real hw?

Yes. This has been tested on my Lumen W1700K2 with the environment
described above. MLO Wi-Fi P2P communication and some wired-to-WLAN
cases were indeed left unbound by PPE. CPU usage was high, and the
unbound throughput was close to 50% of what this patch achieves now.

> 
> Some comments inline.
> 
> Regards,
> Lorenzo
> >>
>> Before touching the PPE table, resolve the destination MAC through the
>> bridge device above the ingress netdev. If the PPE driver's L2 offload
>> cache lookup misses, bind the hardware flow to the resolved CDM4/WDMA
>> path.
>>
>> Assisted-by: Codex:gpt-5.5
>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
>> ---
>>  drivers/net/ethernet/airoha/airoha_ppe.c | 138 +++++++++++++++++++----
>>  1 file changed, 119 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
>> index 26da519236bf..ea932e6d87f6 100644
>> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
>> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
>> @@ -803,65 +803,163 @@ static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
>>  }
>>  
>>  static int
>> -airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
>> -				    struct airoha_flow_table_entry *e,
>> -				    u32 hash, bool rx_wlan)
>> +airoha_ppe_foe_commit_subflow(struct airoha_ppe *ppe,
>> +			      const struct airoha_foe_entry *bridge,
> 
> maybe l2_hwe instead of bridge?
> 
>> +			      u32 hash, bool rx_wlan)
>>  {
>>  	u32 mask = AIROHA_FOE_IB1_BIND_PACKET_TYPE | AIROHA_FOE_IB1_BIND_UDP;
>>  	struct airoha_foe_entry *hwe_p, hwe;
>> -	struct airoha_flow_table_entry *f;
>>  	int type;
>>  
>>  	hwe_p = airoha_ppe_foe_get_entry_locked(ppe, hash);
>>  	if (!hwe_p)
>>  		return -EINVAL;
>>  
>> -	f = kzalloc_obj(*f, GFP_ATOMIC);
>> -	if (!f)
>> -		return -ENOMEM;
>> -
>> -	hlist_add_head(&f->l2_subflow_node, &e->l2_flows);
>> -	f->type = FLOW_TYPE_L2_SUBFLOW;
>> -	f->hash = hash;
>> -
>>  	memcpy(&hwe, hwe_p, sizeof(*hwe_p));
>> -	hwe.ib1 = (hwe.ib1 & mask) | (e->data.ib1 & ~mask);
>> +	hwe.ib1 = (hwe.ib1 & mask) | (bridge->ib1 & ~mask);
>>  
>>  	type = FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, hwe.ib1);
>>  	if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T) {
>> -		memcpy(&hwe.ipv6.l2, &e->data.bridge.l2, sizeof(hwe.ipv6.l2));
>> -		hwe.ipv6.ib2 = e->data.bridge.ib2;
>> +		memcpy(&hwe.ipv6.l2, &bridge->bridge.l2,
>> +		       sizeof(hwe.ipv6.l2));
>> +		hwe.ipv6.ib2 = bridge->bridge.ib2;
>>  		/* setting smac_id to 0xf instruct the hw to keep original
>>  		 * source mac address
>>  		 */
>>  		hwe.ipv6.l2.src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID,
>>  						    0xf);
>>  	} else {
>> -		memcpy(&hwe.bridge.l2, &e->data.bridge.l2,
>> +		memcpy(&hwe.bridge.l2, &bridge->bridge.l2,
>>  		       sizeof(hwe.bridge.l2));
>> -		hwe.bridge.ib2 = e->data.bridge.ib2;
>> +		hwe.bridge.ib2 = bridge->bridge.ib2;
>>  		if (type == PPE_PKT_TYPE_IPV4_HNAPT)
>>  			memcpy(&hwe.ipv4.new_tuple, &hwe.ipv4.orig_tuple,
>>  			       sizeof(hwe.ipv4.new_tuple));
>>  	}
>>  
>> -	hwe.bridge.data = e->data.bridge.data;
>> -	airoha_ppe_foe_commit_entry(ppe, &hwe, hash, rx_wlan);
>> +	hwe.bridge.data = bridge->bridge.data;
>> +
>> +	return airoha_ppe_foe_commit_entry(ppe, &hwe, hash, rx_wlan);
>> +}
>> +
>> +static int
>> +airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
>> +				    struct airoha_flow_table_entry *e,
>> +				    u32 hash, bool rx_wlan)
>> +{
>> +	struct airoha_flow_table_entry *f;
>> +	int err;
>> +
>> +	f = kzalloc_obj(*f, GFP_ATOMIC);
>> +	if (!f)
>> +		return -ENOMEM;
>> +
>> +	err = airoha_ppe_foe_commit_subflow(ppe, &e->data, hash, rx_wlan);
>> +	if (err) {
>> +		kfree(f);
>> +		return err;
>> +	}
>> +
>> +	hlist_add_head(&f->l2_subflow_node, &e->l2_flows);
>> +	f->type = FLOW_TYPE_L2_SUBFLOW;
>> +	f->hash = hash;
>>  
>>  	return 0;
>>  }
>>  
>> +static bool
>> +airoha_ppe_foe_prepare_wdma_subflow_dev(struct airoha_ppe *ppe,
>> +					struct net_device *dev,
>> +					struct airoha_flow_data *data,
>> +					struct airoha_foe_entry *hwe)
>> +{
>> +	u32 pse_port;
>> +	int err;
>> +
>> +	err = airoha_ppe_foe_entry_prepare(ppe->eth, hwe, dev,
>> +					   PPE_PKT_TYPE_BRIDGE, data, 0);
>> +	if (err)
>> +		return false;
>> +
>> +	pse_port = FIELD_GET(AIROHA_FOE_IB2_PSE_PORT, hwe->bridge.ib2);
>> +	if (pse_port != FE_PSE_PORT_CDM4)
>> +		return false;
>> +
>> +	return true;
> 
> 	return pse_port == FE_PSE_PORT_CDM4;
> 
>> +}
>> +
>> +static struct net_device *
>> +airoha_ppe_foe_get_bridge_master(struct net_device *dev)
>> +{
>> +	struct net_device *master = NULL;
>> +
>> +	rcu_read_lock();
>> +	master = netdev_master_upper_dev_get_rcu(dev);
>> +	if (master && netif_is_bridge_master(master))
>> +		dev_hold(master);
>> +	else
>> +		master = NULL;
>> +	rcu_read_unlock();
>> +
>> +	return master;
>> +}
>> +
>> +static bool
>> +airoha_ppe_foe_prepare_wdma_subflow(struct airoha_ppe *ppe,
>> +				    struct sk_buff *skb,
>> +				    struct airoha_foe_entry *hwe)
>> +{
>> +	struct ethhdr *eh = eth_hdr(skb);
>> +	struct airoha_flow_data data = {};
>> +	struct net_device *master;
>> +
>> +	if (!is_valid_ether_addr(eh->h_source) ||
>> +	    !is_valid_ether_addr(eh->h_dest))
>> +		return false;
>> +
>> +	ether_addr_copy(data.eth.h_dest, eh->h_dest);
>> +	ether_addr_copy(data.eth.h_source, eh->h_source);
>> +
>> +	if (!skb->dev)
>> +		return false;
>> +
>> +	/* WLAN egress unbound hits can arrive before flowtable creates the
>> +	 * L2 master flow normally used for subflow binding. Resolve only
>> +	 * through the bridge master so dev_fill_forward_path() must use the
>> +	 * bridge FDB for the destination MAC. Calling the ingress AP netdev
>> +	 * directly can describe the source station's WDMA path and would
>> +	 * corrupt Wi-Fi-to-wired flows whose real egress is not WDMA.
>> +	 */
>> +	master = airoha_ppe_foe_get_bridge_master(skb->dev);
>> +	if (!master)
>> +		return false;
>> +
>> +	if (airoha_ppe_foe_prepare_wdma_subflow_dev(ppe, master, &data,
>> +						    hwe)) {
>> +		dev_put(master);
>> +		return true;
>> +	}
>> +
>> +	dev_put(master);
>> +	return false;
> 
> maybe something like:
> 
> 	ret = airoha_ppe_foe_prepare_wdma_subflow_dev();
> 	dev_put(master);
> 
> 	return ret;
> 
>> +}
>> +
>>  static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
>>  					struct sk_buff *skb,
>>  					u32 hash, bool rx_wlan)
>>  {
>> +	struct airoha_foe_entry wdma_hwe = {};
>>  	struct airoha_flow_table_entry *e;
>>  	struct airoha_foe_bridge br = {};
>>  	struct airoha_foe_entry *hwe;
>>  	bool commit_done = false;
>> +	bool wdma_ready = false;
>>  	struct hlist_node *n;
>>  	u32 index, state;
>>  
>> +	wdma_ready = airoha_ppe_foe_prepare_wdma_subflow(ppe, skb,
>> +							 &wdma_hwe);
>> +
>>  	spin_lock_bh(&ppe_lock);
>>  
>>  	hwe = airoha_ppe_foe_get_entry_locked(ppe, hash);
>> @@ -899,6 +997,8 @@ static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
>>  				   airoha_l2_flow_table_params);
>>  	if (e)
>>  		airoha_ppe_foe_commit_subflow_entry(ppe, e, hash, rx_wlan);
>> +	else if (wdma_ready)
>> +		airoha_ppe_foe_commit_subflow(ppe, &wdma_hwe, hash, rx_wlan);
>>  unlock:
>>  	spin_unlock_bh(&ppe_lock);
>>  }
>> -- 
>> 2.53.0
>>

All inline code-style review comments will be addressed in the next
submission of the patch set, together with the responses to Sashiko's
review, if any.

