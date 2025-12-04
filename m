Return-Path: <netdev+bounces-243609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F1DCA485B
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 620C3315A1B0
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D91E314B70;
	Thu,  4 Dec 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5v2143l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496C313290
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865061; cv=none; b=bUEeSNr/rcdid7gH5XchsPgGWGDp9KaPgm/dObt6UfJaC/TDjDVe27Na3iSWcTxr6gDHU6KKd5ViKub6nrP/geU3Mjg+Cmk8tzeTN/97ALIAMXrO1ELWL0K8BcPv5vBZWv6TTFSv/jqKvlHa3PeDwsNtHcESWRsxwJYpN4FCtLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865061; c=relaxed/simple;
	bh=uojvQcHou5oXqNNEnLZdn5nZm+d1gWRdW3OC5Z/daso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4SrsDC3cP7evNc2awDUg/5c03ng+CKbiAKubN3U1yIxQmSN/C4ZqhchS8a8lgCeoynytZtgNME7OfMblEY+WxL640s1MBXKlbe6rdM8ECmwT2wjzVBQ1LNmaKZbMVj0w7+3YSCntD4tHLtx28hshu1xVVS3IoKH+hTxgg45uIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5v2143l; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29555415c5fso14917145ad.1
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 08:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865059; x=1765469859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOzZfIH9Lo6vEdAA49vWqjJXfX2W8pQl4mAmhvon218=;
        b=R5v2143lgd8e48JQqvoXR8DoQj9CWMt1B7SZVQ2YY4soQMeaNeafYH4NkvCtuZLVvI
         inn7nPPGC9nnu0dD0mg1b7pxXofWCMu4631B24LEAk/iHQQsfzOXtZRpsnHgOwregXSe
         haKnwQyPGz3RU/9Mi0+QY9oKM9P+pZu7Cq5ZAM9KoTyb05udMISW+cazO/G3n2Zx60Rd
         9A4rcYXaZLDjfxRUEpHhQz2cdXhFzf274gZ6fl5Mr+MD1FMFU6i2cZsgAOXFkGSNwiKo
         2n1QUt2eaxh9f3LDvsW1oizDoyx0Evv4+J7NUtFt21Ta7C1how4kOlY+WZDayVinOPrc
         5+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865059; x=1765469859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOzZfIH9Lo6vEdAA49vWqjJXfX2W8pQl4mAmhvon218=;
        b=QQqCPILG1QQL0BJNRiGO1ZlPrHa79xg24+oXOEqrX0Ip9IlDsY3YAfQduXymCjZktD
         YjxJFwwZa4MxDJsNHdaGkr+GpgMLjprfPKkt6MGRvKZkfdZITV9InhdqiHYMV4NTEGR3
         RQkmnm9VN61/IcOsHK9blZaSKz221w9eCzpxx8GTcxJpYDrCsd0phUIkOq3CT6dNhtDz
         x2BnvMy0l0QRJZRkeKdZ1h4Gltjkuw90uYB19fUZTS+cDeGG+KoumsRhEXXmvaXi7CXc
         de9HWQdOYBsftBSnjxpBsApDDgkSymwOZymxeoGSbfA/0mpWXdXcRyugOlnga9fWACW7
         EabQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCDd5OxI76iBYlii7en+/pYAbUf9NBKo8eErPuLH8uDaGKfQeLftFi7+EuQajNk7hO7kO/i74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZvYKaLu25X3vRklWEs7E8yxUdetM4rm1QDYmO+nrqU5dtLnh3
	PFi70c20W7hjwrXugoYJmsi3vRIuwxqqXz6is4024c2V79Dcgu5JE5U2dSfiIg==
X-Gm-Gg: ASbGnctyBgjnksSLtW17LbQyu/jrTLg+QfM9JLGz6hAFoB9eHbiZtnPX4ggqnl6Xse8
	fXWdJ5dK1oNnhb4E2MR4zqH+1IY5HGkUjwXhLT/HVMlMAjt+HY2doQ4NS/5jux0Y4rWDFSxo3mI
	siCooZONafplapotROEctWqqvQYvBsKfFM3K/DsBZH+3crAtWDUssDtaq9A0ZQQIZMP3woFRzeQ
	sTPwiby3gKaVBtdtS9mgRlugjtKIzUmWu5XXz8TM1i9LEY+6g4e1HwX7m6isCWmhZ4ploaTR4oK
	pG+h1SPlpnZ+fBe+7TnUm5yJrw7xMZ5PibSbxex6abJR4JJnzdft0uYROZpEWTys3VZ04ta0h9z
	WdKQEoEwRx8IllXKp+VDs5DCeJ8cqGMA096OLxcAIxr2EI9VC2hkZ5NyPKlQHChPCArVFz5Vyb+
	DEkQCSUdFnNdUN0YMTroflYdU=
X-Google-Smtp-Source: AGHT+IEhqjbEuXaysSF/wkAXhEmzAlPFdTVX3OMfc8S/rfmItTqonwqGE1/z5t8WZPXeAov5Rk8BdA==
X-Received: by 2002:a17:903:3504:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-29d683eb3a8mr83132745ad.61.1764865058842;
        Thu, 04 Dec 2025 08:17:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f1cfsm24139315ad.55.2025.12.04.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 04/13] selftests/filesystems: file_stressor: Fix build error seen with -Werror
Date: Thu,  4 Dec 2025 08:17:18 -0800
Message-ID: <20251204161729.2448052-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix

file_stressor.c:112:9: error: unused variable 'pid_self'

by dropping the unused variable.

Fixes: aab154a442f9b ("selftests: add file SLAB_TYPESAFE_BY_RCU recycling stressor")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/filesystems/file_stressor.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/file_stressor.c b/tools/testing/selftests/filesystems/file_stressor.c
index 01dd89f8e52f..4f314270298d 100644
--- a/tools/testing/selftests/filesystems/file_stressor.c
+++ b/tools/testing/selftests/filesystems/file_stressor.c
@@ -109,8 +109,6 @@ FIXTURE_TEARDOWN(file_stressor)
 TEST_F_TIMEOUT(file_stressor, slab_typesafe_by_rcu, 900 * 2)
 {
 	for (int i = 0; i < self->nr_procs; i++) {
-		pid_t pid_self;
-
 		self->pids_openers[i] = fork();
 		ASSERT_GE(self->pids_openers[i], 0);
 
-- 
2.43.0


