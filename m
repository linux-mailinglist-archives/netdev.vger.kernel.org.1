Return-Path: <netdev+bounces-111140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16CD93002E
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 20:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094891C213A8
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F2A1779B8;
	Fri, 12 Jul 2024 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjkvxCDn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D799D1779B1
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807631; cv=none; b=bVue3Zu+sSvzAaKtVf1tjDzlRIUh93wXmcW6k3C4tnTVDK5FN0BNXYPthggymwgF5zp582PdEsT6IhCwjv7I6j2Qk2TwzH+AcrTURseB6wtlSr6sXJXjz4ogCCp2v/lWpTPQabWI12LIz6tJAW9lGqE4L2qVhRzRX/vJYejlhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807631; c=relaxed/simple;
	bh=7StgXDt3Bfj8YypYQ53JnodI6Mkg/jFSULezrQfBVyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2CvDg6ENHTOfs5PQKaEICdwR2Vruruz+pPrCVzRKU7sgGHoMuD2mfUVnCidUhIJUuUSM4yu/RXjSKVzknd+sIumLiXfC+kfaTx6/dWPlvHG2GOjOorCLFYKT1990jIUPUgqy9rfeTq4qoU9Mdlhh2eIqcR8r/SCuBR49oNeTrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjkvxCDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138C4C4AF0C;
	Fri, 12 Jul 2024 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720807631;
	bh=7StgXDt3Bfj8YypYQ53JnodI6Mkg/jFSULezrQfBVyU=;
	h=From:To:Cc:Subject:Date:From;
	b=SjkvxCDnStsI55/U2mR52PuC0PaFJEq5LpnJ6djyC8PbSRCW/XakY4AckCRWQaV2c
	 Ukcp+OM/bQrRP86cPlAOnOitb2LNq1alh2tprtOnDNvAvpuSRK0kWiwqS5nfXuYEbt
	 0EILkwssGCDFywOD4sXZKKgF/cMk4lpxeOWUnd5UUEJxfuxAjO1WyGPqawkyZbU2oE
	 KaFf7NxV4ea8N9VWdkTpwrlE8S3X45j8LwSFA9U9oLrdg/D7J4dOSaFBYOXQcZC1yC
	 jVZsjWNLdjQfY24YyTYOZ8si+y3VENHf5PExYQ3yNvxqKDP3bXt7YveKpf5HNNlroR
	 PB6oEMpuHFAgA==
From: Jakub Kicinski <kuba@kernel.org>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>,
	idosch@nvidia.com,
	danieller@nvidia.com
Subject: [PATCH ethtool-next] module-eeprom: treat zero arguments like any other arguments for hex dump
Date: Fri, 12 Jul 2024 11:07:06 -0700
Message-ID: <20240712180706.466124-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code does not differentiate between user asking for page 0 and
page not being set on the CLI at all. This is problematic because
drivers don't support old type of dumping for newer module types.
For example trying to hex dump EEPROM of a QSFP-DD on mlx5 gives
us in kernel logs:

  mlx5_query_module_eeprom[...]: Module ID not recognized: 0x18

We can dump all the non-zero pages, and without "hex on" ethtool
also uses the page-aware API to get the information it will print.
But hex dumping page 0 is not possible.

Instead of using zero / non-zero to figure out whether param was
set - add a bitmap of which params got set on command line.
The nl_param()'s dest option is not used by any other command,
so we're free to change the format.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: idosch@nvidia.com
CC: danieller@nvidia.com
---
 netlink/module-eeprom.c | 30 +++++++++++++++++++++---------
 netlink/parser.c        | 11 +++++++++--
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/netlink/module-eeprom.c b/netlink/module-eeprom.c
index fe02c5ab2b65..2b30d042c00a 100644
--- a/netlink/module-eeprom.c
+++ b/netlink/module-eeprom.c
@@ -22,6 +22,7 @@
 #define ETH_I2C_MAX_ADDRESS	0x7F
 
 struct cmd_params {
+	unsigned long present;
 	u8 dump_hex;
 	u8 dump_raw;
 	u32 offset;
@@ -31,6 +32,14 @@ struct cmd_params {
 	u32 i2c_address;
 };
 
+enum {
+	PARAM_OFFSET = 2,
+	PARAM_LENGTH,
+	PARAM_PAGE,
+	PARAM_BANK,
+	PARAM_I2C,
+};
+
 static const struct param_parser getmodule_params[] = {
 	{
 		.arg		= "hex",
@@ -44,31 +53,31 @@ static const struct param_parser getmodule_params[] = {
 		.dest_offset	= offsetof(struct cmd_params, dump_raw),
 		.min_argc	= 1,
 	},
-	{
+	[PARAM_OFFSET] = {
 		.arg		= "offset",
 		.handler	= nl_parse_direct_u32,
 		.dest_offset	= offsetof(struct cmd_params, offset),
 		.min_argc	= 1,
 	},
-	{
+	[PARAM_LENGTH] = {
 		.arg		= "length",
 		.handler	= nl_parse_direct_u32,
 		.dest_offset	= offsetof(struct cmd_params, length),
 		.min_argc	= 1,
 	},
-	{
+	[PARAM_PAGE] = {
 		.arg		= "page",
 		.handler	= nl_parse_direct_u32,
 		.dest_offset	= offsetof(struct cmd_params, page),
 		.min_argc	= 1,
 	},
-	{
+	[PARAM_BANK] = {
 		.arg		= "bank",
 		.handler	= nl_parse_direct_u32,
 		.dest_offset	= offsetof(struct cmd_params, bank),
 		.min_argc	= 1,
 	},
-	{
+	[PARAM_I2C] = {
 		.arg		= "i2c",
 		.handler	= nl_parse_direct_u32,
 		.dest_offset	= offsetof(struct cmd_params, i2c_address),
@@ -267,15 +276,18 @@ int nl_getmodule(struct cmd_context *ctx)
 	 * ioctl. Netlink can only request specific pages.
 	 */
 	if ((getmodule_cmd_params.dump_hex || getmodule_cmd_params.dump_raw) &&
-	    !getmodule_cmd_params.page && !getmodule_cmd_params.bank &&
-	    !getmodule_cmd_params.i2c_address) {
+	    !(getmodule_cmd_params.present & (1 << PARAM_PAGE |
+					      1 << PARAM_BANK |
+					      1 << PARAM_I2C))) {
 		nlctx->ioctl_fallback = true;
 		return -EOPNOTSUPP;
 	}
 
 #ifdef ETHTOOL_ENABLE_PRETTY_DUMP
-	if (getmodule_cmd_params.page || getmodule_cmd_params.bank ||
-	    getmodule_cmd_params.offset || getmodule_cmd_params.length)
+	if (getmodule_cmd_params.present & (1 << PARAM_PAGE |
+					    1 << PARAM_BANK |
+					    1 << PARAM_OFFSET |
+					    1 << PARAM_LENGTH))
 #endif
 		getmodule_cmd_params.dump_hex = true;
 
diff --git a/netlink/parser.c b/netlink/parser.c
index 6f863610a490..cd32752a9ddb 100644
--- a/netlink/parser.c
+++ b/netlink/parser.c
@@ -996,7 +996,7 @@ static void tmp_buff_destroy(struct tmp_buff *head)
  *               and their handlers; the array must be terminated by null
  *               element {}
  * @dest:        optional destination to copy parsed data to (at
- *               param_parser::offset)
+ *               param_parser::offset); buffer should start with presence bitmap
  * @group_style: defines if identifiers in .group represent separate messages,
  *               nested attributes or are not allowed
  * @msgbuffs:    (only used for @group_style = PARSER_GROUP_MSG) array to store
@@ -1096,7 +1096,14 @@ int nl_parser(struct nl_context *nlctx, const struct param_parser *params,
 			buff = tmp_buff_find(buffs, parser->group);
 		msgbuff = buff ? buff->msgbuff : &nlsk->msgbuff;
 
-		param_dest = dest ? ((char *)dest + parser->dest_offset) : NULL;
+		if (dest) {
+			unsigned long index = parser - params;
+
+			param_dest = ((char *)dest + parser->dest_offset);
+			set_bit(index, (unsigned long *)dest);
+		} else {
+			param_dest = NULL;
+		}
 		ret = parser->handler(nlctx, parser->type, parser->handler_data,
 				      msgbuff, param_dest);
 		if (ret < 0)
-- 
2.45.2


