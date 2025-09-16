Return-Path: <netdev+bounces-223346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E05B58D34
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 06:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FA33B3A9B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 04:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6824A2DA769;
	Tue, 16 Sep 2025 04:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fkm2iDgr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD402D7DC3
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998111; cv=none; b=eEI5WIQocGbbJ8sMshC6Omj1Vs2w8CdCkjjoo13jmjkR+U1hLVBOwqAj1NKyloO4030ThqJ5p3UwuzB9UKAfy5mTwt8/cn91+TuWtd0sUVlyn6aJa/W1tTtPgKy8qfMP3Aj47rYjEKo1HcbifM8RK31QMxN/tkFQ1jIY2WCa7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998111; c=relaxed/simple;
	bh=ja+bbJPbRSrQwDXA6/q8IikecZ6d8Rw7OMDfeYI0NFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDk77YDvcGvA1lPDkdWqO6B6bVuPzLRwMeMngd75CiMlGqDpYhc786Jtd3gtlpXshWPKjzsGNiQla4ugr0cOjB5XcuAJBzv6AMf35TzqqbtctWGAqh5IWB7dzB292Uj8K2n+rX9DwJsjVTrNZ4bjNmt+SPH6bxrMzxezv0TGSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fkm2iDgr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-264417f3a26so15970315ad.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998108; x=1758602908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4GnwUXvg4e1SjHBDj7IOnsANmiVf/8g2S4TikZ2k4g=;
        b=Fkm2iDgrcPVBuaesrw7FvVYaF9dMzh7OYHeK4JX3EgxQ++R33RT7gwSxXKWspg2bZz
         5FOFvJ9AkTWPvAhIegP4B+Vj0Gy+5liVRyC8yoicuKPE5FKhfmFF8b8qV0G+MVzpCmms
         4qfEPXAE3lymVWIuTtXVTadXIAI1bFHNZBRgjs69h3p8XbsTTNKEC7MjRXJjx38eAhgc
         zaoIwDnkLZSXNeCZxzCz630o7NNmGpGKTQrdgbdy1CKScwc/89o++bjOv83NkYZeXeTq
         FO51pCkeizUOyu86k/oKP//hAvAEpA9Za35Q8X5WtgOWGeoJmw9MQI/icPPvrJpZWAX+
         n2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998108; x=1758602908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4GnwUXvg4e1SjHBDj7IOnsANmiVf/8g2S4TikZ2k4g=;
        b=nJp0UM0m6yFLgsUdJZCi8C5Y+kvJAJEcpmIWfxIbiNmGqGQ8V5n4l9faX4+VGmrpph
         0q2AiIcQIwH9fNoAyUwB3+52fh4BMhXwa6y7/7bnf8mUgYTPLh+ETxr6rzc9lqXZpMJ/
         X53VX30KrJGYcr//JRc34FwnX1t/4u0ziUwcw8ipJu9K5V0xeEA+0BB7gpRddbsC/yl6
         zkqaH2pPAQf32pxjsi2rKH3DNFGwX6sDbgarKDhKKpnVNgQmRV5pK6uZwhvXQMLCNFsj
         IzFxp2YYXjkZqJJOTM3ZQCnWYu33SVCJ92vduvIO4PqRXY/2TSIrn8vOMMgnf+M6sZhA
         DZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVx7cMlMII3ITaDlngduZI1PVIfCbD6A9ZoVgwWBTsvCiMP2RbEaDJDWPAuO7hQjCw5z8tW7SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLPitVgCNiBsW5fv5s2hdtKZL3C95r9otbqW/r8JTShVa4qdO
	J6ihQorm3dcl7UwaCuVCDEbZuMbZbfJC9HiJiiZDYMwV3upAVyr7f5sQ
X-Gm-Gg: ASbGncsPrRxyrB0jYw46vlaZ1ud1UZABF8NiRNVbBBTabdW4Ws8tFi/ub9gQz9AuWJi
	SpnYvpOfXhSA+mNIo26ZYC8qgHyerg4saGZHQzMvTGGHpkBum78HLsp6BYqlbMWUjIYfD5Oiyxz
	65HxnIIFROHSkibNBbcmBYR71bp1EWSKV6cZK6mliaENGokk0yYTI7IDWPuLwcZrJQm3BQMqHMt
	1/lvQVyvbkVh5pB14xmiLRlrLZM2Ac9wKQQlrsIcSQZUvbEhnQ8RUlJLXIvuKpdtzluY7nZR9z3
	kCDv61RgetGjeX17PbZrxGf5vHljVotAF3t5E10W2LRHukd3a1HouDyOBDl8KFavbqzCyWTiiF2
	1WGsWLanzRde/T92srBX1Bdx0YB/S33uWufu+gv8=
X-Google-Smtp-Source: AGHT+IEX+DuJO9pqL+sh6jlOJbx2wPh/MnPUcew7z+h1RxAPsxkAl191gDKewoy1JkBZ+L5tKb1L0g==
X-Received: by 2002:a17:902:ec8e:b0:25d:d848:1cca with SMTP id d9443c01a7336-25dd8481fbdmr195481725ad.35.1757998107572;
        Mon, 15 Sep 2025 21:48:27 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:27 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 02/14] drm/i915/gt: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:23 +0800
Message-Id: <20250916044735.2316171-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_ring_submission.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ring_submission.c b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
index 2a6d79abf25b..bf73166a1337 100644
--- a/drivers/gpu/drm/i915/gt/intel_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
@@ -392,14 +392,12 @@ static void reset_rewind(struct intel_engine_cs *engine, bool stalled)
 
 	rq = NULL;
 	spin_lock_irqsave(&engine->sched_engine->lock, flags);
-	rcu_read_lock();
 	list_for_each_entry(pos, &engine->sched_engine->requests, sched.link) {
 		if (!__i915_request_is_complete(pos)) {
 			rq = pos;
 			break;
 		}
 	}
-	rcu_read_unlock();
 
 	/*
 	 * The guilty request will get skipped on a hung engine.
-- 
2.34.1


