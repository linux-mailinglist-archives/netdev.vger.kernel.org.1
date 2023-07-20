Return-Path: <netdev+bounces-19603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA2675B5C0
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91B21C21494
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA9C2FA56;
	Thu, 20 Jul 2023 17:37:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4572FA43
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 17:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6AEC433C8;
	Thu, 20 Jul 2023 17:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689874674;
	bh=vu7UB2hzV9ciT9GlxlDlkSpD6KnJe/N1NAd6qnAITwI=;
	h=From:To:Cc:Subject:Date:From;
	b=AGqFkeRuGe56ph4NRtcjTDjVP1qGFonFHKQ7616alyFT7Pym1Mlg/iIbp1WAEYovQ
	 QiQ/kcT8V4KK4sG5/HWN/15ODqkH2CA+PoirlMyWil4lKGIO5vpBucxkg4eZ8jRARW
	 qJiaBcz4lC5WwcTXoP0068toTK87lG7X+NDRXd/94SGrkzkVJmEJY2Ot+jJddNZA8f
	 DXd8jzpoFI/nFG/JC4bzbhybdodcZh3pfo6azNzUCzLWOsPQfRLErN4GfNy9s1KSgi
	 GDYd134fJX9KWXMr0SFf/ZU7vlR4Me4XxuBd04IwS4YTX5VtSJ7a60edGelKvQAbUu
	 v+URZH2BOjD+w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: [PATCH net-next] page_pool: add a lockdep check for recycling in hardirq
Date: Thu, 20 Jul 2023 10:37:51 -0700
Message-ID: <20230720173752.2038136-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page pool use in hardirq is prohibited, add debug checks
to catch misuses. IIRC we previously discussed using
DEBUG_NET_WARN_ON_ONCE() for this, but there were concerns
that people will have DEBUG_NET enabled in perf testing.
I don't think anyone enables lockdep in perf testing,
so use lockdep to avoid pushback and arguing :)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: peterz@infradead.org
CC: mingo@redhat.com
CC: will@kernel.org
CC: longman@redhat.com
CC: boqun.feng@gmail.com
CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
---
 include/linux/lockdep.h | 7 +++++++
 net/core/page_pool.c    | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 310f85903c91..dc2844b071c2 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -625,6 +625,12 @@ do {									\
 	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirq_context)); \
 } while (0)
 
+#define lockdep_assert_no_hardirq()					\
+do {									\
+	WARN_ON_ONCE(__lockdep_enabled && (this_cpu_read(hardirq_context) || \
+					   !this_cpu_read(hardirqs_enabled))); \
+} while (0)
+
 #define lockdep_assert_preemption_enabled()				\
 do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
@@ -659,6 +665,7 @@ do {									\
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
 # define lockdep_assert_in_irq() do { } while (0)
+# define lockdep_assert_no_hardirq() do { } while (0)
 
 # define lockdep_assert_preemption_enabled() do { } while (0)
 # define lockdep_assert_preemption_disabled() do { } while (0)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a3e12a61d456..3ac760fcdc22 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -536,6 +536,8 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)
 {
 	int ret;
+
+	lockdep_assert_no_hardirq();
 	/* BH protection not needed if current is softirq */
 	if (in_softirq())
 		ret = ptr_ring_produce(&pool->ring, page);
@@ -642,6 +644,8 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 	int i, bulk_len = 0;
 	bool in_softirq;
 
+	lockdep_assert_no_hardirq();
+
 	for (i = 0; i < count; i++) {
 		struct page *page = virt_to_head_page(data[i]);
 
-- 
2.41.0


