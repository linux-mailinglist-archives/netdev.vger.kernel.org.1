Return-Path: <netdev+bounces-291298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Zw8pBlk5FGorLAcAu9opvQ
	(envelope-from <netdev+bounces-291298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:58:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 482B45CA343
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73EC23008769
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B81B37F754;
	Mon, 25 May 2026 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O8wjKByp"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118731F999
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710293; cv=fail; b=SUBsayFhbrpRFUPIx7jLIS3mp1HYtLeul3ZWtGJUT32FRW/vsWysHd32ArQoetaItB3w84uD2S6WlQvfXif1mHJ8phxdT54HL1Jb40djm7wZ8mbnDfc5fUB4vEaX+hg3kcW3Xwy6prNZYAAEVbcfa+U6MmqKlXVksbUg99G/BfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710293; c=relaxed/simple;
	bh=KYPTqNn2wM6FNt7gyp7bpu2CUtmjzYMaS2ZSVI2Y3t0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RneI1feR8uIWlcpAtZonAOUxkb965i+QI3kzi7+/vt8oKUl+08tbO6Pg27/N+l3eeiMIztLAbgCxpxbNOC+ClIaDjxFSbBuSiUoYO3YnzMsSEautqapkV87lR4UAHa0LjeVFbS9iQZnu8dJhARMdIR/n4VML988axzwzQ2zmyso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O8wjKByp; arc=fail smtp.client-ip=40.93.194.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdvvdmaVGOHZPM8+CixrS5DnBbXktEkMkwGj9U9GFiVPTz4TQPTtpUS+fdyodhkqfSBIW22IliH5qrWafRZ/W4flw/0l4KPADVR8FljcPTXdwjk2YN5ipYtfDkirkaDxvVO9SftqKqiTKkl/VM/xVhjC3iJtXFPMWN2jxMEbaSnfItDTuGJndZj2ZWygMdNd33uZEAl/keQMYxOxXaoEWeCvLwWlmpT/XSg527kRRTUcIPCJS8fWGMRQJgr69n0OmP60PGM7bVUMpVYeKOycCNHT8461MpVwHvq3vPkyXQ5dmDV2Y1ACCnkOerqMpVyN5vc0djv5qjvVQ1le/jQ82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mECO5mRB7SuJQYUxcOl/vIR0Gy7tFWjC50Pg+74dxRw=;
 b=kRB+mEsxesHcg/culCDbCEtLnvMC7p58wDxA7ayJkL8B7fSXRiqWz6ysHyhePwLerp1qhVWgwYL2iiU7EExgVl25lY13YpaTPrAa24llgjBn3CSGwMBScg55ibavQlINtDXUqZyh2an+c+rJrr/TmHOjM3xmVwja8jgSnHkN81TTGtU3xONdRnOSJmvm0scdi6Nf6kLNH1q5HFCh0cukwvjDagYlUpJTL+MSniFUO79I5Gw4Iu421PfTlSkByLA1jk16Lam3tPUhAqsBeBKmeEnboklqbsn4/M437xsSCyUrSZUqMefwpBN8koUj3woYCGtusX7fvkHA7ujdHJIbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mECO5mRB7SuJQYUxcOl/vIR0Gy7tFWjC50Pg+74dxRw=;
 b=O8wjKBypZ7haA4vZxDD7bbSdnDDifwx+H4i993GRVsL8hB+/dcvX8p2u5F0KVOtxCjutzh0bq8TmBTrX3rEhO/RTbHdLFcPpPUP9l1ONBq+aT885G6cUt1MpIspe1CFu9/K7vfYNzf02dkzhqsZvxC15Ejgt2dypQJFRp2WJ0P2W4holo7n/WD4Okl2VWaQTg04nd9fsq/x8ERqvy4e5pw+y0+a9ugDzTzP/ZFLV6i43IoyIBte8GoBJtGPT2RZucdpHXKCqPAXSX7eImtH8OjHWNucSqb4/KHq5Kf2z9L2VYBiSShsrbIevGpp4PxyBv9eQYoxYdJh34EGij3t2aA==
Received: from SN6PR04CA0107.namprd04.prod.outlook.com (2603:10b6:805:f2::48)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:58:06 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:805:f2:cafe::97) by SN6PR04CA0107.outlook.office365.com
 (2603:10b6:805:f2::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 11:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 11:58:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 04:57:53 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 25 May 2026 04:57:51 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 1/5] module-common: Add module_dump_eeprom_hex() helper
Date: Mon, 25 May 2026 14:57:30 +0300
Message-ID: <6d9164817eadb4e8becfef7833f4067efb29f94f.1779694603.git.danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: ca69d805-2d22-4f59-e4de-08deba54e238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|11063799006|3023799007|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	iTGOubo7qniOYDpZUyzNtr9COmjmFKp5OpHOKhMj0wjvgnP/ZPAk8awEj1fMTGW4FPdgyKXKWBuOPvuxlCUxTTUhwhS/xR8DWxuIl2ONqkqWigrXGNnMzY10KrJ4y7MZeKi+k0FtW43o1940mLEaM2OlrJAe18jCZVhyCoVUJaq8qeofT5ur99toWgwmC8QYAOY64Ho0w2oACzDiIGxlEHbfQ4qp+lq3+PUSwSpK8ViUrCP3Vioz/AiYzupIekj5FfU9eg+wm+Rsp/U2D8muD/DZVWmNHRpC8QS4Tz1wzU/z532g44WU6bSeu/McwUnMfudapS46btZpbSS5VN3m3jn+G2zi+pr5Vv7lTmnbkuYVU5g0TxfhPbbKUMO+YSLn4dRbf7M463Mqb5FbTFNXs+obs0UuzLbISCUSyxO54gG7ENvWDMAYj1cIOXkvvo9owojSoprkSZNSvETbl8xAXka3CqjazJJOVHsxUbzEakWtmuzEzLcqBl5BBxifhjXhjixp6zJjfTAqrrIrXX7ur2J9nnfsPvQ27/UUIs7DKxS53wHmHk5I9z+76BukLpLe8oa3WLrOe/P+EFe5d2uZstp7PJHvEOEaa79LO0jb8993MPb6pcCBiZqCOA6dCUuEwMEHceCBolal4hpOF8Iw4xqk640vDD4+LEurJomKjzSm5qOhwxOGjD3dMwoLln/Vql+2ce8KXyMWNGurSdqgwI/WETQVtAVzegKDo2lbfFg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(11063799006)(3023799007)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ULakp463u0aKV77/SsfI/Sv8EtKhQSx+ecTpH6A73/U+p2CRGhB5zUmYYlGiHlldMdHmQtXo2EE36Ifx4FA0l+rq6nQVARvyD9xlCDVCJj9cSbITy5BscrIYXr/h1XfI54sJY5Ug+kXwaP967ffpdE5dWe0RP4F4Yg8UFVZZFCg3uk3hHw8DXESo72lL6cGn8xjdKatKCvuzQnhAAbjJnLzt011cTFNq0Ve9U0vgOoCJ+iS8fyYxiH+PyI0ugiSFigmn17vq/jkVYNh9PwCDdqIdcWEqTGMg+SuAwTRFk//1AY+qLP93LDvaQBSkpOquUWTMUbRIbf4KZPckIoGJo79qWQPJ/Ow5wZlB8FOow30A4hyuduacGdAhPlPEvid6rKbCfYSozhqT5ecGjsBcLJqqHEnEvXvTnzqkB07vXHHTDdJk9oe8QK/5+6lc5Bj5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:58:06.7235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca69d805-2d22-4f59-e4de-08deba54e238
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291298-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 482B45CA343
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add module_dump_eeprom_hex() as the shared building block for the
per-type EEPROM page hex dump functions added in the next patch. It
prints a per-page header followed by a hex dump; the header format is
selected by print_i2c / print_bank flags in struct module_eeprom_dump.

In JSON context, the flags are ignored and all metadata fields are
emitted as one object inside the enclosing "pages" array.

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v3:
    	* Drop "length" from JSON output as it equals the length of the
    	  "data" array.
    
    v2:
    	* Add JSON output support. The helper now takes a struct
    	  module_eeprom_dump containing print_bank and print_i2c flags
    	  that select which header fields are printed; in JSON context
    	  all fields are emitted unconditionally.

 module-common.c | 36 ++++++++++++++++++++++++++++++++++++
 module-common.h | 12 ++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/module-common.c b/module-common.c
index 4e9a0a7..42fccf6 100644
--- a/module-common.c
+++ b/module-common.c
@@ -656,3 +656,39 @@ void module_show_dom_mod_lvl_monitors(const struct sff_diags *sd)
 	PRINT_VCC_ALL("Module voltage", "module_voltage_measurement",
 		      sd->sfp_voltage[MCURR]);
 }
+
+/* Print one EEPROM memory block with a descriptive header followed by hex
+ * dump. The header is selected by the dump->print_i2c and dump->print_bank
+ * flags: "Page: 0xN" is always printed, an I2C-addressed block prints
+ * "I2C Address: 0xN" and a banked page prints "Bank: 0xN".
+ *
+ * In JSON context, all fields (bank, page, offset, i2c_address) are emitted
+ * unconditionally as a JSON object inside the enclosing "pages" array.
+ */
+void module_dump_eeprom_hex(const struct module_eeprom_dump *dump)
+{
+	u32 i;
+
+	if (is_json_context()) {
+		open_json_object(NULL);
+		print_uint(PRINT_JSON, "bank", "%u", dump->bank);
+		print_uint(PRINT_JSON, "page", "%u", dump->page);
+		print_uint(PRINT_JSON, "offset", "%u", dump->offset);
+		print_uint(PRINT_JSON, "i2c_address", "%u", dump->i2c_address);
+		open_json_array("data", "");
+		for (i = 0; i < dump->length; i++)
+			print_hex(PRINT_JSON, NULL, "%02x", dump->data[i]);
+		close_json_array("");
+		close_json_object();
+		return;
+	}
+
+	if (dump->print_i2c)
+		printf("I2C Address: 0x%02x\n", dump->i2c_address);
+	if (dump->print_bank)
+		printf("Bank: 0x%x\n", dump->bank);
+	printf("Page: 0x%x\n\n", dump->page);
+
+	dump_hex(stdout, dump->data, dump->length, dump->offset);
+	printf("\n");
+}
diff --git a/module-common.h b/module-common.h
index 985b518..4063448 100644
--- a/module-common.h
+++ b/module-common.h
@@ -261,6 +261,17 @@ struct module_aw_chan {
 	__u8 adver_value;	/* Supported if (offset & value) != 0. */
 };
 
+struct module_eeprom_dump {
+	u32 offset;
+	u32 length;
+	u8 page;
+	u8 bank;
+	u8 i2c_address;
+	bool print_bank;
+	bool print_i2c;
+	const u8 *data;
+};
+
 extern const struct module_aw_mod module_aw_mod_flags[];
 extern const struct module_aw_chan module_aw_chan_flags[];
 
@@ -283,5 +294,6 @@ void module_show_identifier(const __u8 *id, int id_offset);
 void module_show_connector(const __u8 *id, int ctor_offset);
 void module_show_mit_compliance(u16 value);
 void module_show_dom_mod_lvl_monitors(const struct sff_diags *sd);
+void module_dump_eeprom_hex(const struct module_eeprom_dump *dump);
 
 #endif /* MODULE_COMMON_H__ */
-- 
2.51.0


