Return-Path: <netdev+bounces-40333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A527C6C07
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B9A1C21149
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E7823758;
	Thu, 12 Oct 2023 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4DD2420C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 11:14:29 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9913D94;
	Thu, 12 Oct 2023 04:14:27 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso1574710a12.3;
        Thu, 12 Oct 2023 04:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697109266; x=1697714066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjdP/1UQNz4vXjRgezA+S9KrCfwhCzW1/s+0kKPQHC8=;
        b=EB61wJADKpOXPBLFtkSqnYDu54z/yt51b5q5zuYeq7AI1uWtzOpEun9R0Zs5tAVEG1
         dXT2dEV5OE5adtJF+9aY3jzKkAsz+toRqDPxxQo8Tb4u6sfDjjvZNqKzKM5k8ZVliYFU
         ZJDnC7BtY9GN47Ddn06HxLVaePOYapvr3MO8RsrX8zKGd9Ujiq3sfD7HkFDUIag+4mp3
         ChlXIMYHDXUJOAOVZ+QHAxf2tG7xchaA99Rb9sk7jhOEpudpKX1HUue09H+Bmo1f2dgK
         BuDGJ+/EYs9bYBmtMtfpKsRV3aeKUMTRBlfXHMQlOjkGmtG4AarQf8zip2IM3wf0Vw1L
         fWNQ==
X-Gm-Message-State: AOJu0YzsMrhvRXsqXJfujyizOAZ/QXMDUFT26l+gsyA0YmPPVVtlR3pE
	3+hS0mwqz96WHyggLM5ORrJlhOb90wk=
X-Google-Smtp-Source: AGHT+IEALGjRLZc4hVCophGPLE0JhjYSDpEBz6AeOT98TyySKAJSvfwxYSY2P3/HKA4VC9yqMgx5Ig==
X-Received: by 2002:aa7:df0e:0:b0:52c:8a13:2126 with SMTP id c14-20020aa7df0e000000b0052c8a132126mr21198955edy.37.1697109265642;
        Thu, 12 Oct 2023 04:14:25 -0700 (PDT)
Received: from localhost (fwdproxy-cln-012.fbsv.net. [2a03:2880:31ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id s7-20020aa7c547000000b0052348d74865sm9972352edr.61.2023.10.12.04.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:14:25 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/4] netconsole: Attach cmdline target to dynamic target
Date: Thu, 12 Oct 2023 04:14:00 -0700
Message-Id: <20231012111401.333798-4-leitao@debian.org>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable the attachment of a dynamic target to the target created during
boot time. The boot-time targets are named as "cmdline\d", where "\d" is
a number starting at 0.

If the user creates a dynamic target named "cmdline0", it will attach to
the first target created at boot time (as defined in the
`netconsole=...` command line argument). `cmdline1` will attach to the
second target and so forth.

If there is no netconsole target created at boot time, then, the target
name could be reused.

Relevant design discussion:
https://lore.kernel.org/all/ZRWRal5bW93px4km@gmail.com/

Suggested-by: Joel Becker <jlbec@evilplan.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e153bce4dee4..6e14ba5e06c8 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -629,6 +629,23 @@ static const struct config_item_type netconsole_target_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
+static struct netconsole_target *find_cmdline_target(const char *name)
+{
+	struct netconsole_target *nt, *ret = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&target_list_lock, flags);
+	list_for_each_entry(nt, &target_list, list) {
+		if (!strcmp(nt->item.ci_name, name)) {
+			ret = nt;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&target_list_lock, flags);
+
+	return ret;
+}
+
 /*
  * Group operations and type for netconsole_subsys.
  */
@@ -639,6 +656,17 @@ static struct config_item *make_netconsole_target(struct config_group *group,
 	struct netconsole_target *nt;
 	unsigned long flags;
 
+	/* Checking if a target by this name was created at boot time.  If so,
+	 * attach a configfs entry to that target.  This enables dynamic
+	 * control.
+	 */
+	if (!strncmp(name, NETCONSOLE_PARAM_TARGET_PREFIX,
+		     strlen(NETCONSOLE_PARAM_TARGET_PREFIX))) {
+		nt = find_cmdline_target(name);
+		if (nt)
+			return &nt->item;
+	}
+
 	nt = alloc_and_init();
 	if (!nt)
 		return ERR_PTR(-ENOMEM);
-- 
2.34.1


