Return-Path: <netdev+bounces-210192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04197B124B2
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 21:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07A43A9AE0
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F8C2517A5;
	Fri, 25 Jul 2025 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="xwrVJ/ak"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22BA205E2F
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753471312; cv=none; b=Nq40/Und0NqY4uvLTRnPxlkqWdI4XhMJdHXI+9TT2swMx6srg2AFMyT48+clBvDNd+xDzor8fmkjvNeQzybH59S6GxchHqgR4djmFN3dYLmDHKvv9CXbIZpVGgtvhRur2zN1lDMEyB6hULRk7KYVjp9EaO/uL7QIf8l4WxPX3Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753471312; c=relaxed/simple;
	bh=z6PcWEJcpz+Y9HsDjmffpjbj649cVvM+W7dR2X9ghBM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtFL0hD6yqbjXdyWVXzQJTRqrG0UmTKutFOsI/uqF12aHH9UUvjIfJzSwhWKtra2LMYPlXmObDdz2cU4PW8lsZVkEqkOytJpg1ZAMhYpuPjUyYrIh5GpfvCKfAjr4y98tCVEDot74tYl0i+2ky4qG5XmatDLZLj0XfqJiHNkJEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=xwrVJ/ak; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1753471291; x=1753730491;
	bh=z6PcWEJcpz+Y9HsDjmffpjbj649cVvM+W7dR2X9ghBM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xwrVJ/akmgVhfwjUH1TJzL/z8W3cHDf/kz8IbAE3t3iFa7Fw6vV5R6Ci9GXWzs8Qr
	 UICJmdsF2MXKXMVM4MjJZVfPCZ0a60H2pQoMfqOmGQoitvR8V16t5iRfvRNRxv6aCB
	 Dqr6Hs4SshNIgzUrupPMzHfn4GjK+ymjkIn+E2c27P7kxueXMHfbUkI1CDGAg2IumC
	 o7+3l+629uQT1A8teNNP5W4ZJ8sCsieP3omy+Dn9SlDBgbivEOokCthloIdqHWcBYz
	 O8wfHxPUg/z22Pg59jCYd9A1i4UZ2s2sDku7TdgVxqPDqnrLMBhMWN02teZqaDaDbS
	 bvQZn9GVTGh1Q==
Date: Fri, 25 Jul 2025 19:21:25 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io
Subject: Re: [PATCH net v2 1/2] net/sched: Fix backlog accounting in qdisc_dequeue_internal
Message-ID: <hx253TcI4I55RNMXolN6TJgZIJDge0mfDHoTzM4x69-mZwEL-AGh3pXbhRcWhbKaCitqPL8ljB74UTpyxyduNSpBjPR0wSFBAdRNvv7Tgoc=@willsroot.io>
In-Reply-To: <aIPTTxhfC519+cdr@pop-os.localdomain>
References: <20250724165507.20789-1-will@willsroot.io> <aIPTTxhfC519+cdr@pop-os.localdomain>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: e331be3e89d203215569377454ba4ac485f97123
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, July 25th, 2025 at 6:56 PM, Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:

>=20
>=20
> On Thu, Jul 24, 2025 at 04:55:27PM +0000, William Liu wrote:
>=20
> > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> > index 2a0f3a513bfa..f9e6d76a1712 100644
> > --- a/net/sched/sch_fq_codel.c
> > +++ b/net/sched/sch_fq_codel.c
> > @@ -286,6 +286,10 @@ static struct sk_buff *fq_codel_dequeue(struct Qdi=
sc *sch)
> > struct fq_codel_flow *flow;
> > struct list_head *head;
> >=20
> > + /* reset these here, as change needs them for proper accounting*/
> > + q->cstats.drop_count =3D 0;
> > + q->cstats.drop_len =3D 0;
> > +
> > begin:
> > head =3D &q->new_flows;
> > if (list_empty(head)) {
> > @@ -319,8 +323,6 @@ static struct sk_buff *fq_codel_dequeue(struct Qdis=
c *sch)
> > if (q->cstats.drop_count) {
> > qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
> > q->cstats.drop_len);
> > - q->cstats.drop_count =3D 0;
> > - q->cstats.drop_len =3D 0;
>=20
>=20
>=20
> Is this change really necessary? This could impact more than just the "sh=
rinking
> to the limit" code path. We need to minimize the the impact of the patch =
since it
> is targeting -net and -stable.
>=20
> The rest looks good to me.
>=20
> Thanks for your patch!

I think so, else qdisc_tree_reduce_backlog after the code path for shrinkin=
g to the limit would have incorrect arguments if the drop path ever happens=
 inside fq_codel_dequeue, which qdisc_dequeue_internal uses on an empty gso=
_skb.

The alternative is to add additional book-keeping fields in the struct for =
this one case, but I don't see cstats.drop_len or cstats.drop_count used el=
sewhere.

Best,
Will

