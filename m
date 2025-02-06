Return-Path: <netdev+bounces-163385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9699CA2A186
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F561889835
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B472248BD;
	Thu,  6 Feb 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="QCnWGTQs"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6162253F1;
	Thu,  6 Feb 2025 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824588; cv=none; b=S1bxLbTSM9GGJSkLMESuMB9rIyTG9j53Ra1EnVU5LPyb8B+jREmv1TP5wKVzR13fuo2Iswo+JcxrpWxOEPPGkkz04vGM5XCtAvavzHDsw39jGURKrU8Lu69OG44W8D2T7sCT1hcV2oRFbOoOO3EKn+xvj5dfdntMMZCUwSfEp+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824588; c=relaxed/simple;
	bh=OZ4p2TEAvzA91NztAkEF+aQDuYd4qBx+l/3Y/5SUh8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDGRqd8s/In5NLKSTkkNgqUEespoak/kaDyvUwBd5QIteyG184vAl/1ZSLMUoc/a3n8GoYYYPaSXJBg4tbU4pgtwr/H0EEZ7bza0UIgoL0ERIBPDS514ZdG/TwEu5N2kjsoUKbnSsCLPI7JX8WJ3mXopceu7whVPq0nGWwCpYD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=QCnWGTQs; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738824578;
	bh=CPJTzz7OWYTv87v/HjNuVZKCN3qivXN5AxZ00A5JUKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QCnWGTQswMqH8vbsvwU/sO21/daPLxrakjMNzK+2ZO3Yko1JpTjmmLymBxubXzyko
	 zhenxCdvSZ4LUl0xKF3WmuV4Aqvl3nRtdxpOP3bCAYnsa92AwhqYadgwG64Y+KMrTe
	 Px0IhfdUP+eiMpM4XiFwDg5/UjcBGva0WVt6IWtmm+C715CZsFKfWRK8Vwn5/tCmsB
	 MrIRe+o376yiz+6y4W+jGNXuMFNnMLNKr7FeVKeZWxgLVu5KvxzNIYc0PDFFSXWnK6
	 knAinzuD8YPU4Ezo4uJBc5zxmxea6gQPjMa23aWKI2tenQIOPTLtv2G+aWSZvIilBM
	 AeS/E1gqZwwiA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 8DDBF74887; Thu,  6 Feb 2025 14:49:38 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 06 Feb 2025 14:48:23 +0800
Subject: [PATCH net-next 1/2] usb: Add base USB MCTP definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-dev-mctp-usb-v1-1-81453fe26a61@codeconstruct.com.au>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
In-Reply-To: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
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
 MAINTAINERS                  |  1 +
 include/linux/usb/mctp-usb.h | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/usb/ch9.h |  1 +
 3 files changed, 30 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 79756f2100e001177191b129c48cf49e90173a68..f4e093674cf07260ca1cbb5a8873bdff782c614d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13775,6 +13775,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/mctp.rst
 F:	drivers/net/mctp/
+F:	include/linux/usb/mctp-usb.h
 F:	include/net/mctp.h
 F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
new file mode 100644
index 0000000000000000000000000000000000000000..ad58a7edff8d5228717f9add22615c3fad7d4cde
--- /dev/null
+++ b/include/linux/usb/mctp-usb.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * mctp-usb.h - MCTP USB transport binding: common definitions.
+ *
+ * These are protocol-level definitions, that may be shared between host
+ * and gadget drivers.
+ *
+ * Copyright (C) 2024 Code Construct Pty Ltd
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


