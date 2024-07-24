Return-Path: <netdev+bounces-112847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6AE93B7FF
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 22:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E31D1F2134D
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 20:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1516D9A6;
	Wed, 24 Jul 2024 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxXricwP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B5316D4EB
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852746; cv=none; b=euUYRdIrAYYfCgVR2XLOwWoC9jmPuFkqHFTzkz15OXXu8IP+3vTUxzZ0UhBffg1Dhy9RvFpycJjIeAwB0ZcDUy2q9gmcLmt2JHPvkqbwuZHGaHSrQrKMt8d1LBnwxQh3rh/c1Y1ORIaLGWXOgOZ9oTEztlPspE7MhZI0/WUhTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852746; c=relaxed/simple;
	bh=tSpSZMhOXoe95sZf/3QKYEavIF0nVCZ74BdhqIxYt1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruHyxXzXvKEjbNM0U/GV7tHp87RLI5uu/Frv/dRvAPKt59dsd4f5zQuJ1k4KFGBZCWpuXDH9g0NpTtnQoZdt9qQOzOS8zAgfF4vRsB79oismXOVVsZlUerrXoBC6rK8zcxmPLWEhPER6p4E/EirLXxUcUzV85JgV6IIIMDoknFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxXricwP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721852743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8PmOZsPrictgXxDk26WLf+INcKSpSv7lBh+EbLrOY9g=;
	b=NxXricwP+muCpGi8QLG4F/iWWLyL40atyrhLe13nYFvysTfFamZuQn/Tv1PYC2YpcCIJe9
	MaezU9Yzl+juFlFaUCdTNIGoaYqnrH/ShoR+9EKmoliZ2mPwrRg5L3BOsteFh/sZQG5TUb
	TnE/veUcTRjsg4soTbdF+fzU3+ICdMc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-JJQvUUL6NdqyNvM75CqTMA-1; Wed,
 24 Jul 2024 16:25:40 -0400
X-MC-Unique: JJQvUUL6NdqyNvM75CqTMA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADC281955D44;
	Wed, 24 Jul 2024 20:25:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C23A19560AE;
	Wed, 24 Jul 2024 20:25:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH RFC v2 04/11] net-shapers: implement NL group operation
Date: Wed, 24 Jul 2024 22:24:50 +0200
Message-ID: <bfa0800bed218c117f7a1bcea80e1ee7f43b486d.1721851988.git.pabeni@redhat.com>
In-Reply-To: <cover.1721851988.git.pabeni@redhat.com>
References: <cover.1721851988.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Alllow grouping multiple inputs shaper under the given output's
one.

Try hard to pre-allocated the needed resources, to avoid non
trivial H/W configuration rollbacks in case of any failure.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/shaper/shaper.c | 265 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 264 insertions(+), 1 deletion(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 7802c9ba6d9c..d99d000d7e7a 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -48,6 +48,18 @@ static bool is_detached(u32 handle)
 	return net_shaper_handle_scope(handle) == NET_SHAPER_SCOPE_DETACHED;
 }
 
+/* count the number of [multi] attributes of the given type */
+static int attr_list_len(struct genl_info *info, int type)
+{
+	struct nlattr *attr;
+	int rem, cnt = 0;
+
+	nla_for_each_attr_type(attr, type, genlmsg_data(info->genlhdr),
+			       genlmsg_len(info->genlhdr), rem)
+		cnt++;
+	return cnt;
+}
+
 static int fill_handle(struct sk_buff *msg, u32 handle, u32 type,
 		       const struct genl_info *info)
 {
@@ -255,6 +267,27 @@ static void sc_commit(struct net_device *dev, int nr_shapers,
 	xa_unlock(xa);
 }
 
+/* rollback all the tentative inserts from the shaper cache */
+static void sc_rollback(struct net_device *dev)
+{
+	struct xarray *xa = __sc_container(dev);
+	struct net_shaper_info *cur;
+	unsigned long index;
+
+	if (!xa)
+		return;
+
+	xa_lock(xa);
+	xa_for_each_marked(xa, index, cur, XA_MARK_0) {
+		if (is_detached(index))
+			idr_remove(&dev->net_shaper_data->detached_ids,
+				   net_shaper_handle_id(index));
+		__xa_erase(xa, index);
+		kfree(cur);
+	}
+	xa_unlock(xa);
+}
+
 static int parse_handle(const struct nlattr *attr, const struct genl_info *info,
 			u32 *handle)
 {
@@ -354,6 +387,36 @@ static int parse_shaper(struct net_device *dev, const struct nlattr *attr,
 	return __parse_shaper(dev, tb, info, shaper);
 }
 
+/* alike parse_shaper(), but additionally allow the user specifying
+ * the shaper's parent handle
+ */
+static int parse_output_shaper(struct net_device *dev,
+			       const struct nlattr *attr,
+			       const struct genl_info *info,
+			       struct net_shaper_info *shaper)
+{
+	struct nlattr *tb[NET_SHAPER_A_PARENT + 1];
+	int ret;
+
+	ret = nla_parse_nested(tb, NET_SHAPER_A_PARENT, attr,
+			       net_shaper_ns_output_info_nl_policy,
+			       info->extack);
+	if (ret < 0)
+		return ret;
+
+	ret = __parse_shaper(dev, tb, info, shaper);
+	if (ret)
+		return ret;
+
+	if (tb[NET_SHAPER_A_PARENT]) {
+		ret = parse_handle(tb[NET_SHAPER_A_PARENT], info,
+				   &shaper->parent);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_shaper_info *shaper;
@@ -568,9 +631,209 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+/* Update the H/W and on success update the local cache, too */
+static int net_shaper_group(struct net_device *dev, int nr_inputs,
+			    struct net_shaper_info *inputs,
+			    struct net_shaper_info *output,
+			    struct netlink_ext_ack *extack)
+{
+	enum net_shaper_scope scope, output_scope, output_pscope;
+	struct net_shaper_info *parent = NULL;
+	int i, ret;
+
+	output_scope = net_shaper_handle_scope(output->handle);
+	if (output_scope != NET_SHAPER_SCOPE_DETACHED &&
+	    output_scope != NET_SHAPER_SCOPE_NETDEV) {
+		NL_SET_ERR_MSG_FMT(extack, "Invalid scope %d for output shaper %x",
+				   output_scope, output->handle);
+		return -EINVAL;
+	}
+
+	output_pscope = net_shaper_handle_scope(output->parent);
+	if (output_scope == NET_SHAPER_SCOPE_DETACHED) {
+		if (net_shaper_handle_id(output->handle) !=
+		    NET_SHAPER_ID_UNSPEC && !sc_lookup(dev, output->handle)) {
+			NL_SET_ERR_MSG_FMT(extack, "Output shaper %x does not exists",
+					   output->handle);
+			return -EINVAL;
+		}
+		if (output_pscope != NET_SHAPER_SCOPE_DETACHED &&
+		    output_pscope != NET_SHAPER_SCOPE_NETDEV) {
+			NL_SET_ERR_MSG_FMT(extack, "Invalid scope %d for output parent shaper %x",
+					   output_pscope, output->parent);
+			return -EINVAL;
+		}
+	}
+
+	if (output_pscope == NET_SHAPER_SCOPE_DETACHED) {
+		parent = sc_lookup(dev, output->parent);
+		if (!parent) {
+			NL_SET_ERR_MSG_FMT(extack, "Output parent shaper %x does not exists",
+					   output->parent);
+			return -EINVAL;
+		}
+	}
+
+	/* for newly created detached scope shaper, the following will update the
+	 * handle, due to id allocation
+	 */
+	ret = sc_prepare_insert(dev, &output->handle, extack);
+	if (ret)
+		goto rollback;
+
+	for (i = 0; i < nr_inputs; ++i) {
+		scope = net_shaper_handle_scope(inputs[i].handle);
+		if (scope != NET_SHAPER_SCOPE_QUEUE &&
+		    scope != NET_SHAPER_SCOPE_DETACHED) {
+			ret = -EINVAL;
+			NL_SET_ERR_MSG_FMT(extack, "Invalid scope %d for input shaper %d handle %x",
+					   scope, i, inputs[i].handle);
+			goto rollback;
+		}
+		if (scope == NET_SHAPER_SCOPE_DETACHED &&
+		    !sc_lookup(dev, inputs[i].handle)) {
+			ret = -EINVAL;
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Can't create detached shaper as input %d handle %x",
+					   i, inputs[i].handle);
+			goto rollback;
+		}
+
+		ret = sc_prepare_insert(dev, &inputs[i].handle, extack);
+		if (ret)
+			goto rollback;
+
+		/* the inputs shapers will be nested to the output */
+		if (inputs[i].parent != output->handle) {
+			inputs[i].parent = output->handle;
+			output->children++;
+		}
+	}
+
+	ret = dev->netdev_ops->net_shaper_ops->group(dev, nr_inputs,
+						     inputs, output,
+						     extack);
+	if (ret < 0)
+		goto rollback;
+
+	if (parent)
+		parent->children++;
+	sc_commit(dev, 1, output);
+	sc_commit(dev, nr_inputs, inputs);
+	return ret;
+
+rollback:
+	sc_rollback(dev);
+	return ret;
+}
+
+static int nla_handle_total_size(void)
+{
+	return nla_total_size(nla_total_size(sizeof(u32)) +
+			      nla_total_size(sizeof(u32)));
+}
+
+static int group_send_reply(struct genl_info *info, u32 handle, int id)
+{
+	struct nlattr *handle_attr;
+	struct sk_buff *msg;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+/* prepare the msg reply in advance, to avoid device operation rollback */
+	msg = genlmsg_new(nla_handle_total_size(), GFP_KERNEL);
+	if (!msg)
+		return ret;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr)
+		goto free_msg;
+
+	handle_attr = nla_nest_start(msg, NET_SHAPER_A_HANDLE);
+	if (!handle_attr)
+		goto free_msg;
+
+	if (nla_put_u32(msg, NET_SHAPER_A_SCOPE,
+			net_shaper_handle_scope(handle)))
+		goto free_msg;
+
+	if (nla_put_u32(msg, NET_SHAPER_A_ID, id))
+		goto free_msg;
+
+	nla_nest_end(msg, handle_attr);
+	genlmsg_end(msg, hdr);
+
+	ret =  genlmsg_reply(msg, info);
+	if (ret)
+		goto free_msg;
+
+	return ret;
+
+free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_info *inputs, output;
+	int i, ret, rem, nr_inputs;
+	struct net_device *dev;
+	struct nlattr *attr;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_INPUTS) ||
+	    GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_OUTPUT))
+		return -EINVAL;
+
+	ret = fetch_dev(info, &dev);
+	if (ret)
+		return ret;
+
+	nr_inputs = attr_list_len(info, NET_SHAPER_A_INPUTS);
+	inputs = kcalloc(nr_inputs, sizeof(struct net_shaper_info), GFP_KERNEL);
+	if (!inputs) {
+		GENL_SET_ERR_MSG_FMT(info, "Can't allocate memory for %d input shapers",
+				     nr_inputs);
+		ret = -ENOMEM;
+		goto put;
+	}
+
+	ret = parse_output_shaper(dev, info->attrs[NET_SHAPER_A_OUTPUT], info,
+				  &output);
+	if (ret)
+		goto free_shapers;
+
+	i = 0;
+	nla_for_each_attr_type(attr, NET_SHAPER_A_INPUTS,
+			       genlmsg_data(info->genlhdr),
+			       genlmsg_len(info->genlhdr), rem) {
+		if (WARN_ON_ONCE(i >= nr_inputs))
+			goto free_shapers;
+
+		ret = parse_shaper(dev, attr, info, &inputs[i++]);
+		if (ret)
+			goto free_shapers;
+	}
+
+	ret = net_shaper_group(dev, nr_inputs, inputs, &output, info->extack);
+	if (ret < 0)
+		goto free_shapers;
+
+	ret = group_send_reply(info, output.handle, ret);
+	if (ret) {
+		/* Error on reply is not fatal to avoid rollback a successful
+		 * configuration
+		 */
+		GENL_SET_ERR_MSG_FMT(info, "Can't send reply %d", ret);
+		ret = 0;
+	}
+
+free_shapers:
+	kfree(inputs);
+
+put:
+	dev_put(dev);
+	return ret;
 }
 
 void dev_shaper_flush(struct net_device *dev)
-- 
2.45.2


