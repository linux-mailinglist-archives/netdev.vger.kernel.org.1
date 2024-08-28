Return-Path: <netdev+bounces-122985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698EA96363C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205BC285C73
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05AE1AD9FB;
	Wed, 28 Aug 2024 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="B00K9GB2";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="I10jGHXN"
X-Original-To: netdev@vger.kernel.org
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620A16CD32
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888093; cv=none; b=VyiWQFaURgRq2NO+n7H5/saHwT4W2eNp+Wo3yQ911Wjvd3W7VZO6nsSka7yfc8+5oLz6TiQKiJypnxMZXPDRLcJXA9IgHhFILLTxSIxWJzthnbBptw3m9/443hiqyPU6J/QLRHJIsD7GaM4vP7XwACxnT+sDYUfPsoqjyCbS+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888093; c=relaxed/simple;
	bh=xU+md2SetDkcYnHecB52y7DFrXKFh7mateJ7n0bOZaY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P28VGi58KcdvwopWSSwdhSJPbjUNLC3BjAol9b7YDdqvOYVyNXuHtEdI0s0LCp5rt0QTDPc4Hy0HW1Ns0HnagESmJ5ir16ZF5lTlqEif70KdoNpqlUmI2jYgieybY9kNPQYW3iH6H/uBWLmpmlt4s7lDPzUOuVAOZr7ahUPPlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=B00K9GB2; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=I10jGHXN; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724888092; x=1756424092;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=xU+md2SetDkcYnHecB52y7DFrXKFh7mateJ7n0bOZaY=;
  b=B00K9GB21gxQrgfeewHlYanWA148x+sSFlf5J3HEeCN5gwz4SRAmISZx
   9mc0nYLHcT03hdLEBOCTal0U1U+G6mbhoVeYuIR9mN+ZGOJp9LklwnKzf
   h0Mp3EafAptlBEAUMh4U8lO/L1riiZcy0WSY/4iuXSFnSMRfGjBPU0zqi
   4BiBEBZytxL784KHclpPK/8/mORAnOU9WmNiFF7rol0cKI7bEavoE+2KP
   4+wlxtBCyMGi3AFyQkxmYAN4QGE4m5NgFpVOycCCzGDymp2nixq3gYYb2
   vafek4y1hffa6Bv9m19LHBFDtIWjuZS4/DhpiaFcmX+N+g4Bq7OQRiIWO
   A==;
X-CSE-ConnectionGUID: 3FEdszvHQpG9Sdn1THbSxg==
X-CSE-MsgGUID: d2cqoiOPSRySZLFaJzY+qQ==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:34:51 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d244820edso73632805ab.3
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724888090; x=1725492890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9OfSZAS2IbNEBKOlhjo34CvGTPlpmaMUhKOP9nkqn58=;
        b=I10jGHXNAM0MdjwUpp/MQiv7yReBEowtvOsSnXXZMnoVk4ZKcn4XmqVlsJ94rgiYul
         4DLLXt7sPTFKIY5IDo1IRPjpzaUl0MJibtZI3i+rPaOunAmUupXljcQUT5M0LMCq0qi/
         7HjvOdNP+9OmK5Wkze5SPI1+G4JvIDQyW2hS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724888090; x=1725492890;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OfSZAS2IbNEBKOlhjo34CvGTPlpmaMUhKOP9nkqn58=;
        b=jdQYMv10te/osLVfpexNKVWEhgoyhMPspfmHJ7VbNos6FHzkWGjsqOiV+BkUN2ZIUr
         F9pDT+2B+BS008daTjGa7pIMKXHsNMLKCXAZnBZ2obdhSh1kPijbS4PMkEOioNXeO5OV
         F0A+NGS4sdbMOY+uk3tjdfLEwkuwwYqXte8c+Q3OdtXoxO5jIgDvk4Ps6vgVKXRKibyd
         0hZKHJ8X7qw9z7OUKyWUTPHtq8LmlQk3Bkg9CaOjKf5/CN/YdoezkRz8z8UuC7buA3vI
         hYe5OEFCfzJ/bhK/c7t04IHAeYDPya+/Ok9iSw2/TqdGYryFN3KfTMmGPLytDjs2hncP
         2E/g==
X-Forwarded-Encrypted: i=1; AJvYcCVoe6azYpTcMKsWNWtMxr13KtTN3cztlaRt+KGylh+Ns6YXqSDngRt1qDCqFT8Ht6a2KaKfWF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/cbuWjSd9TuFjavdyvjUNkTuFAVjWVQ7ybqQxd2wVHs6ZtrB
	MEiwMT8QKBlJ2MwM9hHvXPQAKvKtXVUG8YlXfb94hK1t7itLn4AOPFhWX6W1OU5Cpll24TXefwU
	wn4o8ibSKsxHCWk/cpgPyytA+m0anDeC3WLjdndg60IaaIzcylVYTye1IpOlxJhEVtSmBl5ZOII
	yeCFxSKAQzX4a+27CycNdvN4dhhzbHSg==
X-Received: by 2002:a05:6e02:2163:b0:39d:23e7:9709 with SMTP id e9e14a558f8ab-39f377fe8fbmr18823095ab.13.1724888090641;
        Wed, 28 Aug 2024 16:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLz9RvA4l+Z6sywvQD2C5NkwUsJjLtb6kpT/TnPs6NQ9k1gr0Pw4jw9Y0tMH3qj56eN3Bb8OWpvGhLWZySCMQ=
X-Received: by 2002:a05:6e02:2163:b0:39d:23e7:9709 with SMTP id
 e9e14a558f8ab-39f377fe8fbmr18822925ab.13.1724888090313; Wed, 28 Aug 2024
 16:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:34:39 -0700
Message-ID: <CALAgD-7-Z+xbXwtvA9n9X2YE-B9f2bHFtyQxkX1uL+Yqd5zRuQ@mail.gmail.com>
Subject: BUG: corrupted list in neigh_destroy
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, j.granados@samsung.com, 
	linux@weissschuh.net, judyhsiao@chromium.org, James.Z.Li@dell.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a
corrupted list bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

list_del corruption, ffff88802cfc0d80->next is NULL
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 4497 Comm: kworker/0:3 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events_power_efficient neigh_periodic_work
RIP: 0010:__list_del_entry_valid_or_report+0xc3/0x120 lib/list_debug.c:52
Code: 08 48 89 df e8 4e 01 96 fd 48 8b 13 4c 39 fa 75 62 b0 01 5b 41
5c 41 5e 41 5f c3 48 c7 c7 60 5a a9 8b 4c 89 fe e8 dd ff 96 06 <0f> 0b
48 c7 c7 c0 5a a9 8b 4c 89 fe e8 cc ff 96 06 0f 0b 48 c7 c7
RSP: 0018:ffffc90002ce7978 EFLAGS: 00010046
RAX: 0000000000000033 RBX: 0000000000000000 RCX: 31a71fdaa0dd1600
RDX: 0000000000000000 RSI: 0000000080000202 RDI: 0000000000000000
RBP: ffffc90002ce7ac8 R08: ffffffff8172e30c R09: 1ffff9200059ced0
R10: dffffc0000000000 R11: fffff5200059ced1 R12: dffffc0000000000
R13: ffff88802cfc0d80 R14: 0000000000000000 R15: ffff88802cfc0d80
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dc1a4cee78 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_move_tail include/linux/list.h:310 [inline]
 ref_tracker_free+0x191/0x7b0 lib/ref_tracker.c:262
 netdev_tracker_free include/linux/netdevice.h:4058 [inline]
 netdev_put include/linux/netdevice.h:4075 [inline]
 neigh_destroy+0x317/0x570 net/core/neighbour.c:914
 neigh_periodic_work+0x3c6/0xd40 net/core/neighbour.c:1007
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0xc3/0x120 lib/list_debug.c:52
Code: 08 48 89 df e8 4e 01 96 fd 48 8b 13 4c 39 fa 75 62 b0 01 5b 41
5c 41 5e 41 5f c3 48 c7 c7 60 5a a9 8b 4c 89 fe e8 dd ff 96 06 <0f> 0b
48 c7 c7 c0 5a a9 8b 4c 89 fe e8 cc ff 96 06 0f 0b 48 c7 c7
RSP: 0018:ffffc90002ce7978 EFLAGS: 00010046
RAX: 0000000000000033 RBX: 0000000000000000 RCX: 31a71fdaa0dd1600
RDX: 0000000000000000 RSI: 0000000080000202 RDI: 0000000000000000
RBP: ffffc90002ce7ac8 R08: ffffffff8172e30c R09: 1ffff9200059ced0
R10: dffffc0000000000 R11: fffff5200059ced1 R12: dffffc0000000000
R13: ffff88802cfc0d80 R14: 0000000000000000 R15: ffff88802cfc0d80
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dc1a4cee78 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


-- 
Yours sincerely,
Xingyu

