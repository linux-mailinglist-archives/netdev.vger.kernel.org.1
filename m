Return-Path: <netdev+bounces-285073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJc9IxjH+2l5EgAAu9opvQ
	(envelope-from <netdev+bounces-285073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:56:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F81D4E16AC
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99B743009800
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E7E3D2FFD;
	Wed,  6 May 2026 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDnYxgLa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mbuV+gN+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84F35B631
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778108174; cv=none; b=M986QaqNl9C60fUaGkMkhtoRyWS9xTvgAuFe3zpNL6vck14XAVwcAAFKm0Y2pYZl91lj+mEaviJVpd+zoBVVgNZeGvzXXhBG3Ph7yfwwzn3uxPd1iy78m7XI6ICzTrn+1p/2OV5QrNHr5vGCt7ZvOObjfOb3KS42SsJA5fJ24i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778108174; c=relaxed/simple;
	bh=dM3TlIQgVWr1xfD/Lm0b3bvPVHqNBiyinGy2WrAxOQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhribC7wA9ZyzPqgoakdvXc3efajQJL2Tt9vhNoB2mF1rc4EJrTomSzaeuFq5XFV+RsW+KDlA9/SDXFTM3+X/F1ia/oc07Ec8f1euQGTnRewgU4Ru4AmxaJm1ZFhYoiucPFkAfeNmU4xKY5AM/diD4iWexP78fp1nGaD7vCQi8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDnYxgLa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mbuV+gN+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778108171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrLMs5/3pE8k0d8D7czaQla4yNq4KH+KGMukbjP7+Io=;
	b=gDnYxgLaTSuQ++xAxp+kved5m7CVgjJ055l5LdYbc/iGde8NrVFMD4R3wbzwE5QM8bX+9X
	sqINbg2NYGk53gEu/uMcKlz6MIFbUSd3AaNMs0EuDo2ITwqm5hxOdbm6roD9TIe7w9ipBk
	AM1fFzy2WNdagfaZa4P2q8D+Irotyac=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-jdTIto9xMCOuM1UUQR7m0A-1; Wed, 06 May 2026 18:56:10 -0400
X-MC-Unique: jdTIto9xMCOuM1UUQR7m0A-1
X-Mimecast-MFC-AGG-ID: jdTIto9xMCOuM1UUQR7m0A_1778108169
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso819095e9.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778108169; x=1778712969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RrLMs5/3pE8k0d8D7czaQla4yNq4KH+KGMukbjP7+Io=;
        b=mbuV+gN+cVPTm4ABHHEl10zFZKjUYLfTVBqpjiW5lsPQHREPJqYmXpqLK0aMnirTwR
         T2Iz9KkiP+OnxFqcNZIWJLjrrXVCXjO/jILjlpwkWCIZfGrRk1cEPwnapIHozQ/ppFPs
         W+XrGRA511j5E0MJ40qzn6zhOnsPRKFwGG4IMSFMHZPEnVyaAQCh3Oz7q6Zu8VgGa1QV
         StMWlaTqR4EArphUqG38U0/Y/Pz8xwEiNFoE4KAiBz9OzdrkLMdrTyksFYFi1gFqSd2M
         /fosXbO5rIYzk+YaC4iMlWI2itbYyuy9NkhRr8rr1ZcyO6qOvlRklczCkTv0SWTC1XC5
         WiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778108169; x=1778712969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrLMs5/3pE8k0d8D7czaQla4yNq4KH+KGMukbjP7+Io=;
        b=MVmwC+jOpzK6iwiZ1wDI08IfLixvTPYK8wzECmViIzeO0oLIbARJ/cFsIPRqUWJ09T
         YcBQWVw0uuh9eJswLGT1PFbRnEnZuSLFEy+kqSm2FskQXqEApIFpblaHksZlF5+sgbcf
         dmeBDaxWM7HPHn+PRDZjIGyUBkpO0Ytufs6bNZIvbMKatGCrlNNrwYCy+JmTjJm8FDrW
         bxxBBAgyx0IJcYoDPuo6AE9Tlgv/pOIgRi8bzbp3XAj5DoD/WT3ffrsDM7P4SbZ5Vqe3
         PQ+g4QBcHYTCD1/H8uvhfL9M7sLMSIUSmRxRymBQPHUqSpH3lzB/dkZ9LXgtU8BNcMQ4
         M8pA==
X-Forwarded-Encrypted: i=1; AFNElJ9ecOrZJISGs0q0aM3mDh0bgNWWLXQW7Y1OhDuheso+NOK2JRjVumJZ6WK16KRUJvnhLf8Vlyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAxh+PxzRjKlcL32zjFYttvJMjSCtPG7A8Bx4FNg35P8UL6eNw
	OsbCCP4t2obpM4XG1pF/IMiOhfvg845oHnqxuk9OjmYBZJMr7ZAE27CDSPnjvyq3vyomrgALzCV
	c3bRpwJhUHuY2yOBrEbQrEWieXXMlUXptK+aNRr0S3O2+f/nfJYyHmUXpMQ==
X-Gm-Gg: AeBDiet+8DCNH9OJNtsuuj018TJwCUIVQ0kfYokB1vF9sXdXCQFduYkwhJKFczIJ8B8
	bAvQ68sm2uNhmn8dnyNBS9MLjL9yiosKdvWjzA0Fw86i/EBA93x2gl7CV42HN5VvRKcO4aVPoxD
	corFARf7Lh9hzBEiEzDELiPtMSd0YGZv/z03HSrdOsE2kR/tcKCs7hVbXrDRXmhJ+qQ5WkePScj
	BuSNqLF0ys5pdSscaQ1yquxMditFMj/m8lZVt1rvbif5X54G31jwnLUVzdJWUvUI5V3C9dHXnaX
	/gSBLqaZ+oQTraK2YPbJwMiSAq0OAIdlTTuQ7ugudIRXhhUJF/Fb3irXaArF6jPjjis1Ah+oN3j
	/dgoxh0A13Q0pWvIbuVroN6gYWZu63OD490sXFydJZTAqmaLUg2iaBpJoqqgR/w==
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48e51f32aebmr87549935e9.16.1778108168898;
        Wed, 06 May 2026 15:56:08 -0700 (PDT)
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48e51f32aebmr87549685e9.16.1778108168416;
        Wed, 06 May 2026 15:56:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48b23sm16159726f8f.14.2026.05.06.15.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:56:07 -0700 (PDT)
Date: Wed, 6 May 2026 18:56:04 -0400
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
Message-ID: <20260506185515-mutt-send-email-mst@kernel.org>
References: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
 <20260506141033.180450-5-simon.schippers@tu-dortmund.de>
 <20260506181909-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506181909-mutt-send-email-mst@kernel.org>
X-Rspamd-Queue-Id: 8F81D4E16AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285073-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 06:28:06PM -0400, Michael S. Tsirkin wrote:
> On Wed, May 06, 2026 at 04:10:33PM +0200, Simon Schippers wrote:
> > This commit prevents tail-drop when a qdisc is present and the ptr_ring
> > becomes full. Once an entry is successfully produced and the ptr_ring
> > reaches capacity, the netdev queue is stopped instead of dropping
> > subsequent packets. If no qdisc is present, the previous tail-drop
> > behavior is preserved.
> > 
> > If producing an entry fails anyways due to a race, tun_net_xmit() drops
> > the packet. Such races are expected because LLTX is enabled and the
> > transmit path operates without the usual locking.
> > 
> > The __tun_wake_queue() function of the consumer races with the producer
> > for waking/stopping the netdev queue, which could result in a stalled
> > queue. Therefore, an smp_mb__after_atomic() is introduced that pairs
> > with the smp_mb() of the consumer. It follows the principle of store
> > buffering described in tools/memory-model/Documentation/recipes.txt:
> > 
> > - The producer in tun_net_xmit() first sets __QUEUE_STATE_DRV_XOFF,
> >   followed by an smp_mb__after_atomic() (= smp_mb()), and then reads the
> >   ring with __ptr_ring_produce_peek().
> > 
> > - The consumer in __tun_wake_queue() first writes zero to the ring in
> >   __ptr_ring_consume(), followed by an smp_mb(), and then reads the queue
> >   status with netif_tx_queue_stopped().
> > 
> > => Following the aforementioned principle, it is impossible for the
> >    producer to see a full ring (and therefore not wake the queue on the
> >    re-check) while the consumer simultaneously fails to see a stopped
> >    queue (and therefore also does not wake it).
> > 
> > Benchmarks:
> > The benchmarks show a slight regression in raw transmission performance
> > when using two sending threads. Packet loss also occurs only in the
> > two-thread sending case; no packet loss was observed with a single
> > sending thread.
> > 
> > Test setup:
> > AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> > Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> > mitigations disabled.
> > 
> > Note for tap+vhost-net:
> > XDP drop program active in VM -> ~2.5x faster; slower for tap due to
> > more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> > 
> > +--------------------------+--------------+----------------+----------+
> > | 1 thread                 | Stock        | Patched with   | diff     |
> > | sending                  |              | fq_codel qdisc |          |
> > +------------+-------------+--------------+----------------+----------+
> > | TAP        | Received    | 1.132 Mpps   | 1.133 Mpps     | +0.1%    |
> > |            +-------------+--------------+----------------+----------+
> > |            | Lost/s      | 3.765 Mpps   | 0 pps          |          |
> > +------------+-------------+--------------+----------------+----------+
> > | TAP        | Received    | 3.857 Mpps   | 3.905 Mpps     | +1.2%    |
> > |            +-------------+--------------+----------------+----------+
> > | +vhost-net | Lost/s      | 0.802 Mpps   | 0 pps          |          |
> > +------------+-------------+--------------+----------------+----------+
> > 
> > +--------------------------+--------------+----------------+----------+
> > | 2 threads                | Stock        | Patched with   | diff     |
> > | sending                  |              | fq_codel qdisc |          |
> > +------------+-------------+--------------+----------------+----------+
> > | TAP        | Received    | 1.115 Mpps   | 1.092 Mpps     | -2.1%    |
> > |            +-------------+--------------+----------------+----------+
> > |            | Lost/s      | 8.490 Mpps   | 359 pps        |          |
> > +------------+-------------+--------------+----------------+----------+
> > | TAP        | Received    | 3.664 Mpps   | 3.549 Mpps     | -3.1%    |
> > |            +-------------+--------------+----------------+----------+
> > | +vhost-net | Lost/s      | 5.330 Mpps   | 832 pps        |          |
> > +------------+-------------+--------------+----------------+----------+
> > 
> > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > ---
> >  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index fc358c4c355b..d9ffbf88cfd8 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1018,6 +1018,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	struct netdev_queue *queue;
> >  	struct tun_file *tfile;
> >  	int len = skb->len;
> > +	int ret;
> >  
> >  	rcu_read_lock();
> >  	tfile = rcu_dereference(tun->tfiles[txq]);
> > @@ -1072,13 +1073,33 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >  
> >  	nf_reset_ct(skb);
> >  
> > -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> > +	queue = netdev_get_tx_queue(dev, txq);
> > +
> > +	spin_lock(&tfile->tx_ring.producer_lock);
> > +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> > +	if (!qdisc_txq_has_no_queue(queue) &&
> > +	    (__ptr_ring_produce_peek(&tfile->tx_ring) || ret)) {
> > +		netif_tx_stop_queue(queue);
> > +		/* Paired with smp_mb() in __tun_wake_queue() */
> > +		smp_mb__after_atomic();
> > +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> > +			netif_tx_wake_queue(queue);
> > +	}
> > +	spin_unlock(&tfile->tx_ring.producer_lock);
> > +
> 
> There's a weird corner case here when tx_queue_len is 0
> but a qdisc has been configured - it looks like that
> currently it just drops all packets, with this change,
> the qdisc will get stuck permanently.
> 
> I suspect just checking tx_ring.size should fix it.
> Or if you feel adventurous, change return code for __ptr_ring_produce
> to distinguish between "no ring" and "no space".


__ptr_ring_produce_peek really.


> 
> > +	if (ret) {
> > +		/* This should be a rare case if a qdisc is present, but
> > +		 * can happen due to lltx.
> > +		 * Since skb_tx_timestamp(), skb_orphan(),
> > +		 * run_ebpf_filter() and pskb_trim() could have tinkered
> > +		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
> > +		 * we must drop instead.
> > +		 */
> >  		drop_reason = SKB_DROP_REASON_FULL_RING;
> >  		goto drop;
> >  	}
> >  
> >  	/* dev->lltx requires to do our own update of trans_start */
> > -	queue = netdev_get_tx_queue(dev, txq);
> >  	txq_trans_cond_update(queue);
> >  
> >  	/* Notify and wake up reader process */
> > -- 
> > 2.43.0


