Return-Path: <netdev+bounces-207321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6175CB06A5A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A06564473
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CB67483;
	Wed, 16 Jul 2025 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JTQb1Kvk"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273C128F5
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624934; cv=none; b=VPN4lKw3nyI6kZL8xTFYzvChOyHmmeVM1dRRsCRLT0VnANdrcZlJb2khL3vl9rsgzO9kQK3iPUz1WM/wAL82ESXdT9HsFPQl9LwN5Hhydgf07J33yHJloFKuWGOkuQi5YcIiv79HyMUvqSOYmA3uqM7avTJrOb5VMIrQddo2Qjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624934; c=relaxed/simple;
	bh=bF3eAJPKjlAX0gmHM4YTfXjMQhi+hJNSNb/htMc19BY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUM1iktk87sqVNq3c3LR1f5KJ81TlJVDP+7u6XM3pv/+cfcAaM9JqiJEJRKsXEZPJI7OtFkGvvMhQAplVgOXVfXXTnOK6uKFlcqNzzXMoHLIaY6T9ogLcToHSss7WkvqLyQ6aB/wG4x5GzZnm2qo5Xysxl0+UPK6hsRyDRx+x74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JTQb1Kvk; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752624930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NqDbyW0SQUqhy7PhdCLuIIofPAFpacRqZlTUSJkPTyE=;
	b=JTQb1Kvksng+jYaz/qIjlUMNHkTE6wJS+drkqD5B6/k3CPzRQtwKqfyb2H6msM8nV7uBRA
	y3ErCC9r3W8gycNE18Dr41nrdkPFjuhXXNaF3KTdv8h/r1dfC2UUk57d3tiDkIf/1DwamN
	AA0B31lDb7enfR1pMvq7BcpdkEVjiuY=
From: Zqiang <qiang.zhang@linux.dev>
To: oneukum@suse.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com
Cc: qiang.zhang@linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: Make init_satus() return -ENOMEM if alloc failed
Date: Wed, 16 Jul 2025 08:15:23 +0800
Message-ID: <20250716001524.168110-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This commit make init_status() return -ENOMEM, if invoke
kmalloc() return failed.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 drivers/net/usb/usbnet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 921c05bc73e3..26fce452581c 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -254,6 +254,8 @@ static int init_status (struct usbnet *dev, struct usb_interface *intf)
 				"status ep%din, %d bytes period %d\n",
 				usb_pipeendpoint(pipe), maxp, period);
 		}
+	} else {
+		return -ENOMEM;
 	}
 	return 0;
 }
-- 
2.48.1


