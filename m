Return-Path: <netdev+bounces-140850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4F29B87D7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DE2283223
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 00:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDAB4644E;
	Fri,  1 Nov 2024 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UxPCaSRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D32D047
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422161; cv=none; b=N0w69xi5ElS7icZ30A0Lt+rfaOA5lIuG/jovmU7ev7uZml0jRWcxhhyxfBk7d2rXGbvyBrLRrHha7TxetMPprGCrftLBvP6m7T9qWZELmiS9GfdS8cPikWICD9Ej4gZO4QV50kWNhDtsBSnZRBgOSb0n/2+2FtL329SpU7jqlKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422161; c=relaxed/simple;
	bh=sxmIdc/sf/bIbzvaUc2kAE34qI248wxvFYvdvCkPsdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ileeveSOnAgk2NXBbwsxgAuh+eYTJbhvmTQ/+PnHFkiuYwpdeUsTkJRSlDfRfNZjBvnuHhDf42BDMOAYAqtwNn5+dN+gViAY+C/8I2s2XcADikchsxosR/EO7cUqKhM/2j9MOiq9K75lft8wxz7iui19EhTGA4oWd4NO4bOPFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UxPCaSRV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso1836706b3a.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 17:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730422154; x=1731026954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C84IinfynAgOtsJcnt7PRBvv5jmEZH+SpaWYZvenng4=;
        b=UxPCaSRVuFLOjK6PyWLffYW/hCT2lnDj+iKACs1qJvSjajUaYaAsKlzAOg9W/ir1IE
         C+Q1uktET4VRmguRf1Stl/KHbplX1F9wrCsdrcl3xvWv1mOEYXPwhm/q3c+1n/UkW5ym
         fll4Q5OrQrsg0KtZmY8FYv3up0/xKUgxL2Wqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422154; x=1731026954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C84IinfynAgOtsJcnt7PRBvv5jmEZH+SpaWYZvenng4=;
        b=hmf0im2NaWjYzZwTy3htlPKMOERZUP7Un6cBOR/HK2SfvstElThgqsenBB23v3qFwH
         kL0Wl0bVobmicucQswZm/AdYU1eAzGY5a2Udr15xyXBJedibRJnB9VaCgBtiNat4aCZu
         SqKGGg99aI1RQM326FL3Kichpb+ygTXW7hO1Uh8slp0C5Gm9fllC9SmBhrzrTUqpr4On
         Tq0RgAET7Hd3m8bPZNq+DQZjOk9klRJn7qc5nnBUpykQTs3zLP42HJ76YJbk4kfNtXKg
         SDAEqH0fxsDpg6Gf5u1j510JiZA2tMqwj3zSFJW9QVUDIlnyLlJ++RAYZ6gKC9lzsvWj
         Dzhg==
X-Gm-Message-State: AOJu0Yx4utnxOzGJ/Mz+bzWm9empnZCmg2bEL4mR5JnfduHL63JQbUTi
	kLR/WIAR7YITNyLshJ/5OAHhbILYiRmkaqcAztsb/GZ0S+/Nv3F5URLWRpMLCRxxzEEK4hdkS/8
	/paMjAgj7qnRbN6vJuOz5rW/3j7EtIdR1luIiSZHfjxS+NLOk0aWtl2VFRjTu3OAYjUDCQFNU2l
	grRgMdHHhlMu/QTGB4pojGsjwJLc5flbjb/XM=
X-Google-Smtp-Source: AGHT+IE9WOD6/yfsc6BWuxiJjhfnL8HBDUHOKZxJZ9gg36KeZpLNUbIMLjPvZ3muP19ag2B9GvlzQA==
X-Received: by 2002:a05:6a20:432c:b0:1cf:34c3:9d0 with SMTP id adf61e73a8af0-1dba420306dmr2642123637.17.1730422154329;
        Thu, 31 Oct 2024 17:49:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a12c27sm1585365a12.93.2024.10.31.17.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:49:13 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 2/7] net: Suspend softirq when prefer_busy_poll is set
Date: Fri,  1 Nov 2024 00:48:29 +0000
Message-Id: <20241101004846.32532-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101004846.32532-1-jdamato@fastly.com>
References: <20241101004846.32532-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

When NAPI_F_PREFER_BUSY_POLL is set during busy_poll_stop and the
irq_suspend_timeout is nonzero, this timeout is used to defer softirq
scheduling, potentially longer than gro_flush_timeout. This can be used
to effectively suspend softirq processing during the time it takes for
an application to process data and return to the next busy-poll.

The call to napi->poll in busy_poll_stop might lead to an invocation of
napi_complete_done, but the prefer-busy flag is still set at that time,
so the same logic is used to defer softirq scheduling for
irq_suspend_timeout.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 v3:
   - Removed reference to non-existent sysfs parameter from commit
     message. No functional/code changes.

 net/core/dev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 68d0b16c2f2c..a388303b26b9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6235,7 +6235,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 			timeout = napi_get_gro_flush_timeout(n);
 		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
-	if (n->defer_hard_irqs_count > 0) {
+	if (napi_prefer_busy_poll(n)) {
+		timeout = napi_get_irq_suspend_timeout(n);
+		if (timeout)
+			ret = false;
+	}
+	if (ret && n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
 		timeout = napi_get_gro_flush_timeout(n);
 		if (timeout)
@@ -6371,9 +6376,13 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
-		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		timeout = napi_get_gro_flush_timeout(napi);
-		if (napi->defer_hard_irqs_count && timeout) {
+		timeout = napi_get_irq_suspend_timeout(napi);
+		if (!timeout) {
+			napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
+			if (napi->defer_hard_irqs_count)
+				timeout = napi_get_gro_flush_timeout(napi);
+		}
+		if (timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
 			skip_schedule = true;
 		}
-- 
2.25.1


