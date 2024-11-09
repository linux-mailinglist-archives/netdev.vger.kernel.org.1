Return-Path: <netdev+bounces-143497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568CA9C2A34
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 06:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C12B284687
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 05:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4AC145A18;
	Sat,  9 Nov 2024 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="t/evmyu8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1913A89A
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 05:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731128590; cv=none; b=JP3VTibWcpG+VS5poB/DR3Qel/kAoP1lMUt34ZPHIfCM1159Bk6UrUH2uV7z/6pc1iyB5S2i/0dUbr3c/U2/UcTLChTSax8LInCcMj4rXlnVTc1UZq4cVEpaWevhQlkd1D9+UEgsZJn3sLgnlO9X8mbIsgcgT5QIzlOVNRsa+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731128590; c=relaxed/simple;
	bh=7YkKWB/VoyUXO1lGGm/ESxIvFChf/k/+Rh3/h3kzr9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q07fvEyv3Z9kGypEZ2FRC6xhEU4RUVR2qZblKCO6+FSjKJ0lY1jxsQvBVl1JkZIy9HRimrD1mIrsI98VWjgVadOIZX5dhGrTcZuStBaJdeCjF67ps9RA/czNX4HZmKbTODRrrdEgznFzyfdPjbeelq1cP/OrRwj3euwIz9n8O+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=t/evmyu8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cf3e36a76so30932705ad.0
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 21:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731128587; x=1731733387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HzDb2SxhUo/TAU2Mmq5phfYmvXMmtRzJHslebclKIo=;
        b=t/evmyu8G4ny8Jj6n3S6uWHTe17BFJZAhatSr6DDRc8Ln8hL4O8YtaDMM8ulvpLiN5
         q5oo7IOkdsp1eakLyNNeQyfN/M7HuPlGdM4/fjkCWddtoz9DDfUUeztN+pvZrwGu8yBE
         MSffHIoLcc9KMa/BQ44jQLGKXwJpciRdqdGDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731128587; x=1731733387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HzDb2SxhUo/TAU2Mmq5phfYmvXMmtRzJHslebclKIo=;
        b=q1SkBMsOIIq3XbYoW9A7cU3+fXceS6jaWDYr8U8ZuS9W6B9CT3O1uuh6PqxYIZjgcm
         AAHoebQTT1VSIZme6+609UfDeJSiMr8oH1HU2vJFwmM+7VgrGHGB2ontqX7souuxLmLS
         EMsTV3pTAJUbEJauoCm0FZpbktANFREHprNuZ249wJ0oveXRRCXg04eNUKKzbw3yz3l9
         rXP6fWSFJKOSIINeH63y1HNqme7AhhcQtm8M8+WE/V35VNFtRIPdhb4+0khRLRcmtyNJ
         OPS7AJuPGhjEOng/KgoMFNDqj/KiavesUg9uxwi3HTWVc/o27hcp/q7vfjeeRgHxV6s3
         OC3g==
X-Gm-Message-State: AOJu0YwptipKAGZslxpnWHXCRs4eo8zhMqoHsX5FxEI1PjStDOUMJxwm
	gBB/GfIlYhGvlm5VgcbhMpa/nBkyikz/OJe9NC3McHAFreT1Gw2JFANdg8tSxdjeolxHcFR7dtF
	F4ttHPSfs0LTPOZcaEl7Jurx+J6hQiXWAz2+PJTar3FeXF8zYHxvP0+twBCSLhmJye+rOEEQxV5
	sjgVFRRy26UeYHQH/hkrPVo8Ecl1H2ATgF6rE=
X-Google-Smtp-Source: AGHT+IHzB6H5fYYWLx9Q/0EgCmqqmoSLpb0RpBfHo0MP/hNXaD4wRBqJGO7LLl2PREd6yNCUXUCBSQ==
X-Received: by 2002:a17:903:234c:b0:20c:8907:90a with SMTP id d9443c01a7336-211834f3291mr77516525ad.5.1731128587405;
        Fri, 08 Nov 2024 21:03:07 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5853csm39182305ad.186.2024.11.08.21.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 21:03:06 -0800 (PST)
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
Subject: [PATCH net-next v9 2/6] net: Add control functions for irq suspension
Date: Sat,  9 Nov 2024 05:02:32 +0000
Message-Id: <20241109050245.191288-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241109050245.191288-1-jdamato@fastly.com>
References: <20241109050245.191288-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

The napi_suspend_irqs routine bootstraps irq suspension by elongating
the defer timeout to irq_suspend_timeout.

The napi_resume_irqs routine effectively cancels irq suspension by
forcing the napi to be scheduled immediately.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v8:
  - Drop unneeded exports as pointed out by Jakub.

 v7:
  - This is now patch 2 instead of patch 3; patch 2 from v6 was dropped.

 v1 -> v2:
   - Added a comment to napi_resume_irqs.

 include/net/busy_poll.h |  3 +++
 net/core/dev.c          | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index f03040baaefd..c858270141bc 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -52,6 +52,9 @@ void napi_busy_loop_rcu(unsigned int napi_id,
 			bool (*loop_end)(void *, unsigned long),
 			void *loop_end_arg, bool prefer_busy_poll, u16 budget);
 
+void napi_suspend_irqs(unsigned int napi_id);
+void napi_resume_irqs(unsigned int napi_id);
+
 #else /* CONFIG_NET_RX_BUSY_POLL */
 static inline unsigned long net_busy_loop_on(void)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 4d910872963f..13d00fc10f55 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6507,6 +6507,43 @@ void napi_busy_loop(unsigned int napi_id,
 }
 EXPORT_SYMBOL(napi_busy_loop);
 
+void napi_suspend_irqs(unsigned int napi_id)
+{
+	struct napi_struct *napi;
+
+	rcu_read_lock();
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		unsigned long timeout = napi_get_irq_suspend_timeout(napi);
+
+		if (timeout)
+			hrtimer_start(&napi->timer, ns_to_ktime(timeout),
+				      HRTIMER_MODE_REL_PINNED);
+	}
+	rcu_read_unlock();
+}
+
+void napi_resume_irqs(unsigned int napi_id)
+{
+	struct napi_struct *napi;
+
+	rcu_read_lock();
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		/* If irq_suspend_timeout is set to 0 between the call to
+		 * napi_suspend_irqs and now, the original value still
+		 * determines the safety timeout as intended and napi_watchdog
+		 * will resume irq processing.
+		 */
+		if (napi_get_irq_suspend_timeout(napi)) {
+			local_bh_disable();
+			napi_schedule(napi);
+			local_bh_enable();
+		}
+	}
+	rcu_read_unlock();
+}
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 static void __napi_hash_add_with_id(struct napi_struct *napi,
-- 
2.25.1


