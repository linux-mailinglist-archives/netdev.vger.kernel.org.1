Return-Path: <netdev+bounces-56348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E22280E8EE
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E871F21AC9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB09B5C8FE;
	Tue, 12 Dec 2023 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="d3zTKQXt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEA3A6
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:54 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1e116f2072so1118186766b.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702376273; x=1702981073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9Yp3x4mB8o6EVxoJQRF1QQfUP6GGPqcslyRHb22d6c=;
        b=d3zTKQXtiscKoDj+9qwFsfYuz2h0iIGK5C/tIC5CJEIShuK3Axva+XbJrJInDdh0xY
         wVwJOhOBIi8sVci5aX1B/t1LnCr+7eNKWmTgbsyh6EtlP+zniOv/AjAl03Tj1X9c0n7g
         lrY1ocgAoudYjDWJegbkikj750WteYsnYHMPeXvzH8xfMo1s42ZnsOqcMWEBgRUgyDWH
         qFrD+NpX+IdqHximrRcI3FIKZ8EFwMwEYdsqkkeoW8NAQ/9EHOPjPGsoB8WPGgAE61eK
         Nolb7xRoS1oXTH31XngrkfL6sY6rQtWkskDLXomiYeICVwg8Dvhq09Bu2ymjJQ/yvUT/
         Cl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376273; x=1702981073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9Yp3x4mB8o6EVxoJQRF1QQfUP6GGPqcslyRHb22d6c=;
        b=u6R1o1dc5E/Ep73lrSglT6Mva6VMN0Y+WquD+rxWYf8u3/qj9TPJJUzvjW90cM2u2x
         m7m0QunqCro6lxd9RBfizNCOWw+70tQiLk8sizS54s6YKdXxgxDOMRgokL6MiKG/+ral
         efKHP+bEQMN2yX0QNiXPm5sLf2bc783CsBetmIsI8QFNG2PBPE0Nk1qzXG5rUfky8Ukm
         UENSL7tCn3+qG7hc7k7IEk0I+At/ijOqGPcOgjND/o7bHDF7bDcHBMtXRvXsRA+DWP06
         0jC+TAMNf6uI5fTwdFSlasg9EQWABSTFqtfGaK1M9Q6ETPlNGdPYp7FktemA4n0WfJ+Q
         WS8w==
X-Gm-Message-State: AOJu0YxADJGwqZWt98wIsXu50CvYIyBZrdSJBLnvyplZMZmNCnhTFnh+
	t2lFDZNmgzXdrLCHOXExAf5g7sr4Rm5YE7cy+t0=
X-Google-Smtp-Source: AGHT+IGAL4uZ30BQu9Wm1FDAYbCJXZW51xqdiferJHMra5zUX7DYKhL6idUAq+nqlLH2XWCHgnY8Rw==
X-Received: by 2002:a17:907:28c1:b0:a19:5cb3:c52d with SMTP id en1-20020a17090728c100b00a195cb3c52dmr6451674ejc.11.1702376273031;
        Tue, 12 Dec 2023 02:17:53 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id vc11-20020a170907d08b00b00a1b6d503e7esm6007486ejc.157.2023.12.12.02.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:17:52 -0800 (PST)
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
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [patch net-next v6 9/9] devlink: extend multicast filtering by port index
Date: Tue, 12 Dec 2023 11:17:36 +0100
Message-ID: <20231212101736.1112671-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212101736.1112671-1-jiri@resnulli.us>
References: <20231212101736.1112671-1-jiri@resnulli.us>
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
v4->v5:
- removed generated userspace bits
v3->v4:
- rebased on top of genl_sk_priv_*() introduction
---
 Documentation/netlink/specs/devlink.yaml |  1 +
 net/devlink/devl_internal.h              |  9 +++++++++
 net/devlink/health.c                     |  6 +++++-
 net/devlink/netlink.c                    | 10 +++++++++-
 net/devlink/netlink_gen.c                |  5 +++--
 net/devlink/port.c                       |  5 ++++-
 6 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 88bfcb3c3346..cf6eaa0da821 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2264,3 +2264,4 @@ operations:
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
index 06f294d34a04..c6de311130fb 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -73,8 +73,13 @@ int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
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
@@ -101,6 +106,9 @@ static bool devlink_obj_desc_match(const struct devlink_obj_desc *desc,
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
-- 
2.43.0


