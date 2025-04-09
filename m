Return-Path: <netdev+bounces-180662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3751AA820F6
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8E23BC823
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721F125C703;
	Wed,  9 Apr 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR1YVk9c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CAC1D6DBC;
	Wed,  9 Apr 2025 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190699; cv=none; b=GjmUOdeUgguve4OdHCOGGpf6szWbnFX5gsdEB1db1GmZNn4xt9RCgf0ZIGwaLXaSUFC74BTYZ9BqGehm6rAGXovPd65zFlL0VBMoWMNz6Gt8rCUPIa9yoLEG31gyAaWMD4B9T7MON3CPJ6BQfMHVKkbw25leiaCI5mWOwQJQh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190699; c=relaxed/simple;
	bh=9y05Lr8UWQZsTrWL/CPzmibQKQ++CzKzchknlhwYLJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYXAfMddVicuuM+BFfOAT3QT0ZmK8lGkC9YY18U7zq02y9r1VA/h8is9Tn54L9TZeaMHhf5dJ6+rn50T1V+Mdlaqva+LXbPcvKEY0BbON1CTbFS9LqFogmTwPx3tka3Y8Wimn7x/MI6cmChzCT6218+FAQZaa7y78qZabQKFoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jR1YVk9c; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ede096d73so29897205e9.2;
        Wed, 09 Apr 2025 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744190696; x=1744795496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd0ZQP+RaOtlGM+Bn/aOlJ8Q6DsEZ41QfPHQrkJtrP8=;
        b=jR1YVk9cLBFnHqNysUdJBwk9ddBfbSm04okKephe52GV/uO38d+k/soA7yIP3I31wt
         CHfes3fpsmxzwW4UtKZ3mCYU5MjWQpwHwH4DzOraNV7tS8hJhBfZzfsqGlZv7r31MUCL
         CK1td8bI/coF4alj6e+6vXNGlh4ng430z6tkJ5Jl+PgyQMXVsp4C6GVgH+pAVn/8ydU6
         nDLhiWIzAND7MiWaHdz+C2+wKt9lF8a0yMHPq1c3wVN0+5TxSmNb2Iuj5NGeYSeuUTTa
         fr0npykId5gllULslGMzPZdot6HX9jM8D1LE8s9DZ5+f4gtooLr8oombqzTPWg8eA/uf
         CWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744190696; x=1744795496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vd0ZQP+RaOtlGM+Bn/aOlJ8Q6DsEZ41QfPHQrkJtrP8=;
        b=sTUdmDXcWpIfymEltJJjM/5/plb6GpX6vJSrCckuvz5NbcCFgobfGmRz7gUOd9wD0b
         fuAgBrNe2r//BMawNcqiQYHVXevxJvZkRvxymUzfZpbgcYWbDtLUBgOGilqEnCWrR1MK
         m92Iq74zlIWm3i2dCupUqE3Z4wWqo1qKVKD9B63cmQ9BVM/FAoULCj/gef3uhCKXllN/
         bv3et6OOIUQYcyG5tvjnae+ILC/IqNSxyBTpinHi6HpQ0FI3lwidmrg6FL9FCbam3Jj8
         X9YeEgRKD2QalzQTN9hUczd3+wxl4KSQ9JjoVARgYkC9Wy7A+XVqRM+4QWQ5K4Oq/W8U
         Q+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlp53fVHXVkxPXmDcKM9Z34rGmlQ5ows/vt69QSCREuUEeMbz+Lu1geXLBObNughU1JMPr498=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj49TL9kbOb/g/keti/XlY8EidhkGP9cuTJFr6pGpysLBKS6O7
	BnJvFRbdgxyYxeXRcGRmydswQUD4BoqFY6zW3n88I4EnefsQUG0i
X-Gm-Gg: ASbGncu7JS3+jBk0KZmziftfBmRvpSHcAVy7CaASsZWhuIl/f71/4RTZXrCgNPiAclP
	r4VIypPOYaXitcXr2Ao7x5NRi2vdM5tpMQCJfTejYFH17DxDjS32M4XVqTvqPBPbqAzMpl/r0Iz
	J28OHvzsL4gvYnlW0P40vDpgaQa++YBQSIZO3XlsIZnK3rMt0y6SE9x4Q+/xQrk07EY7/SzUUs4
	le3QbTz16fX4TqtakmudYB+KQ4hFVS3h8OzepjwVW0dJ7OfDM6R7wCvjE7F+r8ospmIJOf0sauc
	y8ayxhKlDRuv9RtDCHyLHSItyaVm+BNJtKnmMH97UYFv2KrpDXuGgwpFjEufSaXeH2f/qqEocYc
	Vyw==
X-Google-Smtp-Source: AGHT+IE8dy+g6fAtm0+Z63ZSBTKVqiQ1ETK79CJd1TMR6OU1rnor+Qjq/XABT4WyE/1qRq6Svnoriw==
X-Received: by 2002:a05:600c:1992:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-43f1ed4b5e0mr16806455e9.25.1744190695676;
        Wed, 09 Apr 2025 02:24:55 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5b08sm10036735e9.33.2025.04.09.02.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 02:24:55 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH v1] ptp: ocp: add irig and dcf NULL-check in __handle_signal functions
Date: Wed,  9 Apr 2025 12:24:46 +0300
Message-ID: <20250409092446.64202-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __handle_signal_outputs and __handle_signal_inputs add
irig and dcf NULL-check

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 7945c6be1f7c..4e4a6f465b01 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2434,15 +2434,19 @@ ptp_ocp_dcf_in(struct ptp_ocp *bp, bool enable)
 static void
 __handle_signal_outputs(struct ptp_ocp *bp, u32 val)
 {
-	ptp_ocp_irig_out(bp, val & 0x00100010);
-	ptp_ocp_dcf_out(bp, val & 0x00200020);
+	if (bp->irig_out)
+		ptp_ocp_irig_out(bp, val & 0x00100010);
+	if (bp->dcf_out)
+		ptp_ocp_dcf_out(bp, val & 0x00200020);
 }
 
 static void
 __handle_signal_inputs(struct ptp_ocp *bp, u32 val)
 {
-	ptp_ocp_irig_in(bp, val & 0x00100010);
-	ptp_ocp_dcf_in(bp, val & 0x00200020);
+	if (bp->irig_out)
+		ptp_ocp_irig_in(bp, val & 0x00100010);
+	if (bp->dcf_out)
+		ptp_ocp_dcf_in(bp, val & 0x00200020);
 }
 
 static u32
-- 
2.45.2


