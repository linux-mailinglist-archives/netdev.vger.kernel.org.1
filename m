Return-Path: <netdev+bounces-68714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117A8847A78
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 21:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB636284912
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA5F8062D;
	Fri,  2 Feb 2024 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+Y9F7P4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344028062A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905535; cv=none; b=qtgTRbhuGFC6mZQ/K/cDUtoSCh1KB5K3v0DfVnoXrBrjVdaGgV0x/ecEAKRowplysJXA1p17fqzzx/EsbpLdJdKcELjB64bC5XCc/iZM86l9uoGKOH3iZnJ+Y8JsFkHwg0PJpyH/VxUQV0SgTrYr+CU3b7waHX/Az6u2UsxxODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905535; c=relaxed/simple;
	bh=VeuU1gtpMHD6R4y3QskCdXixRRQG76sqQMFIwVjNW8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ueDe7gZyGin6GwUSf0DWB5gzmg9/HJl6l9tuMs3e6/dhEJZSXeLOuD/RwOkhNwWn/Lq5MwaLvgE0jCrD9eVq80UxLKpDPaDMEaz6pePVuNmyds9uh1drWlDmby6be7O7dkSmhO8od1HS3tcquoLa0MruSeDhPpTWQbtAdw+s3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+Y9F7P4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706905533; x=1738441533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VeuU1gtpMHD6R4y3QskCdXixRRQG76sqQMFIwVjNW8o=;
  b=N+Y9F7P4X5vN0yMsUJUBXbOaZboVinGE8tstRUzH5LIKlDV58RNXcvPo
   N204bI7E5beaJii1v+qP8a1LF/54cAGCFq+jrwwGzepwbv5nGqbVSG0IG
   cHHca2KxEiQbKtT+T1kE8mRD0G9NuRu0UoUQFGmeeivZHaiCZxmUmzitL
   tBhHNzmcooIuQRA8zr+xjaH97fPpFmTe+jQpGm/y1WoMSkCicvAKny6ex
   wzroaHp8qM5+rb5+ovB5nqb+iaMhLpPEidmGoO0OJyeIlKag3FpmScVqD
   zjUEl2SwZLQ+85MfQyuZc9YmCq+KWScY3k+BY/Gh6WeFB+91GXpj1GL8n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10885086"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="10885086"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 12:25:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="489194"
Received: from apalla-mobl2.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.249.41.168])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 12:25:27 -0800
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
Subject: [PATCH ethtool v2] ethtool: add support for RSS input transformation
Date: Fri,  2 Feb 2024 13:25:20 -0700
Message-Id: <20240202202520.70162-1-ahmed.zaki@intel.com>
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
v2: add a note in the man page on the loss of entropy due to XORing.

 ethtool.8.in  | 14 ++++++++++++++
 ethtool.c     | 16 ++++++++++++++++
 netlink/rss.c | 19 +++++++++++++++++--
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 7a3080f..5924b8d 100644
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
@@ -1201,6 +1202,19 @@ even if a nibble is zero.
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
+destination fields are swapped (i.e. Symmetric RSS). Note that XORing the
+input parameters reduces the entropy of the input set and the hash algorithm
+could potentially be exploited. Switch off (default) by
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


