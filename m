Return-Path: <netdev+bounces-168341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCFFA3E981
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C0219C8037
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055DF1CAA87;
	Fri, 21 Feb 2025 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bIAZFRGl"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EBF192D96;
	Fri, 21 Feb 2025 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099431; cv=none; b=GsUfSEOmK5Q8n9XwmTkE+zKLp3bN+rFuOeOMKGWu5VOXAb/7cqrzbpYHoH8eS5/yZ/9ifJgoukisKOwHR4yI8Ak2nX19MqCtA1tk8cMCode7lh+HyXzhdO5BJlS6y7SNMHM6eH4b6ph2dv+9X4rrwlmStQbjLwyGwfpXOjaiQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099431; c=relaxed/simple;
	bh=Mhst66kmKrIm+sg1YPCExZpth9I5Pw0L0khRNjmjk3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZqnBXXbc46ksQqcNzev9Lz0+ki6PoVUcumMwGx3HU1GZnZOsmeB2xAU1K05IwLQaPyNLB0NrJ8ypnOpaVkfeyrVm706VJ4ahMfiZDGN+I4TBFBThf/wB7uasUjgiTQ/V0+Act2Co2m1m2OoSFjplVc6uHGbqyz4dh2zZQwK1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bIAZFRGl; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1740099426;
	bh=j7P+g+DfPE1ixwT6fo+dp4YcW+7/Cg7z3OsGUGHtROI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bIAZFRGlcE1EhzdtYn0u/kgc09CwnkPDUh5eCjDDfD+a0K2JF5vwetNpkH9tddYsg
	 4hMidSfiobwH/9+1YlgNdTAGbkfbzpZhwFzLqbS2hneEycOPr1IzUokfD/HYZAXgiz
	 3j3t1S+VHIdh3H/Wjjrw/9x2g/isFSVozETacVBmijNswhZjmGgX4YWdVfEHhVZppN
	 9sTi2ojDXH25vdmn7djme8bGc/JcfFeKkc6SvO7nwczjDuAPBgJUiBIG+acbzxXYwa
	 siLbG2lYCnWmVVFZmDCPyIC8uuLZFOZdkgVlttPGxHQgQEBwKIf4n67DlOt0ZBXZnr
	 GtdVP16yKn4hA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id A486276C0A; Fri, 21 Feb 2025 08:57:06 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 21 Feb 2025 08:56:57 +0800
Subject: [PATCH net-next v3 1/2] usb: Add base USB MCTP definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-dev-mctp-usb-v3-1-3353030fe9cc@codeconstruct.com.au>
References: <20250221-dev-mctp-usb-v3-0-3353030fe9cc@codeconstruct.com.au>
In-Reply-To: <20250221-dev-mctp-usb-v3-0-3353030fe9cc@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 Santosh Puranik <spuranik@nvidia.com>
X-Mailer: b4 0.14.0

Upcoming changes will add a USB host (and later gadget) driver for the
MCTP-over-USB protocol. Add a header that provides common definitions
for protocol support: the packet header format and a few framing
definitions. Add a define for the MCTP class code, as per
https://usb.org/defined-class-codes.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
v3:
 - __u8 -> u8
 - GPL-2 rather than 2+
v2:
 - add reference & URL to DSP0283
 - update copyright year
---
 MAINTAINERS                  |  1 +
 include/linux/usb/mctp-usb.h | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/usb/ch9.h |  1 +
 3 files changed, 32 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67665d9dd536..e7b326dba9a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13903,6 +13903,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/mctp.rst
 F:	drivers/net/mctp/
+F:	include/linux/usb/mctp-usb.h
 F:	include/net/mctp.h
 F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
new file mode 100644
index 000000000000..a2f6f1e04efb
--- /dev/null
+++ b/include/linux/usb/mctp-usb.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mctp-usb.h - MCTP USB transport binding: common definitions,
+ * based on DMTF0283 specification:
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf
+ *
+ * These are protocol-level definitions, that may be shared between host
+ * and gadget drivers.
+ *
+ * Copyright (C) 2024-2025 Code Construct Pty Ltd
+ */
+
+#ifndef __LINUX_USB_MCTP_USB_H
+#define __LINUX_USB_MCTP_USB_H
+
+#include <linux/types.h>
+
+struct mctp_usb_hdr {
+	__be16	id;
+	u8	rsvd;
+	u8	len;
+} __packed;
+
+#define MCTP_USB_XFER_SIZE	512
+#define MCTP_USB_BTU		68
+#define MCTP_USB_MTU_MIN	MCTP_USB_BTU
+#define MCTP_USB_MTU_MAX	(U8_MAX - sizeof(struct mctp_usb_hdr))
+#define MCTP_USB_DMTF_ID	0x1ab4
+
+#endif /*  __LINUX_USB_MCTP_USB_H */
diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index 91f0f7e214a5..052290652046 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -330,6 +330,7 @@ struct usb_device_descriptor {
 #define USB_CLASS_AUDIO_VIDEO		0x10
 #define USB_CLASS_BILLBOARD		0x11
 #define USB_CLASS_USB_TYPE_C_BRIDGE	0x12
+#define USB_CLASS_MCTP			0x14
 #define USB_CLASS_MISC			0xef
 #define USB_CLASS_APP_SPEC		0xfe
 #define USB_SUBCLASS_DFU			0x01

-- 
2.39.5


