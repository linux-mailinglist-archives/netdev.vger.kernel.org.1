Return-Path: <netdev+bounces-267882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKelA9f6tWkI8AAAu9opvQ
	(envelope-from <netdev+bounces-267882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:18:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C2F28FA36
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CFC230428A4
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 00:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647B1A0BF3;
	Sun, 15 Mar 2026 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="yAT9AVsN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640921D5AD4
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533836; cv=none; b=ZUh9E6vkh2LceBRhZAIXFg26iiuESVmB59FqzxxQS2YSUheCg3ZbyvlkvUz/3gCV+HIYP9s8F/mKKbZKwKlgmn4I1Mcfwr8Z7uc8Xlp2YjUYwHk9E1rxVgXHxACUn/JCLPabMJDBJhPWod7PRA5Be7FZjiFN7CKUCOF1Dftlukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533836; c=relaxed/simple;
	bh=AeG3U82cJCeLwDk/yqVNd9n+Ztt7hUxFG6FQOE0Beg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbFVQvXiwyH6j/0bacXHU/AcJouEWzbyAf4h66PeIwoo/PwOjrd9oiTBv7YpR+erzyEi3GlHLfZXbZOXpUK7TV2YLHevqXqTa+wLODGy0acKFZ8M/NpcfxJbxBCfxnv3uPmGwAI608NJaw49DaowCzikjIwJ83VRGBJT1jLKf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=yAT9AVsN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae4988e039so29051365ad.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533835; x=1774138635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFKQyoapMblUhKijnKk9b/cOnKvuPMI/9Dp7doXD56o=;
        b=yAT9AVsN4GGqDYij7KCmFLF1qvmYlClWqZw+I5HFGYdWhxsW4KxEomsTrKH5yPnWV+
         WCHprn5E6IltvWVkHhWcQfVr9T6khngo016SE/2+IMD1AIkgU+4/Vl0cOR3/sEoKZCsI
         7jfSIqgFu0pSASq2DbeBly/dYJWHveOKO1JJGIKvubR270x/0GsS9wXD2kcysIF+oYed
         FB7lErTC3i56bBO95jmWSomVrf4U1B5kpv1Bups9/O2EU6GK3TksaY9V+xj1YKnfw1KW
         2LQOS8P1BwL4PSlwFccEPYDZ8bEpMbnt7co3ZTrBY99CGAAHggBl+aIEfh9h1VwYmnd7
         MzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533835; x=1774138635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFKQyoapMblUhKijnKk9b/cOnKvuPMI/9Dp7doXD56o=;
        b=YZlT0tPFyHaI7eskRW+OvwIRJa6jaBDL/n2+rx6drCjNzbnIjTgrSyo63CSszba9HP
         XezR4b2zqawl6gQh3poic2yqSixvdFEmC17CxBvTDiXTWBTXznpZ7jrb+Fa4zTf8wAy+
         RrNxW4I2zZvk4TkYSJicFwnlUdGvKG6dbnLI06bqviaEoOuJDiHiyxO/KLY0LgJBWFJj
         Xqy/yCZKeRqjN9eEsfmo1cmV/TyZAn1frzioWbqDL3RWtGRNj3KIXcieY4N4saWLIb0C
         tIoho3fqLGeFUBXehf5Om5ErxVmeqob5XiqW7JutAnUrDxH39gUsKQjJ5FcK8RbY8UJW
         elnQ==
X-Gm-Message-State: AOJu0Yw3uDQNtivN22ZLsUDZIaBrawZfuLxGSZjDdSUqRVPkfQpEbmhB
	9sTrwE0kHIqxEjywH4ucOoLX1O9rhlPBMlYuCdsxIsWSYyWH2BMO+tkGo8c2/kCsonb7u2za88w
	fx29D
X-Gm-Gg: ATEYQzz/Glb0rMXcxxLhLt3Ys0ecWK0rkxksp/GEvMLPquGlkO+NAofKtzhr8lxxVIH
	FTXH4eNM9Gn+V0zcDTQZddjnK8FeJZsQliBdV8Xrv4G19fqWnciPisS4DLTvIaIBYlLqvajzUWO
	u0RpPG+9Jk0B024l+NiPXeeN8yjmbs3MVnW6gN59egk7Cjh8V6kBd5I21LnM922XPTiXRZh0PMT
	uz7mYaz/tHke6SfIXGOXwfgJHTxokIY36sQYYATko7/YYAgqPGvmOT1RaHtwn6479iHWcadswSJ
	MoseIIFNDyM5xZGmKPKNcBw4bZYZpkDUbZCD9L+mE3WCrTq1c1DPMNq4JPOExWtIjGzKY294YQL
	KVAZcUu6yVHymVehrgTcv/Hn66DEq+GpY1rdlD/VhOwZ+K79/BzL6Qk0i5P4JJiEpXrbcBdxMwW
	anVlk+2/wztwjj74wAILJaKpCXJzg25rGb7u12zf0yJWQ=
X-Received: by 2002:a17:902:f64a:b0:2ae:5d90:9d95 with SMTP id d9443c01a7336-2aeca59ab46mr88960695ad.14.1773533834797;
        Sat, 14 Mar 2026 17:17:14 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:17:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net v2 06/10] net/sched: netem: fix slot delay calculation overflow
Date: Sat, 14 Mar 2026 17:14:10 -0700
Message-ID: <20260315001649.23931-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315001649.23931-1-stephen@networkplumber.org>
References: <20260315001649.23931-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267882-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 86C2F28FA36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_slot_next() computes a random delay between min_delay and
max_delay using:

  get_random_u32() * (max_delay - min_delay) >> 32

This overflows signed 64-bit arithmetic when the delay range exceeds
approximately 2.1 seconds (2^31 nanoseconds), producing a negative
result that effectively disables slot-based pacing. This is a
realistic configuration for WAN emulation (e.g., slot 1s 5s).

Use mul_u64_u32_shr() which handles the widening multiply without
overflow.

Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 3b2211fc03df..aa0d578b5f0e 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -21,6 +21,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/reciprocal_div.h>
 #include <linux/rbtree.h>
+#include <linux/math64.h>
 #include <linux/percpu.h>
 
 #include <net/gso.h>
@@ -680,9 +681,8 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 
 	if (!q->slot_dist)
 		next_delay = q->slot_config.min_delay +
-				(get_random_u32() *
-				 (q->slot_config.max_delay -
-				  q->slot_config.min_delay) >> 32);
+			mul_u64_u32_shr(q->slot_config.max_delay - q->slot_config.min_delay,
+					get_random_u32(), 32);
 	else
 		next_delay = tabledist(q->slot_config.dist_delay,
 				       (s32)(q->slot_config.dist_jitter),
-- 
2.51.0


