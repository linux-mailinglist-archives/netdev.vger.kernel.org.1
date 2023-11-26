Return-Path: <netdev+bounces-51160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C6D7F95F3
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D66280C39
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 22:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F3114A80;
	Sun, 26 Nov 2023 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ1Z+Lm5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA312E79
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 22:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AF4C433C8;
	Sun, 26 Nov 2023 22:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701039540;
	bh=d1LyswOgjMdgMdrsKBQr/rLOSrB+LFB0dElhHDtSve0=;
	h=From:To:Cc:Subject:Date:From;
	b=CQ1Z+Lm5i8Lf3eSojjiixlCS8g5ZLe0NzOgJ+ot/UxwQXnXJSNl/9+7K7eUPOQfJ5
	 uZ4NP3Q5TGz1M0IcLmDWGP4tqDnT7IG/FpQUAzwu4jnsSBVUcM7Yv9JIEPnuQRe8zH
	 MdNfJeGfJdewcLpS3Jf5G0Z10DuxVc3kVRuPTzbc6XB6TnbedHolSHb5u0njzkcUph
	 aHZ9R+9+R6tNg4rI0UuRvulD4IcoLVq7k1qsSs1f4q3f90u51TidEeHNdV19DW3tfd
	 EE/Tow7QAyqiEDs3mdkaNCGH2vKJmx4X5EmbIcAeUi2dsszWSi18RRQei4aWjwKWkd
	 LzKX2p5xwlN9Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us
Subject: [PATCH net] tools: ynl-gen: always construct struct ynl_req_state
Date: Sun, 26 Nov 2023 14:58:58 -0800
Message-ID: <20231126225858.2144136-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ynl_req_state carries reply-related info from generated code
into generic YNL code. While we don't need reply info to execute
a request without a reply, we still need to pass in the struct, because
it's also where we get the pointer to struct ynl_sock from. Passing NULL
results in crashes if kernel returns an error or an unexpected reply.

Fixes: dc0956c98f11 ("tools: ynl-gen: move the response reading logic into YNL")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jiri@resnulli.us
---
 tools/net/ynl/generated/devlink-user.c   | 87 ++++++++++++++++--------
 tools/net/ynl/generated/ethtool-user.c   | 51 +++++++++-----
 tools/net/ynl/generated/fou-user.c       |  6 +-
 tools/net/ynl/generated/handshake-user.c |  3 +-
 tools/net/ynl/ynl-gen-c.py               | 10 ++-
 5 files changed, 102 insertions(+), 55 deletions(-)

diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index c12ca87ca2bb..8e757e249dab 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -2399,6 +2399,7 @@ void devlink_port_set_req_free(struct devlink_port_set_req *req)
 
 int devlink_port_set(struct ynl_sock *ys, struct devlink_port_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -2416,7 +2417,7 @@ int devlink_port_set(struct ynl_sock *ys, struct devlink_port_set_req *req)
 	if (req->_present.port_function)
 		devlink_dl_port_function_put(nlh, DEVLINK_ATTR_PORT_FUNCTION, &req->port_function);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -2537,6 +2538,7 @@ void devlink_port_del_req_free(struct devlink_port_del_req *req)
 
 int devlink_port_del(struct ynl_sock *ys, struct devlink_port_del_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -2550,7 +2552,7 @@ int devlink_port_del(struct ynl_sock *ys, struct devlink_port_del_req *req)
 	if (req->_present.port_index)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -2568,6 +2570,7 @@ void devlink_port_split_req_free(struct devlink_port_split_req *req)
 
 int devlink_port_split(struct ynl_sock *ys, struct devlink_port_split_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -2583,7 +2586,7 @@ int devlink_port_split(struct ynl_sock *ys, struct devlink_port_split_req *req)
 	if (req->_present.port_split_count)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_SPLIT_COUNT, req->port_split_count);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -2602,6 +2605,7 @@ void devlink_port_unsplit_req_free(struct devlink_port_unsplit_req *req)
 int devlink_port_unsplit(struct ynl_sock *ys,
 			 struct devlink_port_unsplit_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -2615,7 +2619,7 @@ int devlink_port_unsplit(struct ynl_sock *ys,
 	if (req->_present.port_index)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -2926,6 +2930,7 @@ void devlink_sb_pool_set_req_free(struct devlink_sb_pool_set_req *req)
 int devlink_sb_pool_set(struct ynl_sock *ys,
 			struct devlink_sb_pool_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -2945,7 +2950,7 @@ int devlink_sb_pool_set(struct ynl_sock *ys,
 	if (req->_present.sb_pool_size)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_POOL_SIZE, req->sb_pool_size);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -3126,6 +3131,7 @@ devlink_sb_port_pool_set_req_free(struct devlink_sb_port_pool_set_req *req)
 int devlink_sb_port_pool_set(struct ynl_sock *ys,
 			     struct devlink_sb_port_pool_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -3145,7 +3151,7 @@ int devlink_sb_port_pool_set(struct ynl_sock *ys,
 	if (req->_present.sb_threshold)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_THRESHOLD, req->sb_threshold);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -3334,6 +3340,7 @@ devlink_sb_tc_pool_bind_set_req_free(struct devlink_sb_tc_pool_bind_set_req *req
 int devlink_sb_tc_pool_bind_set(struct ynl_sock *ys,
 				struct devlink_sb_tc_pool_bind_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -3357,7 +3364,7 @@ int devlink_sb_tc_pool_bind_set(struct ynl_sock *ys,
 	if (req->_present.sb_threshold)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_THRESHOLD, req->sb_threshold);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -3376,6 +3383,7 @@ void devlink_sb_occ_snapshot_req_free(struct devlink_sb_occ_snapshot_req *req)
 int devlink_sb_occ_snapshot(struct ynl_sock *ys,
 			    struct devlink_sb_occ_snapshot_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -3389,7 +3397,7 @@ int devlink_sb_occ_snapshot(struct ynl_sock *ys,
 	if (req->_present.sb_index)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_INDEX, req->sb_index);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -3409,6 +3417,7 @@ devlink_sb_occ_max_clear_req_free(struct devlink_sb_occ_max_clear_req *req)
 int devlink_sb_occ_max_clear(struct ynl_sock *ys,
 			     struct devlink_sb_occ_max_clear_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -3422,7 +3431,7 @@ int devlink_sb_occ_max_clear(struct ynl_sock *ys,
 	if (req->_present.sb_index)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_INDEX, req->sb_index);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -3544,6 +3553,7 @@ void devlink_eswitch_set_req_free(struct devlink_eswitch_set_req *req)
 int devlink_eswitch_set(struct ynl_sock *ys,
 			struct devlink_eswitch_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -3561,7 +3571,7 @@ int devlink_eswitch_set(struct ynl_sock *ys,
 	if (req->_present.eswitch_encap_mode)
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_ESWITCH_ENCAP_MODE, req->eswitch_encap_mode);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -3895,6 +3905,7 @@ devlink_dpipe_table_counters_set_req_free(struct devlink_dpipe_table_counters_se
 int devlink_dpipe_table_counters_set(struct ynl_sock *ys,
 				     struct devlink_dpipe_table_counters_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -3910,7 +3921,7 @@ int devlink_dpipe_table_counters_set(struct ynl_sock *ys,
 	if (req->_present.dpipe_table_counters_enabled)
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED, req->dpipe_table_counters_enabled);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -3929,6 +3940,7 @@ void devlink_resource_set_req_free(struct devlink_resource_set_req *req)
 int devlink_resource_set(struct ynl_sock *ys,
 			 struct devlink_resource_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -3944,7 +3956,7 @@ int devlink_resource_set(struct ynl_sock *ys,
 	if (req->_present.resource_size)
 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_RESOURCE_SIZE, req->resource_size);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -4319,6 +4331,7 @@ void devlink_param_set_req_free(struct devlink_param_set_req *req)
 
 int devlink_param_set(struct ynl_sock *ys, struct devlink_param_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -4336,7 +4349,7 @@ int devlink_param_set(struct ynl_sock *ys, struct devlink_param_set_req *req)
 	if (req->_present.param_value_cmode)
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_CMODE, req->param_value_cmode);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -4631,6 +4644,7 @@ void devlink_region_del_req_free(struct devlink_region_del_req *req)
 
 int devlink_region_del(struct ynl_sock *ys, struct devlink_region_del_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -4648,7 +4662,7 @@ int devlink_region_del(struct ynl_sock *ys, struct devlink_region_del_req *req)
 	if (req->_present.region_snapshot_id)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_REGION_SNAPSHOT_ID, req->region_snapshot_id);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -4922,6 +4936,7 @@ void devlink_port_param_set_req_free(struct devlink_port_param_set_req *req)
 int devlink_port_param_set(struct ynl_sock *ys,
 			   struct devlink_port_param_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -4935,7 +4950,7 @@ int devlink_port_param_set(struct ynl_sock *ys,
 	if (req->_present.port_index)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -5360,6 +5375,7 @@ devlink_health_reporter_set_req_free(struct devlink_health_reporter_set_req *req
 int devlink_health_reporter_set(struct ynl_sock *ys,
 				struct devlink_health_reporter_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -5381,7 +5397,7 @@ int devlink_health_reporter_set(struct ynl_sock *ys,
 	if (req->_present.health_reporter_auto_dump)
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP, req->health_reporter_auto_dump);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -5402,6 +5418,7 @@ devlink_health_reporter_recover_req_free(struct devlink_health_reporter_recover_
 int devlink_health_reporter_recover(struct ynl_sock *ys,
 				    struct devlink_health_reporter_recover_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -5417,7 +5434,7 @@ int devlink_health_reporter_recover(struct ynl_sock *ys,
 	if (req->_present.health_reporter_name_len)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_HEALTH_REPORTER_NAME, req->health_reporter_name);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -5438,6 +5455,7 @@ devlink_health_reporter_diagnose_req_free(struct devlink_health_reporter_diagnos
 int devlink_health_reporter_diagnose(struct ynl_sock *ys,
 				     struct devlink_health_reporter_diagnose_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -5453,7 +5471,7 @@ int devlink_health_reporter_diagnose(struct ynl_sock *ys,
 	if (req->_present.health_reporter_name_len)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_HEALTH_REPORTER_NAME, req->health_reporter_name);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -5556,6 +5574,7 @@ devlink_health_reporter_dump_clear_req_free(struct devlink_health_reporter_dump_
 int devlink_health_reporter_dump_clear(struct ynl_sock *ys,
 				       struct devlink_health_reporter_dump_clear_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -5571,7 +5590,7 @@ int devlink_health_reporter_dump_clear(struct ynl_sock *ys,
 	if (req->_present.health_reporter_name_len)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_HEALTH_REPORTER_NAME, req->health_reporter_name);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -5592,6 +5611,7 @@ void devlink_flash_update_req_free(struct devlink_flash_update_req *req)
 int devlink_flash_update(struct ynl_sock *ys,
 			 struct devlink_flash_update_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -5609,7 +5629,7 @@ int devlink_flash_update(struct ynl_sock *ys,
 	if (req->_present.flash_update_overwrite_mask)
 		mnl_attr_put(nlh, DEVLINK_ATTR_FLASH_UPDATE_OVERWRITE_MASK, sizeof(struct nla_bitfield32), &req->flash_update_overwrite_mask);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -5780,6 +5800,7 @@ void devlink_trap_set_req_free(struct devlink_trap_set_req *req)
 
 int devlink_trap_set(struct ynl_sock *ys, struct devlink_trap_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -5795,7 +5816,7 @@ int devlink_trap_set(struct ynl_sock *ys, struct devlink_trap_set_req *req)
 	if (req->_present.trap_action)
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_TRAP_ACTION, req->trap_action);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -5968,6 +5989,7 @@ void devlink_trap_group_set_req_free(struct devlink_trap_group_set_req *req)
 int devlink_trap_group_set(struct ynl_sock *ys,
 			   struct devlink_trap_group_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -5985,7 +6007,7 @@ int devlink_trap_group_set(struct ynl_sock *ys,
 	if (req->_present.trap_policer_id)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_TRAP_POLICER_ID, req->trap_policer_id);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -6152,6 +6174,7 @@ devlink_trap_policer_set_req_free(struct devlink_trap_policer_set_req *req)
 int devlink_trap_policer_set(struct ynl_sock *ys,
 			     struct devlink_trap_policer_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -6169,7 +6192,7 @@ int devlink_trap_policer_set(struct ynl_sock *ys,
 	if (req->_present.trap_policer_burst)
 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_TRAP_POLICER_BURST, req->trap_policer_burst);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -6190,6 +6213,7 @@ devlink_health_reporter_test_req_free(struct devlink_health_reporter_test_req *r
 int devlink_health_reporter_test(struct ynl_sock *ys,
 				 struct devlink_health_reporter_test_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -6205,7 +6229,7 @@ int devlink_health_reporter_test(struct ynl_sock *ys,
 	if (req->_present.health_reporter_name_len)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_HEALTH_REPORTER_NAME, req->health_reporter_name);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -6384,6 +6408,7 @@ void devlink_rate_set_req_free(struct devlink_rate_set_req *req)
 
 int devlink_rate_set(struct ynl_sock *ys, struct devlink_rate_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -6407,7 +6432,7 @@ int devlink_rate_set(struct ynl_sock *ys, struct devlink_rate_set_req *req)
 	if (req->_present.rate_parent_node_name_len)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_RATE_PARENT_NODE_NAME, req->rate_parent_node_name);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -6427,6 +6452,7 @@ void devlink_rate_new_req_free(struct devlink_rate_new_req *req)
 
 int devlink_rate_new(struct ynl_sock *ys, struct devlink_rate_new_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -6450,7 +6476,7 @@ int devlink_rate_new(struct ynl_sock *ys, struct devlink_rate_new_req *req)
 	if (req->_present.rate_parent_node_name_len)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_RATE_PARENT_NODE_NAME, req->rate_parent_node_name);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -6469,6 +6495,7 @@ void devlink_rate_del_req_free(struct devlink_rate_del_req *req)
 
 int devlink_rate_del(struct ynl_sock *ys, struct devlink_rate_del_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -6482,7 +6509,7 @@ int devlink_rate_del(struct ynl_sock *ys, struct devlink_rate_del_req *req)
 	if (req->_present.rate_node_name_len)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_RATE_NODE_NAME, req->rate_node_name);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -6645,6 +6672,7 @@ void devlink_linecard_set_req_free(struct devlink_linecard_set_req *req)
 int devlink_linecard_set(struct ynl_sock *ys,
 			 struct devlink_linecard_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -6660,7 +6688,7 @@ int devlink_linecard_set(struct ynl_sock *ys,
 	if (req->_present.linecard_type_len)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_LINECARD_TYPE, req->linecard_type);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -6810,6 +6838,7 @@ void devlink_selftests_run_req_free(struct devlink_selftests_run_req *req)
 int devlink_selftests_run(struct ynl_sock *ys,
 			  struct devlink_selftests_run_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -6823,7 +6852,7 @@ int devlink_selftests_run(struct ynl_sock *ys,
 	if (req->_present.selftests)
 		devlink_dl_selftest_id_put(nlh, DEVLINK_ATTR_SELFTESTS, &req->selftests);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
diff --git a/tools/net/ynl/generated/ethtool-user.c b/tools/net/ynl/generated/ethtool-user.c
index 74b883a14958..660435639e2b 100644
--- a/tools/net/ynl/generated/ethtool-user.c
+++ b/tools/net/ynl/generated/ethtool-user.c
@@ -1843,6 +1843,7 @@ void ethtool_linkinfo_set_req_free(struct ethtool_linkinfo_set_req *req)
 int ethtool_linkinfo_set(struct ynl_sock *ys,
 			 struct ethtool_linkinfo_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -1862,7 +1863,7 @@ int ethtool_linkinfo_set(struct ynl_sock *ys,
 	if (req->_present.transceiver)
 		mnl_attr_put_u8(nlh, ETHTOOL_A_LINKINFO_TRANSCEIVER, req->transceiver);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -2067,6 +2068,7 @@ void ethtool_linkmodes_set_req_free(struct ethtool_linkmodes_set_req *req)
 int ethtool_linkmodes_set(struct ynl_sock *ys,
 			  struct ethtool_linkmodes_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -2094,7 +2096,7 @@ int ethtool_linkmodes_set(struct ynl_sock *ys,
 	if (req->_present.rate_matching)
 		mnl_attr_put_u8(nlh, ETHTOOL_A_LINKMODES_RATE_MATCHING, req->rate_matching);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -2398,6 +2400,7 @@ void ethtool_debug_set_req_free(struct ethtool_debug_set_req *req)
 
 int ethtool_debug_set(struct ynl_sock *ys, struct ethtool_debug_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -2409,7 +2412,7 @@ int ethtool_debug_set(struct ynl_sock *ys, struct ethtool_debug_set_req *req)
 	if (req->_present.msgmask)
 		ethtool_bitset_put(nlh, ETHTOOL_A_DEBUG_MSGMASK, &req->msgmask);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -2577,6 +2580,7 @@ void ethtool_wol_set_req_free(struct ethtool_wol_set_req *req)
 
 int ethtool_wol_set(struct ynl_sock *ys, struct ethtool_wol_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -2590,7 +2594,7 @@ int ethtool_wol_set(struct ynl_sock *ys, struct ethtool_wol_set_req *req)
 	if (req->_present.sopass_len)
 		mnl_attr_put(nlh, ETHTOOL_A_WOL_SOPASS, req->_present.sopass_len, req->sopass);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -3045,6 +3049,7 @@ void ethtool_privflags_set_req_free(struct ethtool_privflags_set_req *req)
 int ethtool_privflags_set(struct ynl_sock *ys,
 			  struct ethtool_privflags_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -3056,7 +3061,7 @@ int ethtool_privflags_set(struct ynl_sock *ys,
 	if (req->_present.flags)
 		ethtool_bitset_put(nlh, ETHTOOL_A_PRIVFLAGS_FLAGS, &req->flags);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -3273,6 +3278,7 @@ void ethtool_rings_set_req_free(struct ethtool_rings_set_req *req)
 
 int ethtool_rings_set(struct ynl_sock *ys, struct ethtool_rings_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -3312,7 +3318,7 @@ int ethtool_rings_set(struct ynl_sock *ys, struct ethtool_rings_set_req *req)
 	if (req->_present.tx_push_buf_len_max)
 		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX, req->tx_push_buf_len_max);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -3495,6 +3501,7 @@ void ethtool_channels_set_req_free(struct ethtool_channels_set_req *req)
 int ethtool_channels_set(struct ynl_sock *ys,
 			 struct ethtool_channels_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -3520,7 +3527,7 @@ int ethtool_channels_set(struct ynl_sock *ys,
 	if (req->_present.combined_count)
 		mnl_attr_put_u32(nlh, ETHTOOL_A_CHANNELS_COMBINED_COUNT, req->combined_count);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -3798,6 +3805,7 @@ void ethtool_coalesce_set_req_free(struct ethtool_coalesce_set_req *req)
 int ethtool_coalesce_set(struct ynl_sock *ys,
 			 struct ethtool_coalesce_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -3861,7 +3869,7 @@ int ethtool_coalesce_set(struct ynl_sock *ys,
 	if (req->_present.tx_aggr_time_usecs)
 		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS, req->tx_aggr_time_usecs);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -4036,6 +4044,7 @@ void ethtool_pause_set_req_free(struct ethtool_pause_set_req *req)
 
 int ethtool_pause_set(struct ynl_sock *ys, struct ethtool_pause_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -4055,7 +4064,7 @@ int ethtool_pause_set(struct ynl_sock *ys, struct ethtool_pause_set_req *req)
 	if (req->_present.stats_src)
 		mnl_attr_put_u32(nlh, ETHTOOL_A_PAUSE_STATS_SRC, req->stats_src);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -4242,6 +4251,7 @@ void ethtool_eee_set_req_free(struct ethtool_eee_set_req *req)
 
 int ethtool_eee_set(struct ynl_sock *ys, struct ethtool_eee_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -4263,7 +4273,7 @@ int ethtool_eee_set(struct ynl_sock *ys, struct ethtool_eee_set_req *req)
 	if (req->_present.tx_lpi_timer)
 		mnl_attr_put_u32(nlh, ETHTOOL_A_EEE_TX_LPI_TIMER, req->tx_lpi_timer);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -4437,6 +4447,7 @@ void ethtool_cable_test_act_req_free(struct ethtool_cable_test_act_req *req)
 int ethtool_cable_test_act(struct ynl_sock *ys,
 			   struct ethtool_cable_test_act_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -4446,7 +4457,7 @@ int ethtool_cable_test_act(struct ynl_sock *ys,
 	if (req->_present.header)
 		ethtool_header_put(nlh, ETHTOOL_A_CABLE_TEST_HEADER, &req->header);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -4465,6 +4476,7 @@ ethtool_cable_test_tdr_act_req_free(struct ethtool_cable_test_tdr_act_req *req)
 int ethtool_cable_test_tdr_act(struct ynl_sock *ys,
 			       struct ethtool_cable_test_tdr_act_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -4474,7 +4486,7 @@ int ethtool_cable_test_tdr_act(struct ynl_sock *ys,
 	if (req->_present.header)
 		ethtool_header_put(nlh, ETHTOOL_A_CABLE_TEST_TDR_HEADER, &req->header);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -4782,6 +4794,7 @@ void ethtool_fec_set_req_free(struct ethtool_fec_set_req *req)
 
 int ethtool_fec_set(struct ynl_sock *ys, struct ethtool_fec_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -4799,7 +4812,7 @@ int ethtool_fec_set(struct ynl_sock *ys, struct ethtool_fec_set_req *req)
 	if (req->_present.stats)
 		ethtool_fec_stat_put(nlh, ETHTOOL_A_FEC_STATS, &req->stats);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -5235,6 +5248,7 @@ void ethtool_module_set_req_free(struct ethtool_module_set_req *req)
 
 int ethtool_module_set(struct ynl_sock *ys, struct ethtool_module_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -5248,7 +5262,7 @@ int ethtool_module_set(struct ynl_sock *ys, struct ethtool_module_set_req *req)
 	if (req->_present.power_mode)
 		mnl_attr_put_u8(nlh, ETHTOOL_A_MODULE_POWER_MODE, req->power_mode);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -5397,6 +5411,7 @@ void ethtool_pse_set_req_free(struct ethtool_pse_set_req *req)
 
 int ethtool_pse_set(struct ynl_sock *ys, struct ethtool_pse_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -5412,7 +5427,7 @@ int ethtool_pse_set(struct ynl_sock *ys, struct ethtool_pse_set_req *req)
 	if (req->_present.pw_d_status)
 		mnl_attr_put_u32(nlh, ETHTOOL_A_PODL_PSE_PW_D_STATUS, req->pw_d_status);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -5746,6 +5761,7 @@ void ethtool_plca_set_cfg_req_free(struct ethtool_plca_set_cfg_req *req)
 int ethtool_plca_set_cfg(struct ynl_sock *ys,
 			 struct ethtool_plca_set_cfg_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -5771,7 +5787,7 @@ int ethtool_plca_set_cfg(struct ynl_sock *ys,
 	if (req->_present.burst_tmr)
 		mnl_attr_put_u32(nlh, ETHTOOL_A_PLCA_BURST_TMR, req->burst_tmr);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -6124,6 +6140,7 @@ void ethtool_mm_set_req_free(struct ethtool_mm_set_req *req)
 
 int ethtool_mm_set(struct ynl_sock *ys, struct ethtool_mm_set_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -6143,7 +6160,7 @@ int ethtool_mm_set(struct ynl_sock *ys, struct ethtool_mm_set_req *req)
 	if (req->_present.tx_min_frag_size)
 		mnl_attr_put_u32(nlh, ETHTOOL_A_MM_TX_MIN_FRAG_SIZE, req->tx_min_frag_size);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
diff --git a/tools/net/ynl/generated/fou-user.c b/tools/net/ynl/generated/fou-user.c
index 4271b5d43c58..f30bef23bc31 100644
--- a/tools/net/ynl/generated/fou-user.c
+++ b/tools/net/ynl/generated/fou-user.c
@@ -72,6 +72,7 @@ void fou_add_req_free(struct fou_add_req *req)
 
 int fou_add(struct ynl_sock *ys, struct fou_add_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -99,7 +100,7 @@ int fou_add(struct ynl_sock *ys, struct fou_add_req *req)
 	if (req->_present.ifindex)
 		mnl_attr_put_u32(nlh, FOU_ATTR_IFINDEX, req->ifindex);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
@@ -117,6 +118,7 @@ void fou_del_req_free(struct fou_del_req *req)
 
 int fou_del(struct ynl_sock *ys, struct fou_del_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -140,7 +142,7 @@ int fou_del(struct ynl_sock *ys, struct fou_del_req *req)
 	if (req->_present.peer_v6_len)
 		mnl_attr_put(nlh, FOU_ATTR_PEER_V6, req->_present.peer_v6_len, req->peer_v6);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
diff --git a/tools/net/ynl/generated/handshake-user.c b/tools/net/ynl/generated/handshake-user.c
index 7c67765daf90..6901f8462cca 100644
--- a/tools/net/ynl/generated/handshake-user.c
+++ b/tools/net/ynl/generated/handshake-user.c
@@ -295,6 +295,7 @@ void handshake_done_req_free(struct handshake_done_req *req)
 
 int handshake_done(struct ynl_sock *ys, struct handshake_done_req *req)
 {
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -308,7 +309,7 @@ int handshake_done(struct ynl_sock *ys, struct handshake_done_req *req)
 	for (unsigned int i = 0; i < req->n_remote_auth; i++)
 		mnl_attr_put_u32(nlh, HANDSHAKE_A_DONE_REMOTE_AUTH, req->remote_auth[i]);
 
-	err = ynl_exec(ys, nlh, NULL);
+	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
 		return -1;
 
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index cbbda276f6d1..0d63dc88079b 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1713,14 +1713,14 @@ _C_KW = {
     ret_ok = '0'
     ret_err = '-1'
     direction = "request"
-    local_vars = ['struct nlmsghdr *nlh;',
+    local_vars = ['struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };',
+                  'struct nlmsghdr *nlh;',
                   'int err;']
 
     if 'reply' in ri.op[ri.op_mode]:
         ret_ok = 'rsp'
         ret_err = 'NULL'
-        local_vars += [f'{type_name(ri, rdir(direction))} *rsp;',
-                       'struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };']
+        local_vars += [f'{type_name(ri, rdir(direction))} *rsp;']
 
     print_prototype(ri, direction, terminate=False)
     ri.cw.block_start()
@@ -1736,7 +1736,6 @@ _C_KW = {
         attr.attr_put(ri, "req")
     ri.cw.nl()
 
-    parse_arg = "NULL"
     if 'reply' in ri.op[ri.op_mode]:
         ri.cw.p('rsp = calloc(1, sizeof(*rsp));')
         ri.cw.p('yrs.yarg.data = rsp;')
@@ -1746,8 +1745,7 @@ _C_KW = {
         else:
             ri.cw.p(f'yrs.rsp_cmd = {ri.op.rsp_value};')
         ri.cw.nl()
-        parse_arg = '&yrs'
-    ri.cw.p(f"err = ynl_exec(ys, nlh, {parse_arg});")
+    ri.cw.p("err = ynl_exec(ys, nlh, &yrs);")
     ri.cw.p('if (err < 0)')
     if 'reply' in ri.op[ri.op_mode]:
         ri.cw.p('goto err_free;')
-- 
2.42.0


