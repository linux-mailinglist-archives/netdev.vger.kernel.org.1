Return-Path: <netdev+bounces-213815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D18B26DC0
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 19:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049365E6641
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A9928642D;
	Thu, 14 Aug 2025 17:33:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447A9307AEC;
	Thu, 14 Aug 2025 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192780; cv=none; b=JwfouSIJROnPU4dwSRelnI7OA+oI1Z3mLqKae9E6W3gPBVVZl1Ry4OrScao0MdimLKEZXdzlgNVeDwjHrbWKPs/oalBqEkCQKtEM50L6He45IHrE1sdlkxNI9ffCpqu5GTbtJBkdROU3xF/RcXbVSMuX3RD8DIryF/oMgSUy3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192780; c=relaxed/simple;
	bh=kkfVGzm5xmcTEpogiJpAh2am7fD/kzJmY//e5rig2mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hnrNm3zlAao9nq/O0kuPnMeSG+phs8qY5vGfhmz2R7yGCfcS5UkmA7mznYAtyDbUEuIDFa4lUpz2e5ksjvjg6WGf/PkTy2w8dvqyb2aNigHhX7wpteqEmKby6+I7S0eWl6lvq2mbzwUyla2BsQAsSueKcTMDKj0e3WGsqtqFLvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e39ec6fd1so39423b3a.1;
        Thu, 14 Aug 2025 10:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755192778; x=1755797578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dasZqLBqwx+H11h3+pcxGW3OtNoFUdtbGyZtK+yv22E=;
        b=gqkRYmmRvNKYyhQazZR+Bueio5K5VBMvpZle56/y3Jr018ybJfoIoNXnn0YKsz4hXf
         pZq7LvCv0f+62K2CjJ5an2LyDK340BHDnZta5TrPFDPYiZ10q8PFQQX1UDLLVRrh7CUV
         4hizcVw6pbgsQNwICpQKK+VW113izQGAiVHOQtsVXrXvX+hWzl/gJFu19G6SD1n+tyPE
         DKOUS+4tlYBlq9xpnfQWl51k6/OlxSrx4nHDTLfsL9N6jT6LfKT6yZcuNTL6q4mNDOCg
         HEbH5yskGvZ4LMKT3G3nv48Jg5CrW/uysqs4Cqacr9hGI7EnyQ5RPWFwoQVm/iz88+7S
         yuZA==
X-Forwarded-Encrypted: i=1; AJvYcCX2K7t/UZuvCAnuPh2mQxr1xhvAm/MDlYl5I1GIchoc7p1K80J9kqRFPKCUHgQ0uTVHIYuGpSm1ErYYo1E=@vger.kernel.org, AJvYcCXCocU6MINEKN49elLo/vzCwr2SpNJ3yLOArvRwIdSQVe/pKhel0Kz99QXtGMwgZtATyFbo+2Jc@vger.kernel.org
X-Gm-Message-State: AOJu0YxcRVbJobypNVEI7ybovhy4G0lMW0t1yioN0EwlxxTF/eUOVCAL
	MKZNFgzvVHcQ7OLMbbHhPwlCZOzfIF0gPaj2I0xXJNWqURS0kTiqHWlD
X-Gm-Gg: ASbGncuy4gLaPufieGYz353XQt9Ef1Rx0qwZShkXStyxgt8Y2FF9LWrAjkl3ohxUvrF
	V54jkQylr2MG7fqD2oAJi8rg7SuWWbY+hzRatQsX9N71tkpThhK5n570mHcWbPtZEycnDhGan0T
	jglL4hWDQX4R0IcubJC+JmhN9OxNGIKod4wIazjg2WNCw2OdkrQyMrqTa58Q18QAAqAHD6CPBA7
	Fhl0YDgETvkXHYuOSjcjTrsva2rr87t1rnUywxXjIeL2ZoImL7pbzLCZ0kspx7aXI3HG4EPYwrV
	V0plrWPhNQSWWXXA8nlBYuRXIJqPRGTqH2u+HBg0Rmk5uqxR2VCkFodUmdenXwuWCTyPmPNYt3z
	0AlRShM1VHUVb
X-Google-Smtp-Source: AGHT+IHltg6a+HaOlxcazGeUX2V9JUVGbnikZvvlVSr+EnMxBo4ySKHtSPMZQyzthHc+6UEKVzvJGA==
X-Received: by 2002:a05:6a00:4fc4:b0:75f:acdc:70d0 with SMTP id d2e1a72fcca58-76e2fbd5c3bmr2744284b3a.7.1755192778530;
        Thu, 14 Aug 2025 10:32:58 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcfe18sm35148517b3a.93.2025.08.14.10.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 10:32:58 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	max.byungchul.park@gmail.com,
	yeoreum.yun@arm.com,
	ppbuk5246@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH] net/nfc: Fix A-B/B-A deadlock between nfc_unregister_device and rfkill_fop_write
Date: Thu, 14 Aug 2025 17:31:43 +0000
Message-ID: <20250814173142.632749-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A potential deadlock due to A-B/B-A deadlock exists between the NFC core
and the RFKill subsystem, involving the NFC device lock and the
rfkill_global_mutex.

This issue is particularly visible on PREEMPT_RT kernels, which can
report the following warning:

| rtmutex deadlock detected
| WARNING: CPU: 0 PID: 22729 at kernel/locking/rtmutex.c:1674 rt_mutex_handle_deadlock+0x68/0xec kernel/locking/rtmutex.c:-1
| Modules linked in:
| CPU: 0 UID: 0 PID: 22729 Comm: syz.7.2187 Kdump: loaded Not tainted 6.17.0-rc1-00001-g1149a5db27c8-dirty #55 PREEMPT_RT
| Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu1 06/11/2025
| pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
| pc : rt_mutex_handle_deadlock+0x68/0xec kernel/locking/rtmutex.c:-1
| lr : rt_mutex_handle_deadlock+0x40/0xec kernel/locking/rtmutex.c:1674
| sp : ffff8000967c7720
| x29: ffff8000967c7720 x28: 1fffe0001946d182 x27: dfff800000000000
| x26: 0000000000000001 x25: 0000000000000003 x24: 1fffe0001946d00b
| x23: 1fffe0001946d182 x22: ffff80008aec8940 x21: dfff800000000000
| x20: ffff0000ca368058 x19: ffff0000ca368c10 x18: ffff80008af6b6e0
| x17: 1fffe000590b8088 x16: ffff80008046cc08 x15: 0000000000000001
| x14: 1fffe000590ba990 x13: 0000000000000000 x12: 0000000000000000
| x11: ffff6000590ba991 x10: 0000000000000002 x9 : 0fe446e029bcfe00
| x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
| x5 : 0000000000000001 x4 : 0000000000001000 x3 : ffff800080503efc
| x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000001
| Call trace:
|  rt_mutex_handle_deadlock+0x68/0xec kernel/locking/rtmutex.c:-1 (P)
|  __rt_mutex_slowlock+0x1cc/0x480 kernel/locking/rtmutex.c:1734
|  __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
|  rt_mutex_slowlock+0x140/0x21c kernel/locking/rtmutex.c:1800
|  __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
|  __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
|  mutex_lock+0xf0/0x10c kernel/locking/rtmutex_api.c:603
|  device_lock include/linux/device.h:911 [inline]
|  nfc_dev_down net/nfc/core.c:143 [inline]
|  nfc_rfkill_set_block+0x48/0x2a4 net/nfc/core.c:179
|  rfkill_set_block+0x184/0x364 net/rfkill/core.c:346
|  rfkill_fop_write+0x4dc/0x624 net/rfkill/core.c:1301
|  vfs_write+0x2b8/0xa30 fs/read_write.c:684
|  ksys_write+0x120/0x210 fs/read_write.c:738
|  __do_sys_write fs/read_write.c:749 [inline]
|  __se_sys_write fs/read_write.c:746 [inline]
|  __arm64_sys_write+0x7c/0x90 fs/read_write.c:746
|  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
|  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
|  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
|  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
|  el0_svc+0x40/0x140 arch/arm64/kernel/entry-common.c:879
|  el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
|  el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:596

The scenario is as follows:

Task A (rfkill_fop_write):
  1. Acquires rfkill_global_mutex.
  2. Iterates devices and calls rfkill_set_block()
     -> nfc_rfkill_set_block()
     -> nfc_dev_down().
  3. Tries to acquire NFC device_lock.

Task B (nfc_unregister_device):
  1. Acquires NFC device_lock.
  2. Calls rfkill_unregister().
  3. Tries to acquire rfkill_global_mutex.

Task A waits for the device_lock held by Task B, while Task B waits for
the rfkill_global_mutex held by Task A.

To fix this, move the calls to rfkill_unregister() and rfkill_destroy()
outside the device_lock critical section in nfc_unregister_device().

We ensure this is safe by first acquiring the device_lock, setting the
shutting_down flag (which prevents races with nfc_dev_down()),
stashing the rfkill pointer in a local variable, nullifying the pointer
in the nfc_dev structure, and then releasing the device_lock before
calling the rfkill unregister functions. This breaks the lock inversion.

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 net/nfc/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/nfc/core.c b/net/nfc/core.c
index ae1c842f9c64..c8dc6414514b 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -1154,6 +1154,7 @@ EXPORT_SYMBOL(nfc_register_device);
 void nfc_unregister_device(struct nfc_dev *dev)
 {
 	int rc;
+	struct rfkill *rfk = NULL;
 
 	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
 
@@ -1163,14 +1164,18 @@ void nfc_unregister_device(struct nfc_dev *dev)
 			 "was removed\n", dev_name(&dev->dev));
 
 	device_lock(&dev->dev);
+	dev->shutting_down = true;
 	if (dev->rfkill) {
-		rfkill_unregister(dev->rfkill);
-		rfkill_destroy(dev->rfkill);
+		rfk = dev->rfkill;
 		dev->rfkill = NULL;
 	}
-	dev->shutting_down = true;
 	device_unlock(&dev->dev);
 
+	if (rfk) {
+		rfkill_unregister(rfk);
+		rfkill_destroy(rfk);
+	}
+
 	if (dev->ops->check_presence) {
 		timer_delete_sync(&dev->check_pres_timer);
 		cancel_work_sync(&dev->check_pres_work);
-- 
2.50.0


