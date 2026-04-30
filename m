Return-Path: <netdev+bounces-282696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI4VD9wP82kDxAEAu9opvQ
	(envelope-from <netdev+bounces-282696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:16:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1C949F262
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D4A3012CCE
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302CF3FBEB0;
	Thu, 30 Apr 2026 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWjeV+Hc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA13FBEB1
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536976; cv=none; b=mU77TlE5t3WAvvqHsxLNxThbbpmQ0bEzadQJBJv80fv+3+S900ezUlNpoSQ8UPZhZyZMWl14TX/fbF8vPS+kFzvlZdv+Vu4mNAC/OYRjgQl7gbt+klHPwd88jYVcsa4zsSVf56kK6iW2wjbC/zFS749vTCkeMiBf6CCqWsUAcTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536976; c=relaxed/simple;
	bh=kXDNzh3W0EHULfn4PPnSPjEYkLJFsmJz53EYF9EyLIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FuYncaBwJuGk9DzW54qh4BPiwaKHkPpteGfA4WLvK+pE429wy4Jcb8vWh53zTDByXEaESX/TUKZmJ6nApue3LfIYdgrHXnCx1Dpd+v/2vXptKcU9T0OaIGy7N7JchXueZ84TQz0wkvQe9GSnPlaV7njR/dnGLqFuFf3dLhcsOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWjeV+Hc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d95017a68so423637a91.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777536974; x=1778141774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzPzUpwdLlRLvZLzGbauoBQzCR22bCmWR4lR+Wns/aM=;
        b=JWjeV+HcG3bXmpE2aT5bpH2mPJKn9S0+7Me8zUthfUcA7yoiLO1Li8tc0KDcr+lmtG
         NC5qknuo2HZKjaVOhoQM8S3mHkYP4FfA9wIDrWSzFKqyJfI9f9MRrcwkX/uBvCW2/plA
         vW0hJnDaRN/rJat2wMji0M6UkHvz8T4x6zbSLSKqjorLbR8YVvR+n5+3Tfy6nQzO4ETV
         R28F3Mw1h7YJDLBW8HBvE+LTgmnoKpj4trcVw8qR9W1sgipGX4axvlWD3YYlsZnpc0zj
         mZHiwPWmslm0XVVVD6Zb1Y/xdHH9sUctULoRSBu1eRmFCZZLPlTdJyCplMTF3JBhWcvN
         rxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777536974; x=1778141774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzPzUpwdLlRLvZLzGbauoBQzCR22bCmWR4lR+Wns/aM=;
        b=o0cqJTAwlpQachwl1+jMA2iMIIersV93kFEvyYrZmiLSe7XFut+gzIH63xyiiXMt8F
         DFnE0sLOa51Fxpymurnnagm6SudbCTKLbahrPCJohJCIEWW5+AFzpXiEyrPCqyXH2ocV
         mp7KxqT+LJ9c2OEcOEYn4Tz7p3bvm9NTsmhscSSrXRHnjJd7hGGan2H+6v8oc+IIhYqL
         Zg3jNcG3ijuF3NwT/43XXITnybxGHYeVgPOMmq0/lVQaUICo99GRm5G/8ecs3h7RHv6u
         Wqka4ZLS3CoP4mQ5U5uWAZH9fRtUdZw91S+mNGLwrQuBrYEKvCmHfREW3hkbHyO5ebIr
         vk0A==
X-Gm-Message-State: AOJu0YzVNMYilEptZWnv15mXKrdu/JGYFgzOHmLgKEhli6REUEIauO/E
	T/X0RxSy34P1C0k31KSAGmoIvIQMF+8wFDYAtF4TnPIscL94pd7ZX9Vo0QOXfw==
X-Gm-Gg: AeBDiess4Ey7pnZCxLV7NwFvnw9XyeB1V+3EUCTx8B5NkGGmKmf930Z0ZqWs1+tqjVE
	Y75Pc4sO+c1h0V9QkRcQ+Ohl0FJwKsFihUL7TZyOJYiAGNNzLMa5pOMFD2c0s5WlWAMEif3zmcg
	yODHeUJz9p0V+wfyg7QiYdRaoLgw5m+viZ7jxjYL6UjS3SC2aE+vv/eV3csawsEH+742C4Nx/gS
	VsmF6brz3p2CY5fMJVHRVinoexTMuiWAHWOusZWaRKWo3i21mCN3HMakAA/Enqp8kLgffHunJkb
	rTgpkSyDJXAoRbU/TkC/WJAyWm4kfdGsyyU9F7b0njCT1gR0MMhIkQ5hgkeVcHXLwj+hheBrLPY
	ffafikSjtq92cxJSwAwzyH9igCPu0GBTVKrEoIK8iMkJxWuUw6WeJWk6/rmbVVUO+mXVF2An54P
	PhVY+zfrBKSpFiBjf/6xH+9iNv4bOmROfi0TRUlsMWWaWzanVoG+DEd8rJFFI=
X-Received: by 2002:a17:90b:38c4:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-364c30feb2dmr2009777a91.23.1777536973687;
        Thu, 30 Apr 2026 01:16:13 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879f22esm44208345ad.31.2026.04.30.01.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 01:16:13 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: netdev@vger.kernel.org
Cc: willemb@google.com,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org
Subject: [PATCH net v3] ipv6: flowlabel: enforce per-netns limit for unprivileged callers
Date: Thu, 30 Apr 2026 16:16:08 +0800
Message-Id: <20260430081608.3137365-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE1C949F262
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-282696-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are file
scope and shared across netns. mem_check() reads fl_size to decide
whether to deny non-CAP_NET_ADMIN callers; capable() runs against
init_user_ns, so an unprivileged user in any non-init userns can
push fl_size past FL_MAX_SIZE - FL_MAX_SIZE/4 and starve every
other unprivileged userns on the host.

Add struct netns_ipv6::flowlabel_count, bumped and decremented next
to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. Place it near
ipmr_seq rather than next to flowlabel_has_excl: flowlabel_has_excl
is read on every flowlabel lookup, and a counter written on every
alloc would dirty its cacheline.

mem_check() folds an extra FL_MAX_SIZE/8 ceiling into the existing
non-CAP_NET_ADMIN conditional.

Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the file
was added; machines and connection counts have grown. The new
per-netns ceiling is then 1024 flowlabels, half of FL_MAX_SIZE/4.

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
v3 (this submission, netdev): addressed Willem's review on the
    private security@ thread:
    - merged the FL_MAX_SIZE doubling into this patch
    - dropped the test data block from the commit body
    - moved flowlabel_count to a 4-byte hole next to ipmr_seq, off
      the flowlabel_has_excl cacheline
    - inlined fl->fl_net in ip6_fl_gc (no local var)
v2: per-netns counter + cap, sent to security@ as a 2-patch series
v1: fix-shape sketch in original disclosure

 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_flowlabel.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 34bdb1308..329482373 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -119,6 +119,7 @@ struct netns_ipv6 {
 	struct fib_notifier_ops	*notifier_ops;
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
 	unsigned int ipmr_seq; /* protected by rtnl_mutex */
+	atomic_t		flowlabel_count;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c92f98c6f..4a5219356 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -36,7 +36,7 @@
 /* FL hash table */
 
 #define FL_MAX_PER_SOCK	32
-#define FL_MAX_SIZE	4096
+#define FL_MAX_SIZE	8192
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
@@ -162,6 +162,7 @@ static void ip6_fl_gc(struct timer_list *unused)
 				ttd = fl->expires;
 				if (time_after_eq(now, ttd)) {
 					*flp = fl->next;
+					atomic_dec(&fl->fl_net->ipv6.flowlabel_count);
 					fl_free(fl);
 					atomic_dec(&fl_size);
 					continue;
@@ -195,6 +196,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 			if (net_eq(fl->fl_net, net) &&
 			    atomic_read(&fl->users) == 0) {
 				*flp = fl->next;
+				atomic_dec(&net->ipv6.flowlabel_count);
 				fl_free(fl);
 				atomic_dec(&fl_size);
 				continue;
@@ -245,6 +247,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
 	atomic_inc(&fl_size);
+	atomic_inc(&net->ipv6.flowlabel_count);
 	spin_unlock_bh(&ip6_fl_lock);
 	rcu_read_unlock();
 	return NULL;
@@ -464,6 +467,7 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
+	struct net *net = sock_net(sk);
 	int room = FL_MAX_SIZE - atomic_read(&fl_size);
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
@@ -478,7 +482,9 @@ static int mem_check(struct sock *sk)
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
-	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
+	      (count > 0 && room < FL_MAX_SIZE/2) ||
+	      room < FL_MAX_SIZE/4 ||
+	      atomic_read(&net->ipv6.flowlabel_count) >= FL_MAX_SIZE/8) &&
 	     !capable(CAP_NET_ADMIN)))
 		return -ENOBUFS;
 
-- 
2.34.1


