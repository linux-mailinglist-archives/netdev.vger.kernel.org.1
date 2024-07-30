Return-Path: <netdev+bounces-114317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7BC9421C2
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7D028351F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B01418E025;
	Tue, 30 Jul 2024 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcsUUOC0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71118DF8B
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372100; cv=none; b=ISWIqTeeGRWcWb4HIv3TtWz6TI0sDNvro1dwF4QG94o3CVSd+ca1v2LhfgfyCo6PIcozwhw1HL41OPwJSR6s2HwsN9q20lSZ4ygQ1v3NfBpWc0dJT8EEZ7rSNGfAzmIwyzhvZM9Q7pnZAB5L3zu93l1/mlqtZ7Nz9IpQ/UbVATU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372100; c=relaxed/simple;
	bh=KI3Q3Ke1ZAgJnFHizsBWt3o9Sg9R1HHh90Pi8VWF3NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrkrNZgXGweRDZmUqiLrIb0dSq5nnDEM7DGnh5n0HS3GNNEa8EeWFTgzdbnJnJ8R+cQkanHz7683vtUONk/p6BQwJwCHCCTpMwpxauU3efYn/j7QLFEjEXKAQ2qw4L7ZshXfuGlkDF1ktAHR9SVcHtxou3eM2Z5tGg/efcYo7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcsUUOC0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722372097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AebRBH9L8uV4hA9s5/+mah/Z9sy55AJS7DHsGUbay6M=;
	b=EcsUUOC0zHuvoVe02x96RobbvkBLhIrXlvBxM3qBCcBVMYXLRmo/mgcrP79GI33QhBgmp0
	kgpmto1p7QjsMpqTRKscRFgCgj1mNN927lmddjVTvDOOBRxtmqtRhOlDZ+HeV9oHowrQCi
	vYaRQyifciSzIJWItsvRYOOflqiD0/o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-k09PtvBZOA2om1OlONiGjQ-1; Tue,
 30 Jul 2024 16:41:35 -0400
X-MC-Unique: k09PtvBZOA2om1OlONiGjQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 065E31955D54;
	Tue, 30 Jul 2024 20:41:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 286B13000192;
	Tue, 30 Jul 2024 20:41:29 +0000 (UTC)
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
Subject: [PATCH v3 05/12] net-shapers: implement NL group operation
Date: Tue, 30 Jul 2024 22:39:48 +0200
Message-ID: <4722e2ad6e2e36184a5b18158b677a64dc0caf01.1722357745.git.pabeni@redhat.com>
In-Reply-To: <cover.1722357745.git.pabeni@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Allow grouping multiple inputs shaper under the given output's
one.

Try hard to pre-allocated the needed resources, to avoid non
trivial H/W configuration rollbacks in case of any failure.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
RFC v2 -> RFC v3:
 - dev_put() -> netdev_put()
---
 net/shaper/shaper.c | 265 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 264 insertions(+), 1 deletion(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 8ecbfd9002be..87db541de646 100644
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
@@ -569,9 +632,209 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
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
+	/* for newly created detached scope shaper, the following will update
+	 * the handle, due to id allocation
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
+	netdev_put(dev, NULL);
+	return ret;
 }
 
 void dev_shaper_flush(struct net_device *dev)
-- 
2.45.2


