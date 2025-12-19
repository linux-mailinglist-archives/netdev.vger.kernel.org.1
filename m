Return-Path: <netdev+bounces-245551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C705CD1201
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B48A830194D4
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652AE31A575;
	Fri, 19 Dec 2025 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iy/mmZa5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CA3339B41
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164884; cv=none; b=QARkXbu7jdFR6KjaVQUFL2CdVgTBuTRLrIp+AYiBGPdjmRSQdGWwCJ/Oh1gCgZpExQh07N74Lhd4FRgkU0pZ0F86h8ozbX7u6jaVo63JMniWcpy7Xac/WOuyf//t82Y2fqIdV8QtDdr8CkdVV+//6wYikvKnhOx0al1DjHCvaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164884; c=relaxed/simple;
	bh=sPdvCaqzHL1BNrBCKwAotEVYl2eJOECD8r+TGqurXPc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UV+HqP6g2qwWTNvRdjMrGhYeh5uHagXzXBpkF95xpzOP0n45HMYY7f6mxE0Lm3Ek5MjxFQP38diqVjtTqHIjGUJixcF+jhbleFm2bDneoAjlTluiKHSFJEzbA0fHeErsUwQldInTwRQJXWHgO3GGJ0R8QxHOo9n3NX7R9iubhuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iy/mmZa5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766164880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pPnhyw/i/3SzlIuWdiWigNi8X6TDLr93j9cN8Sri8f4=;
	b=Iy/mmZa5kQBMFDKLMrTgcfbIomzmkyPJqdKxgeHwwgPdeLbrBtV2Uhjvq9Y3ZeLFbv/77H
	TEbFKyGTLqtMoqtMfgMAAQWMtDR7oo5TJU4LLWjFwHL4WSrVX/jUmJ43Hv2tasqTADCktE
	HW18jYNcXx6CdAzDaGci7pn0qTEaH1Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-8M2yYNr4P8C71VC9hEOD4A-1; Fri,
 19 Dec 2025 12:21:18 -0500
X-MC-Unique: 8M2yYNr4P8C71VC9hEOD4A-1
X-Mimecast-MFC-AGG-ID: 8M2yYNr4P8C71VC9hEOD4A_1766164878
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F073A18005AE
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 17:21:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.215])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3488F30001A2
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 17:21:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net] trace: fix UBSAN warning in __remove_instance
Date: Fri, 19 Dec 2025 18:21:03 +0100
Message-ID: <9c3f30d166d7d4e08afd81d462413dff1703776a.1766164851.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Darrick J. Wong <djwong@kernel.org>

xfs/558 triggers the following UBSAN warning:

 ------------[ cut here ]------------
 UBSAN: shift-out-of-bounds in /storage/home/djwong/cdev/work/linux-xfs/kernel/trace/trace.c:10510:10
 shift exponent 32 is too large for 32-bit type 'int'
 CPU: 1 UID: 0 PID: 888674 Comm: rmdir Not tainted 6.19.0-rc1-xfsx #rc1 PREEMPT(lazy)  dbf607ef4c142c563f76d706e71af9731d7b9c90
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-4.module+el8.8.0+21164+ed375313 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x4a/0x70
  ubsan_epilogue+0x5/0x2b
  __ubsan_handle_shift_out_of_bounds.cold+0x5e/0x113
  __remove_instance.part.0.constprop.0.cold+0x18/0x26f
  instance_rmdir+0xf3/0x110
  tracefs_syscall_rmdir+0x4d/0x90
  vfs_rmdir+0x139/0x230
  do_rmdir+0x143/0x230
  __x64_sys_rmdir+0x1d/0x20
  do_syscall_64+0x44/0x230
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7f7ae8e51f17
 Code: f0 ff ff 73 01 c3 48 8b 0d de 2e 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 54 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 b1 2e 0e 00 f7 d8 64 89 02 b8
 RSP: 002b:00007ffd90743f08 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
 RAX: ffffffffffffffda RBX: 00007ffd907440f8 RCX: 00007f7ae8e51f17
 RDX: 00007f7ae8f3c5c0 RSI: 00007ffd90744a21 RDI: 00007ffd90744a21
 RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007f7ae8f35ac0 R11: 0000000000000246 R12: 00007ffd90744a21
 R13: 0000000000000001 R14: 00007f7ae8f8b000 R15: 000055e5283e6a98
  </TASK>
 ---[ end trace ]---

whilst tearing down an ftrace instance.  TRACE_FLAGS_MAX_SIZE is now 64,
so the mask comparison expression must be typecast to a u64 value to
avoid an overflow.  AFAICT, ZEROED_TRACE_FLAGS is already cast to ULL
so this is ok.

Fixes: bbec8e28cac592 ("tracing: Allow tracer to add more than 32 options")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note: DO NOT MERGE on net nor net-next. Reshared on the netdev ML to fix
CI failures caused by the blamed commit above. Will rot on PW until the
net PR or someone can access the CI hosts, whatever come first.
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e575956ef9b5..6f2148df14d9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10507,7 +10507,7 @@ static int __remove_instance(struct trace_array *tr)
 
 	/* Disable all the flags that were enabled coming in */
 	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
-		if ((1 << i) & ZEROED_TRACE_FLAGS)
+		if ((1ULL << i) & ZEROED_TRACE_FLAGS)
 			set_tracer_flag(tr, 1ULL << i, 0);
 	}
 
-- 
2.52.0


