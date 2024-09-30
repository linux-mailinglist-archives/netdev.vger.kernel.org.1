Return-Path: <netdev+bounces-130417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D8F98A667
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951391C22998
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AA6190684;
	Mon, 30 Sep 2024 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eA8kHymg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A8190671
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704533; cv=none; b=t5nJuQq2txtQkTc827WVq9qBE9tKbSs8acGlUAjhe8W+S+6ZEzd+VTedk/HFr4SDYfMxZTeYawAVPhX1n3gNlxb3YfuiPMtMPYPJfivEL0aRTvpMZzaKhhdFGlcWYfrmzhQNaIJAByYFG6y7ZH1s7gBEGyr8BP7C3s7uI8M70j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704533; c=relaxed/simple;
	bh=Ni2+D7poOEDWw1MYfoBmYXHcTa0hVnKis1haBb5DDCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYGDfh8HpheY+wNsyZoSVJzDqAL5gBl/CIpflZyuirfJcLWTIMOh2tYyAJwmWW2lDCywQ6Mas09eBf66k8j1IsNumSdy7lOUrT6W38aoaj+g/gahEckK+9jD7zy88eA47mu7c9yVkiXXUNvVKKJUslTnMnWXlypNZvfUwFPFuPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eA8kHymg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727704530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0nzLN0YTUprsy8RfgpIhspndZYlYjADPE95W06NkOI=;
	b=eA8kHymg6FyeZ03f+JxyYjCpyOk2K3o9uldbCvngN3W0VXlpXiv0opih34Nij11Uq+HUAq
	A6PjMgXG5nzEDbL1i6KbEinn0Q51wze+ho4f76Yo3gpr+Bm868fg33qwUWLLvuCk/+V4pn
	iotGj8b3DUPiHUd1BdbnEPkkReGleFY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-8yJMa465P-uP4JhjKV39wQ-1; Mon,
 30 Sep 2024 09:55:27 -0400
X-MC-Unique: 8yJMa465P-uP4JhjKV39wQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74F541944DE0;
	Mon, 30 Sep 2024 13:55:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E0691954B0F;
	Mon, 30 Sep 2024 13:55:20 +0000 (UTC)
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
Subject: [PATCH v8 net-next 09/15] net: shaper: implement introspection support
Date: Mon, 30 Sep 2024 15:53:56 +0200
Message-ID: <7523bf4d6f19429efd32192dd5b90f7bb0b0b20d.1727704215.git.pabeni@redhat.com>
In-Reply-To: <cover.1727704215.git.pabeni@redhat.com>
References: <cover.1727704215.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The netlink op is a simple wrapper around the device callback.

Extend the existing fetch_dev() helper adding an attribute argument
for the requested device. Reuse such helper in the newly implemented
operation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v5 -> v6:
 - update to new API

v4 -> v5:
 - replace net_device* with binding* in most functions
 - de-deplicate some code thanks to more generic helpers in previous
   patches

v3 -> v4:
 - another dev_put() -> netdev_put() conversion, missed in previous
   iteration

RFC v2 -> v3:
 - dev_put() -> netdev_put()
---
 net/shaper/shaper.c | 98 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 92c8da046391..f9399984165a 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -601,22 +601,29 @@ int net_shaper_nl_post_dumpit(struct netlink_callback *cb)
 int net_shaper_nl_cap_pre_doit(const struct genl_split_ops *ops,
 			       struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	return net_shaper_generic_pre(info, NET_SHAPER_A_CAPS_IFINDEX);
 }
 
 void net_shaper_nl_cap_post_doit(const struct genl_split_ops *ops,
 				 struct sk_buff *skb, struct genl_info *info)
 {
+	net_shaper_generic_post(info);
 }
 
 int net_shaper_nl_cap_pre_dumpit(struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)cb->ctx;
+
+	return net_shaper_ctx_setup(genl_info_dump(cb),
+				    NET_SHAPER_A_CAPS_IFINDEX, ctx);
 }
 
 int net_shaper_nl_cap_post_dumpit(struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)cb->ctx;
+
+	net_shaper_ctx_cleanup(ctx);
+	return 0;
 }
 
 int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
@@ -1147,14 +1154,99 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	goto free_leaves;
 }
 
+static int
+net_shaper_cap_fill_one(struct sk_buff *msg,
+			struct net_shaper_binding *binding,
+			enum net_shaper_scope scope, unsigned long flags,
+			const struct genl_info *info)
+{
+	unsigned long cur;
+	void *hdr;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (net_shaper_fill_binding(msg, binding, NET_SHAPER_A_CAPS_IFINDEX) ||
+	    nla_put_u32(msg, NET_SHAPER_A_CAPS_SCOPE, scope))
+		goto nla_put_failure;
+
+	for (cur = NET_SHAPER_A_CAPS_SUPPORT_METRIC_BPS;
+	     cur <= NET_SHAPER_A_CAPS_MAX; ++cur) {
+		if (flags & BIT(cur) && nla_put_flag(msg, cur))
+			goto nla_put_failure;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
 int net_shaper_nl_cap_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct net_shaper_binding *binding;
+	const struct net_shaper_ops *ops;
+	enum net_shaper_scope scope;
+	unsigned long flags = 0;
+	struct sk_buff *msg;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_CAPS_SCOPE))
+		return -EINVAL;
+
+	binding = net_shaper_binding_from_ctx(info->ctx);
+	scope = nla_get_u32(info->attrs[NET_SHAPER_A_CAPS_SCOPE]);
+	ops = net_shaper_ops(binding);
+	ops->capabilities(binding, scope, &flags);
+	if (!flags)
+		return -EOPNOTSUPP;
+
+	msg = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = net_shaper_cap_fill_one(msg, binding, scope, flags, info);
+	if (ret)
+		goto free_msg;
+
+	ret =  genlmsg_reply(msg, info);
+	if (ret)
+		goto free_msg;
 	return 0;
+
+free_msg:
+	nlmsg_free(msg);
+	return ret;
 }
 
 int net_shaper_nl_cap_get_dumpit(struct sk_buff *skb,
 				 struct netlink_callback *cb)
 {
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net_shaper_binding *binding;
+	const struct net_shaper_ops *ops;
+	enum net_shaper_scope scope;
+	int ret;
+
+	binding = net_shaper_binding_from_ctx(cb->ctx);
+	ops = net_shaper_ops(binding);
+	for (scope = 0; scope <= NET_SHAPER_SCOPE_MAX; ++scope) {
+		unsigned long flags = 0;
+
+		ops->capabilities(binding, scope, &flags);
+		if (!flags)
+			continue;
+
+		ret = net_shaper_cap_fill_one(skb, binding, scope, flags,
+					      info);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.45.2


