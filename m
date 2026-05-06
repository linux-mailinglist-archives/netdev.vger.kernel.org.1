Return-Path: <netdev+bounces-285059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKxuAH/A+2mBEQAAu9opvQ
	(envelope-from <netdev+bounces-285059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:28:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 538B04E13B9
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04F033008D33
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9D63603D1;
	Wed,  6 May 2026 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTfuKZIf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7JIkOfA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA435F5FB
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106492; cv=none; b=Sl1At/Xxj1RE4t2x89SULV6PjGaRaXixAtQkXKM0wLW6iTcSJVWIoN3ZDSqqRt4hmLED6AtaFY1aUbfww90crn7UUX+BgG2p5Gz7mV4f+DxH3GmVSVTikxifqHkZIHkidoUYTA3XSXcBYu+JpJcavOq2Q6EgKfj45MQaOqkU6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106492; c=relaxed/simple;
	bh=rtVwk1ax2o4nJ4GXyKTejUp5AmKhUCVDmo4YRJ3ERHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMrXRIE9wgCS7gJ5CMRLvHmYYyrdW6B0ZMCKEw4a/tz+wFbWDqWIAP3OdSaHSHgqhz7HG/95RXVri9OZfcwXMQBWZjlFrDM7tF0A9hh+KLDmflG3RRMmqVU8lUo9YUn91uvs2f3GjWAjQQFV0EzBhkKeULOZcR3JN/jDAwJ1xuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTfuKZIf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7JIkOfA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778106489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t8i9O8vJ9NfXLrrn+cYRMOYCqXIwE6jcbZ+nzxxFXS0=;
	b=UTfuKZIfGm0uVdIw9KVN/gemybNl8rQfia42DnBaW6TBWSPw2oxD2wO58aWcRbz5MjBNEY
	f1xpSjyGCIGZrR3hJI5/hI5y8KONHILHq2hhbf6ZH/v57hdYIcB6fkLAAK/WD9KG3ACMWz
	PPs3wRlpCVjOWtd+Wxde3yaFtIjcUb0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-5AapUYwwMPC8asCNgvhW4A-1; Wed, 06 May 2026 18:28:08 -0400
X-MC-Unique: 5AapUYwwMPC8asCNgvhW4A-1
X-Mimecast-MFC-AGG-ID: 5AapUYwwMPC8asCNgvhW4A_1778106487
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d127eb013so926475e9.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778106487; x=1778711287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8i9O8vJ9NfXLrrn+cYRMOYCqXIwE6jcbZ+nzxxFXS0=;
        b=T7JIkOfA6LbehnvBkk0609D5QbeP0HnzceqdAojuDwtCVjAcVhTFLIVvYYQu400PFJ
         iT6iTcvEK+l1WVKMU7J+LpSLVdWwTFYCO59KthyikifuNBCeKAKh6oIsWmLvw/scTFcv
         f2v31Ds7CwBq+6cKpkhV40tsSNLLuKtBX6aCs5Ka9cTE8bRt5M8aN2kUFNAk6WoI40IP
         XaNNH2A2w2RFnkJGs363Bxla86nrcpQr1Hhgn0Z5JOy87HCYkbBwddikygWd9lc4b9I7
         DrN+pFOOVLsWnX/Zl8Qb8Qw1fBXgqgwXuGJ3oSqY/btk0zXApynMWU6zXELRvxMAso4p
         OghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778106487; x=1778711287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8i9O8vJ9NfXLrrn+cYRMOYCqXIwE6jcbZ+nzxxFXS0=;
        b=haKZxeww98GEHhZ31i8E/G8w/Zjdn9hOj6BQHi7KgUjAGuVRmhYXcLHPAlB1dZfMbX
         20X/f7l9CrmUIx9SXDTK1urfCcqrhFfKmXiICId1DxL2LIXJLtUmkeEJeAVUtQVM3Lwu
         2t7GRvjaW4Y1740WVQuvAsKQthAQIaIAq8G5bD0mAH8ss8ztMb8llI4kPIj/iwSRZqNR
         9Ttv6FGoqW9ctnBQVGCrQ8A480rr+5m+cFj8KO38gERCMHCLeLiCwRUNVRSY14WIlUO4
         6Te8HuWGy9hsVJdAgiDr13k0Qz2VhIR1XILOpLgeAx4QxZ+kZTu+rLbH32Cs657nZEA6
         bVVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bQRathadogV5qHdOhoih284Uc/Bqjnha8zCl/7UtYC3+bQhW2yaDaZ9n+biTjLnyNKmQe6Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYnDhaoP+AvheNsCNFymwN7uMVt76v9JTI4YdY9yK8j0ydK9c
	+iCZHt+fIN8HQeEM6JayWgzE7+KeOepgy1UiEtv4ol71WLjfWSz7DmLD/gfiWXZvWajqUWdNJJo
	aspJhVxCM37rqjhQr9CbHl4uzMW1KYTqSQVxYaVvJgFp+V3PgEA+LDUF1Wg==
X-Gm-Gg: AeBDiescP4zGWuMzelX/JR2bvIwC+W5M+ItM3pQG3XwuQs+ogTCzkczlwCKbS3EMaFd
	FXlEFvzmpG9f2oH27sVyfw8wvuBcq/wisZjPWcBkIjhFgWExpFDgNDHZJ4eA43WpvCsw4hYnGvQ
	b9W1cLfiwkSIxNY3789vS2MggBDOofTFH81R5+hMJdunpaExzaCtsaBea1O6S/7VEcNq8smf1cn
	9aDWSlg75+9I6FROIEcfnRpiG63IyoG/sBB0ErnBsoEjcP3tyXFUMh6bZR6nFaLsK2kXXvXLO6I
	vnaap/CtQPF5OvoG7I0hfT1ynKukp4UvSDH7MFsP6eGUTbIY4b6Y4NSrlkar//JmCcmTy4Ehj2+
	yl/VF4HelIDeqAPdi4sgIyeMS3FlxUO04TnXM5oWUaXGl+mMJNg4=
X-Received: by 2002:a05:600c:8908:b0:48a:5821:5ff2 with SMTP id 5b1f17b1804b1-48e51f24340mr59778985e9.8.1778106487228;
        Wed, 06 May 2026 15:28:07 -0700 (PDT)
X-Received: by 2002:a05:600c:8908:b0:48a:5821:5ff2 with SMTP id 5b1f17b1804b1-48e51f24340mr59778725e9.8.1778106486686;
        Wed, 06 May 2026 15:28:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538aaa0fsm97231005e9.7.2026.05.06.15.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:28:06 -0700 (PDT)
Date: Wed, 6 May 2026 18:28:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v10 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
Message-ID: <20260506181909-mutt-send-email-mst@kernel.org>
References: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
 <20260506141033.180450-5-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506141033.180450-5-simon.schippers@tu-dortmund.de>
X-Rspamd-Queue-Id: 538B04E13B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285059-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 04:10:33PM +0200, Simon Schippers wrote:
> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> becomes full. Once an entry is successfully produced and the ptr_ring
> reaches capacity, the netdev queue is stopped instead of dropping
> subsequent packets. If no qdisc is present, the previous tail-drop
> behavior is preserved.
> 
> If producing an entry fails anyways due to a race, tun_net_xmit() drops
> the packet. Such races are expected because LLTX is enabled and the
> transmit path operates without the usual locking.
> 
> The __tun_wake_queue() function of the consumer races with the producer
> for waking/stopping the netdev queue, which could result in a stalled
> queue. Therefore, an smp_mb__after_atomic() is introduced that pairs
> with the smp_mb() of the consumer. It follows the principle of store
> buffering described in tools/memory-model/Documentation/recipes.txt:
> 
> - The producer in tun_net_xmit() first sets __QUEUE_STATE_DRV_XOFF,
>   followed by an smp_mb__after_atomic() (= smp_mb()), and then reads the
>   ring with __ptr_ring_produce_peek().
> 
> - The consumer in __tun_wake_queue() first writes zero to the ring in
>   __ptr_ring_consume(), followed by an smp_mb(), and then reads the queue
>   status with netif_tx_queue_stopped().
> 
> => Following the aforementioned principle, it is impossible for the
>    producer to see a full ring (and therefore not wake the queue on the
>    re-check) while the consumer simultaneously fails to see a stopped
>    queue (and therefore also does not wake it).
> 
> Benchmarks:
> The benchmarks show a slight regression in raw transmission performance
> when using two sending threads. Packet loss also occurs only in the
> two-thread sending case; no packet loss was observed with a single
> sending thread.
> 
> Test setup:
> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> mitigations disabled.
> 
> Note for tap+vhost-net:
> XDP drop program active in VM -> ~2.5x faster; slower for tap due to
> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> 
> +--------------------------+--------------+----------------+----------+
> | 1 thread                 | Stock        | Patched with   | diff     |
> | sending                  |              | fq_codel qdisc |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Received    | 1.132 Mpps   | 1.133 Mpps     | +0.1%    |
> |            +-------------+--------------+----------------+----------+
> |            | Lost/s      | 3.765 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Received    | 3.857 Mpps   | 3.905 Mpps     | +1.2%    |
> |            +-------------+--------------+----------------+----------+
> | +vhost-net | Lost/s      | 0.802 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> 
> +--------------------------+--------------+----------------+----------+
> | 2 threads                | Stock        | Patched with   | diff     |
> | sending                  |              | fq_codel qdisc |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Received    | 1.115 Mpps   | 1.092 Mpps     | -2.1%    |
> |            +-------------+--------------+----------------+----------+
> |            | Lost/s      | 8.490 Mpps   | 359 pps        |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Received    | 3.664 Mpps   | 3.549 Mpps     | -3.1%    |
> |            +-------------+--------------+----------------+----------+
> | +vhost-net | Lost/s      | 5.330 Mpps   | 832 pps        |          |
> +------------+-------------+--------------+----------------+----------+
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index fc358c4c355b..d9ffbf88cfd8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1018,6 +1018,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct netdev_queue *queue;
>  	struct tun_file *tfile;
>  	int len = skb->len;
> +	int ret;
>  
>  	rcu_read_lock();
>  	tfile = rcu_dereference(tun->tfiles[txq]);
> @@ -1072,13 +1073,33 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	nf_reset_ct(skb);
>  
> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> +	queue = netdev_get_tx_queue(dev, txq);
> +
> +	spin_lock(&tfile->tx_ring.producer_lock);
> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> +	if (!qdisc_txq_has_no_queue(queue) &&
> +	    (__ptr_ring_produce_peek(&tfile->tx_ring) || ret)) {
> +		netif_tx_stop_queue(queue);
> +		/* Paired with smp_mb() in __tun_wake_queue() */
> +		smp_mb__after_atomic();
> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> +			netif_tx_wake_queue(queue);
> +	}
> +	spin_unlock(&tfile->tx_ring.producer_lock);
> +

There's a weird corner case here when tx_queue_len is 0
but a qdisc has been configured - it looks like that
currently it just drops all packets, with this change,
the qdisc will get stuck permanently.

I suspect just checking tx_ring.size should fix it.
Or if you feel adventurous, change return code for __ptr_ring_produce
to distinguish between "no ring" and "no space".


> +	if (ret) {
> +		/* This should be a rare case if a qdisc is present, but
> +		 * can happen due to lltx.
> +		 * Since skb_tx_timestamp(), skb_orphan(),
> +		 * run_ebpf_filter() and pskb_trim() could have tinkered
> +		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
> +		 * we must drop instead.
> +		 */
>  		drop_reason = SKB_DROP_REASON_FULL_RING;
>  		goto drop;
>  	}
>  
>  	/* dev->lltx requires to do our own update of trans_start */
> -	queue = netdev_get_tx_queue(dev, txq);
>  	txq_trans_cond_update(queue);
>  
>  	/* Notify and wake up reader process */
> -- 
> 2.43.0


