Return-Path: <netdev+bounces-23988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7854D76E698
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D55D2812DF
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D121D2FD;
	Thu,  3 Aug 2023 11:14:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D91DDFD
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:14:00 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB417B2
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:13:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so1009589a12.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061237; x=1691666037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acl+6MFV+mmBUdW1tpmvr9zmTCsPCF2C2c03qMnY7Pk=;
        b=jWuRzMRSykF7eeev+a1N6KIwEQ6X00brNqVNKjQk1lQQhkyBbbm1L5jDmtiqtddOAz
         xTORfVzSTFqoJK1rqCwK0vJxiadxvs+8L44KHEqDO9rxdOOriHKm7xwHnrrxM6INf5QZ
         kXpTR+EV3Sp9qVNuAEnlojxivUBx2ov5eOyNK2DLv1EURKG8V+4RZH1+a3VGppTBPZYk
         rxS1HvKGfzyuBY+c1SpBl0ejk4Dqr+bpCFYB2s5S/Psofl3UziHNb/k650ZSIoFAJHIE
         XFnWnMqciQvF4KHRG30qlrTvZ3IKN6XlVWm2zRCeZaou9dJ/BVTWfJ4ah2kK+Pt6MmCP
         GfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061237; x=1691666037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acl+6MFV+mmBUdW1tpmvr9zmTCsPCF2C2c03qMnY7Pk=;
        b=H/RrrgJ3AIcebHkYQJEDuj0D4ObrTjNvsI1uqGjq1x+ncXu74zzIRuCj9BhbnHMmiW
         FzEaE12Et5f6PJELAC3ptgbJpr6UAyjiZPAZIlq3BBc8aGQDVYp9UM5/RHAo76rb2mJx
         9W5bU0MmA4vwsclSNbz+Sp5kFsaEocXMdGx+w9Lxz552VJl9cZ1YfCk32vMwDZYTHmk8
         tegJ3EQYtHfJpwEXMpzVKcJ36ffT4yLauDl3qHGsm8ZaxupIAqOG5sGk6zfMteybWXfU
         hNq274bdvAzcdGnGP65LPn9avf2iJ15zLoeZyAsLW7twXFK0Wpbbh9d4dHhSmfN4UCbR
         7n5g==
X-Gm-Message-State: ABy/qLaBMtQrppv0F6A8qkkAeGzLdysMSoOwtxFg/wxhXqz94rzNb1Se
	TvzoQv/qq5jY3x1RWWH9gmfKOuN5GSAXxoV5Zn/NSw==
X-Google-Smtp-Source: APBJJlFz4iyOeKD1lHK/TXw+ASZx5LYDb8m1CNiBwPgJGfnNdo4/ILv8862P9CA2m5bLeGIlPOvH/A==
X-Received: by 2002:a05:6402:553:b0:522:2061:bc84 with SMTP id i19-20020a056402055300b005222061bc84mr7765775edx.24.1691061237314;
        Thu, 03 Aug 2023 04:13:57 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id j10-20020a50ed0a000000b0051e0cb4692esm9869017eds.17.2023.08.03.04.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:56 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next v3 10/12] devlink: add split ops generated according to spec
Date: Thu,  3 Aug 2023 13:13:38 +0200
Message-ID: <20230803111340.1074067-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803111340.1074067-1-jiri@resnulli.us>
References: <20230803111340.1074067-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Improve the existing devlink spec in order to serve as a source for
generation of valid devlink split ops for the existing commands.
Add the generated sources.

Node that the policies are narrowed down only to the attributes that
are actually parsed. The dont-validate-strict parsing policy makes sure
that other possibly passed garbage attributes from userspace are
ignored during validation.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- un-static devlink_nl_pre/post_doit() to fix the build
v1->v2:
- fixed "for" typo
- added note to patch description about narrowing down the policy
- moved info-get dump op addition to a separate patch
- regenerated files according to static policies change
---
 Documentation/netlink/specs/devlink.yaml | 10 ++++
 net/devlink/Makefile                     |  2 +-
 net/devlink/netlink_gen.c                | 59 ++++++++++++++++++++++++
 net/devlink/netlink_gen.h                | 29 ++++++++++++
 4 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 net/devlink/netlink_gen.c
 create mode 100644 net/devlink/netlink_gen.h

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 12699b7ce292..f6df0b3fd502 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -165,8 +165,13 @@ operations:
       name: get
       doc: Get devlink instances.
       attribute-set: devlink
+      dont-validate:
+        - strict
+        - dump
 
       do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
         request:
           value: 1
           attributes: &dev-id-attrs
@@ -189,8 +194,13 @@ operations:
       name: info-get
       doc: Get device information, like driver name, hardware and firmware versions etc.
       attribute-set: devlink
+      dont-validate:
+        - strict
+        - dump
 
       do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
         request:
           value: 51
           attributes: *dev-id-attrs
diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index ef91a76646a3..a087af581847 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := leftover.o core.o netlink.o dev.o health.o
+obj-y := leftover.o core.o netlink.o netlink_gen.o dev.o health.o
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
new file mode 100644
index 000000000000..32d8cbed0c30
--- /dev/null
+++ b/net/devlink/netlink_gen.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/devlink.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "netlink_gen.h"
+
+#include <uapi/linux/devlink.h>
+
+/* DEVLINK_CMD_GET - do */
+static const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
+/* DEVLINK_CMD_INFO_GET - do */
+static const struct nla_policy devlink_info_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
+/* Ops table for devlink */
+const struct genl_split_ops devlink_nl_ops[4] = {
+	{
+		.cmd		= DEVLINK_CMD_GET,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.pre_doit	= devlink_nl_pre_doit,
+		.doit		= devlink_nl_get_doit,
+		.post_doit	= devlink_nl_post_doit,
+		.policy		= devlink_get_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DEVLINK_CMD_GET,
+		.validate	= GENL_DONT_VALIDATE_DUMP,
+		.dumpit		= devlink_nl_get_dumpit,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DEVLINK_CMD_INFO_GET,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.pre_doit	= devlink_nl_pre_doit,
+		.doit		= devlink_nl_info_get_doit,
+		.post_doit	= devlink_nl_post_doit,
+		.policy		= devlink_info_get_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DEVLINK_CMD_INFO_GET,
+		.validate	= GENL_DONT_VALIDATE_DUMP,
+		.dumpit		= devlink_nl_info_get_dumpit,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+};
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
new file mode 100644
index 000000000000..11980e04a718
--- /dev/null
+++ b/net/devlink/netlink_gen.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/devlink.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_DEVLINK_GEN_H
+#define _LINUX_DEVLINK_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/devlink.h>
+
+/* Ops table for devlink */
+extern const struct genl_split_ops devlink_nl_ops[4];
+
+int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+			struct genl_info *info);
+void
+devlink_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		     struct genl_info *info);
+
+int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int devlink_nl_info_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_info_get_dumpit(struct sk_buff *skb,
+			       struct netlink_callback *cb);
+
+#endif /* _LINUX_DEVLINK_GEN_H */
-- 
2.41.0


