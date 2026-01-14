Return-Path: <netdev+bounces-249766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B53ED1D6E5
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 618BA3011A5A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712A3815D0;
	Wed, 14 Jan 2026 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PROpqXr2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93937F8D7
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381408; cv=none; b=bEuJCCBiOy+Zu7Yj9F3s8JPHinFfy3Z1/reP0+a1iuMnzhBXcQ9ao/Iahlcp/wls/kUvMh5dM6LcgeJgpN9A5XlWDLXF9oTIOhj72bu09nmz0pfbe4QLFqW+Nmd9PtfMaqRw7KSfbrl9A5bEuUpFqOpFJ5K+8fmvj02D3XX6BSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381408; c=relaxed/simple;
	bh=mU6ejUGlwUAibc9npSixGfRqp5mvk3uT2gxe6YRqu2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jg5VkS3kD7ktdLvg7/RbV9d4cyhCE1vm88MkhwYD9dvaMH0g5mI66kBdZN3PaEk7HSFv70sLzQi7aOSZoRLffdoDkiUWuM1EIEsr3XYoodGN3FAT9LBssFPqK06XnYmFGF3r3egIrv7M3gxr05Fgu6gYc+QsohxRWlYg4q9zpds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PROpqXr2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768381404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Ohio87n6rJ1fHkc1Q0/QDujSz+L4naGbi/eaeFTmR0=;
	b=PROpqXr2xFU+48hx4QTXNfvss53tZX38CIk8bN+32FOn8uYnGYSeLrq1KOHPgqa6ykHKMd
	xwHEnvQlL19Uu3dqgtZo7MJbYCgrLZsFRJNSnVgOxa7le7fTlzspr1/8YOq5vYlGxEzjzC
	2EqFDzhuKD1BWprVHowfh3yZYv8lp1c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-XTQSlR3qNzSKVAEQByTgxw-1; Wed,
 14 Jan 2026 04:03:23 -0500
X-MC-Unique: XTQSlR3qNzSKVAEQByTgxw-1
X-Mimecast-MFC-AGG-ID: XTQSlR3qNzSKVAEQByTgxw_1768381402
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E01B195605F;
	Wed, 14 Jan 2026 09:03:22 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.32.149])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2066D1800665;
	Wed, 14 Jan 2026 09:03:19 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] usbnet: limit max_mtu based on device's hard_mtu
Date: Wed, 14 Jan 2026 10:03:17 +0100
Message-ID: <20260114090317.3214026-1-lvivier@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The usbnet driver initializes net->max_mtu to ETH_MAX_MTU before calling
the device's bind() callback. When the bind() callback sets
dev->hard_mtu based the device's actual capability (from CDC Ethernet's
wMaxSegmentSize descriptor), max_mtu is never updated to reflect this
hardware limitation).

This allows userspace (DHCP or IPv6 RA) to configure MTU larger than the
device can handle, leading to silent packet drops when the backend sends
packet exceeding the device's buffer size.

Fix this by limiting net->max_mtu to the device's hard_mtu after the
bind callback returns.

See https://gitlab.com/qemu-project/qemu/-/issues/3268 and
    https://bugs.passt.top/attachment.cgi?bugid=189

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/net/usb/usbnet.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 36742e64cff7..8dbbeb8ce3f8 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1821,9 +1821,14 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 		if ((dev->driver_info->flags & FLAG_NOARP) != 0)
 			net->flags |= IFF_NOARP;
 
-		/* maybe the remote can't receive an Ethernet MTU */
-		if (net->mtu > (dev->hard_mtu - net->hard_header_len))
-			net->mtu = dev->hard_mtu - net->hard_header_len;
+		/* limit max_mtu to the device's hard_mtu */
+		if (net->max_mtu > (dev->hard_mtu - net->hard_header_len))
+			net->max_mtu = dev->hard_mtu - net->hard_header_len;
+
+		/* limit mtu to max_mtu */
+		if (net->mtu > net->max_mtu)
+			net->mtu = net->max_mtu;
+
 	} else if (!info->in || !info->out)
 		status = usbnet_get_endpoints(dev, udev);
 	else {
-- 
2.52.0


