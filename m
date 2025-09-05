Return-Path: <netdev+bounces-220212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13244B44BEF
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C945A33B6
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15B1FFC49;
	Fri,  5 Sep 2025 02:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nBWNsNyy"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAEA1487F6;
	Fri,  5 Sep 2025 02:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040953; cv=none; b=X47FI29oP/Q77eTU6yaML04zEKOWWGjOW3K2yU8N6Ojo9HqE6YTuPs2BanBvgand0aPrm/wqgee7d9k+R8EWqqObXsP6Td8jSIyxEOoTo75uh88eg/J3OmL90wDOAzAFwR86DnZgvYDHJ3jBJ9zd4TxAVhxFqv7FayivrvlMDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040953; c=relaxed/simple;
	bh=m0NchfMU+6mv+FH2Live2SrPoEDdZN1S9Mkgu9lUtvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7A9N7durXuLdIhmHj1bPR+TLSSPgnLKTNC+9Oy/ytLeYAWf46ksYTEOklOiJabQP7nkbwf/e8tMjO/mNrZzSWR0z1Vms2PR+hjfNy3RmknGVK5mySZFdjR41XLqs60Qz5Iq53leCgBYc6yTSiuHGlolZPaCYRPcVTJeMPu/qqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nBWNsNyy; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=TS
	2c4+8QcxzYCQJ9dOwqNrRRCyzgODztpgqxHCDceTQ=; b=nBWNsNyyuSn5F3z0s/
	QzuJv8Nrbaah8YFsYpiXBbpyF3JgDSGG9FNRwAxBqGD7H036I9Q9aK82x5K9KdHu
	+6UDW257J3VuIKMeyotgPpehQblGttdcVyScOdaRQHYz49Q9OVtUZlMcKyKtr3hY
	vhtdpt64LiYq5OfcpMbbNZK/s=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXNKwdUbpo_djoGA--.23003S2;
	Fri, 05 Sep 2025 10:55:26 +0800 (CST)
From: liuqiangneo@163.com
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH] ixgbe: Remove self-assignment code
Date: Fri,  5 Sep 2025 10:55:15 +0800
Message-ID: <20250905025519.58196-1-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXNKwdUbpo_djoGA--.23003S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF13XryUWr17ur17JFykGrg_yoW8Gr4rpF
	W8u3sIgry3XF45Way8Xay5Jr90ga92vw4rGFyDAw4rZw1DCrsrGwn7t3y0yFyxZrW0vF1I
	vF45Aws5C3Z3J3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGXd8UUUUU=
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/1tbishG-YWi6TaZSWAAAsO

From: Qiang Liu <liuqiang@kylinos.cn>

After obtaining the register value via raw_desc,
redundant self-assignment operations can be removed.

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index bfeef5b0b99d..6efedf04a963 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -143,18 +143,14 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 
 	/* Read sync Admin Command response */
 	if ((hicr & IXGBE_PF_HICR_SV)) {
-		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
+		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
-			raw_desc[i] = raw_desc[i];
-		}
 	}
 
 	/* Read async Admin Command response */
 	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
-		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
+		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
-			raw_desc[i] = raw_desc[i];
-		}
 	}
 
 	/* Handle timeout and invalid state of HICR register */
-- 
2.43.0


