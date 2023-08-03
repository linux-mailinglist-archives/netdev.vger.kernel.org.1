Return-Path: <netdev+bounces-24044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B428176E96F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA1028180F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2921F16C;
	Thu,  3 Aug 2023 13:05:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC541E528
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB8DC433CD;
	Thu,  3 Aug 2023 13:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691067907;
	bh=Rbrz3Rgsy9WHnh0jzXQhfjbYc7AK2B7A6Zy82MXOu2w=;
	h=From:To:Cc:Subject:Date:From;
	b=axvyvmcnI7D5Uw72e1jkyZ9Fp3I//71OovxPrLPpHDOpdbDnvmym2h2R261qiG/6D
	 YA9pG85q7uLJEQ3QXNiSqY1diJGzpT6N7B7os5T6odfZfxsE0pDEcmTtc3C/7K+EKf
	 XCHecGnN4PxAoxBQOQPAtL3Mz2k6aCnqaSXP/P1OzGVcKGJxfNj7dVnVE0tw0Qagdp
	 Tvji5AAJynaeRKhmKoFaCf1MXaIinJxhdIC7GzzLXVwrdS0xcTPNTqPck31uAsLtb5
	 SJYrhs7tHPRVYPgLhdzx7PkG8oA/lwTzRC9fvRueq4YQerBziLt/MBFexEw6m6kjet
	 qBDqO+GlGwiQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com,
	Oliver Neukum <oneukum@suse.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14] net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb
Date: Thu,  3 Aug 2023 09:05:03 -0400
Message-Id: <20230803130503.642163-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.320
Content-Transfer-Encoding: 8bit

From: Alan Stern <stern@rowland.harvard.edu>

[ Upstream commit 5e1627cb43ddf1b24b92eb26f8d958a3f5676ccb ]

The syzbot fuzzer identified a problem in the usbnet driver:

usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 754 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
Modules linked in:
CPU: 0 PID: 754 Comm: kworker/0:2 Not tainted 6.4.0-rc7-syzkaller-00014-g692b7dc87ca6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: mld mld_ifc_work
RIP: 0010:usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
Code: 7c 24 18 e8 2c b4 5b fb 48 8b 7c 24 18 e8 42 07 f0 fe 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 a0 c9 fc 8a e8 5a 6f 23 fb <0f> 0b e9 58 f8 ff ff e8 fe b3 5b fb 48 81 c5 c0 05 00 00 e9 84 f7
RSP: 0018:ffffc9000463f568 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801eb28000 RSI: ffffffff814c03b7 RDI: 0000000000000001
RBP: ffff8881443b7190 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000003
R13: ffff88802a77cb18 R14: 0000000000000003 R15: ffff888018262500
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556a99c15a18 CR3: 0000000028c71000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 usbnet_start_xmit+0xfe5/0x2190 drivers/net/usb/usbnet.c:1453
 __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
 netdev_start_xmit include/linux/netdevice.h:4932 [inline]
 xmit_one net/core/dev.c:3578 [inline]
 dev_hard_start_xmit+0x187/0x700 net/core/dev.c:3594
...

This bug is caused by the fact that usbnet trusts the bulk endpoint
addresses its probe routine receives in the driver_info structure, and
it does not check to see that these endpoints actually exist and have
the expected type and directions.

The fix is simply to add such a check.

Reported-and-tested-by: syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-usb/000000000000a56e9105d0cec021@google.com/
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/ea152b6d-44df-4f8a-95c6-4db51143dcc1@rowland.harvard.edu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/usbnet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 71b026277b308..d0b772f433c44 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1771,6 +1771,10 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	} else if (!info->in || !info->out)
 		status = usbnet_get_endpoints (dev, udev);
 	else {
+		u8 ep_addrs[3] = {
+			info->in + USB_DIR_IN, info->out + USB_DIR_OUT, 0
+		};
+
 		dev->in = usb_rcvbulkpipe (xdev, info->in);
 		dev->out = usb_sndbulkpipe (xdev, info->out);
 		if (!(info->flags & FLAG_NO_SETINT))
@@ -1780,6 +1784,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		else
 			status = 0;
 
+		if (status == 0 && !usb_check_bulk_endpoints(udev, ep_addrs))
+			status = -EINVAL;
 	}
 	if (status >= 0 && dev->status)
 		status = init_status (dev, udev);
-- 
2.40.1


