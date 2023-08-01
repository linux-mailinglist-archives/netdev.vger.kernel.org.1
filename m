Return-Path: <netdev+bounces-23126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9C476B058
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45C4281759
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CED200DF;
	Tue,  1 Aug 2023 10:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63D71F94D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:06:45 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A510B;
	Tue,  1 Aug 2023 03:06:42 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52222562f1eso8073818a12.3;
        Tue, 01 Aug 2023 03:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690884401; x=1691489201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKJch/Gc+6Pg2T8wuibMxmyZDdXQuXrYO2iuSwSbYeo=;
        b=k74oqOrjVWqB6iXCQ44//yN6aoHmP0eYIJPuEw9oAYvngOTjZsdMCBhZNhr91WiI7U
         ygj3qNicpAs2D0WoNs1oSiX92LdPKE/PuVORhD6o96l/fDvSsPX94fnxtD6ubbbfNyn1
         iV9Iutm6jkqXSAoqeD0K1C8+d401YeCRssbYfbg0vzJ6cA0zZhAqIih6QJyKUm9PRmLL
         iaBKrwFRLQj5EOoYsC1+TB4/W9CjqRDA1yW3GuMwg6mhiRPGJqMFcv8ssaeJ7rJ65tAG
         W5oPk2WlDukNCNE3SsbmUpbtgNltBrhXiqrnHfWYp5gFvaA1ffl+RNoDzcuE21QSaJVB
         DiIw==
X-Gm-Message-State: ABy/qLaXEHS6FsuTy7kiJRqmTvcUteOFuhNRjtAjpj4eM7rYwItqR3h8
	txXf6rVbdI2/w6OH013aJ4Q=
X-Google-Smtp-Source: APBJJlFObr5S0ouIqsKVv+MAUfGYtKeO4QFnnmSYR80cNImyCPlI3F8Bi0iFjhvx/dHhrY8/XfQ9eg==
X-Received: by 2002:a17:907:78d8:b0:99b:d068:9504 with SMTP id kv24-20020a17090778d800b0099bd0689504mr2141316ejc.2.1690884400524;
        Tue, 01 Aug 2023 03:06:40 -0700 (PDT)
Received: from localhost (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id pk15-20020a170906d7af00b0099bd6026f45sm7387545ejb.198.2023.08.01.03.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 03:06:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: rdunlap@infradead.org,
	benjamin.poirier@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3] netconsole: Enable compile time configuration
Date: Tue,  1 Aug 2023 03:05:32 -0700
Message-Id: <20230801100533.3350037-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable netconsole features to be set at compilation time. Create two
Kconfig options that allow users to set extended logs and release
prepending features at compilation time.

Right now, the user needs to pass command line parameters to netconsole,
such as "+"/"r" to enable extended logs and version prepending features.

With these two options, the user could set the default values for the
features at compile time, and don't need to pass it in the command line
to get them enabled, simplifying the command line.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
  v1 -> v2:
	* Improvements in the Kconfig help section.
  v2 -> v3:
	* Honour the Kconfig settings when creating sysfs targets
	* Add "by default" in a Kconfig help.
---
 drivers/net/Kconfig      | 22 ++++++++++++++++++++++
 drivers/net/netconsole.c | 10 ++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 368c6f5b327e..55fb9509bcae 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -332,6 +332,28 @@ config NETCONSOLE_DYNAMIC
 	  at runtime through a userspace interface exported using configfs.
 	  See <file:Documentation/networking/netconsole.rst> for details.
 
+config NETCONSOLE_EXTENDED_LOG
+	bool "Set kernel extended message by default"
+	depends on NETCONSOLE
+	default n
+	help
+	  Set extended log support for netconsole message. If this option is
+	  set, log messages are transmitted with extended metadata header in a
+	  format similar to /dev/kmsg.  See
+	  <file:Documentation/networking/netconsole.rst> for details.
+
+config NETCONSOLE_PREPEND_RELEASE
+	bool "Prepend kernel release version in the message by default"
+	depends on NETCONSOLE_EXTENDED_LOG
+	default n
+	help
+	  Set kernel release to be prepended to each netconsole message by
+	  default. If this option is set, the kernel release is prepended into
+	  the first field of every netconsole message, so, the netconsole
+	  server/peer can easily identify what kernel release is logging each
+	  message.  See <file:Documentation/networking/netconsole.rst> for
+	  details.
+
 config NETPOLL
 	def_bool NETCONSOLE
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 87f18aedd3bd..e3b6155f4529 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -181,6 +181,11 @@ static struct netconsole_target *alloc_param_target(char *target_config)
 	if (!nt)
 		goto fail;
 
+	if (IS_ENABLED(CONFIG_NETCONSOLE_EXTENDED_LOG))
+		nt->extended = true;
+	if (IS_ENABLED(CONFIG_NETCONSOLE_PREPEND_RELEASE))
+		nt->release = true;
+
 	nt->np.name = "netconsole";
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
 	nt->np.local_port = 6665;
@@ -681,6 +686,11 @@ static struct config_item *make_netconsole_target(struct config_group *group,
 	nt->np.remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
 
+	if (IS_ENABLED(CONFIG_NETCONSOLE_EXTENDED_LOG))
+		nt->extended = true;
+	if (IS_ENABLED(CONFIG_NETCONSOLE_PREPEND_RELEASE))
+		nt->release = true;
+
 	/* Initialize the config_item member */
 	config_item_init_type_name(&nt->item, name, &netconsole_target_type);
 
-- 
2.34.1


