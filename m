Return-Path: <netdev+bounces-26862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F67793B1
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34988281438
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D044634CDB;
	Fri, 11 Aug 2023 15:57:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E834CD8
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:57:36 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23A0270F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbea147034so18775815e9.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691769454; x=1692374254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2uWE/9CGZ/jzqBUWPrNUa+8tEdP/zxdouBROx2qyhc=;
        b=OLRSBMaxbdNTmpoyHwkC1mBWtfAaSGEwqMzCWVTv+PsnUWKDy1F72Q5cZY0+H1OR9o
         7gMDIGu5aOwaIm1027rqDkdQk2lR+d1dMvLi9aHw99sqUIF9a1h4TIBFpJZ1ERUGgXib
         sbvVeSFL++My4SjGts7D7OcltnbV/zpDqD3kY7CTAyKaWQqnKIkWGbLoFqZi9fc0Sder
         yC4tkpHMyL1IFwusfGU9aPbv4rXKOVloVcjID/En8H5aAq0gIYCKzRBf0aWfE+YdOPhG
         CkK/e5jLFHrqn4VyVHMfT7TmOHMQdOxMfXrZW7u/Gmf6CUnoR2epY6d3JTrX8oNEhALT
         lOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769454; x=1692374254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2uWE/9CGZ/jzqBUWPrNUa+8tEdP/zxdouBROx2qyhc=;
        b=WnsrHLW9hiXvHMH5zyPp70aQOBPXs+X6ft5Pz23dboHqBaKkGLtlDbbgDMZZNUUz0z
         bRau9qhFBY1UqzpcDoqE3IbXhi6eCyDKC7jtPQdg+WD1x9/zmN5PBA6iyhnc4GO+XwAc
         AmBqDFM0199wXuiyac5zDhwzOocpZLBOUP+FLhufRXoJGdspCbCC5I+ChaEvHpxc58oh
         /ihr34dbdL8V6rTXQET01KSP9rt+/udAgHHvddWtICBSVKerxYdRRE3Ta6JbOTFe5DkK
         XLfvWJNiYB8ieMUs537VOd+veUmuV/aJz3SUxf5QOcWRYu1KbFtP9LZXq+zf3Hfpn/dX
         VSDQ==
X-Gm-Message-State: AOJu0YxtnTeZg796d7giUrwX24mwh+UIMmxGboyd69+W8dbgZeFP4YlP
	NyPmG+EIDt3bLYk7MM6YV9AzEcLcAm5EjPZFMubDVg==
X-Google-Smtp-Source: AGHT+IHgt//GDxf0DnqEUTxHjdFwaww1Np/IHbyjBJot2VmNCI+jiDCBARmIl6GedzNGb9lxljY6oA==
X-Received: by 2002:adf:f686:0:b0:314:2b0a:dabe with SMTP id v6-20020adff686000000b003142b0adabemr1895553wrp.30.1691769454388;
        Fri, 11 Aug 2023 08:57:34 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id i12-20020a5d630c000000b0031435731dfasm5829989wru.35.2023.08.11.08.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:57:33 -0700 (PDT)
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
Subject: [patch net-next v4 10/13] devlink: allow user to narrow per-instance dumps by passing handle attrs
Date: Fri, 11 Aug 2023 17:57:11 +0200
Message-ID: <20230811155714.1736405-11-jiri@resnulli.us>
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
v3->v4:
- fixed NLM_F_DUMP_FILTERED setting
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
 net/devlink/netlink.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 47e44fb45815..a9b43b0c5959 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -170,8 +170,30 @@ void devlink_nl_post_doit(const struct genl_split_ops *ops,
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
+	err = dump_one(msg, devlink, cb, flags | NLM_F_DUMP_FILTERED);
+
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
@@ -182,7 +204,7 @@ int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		devl_lock(devlink);
 
 		if (devl_is_registered(devlink))
-			err = dump_one(msg, devlink, cb, NLM_F_MULTI);
+			err = dump_one(msg, devlink, cb, flags);
 		else
 			err = 0;
 
@@ -203,6 +225,21 @@ int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 	return msg->len;
 }
 
+int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
+		      devlink_nl_dump_one_func_t *dump_one)
+{
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct nlattr **attrs = info->attrs;
+	int flags = NLM_F_MULTI;
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


