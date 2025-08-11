Return-Path: <netdev+bounces-212487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66558B2106F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F71A18A230D
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE502E093E;
	Mon, 11 Aug 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj3D2R/V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A031F9A89
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926199; cv=none; b=ZJoY28U/7Cp61hy5AA+YlPWDhSFHbFGqgwWP59CFmASaJmcOKAkZTLKJzpDgPdxo7W7cjF9BKOXsDtx0s21dtDoOeIM306nlJTrvQ5OqXtms8FEyTol3AOxvHGM6z5+mIxsLPk0meXNub9Tc+3zlAaovj8udeTU/0crrkDQZf4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926199; c=relaxed/simple;
	bh=RH7z9l5KkRjGeKgIExlrNjKa4fyoQAxpw8b/ndamz4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gro/D7/xVVuPwej1JrSewEDUQXZZBQFXtqxMzdJNx5DlJHG8VRF49feHxFwC6C0+WbN54UkYYULbf6d/RXllNDpuqQmsYx0HYyNhi/k7cJO3P0++BVB40K/rR2Rjfg+PpEEluO/Nox83XUbXkfWSSJtkg/POSduJgbX3mD017k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj3D2R/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA31C4CEED;
	Mon, 11 Aug 2025 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926199;
	bh=RH7z9l5KkRjGeKgIExlrNjKa4fyoQAxpw8b/ndamz4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pj3D2R/Vn0NcnhqgaqNH+MhP1ySQsVm8/syY7Cd93L+aGVNSJ6YTjJ1dalyJzRUmM
	 fxyOuyPYMBUUTux0ZEdQ5y9mv6vje/z2DjLR+fo3DtjNP1iAqXI6/cGRaDs8NiwVDj
	 WPAqIyXDwmVV+Q3lVcExcWBZrJAX+zUg1QZg0ip+ncatU/Kv2HWBf+X4GpqEv4+/lz
	 wAtM/69YoJgx2g6NmxvQxuBOl4uXVkHqlHLLSO0Kn5/JHhA7VU6Y2398mCQA6RGK7L
	 wQHWCCZ8xegoSgcPfirbx6zvF5q0FR+EDrP26mKFcEoLA4oz/Z5wiDYeLrKvjSKTW6
	 mc6GGarIBOAiw==
Date: Mon, 11 Aug 2025 08:29:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 pabeni@redhat.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io,
 victor@mojatatu.com
Subject: Re: [PATCH net v4 1/2] net/sched: Fix backlog accounting in
 qdisc_dequeue_internal
Message-ID: <20250811082958.489df3fa@kernel.org>
In-Reply-To: <n-GjVW0_1R1-ujkLgZIEgnaQKSsNtQ9-7UZiTmDCJsy1EutoUtiGOSahNSxpz2yANsp5olbxItT2X9apTC9btIRepMGAZZVBqWx6ueYE5O4=@willsroot.io>
References: <20250727235602.216450-1-will@willsroot.io>
	<20250808142746.6b76eae1@kernel.org>
	<n-GjVW0_1R1-ujkLgZIEgnaQKSsNtQ9-7UZiTmDCJsy1EutoUtiGOSahNSxpz2yANsp5olbxItT2X9apTC9btIRepMGAZZVBqWx6ueYE5O4=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Aug 2025 21:06:57 +0000 William Liu wrote:
> > On Sun, 27 Jul 2025 23:56:32 +0000 William Liu wrote:
> >   
> > > Special care is taken for fq_codel_dequeue to account for the
> > > qdisc_tree_reduce_backlog call in its dequeue handler. The
> > > cstats reset is moved from the end to the beginning of
> > > fq_codel_dequeue, so the change handler can use cstats for
> > > proper backlog reduction accounting purposes. The drop_len and
> > > drop_count fields are not used elsewhere so this reordering in
> > > fq_codel_dequeue is ok.  
> > 
> > 
> > Using local variables like we do in other qdiscs will not work?
> > I think your change will break drop accounting during normal dequeue?  
> 
> Can you elaborate on this? 
> 
> I just moved the reset of two cstats fields from the dequeue handler
> epilogue to the prologue. Those specific cstats fields are not used
> elsewhere so they should be fine, 

That's the disconnect. AFAICT they are passed to codel_dequeue(),
and will be used during normal dequeue, as part of normal active
queue management under traffic..

> but we need to accumulate their
> values during limit adjustment. Otherwise the limit adjustment loop
> could perform erroneous accounting in the final
> qdisc_tree_reduce_backlog because the dequeue path could have already
> triggered qdisc_tree_reduce_backlog calls.
>
> > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > index 902ff5470607..986e71e3362c 100644
> > > --- a/net/sched/sch_fq.c
> > > +++ b/net/sched/sch_fq.c
> > > @@ -1014,10 +1014,10 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
> > > struct netlink_ext_ack *extack)
> > > {
> > > struct fq_sched_data *q = qdisc_priv(sch);
> > > + unsigned int prev_qlen, prev_backlog;
> > > struct nlattr *tb[TCA_FQ_MAX + 1];
> > > - int err, drop_count = 0;
> > > - unsigned drop_len = 0;
> > > u32 fq_log;
> > > + int err;
> > > 
> > > err = nla_parse_nested_deprecated(tb, TCA_FQ_MAX, opt, fq_policy,
> > > NULL);
> > > @@ -1135,16 +1135,16 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
> > > err = fq_resize(sch, fq_log);
> > > sch_tree_lock(sch);
> > > }
> > > +
> > > + prev_qlen = sch->q.qlen;
> > > + prev_backlog = sch->qstats.backlog;
> > > while (sch->q.qlen > sch->limit) {
> > > struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
> > > 
> > > - if (!skb)
> > > - break;  
> > 
> > 
> > The break conditions is removed to align the code across the qdiscs?  
> 
> That break is no longer needed because qdisc_internal_dequeue handles
> all the length and backlog size adjustments. The check existed there
> because of the qdisc_pkt_len call.

Ack, tho, theoretically the break also prevents an infinite loop.
Change is fine, but worth calling this out in the commit message,
I reckon.

> > > - drop_len += qdisc_pkt_len(skb);
> > > rtnl_kfree_skbs(skb, skb);
> > > - drop_count++;
> > > }
> > > - qdisc_tree_reduce_backlog(sch, drop_count, drop_len);
> > > + qdisc_tree_reduce_backlog(sch, prev_qlen - sch->q.qlen,
> > > + prev_backlog - sch->qstats.backlog);  
> > 
> > 
> > There is no real change in the math here, right?
> > Again, you're just changing this to align across the qdiscs?  
> 
> Yep, asides from using a properly updated qlen and backlog from the
> revamped qdisc_dequeue_internal.

Personal preference, but my choice would be to follow the FQ code,
and count the skbs as they are freed. But up to you, since we hold
the lock supposedly the changes to backlog can only be due to our
purging.

