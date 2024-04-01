Return-Path: <netdev+bounces-83704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AED8937B3
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 05:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996162818B2
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4A4C94;
	Mon,  1 Apr 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLtVAtij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41EC8BE7
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711941033; cv=none; b=J5VOtj4QW7cU6+qvPnPo1wSxYcgK86ccXjF6ZhmZbRLmzUyNQEJ/Cq4Hk7PHUpMrxngTcMhnCw5L+AVZD42F0YUlI+ATqQAsbgoRl9pItk2iOZdy/bMPtKjlc0p1X8mvh5qra+PJ22c9AGe5KRyhcGd0lO26yP9BWSeEfkRlPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711941033; c=relaxed/simple;
	bh=ku8YzMn9QMy7xB2oEL6yj+qh7mh+oEzbTYBRUdDchNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pk7gcnhlDlZb1xnXSf7UbVOyCpvP35c2vQFe8D2xjlj/SFw63g7GiDdFlrTF/1LdXm7oxAKw5UHik43pVP/q8/1yBJRm2EhBqlW0UafD+cRupG8Q0owArzEcnXK7meb8EDHc2z4z/Mcytw67Mnntuf3yDmAbRu6HWCmfhEGaHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLtVAtij; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e243ccbffbso7032265ad.3
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 20:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711941031; x=1712545831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXt+e70s18vvmZvnfHoG/leNZ6ipUAeaM1qUbwNwWzI=;
        b=dLtVAtijqSmTw08t5WInB/jio1gQrTzZthtaRLEEKUaxYhBb4GcQTiBetj82Ar9AvU
         uWyfWldntP/dzC2aY77eXkrHcqZC376ixkFqNOhgIwsWKV98+NArnkmuu4rkieuS84NX
         oZrYolZRHsStghCTtWxAMGUbBlaFv9L+WAf52RqGK72LHPwgd0gbwtA9lRhgTftazHI/
         3tzY2TZxLXzBLBXjJujY+H5SRyTWLQFeL9Z/AKUp0Ad5nyEH1JF6XeSX2bDe3YTBpuRp
         IdjSjeL4mKLDVUjC1P2mxZ9+PeqIDqL4tSx1rn7xDLj7WVGq3EypjUu8HATKXMAMyDFe
         zawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711941031; x=1712545831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXt+e70s18vvmZvnfHoG/leNZ6ipUAeaM1qUbwNwWzI=;
        b=AYFBctdoDyewMtVsWrm58RrV+y8vztkQWAKtqBPuCv+3xQZ5GfiPaFOxK2FOdpQAJ1
         5MCR6WAkGrG+PmavFR7wJHt0vfYJbDVimB4uwwGrsu7qPbG5KXa08Kr+pGNk5mf8KF6E
         xNt3BuSy8AGGiGu5SyrOoLoVjKkInMNiWynOMg+fVzyGybYlgeqJtBJfIxyGn5yLTqeK
         sfCq/qrWfbz8Qbj/8TKe+OFNV2b6dCxvlB4hLbK9vPoK1HmSQ94TPnwUk6ZIdd1VlW2I
         vT4buN1Azl8EvjoDAynhOyOBCy9KczlHGCBFJVDtws+y6oihkmj0Y2cosH1P2POpR7+8
         Og7Q==
X-Gm-Message-State: AOJu0YysBO/lagnACU6g6Bj38fbvoJhgeRv+R5B1nA0TqYM6RCHiq3dy
	WlCalqa3L7PLL8GKzzbaXgU45TDx7qYxRUG8a2clUeAwmcBgg+7uB5XnytsxxlpJdA==
X-Google-Smtp-Source: AGHT+IEXS137BcaOTa/vlLvaLkGUV11vzKhxJNFv9g/uPYTSxF4b5VR8M6Horum+L6QEo6rFTvdRMA==
X-Received: by 2002:a17:902:c084:b0:1e2:3cc0:f4bc with SMTP id j4-20020a170902c08400b001e23cc0f4bcmr5493412pld.27.1711941031001;
        Sun, 31 Mar 2024 20:10:31 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001e00ae60396sm7807464plk.91.2024.03.31.20.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 20:10:30 -0700 (PDT)
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
Subject: [PATCHv4 net-next 4/4] uapi: team: use header file generated from YAML spec
Date: Mon,  1 Apr 2024 11:10:04 +0800
Message-ID: <20240401031004.1159713-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401031004.1159713-1-liuhangbin@gmail.com>
References: <20240401031004.1159713-1-liuhangbin@gmail.com>
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


