Return-Path: <netdev+bounces-214505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8379B29EEB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 12:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B9D207D24
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03172701C3;
	Mon, 18 Aug 2025 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="oHmj8Jkx"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7442236F2
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512372; cv=none; b=tUStPStSGqmlGIGeoqVBdIzViyZRMA2byD0AbtMmbdZ8gfsTCqhnluXrYvOQIUfzIQjiBG1yn0LcgDO63lop8rHriVHOxZTyY3WmequvUzvuM1OcxJemu8GCmFM0nwp7Pk9AP01PudOKkIO/XBK+KGSh2LyL+rrA3VMajljFuf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512372; c=relaxed/simple;
	bh=f30jZL5cYWfUn1vWNWyTFBHLrGVCX1FnWqrPVRvaIe8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RHnhZwHrrB77dryevouNFm1HEzgDhR1T5/lsYd9kxpYCmWLQAIANxR7XLjukG2eg+IZLekVG8kZbNfQ+awfVt22Zwd26wxOaL/zBzQAnIOrFn8tH6K7w3xPcQDiAbn47OTkQKWJiVpYUXjhsShoesrotJ74ukqpUMfwlFN0xt8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=oHmj8Jkx; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1755512356; bh=f30jZL5cYWfUn1vWNWyTFBHLrGVCX1FnWqrPVRvaIe8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oHmj8Jkx7+QX4TFX9u+mNGH9lll/6ZJxEolXYC/ijdyXwxR2C+5597fmAdVFwYCOr
	 ZfA26R7i466ABzXTkI3LTnGLsXgC8alK9BqPbZFRabZgbNT+mKOerox65QxXMvhLl6
	 /918zRCr9t734sZaaOjGSMl8CNum1iAwoNAVmesHtQ11E8l6OgPKV/zKdAXh5Oy+f9
	 JX3t/4YLPo8rwNl6JDiXuSctqZG0/DhdqntT5As4Wylw37nNOY9MbL3z8g01IQ9VeF
	 UzEmZhCPJXXFGbbmeVga7OphjBIKJ+/CgBmTBXgZcxaK1ror7Y6QcMtY7Q0Vp+2fY/
	 DIDodlQTvZMtQ==
To: William Liu <will@willsroot.io>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com,
 kuba@kernel.org, savy@syst3mfailure.io, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 cake@lists.bufferbloat.net, William Liu <will@willsroot.io>
Subject: Re: [PATCH net 1/2] net/sched: Make cake_enqueue return NET_XMIT_CN
 when past buffer_limit
In-Reply-To: <20250817172344.449992-1-will@willsroot.io>
References: <20250817172344.449992-1-will@willsroot.io>
Date: Mon, 18 Aug 2025 12:19:16 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87a53xj5jv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

William Liu <will@willsroot.io> writes:

> The following setup can trigger a WARNING in htb_activate due to
> the condition: !cl->leaf.q->q.qlen
>
> tc qdisc del dev lo root
> tc qdisc add dev lo root handle 1: htb default 1
> tc class add dev lo parent 1: classid 1:1 \
>        htb rate 64bit
> tc qdisc add dev lo parent 1:1 handle f: \
>        cake memlimit 1b
> ping -I lo -f -c1 -s64 -W0.001 127.0.0.1
>
> This is because the low memlimit leads to a low buffer_limit, which
> causes packet dropping. However, cake_enqueue still returns
> NET_XMIT_SUCCESS, causing htb_enqueue to call htb_activate with an
> empty child qdisc.
>
> I do not believe return value of NET_XMIT_CN is necessary for packet
> drops in the case of ack filtering, as that is meant to optimize
> performance, not to signal congestion.
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) qdisc")
> Signed-off-by: William Liu <will@willsroot.io>
> Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
> ---
>  net/sched/sch_cake.c | 3 +++
>  1 file changed, 3 i
> nsertions(+)
>
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dbcfb948c867..40814449f17a 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1934,6 +1934,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  			cake_drop(sch, to_free);
>  		}
>  		b->drop_overlimit += dropped;
> +
> +		if (dropped)
> +			return NET_XMIT_CN;

cake_drop() may drop from a different flow, so we can't unconditionally
return NET_XMIT_CN. We'll have to check the return code of cake_drop()
and only return NET_XMIT_CN if it's the same flow we just enqueued a
packet to (which is also what fq_codel does, BTW).

-Toke

