Return-Path: <netdev+bounces-289449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A7PAZhaDGodfwUAu9opvQ
	(envelope-from <netdev+bounces-289449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:42:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A2057EE34
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9758030B386F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC164DB56F;
	Tue, 19 May 2026 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cMiVRYdM"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF622DC767
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194268; cv=fail; b=PeXEiwmUqT8yYewEbHAoO1AmzIweFLHrxi1kQX3fOzj6/EgW0/tp+XYoj2XUHPKl3yihI+khGmnbJqosg7/aZNu7pWYkv804vu+rLZOk2agr6wRVKjFvYZKQ/oFOfOPPERWMcJXF9K8Y5E/vPZxwQliWDtU0OqYEHX4HJiQxpT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194268; c=relaxed/simple;
	bh=JrngMcReOeMDJm+1j8pVqDE5Rg7706m5JGEDSUt6BpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SP15CzgSI1Y2a3DcV+YtgvxFDLihzSrpNwfPS2ijZ2xi0qnuaMbsKfB+c36Q+yIjkBJ3KVIEGnt7pDGoW/t2T9hjNLoyjRTbnI+ayXCSyX90Jg5QaLv7DAjlwKi7jmp4Kw4GKYTV0Y7JraCTlJM2Rhu38oIOL9Vw3VgOvyNwPKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cMiVRYdM; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvDT0i7YSr75E12OqtypkDtLDNDeSA90EUJZL4AaF0Hi/UNSvmWjBygOeSnNDTGrcKEGpEAks9dAQvYza0iiu7LRwNqmnxXoQHN1SYpPu3viX6jDqY0LjwcOphjlDsW3TkdPXCf5TmOnqg/G4GqpRcBeO4XAuWX6JTz6fvFLBTJt0iT8cGkDK6Jqw8nbqFRNNSgddIOdH3tGbCs9IneRV4iNaGcuEdUjDFOhBv7RQ/bAZF5Tvz7dFisHAEJVejargxTfsOAgNaxp5g5pHCBH5RniUf7mStWRRcUAD15KBtpTvNqDT98ouusUhVEQ15/XN8ELWuDQ2M+vgEY4IRJUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9cIj7UZsR+p1SyV+UROduSAeKnVvf82KOYZLZBEoLc=;
 b=itHvzIfbcJWuBlMgTmvsSvkjhJxOxjqlN/658+SuOjDazlY5c8LyBWDTB5uexYfJzq9AUIlzh5O0Rk/pfbTGfcDDJcekh2hWrCU4Yk0x2ewQX9CuyhTaQWILSF1Pvxd50PuY+oEtZ852SrpRJlG/yjD+BAA0nDpRmZNiIVMYMyvso9sca0SZnmbkEc8UBazhrB7ELVbxGOLyOpznTbSaLh+Vy4NVgbJCURA2j043jK3knUszXn7T5mUndHntS+exdy9xGiyTLjpkQrKrbttCTOF6Wzb/IT/DWgKghMgZE3zpmmPctPmoSBXeESvT3To9chwlXt6PTDFq0bg7jbgd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9cIj7UZsR+p1SyV+UROduSAeKnVvf82KOYZLZBEoLc=;
 b=cMiVRYdMJEyIbF//KTsi9z7atCqn2/4Xt8Q79q5DnrVA6R30k2fENIPg90pAFDl7CwowOlcgBgrYNinRRkoheDWEiUrnjs2LDTN1meBcmTc6ohBX3LliZk6soKJAmjaknHnSaqaN5LDmk1UlOr/rtxoc83IGiTDML7JLrRh5F5JCh/FGOX88a1S+ml7BLR+HR6bkF6vqyFy4x3D3LOmQ98HmKBCFPn0K0hjB9w/IQpgHU3kJGNX6HWvry0ORpc8dSd0dWVIkMGd4yK28oJAwdDqtu1sUyAU4Kp99Dvn4v7BVkxElU5+MhHs7/qyzoe7OBGybHQmc4sQH9Rbd6ykDvw==
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 12:37:40 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::68) by MW4PR04CA0302.outlook.office365.com
 (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 12:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 12:37:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 05:37:22 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 19 May 2026 05:37:19 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 2/5] sfpid: Refactor sff8079_show_all_nl() to separate page retrieval from display
Date: Tue, 19 May 2026 15:36:59 +0300
Message-ID: <2ed94861ad30f87be22f5933fc6a67f4cf9537ea.1779190777.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779190777.git.danieller@nvidia.com>
References: <cover.1779190777.git.danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b0f00a-86b3-43d0-8511-08deb5a36ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003|11063799006|3023799003;
X-Microsoft-Antispam-Message-Info:
	rv7/aI/rIv1yMpyowMczHQRigTyXGZoDQKSTC/Iftmi0auCpsS6UjtAgUh6Vq/MapqJ3KDjXz4RRKR6D/aeo2Qxy4ba4TTZMSS04PQyhhQEoPFLdNzy+hJHApZAYTRDmv7RtNzPOsRaAcnuQhAm5OOMN9bKmnzDeG56PRsAHW25Hb15ZywKMbt6IUo/ovjqqUzzLIPvxfs9tmTIyaZkWmnumvWcawnjZx/rlLPnjWKDbFICydfKz/mpr21rQAGut/lE6wproUD8+VCgpSOlTsIyawQ+DhxGJBw4Jz2Y69R9405ArOAujH9a5x5SfvZdgABQ60doYObkcGVdiZMkuA3Uh/iJgRAFqLGiqEU2RpUeUzOZJI+vAzgPP6ePiz3fU1s0oZ+FJtxCKH4usb7wyyxhiAPafytFVUEDyLJNU37Es4FqOlKk5VDighGTDIgU1WRZjHPEHn08u8WVPbFzG2jNxnSTi5Ea2o7LRFDT1aO/t4MMr09zHQVh2lc9UAHXcxCuOFyEM0Q6MwP/KvESMUa/bgrP2ty/3ZGTYgHEUpEw2e1yAl2sCCI5aB2byM2Y12lKQHwTaAwj8UIAHXHqhPPRzjJy480kKH5QfRcJmONAhrmXrbTaTE0CIgL718S3VFmQNVZe7KZu9kURDqafqfHItX9tnSn+B3Bf9LhP6fk5QeFMmopCx4kGMmcMawmS4pNrUMvfZoOVDxMo1NzQAVRqBjVXd4du/9fr6X7NHc6Y=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+YIQNHmzPINIruZFpY93Y+zZ5AHYK3wEmCm+lPOsPUfV/p3IypC1EVsuMzT+frEnNwwxZVUFmWfKftqmzM07ARWGh64rF1yA3FLhNyj6or2BZLk244SmoD144iUy6NH397BlXMaWglBwfgriKTRdwtY/erUpyISvJ4ztoa1APnR04eRbLOksl1q6zacE50xn2gAMpsslHGF5Rrzdi1ZrdEOdbqU3lCJYgQklkgL3KlQBVfFcn0sHZhGMncrwIXKRm3NsyLWHyl1PtmAugOnH1xOExR5ypWZYAhaWBCkDrIIXahIlehCAv6m4+kBcTKJYN5YYsPX+Hp+zL6ibE08BoPALSu8F78rlcmjOV+Kbq5jVmHtg8TugehbeN8j5O2AJyYnd0OcwLSRljOU19Uga5dl3SN5gGhllW5WhWTOoV0wpAPdVJciq3VojwsNMoE0B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:37:40.6274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b0f00a-86b3-43d0-8511-08deb5a36ab0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289449-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B9A2057EE34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Restructure sff8079_show_all_nl() to first retrieve all the necessary
pages (A0h and optionally A2h) and then pretty-print them, matching the
pattern already used in cmis_show_all_nl() and sff8636_show_all_nl().

This prepares for the next patch which extends the function with a hex
dump mode.

Note that if reading A2h fails, the function now returns an error
without producing partial output, matching the behavior of the other
parsers.

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 sfpid.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sfpid.c b/sfpid.c
index 228b3ee..f753917 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -500,6 +500,7 @@ static int sff8079_get_eeprom_page(struct cmd_context *ctx, u8 i2c_address,
 
 int sff8079_show_all_nl(struct cmd_context *ctx)
 {
+	bool a2h_present;
 	u8 *buf;
 	int ret;
 
@@ -516,24 +517,26 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
 	if (ret)
 		goto out;
 
+	/* Check if A2h page is present */
+	a2h_present = buf[92] & (1 << 6);
+
+	if (a2h_present) {
+		/* Read A2h page */
+		ret = sff8079_get_eeprom_page(ctx, SFF8079_I2C_ADDRESS_HIGH,
+					      buf + ETH_MODULE_SFF_8079_LEN);
+		if (ret) {
+			fprintf(stderr, "Failed to read Page A2h\n");
+			goto out;
+		}
+	}
+
 	new_json_obj(ctx->json);
 	open_json_object(NULL);
 	sff8079_show_all_common(buf);
 
-	/* Finish if A2h page is not present */
-	if (!(buf[92] & (1 << 6)))
-		goto out_json;
-
-	/* Read A2h page */
-	ret = sff8079_get_eeprom_page(ctx, SFF8079_I2C_ADDRESS_HIGH,
-				      buf + ETH_MODULE_SFF_8079_LEN);
-	if (ret) {
-		fprintf(stderr, "Failed to read Page A2h.\n");
-		goto out_json;
-	}
+	if (a2h_present)
+		sff8472_show_all(buf);
 
-	sff8472_show_all(buf);
-out_json:
 	close_json_object();
 	delete_json_obj();
 out:
-- 
2.51.0


