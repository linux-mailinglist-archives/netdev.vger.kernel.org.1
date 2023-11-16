Return-Path: <netdev+bounces-48445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734C57EE57E
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2C61C20BC2
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CD941A9A;
	Thu, 16 Nov 2023 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZEnTi0/F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0B7D6C
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:39 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9dbb3e0ff65so149822766b.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700153318; x=1700758118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA/ZFK3xawEcyb9omOiGWO1jMML/5COVB0SorPJoKYQ=;
        b=ZEnTi0/F9hSJOqSUWS3399Un4b848iOxxSJs0fYFs1qka8cvU4KS23p8HS11Zthg3R
         2w0n6c6rSgS8+yhhhoGRwgaMY5TaVNHU27qwwFlGuMiOu82g1Rn75BXkD26Pqr0IsIyO
         M5i0KWZDjO3hcc8aKYZSwpEzdytDtKVLPmuI73r+D3CA3vwbrB+5xevwqeklGaRMo7Dd
         l/XtTvNU1QPqxzx92IuTOmt/K6OQiYmBwVHxUbvTuZzrf5mswt51TwCLi2lPW/dPJbw5
         oM1VQkWqAPjN+g9tfAIA4nnIrxQeDiH6PMeCk5nF7HmbpDR8zosaaRVS4HfiXpFmX4Jk
         rIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153318; x=1700758118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA/ZFK3xawEcyb9omOiGWO1jMML/5COVB0SorPJoKYQ=;
        b=dlSR2Gbn2SJSPYxcjyXiDTcFTPkM0KKYZcKvw/bpR05pgbcps68XoGDzQCwiUbLqsa
         c1xwYMmB0C0Q+W5z3NYGMvIt3lFrHI0TPHngUx6G2wJQLUfC90vsLU+oBCgBSEMPDNeD
         /aeo5iH6I46X3cfjNGN5S09Hqws3ZFO7mdnbAPU1EJKo5x18n/BuKhFkpZy6MrVKSaId
         6G0jyRVJc2X0C7rnYAJZW0H4sInSBrHfMRTT8uNu1MZomB82a4U/oLTXBErO9+u1OAwV
         kVmBlcfbnUygTz8gHLDb0FMi+K8CqrXUQgkSmLR+io/wpUhOePBWDxnM5MShVOxPAq31
         5MWA==
X-Gm-Message-State: AOJu0Yx+Cm3qSYKAZsipNxvdvNzJKjXYR7+ThjiWtWnclqGqviGZCwQ+
	7KVLHOWI02bc7b9aLMKbgCdCGIAqVxK87GNpbMU=
X-Google-Smtp-Source: AGHT+IE2+tshUJwqRFdoRAMbc5rlHSkGXsilK3xu2cgSsXqU0GtijYzBqfY/5DU3nA7XMJmnySWSow==
X-Received: by 2002:a17:907:3608:b0:9de:32bb:faab with SMTP id bk8-20020a170907360800b009de32bbfaabmr15484082ejc.32.1700153318210;
        Thu, 16 Nov 2023 08:48:38 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id lt7-20020a170906fa8700b009a1a5a7ebacsm8542177ejb.201.2023.11.16.08.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:48:37 -0800 (PST)
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
	sdf@google.com
Subject: [patch net-next v2 9/9] devlink: extend multicast filtering by port index
Date: Thu, 16 Nov 2023 17:48:21 +0100
Message-ID: <20231116164822.427485-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116164822.427485-1-jiri@resnulli.us>
References: <20231116164822.427485-1-jiri@resnulli.us>
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
index cc4991cbce83..49d4fbf3fe44 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2065,3 +2065,4 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - port-index
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 0ee0bcdd4a7d..3ed7808013f1 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -181,6 +181,8 @@ static inline bool devlink_nl_notify_need(struct devlink *devlink)
 struct devlink_obj_desc {
 	const char *bus_name;
 	const char *dev_name;
+	unsigned int port_index;
+	bool port_index_valid;
 	long data[];
 };
 
@@ -192,6 +194,13 @@ static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
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
index 2f06e4ddbf3b..0e96d26203f1 100644
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
index 738e2f340ab9..6c033d1f7e64 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -46,11 +46,16 @@ int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 		flt->dev_name = pos;
 	}
 
+	if (attrs[DEVLINK_ATTR_PORT_INDEX]) {
+		flt->port_index = nla_get_u32(attrs[DEVLINK_ATTR_PORT_INDEX]);
+		flt->port_index_valid = true;
+	}
+
 	/* Free the existing filter if any. */
 	kfree(sk->sk_user_data);
 
 	/* Don't attach empty filter. */
-	if (!flt->bus_name && !flt->dev_name) {
+	if (!flt->bus_name && !flt->dev_name && !flt->port_index_valid) {
 		kfree(flt);
 		flt = NULL;
 	}
@@ -68,6 +73,9 @@ static bool devlink_obj_desc_match(const struct devlink_obj_desc *desc,
 	if (desc->dev_name && flt->dev_name &&
 	    strcmp(desc->dev_name, flt->dev_name))
 		return false;
+	if (desc->port_index_valid && flt->port_index_valid &&
+	    desc->port_index != flt->port_index)
+		return false;
 	return true;
 }
 
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f207f3fc7e20..b3f37e3c1b64 100644
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


