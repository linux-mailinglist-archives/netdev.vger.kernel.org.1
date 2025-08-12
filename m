Return-Path: <netdev+bounces-212731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C7BB21A99
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C6416389F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321AF2D97A3;
	Tue, 12 Aug 2025 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="Jj/D67wr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B9A95C
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754964615; cv=none; b=lS179dtPdaPSVpba1z/c6DQd19fO+Mz40GEignQVB4/CoVwIcNtfGGwsq0vvfXHZzuO9uw7r/swibHNru2yOJvHJzluPBjnnv2GgORQlsiw3BJdXLpGjQyOui2AFXU8v21NqZUMo3gN5l9AWpJ9FOmA5lpR17k/uq+Y1Vcl83o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754964615; c=relaxed/simple;
	bh=Zc6mGV+M+g8jtNiDIWuw233g8b/76DCO1vHAEAsaHCw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8hjUa9fU3Jkl8XK4rNe5JRAeVghAYrm8rS9jZo5cLaYys3+H1PFpJkl3MVU0faT44IimxaZAl/yxKWyln2zvdCpIt3DTeqXNIG8upixZxmTvJlS4Nawl1oXFcbNzV3WZuMR6S6QrbY2FmuVBCp2yPcrY6iprps7uQO4SFMEAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=Jj/D67wr; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1754964608; x=1755223808;
	bh=RGjOALodNF4GDwCJFsUT70QvxeI8viOzti9xhE5y6U4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Jj/D67wr7P18dvfufT1gPvekWstWaaC1sscKjrfEauG8zK6E9D1ATwESqAJ64HAkP
	 6sNamc0LX68d+CSsFlMz8R5q9o4/2Trtux4LPsvIAX3Onf2B0GW4fjiQJCvNDHheeY
	 XqC2XeXwEEE6/a1JrQPd7weBXU1F+6Rb+ohKzLA5fuTLpQf5yzej0UsDyrvIASKva5
	 sPlJlca6kV5VCXjZfzA+Os2K7Y1AQhmzM6W31gq61U7VYRAhsX6gJM5JeB1BeLrFFP
	 N7bVkFYfoV0Wn0AWdf7OHT/N3uRRRqukSY0vej393Zg0BMmDRqWkqQmLI77SI5Xm57
	 A3GoXubUkXyHQ==
Date: Tue, 12 Aug 2025 02:10:02 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, victor@mojatatu.com
Subject: Re: [PATCH net v4 1/2] net/sched: Fix backlog accounting in qdisc_dequeue_internal
Message-ID: <OF2YXaY19FGNBLPjTD_cAIQim1BVjj7pzMkq8j5mXSQJr9Kd6N04zf2YkLCEpxnIz-zrljMlV0Ask-hlUDuc3rkzIKfF7MzY-jgVtyTi2Q4=@willsroot.io>
In-Reply-To: <20250811175120.7dd5b362@kernel.org>
References: <20250727235602.216450-1-will@willsroot.io> <20250808142746.6b76eae1@kernel.org> <n-GjVW0_1R1-ujkLgZIEgnaQKSsNtQ9-7UZiTmDCJsy1EutoUtiGOSahNSxpz2yANsp5olbxItT2X9apTC9btIRepMGAZZVBqWx6ueYE5O4=@willsroot.io> <20250811082958.489df3fa@kernel.org> <-8f3jdd-5pxHr0GW-uu8VtTzqDKDOyJohJ-soIwzRyqJUub186VYIxqNoGOTh8Oxtu1U0CEDl5h3N1c1D1jbn7nIlXUrNo55CHK5KcT23c4=@willsroot.io> <20250811102449.50e5f416@kernel.org> <Xd_A9IO0dh4NAVigE2yIDk9ZbCEz4XRcUO1PBNl2G6kEZF6TEAeXtDR85R_P-zIMdSL17cULM_GdmijrKs84RdMewdZswMDCBu5G7oBrajY=@willsroot.io> <20250811175120.7dd5b362@kernel.org>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 4dfe4d61f12f740ba77c633a9a63e9ae57741934
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, August 12th, 2025 at 12:51 AM, Jakub Kicinski <kuba@kernel.org>=
 wrote:

>=20
>=20
> On Mon, 11 Aug 2025 17:51:39 +0000 William Liu wrote:
>=20
> > > This sort of separation of logic is very error prone in general.
> > > If you're asking for a specific bug that would exist with your
> > > patch - I believe that two subsequent fq_codel_change() calls,
> > > first one reducing the limit, the other one not reducing (and
> > > therefore never invoking dequeue) will adjust the backlog twice.
> >=20
> > In that case, I think the code in the limit adjustment while loop
> > never run, so the backlog reduction would only happen with arguments
> > of 0.
>=20
>=20
> True.
>=20
> > But yes, I agree that this approach is not ideal.
> >=20
> > > As I commented in the previous message - wouldn't counting the
> > > packets we actually dequeue not solve this problem? smth like:
> > >=20
> > > pkts =3D 0;
> > > bytes =3D 0;
> > > while (sch->q.qlen > sch->limit ||
> > >=20
> > > q->memory_usage > q->memory_limit) {
> > >=20
> > > struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
> > >=20
> > > pkts++;
> > > bytes +=3D qdisc_pkt_len(skb);
> > > rtnl_kfree_skbs(skb, skb);
> > > }
> > > qdisc_tree_reduce_backlog(sch, pkts, bytes);
> > >=20
> > > ? "Conceptually" we are only responsible for adjusting the backlog
> > > for skbs we actually gave to kfree_skb().
> >=20
> > I think the issue here is qdisc_dequeue_internal can call the actual
> > dequeue handler, and fq_codel_dequeue would have already made a
> > qdisc_tree_reduce_backlog call [1] when cstats.drop_count is
> > non-zero. Wouldn't we be double counting packets and bytes for
> > qdisc_tree_reduce_backlog after the limit adjustment loop with this
> > approach?
>=20
>=20
> AFAICT only if the backlog adjustment is using the prev_qlen,
> prev_backlog approach, which snapshots the backlog. In that case,
> yes, the "internal drops" will mess up the count.

Yep, that's why I added the dropped_qlen and dropped_backlog variables, tho=
ugh that is not a very pretty solution.

But even looking at the method you suggested (copy pasting for reference):

=09pkts =3D 0;
=09bytes =3D 0;
 =09while (sch->q.qlen > sch->limit ||
 =09       q->memory_usage > q->memory_limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
=20
=09=09pkts++;
=09=09bytes +=3D qdisc_pkt_len(skb);
 =09=09rtnl_kfree_skbs(skb, skb);
 =09}
=09qdisc_tree_reduce_backlog(sch, pkts, bytes);

qdisc_dequeue_internal can trigger fq_codel_dequeue, which can trigger qdis=
c_tree_reduce_backlog before returning (the only qdisc out of these that do=
es so in its dequeue handler).=20

Let's say the limit only goes down by one, and packet A is at the front of =
the queue. qdisc_dequeue_internal takes the dequeue path, and fq_codel_dequ=
eue triggers a qdisc_tree_reduce_backlog from that packet before returning =
the skb. Would this final qdisc_tree_reduce_backlog after the limit drop no=
t double count?=20

> My naive mental model is that we're only responsible for adjusting
> the backlog for skbs we actually dequeued. IOW the skbs that
> qdisc_dequeue_internal() returned to the "limit trimming loop".
> Because we are "deleting" them, potentially in the middle of
> a qdisc hierarchy. If the qdisc decides to delete some more,
> its on the hook for adjusting for those portions.
>=20

Right, but the dequeue handler calling qdisc_tree_reduce_backlog might have=
 already adjusted the backlog for an skb before qdisc_dequeue_internal retu=
rns in fq_codel. This is what makes the handling here messier.=20

I could be missing something, but the original code in fq_codel was very st=
range.

> I can't find any bugs in your prev_* snapshot approach, but it does
> feel like a layering violation to me.

