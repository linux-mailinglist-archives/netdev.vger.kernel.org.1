Return-Path: <netdev+bounces-171773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E006AA4E952
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B425E7AAFB2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890EF27C146;
	Tue,  4 Mar 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRixXU1/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989ED255243
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108229; cv=none; b=E9FzU5oXSKtcHzHG/zsvEMhOKPl3JypSzjNb4w45S68GgIVkzQtak3B7iE/Ld0gSrWgxpQmiQv7CAc8/q+iYj3Hi0e9FUq6PikKTX/iRsp6QF5mGSmskaNy9v5wNY0jgUtAUZ9IAq4HXxg8kc6QpqrNQ7XHZISHixY9sXniwA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108229; c=relaxed/simple;
	bh=R3427OOZ2fFUlJGNoUdRJzRLdAqXp0I9NlKQQsZWKGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmGfJqhGjEYSeiMbWBkaX9RzrK/YIW2Sp1RBxCd5eByCxBZcsRxiHDV+kgzTz9U2aSC2hR/pbf5d0oYfGCQwwcuUa0h/Kt/KH+nDdAvomM0osblYGtDTSGIS2NbIzShx7rSq5OV0vOYkG8uJ5oJ5c8dW5GXRy6jM+RyXwUe0fsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRixXU1/; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d3db37f4e6so55345155ab.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 09:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741108226; x=1741713026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIYNyICcOhif3SQAOVlZwXAxK4sjlYDzZBCEzWBpYCE=;
        b=gRixXU1/6tIj67aS8xM6eUWX3J1n7n2pqcKya9KqGT34CZAqmmAgPmAC2pmGZknp2n
         2ivY9WtUwK5+Is75HHeevnyF+yTpSLAUCivvQLgauaBCbwfB7Q+oWO3sMzBtovl58Uk7
         sOHfR/brP8zF5xWqVItfy3b49Nw2k1JQISq4dQTtXINJwOzyLUBGCThyAkq5N5soJ/dr
         MPRXoUXLBiehTlDhGDFPGsWRKpO0x8Ms9S/zWUzOWU+YoKMUae7yhH2rFCgNJTShDHSf
         VMQ7EsKQhtO+WT83jssJcFJ5BUV67otd/Ug9lN62ciGOsmMNNHQUJGqg/QgwydmG/ISj
         qOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108226; x=1741713026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIYNyICcOhif3SQAOVlZwXAxK4sjlYDzZBCEzWBpYCE=;
        b=u2Xhne6+4H8gB0MIRL5gFEsEQHZsQ84lzANk317aSM7AFPLqeVZ/qBL1n/+akW9fEj
         ZNg/HlKGg+oobaay/a4DrPdfLmLAgycw14xn1PqhKIl9wWxSit3UaeF7H8b/EC4dVf7w
         +R2go8cWUvnAVYLipufjebGA7MUM3k3muSU5FMMmwyZ9k54Ek/Qhulaq2FBeXvf/bBPW
         k5HG69RMywSi8DSfv1z0soI9bS8KlrXfBaF0novN+lGZ2czKZrU13xkPUqQkeHu8eMCU
         0eLmhU234odWJWJaI8dWZ/ryONIhgyqg7F9RjCPNyg1WNplQXLV1HljEik5vKI1joyAF
         S1qw==
X-Gm-Message-State: AOJu0YzRlsmlNlvRzJJovLN4cKITE2+BCgXr8gJYOsi84bVj7LpB7Wpd
	ges742ZU81m6saHB8+1GXtJj6veipatnVPOsaVFwvLHasDUeikLx9yRw2z+YTCcbiWoTlNbRwP2
	HjQq8wddyAOgcTXws3vhR9s03Y4k=
X-Gm-Gg: ASbGncsXb562fuvZDKqMOEjTHaKMPBzQddi6cciaSATUmdIZjYL7uhB11f76CDUrcUf
	Z48jjEw6hdFdEn4mmtrHyaNDj0jLZ939Sb4QVHrywiEK8M1UPg2QZ5rPu0nv1VgiIkANCVoSJ4e
	baMiOKOo8wNpRWk3dUczxD2s3xBVowuLLOIR03Dp2tTmdLyMjs1dFiLYUtf3U=
X-Google-Smtp-Source: AGHT+IGrTWjvYy3Uycg+ckGKOKlIzhmGjL1eJuZM/GrzmGtg2qDhE2AEZCfowCDarNC9u2NfBWQyCMSRHBcE2tnxoIg=
X-Received: by 2002:a05:6e02:2608:b0:3ce:8ed9:ca94 with SMTP id
 e9e14a558f8ab-3d3e6f99245mr175363335ab.14.1741108226444; Tue, 04 Mar 2025
 09:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
 <2ee4d016-5e57-4d86-9dca-e4685cb183bb@nvidia.com> <CADvbK_ft=B310a9dcwgnwDrPKsxhicKJ4v9wAdgPSHhG+gPjLw@mail.gmail.com>
 <5ab59f2d-1c22-4602-95ab-a247b5bf048e@nvidia.com> <CADvbK_draP9X9OWXEYTKrP0_ekjgNu9PYPp6GUkvu-3L24SRYg@mail.gmail.com>
 <CADvbK_cungrr_D5VAiL8C+FSJEoLFYtMxV5foU0XA9E4zrcegA@mail.gmail.com>
 <7061a416-56cb-4751-8576-8071c2205d70@nvidia.com> <CADvbK_faagwC4q0vNEeW7Eu7SZbXuVjULXo3kg7JS16cF+cmig@mail.gmail.com>
 <c986ed18-750f-46bc-9f52-5860d834162e@nvidia.com>
In-Reply-To: <c986ed18-750f-46bc-9f52-5860d834162e@nvidia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 4 Mar 2025 12:10:14 -0500
X-Gm-Features: AQ5f1JrlJucEhWyieGJ3uptnozw9e0-0fPW087kgzDnVKfwaGkVbR1dGFA_Eyhw
Message-ID: <CADvbK_fyWvEH2vPmS5nkwpGBmr+pT3anLM5EkwLr7KLpjuk0qQ@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label
 counting in conntrack
To: Jianbo Liu <jianbol@nvidia.com>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org, ovs-dev@openvswitch.org, 
	davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>, 
	Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 8:20=E2=80=AFPM Jianbo Liu <jianbol@nvidia.com> wrot=
e:
>
>
>
> On 3/4/2025 12:42 AM, Xin Long wrote:
> > On Sun, Mar 2, 2025 at 9:14=E2=80=AFPM Jianbo Liu <jianbol@nvidia.com> =
wrote:
> >>
> >>
> >>
> >> On 3/3/2025 2:22 AM, Xin Long wrote:
> >>> On Tue, Feb 25, 2025 at 9:57=E2=80=AFAM Xin Long <lucien.xin@gmail.co=
m> wrote:
> >>>>
> >>>> On Mon, Feb 24, 2025 at 8:38=E2=80=AFPM Jianbo Liu <jianbol@nvidia.c=
om> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2/25/2025 3:55 AM, Xin Long wrote:
> >>>>>> On Mon, Feb 24, 2025 at 4:01=E2=80=AFAM Jianbo Liu <jianbol@nvidia=
.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 8/13/2024 1:17 AM, Xin Long wrote:
> >>>>>>>> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-ac=
tion
> >>>>>>>> label counting"), we should also switch to per-action label coun=
ting
> >>>>>>>> in openvswitch conntrack, as Florian suggested.
> >>>>>>>>
> >>>>>>>> The difference is that nf_connlabels_get() is called uncondition=
ally
> >>>>>>>> when creating an ct action in ovs_ct_copy_action(). As with thes=
e
> >>>>>>>> flows:
> >>>>>>>>
> >>>>>>>>       table=3D0,ip,actions=3Dct(commit,table=3D1)
> >>>>>>>>       table=3D1,ip,actions=3Dct(commit,exec(set_field:0xac->ct_l=
abel),table=3D2)
> >>>>>>>>
> >>>>>>>> it needs to make sure the label ext is created in the 1st flow b=
efore
> >>>>>>>> the ct is committed in ovs_ct_commit(). Otherwise, the warning i=
n
> >>>>>>>> nf_ct_ext_add() when creating the label ext in the 2nd flow will
> >>>>>>>> be triggered:
> >>>>>>>>
> >>>>>>>>        WARN_ON(nf_ct_is_confirmed(ct));
> >>>>>>>>
> >>>>>>>
> >>>>>>> Hi Xin Long,
> >>>>>>>
> >>>>>>> The ct can be committed before openvswitch handles packets with C=
T
> >>>>>>> actions. And we can trigger the warning by creating VF and runnin=
g ping
> >>>>>>> over it with the following configurations:
> >>>>>>>
> >>>>>>> ovs-vsctl add-br br
> >>>>>>> ovs-vsctl add-port br eth2
> >>>>>>> ovs-vsctl add-port br eth4
> >>>>>>> ovs-ofctl add-flow br "table=3D0, in_port=3Deth4,ip,ct_state=3D-t=
rk
> >>>>>>> actions=3Dct(table=3D1)"
> >>>>>>> ovs-ofctl add-flow br "table=3D1, in_port=3Deth4,ip,ct_state=3D+t=
rk+new
> >>>>>>> actions=3Dct(exec(set_field:0xef7d->ct_label), commit), output:et=
h2"
> >>>>>>> ovs-ofctl add-flow br "table=3D1, in_port=3Deth4,ip,ct_label=3D0x=
ef7d,
> >>>>>>> ct_state=3D+trk+est actions=3Doutput:eth2"
> >>>>>>>
> >>>>>>> The eth2 is PF, and eth4 is VF's representor.
> >>>>>>> Would you like to fix it?
> >>>>>> Hi, Jianbo,
> >>>>>>
> >>>>>> Sure, we have to attach a new ct to the skb in __ovs_ct_lookup() f=
or
> >>>>>> this case, and even delete the one created before ovs_ct.
> >>>>>>
> >>>>>> Can you check if this works on your env?
> >>>>>
> >>>>> Yes, it works.
> >>>>> Could you please submit the formal patch? Thanks!
> >>>> Great, I will post after running some of my local tests.
> >>>>
> >>> Hi Jianbo,
> >>>
> >>> I recently ran some tests and observed that the current approach cann=
ot
> >>> completely avoid the warning. If an skb enters __ovs_ct_lookup() with=
out
> >>> an attached connection tracking (ct) entry, it may still acquire an
> >>> existing ct created outside of OVS (possibly by netfilter) through
> >>> nf_conntrack_in(). This will trigger the warning in ovs_ct_set_labels=
().
> >>>
> >>> Deleting a ct created outside OVS and creating a new one within
> >>> __ovs_ct_lookup() doesn't seem reasonable and would be difficult to
> >>
> >> Yes, I'm also skeptical of your temporary fix, and waiting for your
> >> formal one.
> > Cool.
> >
> >>
> >>> implement. However, since OVS is not supposed to use ct entries creat=
ed
> >>> externally, I believe ct zones can be used to prevent this issue.
> >>> In your case, the following flows should work:
> >>>
> >>> ovs-ofctl add-flow br "table=3D0, in_port=3Deth4,ip,ct_state=3D-trk
> >>> actions=3Dct(table=3D1,zone=3D1)"
> >>> ovs-ofctl add-flow br "table=3D1,
> >>> in_port=3Deth4,ip,ct_state=3D+trk+new,ct_zone=3D1
> >>> actions=3Dct(exec(set_field:0xef7d->ct_label),commit,zone=3D1),
> >>> output:eth2"
> >>> ovs-ofctl add-flow br "table=3D1,
> >>> in_port=3Deth4,ip,ct_label=3D0xef7d,ct_state=3D+trk+est,ct_zone=3D1
> >>> actions=3Doutput:eth2"
> >>>
> >>> Regarding the warning triggered by externally created ct entries, I p=
lan
> >>> to remove the ovs_ct_get_conn_labels() call from ovs_ct_set_labels() =
and
> >>> I'll let nf_connlabels_replace() return an error in such cases, simil=
ar
> >>> to how tcf_ct_act_set_labels() handles this scenario in tc act_ct.
> >>>
> >>
> >> It's a good idea to be consistent with act_ct implementation. But, wou=
ld
> >> you like to revert first if it takes long time to work on the fix?
> > Sorry, revert which one?
>
> Of course the one we are currently replying to - "openvswitch: switch to
> per-action label counting in conntrack".
>
It's true the commit "openvswitch: switch to per-action label counting
in conntrack"
makes the issue more likely to occur.

However, I've reproduced the warning in local tests even without the
commit, so the root cause appears to be independent of this change.

I will post the fix later today.

Thank you for your report!

> > If you mean the fix in skb_nfct_cached(), it hasn't been posted and
> > will not be posted.
>
> No. I think we both know this is just a temporary fix, and it can help
> you to understand the issue.
>
> >
> > Thanks.
> >>
> >> Thanks!
> >>
> >>> Thanks.
> >>>>>
> >>>>>>
> >>>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntra=
ck.c
> >>>>>> index 3bb4810234aa..c599ee013dfe 100644
> >>>>>> --- a/net/openvswitch/conntrack.c
> >>>>>> +++ b/net/openvswitch/conntrack.c
> >>>>>> @@ -595,6 +595,11 @@ static bool skb_nfct_cached(struct net *net,
> >>>>>>                 rcu_dereference(timeout_ext->timeout))
> >>>>>>                 return false;
> >>>>>>         }
> >>>>>> +    if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) && !nf_ct_labels_f=
ind(ct)) {
> >>>>>> +        if (nf_ct_is_confirmed(ct))
> >>>>>> +            nf_ct_delete(ct, 0, 0);
> >>>>>> +        return false;
> >>>>>> +    }
> >>>>>>
> >>>>>> Thanks.
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks!
> >>>>>>> Jianbo
> >>>>>>>
> >>>>>>>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> >>>>>>>> ---
> >>>>>>>> v2: move ovs_net into #if in ovs_ct_exit() as Jakub noticed.
> >>>>>>>> ---
> >>>>>>>>      net/openvswitch/conntrack.c | 30 ++++++++++++--------------=
----
> >>>>>>>>      net/openvswitch/datapath.h  |  3 ---
> >>>>>>>>      2 files changed, 12 insertions(+), 21 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/connt=
rack.c
> >>>>>>>> index 8eb1d644b741..a3da5ee34f92 100644
> >>>>>>>> --- a/net/openvswitch/conntrack.c
> >>>>>>>> +++ b/net/openvswitch/conntrack.c
> >>>>>>>> @@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum =
ovs_key_attr attr)
> >>>>>>>>              attr =3D=3D OVS_KEY_ATTR_CT_MARK)
> >>>>>>>>                  return true;
> >>>>>>>>          if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
> >>>>>>>> -         attr =3D=3D OVS_KEY_ATTR_CT_LABELS) {
> >>>>>>>> -             struct ovs_net *ovs_net =3D net_generic(net, ovs_n=
et_id);
> >>>>>>>> -
> >>>>>>>> -             return ovs_net->xt_label;
> >>>>>>>> -     }
> >>>>>>>> +         attr =3D=3D OVS_KEY_ATTR_CT_LABELS)
> >>>>>>>> +             return true;
> >>>>>>>>
> >>>>>>>>          return false;
> >>>>>>>>      }
> >>>>>>>> @@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, co=
nst struct nlattr *attr,
> >>>>>>>>                         const struct sw_flow_key *key,
> >>>>>>>>                         struct sw_flow_actions **sfa,  bool log)
> >>>>>>>>      {
> >>>>>>>> +     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) *=
 BITS_PER_BYTE;
> >>>>>>>>          struct ovs_conntrack_info ct_info;
> >>>>>>>>          const char *helper =3D NULL;
> >>>>>>>>          u16 family;
> >>>>>>>> @@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, c=
onst struct nlattr *attr,
> >>>>>>>>                  return -ENOMEM;
> >>>>>>>>          }
> >>>>>>>>
> >>>>>>>> +     if (nf_connlabels_get(net, n_bits - 1)) {
> >>>>>>>> +             nf_ct_tmpl_free(ct_info.ct);
> >>>>>>>> +             OVS_NLERR(log, "Failed to set connlabel length");
> >>>>>>>> +             return -EOPNOTSUPP;
> >>>>>>>> +     }
> >>>>>>>> +
> >>>>>>>>          if (ct_info.timeout[0]) {
> >>>>>>>>                  if (nf_ct_set_timeout(net, ct_info.ct, family, =
key->ip.proto,
> >>>>>>>>                                        ct_info.timeout))
> >>>>>>>> @@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ov=
s_conntrack_info *ct_info)
> >>>>>>>>          if (ct_info->ct) {
> >>>>>>>>                  if (ct_info->timeout[0])
> >>>>>>>>                          nf_ct_destroy_timeout(ct_info->ct);
> >>>>>>>> +             nf_connlabels_put(nf_ct_net(ct_info->ct));
> >>>>>>>>                  nf_ct_tmpl_free(ct_info->ct);
> >>>>>>>>          }
> >>>>>>>>      }
> >>>>>>>> @@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_famil=
y __ro_after_init =3D {
> >>>>>>>>
> >>>>>>>>      int ovs_ct_init(struct net *net)
> >>>>>>>>      {
> >>>>>>>> -     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) *=
 BITS_PER_BYTE;
> >>>>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>>>          struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id=
);
> >>>>>>>>
> >>>>>>>> -     if (nf_connlabels_get(net, n_bits - 1)) {
> >>>>>>>> -             ovs_net->xt_label =3D false;
> >>>>>>>> -             OVS_NLERR(true, "Failed to set connlabel length");
> >>>>>>>> -     } else {
> >>>>>>>> -             ovs_net->xt_label =3D true;
> >>>>>>>> -     }
> >>>>>>>> -
> >>>>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>>>          return ovs_ct_limit_init(net, ovs_net);
> >>>>>>>>      #else
> >>>>>>>>          return 0;
> >>>>>>>> @@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
> >>>>>>>>
> >>>>>>>>      void ovs_ct_exit(struct net *net)
> >>>>>>>>      {
> >>>>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>>>          struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id=
);
> >>>>>>>>
> >>>>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>>>          ovs_ct_limit_exit(net, ovs_net);
> >>>>>>>>      #endif
> >>>>>>>> -
> >>>>>>>> -     if (ovs_net->xt_label)
> >>>>>>>> -             nf_connlabels_put(net);
> >>>>>>>>      }
> >>>>>>>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapa=
th.h
> >>>>>>>> index 9ca6231ea647..365b9bb7f546 100644
> >>>>>>>> --- a/net/openvswitch/datapath.h
> >>>>>>>> +++ b/net/openvswitch/datapath.h
> >>>>>>>> @@ -160,9 +160,6 @@ struct ovs_net {
> >>>>>>>>      #if IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>>>          struct ovs_ct_limit_info *ct_limit_info;
> >>>>>>>>      #endif
> >>>>>>>> -
> >>>>>>>> -     /* Module reference for configuring conntrack. */
> >>>>>>>> -     bool xt_label;
> >>>>>>>>      };
> >>>>>>>>
> >>>>>>>>      /**
> >>>>>>>
> >>>>>
> >>
>

