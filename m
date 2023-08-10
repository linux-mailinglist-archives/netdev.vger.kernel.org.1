Return-Path: <netdev+bounces-26354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BC877796C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C12282133
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F76200DF;
	Thu, 10 Aug 2023 13:16:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1481E1CF
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:16:01 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FF910E7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:16:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso8687975e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691673359; x=1692278159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1lU8OubdkMxzgElR7QA8os9skh80GDhCaBnyZI9FEc=;
        b=IMyQWL2H+MmjedJT/1+Pq1co6fKc9GWexPHZX4/GkpxdPrNMG3AcI0MkEVNOGoLKRR
         lZQpj5WqMxq+Q4LVO26ilMUWzIvyBCZEL28MdimGs5oLcaSQggq3rClvFAlVLpgBnALb
         pImjEi6wLco4bZKbhNVFH4is84/Dy7yJ/wz69lzIVkgJxzWWvd4xMguR5rnNlNPJPIfs
         sceuA2Y2nb6bNnwTzpsAVAzwdMD4yr2qSWT4r5d8PACord64DRtwOikikjKU/5UG6J9U
         EW0P/4Wf4MF/8Tebn54JcnQkHIEeirFZ/JVJ+mnzDN0W14AJ6uCvGl6AjbEuEh72RKXP
         2QfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673359; x=1692278159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1lU8OubdkMxzgElR7QA8os9skh80GDhCaBnyZI9FEc=;
        b=kXa0ATLX9YLCKrljzfBR4WX5jxRNwVutldhUuq3SzWVmXdOxBPB9aVxW7/sT6n12PZ
         EHFSGZNggX+vI6UQDWvD5HdyPs5qqCmB4z/cLTNSwg8k1oy/hZDlME1iKbW1Er+qtG/P
         ZR5rCUruWmEL0yBUSBQJnq2EleEFHm3SOBbGuG+2F+ZihwOdSaeToDioOKZbqp+Tsaj1
         mcLQ6pN5XOT0Q2tM/s8CSZ6SqEEjrUq6H6d9yPTV0MA7zUP1XRLcVh7SN9UuWGugDIX3
         4Uew8wa3eKodb5BJvR2wX8EmOJqVY1aBuNLyb5eg4bC3qVKZpRYzgYIytQI4h9eQEbcw
         GQMw==
X-Gm-Message-State: AOJu0Yz29FoMeLWlass2YQeAmxlHlWDcaL71f/+471DJm31irdw+Bz3a
	GtfxskGbdkYU9dVSX3sXRhfDzrJrLzBr0CLK9jEN1g==
X-Google-Smtp-Source: AGHT+IFp2V2zi/9KnDMsJqJUXlqjEHIDY/dT69bwWbb0MxisX7Jzsaq0wkJRoLj04ptroPjJZji0FQ==
X-Received: by 2002:adf:dd85:0:b0:314:3985:b291 with SMTP id x5-20020adfdd85000000b003143985b291mr2014168wrl.15.1691673358895;
        Thu, 10 Aug 2023 06:15:58 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id z15-20020a1c4c0f000000b003fc0505be19sm2115318wmf.37.2023.08.10.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:15:58 -0700 (PDT)
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
Subject: [patch net-next v3 10/13] devlink: allow user to narrow per-instance dumps by passing handle attrs
Date: Thu, 10 Aug 2023 15:15:36 +0200
Message-ID: <20230810131539.1602299-11-jiri@resnulli.us>
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

For SFs, one devlink instance per SF is created. There might be
thousands of these on a single host. When a user needs to know port
handle for specific SF, he needs to dump all devlink ports on the host
which does not scale good.

Allow user to pass devlink handle attributes alongside the dump command
and dump only objects which are under selected devlink instance.

Example:
$ devlink port show
auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false
auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false

$ devlink port show auxiliary/mlx5_core.eth.0
auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false

$ devlink port show auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- rebased on top of the generated split ops changes
- removed SELECTOR nested attr
- rebased on top of flags arg propagation, added NLM_F_DUMP_FILTERED
- removed no longer needed start() and done() dump callbacks
- adjusted patch subject and description to better match what
  the patch does now
v1->v2:
- extended to patch that covers all dumpit commands
- used start() and done() callback to parse the selector attr
- changed the selector attr netlink policy to be created on fly
- changed patch description accordingly
---
 net/devlink/netlink.c | 45 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 47e44fb45815..cd274ae13ae4 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -170,8 +170,29 @@ void devlink_nl_post_doit(const struct genl_split_ops *ops,
 	devlink_put(devlink);
 }
 
-int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
-		      devlink_nl_dump_one_func_t *dump_one)
+static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
+					 struct netlink_callback *cb, int flags,
+					 devlink_nl_dump_one_func_t *dump_one,
+					 struct nlattr **attrs)
+{
+	struct devlink *devlink;
+	int err;
+
+	devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), attrs);
+	if (IS_ERR(devlink))
+		return PTR_ERR(devlink);
+	err = dump_one(msg, devlink, cb, flags);
+	devl_unlock(devlink);
+	devlink_put(devlink);
+
+	if (err != -EMSGSIZE)
+		return err;
+	return msg->len;
+}
+
+static int devlink_nl_inst_iter_dumpit(struct sk_buff *msg,
+				       struct netlink_callback *cb, int flags,
+				       devlink_nl_dump_one_func_t *dump_one)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink *devlink;
@@ -182,7 +203,7 @@ int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		devl_lock(devlink);
 
 		if (devl_is_registered(devlink))
-			err = dump_one(msg, devlink, cb, NLM_F_MULTI);
+			err = dump_one(msg, devlink, cb, flags);
 		else
 			err = 0;
 
@@ -203,6 +224,24 @@ int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 	return msg->len;
 }
 
+int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
+		      devlink_nl_dump_one_func_t *dump_one)
+{
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct nlattr **attrs = info->attrs;
+	int flags = NLM_F_MULTI;
+
+	if (attrs)
+		flags |= NLM_F_DUMP_FILTERED;
+
+	if (attrs &&
+	    (attrs[DEVLINK_ATTR_BUS_NAME] || attrs[DEVLINK_ATTR_DEV_NAME]))
+		return devlink_nl_inst_single_dumpit(msg, cb, flags, dump_one,
+						     attrs);
+	else
+		return devlink_nl_inst_iter_dumpit(msg, cb, flags, dump_one);
+}
+
 struct genl_family devlink_nl_family __ro_after_init = {
 	.name		= DEVLINK_GENL_NAME,
 	.version	= DEVLINK_GENL_VERSION,
-- 
2.41.0


