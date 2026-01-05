Return-Path: <netdev+bounces-246833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69605CF1A0D
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 03:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2126030053E7
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 02:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194F405F7;
	Mon,  5 Jan 2026 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ha+SZ1Ap"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E723184F;
	Mon,  5 Jan 2026 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767580221; cv=none; b=FboE5krgkM0XhZd4f/sDr8iYgsTmgZMWLjzf2oiLNUiKETvtkEhFh7IuT5uW/fX8BZyhf0zhpa4N+CESQWcCB6I5VinZXw2BoLh9yW89Zg1dlT8KHfoKVZIyd8JtnW7eGBfV5Qkk8KW3AD+1KzUvb4KMJ5l6nUkGgqfige/UuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767580221; c=relaxed/simple;
	bh=JrLCXIIYMqEB72dTKPk2q1ENw5x9MH5gAnEeOZv9BXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z7oNuDh0mTuscaGotR9nA0E+K9r0E7DsQMNy2Xpr6Tr1YFuVyPToLBn0Vys/Qy5sv8eE+huPKNBR2xp6hMzeamdz9ogKIifhOLVwFWMbHajkqrgc1+v21GAy6LxOP0mvnLnYoQtpCDX056tZ5OvxdjcOLqlJY1HR1a5O5Yi5AAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ha+SZ1Ap; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qP
	w147oQ4NhHWTTJJ4ox3W/+fXJvr3CJBRA1PXjhvAE=; b=Ha+SZ1Ap6g/W+UT/Q8
	BKVrbEgr+e+SStMdg/owM2ct7mnfQGOiztcfuOHdLfFo2fYPDrvHzVO+9ql/t1g2
	ceKF6MzrOLQHZ1XnoTLmN0i2Vb46z/RwTfkTR2F+Sl6CUxs1z+Gspan9Car8fbg8
	6wfhM3pHujjbOlIlNgJrZee9M=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wB3tAFoIVtp3hY_EA--.481S2;
	Mon, 05 Jan 2026 10:26:51 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [net-next v4] net: wwan: mhi: Add network support for Foxconn T99W760
Date: Mon,  5 Jan 2026 10:26:46 +0800
Message-Id: <20260105022646.10630-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3tAFoIVtp3hY_EA--.481S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr45tF13Wr1xur45KFWUXFb_yoWkKrgE9r
	n3WF9rJw4YqFWjkr18GFW5ZFWfCwn7XF1vvFnYv398Ja4kAFyrWFZ5ZFyIq34293ZxAFsr
	ur9FvF1Yy397KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKv38UUUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwAuT92lbIWtlygAA34

T99W760 is designed based on Qualcomm SDX35 chip. It use similar
architecture with SDX72/SDX75 chip. So we need to assign initial
link id for this device to make sure network available.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
v2: Add changes into same serials with MHI changes
v3: Fix missing serial info
v4: Rebase code and separate out wwan changes from previous
    serials since MHI side has been applied
---
 drivers/net/wwan/mhi_wwan_mbim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 0dace12f5ad0..cf6d3e2a007b 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -99,7 +99,8 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim
 static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
 {
 	if (strcmp(cntrl->name, "foxconn-dw5934e") == 0 ||
-	    strcmp(cntrl->name, "foxconn-t99w640") == 0)
+	    strcmp(cntrl->name, "foxconn-t99w640") == 0 ||
+	    strcmp(cntrl->name, "foxconn-t99w760") == 0)
 		return WDS_BIND_MUX_DATA_PORT_MUX_ID;
 
 	return 0;
-- 
2.25.1


