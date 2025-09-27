Return-Path: <netdev+bounces-226870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93413BA5B8B
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 10:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150853B61BF
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F0A2D6E67;
	Sat, 27 Sep 2025 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/PGuXzs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50C2D47E8
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962981; cv=none; b=etY3a2VQuLNm6XbbCNjNpakAvpZgG2cZc0E9a99R71ozZpC/taucoLr3eSUSuVgRzD03CUvWWml/jEUuoqsbinGFkDxtBrqz4r6C2KvoS6JTq1wJfwZNPzrmXwhjV3wmzGtnBmtecYEo4lJV54gIrxMCMUkn7UcsXWaGbZMvuao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962981; c=relaxed/simple;
	bh=cRUDVTzhvUt3cZRMJciHl/Pqt0TO8UCUstDUWC56C6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXnpnCypWgM0RDBiiJiBt6BQ8CoY7PT4lq7490tyUK7FkTuaxfeNiCcX/4RyTK8X6P07fJBmzxyYe1i6RXaaLsqiv4/9mjkiio8x2QqRgZk/oAsAcTKzN74aXXdHPn4hUjd1feH7gKVWeNkp+9ObrPFSwEFQjHadTDRios8QsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/PGuXzs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758962979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxl0TxLf25xUAMm4j2lJ8TNVEvxXadGeeqzjsC9P7KU=;
	b=S/PGuXzs/08kEGMXQDIDcT+c4Ijcih/jojIyveqYrhaIxkblSREblC+4BgQlM6cDjaz00A
	Fz/b/gHv2lPkHfnjHidXLreVo46oJANYnjGoRAKihy/iFQOUOTGmHUAySmbnWTOjwN/1ch
	kfL0YJ3RaLUBZt3x1MUbn5s8BQbUheo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-v_1g_-S9NnK1glnByDxCzg-1; Sat,
 27 Sep 2025 04:49:34 -0400
X-MC-Unique: v_1g_-S9NnK1glnByDxCzg-1
X-Mimecast-MFC-AGG-ID: v_1g_-S9NnK1glnByDxCzg_1758962972
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14C34180034C;
	Sat, 27 Sep 2025 08:49:32 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.247])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96E7F19560AB;
	Sat, 27 Sep 2025 08:49:26 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v2 2/3] dpll: add phase_offset_avg_factor_get/set callback ops
Date: Sat, 27 Sep 2025 10:49:11 +0200
Message-ID: <20250927084912.2343597-3-ivecera@redhat.com>
In-Reply-To: <20250927084912.2343597-1-ivecera@redhat.com>
References: <20250927084912.2343597-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add new callback operations for a dpll device:
- phase_offset_avg_factor_get(...) - to obtain current phase offset
  averaging factor from dpll device,
- phase_offset_avg_factor_set(...) - to set phase offset averaging factor

Obtain the factor value using the get callback and provide it to the user
if the device driver implement this callback. Execute the set callback upon
user requests, if the driver implement it.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
v2:
* do not require 'set' callback to retrieve current value
* always call 'set' callback regardless of current value
---
 drivers/dpll/dpll_netlink.c | 66 +++++++++++++++++++++++++++++++++----
 include/linux/dpll.h        |  6 ++++
 2 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 0a852011653c4..74c1f0ca95f24 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -164,6 +164,27 @@ dpll_msg_add_phase_offset_monitor(struct sk_buff *msg, struct dpll_device *dpll,
 	return 0;
 }
 
+static int
+dpll_msg_add_phase_offset_avg_factor(struct sk_buff *msg,
+				     struct dpll_device *dpll,
+				     struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	u32 factor;
+	int ret;
+
+	if (ops->phase_offset_avg_factor_get) {
+		ret = ops->phase_offset_avg_factor_get(dpll, dpll_priv(dpll),
+						       &factor, extack);
+		if (ret)
+			return ret;
+		if (nla_put_u32(msg, DPLL_A_PHASE_OFFSET_AVG_FACTOR, factor))
+			return -EMSGSIZE;
+	}
+
+	return 0;
+}
+
 static int
 dpll_msg_add_lock_status(struct sk_buff *msg, struct dpll_device *dpll,
 			 struct netlink_ext_ack *extack)
@@ -675,6 +696,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
 	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
 		return -EMSGSIZE;
 	ret = dpll_msg_add_phase_offset_monitor(msg, dpll, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_phase_offset_avg_factor(msg, dpll, extack);
 	if (ret)
 		return ret;
 
@@ -839,6 +863,23 @@ dpll_phase_offset_monitor_set(struct dpll_device *dpll, struct nlattr *a,
 					     extack);
 }
 
+static int
+dpll_phase_offset_avg_factor_set(struct dpll_device *dpll, struct nlattr *a,
+				 struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	u32 factor = nla_get_u32(a);
+
+	if (!ops->phase_offset_avg_factor_set) {
+		NL_SET_ERR_MSG_ATTR(extack, a,
+				    "device not capable of changing phase offset average factor");
+		return -EOPNOTSUPP;
+	}
+
+	return ops->phase_offset_avg_factor_set(dpll, dpll_priv(dpll), factor,
+						extack);
+}
+
 static int
 dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		  struct netlink_ext_ack *extack)
@@ -1736,14 +1777,25 @@ int dpll_nl_device_get_doit(struct sk_buff *skb, struct genl_info *info)
 static int
 dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
 {
-	int ret;
-
-	if (info->attrs[DPLL_A_PHASE_OFFSET_MONITOR]) {
-		struct nlattr *a = info->attrs[DPLL_A_PHASE_OFFSET_MONITOR];
+	struct nlattr *a;
+	int rem, ret;
 
-		ret = dpll_phase_offset_monitor_set(dpll, a, info->extack);
-		if (ret)
-			return ret;
+	nla_for_each_attr(a, genlmsg_data(info->genlhdr),
+			  genlmsg_len(info->genlhdr), rem) {
+		switch (nla_type(a)) {
+		case DPLL_A_PHASE_OFFSET_MONITOR:
+			ret = dpll_phase_offset_monitor_set(dpll, a,
+							    info->extack);
+			if (ret)
+				return ret;
+			break;
+		case DPLL_A_PHASE_OFFSET_AVG_FACTOR:
+			ret = dpll_phase_offset_avg_factor_set(dpll, a,
+							       info->extack);
+			if (ret)
+				return ret;
+			break;
+		}
 	}
 
 	return 0;
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index fa1e76920d0ee..25be745bf41f1 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -38,6 +38,12 @@ struct dpll_device_ops {
 					void *dpll_priv,
 					enum dpll_feature_state *state,
 					struct netlink_ext_ack *extack);
+	int (*phase_offset_avg_factor_set)(const struct dpll_device *dpll,
+					   void *dpll_priv, u32 factor,
+					   struct netlink_ext_ack *extack);
+	int (*phase_offset_avg_factor_get)(const struct dpll_device *dpll,
+					   void *dpll_priv, u32 *factor,
+					   struct netlink_ext_ack *extack);
 };
 
 struct dpll_pin_ops {
-- 
2.49.1


