Return-Path: <netdev+bounces-161692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A69EA2367A
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 22:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9A11671F7
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0751F37BD;
	Thu, 30 Jan 2025 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hgYDM2DR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6721F2392
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271751; cv=none; b=N0tk05RqrmKhtNqwivH9QrsxDN1zDmZ7b8Kf3w91DbS7Qfse7eW5dSL6rZZ6b3rhvkcgB2YYS/FjOVdEYEA2MszqJuuDOU2gsPeaz1K5MWBs6qPNsC4ux5ytg8PPyTegpmOouB5MYvxWzbqDKdmKzKdbGyGNxoeKJ80eKtLSNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271751; c=relaxed/simple;
	bh=k12/lbC5UqTQvuOY0XqVg2rUFY//dbOT9zo+qbv4oOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dJJFfLZPo/mn0F/5BvOM0iMJshHZPgsm1UdMWKkhkP73kQPvocFdb7qx4NRfHWYRvq7Sl4UknJ4RVpIQ+t7REgdEEbBO3iLYUMAvMxWI0C6LRDBSAnKXnR1bjIdPuUtPRDY8MhyLFVl6r7HFtAVpKIJ+D0XfkmqZvNGVKNsEDao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hgYDM2DR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2162259a5dcso40739705ad.3
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 13:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738271749; x=1738876549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YboRbWKoVWlemRIOH59KqylnvDeKBTmTmqLYeqMQiIE=;
        b=hgYDM2DRgW3Jw+KPlILiShctD6WDpJyDQTS58xlCULZVVzIQ/2GRCI7yChXl1CKMp6
         JaqM1g5pqlEmd8QqMkV9y6yaZV5LDyI/jRygsP4qztOuEhoT3urE8sQdDtFVPxNjul18
         8TM3cgKyFkesSRUvgeS6scGGzva+upGka+OdB+6hQ546csl+Yp/qHU6qavYJdDaV0j5+
         dVRbrxTQ4Vyc7tWuQBIh+LS8oiZdDEVYef74o/D/DfXkAuCtuMNfa6r5v5M1yvx2klzj
         pwoTQvSKimZjbeZCJ7V1lvLLW2n4/xV+Ny4eCSsmy+IGpuqO+h2vgHltIjGbvCzBOUfm
         fLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738271749; x=1738876549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YboRbWKoVWlemRIOH59KqylnvDeKBTmTmqLYeqMQiIE=;
        b=eutGzf61mxsC0mDEIXo4nNXfoRPmqtsXfmRvTegRvFg4XNp9YCiI255buTi3BI8bdo
         BIrawtHk8jYT+gB9miEDNhE1e6j+vYQ8Mp6twC3/JpvCEeW2jcC8hVKf7y/7uQCFPxC3
         LGIxpQETtnBrh7nPnhOKvRNZVPP5fB4kXzR5pArBnFlZnNwlOpQlqAd1jv6L1Bt0eEa1
         dPkqLpAesvJ4bekiKBreakbMf9iMWZ4FYtMAXs5EmLBxy+IOo46jjxyVMSKO0ocV2IXW
         GThNM1tGjKbuc1TmeiQBu0KhuqdRX+DdGo6qCpkh/sLnwmP8mlxmMPNrQTEIs1yqsjg5
         4u6w==
X-Gm-Message-State: AOJu0Yw/PjqZdieZ6Xjg39y7Y2T4pr8iaBgab9NFz3VpKqp97HtWh92E
	HTMCsqylppw3DNFAm6afl4E7Di86jbQsnnA27Dt9kQ6vkg3BC5AiAPSk55Yy4v5YOvOMee2B7ZZ
	/zKV2KQwZd1TDvCZ8jd1ug+QOTxQ2wcZf6dwYTQtiQiIoeDHAtZevAOJQ7otZBGmXXEN/WVW171
	qW5Ge6Lx2AxqZOX9OiMXFoBSh5XHqLshxrsP5/V0MgnfkUySUhluQTMJToYKk=
X-Google-Smtp-Source: AGHT+IEV38TyLfSKPYHV1CRGVy4zRH5M+/rjcv1gz+qw8RgwDKGY/6aR5/6lTle+LOsExHp5nlip6aiSOGyu7Pm1WA==
X-Received: from pfbds12.prod.google.com ([2002:a05:6a00:4acc:b0:72a:bc6b:89ad])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:670d:b0:1e1:ce7d:c0cc with SMTP id adf61e73a8af0-1ed7a61aeefmr12572453637.38.1738271748853;
 Thu, 30 Jan 2025 13:15:48 -0800 (PST)
Date: Thu, 30 Jan 2025 21:15:37 +0000
In-Reply-To: <20250130211539.428952-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250130211539.428952-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130211539.428952-5-almasrymina@google.com>
Subject: [PATCH RFC net-next v2 4/6] net: devmem: TCP tx netlink api
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"

From: Stanislav Fomichev <sdf@fomichev.me>

Add bind-tx netlink call to attach dmabuf for TX; queue is not
required, only ifindex and dmabuf fd for attachment.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 Documentation/netlink/specs/netdev.yaml | 12 ++++++++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/netdev-genl-gen.c              | 13 +++++++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  |  6 ++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 6 files changed, 34 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index cbb544bd6c84..93f4333e7bc6 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -711,6 +711,18 @@ operations:
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+    -
+      name: bind-tx
+      doc: Bind dmabuf to netdev for TX
+      attribute-set: dmabuf
+      do:
+        request:
+          attributes:
+            - ifindex
+            - fd
+        reply:
+          attributes:
+            - id
 
 kernel-family:
   headers: [ "linux/list.h"]
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e4be227d3ad6..04364ef5edbe 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -203,6 +203,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 996ac6a449eb..9e947284e42d 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -99,6 +99,12 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_IRQ_SUSPE
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
 };
 
+/* NETDEV_CMD_BIND_TX - do */
+static const struct nla_policy netdev_bind_tx_nl_policy[NETDEV_A_DMABUF_FD + 1] = {
+	[NETDEV_A_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -190,6 +196,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NETDEV_CMD_BIND_TX,
+		.doit		= netdev_nl_bind_tx_doit,
+		.policy		= netdev_bind_tx_nl_policy,
+		.maxattr	= NETDEV_A_DMABUF_FD,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index e09dd7539ff2..c1fed66e92b9 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -34,6 +34,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb);
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 715f85c6b62e..0e41699df419 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -911,6 +911,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/* stub */
+int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return 0;
+}
+
 void netdev_nl_sock_priv_init(struct list_head *priv)
 {
 	INIT_LIST_HEAD(priv);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e4be227d3ad6..04364ef5edbe 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -203,6 +203,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.48.1.362.g079036d154-goog


