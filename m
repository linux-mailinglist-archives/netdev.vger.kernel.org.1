Return-Path: <netdev+bounces-133393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E10995C8E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B981B22F08
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E8B2A1CF;
	Wed,  9 Oct 2024 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KxhOI1Ab"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BC28399
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435373; cv=none; b=U1JdY48l990FtxGIM9qJTfOrpGgpH8v1izT5pxOCkFDfbZYkKJ0DsW7b+huWG9xr6iuQXLV7V5myXi5jRJsXFbF9vbMi/IIfDJVY4ZWg+ArRaPylw9RIb1mnJWk0InvG32jR8c+QwPTKrp1mX3a8DPlkGqHKdTGTOAibSBypNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435373; c=relaxed/simple;
	bh=Ekg5Ex2CwrKTH3s26jVh5V639pIR/3T65wmqDH2EYMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AxFHb9PR40vWBEa7FULOMHsukeYSu5cwzBMRSyq7CWg42iXgYjDXngxPCdyPyyiuSHrRurnLA/sdlhvSzPQ59XdHX2daQcu+n6rXJ5Ycn3yTj/+M/QOpcWGcUwjNMNICFIZrrT18y+TD6PU4PyNgzdbGFQ0AKM66H09qJ1INNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KxhOI1Ab; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b90984971so64468595ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 17:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728435371; x=1729040171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFExh9JLgCX2o8sJ1oJkFzqxwxUaw6eXwPdUITUkpmw=;
        b=KxhOI1AbsZufB7Wnx0c/a1oYZ/ybMlY5RVsb1lHnHXLHMpgvRGkqKqSCR3AZFeqvaQ
         q+I1b33raksMYT+BckgoYKYuFWmDjifa0rmwdwmcN9mNUIzGQOV4sBlQfpiiuAzZRm00
         bezf1u0VwuNT50GIQ3B6Cmj7I7fPIqcDtYuEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435371; x=1729040171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFExh9JLgCX2o8sJ1oJkFzqxwxUaw6eXwPdUITUkpmw=;
        b=MOH9d2zoDm3v6l2dIB7xXMuPLJFyioXBnwswPMwAQGSdmN1fVkm5f4UHFz4heq1KR+
         2drIyw8x7cFhzhTzJbZcB5cFb6vZOrt9ip54SAUXvT72zvSJF281ASIl/iA+mioLoDUV
         0tQPEL+l+wCSLUIwrha+/e9G0y35fGeYHzvBxmwD1JRV/CHZe/gmBk6A5UKjRdVBd2rk
         rAAXd0m6F5H8ZhZy/dAGvov2tb4pa9TmuEG58CtSIvH3Sg/AVMpA22aOmBKuzSz7cGwf
         fzkckG66XtlqvURXPtdeJw4pMxvn3Mspw0MiMIflohjzMdRoUgQfxK82S1uYqyHgcERU
         SBsw==
X-Gm-Message-State: AOJu0YwNbqVPThUBTp0YteDk1hTPx35kPf10wS7zFYlNjVUFzlZjM2j5
	PE1iBXT6PfApd1iOzhcdNZJGWYpaGJeZC1C4hJ36frr6Hn/FODULNKPmBGwFDhoqse4eU5+lcMq
	FtAbv8IVEY+mrEFTabSrvmVJBiOUmdPk8hXn9oDObZOUfzI/x4j+34l+JQdAlRQf79tmCOCY3lM
	MxNcAbSSXAjntlPMBsHF8XsPsu5vP527KcKtE=
X-Google-Smtp-Source: AGHT+IE6iws8gP7BWGiblTSiPcFSgObUoGQNSyjfQ0BioIRailDiNSGi9E1uSTBmefAKiV8fnM3bNA==
X-Received: by 2002:a17:902:e743:b0:20c:59ca:d76e with SMTP id d9443c01a7336-20c636f44a2mr13256075ad.8.1728435370891;
        Tue, 08 Oct 2024 17:56:10 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec92sm60996045ad.101.2024.10.08.17.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:56:10 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v5 6/9] netdev-genl: Support setting per-NAPI config values
Date: Wed,  9 Oct 2024 00:55:00 +0000
Message-Id: <20241009005525.13651-7-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009005525.13651-1-jdamato@fastly.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to set per-NAPI defer_hard_irqs and gro_flush_timeout.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/netlink/specs/netdev.yaml | 11 ++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/netdev-genl-gen.c              | 18 ++++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  | 45 +++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 6 files changed, 77 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index bf13613eaa0d..7b4ea5a6e73d 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -690,6 +690,17 @@ operations:
         reply:
           attributes:
             - id
+    -
+      name: napi-set
+      doc: Set configurable NAPI instance settings.
+      attribute-set: napi
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - id
+            - defer-hard-irqs
+            - gro-flush-timeout
 
 kernel-family:
   headers: [ "linux/list.h"]
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index cacd33359c76..e3ebb49f60d2 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -201,6 +201,7 @@ enum {
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
+	NETDEV_CMD_NAPI_SET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index b28424ae06d5..e197bd84997c 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -22,6 +22,10 @@ static const struct netlink_range_validation netdev_a_page_pool_ifindex_range =
 	.max	= 2147483647ULL,
 };
 
+static const struct netlink_range_validation netdev_a_napi_defer_hard_irqs_range = {
+	.max	= 2147483647ULL,
+};
+
 /* Common nested types */
 const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1] = {
 	[NETDEV_A_PAGE_POOL_ID] = NLA_POLICY_FULL_RANGE(NLA_UINT, &netdev_a_page_pool_id_range),
@@ -87,6 +91,13 @@ static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1]
 	[NETDEV_A_DMABUF_QUEUES] = NLA_POLICY_NESTED(netdev_queue_id_nl_policy),
 };
 
+/* NETDEV_CMD_NAPI_SET - do */
+static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT + 1] = {
+	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
+	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_napi_defer_hard_irqs_range),
+	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT, },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -171,6 +182,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_DMABUF_FD,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NETDEV_CMD_NAPI_SET,
+		.doit		= netdev_nl_napi_set_doit,
+		.policy		= netdev_napi_set_nl_policy,
+		.maxattr	= NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 8cda334fd042..e09dd7539ff2 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -33,6 +33,7 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb);
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 64e5e4cee60d..59523318d620 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -303,6 +303,51 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+static int
+netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
+{
+	u64 gro_flush_timeout = 0;
+	u32 defer = 0;
+
+	if (info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]) {
+		defer = nla_get_u32(info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]);
+		napi_set_defer_hard_irqs(napi, defer);
+	}
+
+	if (info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]) {
+		gro_flush_timeout = nla_get_uint(info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]);
+		napi_set_gro_flush_timeout(napi, gro_flush_timeout);
+	}
+
+	return 0;
+}
+
+int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct napi_struct *napi;
+	unsigned int napi_id;
+	int err;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID))
+		return -EINVAL;
+
+	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
+
+	rtnl_lock();
+
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		err = netdev_nl_napi_set_config(napi, info);
+	} else {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
+		err = -ENOENT;
+	}
+
+	rtnl_unlock();
+
+	return err;
+}
+
 static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index cacd33359c76..e3ebb49f60d2 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -201,6 +201,7 @@ enum {
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
+	NETDEV_CMD_NAPI_SET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.34.1


