Return-Path: <netdev+bounces-164625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA75A2E7E1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7FD1649B8
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3711DE2A4;
	Mon, 10 Feb 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ftn0SDvj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7A1D47C7
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180061; cv=fail; b=KgIBcal8PRH300e1XF6zVTycI33pPAqlajVOzSttvvW6NWNqj3KdYFEpvsPVt1Vmy+wfNFILyr6IU/szVrFokJly2snjL+X2fMW7e1yrUUMx+1I80purE/qIKopqNrKncVQGbaFJ4+BsbD9BMBJ4IjCjNY8GW7Fm6Te2g/gnIS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180061; c=relaxed/simple;
	bh=euOLibsAGXWC1hR7WKF1037FaI4rbcm89cRDqKg2H5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koYui4DUSK6YkinDaJE0xlkSe7M/Ff+6qnsKpqucd4OVZ+WyHbOdhYJwFkH/5ZLgryK8g7wGHB8EoEtZ/O7tzkzbss1ByRptVTrfajYPRr3MT28WcloRw5alEhXAagufC+K5sVJjmzb7wZZ0G4YLfPnI/gFRPcLx+CoMpks7O5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ftn0SDvj; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjvonwxQ0c8n1M3taU0lpa68ETJhcDnIAAsFTp/BAvVMLZsNyS3fQWV3ZuJpzLKCLpYZMvkLuzKLgn81g2hOk42vfXXDth4+S5JzanWYhuOEcLKpk8bnN+x50dH3UoUVwzzd90gkNeIYQGSKJxnI85ljKEBahjYP+hGOQ84kILhQA5j/CTYs1tMJI76vVn4hvDlh8ONT7k+waZ8Z25j7Vv+Jz4F8UQtj7Sh/++ICDUHmMGnrO93Rd+IH2PkVytJJA6M/jI6XtExLoiHJKuSXU0tgOKRNM0+3cQZUF0wP4+rqZAlHehxZpWqhs3S/LTnkfntPn6XXCZJmyhH67nnFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtGAUYvpc9d6oe33bNXkavMmtg4JxzzGb7s5yp/2Agw=;
 b=GoZ7IeURIWxcoCodL+cIuG6oB8rd45tgQRiUtY7l41dRwvfCC3U+SCeWl/0SgxEzSagc33yYGUMXfqC0R0oYlKQ7PpMilGh/+17x7gSgZtYgoMfRB6SAUUO9PhbHni61j+kpAc9QxGYmPgo9mOZypIjyR6MhHStYHZQghCmFLTLyOdaCl5RapyMOXqM7QvMrqRBNqq0MmSOXYOJNGW3BDQR+X2nC2CzbHONYiPzfEyZAD6VuYnKjtw8/jotdIFWlqL7DtQP+X+6snMczYFPq4ECkiWw4Lf2dQeGM7Gqnobk2ovmqPTnZhMrzux39Gm0wmn7W36fWNtP4ZVTyhqG82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtGAUYvpc9d6oe33bNXkavMmtg4JxzzGb7s5yp/2Agw=;
 b=ftn0SDvjMB0g3foim3wti7wwScYvDS8Laz2KwHt8U56LnOACfi0DfF1TgrhfYxNPO4lW96+bSzlBz8lEA67cpuZaAW3gsX8K8njLgEwm8Ja7toj7KTfBDNVZkFtXZJBGXVxaKNS7NKWure3jhOjtlH5BsylU53rs9vW6vov64ZU69opU34yVgNYvzo+6uLwdMgLYV2w9S5ysbjqXHdoxDLq7Zc84UG0jz2wfk/KqCYigTVgQY6KiT6wuZXUVaDU64odj2TnaJqYzrZygj5tlVb4o7JHFsSISnNTbw2cJ+nIM3YucogL/C9OFVguT7f5vXSxFVZEkI4qilBNkPYn6Tw==
Received: from CH0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:610:cc::6)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Mon, 10 Feb
 2025 09:34:16 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::a5) by CH0PR03CA0061.outlook.office365.com
 (2603:10b6:610:cc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:34:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:34:04 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:34:01 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 14/16] ethtool: Enable JSON output support for SFF8079 and SFF8472 modules
Date: Mon, 10 Feb 2025 11:33:14 +0200
Message-ID: <20250210093316.1580715-15-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210093316.1580715-1-danieller@nvidia.com>
References: <20250210093316.1580715-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d230c8-e6aa-48ed-d0a1-08dd49b61690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GniRWAVbx0R9XFeKaK1C6GPq15qb7nMC42gSgkPNAU+e7VcPY0iluZ14tDn9?=
 =?us-ascii?Q?0gzhwH/IhA4mwpg8XEPe9LfPurQuIPA2AZitNcp9aBd9yCMZY/8yATOdyUEv?=
 =?us-ascii?Q?ukuW2Ul1zAYHInQqwE632ZHqI+d0nNQjF7hAc0XvyxV2sRZRjI38nZi1W/tS?=
 =?us-ascii?Q?NoVxtKhzemTmIFyvgoLmxWofAtNgmewGFFr66rnkdecKBGR+DJPQyaQYlOoc?=
 =?us-ascii?Q?DU39uF48Eq1cZYTRpmdu8UuYv+kdLVY9C8rcd5KUb3jYOkJsRpsH5xJqvMuA?=
 =?us-ascii?Q?/6ZnAxPvCK+Ap6qnqFmiZWguFOOM843igThpNFIU6h0KWNWmmvkta/bA3R0W?=
 =?us-ascii?Q?u3wT2IuFqq0osCHdx7EJj+MYGM07tIF+Kuf8u7Z5YUxcTikjvIIziqTiUpjs?=
 =?us-ascii?Q?nLIA40m44OHXMis0e0Jv56M8ujoNekVQgm/1HTxJpu3SOdu4zOJdSJE8Fbtl?=
 =?us-ascii?Q?sd5pnld7suPPOI6s0skLMl9HKgSlM/4ugXEZjTD6+xpO3qE93Hr0kXvfkwUk?=
 =?us-ascii?Q?/i4WzXIs/iReh3DPG8PoQMznfrVpu78utNLVzklBJqYOr1ZyNFo88/skvhoM?=
 =?us-ascii?Q?r/bZmCkTnDCqfWSlRRjc825Gk9oEkb8bC4hBfnNxDb4ZyfK+jWnxrwEaTpC2?=
 =?us-ascii?Q?cL4YR/VygvbT0i0pD7mncbUZLcJEpH4j/+nNsVvl1b6xaFBsUqTc4bSKFj7a?=
 =?us-ascii?Q?1f4PAfUn2RPy034W2+xqeQW0IPM7j32hA7IHna3sIoFvtLU0M3EzVDKBq+KF?=
 =?us-ascii?Q?S1LVSzwby+UDvb5eYduFlOybWq0A0812waxRW/TV9qrLtOmqPrx7IWLNPmp+?=
 =?us-ascii?Q?nrlC1jePb/e7uXVFGP9PgBBrST81VqtVDOKURTXr4Eg7yt6Ute1Xov8Lr2PT?=
 =?us-ascii?Q?7HO0KmTSWgQMW7443f02kMBFx82B5k8rXsdWhYfWLNHMD0AorzbbR/H+EDZd?=
 =?us-ascii?Q?GYnnyXQkArLxEuhZXoY42rymRfymME25UEIqETksgenmWkvdjIR25oAeYC1F?=
 =?us-ascii?Q?2DG30cKxLdOwe73s5r8THM59yErutQ7FOQgFcMDf6Q0VbzyWIf74TlTn4DtY?=
 =?us-ascii?Q?Hrxa8Eq7eHBseREtNnGbHWcuuY/1hh6fc5HtYy5iaH6kD7WeTXiu77e+A9z3?=
 =?us-ascii?Q?v2Jgb+baQBme85o+Np39kn11M68Y/a6iS5gcDh4U5lUG1oKeXxULg0fgk5FG?=
 =?us-ascii?Q?I1zWncrUyc5WZkeFtXJ1Re86R79FOeb6QtdY1S5zyitdW+NLvWwzQnUnAyaS?=
 =?us-ascii?Q?8Uuy7EUOTQV6aj7T2QVyz3ThYWGipMrEnOB0p21tYVUO2f6ZbWQGOXU8zesq?=
 =?us-ascii?Q?PGBTThwFyUYVwW+HxuelNsjO4XIhDL1Xi/YOZFQRwbsC80eCXkLWPtOcraZk?=
 =?us-ascii?Q?88vyQMC+APX34xpK7wxZSOGRHjC5lcTOrqqVE1SK+jpE4HbF0VexRNDIX62o?=
 =?us-ascii?Q?BtSClqEeXLdsCvZBIQevaLIkfKYYZ0pp3rhM7mA4M3qE2GMNdFjeHExR2WOH?=
 =?us-ascii?Q?bIr3fpQz6P2u/bI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:34:16.6380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d230c8-e6aa-48ed-d0a1-08dd49b61690
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383

 A sample output:

$ ethtool --json -m swp1
[ {
        "identifier": 3,
        "identifier_description": "SFP",
        "extended_identifier": 4,
        "extended_identifier_description": "GBIC/SFP defined by 2-wire
interface ID",
        "connector": 33,
        "connector_description": "Copper pigtail",
        "transceiver_codes": [ 1,0,0,4,0,4,128,213,0 ],
        "transceiver_type": "FC: 100 MBytes/sec",
        "encoding": 0,
        "encoding_description": "unspecified",
        "br_nominal": 10300,
        "rate_identifier": 0,
        "rate_identifier_description": "unspecified",
        "length_(smf)": 0,
        "length_(om2)": 0,
        "length_(om1)": 0,
        "length_(copper_or_active_cable)": 2,
        "length_(om3)": 0,
        "passive_cu_cmplnce.": 1,
        "passive_cu_cmplnce._description": "SFF-8431 appendix E
[SFF-8472 rev10.4 only]",
        "vendor_name": "Mellanox",
        "vendor_oui": [ 0,2,201 ],
        "vendor_pn": "MC2309130-002",
        "vendor_rev": "A2",
        "option_values": [ 0,0 ],
        "br_margin_max": 0,
        "br_margin_min": 0,
        "vendor_sn": "MT1146VS00060",
        "date_code": "111110"
} ]

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---

Notes:
    v3:
    	* Enable JSON output support for SFF8079.
    	* Reword commit message.

 ethtool.c | 4 ++++
 sfpid.c   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/ethtool.c b/ethtool.c
index 0b876e8..8a81001 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5007,6 +5007,8 @@ static int do_getmodule(struct cmd_context *ctx)
 		    (eeprom->len != modinfo.eeprom_len)) {
 			geeprom_dump_hex = 1;
 		} else if (!geeprom_dump_hex) {
+			new_json_obj(ctx->json);
+			open_json_object(NULL);
 			switch (modinfo.type) {
 #ifdef ETHTOOL_ENABLE_PRETTY_DUMP
 			case ETH_MODULE_SFF_8079:
@@ -5026,6 +5028,8 @@ static int do_getmodule(struct cmd_context *ctx)
 				geeprom_dump_hex = 1;
 				break;
 			}
+			close_json_object();
+			delete_json_obj();
 		}
 		if (geeprom_dump_hex)
 			dump_hex(stdout, eeprom->data,
diff --git a/sfpid.c b/sfpid.c
index 0ccf9ad..62acb4f 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -517,7 +517,11 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
 	if (ret)
 		goto out;
 
+	new_json_obj(ctx->json);
+	open_json_object(NULL);
 	sff8079_show_all_common(buf);
+	close_json_object();
+	delete_json_obj();
 
 	/* Finish if A2h page is not present */
 	if (!(buf[92] & (1 << 6)))
-- 
2.47.0


