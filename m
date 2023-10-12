Return-Path: <netdev+bounces-40332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 660847C6C05
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A75E1C210DF
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA73924213;
	Thu, 12 Oct 2023 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C4022F19
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 11:14:28 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061A0C6;
	Thu, 12 Oct 2023 04:14:26 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9a645e54806so129367266b.0;
        Thu, 12 Oct 2023 04:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697109264; x=1697714064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azlBm1bMHX5sI/cuS/oB85eLn/m2Im3cX9O78MhWE54=;
        b=bro8zqXcehwrO4ezI3RZmUzadTXDhiL1ZDgtyvkNuIEAsez50/uTu3RKK94j9/I94f
         KUYMZKUZWY4gn3QO7M/hgEAfdz4T6gzY6RfRSP6FLseDY9ljjnOdfvg0+SHYnaPsLNsE
         lcYWVyfKVKg8clz68w2Xc9UneQS1FNN/aZ8JDI1LfGiaEhdh4LCRSogZKpgEtLkuM8H6
         c+dwq8rqGOz8+4TEJ15kl6jgTe3t4qQ5IWJroTn0chFb1wV3opPAGdZzabVihlqF2XxA
         WdIdlUx4NT/BRobcVam2j4QvV3uV3ompu9lwipw9DF6jvfKlWxU0nV0+MNjsqSWIIZ8V
         J3uA==
X-Gm-Message-State: AOJu0YyIiUblXJE2aex6tIsZfgMnXwBZNtk8z/5CkPGJjNS5MYScYjL3
	H/ba+cygxHsd/LrczWa4urI=
X-Google-Smtp-Source: AGHT+IFnjbzJ0tS0jn0JSP0OrzPHwvZ//zq0pQEckKVTBMtvYvx9oOE+GJDbjH7hjYUREJcgdVb8qQ==
X-Received: by 2002:a17:907:2711:b0:9b2:6c58:87a2 with SMTP id w17-20020a170907271100b009b26c5887a2mr19986752ejk.29.1697109264354;
        Thu, 12 Oct 2023 04:14:24 -0700 (PDT)
Received: from localhost (fwdproxy-cln-018.fbsv.net. [2a03:2880:31ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id x26-20020a170906711a00b0099329b3ab67sm10945121ejj.71.2023.10.12.04.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:14:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: jlbec@evilplan.org,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	Eric Dumazet <edumazet@google.com>
Cc: hch@lst.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net-next v4 2/4] netconsole: Initialize configfs_item for default targets
Date: Thu, 12 Oct 2023 04:13:59 -0700
Message-Id: <20231012111401.333798-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012111401.333798-1-leitao@debian.org>
References: <20231012111401.333798-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For netconsole targets allocated during the boot time (passing
netconsole=... argument), netconsole_target->item is not initialized.
That is not a problem because it is not used inside configfs.

An upcoming patch will be using it, thus, initialize the targets with
the name 'cmdline' plus a counter starting from 0.  This name will match
entries in the configfs later.

Suggested-by: Joel Becker <jlbec@evilplan.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d609fb59cf99..e153bce4dee4 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -53,6 +53,8 @@ static bool oops_only = false;
 module_param(oops_only, bool, 0600);
 MODULE_PARM_DESC(oops_only, "Only log oops messages");
 
+#define NETCONSOLE_PARAM_TARGET_PREFIX "cmdline"
+
 #ifndef	MODULE
 static int __init option_setup(char *opt)
 {
@@ -165,6 +167,10 @@ static void netconsole_target_put(struct netconsole_target *nt)
 {
 }
 
+static void populate_configfs_item(struct netconsole_target *nt,
+				   int cmdline_count)
+{
+}
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
 /* Allocate and initialize with defaults.
@@ -688,6 +694,17 @@ static struct configfs_subsystem netconsole_subsys = {
 	},
 };
 
+static void populate_configfs_item(struct netconsole_target *nt,
+				   int cmdline_count)
+{
+	char target_name[16];
+
+	snprintf(target_name, sizeof(target_name), "%s%d",
+		 NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
+	config_item_init_type_name(&nt->item, target_name,
+				   &netconsole_target_type);
+}
+
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
 /* Handle network interface device notifications */
@@ -887,7 +904,8 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 }
 
 /* Allocate new target (from boot/module param) and setup netpoll for it */
-static struct netconsole_target *alloc_param_target(char *target_config)
+static struct netconsole_target *alloc_param_target(char *target_config,
+						    int cmdline_count)
 {
 	struct netconsole_target *nt;
 	int err;
@@ -922,6 +940,7 @@ static struct netconsole_target *alloc_param_target(char *target_config)
 	if (err)
 		goto fail;
 
+	populate_configfs_item(nt, cmdline_count);
 	nt->enabled = true;
 
 	return nt;
@@ -954,6 +973,7 @@ static int __init init_netconsole(void)
 {
 	int err;
 	struct netconsole_target *nt, *tmp;
+	unsigned int count = 0;
 	bool extended = false;
 	unsigned long flags;
 	char *target_config;
@@ -961,7 +981,7 @@ static int __init init_netconsole(void)
 
 	if (strnlen(input, MAX_PARAM_LENGTH)) {
 		while ((target_config = strsep(&input, ";"))) {
-			nt = alloc_param_target(target_config);
+			nt = alloc_param_target(target_config, count);
 			if (IS_ERR(nt)) {
 				err = PTR_ERR(nt);
 				goto fail;
@@ -977,6 +997,7 @@ static int __init init_netconsole(void)
 			spin_lock_irqsave(&target_list_lock, flags);
 			list_add(&nt->list, &target_list);
 			spin_unlock_irqrestore(&target_list_lock, flags);
+			count++;
 		}
 	}
 
-- 
2.34.1


