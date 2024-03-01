Return-Path: <netdev+bounces-76479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9CE86DE4E
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 10:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E897E1F25742
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5BD6A341;
	Fri,  1 Mar 2024 09:32:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CFE6A33F
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285521; cv=none; b=FhbHRkdo75C5eBl0ft0WXhncNfNjJntvERlRujJ/pTzS9BQRR4wWXKYK4GYzyQxv7bpshIZwZhdCVTMBVbDpQSgbBDOy/Lw19fwgyfu3aG+MaRu1rXmBGxLkMzm6SvHuxTRVnbXwMffQ1HKNqEPZRp6z2oJY+i9Zk5lJzyNsrBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285521; c=relaxed/simple;
	bh=0qK84CikjYO1cqCR5Ax3DixPzFa8sRtu+E2WkSB0ElE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FRl9RbpT2JV3KxZ0E8sTb78hrA8NZjXsbWQDdTvRDF/cr1ZDQiz720jlzLUbEJwtiugqKIfdFN2sBSccHeqlimZ648m94zwIZp3Ph4mlm733SB2Hxvo+UAs5F6EGcl0YDAWyszwhOc1tXIhugNn8kNsqYktR5IeAYaNn9m2Kn3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp80t1709285410t9q1dgu5
X-QQ-Originating-IP: 7ieeqMk1r0c7KI2kKz1p6pCP/2Mfd4bXtoAhZMunZdk=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.149.201])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 01 Mar 2024 17:30:08 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: IcCSTr/hHjN/s1ihGrstUE3luMaAFB4WBRO3oPMT+DSXTk8cOlj59z+A+4Bs4
	L/PwW6RUHQYJ5QT3V+MxQJWi8GYcq1aZb5uOofXzurZ1seuPxCFWxW8r+1i1n+dcXX5OExC
	P/WdUqC04f+9dpR4nEyY7a/1dcj5FMIKqIvsl0GNcfW9QSmtfhytQiCDLm1iDyd4v5UdyYX
	uOoZqv2ub3SagHX3jmev/AiLjdobhuLXR/X3QCvaF4CH4QhqPkw2TrksMcVb/Ghy+9vLMM1
	X2k6vIq1/AmVukXy8U3uj+/34axJuH+zAOr+OynLf7dYXEkf27euUsAmdcFsXItPo+H1ZU6
	rNAE2/GuhTywL3fxdLEw2/qqpYi+fLZbJnVi0MU+dVWVIbn8FcgabqFYJdqABeNNfrX6tup
	QHvEP9B5sf8D1NHd2dO35g==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2361451904155115522
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 2/2] net: txgbe: fix to clear interrupt status after handling IRQ
Date: Fri,  1 Mar 2024 17:29:56 +0800
Message-Id: <20240301092956.18544-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240301092956.18544-1-jiawenwu@trustnetic.com>
References: <20240301092956.18544-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

GPIO EOI is not set to clear interrupt status after handling the
interrupt. It should be done in irq_chip->irq_ack, but this function
is not called in handle_nested_irq(). So executing function
txgbe_gpio_irq_ack() manually in txgbe_gpio_irq_handler().

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index c112f79b026e..93295916b1d2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -475,8 +475,10 @@ irqreturn_t txgbe_gpio_irq_handler(int irq, void *data)
 	gc = txgbe->gpio;
 	for_each_set_bit(hwirq, &gpioirq, gc->ngpio) {
 		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
+		struct irq_data *d = irq_get_irq_data(gpio);
 		u32 irq_type = irq_get_trigger_type(gpio);
 
+		txgbe_gpio_irq_ack(d);
 		handle_nested_irq(gpio);
 
 		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
-- 
2.27.0


