Return-Path: <netdev+bounces-26357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C21B777972
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF4D1C20B09
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405E20CA0;
	Thu, 10 Aug 2023 13:16:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8820C8D
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:16:06 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572BE10E9
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:16:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so7726165e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691673364; x=1692278164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgFUzUxYMcXKapweV3d/+cSGnR4wPaaPZFJX6/RXnoA=;
        b=Nhg0C5JPdz9BKGh1NMPfC1d78gF79UdTDA50DFuZYVyHdBAkEacvjShMKtiHJREqMx
         sue4NUNGknFyR4+54RS4WWpvMC/n5I5fVHJo5XYVEjBiHCaJBmpZIHBObFVcW9xe7FEA
         c377jaWXVpDny7aJApKj82cPPb/UBXmVnsX4G3cFhqDMuH4sMacwCKJw88ZoACwAC7gZ
         dmxvrbbjRheQ3agJIHGFA8dOKEq8hdVhc0VOUWOWzusdj/SU5WyTAN6agtOza01tcqqJ
         njaGX9QeQLnFwPcPFkIbSXpyMwWehpLgvPdXhR+yEaZPoyrN1IQNDANLcYBEaW8kC/fu
         feXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673364; x=1692278164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgFUzUxYMcXKapweV3d/+cSGnR4wPaaPZFJX6/RXnoA=;
        b=VY/3c/4PGrEjJl+jYGwNA6q9l21XEeJRsxIz/RmMzrPiYzSCzVKeZRRqjb0JF9lcft
         TjIk0b9sR9neoBvsoGddlKNyerZQ733ZeJkR6vt91bgomU7bEFHJ3/vDi8yhDn/7dStw
         2zqDBSFW5bfoTaUnYnBSz2CIbme29bZ2BnuLjijlrt8zNhjiM9qjNKdFHWRk4eL+SZ5m
         46D67hXtokTUfy2T0K+Ooz986gvBDM9w2TCK2itFisyXVojPbRp1AMkAe/FQgoX3Oagk
         fAPWJ7ELot/4A2uUm2giWbhcYe1rc8VdI9S4D2zNevK6/zK/zChg8680set8D+/sshPK
         691Q==
X-Gm-Message-State: AOJu0YyOtJ1t/Dy4wuavrJ7ZPO2S5LEvN+HT3WMKbKg6vmXbIXdAbEfJ
	s9W+1RG+msex59k5m2UEMli5t6zL+0N2EvOxcy+O4dZ1
X-Google-Smtp-Source: AGHT+IFne0XGY03a06Q3UPhyX+rNbKLRAF86uXjMSX9ZM2mPMWviNUH0kezL+HKvdIHVdAC2G2GuwQ==
X-Received: by 2002:a5d:670e:0:b0:317:6be2:f444 with SMTP id o14-20020a5d670e000000b003176be2f444mr2234344wru.49.1691673363954;
        Thu, 10 Aug 2023 06:16:03 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b0031437ec7ec1sm2171705wrq.2.2023.08.10.06.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:16:03 -0700 (PDT)
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
Subject: [patch net-next v3 13/13] netlink: specs: devlink: extend health reporter dump attributes by port index
Date: Thu, 10 Aug 2023 15:15:39 +0200
Message-ID: <20230810131539.1602299-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810131539.1602299-1-jiri@resnulli.us>
References: <20230810131539.1602299-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Allow user to pass port index for health reporter dump request.

Re-generate the related code.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 Documentation/netlink/specs/devlink.yaml | 2 +-
 net/devlink/netlink_gen.c                | 5 +++--
 tools/net/ynl/generated/devlink-user.c   | 2 ++
 tools/net/ynl/generated/devlink-user.h   | 9 +++++++++
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 6dbebeebd63e..d1ebcd927149 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -516,7 +516,7 @@ operations:
           attributes: *health-reporter-id-attrs
       dump:
         request:
-          attributes: *dev-id-attrs
+          attributes: *port-id-attrs
         reply: *health-reporter-get-reply
 
       # TODO: fill in the operations in between
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 5f3e980c6a7c..467b7a431de1 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -129,9 +129,10 @@ static const struct nla_policy devlink_health_reporter_get_do_nl_policy[DEVLINK_
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_GET - dump */
-static const struct nla_policy devlink_health_reporter_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_get_dump_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_TRAP_GET - do */
@@ -373,7 +374,7 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.cmd		= DEVLINK_CMD_HEALTH_REPORTER_GET,
 		.dumpit		= devlink_nl_health_reporter_get_dumpit,
 		.policy		= devlink_health_reporter_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index 80ee9d24eb16..3a8d8499fab6 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -2079,6 +2079,8 @@ devlink_health_reporter_get_dump(struct ynl_sock *ys,
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
 	if (req->_present.dev_name_len)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
+	if (req->_present.port_index)
+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
index 12530f1795ca..4b686d147613 100644
--- a/tools/net/ynl/generated/devlink-user.h
+++ b/tools/net/ynl/generated/devlink-user.h
@@ -1242,10 +1242,12 @@ struct devlink_health_reporter_get_req_dump {
 	struct {
 		__u32 bus_name_len;
 		__u32 dev_name_len;
+		__u32 port_index:1;
 	} _present;
 
 	char *bus_name;
 	char *dev_name;
+	__u32 port_index;
 };
 
 static inline struct devlink_health_reporter_get_req_dump *
@@ -1276,6 +1278,13 @@ devlink_health_reporter_get_req_dump_set_dev_name(struct devlink_health_reporter
 	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
 	req->dev_name[req->_present.dev_name_len] = 0;
 }
+static inline void
+devlink_health_reporter_get_req_dump_set_port_index(struct devlink_health_reporter_get_req_dump *req,
+						    __u32 port_index)
+{
+	req->_present.port_index = 1;
+	req->port_index = port_index;
+}
 
 struct devlink_health_reporter_get_list {
 	struct devlink_health_reporter_get_list *next;
-- 
2.41.0


