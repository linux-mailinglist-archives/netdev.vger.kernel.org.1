Return-Path: <netdev+bounces-121459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D4A95D44B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92391C21C56
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2D11922CE;
	Fri, 23 Aug 2024 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="nMfkGg2n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE2191F8E
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434312; cv=none; b=oWA8Jw5FYmXI8QbWueb3oHV1SNGHhBfVafaGQbjNvF8jQW60rr2bcK09qHzuVRmaP0c51ZPcTzM7jXqtTHjAfHP/1s6MFNIVcUPWBupRRFwW9DfXiWK0+Jo+mv7Xx8Qvv3QOGAGDIknQhbvYBfyVCKp40wrGo1Rdf7kczNKLzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434312; c=relaxed/simple;
	bh=LxeFyxsuYCcPtr/MQv2af2sWojNlmhphYuIJiMvBues=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJAVBlJevB1i0Tc40ru2lTsUfk+sWDaeBToE+OlMBhE/wkFRTGdMUshgRdJCCJwErs5FgbyM5QZKiNe46GeKASaP9uqiYa3bF2Lt3gVsqP5Yuwqw1FkQaazwsnMCS1g2hB3GmiV8DOo2dDQb94Srvw15icKiNBNzBCjzr2u2etE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=nMfkGg2n; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-714262f1bb4so1842606b3a.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724434310; x=1725039110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VENZ7u9r+KFqHJZ3BdWz6q0JyzsBYDvzURd4w22e1CM=;
        b=nMfkGg2nH8Ecfi9ElHrvrwn+pvkDxnum08m8jDN2+sCJKx0URNWDCJoHn2ArjkGC5J
         leUXvC7dYpd8tKD9N/YGP7GZLRznRU94kGCzqcq9TCdXl3HHOKrwBE1QdjvRTLF0Zawi
         8JA4WZ08FPYWcz11kc0zTUH5dHwKrinagm6b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434310; x=1725039110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VENZ7u9r+KFqHJZ3BdWz6q0JyzsBYDvzURd4w22e1CM=;
        b=pkmUgqjieF6FCoCuFjIy0t6rmh2603pXbrW0tNHYuVD6Ip/MoSdS3U7idaR7xh0Ian
         fu9/amI5SjwInEbnzTEqrVj/10wWjEhJFsu8DeuV8Udr9frrmNAKCIFKlZJjIYtVQxiV
         TFJozFC7DcOLiDx5Sdejc9+oyQF/6PCfpwau3ZJZwlOrINEDxI16MJYjQ+OwtiweflU/
         FWUq0CW3BBMqPitbRs94DAfT3nuSauvVqBuWrIakTpSGKHMO1eU4gMkPem6Qs8WjiSlf
         VKK+tsxTds7F8nQez5D3CfVMP2SXG/GuRzhlmxdWdkqOraAJ4nUQ8Bq6sEasdlQ7i/yT
         IoTw==
X-Gm-Message-State: AOJu0YxEAraHsDCPYekDvpLk8ZRMmSOw3MzG/1StsZIuqXBhzqReDEO+
	W4BJb82FoL37BqT79VnEKcTRrV+e6MqWCZEKpkWgmwueEmaxQSyGwSNfGYJABRzQ5bPRt4/MT76
	0ZW/ipDxotZcpCpNQ1dl3n5qjXe7VF6xw0qG6jjeCczzRCnIO34/5Oen7kogCGD4wzYPThoah3s
	6UmAul1nVYAO+K53v8qMi8i1a0iDXtE7mZQpi4Vg==
X-Google-Smtp-Source: AGHT+IF80kFwwD0giG0CoU1G7lJncioYNLPbf5NvDHI5LFjxf5lo8LyJnGR5gbXJE+GOFTJmyqHKtA==
X-Received: by 2002:a05:6a00:888:b0:70d:2ba1:2402 with SMTP id d2e1a72fcca58-71445f3cc63mr3053603b3a.29.1724434309626;
        Fri, 23 Aug 2024 10:31:49 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430964fsm3279624b3a.150.2024.08.23.10.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:31:49 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: amritha.nambiar@intel.com,
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
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/6] net: Suspend softirq when prefer_busy_poll is set
Date: Fri, 23 Aug 2024 17:30:53 +0000
Message-Id: <20240823173103.94978-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823173103.94978-1-jdamato@fastly.com>
References: <20240823173103.94978-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

When NAPI_F_PREFER_BUSY_POLL is set during busy_poll_stop and the
irq_suspend_timeout sysfs is nonzero, this timeout is used to defer
softirq scheduling, potentially longer than gro_flush_timeout. This can
be used to effectively suspend softirq processing during the time it
takes for an application to process data and return to the next
busy-poll.

The call to napi->poll in busy_poll_stop might lead to an invocation of
napi_complete_done, but the prefer-busy flag is still set at that time,
so the same logic is used to defer softirq scheduling for
irq_suspend_timeout.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 net/core/dev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3bf325ec25a3..74060ba866d4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6230,7 +6230,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 			timeout = READ_ONCE(n->dev->gro_flush_timeout);
 		n->defer_hard_irqs_count = READ_ONCE(n->dev->napi_defer_hard_irqs);
 	}
-	if (n->defer_hard_irqs_count > 0) {
+	if (napi_prefer_busy_poll(n)) {
+		timeout = READ_ONCE(n->dev->irq_suspend_timeout);
+		if (timeout)
+			ret = false;
+	}
+	if (ret && n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
 		timeout = READ_ONCE(n->dev->gro_flush_timeout);
 		if (timeout)
@@ -6366,9 +6371,13 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
-		napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
-		timeout = READ_ONCE(napi->dev->gro_flush_timeout);
-		if (napi->defer_hard_irqs_count && timeout) {
+		timeout = READ_ONCE(napi->dev->irq_suspend_timeout);
+		if (!timeout) {
+			napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
+			if (napi->defer_hard_irqs_count)
+				timeout = READ_ONCE(napi->dev->gro_flush_timeout);
+		}
+		if (timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
 			skip_schedule = true;
 		}
-- 
2.25.1


