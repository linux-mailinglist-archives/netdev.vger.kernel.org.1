Return-Path: <netdev+bounces-280246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONTEGiPe52kBCAIAu9opvQ
	(envelope-from <netdev+bounces-280246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:29:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6CB43F75A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37F7B3103F76
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60303DDDA1;
	Tue, 21 Apr 2026 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="f1xBHmSV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105E34DCFF
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803046; cv=none; b=NjZgUQpHxFAYVX+NpaQ8Xpbj172aDpAcnZL2mWvBnRJtKh1S31DalfhfHbczgB5/9+c6//syS7PDNUxd6qVcKyVeZObmjDQa03wraLZPAMjuBKz/P0T15aYqAE/tGye+31gt+5fbLMV9SQXfCzrOPBzv//dbAghoCxY15D0ZL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803046; c=relaxed/simple;
	bh=/Id4Vkj5hUUlD367m3ge/EI6RWax6cGg9wZAlGeekGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edU7VL/QKrs/GYbpD5WtRQb8Adn97lrUxk2c7TAioY3U8Jw6kITUtfcQyOicGLzN/s8W99QsQ8MRY427Q6qmWaYA/bdKkwy2OXM9qWmcvnR+/EZbKdX/MjDosZ9ociRIQk3FI8kdLKMYJYt5oO65s1nhLDnP0l1cT5VN4tJoaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=f1xBHmSV; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d891442388so6929523eec.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776803044; x=1777407844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0eOIKhmn4Nq6DnuLze7YpIhxlkvWgvIcRLfyh15Jn78=;
        b=f1xBHmSVCRWRrltAUYYLx2SJ0hsDIsZF8VzrKnZ1TwOckdcgoR92mLs75Le/UnzSh7
         o8HnKgkseOkhtu67945YLmUDlf9YPnLhgmEpybF2SLjC3EfEupVnuBnUiJqCT0BMUard
         8FmTmysjqp9o2QKFOB4lm4OGjAMibZTSph9H4Eig7euDt3b/zhdf4MTjOPIse+9ATQev
         6O2Nvkl/jDIcyxx3EdDeIra60G1abSlWwfpsdP76+k61Hx/eMBT6OCnfMxwfFXshwsa5
         X8lobrNKTeJ2TPeLS/asCIhMD8kV6iE54IMzEEapTbpsdoEPRKcIVCN9qmn9oJN3345l
         dkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803044; x=1777407844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eOIKhmn4Nq6DnuLze7YpIhxlkvWgvIcRLfyh15Jn78=;
        b=LmuLsJ02XridoToy+B3yA9BR3+FZ+VUl5pL58kQoKNacl38gS1GsoQTyVmEKK6Zxh+
         o8kYbTc4e/NVA8j2F+fMnPp1JgBEsX5BA17LyAZ5obJatm6TUdI+87n55NwkRtIWbnTS
         cv1BsXD7RGrCBv6CdPZVm5wvlOCdNVmqivQXVstGpBSrk194s8/Vx6rssi8UKU/Tu2VO
         zlaQxE/mKKGlmBkyFpnVdXfmcvxJHEy2kVvA2myN8XRQKr/wDrTmBDFMIwXaHNxEeFzx
         yTSkyOAeGjNMkiWwmTNlpTkw/6K/2S0dDz6lGMXbB+m7aP4YNbasYOpOi4JJKm9n1f94
         HsVQ==
X-Gm-Message-State: AOJu0YxZi4QScEjfMhcoqPvz2UkNdvfxPymy+wV/WIc6jgrRTfr8ArrK
	H+IXfKr/vREhxEkINydKNVksZYubFtj44fiHHlQ/ELdnZ393v4XaIGa3BSbu1c1koV8kSY+kjDS
	sndbv
X-Gm-Gg: AeBDiesKFxA7lPtKrR0LQPwW7ZCqpgNkx7LbAExy+0ArJZzYeCAjbH4Q29awhBv027a
	tXLPH9CSkvZEmNP6guizOgQmBwwP6Dpl/AUffjpoY115P17FCee+VQuclIQA71kLn+xjwYELqmg
	+u4eX8JHcid0z9sL3hbRvIPImBZhHMxd+2MXweea64AhFkSUXAEA/5qp+rBffEjX7qzVhh0SxxI
	Skzlq5cPtINhvPuYTb0Msl9nP0eaMrmxj2KcJvIKX1FdNd37opyLrykAsTna1SRAYA8K+6K1WCX
	A7zbe/zstQLxeoRJyqFP+/8oyFrt7fZuOBF7B2fwDu1yyi6m+t4Ooi74/niwJY+ggVQIrCYoo7S
	CdiZgJ8t+8r4oirfxDi7kRHYEjwi2ZD1509CcA4pa+Yn0s2STG0sk5Km3cM6j0Xc1gIHyo4a9wc
	nWBukVfegsiDwgle5OXaW9EOux3XsVzBWS3qFva6WyrZE=
X-Received: by 2002:a05:7300:ed18:b0:2d8:7302:d3b with SMTP id 5a478bee46e88-2e4788392e5mr11199966eec.18.1776803043789;
        Tue, 21 Apr 2026 13:24:03 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ac84c38sm20941163eec.13.2026.04.21.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:24:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] lib: add input validation for time, rate, and size parsing functions
Date: Tue, 21 Apr 2026 13:23:59 -0700
Message-ID: <20260421202359.632074-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280246-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,networkplumber.org:email]
X-Rspamd-Queue-Id: CB6CB43F75A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The parsing functions get_time(), get_time64(), get_rate(), get_rate64(),
and get_size64() use strtod() to convert user input but don't validate
the parsed values. This allows negative numbers and overflow values to
be passed through, which can cause unexpected behavior or security issues
when these values reach the kernel as unsigned integers.

Add validation to reject:
- Negative values (which make no sense for time, rate, or size)
- Overflow conditions (when strtod() returns HUGE_VAL with ERANGE)
- Empty strings (already checked, but now with explicit comments)

This prevents potential issues and provides clearer error reporting.
Fixing it in iproute2 does not mean that the kernel is off the hook
for handling negative values. Checks are still needed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/utils.c      | 16 ++++++++++++++--
 lib/utils_math.c | 25 ++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/lib/utils.c b/lib/utils.c
index 1215fe31..50602e59 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1647,7 +1647,13 @@ int get_time(unsigned int *time, const char *str)
 
 	t = strtod(str, &p);
 	if (p == str)
-		return -1;
+		return -1;	/* empty string */
+
+	if (t < 0)
+		return -1;	/* negative value */
+
+	if (t == HUGE_VAL && errno == ERANGE)
+		return -1;	/* out of range */
 
 	if (*p) {
 		if (strcasecmp(p, "s") == 0 || strcasecmp(p, "sec") == 0 ||
@@ -1693,7 +1699,13 @@ int get_time64(__s64 *time, const char *str)
 
 	nsec = strtod(str, &p);
 	if (p == str)
-		return -1;
+		return -1;	/* empty string */
+
+	if (nsec < 0)
+		return -1;	/* negative value */
+
+	if (nsec == HUGE_VAL && errno == ERANGE)
+		return -1;	/* out of range */
 
 	if (*p) {
 		if (strcasecmp(p, "s") == 0 ||
diff --git a/lib/utils_math.c b/lib/utils_math.c
index fd2ddc7c..4b0ac266 100644
--- a/lib/utils_math.c
+++ b/lib/utils_math.c
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <math.h>
 #include <limits.h>
+#include <errno.h>
 #include <asm/types.h>
 
 #include "utils.h"
@@ -42,7 +43,13 @@ int get_rate(unsigned int *rate, const char *str)
 	const struct rate_suffix *s;
 
 	if (p == str)
-		return -1;
+		return -1;	/* empty string */
+
+	if (bps < 0)
+		return -1;	/* negative */
+
+	if (bps == HUGE_VAL && errno == ERANGE)
+		return -1;	/* out of range */
 
 	for (s = suffixes; s->name; ++s) {
 		if (strcasecmp(s->name, p) == 0) {
@@ -70,7 +77,13 @@ int get_rate64(__u64 *rate, const char *str)
 	const struct rate_suffix *s;
 
 	if (p == str)
-		return -1;
+		return -1;	/* empty string */
+
+	if (bps < 0)
+		return -1;	/* negative */
+
+	if (bps == HUGE_VAL && errno == ERANGE)
+		return -1;	/* out of range */
 
 	for (s = suffixes; s->name; ++s) {
 		if (strcasecmp(s->name, p) == 0) {
@@ -95,7 +108,13 @@ int get_size64(__u64 *size, const char *str)
 
 	sz = strtod(str, &p);
 	if (p == str)
-		return -1;
+		return -1;	/* empty string */
+
+	if (sz < 0)
+		return -1;	/* negative */
+
+	if (sz == HUGE_VAL && errno == ERANGE)
+		return -1;	/* out of range */
 
 	if (*p) {
 		if (strcasecmp(p, "kb") == 0 || strcasecmp(p, "k") == 0)
-- 
2.53.0


