Return-Path: <netdev+bounces-284815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NteIuE2+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:41:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6134DA59F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1307A3021EA2
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827D44CF40;
	Wed,  6 May 2026 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="kN7alnMn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7120D449EC3
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071186; cv=none; b=qWeH6NOpSXOMdlzPdUagsmPFPdPom9L8em/PJ49Pc8WiGdDqb8Won4mx9+JviUE6O2SicU9Ji4eMZG1OXlYDsF5qMUHrJG6S33x8wlkYXLgspNg3YvWGxKUfuyQtj9pa2/sfSm9uk7B37a3PS0ZJmj/0zLV1NQtwtIs4thG5HWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071186; c=relaxed/simple;
	bh=k2OsgyNizxusADUde0S14UIFkxXaowbHk4UidSMtIxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwnCxZq2Wz1BCvTHhY40OhX08DQfBcrAVX97BEv2MSydf19tnAnRoNqPjYbfeFcf3FJwTYIBnynMZRc9ZuUbwKgaSkCeloi3eHX2c6Fkq1ECw3WlPO1u9k3AgyUcGDkQyvZ2NxKp26i4ebeBPviAbeUp2qZ6tdZ9wXZ2pOw1qp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=kN7alnMn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso48023795e9.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778071183; x=1778675983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+J3XqbnCoYpAGIzRu85OxjjRlSoL1F1apznBZBvmL0=;
        b=kN7alnMnOMyXU4H482oQdv3HwPLilXiX6/vOa8/br9j7nTSO+cqGJbeyP1q3tTVKyZ
         LntjB2EcJskhXPIl9j3l6ngvnvFznYYOyLQ25P/7F9LfDua/bRX/mH4vtpcOleOllU3X
         HDBx5FSFns6a/zmXf5mg5gl1aklov8GhB46olnWuSyg3q9Khau7HhjOls4GLzeEbnobm
         iru73HNrQZyh51wttt0DxeLBXgYHevosQs/Q34f0VfIC3xFF5AicBEm9ek65jsb2fxaw
         p7rRekdub/ZwjgEXmNkTjEkKmOwcveUT7lE7/vv9kEsDNPexTu9kP9oLU1yaHRFuId2v
         +C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071183; x=1778675983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+J3XqbnCoYpAGIzRu85OxjjRlSoL1F1apznBZBvmL0=;
        b=RBR+K9Kg9pamHAqAEGhv6xujI/B4T7XZs6YpieC522TwG1GUdt0ZfVF+ADIstl6Ota
         vQ9jowGaE4EPZd3u0Um4FJUgztxE0zuhUlko1iFcweKO7ONMeHpdjU3tFhVxNcIGkg1m
         9Vj3z1Wrj1Pan4BDt4hpmZmv5IZNx0dJHDFX0AF/yZA+d8S8xTShfJjHJnSmvABasBQI
         dwSAQUz1cX+iOFjIfF0qfPjbACPEV6W1EC7Rrt6tRYo4xxwI65N4yZpZAB/89gjp0yEZ
         FAUq3gc2fQx8mpSy7bogtwXcKlDU0q0Ve5BYUQTZ3nsgOrAw0Wuzw6fuA5tYiR/v8Sce
         Up4Q==
X-Forwarded-Encrypted: i=1; AFNElJ++nv0gW+NlqpB8bccifyc6XXV99m6uHHwkUjoMlfDuNxpfXgJL0PEmFLjzHTgqUN+lCBSuVZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLgs6JeQoSFefgfP6bZVdpwXpOvHDzQbOVNwWBij1fmi93ukp
	LsfzF6/80+joSwtzNCk+pQGstBmHW0a4PHMJ1i7eC6qMBpX5qfgVR/b+yrfV6OMZroU=
X-Gm-Gg: AeBDievYLECFx4xLS6Dx4DOWLG5D2KCGb6ZppaFOaArtLQ51x9/flfDPHxT8BR5ZWCG
	lhgmUpZFmLlnFuUykm16/MpKblpNkAFBhgoVb3skE2AQyUJ0uWkTTOSVmk0tN108ZfxretanBAn
	94PY5hCRwT/i3XnQj5abX1qUfzejgaLopSKHYhUu8QhPu5qhZ7A7Z6EDvDf5D/OtaZGlusqAoFW
	b5/iljvn332iRlxYxpy3QCufKPlFiltL9wW4l2oIZX6NiSk9xkdON1aI4uHcSJDoqoOWborDIw7
	oKmBquJfq1RWH9MpsGvR+o6nc5W1lMuUpV1n63PVYB5bobJHAgYLdIgh8lAL6bOzOLEAY7P3Xc5
	wSVvKSX0kjwrctDDuDHbxamxkwRwjm5fG/CQtwJYvIH7q2TorDRp4qCQx7rKRDeuYHZqu+J6hue
	bEArUQw3QwrqsKXbqqnvrBLXAVbNLTtG4dHYuBltW+Xa7JeKMvFiN365bhfJhKhg+rsuYAQLaut
	zRqbjVKeqm8WyPPnV829NkrZ/HM273A
X-Received: by 2002:a05:600d:8408:b0:489:fec9:a17e with SMTP id 5b1f17b1804b1-48e51f30534mr42486405e9.12.1778071182844;
        Wed, 06 May 2026 05:39:42 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53891d62sm76399015e9.1.2026.05.06.05.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:39:42 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 1/2] drbd: move UAPI headers to include/uapi/linux/
Date: Wed,  6 May 2026 14:39:25 +0200
Message-ID: <20260506123926.1944290-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506123926.1944290-1-christoph.boehmwalder@linbit.com>
References: <20260506123926.1944290-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8A6134DA59F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[linbit-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284815-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linbit-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linbit.com:mid,linbit.com:email,linbit-com.20251104.gappssmtp.com:dkim]

drbd.h and drbd_limits.h contain only type definitions, enums, and
constants shared between kernel and userspace. These should be part of
UAPI.

Split the genl_api header into two: the genlmsghdr and the enums are
UAPI, the rest stays there for now (it will be removed by one of the
next commits in this series).

drbd_config.h is clearly DRBD-internal, so move it there.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_buildtag.c            |  2 +-
 .../block/drbd}/drbd_config.h                 |  0
 drivers/block/drbd/drbd_int.h                 |  2 +-
 include/linux/drbd_genl_api.h                 | 40 ------------------
 include/{ => uapi}/linux/drbd.h               | 42 ++++++++++++++++++-
 include/{ => uapi}/linux/drbd_limits.h        |  2 +-
 6 files changed, 44 insertions(+), 44 deletions(-)
 rename {include/linux => drivers/block/drbd}/drbd_config.h (100%)
 rename include/{ => uapi}/linux/drbd.h (87%)
 rename include/{ => uapi}/linux/drbd_limits.h (99%)

diff --git a/drivers/block/drbd/drbd_buildtag.c b/drivers/block/drbd/drbd_buildtag.c
index cb1aa66d7d5d..cd0389488f63 100644
--- a/drivers/block/drbd/drbd_buildtag.c
+++ b/drivers/block/drbd/drbd_buildtag.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/drbd_config.h>
+#include "drbd_config.h"
 #include <linux/module.h>
 
 const char *drbd_buildtag(void)
diff --git a/include/linux/drbd_config.h b/drivers/block/drbd/drbd_config.h
similarity index 100%
rename from include/linux/drbd_config.h
rename to drivers/block/drbd/drbd_config.h
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f6d6276974ee..f3d746a6d6fd 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -34,7 +34,7 @@
 #include <linux/prefetch.h>
 #include <linux/drbd_genl_api.h>
 #include <linux/drbd.h>
-#include <linux/drbd_config.h>
+#include "drbd_config.h"
 #include "drbd_strings.h"
 #include "drbd_state.h"
 #include "drbd_protocol.h"
diff --git a/include/linux/drbd_genl_api.h b/include/linux/drbd_genl_api.h
index 70682c058027..19d263924852 100644
--- a/include/linux/drbd_genl_api.h
+++ b/include/linux/drbd_genl_api.h
@@ -2,46 +2,6 @@
 #ifndef DRBD_GENL_STRUCT_H
 #define DRBD_GENL_STRUCT_H
 
-/**
- * struct drbd_genlmsghdr - DRBD specific header used in NETLINK_GENERIC requests
- * @minor:
- *     For admin requests (user -> kernel): which minor device to operate on.
- *     For (unicast) replies or informational (broadcast) messages
- *     (kernel -> user): which minor device the information is about.
- *     If we do not operate on minors, but on connections or resources,
- *     the minor value shall be (~0), and the attribute DRBD_NLA_CFG_CONTEXT
- *     is used instead.
- * @flags: possible operation modifiers (relevant only for user->kernel):
- *     DRBD_GENL_F_SET_DEFAULTS
- * @volume:
- *     When creating a new minor (adding it to a resource), the resource needs
- *     to know which volume number within the resource this is supposed to be.
- *     The volume number corresponds to the same volume number on the remote side,
- *     whereas the minor number on the remote side may be different
- *     (union with flags).
- * @ret_code: kernel->userland unicast cfg reply return code (union with flags);
- */
-struct drbd_genlmsghdr {
-	__u32 minor;
-	union {
-	__u32 flags;
-	__s32 ret_code;
-	};
-};
-
-/* To be used in drbd_genlmsghdr.flags */
-enum {
-	DRBD_GENL_F_SET_DEFAULTS = 1,
-};
-
-enum drbd_state_info_bcast_reason {
-	SIB_GET_STATUS_REPLY = 1,
-	SIB_STATE_CHANGE = 2,
-	SIB_HELPER_PRE = 3,
-	SIB_HELPER_POST = 4,
-	SIB_SYNC_PROGRESS = 5,
-};
-
 /* hack around predefined gcc/cpp "linux=1",
  * we cannot possibly include <1/drbd_genl.h> */
 #undef linux
diff --git a/include/linux/drbd.h b/include/uapi/linux/drbd.h
similarity index 87%
rename from include/linux/drbd.h
rename to include/uapi/linux/drbd.h
index 5468a2399d48..7930a972d8a4 100644
--- a/include/linux/drbd.h
+++ b/include/uapi/linux/drbd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
 /*
   drbd.h
   Kernel module for 2.6.x Kernels
@@ -389,4 +389,44 @@ enum write_ordering_e {
 
 #define DRBD_CPU_MASK_SIZE 32
 
+/**
+ * struct drbd_genlmsghdr - DRBD specific header used in NETLINK_GENERIC requests
+ * @minor:
+ *     For admin requests (user -> kernel): which minor device to operate on.
+ *     For (unicast) replies or informational (broadcast) messages
+ *     (kernel -> user): which minor device the information is about.
+ *     If we do not operate on minors, but on connections or resources,
+ *     the minor value shall be (~0), and the attribute DRBD_NLA_CFG_CONTEXT
+ *     is used instead.
+ * @flags: possible operation modifiers (relevant only for user->kernel):
+ *     DRBD_GENL_F_SET_DEFAULTS
+ * @volume:
+ *     When creating a new minor (adding it to a resource), the resource needs
+ *     to know which volume number within the resource this is supposed to be.
+ *     The volume number corresponds to the same volume number on the remote side,
+ *     whereas the minor number on the remote side may be different
+ *     (union with flags).
+ * @ret_code: kernel->userland unicast cfg reply return code (union with flags);
+ */
+struct drbd_genlmsghdr {
+	__u32 minor;
+	union {
+		__u32 flags;
+		__s32 ret_code;
+	};
+};
+
+/* To be used in drbd_genlmsghdr.flags */
+enum {
+	DRBD_GENL_F_SET_DEFAULTS = 1,
+};
+
+enum drbd_state_info_bcast_reason {
+	SIB_GET_STATUS_REPLY = 1,
+	SIB_STATE_CHANGE = 2,
+	SIB_HELPER_PRE = 3,
+	SIB_HELPER_POST = 4,
+	SIB_SYNC_PROGRESS = 5,
+};
+
 #endif
diff --git a/include/linux/drbd_limits.h b/include/uapi/linux/drbd_limits.h
similarity index 99%
rename from include/linux/drbd_limits.h
rename to include/uapi/linux/drbd_limits.h
index 5b042fb427e9..a72a102d1ca7 100644
--- a/include/linux/drbd_limits.h
+++ b/include/uapi/linux/drbd_limits.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
   drbd_limits.h
   This file is part of DRBD by Philipp Reisner and Lars Ellenberg.
-- 
2.53.0


