Return-Path: <netdev+bounces-220655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5EB478A0
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C2F1B258C6
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0A519FA93;
	Sun,  7 Sep 2025 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="q4S4K3R7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B34194A65
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757209806; cv=none; b=lBe6RIWmGTvGrB1uxbMFZhT7nIyANTYmHgFs1dVNeAxtgTbi57yiRbU/yE3ulnbA74NvIHa7OSfCekm9ZcDiXSor4KWz+ArSr9EkhjtBFno0/ykPpWuULyAlhxIwwFjucMjULpR6GLJlMQt+D+9M2MyTcCEnail+FR6c8Fu91aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757209806; c=relaxed/simple;
	bh=5A7YLcfGe7inGfbpAPXEbvmbLXs907jHUpHIPELTEPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/NlZoMQdbKwtHkpNzguIbNpx8aXIOCjsNSWSNYtSeu5/IowtBiq1l1y6Ikjcs88exrbH2/Vwg1jo/G0n5FhdWw5DIj3i2/U9WTmH1lcPlmV3Et6NIZ/x60AtVAzEuKQwgcyZZQUMqJ5tcjLUS3Tnglx4/ssGHdCM5J/CTP2cRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=q4S4K3R7; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7ECD443F27;
	Sun,  7 Sep 2025 01:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757209351;
	bh=PKuyKYJi6byxAYN1qYK1mhqanIk8J/5vPG8JnZWak0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=q4S4K3R7SgHhZTXxSWUcHSDl5jP+Ol9WHXd8S8tCr/jlTQvhiwLeHlnM4tfAPryxM
	 4SDJmvd2AOkOaUK39NpCTdP2iIx5cu7fb+fUpth9e9oMiUqoVLnHQvAzTLPN3qY/RP
	 lRRZ/hDpmE7nbxabJt8oNrBoMz3FT7j9RGBs01CWXRZ6Ei+JbNwS15hl6GU0iqQzc6
	 Fzm5sBQVygGKs0Lz8Are6PSCBqiKidPavJv4HmbF8UH2j9aLhS76dpOh6ZoD4u7ju5
	 xQFoh3/OEzMlq3xNIGdXv2Mq6OKxUzuBWkgIqrit5QMIvD/rYJg2Vd4rBOYG5iKjmX
	 tUV/Vnwsx2pFA==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH 3/4 iproute2-next] tc: Expand tc_calc_xmittime, tc_calc_xmitsize to u64
Date: Sat,  6 Sep 2025 18:42:15 -0700
Message-Id: <20250907014216.2691844-4-jay.vosburgh@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
References: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
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

Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
---
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


