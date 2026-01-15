Return-Path: <netdev+bounces-250144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F46ED244CD
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3958030A7C23
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBE9393DCD;
	Thu, 15 Jan 2026 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aHXhSO0u"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B9389E0E;
	Thu, 15 Jan 2026 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477655; cv=none; b=TShBoQMS3zGnmfQrEcNzqlfY4XqnRRqK+wxdws2v9k3Xp52VIZeCHOe9l1v9wPYGaBmwSpDZuzcuz1HJXY0EfuOMVOJGhtIqzlqmoRZAF6C2uwdfU4eHClc7PFjO9L2xBwJ9b7Cfccd8b8F0spnKSebtd2Vx2mhFv4JTUjiv1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477655; c=relaxed/simple;
	bh=hPpGrhBm7dswjrLDv/THjvYEQrlbFx3TtA9jAFW1hNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lY8HJ2SbyDhGAA0GuAfk1abaTFmiTzMuHLWhaaoTGzeOWDHDI6LA6wqjLhTWrnFwgxhznjZTFTNNYyhCEwH3TXIEWdduXkSYNDGPo3J07h/01ZgH5ZN9AVepY5Rnd0ZT8WBSoA2UOrOkTldpPILskT5f5gYu5FrjQA+jCxavs+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aHXhSO0u; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/4
	b01nswZlIsKdbMEMUcNlPloW0gjn+e2EWs/AY2u78=; b=aHXhSO0u60uet3jDlt
	ozkenQewX2OaKjX6xLMNdcSH6EI1p9o3jtfxiau7+wGmsqWF1IlyzLNeM9sPRpbD
	FZ7S0qiYSgr4l+dtEocNr/YKKl7I5jCmlrvFoeKsaTECKqDvF4GLtwrt+G8Ax7wt
	ntIt1rp4fmVTGE0fRBJTkHLxU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHLGiX02hpr2PzGQ--.4331S10;
	Thu, 15 Jan 2026 19:46:51 +0800 (CST)
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
	slark_xiao@163.com
Subject: [net-next v7 8/8] net: wwan: mhi_wwan_ctrl: Add NMEA channel support
Date: Thu, 15 Jan 2026 19:46:25 +0800
Message-Id: <20260115114625.46991-9-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260115114625.46991-1-slark_xiao@163.com>
References: <20260115114625.46991-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHLGiX02hpr2PzGQ--.4331S10
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW3Xw48Gr4fGr4kur1rJFb_yoWfKrgE9w
	1kXF9rJrW3J347KFsF9F13urWfK3W0qF4kXFnaqr9Yv347XFyfWw1kZF4Dtr9F9r17CF9r
	urnxWayFyw4fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREEfO5UUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5wuT92lo06v9NgAA36

For MHI WWAN device, we need a match between NMEA channel and
WWAN_PORT_NMEA type. Then the GNSS subsystem could create the
gnss device succssfully.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
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


