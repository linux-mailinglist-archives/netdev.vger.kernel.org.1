Return-Path: <netdev+bounces-141683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E12A9BC06F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E7B1F22697
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC3D1FE0E2;
	Mon,  4 Nov 2024 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hqrlQdJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF721FDFB8
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757412; cv=none; b=pjqaO7DuehPieVQbXHx6bBp8Y9LQB2vbHGRb+HWbOZROEOX2JbGZI7Xvkseuj1JsIatu4XBh5IpPC3roeLIR1wU2xS9TdqPQ9DDj92/+tO2U2VmHP6j5CHCsn2GaHF9hOREOqWYlF6dAiteLLkQ9bdNKGs7yhwSYSF2Voq2Fj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757412; c=relaxed/simple;
	bh=OodwMsu6GphoAslfKl1LgS8kToCLyqz2m3IDnGDSc7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqBr30Jvfbrlstj97VGKCLnUDbz3YL/rbLAOfI3Tt1FAMlAPDK1ByzZAe5mQvo5OxLm8UfKPGEKJ1iCsFVSR8QBoimSQvTVbyw2k6fHHi2C3r7argrdZazL/IZqHPo+NeofXwvntLa1mGtHmXDGacKYVeP+rWXb930lHEZNN1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hqrlQdJV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c9978a221so48194335ad.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 13:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730757410; x=1731362210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHTcnyI8OB/3G3DumGaoUFWEu1m3gZBmE22QPK1+GKg=;
        b=hqrlQdJV6trD6ujHD6ghldu3Q6uC7Ck2VP2rEAuizhaifU4FHhii9z1C3+9VvovZSe
         nSb/1EHSEJxPAN/a9JB+LtfHerPF3m4ZkLBk4YM6LsxA9ooTqs3x/IQg846s+X2i99Oz
         UmeGe1bv4Y/bPt+bbeAHHRKPvAE2n6edVxg3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757410; x=1731362210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHTcnyI8OB/3G3DumGaoUFWEu1m3gZBmE22QPK1+GKg=;
        b=DOmkcxEt1m4voavbr6T8a9MtztXmJME2gROE+8uyevling2zULrKCGnmnxEtQuh+mf
         AbwrH7pzGBMyrwDMLs5GOVvurx+IQtIVjkNfdYNGaCn3r2qN2Rb3dqLb/boLrzDIHBBR
         w148ACjp9Cg8ldm7RnweWNcmvtrUrDEC3BQaTYMOseiWRp6jPAT3ANvDtB24nOdVmq5q
         SjLpRd1dU7pGaqiblFjsAQhiNAr+acw1whWwiqWhjyKD+QHvB2p+XfbbRG9suS5JEzYM
         /km2vrOtJnyfG8B/4SRlFxxhP0fgxCZsl0Rd8sRePVomAb1/v42FP76V6mkJEG/zyfCu
         cSvw==
X-Gm-Message-State: AOJu0YyfPjX5ACMxtLE9J4wL+v68+hReDK01XJ4vuJVsDCExKRPO7TAm
	XrFsHqt5xUH7xFKnJDtCQ9xCZTiHq0JJd+TMBjHFe7Rz7tp0bi+X0Xt/4ihJyJbx/SH7N756Bvb
	t/mqSgmtYCHE8J0XkY+kLcU1fKmQqvOYSQ2gxASx38N6E57+jQgKmNdbMu6HE7BeE8QQ5fBjmMc
	npPdD97EWe8alMl7ualg/sP3GU9JjG/8VbLqY=
X-Google-Smtp-Source: AGHT+IHzwf6vbF478BWj4+FrE88DtdyBD7kSBvF5CWlyGuwguVJXVL9Rzcja4x7spau6sxINfeFGlQ==
X-Received: by 2002:a17:902:ea03:b0:210:f6ba:a8c9 with SMTP id d9443c01a7336-210f6bab1d9mr277568575ad.17.1730757410095;
        Mon, 04 Nov 2024 13:56:50 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057062b8sm65860255ad.63.2024.11.04.13.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:56:49 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
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
Subject: [PATCH net-next v6 2/7] net: Suspend softirq when prefer_busy_poll is set
Date: Mon,  4 Nov 2024 21:55:26 +0000
Message-Id: <20241104215542.215919-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104215542.215919-1-jdamato@fastly.com>
References: <20241104215542.215919-1-jdamato@fastly.com>
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
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v3:
   - Removed reference to non-existent sysfs parameter from commit
     message. No functional/code changes.

 net/core/dev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4d910872963f..51d88f758e2e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6239,7 +6239,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
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
@@ -6375,9 +6380,13 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
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


