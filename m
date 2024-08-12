Return-Path: <netdev+bounces-117702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB2594ED82
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3281C21DBC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D977217D346;
	Mon, 12 Aug 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="csCCVyQY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768317CA04
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467470; cv=none; b=uypvtLU0X+sGm5JSG/kThpTkwZFc4ytmcDwwSxZ0i7o0HErEv4bX/gLdjEOfVirRvCJRFXL+hhsWNRoUlbg/ZDfEyPA1JB0aHDiwuEoohZc8/TLlxTb0wGWbIq7Lcb84zp5tNgDiDEXuAeJiWfWyIaqdRWl13zWvmdr03N4F6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467470; c=relaxed/simple;
	bh=7D4nSopAswje42tiwfemXKteeIJlxL8CBnP83xM8vMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W2r34mlcxD+MBmt9Nt8ZbgsjxB+R+r8PkfLLZpfwgVMRqdG8c/7F+wzK34zTy89QToYu9dRZLYA6dRu62DHVAxZW/rhPeq6alnzzR9cE5Ol2ubvcIBHH1PPezI3HD2i1r/lMBAu7ULx2A13mDcMnIb0LrTQRxfFzClZvNmzYJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=csCCVyQY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb53da06a9so2849406a91.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723467468; x=1724072268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8EIjZ+dOaHiyTQHWoEcWpqwaxp1crrF3ZUUT4V7ceY=;
        b=csCCVyQYpAGMV/2jvPAAWSan3sxedvdHRjPQypPCYy4s/ao6ZEqMU86RT84rxmv4Vs
         /gTMds7ik6xVnflvP/cLASq5l3I0NTKJdi/kU6o3hZpmLRbfsGFxuwCmJhFN/1/IV6W0
         bz5bYHsoR5nrvBBhAih5Nj772TDLiX/t7EZTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723467468; x=1724072268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8EIjZ+dOaHiyTQHWoEcWpqwaxp1crrF3ZUUT4V7ceY=;
        b=SABWxrgE9EZZSgnUECB3pC1Z30fDJrra7LSyHYQnQ7R47Nrzv6DyczXn+ZApjLbu9p
         im/rs256QX24toOBAXnQe5pmNFJNut4Jxo0G/utb1yvTXBx85PbFncO264HoRl04m9Dh
         bSwTR7JEWdSEisspFho2gHlCkim6MmWDJLhZbYwruBzZqfskTwOQlfd4FCVhUMO0bbWb
         jhRnTQr77FzGKOSS2O3O0B/vWiMcE2jD6Tp0vAmy5f4k9TsYuI6ZzvqV5P74CM2/Ilyv
         CDI5tp+WHP5f330nO5uCLohkECFqNv1/XvLkKWU5wKSwFj+BNBHyL2FU9QvUDKanVEdL
         Le4A==
X-Gm-Message-State: AOJu0YzHtztLG2yBpUy+wMpCDtY2DOlRay4j07F69lmwcdojhGzVv6nM
	HNh39OMAcuTmGilKP80hWaAzu9A/1kIQdP8Obo6VA+j3af0h5cgdMIFiOFf8jaTnjuhoFYac2rk
	OurNTwTgTtyAk12CI+SZo2LFNVLe7+B1+ZxMvDSEjwlS4KPdhK1oXT9TTUizo4jh5Qoxs6WHlP9
	zPgDcGSl47X53WnvN4zdOrF6v5fTnOdxtxRl4vIA==
X-Google-Smtp-Source: AGHT+IGhoYSk07I5fC4BrCFew7CkXaFEzmv02TFPAarMCe+LsdgSiAssK/J9JSq72T4HY5C3UL3rwg==
X-Received: by 2002:a17:90b:350c:b0:2c8:2236:e2c3 with SMTP id 98e67ed59e1d1-2d392abdd84mr10304a91.17.1723467467903;
        Mon, 12 Aug 2024 05:57:47 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9ca6fafsm8183368a91.34.2024.08.12.05.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:57:47 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 3/5] net: Add control functions for irq suspension
Date: Mon, 12 Aug 2024 12:57:06 +0000
Message-Id: <20240812125717.413108-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812125717.413108-1-jdamato@fastly.com>
References: <20240812125717.413108-1-jdamato@fastly.com>
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

The napi_resume_irqs routine effectly cancels irq suspension by forcing
the napi to be scheduled immediately.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 include/net/busy_poll.h |  3 +++
 net/core/dev.c          | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 9b09acac538e..f095b2bdeee1 100644
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
index a19470253eb4..bd23f2c68558 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6505,6 +6505,39 @@ void napi_busy_loop(unsigned int napi_id,
 }
 EXPORT_SYMBOL(napi_busy_loop);
 
+void napi_suspend_irqs(unsigned int napi_id)
+{
+	struct napi_struct *napi;
+
+	rcu_read_lock();
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		unsigned long timeout = READ_ONCE(napi->dev->irq_suspend_timeout);
+
+		if (timeout)
+			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(napi_suspend_irqs);
+
+void napi_resume_irqs(unsigned int napi_id)
+{
+	struct napi_struct *napi;
+
+	rcu_read_lock();
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		if (READ_ONCE(napi->dev->irq_suspend_timeout)) {
+			local_bh_disable();
+			napi_schedule(napi);
+			local_bh_enable();
+		}
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(napi_resume_irqs);
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 static void napi_hash_add(struct napi_struct *napi)
-- 
2.25.1


