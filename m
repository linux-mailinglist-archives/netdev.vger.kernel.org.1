Return-Path: <netdev+bounces-240877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CEEC7BB1A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FB794E3653
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85DA2F2603;
	Fri, 21 Nov 2025 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iilT4xm/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336052FFDC4
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763758650; cv=none; b=Fx14tyqttvJsg1nlHrYz3S5ZOKUfE7Si0WzrwSwaprA+GjgnW5nfiQxeeTW/cLo74l4haJvnuHCe40VnwXafZhOZHE3+OaU3QbAwi+bRxk0kkpJQJKKW6Yg7nskebXyKlcDjDi9ZaCpRuVDW9KrDd7n7kZaDxMxI+R4Hdi9TMds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763758650; c=relaxed/simple;
	bh=UPlzbUhG0sUdnlQKJ3marB1iLd6icHWptIoTFxih6EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWyaqopv6uZHdiqItw17+nfhHaJg5d6p3tTFQWfwrDxsG0J/WcQqSAuYc0TqC16j0vPlSkUiuRDGSPZo9GpDL/k3oU1ELqHlJb6+CUq07f1zxTU448fh5VgTy29D0nCeVai1yhZEdZz3HQ6GT15rVz5wnzp4c0fPad0sBXFG1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iilT4xm/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso3654058b3a.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763758646; x=1764363446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Poo6Sa9lcHdpaFK5k4oi0jUxnFCHoqA8HD7iXMrSA+c=;
        b=iilT4xm/dFSHkuU070N5Hiuo1qJEmhP88GUDeqxsYfL14RiPtOeZy+npqERG3ZiFAb
         shb0r63YXY4JhdYA7DaLr/8MovdVEGl0rP/ZsRJAet2xhBJNcrQ3vKSjzPjrbyzzYplN
         xR5n3inkeMOyfSVzJ48dpM+H740T/Xm8ERlNvWgDpSqlrHxjkWFkG6XaPS+skolDvNO6
         tQ62RRIS2VXovon2ABSzVcXmRtRLppMq/8BAgwTPyXSTjvveE4bjqxX6bg9+O/OE27xY
         /42VTubNt95MQtEBykDcPYucmORzKvt+Jm7DOmcU3b1AcY/9pK3ecjS+6+GkyvpodE5E
         CqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763758646; x=1764363446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Poo6Sa9lcHdpaFK5k4oi0jUxnFCHoqA8HD7iXMrSA+c=;
        b=HXk7tC2rGK9k5c2a9WDZ1XK1zzBXdeixih9ooy6/1Y37v3l26k3lb2jaESMIkQvckm
         IMHlcCE4sHsHjNTdF0pdMkpPavfebwyQtd3ouoNusv5QWNxGVOs9X2AuaGRphbaRPsZb
         7OXw4hV9ji1Z7wk/eDS0OiC3Tt137NV/1yOz5MBqRDi3PDP/60HBBhFX0+RJmFaWMA/2
         0uGqdtdIUUaJqG3/V+Jpi8D+bE9QYrBDmNuQxXxRVMkzElVIrEBLmiPoHXU1kNbu5qnk
         p/IGsF3wmUBKZAMWJkFEDLHZJqEXfxleVndclicZ5l0NMT69G/aB5hSlQesN0ChOt2r3
         fMHA==
X-Gm-Message-State: AOJu0Yxqf97eAOhm4yXD2+RkNF2ui3mS5pHCgVgS54x0a5gb1SBg7OWh
	Z57vM9mxlpGg8Ant0FSoQTK2dVmHZCqkVGMbURBIVsTmGoc/YfVQi1uJ
X-Gm-Gg: ASbGncu2QQGwzgcTuRkriz4dxyQsK7QGGWdHlWtgeJDrkHTw7hyPHIpbRSf6sTcDY0c
	cvh1+bL93AG06OKulTsu0We7eZ+GsSBPWxF85UOaDPYCOBz2mbLwIzbwyy3sJgxRkO/pe3Wcezd
	U14BwDCLl76ark1LjuMQPfIFnjXOz5uDTn8eGO2SakCEYavv+Z0UIbC2nz05HrFuw+lHMVpxbzW
	KBvSUukobuf0k6DsyymOOYkAEchXmUa+XDF1XlfinE8Mkyj67rQlBLQybGjDIQeAHsgdSnzO1TN
	rEukBIbH13HHfHOlbJYRDGJKSpYo1CkcdFKq0bxY1o9rZKVt4tBqg6FEpM/9NV9GT2/CHMnVZtS
	q1L/64twFWQ8kQrN2bgS85dY3lIKS7lO5NVnbL3NGgGZnvlNaSOfS+qSzLxRS7l7OK8AXCp6rUV
	zyRXNkFNSaZpwpRw==
X-Google-Smtp-Source: AGHT+IH//nlQhpFNWJFSpf0HqRxnQnhkjJv8FVJoHkSE0cLFRtULz+JaCnsHASmQaZHVZX45TQt2fQ==
X-Received: by 2002:a05:6a00:4b12:b0:7b9:420:cc0f with SMTP id d2e1a72fcca58-7c58cb8e698mr4659490b3a.14.1763758646352;
        Fri, 21 Nov 2025 12:57:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f145845csm6956086b3a.61.2025.11.21.12.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 12:57:26 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	david.laight.linux@gmail.com,
	dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] rqspinlock: Handle return of raw_res_spin_lock{_irqsave} in locktorture
Date: Fri, 21 Nov 2025 12:57:24 -0800
Message-ID: <20251121205724.2934650-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121205724.2934650-1-ameryhung@gmail.com>
References: <20251121205724.2934650-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return errors from raw_res_spin_lock{_irqsave}() to writelock(). This is
simply to silence the unused result warning. lock_torture_writer()
currently does not handle errors returned from writelock(). This aligns
with the existing torture test for ww_mutex.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/locking/locktorture.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index ce0362f0a871..2b3686b96907 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -369,8 +369,7 @@ static rqspinlock_t rqspinlock;
 
 static int torture_raw_res_spin_write_lock(int tid __maybe_unused)
 {
-	raw_res_spin_lock(&rqspinlock);
-	return 0;
+	return raw_res_spin_lock(&rqspinlock);
 }
 
 static void torture_raw_res_spin_write_unlock(int tid __maybe_unused)
@@ -392,8 +391,12 @@ static struct lock_torture_ops raw_res_spin_lock_ops = {
 static int torture_raw_res_spin_write_lock_irq(int tid __maybe_unused)
 {
 	unsigned long flags;
+	int err;
+
+	err = raw_res_spin_lock_irqsave(&rqspinlock, flags);
+	if (err)
+		return err;
 
-	raw_res_spin_lock_irqsave(&rqspinlock, flags);
 	cxt.cur_ops->flags = flags;
 	return 0;
 }
-- 
2.47.3


