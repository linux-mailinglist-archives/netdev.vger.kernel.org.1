Return-Path: <netdev+bounces-299290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ib4PNDRgL2pa/QQAu9opvQ
	(envelope-from <netdev+bounces-299290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 04:15:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A2F682D35
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 04:15:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oKH6HG9J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299290-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299290-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0883E3005EBC
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 02:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183801A683A;
	Mon, 15 Jun 2026 02:15:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460D1E376C
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 02:15:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781489713; cv=none; b=PNOrfQDwPmYLe8pll5UJqvygq/RhRGVMFE2oIua7dbm3uRrr2nT/1Qx3zuaif8urAXVbsYLdPXJRgH4LMA6QcKUZS+41sbsXkVixFRV4NaQ1fRxvD67TFzEMaTQhdZZjrbUn/+i+szRPYZYpwPOt708IC5F+74yeXejWvZDLl8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781489713; c=relaxed/simple;
	bh=gyjz/USqjUUtM62ty/LRr7o6O6v2mzhDa0axURjvys0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H7INsAjkUUduFoss/XX79c50XEapINf1baov6VEFgEYkdBLRsujVYXgLHVAMpro4MMHEgaUqNF4vYmbaCKfeIXgar1JklrYu1VYwwhxxY/3QYruuD5DNDUc1PwkBt0tTTd0SAqrltEGGLsWCt7yQbGZdmutt+Nqgg2V6FfvzGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oKH6HG9J; arc=none smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51780bbc560so33169771cf.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 19:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781489711; x=1782094511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dgs8zi4UB7t/plEWUkJHCQvofyIKmiToTSGYIIN2vkI=;
        b=oKH6HG9J7mdqg1cvcFmByA+uLIzS8ZX6O2HF2P84ewmRZF/aO8R+Qg/dlFSSN/09XV
         aOURHT6qcKBOUuIw4jj78edELRrFNyuIw4kerq7etpHRpwYg0+gJrTN4loVU6FeGGT+W
         0Ixzyz430IXXFg8hIFsVUn+EY6b5nSFELU9heDKR9RVGhEmewJHVVGHMKoyMf+4HiMD/
         2hOaXI0AGY+czjXkwbR+a7rVBvMOlmrfibf4QoICUmgx3/DNgV01VzIhcEhNB8n9Q9xi
         xIA8R+5D/pULPHZCUywYC4Z9LBnbc6xm97xB64573ezt+Ba7yK5gLykSHAtZvCG9+y/0
         vvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781489711; x=1782094511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dgs8zi4UB7t/plEWUkJHCQvofyIKmiToTSGYIIN2vkI=;
        b=Zbc0+hzRvHSYpA7uDh/yXxiqubR+/VWoNogsUPbXLsHFyExQ6DEGLTCTrgjwej86bV
         4x1bX2YppBjuV8Tv0kmvffLwYwl9Vh5of5rZ/CFCfFXed5tdipMl0Gs+hMsSASLRESqa
         cCM1sRp96QkKgyJuPM1ZfhiDCSPynjcyP5cgUmkTr6oRyrSZ8LZkHjZEE7UidV1+SWrz
         AiYFAzdhzVrc/H6u0jeu2e1IkQMgZNuutTQIUgS1qGZ8/qL1rVF0frHEjoTqSlYXq6i7
         3GP3w0tKDhkbQ9GdzzSSHwpHfBpW79z/GiZdgo5pY2xQ1JAcB4+5YtV3UgG++jXxv+ue
         iNJg==
X-Forwarded-Encrypted: i=1; AFNElJ9avT+WU51XBZgFGxWwrrqVk8GDlil8UVjd24oENL12iyR3k81EEDjDGJl7Ay5mEuu1tCYPvNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr3KSOenBGK/5163nHeePaWimKm1EqA5r3hlvvQhmNdysp+WRo
	Iql17Pba+Dkk69OiOSVdLscZxZ7ROE31MQ4mOG71droNqzAOD3MegISPeu88ggL8ElGMfw==
X-Gm-Gg: Acq92OHoVYL9fBNu/z/mjgEtgYGBSib/rvXokwuxvbiW2VALesjOVAWhnriMrgIZY1L
	aXdELsgRr3xtCGgj6GG13Go8dBVwXbdcGRcAtZBKA1SMuD8JwS+Q0FyY3pGWWT5qKaJ3Vb4TyK7
	IEuAkaJXVdSQQVIPJv+okcxCDVE48igYXc9nptzHzIgNdPQqLHnIYxbDl2WwReQDQRiNQCC3z/r
	xfZhZGFLcnyNFl/edybHQ1NlGpYeZF5sPGA2roYYH3NXxyOwZY5T/3Hzo0pI4zkQDTD8xTXYYPE
	BqwzAifKnwxlMpi17YKYT1RmZV+AF87vfSO1s/Fu7zTNfxANUFtS7ikluJPslVzjG34wuf7Buhg
	mwZg9RFnSnmtvpb7byuZmHXnGFt/NvkzzdBHWT7Fd9rfINzsHs4pmIMKTQ31nZwbT8DGzUXq2hO
	hUeasTFgI/2hZ13Pd9BOaKrvStYRfv5SZOwHtyHUQU/zPEqxfR68Dl0vDjzE5FwqtBksCDJg==
X-Received: by 2002:a05:622a:1819:b0:517:5bc6:b575 with SMTP id d75a77b69052e-517fbc898cfmr172653761cf.4.1781489710652;
        Sun, 14 Jun 2026 19:15:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:985:4601:5df0:2106:6ce9:6b1:8f70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d305134b20sm96793466d6.43.2026.06.14.19.15.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 19:15:10 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: dwmw2@infradead.org,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] ptp: vmclock: KASAN slab-use-after-free in vmclock_miscdev_read
Date: Sun, 14 Jun 2026 22:15:08 -0400
Message-ID: <178144969601.60470.14493569608271069160@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299290-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dwmw2@infradead.org,m:richardcochran@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[infradead.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31A2F682D35

Hi,

I hit the following KASAN report while testing current upstream kernel.

The issue was reproduced by opening /dev/vmclock0, unbinding the vmclock
platform device, and then reading from the old fd.

KASAN: slab-use-after-free in vmclock_miscdev_read

I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/7c2d117852611448a80026f8aa4d4bc4

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  148.011605][ T8390] BUG: KASAN: slab-use-after-free in vmclock_miscdev_read (drivers/ptp/ptp_vmclock.c:409)
[  148.015241][ T8390] Read of size 8 at addr ffff88811fdc7478 by task repro_vmclock_o/8390
[  148.018209][ T8390] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  148.018216][ T8390] Call Trace:
[  148.018226][ T8390]  <TASK>
[  148.018232][ T8390]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  148.018248][ T8390]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[  148.018314][ T8390]  kasan_report (mm/kasan/report.c:595)
[  148.018335][ T8390]  vmclock_miscdev_read (drivers/ptp/ptp_vmclock.c:409)
[  148.018384][ T8390]  vfs_read (fs/read_write.c:572)
[  148.018453][ T8390]  __x64_sys_pread64 (fs/read_write.c:765 fs/read_write.c:773 fs/read_write.c:770 fs/read_write.c:770)
[  148.018483][ T8390]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  148.018498][ T8390]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  148.018604][ T8390]  </TASK>
[  148.042173][ T8390] Freed by task 8390 on cpu 1 at 147.908511s:
[  148.042791][ T8390]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[  148.043265][ T8390]  kasan_save_free_info (mm/kasan/generic.c:584)
[  148.043775][ T8390]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[  148.044256][ T8390]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[  148.044668][ T8390]  devres_release_all (drivers/base/devres.c:50 drivers/base/devres.c:547 drivers/base/devres.c:576)
[  148.045171][ T8390]  device_release_driver_internal (drivers/base/dd.c:598 drivers/base/dd.c:1357 drivers/base/dd.c:1375)
[  148.045791][ T8390]  unbind_store (drivers/base/bus.c:244)
[  148.046252][ T8390]  kernfs_fop_write_iter (fs/kernfs/file.c:352)
[  148.046798][ T8390]  vfs_write (fs/read_write.c:595 fs/read_write.c:688)
[  148.047229][ T8390]  ksys_write (fs/read_write.c:740)
[  148.047678][ T8390]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  148.048144][ T8390]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  148.048996][ T8390] The buggy address belongs to the object at ffff88811fdc7400
[  148.048996][ T8390]  which belongs to the cache kmalloc-512 of size 512
[  148.050394][ T8390] The buggy address is located 120 bytes inside of
[  148.050394][ T8390]  freed 512-byte region [ffff88811fdc7400, ffff88811fdc7600)


Best,
Shuangpeng

