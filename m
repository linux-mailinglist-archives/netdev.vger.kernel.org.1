Return-Path: <netdev+bounces-120882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D095B1FD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B006B231E4
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6776117DFFB;
	Thu, 22 Aug 2024 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rV1w+g3Q"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0217DFFC;
	Thu, 22 Aug 2024 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319596; cv=none; b=AJgean5WDaPhp9nkbpvjL/V1VbTPaaC6d+Z1rEYMzaE1wxT0BBOCvr3Af3EVtShidKEbsI8pf+pdKFQQ0GpnZDBVRYsob7rLUl64l1rFOepyZtkFF/RaIHqb52FLLATicdImOo5swQpeBIimWcVJ9Le21EJQkSk81TwPy5PPq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319596; c=relaxed/simple;
	bh=vzqvxFl3bgMoEVE6JsDbJKaHQIJiWe8yJ/JpRH0nHog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbHopdPwX+jAumRV7C3P5NJLWBndGWZugASGym8Q/oOyyaWmCKQXmD9gR0p+iRRDnIAUhhmDdUBiZEryrgtTDQ1U5Bkjsl45lErQGPd3Ggx18qZRsLJhNDAtVNzZhHKCGjjtPGTZ7swVlWpRP9HhTWXN7Pc2x+ghUYrY4dkR12I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rV1w+g3Q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47M9dQcR53804207, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724319567; bh=vzqvxFl3bgMoEVE6JsDbJKaHQIJiWe8yJ/JpRH0nHog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rV1w+g3Qm69/1BugCMh29sttwOp65vjAoaKxOZuvQdCQK91AVDr6fZMZkONiiHlpA
	 PZEeouhII90Ob+//I5T6EgndyouUA80OX0dILxC2kGYt8GXfpCPBBDIbiykd8qGIm+
	 PjI+30IMkT8Vu7hp8x+J+yVARNgMp3inj9gOTJV1s1ProiwjuGXwfmu53n8GRVGDhC
	 NO84ufV6KPJEng7f/VBczA/5+WyKkxt9eflGnJEYleijABNOD51fRZ/8DbNAxv8oah
	 uA+MDX08eygbxt2HNR/owmKaFFjZagrUsGN0rEh5MxwczGzJDvvTfEjKOG3pTp6mcE
	 o+kCHxXssrETA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47M9dQcR53804207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 17:39:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 17:39:27 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Aug
 2024 17:39:26 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v28 04/13] rtase: Implement the interrupt routine and rtase_poll
Date: Thu, 22 Aug 2024 17:37:45 +0800
Message-ID: <20240822093754.17117-5-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822093754.17117-1-justinlai0215@realtek.com>
References: <20240822093754.17117-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

1. Implement rtase_interrupt to handle txQ0/rxQ0, txQ4~txQ7 interrupts,
and implement rtase_q_interrupt to handle txQ1/rxQ1, txQ2/rxQ2 and
txQ3/rxQ3 interrupts.
2. Implement rtase_poll to call ring_handler to process the tx or
rx packet of each ring. If the returned value is budget,it means that
there is still work of a certain ring that has not yet been completed.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 7f683c246003..6e7f30b015eb 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -571,6 +571,75 @@ static void rtase_hw_start(const struct net_device *dev)
 	rtase_enable_hw_interrupt(tp);
 }
 
+/*  the interrupt handler does RXQ0 and TXQ0, TXQ4~7 interrutp status
+ */
+static irqreturn_t rtase_interrupt(int irq, void *dev_instance)
+{
+	const struct rtase_private *tp;
+	struct rtase_int_vector *ivec;
+	u32 status;
+
+	ivec = dev_instance;
+	tp = ivec->tp;
+	status = rtase_r32(tp, ivec->isr_addr);
+
+	rtase_w32(tp, ivec->imr_addr, 0x0);
+	rtase_w32(tp, ivec->isr_addr, status & ~RTASE_FOVW);
+
+	if (napi_schedule_prep(&ivec->napi))
+		__napi_schedule(&ivec->napi);
+
+	return IRQ_HANDLED;
+}
+
+/*  the interrupt handler does RXQ1&TXQ1 or RXQ2&TXQ2 or RXQ3&TXQ3 interrupt
+ *  status according to interrupt vector
+ */
+static irqreturn_t rtase_q_interrupt(int irq, void *dev_instance)
+{
+	const struct rtase_private *tp;
+	struct rtase_int_vector *ivec;
+	u16 status;
+
+	ivec = dev_instance;
+	tp = ivec->tp;
+	status = rtase_r16(tp, ivec->isr_addr);
+
+	rtase_w16(tp, ivec->imr_addr, 0x0);
+	rtase_w16(tp, ivec->isr_addr, status);
+
+	if (napi_schedule_prep(&ivec->napi))
+		__napi_schedule(&ivec->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int rtase_poll(struct napi_struct *napi, int budget)
+{
+	const struct rtase_int_vector *ivec;
+	const struct rtase_private *tp;
+	struct rtase_ring *ring;
+	int total_workdone = 0;
+
+	ivec = container_of(napi, struct rtase_int_vector, napi);
+	tp = ivec->tp;
+
+	list_for_each_entry(ring, &ivec->ring_list, ring_entry)
+		total_workdone += ring->ring_handler(ring, budget);
+
+	if (total_workdone >= budget)
+		return budget;
+
+	if (napi_complete_done(napi, total_workdone)) {
+		if (!ivec->index)
+			rtase_w32(tp, ivec->imr_addr, ivec->imr);
+		else
+			rtase_w16(tp, ivec->imr_addr, ivec->imr);
+	}
+
+	return total_workdone;
+}
+
 static int rtase_open(struct net_device *dev)
 {
 	struct rtase_private *tp = netdev_priv(dev);
-- 
2.34.1


