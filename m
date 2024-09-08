Return-Path: <netdev+bounces-126294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AB69708B1
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6861F21E09
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E4117B4F6;
	Sun,  8 Sep 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UcrojUoR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0C17B428
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811743; cv=none; b=QiiGhZ+1hUitBstzm2n+CkXt0c18CyYRw5nF3tlpuPn+pcowqtjqEIsvggf1/lu/igjbBq6T/bZ7nFHgyL3vtOYXq7Iffk2TAPVjDWCzltCGzREsSFHXdVApjmEphmx5ZxBReiHVuh665FNcsdLxOWGXDOo6ZeTQKde/z14FGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811743; c=relaxed/simple;
	bh=xROhpCG/UFEqyPlPHFBjL+Ei3IMKFCnsu+i2mJFrfH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AgKlWXntVFvFGT8kkaZbYoJGjkbNl60xWTQamZeJObPzvj53DXEfx7+JiS/oyvugjjW/uMHYrglo08Nrk2HnmUKyAWNc9ZQECRSlt3helZqegJBwWy5T97dUO8tS5UmxkTY15+nUDODa9OhuN5YMe4lKZFS//GedvylVktDedz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UcrojUoR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2059204f448so28706985ad.0
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725811740; x=1726416540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjuOdM76RGp3MQYm8FNYFfW8Ad8/c/uFJG5zKSZKRs4=;
        b=UcrojUoR47QsbVddSVJXoRJrwtGmBnePKrStMsH5hZI8pzuMaxIoZhPO8V3Y8fI5TT
         YqFbLq716nPBXKUdU7UZRj8zOEJhLMNA8AzO8bDNtd4nbt0dQL+b/XPAUky4rvcC/DJ+
         8oMzgdGQC2bLGf94bXRiZr21yNk3WQdQsgmAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725811740; x=1726416540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjuOdM76RGp3MQYm8FNYFfW8Ad8/c/uFJG5zKSZKRs4=;
        b=la/tq7qeWXHbkdFr+P36z377AFNbxuu+hgkJiIgUehuFQgdP4/dqH0L71O+v3bWxre
         TeFGqrFC3DxUKI5v6uCXXP0Wrg2ke/IYxhgQDeUEXy5vR0muzxXmS6OdbkKfcqioV0Ht
         FxKBmxJmO+JA1YCre2R/k53Sk7y9A3DHMklbLUsmV+A43JneePiKz2QZhXQ22p5S88i9
         QDvcqMJ8vVdco1UIQn0vwXvDFreCQuG9E3jyhnLvsjscBzRtz5UG3FUEK+z6t3NHSyuc
         rANHgqws5wa6LI1hGQ/1sJr1XZRWXR2YFGowPVdHJSCCp8HrMVnGnCw09UnsGRvADIIQ
         hhhA==
X-Gm-Message-State: AOJu0YzCemJ1Dw37JwrhalpBXOCvt7uRRcTRXtdrMpp8ioIYTWdTm+Dr
	ltlw6cbzJTdsWOXR4hhUYtnrtrLSW2cV4KRad0FNwfa8dji0xFsNQzQTtb3i82EIzkpFcJ5oV7w
	iBEeqSLPd/fVP4y1tekPbub5gk0FoZ5N4FnE2cf/3SwxUau19ddx0/TE/BS7LGC4w2p97d/0RY9
	OzlMS+9kOW50LEjRgeiuybZd0Cz+F4BlJY2tPhLA71
X-Google-Smtp-Source: AGHT+IFc2+MJ78cW07NMZFUPaJZvV2Tyokj10k8rhRH/L30+78xT+3ctMyGfzd0g5mcjr2mR8Wy2DQ==
X-Received: by 2002:a17:903:1ca:b0:205:80e7:dcc5 with SMTP id d9443c01a7336-206f0612c3fmr130641445ad.44.1725811740001;
        Sun, 08 Sep 2024 09:09:00 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3179fsm21412535ad.258.2024.09.08.09.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:08:59 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v2 6/9] netdev-genl: Support setting per-NAPI config values
Date: Sun,  8 Sep 2024 16:06:40 +0000
Message-Id: <20240908160702.56618-7-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908160702.56618-1-jdamato@fastly.com>
References: <20240908160702.56618-1-jdamato@fastly.com>
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
 Documentation/netlink/specs/netdev.yaml | 12 ++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/netdev-genl-gen.c              | 15 +++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  | 52 +++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 6 files changed, 82 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 3034c480d0b4..7c0c25e5b808 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -642,6 +642,18 @@ operations:
             - rx-bytes
             - tx-packets
             - tx-bytes
+    -
+      name: napi-set
+      doc: Set configurable NAPI instance settings.
+      attribute-set: napi
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - ifindex
+            - index
+            - defer-hard-irqs
+            - gro-flush-timeout
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index fd02b5b3b081..4e6941b45f3e 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -189,6 +189,7 @@ enum {
 	NETDEV_CMD_QUEUE_GET,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
+	NETDEV_CMD_NAPI_SET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 8350a0afa9ec..209c56cf08f1 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -74,6 +74,14 @@ static const struct nla_policy netdev_qstats_get_nl_policy[NETDEV_A_QSTATS_SCOPE
 	[NETDEV_A_QSTATS_SCOPE] = NLA_POLICY_MASK(NLA_UINT, 0x1),
 };
 
+/* NETDEV_CMD_NAPI_SET - set */
+static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT + 1] = {
+	[NETDEV_A_NAPI_IFINDEX] = { .type = NLA_U32, },
+	[NETDEV_A_NAPI_INDEX] = { .type = NLA_U32, },
+	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = { .type = NLA_S32 },
+	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -151,6 +159,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_QSTATS_SCOPE,
 		.flags		= GENL_CMD_CAP_DUMP,
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
index 4db40fd5b4a9..b70cb0f20acb 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -28,6 +28,7 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb,
 			       struct netlink_callback *cb);
 int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb);
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 68ec8265567d..fca1670706cc 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -303,6 +303,58 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+static int
+netdev_nl_napi_set_config(struct napi_storage *napi_storage, struct genl_info *info)
+{
+	u64 gro_flush_timeout = 0;
+	int defer = 0;
+
+	if (info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]) {
+		defer = nla_get_s32(info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]);
+		WRITE_ONCE(napi_storage->defer_hard_irqs, defer);
+	}
+
+	if (info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]) {
+		gro_flush_timeout = nla_get_uint(info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]);
+		WRITE_ONCE(napi_storage->gro_flush_timeout, gro_flush_timeout);
+	}
+
+	return 0;
+}
+
+int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct napi_storage *napi_storage;
+	struct net_device *netdev;
+	u32 ifindex;
+	u32 index;
+	int err;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_IFINDEX))
+		return -EINVAL;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_INDEX))
+		return -EINVAL;
+
+	ifindex = nla_get_u32(info->attrs[NETDEV_A_NAPI_IFINDEX]);
+	index = nla_get_u32(info->attrs[NETDEV_A_NAPI_INDEX]);
+
+	rtnl_lock();
+
+	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
+	if (netdev) {
+		napi_storage = &netdev->napi_storage[index];
+		err = netdev_nl_napi_set_config(napi_storage, info);
+	} else {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_IFINDEX]);
+		err = -ENODEV;
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
index b088a34e9254..4c5bfbc85504 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -188,6 +188,7 @@ enum {
 	NETDEV_CMD_QUEUE_GET,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
+	NETDEV_CMD_NAPI_SET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.25.1


