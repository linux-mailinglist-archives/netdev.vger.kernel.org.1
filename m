Return-Path: <netdev+bounces-189176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDA7AB0FC5
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D1F7BB55E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD02F28E5E0;
	Fri,  9 May 2025 10:01:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C95222576
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784888; cv=none; b=stlRv4Dmq9z3CLcgkBzsUAJ4gFMpgtPcH6NtJj70rYGpnoBqVdBPawsfSiTodzyRXc2mTST0tMytbHm2RzRoklsMC7iOPcDnuDXOdQ2h/TvRP1S3zMlurT9+pABHc/bIlKVGSIRan9GxMIKJY5E2pcXINFyiokpcUZOtROOU+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784888; c=relaxed/simple;
	bh=If0FUMeJ4QjZaMTOvxJveyRW8VTBOYof/6sdK2OIG6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rODpUJATQse1ib0UwFk6ZJB+RpsvAHbyb95n49axECVejnB/EA0A48v+N9eFC0a42iw+XGgFOefCqKgbVCkXeJFxv+FM5/CfKcz7Mv1FhlIdmaoDLTiZYNxboKJ1j0yM4+dS4Fm70+bYu8/0qKQM/sfEMxuDXHv0R74ylKN2miQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1746784826tcb694605
X-QQ-Originating-IP: 9eurIngiXfqvZwjEWR41ATiDPHidNcQV2pwgYiqQgcw=
Received: from w-MS-7E16.trustnetic.com ( [122.233.173.186])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 18:00:25 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9941766595422087527
EX-QQ-RecipientCnt: 8
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net 2/2] net: libwx: Fix firmware interaction failure
Date: Fri,  9 May 2025 18:00:03 +0800
Message-ID: <F2122F5E9DA92C07+20250509100003.22361-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250509100003.22361-1-jiawenwu@trustnetic.com>
References: <20250509100003.22361-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NIdHI9sZK12ObWIc8kvX9WEuKj1CjWTPHu5Z54q8N8WiQm9pxBC2HgIN
	KixKTyU16xI69qf6GM94kBWIdyaUtCKMX4ycFLXuxy6+dVZPl6v0/Udt8x1VXSI3bgGf2WV
	FlVPr9uJg1AX+JQEqenEBK2edNR/U2CjD+c7ZgQ4c3H6E2c2wU9g15iS7oJf+VN27qMvSCd
	UPj6Bp6YKanalVY467Hl9Ml+ktUgmVvUCdpvA91h03fGPpZv11hjpulhuKRk85NDEZrgLzz
	2vD/mwFw1xKP9l2NLJmiOg6HkMSPPCYtHHZrtmES1XfwuK6q+2woFjmnhDh+QFz/d4usxMm
	fyb7eBAl7Unzq1DEqg/jf1ffpM7inJC9ZXnhH5O3zSTux/f0tqjtOfga0QmZ8hGdto8mgR1
	qYpYlw/NUMZ0hlf7IVT6cuDhspcblhlyUb06EdeBRbQWfQSYrVrHN3Dz1n/IffuXEwlfAK2
	e9rKrPVU7ptO/vUK7Q7DyvRhk3ROHk7NKnXSuvioYul6yHGcBzugh/3eNRuSiHOO3nA2swJ
	gZzMBiogA0HLwhcVpT+Kgqrr7wt7DVUMjkSiIT34epzP4ZNxe0UXtj+04kIf7FdzX4CejTu
	RYtyShw+ZICQExto5SSYm7EDM6Im5ycqziYT/lH8A5BCfJGwvkhkGN3vETl1fJO4Cj5FE3k
	BLCiIr3wmCZronwr16M7PGlAjL9cWJGaiSj63Sj0pLsnylOyjjytbfQl/ZuIeYKMuOT6OpW
	2desahoiCdVa/tvePu7nhv50eZQSC+nE88Y/y1LcWKNEwtHSt7WqvdEjpzhVMkTHQYJwaCD
	ZPiM9yjfEMO3TmBLA+JkxCeVqCdd4atz+NDc24j+Npw1bJxXlBuMfbKEcn9HPRlHwgIzMmg
	TxVeBcLehuj6pYxKygxQoXnELQ/xWkSax0OKdZNkjDtYCeBfhiaixT6YjOh8eFHLbflN+Nb
	craY4Nr88n6PoYcQV3ZNp2RgL/m8OKHSkoX5iZEP+AMLkgdAE+whWLabB1CaXJsZRoTiMKT
	gSsSHI/9l7CMF/+RL3wbP7TdwZNbXi0Vk1Y6NrHw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

There are two issues that need to be fixed on the new SW-FW interaction.

The timeout waiting for the firmware to return is too short. So that
some mailbox commands cannot be completed. Use the 'timeout' parameter
instead of fixed timeout value for flexible configuration.

Missing the error return if there is an unknown command. It causes the
driver to mistakenly believe that the interaction is complete. This
problem occurs when new driver is paired with old firmware, which does
not support the new mailbox commands.

Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 3c3aa5f4ebbf..de06467898de 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -435,7 +435,7 @@ static int wx_host_interface_command_r(struct wx *wx, u32 *buffer,
 	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, WX_SW2FW_MBOX_CMD_VLD);
 
 	/* polling reply from FW */
-	err = read_poll_timeout(wx_poll_fw_reply, reply, reply, 1000, 50000,
+	err = read_poll_timeout(wx_poll_fw_reply, reply, reply, 2000, timeout * 1000,
 				true, wx, buffer, send_cmd);
 	if (err) {
 		wx_err(wx, "Polling from FW messages timeout, cmd: 0x%x, index: %d\n",
@@ -443,6 +443,12 @@ static int wx_host_interface_command_r(struct wx *wx, u32 *buffer,
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


