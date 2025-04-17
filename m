Return-Path: <netdev+bounces-183969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4841A92DF7
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443148A770D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2464F2253EC;
	Thu, 17 Apr 2025 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ySRDZn8l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2753223326
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931751; cv=none; b=TSbMIJZ1ldgTmnlodQuLA0Rzm11bESAVGEo03ZUbpBGThSBtpEyd/Ry3k4aTwr7T9pf1u7PPA3xltlTT+mGSK/UZLFVHw5+Cyg8m7R4dS5jQMxYt06jQX3rclKkrgGnKEAdZcuEYydtDr4lJ7w5zHPfco79GnqdKMKlk1WrDsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931751; c=relaxed/simple;
	bh=2dZoJzTC0n61gPVgiUOtZNVtQFu+fxnK0ytlJJQhhoY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tL3XpPRJzmmgjMKeZCObPlJ9ypL3OOm4qdMSErPQd+akJoljjXu4rZCv4L8voPs3I4QOxKFcrLDATjolMUr4lephH2T8fIvGRshMDo/O8uKCD2jLLe7xu07ywdtpRhbXqDHh+3gnMgKRoF08Bgg0AEo3yvdMFoxPZloBr8d4iqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ySRDZn8l; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2265a09dbfcso19742765ad.0
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931748; x=1745536548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D79NJsf1TGTEMEOpAaNY/M1MB+ANu8p+KTCg2KZrIz0=;
        b=ySRDZn8l5JGkX7Zr7CAFQgXuluJLkny5gUf4ZwRRhpO43NF1P5wQaliKaKm91/Xjv4
         yh3a58xTQLjZ+pIqmVOhcp1HnGXkviPlKKmqJEeEemIEXcjvW5eIaciHSakgu9dq4jiT
         CsYRI4ESKJ5yVjdSXJuKg+AOxKrQqt/BYAsYfJFXSm+xQb/9IMXREXwA4B2IA7TN3yET
         CnW+NKsvc7mfI1F+Zybxmc9QGQ0ez702OyP+QatxWoYpZgcF83EoWK2MskqI4q+BZCSc
         st7IovsdTl1UcR9ZnTe7gERJ7rjjxRWL/sp9lqnJIoj81hMwa+aZV1pCHZzI6BQ9Nofh
         Ua/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931748; x=1745536548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D79NJsf1TGTEMEOpAaNY/M1MB+ANu8p+KTCg2KZrIz0=;
        b=Jh5WExqftGMzHsbE1/bMgPF/wThiRQjzMo/Kyu0n0F+xDMo8k/WoiRgrqPQqnBJ8JR
         5Xv1lHDR2CjgSzOFUZNZjn52z7XnTOPkeDvE4SF2y4gaNEWlHgQPUwK+xro0aNNUgMvA
         6Irbcvfg3+NQBNQ7uARXOmVCieNT1DglB2Rfqp+FrMfqDpR8TNRK/75gmTlF6fTgwRu8
         elbI1uM6Nel2P/1rtEn+me3kCnvek0xXrBjVQ8au5/5z+1iFTkDjaZ04qCg9G7Sfwdoc
         tc0/V7sLpe6HbDKdCCaXKfOBEqw4yfVxJ31WvOUYC0Evcdus0DTKDqb63LMBTNU9/iRH
         Yd/g==
X-Gm-Message-State: AOJu0YyvQQuwZkHVRZXozIUAMg7BX+FOKtwf7//mU9kmSi51n+zJldP/
	w5U74u0fvtNwPzLXm8UL6qgfzXQ37HHs/RgwFJ0q6PrOy38vnSGn9XdeJLWJ60ZCbtkvvyc3mE7
	/VeJFxVtcUcbVWnCf+d+O4IYy/+OY+Ei9rElLdJCwqKiJ9K3MbambfFigEJmzekJxe1U/JJrAub
	u8kOe5OY5lu+ssXdZmQyFzpX/AxXKZm3vzyr5eWMZv+K60aDwCMWXMsA9/kQI=
X-Google-Smtp-Source: AGHT+IHy1T/1z+NJL4BJU+iXB4LK2zZWs5B92L/ElRddM/YiSv7Pqa6D5DGsEWfs9CGjLVH/CKIEzaAm/x1/UmSHJw==
X-Received: from plbmj7.prod.google.com ([2002:a17:903:2b87:b0:220:c367:eb6d])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5c6:b0:224:f12:3734 with SMTP id d9443c01a7336-22c535adfb7mr8174075ad.30.1744931747869;
 Thu, 17 Apr 2025 16:15:47 -0700 (PDT)
Date: Thu, 17 Apr 2025 23:15:34 +0000
In-Reply-To: <20250417231540.2780723-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417231540.2780723-4-almasrymina@google.com>
Subject: [PATCH net-next v9 3/9] net: devmem: TCP tx netlink api
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Stanislav Fomichev <sdf@fomichev.me>

Add bind-tx netlink call to attach dmabuf for TX; queue is not
required, only ifindex and dmabuf fd for attachment.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v3:
- Fix ynl-regen.sh error (Simon).

---
 Documentation/netlink/specs/netdev.yaml | 12 ++++++++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/netdev-genl-gen.c              | 13 +++++++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  |  6 ++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 6 files changed, 34 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index f5e0750ab71d..c0ef6d0d7786 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -743,6 +743,18 @@ operations:
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
   headers: [ "net/netdev_netlink.h"]
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 7600bf62dbdf..7eb9571786b8 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -219,6 +219,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 739f7b6506a6..4fc44587f493 100644
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
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 17d39fd64c94..cf3fad74511f 100644
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
index b64c614a00c4..5e42f800dfcf 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -934,6 +934,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/* stub */
+int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return 0;
+}
+
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
 {
 	INIT_LIST_HEAD(&priv->bindings);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 7600bf62dbdf..7eb9571786b8 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -219,6 +219,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.49.0.805.g082f7c87e0-goog


