Return-Path: <netdev+bounces-280159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A4VLjCN52m89wEAu9opvQ
	(envelope-from <netdev+bounces-280159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:44:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C403F43C3A6
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BCB83004203
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BADD3D6CB6;
	Tue, 21 Apr 2026 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haccmxp/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D883A4F58
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782357; cv=none; b=ZUX5k+7op8MTn627ts2proaByhBwjWC63GsZrQc3r+wtsvzSR1XVNSrbhJT+EQi2CNxz2D+BSpaG9Ybr9q3gVAyI/dseTMTKrr3HshliT27Rahw2LTRObgZEeTXUTzZWL4mQjCD5bGbTHyukTl16dd70SrsdtvZM06k+UNHgPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782357; c=relaxed/simple;
	bh=bqj16M9sXgb+IXozCV+sslVqz7EOll3b3HF6ElR6qSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I48nxUi4pgXBBrTurXo375KTGgpDvKkdoQ19i+FHUmq2zboiSRTuFgqJao7EOcmAfFBzVtDVNa/uFqJAf5f7ulDbA5KGdFQQM4aIcwLW9hOeXAPWTIWePwJjdGsoeTnAutzCbmbBZHa6A1cTgTun5UFNT8eL2DD0/C7fLwiPRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haccmxp/; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso3410011a91.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776782355; x=1777387155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89i13l84ZtV3KnNbve6BQUkD0/QmKUsGVYaEDD5ukCY=;
        b=haccmxp/Wj/AnbNfUWFNvSz4vKr4TuuDNAVxdDEL7iFXNPTwX+pNhwKBBH4qXogh0+
         MtwZ77GxGblRXFLL4Wn3U01QBMU+5BUkRdzFuHWdkndcBH5B1zRHZnYFRRrX88vbTVOf
         kq1qOuAmImbuzVqq2maM7ZwD3slLXSZ79mVNwOEUvV1isiGf7JeWIqw+xcDZ57zUYNYx
         CINQe+kB1qp+ebfhVryoBlf8wqsNu5/lePFiJ4AU4FHh8vPPWu0qdkCtLHhuUFCU5J/V
         KsMgXiECu3Ugt4vEHZmlYi3MgoU+oILo3RsLkgBRszXBV9ONvujxWdMRe37wLMKJfufm
         gadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776782355; x=1777387155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=89i13l84ZtV3KnNbve6BQUkD0/QmKUsGVYaEDD5ukCY=;
        b=QxMfZvNDWLIcgjzHhwXml0g5GG5ofg8QoDs9Uqr9ZhiJbrOaUpLhRrzczZz/jYCEei
         W0EYlwWkKK/fF9+90z5Rru6TG6p+E/f6dFqcZp8qWuHsV+hpm100olh+3YM2TWwfPcmk
         T5oaV1QeP/HvJL28N4vzm/iMv60U+btrirhrWAWwxAahUbPQwpB6+WoSthn4noWFCb6A
         mtBMIL32+Qi37OuaGLg28oW6t2Sqizes3CuMREU+xjyQxovvqhbHXAaJTaOHbCa8GO/S
         WNk7mjNjuBLlDxm8Q3WAHhrL7QPTCwJCrh28CE4R+NTsWa9Pgz2KR9fXQy8OxLhk1IcI
         +dIQ==
X-Gm-Message-State: AOJu0YxPipn1r3VasmSM2pA8NGVGEGEANViTyB35wnhM6a5zkds3I+Gb
	maaZBzNak+5bzKMI4GTCYcpU2sjksDYGZB1YrlNrpkPOZ8LWi9mX9udX
X-Gm-Gg: AeBDieu8CtcT7WIV2/ZhBpaJNXeRt7+TFZp5xPeOg6HamvhlpIIlwUdGHMx8wog5w5H
	jgSxnThHzxk9Mc2YrTOZX4KtXPWpeCLmzN0rIz3Pvv8db8NErpaJdb2zVjKdmj2Z+yeySLsBL1N
	gtmgxXoJd/hU4ykcUaBnWK1l91ekTHKu6KuAqFT9TkZTsJH44a4LZ6A5EXwWPbzToEkWLXyPf6d
	kAX1ZawRA5mjX1CNgNLb7mV9IrxtpziCLYYA5hhx90vpKCxjaFzh95ookSOWep5ERwRBxsksmXi
	zfxL6EkJHUGsJo/5nUlegE3JMM6gJzqvKHN+BvEjxFH6UKKi9NNK0d9LK2F8D9ULpfrpQeXek9C
	xY6I6s2XchhZRWlWqraz+GbddktjYxSevtTuz+v0sEfBrb/Hrt2cW2AUQyxydR0ilzo6w1nkBcl
	yXjxdwLLkhsMa3kg5vaJ5VWSeNXYj8LcGM2dFLSylMM+cY05slZ428hYAS0g+Exr/j+A==
X-Received: by 2002:a17:90b:55cc:b0:35e:30bc:804d with SMTP id 98e67ed59e1d1-3614048adcdmr17917427a91.15.1776782355084;
        Tue, 21 Apr 2026 07:39:15 -0700 (PDT)
Received: from [0.0.0.0] (42-200-245-168.static.imsbiz.com. [42.200.245.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141898ebasm14169063a91.7.2026.04.21.07.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 07:39:14 -0700 (PDT)
Message-ID: <60c9218e-33fe-441e-ac25-1a42fecb29a5@gmail.com>
Date: Tue, 21 Apr 2026 22:39:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: hsr: avoid learning unknown senders for
 local delivery
To: Felix Maurer <fmaurer@redhat.com>, Ao Zhou <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Shaurya Rane <ssrane_b23@ee.vjti.ac.in>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <kees@kernel.org>, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Yuqi Xu <xuyuqiabc@gmail.com>,
 royenheart@gmail.com
References: <cover.1775056603.git.royenheart@outlook.com>
 <b053e938014c9bac22f7f687ecc2970f23a2b74a.1775281843.git.royenheart@gmail.com>
 <adYwjxLBBaLY52Wb@thinkpad>
From: Haoze Xie <royenheart@gmail.com>
In-Reply-To: <adYwjxLBBaLY52Wb@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,linutronix.de,davemloft.net,google.com,kernel.org,redhat.com,ti.com,ee.vjti.ac.in,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280159-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royenheart@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C403F43C3A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/2026 6:40 PM, Felix Maurer wrote:
> On Sat, Apr 04, 2026 at 07:30:47PM +0800, Ao Zhou wrote:
>> From: Haoze Xie <royenheart@gmail.com>
>>
>> Traffic that is directly addressed to the local HSR/PRP master can be
>> delivered locally without creating a persistent node entry. Learning one
>> node per previously unseen source MAC lets forged sender floods grow
>> node_db until the prune timer catches up.
>>
>> Determine whether a frame is locally exclusive before node lookup and
>> skip learning for unknown senders in that case. When no node state
>> exists, also skip duplicate discard checks that depend on it.
>>
>> This keeps locally-destined traffic reachable while avoiding node table
>> growth from source-MAC floods in both the PRP SAN path and the HSR/PRP
>> tagged sender paths.
> 
> I see the problem you are trying to solve here, but I don't think this
> patch provides a significant improvement over the current situation.
> Yes, this will disable learning of new nodes from regular traffic (and
> thereby completely prevent the duplicate discard algorithm from
> working). New nodes would only be learned from supervision frames. But
> nothing prevents a malicious host in the network from spoofing tons of
> supervision frames.
> 
> HSR and PRP are supposed to be used in pretty restricted network
> environments, so the whole protocol design doesn't really expect
> malicious actors in the network and doesn't provide good options to
> safeguard against misuse.
> 
> IMHO, the only real way to prevent excessive resource use on our side is
> to put a limit on these resources. In this case, limit the size of the
> node table (bonus: make that limit configurable as Paolo suggested).
> 
> Thanks,
>    Felix
> 

I agree and therefore dropped the v2 learning-suppression approach and
reworked the fix toward directly bounding node-table growth in v3 patch.

If the node-table-limit approach in v3 looks acceptable, I can also follow
up later with refinements such as per-device configurability and better
visibility when the table is saturated.

Best regards,
Haoze Xie

> 
>> Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
>> Fixes: 451d8123f897 ("net: prp: add packet handling support")
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
>> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
>> Suggested-by: Xin Liu <bird@lzu.edu.cn>
>> Tested-by: Yuqi Xu <xuyuqiabc@gmail.com>
>> Signed-off-by: Haoze Xie <royenheart@gmail.com>
>> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
>> ---
>> changes in v2:
>> - generalize the fix beyond PRP SAN traffic and cover HSR/PRP tagged sender floods
>> - decide whether learning is needed from local-exclusive delivery instead of protocol-specific SAN checks
>> - use the normal NULL return semantics from hsr_get_node() instead of ERR_PTR-based error plumbing
>> - skip duplicate-discard state checks when no node state exists
>>
>>  net/hsr/hsr_forward.c  | 23 +++++++++++++----------
>>  net/hsr/hsr_framereg.c |  5 ++++-
>>  net/hsr/hsr_framereg.h |  2 +-
>>  3 files changed, 18 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
>> index aefc9b6936ba..15bd17b4ee17 100644
>> --- a/net/hsr/hsr_forward.c
>> +++ b/net/hsr/hsr_forward.c
>> @@ -403,7 +403,8 @@ static void hsr_deliver_master(struct sk_buff *skb, struct net_device *dev,
>>  	int res, recv_len;
>>
>>  	was_multicast_frame = (skb->pkt_type == PACKET_MULTICAST);
>> -	hsr_addr_subst_source(node_src, skb);
>> +	if (node_src)
>> +		hsr_addr_subst_source(node_src, skb);
>>  	skb_pull(skb, ETH_HLEN);
>>  	recv_len = skb->len;
>>  	res = netif_rx(skb);
>> @@ -545,7 +546,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>>  		/* Don't send frame over port where it has been sent before.
>>  		 * Also for SAN, this shouldn't be done.
>>  		 */
>> -		if (!frame->is_from_san &&
>> +		if (frame->node_src && !frame->is_from_san &&
>>  		    hsr->proto_ops->register_frame_out &&
>>  		    hsr->proto_ops->register_frame_out(port, frame))
>>  			continue;
>> @@ -688,21 +689,25 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>>  		return -EINVAL;
>>
>>  	memset(frame, 0, sizeof(*frame));
>> +	frame->port_rcv = port;
>>  	frame->is_supervision = is_supervision_frame(port->hsr, skb);
>>  	if (frame->is_supervision && hsr->redbox)
>>  		frame->is_proxy_supervision =
>>  			is_proxy_supervision_frame(port->hsr, skb);
>>
>> +	ethhdr = (struct ethhdr *)skb_mac_header(skb);
>> +	check_local_dest(port->hsr, skb, frame);
>> +
>>  	n_db = &hsr->node_db;
>>  	if (port->type == HSR_PT_INTERLINK)
>>  		n_db = &hsr->proxy_node_db;
>>
>>  	frame->node_src = hsr_get_node(port, n_db, skb,
>> -				       frame->is_supervision, port->type);
>> -	if (!frame->node_src)
>> -		return -1; /* Unknown node and !is_supervision, or no mem */
>> +				       frame->is_supervision, port->type,
>> +				       !frame->is_local_exclusive);
>> +	if (!frame->node_src && !frame->is_local_exclusive)
>> +		return -1;
>>
>> -	ethhdr = (struct ethhdr *)skb_mac_header(skb);
>>  	frame->is_vlan = false;
>>  	proto = ethhdr->h_proto;
>>
>> @@ -720,13 +725,10 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>>  	}
>>
>>  	frame->is_from_san = false;
>> -	frame->port_rcv = port;
>>  	ret = hsr->proto_ops->fill_frame_info(proto, skb, frame);
>>  	if (ret)
>>  		return ret;
>>
>> -	check_local_dest(port->hsr, skb, frame);
>> -
>>  	return 0;
>>  }
>>
>> @@ -739,7 +741,8 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
>>  	if (fill_frame_info(&frame, skb, port) < 0)
>>  		goto out_drop;
>>
>> -	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
>> +	if (frame.node_src)
>> +		hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
>>  	hsr_forward_do(&frame);
>>  	rcu_read_unlock();
>>  	/* Gets called for ingress frames as well as egress from master port.
>> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
>> index 50996f4de7f9..2bc6f8f154c2 100644
>> --- a/net/hsr/hsr_framereg.c
>> +++ b/net/hsr/hsr_framereg.c
>> @@ -221,7 +221,7 @@ void prp_update_san_info(struct hsr_node *node, bool is_sup)
>>   */
>>  struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
>>  			      struct sk_buff *skb, bool is_sup,
>> -			      enum hsr_port_type rx_port)
>> +			      enum hsr_port_type rx_port, bool learn)
>>  {
>>  	struct hsr_priv *hsr = port->hsr;
>>  	struct hsr_node *node;
>> @@ -270,6 +270,9 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
>>  			san = true;
>>  	}
>>
>> +	if (!learn)
>> +		return NULL;
>> +
>>  	return hsr_add_node(hsr, node_db, ethhdr->h_source, san, rx_port);
>>  }
>>
>> diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
>> index c65ecb925734..3d9c88e83090 100644
>> --- a/net/hsr/hsr_framereg.h
>> +++ b/net/hsr/hsr_framereg.h
>> @@ -33,7 +33,7 @@ void hsr_del_self_node(struct hsr_priv *hsr);
>>  void hsr_del_nodes(struct list_head *node_db);
>>  struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
>>  			      struct sk_buff *skb, bool is_sup,
>> -			      enum hsr_port_type rx_port);
>> +			      enum hsr_port_type rx_port, bool learn);
>>  void hsr_handle_sup_frame(struct hsr_frame_info *frame);
>>  bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr);
>>  bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr);
>> --
>> 2.53.0
>>
> 


