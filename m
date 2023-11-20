Return-Path: <netdev+bounces-49132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABBE7F0E14
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0C71C21624
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4D3FBFB;
	Mon, 20 Nov 2023 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dBp11RtN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EBF1713
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:16 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so6002674a12.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700470035; x=1701074835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htebmSb+wNlEeqd9kaA68nWsJmpSi+7d0VYs1jUfc3U=;
        b=dBp11RtNMOsahVOl9cUli1YrSYI/dD5+x0i8ryuEXmGxTfYK1KVxBKQMR7y48ueEpU
         D/FpN4zK3NJKxp/pwdVJ93xc/ZFKogfbDNPKktlblVbG554ig0AJDzUOgry44R0GaW5c
         Y85EXrylWOruKxl8PdBnVaX1XHvOKlFhirsgsw876Uo8T1JMz8Y3ZXRn39oJX5TQVfdz
         cP99NCMyqmIv8nW5LGrHEP/DIEF1xzq2LLR3XhKdKPUo0odduM3+Dr/Kp3YChVYoLuB4
         1zV03jcpS5Y3PcprOvRmr0gfz2L9VzcL8EGHsWz8KFa0oh173lAQg6loaLX53sbZf/4y
         6pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470035; x=1701074835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htebmSb+wNlEeqd9kaA68nWsJmpSi+7d0VYs1jUfc3U=;
        b=TF5fSDrCIJOSV/dyXp0Cdm6IHtNZNfY74yFW/0Nikc+cD1EsrOlSmLmo21xoEoqtwG
         XUy95+rXZO7uer//dGm9lIEyG/SiiVgnhO0k3/M5zNHCrBOkELRqsc7NdHVbZQ06CDK6
         HAAVJ0J3cxyVXJJUO0Vy7EYNYVb19U2kKq8ceTpLjC6jOJIu6E33KHHYiYgGAePSZiMr
         d7T8xdW2VNDx1pTZJy6GEpwLh2jkuqV1o+QDWmd4s2wK9LQCaz4kNZ/XS3X5M3OWs0MB
         liwrtuzQdGnyAmZzMwmvoIfcPM8296Fuyvs8js1+IL2z97J0gm2LFBY4P9/g17vR25th
         Arqg==
X-Gm-Message-State: AOJu0Ywtnafn2kuMwPAREztY18kRXxRShYkwNFXoLwzuUbHDE/ylSl+J
	63TSgx2F3xSJLswgS73Wa0RdcW8Q0ZmUaGHCvDzpOw==
X-Google-Smtp-Source: AGHT+IEEw0kUY7NP1xo8anWcQXXVJ3Vuj7HTQLfXDMB3urwSsz6f6VZoDNCz+6t/ssr86JX5o1ME1w==
X-Received: by 2002:a50:ee17:0:b0:543:7201:7c70 with SMTP id g23-20020a50ee17000000b0054372017c70mr6440000eds.7.1700470035333;
        Mon, 20 Nov 2023 00:47:15 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402070b00b005489d3b0a58sm1459159edx.55.2023.11.20.00.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:47:14 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com,
	horms@kernel.org
Subject: [patch net-next v3 8/9] devlink: add a command to set notification filter and use it for multicasts
Date: Mon, 20 Nov 2023 09:46:56 +0100
Message-ID: <20231120084657.458076-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120084657.458076-1-jiri@resnulli.us>
References: <20231120084657.458076-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently the user listening on a socket for devlink notifications
gets always all messages for all existing instances, even if he is
interested only in one of those. That may cause unnecessary overhead
on setups with thousands of instances present.

User is currently able to narrow down the devlink objects replies
to dump commands by specifying select attributes.

Allow similar approach for notifications. Introduce a new devlink
NOTIFY_FILTER_SET which the user passes the select attributes. Store
these per-socket and use them for filtering messages
during multicast send.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 10 ++++
 include/uapi/linux/devlink.h             |  2 +
 net/devlink/devl_internal.h              | 33 +++++++++++-
 net/devlink/netlink.c                    | 69 ++++++++++++++++++++++++
 net/devlink/netlink_gen.c                | 15 +++++-
 net/devlink/netlink_gen.h                |  4 +-
 tools/net/ynl/generated/devlink-user.c   | 31 +++++++++++
 tools/net/ynl/generated/devlink-user.h   | 47 ++++++++++++++++
 8 files changed, 207 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 572d83a414d0..cc4991cbce83 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2055,3 +2055,13 @@ operations:
             - bus-name
             - dev-name
             - selftests
+
+    -
+      name: notify-filter-set
+      doc: Set notification messages socket filter.
+      attribute-set: devlink
+      do:
+        request:
+          attributes:
+            - bus-name
+            - dev-name
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index b3c8383d342d..130cae0d3e20 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -139,6 +139,8 @@ enum devlink_command {
 	DEVLINK_CMD_SELFTESTS_GET,	/* can dump */
 	DEVLINK_CMD_SELFTESTS_RUN,
 
+	DEVLINK_CMD_NOTIFY_FILTER_SET,
+
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index e19e8dd47092..0ee0bcdd4a7d 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -178,11 +178,40 @@ static inline bool devlink_nl_notify_need(struct devlink *devlink)
 				  DEVLINK_MCGRP_CONFIG);
 }
 
+struct devlink_obj_desc {
+	const char *bus_name;
+	const char *dev_name;
+	long data[];
+};
+
+static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
+					    struct devlink *devlink)
+{
+	memset(desc, 0, sizeof(*desc));
+	desc->bus_name = devlink->dev->bus->name;
+	desc->dev_name = dev_name(devlink->dev);
+}
+
+int devlink_nl_notify_filter(struct sock *dsk, struct sk_buff *skb, void *data);
+
+static inline void devlink_nl_notify_send_desc(struct devlink *devlink,
+					       struct sk_buff *msg,
+					       struct devlink_obj_desc *desc)
+{
+	genlmsg_multicast_netns_filtered(&devlink_nl_family,
+					 devlink_net(devlink),
+					 msg, 0, DEVLINK_MCGRP_CONFIG,
+					 GFP_KERNEL,
+					 devlink_nl_notify_filter, desc);
+}
+
 static inline void devlink_nl_notify_send(struct devlink *devlink,
 					  struct sk_buff *msg)
 {
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	struct devlink_obj_desc desc;
+
+	devlink_nl_obj_desc_init(&desc, devlink);
+	devlink_nl_notify_send_desc(devlink, msg, &desc);
 }
 
 /* Notify */
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index d0b90ebc8b15..738e2f340ab9 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -13,6 +13,75 @@ static const struct genl_multicast_group devlink_nl_mcgrps[] = {
 	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
 };
 
+int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
+				      struct genl_info *info)
+{
+	struct sock *sk = NETLINK_CB(skb).sk;
+	struct nlattr **attrs = info->attrs;
+	struct devlink_obj_desc *flt;
+	size_t data_offset = 0;
+	size_t data_size = 0;
+	char *pos;
+
+	if (attrs[DEVLINK_ATTR_BUS_NAME])
+		data_size += nla_len(attrs[DEVLINK_ATTR_BUS_NAME]) + 1;
+	if (attrs[DEVLINK_ATTR_DEV_NAME])
+		data_size += nla_len(attrs[DEVLINK_ATTR_DEV_NAME]) + 1;
+
+	flt = kzalloc(sizeof(*flt) + data_size, GFP_KERNEL);
+	if (!flt)
+		return -ENOMEM;
+
+	pos = (char *) flt->data;
+	if (attrs[DEVLINK_ATTR_BUS_NAME]) {
+		data_offset += nla_strscpy(pos,
+					   attrs[DEVLINK_ATTR_BUS_NAME],
+					   data_size) + 1;
+		flt->bus_name = pos;
+		pos += data_offset;
+	}
+	if (attrs[DEVLINK_ATTR_DEV_NAME]) {
+		nla_strscpy(pos, attrs[DEVLINK_ATTR_DEV_NAME],
+			    data_size - data_offset);
+		flt->dev_name = pos;
+	}
+
+	/* Free the existing filter if any. */
+	kfree(sk->sk_user_data);
+
+	/* Don't attach empty filter. */
+	if (!flt->bus_name && !flt->dev_name) {
+		kfree(flt);
+		flt = NULL;
+	}
+
+	sk->sk_user_data = flt;
+	return 0;
+}
+
+static bool devlink_obj_desc_match(const struct devlink_obj_desc *desc,
+				   const struct devlink_obj_desc *flt)
+{
+	if (desc->bus_name && flt->bus_name &&
+	    strcmp(desc->bus_name, flt->bus_name))
+		return false;
+	if (desc->dev_name && flt->dev_name &&
+	    strcmp(desc->dev_name, flt->dev_name))
+		return false;
+	return true;
+}
+
+int devlink_nl_notify_filter(struct sock *dsk, struct sk_buff *skb, void *data)
+{
+	struct devlink_obj_desc *flt = dsk->sk_user_data;
+	struct devlink_obj_desc *desc = data;
+
+	if (!flt)
+		return 0;
+
+	return !devlink_obj_desc_match(desc, flt);
+}
+
 int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
 				 struct devlink *devlink, int attrtype)
 {
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 788dfdc498a9..f207f3fc7e20 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -560,8 +560,14 @@ static const struct nla_policy devlink_selftests_run_nl_policy[DEVLINK_ATTR_SELF
 	[DEVLINK_ATTR_SELFTESTS] = NLA_POLICY_NESTED(devlink_dl_selftest_id_nl_policy),
 };
 
+/* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
+static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* Ops table for devlink */
-const struct genl_split_ops devlink_nl_ops[73] = {
+const struct genl_split_ops devlink_nl_ops[74] = {
 	{
 		.cmd		= DEVLINK_CMD_GET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
@@ -1233,4 +1239,11 @@ const struct genl_split_ops devlink_nl_ops[73] = {
 		.maxattr	= DEVLINK_ATTR_SELFTESTS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DEVLINK_CMD_NOTIFY_FILTER_SET,
+		.doit		= devlink_nl_notify_filter_set_doit,
+		.policy		= devlink_notify_filter_set_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 0e9e89c31c31..71693d834ad2 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -16,7 +16,7 @@ extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_F
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
-extern const struct genl_split_ops devlink_nl_ops[73];
+extern const struct genl_split_ops devlink_nl_ops[74];
 
 int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
@@ -137,5 +137,7 @@ int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
 				    struct netlink_callback *cb);
 int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
+				      struct genl_info *info);
 
 #endif /* _LINUX_DEVLINK_GEN_H */
diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index bc5065bd99b2..cd5f70eadf5b 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -6830,6 +6830,37 @@ int devlink_selftests_run(struct ynl_sock *ys,
 	return 0;
 }
 
+/* ============== DEVLINK_CMD_NOTIFY_FILTER_SET ============== */
+/* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
+void
+devlink_notify_filter_set_req_free(struct devlink_notify_filter_set_req *req)
+{
+	free(req->bus_name);
+	free(req->dev_name);
+	free(req);
+}
+
+int devlink_notify_filter_set(struct ynl_sock *ys,
+			      struct devlink_notify_filter_set_req *req)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_NOTIFY_FILTER_SET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
+
+	err = ynl_exec(ys, nlh, NULL);
+	if (err < 0)
+		return -1;
+
+	return 0;
+}
+
 const struct ynl_family ynl_devlink_family =  {
 	.name		= "devlink",
 };
diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
index 1db4edc36eaa..e5d79b824a67 100644
--- a/tools/net/ynl/generated/devlink-user.h
+++ b/tools/net/ynl/generated/devlink-user.h
@@ -5252,4 +5252,51 @@ devlink_selftests_run_req_set_selftests_flash(struct devlink_selftests_run_req *
 int devlink_selftests_run(struct ynl_sock *ys,
 			  struct devlink_selftests_run_req *req);
 
+/* ============== DEVLINK_CMD_NOTIFY_FILTER_SET ============== */
+/* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
+struct devlink_notify_filter_set_req {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_notify_filter_set_req *
+devlink_notify_filter_set_req_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_notify_filter_set_req));
+}
+void
+devlink_notify_filter_set_req_free(struct devlink_notify_filter_set_req *req);
+
+static inline void
+devlink_notify_filter_set_req_set_bus_name(struct devlink_notify_filter_set_req *req,
+					   const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_notify_filter_set_req_set_dev_name(struct devlink_notify_filter_set_req *req,
+					   const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
+/*
+ * Set notification messages socket filter.
+ */
+int devlink_notify_filter_set(struct ynl_sock *ys,
+			      struct devlink_notify_filter_set_req *req);
+
 #endif /* _LINUX_DEVLINK_GEN_H */
-- 
2.41.0


