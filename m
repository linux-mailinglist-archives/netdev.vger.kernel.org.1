Return-Path: <netdev+bounces-283428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPmhLgcU9mnMSAIAu9opvQ
	(envelope-from <netdev+bounces-283428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 17:11:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F454B2968
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8BEE302A6D0
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AE93815F1;
	Sat,  2 May 2026 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpnIrw1h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C4037C0FA
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777734568; cv=none; b=C/Atgy3mqjI4HjkhKW21WJ0jDBFcRcXQuvNrvzdlWGd2zjzGcIm/ADI11/KeIYxXNWU/ic2qF0ArvC4BJ+POJ5v+he2HWwBD5xryvwoMGWOgJoJDf1Xt9aZeKXZ4UljwqaEDhbvQOfDwzBtT0RVOvcdVDD0fP28tT96U33K/7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777734568; c=relaxed/simple;
	bh=uazcdPaE5njKmpLYawFPN4mUVC9ypP4hDv4opGgd7Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i63czfT8fxM27dYzfcFLu0lLqxMFB5GFY8GiKoWPh9+/qm+6eqrd+WMuzeKWvix4UMzp3ri3mSCpcPt47KHnHuw6o5508C/v9zoO+Uv/NFJ7gYsJBOVQzhgKCWThTXxzIroe98fHUYzMVOZzNdnTEIS/6bR44o3Rp0q5mafWLGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpnIrw1h; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-824c9da9928so1228965b3a.3
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 08:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777734564; x=1778339364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uZCg2ntfiIQSDRsAzajTIBjeudz9C8jXIZXlecgKHlI=;
        b=MpnIrw1h6hGrASr6P0bNa973sOIWzwfxBIpdAQRI/aHetUnIAYziAcHh0CMjxzd4e8
         otAiR1fqCgIxW2LubpHI60XDQDSb61nVQwAaB9nmjsQxXdWlc7n2K3wswxc3FZyA2PpR
         uKbnolmGxJOyB8WeJHYgtWowgE3tgxylcQYYnqxe24ZKl1nQ3Zc9VcNxdChtWebQ8684
         uODeJhombxEVFnGeODR3kp63i79CfrTLMJC46prAyZL4HRzVfdMhEKSorF7FceWSDs57
         0PJltxHx8kX7dn8xW7KDMWcoERpnYM9ElHAUCB1F58smJdynxv2zxRB1MVc8De0t1Oen
         0iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777734564; x=1778339364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZCg2ntfiIQSDRsAzajTIBjeudz9C8jXIZXlecgKHlI=;
        b=sLX8kdwAtm/7+kJg9TT229zVkXBsFYL62zUtsT/uUwbeo6QuRh/TGSP0Xz3rovDq0r
         Wge7JQokquTaBuUXVWyZGP/dwC8PI5AapY0gUGI1e4WppoaSMoOZEcbtuTV+Bys/VEqK
         AySm4nTI597L5Xqv+4B6jZcciiURwoHIupQlaNEFNxY9RFoYcOV/S7TzQFG3U8LnVYav
         wQ0Pzfbh6JvK0fcGpkgpk5NT72lWEXTwbLq51N+mIHc4UR2/Djs6dTQJHVoflWEcqLxm
         oAGKpEanwLz6KxxHDqlB8lzOMnmETrb7DJTcujRItGYloSKmayZ59AaMR80/UhUEFV7i
         BK+A==
X-Forwarded-Encrypted: i=1; AFNElJ+QZ7NjM9nALruPC50ZXP2tcCMAgskl1pYMAmLCs9vmpDDU8T055r9WcfkdgUmSfALr5XVs4S4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8wr1nyW91zm1251dCdXOxX8ulashYsL9UlUSa9aKQTiqQ8EuU
	D+/4eRaob5DPsCN57KGWYWopTCpwfRxGPMVAYtrqcPZiWjlC54HLeAT8
X-Gm-Gg: AeBDieuIvkoDkp6xR0wBUtytH2RK4/HcyYuEtZEVTPsThocovR1DJOqZpIycDxLiNrG
	lgmk8MMYJdOr4n5dKBynegnDUwhjpNxNBMY1o+nMOH+96oM8c+x7FTYGVGaY+6NygMQZj/yOFMa
	fCzl4oruqk1xXugX/TGFfwFPU813RPHnjz6IGL4I9ogz34CzHHQIvURkrcahi9VVcLdd9bOucCA
	+EGs1G/aPrb1FFGQeEALd0NDGW2NduuJbY1rucu4LYMOBQsdyls/n/XFayuv10aREt9tYuJr0Oh
	AETH/iaZexZj8A9GOSbA+oHY9IyJvvlKJYrDPjp4jRy19FbuCrqTpTQNxtbeh7NfNggXlcY6/Om
	4kMvUZxGfYPh8xMaxY7c2F+kl2uROr4Yv8Pgfzx6ERy/xSR+pF7/o+giMuJRXjfgT73NRmgsYI8
	kgqXC2Smc4ryKhESCF3t+lEEfL9/7ZWKR0zmFMjtMBFfHm8bgo9f8XNoVD
X-Received: by 2002:a05:6a21:6d95:b0:3a1:90ef:7e46 with SMTP id adf61e73a8af0-3a7f1bc4197mr3551311637.33.1777734563683;
        Sat, 02 May 2026 08:09:23 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515833ee3sm6080310b3a.11.2026.05.02.08.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 08:09:23 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	willemb@google.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v6] ipv6: flowlabel: enforce per-netns limit for unprivileged callers
Date: Sat,  2 May 2026 23:09:18 +0800
Message-Id: <20260502150918.4171847-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 20F454B2968
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283428-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ms2.inr.ac.ru,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]

fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are file
scope and shared across netns. mem_check() reads fl_size to decide
whether to deny non-CAP_NET_ADMIN callers; capable() runs against
init_user_ns, so an unprivileged user in any non-init userns can
push fl_size past FL_MAX_SIZE - FL_MAX_SIZE/4 and starve every
other unprivileged userns on the host.

Add struct netns_ipv6::flowlabel_count, bumped and decremented next
to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new field
is placed in the existing 4-byte hole after ipmr_seq, so struct
netns_ipv6 stays the same size on 64-bit builds.

Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the file
was added; machines and connection counts have grown.

mem_check() folds an extra per-netns ceiling into the existing
non-CAP_NET_ADMIN conditional. The ceiling is half of the total
budget that unprivileged callers have ever been able to use, i.e.
(FL_MAX_SIZE - FL_MAX_SIZE/4) / 2 = 3072 entries. With FL_MAX_SIZE
doubled, this preserves the original per-user reach (~3K, what an
unprivileged caller could already obtain before this change) while
forcing an attacker to spread allocations across at least two
netns to exhaust the global non-CAP_NET_ADMIN budget.

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
v6 (this submission, addressing v5 review by Willem):
    - Rebased onto current net (resolves the conflict on
      include/net/netns/ipv6.h that v5 hit. ipmr_seq is now
      atomic_t but remains 4 bytes, so flowlabel_count still
      fills the 4-byte hole after it).
    - Restored fl_free() to its original position in both
      ip6_fl_gc() and ip6_fl_purge(). v5 had moved fl_free()
      after the new atomic_dec() to avoid the use-after-free
      on fl->fl_net. v6 instead caches fl->fl_net into a
      local before fl_free() in ip6_fl_gc(), and uses the
      net argument already in scope in ip6_fl_purge().
v5: replaced the per-netns ceiling FL_MAX_SIZE/8 with the
    computed unpriv_user_limit = (FL_MAX_SIZE - FL_MAX_SIZE/4)/2,
    which evaluates to 3072. v4's FL_MAX_SIZE/8 = 1024 would
    have reduced the per-user budget below the ~3K an
    unprivileged caller could already obtain before any of
    this work, defeating the reason FL_MAX_SIZE was doubled
    in the first place.
v4: addressed Willem's v3 review on netdev. Dropped the
    flowlabel_has_excl cacheline argument in favour of "fills
    the existing 4-byte hole after ipmr_seq", and reordered
    atomic_dec(&...flowlabel_count) to sit immediately after
    atomic_dec(&fl_size) in ip6_fl_gc and ip6_fl_purge.
v3: addressed Willem's review on the private security@ thread.
    Merged FL_MAX_SIZE doubling, dropped test data, moved
    flowlabel_count near ipmr_seq, inlined fl->fl_net in
    ip6_fl_gc.
v2: per-netns counter + cap, sent to security@ as a 2-patch
    series.
v1: fix-shape sketch in original disclosure.

 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_flowlabel.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 499e42881..ef698f5fa 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -119,6 +119,7 @@ struct netns_ipv6 {
 	struct fib_notifier_ops	*notifier_ops;
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
 	atomic_t		ipmr_seq;
+	atomic_t		flowlabel_count;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c92f98c6f..28e43718d 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -36,7 +36,7 @@
 /* FL hash table */
 
 #define FL_MAX_PER_SOCK	32
-#define FL_MAX_SIZE	4096
+#define FL_MAX_SIZE	8192
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
@@ -161,9 +161,12 @@ static void ip6_fl_gc(struct timer_list *unused)
 					fl->expires = ttd;
 				ttd = fl->expires;
 				if (time_after_eq(now, ttd)) {
+					struct net *net = fl->fl_net;
+
 					*flp = fl->next;
 					fl_free(fl);
 					atomic_dec(&fl_size);
+					atomic_dec(&net->ipv6.flowlabel_count);
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -197,6 +200,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 				*flp = fl->next;
 				fl_free(fl);
 				atomic_dec(&fl_size);
+				atomic_dec(&net->ipv6.flowlabel_count);
 				continue;
 			}
 			flp = &fl->next;
@@ -245,6 +249,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
 	atomic_inc(&fl_size);
+	atomic_inc(&net->ipv6.flowlabel_count);
 	spin_unlock_bh(&ip6_fl_lock);
 	rcu_read_unlock();
 	return NULL;
@@ -464,6 +469,9 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
+	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
+	const int unpriv_user_limit = unpriv_total_limit / 2;
+	struct net *net = sock_net(sk);
 	int room = FL_MAX_SIZE - atomic_read(&fl_size);
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
@@ -478,7 +486,9 @@ static int mem_check(struct sock *sk)
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
-	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
+	      (count > 0 && room < FL_MAX_SIZE/2) ||
+	      room < FL_MAX_SIZE/4 ||
+	      atomic_read(&net->ipv6.flowlabel_count) >= unpriv_user_limit) &&
 	     !capable(CAP_NET_ADMIN)))
 		return -ENOBUFS;
 
-- 
2.34.1


