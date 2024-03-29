Return-Path: <netdev+bounces-83196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB24891531
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB482868B8
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 08:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E524D9E6;
	Fri, 29 Mar 2024 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgiAzp3B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F804D9E4
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711700949; cv=none; b=H5yNUyNBVMXilMug6GBYbrK5z6egBo4iRucU512MbHc26IJfFy2rrxxLY9MO/EGVbP7+tlh53U6bEccOHNpW3x39usiMjKXu8hVCYjO2WfFX4PxkUNS8XpKZ5GR+v13r0Hg7bfLS073OkRfCiLj6oUuLCkPqeEtMStG1rp7b5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711700949; c=relaxed/simple;
	bh=ku8YzMn9QMy7xB2oEL6yj+qh7mh+oEzbTYBRUdDchNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmiDIrW/f77MtwFFdwMq2RgLZIHb3et+j6uScV7dNOIWjj3iJW2wii52GJela7IVFILpwn2Y7sSOAcXv643QX9ObDVTPdDLdSiKduKOxHSrUv6ZdpQIhRCqqZb1Ov9d5pRYDbJeXBOvRwh2j8Zk9onaS/QlFvG90AOFeUpfCEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgiAzp3B; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dd161eb03afso1776387276.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711700946; x=1712305746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXt+e70s18vvmZvnfHoG/leNZ6ipUAeaM1qUbwNwWzI=;
        b=DgiAzp3BGGZFTDkUqXLPIJ/DhOriXlVfXuMvMooIGpuncjuSBxLH4FmliUtxvS4Izc
         ItJpizu3648U8gn8YoNLJfGG+vh/IVp64GvnIDEso85ze/vDYkY32K7inok4uUz1a6vX
         bDGeD/yTBRjctdrg5o8n6vvUT7PD/Ulx0mgk+07RdBt1D+AW0RDbHbkTJ1pG2RyePKBG
         qTFHl2nFqBg3sbyRV13bqMJ0Ct3u+BGlf64KglLukZMDf34O/NZECzME+xploCwLFG27
         yk56LqQktgePyQYmpiXMQwR/uAIZu60pLZFH8OWM+lypU8tbylLH4D5S2B9Kl/RtwNh2
         gp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711700946; x=1712305746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXt+e70s18vvmZvnfHoG/leNZ6ipUAeaM1qUbwNwWzI=;
        b=mUiEDGcD+m/pRsrT+bKXdmPx47AeN+YHvVlulF65ixr4oVbJfkzJsl6pL+jBhNwyx3
         Nr5ao+2VZuVkPkFbGkw7aMCfTHyU20jj31tk/4AlHoWlbNWA7vPtNM2ixlyrGJJKb1bu
         l4CdEcGyZF+b1kYquHyUDrDCE3pXSuK2gRuaMYzquPAXgYzZY2GFuzHs+z26dYR6bX7Y
         kOP71Vn+L2h+FepbUKFhXMi97n7e5tygYhHD5KaawvGOFVmljnFXw3XiKIr1TiVw5g0y
         EMwgtuTkOZp/99srOp/chOMJytEo3F2mvt7URleh5jF1gXw88uLZyXf9m+5EDygIOovq
         owGg==
X-Gm-Message-State: AOJu0YytL1wjuXhJr/MijeKC/iNJ7PQ5egIM0pij2ef6+/dOv2ND9s36
	eE423qeenVwDE71rH31YTaGkIM9PjH4LKkfw4YJ1sb9pRjwHX2h1BDM33yw3DnZfhxDF
X-Google-Smtp-Source: AGHT+IGgCxsLIbjx6d9hVV8K74ijBPDLZ1KPeodxZsXMOCmQhhSDTxfM3tdV6mJdE8Wq8L+slU5vbQ==
X-Received: by 2002:a25:6f89:0:b0:dc7:465d:c06d with SMTP id k131-20020a256f89000000b00dc7465dc06dmr1549516ybc.28.1711700946296;
        Fri, 29 Mar 2024 01:29:06 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b12-20020a056a000a8c00b006e5a915a9e7sm2656020pfl.10.2024.03.29.01.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 01:29:05 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 4/4] uapi: team: use header file generated from YAML spec
Date: Fri, 29 Mar 2024 16:28:47 +0800
Message-ID: <20240329082847.1902685-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329082847.1902685-1-liuhangbin@gmail.com>
References: <20240329082847.1902685-1-liuhangbin@gmail.com>
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


