Return-Path: <netdev+bounces-35989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A72F7AC3FE
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 19:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E36E9281ADD
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 17:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2227820B2E;
	Sat, 23 Sep 2023 17:36:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D83208BF
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 17:36:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4FE196
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695490559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r3dXsJ0PrUMLwxsDu1xZWpklvax4jGZqZ2Owbl/wVfY=;
	b=aqag7h4BRz+OeYOEzlMSL4VsDBJ8zlD13SlzZDHXGd/KVCMptB8kxqzD3ZMGV8xcU+9Ugf
	+D/AZuZ9ffl0A9X/wfLr/v74Vd1H6NDolz/97/pYhc+Nq/roMVvis8E+UyTWSoQeiqW3pL
	b+t7JPBP7s2OadAJlFyBInfq/Gt+tCM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ccx2DC7vNH6oMFeTTmbrhw-1; Sat, 23 Sep 2023 13:35:57 -0400
X-MC-Unique: ccx2DC7vNH6oMFeTTmbrhw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-27731a5b94dso478166a91.1
        for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 10:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695490556; x=1696095356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3dXsJ0PrUMLwxsDu1xZWpklvax4jGZqZ2Owbl/wVfY=;
        b=wwK3plnfSlDmxBY7CcLfAcC6C8TKkyCeA1V3zWWr4mbEF3R7GJZamnhuoipUj21Isq
         +2AJtB1bMQHMZ+kXbQQ1BOLDkEBF3uBmSFH1CtRLAQ/W0XJX8yi/loFaYFXx96tE2hUS
         eBYs/GbzasdpB9Ag8zdTOyD/ChbeX5+EHKp7psA+VmccNWa6O+KwJ1mQ0fYiUOIZktuX
         lkGxKGw3m/kX0ZclNZUSD0iObMNJzp5yxC62lZeLalcOsAp0xVLSc+XwzHzH8F9faBkm
         9T3HAbnev+QHDqZ5XW/N718hEaKbOpYNdDkvCILHPRwxiGmXgqk9088+XbdNtPAnYsnm
         OYPQ==
X-Gm-Message-State: AOJu0YwtJ2R7Nc+OuUfrPR4yYrVq5Xgf3ZHctd29FVTLnNkXoijs592F
	2oGYWxjyyQSiZo31LUAyy+v33E4Mol+wt/eHF1NbCtPW79alkXwm3SSVDv69NH0pkGnJGetnt18
	XJ1Peci9e6FjbIuRL
X-Received: by 2002:a17:902:788d:b0:1b8:af7f:6331 with SMTP id q13-20020a170902788d00b001b8af7f6331mr1864379pll.55.1695490556357;
        Sat, 23 Sep 2023 10:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtsHqA4s/kToHDmVHBnV78p43e5k0NjgHvGHO91nmCHsLgFgSM+u6dTE0zClXjg0aRNcNLSA==
X-Received: by 2002:a17:902:788d:b0:1b8:af7f:6331 with SMTP id q13-20020a170902788d00b001b8af7f6331mr1864370pll.55.1695490556026;
        Sat, 23 Sep 2023 10:35:56 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902eac600b001b801044466sm5608435pld.114.2023.09.23.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 10:35:55 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: steve.glendinning@shawell.net
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+6966546b78d050bb0b5d@syzkaller.appspotmail.com
Subject: [PATCH] net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg
Date: Sun, 24 Sep 2023 02:35:49 +0900
Message-ID: <20230923173549.3284502-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot reported the following uninit-value access issue:

=====================================================
BUG: KMSAN: uninit-value in smsc75xx_wait_ready drivers/net/usb/smsc75xx.c:975 [inline]
BUG: KMSAN: uninit-value in smsc75xx_bind+0x5c9/0x11e0 drivers/net/usb/smsc75xx.c:1482
CPU: 0 PID: 8696 Comm: kworker/0:3 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 smsc75xx_wait_ready drivers/net/usb/smsc75xx.c:975 [inline]
 smsc75xx_bind+0x5c9/0x11e0 drivers/net/usb/smsc75xx.c:1482
 usbnet_probe+0x1152/0x3f90 drivers/net/usb/usbnet.c:1737
 usb_probe_interface+0xece/0x1550 drivers/usb/core/driver.c:374
 really_probe+0xf20/0x20b0 drivers/base/dd.c:529
 driver_probe_device+0x293/0x390 drivers/base/dd.c:701
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:920
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x3b0e/0x40d0 drivers/base/core.c:2680
 usb_set_configuration+0x380f/0x3f10 drivers/usb/core/message.c:2032
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:241
 usb_probe_device+0x311/0x490 drivers/usb/core/driver.c:272
 really_probe+0xf20/0x20b0 drivers/base/dd.c:529
 driver_probe_device+0x293/0x390 drivers/base/dd.c:701
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:920
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x3b0e/0x40d0 drivers/base/core.c:2680
 usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x5e7b/0x8a70 drivers/usb/core/hub.c:5576
 process_one_work+0x1688/0x2140 kernel/workqueue.c:2269
 worker_thread+0x10bc/0x2730 kernel/workqueue.c:2415
 kthread+0x551/0x590 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Local variable ----buf.i87@smsc75xx_bind created at:
 __smsc75xx_read_reg drivers/net/usb/smsc75xx.c:83 [inline]
 smsc75xx_wait_ready drivers/net/usb/smsc75xx.c:968 [inline]
 smsc75xx_bind+0x485/0x11e0 drivers/net/usb/smsc75xx.c:1482
 __smsc75xx_read_reg drivers/net/usb/smsc75xx.c:83 [inline]
 smsc75xx_wait_ready drivers/net/usb/smsc75xx.c:968 [inline]
 smsc75xx_bind+0x485/0x11e0 drivers/net/usb/smsc75xx.c:1482

This issue is caused because usbnet_read_cmd() reads less bytes than requested
(zero byte in the reproducer). In this case, 'buf' is not properly filled.

This patch fixes the issue by returning -ENODATA if usbnet_read_cmd() reads
less bytes than requested.

Fixes: d0cad871703b ("smsc75xx: SMSC LAN75xx USB gigabit ethernet adapter driver")
Reported-and-tested-by: syzbot+6966546b78d050bb0b5d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6966546b78d050bb0b5d
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/net/usb/smsc75xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 5d6454fedb3f..78ad2da3ee29 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -90,7 +90,9 @@ static int __must_check __smsc75xx_read_reg(struct usbnet *dev, u32 index,
 	ret = fn(dev, USB_VENDOR_REQUEST_READ_REGISTER, USB_DIR_IN
 		 | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 0, index, &buf, 4);
-	if (unlikely(ret < 0)) {
+	if (unlikely(ret < 4)) {
+		ret = ret < 0 ? ret : -ENODATA;
+
 		netdev_warn(dev->net, "Failed to read reg index 0x%08x: %d\n",
 			    index, ret);
 		return ret;
-- 
2.41.0


