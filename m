Return-Path: <netdev+bounces-189950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBC8AB494E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B247E463750
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5A41A23BA;
	Tue, 13 May 2025 02:12:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF41C84AF
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102327; cv=none; b=awV4+E4ayDwPZzKbei/Uz02raMgq7o+V+a7LRR/YKQojeSXPtpILCODQ0vXAUliwoYu8+Yhb3/YWtrE+NeDNBfqGRE4pgFaXqiryN2YtDiEwxxjxCA5Ro1xAMtVIwXBKNpCr3DEJAdiUYpqX57WimsGajVa5zdwSwXzNMgqSsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102327; c=relaxed/simple;
	bh=YwTxb2eb41jyC2ntDiFjf9GYy2JK5YJeH7Dr6PHfyuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIj5pqU6VnkiwFyTQuiJfrmDjgyNc75B6tzNl97zqb0ww6FUMQMAycSshFGooY0gn4hGP4ai1MBBd7OwEPa2AZjkkGDluTOqquIX+DjPaTj+iZmURhG29bhk1DPIua3S6dBuGWtC6Obepf0HCZpExKR14kH6HEdGV8uszhzovu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz20t1747102231t638f7d98
X-QQ-Originating-IP: NzqX8u+SUXOtsgxN//R/yT8Prv586r026Q465RX9/gw=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 May 2025 10:10:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4340695544214056807
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
Subject: [PATCH net v2 3/3] net: libwx: Fix FW mailbox unknown command
Date: Tue, 13 May 2025 10:10:09 +0800
Message-ID: <64DBB705D35A0016+20250513021009.145708-4-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NN51gi9eLBwaQhfj9uU+OVR9JARpemjbhuc7cfO/Va7XxSf3I8ephsgt
	+OFbvQcx1sPXkbNTQgM0gLHK5iplrktX7hFMgfNY3GlgOlrtfWPUJ2oqLT+RNdna6bB79tO
	FY3F4rfNrU7R794FCvaCnKqeMmPwY//qwtBMfIif+wSM6ceRts6n9tnbwPt4g5QuT7/0o6t
	hu/YHfOgrbYcHOrMWmQSMejOf1fg7qp/N1QJR9zFr3Sgbsn3JPVgdSPPqP8yYxzhA1epAKo
	GcAwF9HH6wMG/vKH8uXoUts+0Chz9nf4pW1wufBt7z9SHf5r09JtJ7kmDiz28W1Cv8PJAua
	P8pUu3LnUNqo0Ll/pNGg24XRaus8q0Bcr2cKq6Al4EQWrS3QrIdsSn4wFh/73FXVO53HPd6
	SLiSZAu8tmIFbHgDVxy72WKrrlQ9NSx/Yq6evwgW+Fi0Ba75Hoqdb0XmNs9qGxYANIN5I3I
	PjC8nczUO0/9oPd43JX3fO30f8s+ORMa1j5jUkmDQ9O3ilUWhaeQNTTIVzuagmOoAVSrDG7
	afY1B38vUqwBBKWtw3oJX3WbyEJHzmsV1uasN8sR9RnwOS51SKb34K0F0lnj1kKJ3SSQWbw
	s9SsoYNI9f8Wljrz2FJzW3RhDiHptSjGB0lSvlUhFx5mD/6wDu6v0FCtrpJeRMkuY8z9fgj
	ix4e5wI4ctVZQi4v1c4kuqPWbUhcyXVL3GJg+aNHa7Inuvc2pucHGU9pdbV30PLNGGNfwsu
	3n/7kG1Vd8ZnFk270XW/NKQh6csy3+ng61+sgJ+i0DTqV3fR9nimREaRiUxtr3a7sj1HVFX
	kpaJV2w65IVx3Xbxz9C36DsquobImGOKfdFY6KynPzePNXwuERissgNl76qwA/TDJqxbwOI
	yuNK9f8HW+rqQEAMTYBg6NBfa/xjXOJhxcsZ+ZYK3OQhJhfaxxpSSV+ZgYWm4j8EC2YIGi7
	XN16h0tMbZ6SQ1OINsbLLfcOvlpjjnmjphYfHdTwDVaO3CBdIJ6hdZ+DNaBuf+tkAT2pyvo
	cx5wn2ppIYdIXI/58lxWV7y5iYb4k=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

For the new SW-FW interaction, missing the error return if there is an
unknown command. It causes the driver to mistakenly believe that the
interaction is complete. This problem occurs when new driver is paired
with old firmware, which does not support the new mailbox commands.

Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index ccdc57e9b0d5..490d34233d38 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -442,6 +442,12 @@ static int wx_host_interface_command_r(struct wx *wx, u32 *buffer,
 		goto rel_out;
 	}
 
+	if (hdr->cmd_or_resp.ret_status == 0x80) {
+		wx_err(wx, "Unknown FW command: 0x%x\n", send_cmd);
+		err = -EINVAL;
+		goto rel_out;
+	}
+
 	/* expect no reply from FW then return */
 	if (!return_data)
 		goto rel_out;
-- 
2.48.1


