Return-Path: <netdev+bounces-22748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4A6769080
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE391C20B35
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A22171AF;
	Mon, 31 Jul 2023 08:38:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6989174D8
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:38:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ECE10F0;
	Mon, 31 Jul 2023 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fpzWiCemt8iyK69nP61qCLs36MXwZ+pdOr4ITT1eya0=; b=haZPeO5LdCP8/cngv1IF8GYnCB
	JpI6Oqi+D5JWYV1zV+UjHB17TpOjFoeZZzwl1VQafULr2qvZRn/XoTAXSHIEjVqtWdVCMz8RpuO6N
	o6gFWkRf/SJGeERduYeO8nm11vdejRYzeBlpu8QN5MxNjuAxE/FZHwOrcL+9NtHTnvsc1MUJqDMMt
	cXSljNq6m1mtzPD90yydTLSCGm866aXjcZtAE+wJufjf9+QUNmVjm+JGAx/+tmp3PNtX1yf4QYSqg
	JOn2InDeSov1ckzUOPpiLvTZO86uQ3G/hx3/Us7Jx/uXyo6lci2OF1mLPe6VF9vpF6DDFvT+Y5p5m
	u2OKnHLQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qQOQ6-00EYvK-1x;
	Mon, 31 Jul 2023 08:38:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Joshua Kinard <kumba@gentoo.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list),
	linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [PATCH 5/5] modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules
Date: Mon, 31 Jul 2023 10:38:06 +0200
Message-Id: <20230731083806.453036-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731083806.453036-1-hch@lst.de>
References: <20230731083806.453036-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It has recently come to my attention that nvidia is circumventing the
protection added in 262e6ae7081d ("modules: inherit
TAINT_PROPRIETARY_MODULE") by importing exports from their propriertary
modules into an allegedly GPL licensed module and then rexporting them.

Given that symbol_get was only ever inteded for tightly cooperating
modules using very internal symbols it is logical to restrict it to
being used on EXPORY_SYMBOL_GPL and prevent nvidia from costly DMCA
circumvention of access controls law suites.

All symbols except for four used through symbol_get were already exported
as EXPORT_SYMBOL_GPL, and the remaining four ones were switched over in
the preparation patches.

Fixes: 262e6ae7081d ("modules: inherit TAINT_PROPRIETARY_MODULE")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/module/internal.h |  1 +
 kernel/module/main.c     | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index c8b7b4dcf7820d..add687c2abde8b 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -93,6 +93,7 @@ struct find_symbol_arg {
 	/* Input */
 	const char *name;
 	bool gplok;
+	bool gplonly;
 	bool warn;
 
 	/* Output */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 59b1d067e52890..85d3f00ca65758 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -281,6 +281,8 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 
 	if (!fsa->gplok && syms->license == GPL_ONLY)
 		return false;
+	if (fsa->gplonly && syms->license != GPL_ONLY)
+		return false;
 
 	sym = bsearch(fsa->name, syms->start, syms->stop - syms->start,
 			sizeof(struct kernel_symbol), cmp_name);
@@ -776,8 +778,9 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 void __symbol_put(const char *symbol)
 {
 	struct find_symbol_arg fsa = {
-		.name	= symbol,
-		.gplok	= true,
+		.name		= symbol,
+		.gplok		= true,
+		.gplonly	= true,
 	};
 
 	preempt_disable();
@@ -1289,14 +1292,18 @@ static void free_module(struct module *mod)
 void *__symbol_get(const char *symbol)
 {
 	struct find_symbol_arg fsa = {
-		.name	= symbol,
-		.gplok	= true,
-		.warn	= true,
+		.name		= symbol,
+		.gplok		= true,
+		.gplonly	= true,
+		.warn		= true,
 	};
 
 	preempt_disable();
 	if (!find_symbol(&fsa) || strong_try_module_get(fsa.owner)) {
 		preempt_enable();
+		if (fsa.gplonly)
+			pr_warn("failing symbol_get of non-GPLONLY symbol %s.\n",
+				symbol);
 		return NULL;
 	}
 	preempt_enable();
-- 
2.39.2


