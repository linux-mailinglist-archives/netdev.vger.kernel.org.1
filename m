Return-Path: <netdev+bounces-134657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 785FF99AB6B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A06B2212B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C071D1511;
	Fri, 11 Oct 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kEFLNMUP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D51D150F
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672370; cv=none; b=NGn3aF9/yZ9ShtN81XyDhpK1ckOG5fu74uEJMBahsGr3n9oZ1mCBigMDtxHeoYiDwgMCAvWHZV96xQ6/VyQmOcoeCq6hHWy0L5gChlb7+/6+LXWSkdu0rMJhI6+mEGNWioAST5etKo3kBeBbgnYcr0u5HkfHZkkGZvox4uOCGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672370; c=relaxed/simple;
	bh=zvOKoSWpCtfq2DkhujLZNrhtz2v6Zmec/fDGJRPrwF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LavjORPl2aszvrC279Y/gx9+vvY/v4FN2kMc9gOtb/BJlnF0+OLkjDs6q+OZdsCWYWE0aT4VvH86r4ITaxnGvynwRkNZdrOe0CQPxLoRf8aYaCwYa+g94PG093V5AbzGBZmaGVkkXT19k1vbt4mBWgCWShOii2Fryf/9HsBaC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kEFLNMUP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7e9f955cb97so1324995a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728672368; x=1729277168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjPADzwi5V5cwtkOzcpnu/nnt8Tp7+ZZXtsz7wNAOXY=;
        b=kEFLNMUPCMI+d85la67QUclsgDekU++B+Utmmv/HEpMixlZXKlXFt6nTEkmoFFbu0f
         HmZ88d6PHPEGUE9XdmyjaOsMTBrFl2Pn+71jlaBaWQJbb/aKr/t7rwuAuxs8rtfgWiLI
         UdobHG3QPs3UFHU5ms6qXu/WJD/dUYjrgfkGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672368; x=1729277168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjPADzwi5V5cwtkOzcpnu/nnt8Tp7+ZZXtsz7wNAOXY=;
        b=LFfympnWAdtPcbZQu9I2FMMlB+vTYoeAPiVgYpVoc8RpO0+YXr6Y9lqC4QfPj4L8MV
         Qhri66Mc9yqXDOKVMx4FZBRxGSGk+GY3GDfYnPKkj5KZEyxprZcwwlF0sKmpYVVvZQG5
         kohr3Tu9KF5dk/cjGwUrZClcpHM94cOHstwNmx55gb/jfQ37yTaiIyJLy+SRficiXmAX
         qj7quQCQnPs53izIks1F5IRSRa6+0B04NUuNRkUJe/ZR425OvlkKR8fMGAZsGT1P5zc0
         2kWmLV2mzkaVlCNrfqSms/VgcMR3LAAbDosgyYpGAqY9e/RM5OKoNZxkLbTH4uuYvmj4
         j96w==
X-Gm-Message-State: AOJu0YyVY2KeA25OIAFNEjBYwpn/QsKd0npKDEeyIgkJTs8kKE9f9Jzm
	1gtMNedRR88kqcXREqyH8A8NwDIshkOXJfG934S5qW5WPtlURAm1oFyEJb5PnoY1YzIJWK5Sw11
	7c1J6FmnZV8aJuGOmZ7OGiN+TnvbIBk+MSjdP8WYnvTlVj0/L5D3++OZEXd68/myMV5QiHExBXa
	R9/xruWBuF/lUexedVXsVG8457ftXhmViAgCI=
X-Google-Smtp-Source: AGHT+IFbpC6LdWulF15xz3jNJey+lj89xVnhKvnZb2szYPjzAcm84CGLWMoW7WgyJIzp7pZGdv4myg==
X-Received: by 2002:a17:90b:4009:b0:2e2:bd68:b8d8 with SMTP id 98e67ed59e1d1-2e2f0a065b8mr4688076a91.8.1728672367752;
        Fri, 11 Oct 2024 11:46:07 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30d848e1csm687625a91.42.2024.10.11.11.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:46:07 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v6 6/9] netdev-genl: Support setting per-NAPI config values
Date: Fri, 11 Oct 2024 18:45:01 +0000
Message-Id: <20241011184527.16393-7-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011184527.16393-1-jdamato@fastly.com>
References: <20241011184527.16393-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to set per-NAPI defer_hard_irqs and gro_flush_timeout.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 11 ++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/netdev-genl-gen.c              | 18 ++++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  | 45 +++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 6 files changed, 77 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 7b47454c51dd..f9cb97d6106c 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -693,6 +693,17 @@ operations:
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
index ac19f2e6cfbe..b49c3b4e5fbe 100644
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


