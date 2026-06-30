Return-Path: <netdev+bounces-302951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0V++CFpEQ2oYWQoAu9opvQ
	(envelope-from <netdev+bounces-302951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:21:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F296E03C9
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:21:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=O323CP3q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302951-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302951-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DCFB309E4EA
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D4A33BBCF;
	Tue, 30 Jun 2026 04:17:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E9D3B71D7
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:17:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793049; cv=none; b=Uy3+OQy1jY2h5hRF+XkknrDOhc3nyI1q239RGfH1639qPYEVK1Nlt190XW/s8UIgc9SooNq5ti4uxvMF0lFg/M1d205T95puejJx8Bjtprb8cYOYZ7jn9lvZVyKP0yryCk0dR1KNrB+wymYtENuunTvVdsKLOsiE8Rc6L8TJDzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793049; c=relaxed/simple;
	bh=8u5uZUMqhrL/gnN85tqtWF3US52t+rBo+R6AWDwO5ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUW+S8E52Z/t3fdT6ZbUiPFZIK9B10uR8oWNazPhct81cPRYWo07BYiuuItWzQlRpzDwNSwL4FapMEr0UvMshVhWPPvHd5TD2vrWCeKbDgLXdoiLO5Gsj6IeX4BEYK/wUtG6SC7PN0xtNQQ2f5xWxuFjW20I95P5WGpbWS5KZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O323CP3q; arc=none smtp.client-ip=74.125.82.42
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-139edc6bfc0so7642621c88.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782793045; x=1783397845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OjgHD+veL6Mrs93d7R3aSe1UX0mQg1cLxReyF2YhYPw=;
        b=O323CP3qFts6eay/77P5Bgbp0JoTIDQIXpTbAo5xG4OQTLtykzxJcwieKuJM0e1n/J
         4JHRHXVin4N8vfSQgj73907E9c/HawBqTLJg4mC0c571T7L6J5j/c+DJQEK1wdErE8IH
         Ahu+GHiD/KbCy2CLZFAszbcdQ29yWRq5nj+csx5CPpWcjWtxr3/UhpY/Nwz27FaisPgt
         2RaVmtSvHZQbDBZLPq/PrzIjlnVaj1aneagwCJSCLIsI8MuMtsUOBv81kAy1rZYAngIF
         axj2u3IfLqnQt7MmnKbjuCC3JLd35YjvptO7+XTYwKrmmgRMa/0cv074haxzdd8MNW5x
         GA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793045; x=1783397845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjgHD+veL6Mrs93d7R3aSe1UX0mQg1cLxReyF2YhYPw=;
        b=Bx8kXPiqtCsTYnIgxvX4+Ok8fmVDlBdWcE16gYj+HiN5KlDHE1Rxd3NwqtViDp5Fys
         ToZAljrJHH1mtgJPeQ0KT/4fAWJ0+qXC/X63E5jZFwzI/3+VWRlDdN2y6tRYHcLaTEI8
         bxWsEGMqdko/qCcaM0L5l4/Zj304zSI+g7DZOD4LK+/23VN5B3MuXiYTxIvJ9XxwHbRO
         5NIYcR69nTMJwptXMc01u4doAGTEgKBiWM6vW8Ob6v8hK+5YCw7JkxZSJ2+QAqYB91cW
         IYXuvI+JpLERJHMHFCSBCbVIoNQW1PyCZSKNyDPacr5EN5obLB2jCjdbDViSdw+W2jaK
         sP4A==
X-Forwarded-Encrypted: i=1; AFNElJ8wMaP5zEeSqkfDVsjzDZ0w8DrM65Il9QiFGvophZtpQV/ezblhQRNRXy8RjmzzMm41rmt6ymM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNJY0tqkWpzk+vT3mE91byRl9JAZow5mZvOwWzBL6VOwtF3GXE
	q89bhP/tpwtA0sYvD9iGm9P4eOQnt90mpr9QIim+AB34juXE1TnbbK6j
X-Gm-Gg: AfdE7clDhA6lolU4Z6bwD25nQPYVvZCwEloKLhWbqkfEDsvLXG5pdI4FrW91vb2mCRZ
	dw3/llgbuVhrGcbb/x1YflTUf0xVTPU0Hg7eEYbLYQ0MWjZw8LOd99e25t9wA+bCvvJdjDiWT2p
	MyAW9n5NmAs4dl+rbhEGautpHjEgEK1cUJPnimGZ0aLFwp4PQeGk3I1ecyzmjTFK2YTUenJIFzT
	AWLmJj8YhJp6IU+UvWf7YJicN+C1VEA+tVoCwVXJQGeJDuHU2+M3Hos0yThgIP1gMelSN+IYhl4
	YgosptEfT+/Z0p1gPJFuD33gJzZE1rdKrkMpYXJCidctxNCdXRb77t5jvIoUCqgiOZsUdddC0S4
	FT3Zk7xDVvPLpWfW6BxbtQZ+WNzz3fqLTE4X7Soc2ylmwLuUIwuol5QaKmiIRtx9CANPklsmwnZ
	vQqImbkAMw1VeyJsH2dfgMEMPAhtpzBDmdWaEpjIM/xzBya0oHGQE1735vcpsdLPGlokmr
X-Received: by 2002:a05:7022:fa0:b0:13b:20ad:b96a with SMTP id a92af1059eb24-13b2a1dd575mr1300904c88.50.1782793045226;
        Mon, 29 Jun 2026 21:17:25 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:bf30:8dca:9d63:c0de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2a9b425asm3891062c88.0.2026.06.29.21.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:17:24 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: castet.matthieu@free.fr,
	stf_xl@wp.pl,
	3chas3@gmail.com,
	gregkh@linuxfoundation.org
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+3d45d763d18796f97412@syzkaller.appspotmail.com
Subject: [PATCH] usb: atm: ueagle: fix use-after-free in uea_upload_pre_firmware()
Date: Tue, 30 Jun 2026 09:47:16 +0530
Message-ID: <20260630041716.97102-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302951-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:castet.matthieu@free.fr,m:stf_xl@wp.pl,m:3chas3@gmail.com,m:gregkh@linuxfoundation.org,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kartikey406@gmail.com,m:syzbot+3d45d763d18796f97412@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[free.fr,wp.pl,gmail.com,linuxfoundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,3d45d763d18796f97412];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76F296E03C9

uea_load_firmware() calls request_firmware_nowait() passing a raw
struct usb_device pointer as context, without holding a reference
to it.

If the USB device is disconnected before the firmware workqueue
fires, the usb_device and its usb_interface objects are freed while
uea_upload_pre_firmware() is still pending on the workqueue. When
the callback eventually runs, it accesses the freed memory causing
a slab-use-after-free:

  BUG: KASAN: slab-use-after-free in __intf_to_usbdev
  include/linux/usb.h:752 [inline]
  BUG: KASAN: slab-use-after-free in uea_upload_pre_firmware+0x8d/0x640
  drivers/usb/atm/ueagle-atm.c:598
  Read of size 8 at addr ffff88802b0710b8 by task kworker/0:2/1664

Fix by calling usb_get_dev() before queuing the firmware request to
pin the usb_device in memory for the lifetime of the async operation,
and usb_put_dev() in the callback once it is finished with the
pointer. On the error path where request_firmware_nowait() itself
fails, drop the reference immediately since the callback will never
fire.

Reported-by: syzbot+3d45d763d18796f97412@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3d45d763d18796f97412
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/usb/atm/ueagle-atm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index d610cdcef7d0..686cc58fb89f 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -663,6 +663,7 @@ static void uea_upload_pre_firmware(const struct firmware *fw_entry,
 	uea_err(usb, "firmware is corrupted\n");
 err:
 	release_firmware(fw_entry);
+	usb_put_dev(usb);
 }
 
 /*
@@ -693,12 +694,14 @@ static int uea_load_firmware(struct usb_device *usb, unsigned int ver)
 		break;
 	}
 
+	usb_get_dev(usb);
 	ret = request_firmware_nowait(THIS_MODULE, 1, fw_name, &usb->dev,
 					GFP_KERNEL, usb,
 					uea_upload_pre_firmware);
-	if (ret)
+	if (ret) {
 		uea_err(usb, "firmware %s is not available\n", fw_name);
-	else
+		usb_put_dev(usb);
+	} else
 		uea_info(usb, "loading firmware %s\n", fw_name);
 
 	return ret;
-- 
2.43.0


