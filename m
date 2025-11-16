Return-Path: <netdev+bounces-238927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FF4C611E6
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 10:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63DF04E1FE6
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BB723B63F;
	Sun, 16 Nov 2025 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vjcR0Dx4"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D4F6FBF;
	Sun, 16 Nov 2025 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763283897; cv=none; b=QcvbMD3pbedCSE4nMX2d8oaz03S6F7bSzQevCl0AjFnXs05eviRFUfKQ5Ef4wVkt+Ki5I9+G9kZxccuEI8A8JoXeQf1/69f0Xxv2xgFnWRr59uU0R32HmvDI81cCn5WnUMSe7jqIsjiGt1ZWZ5IktLJIFkxq1tAFtdL24LG8q64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763283897; c=relaxed/simple;
	bh=bMAovyXQ5Jl2Bqfqm4OhLklP2RmlDOwRJrVYcNtJTnU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jHA+x7DUwOHwx3/WlLg6C3GKQuSR8y239/O8st+15OikPLu3pM7dbPOZOMb8uWgdCNFksvlvyw27nqS25TuPsrExfXGe1iR/83SvFTPAfhQS8drpL/UhxqrquB6N28HdE8rhhF/fFsC4ecE5znz9TDrhnTa98K/e3+tFk6TwEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vjcR0Dx4; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1763283885; bh=1KDMtZ2uqJgZB/2vth/TRG5ypYnqKb/ZVL+aTW9r1bY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vjcR0Dx4mq7DFSDiXzpVuQ/H0h/jf5hGu4n8H1fVsZ/RA1+0zgMk0OuSwg7PjKdki
	 Px18fZX7fDGJlgBFKIGTws1yKL1EZrhDqyKPz4HCwHqett93ILWHxDtET7DR6ZgBla
	 TG7HGsyh8J7Vcr2JSYjSCR6nZDQ9G+tOe2d2H/UM=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 12B240D3; Sun, 16 Nov 2025 17:04:43 +0800
X-QQ-mid: xmsmtpt1763283883tg2uawld0
Message-ID: <tencent_279508EB2AECDECC2C79466F582D896E980A@qq.com>
X-QQ-XMAILINFO: MqG4KXyEKpQyuCgPqWrEYZ39If+J0XxCosFEmMtYywoi8JFEGQ2u43jBsC36G+
	 gpWyfXtvkFx21ZREFkbfim6+Mf/SKD1QaGip6HtPGjldjvi4yssG4WLDpFWywGTjKHxZInbyGHCB
	 flyfrwMJs/rPw8IgN6TU4aVbB9ku+gHLsVPD7Eg4qe65s83jsOAAwAf1urWbQdefpgLJ+TSwkwQ7
	 IGWwQD0FTTMBtgxGAujJpsZEzWHoHQzhtkVZwhQjbDeprtyMiEViaQF5aMOsAHSJm9cKkTUKfINr
	 KcLv6toM53CllFX0HskBlby+/ELmPTWK4UrtPJlVPNOEqmb12WfVt2KGeunIrLtEz3WSlhol34TA
	 d7icEEB11XY9MyQmqLZ2Lerqm6j0K7wNVx+myOfHKY3U4S+uS6e2VLcys6gHENbneYh62m+1t9cz
	 hqm4uoKfuHq9kvU0sTnv6OBgo6/3brl/Yjjv6MVqtepPzprdRuwZ6bG+IVY7yBktYaz2NOwkaTmO
	 1Wu9MrhOjcD+wvsjobkG2eDrkBmBznMt63ZWm+3GERoiJ8d6A81Q7JzaSphuRj1spl8f9Eyp/zqQ
	 RXwTdkGNn0aX5FHX2Wpmx121r/oRdDi11X5oNTe+jbljOcjyl/VIUzYFsci7Zdwv9o+jX7XH3DRt
	 NfZGh5+pF2WzWnSPPehrbjmJVqU8SAmfbsHH4sftzD7Dk9GDM4AaqYuVV9aNb4PiqVRngroQ9y2g
	 I/QWF2gqnYKQKGycRsv12GQ2kViX6qUZLCHIFb8E1rk+SMU6TybE+Cmuel3l3hA0XgpIF3zp2eIe
	 JW/woTwf8KSI9eqrZHXtYw6X0Ryqpl7yGszcEqwvOWTUwDQU0ON86FsBviDLRjgBFWkZkzwmlg7I
	 +ubu7mXeAAW5l1+p8/khmkgSOfRH/1jnWTFGs/6cd7YulItYD5xq+SacrC6YIrbDd+MjKsHqs4Uz
	 PiwdEjZ23G9GiWg9eZGgN74AodveakKoqn8jd4PnzB5GCM51bJbUGrVk70bA/LEME/LWm0IBQ=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9aa47cd4633a3cf92a80@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] Bluetooth: hci_sock: Prevent race in socket write iter and sock bind
Date: Sun, 16 Nov 2025 17:04:43 +0800
X-OQ-MSGID: <20251116090442.49103-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69197079.a70a0220.3124cb.0070.GAE@google.com>
References: <69197079.a70a0220.3124cb.0070.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a potential race condition between sock bind and socket write
iter. bind may free the same cmd via mgmt_pending before write iter sends
the cmd, just as syzbot reported in UAF[1].

Here we use hci_dev_lock to synchronize the two, thereby avoiding the
UAF mentioned in [1].

[1]
syzbot reported:
BUG: KASAN: slab-use-after-free in mgmt_pending_remove+0x3b/0x210 net/bluetooth/mgmt_util.c:316
Read of size 8 at addr ffff888077164818 by task syz.0.17/5989
Call Trace:
 mgmt_pending_remove+0x3b/0x210 net/bluetooth/mgmt_util.c:316
 set_link_security+0x5c2/0x710 net/bluetooth/mgmt.c:1918
 hci_mgmt_cmd+0x9c9/0xef0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0x6ca/0xef0 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 sock_write_iter+0x279/0x360 net/socket.c:1195

Allocated by task 5989:
 mgmt_pending_add+0x35/0x140 net/bluetooth/mgmt_util.c:296
 set_link_security+0x557/0x710 net/bluetooth/mgmt.c:1910
 hci_mgmt_cmd+0x9c9/0xef0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0x6ca/0xef0 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 sock_write_iter+0x279/0x360 net/socket.c:1195

Freed by task 5991:
 mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
 mgmt_pending_foreach+0x30d/0x380 net/bluetooth/mgmt_util.c:257
 mgmt_index_removed+0x112/0x2f0 net/bluetooth/mgmt.c:9477
 hci_sock_bind+0xbe9/0x1000 net/bluetooth/hci_sock.c:1314

Fixes: 6fe26f694c82 ("Bluetooth: MGMT: Protect mgmt_pending list with its own lock")
Reported-by: syzbot+9aa47cd4633a3cf92a80@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9aa47cd4633a3cf92a80
Tested-by: syzbot+9aa47cd4633a3cf92a80@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/hci_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index fc866759910d..ad19022ae127 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1311,7 +1311,9 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
+		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
+		hci_dev_unlock(hdev);
 
 		err = hci_dev_open(hdev->id);
 		if (err) {
-- 
2.43.0


