Return-Path: <netdev+bounces-165376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641A3A31C3C
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2AAB188591D
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56EF1D5CC5;
	Wed, 12 Feb 2025 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="J50MWAYo"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7163154426;
	Wed, 12 Feb 2025 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328441; cv=none; b=bFB5MYroQ+9o2OTPIqJH0ayV9KXrckSLWcdLlSzuFQUX60Eev60z+NXvaE72Gj+1n8799LNnX8qnBJS4c9W5r6wdzGYzvp3xvglnzgtcKOQolAcP8JEObUYjhShxSB9RqSyrZYsmkLKEm7C9nUBsTkbM3GxYex0FVIcligbfYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328441; c=relaxed/simple;
	bh=iQWcraTsdGnPAfOCu3SSeB8ldVoydp4XA3qwnW186NA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFwBMVpYut5CYdAJCkWWlmY/8uST+SQVyonSt383l/tOalvzbkZlVQN5MwbcNenKwryTJPDh1RS2awlf7AqDRqcc0MepEBTZrJHRvvL68hwoQuvJFN+Gc1/C6r2u7nPP1xWeuIxnxTzyYgu0ikLHdk4qYRQYYADtaO1sx9z5vCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=J50MWAYo; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739328431;
	bh=WSkuDrCPHTBcR4s2iQvBzrYE7fMkGLA9E5ojLKGNvz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=J50MWAYosytUcKDQmg+NKpOLyRhVv9CVjaziixzjRhRb1+EXAom5APj9GzAsOw74S
	 VsTxsP7dZUifVBlgOYdrozXzy2CqNJrWQxhZtTc77nzbAyFeRxsD/C6bAXxoCf4HYG
	 IPI7XuC8CjE/p2EIABwxyPITI76albHqlQG8L6mT478G0xzxmJ8HcKDqpWaXa/5/N2
	 GtwwdDrvRtj3YZhLumCLkWUEqztlwTEaeP7bhU93fNWziW9sZQJF8RQQl93MyUrfI2
	 Nak5AndxtnAbaMO2q9kjusw3vpUlcSPkRDUjyj6rycEjZQ5qnMbjQm95XCdL6umTUv
	 59iYpojO25N8Q==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id B65577570B; Wed, 12 Feb 2025 10:47:11 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 12 Feb 2025 10:46:50 +0800
Subject: [PATCH net-next v2 1/2] usb: Add base USB MCTP definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-dev-mctp-usb-v2-1-76e67025d764@codeconstruct.com.au>
References: <20250212-dev-mctp-usb-v2-0-76e67025d764@codeconstruct.com.au>
In-Reply-To: <20250212-dev-mctp-usb-v2-0-76e67025d764@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 Santosh Puranik <spuranik@nvidia.com>
X-Mailer: b4 0.14.2

Upcoming changes will add a USB host (and later gadget) driver for the
MCTP-over-USB protocol. Add a header that provides common definitions
for protocol support: the packet header format and a few framing
definitions. Add a define for the MCTP class code, as per
https://usb.org/defined-class-codes.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v2:
 - add reference & URL to DSP0283
 - update copyright year
---
 MAINTAINERS                  |  1 +
 include/linux/usb/mctp-usb.h | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/usb/ch9.h |  1 +
 3 files changed, 32 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67665d9dd536873e94afffc00393c2fe2e8c2797..e7b326dba9a9e6f50c3beeb172d93641841f6242 100644
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
index 0000000000000000000000000000000000000000..b19392aa29310eda504f65bd098c849bd02dc0a1
--- /dev/null
+++ b/include/linux/usb/mctp-usb.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
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
+	__u8	rsvd;
+	__u8	len;
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
index 91f0f7e214a5a57c8bee3f44c4dbf7b175843d8c..052290652046591fba46f1f0cb5cf77fd965f555 100644
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


