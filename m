Return-Path: <netdev+bounces-299287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tXDLOvBSL2ri+QQAu9opvQ
	(envelope-from <netdev+bounces-299287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:18:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5353E682B88
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:18:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lVSeNbm1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299287-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299287-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 445693001B7A
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 01:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9E2192F9;
	Mon, 15 Jun 2026 01:17:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFDA236A73
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 01:17:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486222; cv=none; b=kw6AyfY6wkKs211/AhIiTZlgXNvElYlQTAYUlCV9GA+It3TCvcOSrWrDNIsOcdd3OdgYFgOrdUFdDS3PqIgimLTcya4vlLc4JYPcTHujHAs/jIRveloVJzjTOqqRDtTA6l/+VeQLoaZ+CvHJCNWspQzNm/CErmutRpGgC+xHJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486222; c=relaxed/simple;
	bh=trVIk13W7Y5cs88wloEtPHgtgwxXK59dgYVXbQ4YBrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J5pa7JNlmJoqZjFQ39yZLTgbTSLTFWtvrT57WAey8OnL3T3AR4AJr6vBT4E1mFU4Jo/5DX/Avm2a3vXvdLOO/NaFLS3wJPwHHqg/TkkbT1yWUjRf4Y21jcNNIJNrwcq+HqX3YVQ4kgHhGxiv9CPfiSbR8pWoxUgKYFyeN68++1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVSeNbm1; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-91563382bcfso322549285a.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 18:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781486220; x=1782091020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SDlixpD+BqkdIAghv/Y/LRkUC2+7bgGbDTHj+B8lK0g=;
        b=lVSeNbm1MkipSsN/Oo8kLbyAwlMQpcGklTEqJFirNvDRasZnNnsjBZ64AD3SNz5GI3
         ND1qINgP8pezXrv46pqseT1p9GD2UThu0yDtMrdAuRSEgwN/rtPSjet7fRjyY6F1qbkk
         0srj18hQhyUYWxZVtFRTnGRm9YuUggOPnpCMo4FKFy/pAdARdVuicpL1urYty/X1Znpx
         7dXmCAplPykZSfj9kgd0fszD4Oci0TGRmWzEMONSfVCpwPI4qzFBbftNoRXGDYHbKtnC
         XqS1g3YIJJZwmA5LAeKRU8waHrjrKvuxsH31Evv4CKDKZuxWP0JUEDM0F94m0s5xaES/
         fj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781486220; x=1782091020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDlixpD+BqkdIAghv/Y/LRkUC2+7bgGbDTHj+B8lK0g=;
        b=kICZU4XGB2mzqczM9p29JHE7TVs6FJR7NBZz5H9tqon3jL1xP64ajy2HcNvCXyRvZc
         ozovdyeWoZt72ZkGLLF0tMij3Y4YT9DjKs42BRyQi4bVZbX0/QlUlBcbIafM+8j3THvx
         qRcug79ga6/LIquQAdmiuQ7UBwa+HvZkJpq0UdH3BHtTV70mNOJFS6g0aTM+QZnNllDq
         nhw+J9thXaiSzAmzzk533o3vV+3mJQWDeEu2W3jq7p2YN/7eqTRvh9JT7tKz4rDMdBiM
         gXRIEYoPknjsOf+jJA2/IUIepL9nm845oK0h8MYODp0Dkkab+J9+i+hXt5ruuqbDXyNw
         I8MQ==
X-Gm-Message-State: AOJu0YxObqU/Znx9SG7SCP60GmuecLpelq4zFEV4ax8BkWK4l8BTHo/I
	fv9PSN6fkzdgzYd4ouTV36tPiXsRyORXEautF2XQNSgOfL2wkQAegfgRqeqeavvjJpKc9Q==
X-Gm-Gg: Acq92OGYxWl2KwNytRMAx43Eof7fKjwjnjl7gQV+uf4LdCf1A0uS0oJN0/UVWX08Y6b
	w70AliCP36yXCGoBBEhUW2NsGxGRUCSTuzRjnucDlpnuoH2NDe+iwucTEX0APdx1kukd0tPE7xo
	CqpeVHPmgRW8KEk1ATtEFCcKGtFSl8yQkMF/4XRUZvurMaorp7jUXAS8cWAnu+PEg6qIzA0JxKS
	i8Xz5BefJUYrV1dQMlxW1Ah/69qGT5OR767ijFUccLv82+QXrX6NYRni1PvKZT9OI7AnkarZJ4o
	PSbPiUs2NjPNzQxAOJWfq2z02woimRrN1cajdocsGCdNHoHB247EgtGfLFbTF6TzBf2XKBavpNg
	NdDce9d7xJOf7WLDuM7A3JMdIChx0bsjWMQzg4u/4cv8+Bu45hUk9RUQ2cz7h4ziyTEEayegTzL
	tNCt2yG2QkEgdtxo861eSkru+BTvfXVPC5bs00GnHitRPqVsgAtJ95XPFi89TRe7XcI4pKow==
X-Received: by 2002:a05:620a:25d1:b0:915:aa63:f362 with SMTP id af79cd13be357-9161bf5c9bcmr1886777385a.56.1781486220007;
        Sun, 14 Jun 2026 18:17:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:985:4601:5df0:2106:6ce9:6b1:8f70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a006ef0sm904510185a.24.2026.06.14.18.16.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 18:16:59 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [BUG] netdevsim: KASAN slab-use-after-free in ref_tracker_free
Date: Sun, 14 Jun 2026 21:16:57 -0400
Message-ID: <178144969601.60470.14764529841344817811@gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299287-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5353E682B88

Hi netdev maintainers,

I hit the following KASAN report while testing an upstream kernel.

The issue was reproduced with netdevsim. I have not confirmed whether this is
specific to netdevsim or whether other net devices can trigger a similar issue.

The KASAN report shows a slab-use-after-free in ref_tracker_free(), reached from
sysfs_rtnl_lock() while reading phys_port_name.

I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

To help trigger the bug more reliably, we applied a minimal diagnostic patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/b49765d646ec4610917015371aa1c3ca

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[ 3145.449971][T17497] BUG: KASAN: slab-use-after-free in ref_tracker_free (lib/ref_tracker.c:295)
[ 3145.452089][T17497] Read of size 1 at addr ffff888107678598 by task cat/17497
[ 3145.454439][T17497]
[ 3145.454977][T17497] Tainted: [W]=WARN
[ 3145.454980][T17497] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 3145.454985][T17497] Call Trace:
[ 3145.454991][T17497]  <TASK>
[ 3145.454994][T17497]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[ 3145.455002][T17497]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[ 3145.455028][T17497]  kasan_report (mm/kasan/report.c:595)
[ 3145.455046][T17497]  ref_tracker_free (lib/ref_tracker.c:295)
[ 3145.455083][T17497]  sysfs_rtnl_lock (include/linux/netdevice.h:4491 include/linux/netdevice.h:4508 include/linux/netdevice.h:4534 net/core/net-sysfs.c:122)
[ 3145.455091][T17497]  phys_port_name_show (net/core/net-sysfs.c:665)
[ 3145.455118][T17497]  dev_attr_show (drivers/base/core.c:2421)
[ 3145.455128][T17497]  sysfs_kf_seq_show (fs/sysfs/file.c:65)
[ 3145.455135][T17497]  seq_read_iter (fs/seq_file.c:231)
[ 3145.455144][T17497]  vfs_read (fs/read_write.c:493 fs/read_write.c:574)
[ 3145.455169][T17497]  ksys_read (fs/read_write.c:717)
[ 3145.455181][T17497]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[ 3145.455188][T17497]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[ 3145.455193][T17497] RIP: 0033:0x7fcf098c43ce
[ 3145.455200][T17497] Code: c0 e9 b6 fe ff ff 50 48 8d 3d 6e 08 0b 00 e8 69 01 02 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
[ 3145.455204][T17497] RSP: 002b:00007ffd05e76b98 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 3145.455211][T17497] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fcf098c43ce
[ 3145.455214][T17497] RDX: 0000000000020000 RSI: 00007fcf095e4000 RDI: 0000000000000003
[ 3145.455217][T17497] RBP: 00007fcf095e4000 R08: 00007fcf095e3010 R09: 0000000000000000
[ 3145.455219][T17497] R10: fffffffffffffbc5 R11: 0000000000000246 R12: 0000000000000000
[ 3145.455222][T17497] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
[ 3145.455227][T17497]  </TASK>
[ 3145.455229][T17497]
[ 3145.479014][T17497] Freed by task 17497 on cpu 0 at 3145.447575s:
[ 3145.479559][T17497]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[ 3145.479963][T17497]  kasan_save_free_info (mm/kasan/generic.c:584)
[ 3145.480411][T17497]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[ 3145.480813][T17497]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[ 3145.481148][T17497]  device_release (drivers/base/core.c:2542)
[ 3145.481567][T17497]  kobject_put (lib/kobject.c:689 lib/kobject.c:720 include/linux/kref.h:65 lib/kobject.c:737)
[ 3145.481951][T17497]  sysfs_rtnl_lock (net/core/net-sysfs.c:121)
[ 3145.482351][T17497]  phys_port_name_show (net/core/net-sysfs.c:665)
[ 3145.482782][T17497]  dev_attr_show (drivers/base/core.c:2421)
[ 3145.483154][T17497]  sysfs_kf_seq_show (fs/sysfs/file.c:65)
[ 3145.483586][T17497]  seq_read_iter (fs/seq_file.c:231)
[ 3145.483975][T17497]  vfs_read (fs/read_write.c:493 fs/read_write.c:574)
[ 3145.484334][T17497]  ksys_read (fs/read_write.c:717)
[ 3145.484701][T17497]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[ 3145.485092][T17497]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[ 3145.485592][T17497]
[ 3145.485794][T17497] The buggy address belongs to the object at ffff888107678000
[ 3145.485794][T17497]  which belongs to the cache kmalloc-cg-8k of size 8192
[ 3145.486991][T17497] The buggy address is located 1432 bytes inside of
[ 3145.486991][T17497]  freed 8192-byte region [ffff888107678000, ffff88810767a000)
[ 3145.488159][T17497]
[ 3145.488367][T17497] The buggy address belongs to the physical page:


Best,
Shuangpeng

