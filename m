Return-Path: <netdev+bounces-26864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2976E7793B6
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A1A2823EA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24DB2AB53;
	Fri, 11 Aug 2023 15:57:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73BF2AB44
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:57:41 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC6330D5
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-319559fd67dso1139375f8f.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691769459; x=1692374259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgFUzUxYMcXKapweV3d/+cSGnR4wPaaPZFJX6/RXnoA=;
        b=GbPjefBQwLKMo9Cv3u/mLMiQSG69c9wJvkN2BoLzBijvZ2LJQHFYN/th0ceNtJHYl7
         HW+9mjSJHexLDQdH+1z8sVmGde1KcMfplp2ugGUmCzzZinT+VCFUS+89m5BR58XEECGB
         vBzElJCB22lQcxsJt3ewWA1MTWaR0wDWrnoN14RPuteadM7RmFl7opZZ2bU/t49aOGjP
         1LIRtbhNT73S4bD3CEataFqPn7Io8DWY1Ua1JpRBZeOgUJeDTvv0pGH4kXbEeHFyCDnW
         JciTbBzM389cpj2vvZsTqME9CHEdZvlNIrc2RM16r6uvXV4MwwnLdcLlEYXan8G6w4+z
         DAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769459; x=1692374259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgFUzUxYMcXKapweV3d/+cSGnR4wPaaPZFJX6/RXnoA=;
        b=Q/7SEvmJuDKCKzgG0GV34p4BR8doOAKaCcbIadDgUwlGGN77y/lwyqFmWRQcLVXRQE
         0EoEZ4EhLkl06IpGDURWhqCCojq5B27MavMqRfKDaaQxQSOe2F3k7aku5r3q1A8Chzqi
         TkR6sChi47D6U5spXQKa9V4NOBZWWV3aQsTDMT3OPBvVQMq0J9kPudYdqRxKlE6RWZND
         MgMvvuojhdfUjNXOZA/y0YlUdHhyI77uXn2JKHceNDFMcG/tVJRDanI2dvc5u3GkNP7K
         SSw4Sh2/YeWhsvFunyvYzdQGnFE1JVC5kcxL9VFfFa94t18CnlMdjakl3DXlNh8AyGTS
         7anQ==
X-Gm-Message-State: AOJu0YzgXLSHv8X2i423zNVEZF7I44PKaF/qKDBz3CpFZn8ECTBw8qXr
	EccgrI+Xi69xC8hon8u6Q8fRqxSjsANM5YrXF87nApy0
X-Google-Smtp-Source: AGHT+IEdvlm/3bXbb+iJ+m9jGZnQukawKA2u/Yxglqib9h/I21/PMZFucicFLNoNQWfHnrfXNohgbA==
X-Received: by 2002:adf:f60d:0:b0:319:5412:587e with SMTP id t13-20020adff60d000000b003195412587emr1763183wrp.30.1691769459307;
        Fri, 11 Aug 2023 08:57:39 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id o17-20020adfe811000000b0031762e89f94sm5785007wrm.117.2023.08.11.08.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:57:38 -0700 (PDT)
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
Subject: [patch net-next v4 13/13] netlink: specs: devlink: extend health reporter dump attributes by port index
Date: Fri, 11 Aug 2023 17:57:14 +0200
Message-ID: <20230811155714.1736405-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811155714.1736405-1-jiri@resnulli.us>
References: <20230811155714.1736405-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
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


