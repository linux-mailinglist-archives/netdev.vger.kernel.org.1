Return-Path: <netdev+bounces-88635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507E98A7EF8
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 11:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBA3280E8D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E60212837C;
	Wed, 17 Apr 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoxBrM1T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D466A353
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344451; cv=none; b=nHKfTsHOtj0UuHmRJ6hiZtwHkLRy20+aug89ZVWPZCkLXvA6fRnDuL99A1ITc330qtPCdf06rRb9VLZpTumAV0ICu1c/Lyf6UC1lBq4psFHDrK8KhihAGxodNPOszC1Hcs3tC5Ub+uE44WFDgahcbgjx3s3TeNpdEuXnIU8PhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344451; c=relaxed/simple;
	bh=8gSHbgbo0AKKIkxQVx1xcqgZ4ykmwU7ctyGAbe4xG+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbJlmPfwutMWYNn9hmd4gX9MsgoV6oKrNL8jX2smM6kpLnjuWOORLo1vPRRNmZR/cQPU0mLjpJW7A1tuIeFhbQvuT4HgskCFmKImVZGPBohqb2sOZKkiXW3L43QNgXVz9deuuJlzUkr7jtj7kQL60eHvt9CCKCeOJX9qeJJQNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoxBrM1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE32C072AA;
	Wed, 17 Apr 2024 09:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713344450;
	bh=8gSHbgbo0AKKIkxQVx1xcqgZ4ykmwU7ctyGAbe4xG+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoxBrM1TGbkShYKPxiGcTCiTBhhHEsDJekg2aytVHK9r57G664DeF16mTyUp397hs
	 yIEJ0n+R5H+jUHV42zl0dytg5GQ1bB8eFGefvkmWv4PPDc317hWxavIL7/bRZmbMfW
	 PV+w5RZO0P5Ol8lZsjB2luR2jQAf89Y1wK4GFMwQUBCUsivCmqCbB67E3ZmR1sAdX+
	 fDtcrLQugyHt9kl+qsM0ce8pyXQC9Oi6RT2e1oSf97chpFh2Lv5iD3gDAS/kDpNysI
	 fmy/mBZfBdQcfgVAgWStX26SI+bSNZ6lSospTU7p37qFEq37HvS+Kf9imGOpudBA+9
	 DJI+ZsxfEw7dQ==
Date: Wed, 17 Apr 2024 10:00:46 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 01/14] net_sched: sch_fq: implement lockless
 fq_dump()
Message-ID: <20240417090046.GB3846178@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-2-edumazet@google.com>
 <20240416181915.GT2320920@kernel.org>
 <CANn89i+X3zkk-RwRVuMursG-RY+R6P29AWK-pjjVuNKT91VsJw@mail.gmail.com>
 <CANn89i+iNKvCv+RPtCa4KOY9DCEQJfGP9xHSedFUbWZHt2DSFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+iNKvCv+RPtCa4KOY9DCEQJfGP9xHSedFUbWZHt2DSFw@mail.gmail.com>

On Wed, Apr 17, 2024 at 10:45:09AM +0200, Eric Dumazet wrote:
> On Tue, Apr 16, 2024 at 8:33 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Tue, Apr 16, 2024 at 8:19 PM Simon Horman <horms@kernel.org> wrote:
> > >
> > > On Mon, Apr 15, 2024 at 01:20:41PM +0000, Eric Dumazet wrote:
> > > > Instead of relying on RTNL, fq_dump() can use READ_ONCE()
> > > > annotations, paired with WRITE_ONCE() in fq_change()
> > > >
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > ---
> > > >  net/sched/sch_fq.c | 96 +++++++++++++++++++++++++++++-----------------
> > > >  1 file changed, 60 insertions(+), 36 deletions(-)
> > > >
> > > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > > index cdf23ff16f40bf244bb822e76016fde44e0c439b..934c220b3f4336dc2f70af74d7758218492b675d 100644
> > > > --- a/net/sched/sch_fq.c
> > > > +++ b/net/sched/sch_fq.c
> > > > @@ -888,7 +888,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
> > > >               fq_rehash(q, old_fq_root, q->fq_trees_log, array, log);
> > > >
> > > >       q->fq_root = array;
> > > > -     q->fq_trees_log = log;
> > > > +     WRITE_ONCE(q->fq_trees_log, log);
> > > >
> > > >       sch_tree_unlock(sch);
> > > >
> > > > @@ -931,7 +931,7 @@ static void fq_prio2band_compress_crumb(const u8 *in, u8 *out)
> > > >
> > > >       memset(out, 0, num_elems / 4);
> > > >       for (i = 0; i < num_elems; i++)
> > > > -             out[i / 4] |= in[i] << (2 * (i & 0x3));
> > > > +             out[i / 4] |= READ_ONCE(in[i]) << (2 * (i & 0x3));
> > > >  }
> > > >
> > >
> > > Hi Eric,
> > >
> > > I am a little unsure about the handling of q->prio2band in this patch.
> > >
> > > It seems to me that fq_prio2band_compress_crumb() is used to
> > > to store values in q->prio2band, and is called (indirectly)
> > > from fq_change() (and directly from fq_init()).
> > >
> > > While fq_prio2band_decompress_crumb() is used to read values
> > > from q->prio2band, and is called from fq_dump().
> > >
> > > So I am wondering if should use WRITE_ONCE() when storing elements
> > > of out. And fq_prio2band_decompress_crumb should use READ_ONCE when
> > > reading elements of in.
> >
> > Yeah, you are probably right, I recall being a bit lazy on this part,
> > thanks !
> 
> I will squash in V2 this part :
> 
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 934c220b3f4336dc2f70af74d7758218492b675d..238974725679327b0a0d483c011e15fc94ab0878
> 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -106,6 +106,8 @@ struct fq_perband_flows {
>         int                 quantum; /* based on band nr : 576KB, 192KB, 64KB */
>  };
> 
> +#define FQ_PRIO2BAND_CRUMB_SIZE ((TC_PRIO_MAX + 1) >> 2)
> +
>  struct fq_sched_data {
>  /* Read mostly cache line */
> 
> @@ -122,7 +124,7 @@ struct fq_sched_data {
>         u8              rate_enable;
>         u8              fq_trees_log;
>         u8              horizon_drop;
> -       u8              prio2band[(TC_PRIO_MAX + 1) >> 2];
> +       u8              prio2band[FQ_PRIO2BAND_CRUMB_SIZE];
>         u32             timer_slack; /* hrtimer slack in ns */
> 
>  /* Read/Write fields. */
> @@ -159,7 +161,7 @@ struct fq_sched_data {
>  /* return the i-th 2-bit value ("crumb") */
>  static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
>  {
> -       return (prio2band[prio / 4] >> (2 * (prio & 0x3))) & 0x3;
> +       return (READ_ONCE(prio2band[prio / 4]) >> (2 * (prio & 0x3))) & 0x3;
>  }

Thanks Eric,

assuming that it is ok for this version of fq_prio2band() to run
from fq_enqueue(), this update looks good to me.

> 
>  /*
> @@ -927,11 +929,15 @@ static const struct nla_policy
> fq_policy[TCA_FQ_MAX + 1] = {
>  static void fq_prio2band_compress_crumb(const u8 *in, u8 *out)
>  {
>         const int num_elems = TC_PRIO_MAX + 1;
> +       u8 tmp[FQ_PRIO2BAND_CRUMB_SIZE];
>         int i;
> 
> -       memset(out, 0, num_elems / 4);
> +       memset(tmp, 0, sizeof(tmp));
>         for (i = 0; i < num_elems; i++)
> -               out[i / 4] |= READ_ONCE(in[i]) << (2 * (i & 0x3));
> +               tmp[i / 4] |= in[i] << (2 * (i & 0x3));
> +
> +       for (i = 0; i < FQ_PRIO2BAND_CRUMB_SIZE; i++)
> +               WRITE_ONCE(out[i], tmp[i]);
>  }
> 
>  static void fq_prio2band_decompress_crumb(const u8 *in, u8 *out)
> 

