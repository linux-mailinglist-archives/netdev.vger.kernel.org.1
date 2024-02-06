Return-Path: <netdev+bounces-69571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDA884BB3C
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82FDDB29AF5
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380A515A4;
	Tue,  6 Feb 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IyZjkIny"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73A8C1E
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237815; cv=none; b=l40OsFOcziAIxbr6T8e8JZks4hTd6j1JQLlYyY5tpIoirsk03bAHFqQ8OSXIf/wBUzB5kdXl9o43IyniMM611NEJojWaWt7jz4KL352w/fqJzQ0iNs4wPgH35qYQfyaaG/TJddSa5fP8q1gkeCw0dVDy6lsrR2D1CtDoPIUwYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237815; c=relaxed/simple;
	bh=ca1B0aHAa1osgL1XYVTbFu+y72b0oK99U35SfhA5nTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPYGrvCLtR0dEihk4DnDVKICSECH2RpHjmP4aYBdxpXDWoBmz/Gap6siniQji2fgJCRNDN279o7xMk4vYRBnNv1GRr8pL6sJLJ6Ge9nV8BYdKk7wmdEZyvEsmdoYZRQGA1lRrXkOFkVjmxqbzn5DjM2FzpGzoCo/WsLfuuBN3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IyZjkIny; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fc52c2ae4so40945115e9.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707237811; x=1707842611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nVtnNvazOjnwUdE1wP5erqfSYfRBr30Sy9NKQ5fJ+hw=;
        b=IyZjkInyA5B58WT7G/44agXXK+IZFfnBDc2WtIxhjReNo2Av7CS9a5cbgl3qB/USIN
         ldbwPUFTwVI50ELn53nqQonS+G++gX47md4DG2Q+EN3b2CscN7XfY/DAD5DzZLoXXsdg
         25Hu7i5HxhMWOjlELvqkj1BSqu0RjRAI2jhvvh5ciTdPeyd4pP+PaJhMJRGei0Cw3P8A
         x5F9M4hAGUp9HuFmVc/O6PNk8WrSF8bf65spgiuscY0dsOufevHbz2IAkI5MklvOsff3
         wDgyiTvIFGjEEvv2r44RrY1qNfH/LfqMi8TK+96KdkSxIbNfSlK8GIGFL+FnD2YFl0XI
         lCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237811; x=1707842611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVtnNvazOjnwUdE1wP5erqfSYfRBr30Sy9NKQ5fJ+hw=;
        b=MQS8Z+BWl71cFwF3+dfk31oDynlWKrTx6G5do5AOxRgHEyxJB2F3LL9iHyB1jzWlXm
         lhbI408iV/DSKA8xafW/eubaYiNUUQaTrIWYMgHZwfI94ZcxxEA9ybRlXqJBMEoVc86U
         JleK0igA7uQA01eR7kph/O1ip7W+dyKYY/ZJDY3lx1FhSiu2M4kTNL69v1MxzPM3usZd
         NTdHCdnG3BNLfjOtyJ/y6UVQH4sCNEuGWY/qI7ozEd2jSs73alWK3byFE+4DT/TfMNcN
         CDRgj996RepX4XX+sNabBJ+CQ1iy/4lF7ywqHuEjetJCagnfz0I/w6NoRtqAmGkpEPHZ
         +urw==
X-Gm-Message-State: AOJu0YwGSSdGLZeQE6yVJmpbKAG9NxCv36EpYnPxeY+sAOsxgk297gYD
	RNIzGbVSxvwWnRlKSXPEn67Fwzhcjwqfz+fXpSACkXERoYsCIHuHm7JM+jp9EwXVXWrzp6Cs/5B
	C+mA=
X-Google-Smtp-Source: AGHT+IEf8OFScXPJG2GGe8AsQJmy+zli2R25M18OFjuGFgfKT8BBeTuamfXMI0LqDVuQnLEkagmASQ==
X-Received: by 2002:a05:600c:5109:b0:40e:ac4f:7156 with SMTP id o9-20020a05600c510900b0040eac4f7156mr2644087wms.5.1707237810498;
        Tue, 06 Feb 2024 08:43:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6JVHtq2HBSDkzQqv11yhu0lZ2fZL9PcwURe2B1qlRke63DJFQ93v24xcBDF7fh3IClYpaVEhDcDGbQ85iFXPC8H4QkjSNjbUpyP6A4Cf9QkS+wny/Dam4rAwZ9pETyHp6fX+s0iBtCcW0953V3rd8Get9V6yVUyZflQtabQiUh2TtIc57kxl92kpfLnLl1uE4GZS4FO09TNceN2hZW4XHOvXuQBIBHvFsvfFTeibxzLtfTZ4KygMcHPqlNBtzI1zXVqBYDEP+xWb+24rxwp4aeX8=
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id iv10-20020a05600c548a00b0040ebf603a89sm2544863wmb.11.2024.02.06.08.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:43:29 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [patch net] net/mlx5: DPLL, Fix possible use after free after delayed work timer triggers
Date: Tue,  6 Feb 2024 17:43:28 +0100
Message-ID: <20240206164328.360313-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

I managed to hit following use after free warning recently:

[ 2169.711665] ==================================================================
[ 2169.714009] BUG: KASAN: slab-use-after-free in __run_timers.part.0+0x179/0x4c0
[ 2169.716293] Write of size 8 at addr ffff88812b326a70 by task swapper/4/0

[ 2169.719022] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 6.8.0-rc2jiri+ #2
[ 2169.720974] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[ 2169.722457] Call Trace:
[ 2169.722756]  <IRQ>
[ 2169.723024]  dump_stack_lvl+0x58/0xb0
[ 2169.723417]  print_report+0xc5/0x630
[ 2169.723807]  ? __virt_addr_valid+0x126/0x2b0
[ 2169.724268]  kasan_report+0xbe/0xf0
[ 2169.724667]  ? __run_timers.part.0+0x179/0x4c0
[ 2169.725116]  ? __run_timers.part.0+0x179/0x4c0
[ 2169.725570]  __run_timers.part.0+0x179/0x4c0
[ 2169.726003]  ? call_timer_fn+0x320/0x320
[ 2169.726404]  ? lock_downgrade+0x3a0/0x3a0
[ 2169.726820]  ? kvm_clock_get_cycles+0x14/0x20
[ 2169.727257]  ? ktime_get+0x92/0x150
[ 2169.727630]  ? lapic_next_deadline+0x35/0x60
[ 2169.728069]  run_timer_softirq+0x40/0x80
[ 2169.728475]  __do_softirq+0x1a1/0x509
[ 2169.728866]  irq_exit_rcu+0x95/0xc0
[ 2169.729241]  sysvec_apic_timer_interrupt+0x6b/0x80
[ 2169.729718]  </IRQ>
[ 2169.729993]  <TASK>
[ 2169.730259]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[ 2169.730755] RIP: 0010:default_idle+0x13/0x20
[ 2169.731190] Code: c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc 8b 05 9a 7f 1f 02 85 c0 7e 07 0f 00 2d cf 69 43 00 fb f4 <fa> c3 66 66 2e 0f 1f 84 00 00 00 00 00 65 48 8b 04 25 c0 93 04 00
[ 2169.732759] RSP: 0018:ffff888100dbfe10 EFLAGS: 00000242
[ 2169.733264] RAX: 0000000000000001 RBX: ffff888100d9c200 RCX: ffffffff8241bd62
[ 2169.733925] RDX: ffffed109a848b15 RSI: 0000000000000004 RDI: ffffffff8127ac55
[ 2169.734566] RBP: 0000000000000004 R08: 0000000000000000 R09: ffffed109a848b14
[ 2169.735200] R10: ffff8884d42458a3 R11: 000000000000ba7e R12: ffffffff83d7d3a0
[ 2169.735835] R13: 1ffff110201b7fc6 R14: 0000000000000000 R15: ffff888100d9c200
[ 2169.736478]  ? ct_kernel_exit.constprop.0+0xa2/0xc0
[ 2169.736954]  ? do_idle+0x285/0x290
[ 2169.737323]  default_idle_call+0x63/0x90
[ 2169.737730]  do_idle+0x285/0x290
[ 2169.738089]  ? arch_cpu_idle_exit+0x30/0x30
[ 2169.738511]  ? mark_held_locks+0x1a/0x80
[ 2169.738917]  ? lockdep_hardirqs_on_prepare+0x12e/0x200
[ 2169.739417]  cpu_startup_entry+0x30/0x40
[ 2169.739825]  start_secondary+0x19a/0x1c0
[ 2169.740229]  ? set_cpu_sibling_map+0xbd0/0xbd0
[ 2169.740673]  secondary_startup_64_no_verify+0x15d/0x16b
[ 2169.741179]  </TASK>

[ 2169.741686] Allocated by task 1098:
[ 2169.742058]  kasan_save_stack+0x1c/0x40
[ 2169.742456]  kasan_save_track+0x10/0x30
[ 2169.742852]  __kasan_kmalloc+0x83/0x90
[ 2169.743246]  mlx5_dpll_probe+0xf5/0x3c0 [mlx5_dpll]
[ 2169.743730]  auxiliary_bus_probe+0x62/0xb0
[ 2169.744148]  really_probe+0x127/0x590
[ 2169.744534]  __driver_probe_device+0xd2/0x200
[ 2169.744973]  device_driver_attach+0x6b/0xf0
[ 2169.745402]  bind_store+0x90/0xe0
[ 2169.745761]  kernfs_fop_write_iter+0x1df/0x2a0
[ 2169.746210]  vfs_write+0x41f/0x790
[ 2169.746579]  ksys_write+0xc7/0x160
[ 2169.746947]  do_syscall_64+0x6f/0x140
[ 2169.747333]  entry_SYSCALL_64_after_hwframe+0x46/0x4e

[ 2169.748049] Freed by task 1220:
[ 2169.748393]  kasan_save_stack+0x1c/0x40
[ 2169.748789]  kasan_save_track+0x10/0x30
[ 2169.749188]  kasan_save_free_info+0x3b/0x50
[ 2169.749621]  poison_slab_object+0x106/0x180
[ 2169.750044]  __kasan_slab_free+0x14/0x50
[ 2169.750451]  kfree+0x118/0x330
[ 2169.750792]  mlx5_dpll_remove+0xf5/0x110 [mlx5_dpll]
[ 2169.751271]  auxiliary_bus_remove+0x2e/0x40
[ 2169.751694]  device_release_driver_internal+0x24b/0x2e0
[ 2169.752191]  unbind_store+0xa6/0xb0
[ 2169.752563]  kernfs_fop_write_iter+0x1df/0x2a0
[ 2169.753004]  vfs_write+0x41f/0x790
[ 2169.753381]  ksys_write+0xc7/0x160
[ 2169.753750]  do_syscall_64+0x6f/0x140
[ 2169.754132]  entry_SYSCALL_64_after_hwframe+0x46/0x4e

[ 2169.754847] Last potentially related work creation:
[ 2169.755315]  kasan_save_stack+0x1c/0x40
[ 2169.755709]  __kasan_record_aux_stack+0x9b/0xf0
[ 2169.756165]  __queue_work+0x382/0x8f0
[ 2169.756552]  call_timer_fn+0x126/0x320
[ 2169.756941]  __run_timers.part.0+0x2ea/0x4c0
[ 2169.757376]  run_timer_softirq+0x40/0x80
[ 2169.757782]  __do_softirq+0x1a1/0x509

[ 2169.758387] Second to last potentially related work creation:
[ 2169.758924]  kasan_save_stack+0x1c/0x40
[ 2169.759322]  __kasan_record_aux_stack+0x9b/0xf0
[ 2169.759773]  __queue_work+0x382/0x8f0
[ 2169.760156]  call_timer_fn+0x126/0x320
[ 2169.760550]  __run_timers.part.0+0x2ea/0x4c0
[ 2169.760978]  run_timer_softirq+0x40/0x80
[ 2169.761381]  __do_softirq+0x1a1/0x509

[ 2169.761998] The buggy address belongs to the object at ffff88812b326a00
                which belongs to the cache kmalloc-256 of size 256
[ 2169.763061] The buggy address is located 112 bytes inside of
                freed 256-byte region [ffff88812b326a00, ffff88812b326b00)

[ 2169.764346] The buggy address belongs to the physical page:
[ 2169.764866] page:000000000f2b1e89 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12b324
[ 2169.765731] head:000000000f2b1e89 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 2169.766484] anon flags: 0x200000000000840(slab|head|node=0|zone=2)
[ 2169.767048] page_type: 0xffffffff()
[ 2169.767422] raw: 0200000000000840 ffff888100042b40 0000000000000000 dead000000000001
[ 2169.768183] raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
[ 2169.768899] page dumped because: kasan: bad access detected

[ 2169.769649] Memory state around the buggy address:
[ 2169.770116]  ffff88812b326900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 2169.770805]  ffff88812b326980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 2169.771485] >ffff88812b326a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2169.772173]                                                              ^
[ 2169.772787]  ffff88812b326a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2169.773477]  ffff88812b326b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 2169.774160] ==================================================================
[ 2169.774845] ==================================================================

I didn't manage to reproduce it. Though the issue seems to be obvious.
There is a chance that the mlx5_dpll_remove() calls
cancel_delayed_work() when the work runs and manages to re-arm itself.
In that case, after delay timer triggers next attempt to queue it,
it works with freed memory.

Fix this by using cancel_delayed_work_sync() instead which makes sure
that work is done when it returns.

Fixes: 496fd0a26bbf ("mlx5: Implement SyncE support using DPLL infrastructure")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 18fed2b34fb1..928bf24d4b12 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -389,7 +389,7 @@ static void mlx5_dpll_remove(struct auxiliary_device *adev)
 	struct mlx5_dpll *mdpll = auxiliary_get_drvdata(adev);
 	struct mlx5_core_dev *mdev = mdpll->mdev;
 
-	cancel_delayed_work(&mdpll->work);
+	cancel_delayed_work_sync(&mdpll->work);
 	mlx5_dpll_mdev_netdev_untrack(mdpll, mdev);
 	destroy_workqueue(mdpll->wq);
 	dpll_pin_unregister(mdpll->dpll, mdpll->dpll_pin,
-- 
2.43.0


