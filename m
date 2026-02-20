Return-Path: <netdev+bounces-259782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNeULFDYmGnJNQMAu9opvQ
	(envelope-from <netdev+bounces-259782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:55:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6CD16B138
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647F5302B396
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672D3093C9;
	Fri, 20 Feb 2026 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRKyamcw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC22E7BC2
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771624525; cv=none; b=QCsEpz+LRXvTMmk4/ynAsL8cNW49g5LwQ6+K9+d3wC0Qxqranu4NYqG23yiuBp9OilDzaXirlUv9ga6YC83IUrIiOunvw8skucAtRb2yTUShOl0C7hbT0UKbrPiTNxM1XzQY+Fj8ujQKya+eFYWrmwciUSUCyVfpTmyYhbfbA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771624525; c=relaxed/simple;
	bh=vlRi7s7jtzkqZNRoowOK4CI8RGB7OGnbkDE+E2fOMEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVDjfh4uIHwhgVny61CSWggROJBK3eOICrog7BjAey8cRgv33+RL1w3Af0AK2yeWsWBB08tsIqSnR+IJfk0+F1kuMfOVs8Cc0UVDW7z27xsVqJqW47fhAzeO/urLEsu0sb98HUcQIZw2/vInikPKMK5Q/Qdhn72hAVxQnl7QoOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRKyamcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEE1C116C6;
	Fri, 20 Feb 2026 21:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771624525;
	bh=vlRi7s7jtzkqZNRoowOK4CI8RGB7OGnbkDE+E2fOMEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRKyamcwgotM7ANLPmv5TX9rm/TD9qt2eDvJdZYu9+HW5jdXfNIqR5Ha2qnh6fFs0
	 xjkLR1d34iYwgUePC91U6QP74gVlnlZPagud46VWlnwqxoInQLtJOMR256h2tFH/9E
	 qxCRwYoMiG8l4+GvqvDxRht6Wf/1v20mLvf2klfH9bUPEiGeBvORCWnejNReq3Idw1
	 T80Y9Ue4TioGDbkmcHi5/Q33iCwKSFIehtQrl4V83P4c0jbJIT2QLlCTiiZfFyA4ao
	 HvsItnPbUTX7RvNc+EEu8BKdPrRbcFM0JP8ytp9vrO8E2uzH+wERu0QwrK9csvOeGc
	 +tpbX4GtYPzvw==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	willemb@google.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	krikku@gmail.com,
	horms@kernel.org,
	kuniyu@google.com,
	eric.dumazet@gmail.com
Subject: Re: [net] net: fix potential out-of-bound access in set_rps_cpu()
Date: Fri, 20 Feb 2026 13:52:10 -0800
Message-ID: <20260220215209.3209259-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220144344.2548121-1-edumazet@google.com>
References: <20260220144344.2548121-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,davemloft.net,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259782-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B6CD16B138
X-Rspamd-Action: no action

Hi Eric!

I'm attaching the AI review. It's a bit long, I stopped reading
half way thru. But looking at the code I think AI is onto something.
We have fetched the flow_table in get_rps_cpu() based on
skb_get_rx_queue(skb), but in set_rps_cpu() we are fetching the table
for the target / next_cpu, which we make sure is _not_ the same:

    if (rxq_index == skb_get_rx_queue(skb))

---
net: fix potential out-of-bound access in set_rps_cpu()

This commit addresses an out-of-bound access issue introduced when
set_rps_cpu() was reloading rxqueue->rps_flow_table. The fix passes the
flow_table pointer from get_rps_cpu() to set_rps_cpu() to follow RCU rules.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 096b3ff13f6b..7c5e69c771ca 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4993,13 +4993,11 @@ static bool rps_flow_is_active(struct rps_dev_flow *rflow,
>  static struct rps_dev_flow *
>  set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash,
> -	    u32 flow_id)
> +	    u32 flow_id, struct rps_dev_flow_table *flow_table)
>  {
>  	if (next_cpu < nr_cpu_ids) {
>  		u32 head;
>  #ifdef CONFIG_RFS_ACCEL
> -		struct netdev_rx_queue *rxqueue;
> -		struct rps_dev_flow_table *flow_table;
>  		struct rps_dev_flow *old_rflow;
>  		struct rps_dev_flow *tmp_rflow;
>  		unsigned int tmp_cpu;
> @@ -5014,11 +5012,6 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  		if (rxq_index == skb_get_rx_queue(skb))
>  			goto out;
>
> -		rxqueue = dev->_rx + rxq_index;
> -		flow_table = rcu_dereference(rxqueue->rps_flow_table);
> -		if (!flow_table)
> -			goto out;
> -
>  		tmp_rflow = &flow_table->flows[flow_id];
>  		tmp_cpu = READ_ONCE(tmp_rflow->cpu);
>

Does this change introduce an aliasing issue in the CONFIG_RFS_ACCEL path?

In get_rps_cpu(), the flow_table parameter is obtained from the receiving
queue (dev->_rx[skb_get_rx_queue(skb)]) and rflow points to
&flow_table->flows[flow_id].

When this rflow is passed into set_rps_cpu() with the same flow_table and
flow_id, tmp_rflow is computed as &flow_table->flows[flow_id]:

net/core/dev.c:set_rps_cpu() {
	tmp_rflow = &flow_table->flows[flow_id];
	tmp_cpu = READ_ONCE(tmp_rflow->cpu);
	rc = cpu_rmap_lookup_index(dev->rx_cpu_rmap, next_cpu);
	if (rc >= 0)
		next_cpu = rc;

	old_rflow = rflow;
	rflow = tmp_rflow;
	WRITE_ONCE(rflow->filter, rc);
	WRITE_ONCE(rflow->hash, hash);

	if (old_rflow->filter == rc)
		WRITE_ONCE(old_rflow->filter, RPS_NO_FILTER);
}

Since rflow and tmp_rflow are derived from the same flow_table and flow_id,
they point to the same memory location. After the assignments old_rflow =
rflow and rflow = tmp_rflow, all three pointers alias the same object.

The code stores rc into rflow->filter with WRITE_ONCE(rflow->filter, rc),
then checks if (old_rflow->filter == rc). Because old_rflow is rflow (which
is tmp_rflow), this condition is always true, causing WRITE_ONCE(old_rflow->
filter, RPS_NO_FILTER) to immediately clear the filter ID that was just set.

This means the hardware filter ID is never retained in the rps_dev_flow
entry. On subsequent packets for the same flow, the stale-flow check:

	if (READ_ONCE(tmp_rflow->filter) != RPS_NO_FILTER)

will always find RPS_NO_FILTER, causing ndo_rx_flow_steer() to be called
redundantly for every packet even when the flow is already steered.

Was the intent to use different flow tables for the receiving and target
queues so that the filter deduplication logic could work properly?

> @@ -5134,7 +5127,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  		      rflow->last_qtail)) >= 0)) {
>  			tcpu = next_cpu;
>  			rflow = set_rps_cpu(dev, skb, rflow, next_cpu, hash,
> -					    flow_id);
> +					    flow_id, flow_table);
>  		}
>
>  		if (tcpu < nr_cpu_ids && cpu_online(tcpu)) {
-- 
pw-bot: cr

