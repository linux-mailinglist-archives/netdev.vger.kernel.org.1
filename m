Return-Path: <netdev+bounces-125101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D2C96BE8E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FB7B2565F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1961D9D97;
	Wed,  4 Sep 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O85YO2sC"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556D1E884
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456493; cv=none; b=AII+CgletL6A0sCLYvGyv3C3Mc9Ww8X3m52cki3Qg64qkvbIGGGOqP95syIBD4msgp+7Gt7WKOhsloCcpSRzaLMwcNLYZTwtLykUNrnm+pEOzSFaREKyYdDvPN1wwYzArgaacMm2ft8b9eCr4ofM+azKPPPze4trLr2TFPW+Ng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456493; c=relaxed/simple;
	bh=KXKiGS7UCY9h6e5+s0bMiiKPkG4zS/jsS/kad2zB8lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Va2fCn9ZhNhmNyXEQoivhwkDZxk+UX3gGRLEEyUiAnIWul40+ZzZIq/exuygB02wKMMNVRmFCl/M1ytG/iepxRglnioKm1m6ZlVTMpNHe+x+kjPJYUiz5N5XXVYWnLEKfd7+/YyQCrZB+kNbu9IBWJNTtbAdeCz1W0eiwPguDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O85YO2sC; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725456489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F+RcADK2HGjXQMRLuoz0R8HYjH5YaS+98Y2udmZDFVc=;
	b=O85YO2sCtROwtFg1ehrEShY891yWKDstkyvRku73/yy0lXnaAdMutwlPEt263Im+zZG9d2
	0aKllS23j28DrX95jo7nZL0IxG2isUg1SHD/3vxHtl96fl0kKAQKOIHp9ddVmuJTwE9AQM
	TQ62Ca9gTIlZ1btAqmgPTr6ENja9eVQ=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] ptp: ocp: Improve PCIe delay estimation
Date: Wed,  4 Sep 2024 13:28:42 +0000
Message-ID: <20240904132842.559217-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The PCIe bus can be pretty busy during boot and probe function can
see excessive delays. Let's find the minimal value out of several
tests and use it as estimated value.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/ptp/ptp_ocp.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index e7479b9b90cb..22b22e605781 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -1561,19 +1561,22 @@ ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
 	ktime_t start, end;
 	ktime_t delay;
 	u32 ctrl;
+	int i;
 
-	ctrl = ioread32(&bp->reg->ctrl);
-	ctrl = OCP_CTRL_READ_TIME_REQ | OCP_CTRL_ENABLE;
+	for (i = 0; i < 3; i++) {
+		ctrl = ioread32(&bp->reg->ctrl);
+		ctrl = OCP_CTRL_READ_TIME_REQ | OCP_CTRL_ENABLE;
 
-	iowrite32(ctrl, &bp->reg->ctrl);
+		iowrite32(ctrl, &bp->reg->ctrl);
 
-	start = ktime_get_ns();
+		start = ktime_get_ns();
 
-	ctrl = ioread32(&bp->reg->ctrl);
+		ctrl = ioread32(&bp->reg->ctrl);
 
-	end = ktime_get_ns();
+		end = ktime_get_ns();
 
-	delay = end - start;
+		delay = min(delay, end - start);
+	}
 	bp->ts_window_adjust = (delay >> 5) * 3;
 }
 
-- 
2.43.0


