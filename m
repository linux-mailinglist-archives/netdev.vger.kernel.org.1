Return-Path: <netdev+bounces-31583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F5878EE7C
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46735281572
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B15F11C81;
	Thu, 31 Aug 2023 13:22:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE36125A8
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:22:43 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FDACEB
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3110ab7110aso645824f8f.3
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693488160; x=1694092960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+nkXB1sUqI8gd72PD8v1L11a4OBB90zkZ3AR6jPFao=;
        b=rU7zVX/ZKLiC6O7/VUTAIN7WJW5kAVcjQ21oyIUnoV6YidTalZSnjUaAgnEYtsY/66
         2UnfVbUydotwxkON0qmplGRKj04fsWwb7QCyJC+pnvTb6fo5t7TrrJS/Oav7UZa1f8nS
         HDAqwvg87CuKrJ8qvswqxMue7pd3oT9Fvidma7lO/XpKlCzoJURIJOnNBhFxjQ5RhHvt
         v3McVigXrvHEtVAB2+Gnz3ueNn6WH1CpZnBe7McJxJCwZMaf4Moo34dp2s9uP1xoo7Pl
         2ny2OyX+xxlQpR8ZpacwAZZkOmOZt8Y4Vh8tW6Nzy1k1joaVcaPtLPFv25R606YFe9fu
         AHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693488160; x=1694092960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+nkXB1sUqI8gd72PD8v1L11a4OBB90zkZ3AR6jPFao=;
        b=SgUW5acnW+ptKPl5zUnSl5WHypIYCEoJT5VndC/oq/Sqp+m6oJw0VoOUwTykjEtW82
         VB2twp4VjyvdwKy9TlKgTouQ6CIoDviri5Fk+NLayDiknHU3Vnz2wrA3cxXWpSHQxyBe
         ObooNz1GFpA2R6Oi5M8tnrD1zb0zlYB3QrFisZBxC661fkyyuqzu/0KZ+B6vb0CYhD4T
         aBE5Ns1D3YmTeUZlBsfRWFcoLabE/K7oMgmadtklq9aDzeOFZT4u4Bbp+RSZjNV2aK2Z
         WSSfVLYLYtpWg7+hRC5L9AA67pBEj7zE6lcSthXodXYDchhenHy1NVOQXxVB0O0ckF9b
         y+JA==
X-Gm-Message-State: AOJu0YzaqHh4MX9DPvaHPArX9e1DHk3X4VUINJk8KyHoJTFFyFAZG/sc
	QcniDR9WUzLrfMufNsa8CLAEnZerOto8DAEmNzc=
X-Google-Smtp-Source: AGHT+IEiJAYbYFlqAJC1UCGPl8Kgmouljt1mLvqyixT712mERuSLKLNvVk+4YS+hyp03/jKklZa+Xw==
X-Received: by 2002:a5d:414f:0:b0:317:67bf:3376 with SMTP id c15-20020a5d414f000000b0031767bf3376mr4026312wrq.57.1693488160372;
        Thu, 31 Aug 2023 06:22:40 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe884000000b0030ae53550f5sm2206437wrm.51.2023.08.31.06.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:22:39 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next 5/6] mnl_utils: introduce a helper to check if dump policy exists for command
Date: Thu, 31 Aug 2023 15:22:28 +0200
Message-ID: <20230831132229.471693-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831132229.471693-1-jiri@resnulli.us>
References: <20230831132229.471693-1-jiri@resnulli.us>
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

Benefit from GET_POLICY command of ctrl netlink and introduce a helper
that dumps policies and finds out, if there is a separate policy
specified for dump op of specified command.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/mnl_utils.h |   1 +
 lib/mnl_utils.c     | 121 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/include/mnl_utils.h b/include/mnl_utils.h
index 2193934849e1..76fe1dfec938 100644
--- a/include/mnl_utils.h
+++ b/include/mnl_utils.h
@@ -30,5 +30,6 @@ int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, siz
 			 mnl_cb_t cb, void *data);
 int mnlu_gen_socket_recv_run(struct mnlu_gen_socket *nlg, mnl_cb_t cb,
 			     void *data);
+int mnlu_gen_cmd_dump_policy(struct mnlu_gen_socket *nlg, uint8_t cmd);
 
 #endif /* __MNL_UTILS_H__ */
diff --git a/lib/mnl_utils.c b/lib/mnl_utils.c
index f8e07d2f467f..1c78222828ff 100644
--- a/lib/mnl_utils.c
+++ b/lib/mnl_utils.c
@@ -110,7 +110,7 @@ int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, siz
 	return err;
 }
 
-static int get_family_attrs_cb(const struct nlattr *attr, void *data)
+static int ctrl_attrs_cb(const struct nlattr *attr, void *data)
 {
 	int type = mnl_attr_get_type(attr);
 	const struct nlattr **tb = data;
@@ -124,6 +124,12 @@ static int get_family_attrs_cb(const struct nlattr *attr, void *data)
 	if (type == CTRL_ATTR_MAXATTR &&
 	    mnl_attr_validate(attr, MNL_TYPE_U32) < 0)
 		return MNL_CB_ERROR;
+	if (type == CTRL_ATTR_POLICY &&
+	    mnl_attr_validate(attr, MNL_TYPE_NESTED) < 0)
+		return MNL_CB_ERROR;
+	if (type == CTRL_ATTR_OP_POLICY &&
+	    mnl_attr_validate(attr, MNL_TYPE_NESTED) < 0)
+		return MNL_CB_ERROR;
 	tb[type] = attr;
 	return MNL_CB_OK;
 }
@@ -134,7 +140,7 @@ static int get_family_cb(const struct nlmsghdr *nlh, void *data)
 	struct nlattr *tb[CTRL_ATTR_MAX + 1] = {};
 	struct mnlu_gen_socket *nlg = data;
 
-	mnl_attr_parse(nlh, sizeof(*genl), get_family_attrs_cb, tb);
+	mnl_attr_parse(nlh, sizeof(*genl), ctrl_attrs_cb, tb);
 	if (!tb[CTRL_ATTR_FAMILY_ID])
 		return MNL_CB_ERROR;
 	if (!tb[CTRL_ATTR_MAXATTR])
@@ -252,3 +258,114 @@ int mnlu_gen_socket_recv_run(struct mnlu_gen_socket *nlg, mnl_cb_t cb,
 				    MNL_SOCKET_BUFFER_SIZE,
 				    cb, data);
 }
+
+static int ctrl_policy_attrs_cb(const struct nlattr *attr, void *data)
+{
+	int type = mnl_attr_get_type(attr);
+	const struct nlattr **tb = data;
+
+	if (mnl_attr_type_valid(attr, CTRL_ATTR_POLICY_DUMP_MAX) < 0)
+		return MNL_CB_ERROR;
+
+	if (type == CTRL_ATTR_POLICY_DO &&
+	    mnl_attr_validate(attr, MNL_TYPE_U32) < 0)
+		return MNL_CB_ERROR;
+	if (type == CTRL_ATTR_POLICY_DUMP &&
+	    mnl_attr_validate(attr, MNL_TYPE_U32) < 0)
+		return MNL_CB_ERROR;
+
+	tb[type] = attr;
+	return MNL_CB_OK;
+}
+
+struct cmd_dump_policy_ctx {
+	uint8_t cmd;
+	uint8_t do_policy_idx_found:1,
+		dump_policy_idx_found:1;
+	uint32_t do_policy_idx;
+	uint32_t dump_policy_idx;
+	uint32_t dump_policy_attr_count;
+};
+
+static void process_dump_op_policy_nest(const struct nlattr *op_policy_nest,
+					struct cmd_dump_policy_ctx *ctx)
+{
+	struct nlattr *tb[CTRL_ATTR_POLICY_DUMP_MAX + 1] = {};
+	const struct nlattr *attr;
+	int err;
+
+	mnl_attr_for_each_nested(attr, op_policy_nest) {
+		if (ctx->cmd != (attr->nla_type & ~NLA_F_NESTED))
+			continue;
+		err = mnl_attr_parse_nested(attr, ctrl_policy_attrs_cb, tb);
+		if (err != MNL_CB_OK)
+			continue;
+		if (tb[CTRL_ATTR_POLICY_DO]) {
+			ctx->do_policy_idx = mnl_attr_get_u32(tb[CTRL_ATTR_POLICY_DO]);
+			ctx->do_policy_idx_found = true;
+		}
+		if (tb[CTRL_ATTR_POLICY_DUMP]) {
+			ctx->dump_policy_idx = mnl_attr_get_u32(tb[CTRL_ATTR_POLICY_DUMP]);
+			ctx->dump_policy_idx_found = true;
+		}
+		break;
+	}
+}
+
+static void process_dump_policy_nest(const struct nlattr *policy_nest,
+				     struct cmd_dump_policy_ctx *ctx)
+{
+	const struct nlattr *attr;
+
+	if (!ctx->dump_policy_idx_found)
+		return;
+
+	mnl_attr_for_each_nested(attr, policy_nest)
+		if (ctx->dump_policy_idx == (attr->nla_type & ~NLA_F_NESTED))
+			ctx->dump_policy_attr_count++;
+}
+
+static int cmd_dump_policy_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
+	struct nlattr *tb[CTRL_ATTR_MAX + 1] = {};
+	struct cmd_dump_policy_ctx *ctx = data;
+
+	mnl_attr_parse(nlh, sizeof(*genl), ctrl_attrs_cb, tb);
+	if (!tb[CTRL_ATTR_FAMILY_ID])
+		return MNL_CB_OK;
+
+	if (tb[CTRL_ATTR_OP_POLICY])
+		process_dump_op_policy_nest(tb[CTRL_ATTR_OP_POLICY], ctx);
+
+	if (tb[CTRL_ATTR_POLICY])
+		process_dump_policy_nest(tb[CTRL_ATTR_POLICY], ctx);
+
+	return MNL_CB_OK;
+}
+
+int mnlu_gen_cmd_dump_policy(struct mnlu_gen_socket *nlg, uint8_t cmd)
+{
+	struct cmd_dump_policy_ctx ctx = {
+		.cmd = cmd,
+	};
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = _mnlu_gen_socket_cmd_prepare(nlg, CTRL_CMD_GETPOLICY,
+					   NLM_F_REQUEST | NLM_F_ACK | NLM_F_DUMP,
+					   GENL_ID_CTRL, 1);
+
+	mnl_attr_put_u16(nlh, CTRL_ATTR_FAMILY_ID, nlg->family);
+
+	err = mnlu_gen_socket_sndrcv(nlg, nlh, cmd_dump_policy_cb, &ctx);
+	if (err)
+		return err;
+
+	if (!ctx.dump_policy_idx_found || !ctx.do_policy_idx_found ||
+	    ctx.do_policy_idx == ctx.dump_policy_idx ||
+	    !ctx.dump_policy_attr_count)
+		return -ENOTSUP;
+
+	return 0;
+}
-- 
2.41.0


