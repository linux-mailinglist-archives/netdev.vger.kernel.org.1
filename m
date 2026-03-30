Return-Path: <netdev+bounces-273124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GyaIyhVymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:49:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DFE359A66
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 260023008200
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F33BA259;
	Mon, 30 Mar 2026 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apveyVId"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB73BD23B
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867440; cv=none; b=qww40dpSEhwMgF6IPruTwbodzJ3nR4wbrnGEy0g/FuicxESG9Yk74jN7PGP/wm1VSUPBuAtpBa5YJ52BboY+tsJNqJEqAgDLpk/J0UZNfsaSuvTxzmgFLkaOXornNol9D6YzwHsSmZ4fIZ/kcHet62ZTrLjTqbBK5DOYvkceJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867440; c=relaxed/simple;
	bh=0NaCRr9qEPpuUE1FAw5AixgLvtREFNQs0j4yj3eOJ2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBkEaHrBCO4/vUH8z9+2sMWe7Dp6hjQ0QhbeTRR2IhA4T8Hk8ss+GSE2FUlGDRm30desB8/d4fG6aDPNBS1nWgFaoBisAoQcKnUmrSsNir9m8P6d5H4w7N45Ga5dixrL+ocaTQjOqRLntK1CWoJqWpS6156wokySvprg5rFb8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apveyVId; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b258576d8cso2946475ad.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 03:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774867439; x=1775472239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nfMTusRMBUcug+NPUw9SapTsWZw2E0CZcmoh/QoIp0=;
        b=apveyVIdikiaoUscz3u+fGhbovMldQhSqwseWtvwRosvbSGtxKqUw05DBoRCKecIIK
         Je7u8DC1qYQvcYbotfIShJ5S0wp1Y511R0SlpzohXCdKe888NEJsdT3GvQ6Einh2WQKF
         9bzRW44mKltY7fdMOaOMbbxJgTZXvB0S6LhrMPAd4PojTEfNHqb4ONqGPu17wrSwxRBG
         7e7Q2/cmrIyaTBb7Y5A8Vekv+9lGH6Vz0Dt8FrQnNxOFNzf7AO8XryGxPAqBqeKTOHO+
         s2Dz+uhO6/utnrpPMmAz3vzbxaXnHI0Y67Dftkq1yw5X8TcKXsumc1dzsp6LSFqikBxq
         xL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774867439; x=1775472239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nfMTusRMBUcug+NPUw9SapTsWZw2E0CZcmoh/QoIp0=;
        b=DMsIjeAUzoaUifn3fM0DcZ1jcLQPOeyywKjR9blSDreKHaHOgzJvkJz6orP7w9gb9i
         ISesMfxcJGRLGbIxWrPk3Sh2BveFBVur58Nk+bz2gdI5A2dFHjXIUZN1K3AH78BGAuA3
         o8+N9qxRnJo4zv36BVMiiCwIvo0r64GIWjosbSzEk+J99JzSbPpVoz011EZTH47HRRoc
         9S5hBT+Vpdq4h0MF9HHHyKO4Sti8WnnoQ9H6QzJLQ5O99tqR3AgMmU9ulhhpXfzCL72V
         QYCc05a5S3hJGv3uFGmXI82rNDg6ICx9fuMNHooZeIBq56D5hRRbEEcWylFI7uyKvOmd
         xaKA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9RqPGSTEw+LZ59caRX6Me0aVKkZN3n2JhcuUcgzagC1Y/IoKN49376YEcmminv+r5nfsirI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkuFirzUADe4I+ya/RaVtr4haAky5TWFXR1NDHLvq0RrX4iMk
	vBaA/gMqXvQie/JHrqdQdEgCXbMhltB+kdFuw1gKSQCdj7ZwiYeIPioa
X-Gm-Gg: ATEYQzzqvk2pMZ5jrVfp2dZeG7T/rvY8/JtqwgTzMr+gm2Czrmx+sDsLBR139UqmJ28
	uJ0rd80aTBdruqvsajUisvbAnO1ILVLT+1RkLmG7HMMU5HSP/+GrLhfMtmIVTK481LIRyE2thLP
	LDxEQr5A9VMhfJ6N/75x/arX6dvorXfHPVPY/pE5ArB+lo0I9Ppz7Y4Luvk1ysNCAIBxtDG2eIT
	yg6TvcgJnvZT2/F+J9M+A8PfTbWAP3bB3m/UNUldd/XNoLvX764Hx3DIelmKtj3AOKO6Uoq2/oI
	n0oFoSFaq2KwoCkTJ6/HTi4g89nz8q0olFbcQoHGXs0E3XJm9OW7YAO6fhGeyONPjOkhg6OoP0P
	zFR9hNU5HZ5F0jidnadN3bNYvvOIEnQBWRoj8MnZ+fvVNdrPkAW0Cshz1sTh0N25UqgX8UBQ7Qb
	T9jF22myIL69SSFOBvi2Z2aBD0d0GidllxNmT3Q0h7WppZCMNnJRd/PSvQXCVDEcqrVHT1lzbWt
	7DtYiEWqINf
X-Received: by 2002:a17:902:f542:b0:2aa:d5e5:b136 with SMTP id d9443c01a7336-2b0cdd7bb09mr126049405ad.38.1774867438367;
        Mon, 30 Mar 2026 03:43:58 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642864sm88311575ad.12.2026.03.30.03.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:43:57 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: taprio: fix NULL pointer dereference in class dump
Date: Mon, 30 Mar 2026 18:29:08 +0800
Message-ID: <20260330102904.2677818-5-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-273124-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: E4DFE359A66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a TAPRIO child qdisc is deleted via RTM_DELQDISC, taprio_graft()
is called with new == NULL and stores NULL into q->qdiscs[cl - 1].
Subsequent RTM_GETTCLASS dump operations walk all classes via
taprio_walk() and call taprio_dump_class(), which calls taprio_leaf()
returning the NULL pointer, then dereferences it to read child->handle,
causing a kernel NULL pointer dereference.

The bug is reachable with namespace-scoped CAP_NET_ADMIN on any kernel
with CONFIG_NET_SCH_TAPRIO enabled. On systems with unprivileged user
namespaces enabled, an unprivileged local user can trigger a kernel
panic by creating a taprio qdisc inside a new network namespace,
grafting an explicit child qdisc, deleting it, and requesting a class
dump. The RTM_GETTCLASS dump itself requires no capability.

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
 RIP: 0010:taprio_dump_class (net/sched/sch_taprio.c:2475)
 Call Trace:
  <TASK>
  tc_fill_tclass (net/sched/sch_api.c:1966)
  qdisc_class_dump (net/sched/sch_api.c:2329)
  taprio_walk (net/sched/sch_taprio.c:2510)
  tc_dump_tclass_qdisc (net/sched/sch_api.c:2353)
  tc_dump_tclass_root (net/sched/sch_api.c:2370)
  tc_dump_tclass (net/sched/sch_api.c:2431)
  rtnl_dumpit (net/core/rtnetlink.c:6827)
  netlink_dump (net/netlink/af_netlink.c:2325)
  rtnetlink_rcv_msg (net/core/rtnetlink.c:6927)
  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
  </TASK>

Fix this by substituting &noop_qdisc when new is NULL in
taprio_graft(), following the same pattern used by multiq_graft() and
prio_graft(). This ensures q->qdiscs[] slots are never NULL, making
all consumer paths (dump, enqueue, dequeue) safe. The noop_qdisc is a
kernel-global builtin qdisc that drops all packets, which is
functionally equivalent to a NULL child for data path purposes. The
refcount increment and flag modification are guarded with
!= &noop_qdisc to avoid modifying the global singleton.

Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual q->qdiscs[]")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/sched/sch_taprio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index f721c03514f60..cecaef16c0dd1 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2183,6 +2183,9 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
 	if (!dev_queue)
 		return -EINVAL;
 
+	if (!new)
+		new = &noop_qdisc;
+
 	if (dev->flags & IFF_UP)
 		dev_deactivate(dev);
 
@@ -2196,14 +2199,14 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
 	*old = q->qdiscs[cl - 1];
 	if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
 		WARN_ON_ONCE(dev_graft_qdisc(dev_queue, new) != *old);
-		if (new)
+		if (new != &noop_qdisc)
 			qdisc_refcount_inc(new);
 		if (*old)
 			qdisc_put(*old);
 	}
 
 	q->qdiscs[cl - 1] = new;
-	if (new)
+	if (new != &noop_qdisc)
 		new->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
 
 	if (dev->flags & IFF_UP)
-- 
2.43.0


