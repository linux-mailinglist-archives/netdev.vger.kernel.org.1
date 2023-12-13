Return-Path: <netdev+bounces-56775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE297810CB4
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089BFB20C73
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF711F927;
	Wed, 13 Dec 2023 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZPLHz1j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D84AF4
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:45:18 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce94f62806so3672221b3a.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702457117; x=1703061917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXt+e70s18vvmZvnfHoG/leNZ6ipUAeaM1qUbwNwWzI=;
        b=PZPLHz1jDIL6NfW9LJ3TtdlzVNpLN508/vfZD+/VwhE5GOLvIZx3HQyhe82ToSGE76
         E27zwqHrGqwJZsC+be1L8Y+aCNGLALUJ3y11pAHX8HnX/29b3B6B0WpHKHp//UZ7qrNR
         l8r0GsQYdE1ij8MwULOvOkHENcbiJzy0R3B+seoQhRLOITyIZuLL5X2Cy7FIJWChUFyd
         NECRUNdBduD45AFONJ7ETlzXTri5yxTzX4Y9naJbyNev2f2SUnYYw0Hjw2fm2BbVhIOW
         Hk+Mbs30mFt/YrGw75eZgqaqUtxRYXN/bUBEbhfXQFXsA9l6t6YB1vXA69oRj5CIBPMn
         uscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457117; x=1703061917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXt+e70s18vvmZvnfHoG/leNZ6ipUAeaM1qUbwNwWzI=;
        b=QloznM/LCEmehxzWsZTGieWMXJjKHOBeb1Q8IE5tl8J7ADfU4ctvP7FmwPhcpMRwhr
         DRhGHayG0oFs+M6JXyWa6N/K62Jq7awxaxJMFbYZr+k/QGdO9G2Ynr+gZ10Sex9EKcyq
         zJY6fcrfj0E4YIMwHwgJo3DHuIbMm0p4V9qVYrZo5W/o/YixqV2oXsNVkT3O8MBhSDXK
         RJKyw+YckecmhXS6brdgvh3K9gbOSUoI9MZMCvb/VxBvLChRje7KfZYzhv2O/eCo4Rqq
         yFnTLzMIiWU+6PvEiihhHNVb3NBY8IIp6+tBqbVkh1W8+oHUvKwxa08Wpkf1D+wSi9N1
         wDsw==
X-Gm-Message-State: AOJu0YxQEKL/6Ew1Hlwc3fm3dxBaeNYW+wEaMspS01a5EBs84UbH46BV
	oDiRTMMkwXZC2mVNjGofUI62XwiQ9DPHTYaAfj8=
X-Google-Smtp-Source: AGHT+IH5kP7AhrmVPo3RJ2iT//G/47RMdOIWxy+LKUxYWdfi9Iv3tfua4SNhPFM8N/4EKoElq2/46g==
X-Received: by 2002:a05:6a20:a8a1:b0:18c:a8fe:42f3 with SMTP id ca33-20020a056a20a8a100b0018ca8fe42f3mr3423398pzb.19.1702457117397;
        Wed, 13 Dec 2023 00:45:17 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f54200b001cfc67d46efsm9897824plf.191.2023.12.13.00.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 00:45:16 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [Draft PATCH net-next 3/3] uapi: team: use header file generated from YAML spec
Date: Wed, 13 Dec 2023 16:45:02 +0800
Message-ID: <20231213084502.4042718-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213084502.4042718-1-liuhangbin@gmail.com>
References: <20231213084502.4042718-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generated with:

 $ ./tools/net/ynl/ynl-gen-c.py --mode uapi \
 > --spec Documentation/netlink/specs/team.yaml \
 > --header -o include/uapi/linux/if_team.h

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/uapi/linux/if_team.h | 116 +++++++++++++----------------------
 1 file changed, 43 insertions(+), 73 deletions(-)

diff --git a/include/uapi/linux/if_team.h b/include/uapi/linux/if_team.h
index 13c61fecb78b..a5c06243a435 100644
--- a/include/uapi/linux/if_team.h
+++ b/include/uapi/linux/if_team.h
@@ -1,108 +1,78 @@
-/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
-/*
- * include/linux/if_team.h - Network team device driver header
- * Copyright (c) 2011 Jiri Pirko <jpirko@redhat.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/team.yaml */
+/* YNL-GEN uapi header */
 
-#ifndef _UAPI_LINUX_IF_TEAM_H_
-#define _UAPI_LINUX_IF_TEAM_H_
+#ifndef _UAPI_LINUX_IF_TEAM_H
+#define _UAPI_LINUX_IF_TEAM_H
 
+#define TEAM_GENL_NAME		"team"
+#define TEAM_GENL_VERSION	1
 
-#define TEAM_STRING_MAX_LEN 32
-
-/**********************************
- * NETLINK_GENERIC netlink family.
- **********************************/
-
-enum {
-	TEAM_CMD_NOOP,
-	TEAM_CMD_OPTIONS_SET,
-	TEAM_CMD_OPTIONS_GET,
-	TEAM_CMD_PORT_LIST_GET,
-
-	__TEAM_CMD_MAX,
-	TEAM_CMD_MAX = (__TEAM_CMD_MAX - 1),
-};
+#define TEAM_STRING_MAX_LEN			32
+#define TEAM_GENL_CHANGE_EVENT_MC_GRP_NAME	"change_event"
 
 enum {
 	TEAM_ATTR_UNSPEC,
-	TEAM_ATTR_TEAM_IFINDEX,		/* u32 */
-	TEAM_ATTR_LIST_OPTION,		/* nest */
-	TEAM_ATTR_LIST_PORT,		/* nest */
+	TEAM_ATTR_TEAM_IFINDEX,
+	TEAM_ATTR_LIST_OPTION,
+	TEAM_ATTR_LIST_PORT,
 
 	__TEAM_ATTR_MAX,
-	TEAM_ATTR_MAX = __TEAM_ATTR_MAX - 1,
+	TEAM_ATTR_MAX = (__TEAM_ATTR_MAX - 1)
 };
 
-/* Nested layout of get/set msg:
- *
- *	[TEAM_ATTR_LIST_OPTION]
- *		[TEAM_ATTR_ITEM_OPTION]
- *			[TEAM_ATTR_OPTION_*], ...
- *		[TEAM_ATTR_ITEM_OPTION]
- *			[TEAM_ATTR_OPTION_*], ...
- *		...
- *	[TEAM_ATTR_LIST_PORT]
- *		[TEAM_ATTR_ITEM_PORT]
- *			[TEAM_ATTR_PORT_*], ...
- *		[TEAM_ATTR_ITEM_PORT]
- *			[TEAM_ATTR_PORT_*], ...
- *		...
- */
-
 enum {
 	TEAM_ATTR_ITEM_OPTION_UNSPEC,
-	TEAM_ATTR_ITEM_OPTION,		/* nest */
+	TEAM_ATTR_ITEM_OPTION,
 
 	__TEAM_ATTR_ITEM_OPTION_MAX,
-	TEAM_ATTR_ITEM_OPTION_MAX = __TEAM_ATTR_ITEM_OPTION_MAX - 1,
+	TEAM_ATTR_ITEM_OPTION_MAX = (__TEAM_ATTR_ITEM_OPTION_MAX - 1)
 };
 
 enum {
 	TEAM_ATTR_OPTION_UNSPEC,
-	TEAM_ATTR_OPTION_NAME,		/* string */
-	TEAM_ATTR_OPTION_CHANGED,	/* flag */
-	TEAM_ATTR_OPTION_TYPE,		/* u8 */
-	TEAM_ATTR_OPTION_DATA,		/* dynamic */
-	TEAM_ATTR_OPTION_REMOVED,	/* flag */
-	TEAM_ATTR_OPTION_PORT_IFINDEX,	/* u32 */ /* for per-port options */
-	TEAM_ATTR_OPTION_ARRAY_INDEX,	/* u32 */ /* for array options */
+	TEAM_ATTR_OPTION_NAME,
+	TEAM_ATTR_OPTION_CHANGED,
+	TEAM_ATTR_OPTION_TYPE,
+	TEAM_ATTR_OPTION_DATA,
+	TEAM_ATTR_OPTION_REMOVED,
+	TEAM_ATTR_OPTION_PORT_IFINDEX,
+	TEAM_ATTR_OPTION_ARRAY_INDEX,
 
 	__TEAM_ATTR_OPTION_MAX,
-	TEAM_ATTR_OPTION_MAX = __TEAM_ATTR_OPTION_MAX - 1,
+	TEAM_ATTR_OPTION_MAX = (__TEAM_ATTR_OPTION_MAX - 1)
 };
 
 enum {
 	TEAM_ATTR_ITEM_PORT_UNSPEC,
-	TEAM_ATTR_ITEM_PORT,		/* nest */
+	TEAM_ATTR_ITEM_PORT,
 
 	__TEAM_ATTR_ITEM_PORT_MAX,
-	TEAM_ATTR_ITEM_PORT_MAX = __TEAM_ATTR_ITEM_PORT_MAX - 1,
+	TEAM_ATTR_ITEM_PORT_MAX = (__TEAM_ATTR_ITEM_PORT_MAX - 1)
 };
 
 enum {
 	TEAM_ATTR_PORT_UNSPEC,
-	TEAM_ATTR_PORT_IFINDEX,		/* u32 */
-	TEAM_ATTR_PORT_CHANGED,		/* flag */
-	TEAM_ATTR_PORT_LINKUP,		/* flag */
-	TEAM_ATTR_PORT_SPEED,		/* u32 */
-	TEAM_ATTR_PORT_DUPLEX,		/* u8 */
-	TEAM_ATTR_PORT_REMOVED,		/* flag */
+	TEAM_ATTR_PORT_IFINDEX,
+	TEAM_ATTR_PORT_CHANGED,
+	TEAM_ATTR_PORT_LINKUP,
+	TEAM_ATTR_PORT_SPEED,
+	TEAM_ATTR_PORT_DUPLEX,
+	TEAM_ATTR_PORT_REMOVED,
 
 	__TEAM_ATTR_PORT_MAX,
-	TEAM_ATTR_PORT_MAX = __TEAM_ATTR_PORT_MAX - 1,
+	TEAM_ATTR_PORT_MAX = (__TEAM_ATTR_PORT_MAX - 1)
 };
 
-/*
- * NETLINK_GENERIC related info
- */
-#define TEAM_GENL_NAME "team"
-#define TEAM_GENL_VERSION 0x1
-#define TEAM_GENL_CHANGE_EVENT_MC_GRP_NAME "change_event"
+enum {
+	TEAM_CMD_NOOP,
+	TEAM_CMD_OPTIONS_SET,
+	TEAM_CMD_OPTIONS_GET,
+	TEAM_CMD_PORT_LIST_GET,
+
+	__TEAM_CMD_MAX,
+	TEAM_CMD_MAX = (__TEAM_CMD_MAX - 1)
+};
 
-#endif /* _UAPI_LINUX_IF_TEAM_H_ */
+#endif /* _UAPI_LINUX_IF_TEAM_H */
-- 
2.43.0


