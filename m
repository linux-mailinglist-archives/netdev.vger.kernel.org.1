Return-Path: <netdev+bounces-189709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4216EAB3490
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAC3188BFCC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28925C83B;
	Mon, 12 May 2025 10:08:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7100725A341
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044509; cv=none; b=WVGxeZKx5cH0IxKB0N1hEHEiAeTTz4h6/aSlVj6XKVdRU9wSH930nrpxnGmY3E2n9nDguNhE0ZTipzn0lUYHWC5kBVwqCapRHuUMlWqgJNtlWW5fC6cpZ5QlqUyXZmW3g+pEnLLg9k3ht+XaxHAYAIRGgoQ2i/rkpKYo7TJoeq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044509; c=relaxed/simple;
	bh=7nE7u3MLt+E/7waiYIIJecvKDY9v1vWCERJAkKjmnQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xdns3dGLJVyVuOdbhkmHAtcZawpkg9RDhrTf91aAO3VF4mcJJYSK7bRKSW/6alL+74G/LpqMdFPjdsVy2fQgVhO0SsruQL+J9VGTab1Gdh4+jeth8TMSFz9zURMV6Yb3o+te5kUlTeyjJ9rWLV5Fdrm8aTRSFUfjKh70O58y1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1747044423t836d2841
X-QQ-Originating-IP: g9tQBrdJ4ZYwrm/EHae3+Cd77jpvY+qu+45krQzI5Qk=
Received: from w-MS-7E16.trustnetic.com ( [122.233.173.186])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 May 2025 18:06:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15804977559772286950
EX-QQ-RecipientCnt: 8
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next] net: txgbe: Fix pending interrupt
Date: Mon, 12 May 2025 18:06:52 +0800
Message-ID: <F4F708403CE7090B+20250512100652.139510-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MaCc72GaN9m8fwrCRvEVrDbyX+Mhy8dax1jn4lFmXuXKiQ+W4lDyOljS
	1F4Lyu5LzH2jcOXUwDt/X8M7kargajg94yNATS8RxV6o/a3tRGso+RqnDJhSx1/7lUeujlx
	gmgibpJ8yhAn9GuUN6y6yCgiRu92eiLxbaKXHKUXMYKL/3fKSOP77HwMFwTwVUjCi/unJlN
	pOAjpoequfbEY9ox+d7zTDrz5s0gMdJr1HbLOVB7X16yZQi8ogrSBbYMzJFkX4HpHkepdlz
	6imUI2+P342h4MkmNNBJp5cyRCMcD9nTnJ5gsW0/jcUtQyAGZa2SBWoBnbLx12Xcmep6GwA
	r+xvqXhHtS8a2TYoR+CiQVQXDadVnJ9ZQ6jaMRGquK5ybsn8zQfVPa9yC7PzNV8sNW9n+Bi
	QEWiIz8IjRLuQ8lDxSSggtKgqWFJOp6IdSP5n6738bTYJdttvJ2ajBfGH4IF/4zhaC1/cfG
	jh6UzVQanPJLVbLeoUXNm0SwSJVvjEoETI0ykVg0vlxwh7v2VY0/W9lSJrgu2MlMoJaBo/C
	t/37/05Hb8zJxWYwkRmuLymRR2SqCjwNUOTZUZweAetb+fCMkwFK/JVKvB4TQWiNks/pc41
	c0sPYdpMCBcUgDge6g2FV90AwnxKp6t3wcKONsPxJW3z6TXiFjo3Cg+7X+aI68RjriRSFt6
	rYV7NA8VJJrzkvwG5WXdX6xYLWgcCGt7T00yxXap8mlnI3qP+OQCoDvb0KkBpIBssu/EDP2
	ng5oGwynVSIT0dFsWiqBFSTHbP5rgPaWrZ+qPqT4mG6jqTQuImpvzqPFyFgDWw83aEVoGFx
	iDxNYKyRNxqYUnaUdVBUOEgCDduNnwuQfoDMHtM96XSoNHORgFew0xSD5Ki7KSQluG3+nTz
	JgHZR5uh4nmgU5siMeqETPpNv47/jqqj8nUeoOxh8cgKu8OstmI4czzv6oy7VklBTKI4ywz
	oTSw0hhN6dRawPFfLMu+IubvPhYKEF4wJ8xbJ5oD+iSAgPMdbNcHzZOX+3et09kYnm/gSf5
	i35aZ0XVWCE/xXq3ikmCcMyFQ/BzQ=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

For unknown reasons, sometimes the value of MISC interrupt is 0 in the
IRQ handle function. In this case, wx_intr_enable() is also should be
invoked to clear the interrupt. Otherwise, the next interrupt would
never be reported.

Fixes: a9843689e2de ("net: txgbe: add sriov function support")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 3b9e831cf0ef..19878f02d956 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -112,8 +112,6 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
 
 	if (wx->pdev->msix_enabled) {
 		eicr = wx_misc_isb(wx, WX_ISB_MISC);
-		if (!eicr)
-			return IRQ_NONE;
 		txgbe->eicr = eicr;
 		if (eicr & TXGBE_PX_MISC_IC_VF_MBOX) {
 			wx_msg_task(txgbe->wx);
@@ -139,10 +137,7 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
 	q_vector = wx->q_vector[0];
 	napi_schedule_irqoff(&q_vector->napi);
 
-	eicr = wx_misc_isb(wx, WX_ISB_MISC);
-	if (!eicr)
-		return IRQ_NONE;
-	txgbe->eicr = eicr;
+	txgbe->eicr = wx_misc_isb(wx, WX_ISB_MISC);
 
 	return IRQ_WAKE_THREAD;
 }
-- 
2.48.1


