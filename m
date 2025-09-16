Return-Path: <netdev+bounces-223723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B7CB5A3E4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A726326FB8
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFAA306486;
	Tue, 16 Sep 2025 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cvY9HlQA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E02E7BC0
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057872; cv=none; b=aZNhGQOZdgx96jSSF/DQ08cWIutVEciTwi054stRwhPx9PnsvgHYwekqSN9D4ElMzHx5LzEURXVq0Pi9j42mZPbQB/plaPr6OxNUZHA3kRtdvW+Eqc6pk5kWe6e6rYooYfWYKPSiGu+a/XhvUZBXvUb2HItN1cGDp4fH7yAY1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057872; c=relaxed/simple;
	bh=U0DQSUXzdkGCUtIL08J1kUH9ilNAl6CZDf4WX63sCP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0vqLvtH3l2enl6tS0iamJCYBVGxa/jU+5KOZU6BC11qP8TAvSL+s1HWxx1QsreE5nGsagJG9S+5Xs+8gZZuIrz9Tc9VdijfPyB9Y3HrWvzwbh/vGPLwXv0aR94inRxV7UhasEKCID2AcrAjM2JAIHCu5MO9FDgRJQpPm0f9Fo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cvY9HlQA; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DF2AC454BA;
	Tue, 16 Sep 2025 21:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758057860;
	bh=+1N4rXxwwvPb2u5UuWSyCXXmpo0LZoVx2I6VhnGhIKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=cvY9HlQAjKFYvrOEjx0Z3qaVhT2kTpvlZzdaK2jRQMDT6kbIyJtlvR37vqpIK7SYX
	 oH6S9WuzMfUgI7UWxRGczFQPBUd0l48fzzduL42IfKSUg8jKXPGG3LviHVpY6t9m31
	 nvwsDoijbq8hHHeWNpo/bSlG0qndk+EZI54dGhDX82vcP2JBkH6MKXt4zmT+gfmpNs
	 X/0zkKWjM3io0Gb6fIC8V/1IY8g5n7pxMn1dXU1qL3+Renm1wP0a+A2bIcZ0wbpCHv
	 ESz0QWuhA/vMy/r1pKbGMQBj4lrzwEDcaUBwJYhQxr3pj4w6DG29CCyNtTQyf+WMkN
	 sbn98yEMkUVAQ==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH v2 3/4 iproute2-next] tc: Expand tc_calc_xmittime, tc_calc_xmitsize to u64
Date: Tue, 16 Sep 2025 14:24:02 -0700
Message-Id: <20250916212403.3429851-4-jay.vosburgh@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916212403.3429851-1-jay.vosburgh@canonical.com>
References: <20250916212403.3429851-1-jay.vosburgh@canonical.com>
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


