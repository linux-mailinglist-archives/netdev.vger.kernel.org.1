Return-Path: <netdev+bounces-154918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC652A0055E
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971CA16117C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884641C5F34;
	Fri,  3 Jan 2025 07:51:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95901C5F32
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735890665; cv=none; b=RqoBddpzPVl7tPx6S4+jwXni5TaeuAkoLOEdcKAD5LoUFL2oD4UFKiNfbOvZcCMBPO/K+w2Xs0MTlsQqeG3ViLw/7crKVSXKqD5KeuzDHYvjbApKzkalcoNjXZB8m1GYYrOPjPQCgN0myMTUOtVKqMGySRxRcM/JzP3xgehLDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735890665; c=relaxed/simple;
	bh=+WdLCJyF0m8zdh2AysDrsxeJJJZbDUwwwh8KfyRcRAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t0OfAFEehz+0SkI8upxBOR2AOQqy1KjBZIjyi/yNOJK0InKS1qyI0OhDAwqk7v3ROIBBCrwOvZ6Ef+S5Ky8Zs4KYPXHE6wwPvWodzh9g83V3rfZkXpGnWi6Jp1WQVO472sVlr0GSVpzFH0jmSe/vsU0XijTHw8t9qRtBj5xuufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz3t1735890549tqaemu1
X-QQ-Originating-IP: GXy1kIS23LYrMwflE0XRTtnbZtfln2G96oQMS2LckA8=
Received: from wxdbg.localdomain.com ( [125.118.30.165])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 03 Jan 2025 15:49:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7879358710016601576
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
Subject: [PATCH net v2] net: libwx: fix firmware mailbox abnormal return
Date: Fri,  3 Jan 2025 16:10:13 +0800
Message-Id: <20250103081013.1995939-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OW3qjH3bC/TA6pvUYVInmUABMC6wugI+10FOoLVOGn7DAHOtCa9jPBjW
	3ralBHipjD+yAUxf0SgAZZjwSIqZ144TgtOJJ9MuQcgwFl5BMTYU0Y6i/J6odw1DUMAMYLi
	/sMCD0zjdjYLShhZVcyz57VhejH8n+V4UK0tc/1GdgVuSbp/8+TiH3tOVlp0UjgjygVzSde
	5UQXkAQIMO9u9YjaG5x32NrvBD10UI2lfy+THSbMWUthIK7gHQyykywARw4vFdlqiix8Ip7
	m0DbboyOiUrZPVvgspeISlk7q1/VAEqgYKR1JubaX7/+acQSVg8GCTfjOlhgf2bGsz9gzJF
	wJJQz9BMd9t8UI9K824nZI6CpQ6eskfMvOqyAdr1bpNj00W/QxrVp41S+p/gZDRQLCDc7it
	arhW0QUGU57/x1TBemb25npL0DjFXAcXHVDEV+SIUa/3b8le2jtj4Dv/wxVW37KlpDnVKm8
	/FnF3RrSAOebVkgabfhQPzh9KmyX2XjY5O0Mqi73tmX9hLoOFXz8nxZEw297GSFz1wi/oay
	3YCjJHGIq5jkIJZzi8mkqCSPSDJprC7xGLrvA0gx48KNN/e7E8F6eCjOVr7pukiEiOXBvUr
	F9VmOaY+LaBDjKce8mmjak6P/iAprXyTVT1SLhkHQQndgaQDjD1ZVqF8zFyUv/bWHBZXps6
	mytA4QBc3uk2u1DNpDbYINuLW/7Y4TaE6sdm8rbbKaLSNQ+swc2QZ8sU7s3+lXY35DNcQRQ
	sEXuXCnEBnMkDCXt6OfRrW1S6IGYUYFUv1S75lQkQp71KsOewOHveLxdN8IU0VGWH7GH25b
	W+LM64amc/jvI0oblUcwQz83FWntfIFDYTzoHP6L1R7op2SPWksha1Zsb+2xzLjD5xNLIBM
	dOHFB+EFH+HNQ/CYCHfY4B74MChvXfQthB3Ectt52hytRlMH5xHbCs3G6N9bATgm+y3q7Mm
	jiVJaK8yJNDdqo0Q146RO7DVA2HNZsbdrPPM3qSBH1WA+CeBsUIGrayH/l7UomCViL04=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

The existing SW-FW interaction flow on the driver is wrong. Follow this
wrong flow, driver would never return error if there is a unknown command.
Since firmware writes back 'firmware ready' and 'unknown command' in the
mailbox message if there is an unknown command sent by driver. So reading
'firmware ready' does not timeout. Then driver would mistakenly believe
that the interaction has completed successfully.

It tends to happen with the use of custom firmware. Move the check for
'unknown command' out of the poll timeout for 'firmware ready'. And adjust
the debug log so that mailbox messages are always printed when commands
timeout.

Fixes: 1efa9bfe58c5 ("net: libwx: Implement interaction with firmware")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
Changes in v2:
- Detail the issue in the commit log.
- Change log level from debug to error to print unknown cmd.
- Always return an error when cmd timed out.
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 24 ++++++++++------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 1bf9c38e4125..deaf670c160e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -334,27 +334,25 @@ int wx_host_interface_command(struct wx *wx, u32 *buffer,
 	status = read_poll_timeout(rd32, hicr, hicr & WX_MNG_MBOX_CTL_FWRDY, 1000,
 				   timeout * 1000, false, wx, WX_MNG_MBOX_CTL);
 
+	buf[0] = rd32(wx, WX_MNG_MBOX);
+	if ((buf[0] & 0xff0000) >> 16 == 0x80) {
+		wx_err(wx, "Unknown FW command: 0x%x\n", buffer[0] & 0xff);
+		status = -EINVAL;
+		goto rel_out;
+	}
+
 	/* Check command completion */
 	if (status) {
-		wx_dbg(wx, "Command has failed with no status valid.\n");
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
+		wx_err(wx, "Command has failed with no status valid.\n");
 		wx_dbg(wx, "write value:\n");
 		for (i = 0; i < dword_len; i++)
 			wx_dbg(wx, "%x ", buffer[i]);
 		wx_dbg(wx, "read value:\n");
 		for (i = 0; i < dword_len; i++)
 			wx_dbg(wx, "%x ", buf[i]);
+		wx_dbg(wx, "\ncheck: %x %x\n", buffer[0] & 0xff, ~buf[0] >> 24);
+
+		goto rel_out;
 	}
 
 	if (!return_data)
-- 
2.27.0


