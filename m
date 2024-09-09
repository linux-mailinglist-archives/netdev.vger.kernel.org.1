Return-Path: <netdev+bounces-126725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 725BF972514
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02F41F24C20
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7917C9F8;
	Mon,  9 Sep 2024 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JO4sH4ix"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072118DF60
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919909; cv=none; b=smPTzCPPodgNZvVBpYevGbNaMgA1W4zPQJhRUJLB0Zfv5k9Uj5A/KXXgLvHyLQAj53dVPvFJFiOBP04o3RnYfSbRXqnyO4Vjfn1/+akqB8z9wziN1kQWv2nlwvusS5cs9FRjeu5f0Ou2f4YKjNEXaT3OMWnILgyWYeZuMPXpCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919909; c=relaxed/simple;
	bh=MoBm8NNZnzrCuLWfSiWYU4f2Lba5+c0RTIapfL1YFDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Prfl2HJDM8dgKITHld0tXQDwvAgPDBHbKwR+vOWcptIRZX3WS/LxcYTogY3OzHqxT1WtkbcXw985tXBpMTIavgmDg7w90kTDlZjJJZ2LHgBy6UbZjXZnHp3fPW6pKhnuDleop5U2D73EfGaKhS77P3DxIyhrFuSp31HITRCWZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JO4sH4ix; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725919906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rZRAFE1PifDnARdCag97zpgkPbbZa5BBiiypRORyLQ=;
	b=JO4sH4ixmkfF5JpBiC4pberDWSmbR3yizdlGngjXWifD1g3MGnWRbysvFoMbAnlNKJWvmj
	9sXN6XnZdkM9d+9DIoCd93+ljrLUIC4ihh+ow+8SaHHI+t9+p/keoK9k/16u/siGvKf8Bo
	edsRCrjFeZn5XU0NpuKb0v4lpTyptE0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-R_Ja6J4YOgiM5q5i1UFWNA-1; Mon,
 09 Sep 2024 18:11:44 -0400
X-MC-Unique: R_Ja6J4YOgiM5q5i1UFWNA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FE3419560B1;
	Mon,  9 Sep 2024 22:11:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.56])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A49C1956086;
	Mon,  9 Sep 2024 22:11:37 +0000 (UTC)
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
Subject: [PATCH v7 net-next 10/15] net-shapers: implement cap validation in the core
Date: Tue, 10 Sep 2024 00:10:04 +0200
Message-ID: <b1b9a2ba1f8847b602f90102a0321a42ac9ff06f.1725919039.git.pabeni@redhat.com>
In-Reply-To: <cover.1725919039.git.pabeni@redhat.com>
References: <cover.1725919039.git.pabeni@redhat.com>
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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
index cf282b26f9aa..8631e700a069 100644
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
@@ -489,6 +557,28 @@ static int net_shaper_parse_info(struct net_shaper_binding *binding,
 
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
 
@@ -519,6 +609,13 @@ static int net_shaper_parse_leaf(struct net_shaper_binding *binding,
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
@@ -860,6 +957,10 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
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


