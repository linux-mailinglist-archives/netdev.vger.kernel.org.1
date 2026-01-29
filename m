Return-Path: <netdev+bounces-254745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPAHGvY9e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:01:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 077BFAF4FA
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 673263097DA8
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92A63815E6;
	Thu, 29 Jan 2026 10:55:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780FE33F8A7;
	Thu, 29 Jan 2026 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684100; cv=none; b=upAtpTaP5zsa39SeEj0PHIrF7U7j3kadwow/VNn6gXHyeljfc+njEFzoa4s51F3ePj1lggQLWQhgzxq+pwYDUkQ6Z53u6R4bgpkyxa/NBU3N2D0Jj5KzErQtP+gIb0tKBPje3I3IY47urkqzOS8cQBvcRzzthz+LhXlu3ZM5hus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684100; c=relaxed/simple;
	bh=1K5IqJRvatmxZmxrvyMTfmzqoKKlWjYoUj9r1bFB72E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcOvBljjcVlk8a/R1ZdXjZ7dbt1/r7cEmYBOOvxSCzY+9WCoERLsxvo7KyhBVSbGNT5NyqS+V39npBdr1b7jNaC5rbA80qs/9eg1kOgij6h9T1LJmONJHy8cbj3DdTtFTuUNyChhmX2PxcKc6NzdAgdHM1MYFOExIX84Fm6IcRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C153560516; Thu, 29 Jan 2026 11:54:57 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH v2 net-next 6/7] netfilter: xt_time: use is_leap_year() helper
Date: Thu, 29 Jan 2026 11:54:26 +0100
Message-ID: <20260129105427.12494-7-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129105427.12494-1-fw@strlen.de>
References: <20260129105427.12494-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[huawei.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254745-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[ruanjinjie.huawei.com:query timed out];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid,strlen.de:email]
X-Rspamd-Queue-Id: 077BFAF4FA
X-Rspamd-Action: no action

From: Jinjie Ruan <ruanjinjie@huawei.com>

Use the is_leap_year() helper from rtc.h instead of
writing it by hand

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/xt_time.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/xt_time.c b/net/netfilter/xt_time.c
index 6aa12d0f54e2..00319d2a54da 100644
--- a/net/netfilter/xt_time.c
+++ b/net/netfilter/xt_time.c
@@ -14,6 +14,7 @@
 
 #include <linux/ktime.h>
 #include <linux/module.h>
+#include <linux/rtc.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
 #include <linux/netfilter/x_tables.h>
@@ -64,11 +65,6 @@ static const u_int16_t days_since_epoch[] = {
 	3287, 2922, 2557, 2191, 1826, 1461, 1096, 730, 365, 0,
 };
 
-static inline bool is_leap(unsigned int y)
-{
-	return y % 4 == 0 && (y % 100 != 0 || y % 400 == 0);
-}
-
 /*
  * Each network packet has a (nano)seconds-since-the-epoch (SSTE) timestamp.
  * Since we match against days and daytime, the SSTE value needs to be
@@ -138,7 +134,7 @@ static void localtime_3(struct xtm *r, time64_t time)
 	 * (A different approach to use would be to subtract a monthlength
 	 * from w repeatedly while counting.)
 	 */
-	if (is_leap(year)) {
+	if (is_leap_year(year)) {
 		/* use days_since_leapyear[] in a leap year */
 		for (i = ARRAY_SIZE(days_since_leapyear) - 1;
 		    i > 0 && days_since_leapyear[i] > w; --i)
-- 
2.52.0


