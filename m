Return-Path: <netdev+bounces-39491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31A7BF781
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CD8281DB1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF91717754;
	Tue, 10 Oct 2023 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53517733
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:38:26 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79141CC;
	Tue, 10 Oct 2023 02:38:21 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so9219393a12.0;
        Tue, 10 Oct 2023 02:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696930700; x=1697535500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afOI7n0O0xBXNXt45jFmttLB+IlVWLekbDfMghG+2eE=;
        b=c4Jcnsvvrd8xtqkIEHF0/TQQTLPxZ3FE3ruYgs5+n28oijPVTdNW9pXRojOdqYFaUF
         oACIutyPz2nYYLIrLydh7ejTf2oJv8cEpJwLUe9DOs81GPT5J0scn/f0hwT+tmGYShNF
         MDehCPgBfE4TBox7vUPJyrW0bhQrQrPBUh71nDlgZIoCLXoa/t8hqGVabQaoIZmgI+B8
         hQSiRi/2KnKBvefcGrmpvwCROmMP52uLopAQWbPkulwTqCWsQwicxfexY8HDf3a2IEBV
         gR5hKVl1aOh01eXZcEN7dG1QbcpRuQUeXCDfIcUO9aZCK40ZXvaGGDPZoEIRcQzTfnti
         9ODw==
X-Gm-Message-State: AOJu0Yy3tSd3EMwh3YQrIxr4ZGf8qDyd/W5pGOXutPv4ui+mf59pmUWk
	ea95t6CI1KVTe/9lragLabw=
X-Google-Smtp-Source: AGHT+IHPF+oZSd3W1X9NGPYTSkvLFuiu1FqauSDYZLA3nNztHC0NnNrCQn6K/4bb6Mdt9O1OlnuXHQ==
X-Received: by 2002:a05:6402:3c1:b0:533:2449:7a59 with SMTP id t1-20020a05640203c100b0053324497a59mr16174945edw.11.1696930699688;
        Tue, 10 Oct 2023 02:38:19 -0700 (PDT)
Received: from localhost (fwdproxy-cln-005.fbsv.net. [2a03:2880:31ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d9c4000000b0052284228e3bsm7404542eds.8.2023.10.10.02.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:38:17 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/4] netconsole: Attach cmdline target to dynamic target
Date: Tue, 10 Oct 2023 02:37:50 -0700
Message-Id: <20231010093751.3878229-4-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010093751.3878229-1-leitao@debian.org>
References: <20231010093751.3878229-1-leitao@debian.org>
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
index 3d7002af505d..519f4d065921 100644
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
+	if (!strncmp(name, NETCONSOLE_PARAM_TARGET_NAME,
+		     strlen(NETCONSOLE_PARAM_TARGET_NAME))) {
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


