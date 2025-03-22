Return-Path: <netdev+bounces-176866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97CBA6C9D7
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 11:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E3A3A5B3F
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837781F8F04;
	Sat, 22 Mar 2025 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG5KKV26"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A41EFF83
	for <netdev@vger.kernel.org>; Sat, 22 Mar 2025 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640741; cv=none; b=mXIyuGNpy+7eLAd5c7XHw76tNbcu2xivv/HuDDtrnOLdHO9QiiKDfv7a70d4TIAmAmuYN9GMH1je0CsVRfQ9rYIaGyYMOBXEVjCUjYEE6dvzbPGdIQ/6/5lero6+md64CUmelGRKoiEuyOVEGSkPy5u4DTMPKqNMqpyV0cDnZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640741; c=relaxed/simple;
	bh=M2VDDgrzF/hgLNIG7RpPOfNLqJwvWD552v/vlOPqxsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=phE7ep6d20tosOORq0S9KXbC9Y1kskNDoFImlC/IR2xhlcCFXL7W3Bcx0/BDD2A9mPoUZWbgtVDY6AWCqqGHNCCzkzk9LdWAH/nyvoFOUDXNTSfvCT4B/nZoLDc8uB7XNFCbsnDQrH8oVn6oIuTEYr/KfJKFkT4DgWzZRFdjlBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YG5KKV26; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3014ae35534so4370508a91.0
        for <netdev@vger.kernel.org>; Sat, 22 Mar 2025 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742640739; x=1743245539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3PtaB9Ju3vFH0DuMHjQEmuihGRgL+PmPeKk6ZAxmuEs=;
        b=YG5KKV26fVsLyqzb8DATtAgKVVhRL2hOlHvQcPOCP6YNbBXPVNP8wAyoMloXiDGyy2
         t23PUyioCLSdFeGSoDBD0jWUjArfvCKYNTmNkkGx3BoVIPBfDClQKODIift8O2uZ0gCv
         Nnf0q401KEwSwNEaEtLktCUDEuOBJaZCdrLgqeZWOKpiaigSfnPKVYMMoQzZ4iaKSwiP
         Nk3XKABrg3Y7813rn8i30c6G659QNlalwuMhohFTCxt3XOg3jIvt9xdU3TQJox9z00Ax
         IFLvmuvYHosK3odbojyWi1FCZy+i2JyZ68c9GiD9tetUKq9Sj0CNKtX42Um6k2O3yChS
         zGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742640739; x=1743245539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PtaB9Ju3vFH0DuMHjQEmuihGRgL+PmPeKk6ZAxmuEs=;
        b=jgXkDGg/+SanfqHEzRuZkweUr5ZUCJXjX7VKicNIr3wy5MDoN+pD6qFq2zgNk9/1Y8
         15fgj3aTvDNB0sbYuvlbsXCiT+q0SRg4YsGO0Brw4DKbip0sQrRd29hXqe3Biph6ezd5
         3M2Ep5KjKBafpsDhbKxwcWXOIZWBQ6dbaN5/SyKbzQOjaDcXPE+CapQHgjlibD07OPLd
         LeYEiuZTW8ZRlZ5IHprrNCoQGXUis69WXYZq4U5JF+QpUiWiPbAd+3HaIQYFAs//1P/0
         25T+pX2DVlO1JFhdOIFY5vgaSFm9/q51PLF9XanzzJQVEb45WdDdnin2x22jXc5r8DZg
         bQOg==
X-Forwarded-Encrypted: i=1; AJvYcCUYCOQLA1Uftd8/cM3K4Uy9JfyiXOT/tnqppyTAfvxyMqGceuDpTi5ihdoJQrYtPOZsW8Wcano=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyng0a7MprDrbbVvK+R73iE0yBpIAjzKFS8BDrKrxevgS1Rp3Et
	mSXT9OrnO450i6Tx+e7MSIRr7Msqr1KWqsjtc551muQWfOU2q+a8
X-Gm-Gg: ASbGncsI69jdzO09+qAe/Yol6sScIf2CutHtr3+e+kC2skQCZWP6hvtXS/9z/kSmLCc
	LCQ+AEpdQIT8k0EUhs19TDEQeMPff90mj/4EEmh8diCtn4JPtcXxQahj3V15UpbFfmcMhJ/Tu3R
	gGLh2FAErQHb3VOgOI5tb/5U8v1MEpa6MZ/RZGDl/nopCbWavE413njinXucoWpbJQnhTAGg1ul
	YpvzwhrY0RpeCMfdRZGazzr9/eQHpOb4cDbIsUh7olAtA2NQH8icMoGx3BolQnRtOqBNNnUHGnn
	hrzm+z6sHfuh6xkTgttN0175Ri5FqZF8qcoE3A8xEYHnDgHq/2OROGvzJtLe3olk/kc=
X-Google-Smtp-Source: AGHT+IHsiWDf899njCBFRTebEtxecXTxqvAuszDt0ODHuPoHrNU8xJvrD8cEEpoY5rdffxtSnWTwLQ==
X-Received: by 2002:a17:90b:1dd2:b0:301:1bce:c26f with SMTP id 98e67ed59e1d1-3030fe8d558mr9297897a91.3.1742640738731;
        Sat, 22 Mar 2025 03:52:18 -0700 (PDT)
Received: from localhost.localdomain ([125.177.169.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf636029sm7904519a91.42.2025.03.22.03.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 03:52:18 -0700 (PDT)
From: pwn9uin@gmail.com
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Minjoong Kim <pwn9uin@gmail.com>
Subject: [PATCH net v2] atm: Fix NULL pointer dereference
Date: Sat, 22 Mar 2025 10:52:00 +0000
Message-Id: <20250322105200.14981-1-pwn9uin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Minjoong Kim <pwn9uin@gmail.com>

When MPOA_cache_impos_rcvd() receives the msg, it can trigger
Null Pointer Dereference Vulnerability if both entry and
holding_time are NULL. Because there is only for the situation
where entry is NULL and holding_time exists, it can be passed
when both entry and holding_time are NULL. If these are NULL,
the entry will be passd to eg_cache_put() as parameter and
it is referenced by entry->use code in it.

kasan log:

[    3.316691] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006:I
[    3.317568] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[    3.318188] CPU: 3 UID: 0 PID: 79 Comm: ex Not tainted 6.14.0-rc2 #102
[    3.318601] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    3.319298] RIP: 0010:eg_cache_remove_entry+0xa5/0x470
[    3.319677] Code: c1 f7 6e fd 48 c7 c7 00 7e 38 b2 e8 95 64 54 fd 48 c7 c7 40 7e 38 b2 48 89 ee e80
[    3.321220] RSP: 0018:ffff88800583f8a8 EFLAGS: 00010006
[    3.321596] RAX: 0000000000000006 RBX: ffff888005989000 RCX: ffffffffaecc2d8e
[    3.322112] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000030
[    3.322643] RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff6558b88
[    3.323181] R10: 0000000000000003 R11: 203a207972746e65 R12: 1ffff11000b07f15
[    3.323707] R13: dffffc0000000000 R14: ffff888005989000 R15: ffff888005989068
[    3.324185] FS:  000000001b6313c0(0000) GS:ffff88806d380000(0000) knlGS:0000000000000000
[    3.325042] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.325545] CR2: 00000000004b4b40 CR3: 000000000248e000 CR4: 00000000000006f0
[    3.326430] Call Trace:
[    3.326725]  <TASK>
[    3.326927]  ? die_addr+0x3c/0xa0
[    3.327330]  ? exc_general_protection+0x161/0x2a0
[    3.327662]  ? asm_exc_general_protection+0x26/0x30
[    3.328214]  ? vprintk_emit+0x15e/0x420
[    3.328543]  ? eg_cache_remove_entry+0xa5/0x470
[    3.328910]  ? eg_cache_remove_entry+0x9a/0x470
[    3.329294]  ? __pfx_eg_cache_remove_entry+0x10/0x10
[    3.329664]  ? console_unlock+0x107/0x1d0
[    3.329946]  ? __pfx_console_unlock+0x10/0x10
[    3.330283]  ? do_syscall_64+0xa6/0x1a0
[    3.330584]  ? entry_SYSCALL_64_after_hwframe+0x47/0x7f
[    3.331090]  ? __pfx_prb_read_valid+0x10/0x10
[    3.331395]  ? down_trylock+0x52/0x80
[    3.331703]  ? vprintk_emit+0x15e/0x420
[    3.331986]  ? __pfx_vprintk_emit+0x10/0x10
[    3.332279]  ? down_trylock+0x52/0x80
[    3.332527]  ? _printk+0xbf/0x100
[    3.332762]  ? __pfx__printk+0x10/0x10
[    3.333007]  ? _raw_write_lock_irq+0x81/0xe0
[    3.333284]  ? __pfx__raw_write_lock_irq+0x10/0x10
[    3.333614]  msg_from_mpoad+0x1185/0x2750
[    3.333893]  ? __build_skb_around+0x27b/0x3a0
[    3.334183]  ? __pfx_msg_from_mpoad+0x10/0x10
[    3.334501]  ? __alloc_skb+0x1c0/0x310
[    3.334809]  ? __pfx___alloc_skb+0x10/0x10
[    3.335283]  ? _raw_spin_lock+0xe0/0xe0
[    3.335632]  ? finish_wait+0x8d/0x1e0
[    3.335975]  vcc_sendmsg+0x684/0xba0
[    3.336250]  ? __pfx_vcc_sendmsg+0x10/0x10
[    3.336587]  ? __pfx_autoremove_wake_function+0x10/0x10
[    3.337056]  ? fdget+0x176/0x3e0
[    3.337348]  __sys_sendto+0x4a2/0x510
[    3.337663]  ? __pfx___sys_sendto+0x10/0x10
[    3.337969]  ? ioctl_has_perm.constprop.0.isra.0+0x284/0x400
[    3.338364]  ? sock_ioctl+0x1bb/0x5a0
[    3.338653]  ? __rseq_handle_notify_resume+0x825/0xd20
[    3.339017]  ? __pfx_sock_ioctl+0x10/0x10
[    3.339316]  ? __pfx___rseq_handle_notify_resume+0x10/0x10
[    3.339727]  ? selinux_file_ioctl+0xa4/0x260
[    3.340166]  __x64_sys_sendto+0xe0/0x1c0
[    3.340526]  ? syscall_exit_to_user_mode+0x123/0x140
[    3.340898]  do_syscall_64+0xa6/0x1a0
[    3.341170]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    3.341533] RIP: 0033:0x44a380
[    3.341757] Code: 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c00
[    3.343078] RSP: 002b:00007ffc1d404098 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[    3.343631] RAX: ffffffffffffffda RBX: 00007ffc1d404458 RCX: 000000000044a380
[    3.344306] RDX: 000000000000019c RSI: 00007ffc1d4040b0 RDI: 0000000000000003
[    3.344833] RBP: 00007ffc1d404260 R08: 0000000000000000 R09: 0000000000000000
[    3.345381] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[    3.346015] R13: 00007ffc1d404448 R14: 00000000004c17d0 R15: 0000000000000001
[    3.346503]  </TASK>
[    3.346679] Modules linked in:
[    3.346956] ---[ end trace 0000000000000000 ]---
[    3.347315] RIP: 0010:eg_cache_remove_entry+0xa5/0x470
[    3.347737] Code: c1 f7 6e fd 48 c7 c7 00 7e 38 b2 e8 95 64 54 fd 48 c7 c7 40 7e 38 b2 48 89 ee e80
[    3.349157] RSP: 0018:ffff88800583f8a8 EFLAGS: 00010006
[    3.349517] RAX: 0000000000000006 RBX: ffff888005989000 RCX: ffffffffaecc2d8e
[    3.350103] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000030
[    3.350610] RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff6558b88
[    3.351246] R10: 0000000000000003 R11: 203a207972746e65 R12: 1ffff11000b07f15
[    3.351785] R13: dffffc0000000000 R14: ffff888005989000 R15: ffff888005989068
[    3.352404] FS:  000000001b6313c0(0000) GS:ffff88806d380000(0000) knlGS:0000000000000000
[    3.353099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.353544] CR2: 00000000004b4b40 CR3: 000000000248e000 CR4: 00000000000006f0
[    3.354072] note: ex[79] exited with irqs disabled
[    3.354458] note: ex[79] exited with preempt_count 1

Signed-off-by: Minjoong Kim <pwn9uin@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
Changes in v2:
* Add KASAN report and Link to patch description
* Link to v1 https://lore.kernel.org/netdev/20250314003404.16408-1-pwn9uin@gmail.com/
---
 net/atm/mpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index 324e3ab96bb3..12da0269275c 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -1314,6 +1314,8 @@ static void MPOA_cache_impos_rcvd(struct k_message *msg,
 	holding_time = msg->content.eg_info.holding_time;
 	dprintk("(%s) entry = %p, holding_time = %u\n",
 		mpc->dev->name, entry, holding_time);
+	if (entry == NULL && !holding_time)
+		return;
 	if (entry == NULL && holding_time) {
 		entry = mpc->eg_ops->add_entry(msg, mpc);
 		mpc->eg_ops->put(entry);
-- 
2.34.1


