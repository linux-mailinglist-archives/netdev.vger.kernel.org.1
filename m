Return-Path: <netdev+bounces-223755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798EB5A462
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A4E487600
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DDB3294F3;
	Tue, 16 Sep 2025 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Q+VzB5Jk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29C285CA1
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059873; cv=none; b=fqT9I8ASX4H6AAiXv4StdLNKT3pUUBwDU25sB4lscZuWN16u+zr/LehU4Nkae+WyQCBoKyjZK/AdAegrXIMjH087h9l0HMCuxOUJJXgSXH0ZUVNYvCbW/fgz0Qb8fWIwwcfrzG5Ry5zHSjLK7dPmcaqPh+njbt6ZxLrr7dwSAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059873; c=relaxed/simple;
	bh=PgPMCsAMvYDXqHmBEiURSZbEai1r8SRoiyzLYHHPTM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SpF3I+cH4KRAg7Fe09jLlTGKrLeC1vX+XZNt0FpkqFP+6XcI1eQVwY/2+NwF2R5fV9VV8SUWmaisuR/XXlbTDFRINyAOUA3UrPQHHpa464+XXEabZiS6GVEKyNq3v74vtHHyxVn6rSAqQJy1FY5vJKcnppmuATViH3mA7v1LEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Q+VzB5Jk; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id AD042454BB;
	Tue, 16 Sep 2025 21:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758059869;
	bh=PlpYodVU83nYWNLYQK9ddsNqIeKI/2NAjNxeXVbhweE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=Q+VzB5JkoRGGno/1x3GTox6YnhPquy1i5nywpdKgNn5VZ0KboQeSdEkb5lQHeTSGW
	 YWaUOBdf4LfhtPfyTOABM8Hd+fOKZshDY9VvaLHzbfdnZTQ4yy8M7PrlalamUAmSMC
	 6GQaddZ+Q+A6YJQthlDyqvYbuZ0anlduAjzEDAQZYFQsC+fG4oaOBTKlIKDS/2Yx/y
	 /HxenjRumljYJtdbnmg5LCKZ3piHk8iL/7pi9mtBFPKrtEzdZ7qDABK2eiVqurF+lv
	 w7DyfPT7usd/fkr5EVHJPWh2li1EXb3wPDxorQxMWFeKs6VFc2vhDolDXdpYrL8/VT
	 DZB+k5FbNwDMg==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH v2 3/4 iproute2-next] tc: Expand tc_calc_xmittime, tc_calc_xmitsize to u64
Date: Tue, 16 Sep 2025 14:57:30 -0700
Message-Id: <20250916215731.3431465-4-jay.vosburgh@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916215731.3431465-1-jay.vosburgh@canonical.com>
References: <20250916215731.3431465-1-jay.vosburgh@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	In preparation for accepting 64-bit burst sizes, modify
tc_calc_xmittime and tc_calc_xmitsize to handle 64-bit values.

	tc_calc_xmittime continues to return a 32-bit value, as its range
is limited by the kernel API, but overflow is now detected and the return
value is limited to UINT_MAX.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
---

v2: add Jamal's ack
v3: no changes

 tc/tc_core.c | 9 ++++++---
 tc/tc_core.h | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tc/tc_core.c b/tc/tc_core.c
index 32fd094f6a05..a422e02c8795 100644
--- a/tc/tc_core.c
+++ b/tc/tc_core.c
@@ -43,12 +43,15 @@ unsigned int tc_core_ktime2time(unsigned int ktime)
 	return ktime / clock_factor;
 }
 
-unsigned int tc_calc_xmittime(__u64 rate, unsigned int size)
+unsigned int tc_calc_xmittime(__u64 rate, __u64 size)
 {
-	return ceil(tc_core_time2tick(TIME_UNITS_PER_SEC*((double)size/(double)rate)));
+	double val;
+
+	val = ceil(tc_core_time2tick(TIME_UNITS_PER_SEC*((double)size/(double)rate)));
+	return val > UINT_MAX ? UINT_MAX : val;
 }
 
-unsigned int tc_calc_xmitsize(__u64 rate, unsigned int ticks)
+__u64 tc_calc_xmitsize(__u64 rate, unsigned int ticks)
 {
 	return ((double)rate*tc_core_tick2time(ticks))/TIME_UNITS_PER_SEC;
 }
diff --git a/tc/tc_core.h b/tc/tc_core.h
index c0fb7481420a..d80370360dec 100644
--- a/tc/tc_core.h
+++ b/tc/tc_core.h
@@ -15,8 +15,8 @@ enum link_layer {
 double tc_core_tick2time(double tick);
 unsigned tc_core_time2ktime(unsigned time);
 unsigned tc_core_ktime2time(unsigned ktime);
-unsigned tc_calc_xmittime(__u64 rate, unsigned size);
-unsigned tc_calc_xmitsize(__u64 rate, unsigned ticks);
+unsigned tc_calc_xmittime(__u64 rate, __u64 size);
+__u64 tc_calc_xmitsize(__u64 rate, unsigned ticks);
 int tc_calc_rtable(struct tc_ratespec *r, __u32 *rtab,
 		   int cell_log, unsigned mtu, enum link_layer link_layer);
 int tc_calc_rtable_64(struct tc_ratespec *r, __u32 *rtab,
-- 
2.25.1


