Return-Path: <netdev+bounces-125118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D7A96BF5E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7D51F22BA0
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E281DB557;
	Wed,  4 Sep 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5zO+REg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684CD1DB54A
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458273; cv=none; b=RUbd0Cge7EqpMffzVVc8VVHH3fLYuIhxl6b8DuSVUc/siATYmz6xcIM72rAextCzjEqk2ZSLCog0q5hHvCUJ2/JAUBMUDxmZVkEGv+A62nHyWMBHkIv1VfDEPzB/I4ntkqnh/53YmOuuGXxprfExGNpTSJDFSdvI3YnF9b+ptes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458273; c=relaxed/simple;
	bh=SshyXV6VEYrwhG8Z4yhjgTNmPVFJzF4q96u4rkvQ5x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDeCtPu0ZJkg02BBjvQTBjzalXGwF52z5UF0FUs7QL/OTYkITJ1l6RNSq141Yow2da2MHgHGYibjD6t3dkHtjF+Y4yzpHNt4K67d+Xf3tpuwKgrmUoPTyYP69+JKN0uwR4caP75hv8XxjOaZwACtT98JOooAiKpzimnMnegVMQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5zO+REg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725458270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rl6yobjd7UXt2Q/0cYy4li72iQT0wTFuHNoZ0R0l76E=;
	b=P5zO+REgVix95SNN9ClaYTyfgXQ/OgV9u9pDLxRHoGEvpNKpYjEP905BgExq2oL0554iUf
	F0A6Hz+0e/se6UlDJKqVNBHvRAwDUOrEM2nuQ65gGaq2zYkN9sRrGLmJ4/7huZ2075Hg63
	c7QutXzl42fOD9DQFg4+CwjtCrjZWag=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-qlWDzr_nPkm7yqfTIVhmEQ-1; Wed,
 04 Sep 2024 09:57:49 -0400
X-MC-Unique: qlWDzr_nPkm7yqfTIVhmEQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 580171944D41;
	Wed,  4 Sep 2024 13:57:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EADD1955F1E;
	Wed,  4 Sep 2024 13:57:34 +0000 (UTC)
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
	edumazet@google.com
Subject: [PATCH v6 net-next 10/15] net-shapers: implement cap validation in the core
Date: Wed,  4 Sep 2024 15:53:42 +0200
Message-ID: <70576ddc8b7323192c452ee1c66e7a228f7d8b68.1725457317.git.pabeni@redhat.com>
In-Reply-To: <cover.1725457317.git.pabeni@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/shaper/shaper.c | 102 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 3 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index bc55dd53a5d7..2302faf9ee45 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -441,6 +441,64 @@ static int net_shaper_parse_handle(const struct nlattr *attr,
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
@@ -491,6 +549,28 @@ static int net_shaper_parse_info(struct net_shaper_binding *binding,
 
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
 
@@ -516,9 +596,21 @@ static int net_shaper_parse_info_nest(struct net_shaper_binding *binding,
 	if (ret < 0)
 		return ret;
 
-	if (node && shaper->handle.scope != NET_SHAPER_SCOPE_QUEUE) {
-		NL_SET_BAD_ATTR(info->extack, tb[NET_SHAPER_A_HANDLE]);
-		return -EINVAL;
+	/* When node is specified, the shaper is actually a leaf for a
+	 * group() operation.
+	 */
+	if (node) {
+		if (shaper->handle.scope != NET_SHAPER_SCOPE_QUEUE) {
+			NL_SET_BAD_ATTR(info->extack, tb[NET_SHAPER_A_HANDLE]);
+			return -EINVAL;
+		}
+
+		if (node->handle.scope == NET_SHAPER_SCOPE_NODE) {
+			ret = net_shaper_validate_nesting(binding, shaper,
+							  info->extack);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (!exists)
@@ -875,6 +967,10 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
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


