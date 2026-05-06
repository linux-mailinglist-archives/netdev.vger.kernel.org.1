Return-Path: <netdev+bounces-284754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF+FIs37+mnjUwMAu9opvQ
	(envelope-from <netdev+bounces-284754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:29:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1664D7DC7
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D17823064AE4
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 08:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778823E3C4B;
	Wed,  6 May 2026 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdrsxTJb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC43E3C60
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055870; cv=none; b=oArGV4X9AehO4w9RrgE2+fNNnKEMq18DPx/4AK/uEh8Air5jXJn7sDKauCFZKbXiOjBeuJbxfHzng3zP5+J5bqOe25+0fmw6Oo3oS7n5qN/hklq+/H7z32dgl9EGLsf+3bOBYdJSgpnLGBT08QWuWk2ww1F/OnPEcGnHd8kbcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055870; c=relaxed/simple;
	bh=/zhX6pVHc6jKOYVIyZpu2RA8wq4PDni8zJBq8MVeqw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AT5/clGbmbyfGhtjnfmFQwrS9WLi988BfUCiQP4RlZXLcWAKvwCcRBHU+TmHdVbDg7hkvvkRbrnSVtL4N/6WJARUj5Ka2jaN4DApXx9cXCCnNrj1qixbE//g9v+f8BGus5q9at4Ea58LyqC4EmFfAeO4jVlL4v1aN6D+Vkhvjqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdrsxTJb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36535998b71so397103a91.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 01:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778055868; x=1778660668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MU+BTMLVtF5cm6yr1FFJAfY/wspADdxuXDbB9M810Sk=;
        b=QdrsxTJb4pssRg4UAyYgdke1301S2EvscGAZ+NC4TDUC93JdNrPzm/eCDf47x4jxNh
         pjVJezk/m3cV2TEGG2BQ9M3np1hhXNwgnHdeuCdJLD8fKyxnJJoXNj9v9Z6jZNchW+lC
         8/GfI5F/SzLzo6f428E5+8FXYNukHQO7xRm3NkNAjbtCwBrrFn9f6S6COMywQ6F1e827
         B9Yy6Yu7a+1AVAQw4F6W902PV2uCJxmDXWd0uF4eYoZLVHVmwdmSjvZ7pSPDb2jdJJxv
         zQ5HX0sRP8uKr6XToWl8TiGrLvV/PSRxKDhCwHJUdbwFVta7CeEXSCwk2fAFP6M0QAiG
         wikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778055868; x=1778660668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MU+BTMLVtF5cm6yr1FFJAfY/wspADdxuXDbB9M810Sk=;
        b=Cp2w6cSN31uHGEFRnouaWVLNgc++/+zQwIyDP1DRN4L5+NhbRwSZu+A3Uqg0e3IJuc
         DLrkKXuOsn1ecaxCVWDBS3iXWWKeXnyLljO+S9xwJaY+Y6Ks+MWdzQdVhhZpR/Q505xR
         WGe3K4PcWjMg7/zC9Q6m0kt+WwNroNP3n+AdhdWtBlZ6nzCjnNhqeH/B9+zOD6sy/2Uu
         Df3MT4B8oolXPoDm+MDVAjVeJbB2awoINaSnK3oizRGT86DB01yvG3GrHbpu69eoO+v5
         bQ+QVwrDSisEmGUVWkYQaHoTrR9wsymF+E9v9L8QDGKkPEefnaw35bgCmfrXL4staFIi
         utsg==
X-Forwarded-Encrypted: i=1; AFNElJ81MMeyRyvxfS5qzEtvPhupgJT+nKI9JuzOGYytf08ZqXeAw6AVcv5M0W3N4FOtPXl6w1grneA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLS8wH+WiEohTaLG5sh91nAD89wb80PmnYhrVrX3mx9Bge3M6
	JGM2MnN1FQ+QbQPbk47xGBArTwemaj51pjcetRKhWUfqLZGN9+p0c8Ww
X-Gm-Gg: AeBDies2scbZXM9OAM8jkzlPS2RAZL8spq/K9tTVL3HXOnYJDx9tEbdZOz2c1fPKFDa
	6DDG+1UNQhQdFtMJUmUT+LwK7Zd8lMbWtcJAKfqlAzu6fyrqLsXYxm1Y1aYvnJfl2kHKY7crv/D
	dUy1dYWXx3q51/JglG2IgmibRfHStmnmYgSt91bvqZHdLwhAbXm7qoyDDw1EgkZXtXR6pmAPPuV
	LgrbyRs56EJT/ErYkVXI7zK5yjn6QU+590qxn1okVrktxQ+JWEI5lRRD/U1maaHZtGpLlKFx5ko
	5+YBjFxPEtr4N3wXzmTxWbFhSHoeBqUqInIh6Z5X9Iu6K65IjIVLEiZlypwi53176BBbdYUYldC
	1UPYB1Yt8g0IGlNUd6te3cMQJvEjYe5X3S2wuVRkRrtgddjPWdFI5iMVqyit81NaMkLukrwjMvN
	lXRcDzYV35OIV8KdDeZ5IYkKSozpZECYtudUAoFInuf+sTgkInAhRk1rUnOCE=
X-Received: by 2002:a17:90b:4a92:b0:35d:aa02:d776 with SMTP id 98e67ed59e1d1-365a96b3b2cmr1880890a91.2.1778055868209;
        Wed, 06 May 2026 01:24:28 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b12a1eddsm1000293a91.6.2026.05.06.01.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 01:24:27 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Willem de Bruijn <willemb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>
Subject: [PATCH net v8 2/2] ipv6: flowlabel: enforce per-netns limit for unprivileged callers
Date: Wed,  6 May 2026 16:24:16 +0800
Message-Id: <20260506082416.2259567-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506082416.2259567-1-maoyixie.tju@gmail.com>
References: <20260506082416.2259567-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D1664D7DC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,ms2.inr.ac.ru,gmail.com,vger.kernel.org,ntu.edu.sg];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284754-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are
file scope and shared across netns. mem_check() reads fl_size to
decide whether to deny non-CAP_NET_ADMIN callers. capable() runs
against init_user_ns, so an unprivileged user in any non-init
userns can push fl_size past FL_MAX_SIZE - FL_MAX_SIZE / 4 and
starve every other unprivileged userns on the host.

Add struct netns_ipv6::flowlabel_count, bumped and decremented
next to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new
field fills the existing 4-byte hole after ipmr_seq, so struct
netns_ipv6 stays the same size on 64-bit builds.

Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the
file was added. Machines and connection counts have grown.

mem_check() folds an extra per-netns ceiling into the existing
non-CAP_NET_ADMIN conditional. The ceiling is half of the total
budget that unprivileged callers have ever been able to use, i.e.
(FL_MAX_SIZE - FL_MAX_SIZE / 4) / 2 = 3072 entries. With
FL_MAX_SIZE doubled, this preserves the original per-user reach
of 3K (what an unprivileged caller could already obtain before
this change), while forcing an attacker to spread allocations
across at least two netns to exhaust the global non-CAP_NET_ADMIN
budget.

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

The previous patch took ip6_fl_lock across mem_check and
fl_intern, so the new flowlabel_count read in mem_check and the
new flowlabel_count++ in fl_intern run under the same critical
section. flowlabel_count is therefore plain int, like fl_size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_flowlabel.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 499e42881..875916d60 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -119,6 +119,7 @@ struct netns_ipv6 {
 	struct fib_notifier_ops	*notifier_ops;
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
 	atomic_t		ipmr_seq;
+	int			flowlabel_count;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index a89746431..b1ccdf0dc 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -36,7 +36,7 @@
 /* FL hash table */
 
 #define FL_MAX_PER_SOCK	32
-#define FL_MAX_SIZE	4096
+#define FL_MAX_SIZE	8192
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
@@ -162,8 +162,9 @@ static void ip6_fl_gc(struct timer_list *unused)
 				ttd = fl->expires;
 				if (time_after_eq(now, ttd)) {
 					*flp = fl->next;
-					fl_free(fl);
 					fl_size--;
+					fl->fl_net->ipv6.flowlabel_count--;
+					fl_free(fl);
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -197,6 +198,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 				*flp = fl->next;
 				fl_free(fl);
 				fl_size--;
+				net->ipv6.flowlabel_count--;
 				continue;
 			}
 			flp = &fl->next;
@@ -243,6 +245,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
 	fl_size++;
+	net->ipv6.flowlabel_count++;
 	return NULL;
 }
 
@@ -460,6 +463,9 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
+	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
+	const int unpriv_user_limit = unpriv_total_limit / 2;
+	struct net *net = sock_net(sk);
 	int room;
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
@@ -478,7 +484,9 @@ static int mem_check(struct sock *sk)
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
-	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
+	      (count > 0 && room < FL_MAX_SIZE / 2) ||
+	      room < FL_MAX_SIZE / 4 ||
+	      net->ipv6.flowlabel_count >= unpriv_user_limit) &&
 	     !capable(CAP_NET_ADMIN)))
 		return -ENOBUFS;
 
-- 
2.34.1


