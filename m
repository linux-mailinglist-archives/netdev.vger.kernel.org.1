Return-Path: <netdev+bounces-221057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F01B49FA5
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 05:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538F01B25A88
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5D324A063;
	Tue,  9 Sep 2025 03:03:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E654315A;
	Tue,  9 Sep 2025 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387010; cv=none; b=Dv4DUQnS8/46l9HmFauirr+Yklkiav4GL0tv0ICLW+u3NAyptDA/anmc7ZJ6LW7myjNAJAhaGftAW1RPe5FZ0N3mz1jgSb5F81XBC/k9PqpWu99WxJM0Lvahz6VLP/oocEHFN1GUinZDUHCqswU6ae+OECVUxrD310Vvc6yFp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387010; c=relaxed/simple;
	bh=5Br/JtHWpm9N8F9/75f4idwkCmmdDe/0q5sbqqZBaW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C6HPs/WHfpDcZGwNE/gZle3PtfYFpj3uWdugFNeTOtOFAJFs3GhOth7xGiSfLH2dto3NjeMZjvZJqPnrTRRpmaMreiPciU1HqVPxVVehBpOTv6m3WD/gVsTxstusE/DQoMTfiGHry8rEhHyhiVHejK7qOsRnH+Gg+ELGkjA3WQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cLT7n1ybPz2TTKD;
	Tue,  9 Sep 2025 10:59:49 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FB85180043;
	Tue,  9 Sep 2025 11:03:03 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Sep
 2025 11:03:02 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<npitre@baylibre.com>, <simona@ffwll.ch>, <deller@gmx.de>,
	<soci@c64.rulez.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <linux-fbdev@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [report] BUG: KASAN: slab-out-of-bounds in soft_cursor+0x454/0xa30
Date: Tue, 9 Sep 2025 11:24:43 +0800
Message-ID: <20250909032443.196506-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)

Hello, my local syzkaller report a KASAN slab-out-of-bounds issue:

 ==================================================================
 BUG: KASAN: slab-out-of-bounds in soft_cursor+0x454/0xa30
 Read of size 128 at addr ffff88810f53d000 by task test/674

 CPU: 1 UID: 0 PID: 674 Comm: test Not tainted 6.17.0-rc4+ #272 PREEMPT(none)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0xab/0xe0
  print_address_description.constprop.0+0x2c/0x3d0
  print_report+0xb4/0x270
  kasan_report+0xb8/0xf0
  kasan_check_range+0x39/0x1c0
  __asan_memcpy+0x24/0x60
  soft_cursor+0x454/0xa30
  ccw_cursor+0x1715/0x1ce0
  fbcon_cursor+0x410/0x5f0
  hide_cursor+0x8b/0x230
  redraw_screen+0x5c7/0x740
  vc_do_resize+0xcdd/0xe90
  fbcon_do_set_font+0x45d/0x940
  fbcon_set_font+0x83b/0x980
  con_font_op+0x805/0xa10
  vt_k_ioctl+0x2f9/0xb00
  vt_ioctl+0x14a/0x1870
  tty_ioctl+0x6d0/0x1610
  __x64_sys_ioctl+0x194/0x210
  do_syscall_64+0x5f/0x2d0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>

 Allocated by task 613:
  kasan_save_stack+0x24/0x50
  kasan_save_track+0x14/0x30
  __kasan_kmalloc+0x7f/0x90
  __kmalloc_noprof+0x1f5/0x510
  fbcon_rotate_font+0x440/0xee0
  fbcon_switch+0x751/0x1480
  redraw_screen+0x2b6/0x740
  vc_do_resize+0xcdd/0xe90
  fbcon_modechanged+0x333/0x6d0
  fbcon_set_all_vcs+0x1e0/0x3c0
  rotate_all_store+0x2e4/0x370
  dev_attr_store+0x5c/0x90
  sysfs_kf_write+0x1db/0x270
  kernfs_fop_write_iter+0x365/0x510
  vfs_write+0xa5e/0xd70
  ksys_write+0x129/0x240
  do_syscall_64+0x5f/0x2d0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

This issue can be reproduced by:
 echo 3 > /sys/devices/virtual/graphics/fbcon/rotate_all
 ioctl(fd, KDFONTOP, &font_op); // set bigger width or height

When exec KD_FONT_OP_SET cmd, function fbcon_do_set_font() update
vc->vc_font.width/height, but visit the old ops->fontbuffer in
ccw_cursor(), which will be updated in fbcon_rotate_font() later.

fbcon_set_font
    fbcon_do_set_font
        // update vc->vc_font.width/height
        vc->vc_font.width = w;
        vc->vc_font.height = h;
        vc_do_resize
            redraw_screen
                // ops->fontbuffer is old, but width/height is new
                hide_cursor
                    ccw_cursor
                        src = ops->fontbuffer + (...*vc->vc_font.width));
                // update ops->fontbuffer
                fbcon_switch
                    fbcon_rotate_font
                        ops->fontbuffer = kmalloc_array(len, d_cellsize);

I am not sure below code is ok to fix this issue, although it can prevent
the KASAN report.

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 62049ceb34de..12dc2fa30417 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -953,7 +953,6 @@  void redraw_screen(struct vc_data *vc, int is_switch)
 		if (tty0dev)
 			sysfs_notify(&tty0dev->kobj, NULL, "active");
 	} else {
-		hide_cursor(vc);
 		redraw = 1;
 	}
 
@@ -964,6 +963,8 @@  void redraw_screen(struct vc_data *vc, int is_switch)
 		set_origin(vc);
 		update = vc->vc_sw->con_switch(vc);
 		set_palette(vc);
+		if (!is_switch)
+			hide_cursor(vc);
 		/*
 		 * If console changed from mono<->color, the best we can do
 		 * is to clear the buffer attributes. As it currently stands,

