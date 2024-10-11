Return-Path: <netdev+bounces-134696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E33799AD74
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F0BB20A37
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102C1D0E0A;
	Fri, 11 Oct 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="tmFZL+Md"
X-Original-To: netdev@vger.kernel.org
Received: from mx10lb.world4you.com (mx10lb.world4you.com [81.19.149.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F819CC10
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728678303; cv=none; b=eCzJ9qE2dv5HEdNTUH3lZ+2dx8AEvj2HCWXe7ENdGqZaDlVxseo8TgPIEKBb8TVq3s9oR6PopV2m7XU8ckNPU8Zjnq+7UjnLr64DsMgIkXHwX/G5axRW+friRqFN13w6Jodl7KCZ61GUJOFQB7PN8KCIGyQ4Z/znFlBtPTtx1HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728678303; c=relaxed/simple;
	bh=5Ekpk5FnVFG/rAv/zJNiB+Af0Pa+FfaKb4dFrHSkoTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IeumvFCZd9gxzltUlOhkQu0N8J9ZauAP6RCvLvWijnYVifHbt4gJxIGF/7xGVp7VIVAgL8WuKWFs0L/JQWouS2SOKjV2BtPv44aDb8gczNZd5bKiBr5Lw7x1d1qOumBfgtLv+fcnDAbaQGpzTzDm+INIKKDWuGsbg35/Nmp+bJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=tmFZL+Md; arc=none smtp.client-ip=81.19.149.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ALLXedTczsskWYT8EyWguub+TKfvEY+dZAtEEz5BF6A=; b=tmFZL+Mdx2UCrMPSH5SSONiv7C
	Wun4H9fmG2lzNzLGYknVliPJ7j8auJhJwzz7Vv3osQVtSqUCevRQbb6VaG+xB9qQ3+0nQdx8HA7rR
	rYu6P87NnnLjdupiwra907grmj4ub/yamTTGIRkH7RaaOXGL/bLCPaM3rZxebXXS30RE=;
Received: from [88.117.56.173] (helo=hornet.engleder.at)
	by mx10lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1szLiQ-000000005uk-0ndw;
	Fri, 11 Oct 2024 21:54:22 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH RFC net-next] e1000e: Fix real-time violations on link up
Date: Fri, 11 Oct 2024 21:54:12 +0200
Message-Id: <20241011195412.51804-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Gerhard Engleder <eg@keba.com>

Link down and up triggers update of MTA table. This update executes many
PCIe writes and a final flush. Thus, PCIe will be blocked until all writes
are flushed. As a result, DMA transfers of other targets suffer from delay
in the range of 50us. The result are timing violations on real-time
systems during link down and up of e1000e.

Execute a flush after every single write. This prevents overloading the
interconnect with posted writes. As this also increases the time spent for
MTA table update considerable this change is limited to PREEMPT_RT.

Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/net/ethernet/intel/e1000e/mac.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index d7df2a0ed629..f4693d355886 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -331,9 +331,15 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
 	}
 
 	/* replace the entire MTA table */
-	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
+	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
 		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
+#ifdef CONFIG_PREEMPT_RT
+		e1e_flush();
+#endif
+	}
+#ifndef CONFIG_PREEMPT_RT
 	e1e_flush();
+#endif
 }
 
 /**
-- 
2.39.2


