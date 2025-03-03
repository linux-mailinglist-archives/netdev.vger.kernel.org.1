Return-Path: <netdev+bounces-171328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAE5A4C89F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68A3166CB1
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E1823F299;
	Mon,  3 Mar 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGJsYtgF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D021B9D6
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019925; cv=none; b=Ef8eNgwTi/XEMLWzVpqRIQJtoauBUHG0xlaYUpbj47KaHL6W7m+DQvWEtmfvF9cGbplEH9qlUbYLRtRFPHzWEXB9gaD+YZ1+jx7B3rOWWGlB0xI6HkucNH11y5gYyCUlxSPY8IsFGcQpFYHoZW5N7JCG5WgojsFpgQ7SWZrsavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019925; c=relaxed/simple;
	bh=COQ1lzw4kiMfm8ReZiT9YP+kROTglMlMasuTLt8RzdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNblUGauiN+J7qJlIMjYjtBo14x6ozIww+ytp1HGn+TMSYFW5HsBGMPerpncniPWzigPqoXZPmwURQHJVNxk+9dYPxR+vAC1ipX5lv4aWDD8oidmB21ML/cvFCKHAXkG6bEsbVDtvhPiRgvF6ROJNqi2U9xgBlLgNDAwzfsFA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGJsYtgF; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86b31db3c3bso1838414241.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741019923; x=1741624723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TXhUDMRUTonTzQv/+Ca+o7z/lT0HMjz2fmwnta25tg=;
        b=lGJsYtgFsCL5mreNi+UWvWtkzTi4G4kD4LvLMvsGkuwFDKMlTUBOqPQGaR9Ibt5Yvh
         xLiS3xCtv6MK0GDpu5FSSApGU6Jx8qv2QRDbKdptwtWeKja4wGgiUJxM1H47zdo247Ei
         p/VnnnV0IITzbZ7TV+7+buC5II2GKn3sALrDRetb0nXQSqyygi/oMvhreeloOxicvpS3
         NF26Sencj7aSvfQ9CIIYUuCmgC3CK/cV9Ui1UfUlUzkiJ65qF06BRi9lhft2JEDapI9x
         1tRY1kM0mWgIfQ9imQPOPD0esLqp0bpgIHlfsK4cT3wLhQx4n8i+o9y0GOGgD7WygbY+
         xlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019923; x=1741624723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TXhUDMRUTonTzQv/+Ca+o7z/lT0HMjz2fmwnta25tg=;
        b=t0VWZSRZZx7wsV5F0Y/Gv0jRKq9tzS/jAWfqPXJ8l0sGelYZ7C3wLl+DserJTA4V9o
         +KygMI2xQTR8h3h9Kh/5PcFVFAT9u6UPlnFEyIaExHNkegDbot3orx835Jn+hUcyhIeo
         nCxqVqeKIMwKCqH2Wwm4quBqKJzWxsEUI9dK0P2JuAi6wWzKYeOLw8TB6LM1xI5ct9fU
         hYU8tQOxyWtzeydcfWr3RR6ar6uN9qKAP3FZ7xR3sksqIfMgQhnVafHZOUGzXHgagMl1
         dtj6ztoiWYLYg/6qGnJEAyLB2GDhkjKEXY/7vopdXoEX+MLH/GSoMzUMtpa/c+LslnP+
         osbA==
X-Forwarded-Encrypted: i=1; AJvYcCXPXWbkuz/oLMICpVmWQftR7pRl8AEhoWOVEDedZuGfX/mjfOiqS5qceTM7NDUfLgjuorI2nAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDqFajZkiuwun6y1Sik4oU8KT4AYQ37R9hb8dbuPJRXXiOEX2
	/F+hQUmTawFSdB32HW8XglNUUrF87Th+K3A4bdhgk2z4MO1uBj/flM7MSxyHKfGVibnqiFOvewg
	O382Q7buUhyOp364StT2PH0X7SzA=
X-Gm-Gg: ASbGncv+S5FYy4rK54cKv1kcylMRY4rM7ZRSiBcuUHFrjUdfS3Xds8N/TDm7bNJ5rem
	UudZXaiRBrbwUCu33vVZ+55x9zR+5ButT3PCKhQoONiRsqFXXPRYIct56wPJmyMJ15vLQSpZf5R
	OYyiu33NYT8ANC0NoueRUScH0r
X-Google-Smtp-Source: AGHT+IGbpGdvs/goGhPVVf3xCPQPZ8Cle+IorJ+j+josLE88oFBOm3B6q1SagoV0UyScCYTyJ3Bh6nBQOcP2BS80S8A=
X-Received: by 2002:a05:6102:3f01:b0:4bb:cdc0:5dd7 with SMTP id
 ada2fe7eead31-4c044ee0009mr7928957137.16.1741019922748; Mon, 03 Mar 2025
 08:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
 <2ee4d016-5e57-4d86-9dca-e4685cb183bb@nvidia.com> <CADvbK_ft=B310a9dcwgnwDrPKsxhicKJ4v9wAdgPSHhG+gPjLw@mail.gmail.com>
 <5ab59f2d-1c22-4602-95ab-a247b5bf048e@nvidia.com> <CADvbK_draP9X9OWXEYTKrP0_ekjgNu9PYPp6GUkvu-3L24SRYg@mail.gmail.com>
 <CADvbK_cungrr_D5VAiL8C+FSJEoLFYtMxV5foU0XA9E4zrcegA@mail.gmail.com> <2400a58c-5f1d-4fe1-a2db-4c7207613b39@ovn.org>
In-Reply-To: <2400a58c-5f1d-4fe1-a2db-4c7207613b39@ovn.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 3 Mar 2025 11:38:30 -0500
X-Gm-Features: AQ5f1JrR8_UQ7dNopJz59KmfM6_WKgzEe6bpcE1POmEumMmw8pX0Y8VDszkae4w
Message-ID: <CADvbK_d+XrwV_mSQCgGE+vrrOmt373Gx6QN+uZOf_CbafVOyuA@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label
 counting in conntrack
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jianbo Liu <jianbol@nvidia.com>, network dev <netdev@vger.kernel.org>, dev@openvswitch.org, 
	ovs-dev@openvswitch.org, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:56=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org> w=
rote:
>
> On 3/2/25 19:22, Xin Long wrote:
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
> >>>>>>     table=3D0,ip,actions=3Dct(commit,table=3D1)
> >>>>>>     table=3D1,ip,actions=3Dct(commit,exec(set_field:0xac->ct_label=
),table=3D2)
> >>>>>>
> >>>>>> it needs to make sure the label ext is created in the 1st flow bef=
ore
> >>>>>> the ct is committed in ovs_ct_commit(). Otherwise, the warning in
> >>>>>> nf_ct_ext_add() when creating the label ext in the 2nd flow will
> >>>>>> be triggered:
> >>>>>>
> >>>>>>      WARN_ON(nf_ct_is_confirmed(ct));
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
> > implement. However, since OVS is not supposed to use ct entries created
> > externally,
>
> I'm not fully following this conversation, but this statement doesn't
> seem right.  OVS should be able to use ct entries created externally.
> i.e. if the packet already has some ct entry attached while entering
> OVS datapth, OVS should be able to match on the content of that entry.
>
Hi Ilya,

Thank you for your comment.

If OVS should use conntrack (ct) entries created externally, features
relying on NF_CT_EXT_XXX may not work on such entries. The NF_CT_EXT_LABELS
extension discussed in this thread is one example. Other extensions like
NF_CT_EXT_HELPER, NF_CT_EXT_ECACHE, and NF_CT_EXT_TIMEOUT may also be
affected.

If the ct entry already exists before the OVS flow with ct actions is
created, the entry might not have the required NF_CT_EXT extension as
it was not created with the tmpl set by OVS, even though the OVS flow
requests it.

As far as I know, using a separate conntrack zone to avoid reusing the
existing ct entry can work around this issue.

Let me know if I missed something, or do you have any better solutions?

Thanks.

> > I believe ct zones can be used to prevent this issue.
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
> > Thanks.
> >>>
> >>>>
> >>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack=
.c
> >>>> index 3bb4810234aa..c599ee013dfe 100644
> >>>> --- a/net/openvswitch/conntrack.c
> >>>> +++ b/net/openvswitch/conntrack.c
> >>>> @@ -595,6 +595,11 @@ static bool skb_nfct_cached(struct net *net,
> >>>>               rcu_dereference(timeout_ext->timeout))
> >>>>               return false;
> >>>>       }
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
> >>>>>>    net/openvswitch/conntrack.c | 30 ++++++++++++------------------
> >>>>>>    net/openvswitch/datapath.h  |  3 ---
> >>>>>>    2 files changed, 12 insertions(+), 21 deletions(-)
> >>>>>>
> >>>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntra=
ck.c
> >>>>>> index 8eb1d644b741..a3da5ee34f92 100644
> >>>>>> --- a/net/openvswitch/conntrack.c
> >>>>>> +++ b/net/openvswitch/conntrack.c
> >>>>>> @@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum ov=
s_key_attr attr)
> >>>>>>            attr =3D=3D OVS_KEY_ATTR_CT_MARK)
> >>>>>>                return true;
> >>>>>>        if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
> >>>>>> -         attr =3D=3D OVS_KEY_ATTR_CT_LABELS) {
> >>>>>> -             struct ovs_net *ovs_net =3D net_generic(net, ovs_net=
_id);
> >>>>>> -
> >>>>>> -             return ovs_net->xt_label;
> >>>>>> -     }
> >>>>>> +         attr =3D=3D OVS_KEY_ATTR_CT_LABELS)
> >>>>>> +             return true;
> >>>>>>
> >>>>>>        return false;
> >>>>>>    }
> >>>>>> @@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, cons=
t struct nlattr *attr,
> >>>>>>                       const struct sw_flow_key *key,
> >>>>>>                       struct sw_flow_actions **sfa,  bool log)
> >>>>>>    {
> >>>>>> +     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) * B=
ITS_PER_BYTE;
> >>>>>>        struct ovs_conntrack_info ct_info;
> >>>>>>        const char *helper =3D NULL;
> >>>>>>        u16 family;
> >>>>>> @@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, con=
st struct nlattr *attr,
> >>>>>>                return -ENOMEM;
> >>>>>>        }
> >>>>>>
> >>>>>> +     if (nf_connlabels_get(net, n_bits - 1)) {
> >>>>>> +             nf_ct_tmpl_free(ct_info.ct);
> >>>>>> +             OVS_NLERR(log, "Failed to set connlabel length");
> >>>>>> +             return -EOPNOTSUPP;
> >>>>>> +     }
> >>>>>> +
> >>>>>>        if (ct_info.timeout[0]) {
> >>>>>>                if (nf_ct_set_timeout(net, ct_info.ct, family, key-=
>ip.proto,
> >>>>>>                                      ct_info.timeout))
> >>>>>> @@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ovs_=
conntrack_info *ct_info)
> >>>>>>        if (ct_info->ct) {
> >>>>>>                if (ct_info->timeout[0])
> >>>>>>                        nf_ct_destroy_timeout(ct_info->ct);
> >>>>>> +             nf_connlabels_put(nf_ct_net(ct_info->ct));
> >>>>>>                nf_ct_tmpl_free(ct_info->ct);
> >>>>>>        }
> >>>>>>    }
> >>>>>> @@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_family =
__ro_after_init =3D {
> >>>>>>
> >>>>>>    int ovs_ct_init(struct net *net)
> >>>>>>    {
> >>>>>> -     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) * B=
ITS_PER_BYTE;
> >>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>        struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> >>>>>>
> >>>>>> -     if (nf_connlabels_get(net, n_bits - 1)) {
> >>>>>> -             ovs_net->xt_label =3D false;
> >>>>>> -             OVS_NLERR(true, "Failed to set connlabel length");
> >>>>>> -     } else {
> >>>>>> -             ovs_net->xt_label =3D true;
> >>>>>> -     }
> >>>>>> -
> >>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>        return ovs_ct_limit_init(net, ovs_net);
> >>>>>>    #else
> >>>>>>        return 0;
> >>>>>> @@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
> >>>>>>
> >>>>>>    void ovs_ct_exit(struct net *net)
> >>>>>>    {
> >>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>        struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> >>>>>>
> >>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>        ovs_ct_limit_exit(net, ovs_net);
> >>>>>>    #endif
> >>>>>> -
> >>>>>> -     if (ovs_net->xt_label)
> >>>>>> -             nf_connlabels_put(net);
> >>>>>>    }
> >>>>>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath=
.h
> >>>>>> index 9ca6231ea647..365b9bb7f546 100644
> >>>>>> --- a/net/openvswitch/datapath.h
> >>>>>> +++ b/net/openvswitch/datapath.h
> >>>>>> @@ -160,9 +160,6 @@ struct ovs_net {
> >>>>>>    #if IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>        struct ovs_ct_limit_info *ct_limit_info;
> >>>>>>    #endif
> >>>>>> -
> >>>>>> -     /* Module reference for configuring conntrack. */
> >>>>>> -     bool xt_label;
> >>>>>>    };
> >>>>>>
> >>>>>>    /**
> >>>>>
> >>>
>

