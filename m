Return-Path: <netdev+bounces-249427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD3AD18AB6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 13:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AD343081E76
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 12:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACAD38F23F;
	Tue, 13 Jan 2026 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWj6nDPB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3136657B
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306623; cv=none; b=EZQtAru92ifrXlDt6UlfhAbXlvJq3poX8mSNOMgrXdHELO16+nnIhnbNjlo2WnZ+Y4z5P8vokWcEOs7ieWpNHA5tdFwnc8vIGIzxy9OzxwN3qIgjmAnyflnvh+2hrerILqjQ44WBtE/3F5TDAab3K57/WUgrbFCn0Xd2eiHIiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306623; c=relaxed/simple;
	bh=dVFd1rc2Qeb23oK7AogbGbRs2z1mZMoMQ/bDgLasVj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aT5wmmjwHut4afX3zgLedbptJK8RVQlslKQ9TkJNmW+A5oZNSaTbD/ghd+Yt2asE80pB72LgIvanuIjfT7pqW9t/0eiWHEuvpPlqTMZKsNb4A6a1FvbL9KhY485n0YoTM7QVG5p5E5dTwM9EHLI6sWYeJQCTe5xLvpmv9jaWVro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWj6nDPB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768306620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqMOAAdX6b6MX/mADiWnXJHvpUV9kTdGsD1SHFH/Nac=;
	b=VWj6nDPBFsrGlDRmCDNmejKtVJujkAgsafFQ4NE2a/5VkgHhcPL7i9aXDldvfagTPhxdB4
	Vbpt49/aBUcMJxaBW9Twtsk5cc/HGMwdRrLzLj1Rdd1HTIkzQ5D4N6Kw2/aA6Asur5yvE/
	RKzFAeAELPHku+6ETCgdYKE4ooBsJoM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-Nh41L1t6PD-cT990NVKMag-1; Tue,
 13 Jan 2026 07:16:57 -0500
X-MC-Unique: Nh41L1t6PD-cT990NVKMag-1
X-Mimecast-MFC-AGG-ID: Nh41L1t6PD-cT990NVKMag_1768306615
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B60D1956096;
	Tue, 13 Jan 2026 12:16:55 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C50A81954196;
	Tue, 13 Jan 2026 12:16:47 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH net-next v2 2/3] dpll: add dpll_device op to set working mode
Date: Tue, 13 Jan 2026 13:16:35 +0100
Message-ID: <20260113121636.71565-3-ivecera@redhat.com>
In-Reply-To: <20260113121636.71565-1-ivecera@redhat.com>
References: <20260113121636.71565-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently, userspace can retrieve the DPLL working mode but cannot
configure it. This prevents changing the device operation, such as
switching from manual to automatic mode and vice versa.

Add a new callback .mode_set() to struct dpll_device_ops. Extend
the netlink policy and device-set command handling to process
the DPLL_A_MODE attribute.  Update the netlink YAML specification
to include the mode attribute in the device-set operation.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* fixed bitmap size in dpll_mode_set()
---
 Documentation/netlink/specs/dpll.yaml |  1 +
 drivers/dpll/dpll_netlink.c           | 44 +++++++++++++++++++++++++++
 drivers/dpll/dpll_nl.c                |  1 +
 include/linux/dpll.h                  |  2 ++
 4 files changed, 48 insertions(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 78d0724d7e12c..b55afa77eac4b 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -550,6 +550,7 @@ operations:
         request:
           attributes:
             - id
+            - mode
             - phase-offset-monitor
             - phase-offset-avg-factor
     -
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index d6a0e272d7038..7a72d5d0d7093 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -853,6 +853,45 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
 }
 EXPORT_SYMBOL_GPL(dpll_pin_change_ntf);
 
+static int
+dpll_mode_set(struct dpll_device *dpll, struct nlattr *a,
+	      struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	enum dpll_mode mode = nla_get_u32(a), old_mode;
+	DECLARE_BITMAP(modes, DPLL_MODE_MAX + 1) = { 0 };
+	int ret;
+
+	if (!(ops->mode_set && ops->supported_modes_get)) {
+		NL_SET_ERR_MSG_ATTR(extack, a,
+				    "dpll device does not support mode switch");
+		return -EOPNOTSUPP;
+	}
+
+	ret = ops->mode_get(dpll, dpll_priv(dpll), &old_mode, extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get current mode");
+		return ret;
+	}
+
+	if (mode == old_mode)
+		return 0;
+
+	ret = ops->supported_modes_get(dpll, dpll_priv(dpll), modes, extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get supported modes");
+		return ret;
+	}
+
+	if (!test_bit(mode, modes)) {
+		NL_SET_ERR_MSG(extack,
+			       "dpll device does not support requested mode");
+		return -EINVAL;
+	}
+
+	return ops->mode_set(dpll, dpll_priv(dpll), mode, extack);
+}
+
 static int
 dpll_phase_offset_monitor_set(struct dpll_device *dpll, struct nlattr *a,
 			      struct netlink_ext_ack *extack)
@@ -1808,6 +1847,11 @@ dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
 	nla_for_each_attr(a, genlmsg_data(info->genlhdr),
 			  genlmsg_len(info->genlhdr), rem) {
 		switch (nla_type(a)) {
+		case DPLL_A_MODE:
+			ret = dpll_mode_set(dpll, a, info->extack);
+			if (ret)
+				return ret;
+			break;
 		case DPLL_A_PHASE_OFFSET_MONITOR:
 			ret = dpll_phase_offset_monitor_set(dpll, a,
 							    info->extack);
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index 36d11ff195df4..a2b22d4921142 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -45,6 +45,7 @@ static const struct nla_policy dpll_device_get_nl_policy[DPLL_A_ID + 1] = {
 /* DPLL_CMD_DEVICE_SET - do */
 static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_PHASE_OFFSET_AVG_FACTOR + 1] = {
 	[DPLL_A_ID] = { .type = NLA_U32, },
+	[DPLL_A_MODE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
 	[DPLL_A_PHASE_OFFSET_MONITOR] = NLA_POLICY_MAX(NLA_U32, 1),
 	[DPLL_A_PHASE_OFFSET_AVG_FACTOR] = { .type = NLA_U32, },
 };
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 912a2ca3e0ee7..c6d0248fa5273 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -20,6 +20,8 @@ struct dpll_pin_esync;
 struct dpll_device_ops {
 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
 			enum dpll_mode *mode, struct netlink_ext_ack *extack);
+	int (*mode_set)(const struct dpll_device *dpll, void *dpll_priv,
+			enum dpll_mode mode, struct netlink_ext_ack *extack);
 	int (*supported_modes_get)(const struct dpll_device *dpll,
 				   void *dpll_priv, unsigned long *modes,
 				   struct netlink_ext_ack *extack);
-- 
2.52.0


