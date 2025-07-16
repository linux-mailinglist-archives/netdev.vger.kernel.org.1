Return-Path: <netdev+bounces-207322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA49B06A5B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5354E44CF
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61B22746C;
	Wed, 16 Jul 2025 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bFL8hYiT"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9615D1;
	Wed, 16 Jul 2025 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624936; cv=none; b=rE3JlDLDgaAZQdIhsGjHp7ooxFaHNM5pYk+UDkKsYNN1hJMaPUtsanXdZEA4UudwhLNazEJlgVH534QeM2DB2xcky4S4tqgTQwoyvuu5go1Vd/C1Lsid4oxS493qroiYw4CxP81gHsHylq9hpGTJUlVAaPV3FoS6q7urDhuwMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624936; c=relaxed/simple;
	bh=U9WT3Sa5XT2rFbxAIA6n4tmS7VNkIAjEECATb45mesk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BX0U0E8Tph9DCMi65hEJ5MKpLfKGv3Zax1p5vsqNWyvSPZOHc1ezlrsrFXwbEevNmZFebOXHBowP6G1HXBYSbKB8L9e8A7TZzi/Xes95dCbgSso98PNii6oAXf/+7SsMHuWXR35g17ToV8MmowWiGxdlPRG0R1O/KqRY9O62H40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bFL8hYiT; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752624931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dw1/tNCr8/y5ixyes0oliGaYf+H4IQ7j2Lhoby7Ej4U=;
	b=bFL8hYiTeGhQryhkV8O8F3Ty92Suq/E4GQeDAWKNNSMwhkGFkC/TSRAFx0OPncVT+5jEs8
	OQt8nL7tzWIR8CZUhFM1Xu0D6Szhvpl1kBMEqqixlGPaOg/pfziHQVWbjR8YqGDbqjmkLA
	fg+njft2tLKJpP6aXlyIFdQg2xS9Wv0=
From: Zqiang <qiang.zhang@linux.dev>
To: oneukum@suse.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com
Cc: qiang.zhang@linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: Remove duplicate assignments for net->pcpu_stat_type
Date: Wed, 16 Jul 2025 08:15:24 +0800
Message-ID: <20250716001524.168110-2-qiang.zhang@linux.dev>
In-Reply-To: <20250716001524.168110-1-qiang.zhang@linux.dev>
References: <20250716001524.168110-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This commit remove duplicate assignments for net->pcpu_stat_type
in usbnet_probe().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 drivers/net/usb/usbnet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 6a3cca104af9..921c05bc73e3 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1759,7 +1759,6 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	dev->hard_mtu = net->mtu + net->hard_header_len;
 	net->min_mtu = 0;
 	net->max_mtu = ETH_MAX_MTU;
-	net->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	net->netdev_ops = &usbnet_netdev_ops;
 	net->watchdog_timeo = TX_TIMEOUT_JIFFIES;
-- 
2.48.1


