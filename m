Return-Path: <netdev+bounces-39505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72977BF905
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7DF281BAD
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D547DF69;
	Tue, 10 Oct 2023 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiU6YT8M"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941DFC1D
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:51:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2B994
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696935088; x=1728471088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O0zF6VR/kSqg7WE3pplSWDGiXzOLARFsIB/7Sb967Ds=;
  b=WiU6YT8MehRwORSeYjSAvhe8VFMFPkrkcz/E+g8GABjrcqZMeGR/xd++
   uVsxbiVJ+sdeF4/w9fYqyEBa413xg9ANNpEN7FQ7eUgbXWNp7RJr12dh/
   YALOj+FT3lFwHkvrdgGe6t5NeyXxhBFb0K6vGkI6FZCm6Oiw2iSxd5bYD
   jAXilhrluFmocE1vU85y/sRSG0y4WeuBWGIVkkQyB9GmZ5IJhR1UYFWve
   N1SDHoPRKaXhO2XClfdmceuT60AfuhGW9UETvIqDr52j1AO5EClYmj0zw
   9GgLrOJgfgT5bJUNhaD6VOOe2cOGhw0oYhC4YXjcpEdch2ZrBvHO5MuF8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="450859585"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="450859585"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084726153"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="1084726153"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2023 03:50:52 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4E47C386C3;
	Tue, 10 Oct 2023 11:50:49 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Edwin Peer <edwin.peer@broadcom.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Luo bin <luobin9@huawei.com>,
	George Cherian <george.cherian@marvell.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Cc: Brett Creeley <brett.creeley@amd.com>,
	Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>,
	Aya Levin <ayal@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH net-next v1 1/8] devlink: retain error in struct devlink_fmsg
Date: Tue, 10 Oct 2023 12:43:11 +0200
Message-Id: <20231010104318.3571791-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010104318.3571791-1-przemyslaw.kitszel@intel.com>
References: <20231010104318.3571791-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Retain error value in struct devlink_fmsg, to relieve drivers from
checking it after each call.
Note that fmsg is an in-memory builder/buffer of formatted message,
so it's not the case that half baked message was sent somewhere.

We could find following scheme in multiple drivers:
  err = devlink_fmsg_obj_nest_start(fmsg);
  if (err)
  	return err;
  err = devlink_fmsg_string_pair_put(fmsg, "src", src);
  if (err)
  	return err;
  err = devlink_fmsg_something(fmsg, foo, bar);
  if (err)
	return err;
  // and so on...
  err = devlink_fmsg_obj_nest_end(fmsg);

With retaining error API that translates to:
  devlink_fmsg_obj_nest_start(fmsg);
  devlink_fmsg_string_pair_put(fmsg, "src", src);
  devlink_fmsg_something(fmsg, foo, bar);
  // and so on...
  err = devlink_fmsg_obj_nest_end(fmsg);

What means we check error just at the end
(one could return it directly of course).

Possible error scenarios are developer error (API misuse) and memory
exhaustion, both cases are good candidates to choose readability
over fastest possible exit.

This commit itself is an illustration of benefits for the dev-user,
more of it will be in separate commits of the series.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 2/4 grow/shrink: 11/9 up/down: 325/-646 (-321)
---
 net/devlink/health.c | 255 ++++++++++++++++---------------------------
 1 file changed, 92 insertions(+), 163 deletions(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index 638cad8d5c65..2d26479e9dbe 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -19,6 +19,7 @@ struct devlink_fmsg_item {
 
 struct devlink_fmsg {
 	struct list_head item_list;
+	int err; /* first error encountered on some devlink_fmsg_XXX() call */
 	bool putting_binary; /* This flag forces enclosing of binary data
 			      * in an array brackets. It forces using
 			      * of designated API:
@@ -565,10 +566,8 @@ static int devlink_health_do_dump(struct devlink_health_reporter *reporter,
 		return 0;
 
 	reporter->dump_fmsg = devlink_fmsg_alloc();
-	if (!reporter->dump_fmsg) {
-		err = -ENOMEM;
-		return err;
-	}
+	if (!reporter->dump_fmsg)
+		return -ENOMEM;
 
 	err = devlink_fmsg_obj_nest_start(reporter->dump_fmsg);
 	if (err)
@@ -673,43 +672,59 @@ int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
 	return devlink_health_reporter_recover(reporter, NULL, info->extack);
 }
 
-static int devlink_fmsg_nest_common(struct devlink_fmsg *fmsg,
-				    int attrtype)
+static bool _devlink_fmsg_err_or_binary(struct devlink_fmsg *fmsg)
+{
+	if (!fmsg->err && fmsg->putting_binary)
+		fmsg->err = -EINVAL;
+
+	return fmsg->err;
+}
+
+static int devlink_fmsg_nest_common(struct devlink_fmsg *fmsg, int attrtype)
 {
 	struct devlink_fmsg_item *item;
 
+	if (fmsg->err)
+		return fmsg->err;
+
 	item = kzalloc(sizeof(*item), GFP_KERNEL);
-	if (!item)
-		return -ENOMEM;
+	if (!item) {
+		fmsg->err = -ENOMEM;
+		return fmsg->err;
+	}
 
 	item->attrtype = attrtype;
 	list_add_tail(&item->list, &fmsg->item_list);
 
 	return 0;
 }
 
+/**
+ * devlink_fmsg_obj_nest_start - emit start of nested object to @fmsg
+ *
+ * @fmsg: struct devlink_fmsg pointer, formatted message
+ *
+ * If called on @fmsg already in error state, that error will be returned.
+ */
 int devlink_fmsg_obj_nest_start(struct devlink_fmsg *fmsg)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
+	if (_devlink_fmsg_err_or_binary(fmsg))
+		return fmsg->err;
 
 	return devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_OBJ_NEST_START);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_obj_nest_start);
 
 static int devlink_fmsg_nest_end(struct devlink_fmsg *fmsg)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
+	if (_devlink_fmsg_err_or_binary(fmsg))
+		return fmsg->err;
 
 	return devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_NEST_END);
 }
 
 int devlink_fmsg_obj_nest_end(struct devlink_fmsg *fmsg)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
 	return devlink_fmsg_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_obj_nest_end);
@@ -720,15 +735,19 @@ static int devlink_fmsg_put_name(struct devlink_fmsg *fmsg, const char *name)
 {
 	struct devlink_fmsg_item *item;
 
-	if (fmsg->putting_binary)
-		return -EINVAL;
+	if (_devlink_fmsg_err_or_binary(fmsg))
+		return fmsg->err;
 
-	if (strlen(name) + 1 > DEVLINK_FMSG_MAX_SIZE)
-		return -EMSGSIZE;
+	if (strlen(name) + 1 > DEVLINK_FMSG_MAX_SIZE) {
+		fmsg->err = -EMSGSIZE;
+		return fmsg->err;
+	}
 
 	item = kzalloc(sizeof(*item) + strlen(name) + 1, GFP_KERNEL);
-	if (!item)
-		return -ENOMEM;
+	if (!item) {
+		fmsg->err = -ENOMEM;
+		return fmsg->err;
+	}
 
 	item->nla_type = NLA_NUL_STRING;
 	item->len = strlen(name) + 1;
@@ -741,68 +760,32 @@ static int devlink_fmsg_put_name(struct devlink_fmsg *fmsg, const char *name)
 
 int devlink_fmsg_pair_nest_start(struct devlink_fmsg *fmsg, const char *name)
 {
-	int err;
+	if (_devlink_fmsg_err_or_binary(fmsg))
+		return fmsg->err;
 
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
-	err = devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_PAIR_NEST_START);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_put_name(fmsg, name);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_PAIR_NEST_START);
+	return devlink_fmsg_put_name(fmsg, name);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_pair_nest_start);
 
 int devlink_fmsg_pair_nest_end(struct devlink_fmsg *fmsg)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
 	return devlink_fmsg_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_pair_nest_end);
 
 int devlink_fmsg_arr_pair_nest_start(struct devlink_fmsg *fmsg,
 				     const char *name)
 {
-	int err;
-
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_ARR_NEST_START);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	return devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_ARR_NEST_START);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_arr_pair_nest_start);
 
 int devlink_fmsg_arr_pair_nest_end(struct devlink_fmsg *fmsg)
 {
-	int err;
-
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
-	err = devlink_fmsg_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_nest_end(fmsg);
+	return devlink_fmsg_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_arr_pair_nest_end);
 
@@ -816,14 +799,19 @@ int devlink_fmsg_binary_pair_nest_start(struct devlink_fmsg *fmsg,
 		return err;
 
 	fmsg->putting_binary = true;
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_binary_pair_nest_start);
 
 int devlink_fmsg_binary_pair_nest_end(struct devlink_fmsg *fmsg)
 {
-	if (!fmsg->putting_binary)
-		return -EINVAL;
+	if (fmsg->err)
+		return fmsg->err;
+
+	if (!fmsg->err && !fmsg->putting_binary) {
+		fmsg->err = -EINVAL;
+		return fmsg->err;
+	}
 
 	fmsg->putting_binary = false;
 	return devlink_fmsg_arr_pair_nest_end(fmsg);
@@ -836,12 +824,16 @@ static int devlink_fmsg_put_value(struct devlink_fmsg *fmsg,
 {
 	struct devlink_fmsg_item *item;
 
-	if (value_len > DEVLINK_FMSG_MAX_SIZE)
-		return -EMSGSIZE;
+	if (value_len > DEVLINK_FMSG_MAX_SIZE) {
+		fmsg->err = -EMSGSIZE;
+		return fmsg->err;
+	}
 
 	item = kzalloc(sizeof(*item) + value_len, GFP_KERNEL);
-	if (!item)
-		return -ENOMEM;
+	if (!item) {
+		fmsg->err = -ENOMEM;
+		return fmsg->err;
+	}
 
 	item->nla_type = value_nla_type;
 	item->len = value_len;
@@ -854,41 +846,41 @@ static int devlink_fmsg_put_value(struct devlink_fmsg *fmsg,
 
 static int devlink_fmsg_bool_put(struct devlink_fmsg *fmsg, bool value)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
+	if (_devlink_fmsg_err_or_binary(fmsg))
+		return fmsg->err;
 
 	return devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_FLAG);
 }
 
 static int devlink_fmsg_u8_put(struct devlink_fmsg *fmsg, u8 value)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
+	if (_devlink_fmsg_err_or_binary(fmsg))
+		return fmsg->err;
 
 	return devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U8);
 }
 
 int devlink_fmsg_u32_put(struct devlink_fmsg *fmsg, u32 value)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
+	if (_devlink_fmsg_err_or_binary(fmsg))
+		return fmsg->err;
 
 	return devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U32);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u32_put);
 
 static int devlink_fmsg_u64_put(struct devlink_fmsg *fmsg, u64 value)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
+	if (_devlink_fmsg_err_or_binary(fmsg))
+		return fmsg->err;
 
 	return devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U64);
 }
 
 int devlink_fmsg_string_put(struct devlink_fmsg *fmsg, const char *value)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
+	if (_devlink_fmsg_err_or_binary(fmsg))
+		return fmsg->err;
 
 	return devlink_fmsg_put_value(fmsg, value, strlen(value) + 1,
 				      NLA_NUL_STRING);
@@ -908,113 +900,52 @@ EXPORT_SYMBOL_GPL(devlink_fmsg_binary_put);
 int devlink_fmsg_bool_pair_put(struct devlink_fmsg *fmsg, const char *name,
 			       bool value)
 {
-	int err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_bool_put(fmsg, value);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	devlink_fmsg_bool_put(fmsg, value);
+	return devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_bool_pair_put);
 
 int devlink_fmsg_u8_pair_put(struct devlink_fmsg *fmsg, const char *name,
 			     u8 value)
 {
-	int err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u8_put(fmsg, value);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	devlink_fmsg_u8_put(fmsg, value);
+	return devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u8_pair_put);
 
 int devlink_fmsg_u32_pair_put(struct devlink_fmsg *fmsg, const char *name,
 			      u32 value)
 {
-	int err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_put(fmsg, value);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	devlink_fmsg_u32_put(fmsg, value);
+	return devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u32_pair_put);
 
 int devlink_fmsg_u64_pair_put(struct devlink_fmsg *fmsg, const char *name,
 			      u64 value)
 {
-	int err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_put(fmsg, value);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	devlink_fmsg_u64_put(fmsg, value);
+	return devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u64_pair_put);
 
 int devlink_fmsg_string_pair_put(struct devlink_fmsg *fmsg, const char *name,
 				 const char *value)
 {
-	int err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_string_put(fmsg, value);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	devlink_fmsg_string_put(fmsg, value);
+	return devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_string_pair_put);
 
 int devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,
 				 const void *value, u32 value_len)
 {
 	u32 data_size;
-	int end_err;
 	u32 offset;
 	int err;
 
@@ -1030,14 +961,12 @@ int devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,
 		if (err)
 			break;
 		/* Exit from loop with a break (instead of
-		 * return) to make sure putting_binary is turned off in
-		 * devlink_fmsg_binary_pair_nest_end
+		 * return) to make sure putting_binary is turned off
 		 */
 	}
 
-	end_err = devlink_fmsg_binary_pair_nest_end(fmsg);
-	if (end_err)
-		err = end_err;
+	err = devlink_fmsg_binary_pair_nest_end(fmsg);
+	fmsg->putting_binary = false;
 
 	return err;
 }
-- 
2.40.1


