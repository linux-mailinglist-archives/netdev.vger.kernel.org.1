Return-Path: <netdev+bounces-58227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B24815904
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 13:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88CD1F22568
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 12:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E62E641;
	Sat, 16 Dec 2023 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZmKCtsBv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A7D279
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a22f59c6aeaso178599866b.2
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 04:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702729819; x=1703334619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SksabRRuzPhq1bHXhenDAYEiuuMN4zcmCaZ26jqamMQ=;
        b=ZmKCtsBvqkGuoTkkpnedf5kX4vvoCCmYtcLY8mBfpuM41t41pUO6thrzoaFEbrOoZI
         bYvzEH3Lf1z7xC/4BdCjAbu6pMsfVRDttvBNFyHRr7V6usOsJheHpw0HCaG1qchWTMGR
         mUpGPD5aTkRPZtnNJo8fzxvupwVSPq55+kpItib+NfLoRjmEPV0DLchGVx+m5+1Hoahg
         ErUhD8HAD4UrGA5sJkZSsF+xEsoKa5fqdFtBDkcyiykYm4WHByCwwuF3mWQL5uECPZm0
         9jsJ+Y35rc++y1yMvn/iYhF8mjzBY/RIjxVVtAzGCQVXfLfE1VPDrTQwrdN8VDZGPbVQ
         V2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702729819; x=1703334619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SksabRRuzPhq1bHXhenDAYEiuuMN4zcmCaZ26jqamMQ=;
        b=q008FGPz9fQGihQVcOpIRB3bbYXL3dzoN3OhpTENnVIBf1YB6k98LOcwBLscp7Hhjp
         lfT1bGNtOXUk7Y9W97UHuqi7KI0lsP31n/ZbJzK2Su6KxcTYVdQhzpvpLzlS0lWgU6dn
         1rNdvt1y3WvOEmUF9yXFpcnWZ9qapRdqVyDR0c2GO7b6ZWKlUAJ/ajVnd/nLsXkfdCT7
         V77kPcQ/XdOM+N59z9oNeyCYqEkHmxkU7ovgi8AVM+DGpRoJKRW/Leu80RiVH/0zXvif
         6NWvYhvxi1QUjSNGmyUdxrKSGh+SEHsw3tldps7HMPRSLMfEBQIqlx+NMuo9uWI/OTc7
         eZQg==
X-Gm-Message-State: AOJu0YyQn66SsmFaZKEdpreWo3S1RIWjQw1v3u7k803fKI8+5FyYB3vs
	9TdGgt4dQSEmCVa2EnOHpDTf9kM+M7qjB+W3kAM=
X-Google-Smtp-Source: AGHT+IERKe18EvAXbiO9PNmhpWCThaVa3jDPdPsj/V9V+jnF671Of9sKZQhft/IQpQIJ7GurFFC7Fw==
X-Received: by 2002:a17:906:2097:b0:a1f:a0c8:750 with SMTP id 23-20020a170906209700b00a1fa0c80750mr5103548ejq.53.1702729818905;
        Sat, 16 Dec 2023 04:30:18 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id vx6-20020a170907a78600b00a1e852ab3f0sm11985622ejc.15.2023.12.16.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 04:30:18 -0800 (PST)
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
Subject: [patch net-next v8 9/9] devlink: extend multicast filtering by port index
Date: Sat, 16 Dec 2023 13:30:01 +0100
Message-ID: <20231216123001.1293639-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216123001.1293639-1-jiri@resnulli.us>
References: <20231216123001.1293639-1-jiri@resnulli.us>
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
index 3176be2585cb..499885c8b9ca 100644
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


