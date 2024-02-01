Return-Path: <netdev+bounces-68207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2E4846204
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 21:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE81528D0C4
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 20:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D749025556;
	Thu,  1 Feb 2024 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8dKoAXe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3593BB43
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820078; cv=none; b=ubwILGEykn7xSRqPq/89AcFIKBwYodS8QRSWxZrHMRs18aIWWvOSnUQCUT/T2AEQc45Kj3mJNfGNUYeQjkj+6WGdYMow/4fIrBG3QnDLfwhzAnFgZvNwaTGajf1cWsW2HzYvYTDBe+X9LhS/XyaJg4vmR6zdq9eFJm18zEUp3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820078; c=relaxed/simple;
	bh=fls4rknSJq3o3uO0ILbpr3vJIvQXRHVDzIBME4PVkxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RvueB/hQ13PR1x21Q5g43OsSQJN70ujW+aWnuyFqGGDcw9qr3qdfmDcOgP0Cpv56uBlJHQwbKHhqqIxhI4BHzwqahlDxvtve2IojT6aTFu18K/Ov996wudGA6ko9Y257XeGFN2Q1W/nBKggMdmlVfMvdKrs7mr/yqMNAO5Btq3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8dKoAXe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706820077; x=1738356077;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fls4rknSJq3o3uO0ILbpr3vJIvQXRHVDzIBME4PVkxM=;
  b=T8dKoAXeAa5jTsE+WqwDMEH2pVYhMZ9OckCAJS+Ir8fqEpg1KT7DlgaL
   q2L1qWi/l7BTlIXtfuvW76eW6vknnegY6TPjbsPz6RB8jSPud6S5PSIEv
   XLNOODieKhqmzCz0bpds++gA5PvST+hkFB9M4VlFHC7jReEJw0aMDlxS2
   /9NRrPzeVgytdgMSPEIhM1daQDX1bGALDdZ9YzzWHT6B5WZ0U/QZJ0e+7
   3ZbrTSRYcBg5ZBIMqatSEzesaoYCu6ay5JUunTrxqxV7xt4ECxFDteO54
   TTi0MLm9QbfNEqjry2FtkSgZurBrIfQivcRmnMcvznvM0U1gyWrVsw56M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="183938"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="183938"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 12:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="1120058157"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="1120058157"
Received: from oradovic-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.60.111])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 12:41:10 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	alexander.duyck@gmail.com,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	gal@nvidia.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH ethtool] ethtool: add support for RSS input transformation
Date: Thu,  1 Feb 2024 13:41:04 -0700
Message-Id: <20240201204104.40931-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for RSS input transformation [1]. Currently, only symmetric-xor
is supported. The user can set the RSS input transformation via:

    # ethtool -X <dev> xfrm symmetric-xor

and sets it off (default) by:

    # ethtool -X <dev> xfrm none

The status of the transformation is reported by a new section at the end
of "ethtool -x":

    # ethtool -x <dev>
      .
      .
      .
      .
      RSS hash function:
          toeplitz: on
          xor: off
          crc32: off
      RSS input transformation:
          symmetric-xor: on

Link: https://lore.kernel.org/netdev/20231213003321.605376-1-ahmed.zaki@intel.com/
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 ethtool.8.in  | 12 ++++++++++++
 ethtool.c     | 16 ++++++++++++++++
 netlink/rss.c | 19 +++++++++++++++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 7a3080f..b701182 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -351,6 +351,7 @@ ethtool \- query or control network driver and hardware settings
 .RB ...\ | \ default \ ]
 .RB [ hfunc
 .IR FUNC ]
+.B2 xfrm symmetric-xor none
 .RB [ context
 .I CTX
 .RB |\  new ]
@@ -1201,6 +1202,17 @@ even if a nibble is zero.
 Sets RSS hash function of the specified network device.
 List of RSS hash functions which kernel supports is shown as a part of the --show-rxfh command output.
 .TP
+.BI xfrm
+Sets the RSS input transformation. Currently, only the
+.B symmetric-xor
+transformation is supported where the NIC XORs the L3 and/or L4 source and
+destination fields (as selected by
+.B --config-nfc rx-flow-hash
+) before passing them to the hash algorithm. The RSS hash function will
+then yield the same hash for the other flow direction where the source and
+destination fields are swapped (i.e. Symmetric RSS). Switch off (default) by
+.B xfrm none.
+.TP
 .BI start\  N
 For the \fBequal\fR and \fBweight\fR options, sets the starting receive queue
 for spreading flows to \fIN\fR.
diff --git a/ethtool.c b/ethtool.c
index 3ac15a7..82919f8 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4029,6 +4029,10 @@ static int do_grxfh(struct cmd_context *ctx)
 		       (const char *)hfuncs->data + i * ETH_GSTRING_LEN,
 		       (rss->hfunc & (1 << i)) ? "on" : "off");
 
+	printf("RSS input transformation:\n");
+	printf("    symmetric-xor: %s\n",
+	       (rss->input_xfrm & RXH_XFRM_SYM_XOR) ? "on" : "off");
+
 out:
 	free(hfuncs);
 	free(rss);
@@ -4146,6 +4150,7 @@ static int do_srxfh(struct cmd_context *ctx)
 	u32 arg_num = 0, indir_bytes = 0;
 	u32 req_hfunc = 0;
 	u32 entry_size = sizeof(rss_head.rss_config[0]);
+	u32 req_input_xfrm = 0xff;
 	u32 num_weights = 0;
 	u32 rss_context = 0;
 	int delete = 0;
@@ -4189,6 +4194,15 @@ static int do_srxfh(struct cmd_context *ctx)
 			if (!req_hfunc_name)
 				exit_bad_args();
 			++arg_num;
+		} else if (!strcmp(ctx->argp[arg_num], "xfrm")) {
+			++arg_num;
+			if (!strcmp(ctx->argp[arg_num], "symmetric-xor"))
+				req_input_xfrm = RXH_XFRM_SYM_XOR;
+			else if (!strcmp(ctx->argp[arg_num], "none"))
+				req_input_xfrm = 0;
+			else
+				exit_bad_args();
+			++arg_num;
 		} else if (!strcmp(ctx->argp[arg_num], "context")) {
 			++arg_num;
 			if(!strcmp(ctx->argp[arg_num], "new"))
@@ -4333,6 +4347,7 @@ static int do_srxfh(struct cmd_context *ctx)
 	rss->cmd = ETHTOOL_SRSSH;
 	rss->rss_context = rss_context;
 	rss->hfunc = req_hfunc;
+	rss->input_xfrm = req_input_xfrm;
 	if (delete) {
 		rss->indir_size = rss->key_size = 0;
 	} else {
@@ -5887,6 +5902,7 @@ static const struct option args[] = {
 			  "		[ equal N | weight W0 W1 ... | default ]\n"
 			  "		[ hkey %x:%x:%x:%x:%x:.... ]\n"
 			  "		[ hfunc FUNC ]\n"
+			  "		[ xfrm symmetric-xor|none ]\n"
 			  "		[ delete ]\n"
 	},
 	{
diff --git a/netlink/rss.c b/netlink/rss.c
index 4ad6065..dc28698 100644
--- a/netlink/rss.c
+++ b/netlink/rss.c
@@ -21,7 +21,8 @@ struct cb_args {
 
 void dump_json_rss_info(struct cmd_context *ctx, u32 *indir_table,
 			u32 indir_size, u8 *hkey, u32 hkey_size,
-			const struct stringset *hash_funcs, u8 hfunc)
+			const struct stringset *hash_funcs, u8 hfunc,
+			u32 input_xfrm)
 {
 	unsigned int i;
 
@@ -46,6 +47,12 @@ void dump_json_rss_info(struct cmd_context *ctx, u32 *indir_table,
 			if (hfunc & (1 << i)) {
 				print_string(PRINT_JSON, "rss-hash-function",
 					     NULL, get_string(hash_funcs, i));
+				open_json_object("rss-input-transformation");
+				print_bool(PRINT_JSON, "symmetric-xor", NULL,
+					   (input_xfrm & RXH_XFRM_SYM_XOR) ?
+					   true : false);
+
+				close_json_object();
 				break;
 			}
 		}
@@ -89,6 +96,7 @@ int rss_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	const struct stringset *hash_funcs;
 	u32 rss_hfunc = 0, indir_size;
 	u32 *indir_table = NULL;
+	u32 input_xfrm = 0;
 	u8 *hkey = NULL;
 	bool silent;
 	int err_ret;
@@ -118,6 +126,9 @@ int rss_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		hkey = mnl_attr_get_payload(tb[ETHTOOL_A_RSS_HKEY]);
 	}
 
+	if (tb[ETHTOOL_A_RSS_INPUT_XFRM])
+		input_xfrm = mnl_attr_get_u32(tb[ETHTOOL_A_RSS_INPUT_XFRM]);
+
 	/* Fetch RSS hash functions and their status and print */
 	if (!nlctx->is_monitor) {
 		ret = netlink_init_ethnl2_socket(nlctx);
@@ -153,7 +164,8 @@ int rss_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	indir_size = indir_bytes / sizeof(u32);
 	if (is_json_context()) {
 		dump_json_rss_info(nlctx->ctx, (u32 *)indir_table, indir_size,
-				   hkey, hkey_bytes, hash_funcs, rss_hfunc);
+				   hkey, hkey_bytes, hash_funcs, rss_hfunc,
+				   input_xfrm);
 	} else {
 		print_indir_table(nlctx->ctx, args->num_rings,
 				  indir_size, (u32 *)indir_table);
@@ -167,6 +179,9 @@ int rss_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 			printf("    %s: %s\n", get_string(hash_funcs, i),
 			       (rss_hfunc & (1 << i)) ? "on" : "off");
 		}
+		printf("RSS input transformation:\n");
+		printf("    symmetric-xor: %s\n",
+		       (input_xfrm & RXH_XFRM_SYM_XOR) ? "on" : "off");
 	}
 
 	return MNL_CB_OK;
-- 
2.34.1


