Return-Path: <netdev+bounces-190766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E603EAB8A72
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE234A00DDB
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0A520D4F8;
	Thu, 15 May 2025 15:12:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635413B7A3;
	Thu, 15 May 2025 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321932; cv=none; b=rbMzxP4wB7qYfg2ZJjtdRAXvyFNCk0HSEz788WB1jOBAetCADuS6X1cocM8E9saTJdgzj3G/HSUH72G+U3dpfNvfN90zG1qOXHEcCcRJOAlkbbDmAU58EK2k9qcploCZ1cVGq9Q4PemJcqdlfE+5Ma5MIERBqu23P5EPmTeW5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321932; c=relaxed/simple;
	bh=Akg0bXgjuTMEa4GvbEnBGJzdyPI1Mq54FHSxMzn8Hg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szHs8CO5/8czZMm/WhGvzit2s1Va37FHUHqOtmdVjPHyFhtDMxviwEfg3TvsbPiBjJrb/L60Ns90adXwTFxL0vcXk49D47xNtcTTouwmnMIVC0c4T05v78LBsvCBesbtoGV7kECAk/5Z0Fr0Ow4C1a+5UxyWRFrkm/GTNuKthbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADXfwA3BCZopDnTFQ--.8013S2;
	Thu, 15 May 2025 23:11:53 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ste3ls@gmail.com
Cc: hayeswang@realtek.com,
	dianders@chromium.org,
	gmazyland@gmail.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] r8152: Add wake up function for RTL8153
Date: Thu, 15 May 2025 23:11:30 +0800
Message-ID: <20250515151130.1401-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXfwA3BCZopDnTFQ--.8013S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4UGr1UWw1xGFy3XryUtrb_yoWkWrgE9r
	s3G3ZIqr45ZrsYkr17JFsxKFyrK34kXw18Ww4Sqw4ftw13t3y8Jr4DWrs0vrn7Ww4rCFyU
	Gw42kFy7t348JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoDA2glvbHNggABsC

In rtl8153_runtime_enable(), the runtime enable/disable logic for RTL8153
devices was incomplete, missing r8153_queue_wake() to enable or disable
the automatic wake-up function. A proper implementation can be found in
rtl8156_runtime_enable().

Add r8153_queue_wake(tp, true) if enable flag is set true, and add
r8153_queue_wake(tp, false) otherwise.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 468c73974046..cb708b79a7af 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4004,10 +4004,12 @@ static void rtl_runtime_suspend_enable(struct r8152 *tp, bool enable)
 static void rtl8153_runtime_enable(struct r8152 *tp, bool enable)
 {
 	if (enable) {
+		r8153_queue_wake(tp, true);
 		r8153_u1u2en(tp, false);
 		r8153_u2p3en(tp, false);
 		rtl_runtime_suspend_enable(tp, true);
 	} else {
+		r8153_queue_wake(tp, false);
 		rtl_runtime_suspend_enable(tp, false);
 
 		switch (tp->version) {
-- 
2.42.0.windows.2


