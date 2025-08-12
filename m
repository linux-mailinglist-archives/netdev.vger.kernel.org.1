Return-Path: <netdev+bounces-213044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2536AB22E83
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6B5167C45
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA612FD1A9;
	Tue, 12 Aug 2025 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="rhfFh4Pw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F2D2FD1A1
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018014; cv=none; b=FYqYkADxUbolKXKbbQ7LTGKoaVtAYaOAUkPD06dvWhFQcOImtwnbKfdDyQdtG+pKIDLwaXj2nb4zweABSeI7SqmwV9EhpUGz5cDuvCm/9EuwfQPXwQqw9UPWI95IJemncrQJ6Eoe3zrUf4Xanmq1JbP8l3fKU9WajhQIWExgkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018014; c=relaxed/simple;
	bh=Y/uH3UmRE0/jRDYQaaY3/CiFVzZkfvu0p5TXfmsm8vw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeDJhpMRASjo45h3xD4CF+cVopn4Z/hoS/TL++DE+3LRQBEq8D1nO4VBCSJ/RimHkEDBVT+SK+vm3KQr95tZwJ6cLt9HzZG6XSqhVEaX2mcB60JW3b8rjKGIGTx22E4e8lAOg4kFa1G8x80Uv4d2xXiNsi6MOFE/UAhLYogIJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=rhfFh4Pw; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1755018003; x=1755277203;
	bh=Y/uH3UmRE0/jRDYQaaY3/CiFVzZkfvu0p5TXfmsm8vw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rhfFh4Pw+qhgWc+Z+caOjSVWCiyttfKrVdc7KLc3fqg3oUy86hWhRTJGfQFOVPCRh
	 Dx9bRpSYTHf5vAhCWxqSYa/fEcaefyRy8yHkOBYCT1NCxp9Ut5P8Bnrnn2QpqjMe2g
	 NBENz5McVYCb/Lxqs2klStEe4NEyd2KQ6X/ANdjiUky3V1M8lZQeJr0X6Mjs4yI7HF
	 oK3WhRoGp7ZCUCFdQ5v7iaSJyW/jzIFg8XYz7FynBC92x2P9NFIk1pk7V+56tyHaib
	 Paj5U2rkmzZ/zldT30B3nhOkE1gF5WeDlFxWlb3rGXTpkeRhm/CwzpwbaXP2EXUU9s
	 7tsDNbCedUPZA==
Date: Tue, 12 Aug 2025 16:59:59 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, victor@mojatatu.com
Subject: Re: [PATCH net v4 1/2] net/sched: Fix backlog accounting in qdisc_dequeue_internal
Message-ID: <YycoAPI6tDiI1T8q-sQI6nAfIVk7E3AeX-6Zx9oERXXbdvHvIdO1zDqVAIAC1BUQaKnMRpAG842fAV94F7OZP7gKLcAx2ZrrEoDdQzZDt-M=@willsroot.io>
In-Reply-To: <20250812073802.28f86ab2@kernel.org>
References: <20250727235602.216450-1-will@willsroot.io> <20250808142746.6b76eae1@kernel.org> <n-GjVW0_1R1-ujkLgZIEgnaQKSsNtQ9-7UZiTmDCJsy1EutoUtiGOSahNSxpz2yANsp5olbxItT2X9apTC9btIRepMGAZZVBqWx6ueYE5O4=@willsroot.io> <20250811082958.489df3fa@kernel.org> <-8f3jdd-5pxHr0GW-uu8VtTzqDKDOyJohJ-soIwzRyqJUub186VYIxqNoGOTh8Oxtu1U0CEDl5h3N1c1D1jbn7nIlXUrNo55CHK5KcT23c4=@willsroot.io> <20250811102449.50e5f416@kernel.org> <Xd_A9IO0dh4NAVigE2yIDk9ZbCEz4XRcUO1PBNl2G6kEZF6TEAeXtDR85R_P-zIMdSL17cULM_GdmijrKs84RdMewdZswMDCBu5G7oBrajY=@willsroot.io> <20250811175120.7dd5b362@kernel.org> <OF2YXaY19FGNBLPjTD_cAIQim1BVjj7pzMkq8j5mXSQJr9Kd6N04zf2YkLCEpxnIz-zrljMlV0Ask-hlUDuc3rkzIKfF7MzY-jgVtyTi2Q4=@willsroot.io> <20250812073802.28f86ab2@kernel.org>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: b9382dd2aaaa3e756f38ae77018a6c51c73abc1f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, August 12th, 2025 at 2:38 PM, Jakub Kicinski <kuba@kernel.org> =
wrote:

>=20
>=20
> On Tue, 12 Aug 2025 02:10:02 +0000 William Liu wrote:
>=20
> > > AFAICT only if the backlog adjustment is using the prev_qlen,
> > > prev_backlog approach, which snapshots the backlog. In that case,
> > > yes, the "internal drops" will mess up the count.
> >=20
> > Yep, that's why I added the dropped_qlen and dropped_backlog
> > variables, though that is not a very pretty solution.
> >=20
> > But even looking at the method you suggested (copy pasting for
> > reference):
> >=20
> > pkts =3D 0;
> > bytes =3D 0;
> > while (sch->q.qlen > sch->limit ||
> > q->memory_usage > q->memory_limit) {
> > struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
> > pkts++;
> > bytes +=3D qdisc_pkt_len(skb);
> > rtnl_kfree_skbs(skb, skb);
> > }
> > qdisc_tree_reduce_backlog(sch, pkts, bytes);
> >=20
> > qdisc_dequeue_internal can trigger fq_codel_dequeue, which can
> > trigger qdisc_tree_reduce_backlog before returning (the only qdisc
> > out of these that does so in its dequeue handler).
> >=20
> > Let's say the limit only goes down by one, and packet A is at the
> > front of the queue. qdisc_dequeue_internal takes the dequeue path,
> > and fq_codel_dequeue triggers a qdisc_tree_reduce_backlog from that
> > packet before returning the skb. Would this final
> > qdisc_tree_reduce_backlog after the limit drop not double count?
>=20
>=20
> The packets that got counted in qdisc_tree_reduce_backlog() inside
> ->dequeue are freed immediately via
>=20
>=20
> drop_func()
> kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_CONGESTED);
>=20
> in the scenario you're describing ->dequeue should return NULL.
>=20
> If that's possible, then we have another bug here :$
>=20
> Normally backlogs get adjusted as the packet travels down the hierarchy
> thru the parent chain. ->dequeue is part of this normal path so skbs it
>=20
> returns are still in the parent's backlogs. qdisc_tree_reduce_backlog()
> is only called when we need to do something to an skb outside of the
> normal ->enqueue/->dequeue flow that iterates the hierarchy.


Ah ok, this makes much more sense now! Thank you for explaining - I will ge=
t a v5 in for this patch with your proposed fix soonish then.

