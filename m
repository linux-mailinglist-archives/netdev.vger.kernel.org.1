Return-Path: <netdev+bounces-26859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012627793AB
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B542821B3
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6AC329C5;
	Fri, 11 Aug 2023 15:57:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2885692
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:57:33 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B1030DD
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso19667285e9.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691769451; x=1692374251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPAP5lBEX2vcC2T4wWrhVRQlFY/OnfoctTNX8XpZ/HE=;
        b=jvCCu0z//XGvQvRaLGYiI/AUmcXKvjk/+LwdKG9hXzp1O9ngY8Dp/Ez4vg37ynwZ3U
         w/4zsUCFm3urgqhr+hrvWMMKHjQ0eX1rQROPfShkhrDTtQeP/FPBuKo4r7xl5OEH08FT
         rl6Yi47AG5whF7FTuz53bTmtAw4NHi5qzSK6C8uBuORePqkd5a0jcNeJ7J8wtnu6v8mX
         IVkGlgC4LdOk74NXDXco5uXsagMpiD391OEzJ2hJM+6OLSXh9K5JlP8AqyP/rr7YiMmj
         mE5nmqdW35IlQRxxXhRah+0EyFD/o+CiZotKGmBobG/OvwZKkt5GXmFsOAiGIQ1ffqac
         ZRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769451; x=1692374251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPAP5lBEX2vcC2T4wWrhVRQlFY/OnfoctTNX8XpZ/HE=;
        b=jA7ECWwgBc8qXmcHrqvEO1Ase+XTuP/RzMWhDj0Rn+JtxZdGme4dctCHbf3Y19fY3f
         PaYbrotWW7QAmI1MX3o4QDe7ukWysNm8vA+7XzcMnHa2lFTEyzNvtsIOCy7XwMZfk9aG
         HX549VcyTQXlXFaNe5H8ntf6HURRDdJKGhjCchuqbDhstwvQNTamMhCiraNj+xxaG/QN
         4aYED4Xdee1Z9J3wKn+FE7Gh0WXqTL4KAli0T1zHU8dskQDEUtRz96KDAimrc/trP1St
         aYGI6pCJL3O1tGHKM8mqnsWvawZs3+8GBnCicdMJKkCG3VFIXES9DXk3xGiPyq6BwWh9
         XPNQ==
X-Gm-Message-State: AOJu0Yy736msIgE98Kb3UTinplD2InCxrpsSeFwNTgdATzA7zi7+iaHW
	zDNZrtkwEBX8ulGJPu29WJlzQelXpn8Sc2oXD8C6kw==
X-Google-Smtp-Source: AGHT+IGM972n9nuegsiEEARruio27Sy8BNrVRm2etn63A2K2wNdeFcOKrmj/iQnt50vEDAYHnxVPSQ==
X-Received: by 2002:adf:e48a:0:b0:317:dde3:2d16 with SMTP id i10-20020adfe48a000000b00317dde32d16mr1874360wrm.51.1691769451073;
        Fri, 11 Aug 2023 08:57:31 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l13-20020adfe9cd000000b0031934b035d2sm5031316wrn.52.2023.08.11.08.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:57:30 -0700 (PDT)
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
Subject: [patch net-next v4 08/13] devlink: remove duplicate temporary netlink callback prototypes
Date: Fri, 11 Aug 2023 17:57:09 +0200
Message-ID: <20230811155714.1736405-9-jiri@resnulli.us>
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

Remove the duplicate temporary netlink callback prototype as the
generated ones are already in place.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/devl_internal.h | 48 -------------------------------------
 1 file changed, 48 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index f8af6ffdbb3a..7caa385703de 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -185,50 +185,11 @@ int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 			     struct netlink_ext_ack *extack);
 
 /* Devlink nl cmds */
-int devlink_nl_pre_doit_port(const struct genl_split_ops *ops,
-			     struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
-				      struct sk_buff *skb,
-				      struct genl_info *info);
 int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_flash_update(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
-				    struct netlink_callback *cb);
 int devlink_nl_cmd_selftests_run(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_rate_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_linecard_get_dumpit(struct sk_buff *skb,
-				   struct netlink_callback *cb);
-int devlink_nl_sb_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_sb_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-int devlink_nl_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_sb_pool_get_dumpit(struct sk_buff *skb,
-				  struct netlink_callback *cb);
-int devlink_nl_sb_port_pool_get_doit(struct sk_buff *skb,
-				     struct genl_info *info);
-int devlink_nl_sb_port_pool_get_dumpit(struct sk_buff *skb,
-				       struct netlink_callback *cb);
-int devlink_nl_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
-					struct genl_info *info);
-int devlink_nl_sb_tc_pool_bind_get_dumpit(struct sk_buff *skb,
-					  struct netlink_callback *cb);
-int devlink_nl_param_get_doit(struct sk_buff *skb,
-			      struct genl_info *info);
-int devlink_nl_param_get_dumpit(struct sk_buff *skb,
-				struct netlink_callback *cb);
-int devlink_nl_region_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_region_get_dumpit(struct sk_buff *skb,
-				 struct netlink_callback *cb);
-int devlink_nl_health_reporter_get_doit(struct sk_buff *skb,
-					struct genl_info *info);
-int devlink_nl_health_reporter_get_dumpit(struct sk_buff *skb,
-					  struct netlink_callback *cb);
 int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
 					    struct genl_info *info);
 int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
@@ -241,12 +202,3 @@ int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
 						   struct genl_info *info);
 int devlink_nl_cmd_health_reporter_test_doit(struct sk_buff *skb,
 					     struct genl_info *info);
-int devlink_nl_trap_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_trap_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-int devlink_nl_trap_group_get_dumpit(struct sk_buff *skb,
-				     struct netlink_callback *cb);
-int devlink_nl_trap_group_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_trap_policer_get_doit(struct sk_buff *skb,
-				     struct genl_info *info);
-int devlink_nl_trap_policer_get_dumpit(struct sk_buff *skb,
-				       struct netlink_callback *cb);
-- 
2.41.0


