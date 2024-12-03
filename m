Return-Path: <netdev+bounces-148689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8C89E2E15
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42406283960
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF23207A31;
	Tue,  3 Dec 2024 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="Nfh5KTbU"
X-Original-To: netdev@vger.kernel.org
Received: from mx02lb.world4you.com (mx02lb.world4you.com [81.19.149.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E2204F7A
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261295; cv=none; b=qE0DgT7qa2Q5XgUqOqkdn+CkqmZK3Gtid8E6PoARJkhqzt74DiU331bFA/lR9ee2ITkVC/fM16f4Eciqu4KW56A+aR6ht7mCNo8kclt0+WnBB6BmhYhZJvN/QcXqNmYwW/kLurO1K4D5752cGBkCkrg07xFKtBLS3E0KCvN2gTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261295; c=relaxed/simple;
	bh=fJpeXemSiKLXm7ACZBgNXRsXhp+X1cBaxOYNrydYQsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X9a/8SqQUXk69DDC5/82iiRo1mHLRX2cg9l0EFZIYXDQTNyl5gq7PhJ70NUOt1kv6Ve5P5VGq6IjISIkI/UxfuXYgukqX2ahm4PspH2ydHYPcM5CZLd6ybhzMJzx5UZo3i9YnSMgmrOez0SRVyLaIaaxrppdcffoL5PACRmSC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=Nfh5KTbU; arc=none smtp.client-ip=81.19.149.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OaLj4gHigrYYzrcyCbpM9wppwoiYRlfqrlvPlvYym9U=; b=Nfh5KTbUHfq2qNXSdi3ZCS0S9g
	SUyZ4+rzaEK0RCGsnANjEPmaUcgrTmMEQRY3AnvJVcAJ1QrQtNL2ApqMrOQvXq636OF8wgvrSax8X
	Ad+qs8oBp4TyLf51ly4m6AVy7Y6X+YHXPL4++6FQsyW103oINN7DHKFTML/V9Hhc6Bhg=;
Received: from [88.117.62.55] (helo=hornet.engleder.at)
	by mx02lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tIZVY-000000003Ft-3lZp;
	Tue, 03 Dec 2024 21:28:33 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH net-next] e1000e: Fix real-time violations on link up
Date: Tue,  3 Dec 2024 21:28:14 +0100
Message-Id: <20241203202814.56140-1-gerhard@engleder-embedded.com>
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
interconnect with posted writes. As this also increases the time spent for
MTA table update considerable this change is limited to PREEMPT_RT.

Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/net/ethernet/intel/e1000e/mac.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index d7df2a0ed629..7a2c10a4ecc5 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -331,8 +331,14 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
 	}
 
 	/* replace the entire MTA table */
-	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
+	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
 		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			/* do not queue up too many writes */
+			if ((i % 8) == 0 && i != 0)
+				e1e_flush();
+		}
+	}
 	e1e_flush();
 }
 
-- 
2.39.2


