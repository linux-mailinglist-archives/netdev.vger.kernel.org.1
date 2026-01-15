Return-Path: <netdev+bounces-250083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4112CD23C2E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4FB230AEEF2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129635F8BA;
	Thu, 15 Jan 2026 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h5vMqRcD"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAB435FF44;
	Thu, 15 Jan 2026 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470934; cv=none; b=oZNjzt3xn+I6rGE9Nosc466A7L6vI+vcx3nnxZoQZJ5vfAS/63EusmELdJy9KsBYpbPID7/np5WG/MEKrRLUs8K9yuGPCkV6/VJFryGqsSd1R8kyprgloT6OEJVygVyEyyfKwzBNPhus+s+wzaNuJPofIOk3EM6JVGxdXlmVtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470934; c=relaxed/simple;
	bh=hPpGrhBm7dswjrLDv/THjvYEQrlbFx3TtA9jAFW1hNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5++CGi0MhKZ432nKGaT8VHsYqyU5sOW5yT1tVUL7qDjyeX4SjErgoiAQS1cJdfkVLYqOjvZ82/O0O3wSRAPJF1/DrfRtIj3fyPbwJIOeeW4nCVkyTpjEhoL/5AUa9W8X86aYNRUkSmrvvfjoknpCvEeHbwQEvkFM+gh2PqolJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h5vMqRcD; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/4
	b01nswZlIsKdbMEMUcNlPloW0gjn+e2EWs/AY2u78=; b=h5vMqRcDMQszMYc7kH
	zlJrIPRAkAycQg+758m3DthuXxZOqwZ4C1auOQOtpf0VEyR9Aco0leZenzLqR8FT
	1XrQ2iCdcDkmhq+jnwy2sQ7i+z+ewjPh5eSkZzEsGc0RFi2lvo6H4A6jYy1olcfb
	sDVn+XRZ6H2ipXagGaBTpee2M=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAH3axTuWhpe3IgLg--.97S10;
	Thu, 15 Jan 2026 17:54:51 +0800 (CST)
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
Subject: [net-next v6 8/8] net: wwan: mhi_wwan_ctrl: Add NMEA channel support
Date: Thu, 15 Jan 2026 17:54:17 +0800
Message-Id: <20260115095417.36975-9-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260115095417.36975-1-slark_xiao@163.com>
References: <20260115095417.36975-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAH3axTuWhpe3IgLg--.97S10
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW3Xw48Gr4fGr4kur1rJFb_yoWfKrgE9w
	1kXF9rJrW3J347KFsF9F13urWfK3W0qF4kXFnaqr9Yv347XFyfWw1kZF4Dtr9F9r17CF9r
	urnxWayFyw4fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRig4S5UUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvwz9YmlouWxo4wAA3z

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


