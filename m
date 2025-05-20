Return-Path: <netdev+bounces-191732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42632ABCF85
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD6B179C98
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 06:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2295125CC50;
	Tue, 20 May 2025 06:40:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967925D1E0
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747723204; cv=none; b=Bi0LFJIswkFgt1C15i9HBJvWXzfop9ZIbZhPa1qe3sIhQffOtgetDHWNnuurIIyuxT3wS3LlqVTr3kMoRir+UFvWTVw3p+IdSmNqNQWNcBkUvo9BrafGr/pwr5DTIz1/aPLYvq7O89nc6xK0yekuYiTKEMMISOLHb/5j0NDlV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747723204; c=relaxed/simple;
	bh=RHh3VmuXOPSPt4AlZbzxW6B7ADyopHMpFY7vh8aey1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gx6CC/z+x8g6WGslEs6kPDMD9ZNR+eIDlOUvoT+0u1E25kA6gW9xKKhDiPYce9WEtVmfSekPVbYLzFEPbJeJs2QY9rfccO7puKIfNUsaixdqoYpMAwuQCdrsslR58bF5pKG0XlKojIacj54oe4xhm78a0ISR6RlWIviBYAUlCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz16t1747723154tb4109c1d
X-QQ-Originating-IP: kpXAUvc4rBUQGVxxo9pcJEHeJvhAKhR0IaB+8ADXL9Q=
Received: from w-MS-7E16.trustnetic.com ( [125.119.67.87])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 20 May 2025 14:39:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1667878887237027694
EX-QQ-RecipientCnt: 8
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	mengyuanlou@net-swift.com
Cc: Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 1/2] net: libwx: Fix statistics of multicast packets
Date: Tue, 20 May 2025 14:38:59 +0800
Message-ID: <0250972BC2F238FA+20250520063900.37370-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MCg5+ArSTX6c55l3cw+X0NHpZzCOLvXNdSC1Mj85vsh4jt2xiNrxpIO5
	8GHsz5djWYhA5EpdFxfwstcsa48yLShu+ARTOUSpGJmlw/42NQSzEr8i9kah+CAi9+tn01j
	EmU42y/P6lDAdVoYL6eTxo/Ab1z0b5lU08a4xhESPlMErFwmCoQcmU8Nay0M4FyCP1TK8Zp
	o47/VaJ34JvfcPop1TazqFdsKGDYYyU7dvQuQztCg5GANSSyxTnAfYCPCUYlJfMuoOClreQ
	HBfxT8znp8EmRLGTRjm4i8pD5beaJwy6IfMjP8RYDrWIdzY3aMoRT7GRd/hEVBWpADofS6Z
	TNy2fGGEiVp2MBIVIIOAfcvipnBRwM/TJd2eRQzR6dYfJ8Q3W+EW0/hddq3sSJd+2LioaaS
	aKYx/V0+L6CorqEN6nrXjt/w+/Np7kOvgH0q4tT75sgkf0Lgfq2TXpQVNZYJynvcDu8qVw+
	d5ugSSLHNSWl58paXlFKWE+GoZOmdckzXUNGjT+ZFhJL9/x5/BWOKCB2kls6SleeXoVKy5+
	qG4dO75stXCRF8o2E1RnD36FG4TZvlIhUJ+Q5LmUv7/ywW3gbqRLsODlWq2cAP3UVLyzSKo
	XrIr9Ug7wnbkVagUakTx9IpmhcKfx35b+sKQOhxP9LJuUG08ivo0xTXj5BLRQyv9vZsti8j
	VhdGZXwBA0U5G7tZkG311FN4CwkJyieryY6818lWXc0yXrR7M9etiFKjh+5H9VZQsX8+KrH
	xPXR9Cj3P3ogHbQ0PAb1oCfgvngOHoSIO4ceXQG4FoAckj2qtZd0e90MMp3FwEpg9eZ0p3v
	I7MK4v5Sh4b9GzElVH9LHk+BJHEbAnga8NogUrpOANTWIYNCzaNXIweOsHI8N60QXDFfrck
	MotSwMtB42tkhF7vSYSfspqTy/mwuMMXAro6LYyHeCTKminTje0FWSZCyBdSdg5pyPIUhLP
	goz5Ei9MTQ1UsIsUfAHxYgJoBLRiup0z2r60aw214APBgQVAcGrKerKoWkLiu1anVcAHEiY
	zqWO2OrNhEjF/4q3UsVZwd3/gKctA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

When SR-IOV is enabled, the number of multicast packets is mistakenly
counted starting from queue 0. It would be a wrong count that includes
the packets received on VF. Fix it to count from the correct offset.

Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 143cc1088eea..17ff3c21539a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2792,7 +2792,8 @@ void wx_update_stats(struct wx *wx)
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
 
-	for (i = 0; i < wx->mac.max_rx_queues; i++)
+	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
+	     i < wx->mac.max_rx_queues; i++)
 		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
 }
 EXPORT_SYMBOL(wx_update_stats);
-- 
2.48.1


