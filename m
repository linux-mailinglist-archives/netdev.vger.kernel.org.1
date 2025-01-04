Return-Path: <netdev+bounces-155114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAD1A01191
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 02:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6EB164BB9
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 01:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE4717993;
	Sat,  4 Jan 2025 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfKdwGMl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9861E507
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 01:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735955612; cv=none; b=Jb0eD73p6mOQ0kE0lth7YciC7t11DMvYTdIApsQCnT10ReSJIwO6DQXuWMespjWGrmrpWPp8ORtq3nYOdMsICccYhQPm9nZMBDw++4BncVDmP8DnWP8AnYa1IzNZGm9PYIhrPaNlKpZzu+I8ki7XJlmJ5CyXQ+bA9swFnX65RJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735955612; c=relaxed/simple;
	bh=A0xYbXIp57Vqj4RZnOTv8z/Q+Ixky1UuXUagkCPYhEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAnv1gfbh+mcE+4hCZ7ze8PwUWyf/4CIt0hywy0YJFt7TxNvbRrDdjxUbyf3KxrOgeKUFXIQ9HhZlemQOTP5MeQefu/x25Q/+H4qSpZHV0l2hz6wAZtCYsJdYU2DVYG7P+TJUVGAKQCh5GW0TSMp4h5U6Cj2jAwTAj/hw8GmaAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfKdwGMl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4363ae65100so132070145e9.0
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 17:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735955608; x=1736560408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYPlEjVhVtKCKAEtspRNA0nLS7O8UOQGLr/sTiznM8c=;
        b=WfKdwGMlSAW3/LxIgWtMT/OEPilmf1m4eh0eNDGribkM9KDKI0AumXQ9pjWVK8FvOb
         JCe9JJXZwkJuJqQENNCuKcwifmAVIR4OeuJKj/vgY9DCDNVXXvqziI+915jFI++aKXFB
         KO6n0HOOsYozOkO5e1NuJEQ/pCjk6pPWqc5iq7TK7iUdm3zymp8n3KmFnS2XDLCstb9s
         ZsYO0BKRjUP4y5JySBbAZHDJOh+Lr8HWrll79lMkY/w5NMzZolpJhNxUeL3LT6JHsLL6
         hAajhU4dxljJLVmnBZR9+bsJN+wBv2MXSS0VGl4AAty9LTUuVwNICrm0ICfq5zvAHnqC
         iwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735955608; x=1736560408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYPlEjVhVtKCKAEtspRNA0nLS7O8UOQGLr/sTiznM8c=;
        b=tlxx9Ugcj0gNqEKiRX2tXwE2ACDvyl6AjNdEewA1i/9imSncC09uTmR9Ygrgzg5FKh
         omsuun52dUTSO4SNfnbiHuzxAWmL30rN9xOwJksxk4evi4O76ZMXnLX4E7m8JY5cyXC7
         NG7Es9o3ZGRW8AjMFiAJuWaG0HF6w87osLJhIk8i4mcUW4eRyi36wna8wF+paQ8Z5Mik
         7lDfT5gCQytc32xxBshQRKowQtwoqU2UNwB4KrGGt/wdoJLotugeYk1YTHG5LqaRfdP+
         +NNVaZf0PtBPW0ZYNUuEztvs+RK5sUS9J1W7/C3NbUMTpqnBjND/U8MBF0HwMb2maXkP
         cwjQ==
X-Gm-Message-State: AOJu0Yy0InZBjsgf/EWVGbVErjBp6BxoH+F5FDp9TfcWBe8/QMR+e5eM
	UdAseWR6LOy5e26MBogLwdPFEDXmVLX7g6ZPO1/D5e1hkxOBIc8qW5MHSQ==
X-Gm-Gg: ASbGncuvSecGlqFkGJRrhrL+5n85SBLShEb//LBve0H80EPpl/Mbvg1hX2nPeoG6i9h
	Ze6xkmn7j6PwjGMkHgO7aqL1dUZo9loCJ2NwD/0C6A+kmvbCddAL+3QYS7BWAz8teUqG3QFF/nD
	AHKhYY06iMq2Yi0zWqd80pMiqvre65X/qH26G1zVQFvDm16XbSW2f6vlw6GmFvj0WvxAjFe0v4Q
	WAA2woYeLn38ZhAUzXZICe24bSp4WBmES6Ygoj5wrYjuDlWltP5YBc=
X-Google-Smtp-Source: AGHT+IEqU+KTfz7A7mLRo/z8cqEDZtW5pwdJ7JrBTsOXO7jIWe/CnrahUxgFYbjLyYD9Y/5MajB8xw==
X-Received: by 2002:a05:600c:1c9d:b0:434:f5c0:329f with SMTP id 5b1f17b1804b1-4366854c17bmr439765675e9.14.1735955608084;
        Fri, 03 Jan 2025 17:53:28 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:20::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4365c08afcbsm508445905e9.21.2025.01.03.17.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 17:53:27 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	damato@fastly.com,
	brett.creeley@amd.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next] eth: fbnic: update fbnic_poll return value
Date: Fri,  3 Jan 2025 17:53:16 -0800
Message-ID: <20250104015316.3192946-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cases where the work done is less than the budget, `fbnic_poll` is
returning 0. This affects the tracing of `napi_poll`. Following is a
snippet of before and after result from `napi_poll` tracepoint. Instead,
returning the work done improves the manual tracing.

Before:
@[10]: 1
...
@[64]: 208175
@[0]: 2128008

After:
@[56]: 86
@[48]: 222
...
@[5]: 1885756
@[6]: 1933841

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index bb54ce5f5787..d4d7027df9a0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1033,7 +1033,7 @@ static int fbnic_poll(struct napi_struct *napi, int budget)
 	if (likely(napi_complete_done(napi, work_done)))
 		fbnic_nv_irq_rearm(nv);
 
-	return 0;
+	return work_done;
 }
 
 irqreturn_t fbnic_msix_clean_rings(int __always_unused irq, void *data)
-- 
2.43.5


