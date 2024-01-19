Return-Path: <netdev+bounces-64378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E872832C23
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2713B283784
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765954667;
	Fri, 19 Jan 2024 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHSs1XFg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22053810
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677141; cv=none; b=taj6LdMIs8BpgySpyhryWcBqtc2eR6oFjEeOx9MbFPZbjjbuFgpatKWI0dXvBqhPc1z0RLqF1l4n6wu2FFyDp9B6hb3keofDAbUHa0HhUNMv1PikKL9RZXDsqAqlOq+OVnC8LJrALUjPLNDsR7pE4RLVvlJBjAo4AAW1FbQMoQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677141; c=relaxed/simple;
	bh=Wvdp8NwroEUnlOcyXYB6fhifFLEf86W+er2ratf6ib4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJ9uL54r2baq0pa8o5EHsIETGyLqbYp4tpDtqTzsiYUrM8eEnRtLXwO18XzIDfhZU3BlqKCAHJjOAWBajJVURbr7L0CWhEW0nWBu+lB/yvnQFS6jLn/Djp5W7aZa3kuZv+Bu9osIfg9xxVfpJDv+ZUBDNBv+saZTIZfk3jodrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devoogdt.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHSs1XFg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devoogdt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso9474505e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705677137; x=1706281937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CVdx0XTXF9oMlbE/2BBUk3oy7mn9BIkXq8b5DHwfmHo=;
        b=CHSs1XFgZy02MUwOsOemKrscOx4cAM1HulvaiKLSTHaOsoy3hdnOywjeP6TNixZc2U
         HkCRwwOIzQMNJhR71XqYK1VxSBm29DA/iHzG3s/9A4e23zYFmEz2+cKjV+ScaULddQf8
         L2g0BTBc7lC/fnvN3bNAlmjwRn75EjXyr6LdcTG1KMX4TBVecnAdImEueKjOJoPdAbLf
         1jOgHsyFSroX0TJmAADXe+26br7na/G2FEMTY7n7c9ifbCzzehH7ZkYfZQXLPxXaks+w
         Qsgxf7F2+QfhU7UjtHpBkCBV9YMzgcH7d2sWUILvOIvsm59f5wqEN6MLWR9B4otlGZ01
         IqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705677137; x=1706281937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVdx0XTXF9oMlbE/2BBUk3oy7mn9BIkXq8b5DHwfmHo=;
        b=fn7Yj6N6hiDZXESEtavd3zjgmTozTgTTSQG7XsFKrNzsXAuiq/oskeKJSMUJRIHi1V
         EO03geHN9EBuNCoT1dGVNi3wXSfT5bvVP/uBcxQL+FyKLYv91IgcKhrUtPeE9Ys5N9aD
         n6ovIWsD5Accb9KNaVOviq1D6b8rrCd6a2316hb3XKjAqgK1lnxdqik6D2SniB/HfOPV
         g8DBA0hf07Kj/N2PwsTxUQjN+hzEj5TZfTMsdpeYtPe76yrWJiG8V3kNYVFrMxVLVozH
         nVtCoXZQMUFTm1e95jNkq441R5oVkBbLUZ1BBtdFp+P3sTFkaivD4Q66BMc5uerzZITR
         1Mxg==
X-Gm-Message-State: AOJu0YwuD6gVFO7aasIs01G7Hy2RkxYJvuWo7gGMo2uAceXPFNlIaNk7
	npsUZaGVHkYKrDqmU79/bmqBtz4PPmsglCcsXPlai+pRVZQjQQ8XoFYCe4FYGJI=
X-Google-Smtp-Source: AGHT+IFqswt8rr5eB+w3XbrpuQtmC48OsJhJXl5UedKOoGcTg/X+a1ET2OSVahz8a1Gfuy80ztbQJQ==
X-Received: by 2002:a05:600c:6743:b0:40e:75d5:c267 with SMTP id ea3-20020a05600c674300b0040e75d5c267mr1720706wmb.180.1705677137282;
        Fri, 19 Jan 2024 07:12:17 -0800 (PST)
Received: from thomas-OptiPlex-7090.nmg.localnet (d528f5fc4.static.telenet.be. [82.143.95.196])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b0040d5f466deesm29221156wmq.38.2024.01.19.07.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 07:12:16 -0800 (PST)
Sender: Thomas Devoogdt <thomas.devoogdt@gmail.com>
From: Thomas Devoogdt <thomas@devoogdt.com>
X-Google-Original-From: Thomas Devoogdt <thomas.devoogdt@barco.com>
To: netdev@vger.kernel.org
Cc: Thomas Devoogdt <thomas.devoogdt@barco.com>
Subject: [PATCH iproute2 v1] tc: {m_gate,q_etf,q_taprio}.c: fix compilation with older glibc versions
Date: Fri, 19 Jan 2024 16:12:11 +0100
Message-ID: <20240119151211.3193876-1-thomas.devoogdt@barco.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

glibc < 2.14 does not define CLOCK_BOOTTIME
glibc < 2.21 does not define CLOCK_TAI

Signed-off-by: Thomas Devoogdt <thomas.devoogdt@barco.com>
---
 tc/m_gate.c   | 4 ++++
 tc/q_etf.c    | 4 ++++
 tc/q_taprio.c | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/tc/m_gate.c b/tc/m_gate.c
index c091ae19..1dacd4b3 100644
--- a/tc/m_gate.c
+++ b/tc/m_gate.c
@@ -26,8 +26,12 @@ static const struct clockid_table {
 	clockid_t clockid;
 } clockt_map[] = {
 	{ "REALTIME", CLOCK_REALTIME },
+#ifdef CLOCK_TAI
 	{ "TAI", CLOCK_TAI },
+#endif
+#ifdef CLOCK_BOOTTIME
 	{ "BOOTTIME", CLOCK_BOOTTIME },
+#endif
 	{ "MONOTONIC", CLOCK_MONOTONIC },
 	{ NULL }
 };
diff --git a/tc/q_etf.c b/tc/q_etf.c
index 572e2bc8..041d72ce 100644
--- a/tc/q_etf.c
+++ b/tc/q_etf.c
@@ -25,8 +25,12 @@ static const struct static_clockid {
 	clockid_t clockid;
 } clockids_sysv[] = {
 	{ "REALTIME", CLOCK_REALTIME },
+#ifdef CLOCK_TAI
 	{ "TAI", CLOCK_TAI },
+#endif
+#ifdef CLOCK_BOOTTIME
 	{ "BOOTTIME", CLOCK_BOOTTIME },
+#endif
 	{ "MONOTONIC", CLOCK_MONOTONIC },
 	{ NULL }
 };
diff --git a/tc/q_taprio.c b/tc/q_taprio.c
index ef8fc7a0..c82bede1 100644
--- a/tc/q_taprio.c
+++ b/tc/q_taprio.c
@@ -35,8 +35,12 @@ static const struct static_clockid {
 	clockid_t clockid;
 } clockids_sysv[] = {
 	{ "REALTIME", CLOCK_REALTIME },
+#ifdef CLOCK_TAI
 	{ "TAI", CLOCK_TAI },
+#endif
+#ifdef CLOCK_BOOTTIME
 	{ "BOOTTIME", CLOCK_BOOTTIME },
+#endif
 	{ "MONOTONIC", CLOCK_MONOTONIC },
 	{ NULL }
 };
-- 
2.43.0


