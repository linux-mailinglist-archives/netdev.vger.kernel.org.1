Return-Path: <netdev+bounces-171710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B67A4E3D6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC8B19C4F3B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B097C25F962;
	Tue,  4 Mar 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXWiw0E+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4313251784
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101703; cv=none; b=IqJdOaRdbXQgQfihWzdKF4RoPrI7RISle79E6bUk9wMZP+mha2n2XzXv6lzeQtOt09wJbKSuT9c89GWu9hGvDSvMeboO3nNO5KtkbkUqzV30GOaazsGjFGUQ40ND31QL75tpXk1LxZ7XVKXV/h5iSLeQpCN7eZQ0awKNGfhJ0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101703; c=relaxed/simple;
	bh=c84Zw+KpGycFFIhHDfDVgr2Tw8mkDW7xlGOoou4h344=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jL8t2I5f4GH/4+wCsl8DQdizXoHSmDoXiJeeVRcS8fNv+u/HgivKuVOMZycxXXXPaluuNVLFAGpnvmYFIMD+u8OMOD1gnD9WHls+KbQt9Q1e52y7LctJTI1+D8aScF/57qtHa2UpNmh0JHAlrdDbCAh2p6eyne0dnn4r5nTW9n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXWiw0E+; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d2f5a932f5so18974935ab.1
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 07:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741101701; x=1741706501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyYDK/oJykG5Rj9gJ7abwrRHjh6AkbCtxzXLcp55dhM=;
        b=SXWiw0E+ef2uhtG9umyp0139XYSI/r+B/l4YHkE2lB55VswA/+gSQsoOH+Uvm9PPXZ
         fNSAsrWWAfKiv/MF24X7gIThaiNJ3pJsBAf4T7vFredgZOMt58CAThY24QNcQu/y4E+C
         x/1AV9/SqjCP4GERYpyXC0yGFbkJ4dyMLqyVjXjGLEmjMoo1wQVoSzPF4GmwyUDnoRQ9
         aWR802SlNkdA9ZjWH734m/BTnLmG31t9QXduEOC8icfT3xZPQU/bBrwJU85zJcLIZeR3
         RYx5Lu73V2nSAeT8Eizw8Byd6sivWNKMHpiWwnmaj8UEjqIXMevFYHxjuTRVt5HMqwdZ
         5ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101701; x=1741706501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyYDK/oJykG5Rj9gJ7abwrRHjh6AkbCtxzXLcp55dhM=;
        b=p9WtvY7bcV/TdD1C0ZNNXwKMD4Zvz5P7H9U3Irq+h2OrYKsAtuOdHcw9a5GUyFA4mC
         T2ayjLvedR//ZGcdIlVo4NfxJf/pKAM1Afn+PiEVSEv3/knr6Zwo2K4FLNWfeCHn2Rwq
         5ptRalpD3qnUG1GZHJ2B+j+wxLJy+3dQ7x6BMl5MuQw+j0K6HPqHLmglEov7XdUijDuI
         l37FIiB075keILVgh9arlsKZgZYig1WN90bMeguRknntSss/MbDbW9gBsqTJjSwagFd1
         6HQ72I1/pIyNd0jQ+FYn9d+Eu/6mRhGK2v+dYmMWfcQ6CbhOPxkAVMrzYuRGzIrIkmNC
         Qfiw==
X-Forwarded-Encrypted: i=1; AJvYcCWFLF5mkRDdstEi0XH3sJUlb9gRdeXbIhz3/2bDrFJs6NQeoQpsFOhgmTglXR4HL4jUHu53AjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZF+FBEjt7MTp/OyxK5oobt14uK+FOriEv15sTQ0r3illhcmPX
	XTgqHlozGGoVjKZdREd/IuoFdZ9ltc5iuCZcoQuQJoIfSi2XebtCetCx5V+1mr6SvBpUb1p6lKj
	pnPGH+TV1smdFa2ZfgcGzovdYCKI=
X-Gm-Gg: ASbGncsS1LUWAPKLrJC9aREyIwFPbhgzGPnqYc1V3OlUgm7Lm7bulqQyndPot2iR/wq
	TmFxBU+TQ7wLKTPLebgqy/Gc6NhcSReoMtMFevn9uyf9PCXXXf53VLSK8yB9iR+aaakMNg0Gdcz
	x5Fnrp8I133k9uKBx8xNRGGAqh/hLS5VKpEskV0LWw4DnCGtOtoOo8F8SjGtg=
X-Google-Smtp-Source: AGHT+IHj2DldmYNb+vFMuI0UItML9Rr7T4axXKJKfQdE4N+2H70KPJRbgYybnHQLMj/yV95+Q/agTtbnr2AEdJfGkfc=
X-Received: by 2002:a05:6e02:184a:b0:3d3:dd32:73d5 with SMTP id
 e9e14a558f8ab-3d3e6e23403mr186276425ab.4.1741101698784; Tue, 04 Mar 2025
 07:21:38 -0800 (PST)
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
 <2400a58c-5f1d-4fe1-a2db-4c7207613b39@ovn.org> <CADvbK_d+XrwV_mSQCgGE+vrrOmt373Gx6QN+uZOf_CbafVOyuA@mail.gmail.com>
 <f8b413f3-8f7c-41f8-867e-b72ecfa99429@ovn.org>
In-Reply-To: <f8b413f3-8f7c-41f8-867e-b72ecfa99429@ovn.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 4 Mar 2025 10:21:26 -0500
X-Gm-Features: AQ5f1JqaA7BFGFHOWK8X-G25lQWhld31jpPHjZzcUycp9f7tgG--g9hu9tU13dY
Message-ID: <CADvbK_fAkoMcMaLys-ks+4_vtSzhrp+50TJYTiCVf2oEh021zw@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label
 counting in conntrack
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jianbo Liu <jianbol@nvidia.com>, network dev <netdev@vger.kernel.org>, dev@openvswitch.org, 
	ovs-dev@openvswitch.org, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 8:23=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org> w=
rote:
>
> On 3/3/25 17:38, Xin Long wrote:
> > On Mon, Mar 3, 2025 at 5:56=E2=80=AFAM Ilya Maximets <i.maximets@ovn.or=
g> wrote:
> >>
> >> On 3/2/25 19:22, Xin Long wrote:
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
> >>>>>>>>     table=3D0,ip,actions=3Dct(commit,table=3D1)
> >>>>>>>>     table=3D1,ip,actions=3Dct(commit,exec(set_field:0xac->ct_lab=
el),table=3D2)
> >>>>>>>>
> >>>>>>>> it needs to make sure the label ext is created in the 1st flow b=
efore
> >>>>>>>> the ct is committed in ovs_ct_commit(). Otherwise, the warning i=
n
> >>>>>>>> nf_ct_ext_add() when creating the label ext in the 2nd flow will
> >>>>>>>> be triggered:
> >>>>>>>>
> >>>>>>>>      WARN_ON(nf_ct_is_confirmed(ct));
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
> >>> implement. However, since OVS is not supposed to use ct entries creat=
ed
> >>> externally,
> >>
> >> I'm not fully following this conversation, but this statement doesn't
> >> seem right.  OVS should be able to use ct entries created externally.
> >> i.e. if the packet already has some ct entry attached while entering
> >> OVS datapth, OVS should be able to match on the content of that entry.
> >>
> > Hi Ilya,
> >
> > Thank you for your comment.
> >
> > If OVS should use conntrack (ct) entries created externally, features
> > relying on NF_CT_EXT_XXX may not work on such entries. The NF_CT_EXT_LA=
BELS
> > extension discussed in this thread is one example. Other extensions lik=
e
> > NF_CT_EXT_HELPER, NF_CT_EXT_ECACHE, and NF_CT_EXT_TIMEOUT may also be
> > affected.
> >
> > If the ct entry already exists before the OVS flow with ct actions is
> > created, the entry might not have the required NF_CT_EXT extension as
> > it was not created with the tmpl set by OVS, even though the OVS flow
> > requests it.
>
> You're right about extensions and it makes sense that they are not actual=
ly
> available, since the data inside labels, for example, is specific for the
> application.  However, there are use cases for matching on the externally
> obtained ct state, which is available.  IIRC, we have a few tests in the
> main OVS system test suite that cover such scenarios.
>
Got it, thank you for the explanation.

> >
> > As far as I know, using a separate conntrack zone to avoid reusing the
> > existing ct entry can work around this issue.
> >
> > Let me know if I missed something, or do you have any better solutions?
> >
> > Thanks.
> >
> >>> I believe ct zones can be used to prevent this issue.
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
> >>> Thanks.
> >>>>>
> >>>>>>
> >>>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntra=
ck.c
> >>>>>> index 3bb4810234aa..c599ee013dfe 100644
> >>>>>> --- a/net/openvswitch/conntrack.c
> >>>>>> +++ b/net/openvswitch/conntrack.c
> >>>>>> @@ -595,6 +595,11 @@ static bool skb_nfct_cached(struct net *net,
> >>>>>>               rcu_dereference(timeout_ext->timeout))
> >>>>>>               return false;
> >>>>>>       }
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
> >>>>>>>>    net/openvswitch/conntrack.c | 30 ++++++++++++----------------=
--
> >>>>>>>>    net/openvswitch/datapath.h  |  3 ---
> >>>>>>>>    2 files changed, 12 insertions(+), 21 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/connt=
rack.c
> >>>>>>>> index 8eb1d644b741..a3da5ee34f92 100644
> >>>>>>>> --- a/net/openvswitch/conntrack.c
> >>>>>>>> +++ b/net/openvswitch/conntrack.c
> >>>>>>>> @@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum =
ovs_key_attr attr)
> >>>>>>>>            attr =3D=3D OVS_KEY_ATTR_CT_MARK)
> >>>>>>>>                return true;
> >>>>>>>>        if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
> >>>>>>>> -         attr =3D=3D OVS_KEY_ATTR_CT_LABELS) {
> >>>>>>>> -             struct ovs_net *ovs_net =3D net_generic(net, ovs_n=
et_id);
> >>>>>>>> -
> >>>>>>>> -             return ovs_net->xt_label;
> >>>>>>>> -     }
> >>>>>>>> +         attr =3D=3D OVS_KEY_ATTR_CT_LABELS)
> >>>>>>>> +             return true;
> >>>>>>>>
> >>>>>>>>        return false;
> >>>>>>>>    }
> >>>>>>>> @@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, co=
nst struct nlattr *attr,
> >>>>>>>>                       const struct sw_flow_key *key,
> >>>>>>>>                       struct sw_flow_actions **sfa,  bool log)
> >>>>>>>>    {
> >>>>>>>> +     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) *=
 BITS_PER_BYTE;
> >>>>>>>>        struct ovs_conntrack_info ct_info;
> >>>>>>>>        const char *helper =3D NULL;
> >>>>>>>>        u16 family;
> >>>>>>>> @@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, c=
onst struct nlattr *attr,
> >>>>>>>>                return -ENOMEM;
> >>>>>>>>        }
> >>>>>>>>
> >>>>>>>> +     if (nf_connlabels_get(net, n_bits - 1)) {
> >>>>>>>> +             nf_ct_tmpl_free(ct_info.ct);
> >>>>>>>> +             OVS_NLERR(log, "Failed to set connlabel length");
> >>>>>>>> +             return -EOPNOTSUPP;
> >>>>>>>> +     }
> >>>>>>>> +
> >>>>>>>>        if (ct_info.timeout[0]) {
> >>>>>>>>                if (nf_ct_set_timeout(net, ct_info.ct, family, ke=
y->ip.proto,
> >>>>>>>>                                      ct_info.timeout))
> >>>>>>>> @@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ov=
s_conntrack_info *ct_info)
> >>>>>>>>        if (ct_info->ct) {
> >>>>>>>>                if (ct_info->timeout[0])
> >>>>>>>>                        nf_ct_destroy_timeout(ct_info->ct);
> >>>>>>>> +             nf_connlabels_put(nf_ct_net(ct_info->ct));
> >>>>>>>>                nf_ct_tmpl_free(ct_info->ct);
> >>>>>>>>        }
> >>>>>>>>    }
> >>>>>>>> @@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_famil=
y __ro_after_init =3D {
> >>>>>>>>
> >>>>>>>>    int ovs_ct_init(struct net *net)
> >>>>>>>>    {
> >>>>>>>> -     unsigned int n_bits =3D sizeof(struct ovs_key_ct_labels) *=
 BITS_PER_BYTE;
> >>>>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>>>        struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> >>>>>>>>
> >>>>>>>> -     if (nf_connlabels_get(net, n_bits - 1)) {
> >>>>>>>> -             ovs_net->xt_label =3D false;
> >>>>>>>> -             OVS_NLERR(true, "Failed to set connlabel length");
> >>>>>>>> -     } else {
> >>>>>>>> -             ovs_net->xt_label =3D true;
> >>>>>>>> -     }
> >>>>>>>> -
> >>>>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>>>        return ovs_ct_limit_init(net, ovs_net);
> >>>>>>>>    #else
> >>>>>>>>        return 0;
> >>>>>>>> @@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
> >>>>>>>>
> >>>>>>>>    void ovs_ct_exit(struct net *net)
> >>>>>>>>    {
> >>>>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>>>        struct ovs_net *ovs_net =3D net_generic(net, ovs_net_id);
> >>>>>>>>
> >>>>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>>>        ovs_ct_limit_exit(net, ovs_net);
> >>>>>>>>    #endif
> >>>>>>>> -
> >>>>>>>> -     if (ovs_net->xt_label)
> >>>>>>>> -             nf_connlabels_put(net);
> >>>>>>>>    }
> >>>>>>>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapa=
th.h
> >>>>>>>> index 9ca6231ea647..365b9bb7f546 100644
> >>>>>>>> --- a/net/openvswitch/datapath.h
> >>>>>>>> +++ b/net/openvswitch/datapath.h
> >>>>>>>> @@ -160,9 +160,6 @@ struct ovs_net {
> >>>>>>>>    #if IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >>>>>>>>        struct ovs_ct_limit_info *ct_limit_info;
> >>>>>>>>    #endif
> >>>>>>>> -
> >>>>>>>> -     /* Module reference for configuring conntrack. */
> >>>>>>>> -     bool xt_label;
> >>>>>>>>    };
> >>>>>>>>
> >>>>>>>>    /**
> >>>>>>>
> >>>>>
> >>
>

