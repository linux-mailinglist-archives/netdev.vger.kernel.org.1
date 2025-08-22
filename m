Return-Path: <netdev+bounces-216124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB04B32220
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 20:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC92C1D284D4
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2832BE033;
	Fri, 22 Aug 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD0GlZI/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986FD2BD5B3;
	Fri, 22 Aug 2025 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886302; cv=none; b=uXjBMkjdZMw2PjJBDLEBOq+P4UY6UEddmij4WJy/ziEyHmtDA+2bAJ6EBrYBaD8Mas9b0T+J+v2MgvhhwkgntjV20+vDOaLxoVUj1knALc6DxEhgDybPvLclurBhWhcnwWEEY3s14ICD6Venfbdgvxma/yN2WMsJvpeDgE9AmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886302; c=relaxed/simple;
	bh=IJtLE1Q4rJCO8zJhc+hEtTZK1+HnLN8Rtssuw8qX5aw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ox44m+2+RcCiIE/jdNz5qwUOttnO1OMhk9Tp20nfdVkGd4rIvCa0M01G+6ArZjIyw2krA+ERu1EzqVUBAhUmVSt2jCXyG3NHPU3pa00K2JDWYhMed+OK+WNh9YUKsDpWMIN/pqm8v6w4E2nmXhBb/08GRw4dV4GZyr1RiKcTKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD0GlZI/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so15396645e9.1;
        Fri, 22 Aug 2025 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755886299; x=1756491099; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhlyI1Vji6S4iPUyGLb7GjEFW+HU1Z0XCJTAoKiKDwk=;
        b=VD0GlZI/Xje8VutMEnH4GJBeKebl2sEK8V8Ea8ttRDWHGibSKOoCLSTxA4YwVDFPxX
         wePRIkfxp1vBD9gEW/ZfoPNCorWeJM3ey3H0kgsRt/JsR9EphasbfAojVW0uP2iyuJCS
         1zeWprJnUu0Z5tb2Tq6fNSo/zraNPs875qZBx7ahOrB/NMNI5xU1ntckLSDv5JGlfXxu
         ODjYiZT2X2wTlpeBOnh37y4t2nplofRAJRa8ydkpISkwvNl3WS4YAGh2SjxejyvV9AMN
         iU2m8Ct2j7tJ42bWTRL/7p0IIuLrSAACkTSsOdUKNvy4rnEIhXDo1xGjX8aqYBZcwRkT
         wABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886299; x=1756491099;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhlyI1Vji6S4iPUyGLb7GjEFW+HU1Z0XCJTAoKiKDwk=;
        b=U7x5gZUwl12FfDmPaMG1cUo58nXJPYD/85dvl92fwAzT4Vo6B8+ugBhyM5lfrVHR9k
         2267XPt5iMjKoc5426GpYY7/5iIRXgzwn2jpVKU7MvJH9iYCS0bH0adQScy/nSf6RFbu
         EKqk7JBHQlsXol65wIKwQO2dTN1VH3wq2Yx8h0aWxZk3Qdy87w6hMn3aeCS/RNgvS8Jb
         y278eISsJbjMdXONhoKVrLprqNxIHPsrb3NqcVB9pibxSLd9dSGJuOV280thbfK6q0Oz
         r2W1QleBUJzHdCIbQ4ePmASJr4+5P51/g1k+dJOSUpV+5sODl79FHa8wuDkvhm6R36o3
         5yrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3AS1YfYlBT0WKjGeglVmVDf4lJdsPgeyAcTVlKZUCSgCUrX8P9cPWmBi2csV4DQl4WbGNKjuoG4IlHaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKPuRYj5Xp3tVaMEKTAudaon2t4nPS7zZ7EOfcpni6Evg/JKel
	KdCvfgQfCsWu3NefXtEyqOP7kaos4micc/bxvl65sVk1EVCDqyuObH5Ls+cmYv4=
X-Gm-Gg: ASbGncultxQD1AF9CP8CPs1YJc/HrXHrJt7W2w/YGTpkJU8c2E69W0uAlfctzjkgyth
	eQqj3DLOrzPxymu2VfPt3YqPqt+wVbdbbScStaGYL/5etR7W6P8HpGMKPtZkQj7JTzTXTx2syed
	sfv3AYtsNTf1byzhwNb46vSFgxZKjPdATrvC1d4jmRnLLu7QaMKx+X6EU1c6/vHXvWmMtpMNrNW
	35EelZFCm+XZ8CSZf3HafKvsaIT57ygt/XPxV62o/mU1VBmnqwuNo5YLL43yvpHPx6gnG3T3IhI
	nsxRXLcZakvILG5PK1/+I7ag6feFKDFss6900vKbo+9prS0UqB5qw7OJqbaapxGJfveXxixc63S
	ESf59J5MZu403gz7pLlaBa7a3
X-Google-Smtp-Source: AGHT+IEcEXXL9E75Q0oSfCH1XgdzQeq368tH6A0PH5dLP2MAUtRhM2w8SNkWmRhoGzgwKx1EHVEoVw==
X-Received: by 2002:a05:600c:4695:b0:456:26a1:a0c1 with SMTP id 5b1f17b1804b1-45b517cb8e5mr42484925e9.17.1755886298715;
        Fri, 22 Aug 2025 11:11:38 -0700 (PDT)
Received: from vova-pc ([37.122.165.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57535439sm8574595e9.4.2025.08.22.11.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:11:38 -0700 (PDT)
Date: Fri, 22 Aug 2025 20:11:36 +0200
From: Vladimir Riabchun <ferr.lambarginio@gmail.com>
To: isdn@linux-pingi.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ferr.lambarginio@gmail.com
Subject: [PATCH] mISDN: hfcpci: Fix warning when deleting uninitialized timer
Message-ID: <aKiy2D_LiWpQ5kXq@vova-pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With CONFIG_DEBUG_OBJECTS_TIMERS unloading hfcpci module leads
to the following splat:

[  250.215892] ODEBUG: assert_init not available (active state 0) object: ffffffffc01a3dc0 object type: timer_list hint: 0x0
[  250.217520] WARNING: CPU: 0 PID: 233 at lib/debugobjects.c:612 debug_print_object+0x1b6/0x2c0
[  250.218775] Modules linked in: hfcpci(-) mISDN_core
[  250.219537] CPU: 0 UID: 0 PID: 233 Comm: rmmod Not tainted 6.17.0-rc2-g6f713187ac98 #2 PREEMPT(voluntary)
[  250.220940] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  250.222377] RIP: 0010:debug_print_object+0x1b6/0x2c0
[  250.223131] Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 4f 41 56 48 8b 14 dd a0 4e 01 9f 48 89 ee 48 c7 c7 20 46 01 9f e8 cb 84d
[  250.225805] RSP: 0018:ffff888015ea7c08 EFLAGS: 00010286
[  250.226608] RAX: 0000000000000000 RBX: 0000000000000005 RCX: ffffffff9be93a95
[  250.227708] RDX: 1ffff1100d945138 RSI: 0000000000000008 RDI: ffff88806ca289c0
[  250.228993] RBP: ffffffff9f014a00 R08: 0000000000000001 R09: ffffed1002bd4f39
[  250.230043] R10: ffff888015ea79cf R11: 0000000000000001 R12: 0000000000000001
[  250.231185] R13: ffffffff9eea0520 R14: 0000000000000000 R15: ffff888015ea7cc8
[  250.232454] FS:  00007f3208f01540(0000) GS:ffff8880caf5a000(0000) knlGS:0000000000000000
[  250.233851] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  250.234856] CR2: 00007f32090a7421 CR3: 0000000004d63000 CR4: 00000000000006f0
[  250.236117] Call Trace:
[  250.236599]  <TASK>
[  250.236967]  ? trace_irq_enable.constprop.0+0xd4/0x130
[  250.237920]  debug_object_assert_init+0x1f6/0x310
[  250.238762]  ? __pfx_debug_object_assert_init+0x10/0x10
[  250.239658]  ? __lock_acquire+0xdea/0x1c70
[  250.240369]  __try_to_del_timer_sync+0x69/0x140
[  250.241172]  ? __pfx___try_to_del_timer_sync+0x10/0x10
[  250.242058]  ? __timer_delete_sync+0xc6/0x120
[  250.242842]  ? lock_acquire+0x30/0x80
[  250.243474]  ? __timer_delete_sync+0xc6/0x120
[  250.244262]  __timer_delete_sync+0x98/0x120
[  250.245015]  HFC_cleanup+0x10/0x20 [hfcpci]
[  250.245704]  __do_sys_delete_module+0x348/0x510
[  250.246461]  ? __pfx___do_sys_delete_module+0x10/0x10
[  250.247338]  do_syscall_64+0xc1/0x360
[  250.247924]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fix this by initializing hfc_tl timer with DEFINE_TIMER macro.
Also, use mod_timer instead of manual timeout update.

Fixes: 87c5fa1bb426 ("mISDN: Add different different timer settings for hfc-pci")
Fixes: 175302f6b79e ("mISDN: hfcpci: Fix use-after-free bug in hfcpci_softirq")
Signed-off-by: Vladimir Riabchun <ferr.lambarginio@gmail.com>
---
 drivers/isdn/hardware/mISDN/hfcpci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index 2b05722d4dbe..ea8a0ab47afd 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -39,12 +39,13 @@
 
 #include "hfc_pci.h"
 
+static void hfcpci_softirq(struct timer_list *unused);
 static const char *hfcpci_revision = "2.0";
 
 static int HFC_cnt;
 static uint debug;
 static uint poll, tics;
-static struct timer_list hfc_tl;
+static DEFINE_TIMER(hfc_tl, hfcpci_softirq);
 static unsigned long hfc_jiffies;
 
 MODULE_AUTHOR("Karsten Keil");
@@ -2305,8 +2306,7 @@ hfcpci_softirq(struct timer_list *unused)
 		hfc_jiffies = jiffies + 1;
 	else
 		hfc_jiffies += tics;
-	hfc_tl.expires = hfc_jiffies;
-	add_timer(&hfc_tl);
+	mod_timer(&hfc_tl, hfc_jiffies);
 }
 
 static int __init
@@ -2332,10 +2332,8 @@ HFC_init(void)
 	if (poll != HFCPCI_BTRANS_THRESHOLD) {
 		printk(KERN_INFO "%s: Using alternative poll value of %d\n",
 		       __func__, poll);
-		timer_setup(&hfc_tl, hfcpci_softirq, 0);
-		hfc_tl.expires = jiffies + tics;
-		hfc_jiffies = hfc_tl.expires;
-		add_timer(&hfc_tl);
+		hfc_jiffies = jiffies + tics;
+		mod_timer(&hfc_tl, hfc_jiffies);
 	} else
 		tics = 0; /* indicate the use of controller's timer */
 
-- 
2.43.0


