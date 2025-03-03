Return-Path: <netdev+bounces-171329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1CFA4C8B9
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7FB18843CE
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B8A24BCE8;
	Mon,  3 Mar 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M35Hv3gc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5880222597
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020192; cv=none; b=RvTLKkEVo16AA4Mcx6qBsOYwyS7MQYemQPp2KTZHyai0pantvaQeHPkVD+1JaFONHTdAFIxtzumgbdFcYDEhzMhCtFCPF60q/ve1OfTt5k/dDpiB8SVT9G/OIEzvlwJGm8u/mku7uJi+OnakUr5tbs3Urp27zcFugYbQuGsYFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020192; c=relaxed/simple;
	bh=Ldfa3ICsZqK1MEnOb39e6i3BC9nu1psOSb7s+tzC2hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=craYlkgOs57Uuy9lE124bHwJ+QNqzE6u1kJop9Blgt8qJ5YEE8CxO7lonRWg1BmzJWLjt7YAP0qmmki4CL0fg++Xn0jWgDvWiBFEXS3c61f63umVFiFgPZR46aKRz9ducxBbt0zCWL/XDoaIHr0KhyE5jHfu8K6KgxYIcxl9zpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M35Hv3gc; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86b5515dd5fso1075490241.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 08:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020190; x=1741624990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpiT7OrQ9p1acOYuuauaz9/VW19FEFR2NpErgZa/KJ0=;
        b=M35Hv3gc5bn22rjD5l5KZAmK2dU+FlaO3fZHzkxZE3Ou84pJLXZ3U8vASK6/QeRvLZ
         cVd0nhUtmtWLNOXTHGOX2IQGdZtiHMnO67xlIr1NAXyt4SFGmQEYhSjyHyM8yUdknOkO
         DVm/swB1TfXO/kF2B8k/eZYvPSZ4yC6/eWP3WbwymDr5GkbB99eHXjzfqOH2c+oFl8bj
         p7x7qNf1e70myJ9UfieZT0B4D1sfWUYEVVZCljx3da3Ubxcv5zrwq/IjPPZNAzxcQV10
         zi8sFOjmu3nMfY+HT4pxfW8vBz3I7Cv3YhJ5sFm+QuvPr4zjhBeytChjf+Wfmwl4GYm/
         wnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020190; x=1741624990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpiT7OrQ9p1acOYuuauaz9/VW19FEFR2NpErgZa/KJ0=;
        b=Ldumz+vWv033Bo6baNQeNsO0hZeNA7da8RZtKVoi4cZsSLgDTzgbly8jZ0NFf9itAB
         K825lNvpABxPY2W+gv1Wb7wavncdVGemerDyT2CGxYdsrt2RYOGfAgHSriMV9Z3hgfRx
         arIGlSeVwmR/hnhHRCberuH4H3tRXsdfLJY2eayXF38TLy7y2a3yQuOBoc1U4JFsVBTU
         mHn/gefWP5Qc6N4GBUV+PoQrChbpdtMU7XKuaJKcyCOOuMO7DUt1WWC03LYk2/b3rmnY
         DblU4WRhkzgdjiI1Q3d6IbLtSnegd9GRFgmAem/4YFix5rhpkE7BBV6mAOpFGHhZLsUs
         lWFg==
X-Gm-Message-State: AOJu0Ywlgf6oysBR1gSe6R+QadE7UXBBy2PHzhX0PINJy+qsRz2DANiE
	KSuwb1lIwjB3/YNA6+Wvnr+Ydi++9WLn39FAKHtppKvF8Ph7OmOCsLFyRx80l42Kz1NExEv/dKY
	vdvjW8Z2Y3AV/U6ho9w9Ux0gh1RY=
X-Gm-Gg: ASbGncsL2fFBKrVHourzJrROt8zOouXCkx0Ace60niL0VUcubh7QZx59lwoa3vtR0WO
	3397A2KtJMDTD9Ub762SmqS8/0Wo1CLBN+GXZHDbIp1CIlv5X4fCPvM+1zpeM3/55YFPh0UFJQJ
	7sQHtdKLGykb9G22YWC+xQWyVO
X-Google-Smtp-Source: AGHT+IFJorKCVWiV59srdPl8LGFyUvQsCPfBm57auwC9Y6f8Na27LBlNhR2v/YPJ3ODlXK0DBnBb7VrM/628YEnyuWQ=
X-Received: by 2002:a05:6102:c10:b0:4bb:e8c5:b172 with SMTP id
 ada2fe7eead31-4c044945333mr9393121137.8.1741020189617; Mon, 03 Mar 2025
 08:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
 <2ee4d016-5e57-4d86-9dca-e4685cb183bb@nvidia.com> <CADvbK_ft=B310a9dcwgnwDrPKsxhicKJ4v9wAdgPSHhG+gPjLw@mail.gmail.com>
 <5ab59f2d-1c22-4602-95ab-a247b5bf048e@nvidia.com> <CADvbK_draP9X9OWXEYTKrP0_ekjgNu9PYPp6GUkvu-3L24SRYg@mail.gmail.com>
 <CADvbK_cungrr_D5VAiL8C+FSJEoLFYtMxV5foU0XA9E4zrcegA@mail.gmail.com> <7061a416-56cb-4751-8576-8071c2205d70@nvidia.com>
In-Reply-To: <7061a416-56cb-4751-8576-8071c2205d70@nvidia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 3 Mar 2025 11:42:57 -0500
X-Gm-Features: AQ5f1JpZiFIlT7li9G4na9VfWCEO71AopRs8naFPmrOJcOK8WzC6Kg2LohvhwFI
Message-ID: <CADvbK_faagwC4q0vNEeW7Eu7SZbXuVjULXo3kg7JS16cF+cmig@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label
 counting in conntrack
To: Jianbo Liu <jianbol@nvidia.com>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org, ovs-dev@openvswitch.org, 
	davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>, 
	Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 9:14=E2=80=AFPM Jianbo Liu <jianbol@nvidia.com> wrot=
e:
>
>
>
> On 3/3/2025 2:22 AM, Xin Long wrote:
> > On Tue, Feb 25, 2025 at 9:57=E2=80=AFAM Xin Long <lucien.xin@gmail.com>=
 wrote:
> >>
> >> On Mon, Feb 24, 2025 at 8:38=E2=80=AFPM Jianbo Liu <jianbol@nvidia.com=
> wrote:
> >>>
> >>>
> >>>
> >>> On 2/25/2025 3:55 AM, Xin Long wrote:
> >>>> On Mon, Feb 24, 2025 at 4:01=E2=80=AFAM Jianbo Liu <jianbol@nvidia.c=
om> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 8/13/2024 1:17 AM, Xin Long wrote:
> >>>>>> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-acti=
on
> >>>>>> label counting"), we should also switch to per-action label counti=
ng
> >>>>>> in openvswitch conntrack, as Florian suggested.
> >>>>>>
> >>>>>> The difference is that nf_connlabels_get() is called unconditional=
ly
> >>>>>> when creating an ct action in ovs_ct_copy_action(). As with these
> >>>>>> flows:
> >>>>>>
> >>>>>>      table=3D0,ip,actions=3Dct(commit,table=3D1)
> >>>>>>      table=3D1,ip,actions=3Dct(commit,exec(set_field:0xac->ct_labe=
l),table=3D2)
> >>>>>>
> >>>>>> it needs to make sure the label ext is created in the 1st flow bef=
ore
> >>>>>> the ct is committed in ovs_ct_commit(). Otherwise, the warning in
> >>>>>> nf_ct_ext_add() when creating the label ext in the 2nd flow will
> >>>>>> be triggered:
> >>>>>>
> >>>>>>       WARN_ON(nf_ct_is_confirmed(ct));
> >>>>>>
> >>>>>
> >>>>> Hi Xin Long,
> >>>>>
> >>>>> The ct can be committed before openvswitch handles packets with CT
> >>>>> actions. And we can trigger the warning by creating VF and running =
ping
> >>>>> over it with the following configurations:
> >>>>>
> >>>>> ovs-vsctl add-br br
> >>>>> ovs-vsctl add-port br eth2
> >>>>> ovs-vsctl add-port br eth4
> >>>>> ovs-ofctl add-flow br "table=3D0, in_port=3Deth4,ip,ct_state=3D-trk
> >>>>> actions=3Dct(table=3D1)"
> >>>>> ovs-ofctl add-flow br "table=3D1, in_port=3Deth4,ip,ct_state=3D+trk=
+new
> >>>>> actions=3Dct(exec(set_field:0xef7d->ct_label), commit), output:eth2=
"
> >>>>> ovs-ofctl add-flow br "table=3D1, in_port=3Deth4,ip,ct_label=3D0xef=
7d,
> >>>>> ct_state=3D+trk+est actions=3Doutput:eth2"
> >>>>>
> >>>>> The eth2 is PF, and eth4 is VF's representor.
> >>>>> Would you like to fix it?
> >>>> Hi, Jianbo,
> >>>>
> >>>> Sure, we have to attach a new ct to the skb in __ovs_ct_lookup() for
> >>>> this case, and even delete the one created before ovs_ct.
> >>>>
> >>>> Can you check if this works on your env?
> >>>
> >>> Yes, it works.
> >>> Could you please submit the formal patch? Thanks!
> >> Great, I will post after running some of my local tests.
> >>
> > Hi Jianbo,
> >
> > I recently ran some tests and observed that the current approach cannot
> > completely avoid the warning. If an skb enters __ovs_ct_lookup() withou=
t
> > an attached connection tracking (ct) entry, it may still acquire an
> > existing ct created outside of OVS (possibly by netfilter) through
> > nf_conntrack_in(). This will trigger the warning in ovs_ct_set_labels()=
.
> >
> > Deleting a ct created outside OVS and creating a new one within
> > __ovs_ct_lookup() doesn't seem reasonable and would be difficult to
>
> Yes, I'm also skeptical of your temporary fix, and waiting for your
> formal one.
Cool.

>
> > implement. However, since OVS is not supposed to use ct entries created
> > externally, I believe ct zones can be used to prevent this issue.
> > In your case, the following flows should work:
> >
> > ovs-ofctl add-flow br "table=3D0, in_port=3Deth4,ip,ct_state=3D-trk
> > actions=3Dct(table=3D1,zone=3D1)"
> > ovs-ofctl add-flow br "table=3D1,
> > in_port=3Deth4,ip,ct_state=3D+trk+new,ct_zone=3D1
> > actions=3Dct(exec(set_field:0xef7d->ct_label),commit,zone=3D1),
> > output:eth2"
> > ovs-ofctl add-flow br "table=3D1,
> > in_port=3Deth4,ip,ct_label=3D0xef7d,ct_state=3D+trk+est,ct_zone=3D1
> > actions=3Doutput:eth2"
> >
> > Regarding the warning triggered by externally created ct entries, I pla=
n
> > to remove the ovs_ct_get_conn_labels() call from ovs_ct_set_labels() an=
d
> > I'll let nf_connlabels_replace() return an error in such cases, similar
> > to how tcf_ct_act_set_labels() handles this scenario in tc act_ct.
> >
>
> It's a good idea to be consistent with act_ct implementation. But, would
> you like to revert first if it takes long time to work on the fix?
Sorry, revert which one?
If you mean the fix in skb_nfct_cached(), it hasn't been posted and
will not be posted.

Thanks.
>
> Thanks!
>
> > Thanks.
> >>>
> >>>>
> >>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack=
.c
> >>>> index 3bb4810234aa..c599ee013dfe 100644
> >>>> --- a/net/openvswitch/conntrack.c
> >>>> +++ b/net/openvswitch/conntrack.c
> >>>> @@ -595,6 +595,11 @@ static bool skb_nfct_cached(struct net *net,
> >>>>                rcu_dereference(timeout_ext->timeout))
> >>>>                return false;
> >>>>        }
> >>>> +    if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) && !nf_ct_labels_fin=
d(ct)) {
> >>>> +        if (nf_ct_is_confirmed(ct))
> >>>> +            nf_ct_delete(ct, 0, 0);
> >>>> +        return false;
> >>>> +    }
> >>>>
> >>>> Thanks.
> >>>>
> >>>>>
> >>>>> Thanks!
> >>>>> Jianbo
> >>>>>
> >>>>>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> >>>>>> ---
> >>>>>> v2: move ovs_net into #if in ovs_ct_exit() as Jakub noticed.
> >>>>>> ---
> >>>>>>     net/openvswitch/conntrack.c | 30 ++++++++++++-----------------=
-
> >>>>>>     net/openvswitch/datapath.h  |  3 ---
> >>>>>>     2 files changed, 12 insertions(+), 21 deletions(-)
> >>>>>>
> >>>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntra=
ck.c
> >>>>>> index 8eb1d644b741..a3da5ee34f92 100644
> >>>>>> --- a/net/openvswitch/conntrack.c
> >>>>>> +++ b/net/openvswitch/conntrack.c
> >>>>>> @@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum ov=
s_key_attr attr)
> >>>>>>             attr =3D=3D OVS_KEY_ATTR_CT_MARK)
> >>>>>>                 return true;
> >>>>>>         if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
> >>>>>> -         attr =3D=3D OVS_KEY_ATTR_CT_LABELS) {
> >>>>>> -             struct ovs_net *ovs_net =3D net_generic(net, ovs_net=
_id);
> >>>>>> -
> >>>>>> -             return ovs_net->xt_label;
> >>>>>> -     }
> >>>>>> +         attr =3D=3D OVS_KEY_ATTR_CT_LABELS)
> >>>>>> +             return true;
> >>>>>>
> >>>>>>         return false;
> >>>>>>     }
> >>>>>> @@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, cons=
t struct nlattr *attr,
> >>>>>>                        const struct sw_flow_key *key,
> >>>>>>                        struct sw_flow_actions **sfa,  bool log)
> >>>>>>     {
> >>>>>> +     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) * B=
ITS_PER_BYTE;
> >>>>>>         struct ovs_conntrack_info ct_info;
> >>>>>>         const char *helper =3D NULL;
> >>>>>>         u16 family;
> >>>>>> @@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, con=
st struct nlattr *attr,
> >>>>>>                 return -ENOMEM;
> >>>>>>         }
> >>>>>>
> >>>>>> +     if (nf_connlabels_get(net, n_bits - 1)) {
> >>>>>> +             nf_ct_tmpl_free(ct_info.ct);
> >>>>>> +             OVS_NLERR(log, "Failed to set connlabel length");
> >>>>>> +             return -EOPNOTSUPP;
> >>>>>> +     }
> >>>>>> +
> >>>>>>         if (ct_info.timeout[0]) {
> >>>>>>                 if (nf_ct_set_timeout(net, ct_info.ct, family, key=
->ip.proto,
> >>>>>>                                       ct_info.timeout))
> >>>>>> @@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ovs_=
conntrack_info *ct_info)
> >>>>>>         if (ct_info->ct) {
> >>>>>>                 if (ct_info->timeout[0])
> >>>>>>                         nf_ct_destroy_timeout(ct_info->ct);
> >>>>>> +             nf_connlabels_put(nf_ct_net(ct_info->ct));
> >>>>>>                 nf_ct_tmpl_free(ct_info->ct);
> >>>>>>         }
> >>>>>>     }
> >>>>>> @@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_family =
__ro_after_init =3D {
> >>>>>>
> >>>>>>     int ovs_ct_init(struct net *net)
> >>>>>>     {
> >>>>>> -     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) * B=
ITS_PER_BYTE;
> >>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>         struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> >>>>>>
> >>>>>> -     if (nf_connlabels_get(net, n_bits - 1)) {
> >>>>>> -             ovs_net->xt_label =3D false;
> >>>>>> -             OVS_NLERR(true, "Failed to set connlabel length");
> >>>>>> -     } else {
> >>>>>> -             ovs_net->xt_label =3D true;
> >>>>>> -     }
> >>>>>> -
> >>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>         return ovs_ct_limit_init(net, ovs_net);
> >>>>>>     #else
> >>>>>>         return 0;
> >>>>>> @@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
> >>>>>>
> >>>>>>     void ovs_ct_exit(struct net *net)
> >>>>>>     {
> >>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>         struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> >>>>>>
> >>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>         ovs_ct_limit_exit(net, ovs_net);
> >>>>>>     #endif
> >>>>>> -
> >>>>>> -     if (ovs_net->xt_label)
> >>>>>> -             nf_connlabels_put(net);
> >>>>>>     }
> >>>>>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath=
.h
> >>>>>> index 9ca6231ea647..365b9bb7f546 100644
> >>>>>> --- a/net/openvswitch/datapath.h
> >>>>>> +++ b/net/openvswitch/datapath.h
> >>>>>> @@ -160,9 +160,6 @@ struct ovs_net {
> >>>>>>     #if IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>         struct ovs_ct_limit_info *ct_limit_info;
> >>>>>>     #endif
> >>>>>> -
> >>>>>> -     /* Module reference for configuring conntrack. */
> >>>>>> -     bool xt_label;
> >>>>>>     };
> >>>>>>
> >>>>>>     /**
> >>>>>
> >>>
>

