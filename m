Return-Path: <netdev+bounces-307734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MGh9Ir9yV2rdOAEAu9opvQ
	(envelope-from <netdev+bounces-307734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:45:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E357C75DAE4
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:45:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ih56SBsR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307734-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307734-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49393304B987
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B8C20E023;
	Wed, 15 Jul 2026 11:41:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541643C7A1
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 11:41:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115713; cv=none; b=WIOc00g3D17uccUuwTxTEcpr3gOXNwrYlRfdLCjz/mNyeSDylMcLy5ztgKFpcfh3celylGMroM++B3jGvHjMOOFQiKCiA9gazMvO7VnkWSiVuXSRkIy4XwTArKBZyiui2H3FiVgdUnAk94Kza/mDU7KTxi1vDx1dkDjZJtxuqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115713; c=relaxed/simple;
	bh=bLS/bR0SrbQYoGBrq7r9Xq4NACvEp9nLXAijXR6HMpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Au13WTD84Yp7SrS0AYEWTjzRXfuhas7QYTUzpsw8cgYl8gUf2LzJauEson2ntD1kawiZjMN+q3dj566an0iOzefhu/4mCzm6yN0hYIDpt57FljwJoeqfocJx/ZjLcaB3Qsi3HFlZxPOFG2SsOMCke6RwJhOWK0T/ZPzpG9gQmXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ih56SBsR; arc=none smtp.client-ip=209.85.222.47
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-973b676f7efso1199989241.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784115710; x=1784720510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOZEHRsNIdbtY0UVrJhkxwUHUpefVoXkjEaudqB5kLg=;
        b=Ih56SBsR8SxYs4CvRCR3ISr7snHxFNt0untaR7hjnNGUCKysPaKrjCHQkBhvhWZGPn
         Xd5ZEgmS7+vbV667rrSmp5yol8LGqJ+Cnd7JqQO4cNuMJN5Pme5wDRr0sek9kXozAUVW
         r9IDFo1qY3bFPeYaHiVjrEr+hXBYG3GBI0/Tde3bsYv5dy1zAkk+iUMWZk6KjetGn+CC
         CX+dt/O1jejen28v0gq5NLH2iBIiZhcd7ROQiZVJ8ApD7qnx/Ek3H8MS2RHZwk30l50z
         Fy5qnhlKHGhGyOoSCadZ4swigGYcbjqs5eerdk+AsSz9IjuEdBJD9dLaStzDoYcDeuIW
         aRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784115710; x=1784720510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOZEHRsNIdbtY0UVrJhkxwUHUpefVoXkjEaudqB5kLg=;
        b=rjDbRWVbFMjerZCmEmshR+FSCphKjVX39pJSB9T3mnQocm1Hf6UCJWyGPjU9kE6gE2
         gYj3AO4zWoyz8RycXlCE0h9Dif20/MddlBok1MDAH0fht4d9RyqzqqIKOzSBG8PLHYzs
         IhQ6lqEBM+xfeR1jiJQQyA0IgQ3P5z2N5esou5crvH70mcmbGGKDn1wIEdJgC2meKm3E
         FK4azvuQmncEwvOHtF/7ZWKN1doFSnVBsJ4DRSv0Z6xqowy7QSdS5aQCpo336+QPKDuS
         NYpEBgV4QZ1XOQUIVBKfjSF2gHvG4MGgoIYVzEOH2TlOlS0gj4WKve4Q3I5VBZYWuSTG
         Ks3w==
X-Gm-Message-State: AOJu0YyKefJxm3ifPQA0U/qZz5EqdP5WqGoKR010Kn3Utwhzhj1x1R7I
	wzXlqWaDMBiq89dbNbO1mNBvu0ryszATNQJfvk78fyA5JcFUfgDxLpZm0teuhBO2SWs=
X-Gm-Gg: AfdE7cmRV5SV1qDaqirUbviIezx+q8iXhTz8u1HZ1GcwFIKNlBDZbskK2+D8FSWlaPG
	L9q1dFBSz8uY94yq3jLWJhR4pqSxtSuPeSKJsm5wqmoBV2e7RHmR3U2595NnWYI0eCC59tO15MC
	CB8CZWqdcaVtu/VJQnyPoHyaTSrCSTNRyyag2z/vOjFUlIUH8sG900On0W40s9L5qw/6baPlavE
	dt6TJgyaxOjbMor1l3ysrgLjYxOXWMjVz5rusKZ092rj54eSfk/LJjEmuwS/Y5hzbQawv2MS/Hn
	ugTBL4Call+VOwFq8AWfExARZWozs1w2T5kcG776wWrF422Ya4/7go47FAG29Z5sNQ/tWjT6a9B
	gIQaPS6ELRiDyCAzZtPhdCnVY6B5akXlMGe9beCYnOO2Gy1z8RDIZyl7ICnNx9guDGGtWTd5HDR
	1NMgk4/w==
X-Received: by 2002:a05:6102:4413:b0:738:9c79:750c with SMTP id ada2fe7eead31-74599fb7e64mr1263732137.15.1784115710049;
        Wed, 15 Jul 2026 04:41:50 -0700 (PDT)
Received: from beelink.. ([46.183.108.35])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6a90d4fsm12279341137.5.2026.07.15.04.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 04:41:49 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH net v2] net/sched: serialize qdisc_rtab_list against concurrent get/put
Date: Wed, 15 Jul 2026 08:41:14 -0300
Message-ID: <20260715114114.446841-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89iLFBPHjjOZg5p7b=-vA++17oBLCJtGi8aJXnfJ3j67J1g@mail.gmail.com>
References: <CAP48HfvFnArD5hDW8gCAWrp4Hz8Pbh7m3A8F6DiPtLYq45WOBg@mail.gmail.com> <CAM0EoMntb24oXpBW-pAYVX1WYTNnTU9eJLe-cvoiD-GGdW-Rkw@mail.gmail.com> <CANn89iK63bSCL3MPBQKiYEwYfioNYkvTBYVL8cavM2THQbPyhA@mail.gmail.com> <CANn89i+6K3TrAx0Jq_6Z+OtLBt6DhV6_dNjU5U6m6epucPzVVg@mail.gmail.com> <CANn89iLFBPHjjOZg5p7b=-vA++17oBLCJtGi8aJXnfJ3j67J1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-307734-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:qwe.aldo@gmail.com,m:qwealdo@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[qwealdo@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qwealdo@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E357C75DAE4

qdisc_get_rtab() and qdisc_put_rtab() mutate the process-global singly
linked list qdisc_rtab_list and a plain non-atomic 'int refcnt' with no
lock. This was only safe because every caller historically held the RTNL
mutex, which serialized all rate-table lookups, inserts and frees.

That invariant no longer holds. cls_flower sets
TCF_PROTO_OPS_DOIT_UNLOCKED, so tc_new_tfilter() keeps rtnl_held == false
for it and sets TCA_ACT_FLAGS_NO_RTNL. That flag propagates through
tcf_exts_validate_ex() -> tcf_action_init() -> tcf_action_init_1() ->
tcf_police_init(), which calls qdisc_get_rtab()/qdisc_put_rtab() with the
RTNL mutex NOT held. Two RTM_NEWTFILTER requests on different CPUs, each
adding a flower filter with a police action carrying the same rate, then
race on qdisc_rtab_list and on the non-atomic refcnt, leading to a
use-after-free / double-free of the kmalloc-2k struct qdisc_rate_table.
qdisc_rtab_list is a single global (not per-netns), so the corrupted
object is shared system-wide.

  BUG: KASAN: slab-use-after-free in qdisc_put_rtab+0x12f/0x160
   qdisc_put_rtab+0x12f/0x160
   tcf_police_init+0xda9/0x1590
   tcf_action_init_1+0x460/0x6b0
   tcf_action_init+0x439/0xa40
   tcf_exts_validate_ex+0x42d/0x550
   fl_change+0xddd/0x7da0
   tc_new_tfilter+0xaa7/0x2420
   rtnetlink_rcv_msg+0x95e/0xe90
  which belongs to the cache kmalloc-2k of size 2048

Protect qdisc_rtab_list and the refcount with a dedicated spinlock. The
(sleeping, GFP_KERNEL) allocation in qdisc_get_rtab() is performed before
taking the lock; if a concurrent inserter added an identical table in the
meantime the freshly allocated one is freed under the lock, so no
duplicate is leaked. qdisc_put_rtab() now decrements the refcount and
unlinks under the same lock.

Fixes: 470502de5bdb ("net: sched: unlock rules update API")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: stable@vger.kernel.org
---

v2:
 - Rework qdisc_get_rtab() to allocate before taking the lock and free the
   surplus table under the lock instead of dropping the lock to allocate
   and re-scanning (Eric Dumazet).
 - Add Fixes: tag and Cc: stable.
 - Build-tested (CONFIG_NET_SCHED=y).

v1 was sent privately to security@kernel.org on 2026-07-11; moving to the
public list now that a fix is ready, as requested.
 net/sched/sch_api.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 8a3236456db4..668bcd60d183 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -415,12 +415,13 @@ static __u8 __detect_linklayer(struct tc_ratespec *r, __u32 *rtab)
 }
 
 static struct qdisc_rate_table *qdisc_rtab_list;
+static DEFINE_SPINLOCK(qdisc_rtab_lock);
 
 struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 					struct nlattr *tab,
 					struct netlink_ext_ack *extack)
 {
-	struct qdisc_rate_table *rtab;
+	struct qdisc_rate_table *rtab, *new_rtab;
 
 	if (tab == NULL || r->rate == 0 ||
 	    r->cell_log == 0 || r->cell_log >= 32 ||
@@ -429,15 +430,20 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 		return NULL;
 	}
 
+	new_rtab = kmalloc_obj(*new_rtab);
+
+	spin_lock(&qdisc_rtab_lock);
 	for (rtab = qdisc_rtab_list; rtab; rtab = rtab->next) {
 		if (!memcmp(&rtab->rate, r, sizeof(struct tc_ratespec)) &&
 		    !memcmp(&rtab->data, nla_data(tab), TC_RTAB_SIZE)) {
 			rtab->refcnt++;
+			spin_unlock(&qdisc_rtab_lock);
+			kfree(new_rtab);
 			return rtab;
 		}
 	}
 
-	rtab = kmalloc_obj(*rtab);
+	rtab = new_rtab;
 	if (rtab) {
 		rtab->rate = *r;
 		rtab->refcnt = 1;
@@ -449,6 +455,7 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 	} else {
 		NL_SET_ERR_MSG(extack, "Failed to allocate new qdisc rate table");
 	}
+	spin_unlock(&qdisc_rtab_lock);
 	return rtab;
 }
 EXPORT_SYMBOL(qdisc_get_rtab);
@@ -457,18 +464,25 @@ void qdisc_put_rtab(struct qdisc_rate_table *tab)
 {
 	struct qdisc_rate_table *rtab, **rtabp;
 
-	if (!tab || --tab->refcnt)
+	if (!tab)
 		return;
 
+	spin_lock(&qdisc_rtab_lock);
+	if (--tab->refcnt) {
+		spin_unlock(&qdisc_rtab_lock);
+		return;
+	}
+
 	for (rtabp = &qdisc_rtab_list;
 	     (rtab = *rtabp) != NULL;
 	     rtabp = &rtab->next) {
 		if (rtab == tab) {
 			*rtabp = rtab->next;
-			kfree(rtab);
-			return;
+			break;
 		}
 	}
+	spin_unlock(&qdisc_rtab_lock);
+	kfree(tab);
 }
 EXPORT_SYMBOL(qdisc_put_rtab);
 
-- 
2.43.0


