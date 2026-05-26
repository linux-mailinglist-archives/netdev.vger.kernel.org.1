Return-Path: <netdev+bounces-291778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ABtIlbEFWqxawcAu9opvQ
	(envelope-from <netdev+bounces-291778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:03:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDF85D9413
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F9853042E70
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161039A800;
	Tue, 26 May 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX0LLqET"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE3397B1D;
	Tue, 26 May 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811055; cv=none; b=apfaKXHsaB2cpzhjtk18GXJx/Mgw4qZNg29aUlmp52JWlkYKBfVuyChdW5tknYhUY2D+9JjDDU5x07/N8tPO5Absw8s6tqA+60Ij0mjsgAERHGtk5YtO7b9c1ENfnONwb+uTA3EKKkDl9BapR2j2+rAeXSIavSv3RkfH8oXxcSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811055; c=relaxed/simple;
	bh=0Gs4eaJHHYJn3YI9i+VzaDQ8SVoakTViO9trjVjDd8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pwf3MvelLxviUZ9W1Qze723eeWTStin7sUNIdsc6T63IA1vOvluGsJA+PMgjFAgWa9Q8kcyZ/HkqixUt5WeFnGMUpjNTs79XPeP735fN3eWwnjasKM+JoOvvpqy/con2wakvLh5Iim/SZKrVl2FJRQj8O39ofTxN/BMCQXxLdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nX0LLqET; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB031F00A3D;
	Tue, 26 May 2026 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811053;
	bh=/kgx1aIktyIXxLHyLL5nUxq2BcZWZyQAxi/lCwJwhvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nX0LLqETWQK97vWl0nBUulTAAbjE1W7FipkRUyXY9drvDHRph+9VNQJrP+DfO96tF
	 72+Ne6G1rY9KiGqqh/k+vfA9NCrQDs4j9Q22hvZSzwos0ro89642Vv7UUpDqLKH28w
	 zeuIOFDJC0JEKXhA6Y1FywUItNWaeT5DnjZFRIg8d7sAl98mWAdW8R5NFHicBxExrd
	 EdwP1odYpitvKHCcCAXd07UKSPyOzx8RxZKtTfdh5wLohP+jrik80OutYuA7Es5tkg
	 b+O/B7vJ2Ym6HuC7QF9iwt0eZ8r6Fui4Jj5IkqxdKNaLec8kfqpjynfYpPwmSXYDOk
	 kfjN2N8xTVA3w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	linux-doc@vger.kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] net: make page_pool_get_stats() void
Date: Tue, 26 May 2026 08:57:22 -0700
Message-ID: <20260526155722.2790742-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526155722.2790742-1-kuba@kernel.org>
References: <20260526155722.2790742-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-291778-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6BDF85D9413
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The kdoc for page_pool_get_stats() is missing a Returns: statement.
Looking at this function, I have no idea what is the purpose of
the bool it returns. My guess was that maybe the static inline
stub returns false if CONFIG_PAGE_POOL_STATS=n but such static
inline helper doesn't exist at all. All callers pass a pointer
to a struct on the stack. Make this function void.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool/helpers.h                    | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 3 +--
 net/core/page_pool.c                               | 7 +------
 net/core/page_pool_user.c                          | 3 +--
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 3247026e096a..e2730dd273b2 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -64,7 +64,7 @@ int page_pool_ethtool_stats_get_count(void);
 u8 *page_pool_ethtool_stats_get_strings(u8 *data);
 u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats);
 
-bool page_pool_get_stats(const struct page_pool *pool,
+void page_pool_get_stats(const struct page_pool *pool,
 			 struct page_pool_stats *stats);
 #else
 static inline int page_pool_ethtool_stats_get_count(void)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 1a3ecf073913..7f33261ba655 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -496,8 +496,7 @@ static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
 	struct page_pool *pool = c->rq.page_pool;
 	struct page_pool_stats stats = { 0 };
 
-	if (!page_pool_get_stats(pool, &stats))
-		return;
+	page_pool_get_stats(pool, &stats);
 
 	rq_stats->pp_alloc_fast = stats.alloc_stats.fast;
 	rq_stats->pp_alloc_slow = stats.alloc_stats.slow;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9a87062134d4..84ec603d1bb3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -85,14 +85,11 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
  * is passed to this API which is filled in. The caller can then report
  * those stats to the user (perhaps via ethtool, debugfs, etc.).
  */
-bool page_pool_get_stats(const struct page_pool *pool,
+void page_pool_get_stats(const struct page_pool *pool,
 			 struct page_pool_stats *stats)
 {
 	int cpu = 0;
 
-	if (!stats)
-		return false;
-
 	/* The caller is responsible to initialize stats. */
 	stats->alloc_stats.fast += pool->alloc_stats.fast;
 	stats->alloc_stats.slow += pool->alloc_stats.slow;
@@ -111,8 +108,6 @@ bool page_pool_get_stats(const struct page_pool *pool,
 		stats->recycle_stats.ring_full += pcpu->ring_full;
 		stats->recycle_stats.released_refcnt += pcpu->released_refcnt;
 	}
-
-	return true;
 }
 EXPORT_SYMBOL(page_pool_get_stats);
 
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 01509d1b3cba..fb5d3f9de936 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -127,8 +127,7 @@ page_pool_nl_stats_fill(struct sk_buff *rsp, const struct page_pool *pool,
 	struct nlattr *nest;
 	void *hdr;
 
-	if (!page_pool_get_stats(pool, &stats))
-		return 0;
+	page_pool_get_stats(pool, &stats);
 
 	hdr = genlmsg_iput(rsp, info);
 	if (!hdr)
-- 
2.54.0


