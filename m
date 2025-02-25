Return-Path: <netdev+bounces-169501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBF9A443C0
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846BC1881EE0
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D0621ABD7;
	Tue, 25 Feb 2025 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwUi0YZw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133521ABB2
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495470; cv=none; b=jF7WoeZdO3gxVDyJsy3tY7nsi0stJloqRH8Y0AZUDybYx2oV/z/IE8VybchfvZxHNYpytyCFP1q3zPmR8GiNrtA7N1sGlTYDpL+uZ+gvZDfGzC+EJ7TThqyoDTu3lsjBi9Tm1lISMFZGrJCUolzxfq0pNB0U5YBjs3Wr4guBqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495470; c=relaxed/simple;
	bh=t+an49SaUSLKH2iO7JnU599cc6Lyecb0DCaneEfGiz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QW72B9Mftl1IUSXu3nvmiledhDfEQyKVcW/xqlSvdqWujeDDEgbA5f+abS301bGAmjcLPJrz/cLNLkubhk/45PfekFh5rmDHxg87sCzFkCiJg49FlBrBFFsZY9YtnvMVqbKIPJH2AKQk3alwMA3WHK0MJorN0+DMHMyYv5tyIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwUi0YZw; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso49171255ab.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 06:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740495468; x=1741100268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcYkF+TYTT7LSX2jmEpwJ1AT78TllMs7Dcv6pKsqtVA=;
        b=fwUi0YZw6dZkaDuFh5cHNeu+z7BkdW/ZOLdRe3ls4sxgN1woSK6Roaen4PMl2+bdlB
         ztVrTW10AJfGQwxO8szEaE/FLgzrANDLiTOu1xWSm8KtL7iIKKia7cYTLy7UB3J2IA8Q
         eFkJwdZuckxsiJcJxiLUC8F82JlebysDaNUUqLVBQHkfc3F4ecL+Fd8OuYHccY/xorCn
         e68cp67wbrWTwRZEVIp0wf7cJVNq6vAiBt3TkXVINp9T28dsKtLF1slh0JjKF5KfbA3R
         erY+4EcnSAwN70xKZG3B+RuqCgxyb3Az9PLUep6i4M/oaR9+ZilavUC9iWNmaIb4ZR/7
         y01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740495468; x=1741100268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcYkF+TYTT7LSX2jmEpwJ1AT78TllMs7Dcv6pKsqtVA=;
        b=dGFiU2vBacakyU6qM1ljIE2dTEDMe4s4/SJcJ+2P5d6MSawuYV6XboH56qJRQ/xZP6
         fZfDyWSAxCOwYvW9BwfZUq5VFUoCvmnDGshEnO+0m5kbAEiC34TMKuvyHuWGo1VHRsuA
         idlmNnDIMs4fYXs3eJkM8aZh8ACmqf8xZx9shixDumJf2uzM/EM5UP6nJLy/QjT/npLy
         8LX1G7L+C15fQu081q2lH4CladsPiwqltow6hT4A8NHiSWcKGo+w+Us/74OFp80ne60L
         2NBFntaKQW3O9KBeMfUAyswPIPGfCOL0DF+rxzZ/zqx/VcXHHJ+rAyOrEdV2sU68VKEj
         /hWg==
X-Gm-Message-State: AOJu0Yxloyy/lXuBmxAoclIymUf/XzwvijBGNdN3xhkRhBssphp15qqg
	RgukWgCnZrUVpexdntKC7IBjbCha7IZqivtF95UfJ3AFYBJjaNLL8BMNCAH9H2V0IqzN6tYDOnH
	cSJDQfUiAqCrlxzNinr1vFP/b3WW/ZA==
X-Gm-Gg: ASbGncvBwheQmZeyu54YkHUG4uh0cxCV0S2+wr2WgsdHy+PTK4mWsC6mwyg2jSj8MjA
	W3uekarRft7tTNBc8VuAm/O1VdlvWGVZPp0Su087fGNLCZCp2Jey02QT3KgDpuRWUWyrDZj6reN
	gpvr2ZN4a2Bg==
X-Google-Smtp-Source: AGHT+IFomr/Fy7AdSqRxd93t+7Dl5NwRo+bGaLGsumpGgrNfjCrUaJBx3aDdd9zzcnFo/C/sOuQwoKtQ6oXNhH1BQUI=
X-Received: by 2002:a05:6e02:3d83:b0:3d2:b930:ab5b with SMTP id
 e9e14a558f8ab-3d2cb473053mr155887155ab.10.1740495467988; Tue, 25 Feb 2025
 06:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
 <2ee4d016-5e57-4d86-9dca-e4685cb183bb@nvidia.com> <CADvbK_ft=B310a9dcwgnwDrPKsxhicKJ4v9wAdgPSHhG+gPjLw@mail.gmail.com>
 <5ab59f2d-1c22-4602-95ab-a247b5bf048e@nvidia.com>
In-Reply-To: <5ab59f2d-1c22-4602-95ab-a247b5bf048e@nvidia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 25 Feb 2025 09:57:36 -0500
X-Gm-Features: AQ5f1JpYmXjseMkd3ZtMcSjMXPo1SaBfMkfHR_Gg9Joz5-4hmQpOsXZaLcVNtyo
Message-ID: <CADvbK_draP9X9OWXEYTKrP0_ekjgNu9PYPp6GUkvu-3L24SRYg@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label
 counting in conntrack
To: Jianbo Liu <jianbol@nvidia.com>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org, ovs-dev@openvswitch.org, 
	davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>, 
	Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 8:38=E2=80=AFPM Jianbo Liu <jianbol@nvidia.com> wro=
te:
>
>
>
> On 2/25/2025 3:55 AM, Xin Long wrote:
> > On Mon, Feb 24, 2025 at 4:01=E2=80=AFAM Jianbo Liu <jianbol@nvidia.com>=
 wrote:
> >>
> >>
> >>
> >> On 8/13/2024 1:17 AM, Xin Long wrote:
> >>> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-action
> >>> label counting"), we should also switch to per-action label counting
> >>> in openvswitch conntrack, as Florian suggested.
> >>>
> >>> The difference is that nf_connlabels_get() is called unconditionally
> >>> when creating an ct action in ovs_ct_copy_action(). As with these
> >>> flows:
> >>>
> >>>     table=3D0,ip,actions=3Dct(commit,table=3D1)
> >>>     table=3D1,ip,actions=3Dct(commit,exec(set_field:0xac->ct_label),t=
able=3D2)
> >>>
> >>> it needs to make sure the label ext is created in the 1st flow before
> >>> the ct is committed in ovs_ct_commit(). Otherwise, the warning in
> >>> nf_ct_ext_add() when creating the label ext in the 2nd flow will
> >>> be triggered:
> >>>
> >>>      WARN_ON(nf_ct_is_confirmed(ct));
> >>>
> >>
> >> Hi Xin Long,
> >>
> >> The ct can be committed before openvswitch handles packets with CT
> >> actions. And we can trigger the warning by creating VF and running pin=
g
> >> over it with the following configurations:
> >>
> >> ovs-vsctl add-br br
> >> ovs-vsctl add-port br eth2
> >> ovs-vsctl add-port br eth4
> >> ovs-ofctl add-flow br "table=3D0, in_port=3Deth4,ip,ct_state=3D-trk
> >> actions=3Dct(table=3D1)"
> >> ovs-ofctl add-flow br "table=3D1, in_port=3Deth4,ip,ct_state=3D+trk+ne=
w
> >> actions=3Dct(exec(set_field:0xef7d->ct_label), commit), output:eth2"
> >> ovs-ofctl add-flow br "table=3D1, in_port=3Deth4,ip,ct_label=3D0xef7d,
> >> ct_state=3D+trk+est actions=3Doutput:eth2"
> >>
> >> The eth2 is PF, and eth4 is VF's representor.
> >> Would you like to fix it?
> > Hi, Jianbo,
> >
> > Sure, we have to attach a new ct to the skb in __ovs_ct_lookup() for
> > this case, and even delete the one created before ovs_ct.
> >
> > Can you check if this works on your env?
>
> Yes, it works.
> Could you please submit the formal patch? Thanks!
Great, I will post after running some of my local tests.

>
> >
> > diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> > index 3bb4810234aa..c599ee013dfe 100644
> > --- a/net/openvswitch/conntrack.c
> > +++ b/net/openvswitch/conntrack.c
> > @@ -595,6 +595,11 @@ static bool skb_nfct_cached(struct net *net,
> >               rcu_dereference(timeout_ext->timeout))
> >               return false;
> >       }
> > +    if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) && !nf_ct_labels_find(c=
t)) {
> > +        if (nf_ct_is_confirmed(ct))
> > +            nf_ct_delete(ct, 0, 0);
> > +        return false;
> > +    }
> >
> > Thanks.
> >
> >>
> >> Thanks!
> >> Jianbo
> >>
> >>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> >>> ---
> >>> v2: move ovs_net into #if in ovs_ct_exit() as Jakub noticed.
> >>> ---
> >>>    net/openvswitch/conntrack.c | 30 ++++++++++++------------------
> >>>    net/openvswitch/datapath.h  |  3 ---
> >>>    2 files changed, 12 insertions(+), 21 deletions(-)
> >>>
> >>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.=
c
> >>> index 8eb1d644b741..a3da5ee34f92 100644
> >>> --- a/net/openvswitch/conntrack.c
> >>> +++ b/net/openvswitch/conntrack.c
> >>> @@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum ovs_k=
ey_attr attr)
> >>>            attr =3D=3D OVS_KEY_ATTR_CT_MARK)
> >>>                return true;
> >>>        if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
> >>> -         attr =3D=3D OVS_KEY_ATTR_CT_LABELS) {
> >>> -             struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id=
);
> >>> -
> >>> -             return ovs_net->xt_label;
> >>> -     }
> >>> +         attr =3D=3D OVS_KEY_ATTR_CT_LABELS)
> >>> +             return true;
> >>>
> >>>        return false;
> >>>    }
> >>> @@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, const s=
truct nlattr *attr,
> >>>                       const struct sw_flow_key *key,
> >>>                       struct sw_flow_actions **sfa,  bool log)
> >>>    {
> >>> +     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) * BITS=
_PER_BYTE;
> >>>        struct ovs_conntrack_info ct_info;
> >>>        const char *helper =3D NULL;
> >>>        u16 family;
> >>> @@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, const =
struct nlattr *attr,
> >>>                return -ENOMEM;
> >>>        }
> >>>
> >>> +     if (nf_connlabels_get(net, n_bits - 1)) {
> >>> +             nf_ct_tmpl_free(ct_info.ct);
> >>> +             OVS_NLERR(log, "Failed to set connlabel length");
> >>> +             return -EOPNOTSUPP;
> >>> +     }
> >>> +
> >>>        if (ct_info.timeout[0]) {
> >>>                if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip=
.proto,
> >>>                                      ct_info.timeout))
> >>> @@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ovs_con=
ntrack_info *ct_info)
> >>>        if (ct_info->ct) {
> >>>                if (ct_info->timeout[0])
> >>>                        nf_ct_destroy_timeout(ct_info->ct);
> >>> +             nf_connlabels_put(nf_ct_net(ct_info->ct));
> >>>                nf_ct_tmpl_free(ct_info->ct);
> >>>        }
> >>>    }
> >>> @@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_family __r=
o_after_init =3D {
> >>>
> >>>    int ovs_ct_init(struct net *net)
> >>>    {
> >>> -     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) * BITS=
_PER_BYTE;
> >>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>        struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> >>>
> >>> -     if (nf_connlabels_get(net, n_bits - 1)) {
> >>> -             ovs_net->xt_label =3D false;
> >>> -             OVS_NLERR(true, "Failed to set connlabel length");
> >>> -     } else {
> >>> -             ovs_net->xt_label =3D true;
> >>> -     }
> >>> -
> >>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>        return ovs_ct_limit_init(net, ovs_net);
> >>>    #else
> >>>        return 0;
> >>> @@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
> >>>
> >>>    void ovs_ct_exit(struct net *net)
> >>>    {
> >>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>        struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> >>>
> >>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>        ovs_ct_limit_exit(net, ovs_net);
> >>>    #endif
> >>> -
> >>> -     if (ovs_net->xt_label)
> >>> -             nf_connlabels_put(net);
> >>>    }
> >>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> >>> index 9ca6231ea647..365b9bb7f546 100644
> >>> --- a/net/openvswitch/datapath.h
> >>> +++ b/net/openvswitch/datapath.h
> >>> @@ -160,9 +160,6 @@ struct ovs_net {
> >>>    #if IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>        struct ovs_ct_limit_info *ct_limit_info;
> >>>    #endif
> >>> -
> >>> -     /* Module reference for configuring conntrack. */
> >>> -     bool xt_label;
> >>>    };
> >>>
> >>>    /**
> >>
>

