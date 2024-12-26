Return-Path: <netdev+bounces-154274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E8E9FC7BE
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 03:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF477A120F
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 02:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA481E507;
	Thu, 26 Dec 2024 02:58:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1BC133
	for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 02:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735181922; cv=none; b=cEZvJ1oncSOjRxqOmJ264+e7Zr/BvN2+aKrpFpO8dsKgS1EXRyIshPQYJuDNnw7WE6DUFbFurwHcT0uKMj/4Y2Wu7PWDrPhs3PlUbIzteljjOA6l1KDu+7YYRMUOj2zSDLm7kMcCG+jJyBDFPYuQbN/g8yAj+PhpmVMpjtJfrYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735181922; c=relaxed/simple;
	bh=FdbddyW9EcF6ERtma4qc/cqrkATrsZ0n5S3x9AMNszQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PRVwhhCx/nYQD+Koj45Jgy2yUK+Fo8HBjb6lnYYUu32jwV0QgIO1hrdBHaxlpstc8ekhbdCTB9TgPYpC1sUWj5I8vah9HZa1i4sM9nbLOP/MLGHV6ESgHSKx1s9NRU7Dacs1k6xM9UI6bZOcc1t7L72WpU3vJa5uUrTHQ66c8RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz5t1735181809tsf8lax
X-QQ-Originating-IP: S+tyynb6c0RbDyQr8/fxAmfwkMWhxh1wYSy+6tUPF0A=
Received: from wxdbg.localdomain.com ( [36.24.116.64])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Dec 2024 10:56:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1231702645064501310
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: libwx: fix firmware mailbox abnormal return
Date: Thu, 26 Dec 2024 11:18:10 +0800
Message-Id: <20241226031810.1872443-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M0vknKB9I1DpFGhJJ2sfhaF/cMxPkfJ2Z4k8VwzohGEwempxiwPrQgcT
	Ze+bA/MuzjsBBld0jDynSvTudGSoSeiiv4/7EnnTgmM41L/akme0YB3o5EQXKkGbPF0NzDJ
	zfmnVsYNLUbE9ize3EoZbh09Ahl4v6t/2pbsFVYiW2cxvYS//VyDtN3quO/1LldJjGn7cfA
	2jDWacJxbS/BbVRntwqfrxBwX8GDK7QcanSvCXyIK3MGmdztO1vNlZS1cPTLoKcng7wP1kR
	QB0POLv/ex4CT41J4QO69Z4LQvUaf+xrGr7loei582eaHLiO9xsKEJh1qwLbLPt7vKXvl4m
	UiV71Gtqf1+s8Urw8PsHjNhM4BpNeyKVf0u6i1nkvpy1gLt+MBGerYRpotoxUemajL/uBwb
	tJ3D0qgvQe/YzVukKRArZMbz6euzUnlCBOEKPibfQrwpHwGyP79jni2ignsFnN4ZvSjWfWh
	YINeYQLLaNmM5JJINvWnnOsZm27k/CooDseZxps7PkZShAEmQiWcmNJhkA+xjy/FfokjQJu
	bwuIuMvqmga5K/SoyTPvQMHEv7s9Xe0FRH74nPXQg+nG0BGdOCIE5cjVg6F//CY0hST8rmo
	wYZ/H+VCU3ehgPixMr1Lz0i7uhfNLkqE0gwOQcxKjuwx0zpEGxBmPN0mD9rgROnCYiI4P8y
	Q1ucM1WQojgK1qkOtM0KDeO/3WAZbYftaC0QFVRlrfR4fB7Cf46bpYzZ9s4acVukWwOybCH
	XNq+Q10QSPH3t8o8Ri0RHWOn0mq0fq2hoL7eUdESTB8OCeu2phqSme6+ovTgpjP6gnHMkd7
	i0WAUoophDNEMiAbIAKOSa/KbzoAh+htLPlPow1z7ZnspziTSc5yf7iAZH9kObmStCuDAKU
	Mv4oX8QsJ05QhmyKYq6DTNLL7tZ+Iaso4LGJe9jaacCJB3efO9WHvgDzx0SYco0IPMV2gno
	K2hwOKlHv7D1X7f6EVSa98RvsSu4RI0oiy2ELQHF1BkcY9A==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Firmware writes back 'firmware ready' and 'unknown command' in the mailbox
message if there is an unknown command sent by driver. It tends to happen
with the use of custom firmware. So move the check for 'unknown command'
out of the poll timeout for 'firmware ready'. And adjust the debug log so
that mailbox messages are always printed when commands timeout.

Fixes: 1efa9bfe58c5 ("net: libwx: Implement interaction with firmware")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 1bf9c38e4125..7059e0100c7c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -334,27 +334,25 @@ int wx_host_interface_command(struct wx *wx, u32 *buffer,
 	status = read_poll_timeout(rd32, hicr, hicr & WX_MNG_MBOX_CTL_FWRDY, 1000,
 				   timeout * 1000, false, wx, WX_MNG_MBOX_CTL);
 
+	buf[0] = rd32(wx, WX_MNG_MBOX);
+	if ((buf[0] & 0xff0000) >> 16 == 0x80) {
+		wx_dbg(wx, "It's unknown cmd.\n");
+		status = -EINVAL;
+		goto rel_out;
+	}
+
 	/* Check command completion */
 	if (status) {
 		wx_dbg(wx, "Command has failed with no status valid.\n");
-
-		buf[0] = rd32(wx, WX_MNG_MBOX);
-		if ((buffer[0] & 0xff) != (~buf[0] >> 24)) {
-			status = -EINVAL;
-			goto rel_out;
-		}
-		if ((buf[0] & 0xff0000) >> 16 == 0x80) {
-			wx_dbg(wx, "It's unknown cmd.\n");
-			status = -EINVAL;
-			goto rel_out;
-		}
-
 		wx_dbg(wx, "write value:\n");
 		for (i = 0; i < dword_len; i++)
 			wx_dbg(wx, "%x ", buffer[i]);
 		wx_dbg(wx, "read value:\n");
 		for (i = 0; i < dword_len; i++)
 			wx_dbg(wx, "%x ", buf[i]);
+		wx_dbg(wx, "check: %x %x\n", buffer[0] & 0xff, ~buf[0] >> 24);
+		if ((buffer[0] & 0xff) != (~buf[0] >> 24))
+			goto rel_out;
 	}
 
 	if (!return_data)
-- 
2.27.0


