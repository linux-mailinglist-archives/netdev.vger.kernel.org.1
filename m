Return-Path: <netdev+bounces-242595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7A4C9270D
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 16:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7A02344AD3
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8FD21A447;
	Fri, 28 Nov 2025 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="c4H67pCP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B856B79CD
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764343177; cv=none; b=nWWcRj9dUR4rGtC43Mu1sPY/PJIQmbi/RrqIbVP7H4la64ND7m7gHWN1pHczeYo97c7t6PNYwp0fmqEoTVxrjhdszHnGye31OOjdAdnO3uZxorll5VZtTvF9xrkRKBW2Bdrfxy/LoqqJEkdlUt0lWUGQM01jn2xlxSRh/x8OgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764343177; c=relaxed/simple;
	bh=Ff5mZRMv+LV2zexrZIF7VaAYw3I7WUiKLILz0zkpgwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LnMKH85z7sFObRs9NlBkqVBfVbOR4p6QFa5cz2yNhDvTGWeQTYyxd3Tc+xOSXXOjkbOQIiO9n5fkNXk34KwEgI3Mzosde1Il9U8wTZx0PGygDoutU7ld7S3Bl3yfrt/iHaj4PeLwj51fFRVMLbJ/5xcfHGffIoU1U6RdkkQoVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=c4H67pCP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b23b6d9f11so162878185a.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 07:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764343175; x=1764947975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=smxYRzT0ovnvItdXzA9aSf3moHBALvJKEBil1+/46V8=;
        b=c4H67pCPtgd963NJOvjkDdE9CDBEvKLoYaNr4cc2o9ET7tUPP9naf1595MQMVUtO6l
         v4cwmjghE7juA0OPgcBm6yUvqhb08pMzvtmVpTh43A0btD/rp3vfqFvN8VOp2GScN52W
         JdOP4TDKCnXprGSRi1StSydGxndNIFIeMvTgcsB6lMBOK0PB40dmzfCq4NOZucGxAXeJ
         Qm4L8vUJNvuVOhYZmbWMPEZqZxc8H41dam21ugovi0p8gM+42VYHHLPwOQdv9I0X8jdi
         7ipxuOyk8f70SLBdG7vkQwij9/yZLhnlQcMBw3BqrVxk8HF8xWE2MPTAyrn8kXkVcARq
         qmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764343175; x=1764947975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smxYRzT0ovnvItdXzA9aSf3moHBALvJKEBil1+/46V8=;
        b=urRS6urflU/G4yoi+Z1pWqlH+ASl6oao7KySXOy0NlzHLg9ohL1eP6SMbcdzUUPLnL
         ZW2yCq3NIIAyklH2jgXvK5Xg0WKki2nWEyW8g9oKA0bwm/ddYmu4c54+aKkuB/eK7s7X
         VQ0sel0MwtmNx/OTbM5BXL4bN4v1Uga+l2Gb4pV3PUGrcxTRW6t9GrHmq8dRIogXGo5n
         9ZKbZbZeLETOQcqcx6zTZ23wcOJrVoJPzEFQ2I0vOM6vnO39Sdkxq4a+h6YJeI7HTyhr
         KYjKwcsPKW/TnZuoLHP8VnBMJvojFTD9shRnsubGBTLXdy5icEgJgiMIoC+5YwHFbb6B
         OunQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCWs0pcixNMP1l0gyIWQJukQ0VEf6Jp0HJfrn+FL72+DBdWtUC7edGjuGB6hWfgAQlCFgTpQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbG+q9CFKCSAiIg/G1RJXY8kFrWyHGbk/zHwOhLRSRJMgcaE9q
	qDRBF5mMFWgZZ5+jsefRR5PbqOpk2IwJ8mQkCwqItkz69KlKiBOKMYJPNJOpPHgYpQckyZWlWOu
	KFc06jg==
X-Gm-Gg: ASbGnctIhJJvwAJHmEuESK5B2SyeOuv0ryQl1NBjfqbZVeeTprZTmZxcjxDpGDSSwUw
	xwRemkkuDVJp3Pye6JSeNOpoA6q//l2x8Dkb0lnLKXIoC4v87397dsI9wsrRajdIMUn6HBFyAdj
	Sb4fvefsksaChcq9sbyH8LeVZnvFoMJvVflwH4AGPZz1RYUL9tNb5m8a+ADDHwnW9+dmMXaby2f
	vrHmnkE8hLx7MK5X+HRAtBxnKE0IDQwgvTz30qmDiL5aCT32CL/nfMCKcCtEmyZdJHBczZtvXW8
	qwYw07rPRjxjXHzHspH5h4NGC+IJho/bIPueY4t8UR6uiQGlJkC905I0f554xZl5HGXyWbxSdJy
	NV5rc6vG9E5Nfywa2qYDGmGk3FwKYmQUrckJW88fMTSCIztHgxR9cFbsfJI5rqceJ1o8csh2Ur5
	G5n7NHI14LL/miA08beIOslQ==
X-Google-Smtp-Source: AGHT+IH+seoWPbpBkN/NLnmNFDU8M3ELaihmyX9ZRgUl6vWuebw5kUzkbcF17MaZbgXr4sMwJayNKg==
X-Received: by 2002:a05:620a:4054:b0:8aa:1761:6e18 with SMTP id af79cd13be357-8b33d1b24b0mr3284295885a.4.1764343174008;
        Fri, 28 Nov 2025 07:19:34 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1df6b9sm319979385a.53.2025.11.28.07.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 07:19:33 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	horms@kernel.org,
	dcaratti@redhat.com,
	zdi-disclosures@trendmicro.com,
	w@1wt.eu,
	security@kernel.org,
	tglx@linutronix.de,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net] net/sched: ets: Always remove class from active list before deleting in ets_qdisc_change
Date: Fri, 28 Nov 2025 10:19:19 -0500
Message-Id: <20251128151919.576920-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zdi-disclosures@trendmicro.com says:

The vulnerability is a race condition between `ets_qdisc_dequeue` and
`ets_qdisc_change`.  It leads to UAF on `struct Qdisc` object.
Attacker requires the capability to create new user and network namespace
in order to trigger the bug.
See my additional commentary at the end of the analysis.

Analysis:

static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
                          struct netlink_ext_ack *extack)
{
...

      // (1) this lock is preventing .change handler (`ets_qdisc_change`)
      //to race with .dequeue handler (`ets_qdisc_dequeue`)
      sch_tree_lock(sch);

      for (i = nbands; i < oldbands; i++) {
              if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
                      list_del_init(&q->classes[i].alist);
              qdisc_purge_queue(q->classes[i].qdisc);
      }

      WRITE_ONCE(q->nbands, nbands);
      for (i = nstrict; i < q->nstrict; i++) {
              if (q->classes[i].qdisc->q.qlen) {
		      // (2) the class is added to the q->active
                      list_add_tail(&q->classes[i].alist, &q->active);
                      q->classes[i].deficit = quanta[i];
              }
      }
      WRITE_ONCE(q->nstrict, nstrict);
      memcpy(q->prio2band, priomap, sizeof(priomap));

      for (i = 0; i < q->nbands; i++)
              WRITE_ONCE(q->classes[i].quantum, quanta[i]);

      for (i = oldbands; i < q->nbands; i++) {
              q->classes[i].qdisc = queues[i];
              if (q->classes[i].qdisc != &noop_qdisc)
                      qdisc_hash_add(q->classes[i].qdisc, true);
      }

      // (3) the qdisc is unlocked, now dequeue can be called in parallel
      // to the rest of .change handler
      sch_tree_unlock(sch);

      ets_offload_change(sch);
      for (i = q->nbands; i < oldbands; i++) {
	      // (4) we're reducing the refcount for our class's qdisc and
	      //  freeing it
              qdisc_put(q->classes[i].qdisc);
	      // (5) If we call .dequeue between (4) and (5), we will have
	      // a strong UAF and we can control RIP
              q->classes[i].qdisc = NULL;
              WRITE_ONCE(q->classes[i].quantum, 0);
              q->classes[i].deficit = 0;
              gnet_stats_basic_sync_init(&q->classes[i].bstats);
              memset(&q->classes[i].qstats, 0, sizeof(q->classes[i].qstats));
      }
      return 0;
}

Comment:
This happens because some of the classes have their qdiscs assigned to
NULL, but remain in the active list. This commit fixes this issue by always
removing the class from the active list before deleting and freeing its
associated qdisc

Reproducer Steps
(trimmed version of what was sent by zdi-disclosures@trendmicro.com)

```
DEV="${DEV:-lo}"
ROOT_HANDLE="${ROOT_HANDLE:-1:}"
BAND2_HANDLE="${BAND2_HANDLE:-20:}"   # child under 1:2
PING_BYTES="${PING_BYTES:-48}"
PING_COUNT="${PING_COUNT:-200000}"
PING_DST="${PING_DST:-127.0.0.1}"

SLOW_TBF_RATE="${SLOW_TBF_RATE:-8bit}"
SLOW_TBF_BURST="${SLOW_TBF_BURST:-100b}"
SLOW_TBF_LAT="${SLOW_TBF_LAT:-1s}"

cleanup() {
  tc qdisc del dev "$DEV" root 2>/dev/null
}
trap cleanup EXIT

ip link set "$DEV" up

tc qdisc del dev "$DEV" root 2>/dev/null || true

tc qdisc add dev "$DEV" root handle "$ROOT_HANDLE" ets bands 2 strict 2

tc qdisc add dev "$DEV" parent 1:2 handle "$BAND2_HANDLE" \
  tbf rate "$SLOW_TBF_RATE" burst "$SLOW_TBF_BURST" latency "$SLOW_TBF_LAT"

tc filter add dev "$DEV" parent 1: protocol all prio 1 u32 match u32 0 0 flowid 1:2
tc -s qdisc ls dev $DEV

ping -I "$DEV" -f -c "$PING_COUNT" -s "$PING_BYTES" -W 0.001 "$PING_DST" \
  >/dev/null 2>&1 &
tc qdisc change dev "$DEV" root handle "$ROOT_HANDLE" ets bands 2 strict 0
tc qdisc change dev "$DEV" root handle "$ROOT_HANDLE" ets bands 2 strict 2
tc -s qdisc ls dev $DEV
tc qdisc del dev "$DEV" parent 1:2 || true
tc -s qdisc ls dev $DEV
tc qdisc change dev "$DEV" root handle "$ROOT_HANDLE" ets bands 1 strict 1
```

KASAN report
```
==================================================================
BUG: KASAN: slab-use-after-free in ets_qdisc_dequeue+0x1071/0x11b0 kernel/net/sched/sch_ets.c:481
Read of size 8 at addr ffff8880502fc018 by task ping/12308
>
CPU: 0 UID: 0 PID: 12308 Comm: ping Not tainted 6.18.0-rc4-dirty #1 PREEMPT(full)
Hardware name: QEMU Ubuntu 25.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack kernel/lib/dump_stack.c:94
 dump_stack_lvl+0x100/0x190 kernel/lib/dump_stack.c:120
 print_address_description kernel/mm/kasan/report.c:378
 print_report+0x156/0x4c9 kernel/mm/kasan/report.c:482
 kasan_report+0xdf/0x110 kernel/mm/kasan/report.c:595
 ets_qdisc_dequeue+0x1071/0x11b0 kernel/net/sched/sch_ets.c:481
 dequeue_skb kernel/net/sched/sch_generic.c:294
 qdisc_restart kernel/net/sched/sch_generic.c:399
 __qdisc_run+0x1c9/0x1b00 kernel/net/sched/sch_generic.c:417
 __dev_xmit_skb kernel/net/core/dev.c:4221
 __dev_queue_xmit+0x2848/0x4410 kernel/net/core/dev.c:4729
 dev_queue_xmit kernel/./include/linux/netdevice.h:3365
[...]

Allocated by task 17115:
 kasan_save_stack+0x30/0x50 kernel/mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 kernel/mm/kasan/common.c:77
 poison_kmalloc_redzone kernel/mm/kasan/common.c:400
 __kasan_kmalloc+0xaa/0xb0 kernel/mm/kasan/common.c:417
 kasan_kmalloc kernel/./include/linux/kasan.h:262
 __do_kmalloc_node kernel/mm/slub.c:5642
 __kmalloc_node_noprof+0x34e/0x990 kernel/mm/slub.c:5648
 kmalloc_node_noprof kernel/./include/linux/slab.h:987
 qdisc_alloc+0xb8/0xc30 kernel/net/sched/sch_generic.c:950
 qdisc_create_dflt+0x93/0x490 kernel/net/sched/sch_generic.c:1012
 ets_class_graft+0x4fd/0x800 kernel/net/sched/sch_ets.c:261
 qdisc_graft+0x3e4/0x1780 kernel/net/sched/sch_api.c:1196
[...]

Freed by task 9905:
 kasan_save_stack+0x30/0x50 kernel/mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 kernel/mm/kasan/common.c:77
 __kasan_save_free_info+0x3b/0x70 kernel/mm/kasan/generic.c:587
 kasan_save_free_info kernel/mm/kasan/kasan.h:406
 poison_slab_object kernel/mm/kasan/common.c:252
 __kasan_slab_free+0x5f/0x80 kernel/mm/kasan/common.c:284
 kasan_slab_free kernel/./include/linux/kasan.h:234
 slab_free_hook kernel/mm/slub.c:2539
 slab_free kernel/mm/slub.c:6630
 kfree+0x144/0x700 kernel/mm/slub.c:6837
 rcu_do_batch kernel/kernel/rcu/tree.c:2605
 rcu_core+0x7c0/0x1500 kernel/kernel/rcu/tree.c:2861
 handle_softirqs+0x1ea/0x8a0 kernel/kernel/softirq.c:622
 __do_softirq kernel/kernel/softirq.c:656
[...]

Commentary:

1. Maher Azzouzi working with Trend Micro Zero Day Initiative was reported as
the person who found the issue. I requested to get a proper email to add to the
reported-by tag but got no response. For this reason i will credit the person
i exchanged emails with i.e zdi-disclosures@trendmicro.com

2. Neither i nor Victor who did a much more thorough testing was able to
reproduce a UAF with the PoC or other approaches we tried. We were both able to
reproduce a null ptr deref. After exchange with zdi-disclosures@trendmicro.com
they sent a small change to be made to the code to add an extra delay which
was able to simulate the UAF. i.e, this:
   qdisc_put(q->classes[i].qdisc);
   mdelay(90);
   q->classes[i].qdisc = NULL;

I was informed by Thomas Gleixner(tglx@linutronix.de) that adding delays was
acceptable approach for demonstrating the bug, quote:
"Adding such delays is common exploit validation practice"
The equivalent delay could happen "by virt scheduling the vCPU out, SMIs,
NMIs, PREEMPT_RT enabled kernel"

3. I asked the OP to test and report back but got no response and after a
few days gave up and proceeded to submit this fix.

Fixes: de6d25924c2a ("net/sched: sch_ets: don't peek at classes beyond 'nbands'")
Reported-by: zdi-disclosures@trendmicro.com
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_ets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 82635dd2cfa5..ae46643e596d 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -652,7 +652,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	sch_tree_lock(sch);
 
 	for (i = nbands; i < oldbands; i++) {
-		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
+		if (cl_is_active(&q->classes[i]))
 			list_del_init(&q->classes[i].alist);
 		qdisc_purge_queue(q->classes[i].qdisc);
 	}
-- 
2.34.1


