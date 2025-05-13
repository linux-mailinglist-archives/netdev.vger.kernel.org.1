Return-Path: <netdev+bounces-189952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3DAB4955
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E77D867947
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6271A1B4254;
	Tue, 13 May 2025 02:12:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E131B0439
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102342; cv=none; b=qhlj/bVmUDYtaAEkPxQGncW5zSLovGuuAhyaQUm/dBRAFr4n7/zC/ssUoD1rBK52EgBbmaQ0VxMU6s6ye4ueMhkFWRduVtRTwo5x4bVnBY0MXB4zPfs1XUh9GuhuHrIbSc1D7okYvmctd/tgVuLV8IuonbzEc9vmwU36/9vEcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102342; c=relaxed/simple;
	bh=f4E1SYxjr1Ol0Rp2E/RHPZ9LGu9Ka+5k2e8U7fOY+Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2CDpRiyFr5Qz5phSG9OzDwk0Jhluxrhvc/Z/FYL2RdqpydD2i9UBMDhDFqAanryNAbw6eKuWWe1LXE+17jxSKKtkR0t+8ALTuVH/37K2fMM9FBwYe6dBFSTwUd0zwWTJnNIlWAun0UQEXhz5AXPcAdDTk8xexcOrNK+jWT7Piw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz20t1747102228t9e05c4c9
X-QQ-Originating-IP: bMFbdtiICzEL0zNzkiGYJZueN/Uz5DSIFzyr78dyM6Y=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 May 2025 10:10:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6140426146961079946
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	rmk+kernel@armlinux.org.uk,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 2/3] net: libwx: Fix FW mailbox reply timeout
Date: Tue, 13 May 2025 10:10:08 +0800
Message-ID: <5D5BDE3EA501BDB8+20250513021009.145708-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250513021009.145708-1-jiawenwu@trustnetic.com>
References: <20250513021009.145708-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NSEFX6u+4l+KjDmLpH1amd6gzWXNrKk+JJ93NyqMdvLVMsO4TrfwUnt+
	gjteta4uKNXeefrco39z0IboRj1Ip8NVhsMMjRAYPCWNOxau71ZGUlkF7SVf18U0tRnF5VM
	57dH314NkE/iTvSMtjS+T35LZs2EkaSNt0xN3DnghewTyu5mCk8YOjzcoYtJmBUDdDH84AW
	UD+Bm430ZrZ72jYroAD/p6cpEwCiIo5erSwDxinc/SmZ9GxuyiDU4D2qyTiRFwZd9xOBO/b
	469WrkiJLCfmavXQmGvVn8utpH3NtKf8RrRFHpt7FoHoTfIKrkHds5Piv6Si53Y/CuhPJyy
	5FKwZWbdLcPHA+uCPxhlNizh65jFcBYfhe9f8dagfZ125b7/Qd+c7dktgUP2OSCQc4q2sZZ
	7fcAm/oZwpVUl+5i8n+lZiF9B5L40trn1ZPRYkJKx+FxcxsndjUjFCz1ga+dxrfpiXcxJVS
	d1FIfvyM6qZ2NOOr0prGSLDV0UcJ1c5QnC8o1elF2XBAtkIUHPCvZQV0KGxuu6xEY4aP0q7
	XyaGMdcpvCYVey6gEe32oaexhqG3a3x52vaQlno27hbebbOvLrJONsAOtmdDXS3qKCVptxW
	lWXluvMCxEMPWO8+N5wFbSmgVY+fRQOComEpKyPljmKHZ+4khqUxhDp06uEOk0w/8gdW/xv
	+ApKUGYI6j3TkcNmRwBGKAbnoSBaB7M0Shz/w1EHalCfSSLtQFzZOFcxZd57CQXBF34oQOF
	ggisLOCLvLaoUcgoIPscAuCtzBqc0YPhclYg0Lu7BOewm/rHHManJGMVvOs7GC7G0ACUozn
	z1gEgJSr2sw0OC/VMd61vrCeW8nK7v2G7X1IJWEAxjBTG684yMl2ApxavPj8X3T1/e+FDM+
	m6YxVpq5Zpi7NkF8R8wasmsH2lxRcacZw00LoZbGQfAWOJBCAzVi0dF3wdPbGYAfP96cF4s
	H6HHMuWFHryoutuWzRXhWvyY+9qDa+sTxCIhyIp2LGpFZQOSKjKZNJG46vGRll49XdE0rvM
	SY9oGH9Be1JaTzi+d6
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

For the new SW-FW interaction, the timeout waiting for the firmware to
return is too short. So that some mailbox commands cannot be completed.
Use the 'timeout' parameter instead of fixed timeout value for flexible
configuration.

Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index aed45abafb1b..ccdc57e9b0d5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -434,8 +434,8 @@ static int wx_host_interface_command_r(struct wx *wx, u32 *buffer,
 	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, WX_SW2FW_MBOX_CMD_VLD);
 
 	/* polling reply from FW */
-	err = read_poll_timeout(wx_poll_fw_reply, reply, reply, 1000, 50000,
-				true, wx, buffer, send_cmd);
+	err = read_poll_timeout(wx_poll_fw_reply, reply, reply, 2000,
+				timeout * 1000, true, wx, buffer, send_cmd);
 	if (err) {
 		wx_err(wx, "Polling from FW messages timeout, cmd: 0x%x, index: %d\n",
 		       send_cmd, wx->swfw_index);
-- 
2.48.1


