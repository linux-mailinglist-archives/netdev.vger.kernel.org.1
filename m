Return-Path: <netdev+bounces-149996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F79E877F
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 20:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C11C163FFE
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C6313AA26;
	Sun,  8 Dec 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="iC+QNjvX"
X-Original-To: netdev@vger.kernel.org
Received: from mx03lb.world4you.com (mx03lb.world4you.com [81.19.149.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B08E54279
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733685547; cv=none; b=jMhAbOEHRcQzVIjnaDjQQDGopDUw9/7ICppEj1phUdRZpdYVHA+HPl3J66tnFovPYjimkYvt2BBx8BJv9MzBiMddFQRRYuxG/Z0amkJiM4e6Y028HoYEUGlxnKiiPooeEtBtptCGPAZ933fa/hRDdPNVM/c60MEyYlcfnyptWPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733685547; c=relaxed/simple;
	bh=nsfq1vtHttbajctqxQhICxOwmOimrKoyStCK/cllPTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VZQY2lbMWRt0h70CzNOn3clqS+0euQPrRdo9fDXt7tAkYzP4Qe/zJeyn02iGrQPFOy54Dt94lMRB+WE2WsYmXzSbkhDI8VaX2zf/2F9HCVRegbZ8uIv5TtrUSBvE+oMNOrAqyRIDDfEaIsF8S7ifFd7XBA7IKmA8MXKsekkemNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=iC+QNjvX; arc=none smtp.client-ip=81.19.149.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Pprlwk4H8fus0mZ0KjoURwKrFvoO/43ERt9bckqWA4o=; b=iC+QNjvXc1bC1j0P/jv1gFGNfG
	zmoJc7wwoQyXBnZp02uFFlwCfPg0OLbcx5Qzy4iN+GVOPhyavJ6CJ44XNYfpZ8yuRzu+tFdXJR3rd
	OpoKa7hLUDdZWfeRiBA7rlDIWHjuNn1d+yUvjrgS1D8yuJlVtn88uWFVmvAWP4kWz32w=;
Received: from [88.117.62.55] (helo=hornet.engleder.at)
	by mx03lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tKMMF-0000000034x-3P6Q;
	Sun, 08 Dec 2024 19:50:21 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Gerhard Engleder <eg@keba.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>
Subject: [PATCH iwl-next v2] e1000e: Fix real-time violations on link up
Date: Sun,  8 Dec 2024 19:49:50 +0100
Message-Id: <20241208184950.8281-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

From: Gerhard Engleder <eg@keba.com>

From: Gerhard Engleder <eg@keba.com>

Link down and up triggers update of MTA table. This update executes many
PCIe writes and a final flush. Thus, PCIe will be blocked until all writes
are flushed. As a result, DMA transfers of other targets suffer from delay
in the range of 50us. This results in timing violations on real-time
systems during link down and up of e1000e.

A flush after a low enough number of PCIe writes eliminates the delay
but also increases the time needed for MTA table update. The following
measurements were done on i3-2310E with e1000e for 128 MTA table entries:

Single flush after all writes: 106us
Flush after every write:       429us
Flush after every 2nd write:   266us
Flush after every 4th write:   180us
Flush after every 8th write:   141us
Flush after every 16th write:  121us

A flush after every 8th write delays the link up by 35us and the
negative impact to DMA transfers of other targets is still tolerable.

Execute a flush after every 8th write. This prevents overloading the
interconnect with posted writes.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
Link: https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
Signed-off-by: Gerhard Engleder <eg@keba.com>
---
v2:
- remove PREEMPT_RT dependency (Andrew Lunn, Przemek Kitszel)
---
 drivers/net/ethernet/intel/e1000e/mac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index d7df2a0ed629..7d1482a9effd 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -331,8 +331,13 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
 	}
 
 	/* replace the entire MTA table */
-	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
+	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
 		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
+
+		/* do not queue up too many writes */
+		if ((i % 8) == 0 && i != 0)
+			e1e_flush();
+	}
 	e1e_flush();
 }
 
-- 
2.39.2


