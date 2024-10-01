Return-Path: <netdev+bounces-131098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EF198C9AB
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 01:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29C11C22967
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2A21E1A0D;
	Tue,  1 Oct 2024 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ExodRjaV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFB1E00A1
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826844; cv=none; b=JflZAPyAeAnODCSzPCNPTLrDSnztGWYn1qG/1FUil6wNE9bHrPnB21cV6i4EcGyTRYWyfKnG7hDo+X3Jrx3KfjDE/0WNiS65JNqafmLIO9PwN31UO6T3xkVxmvd00cp2zqU+sgQKNw7ICfkwUsI1imxzlGTkM4WBZWJklL9BuHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826844; c=relaxed/simple;
	bh=etJ5QQq7z0hnczvA60rILD3Y/1LYpD2GBa8P+y6My1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqtkVPBqlDDjw/iiTEkfN4dbKVP9QycDH1kWwN8UGmDUDBoegROaLMxtLRADb9lBOColyr/n+GUER/w98h6CA4l0aMLzvy7HN8/Mmg9zxu+Z8Xcf+z9xGYV6+QB9gCJn9GwsTaVzgG8sQfVRS/VAp5Ev/RrVbMsO8/9exHHjyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ExodRjaV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e0b9bca173so3701445a91.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 16:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727826841; x=1728431641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp6xBU2Yo2PWr8F48aHYbzV3nL3kOi+Sh9yDhDyEv0E=;
        b=ExodRjaV6byjxnO5/ZZ5xaMB4R0Kh+Xaq5z0OGKKeCHzXLmhj8uyel2IG2JurQA7Og
         H5w8FN2jOnti6VlDltXrl+V/gj/i6moX9tFthH+8fb5LY819zbaqoI3KhGoPcyzN0BFr
         5lCsvIfoLRGnzK88/tKLTTuj/saCDAn1b/kt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826841; x=1728431641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp6xBU2Yo2PWr8F48aHYbzV3nL3kOi+Sh9yDhDyEv0E=;
        b=iGwsLZy7FzpxARgDuWhp+419cfOH/4cRcXnevZ1ayTclPUb/R1mdqA0D/XlVMVjh0p
         UxQz2Q+KUV+kfKzQMqg+icrysF0LPmfTdlyjTIhj3leBuh88aqc2FRee08Boj0z3xM6r
         3Df04TyOLFQHYicMu3uACxEdVqj6/JEaLS21PUc6iHAM3kCt/UIf7VV4n7sc3qzDSIVo
         NFhezif2+27baDWTWRnGZ9NY4JQqwIcUr7JWUS3WUnGkhOvbZRTNMxDjGgTGaThtxWKJ
         oPket3cvI2ohTiyKS1vMPlgu5R5HfhhGrujhAgKNDJ30W+Ed1plgaZYihkxC/LdqZLtW
         hBxQ==
X-Gm-Message-State: AOJu0Yy0RU1n14baIlFRNBoiI0QZhMwv2qIR30U+jZvcenpR3Wbwc7SR
	OO8jA0XQmOnPfJyho8PTaTItf6vBbBG1u+nTdQki/x/0QCQOa1YWcEkDZxIh6axaUHu81yn8WPA
	g1doQt7xN5uKJfOGSUHBMP9m0iuvZL6OF+Ja+bgPpepcsYX/K733xUYV0gWvZqUfJEC83K+QZ9d
	MSAQUlsjYbDIz+ebFu2J69NglF5e8O4eiqp5I=
X-Google-Smtp-Source: AGHT+IEoHQYE+xaLebe1pVy16LZPHUGrAQAE2ajk4dV/5lmrgMHS7is6fxTq38YsNokwFPUG2Bz0xA==
X-Received: by 2002:a17:90a:fb4b:b0:2e0:a0ab:7fd0 with SMTP id 98e67ed59e1d1-2e1846b5446mr1574787a91.16.1727826841525;
        Tue, 01 Oct 2024 16:54:01 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f89e973sm213130a91.29.2024.10.01.16.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:54:01 -0700 (PDT)
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
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v4 6/9] netdev-genl: Support setting per-NAPI config values
Date: Tue,  1 Oct 2024 23:52:37 +0000
Message-Id: <20241001235302.57609-7-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001235302.57609-1-jdamato@fastly.com>
References: <20241001235302.57609-1-jdamato@fastly.com>
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
 net/core/netdev-genl-gen.c              | 14 ++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  | 45 +++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 6 files changed, 73 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index bf13613eaa0d..7f8d2489c68c 100644
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
+            - napi-id
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
index b28424ae06d5..901c6f65b735 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -87,6 +87,13 @@ static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1]
 	[NETDEV_A_DMABUF_QUEUES] = NLA_POLICY_NESTED(netdev_queue_id_nl_policy),
 };
 
+/* NETDEV_CMD_NAPI_SET - set */
+static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT + 1] = {
+	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
+	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = { .type = NLA_S32 },
+	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -171,6 +178,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
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
index 8cda334fd042..85e6d7c95ada 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -30,6 +30,7 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb,
 			       struct netlink_callback *cb);
 int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb);
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
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
2.25.1


