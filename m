Return-Path: <netdev+bounces-171037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD4CA4B406
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 19:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F02D3AEA52
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3501E8335;
	Sun,  2 Mar 2025 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTzqeHP4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362718BBA8
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740939793; cv=none; b=nrwywDmhlRxyu/Xeg9wY7uIU7wBWJna13T2eQem19p9sa9k7E4/1EnyIEMWizqIvVSjEvQsT5VUbrYPEZ7cknXJ2hiUmZrRsIn+X8CSJdZQILNXlvecCeA0vjOIvB3bVffkUX7XMMX9HzvEvrH2VSCYk//Iizc9s+782EvQswPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740939793; c=relaxed/simple;
	bh=UTrbLx+LoTWsWuj6WqIQK0IPA3ahYlDY50R9B6MdCrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCHuBT+OsreNk7WULR63nS2KBk7rQRtbEY3pKR0Ww/4J2foul7AHD284HW0JiYsK/5+y601GnJBa8eAbd5AXkIr4XKdAtU5KdC82LOG6cbsbNFCjur87x27OIBC8J8ZWczdQYivHbPAtJQbEKdEV9g+zRuRhVULHrTLnCMnr0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTzqeHP4; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso16949485ab.1
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 10:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740939791; x=1741544591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riVfNGI/i6ij/5MQndHuw2T5/hTSpdpTuOi4JRYVt8k=;
        b=GTzqeHP4AldMuTM5ioenqjuMflPAA7xUh4wKuZlR0BatPL8bxKlaccVa73vNQdzlpw
         I2g+pgaYr2u0c0/IwdHkmTLu80+qmgOPIYnqfxoFaE/9xPPvQ7dlyd4LivYccyCkjjQc
         23HH3YKx9I02w2n21tAmQIyFro97FKdq8V03sssKqfbutDlXiUkb75kl7E6v7xVU7er4
         ZvvFXYO1JBTYO7ZAMEknPJLx4zC6ngxnz8eYCls8vSy9/bJKvGa9hLwLkLX6SA1BSOB6
         AAbj040YxxWp3Ok+j3/X+qG9Ln5Vz5LWw/8QofWbAEYiPuuyOe1nsS72/1897iJ/rnNe
         fe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740939791; x=1741544591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riVfNGI/i6ij/5MQndHuw2T5/hTSpdpTuOi4JRYVt8k=;
        b=PDEua6vbM0ZLxGPH3H6olMUebjCZu+mh1IZv2BY75CD8J8P0E2Q35VfC/L7Ze3qgxj
         0DluVZimUVphOcRa5T0LXXjxrL3JJLqK3bwVMShCcZnbfXhkHm/jg+lndGMbOrkjC3iy
         aGwUVQg8wfambCd7iiaKWXlItBAJUCYR4VOQDK2wEWjtXQH5rRqWnX1i/PcMhNYaobZP
         Prsb+/w3mTX+YmQweMwf0bXfNdO8TbX5/Ufx0QGKPxZt4+SXZbwRmIUOeDs3IghUAT6C
         RgbxHqyhhOdanfhKKtplVIUHpVJZL+y3fMUEW8badENoA9JEQUPVSVpF2ZYgevf5dOnP
         292w==
X-Gm-Message-State: AOJu0YxfKq81joFbvkNY4VXS++4POXHX2DkzAwXLqECI2UG9Sz0DV1kn
	uC9SwBWTXg38Lg/82hWblpuLY6jtDKL4PIbO4gIwYYqMm0EUIjh3Lh3ItZcs2zxM7BBjNfGiEPW
	5EvMUWgogzXFyxCtDnJeCzniQe6k=
X-Gm-Gg: ASbGncs5o5tuZxBhS91jGln8sMJW9RfEAirwKkf1RGylJaTBWyC/n/P3xWby4tb8Sc1
	G1qB6/Bx3zt9KOlueb12/bcE1JNhHRem307aK1cQOCP/pyO1KPZXYbocT9MoaGpCxifFWEicL5m
	wMZn08phj54CFePFTYNYrnYDvEqFDh
X-Google-Smtp-Source: AGHT+IFoeYTmrakGFfV5F4ECiAcggvxdM/6XUk1tZmTBWzkT0PRR2xVL/dXfnXj8TZ+Hn9KGzwHiWu+R6GXG5c4nh5g=
X-Received: by 2002:a05:6e02:548:b0:3d3:f4fc:a292 with SMTP id
 e9e14a558f8ab-3d3f4fca3bdmr54728625ab.12.1740939790754; Sun, 02 Mar 2025
 10:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
 <2ee4d016-5e57-4d86-9dca-e4685cb183bb@nvidia.com> <CADvbK_ft=B310a9dcwgnwDrPKsxhicKJ4v9wAdgPSHhG+gPjLw@mail.gmail.com>
 <5ab59f2d-1c22-4602-95ab-a247b5bf048e@nvidia.com> <CADvbK_draP9X9OWXEYTKrP0_ekjgNu9PYPp6GUkvu-3L24SRYg@mail.gmail.com>
In-Reply-To: <CADvbK_draP9X9OWXEYTKrP0_ekjgNu9PYPp6GUkvu-3L24SRYg@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 2 Mar 2025 13:22:59 -0500
X-Gm-Features: AQ5f1Jpnnjcn0RLcLqukh1d452pDX_Pv5lsrZ-rRRemcW2DRl-xUCbJtT7jf3RA
Message-ID: <CADvbK_cungrr_D5VAiL8C+FSJEoLFYtMxV5foU0XA9E4zrcegA@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label
 counting in conntrack
To: Jianbo Liu <jianbol@nvidia.com>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org, ovs-dev@openvswitch.org, 
	davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>, 
	Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 9:57=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Mon, Feb 24, 2025 at 8:38=E2=80=AFPM Jianbo Liu <jianbol@nvidia.com> w=
rote:
> >
> >
> >
> > On 2/25/2025 3:55 AM, Xin Long wrote:
> > > On Mon, Feb 24, 2025 at 4:01=E2=80=AFAM Jianbo Liu <jianbol@nvidia.co=
m> wrote:
> > >>
> > >>
> > >>
> > >> On 8/13/2024 1:17 AM, Xin Long wrote:
> > >>> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-actio=
n
> > >>> label counting"), we should also switch to per-action label countin=
g
> > >>> in openvswitch conntrack, as Florian suggested.
> > >>>
> > >>> The difference is that nf_connlabels_get() is called unconditionall=
y
> > >>> when creating an ct action in ovs_ct_copy_action(). As with these
> > >>> flows:
> > >>>
> > >>>     table=3D0,ip,actions=3Dct(commit,table=3D1)
> > >>>     table=3D1,ip,actions=3Dct(commit,exec(set_field:0xac->ct_label)=
,table=3D2)
> > >>>
> > >>> it needs to make sure the label ext is created in the 1st flow befo=
re
> > >>> the ct is committed in ovs_ct_commit(). Otherwise, the warning in
> > >>> nf_ct_ext_add() when creating the label ext in the 2nd flow will
> > >>> be triggered:
> > >>>
> > >>>      WARN_ON(nf_ct_is_confirmed(ct));
> > >>>
> > >>
> > >> Hi Xin Long,
> > >>
> > >> The ct can be committed before openvswitch handles packets with CT
> > >> actions. And we can trigger the warning by creating VF and running p=
ing
> > >> over it with the following configurations:
> > >>
> > >> ovs-vsctl add-br br
> > >> ovs-vsctl add-port br eth2
> > >> ovs-vsctl add-port br eth4
> > >> ovs-ofctl add-flow br "table=3D0, in_port=3Deth4,ip,ct_state=3D-trk
> > >> actions=3Dct(table=3D1)"
> > >> ovs-ofctl add-flow br "table=3D1, in_port=3Deth4,ip,ct_state=3D+trk+=
new
> > >> actions=3Dct(exec(set_field:0xef7d->ct_label), commit), output:eth2"
> > >> ovs-ofctl add-flow br "table=3D1, in_port=3Deth4,ip,ct_label=3D0xef7=
d,
> > >> ct_state=3D+trk+est actions=3Doutput:eth2"
> > >>
> > >> The eth2 is PF, and eth4 is VF's representor.
> > >> Would you like to fix it?
> > > Hi, Jianbo,
> > >
> > > Sure, we have to attach a new ct to the skb in __ovs_ct_lookup() for
> > > this case, and even delete the one created before ovs_ct.
> > >
> > > Can you check if this works on your env?
> >
> > Yes, it works.
> > Could you please submit the formal patch? Thanks!
> Great, I will post after running some of my local tests.
>
Hi Jianbo,

I recently ran some tests and observed that the current approach cannot
completely avoid the warning. If an skb enters __ovs_ct_lookup() without
an attached connection tracking (ct) entry, it may still acquire an
existing ct created outside of OVS (possibly by netfilter) through
nf_conntrack_in(). This will trigger the warning in ovs_ct_set_labels().

Deleting a ct created outside OVS and creating a new one within
__ovs_ct_lookup() doesn't seem reasonable and would be difficult to
implement. However, since OVS is not supposed to use ct entries created
externally, I believe ct zones can be used to prevent this issue.
In your case, the following flows should work:

ovs-ofctl add-flow br "table=3D0, in_port=3Deth4,ip,ct_state=3D-trk
actions=3Dct(table=3D1,zone=3D1)"
ovs-ofctl add-flow br "table=3D1,
in_port=3Deth4,ip,ct_state=3D+trk+new,ct_zone=3D1
actions=3Dct(exec(set_field:0xef7d->ct_label),commit,zone=3D1),
output:eth2"
ovs-ofctl add-flow br "table=3D1,
in_port=3Deth4,ip,ct_label=3D0xef7d,ct_state=3D+trk+est,ct_zone=3D1
actions=3Doutput:eth2"

Regarding the warning triggered by externally created ct entries, I plan
to remove the ovs_ct_get_conn_labels() call from ovs_ct_set_labels() and
I'll let nf_connlabels_replace() return an error in such cases, similar
to how tcf_ct_act_set_labels() handles this scenario in tc act_ct.

Thanks.
> >
> > >
> > > diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.=
c
> > > index 3bb4810234aa..c599ee013dfe 100644
> > > --- a/net/openvswitch/conntrack.c
> > > +++ b/net/openvswitch/conntrack.c
> > > @@ -595,6 +595,11 @@ static bool skb_nfct_cached(struct net *net,
> > >               rcu_dereference(timeout_ext->timeout))
> > >               return false;
> > >       }
> > > +    if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) && !nf_ct_labels_find=
(ct)) {
> > > +        if (nf_ct_is_confirmed(ct))
> > > +            nf_ct_delete(ct, 0, 0);
> > > +        return false;
> > > +    }
> > >
> > > Thanks.
> > >
> > >>
> > >> Thanks!
> > >> Jianbo
> > >>
> > >>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > >>> ---
> > >>> v2: move ovs_net into #if in ovs_ct_exit() as Jakub noticed.
> > >>> ---
> > >>>    net/openvswitch/conntrack.c | 30 ++++++++++++------------------
> > >>>    net/openvswitch/datapath.h  |  3 ---
> > >>>    2 files changed, 12 insertions(+), 21 deletions(-)
> > >>>
> > >>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrac=
k.c
> > >>> index 8eb1d644b741..a3da5ee34f92 100644
> > >>> --- a/net/openvswitch/conntrack.c
> > >>> +++ b/net/openvswitch/conntrack.c
> > >>> @@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum ovs=
_key_attr attr)
> > >>>            attr =3D=3D OVS_KEY_ATTR_CT_MARK)
> > >>>                return true;
> > >>>        if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
> > >>> -         attr =3D=3D OVS_KEY_ATTR_CT_LABELS) {
> > >>> -             struct ovs_net *ovs_net =3D net_generic(net, ovs_net_=
id);
> > >>> -
> > >>> -             return ovs_net->xt_label;
> > >>> -     }
> > >>> +         attr =3D=3D OVS_KEY_ATTR_CT_LABELS)
> > >>> +             return true;
> > >>>
> > >>>        return false;
> > >>>    }
> > >>> @@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, const=
 struct nlattr *attr,
> > >>>                       const struct sw_flow_key *key,
> > >>>                       struct sw_flow_actions **sfa,  bool log)
> > >>>    {
> > >>> +     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) * BI=
TS_PER_BYTE;
> > >>>        struct ovs_conntrack_info ct_info;
> > >>>        const char *helper =3D NULL;
> > >>>        u16 family;
> > >>> @@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, cons=
t struct nlattr *attr,
> > >>>                return -ENOMEM;
> > >>>        }
> > >>>
> > >>> +     if (nf_connlabels_get(net, n_bits - 1)) {
> > >>> +             nf_ct_tmpl_free(ct_info.ct);
> > >>> +             OVS_NLERR(log, "Failed to set connlabel length");
> > >>> +             return -EOPNOTSUPP;
> > >>> +     }
> > >>> +
> > >>>        if (ct_info.timeout[0]) {
> > >>>                if (nf_ct_set_timeout(net, ct_info.ct, family, key->=
ip.proto,
> > >>>                                      ct_info.timeout))
> > >>> @@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ovs_c=
onntrack_info *ct_info)
> > >>>        if (ct_info->ct) {
> > >>>                if (ct_info->timeout[0])
> > >>>                        nf_ct_destroy_timeout(ct_info->ct);
> > >>> +             nf_connlabels_put(nf_ct_net(ct_info->ct));
> > >>>                nf_ct_tmpl_free(ct_info->ct);
> > >>>        }
> > >>>    }
> > >>> @@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_family _=
_ro_after_init =3D {
> > >>>
> > >>>    int ovs_ct_init(struct net *net)
> > >>>    {
> > >>> -     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) * BI=
TS_PER_BYTE;
> > >>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> > >>>        struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> > >>>
> > >>> -     if (nf_connlabels_get(net, n_bits - 1)) {
> > >>> -             ovs_net->xt_label =3D false;
> > >>> -             OVS_NLERR(true, "Failed to set connlabel length");
> > >>> -     } else {
> > >>> -             ovs_net->xt_label =3D true;
> > >>> -     }
> > >>> -
> > >>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> > >>>        return ovs_ct_limit_init(net, ovs_net);
> > >>>    #else
> > >>>        return 0;
> > >>> @@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
> > >>>
> > >>>    void ovs_ct_exit(struct net *net)
> > >>>    {
> > >>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> > >>>        struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> > >>>
> > >>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> > >>>        ovs_ct_limit_exit(net, ovs_net);
> > >>>    #endif
> > >>> -
> > >>> -     if (ovs_net->xt_label)
> > >>> -             nf_connlabels_put(net);
> > >>>    }
> > >>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.=
h
> > >>> index 9ca6231ea647..365b9bb7f546 100644
> > >>> --- a/net/openvswitch/datapath.h
> > >>> +++ b/net/openvswitch/datapath.h
> > >>> @@ -160,9 +160,6 @@ struct ovs_net {
> > >>>    #if IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> > >>>        struct ovs_ct_limit_info *ct_limit_info;
> > >>>    #endif
> > >>> -
> > >>> -     /* Module reference for configuring conntrack. */
> > >>> -     bool xt_label;
> > >>>    };
> > >>>
> > >>>    /**
> > >>
> >

