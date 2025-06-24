Return-Path: <netdev+bounces-200550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E060AE60E1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E533A6E1B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF03C27AC34;
	Tue, 24 Jun 2025 09:31:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4CC1F5617
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757496; cv=none; b=sgI9EycQfmADe5svnhn7XXMorx2+sB3LG2KSkmu6kMBaF2S0JLWBxr43boSn4RVCy8SX7eH79rouKSWsR08F6YP63i1sjmZzhV7vHwid8eMnc6uOV+vNaBT1X25m0ZMV0db0RQYRvbl/XeGEumEaURaPhWTaDUZYdwSbQmR/+sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757496; c=relaxed/simple;
	bh=kt8byCcZZbCMivNSVPKd3GdKp+/tIwTtsD9niFMUAsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NbpqxarwGcOd/07jUnxBbpqG2a87BUJFW+GQQtTJw67XNkCaCPKg3QZlXDi2Esl/MiymYpR1/3mbKffMlIs6C+1J0CsPom8khkb46B1B+Jy02l6uQfMG7tGtLLdBcF3zg+XTYB86MUjpAb+vajven5y7ldKSwcHvFO2DP3DRVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz5t1750757436t7a5b148a
X-QQ-Originating-IP: K30ls6kgrAqnN8oNppNH+Mo4wyOH1a7o76K+8YGVcaU=
Received: from w-MS-7E16.trustnetic.com ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Jun 2025 17:30:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12762027429260773827
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: txgbe: fix the issue of TX failture
Date: Tue, 24 Jun 2025 17:30:21 +0800
Message-ID: <9E4DB1BA09214DE5+20250624093021.273868-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ORVvGvb3vGOHN6r7S3HUHJkwu6PP/5cxOYI77yyQKX5u0KRo78timL9j
	/FaRWwgV0fuOCW599juuaFSyMGy8D0MYeKx81uboOSDvvy2vySkbboC0yk80Y8r7ffYxv0g
	q+6tkWZzrawC4zdkiqOKOTDdXnnG06CN3hnBUT8OJt/l7MmGFVcB9RT3S753SqKvpjdvtdJ
	JcqCTCpcqdPjytm2oTraXkNAqEnN4aqcHBcuAPAguH3ImoS0Iu2m1K/Jt9yzI3YfAVepE2y
	+mnICPApsP5dsZzvPFQEPIPSIcymnFVz5o79MyRFTsvPNiPTs9zyMs+FBD70qHI8k9NXEZM
	PE7flP7Np5IaDzMMFWuV6LD3n31GpCOcWVKnF9q9H9Gc/lLgpGm9ngRip4MYkZJP1MnXD5R
	E/jaROEXXvZJtpT4LjTls+CbQRkbj0fROYHgVDxOcr3n1rZkMZLumMCw0Hp3tgkhNgg2DPr
	Rf3aDpEHyq74ZRzHa/BPrcfsgWYR6CKRYLYXw0Brd8EosojfRJt7zXJKULl0iNjiKPaiv/1
	8SzeBRop9yU3JwL/h0EbqDc30c5yynpRK8BEmSC/3zAS1PawF88kTiwGmZSi6cCRKvugYRy
	uysBIlHO1YE/9H7uOiVnvT7fJXHXcTHwEawndBw25tS9/Y8ZAcIUPadAQnKnKUoDngbgb/2
	DSL1JVvhXF84qpQ3vIyIKMDWdeZCJ4+gD7YAI1CAiil2/kYTE8OMlpPTAHbSdJT4yaSvQUj
	d/eFttHfZAkAAW80S5rD0D/BTF76SrIACgFTCVu11ESF0NRk4pHDa6iLqSpVBV5g09SHtcY
	35MiU5f9FxG7Q0P4Sf8gkZ4NBRvvWzdpeXeJ5HRmwYDzdJOOwi1gdXBa1TRXBq93PCCrDR4
	zvyLZtBhIc9R6jZZoOkKNmJetuW+kc8IHeXzUy2k0RdCYtdQR4Rr1pEjE7htXmoHjpjZNtf
	myDto9rMUJZZWuDUaB+M0sPVjXuRamlaBomsOXujm/3StKTnkvG4EDXp7g05EGdB3sSx4LR
	zA0sy08fkiDMAaQR3pEBLZpychSO6hTA1jkFBMs+IR+EIZkcnLUytWRPH93wrTumQ+FPkN7
	g==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

There is a occasional problem that ping is failed between AML devices.
That is because the manual enablement of the security Tx path on the
hardware is missing, no matter what its previous state was.

Fixes: 6f8b4c01a8cd ("net: txgbe: Implement PHYLINK for AML 25G/10G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 7dbcf41750c1..dc87ccad9652 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -294,6 +294,7 @@ static void txgbe_mac_link_up_aml(struct phylink_config *config,
 	wx_fc_enable(wx, tx_pause, rx_pause);
 
 	txgbe_reconfig_mac(wx);
+	txgbe_enable_sec_tx_path(wx);
 
 	txcfg = rd32(wx, TXGBE_AML_MAC_TX_CFG);
 	txcfg &= ~TXGBE_AML_MAC_TX_CFG_SPEED_MASK;
-- 
2.48.1


