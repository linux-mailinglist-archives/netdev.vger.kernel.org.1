Return-Path: <netdev+bounces-133501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A79B996218
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A632F1F22E1E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC121885B2;
	Wed,  9 Oct 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACkKi696"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2BC1885B4
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461534; cv=none; b=leH1C2c7YF0VsXLJGqHwVpfwb+anQc2q57WzJ6jjhjv+Do0uTluPJcfDdv/OEWGS3AlEeSwLvQP2I9ohhkPdXq5AlRqh/e9k1BuXvWrIrPZ5g99MPltjGPDWYBY4aHDS01P0WmT8czdoyoWp3978CHh6b8HpM9wwMeFeOWvNer0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461534; c=relaxed/simple;
	bh=p5J0ZuaTDeq1z1FHiT82p6ADdy7U5SRpzgPZI88m+no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTMqyVu1Dd+i3C8lwtSbkjfqyLp/jN+UxTrmvLJUSZN4SnzAHa5oOlZtILjSBmK1xlyUf7JE78b01cvucwTmYkXQB2hd59To7cONDiCxwt5iJzuQW9ojJXVpuJTOIb98uiC1Wdn4d0fl72DOfsLxPF0sylkvsvnkDj1/Ey/+hkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACkKi696; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728461531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ow+m6VO/g4MnTygjXzgI2kzm9CE2XHnJv0mKZrbytsE=;
	b=ACkKi696xTUTnNrVGRn9PichjmUPBOGEUMGjqXQxTTGqVW7qBbCyFRxySp4Ai3PGmILMrO
	6+3ELjI0tusbmFBmqsTqBAZP9Ar0XbvALJVx14gkYAecBTJ10vZnCZBOq/z63l1lotHfNj
	I9FRnL2FkPyTpKMvLO/h6yGdW8uvTAk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-4dYbln3fOwqXGtfboSzRbg-1; Wed,
 09 Oct 2024 04:12:05 -0400
X-MC-Unique: 4dYbln3fOwqXGtfboSzRbg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D17919AAED5;
	Wed,  9 Oct 2024 08:11:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.249])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CD9E19560B2;
	Wed,  9 Oct 2024 08:11:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v9 net-next 10/15] net-shapers: implement cap validation in the core
Date: Wed,  9 Oct 2024 10:09:56 +0200
Message-ID: <54667601813e4c0348f39bf8ad2446ffc9fcd383.1728460186.git.pabeni@redhat.com>
In-Reply-To: <cover.1728460186.git.pabeni@redhat.com>
References: <cover.1728460186.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Use the device capabilities to reject invalid attribute values before
pushing them to the H/W.

Note that validating the metric explicitly avoids NL_SET_BAD_ATTR()
usage, to provide unambiguous error messages to the user.

Validating the nesting requires the knowledge of the new parent for
the given shaper; as such is a chicken-egg problem: to validate the
leaf nesting we need to know the node scope, to validate the node
nesting we need to know the leafs parent scope.

To break the circular dependency, place the leafs nesting validation
after the parsing.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v6 -> v7:
  - validate the queue id vs real_num_tx_queues
  - some mangling upon rebase, as 'node' is now always not NULL
    in net_shaper_parse_leaf()
---
 net/shaper/shaper.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index f9399984165a..15463062fe7b 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -439,6 +439,74 @@ static int net_shaper_parse_handle(const struct nlattr *attr,
 	return 0;
 }
 
+static int net_shaper_validate_caps(struct net_shaper_binding *binding,
+				    struct nlattr **tb,
+				    const struct genl_info *info,
+				    struct net_shaper *shaper)
+{
+	const struct net_shaper_ops *ops = net_shaper_ops(binding);
+	struct nlattr *bad = NULL;
+	unsigned long caps = 0;
+
+	ops->capabilities(binding, shaper->handle.scope, &caps);
+
+	if (tb[NET_SHAPER_A_PRIORITY] &&
+	    !(caps & BIT(NET_SHAPER_A_CAPS_SUPPORT_PRIORITY)))
+		bad = tb[NET_SHAPER_A_PRIORITY];
+	if (tb[NET_SHAPER_A_WEIGHT] &&
+	    !(caps & BIT(NET_SHAPER_A_CAPS_SUPPORT_WEIGHT)))
+		bad = tb[NET_SHAPER_A_WEIGHT];
+	if (tb[NET_SHAPER_A_BW_MIN] &&
+	    !(caps & BIT(NET_SHAPER_A_CAPS_SUPPORT_BW_MIN)))
+		bad = tb[NET_SHAPER_A_BW_MIN];
+	if (tb[NET_SHAPER_A_BW_MAX] &&
+	    !(caps & BIT(NET_SHAPER_A_CAPS_SUPPORT_BW_MAX)))
+		bad = tb[NET_SHAPER_A_BW_MAX];
+	if (tb[NET_SHAPER_A_BURST] &&
+	    !(caps & BIT(NET_SHAPER_A_CAPS_SUPPORT_BURST)))
+		bad = tb[NET_SHAPER_A_BURST];
+
+	if (!caps)
+		bad = tb[NET_SHAPER_A_HANDLE];
+
+	if (bad) {
+		NL_SET_BAD_ATTR(info->extack, bad);
+		return -EOPNOTSUPP;
+	}
+
+	if (shaper->handle.scope == NET_SHAPER_SCOPE_QUEUE &&
+	    binding->type == NET_SHAPER_BINDING_TYPE_NETDEV &&
+	    shaper->handle.id >= binding->netdev->real_num_tx_queues) {
+		NL_SET_ERR_MSG_FMT(info->extack,
+				   "Not existing queue id %d max %d",
+				   shaper->handle.id,
+				   binding->netdev->real_num_tx_queues);
+		return -ENOENT;
+	}
+
+	/* The metric is really used only if there is *any* rate-related
+	 * setting, either in current attributes set or in pre-existing
+	 * values.
+	 */
+	if (shaper->burst || shaper->bw_min || shaper->bw_max) {
+		u32 metric_cap = NET_SHAPER_A_CAPS_SUPPORT_METRIC_BPS +
+				 shaper->metric;
+
+		/* The metric test can fail even when the user did not
+		 * specify the METRIC attribute. Pointing to rate related
+		 * attribute will be confusing, as the attribute itself
+		 * could be indeed supported, with a different metric.
+		 * Be more specific.
+		 */
+		if (!(caps & BIT(metric_cap))) {
+			NL_SET_ERR_MSG_FMT(info->extack, "Bad metric %d",
+					   shaper->metric);
+			return -EOPNOTSUPP;
+		}
+	}
+	return 0;
+}
+
 static int net_shaper_parse_info(struct net_shaper_binding *binding,
 				 struct nlattr **tb,
 				 const struct genl_info *info,
@@ -487,6 +555,28 @@ static int net_shaper_parse_info(struct net_shaper_binding *binding,
 
 	if (tb[NET_SHAPER_A_WEIGHT])
 		shaper->weight = nla_get_u32(tb[NET_SHAPER_A_WEIGHT]);
+
+	ret = net_shaper_validate_caps(binding, tb, info, shaper);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int net_shaper_validate_nesting(struct net_shaper_binding *binding,
+				       const struct net_shaper *shaper,
+				       struct netlink_ext_ack *extack)
+{
+	const struct net_shaper_ops *ops = net_shaper_ops(binding);
+	unsigned long caps = 0;
+
+	ops->capabilities(binding, shaper->handle.scope, &caps);
+	if (!(caps & BIT(NET_SHAPER_A_CAPS_SUPPORT_NESTING))) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Nesting not supported for scope %d",
+				   shaper->handle.scope);
+		return -EOPNOTSUPP;
+	}
 	return 0;
 }
 
@@ -517,6 +607,13 @@ static int net_shaper_parse_leaf(struct net_shaper_binding *binding,
 		return -EINVAL;
 	}
 
+	if (node->handle.scope == NET_SHAPER_SCOPE_NODE) {
+		ret = net_shaper_validate_nesting(binding, shaper,
+						  info->extack);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (!exists)
 		net_shaper_default_parent(&shaper->handle, &shaper->parent);
 	return 0;
@@ -858,6 +955,10 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 					   node->parent.scope, node->parent.id);
 			return -ENOENT;
 		}
+
+		ret = net_shaper_validate_nesting(binding, node, extack);
+		if (ret < 0)
+			return ret;
 	}
 
 	if (update_node) {
-- 
2.45.2


