Return-Path: <netdev+bounces-246975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F09CF2F7A
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 11:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D48C2307896B
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 10:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2373168E3;
	Mon,  5 Jan 2026 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f12n0v9H"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975D3164CB;
	Mon,  5 Jan 2026 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608501; cv=none; b=k92SooI6f7B3Nv+2BKGRJ8S+9YoviJrcTf+Iii0pA1EMg9BjIB2eP9gMl66sV6fT17h8HHdpDnRbgewH+3LpDLGiTcK96nE0UypeHatfsxiTmj8mevS1vbeSjjkiDjmxeyzVmJUWRAwHU27GIYXMk7OOn8C8PJgyoMSHUTsDdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608501; c=relaxed/simple;
	bh=QJwR31LUjagdVEaSKK25/11zLr/1MNw+I0HRRvelUeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bc4R3qRajoiJTPypAWqZQfk2xr5NBLqOlT98VQ1Uc1nEQq+bK2k0oqvk58bDc8agdfv75cq5YCTWD06LNJA1wIwR6/T6Lt3Wf+4zUmrc3DHXyX+5E50h2ownEfXqXGvLamVoYqSlnWtW56VCXshL96I5DaJ6SaUUWkppA8AFB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f12n0v9H; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=LX
	Da7p8qMOIcHKrHr4whPEp5/2uFN+0BctnZg49fC7g=; b=f12n0v9HB8vaRTTPba
	5sNCx2vXMEVG9BLtlE4wsnknfFHpRzhhTBlHOQEN6/q8utWSWmp8YRHBKwIZlmbP
	VEHMHFGhYuyJz7c5pfqzJxJDFkwchUEWARzblHLRvE/KKJgxoBjYsV7D4bjgZsuW
	IU8TLcoNC3D541U8U2sezr+Aw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnrxNrkFtpVWA8KQ--.198S10;
	Mon, 05 Jan 2026 18:21:02 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [net-next v4 8/8] net: wwan: mhi_wwan_ctrl: Add NMEA channel support
Date: Mon,  5 Jan 2026 18:20:18 +0800
Message-Id: <20260105102018.62731-9-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260105102018.62731-1-slark_xiao@163.com>
References: <20260105102018.62731-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnrxNrkFtpVWA8KQ--.198S10
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW3Xw48Gr4fGrWDAF45Awb_yoWfWwbE9w
	1DXF9rJrW5W34UKFsFgF13ZryfKw10qF4kXFnavrZYv347XryfWw1kZF4Dtr9Fkr17CF9F
	9rnxWayFyw4fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREK0P3UUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvw543GlbkI65KQAA3p

For MHI WWAN device, we need a match between NMEA channel and
WWAN_PORT_NMEA type. Then the GNSS subsystem could create the
gnss device succssfully.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/net/wwan/mhi_wwan_ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index e9f979d2d851..e13c0b078175 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -263,6 +263,7 @@ static const struct mhi_device_id mhi_wwan_ctrl_match_table[] = {
 	{ .chan = "QMI", .driver_data = WWAN_PORT_QMI },
 	{ .chan = "DIAG", .driver_data = WWAN_PORT_QCDM },
 	{ .chan = "FIREHOSE", .driver_data = WWAN_PORT_FIREHOSE },
+	{ .chan = "NMEA", .driver_data = WWAN_PORT_NMEA },
 	{},
 };
 MODULE_DEVICE_TABLE(mhi, mhi_wwan_ctrl_match_table);
-- 
2.25.1


