Return-Path: <netdev+bounces-246404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 940D8CEB66C
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 07:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B78D5301C958
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 06:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4B22EAB6E;
	Wed, 31 Dec 2025 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F/JSmNWB"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42D1E5B70;
	Wed, 31 Dec 2025 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767163945; cv=none; b=UUTHnaVUw4DMmGiLg2qKAIsOPHHmpkFDSegoNM7zQJbT4C3alQXVyBhHs+mtER00A1Htj0MEkvrjdRVqidIIdVyJbFIjzh7mYxyk+mMO79YfSsIe+vhG+Y8pT/bgTs4A3WLV+zuHeujrh+34TsRa2dFJBi4I4V33h84sQuEpOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767163945; c=relaxed/simple;
	bh=QJwR31LUjagdVEaSKK25/11zLr/1MNw+I0HRRvelUeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKjHfl0NeYgUNE04DC5FdpQKl1vH/HVDKpBXk03r2U6J1UtRYF0rpHR7X8LmKxLiAMjwKIbFNT6I5VIC4csXeEY8W4o6/mUZ2tRaa5t0LvlRJdNdF25APXB7M9ZbI63LHEZgzSg0L/xtAeJCjBa3fVAzY02yh+KpzzdAGuRyO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F/JSmNWB; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=LX
	Da7p8qMOIcHKrHr4whPEp5/2uFN+0BctnZg49fC7g=; b=F/JSmNWByya61yLP3c
	cWI9vJenqcSXHD4/xPHhMvqeQ0X5TdJiyknKonLDjBS7ZSr2r+iZRiOUruz3ZPdL
	nyCOJyscN3uBKVALPoFjsdbVLj8rBCLXplWxgeVkx2YXNXfZqi8E5uJFFo7XG6K2
	7wsNljzLKRDYCWfgJGph/AmL4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHpCPmx1Rp9FyCDg--.29927S10;
	Wed, 31 Dec 2025 14:51:44 +0800 (CST)
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
Subject: [net-next v3 8/8] net: wwan: mhi_wwan_ctrl: Add NMEA channel support
Date: Wed, 31 Dec 2025 14:51:09 +0800
Message-Id: <20251231065109.43378-9-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231065109.43378-1-slark_xiao@163.com>
References: <20251231065109.43378-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHpCPmx1Rp9FyCDg--.29927S10
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW3Xw48Gr4fGrWDAF45Awb_yoWfWwbE9w
	1DXF9rJrW5W34UKFsFgF13ZryfKw10qF4kXFnavrZYv347XryfWw1kZF4Dtr9Fkr17CF9F
	9rnxWayFyw4fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNGYltUUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwAChBmlUyACrowAA3a

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


