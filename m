Return-Path: <netdev+bounces-82417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C65C88DAED
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCB01C234FB
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CAD3A26E;
	Wed, 27 Mar 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpkyWlKT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FD3839D
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533828; cv=none; b=ScBa+b3fmh8xxbP4VfmPGajcpXXjnE8wzVI9EPrgQWplvjhPLLA9jPTMOGdH6cKekshSvaCEbXEUTsev5fs8ok0n3DFweeA9xKieA8rm8OenVfgjiB15DED+rib/pCkEOiG8QWIAzBHzadMUCDUmVGDy94JmGtIdF3ts9NL1Vvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533828; c=relaxed/simple;
	bh=ku8YzMn9QMy7xB2oEL6yj+qh7mh+oEzbTYBRUdDchNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nV4Jwzt9SHVDgjmD1g3Yvqcuz/wR/u/V75YaHIDnnfiIFcdNaAnHxbJ12H25QxHC3DbiAAoPHQ6A6geg0UNGAmir5u7W4DaqWVTunXnXNj7JYttQOpxL6/0Gh152lLW3kauRpmN8wyVVcgszCrfH8DHGb+imKU6ftb1hA0PS+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpkyWlKT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e740fff1d8so4711174b3a.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 03:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711533824; x=1712138624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXt+e70s18vvmZvnfHoG/leNZ6ipUAeaM1qUbwNwWzI=;
        b=SpkyWlKToGeED5GEmBsH+FvAz4j2tkZ5vcFt7XE/8hzSIJBbofCu2ntaeFhVcxm4Qq
         cuhDIa+DDNyQn5Qn0ppSx+KHrhNgW7MjvjluW6yFb9iqbrw2G4/hMLEFIjKWJ83sBbm/
         5mttAzNNsVRk83mz+qrCSlwobvKakFiEZruGapadFmpmcNTXeT1tvU3xb6IMuQxcgrdB
         KBfkvJXA3RemIyjaBrcX+OTgVDYFDIDAnRaxa/oWILXiAqT8jCQ9mDDQwyS88+7SkQuk
         sBj4Y5lPxI1K7eU+c9xUrR90soGVhs+MRRSSmV6K6tX0ZJLrS0rqB2a0HWvFZrycKsap
         Fojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711533824; x=1712138624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXt+e70s18vvmZvnfHoG/leNZ6ipUAeaM1qUbwNwWzI=;
        b=hLNrFxhVIEwCbLz5j47xyEntfvCf7bKtjx8iym3yX6Y0/N25JXvXB38mW4RVjQG+u0
         mbguMsNZ8Oy//oJlTcYW2D/oe0xjNJeVldHc/yszKD+Ju6o5EaVPPN0Y1xdYD3rTKuUC
         sESk/ZsJh0/Vq2x0DWG/JxzLop0/7hW9A5ESup8YR0aRTz7oIq0QUOJDHGEPAR/fuy/b
         i01HCw6FNK0ZUBzMrVhjIKvrwC2DRexf0qR/5WApnYgciYsGQl2yNpHKQSe17fNO5V33
         HvJCFWOB832F7T9L3Qr9wwyhMK2O/wMQd+GdY+RazUB4jHgEjW+ZTjRkDaj09jnvMblI
         oUZw==
X-Gm-Message-State: AOJu0Yy7y3ZtLHW64CYEdFu3CW4gzrFi081v8Qg7Y4OmxImRU/NplvXd
	S4L1TGUvppcdPa95malqqz+U+04QZUfTRUP0xZOGS2Sc8ITCXhZ62YDTTKkZp2WPSOH6
X-Google-Smtp-Source: AGHT+IEf+zyw9sNJRMvvaEpnz8K2n03fycAQaOKh9rm5XHy/rstFjyUYM/rdpkG8fvpNrm+vD176mw==
X-Received: by 2002:a05:6a21:3284:b0:1a3:68ff:5805 with SMTP id yt4-20020a056a21328400b001a368ff5805mr2294595pzb.44.1711533824026;
        Wed, 27 Mar 2024 03:03:44 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b006e6b2ba1577sm7478913pfn.138.2024.03.27.03.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 03:03:43 -0700 (PDT)
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
Subject: [PATCHv2 net-next 4/4] uapi: team: use header file generated from YAML spec
Date: Wed, 27 Mar 2024 18:03:18 +0800
Message-ID: <20240327100318.1085067-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327100318.1085067-1-liuhangbin@gmail.com>
References: <20240327100318.1085067-1-liuhangbin@gmail.com>
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


