Return-Path: <netdev+bounces-50638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3AC7F6613
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24DC3B2111A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF254A98C;
	Thu, 23 Nov 2023 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kOpQcz+W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BFA189
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:16:03 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a06e59384b6so111269966b.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700763362; x=1701368162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB+i87Epg6iQjagr/qaX8WtvurbfKry95yo/SWXW2MA=;
        b=kOpQcz+WHaRuvXgJmzapCeVeu3BX2wGqaWO1IzP0RATeN+JG/QBCzRHHjxR48hmzua
         JC7V6epEF48s3UIDssN81Au4RQfaMKF7KZqgky/4VnR8KSr0NdioeZMQlVgSFsmhRqMt
         22BWl690W3qboUArWHLK3LkhZBxRv5pdup6L6obQxEbNKfY2nEnCaAZu6sqcjdcBa7k/
         +B2PakFduIh1cwS87ZRRUFbszED4Nc8vLF3+HzrhaXliFJsAW7AfaANnboOcutV+Goyt
         e3nynEQztMmXzggp5FjmABrgAL0IH3r4pRKJdgfwXmAEhhPf/4Ao2E7sn6Lz9AHkpC2J
         UnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700763362; x=1701368162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB+i87Epg6iQjagr/qaX8WtvurbfKry95yo/SWXW2MA=;
        b=V/XU4JP/zR4dLJgRg7wlQDC36giBpIxU7Hv2ntMd3N6+YdH3xrVEwNwKTZ/9pUfkMf
         iOyk7mwXGXszgNuFXxuDF8tanwAsqXo8EUPOtVxhtf0/BL+Tie4rCtZCU1LGPtSAyzLi
         psGbtwSXwZn2bjkScKValVgbXYzZRVgF7CiTOuAqb3LMz2F92P2C6JXr9QpOGHr0gRJN
         GLNERxM8QcCiIE69CGwntN9vvjeINCX0bxKLVZ7uXz+QViCMHebEP/J9XHxTAW72NxIX
         BtggLovji5n91bKBXH2YL9A6TqTq378XraCGBuxawzULHnrB9uvJND0DWAl71QibebGP
         SroQ==
X-Gm-Message-State: AOJu0Yzk0B26LoMzOey7vMgEXpE4hpQPncoCo2SkZOJQHM4hOrOSjS9X
	vbaR4tEqBkbvnakYa11n1J+QkwUnMHerQmNiKww=
X-Google-Smtp-Source: AGHT+IEh0b+/o+FW7TXGPWgTE+BnTfqQiG3UmKAe+ye7uySHSNTUiiq802AX4GpN/YatarEE0xLiAQ==
X-Received: by 2002:a17:906:a202:b0:9ae:41db:c27f with SMTP id r2-20020a170906a20200b009ae41dbc27fmr96648ejy.10.1700763362115;
        Thu, 23 Nov 2023 10:16:02 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906119400b009fbdacf9363sm1063763eja.21.2023.11.23.10.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:16:01 -0800 (PST)
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
Subject: [patch net-next v4 9/9] devlink: extend multicast filtering by port index
Date: Thu, 23 Nov 2023 19:15:46 +0100
Message-ID: <20231123181546.521488-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123181546.521488-1-jiri@resnulli.us>
References: <20231123181546.521488-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Expose the previously introduced notification multicast messages
filtering infrastructure and allow the user to select messages using
port index.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- rebased on top of genl_sk_priv_*() introduction
---
 Documentation/netlink/specs/devlink.yaml |  1 +
 net/devlink/devl_internal.h              |  9 +++++++++
 net/devlink/health.c                     |  6 +++++-
 net/devlink/netlink.c                    | 10 +++++++++-
 net/devlink/netlink_gen.c                |  5 +++--
 net/devlink/port.c                       |  5 ++++-
 tools/net/ynl/generated/devlink-user.c   |  2 ++
 tools/net/ynl/generated/devlink-user.h   |  9 +++++++++
 8 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 6bad1d3454b7..4996ff7e09b6 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2065,3 +2065,4 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - port-index
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 82e0fb3bbebf..c7a8e13f917c 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -195,6 +195,8 @@ struct devlink_obj_desc {
 	struct rcu_head rcu;
 	const char *bus_name;
 	const char *dev_name;
+	unsigned int port_index;
+	bool port_index_valid;
 	long data[];
 };
 
@@ -206,6 +208,13 @@ static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
 	desc->dev_name = dev_name(devlink->dev);
 }
 
+static inline void devlink_nl_obj_desc_port_set(struct devlink_obj_desc *desc,
+						struct devlink_port *devlink_port)
+{
+	desc->port_index = devlink_port->index;
+	desc->port_index_valid = true;
+}
+
 int devlink_nl_notify_filter(struct sock *dsk, struct sk_buff *skb, void *data);
 
 static inline void devlink_nl_notify_send_desc(struct devlink *devlink,
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 1d59ec0202f6..acb8c0e174bb 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -490,6 +490,7 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 				   enum devlink_command cmd)
 {
 	struct devlink *devlink = reporter->devlink;
+	struct devlink_obj_desc desc;
 	struct sk_buff *msg;
 	int err;
 
@@ -509,7 +510,10 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 		return;
 	}
 
-	devlink_nl_notify_send(devlink, msg);
+	devlink_nl_obj_desc_init(&desc, devlink);
+	if (reporter->devlink_port)
+		devlink_nl_obj_desc_port_set(&desc, reporter->devlink_port);
+	devlink_nl_notify_send_desc(devlink, msg, &desc);
 }
 
 void
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 33a8e51dea68..7d3635b30725 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -49,8 +49,13 @@ int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 		flt->dev_name = pos;
 	}
 
+	if (attrs[DEVLINK_ATTR_PORT_INDEX]) {
+		flt->port_index = nla_get_u32(attrs[DEVLINK_ATTR_PORT_INDEX]);
+		flt->port_index_valid = true;
+	}
+
 	/* Don't attach empty filter. */
-	if (!flt->bus_name && !flt->dev_name) {
+	if (!flt->bus_name && !flt->dev_name && !flt->port_index_valid) {
 		kfree(flt);
 		flt = NULL;
 	}
@@ -73,6 +78,9 @@ static bool devlink_obj_desc_match(const struct devlink_obj_desc *desc,
 	if (desc->dev_name && flt->dev_name &&
 	    strcmp(desc->dev_name, flt->dev_name))
 		return false;
+	if (desc->port_index_valid && flt->port_index_valid &&
+	    desc->port_index != flt->port_index)
+		return false;
 	return true;
 }
 
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 1cb0e05305d2..c81cf2dd154f 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -561,9 +561,10 @@ static const struct nla_policy devlink_selftests_run_nl_policy[DEVLINK_ATTR_SELF
 };
 
 /* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
-static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* Ops table for devlink */
@@ -1243,7 +1244,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.cmd		= DEVLINK_CMD_NOTIFY_FILTER_SET,
 		.doit		= devlink_nl_notify_filter_set_doit,
 		.policy		= devlink_notify_filter_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 758df3000a1b..62e54e152ecf 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -507,6 +507,7 @@ static void devlink_port_notify(struct devlink_port *devlink_port,
 				enum devlink_command cmd)
 {
 	struct devlink *devlink = devlink_port->devlink;
+	struct devlink_obj_desc desc;
 	struct sk_buff *msg;
 	int err;
 
@@ -525,7 +526,9 @@ static void devlink_port_notify(struct devlink_port *devlink_port,
 		return;
 	}
 
-	devlink_nl_notify_send(devlink, msg);
+	devlink_nl_obj_desc_init(&desc, devlink);
+	devlink_nl_obj_desc_port_set(&desc, devlink_port);
+	devlink_nl_notify_send_desc(devlink, msg, &desc);
 }
 
 static void devlink_ports_notify(struct devlink *devlink,
diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index cd5f70eadf5b..86392da0b52c 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -6853,6 +6853,8 @@ int devlink_notify_filter_set(struct ynl_sock *ys,
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
 	if (req->_present.dev_name_len)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
+	if (req->_present.port_index)
+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
 
 	err = ynl_exec(ys, nlh, NULL);
 	if (err < 0)
diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
index e5d79b824a67..b96837663e6e 100644
--- a/tools/net/ynl/generated/devlink-user.h
+++ b/tools/net/ynl/generated/devlink-user.h
@@ -5258,10 +5258,12 @@ struct devlink_notify_filter_set_req {
 	struct {
 		__u32 bus_name_len;
 		__u32 dev_name_len;
+		__u32 port_index:1;
 	} _present;
 
 	char *bus_name;
 	char *dev_name;
+	__u32 port_index;
 };
 
 static inline struct devlink_notify_filter_set_req *
@@ -5292,6 +5294,13 @@ devlink_notify_filter_set_req_set_dev_name(struct devlink_notify_filter_set_req
 	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
 	req->dev_name[req->_present.dev_name_len] = 0;
 }
+static inline void
+devlink_notify_filter_set_req_set_port_index(struct devlink_notify_filter_set_req *req,
+					     __u32 port_index)
+{
+	req->_present.port_index = 1;
+	req->port_index = port_index;
+}
 
 /*
  * Set notification messages socket filter.
-- 
2.41.0


