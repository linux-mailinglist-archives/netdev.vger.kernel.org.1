Return-Path: <netdev+bounces-81894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE388B88A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EB0B23105
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13796129A6A;
	Tue, 26 Mar 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxST6t1I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2986AC1
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423836; cv=none; b=Ct8agnBaR472lt1irmvcG1AJg50w08Zl/W3dwrYxLSq1O/XfQvfO7rIzeB61fpsPvWLaFgW8TpuKYGr3sYqFg4pG7YF6oWW1H48sGa+t5JOcsHwsVs+8zVydhX2I4+YiL8iVQTyUJo2i+qy1mRaPKW9uDtYsxQkQdiyBX1iozfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423836; c=relaxed/simple;
	bh=ku8YzMn9QMy7xB2oEL6yj+qh7mh+oEzbTYBRUdDchNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRuAUEaTXWsvaD2jNTedVYQFQRE47FniqFgLFC7OkMWrDvVuIkjaknk9deFHcl//ci/6NsKHXaahyD8c/3m2ME+tMpf1CZtxel1mxzPg/ZUlm8Y5dXwjfdpvQo+f0DR3+6m8V7D+g5hu/d6SHXCAMDpRL9V2Kx+QlHyHTq92Z+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxST6t1I; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6c0098328so3415896b3a.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711423833; x=1712028633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXt+e70s18vvmZvnfHoG/leNZ6ipUAeaM1qUbwNwWzI=;
        b=hxST6t1Iaai+BkGzQH0V367/ifl0eBvuUU6mjxDrj727ygQSnu5lafaLpRzF02Kiz3
         xKH3OQf++suzx8kLLS2YRI98jkQ5Q1K1+qPy8uDGyqGtGLOulUvSAktiaB9apImS/hS7
         wBDT62czZVCxMkuFMGLQOsZbfW5zhfzUxMTty9S0ggxSS2J84qnDQwuJKckHr7hthsvG
         bq0vDbiW4Md65ZodKUT9d3DpwvixrjG2d0f0a2yAKk2IORQS4IFul3en5CsuJJnLM05r
         FFbg1xPxUG+vAPF9M3SeJbv62dmI1n3wkmchcVYJubhWSO8Bm986Kp7gB95hU9qF26Kr
         luaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711423833; x=1712028633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXt+e70s18vvmZvnfHoG/leNZ6ipUAeaM1qUbwNwWzI=;
        b=ANVSRIkvkuSKk6HFlDHjeXVJrjiUpR7UDx7y6Q2Woyu1Z4rWNoki4yAngRXOcHn72p
         1HbAx10zMmxqEkEXlvY+Pz7BB6LH6EksdWox0tCvwRf3JxImRPwm8/TIlMOgK8bED77i
         GVsQ0Tsvn+Run5VAWRXXx9sOoqt8XJ3n5eL1t1jnVLtejYPUhpmeVEBYiGt9zj5bX4CX
         sU4MJuEqaRadip2wgkz+wzr6hyU/Fu6FImm+YUsZirham8KuZNF5X+yCf55/5tEYGpQm
         OMP95v21MrbBo0kn9FTF8I+E6ETKADR2bLIJzuR5sD6T9NtKuyF5PCD3JyZywC9Gowpm
         GYVg==
X-Gm-Message-State: AOJu0YzPKD8lGOrqF//Ingo+sO4GPS9x1DP1JYLfL1Iudh0gcIzJY/I4
	Qf1+ofSRlXCCZN5veZZdOXWP6kxC44Y+Okz0go/Ke18NaPdBWK3Z5suNqspwzXvC9w==
X-Google-Smtp-Source: AGHT+IGbCt+BVUMhC+CJnFo7YPm5UcKDsqSI9Gv29tzeBfu/U2NkmI3RXDKBWSE2Dxc4lfR4xm1mGA==
X-Received: by 2002:a05:6a20:8f0b:b0:1a3:b153:5f4e with SMTP id b11-20020a056a208f0b00b001a3b1535f4emr8893947pzk.54.1711423833368;
        Mon, 25 Mar 2024 20:30:33 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902654d00b001dd99fe365dsm5676310pln.42.2024.03.25.20.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 20:30:33 -0700 (PDT)
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
Subject: [PATCH net-next 4/4] uapi: team: use header file generated from YAML spec
Date: Tue, 26 Mar 2024 11:30:04 +0800
Message-ID: <20240326033005.2072622-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326033005.2072622-1-liuhangbin@gmail.com>
References: <20240326033005.2072622-1-liuhangbin@gmail.com>
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


