Return-Path: <netdev+bounces-23264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A1C76B73E
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35981281AAA
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560D226B02;
	Tue,  1 Aug 2023 14:19:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C022EF9
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:19:25 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9510B127
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:19:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bcd6c0282so874830066b.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690899562; x=1691504362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYAfhr+kIZLqFF0wZYJ8uWRcm1Dn7Z+b4KAI90SijJI=;
        b=O2oHRqZq8Gsg5WBzc/BKI5kmBFcQ74jeWfx4piUeOejpByE0uVGMYXDPK41boJiDGe
         TiZzo3dCkqLVnfqNYNTEoM+N2FE0Gmf09ghrKhijj+iN32ckmu35br0u4jwz11KJhUZs
         60Su2korgCvvbSTrAFG5ySxiQFh6FuDc+xUWZqfeNIdlviXQV6MNK7FF4JboqwLUt68u
         aYJ9AnQTFI6CP/I46jsloo6MkVp8XE6Ft0HAJO2wuFT7clNylzvvA9z1L7klwQo78zJA
         6HhvQH2x951d9gWsAcZnp8LLJMW18Y1J+kb3zS9PgSD8lJXNyKRQfdVuDJj/jzRl0OLt
         BnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899562; x=1691504362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYAfhr+kIZLqFF0wZYJ8uWRcm1Dn7Z+b4KAI90SijJI=;
        b=PEc7MsvPMBIcus1kin8iTFmYnXHSiKFt6alrT00B8EClqE4Y0NxkBMWToAnIIvmBp8
         ayBlj1fmTL5bNenniYZzmb6LI9P8FhziZe1DJWuWjo++BrJ7Hblmx4TybtYOn4Z4gCmo
         7FMWwrRR7Jxs2qadMRvvlf6vNkC29g45IFD3mUIXvQItHw/1nS/poGBkFh+gf7uWIh51
         LuulNqvWgH/mULMpjF7HDjBwPqydhYnP2xf3K2UVzaAeM4zLNtBvPX27MIAr41IgD1CT
         OpocQiPwUGvKOq2bVJk8NfLB5d9eSmog0QR6l1ctNqU5EdUEPYiSpNqoh0q5ya5sycDu
         h3Hw==
X-Gm-Message-State: ABy/qLZGKePucnQDIjgrotKd3aGyH/mK2Y6JUF8rE4dD7lNrEJrMwoUa
	s5tHgMEI2aAXadIe3ATJt1YeGI9inlUAALwedtM03w==
X-Google-Smtp-Source: APBJJlHWjQUrsN1tur49nZtzCk1sHdTCUv66FR27yjQXgjm+fhqPCSATXK9XMJwKdqc+VD03tFIONA==
X-Received: by 2002:a17:906:10d6:b0:982:c8d0:683f with SMTP id v22-20020a17090610d600b00982c8d0683fmr2921313ejv.18.1690899562100;
        Tue, 01 Aug 2023 07:19:22 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id lz7-20020a170906fb0700b0099b6b8a0d04sm7794355ejb.157.2023.08.01.07.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:19:21 -0700 (PDT)
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
Subject: [patch net-next 8/8] devlink: use generated split ops and remove duplicated commands from small ops
Date: Tue,  1 Aug 2023 16:19:07 +0200
Message-ID: <20230801141907.816280-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801141907.816280-1-jiri@resnulli.us>
References: <20230801141907.816280-1-jiri@resnulli.us>
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

Do the switch and use generated split ops for get and info_get commands.
Remove those from small ops array.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  2 +-
 net/devlink/leftover.c      | 16 +---------------
 net/devlink/netlink.c       |  2 ++
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 51de0e1fc769..7fdd956ff992 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -124,7 +124,7 @@ struct devlink_cmd {
 	devlink_nl_dump_one_func_t *dump_one;
 };
 
-extern const struct genl_small_ops devlink_nl_small_ops[56];
+extern const struct genl_small_ops devlink_nl_small_ops[54];
 
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 895b732bed8e..3bf42f5335ed 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6278,14 +6278,7 @@ static int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
 	return devlink_trap_policer_set(devlink, policer_item, info);
 }
 
-const struct genl_small_ops devlink_nl_small_ops[56] = {
-	{
-		.cmd = DEVLINK_CMD_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_get_doit,
-		.dumpit = devlink_nl_get_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
+const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_PORT_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -6533,13 +6526,6 @@ const struct genl_small_ops devlink_nl_small_ops[56] = {
 		.dumpit = devlink_nl_cmd_region_read_dumpit,
 		.flags = GENL_ADMIN_PERM,
 	},
-	{
-		.cmd = DEVLINK_CMD_INFO_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_info_get_doit,
-		.dumpit = devlink_nl_info_get_dumpit,
-		/* can be retrieved by unprivileged users */
-	},
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 98d5c6b0acd8..bada2819827b 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -248,6 +248,8 @@ struct genl_family devlink_nl_family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.small_ops	= devlink_nl_small_ops,
 	.n_small_ops	= ARRAY_SIZE(devlink_nl_small_ops),
+	.split_ops	= devlink_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(devlink_nl_ops),
 	.resv_start_op	= DEVLINK_CMD_SELFTESTS_RUN + 1,
 	.mcgrps		= devlink_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(devlink_nl_mcgrps),
-- 
2.41.0


