Return-Path: <netdev+bounces-107318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E3791A8C6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD941F28314
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92559198E6D;
	Thu, 27 Jun 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Of65Kjac"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD56198A35;
	Thu, 27 Jun 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497414; cv=fail; b=JbuWoK/iwaiUodshYbv+sqA1E9EqfWBejdTw3VDwvC4Ul4XRl7i3RVEL27dhPkkDe1QMC5OpDSlceRNYw5X2fQsttoFZ516F/LAho1JDY5Oe5uOrlDl4gnivmbz8QT/XX19Z/FpGa7q6QRwFjvXbmI5NG9pJYb4atRLVwRhBXr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497414; c=relaxed/simple;
	bh=NpEE0ls9XQHFSXMiHmYkeNcLv0lEEe/RUnAq61/u23E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upusdUgZHtFzrx+59rIevO4sISABGftk6qgWW4EY0+r0TKdRFn9BK4n5781Vg0jnICZNRoVYq3eKOpY8d4VoZnWlFvI6dajY3hMp6veKa0cZ6erMArN1Y7W442ZX36JKTFcjgm+Gw6xYmbsD9913EuDgM7PGgJv23JH5LIFx6ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Of65Kjac; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG236lXFjYhrlH7R6+V5Zgg7P7xLZI3Oi7tFFY9tf2dl50B4lHKyqR0EdV18qGLZCCXvxBBtajCJ9bE14TO9pHolzaArWpIdpAsIWw+G3F935i11HmADySeOorpsWCnIDSYx61hAAy+mv51GxkBV9KSlvfeEXcqtQJ1hxlZHv4xLPMmy1nnp07wf6CXj5tfIqfyNRM9u4tpY9bBapBasI3okj0zb0WZaD0iMFMfopxh619RvvUCOSNvKQByHBWpXnupQ85NRL8ID3cUTzBHBEfK0Z0e/kr6Zj4dDkZkeulPK9AnFjDIgny4CTyERUEFZktZK7EkF4pAU7JWk6MHa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVyEvTMWPzgG42wVdEcliSwmDHzFLUOue5wVVlomkSk=;
 b=LecVJV/tMiTXSLrzdZK85GuHkDdc11tDjXk36DwRZ/jeUZbdpVdfplMGdQM2y5oo5AFxaYIV2KD0Sp0SEyNRE9hx6KeuROKVigNb8zMLPKWomepOah0P4E8bRgEMQxDafpPLuLMvxVtr3uvBU02D9SRvwb++nIKC+/nG/FJlDPpH0INYB1WoCYl5qSfTfn244KtSE58jJevdpke3FVD6YJD7k4ojyNBTEUEwfRSDC+K+PMcRPF/o6kdsW0zpM/XtEWkeP0ALTEAaZSlnMYrmj9NlaLXTIke3f8/ksOywpHz7YuGJu+71jEbU107Vt0vSLu2JD8uEoOAzlKPv8JTdrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVyEvTMWPzgG42wVdEcliSwmDHzFLUOue5wVVlomkSk=;
 b=Of65Kjac2b0ZpzY3Ns6tcqicFKXVksKBXR9YvNmc/AOlXmV5JonVYUdC9POoWTsQhVpR6KPUjO3gJge+hF+v6JP7mYr2dPhH9HF+lTCUZ+qIjaPrHnD2d2gDAUPr8mRnElQ2tKXlEAvvhcTsqLmHhBmT3MUiNxqooJGlysIeo96MqURb0uLROoHZKhpdR6W7amBoeOBh1ujLNLhSXNi7JDFP5/ei6n8oCkaVCi7osHxx2Lj2hp2A0b0h2sKQ0TGGhEV7wDNKGSclu/tnj+Ati1dTFM/dX1MoG/5+8CHf/kG6UiToMFtq782QwXE0+9n1Q8rp7Ia020BixVTWjEhFFg==
Received: from BN7PR06CA0057.namprd06.prod.outlook.com (2603:10b6:408:34::34)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 14:10:08 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:34:cafe::8c) by BN7PR06CA0057.outlook.office365.com
 (2603:10b6:408:34::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 14:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.0 via Frontend Transport; Thu, 27 Jun 2024 14:10:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:09:44 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 07:09:38 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
	<sdf@google.com>, <kory.maincent@bootlin.com>,
	<maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
	<przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
	<richardcochran@gmail.com>, <shayagr@amazon.com>, <paul.greenwalt@intel.com>,
	<jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mlxsw@nvidia.com>, <idosch@nvidia.com>,
	<petrm@nvidia.com>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v8 4/9] ethtool: Add flashing transceiver modules' firmware notifications ability
Date: Thu, 27 Jun 2024 17:08:51 +0300
Message-ID: <20240627140857.1398100-5-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240627140857.1398100-1-danieller@nvidia.com>
References: <20240627140857.1398100-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bbe570-9c59-44c1-9b5b-08dc96b2d99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlY1dno2cXFDak8rQ1c2NjJnSnRKVG8rdFR4ZFBqaS9CWVMvb05iUTZ2ZmVs?=
 =?utf-8?B?ODl5b1hJaUdYNG1WdjRxT25mYVRiZkt4VnZaejJPeDJnWDdEQ3hNNjBVbE9W?=
 =?utf-8?B?TytpY3cwb0lLVXh4ME80czNlRS9wakFha3hNOFc1K2xUekdZbWQxcytVejZM?=
 =?utf-8?B?Tm9tZXdwWmIzeVFNNHdsajRHZzBxWEFTeFhXRFlGejJtZnJFUTdKRDMvcXd5?=
 =?utf-8?B?RzkrNE54UTc0SzFkYUliYUwvK0pOZW0ySnNjbTRzY2MrOTZldm8zZGsrWktR?=
 =?utf-8?B?MHR1YlN2OXlLM09mdFM5L1ErTUU3V2NhenZYWnA5dEtmVXpXMmU5VktaclNK?=
 =?utf-8?B?K2w5UXNCS2ZFVFBaRDVNNEkrTTNLUnR3bzdIRWVESzI2MFFvUE0waTVsYWY3?=
 =?utf-8?B?ZXpmbXRCMVJxMU1qZW85Z0NrR3g4M0pPTzZMM2szcUNJeUhtNlBzMVJ3L0VX?=
 =?utf-8?B?QmhRUktoZjVQK1BXTERWL3Njb0lMM2RXRkFZSVpaRi9UL3lkV2NnWnhqL1ZC?=
 =?utf-8?B?azI2azZnY1J6T2syazg0ZmNaRWdDWkplaFRxc1RqZ2NMajQvQmNpMkRTdlV2?=
 =?utf-8?B?cTlxSWkraGtMMW5ySWdQamFaMUNOb2FDVC8yc0p3TXIvRDRNdlBuYzc2NmZJ?=
 =?utf-8?B?dUZGTHV2bVNQbTdNcHJtQzA4d25GTFQrQzY3cWJ5R2NhSHNKRU90VUpReWdR?=
 =?utf-8?B?ejc2c1BvSVNEeXgwVUpnYzE4MGlUMzErTmNWck56UEdlOHRUdUpTbGRQaWN3?=
 =?utf-8?B?WDNlQ3QzcCsya1J3djJBOGF1cGE3Y2UzdW9IVjlpZGc3d283M2p6cTFUamtC?=
 =?utf-8?B?NVBpbXk5Q3lLNS9GYWRERldRVldoKzdmVzlNVmZ3NVJvRGpmRmE4U0hIcUpo?=
 =?utf-8?B?R0IzaDBaMHNhSTl3Q2F5VllXZjdZRDBWUTJ3RXpTS3dmSDAvNTl0WlByVUYw?=
 =?utf-8?B?RUNzVndQbUVLY0dsS2hYT2ZjR1R4aHFYa29UbTJacjdKWGNmcFJ3VVdMOWQx?=
 =?utf-8?B?bDZkb3lmSndmbUs5NVJwYjZDOTRMVitWci96QXZzSkR4Vlk3d052RFN2aWxU?=
 =?utf-8?B?UStRWnRoT21YNzZWYnlHc1pDYitZczhQaVJLLy9tREVOVk5sZm9POVZnd2F3?=
 =?utf-8?B?cDJMblFQZWdkR3l4UzRPYzlVU201S091MjNpdml6M0s0UlAvS3hzMW5NSWxj?=
 =?utf-8?B?eVRLRm9xbHVjbkR3UUFHb09hQVdpcWJiWkVzYXRFbm82U2Z2cW95MkZ6N01K?=
 =?utf-8?B?TmtobDUza3JiWStWajV1UG80cUhOQnZFVGZQRTdMQjQyaTBJOC9ya0s4dCs1?=
 =?utf-8?B?MDlyQ0R6ZUcrWnlyUENkb2xSeTk4L1BzaWVNUXNkZWJYVWtDREt1SDVaVDha?=
 =?utf-8?B?dVBRdVAwUnZzWmFWNXNJcWFnNk5BZ05FTm1XRG1jMHZJTmVhb3lGcW42S3hT?=
 =?utf-8?B?RUhHN3hhZDQrSDdsUzNCU0MxaDZsZzZMQmlBT1JVdGhZdUh3aVZDbmZueUhi?=
 =?utf-8?B?NTFsQWY1dldpczdvRnJ3UnVSUjkwK2t6SFZSMSthUTFtSm1SS09tV2Z5VUlP?=
 =?utf-8?B?dXo3cHFPNG8zWGRFbGo0T2FCNGdlUUhUL3FkTmQwM3BLSHRlQlVhK3BVaGtV?=
 =?utf-8?B?ZlZtVk9qcGRaSDhUcnlSaitmbTM2Z2tWUWNrVmVWNmZxSDhaVkgwYXBNbWI2?=
 =?utf-8?B?RXkrQkc0NXRSN1o4a1FQN1h6SXVBcTZ0VXN6WWsrOGh2S0RVR2tGV2R4N2t2?=
 =?utf-8?B?VHBmWW9QVlU3QStPaUlrNkVWanY4dzhLdjRDb0JiSUM3Qmk1VW5nOTRFejJL?=
 =?utf-8?B?N1ZGaUxmSVBRa0VFTnhVemFMNVRYdUVmTktoMitYZW5rZ1VIaEp6cWh3cDdX?=
 =?utf-8?B?N0JCVVRuU010UEVjdFZiby9FM1F3K2tUcHNMWFZlYTdKYUVtWlpIa083Vzh1?=
 =?utf-8?Q?xIH9wXxBCSF+no8E6BtAK+QtSDXpNa5i?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:10:07.7197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bbe570-9c59-44c1-9b5b-08dc96b2d99f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366

Add progress notifications ability to user space while flashing modules'
firmware by implementing the interface between the user space and the
kernel.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Notes:
    v7:
    	* Return -ENOMEM instead of PTR_ERR(attr) on
    	  ethnl_module_fw_flash_ntf_put_err()ץ
    
    v6:
    	* Reserve '1' more place on SKB for NUL terminator in the error
    	  message string.
    	* Add more prints on error flow, re-write the printing function
    	  and add ethnl_module_fw_flash_ntf_put_err().
    	* Change the communication method so notification will be sent
    	  in unicast instead of multicast.
    	* Add new 'struct ethnl_module_fw_flash_ntf_params' that holds
    	  the relevant info for unicast communication and use it to send
    	  notification to the specific socket.
    	* s/nla_put_u64_64bit/nla_put_uint/
    
    v2:
    	* Increase err_msg length.
    
    v6:
    	* Reserve '1' more place on SKB for NUL terminator in the error
    	  message string.
    	* Add more prints on error flow, re-write the printing function
    	  and add ethnl_module_fw_flash_ntf_put_err().
    	* Change the communication method so notification will be sent
    	  in unicast instead of multicast.
    	* Add new 'struct ethnl_module_fw_flash_ntf_params' that holds
    	  the relevant info for unicast communication and use it to send
    	  notification to the specific socket.
    	* s/nla_put_u64_64bit/nla_put_uint/
    
    v2:
    	* Increase err_msg length.

 net/ethtool/module.c    | 117 ++++++++++++++++++++++++++++++++++++++++
 net/ethtool/module_fw.h |  31 +++++++++++
 net/ethtool/netlink.c   |   5 ++
 net/ethtool/netlink.h   |   1 +
 4 files changed, 154 insertions(+)
 create mode 100644 net/ethtool/module_fw.h

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index ceb575efc290..ba728b4a38a1 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -5,6 +5,7 @@
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
+#include "module_fw.h"
 
 struct module_req_info {
 	struct ethnl_req_info base;
@@ -158,3 +159,119 @@ const struct ethnl_request_ops ethnl_module_request_ops = {
 	.set			= ethnl_set_module,
 	.set_ntf_cmd		= ETHTOOL_MSG_MODULE_NTF,
 };
+
+/* MODULE_FW_FLASH_NTF */
+
+static int
+ethnl_module_fw_flash_ntf_put_err(struct sk_buff *skb, char *err_msg,
+				  char *sub_err_msg)
+{
+	int err_msg_len, sub_err_msg_len, total_len;
+	struct nlattr *attr;
+
+	if (!err_msg)
+		return 0;
+
+	err_msg_len = strlen(err_msg);
+	total_len = err_msg_len + 2; /* For period and NUL. */
+
+	if (sub_err_msg) {
+		sub_err_msg_len = strlen(sub_err_msg);
+		total_len += sub_err_msg_len + 2; /* For ", ". */
+	}
+
+	attr = nla_reserve(skb, ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,
+			   total_len);
+	if (!attr)
+		return -ENOMEM;
+
+	if (sub_err_msg)
+		sprintf(nla_data(attr), "%s, %s.", err_msg, sub_err_msg);
+	else
+		sprintf(nla_data(attr), "%s.", err_msg);
+
+	return 0;
+}
+
+static void
+ethnl_module_fw_flash_ntf(struct net_device *dev,
+			  enum ethtool_module_fw_flash_status status,
+			  struct ethnl_module_fw_flash_ntf_params *ntf_params,
+			  char *err_msg, char *sub_err_msg,
+			  u64 done, u64 total)
+{
+	struct sk_buff *skb;
+	void *hdr;
+	int ret;
+
+	if (ntf_params->closed_sock)
+		return;
+
+	skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	hdr = ethnl_unicast_put(skb, ntf_params->portid, ntf_params->seq,
+				ETHTOOL_MSG_MODULE_FW_FLASH_NTF);
+	if (!hdr)
+		goto err_skb;
+
+	ret = ethnl_fill_reply_header(skb, dev,
+				      ETHTOOL_A_MODULE_FW_FLASH_HEADER);
+	if (ret < 0)
+		goto err_skb;
+
+	if (nla_put_u32(skb, ETHTOOL_A_MODULE_FW_FLASH_STATUS, status))
+		goto err_skb;
+
+	ret = ethnl_module_fw_flash_ntf_put_err(skb, err_msg, sub_err_msg);
+	if (ret < 0)
+		goto err_skb;
+
+	if (nla_put_uint(skb, ETHTOOL_A_MODULE_FW_FLASH_DONE, done))
+		goto err_skb;
+
+	if (nla_put_uint(skb, ETHTOOL_A_MODULE_FW_FLASH_TOTAL, total))
+		goto err_skb;
+
+	genlmsg_end(skb, hdr);
+	genlmsg_unicast(dev_net(dev), skb, ntf_params->portid);
+	return;
+
+err_skb:
+	nlmsg_free(skb);
+}
+
+void ethnl_module_fw_flash_ntf_err(struct net_device *dev,
+				   struct ethnl_module_fw_flash_ntf_params *params,
+				   char *err_msg, char *sub_err_msg)
+{
+	ethnl_module_fw_flash_ntf(dev, ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR,
+				  params, err_msg, sub_err_msg, 0, 0);
+}
+
+void
+ethnl_module_fw_flash_ntf_start(struct net_device *dev,
+				struct ethnl_module_fw_flash_ntf_params *params)
+{
+	ethnl_module_fw_flash_ntf(dev, ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED,
+				  params, NULL, NULL, 0, 0);
+}
+
+void
+ethnl_module_fw_flash_ntf_complete(struct net_device *dev,
+				   struct ethnl_module_fw_flash_ntf_params *params)
+{
+	ethnl_module_fw_flash_ntf(dev, ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED,
+				  params, NULL, NULL, 0, 0);
+}
+
+void
+ethnl_module_fw_flash_ntf_in_progress(struct net_device *dev,
+				      struct ethnl_module_fw_flash_ntf_params *params,
+				      u64 done, u64 total)
+{
+	ethnl_module_fw_flash_ntf(dev,
+				  ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS,
+				  params, NULL, NULL, done, total);
+}
diff --git a/net/ethtool/module_fw.h b/net/ethtool/module_fw.h
new file mode 100644
index 000000000000..ee4a291ac1d4
--- /dev/null
+++ b/net/ethtool/module_fw.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <uapi/linux/ethtool.h>
+
+/**
+ * struct ethnl_module_fw_flash_ntf_params - module firmware flashing
+ *						notifications parameters
+ * @portid: Netlink portid of sender.
+ * @seq: Sequence number of sender.
+ * @closed_sock: Indicates whether the socket was closed from user space.
+ */
+struct ethnl_module_fw_flash_ntf_params {
+	u32 portid;
+	u32 seq;
+	bool closed_sock;
+};
+
+void
+ethnl_module_fw_flash_ntf_err(struct net_device *dev,
+			      struct ethnl_module_fw_flash_ntf_params *params,
+			      char *err_msg, char *sub_err_msg);
+void
+ethnl_module_fw_flash_ntf_start(struct net_device *dev,
+				struct ethnl_module_fw_flash_ntf_params *params);
+void
+ethnl_module_fw_flash_ntf_complete(struct net_device *dev,
+				   struct ethnl_module_fw_flash_ntf_params *params);
+void
+ethnl_module_fw_flash_ntf_in_progress(struct net_device *dev,
+				      struct ethnl_module_fw_flash_ntf_params *params,
+				      u64 done, u64 total);
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index bd04f28d5cf4..393ce668fb04 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -239,6 +239,11 @@ void *ethnl_bcastmsg_put(struct sk_buff *skb, u8 cmd)
 			   cmd);
 }
 
+void *ethnl_unicast_put(struct sk_buff *skb, u32 portid, u32 seq, u8 cmd)
+{
+	return genlmsg_put(skb, portid, seq, &ethtool_genl_family, 0, cmd);
+}
+
 int ethnl_multicast(struct sk_buff *skb, struct net_device *dev)
 {
 	return genlmsg_multicast_netns(&ethtool_genl_family, dev_net(dev), skb,
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 9a333a8d04c1..5e6c6a7b7adc 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -21,6 +21,7 @@ struct sk_buff *ethnl_reply_init(size_t payload, struct net_device *dev, u8 cmd,
 				 void **ehdrp);
 void *ethnl_dump_put(struct sk_buff *skb, struct netlink_callback *cb, u8 cmd);
 void *ethnl_bcastmsg_put(struct sk_buff *skb, u8 cmd);
+void *ethnl_unicast_put(struct sk_buff *skb, u32 portid, u32 seq, u8 cmd);
 int ethnl_multicast(struct sk_buff *skb, struct net_device *dev);
 
 /**
-- 
2.45.0


