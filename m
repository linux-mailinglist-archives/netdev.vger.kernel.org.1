Return-Path: <netdev+bounces-108007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE95F91D8B9
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087CE1C2103B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691C7811FE;
	Mon,  1 Jul 2024 07:15:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030A80BF8
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818132; cv=none; b=jBH5h+Tbwp4fFAT+yy8HzWQonSmlsBRWtJsk0aLaMf/b7qWn3e39vmZvraaVLUCBbzZLhpXgjsKIrs757vDu7wxqxgPEPqrKt/HnULF5ijdBfm9ql2NwnVWyvYaUJmnELabYz4fPXZ3txEvbcStL/ZnJa87AOth4J8hSoZBWg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818132; c=relaxed/simple;
	bh=Tfj+FNKm1mqgd14cWJEiIiRvYH8dm2bj3v74namcXmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CBRatdCOAJquDylsLfuv2LiHGkGfbnf6scYx8U5Jf4RKR5Nnrlf2rlUqDwbC2RRTv4HQ9qzbY+/y/NYrAS0qawoHADvbNEJutdxS7fJoVr4wrzygBoeFGTvWc6hclX3fnD5UEjzyCP5RbV2pfTrez5NKYEoCcSRe9ctnyogcuQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp86t1719818067tpp6qf1r
X-QQ-Originating-IP: 0/obag3gewOf/qdJL2+O0daNKM8S+7d6o54sSqWUl2A=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.148.68])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jul 2024 15:14:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6412110099789273011
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 1/4] net: txgbe: initialize num_q_vectors for MSI/INTx interrupts
Date: Mon,  1 Jul 2024 15:14:13 +0800
Message-Id: <20240701071416.8468-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240701071416.8468-1-jiawenwu@trustnetic.com>
References: <20240701071416.8468-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

When using MSI/INTx interrupts, wx->num_q_vectors is uninitialized.
Thus there will be kernel panic in wx_alloc_q_vectors() to allocate
queue vectors.

Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 68bde91b67a0..f53776877f71 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1686,6 +1686,7 @@ static int wx_set_interrupt_capability(struct wx *wx)
 	}
 
 	pdev->irq = pci_irq_vector(pdev, 0);
+	wx->num_q_vectors = 1;
 
 	return 0;
 }
-- 
2.27.0


