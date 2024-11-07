Return-Path: <netdev+bounces-142872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930EF9C085E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 15:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EAF1F241DD
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE77F200132;
	Thu,  7 Nov 2024 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxMof3HT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E220EA3A
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988274; cv=none; b=iwfKBhSmKR96EYaUmW/vVs5OaFqQXqN0G2UjE+teTX07XhdY0a8V3lizKoA2ay83tU8OoYp/k7jR9QFUk2ln3jkXTO5xJRi/O8yEpdOqiL5dR65vRjI1CC1vNxUljBwI2OBQ8XeZqzpSUmm0aZwtAnmUainHok9qi89z2vR+Bk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988274; c=relaxed/simple;
	bh=C7NhaOom9/WsjUcH4wqoeXZTRQ3idpOsoCb2z/IBJgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYpfhaLKFsgZq7Veos33QND7YkDLDfV4QVpRNvZKgLYfkOyJIk8Xvf8iRqc/xgSXXRnnu57ELW80GDJe889jphnGJKTmuIjsiEQ2BUOfk8c2rCG4wvX94CCQ4eNEeEBbi7pJ6OTEm2ywmfwaceXrDJoLzomyAdFxapXGixBrqmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxMof3HT; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e607556c83so617796b6e.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 06:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730988272; x=1731593072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53j9ED75IGQgVRkvuqlQyL+C8W0jmLRjv9pQW7cB3N8=;
        b=FxMof3HT3OGdZonPRuxVI8/RcShg+oXNyHS3jIf9LrWJiOF8b90CBOUFixGzILaFIm
         K6MgDcd/KYNAqmNH8zpuS+6fSSOh+yY5Eayd/m/2wUiOFOdPaAZiePYZWsP6cgtSPHj3
         AsM6aiiNGMC9TfeDVQfftrJt/MUbrhzRSN/uDYaCYk/ZwZTnKNWMgJ2EUIrUN3Fa8XYl
         oPTmLqFTo5fZwLLuaNPeZsJSjtLDHN2Q/QQPLsQp7siJoaVfnsfG2iSaRFVL4Zhu7N0D
         fUo+/Y59QnaCEBzo9TRzkx0wycEPRl2aRlsEM6iiDcLXvWQIHwVT8Yy/OaJNmsMycFae
         eabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730988272; x=1731593072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53j9ED75IGQgVRkvuqlQyL+C8W0jmLRjv9pQW7cB3N8=;
        b=bG3p7yddWIbee9rEdORxWlkdSbLILBeLOA9f8nihtSFmydTBrD+qcBLReUWKJeBTU8
         mHvIjICmtVvYgGRDl29USMnjJBzbmV3e4uzJV8HMBcl/G1vJ7UWaR3auQDehFVq4zBmx
         DIz+qjsdekRUwX3lhn8EZN5b14zltgE1LrYqwyXoKdIUuuHop4cTE6nu7MMsxpcXAJxV
         ajAmCZcOb4qXTSIv7otva7qTue4oSEOVPCaJ+h3x31wgOCDMGD7RyyO/26dQmFJBbmVW
         t2ZAj2/j2328IGscpNYTQIgw8daaZFmzCKOsloiRKItKzruTWEdTPokLjbGE6gNlMVTi
         acJA==
X-Forwarded-Encrypted: i=1; AJvYcCV+by+4sN2GU5UEQeaOfsjRnGa/GpxLS/v1jBm8T3LTT2gatD22ayDlxOki74x4jMTAVrQffSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdpKxKf77co2Rz054OaUeVTIdQ5b4m+pk0WDr8++aq4rfGcofd
	TdzSQMhGZNr7fOEgYSpyFHqVXnYttVvGVKUNSDaxiSW2+Pb+RtzopBvU5s9CGh+XVdmL1XtzeNb
	aX1hWktHkzRomzWLyQhjjfAQlRInuwRrCdUx6
X-Google-Smtp-Source: AGHT+IGjMuvxYCpr+1bWUklI+YdHHi8Gei70pt9TxFi4MzxonrgpbIAok1BF5FB5/ntACaSjtavTJFWOdeuKac96C8Q=
X-Received: by 2002:a05:6808:2383:b0:3e5:e72e:17c8 with SMTP id
 5614622812f47-3e63845af51mr41657163b6e.21.1730988271998; Thu, 07 Nov 2024
 06:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-ipmr_rcu-v1-1-ad0cba8dffed@debian.org>
 <CANn89iL-L8iBwp=rq-YwAeeoUY2MTjr5akWm=S=k7ckpkaEy+Q@mail.gmail.com> <20241107-invisible-skylark-of-attack-e44be1@leitao>
In-Reply-To: <20241107-invisible-skylark-of-attack-e44be1@leitao>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 15:04:19 +0100
Message-ID: <CANn89i+kYM_QRsqGXfbw-nzTe5K=sbVW3G+Nb2pCW3so5Tr-7w@mail.gmail.com>
Subject: Re: [PATCH net] ipmr: Fix access to mfc_cache_list without lock held
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 2:51=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> Hello Eric,
>
> On Thu, Nov 07, 2024 at 02:13:14PM +0100, Eric Dumazet wrote:
> > On Thu, Nov 7, 2024 at 12:03=E2=80=AFPM Breno Leitao <leitao@debian.org=
> wrote:
> > >
> > > Accessing `mr_table->mfc_cache_list` is protected by an RCU lock. In =
the
> > > following code flow, the lock is not held, causing the following erro=
r
> > > when `RCU_PROVE` is not held.
> > >
> > >         6.12.0-rc5-kbuilder-01145-gbac17284bdcb #33 Tainted: G       =
     E    N
> > >         -----------------------------
> > >         net/ipv4/ipmr_base.c:313 RCU-list traversed in non-reader sec=
tion!!
> > >
> > >         rcu_scheduler_active =3D 2, debug_locks =3D 1
> > >                    2 locks held by RetransmitAggre/3519:
> > >                     #0: ffff88816188c6c0 (nlk_cb_mutex-ROUTE){+.+.}-{=
3:3}, at: __netlink_dump_start+0x8a/0x290
> > >                     #1: ffffffff83fcf7a8 (rtnl_mutex){+.+.}-{3:3}, at=
: rtnl_dumpit+0x6b/0x90
> > >
> > >         stack backtrace:
> > >                     lockdep_rcu_suspicious
> > >                     mr_table_dump
> > >                     ipmr_rtm_dumproute
> > >                     rtnl_dump_all
> > >                     rtnl_dumpit
> > >                     netlink_dump
> > >                     __netlink_dump_start
> > >                     rtnetlink_rcv_msg
> > >                     netlink_rcv_skb
> > >                     netlink_unicast
> > >                     netlink_sendmsg
> > >
> > > Fix accessing `mfc_cache_list` without holding the RCU read lock. Add=
s
> > > `rcu_read_lock()` and `rcu_read_unlock()` around `mr_table_dump()` to
> > > prevent RCU-list traversal in non-reader section.
> > >
> > > Since `mr_table_dump()` is the only function that touches the list, t=
hat
> > > might be the only critical section in `ipmr_rtm_dumproute()` that nee=
ds
> > > to be protected in ipmr_rtm_dumproute().
> > >
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > Fixes: cb167893f41e ("net: Plumb support for filtering ipv4 and ipv6 =
multicast route dumps")
> > > ---
> > >  net/ipv4/ipmr.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> > > index 089864c6a35eec146a1ba90c22d79245f8e48158..bb855f32f328024f384a2=
fa58f42fc227705206e 100644
> > > --- a/net/ipv4/ipmr.c
> > > +++ b/net/ipv4/ipmr.c
> > > @@ -2612,8 +2612,10 @@ static int ipmr_rtm_dumproute(struct sk_buff *=
skb, struct netlink_callback *cb)
> > >                         NL_SET_ERR_MSG(cb->extack, "ipv4: MR table do=
es not exist");
> > >                         return -ENOENT;
> > >                 }
> > > +               rcu_read_lock();
> > >                 err =3D mr_table_dump(mrt, skb, cb, _ipmr_fill_mroute=
,
> > >                                     &mfc_unres_lock, &filter);
> > > +               rcu_read_unlock();
> > >                 return skb->len ? : err;
> > >         }
> > >
> > >
> >
> > What about net/ipv6/ip6mr.c ip6mr_rtm_dumproute() ?
>
> That one might require as well.
>
> > In my opinion, since we still hold RTNL in these paths, we should
> > change the lockdep annotation.
>
> I don't have much experience mixing locks like this. Is it safe to mix
> and match rtnl and RCUs like this?

If holding RTNL is preventing any updates, then surely holding RTNL is enou=
gh
to iterate through the list.



>
> I have the impression that, when iterating a RCU protected list *without*=
 being in the read-side
> critical sections, the RCU doesn't know that someone might be traversing
> the list, and remove the element mid air (mroute_clean_tables()?). Is
> this model incorrect?
>
> > Then later we can remove RTNL from these dump operations.
>
> Do you mean that, execute the dump operation without holding the RTNL,
> thus, relying solely on RCU?

Right, you might have seen patches adding RTNL_FLAG_DUMP_UNLOCKED in
some places ?

More patches are welcomed, in net-next.

>
> > diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
> > index 271dc03fc6dbd9b35db4d5782716679134f225e4..f0af12a2f70bcdf5ba54321=
bf7ebebe798318abb
> > 100644
> > --- a/net/ipv4/ipmr_base.c
> > +++ b/net/ipv4/ipmr_base.c
> > @@ -310,7 +310,8 @@ int mr_table_dump(struct mr_table *mrt, struct sk_b=
uff *skb,
> >         if (filter->filter_set)
> >                 flags |=3D NLM_F_DUMP_FILTERED;
> >
> > -       list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list) {
> > +       list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list,
> > +                               lockdep_rtnl_is_held()) {
> >                 if (e < s_e)
> >                         goto next_entry;
> >                 if (filter->dev &&
>
> Clarifying next steps: Would you like me to review/test and submit, or
> are you planning to send it officially?

For this kind of feedback, I am usually expecting you to send a new
version (after waiting one day,
maybe other reviewers have something to say)

Thank you.

