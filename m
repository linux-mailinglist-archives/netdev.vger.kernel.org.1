Return-Path: <netdev+bounces-291300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAXxIng5FGorLAcAu9opvQ
	(envelope-from <netdev+bounces-291300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:58:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF375CA360
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B485300F13F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1671137F8A6;
	Mon, 25 May 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ixl0emmZ"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D737FF65
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710298; cv=fail; b=idWRn1vSfdccqYQLL+3JuH8xqOFU/BC2WHaigzHJCItEXrKU9ZLuBrgDYfYOlKnr8kVsuU2S+ubFYbl6+4LYhtQ4/r8pVxYsBw0BkCDcDVGt3PFRRNvXK9B+CTv7Ky+EUD/9JxrbN/MepjHytZSUuQScWCO7G4rHSA63lt02OLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710298; c=relaxed/simple;
	bh=JrngMcReOeMDJm+1j8pVqDE5Rg7706m5JGEDSUt6BpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVMJ4eUpRPd1mamx13rzXfR2HQaM9C0HoK/VFNrsSPbB/1gyOK7T0uw2qRJg2SrmIAyQbht6D9+77/IfgNMWUqr67oipmoidhlXnv9m2nXlt/7f5SHnS7BtKrThib4qtawxpbvFPH635uZAtt6MT/rQXEGASjNP8eFcC3oCCNQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ixl0emmZ; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXnbiCm80ecBq96rBHocEULlQWgYl5IbkcTUmUqO8hcDWu8uEfPDdjyfODRSFXdTM4wdVpq3tReeugRDtJqG3YXQ5sYecueyR6g26mH0PKeE0UH0rNkV2yoNVpvVKuCjcyTfJ92dc9YW4SXFYH3MsgVEt5OSf5052dp/h831tEHLUwgwjFDH3tzcAts3RjuIj4dcB6k6nmGvpLORlxuvvm3ZygaWfqKPASpL+L6kO6JPwXHqGP01qcue03Uy3WFDng1z5zNzEfutnLWWmiAClK9LySHxOBNDVlWOfxib7vEVLwirBz2oWsihzACaOnOgSgtMzlA2xcwv0G77oSxS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9cIj7UZsR+p1SyV+UROduSAeKnVvf82KOYZLZBEoLc=;
 b=YFTyfHSGQYfwrDwxzmpRGps6H4Yr6hZjUWOajl4gynnE05RqL8Ku/ZNhQsh6qZin++3yO5awe0qe19vuPX2Oihi6yKQ7EP/hyyrrmF46VRyiFMW6x/GPvmrO2202YmmI1exilJVOelMb8Jz+ZKX6fBYu5JSKPmUPp+keWytfa4CvuqZjFbw52uFyJoc5DHjpXoLZKjJuhuO5w+BydSUWICE4PJUICvFMQE5vzrZziArBAqiXzY9nimV7UvwA16esF/t91p1whDrEAqQIhGtaZlhMD2Jq5DpuGWjRZSzSvoPjTlONfHlF2mgIcvcg6Uzyt4wt+ZujL4LVw6zS38vb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9cIj7UZsR+p1SyV+UROduSAeKnVvf82KOYZLZBEoLc=;
 b=ixl0emmZxdYf3IBXkcxEDldaP9qaA8Tlvxpirn+G3xyxhku/NJnNiS4I4bPyRwTF91eZIvKSGrSFUwlFY/QSigcgdGu/gzC8HQW79lEJu7mDIyaRqREvOIHZdo1Vnx64CsWqRH9oTVYoONsA4XtRgef2GZK7pc2zcuGGY/pyovN2SrJMdksToiz2RaGNDkgMauuIFrsvPujzhTu2Kc2TfALkJJ1DwZgoMdiNHlO+/fd1NQUx6CUqMNU1fj4tkZW18zsZ7zF0qEo/qwgrt+/BJyHu6ug53i49Vglo9FQN8+kkj2HxFtkBfbniQsoTWiY2k3kY6oNQue3WWap/t+QRqg==
Received: from BN9PR03CA0525.namprd03.prod.outlook.com (2603:10b6:408:131::20)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:58:11 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::55) by BN9PR03CA0525.outlook.office365.com
 (2603:10b6:408:131::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 11:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 25 May 2026 11:58:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 04:57:55 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 25 May 2026 04:57:53 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 2/5] sfpid: Refactor sff8079_show_all_nl() to separate page retrieval from display
Date: Mon, 25 May 2026 14:57:31 +0300
Message-ID: <98f3ca2fcb4a89baecb1773892f02591efd5672b.1779694603.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779694603.git.danieller@nvidia.com>
References: <cover.1779694603.git.danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: c5efe33b-0fae-476e-46fa-08deba54e52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|6133799003|11063799006|3023799007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	drsTcsemhZ4F1e9bDZYcdbklx0BlebJOSGIB+9fdXKgAUhp3bqlA9H58+lhKYmn521rkBXieJpUjLqEWZ9fig0liDR5clPcuMvjUb4XtRS+/Qy0gcs7EoSJB/YviACw1JBiOCqWmZWhmCxkgXdr5DHjU+EsivVqJZVS1+VTb+/5eEs7B7okDVtjxfbQgJqOPvR5cnU2hmluI9HPkZYIUnKNFLUhN+hmx6y/pE+IrP9StVhx+Rrn1YbH4vijScJCdZw3Dsup0Bafgh4W8ITzHEqA4EDvBqRy+iV1D31+PZ7xVsFp56zQyuXj3plheVrAF4l4a+3UxspHT0RJLP5xjZisyS00lto70hTQQ4Ubm4YVvKCbzVcOolHjQVqg2230kTPvMqdXWwjD+zOIbcEacpRS0RRIF/VCl+tnxl6U9F8suiP0E9XuoqkkYCAMdJMaU7xLw7WuPvct3hjCjSoTqMZblgwF/8CxBeaeq2XZ2W0iUMHIKuTAYAo8cPS3gWxgYBBBKak7cwmjtSxmaApB7cXFBhRNFiqMyFSzgjgQKcLHTNKqoYlitEBUIj6HR6hPVeBgldx9B8pdZANTORETbvb1bXcaypcqHm89gVb5ELsfPQFyI6cxPyr3M1tkKgZX/B/nEGUZN1K/5THjhLojBGUSsGi7FmedugJCf5wslw6y9BLlA4etr1GawSVA5Dy64t4F/calSiJ1EurIvk12gS0yMyPUIYTb9l9cwlvXdT9c=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(6133799003)(11063799006)(3023799007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LGqunrtujRGgz4FC3xFhXEo0RhepZi27tkrHn/o/eCNeDRZjMuSDuRhwl70Q0WcqRcv5awN2I7QapZskwC93vma8XojyzhDrM463AHoSUVTszpxrOlcKEJ0ZbzgzNXipbsYzENyB8N2AUUi8pgCIWiirj3n8Yn4VjIL9exTMe3QLwErzNbCgI4inSu/WLNGK3MjPm0U51FocK9fyuf9u0NyxT9kZkGuR9Su9/4ymMBo7ptcO0IzeDJX9dfHKsaHg37wCSV6WBlWITXHEGahNA7V8GcxjYlX41W4SvWN0HawRA55FvN95Usap4U9JqnXL7hPZ99mRzbAbEXg/MuObktxm5XFT7QTEcfigoPlLIauKfT3W6yiYbsu6Fiqpb+sxIy/aobTQ2UW70aSMOvC6q6gOz2B1ViXz99vDqdiEKfqYeclW0RtAPPJEJY2V6fvg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:58:11.6220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5efe33b-0fae-476e-46fa-08deba54e52d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291300-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DFF375CA360
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


