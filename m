Return-Path: <netdev+bounces-171398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A89DA4CCE5
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 21:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D053ABF8E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 20:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6487232386;
	Mon,  3 Mar 2025 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzWc6fQM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01B22E3F9;
	Mon,  3 Mar 2025 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034900; cv=none; b=rYt52MDYLLKKPsJuSgUErQ02bjSWIHA1oceuXvXMEfRde9bYLaZRKDaifKmLZd5KNI3kUMluhtDIhcemHNbtOzsMa0Sz8gGqeKehSoaGThyRouFjPXBw6i5ydaHYSXCYzIK5bAfzWeQO3V3HYra60V8sEdfkYAlCdiheZ7C9NJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034900; c=relaxed/simple;
	bh=pD7ejVBu9H7cz/T8DvqHF9UUYtpoXPW+31Sqoi8dUlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pL4vWsgwATCMmWu+OTnltM7iJukyMVlC+IML9PKuhIHqBQ+hS9sYZ5reDXymAEPG8RNtYX2twx0O0Hf9VwdHOGW3jTotCxkjG0o8xPurhA+Qj519CsrZwH8UjH2HdN8dXtbNCVzd5NwFCku8rSCl30/3L8MGSZ8ZFSX/3x93GV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzWc6fQM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so5412291a91.2;
        Mon, 03 Mar 2025 12:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741034898; x=1741639698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgSaLk7w7tBXl30fyHTRaDLylIq/PN9uL/1guvPWn+0=;
        b=QzWc6fQMQNrUFEFDWlpFRwk61BplAk9m9VEo2Oax08SsV/o4xXzt+X16vr1DfF6hIu
         f1pWNMbvTgWuUJZAdDS3UAa1fIpHVrhZzAxLB3YkTUEp/sv3CdwRE+qGEgw1beudFwLf
         9WAFQ5I/0LqWQmG5TOu+Xz6nKNZltkLnY6RW+S3o9XLvk/1HdYtLCqd6Q03JT3AFj8on
         +iexImh7Gu0y5Ep9zwjs/s//AJjdYK33OlTipn3ohnijGDN0XKqkZXrg++0LpLOtXSXc
         6mD6g9uTpfP2YoYTCdo7gJluSLqr9wH2v36vkL3D+Rw3O4wSpzbaDBUzZLeCkfm+JGtt
         JlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741034898; x=1741639698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgSaLk7w7tBXl30fyHTRaDLylIq/PN9uL/1guvPWn+0=;
        b=MIcnVZlzlLcx+rnre8fUsHtjVN02kGxosJhtyG117FPy71tWzX062GIRNHOM7+ZX5F
         Ftl6s45T2pNGaI+1NoNI/tFeVXaX67MgDMUBoVxGKfqw/SMa7ZZmZag5/yq/SafJ3wmO
         u2G/32x8NUdBuBkbon5tV2yQVqHKYXrGNzzDSsbzP5q7cY8fP8WNRKQivwwt6tKdtMXF
         E9/dRrFMU713a5Q12K5+E4uprvqTkbtkGHZhSvbCFs1WaSHVQ4d8l1iei3MCRGblySDh
         3aylfhFgPTWUP4FYqsIZY1llHwppLYG6EB+Whxg5YWiHdl55x6yA4ERC9e0TCFShS3hg
         TdDg==
X-Forwarded-Encrypted: i=1; AJvYcCUvOk5/CIv/c3d/w0pH6QORoVVDKUjISLntvhGVzY+6i6YqbjoB+2btmghhGdVZ+FUAybLy5Ou7@vger.kernel.org, AJvYcCXqu4tWIvdLcINwcH25I91wkDnsjvRa2Hh39EC5tw+jcYJwE/jbMWvAMfZOP1CCngKM99ZYuaXrMTmfgs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvRb0LihgsjqSDnEl5QUhmWF67qHzBB4KsZhKH4eO/I2jLZK3
	MJtA5hvJhb3uxMCFk5qBPexYBEEQ9B5D1bTtZmu3oLRI/9TjjgSq
X-Gm-Gg: ASbGnctuIhtJo5hC8plVfeixx8TDm7S7aIK37p9YWkK4RM3544W5ABdo+4iw4Ji7BOO
	EButHcVNa4LlvjCywz8hkesgBDTw5nAkeElB1ZUGgxHNuJ2tj7AuS+bFueR4UCJMpDJVeqoq4al
	VSVust9YjCjU0gcD6MPKrkkaFp7rCexmEQxuTXENaWiyFw+6afZ7xYoMiicXewlj1jw+XnQiPtP
	d9yd2NOiXqp+i5/+FTz/xKt6l3zSdBZ15CbFMO1EyU1eX/QNv5NlYy3KLAN64IuhatWUnFQEgJf
	nzg9lHY1tOqvImnMsN/pkJCCz+xa0kXXUupIR4OLkQ==
X-Google-Smtp-Source: AGHT+IFFbWklKfcQH/W60SbIzSpV4g5GMRMFfXwE9Du0RkkNIXoYmwwSm6kOFMotBdBvzzH/0uHXGA==
X-Received: by 2002:a17:90b:48c2:b0:2f9:c139:b61f with SMTP id 98e67ed59e1d1-2febab3c710mr24244355a91.14.1741034898455;
        Mon, 03 Mar 2025 12:48:18 -0800 (PST)
Received: from fedora.. ([186.220.38.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea676c4dcsm10501722a91.17.2025.03.03.12.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:48:18 -0800 (PST)
From: joaomboni <joaoboni017@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joaomboni <joaoboni017@gmail.com>
Subject: [PATCH v2] e1000: The 'const' qualifier has been added where applicable to enhance code safety and prevent unintended modifications.
Date: Mon,  3 Mar 2025 17:47:50 -0300
Message-ID: <20250303204751.145171-1-joaoboni017@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Joao Bonifacio <joaoboni017@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3f089c3d47b2..96bc85f09aaf 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -9,7 +9,7 @@
 #include <linux/if_vlan.h>
 
 char e1000_driver_name[] = "e1000";
-static char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
+static const char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
 static const char e1000_copyright[] = "Copyright (c) 1999-2006 Intel Corporation.";
 
 /* e1000_pci_tbl - PCI Device ID Table
-- 
2.48.1


