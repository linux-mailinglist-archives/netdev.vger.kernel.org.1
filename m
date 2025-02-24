Return-Path: <netdev+bounces-169176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B690DA42D1B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129407A3976
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F8A1FDA61;
	Mon, 24 Feb 2025 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6tJF22H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67070838
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426933; cv=none; b=L3wHWc0R2UvwMczZNWxAgvwCKs18ZwE14HfHPRJRSJAfgHnwIBS/2GNU5ZSXyl083aJOqm7l8EYWS1Hd2ImOU4yn7I4jY0gsqxDBINHF/gfv4yeY6i25Sq9MhkSO5DOH1D78Lx85QSmZ7/6Goemtrz3r12b9RRgQpL973Oywfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426933; c=relaxed/simple;
	bh=Y1AT8CyDGUWq3lLcUHZ61IOAZ/gH8bQqeC5K2lCFi1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ga6posNk5BRJ8ts5vHJB6b1Wxwcp50smCSxLOKzeiyBBZ+QyEGAPzxGRpj1i0GecY5d3kzvjag+FBsKw0FbcdVNPe7t/1dMkoOqJod/HAdTo2WPJpHGJOjRkvRnBBEHx6YzWjrqlkJtXp+r1/GYQFFbGGcS0dcUr691LsLA/4rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6tJF22H; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d191bfeafbso16290345ab.0
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 11:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740426931; x=1741031731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOGGEUzxww5rnJiDQOyI+Y9aqTaCCC3x+i0poXIr4Wc=;
        b=R6tJF22H/Q/QerlB96+8df3F03lYhH3ZIYJNlM8/SWW/5OedACtfGujq3Gdn4jGETL
         g34iEHEiFMZOEJfO881+wv2EtY3z5Dv7NimPWvj/PEZ68CnZgND2XAJq+KFCaM0C8QHr
         Rj2UyQ87G55MVVcjweNt7BB23JXeXw+mnaCkwQrSKcCDnvE5XhuK++v5foNKA2z8xsOI
         LoV904+VT09duXWJg4otXC2YnE5qBJ/fgdppR+o2X0o3puFNYV7vcnHjXlH3sTpOKwBB
         RHaaIeaRoQEIu3LJaIeYw7k97jFhjBP4/MNpniN0TA78eTg4fT0Fq+CcAHoRcJkDsNAi
         VgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740426931; x=1741031731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOGGEUzxww5rnJiDQOyI+Y9aqTaCCC3x+i0poXIr4Wc=;
        b=V+VlEklaug2y0PlmAtnSSHQUApd5wOrMkqxgk5dMf3Bilt7nnSmLMnwAjVVrZd5Dfy
         +e79xZL6o19xZihNOKFBfM7jm1cSRYkJnEX1EHLT58WhPV7plPEAcYzHa6N0uLeW91/n
         AlOnP+WrngHrHe1vp8rHSIFrMweoUqNMKKGMuLR23tst7EgABx1+9eBrX6BZp9AfmLC6
         KXpOFxFsViKXRWsNxBYt9JVeB/bRjI4kCS5SZiD/1uSVRWFMYsHgp0dAgWyU1LQ4CB8i
         Mdlnya7w0tqv3Ow8Ru5LB0q8xZW/qvwnyq3drGgkaBHNDheC3tMeS4mk1nwJ9IkRt0cD
         egHw==
X-Gm-Message-State: AOJu0YwMdWIiYDrH+eJY/4bsq0c4ryVumSqOmPuLmh6zQfNu07z5LOaH
	WNwpNpKfZ7r+riXJGUdyB8sJbtOjVVvHU6LgZy7HxTApJDLGqfeWXMbtuNZ0zAL0shrws3xeI+9
	yUAbbuF376eRRqaOlEWLIN1M6LFc=
X-Gm-Gg: ASbGncvZo/IWlazZk8ZMeff2c+onn6sJJsKd6jMcJBhCprrccEuFMIA+3CD6IUozxPL
	86xrlw2tKIaaiYDw1/EPCxh+vmEtqQzZiRWyszSqmiTFQJM4BAHfKO2Uc2CVTDiAdOYKY7ooUb5
	G5jE3vIc8=
X-Google-Smtp-Source: AGHT+IG6j3GftY1IQYa9O8aRf9XYMEOg0Z3VS+62VyTqqVCtQcLRX2fpy/7hGQb/IIxLVLKeMjSXEj7eyIIkEvLla3w=
X-Received: by 2002:a05:6e02:16cf:b0:3d2:bac3:b45f with SMTP id
 e9e14a558f8ab-3d2fc0d9638mr7891125ab.4.1740426930845; Mon, 24 Feb 2025
 11:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
 <2ee4d016-5e57-4d86-9dca-e4685cb183bb@nvidia.com>
In-Reply-To: <2ee4d016-5e57-4d86-9dca-e4685cb183bb@nvidia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 24 Feb 2025 14:55:20 -0500
X-Gm-Features: AWEUYZmA6R4-mIPQgSltdfrpRsSKNdPagxxj05dGCM4wTGaEjTD3tMSNb48A0Cw
Message-ID: <CADvbK_ft=B310a9dcwgnwDrPKsxhicKJ4v9wAdgPSHhG+gPjLw@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label
 counting in conntrack
To: Jianbo Liu <jianbol@nvidia.com>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org, ovs-dev@openvswitch.org, 
	davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>, 
	Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 4:01=E2=80=AFAM Jianbo Liu <jianbol@nvidia.com> wro=
te:
>
>
>
> On 8/13/2024 1:17 AM, Xin Long wrote:
> > Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-action
> > label counting"), we should also switch to per-action label counting
> > in openvswitch conntrack, as Florian suggested.
> >
> > The difference is that nf_connlabels_get() is called unconditionally
> > when creating an ct action in ovs_ct_copy_action(). As with these
> > flows:
> >
> >    table=3D0,ip,actions=3Dct(commit,table=3D1)
> >    table=3D1,ip,actions=3Dct(commit,exec(set_field:0xac->ct_label),tabl=
e=3D2)
> >
> > it needs to make sure the label ext is created in the 1st flow before
> > the ct is committed in ovs_ct_commit(). Otherwise, the warning in
> > nf_ct_ext_add() when creating the label ext in the 2nd flow will
> > be triggered:
> >
> >     WARN_ON(nf_ct_is_confirmed(ct));
> >
>
> Hi Xin Long,
>
> The ct can be committed before openvswitch handles packets with CT
> actions. And we can trigger the warning by creating VF and running ping
> over it with the following configurations:
>
> ovs-vsctl add-br br
> ovs-vsctl add-port br eth2
> ovs-vsctl add-port br eth4
> ovs-ofctl add-flow br "table=3D0, in_port=3Deth4,ip,ct_state=3D-trk
> actions=3Dct(table=3D1)"
> ovs-ofctl add-flow br "table=3D1, in_port=3Deth4,ip,ct_state=3D+trk+new
> actions=3Dct(exec(set_field:0xef7d->ct_label), commit), output:eth2"
> ovs-ofctl add-flow br "table=3D1, in_port=3Deth4,ip,ct_label=3D0xef7d,
> ct_state=3D+trk+est actions=3Doutput:eth2"
>
> The eth2 is PF, and eth4 is VF's representor.
> Would you like to fix it?
Hi, Jianbo,

Sure, we have to attach a new ct to the skb in __ovs_ct_lookup() for
this case, and even delete the one created before ovs_ct.

Can you check if this works on your env?

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 3bb4810234aa..c599ee013dfe 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -595,6 +595,11 @@ static bool skb_nfct_cached(struct net *net,
             rcu_dereference(timeout_ext->timeout))
             return false;
     }
+    if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) && !nf_ct_labels_find(ct)) =
{
+        if (nf_ct_is_confirmed(ct))
+            nf_ct_delete(ct, 0, 0);
+        return false;
+    }

Thanks.

>
> Thanks!
> Jianbo
>
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> > v2: move ovs_net into #if in ovs_ct_exit() as Jakub noticed.
> > ---
> >   net/openvswitch/conntrack.c | 30 ++++++++++++------------------
> >   net/openvswitch/datapath.h  |  3 ---
> >   2 files changed, 12 insertions(+), 21 deletions(-)
> >
> > diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> > index 8eb1d644b741..a3da5ee34f92 100644
> > --- a/net/openvswitch/conntrack.c
> > +++ b/net/openvswitch/conntrack.c
> > @@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum ovs_key=
_attr attr)
> >           attr =3D=3D OVS_KEY_ATTR_CT_MARK)
> >               return true;
> >       if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
> > -         attr =3D=3D OVS_KEY_ATTR_CT_LABELS) {
> > -             struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> > -
> > -             return ovs_net->xt_label;
> > -     }
> > +         attr =3D=3D OVS_KEY_ATTR_CT_LABELS)
> > +             return true;
> >
> >       return false;
> >   }
> > @@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, const str=
uct nlattr *attr,
> >                      const struct sw_flow_key *key,
> >                      struct sw_flow_actions **sfa,  bool log)
> >   {
> > +     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) * BITS_P=
ER_BYTE;
> >       struct ovs_conntrack_info ct_info;
> >       const char *helper =3D NULL;
> >       u16 family;
> > @@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, const st=
ruct nlattr *attr,
> >               return -ENOMEM;
> >       }
> >
> > +     if (nf_connlabels_get(net, n_bits - 1)) {
> > +             nf_ct_tmpl_free(ct_info.ct);
> > +             OVS_NLERR(log, "Failed to set connlabel length");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> >       if (ct_info.timeout[0]) {
> >               if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.pr=
oto,
> >                                     ct_info.timeout))
> > @@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ovs_connt=
rack_info *ct_info)
> >       if (ct_info->ct) {
> >               if (ct_info->timeout[0])
> >                       nf_ct_destroy_timeout(ct_info->ct);
> > +             nf_connlabels_put(nf_ct_net(ct_info->ct));
> >               nf_ct_tmpl_free(ct_info->ct);
> >       }
> >   }
> > @@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_family __ro_=
after_init =3D {
> >
> >   int ovs_ct_init(struct net *net)
> >   {
> > -     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) * BITS_P=
ER_BYTE;
> > +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >       struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> >
> > -     if (nf_connlabels_get(net, n_bits - 1)) {
> > -             ovs_net->xt_label =3D false;
> > -             OVS_NLERR(true, "Failed to set connlabel length");
> > -     } else {
> > -             ovs_net->xt_label =3D true;
> > -     }
> > -
> > -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >       return ovs_ct_limit_init(net, ovs_net);
> >   #else
> >       return 0;
> > @@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
> >
> >   void ovs_ct_exit(struct net *net)
> >   {
> > +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >       struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> >
> > -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >       ovs_ct_limit_exit(net, ovs_net);
> >   #endif
> > -
> > -     if (ovs_net->xt_label)
> > -             nf_connlabels_put(net);
> >   }
> > diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> > index 9ca6231ea647..365b9bb7f546 100644
> > --- a/net/openvswitch/datapath.h
> > +++ b/net/openvswitch/datapath.h
> > @@ -160,9 +160,6 @@ struct ovs_net {
> >   #if IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >       struct ovs_ct_limit_info *ct_limit_info;
> >   #endif
> > -
> > -     /* Module reference for configuring conntrack. */
> > -     bool xt_label;
> >   };
> >
> >   /**
>

