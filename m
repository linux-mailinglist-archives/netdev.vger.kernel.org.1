Return-Path: <netdev+bounces-141142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D29B9BB0
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 01:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013B81C20DB1
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 00:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E0A82890;
	Sat,  2 Nov 2024 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CXmVSRma"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA26026A
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730508861; cv=none; b=FR/Rf3Cl8KznjXjDSx3KF1K9A3va3vgwBBg2yEEp6+/aDacFiTksY+/HaiT3rqbYb8BkwRkNUT9xFhdA6pwm61jxVF0KOxcDSNICVWilwOV2cben6tB1GKkRUDGcEgcYmpPaN38inXVzzp8M0QtrtygWUq+vwL213hrYl+lUxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730508861; c=relaxed/simple;
	bh=EXm15slGzNfWnVCcKwhjpW2xItI7qgGF3EZnB+IK4Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObWtBKVvNOeG+LxuSxy5N2Bw4o7iKSHdC+00eBwg2YWfVpgpu3nfkm1HB9OoRG30j0W6O+kFZO2vmG7sAdVITokE1hTfdC0C6hjo/ic4CmsHUoK2WqC8vQDl3fBPpGnW3k4BXt1EQ0D3MdKHcYCuxxtuTLaSXfkGmBXF8Z7Ddd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CXmVSRma; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720d5ada03cso1006296b3a.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 17:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730508859; x=1731113659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL5GkRrdAcnvufIgU1SQ3kxTcrHiAI2zj9uGsjrWFFg=;
        b=CXmVSRmaIYi+rXra4EuUayEkw6KCAIHEeBtLRsDubI7R1R+1cfhoo9RmUvqh+z8+if
         wRA1dB5T8+4y+z+2bwQn5Snb7c4hIQjTmNKZRGornzvGJTH6hHUMixKDnWT0rm+w3wnZ
         zn2nr8ovXpmAcH7eYvPFXnlUdizc4yyX2KOYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730508859; x=1731113659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gL5GkRrdAcnvufIgU1SQ3kxTcrHiAI2zj9uGsjrWFFg=;
        b=dJg20irV4Tu5Zc2lXByt+ShvwADQA+vbXUgRETFppduWufriEnD5/Ovb1UQ5/xbYAg
         i0OyutLsERwESsZuAPJG69WOHnGC2Xtj7+cHJ5XVLSkhed5HowUAeEEesE3C3jxIveh2
         UJJXtoFX1xKeX04+JqVxjIoiHQ0GU5XFPu3/Au3cr7D4ZEr8kRApaDFoqUjz33MEx1ge
         xWC5ClsVmLrfunmUF/mB9A7uZZDsnIvrtem18k5MG2FwOf7iMxHmZ5gNvWXCXqexRn3Y
         8DRu2X6Zm0U4ETNeCRvKj4rWIXIPRmTpRNfWRYqJNAt7XHbRjvo6u7Uahu557FoBa1R6
         4AAQ==
X-Gm-Message-State: AOJu0Yyrg1/l7hl5teDbqHhzf+cW4+LDNWvDwPIp21No78j2Yk87T7Ff
	UbGp5BdXcCmeLC+lRvVCtl3gX8J58VSfm7NH/FrSy4eEo1RnCPXBhTJZpytGhosMI7xcDDAj1Pq
	mkfGaIF0mxcHc8VCLIAt9FbeDfT3wSSnTcgg1pZ499umXeDnU/3Mu0VVBQFDDQWcXptBVL6br/s
	aPalowbEfNP62u1hn4TXG2yjmtnPiD4uUYgyc=
X-Google-Smtp-Source: AGHT+IHLfifiWXbpCOFmxDL/3xKufGlZs0dfdfDi1U3hJyccG7xnDsSU4zrT/s+vSy7RZsciC8wseQ==
X-Received: by 2002:a05:6a00:10cf:b0:71e:6a99:472f with SMTP id d2e1a72fcca58-720b9de116emr11836467b3a.24.1730508859093;
        Fri, 01 Nov 2024 17:54:19 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc3152fesm3274549b3a.195.2024.11.01.17.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:54:18 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: bagasdotme@gmail.com,
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
Subject: [PATCH net-next v4 2/7] net: Suspend softirq when prefer_busy_poll is set
Date: Sat,  2 Nov 2024 00:51:58 +0000
Message-Id: <20241102005214.32443-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241102005214.32443-1-jdamato@fastly.com>
References: <20241102005214.32443-1-jdamato@fastly.com>
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


