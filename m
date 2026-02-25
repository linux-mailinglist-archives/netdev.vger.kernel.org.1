Return-Path: <netdev+bounces-261060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKxKHXpAn2laZgQAu9opvQ
	(envelope-from <netdev+bounces-261060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:33:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BAB19C53C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDCE7303B7DE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EDD21A459;
	Wed, 25 Feb 2026 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQV4CIUF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6ZvjWT6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84E2E62D1
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044230; cv=none; b=bI7zulzg5AqCIBJt3+dPFIA+uupUUMZBvzeqByvG1MinXuPBuPb1IBirDKrOC2ECjTKQwthJ+Xh9eVRVrGHJDujIlOmcpOgWvhabllWzMTVBpNhJ+o++Dp9g9+Djck7Z5ZaPj0DfS62VFtvYmFur0p4L95aSwOJ23MIJX51X/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044230; c=relaxed/simple;
	bh=QQbyCkrgfW0DcMcKURcWDuJfyD8jbz85niGlAwZhxSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nvId8Y5rIUa9iWKIM0X+g+iPWXptY1QwUwHizli7BzQxzFp50GMefYpFaQ8jIAgzj6mptOwt624TQjHy5HXCCpnYnSv2jbVx4Xu9CAgq2zPc0vil7dmtyVfitjkxKcOygaxYLzqA8fXAwKjczm7j8sGIQgwm8ZLLPwzwuzPEoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQV4CIUF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6ZvjWT6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772044228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kY/OZldHLOg9054bamu6RsdPXTg+KjwVPIo0aVG3Lg=;
	b=aQV4CIUFkqeiGFTWi55jNK+4JC9s3oCftAYLzWOqyOTmFCP2S3ZOgnh+MHPeDwnkiaj7DB
	ZESmA4rby7TwfCejFB42xaNGruSClZplQc6cGfctkWk53XAshUFyxC6G1KdGxWp/NUxHZL
	QIgf/kq54oJOwCCloA3oYPLTFFREGMc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-gwdx7we0NJmCtMc9k87npA-1; Wed, 25 Feb 2026 13:30:21 -0500
X-MC-Unique: gwdx7we0NJmCtMc9k87npA-1
X-Mimecast-MFC-AGG-ID: gwdx7we0NJmCtMc9k87npA_1772044221
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c881d0c617so5227117985a.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772044220; x=1772649020; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kY/OZldHLOg9054bamu6RsdPXTg+KjwVPIo0aVG3Lg=;
        b=W6ZvjWT6V9hAOkor6k9728IXv5rUgbArRzHeFPJlPAzKTWYeipXz3IDS09BZGw92gm
         DDwE2J8n4vmYS+PLk2Xgil/njU5H7CFY/QgdjwHFUE7OmuSLt/yHBzUWc5k/70SWgt/b
         9jZHnyV5AJ6pv/TZdHIVK55OZkYm2iQZU4WCKxal75eX1HuEq9/oXb7rqTnzxjXeGpc/
         69eFCzOqiaR8ySy59KsyiRfWZxVuDOMEh+MlHdoLh9RZm7B0aJ3v8+radr5nLCg9pcAb
         pOFsNirrutbPMcAG83m4IL/QIGfiHdHz0YsjUdnFgsN+SNhfWsvaSUT3BvhgIPeYGOip
         eBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044220; x=1772649020;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kY/OZldHLOg9054bamu6RsdPXTg+KjwVPIo0aVG3Lg=;
        b=E4Sg7or0CNZL6FD1cJXx2t/O9ZhN1vU51fbDu9W5Vz0vVYfRyvTkeUJGNq4nfmYGyc
         8R3iIauokeo0maA7OiceUfufYXgx8Ryavrs4J01yd6u9OqoJYqXleJLW/x/wAjIs3s6H
         4AchboNS2Iyjux8GSGWw3w95PPZMGsZT8Jxob2hWDdbsQugKdbUsN/Is8NQE75PWTnmS
         7f/dpGOV0QLjRAlr6FDC1qtaZ7R4xtNi7uUGN6pJklj9o78m7g4CpmxNhqonaLVkJfjM
         jw2EDbMcdHZuf4g6Dp1Ajsdc4psJ1AY/wpwf5z2BU5VTzYV7rxgGj/F2YC+IsyGc4KGZ
         nsxg==
X-Forwarded-Encrypted: i=1; AJvYcCV/MwSSv7fzR/KAYosqKypzZaE5TchxiOL39flPCAwLja3kK3yy0v9WV96lPxmjVgmD6hXVNFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5rbIKR6lsw/TCV/zrHg/6A/OlvvhspeQ5A6BgoDLA3XaHF3f5
	1SYr2fsFGBubLOaLaybs8MYTsGAGPBeLWVgOO//S5Btrak4QRDtdqcwlRKpViPWilNWrPmhvxwp
	hQ5NkukdCHafg62A/sfEdjbp84Iy8b27xGVopuzl5sqSmCebvLYSagHaUOg==
X-Gm-Gg: ATEYQzx2rqVfj1b4FZQRa+hbVp80YdVmMePWB8rKWxSQRuadgh8ZQn/vh0cqtKo3jEF
	AxKQcZlOg/Lelf1pSqIsfy/1zItmrbHmLQRYvWdlKT84w9ZHaSgqmG8/BAb7SH/y+v8iirk9ejy
	jmcnlZM13H/EJyCs8G+dwN0BTth4FQOh7T/MQgFFLti7UBq4PYLsM8tVQI17MvMy3LXsxOTZ2n+
	O265K7gj4wWjqnAOVpohBqM2VtgBTlKDO7WFSxM5x8hmvqgVHxTQ9cgk7ZqALGf2pFmpPByNhry
	LYF8xvo2ON9mx8YSEotvvtskAXtB5L3/Gz6KLAv71inKZjD7pKY45HV8ei7bNA0ungz9rSPf5Fy
	GnHpkggIarxnj2odJGHUKhBgQJx4JOdO+LKPKQ69lbl5dLR5Upp3NYclnwhU=
X-Received: by 2002:a05:620a:d8d:b0:8c6:a539:55cd with SMTP id af79cd13be357-8cbbcff7148mr231016885a.41.1772044220439;
        Wed, 25 Feb 2026 10:30:20 -0800 (PST)
X-Received: by 2002:a05:620a:d8d:b0:8c6:a539:55cd with SMTP id af79cd13be357-8cbbcff7148mr231008585a.41.1772044219897;
        Wed, 25 Feb 2026 10:30:19 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0ec694sm1339521785a.29.2026.02.25.10.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:30:18 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com,
 edumazet@google.com, pabeni@redhat.com, theo.lebrun@bootlin.com,
 netdev@vger.kernel.org, lorenzo@kernel.org, andrew+netdev@lunn.ch
Subject: Re: [net-next,v2,5/8] net: macb: add XDP support for gem
In-Reply-To: <20260224000844.140431-1-kuba@kernel.org>
References: <20260223182632.1681809-6-pvalerio@redhat.com>
 <20260224000844.140431-1-kuba@kernel.org>
Date: Wed, 25 Feb 2026 19:30:16 +0100
Message-ID: <878qcgn0av.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261060-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 85BAB19C53C
X-Rspamd-Action: no action

On 23 Feb 2026 at 04:08:44 PM, Jakub Kicinski <kuba@kernel.org> wrote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: macb: add XDP support for gem
>
> This patch introduces basic XDP support for the macb/gem driver with
> XDP_PASS, XDP_DROP, and XDP_REDIRECT verdict support.
>
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
>> index a78ad00f53b1..33a963b6dd4d 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -15,6 +15,7 @@
>>  #include <linux/phy/phy.h>
>>  #include <linux/workqueue.h>
>>  #include <net/page_pool/helpers.h>
>> +#include <net/xdp.h>
>
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index 708107e47ae3..26b517ed251c 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>
> [ ... ]
>
>> @@ -1247,9 +1248,27 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
>>  	return packets;
>>  }
>>
>> +static unsigned int gem_rx_headroom(struct macb *bp)
>> +{
>> +	if (rcu_access_pointer(bp->prog))
>> +		return XDP_PACKET_HEADROOM;
>> +
>> +	return NET_SKB_PAD;
>> +}
>> +
>> +static unsigned int gem_max_rx_data_size(int base_sz)
>> +{
>> +	return SKB_DATA_ALIGN(base_sz + ETH_HLEN + ETH_FCS_LEN);
>> +}
>> +
>> +static unsigned int gem_max_rx_buffer_size(int data_sz, struct macb *bp)
>> +{
>> +	return SKB_HEAD_ALIGN(data_sz + bp->rx_headroom);
>> +}
>
> [ ... ]
>
>> @@ -1340,12 +1360,61 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
>>  	 */
>>  }
>>
>> +static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
>> +		       unsigned int len)
>> +{
>> +	struct net_device *dev;
>> +	struct bpf_prog *prog;
>> +	struct xdp_buff xdp;
>> +
>> +	u32 act = XDP_PASS;
>> +
>> +	rcu_read_lock();
>> +
>> +	prog = rcu_dereference(queue->bp->prog);
>> +	if (!prog)
>> +		goto out;
>> +
>> +	xdp_init_buff(&xdp, gem_total_rx_buffer_size(queue->bp), &queue->xdp_rxq);
>> +	xdp_prepare_buff(&xdp, buff_head, queue->bp->rx_headroom, len, false);
>> +	xdp_buff_clear_frags_flag(&xdp);
>> +	dev = queue->bp->dev;
>> +
>> +	act = bpf_prog_run_xdp(prog, &xdp);
>> +	switch (act) {
>> +	case XDP_PASS:
>> +		goto out;
>> +	case XDP_REDIRECT:
>> +		if (unlikely(xdp_do_redirect(dev, &xdp, prog))) {
>> +			act = XDP_DROP;
>> +			break;
>> +		}
>> +		goto out;
>> +	default:
>> +		bpf_warn_invalid_xdp_action(dev, prog, act);
>> +		fallthrough;
>> +	case XDP_ABORTED:
>> +		trace_xdp_exception(dev, prog, act);
>> +		fallthrough;
>> +	case XDP_DROP:
>> +		break;
>> +	}
>
> Does this function need to handle XDP_TX? The driver advertises
> NETDEV_XDP_ACT_BASIC (set in macb_probe() below), which declares support
> for XDP_ABORTED, XDP_DROP, XDP_PASS, and XDP_TX per the UAPI definition
> in include/uapi/linux/netdev.h. An XDP program returning XDP_TX will fall
> through to the default case, call bpf_warn_invalid_xdp_action(), and
> treat it as XDP_DROP. The packet won't be transmitted; it will be dropped
> with a warning instead.
>
> [ ... ]
>
>> @@ -2641,21 +2724,23 @@ static int macb_alloc_consistent(struct macb *bp)
>>  	return -ENOMEM;
>>  }
>>
>> -static int gem_create_page_pool(struct macb_queue *queue)
>> +static int gem_create_page_pool(struct macb_queue *queue, int qid)
>>  {
>>  	struct page_pool_params pp_params = {
>>  		.order = 0,
>>  		.flags = PP_FLAG_DMA_MAP,
>>  		.pool_size = queue->bp->rx_ring_size,
>>  		.nid = NUMA_NO_NODE,
>> -		.dma_dir = DMA_FROM_DEVICE,
>> +		.dma_dir = rcu_access_pointer(queue->bp->prog)
>> +				? DMA_BIDIRECTIONAL
>> +				: DMA_FROM_DEVICE,
>>  		.dev = &queue->bp->pdev->dev,
>>  		.netdev = queue->bp->dev,
>>  		.napi = &queue->napi_rx,
>>  		.max_len = PAGE_SIZE,
>>  	};
>>  	struct page_pool *pool;
>> -	int err = 0;
>> +	int err;
>>
>>  	/* This can happen in the case of HRESP error.
>>  	 * Do nothing as page pool is already existing.
>>  	 */
>>  	if (queue->page_pool)
>>  		return err;
>                        ^^^
>
> Does this return an uninitialized value? The patch changed 'int err = 0'
> to 'int err' without initialization. The early-return path for HRESP error
> recovery returns err when the page pool already exists.
>

argh, I missed this patch removing the initialization while rebasing.

> gem_init_rings() calls this function during HRESP error recovery:
>
> drivers/net/ethernet/cadence/macb_main.c:gem_init_rings()
> 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> 		...
> 		err = gem_create_page_pool(queue, q);
> 		if (err) {
> 			last_err = err;
> 			if (fail_early)
> 				return err;
> 			continue;
> 		}
>
> When err is non-zero, gem_init_rings() skips gem_rx_refill() for that
> queue via continue, potentially leaving the RX queue without buffers.
>
> The unmodified macb_hresp_error_task() calls mog_init_rings(bp, false)
> which calls gem_init_rings() to recover from HRESP errors. During
> recovery, page pools already exist from the initial open, so the
> early-return is taken. If err happens to be non-zero, gem_init_rings()
> skips gem_rx_refill(), breaking packet reception on affected queues after
> HRESP error recovery.
>
> [ ... ]
>
>> @@ -3167,11 +3275,27 @@ static int macb_close(struct net_device *dev)
>>  	return 0;
>>  }
>>
>> +static bool gem_xdp_valid_mtu(struct macb *bp, int mtu)
>> +{
>> +	int max_frame_size;
>> +
>> +	max_frame_size = gem_max_rx_buffer_size(gem_max_rx_data_size(mtu), bp);
>> +
>> +	return max_frame_size <= PAGE_SIZE;
>> +}
>
> Looking at the XDP setup flow, is this MTU validation using the correct
> headroom value?
>
> When gem_xdp_setup() calls gem_xdp_valid_mtu():
>
> drivers/net/ethernet/cadence/macb_main.c:gem_xdp_setup()
> 	if (prog && !gem_xdp_valid_mtu(bp, dev->mtu)) {
> 		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
> 		return -EOPNOTSUPP;
> 	}
>
> 	running = netif_running(dev);
> 	need_update = !!bp->prog != !!prog;
> 	if (running && need_update)
> 		macb_close(dev);
>
> 	old_prog = rcu_replace_pointer(bp->prog, prog, lockdep_rtnl_is_held());
>
> The validation happens before bp->prog is updated. gem_max_rx_buffer_size()
> uses bp->rx_headroom, which is cached during macb_init_rx_buffer_size().
> At validation time, bp->rx_headroom still holds the non-XDP value
> (NET_SKB_PAD, typically 64 bytes) rather than the XDP value
> (XDP_PACKET_HEADROOM = 256 bytes). This makes the validation 192 bytes too
> permissive.
>

I guess gem_xdp_valid_mtu() can depend only on XDP_PACKET_HEADROOM and
just check against it and drop the dependency with bp->rx_headroom.


> An MTU close to the PAGE_SIZE limit could pass validation but then cause
> gem_total_rx_buffer_size() to exceed PAGE_SIZE once the correct XDP
> headroom is applied in macb_open()->macb_init_rx_buffer_size().
>
> [ ... ]
>
>> @@ -5744,13 +5911,9 @@ static int macb_probe(struct platform_device *pdev)
>>  	if (err)
>>  		goto err_out_phy_exit;
>>
>> -	if (macb_is_gem(bp)) {
>> -		bp->rx_headroom = NET_SKB_PAD;
>> -		if (!(bp->caps & MACB_CAPS_RSC)) {
>> -			bp->rx_ip_align = NET_IP_ALIGN;
>> -			bp->rx_headroom += NET_IP_ALIGN;
>> -		}
>> -	}
>> +	if (macb_is_gem(bp))
>> +		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
>> +				    NETDEV_XDP_ACT_REDIRECT;
>
> Is NETDEV_XDP_ACT_BASIC accurate here? Looking at gem_xdp_run() above,
> XDP_TX falls through to the default case and is treated as XDP_DROP with
> a warning. NETDEV_XDP_ACT_BASIC includes XDP_TX support per the UAPI
> definition, but the driver doesn't implement it.

This makes sense. Will require some rearrangement in the way the series
is split.


