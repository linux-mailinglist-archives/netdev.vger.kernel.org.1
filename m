Return-Path: <netdev+bounces-274129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFc+OX8szWk0agYAu9opvQ
	(envelope-from <netdev+bounces-274129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:32:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6341D37C301
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 462EE304A124
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791E4657D0;
	Wed,  1 Apr 2026 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JVdDV906"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37011391E4D;
	Wed,  1 Apr 2026 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053232; cv=none; b=uzwZtvwzeSMKc9KtdCbrsWdkw9YYl0kdLyIHJfFEmlKHm8Ub7tMZX8F4+fgKwqb5tmMxCZkEfV7bCTOcYwogNGEiRLjyf08RxaZFFgx8Ao1iKPe7MKs1KhQWIMtzgHfLcDr9iHlwZwjlszoQAIpQNBj9x0R6tQaJ7dDAE+ykUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053232; c=relaxed/simple;
	bh=zr3uTfhPH3QtRE32YMAmmvNm7KPCBEKBLFvyenoXaxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPjKnYhqm00HJcp9i3UhKM5tCs0Ahj3uRwUt+DxSYwK5WmJgv26MDnq8burmsLB/ve1X72udtauN0wiue/fBzwrTGkPxPKmubaWyldN/6QchpGhIOldOX0c1H0H/qZuuJh6jcLe/nIU8Mr9MPTyktnojSVIL65qReEYhWdYnkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=JVdDV906; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=2kje2VmbWw88L2r+Ky1VorX3CfR9qKWy8zIczpZ54pM=; b=JVdDV906Atr2
	wh+gkAO1sw8CpGf1wOdlfn/jlpUaU4Z4X676RZhrzL53yJ/bZYr0OX1ziKSuMr4Y9thNkzM7MglMu
	NrKFNporCqaH6DDls/c4bUq8A1fdLYTQlRpNKxK0I7Nb7ilR96AohnEaRRHat9nnXJJciFZByOoyQ
	fb0uPpvm8sd6uMky5lMe1zw9Q0nbDjb/4crocpOKQBrdRUMxRY1olwbeyRcChbmA7sDrrrRpk8Oe7
	wZaqxVoCtLCfxiqPCmZ4hDnzgK+gZaHjrDIbi9rFjJEoq/6eejk7QBQitRAToW33VESUzfSLELcL1
	Vc8SOiFKnY2fHvKJpVjdpg==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w7wOW-00HGGD-13;
	Wed, 01 Apr 2026 16:20:20 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 3/4] iommu/generic_pt: disable GCOV for iommu_amdv1.o
Date: Wed,  1 Apr 2026 17:20:19 +0300
Message-ID: <20260401142020.1434243-4-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260401142020.1434243-1-khorenko@virtuozzo.com>
References: <20260401142020.1434243-1-khorenko@virtuozzo.com>
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
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274129-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6341D37C301
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With -fprofile-update=atomic in global CFLAGS_GCOV, GCC cannot
constant-fold FIELD_PREP() expressions inside deeply inlined page table
walker functions.  GCC creates .constprop clones of the inline level
functions, which get their own GCOV instrumentation that prevents
constant evaluation of compile-time checks.

__no_profile cannot be used here because the entire call chain is
__always_inline functions generated by PT_MAKE_LEVELS() macro, and GCC's
constprop cloning creates new profiled function bodies that bypass the
attribute.

Disable GCOV for iommu_amdv1.o to allow BUILD_BUG_ON / FIELD_PREP
compile-time checks to succeed.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 drivers/iommu/generic_pt/fmt/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index 976b49ec97dc..0305f7fb9e35 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+GCOV_PROFILE_iommu_amdv1.o := n
+
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
 iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) += mock
 
-- 
2.43.5


