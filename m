Return-Path: <netdev+bounces-68977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE42849028
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 20:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E64284136
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA55524A1A;
	Sun,  4 Feb 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVNKw0PD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AC250E2
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707076273; cv=none; b=RVwbR9+6ZmvQYvetTpEu8Q8QieqGL3+btfmWaiu1cVzdMEExO8bOOKDXjY2IYgapCgDtdfwjFefGDvmhzOBRPN5rOZubNEvh2BnpR9y3MU37zdj24rcSK6yMAjiPLpalqbL98oCYQiodn9JGk9rRpmeV4yyU9Go9u9qI9WFppRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707076273; c=relaxed/simple;
	bh=aaS0GsUUtAhgw07iVog4F+gSC0wQDRgB++MVJrXuZRw=;
	h=From:References:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=gqRMo4sPxCOMWDZpBbrAU5rnYkFneorEF2x8GSPEx1d0dIh4sxkbvevytDmxcC93xm8s0PrBKdUVug05BD+mb2Uh8s7dIPPGUI+qVuhcr6V3oyvfYPZODjsOLWFpt+VmPmPCcbFaUXLbLSOnzn8RfqnQ8OFQg5VzuNu8Lga73Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVNKw0PD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c431c6c91so17351406d6.0
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 11:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707076270; x=1707681070; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:user-agent
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lkd84eJH5rfuVYq20Bnh9Dxkme3iqkpzTo81fEw4yHY=;
        b=fVNKw0PDR9OgLPgqX+xwoOc07OzboC9i9iENRj4zi5MaL10LfDGZvvWoPf5mrMHfyc
         zGjmSrgu75VZ3uEztQwoDe4bvA2PURAbC6SKTDO1xBiX+2NzGnEEoTXN+zLWMiettLGo
         i0FS3PPq1JbuuG+y6ctsw4v0TU+U5zb2VfuwmmqHxS0JMB59Pvf9E7485Y9+JpJPwCQ2
         QU31lrXnbQtfejdEVWS2v1sveiGZicPxiCNHkbyR6h+/YVGMUc8yvQp6TeghQ1ZFbxTv
         UXwSQDOJKX1366wUwO8SzmjeKylcyIjUtKiUzvm1tmOFocTo7C6tBvjmjgdlW0DOWCl3
         ovgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707076270; x=1707681070;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:user-agent
         :references:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lkd84eJH5rfuVYq20Bnh9Dxkme3iqkpzTo81fEw4yHY=;
        b=M/b9xwHYltFcIERJKZbH0k4S0apj9BJjQ/r8GJyLEifkG/96yZTe6GeUUidpuVUOgY
         0WmUo/9fXojuBu0XnGZD6iH7Fukzisv4Xgvx/m1fxloYt098eBx6EYmrdIrvOROvdIc+
         FOYnwsKgZNllhIp5GnS44vK0uT5/2ms6cKO8sLy0yHrOSfMAypM+6RsS+xUXgV5nLgDF
         fRNyKLYqTBYMGGxFDTQni/af8pFB252h0YYY8ODmmJF08Wwn2tiIfN/jTqC4m8L76RhL
         rzPQs8cNpIOplvy+gt7ZYmJPUj9WOIOazejpD7pLS8hE3LWSgdu8LTOyEevzkzPxrmcs
         45vg==
X-Gm-Message-State: AOJu0Yzq5qLeOivTP4W9mI0ekt+KeMzM7zdEGooG/JGXevxB3GRAWHPg
	hmeBwxLundqv9uOwXB8vn0aWsbjxHV+Jfc7AcOnI1iRt42rPMS8VHRU1sZ5VHqY=
X-Google-Smtp-Source: AGHT+IEfqn03zAYKQnQd3kujOSQ9zv/xDs+SZBzcKwoKG7dPI0+q/fXr3QPjS+6Ngx1TtMs5QDDVlg==
X-Received: by 2002:a0c:f543:0:b0:68c:3c2d:4375 with SMTP id p3-20020a0cf543000000b0068c3c2d4375mr4291355qvm.24.1707076269493;
        Sun, 04 Feb 2024 11:51:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUk5D1SRs32ZuXIWecDUA4ePX/THdJt3AwfI4IqT34uNHM9D91Pxexlzg9hYVMJAJ9A5s3XlFyTCpY9ALWy1XQqt2/ROAqQ5BLkuv4OBiP0L6208UJ5An/5r+GCQCaKbEHaKwundAOkaljSgoZOSK+TXJIaHwv94NBSunZ617ZGCW2FDYMe7ScBH21X1w==
Received: from ja.int.chopps.org.gmail.com (172-222-091-149.res.spectrum.com. [172.222.91.149])
        by smtp.gmail.com with ESMTPSA id lz8-20020a0562145c4800b006837a012417sm3011147qvb.51.2024.02.04.11.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 11:51:08 -0800 (PST)
From: Christian Hopps <chopps@gmail.com>
X-Google-Original-From: Christian Hopps <chopps@chopps.org>
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-9-chopps@chopps.org> <ZWirZo4FrvZOi1Ik@hog>
User-agent: mu4e 1.8.14; emacs 28.2
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next v2 8/8] iptfs: impl: add new iptfs xfrm mode impl
Date: Fri, 02 Feb 2024 04:44:56 -0500
In-reply-to: <ZWirZo4FrvZOi1Ik@hog>
Message-ID: <m2fry857pw.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Sabrina Dubroca <sd@queasysnail.net> writes:

> 2023-11-12, 22:52:19 -0500, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
>>
>> This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
>> functionality. This functionality can be used to increase bandwidth
>> utilization through small packet aggregation, as well as help solve PMTU
>> issues through it's efficient use of fragmentation.
>>
>> Link: https://www.rfc-editor.org/rfc/rfc9347.txt
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  include/net/iptfs.h    |   18 +
>>  net/xfrm/Makefile      |    1 +
>>  net/xfrm/trace_iptfs.h |  224 ++++
>>  net/xfrm/xfrm_iptfs.c  | 2696 ++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 2939 insertions(+)
>>  create mode 100644 include/net/iptfs.h
>>  create mode 100644 net/xfrm/trace_iptfs.h
>>  create mode 100644 net/xfrm/xfrm_iptfs.c
>>
>> diff --git a/include/net/iptfs.h b/include/net/iptfs.h
>> new file mode 100644
>> index 000000000000..d8f2e494f251
>> --- /dev/null
>> +++ b/include/net/iptfs.h
>
> Is this header needed? It's only included by net/xfrm/xfrm_iptfs.c,
> why not put those #defines directly in the file?

Moved into xfrm_iptfs.c and removed this file.

>
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _NET_IPTFS_H
>> +#define _NET_IPTFS_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/ip.h>
>> +
>> +#define IPTFS_SUBTYPE_BASIC 0
>> +#define IPTFS_SUBTYPE_CC 1
>> +#define IPTFS_SUBTYPE_LAST IPTFS_SUBTYPE_CC
>
> _LAST is never used.

Removed.

>> +#define IPTFS_CC_FLAGS_ECN_CE 0x1
>> +#define IPTFS_CC_FLAGS_PLMTUD 0x2
>
> Not used either.

Removed (until we need them).

>> +extern void xfrm_iptfs_get_rtt_and_delays(struct ip_iptfs_cc_hdr *cch, u32 *rtt,
>> +					  u32 *actual_delay, u32 *xmit_delay);
>
> Not implemented in this series, drop this.

Gone.

> [...]
>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>> new file mode 100644
>> index 000000000000..65f7acdbe6a8
>> --- /dev/null
>> +++ b/net/xfrm/xfrm_iptfs.c
> [...]
>> +struct sk_buff *iptfs_pskb_add_frags(struct sk_buff *tpl,
>
> nit: static? afaict it's not used outside this file.

static node.

>> +				     struct skb_frag_walk *walk, u32 off,
>> +				     u32 len, struct skb_seq_state *st,
>> +				     u32 copy_len)
>> +{
>
>
> [...]
>> +
>> +/**
>> + * iptfs_input_ordered() - handle next in order IPTFS payload.
>> + *
>> + * Process the IPTFS payload in `skb` and consume it afterwards.
>> + */
>> +static int iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb)
>> +{
>
> Can we try to not introduce a worse problem than xfrm_input already
> is? 326 lines and 20+ local variables is way too much. And then it
> calls another 200+ lines function...
>
> I did try to understand what the main loop does but I got completely
> lost the 3 times I tried :/

I'm not sure what to do with this comment. :)

Its a fairly complex process of reassembling the fragmented inner packets, and it's already divided into 2 functions as you noted. I don't think breaking this up more is going to do much for simplification b/c now we'll need to be passing pointers to what are currently local variables to maintain the state, and the singular concept of what is going on would be fragmented (no pun intended) across multiple functions when it's really just a single process.

>> +static u32 __reorder_this(struct xfrm_iptfs_data *xtfs, struct sk_buff *inskb,
>> +			  struct list_head *list)
>> +
>
> nit: extra blank line

Fixed.

>> +{
>
>
> [...]
>> +/**
>> + * iptfs_input() - handle receipt of iptfs payload
>> + * @x: xfrm state.
>> + * @skb: the packet.
>> + *
>> + * We have an IPTFS payload order it if needed, then process newly in order
>> + * packetsA.
>
> typo? "packetsA"

Fixed.

> [...]
>> +/* IPv4/IPv6 packet ingress to IPTFS tunnel, arrange to send in IPTFS payload
>> + * (i.e., aggregating or fragmenting as appropriate).
>> + * This is set in dst->output for an SA.
>> + */
>> +static int iptfs_output_collect(struct net *net, struct sock *sk,
>> +				struct sk_buff *skb)
>> +{
>> +	struct dst_entry *dst = skb_dst(skb);
>> +	struct xfrm_state *x = dst->xfrm;
>> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
>> +	struct sk_buff *segs, *nskb;
>> +	u32 count, qcount;
>> +	u32 pmtu = 0;
>> +	bool ok = true;
>> +	bool was_gso;
>> +
>> +	/* We have hooked into dst_entry->output which means we have skipped the
>> +	 * protocol specific netfilter (see xfrm4_output, xfrm6_output).
>> +	 * when our timer runs we will end up calling xfrm_output directly on
>> +	 * the encapsulated traffic.
>> +	 *
>> +	 * For both cases this is the NF_INET_POST_ROUTING hook which allows
>> +	 * changing the skb->dst entry which then may not be xfrm based anymore
>> +	 * in which case a REROUTED flag is set. and dst_output is called.
>> +	 *
>> +	 * For IPv6 we are also skipping fragmentation handling for local
>> +	 * sockets, which may or may not be good depending on our tunnel DF
>> +	 * setting. Normally with fragmentation supported we want to skip this
>> +	 * fragmentation.
>> +	 */
>> +
>> +	BUG_ON(!xtfs);
>
> Or drop the packet and add a DEBUG_NET_WARN_ON_ONCE? This should never
> happen, but why crash the system when we have a way to deal with this
> error?

So this is running into basic assert philosophy I suppose. For true invariant's I like to simplify things by asserting them being true (which also documents them) rather than create more logic branches in the code. The added complexity of those extra branches becomes more apparent when you are doing code-coverage analysis. I'd rather not add code that will never execute that I then have to create impossible situation tests to test.

>> +	if (xtfs->cfg.dont_frag)
>> +		pmtu = iptfs_get_cur_pmtu(x, xtfs, skb);
>> +
>> +	/* Break apart GSO skbs. If the queue is nearing full then we want the
>> +	 * accounting and queuing to be based on the individual packets not on the
>> +	 * aggregate GSO buffer.
>> +	 */
>> +	was_gso = skb_is_gso(skb);
>> +	if (!was_gso) {
>> +		segs = skb;
>> +	} else {
>> +		segs = skb_gso_segment(skb, 0);
>> +		if (IS_ERR_OR_NULL(segs)) {
>> +			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
>> +			kfree_skb(skb);
>> +			return PTR_ERR(segs);
>> +		}
>> +		consume_skb(skb);
>> +		skb = NULL;
>> +	}
>> +
>> +	count = 0;
>> +	qcount = 0;
>
> nit: both of those get incremented through the main loop but never read

Removed.

>> +
>> +	/* We can be running on multiple cores and from the network softirq or
>> +	 * from user context depending on where the packet is coming from.
>> +	 */
>> +	spin_lock_bh(&x->lock);
>> +
>> +	skb_list_walk_safe(segs, skb, nskb) {
>> +		skb_mark_not_on_list(skb);
>> +		count++;
>> +
>> +		/* Once we drop due to no queue space we continue to drop the
>> +		 * rest of the packets from that GRO.
>> +		 */
>> +		if (!ok) {
>> +nospace:
>> +			trace_iptfs_no_queue_space(skb, xtfs, pmtu, was_gso);
>> +			XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMOUTNOQSPACE);
>> +			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
>> +			continue;
>> +		}
>> +
>> +		/* If the user indicated no iptfs fragmenting check before
>> +		 * enqueue.
>> +		 */
>> +		if (xtfs->cfg.dont_frag && iptfs_is_too_big(sk, skb, pmtu)) {
>> +			trace_iptfs_too_big(skb, xtfs, pmtu, was_gso);
>> +			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
>> +			continue;
>> +		}
>> +
>> +		/* Enqueue to send in tunnel */
>> +
>
> nit: unneeded blank line

A style choice, it's an important point in the code, and I was trying to call that out. I'll remove the newline though.

>
>> +		ok = iptfs_enqueue(xtfs, skb);
>> +		if (!ok)
>> +			goto nospace;
>> +
>> +		trace_iptfs_enqueue(skb, xtfs, pmtu, was_gso);
>> +		qcount++;
>> +	}
>> +
>> +	/* Start a delay timer if we don't have one yet */
>> +	if (!hrtimer_is_queued(&xtfs->iptfs_timer)) {
>> +		/* softirq blocked lest the timer fire and interrupt us */
>> +		BUG_ON(!in_interrupt());
>
> Why is that a fatal condition?

Removed this.

>
>> +		hrtimer_start(&xtfs->iptfs_timer, xtfs->init_delay_ns,
>> +			      IPTFS_HRTIMER_MODE);
>> +
>> +		xtfs->iptfs_settime = ktime_get_raw_fast_ns();
>> +		trace_iptfs_timer_start(xtfs, xtfs->init_delay_ns);
>> +	}
>> +
>> +	spin_unlock_bh(&x->lock);
>> +	return 0;
>> +}
>> +
>
> [...]
>> +static int iptfs_copy_create_frags(struct sk_buff **skbp,
>> +				   struct xfrm_iptfs_data *xtfs, u32 mtu)
>> +{
> [...]
>> +	/* prepare the initial fragment with an iptfs header */
>> +	iptfs_output_prepare_skb(skb, 0);
>> +
>> +	/* Send all but last fragment. */
>> +	list_for_each_entry_safe(skb, nskb, &sublist, list) {
>> +		skb_list_del_init(skb);
>> +		xfrm_output(NULL, skb);
>
> Should we stop if xfrm_output fails? Or is it still useful to send the
> rest of the iptfs frags if we lose one in the middle?

At the time it didn't seem worth handling this special case, but I've added freeing the rest now if an xfrm_output returns an error.

>> +	}
>> +
>> +	return 0;
>> +}
>> +
>
> [...]
>> +static int iptfs_first_skb(struct sk_buff **skbp, struct xfrm_iptfs_data *xtfs,
>> +			   u32 mtu)
>> +{
>> +	struct sk_buff *skb = *skbp;
>> +	int err;
>> +
>> +	/* Classic ESP skips the don't fragment ICMP error if DF is clear on
>> +	 * the inner packet or ignore_df is set. Otherwise it will send an ICMP
>> +	 * or local error if the inner packet won't fit it's MTU.
>> +	 *
>> +	 * With IPTFS we do not care about the inner packet DF bit. If the
>> +	 * tunnel is configured to "don't fragment" we error back if things
>> +	 * don't fit in our max packet size. Otherwise we iptfs-fragment as
>> +	 * normal.
>> +	 */
>> +
>> +	/* The opportunity for HW offload has ended */
>> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
>> +		err = skb_checksum_help(skb);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	/* We've split these up before queuing */
>> +	BUG_ON(skb_is_gso(skb));
>
> Drop and DEBUG_NET_WARN_ON_ONCE?

Earlier comment on asserts applies here.

>> +
>> +	trace_iptfs_first_dequeue(skb, mtu, 0, ip_hdr(skb));
>> +
>> +	/* Simple case -- it fits. `mtu` accounted for all the overhead
>> +	 * including the basic IPTFS header.
>> +	 */
>> +	if (skb->len <= mtu) {
>> +		iptfs_output_prepare_skb(skb, 0);
>> +		return 0;
>> +	}
>> +
>> +	BUG_ON(xtfs->cfg.dont_frag);
>
> and here?

I'll just drop this one.

>> +	if (iptfs_first_should_copy(skb, mtu))
>> +		return iptfs_copy_create_frags(skbp, xtfs, mtu);
>
> Since we end up copying anyway, drop this (and
> iptfs_first_should_copy). You can introduce the optimization later on.

I was going to remove this, but I'd really like to leave it. It provides the start of the optimized code, as well as making it obvious to someone coming after me that there is something that can be (somewhat easily?) done here to finish it. So I see a real loss in removing this code, but I don't see any real gain in doing so.

>> +	/* For now we always copy */
>> +	return iptfs_copy_create_frags(skbp, xtfs, mtu);
>> +}
>> +
>> +static struct sk_buff **iptfs_rehome_fraglist(struct sk_buff **nextp,
>> +					      struct sk_buff *child)
>> +{
>> +	u32 fllen = 0;
>> +
>> +	BUG_ON(!skb_has_frag_list(child));
>
> Not needed, this was tested just before calling this function.

Removed.

>> +
>> +	/* It might be possible to account for a frag list in addition to page
>> +	 * fragment if it's a valid state to be in. The page fragments size
>> +	 * should be kept as data_len so only the frag_list size is removed,
>> +	 * this must be done above as well took
>> +	 */
>> +	BUG_ON(skb_shinfo(child)->nr_frags);
>
> Again not worth crashing the system?

The function does not handle this unexpected case, so this seems like a valid use of BUG_ON() even if one doesn't subscribe to the general assert philosophy I mentioned above. :)

>> +	*nextp = skb_shinfo(child)->frag_list;
>> +	while (*nextp) {
>> +		fllen += (*nextp)->len;
>> +		nextp = &(*nextp)->next;
>> +	}
>> +	skb_frag_list_init(child);
>> +	BUG_ON(fllen > child->data_len);
>> +	child->len -= fllen;
>> +	child->data_len -= fllen;
>> +
>> +	return nextp;
>> +}
>
> [...]
>> +static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
>> +{
>> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
>> +	u32 payload_mtu = xtfs->payload_mtu;
>> +	struct sk_buff *skb, *skb2, **nextp;
>> +	struct skb_shared_info *shi, *shi2;
>> +
>> +	/* For now we are just outputting packets as fast as we can, so if we
>> +	 * are fragmenting we will do so until the last inner packet has been
>> +	 * consumed.
>> +	 *
>> +	 * When we are fragmenting we need to output all outer packets that
>> +	 * contain the fragments of a single inner packet, consecutively (ESP
>> +	 * seq-wise). So we need a lock to keep another CPU from sending the
>> +	 * next batch of packets (it's `list`) and trying to output those, while
>> +	 * we output our `list` resuling with interleaved non-spec-client inner
>> +	 * packet streams. Thus we need to lock the IPTFS output on a per SA
>> +	 * basis while we process this list.
>> +	 */
>
> This talks about a lock but I don't see one. What am I missing?

I will fix the comment as no (further) locking is required here. The reason is that iptfs_output_queued() is always being run from a timer (iptfs_delay_timer()) which will only be running on a single CPU at any given time.

>> +	/* NOTE: for the future, for timed packet sends, if our queue is not
>> +	 * growing longer (i.e., we are keeping up) and a packet we are about to
>> +	 * fragment will not fragment in then next outer packet, we might consider
>> +	 * holding on to it to send whole in the next slot. The question then is
>> +	 * does this introduce a continuous delay in the inner packet stream
>> +	 * with certain packet rates and sizes?
>> +	 */
>> +
>> +	/* and send them on their way */
>> +
>> +	while ((skb = __skb_dequeue(list))) {
>> +		struct xfrm_dst *xdst = (struct xfrm_dst *)skb_dst(skb);
>> +		u32 mtu = __iptfs_get_inner_mtu(x, xdst->child_mtu_cached);
>> +		bool share_ok = true;
>> +		int remaining;
>> +
>> +		/* protocol comes to us cleared sometimes */
>> +		skb->protocol = x->outer_mode.family == AF_INET ?
>> +					htons(ETH_P_IP) :
>> +					htons(ETH_P_IPV6);
>> +
>> +		if (payload_mtu && payload_mtu < mtu)
>> +			mtu = payload_mtu;
>
> Isn't that iptfs_get_cur_pmtu?

You're right; replaced the locals and conditional with iptfs_get_cur_pmtu instead.

> [...]
>> +static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me)
>> +{
>> +	struct sk_buff_head list;
>> +	struct xfrm_iptfs_data *xtfs;
>> +	struct xfrm_state *x;
>> +	time64_t settime;
>> +	size_t osize;
>> +
>> +	xtfs = container_of(me, typeof(*xtfs), iptfs_timer);
>> +	x = xtfs->x;
>> +
>> +	/* Process all the queued packets
>> +	 *
>> +	 * softirq execution order: timer > tasklet > hrtimer
>> +	 *
>> +	 * Network rx will have run before us giving one last chance to queue
>> +	 * ingress packets for us to process and transmit.
>> +	 */
>> +
>> +	spin_lock(&x->lock);
>> +	__skb_queue_head_init(&list);
>> +	skb_queue_splice_init(&xtfs->queue, &list);
>> +	osize = xtfs->queue_size;
>
> Unused variable?

Removed.

> [...]
>> +static int iptfs_user_init(struct net *net, struct xfrm_state *x,
>> +			   struct nlattr **attrs)
>> +{
>> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
>> +	struct xfrm_iptfs_config *xc;
>> +
>> +	if (x->props.mode != XFRM_MODE_IPTFS)
>> +		return -EINVAL;
>
> Is that necessary? This only gets called via ->user_init for this
> mode.

It predated the callbacks. I've removed it.

>> +	xc = &xtfs->cfg;
>> +	xc->reorder_win_size = net->xfrm.sysctl_iptfs_rewin;
>> +	xc->max_queue_size = net->xfrm.sysctl_iptfs_maxqsize;
>> +	xc->init_delay_us = net->xfrm.sysctl_iptfs_idelay;
>> +	xc->drop_time_us = net->xfrm.sysctl_iptfs_drptime;
>> +
>> +	if (attrs[XFRMA_IPTFS_DONT_FRAG])
>> +		xc->dont_frag = true;
>> +	if (attrs[XFRMA_IPTFS_REORD_WIN])
>> +		xc->reorder_win_size =
>> +			nla_get_u16(attrs[XFRMA_IPTFS_REORD_WIN]);
>> +	/* saved array is for saving 1..N seq nums from wantseq */
>> +	if (xc->reorder_win_size)
>> +		xtfs->w_saved = kcalloc(xc->reorder_win_size,
>> +					sizeof(*xtfs->w_saved), GFP_KERNEL);
>
> We probably need a reasonable bound on reorder_win_size so that we
> don't try to allocate crazy amounts of memory here.

It's a u16 so there's a built in limit. :)

>> +	if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
>> +		xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
>> +		if (!xc->pkt_size)
>> +			xtfs->payload_mtu = 0;
>
> That's already set to 0 via kzalloc, right? So passing 0 as
> XFRMA_IPTFS_PKT_SIZE is equivalent to not providing it?

Not providing is supposed to mean don't change. You're right they are equivalent currently.

>> +		else if (xc->pkt_size > x->props.header_len)
>> +			xtfs->payload_mtu = xc->pkt_size - x->props.header_len;
>> +		else
>> +			return -EINVAL;
>
> This could probably use an extack to explain why the value was rejected.

OK, also added extack to the callback so to be able to do this.

>> +	}
>> +	if (attrs[XFRMA_IPTFS_MAX_QSIZE])
>> +		xc->max_queue_size = nla_get_u32(attrs[XFRMA_IPTFS_MAX_QSIZE]);
>> +	if (attrs[XFRMA_IPTFS_DROP_TIME])
>> +		xc->drop_time_us = nla_get_u32(attrs[XFRMA_IPTFS_DROP_TIME]);
>> +	if (attrs[XFRMA_IPTFS_INIT_DELAY])
>> +		xc->init_delay_us = nla_get_u32(attrs[XFRMA_IPTFS_INIT_DELAY]);
>> +
>> +	xtfs->ecn_queue_size = (u64)xc->max_queue_size * 95 / 100;
>> +	xtfs->drop_time_ns = xc->drop_time_us * NSECS_IN_USEC;
>> +	xtfs->init_delay_ns = xc->init_delay_us * NSECS_IN_USEC;
>
> Can't we get rid of the _us version? Why store both in kernel memory?

Removed the *_us copies from the config struct.

> [...]
>> +static void iptfs_delete_state(struct xfrm_state *x)
>> +{
>> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
>> +
>> +	if (IS_ERR_OR_NULL(xtfs))
>
> Can mode_data ever be an error pointer?

I don't believe so, changed to (!xtfs).

>> +		return;
>> +
>> +	spin_lock(&xtfs->drop_lock);
>> +	hrtimer_cancel(&xtfs->iptfs_timer);
>> +	hrtimer_cancel(&xtfs->drop_timer);
>> +	spin_unlock(&xtfs->drop_lock);
>> +
>> +	kfree_sensitive(xtfs->w_saved);
>> +	kfree_sensitive(xtfs);
>> +}
>> +
>> +static const struct xfrm_mode_cbs iptfs_mode_cbs = {
>> +	.owner = THIS_MODULE,
>> +	.create_state = iptfs_create_state,
>> +	.delete_state = iptfs_delete_state,
>> +	.user_init = iptfs_user_init,
>> +	.copy_to_user = iptfs_copy_to_user,
>> +	.get_inner_mtu = iptfs_get_inner_mtu,
>> +	.input = iptfs_input,
>> +	.output = iptfs_output_collect,
>> +	.prepare_output = iptfs_prepare_output,
>> +};
>> +
>> +static int __init xfrm_iptfs_init(void)
>> +{
>> +	int err;
>> +
>> +	pr_info("xfrm_iptfs: IPsec IP-TFS tunnel mode module\n");
>> +
>> +	err = xfrm_register_mode_cbs(XFRM_MODE_IPTFS, &iptfs_mode_cbs);
>> +	if (err < 0)
>> +		pr_info("%s: can't register IP-TFS\n", __func__);
>> +
>> +	return err;
>> +}
>> +
>> +static void __exit xfrm_iptfs_fini(void)
>> +{
>> +	xfrm_unregister_mode_cbs(XFRM_MODE_IPTFS);
>> +}
>
> If the module is unloaded, existing xfrm states will be left but
> silently broken?

You're right. I've added try_module_get()/module_put() calls in the create and delete state callbacks now.

All the changes noted above will be in the next published patch set.

Thanks for the thorough review!
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmW/6qsSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlzDQP/1sHpU4/GVORQdJE2fWaZY6nuDdgd8NV
LaU1KqdtcnRac1Nuuzkr5OqR4kmk+FzpKkL/Dhi+g2chN4olq4MEyKWlNXEQhEe1
6rNGyiL4a9rR1re8XXUdZ7oo5T3JCJ5vMq57dZHjNtY5vZAruzfAMkXZwoVMT++D
kO2UaE8CruQFJZeriD+7Ifa+jAc8Mr0/RwlQ5rT+lTLJKVMbPT/e0PPw4A8jhej0
89HeCi8wX9i+hMSqBnxWAOn/paPV0oVFPEmquMXYMw4+xMJWQsgIWfW+TzFNa3uo
STJVtBP/tT0GpDYFuoaXE41FBZJjU3MKm2Be7NW/VsSu62bPoc9krpj8C6HASGf3
YhY8JX55G2GfyBLj6r1r7wnEVInoDXmpb0iTUHz4gp+T/DgwjmJGqowgRfF/8N0W
vyQJ6SImLjANjQj09jgZghMNrEiubALtRUg0kcU36GJ9aLjNErRwEHShlQlwvBdH
R61IpV6CII/RzbNH7+JzmHqq+tw6VHdaUMPukUj4cLl2yGlDjqxdl85AD/+PlxGE
iUJI2QRaNPbBArJCBWEDKqaJJJf0iyf7cCqUQO0YRQxAAORYVEtTg1OKA/6e6CE5
Y88+xflUkE9fihtY9RifvSp+uXPNteMuoVvgaqp9xULC45h8sQAX8YOSM/arEBpW
dHwZ9vYbQdZW
=dnOg
-----END PGP SIGNATURE-----
--=-=-=--

