Return-Path: <netdev+bounces-27698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C96B77CE7E
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62551C20D8D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7851D1429D;
	Tue, 15 Aug 2023 14:52:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BDE14270
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 14:52:10 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A4E1BC2
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:52:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe490c05c9so37785815e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692111122; x=1692715922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96rV7vulxyafEpNNLIvobkaEuUWlM7rFcKC40bxHGLQ=;
        b=jYCAaFGYinoJ2ZMhrlviCGmLx5m8J+Lasdmci5EmpII1iT1BxYYdnRKWz5F2J2PFd1
         fUODtFVht+QnxvUNBCaPv59AgcMuZzWVdfhLRBOAKjlC4YqmuUwAevGACdNuSItG0yx9
         RVH4bfANPNg5zzbNDaQWb7Iv2SYRz71D70uwdjG8oR4k33IdTwIasBvJhRaNd1cI2E8Z
         vvExJqPDGw7V77gyYDVBzZAa++GUl2rpjsVp5x98zc+5WteJXsEZdnsNLFyTMmNa8D0k
         Fyu1jfmZ1Y5tg6KaV36vZokRUgPdg23/o1WMjoCx0JIwyksGP+uKvK4M/IMpgDc0IP8t
         v1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692111122; x=1692715922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96rV7vulxyafEpNNLIvobkaEuUWlM7rFcKC40bxHGLQ=;
        b=HSiZJIHvjNswkfj/jyS/4OpyC08TpxEYuNIvAxhlKe0/ag8QNvbyNP3te7rmDdWubn
         mg3oEb1nObbZZLMkv7SB3VkLSN40IeWtYeT3DY1Y9Ss9HPvBjEBudPxze0+HMOeJqylW
         TmXdtT7XXCSs2Q787xjh5ChPbzLOFxt2SjM9cSF3C7hj3dfCrDMAgSrQHKUiRoMA/SIS
         IgfyKmIxgxy9nVrtFge1p5AfFlZkv36FkuhY2mycbNhL2M54abNiCYE+xM21mPt5qY4b
         qf7hc/vZ75MP7JqX3e4ultKEKZtkGJqJGI8DK9qrc87lmssNbRYwW7TnImHcpNnnhS07
         J4Vg==
X-Gm-Message-State: AOJu0YySvBlS6HOPyGfB++JX/mRvWdX+MeSYdQz+k7M8NnxUYa2xBA3V
	TsGu0hxaTx4eBwgVeY9/VJeUt9cakoeuT9mLX81R9wsQ
X-Google-Smtp-Source: AGHT+IGtCNiQEdmOVdrPRLWCRWrunq2n5/kkUZ2SRWeqQSC1/RDwH9OCtm7X+lQiQCB6JnH5cz/uHQ==
X-Received: by 2002:a5d:6a45:0:b0:317:52ba:81f2 with SMTP id t5-20020a5d6a45000000b0031752ba81f2mr1686873wrw.16.1692111122383;
        Tue, 15 Aug 2023 07:52:02 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c378d00b003fe2de3f94fsm18011150wmr.12.2023.08.15.07.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:52:01 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	shayd@nvidia.com,
	leon@kernel.org
Subject: [patch net-next 3/4] devlink: expose peer SF devlink instance
Date: Tue, 15 Aug 2023 16:51:54 +0200
Message-ID: <20230815145155.1946926-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815145155.1946926-1-jiri@resnulli.us>
References: <20230815145155.1946926-1-jiri@resnulli.us>
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

Introduce a new helper devl_port_fn_devlink_set() to be used by driver
assigning a devlink instance to the peer devlink port function.

Expose this to user over new netlink attribute nested under port
function nest to expose devlink handle related to the port function.

This is particularly helpful for user to understand the relationship
between devlink instances created for SFs and the port functions
they belong to.

Note that caller of devlink_port_notify() needs to hold devlink
instance lock, put the assertion to devl_port_fn_devlink_set() to make
this requirement explicit. Also note the limitations that only allow to
make this assignment for registered objects.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/net/devlink.h        |  4 ++++
 include/uapi/linux/devlink.h |  1 +
 net/devlink/leftover.c       | 45 +++++++++++++++++++++++++++++++++---
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index f7fec0791acc..49662d44471c 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -150,6 +150,8 @@ struct devlink_port {
 
 	struct devlink_rate *devlink_rate;
 	struct devlink_linecard *linecard;
+
+	struct devlink *fn_devlink; /* Peer function devlink instance */
 };
 
 struct devlink_port_new_attrs {
@@ -1667,6 +1669,8 @@ void devlink_port_attrs_pci_vf_set(struct devlink_port *devlink_port, u32 contro
 void devlink_port_attrs_pci_sf_set(struct devlink_port *devlink_port,
 				   u32 controller, u16 pf, u32 sf,
 				   bool external);
+void devl_port_fn_devlink_set(struct devlink_port *devlink_port,
+			      struct devlink *fn_devlink);
 struct devlink_rate *
 devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 		      struct devlink_rate *parent);
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 3782d4219ac9..dd96086860ca 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -676,6 +676,7 @@ enum devlink_port_function_attr {
 	DEVLINK_PORT_FN_ATTR_STATE,	/* u8 */
 	DEVLINK_PORT_FN_ATTR_OPSTATE,	/* u8 */
 	DEVLINK_PORT_FN_ATTR_CAPS,	/* bitfield32 */
+	DEVLINK_PORT_FN_ATTR_DEVLINK,	/* nested */
 
 	__DEVLINK_PORT_FUNCTION_ATTR_MAX,
 	DEVLINK_PORT_FUNCTION_ATTR_MAX = __DEVLINK_PORT_FUNCTION_ATTR_MAX - 1
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 3883a90d32bb..89172c5e3eaa 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -591,11 +591,12 @@ devlink_region_snapshot_get_by_id(struct devlink_region *region, u32 id)
 	return NULL;
 }
 
-static int devlink_nl_put_nested_handle(struct sk_buff *msg, struct devlink *devlink)
+static int devlink_nl_put_nested_handle(struct sk_buff *msg, struct devlink *devlink,
+					int attrtype)
 {
 	struct nlattr *nested_attr;
 
-	nested_attr = nla_nest_start(msg, DEVLINK_ATTR_NESTED_DEVLINK);
+	nested_attr = nla_nest_start(msg, attrtype);
 	if (!nested_attr)
 		return -EMSGSIZE;
 	if (devlink_nl_put_handle(msg, devlink))
@@ -884,6 +885,15 @@ devlink_nl_port_function_attrs_put(struct sk_buff *msg, struct devlink_port *por
 	if (err)
 		goto out;
 	err = devlink_port_fn_state_fill(port, msg, extack, &msg_updated);
+	if (err)
+		goto out;
+	if (port->fn_devlink) {
+		err = devlink_nl_put_nested_handle(msg, port->fn_devlink,
+						   DEVLINK_PORT_FN_ATTR_DEVLINK);
+		if (!err)
+			msg_updated = true;
+	}
+
 out:
 	if (err || !msg_updated)
 		nla_nest_cancel(msg, function_attr);
@@ -1785,7 +1795,8 @@ static int devlink_nl_linecard_fill(struct sk_buff *msg,
 	}
 
 	if (linecard->nested_devlink &&
-	    devlink_nl_put_nested_handle(msg, linecard->nested_devlink))
+	    devlink_nl_put_nested_handle(msg, linecard->nested_devlink,
+					 DEVLINK_ATTR_NESTED_DEVLINK))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
@@ -7133,6 +7144,34 @@ void devlink_port_attrs_pci_sf_set(struct devlink_port *devlink_port, u32 contro
 }
 EXPORT_SYMBOL_GPL(devlink_port_attrs_pci_sf_set);
 
+/**
+ * devl_port_fn_devlink_set - Attach/detach peer devlink
+ *			      instance to port function.
+ * @devlink_port: devlink port
+ * @fn_devlink: devlink instance to attach or NULL to detach
+ */
+void devl_port_fn_devlink_set(struct devlink_port *devlink_port,
+			      struct devlink *fn_devlink)
+{
+	lockdep_assert_held(&devlink_port->devlink->lock);
+	ASSERT_DEVLINK_PORT_REGISTERED(devlink_port);
+
+	if (fn_devlink)
+		ASSERT_DEVLINK_REGISTERED(fn_devlink);
+	else if (WARN_ON(!devlink_port->fn_devlink))
+		return;
+	else
+		ASSERT_DEVLINK_REGISTERED(devlink_port->fn_devlink);
+
+	if (WARN_ON(devlink_port->attrs.flavour != DEVLINK_PORT_FLAVOUR_PCI_SF ||
+		    devlink_port->attrs.pci_sf.external))
+		return;
+
+	devlink_port->fn_devlink = fn_devlink;
+	devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_NEW);
+}
+EXPORT_SYMBOL_GPL(devl_port_fn_devlink_set);
+
 /**
  * devl_rate_node_create - create devlink rate node
  * @devlink: devlink instance
-- 
2.41.0


