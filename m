Return-Path: <netdev+bounces-106223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8029155E9
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DE7288185
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABE21A0717;
	Mon, 24 Jun 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FHEzGx8i"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A01A00DE;
	Mon, 24 Jun 2024 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251589; cv=fail; b=ZKTonBpM7Dap1z1O/11xgRYnHtv/Ps1w5HY81+WrU0zLR36tx3Tt0WuIAMfK6GHdRZvf/MkToMGFSEiXYCtpP8myLkaCt8n8aOatmTbFSJV1wQoMEAmZh3872VgBbCJYjn8xb0jA80tl5Xh0yXe8uTCJ7A4YREhQ7jNFqQNnzPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251589; c=relaxed/simple;
	bh=5nSKT1Qm2EUIs2NwZcmQuktqRoJNT+6dfV4ueHXYZhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2XP98bhsKYJpCj3aF0enYFvuGXoSb70pGlckwqRGnxbaq6ep+zN/V07JnGz6LfEAIHPsT4jZN0B9rUTRRzI27kIhN0hLWtUMeWl6AGUFhJ4E1RWDWlyJiB1s4yiLLHH9jPxkPDnOuMHMHypf3EKcoQsPzhPi6JL54lCSrq4Dz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FHEzGx8i; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXFWwUXBXjJWGdKx29VbDUMbjVMGC7Vlvh017hizAQbAdb2WhI3kHMiD/dvXTQ1344/BzX1Pcj69Djtl33XJ3FVqgG10z7v64K+LjSZEn0aw6UPlsbyU8r4NczKOSGCjwAAqoXJbEFIM3UuqfXfdex3vVzycqKuhVi5/gA2ibvubf7hH0PblLF8iJ8WoAf+IncFeuga8u4vcUB8tOZycuDQHzGW50Eg0ETtAzY4qsQRZIhUteDM4SCpR4Ix5UKwRCcQ4t/lyBPRW5mVyLUgDKoibpCZtti7fXf1wfoIxbzeh68ezFUU8fHgMffqofYhlFYLxIpnwFCAE62xcn/zwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFjiLfMyhNW3bgd3vvg0ZVOs/BYoBQTYyFObF9zZL4s=;
 b=mxoy6QtuXHDxSLpqDlcmv4UNbdlHGNbDh9Kga4uFPUicL7xLcQL9qI0tocCKEQsm3OU3LlSsGhyhBQWEUFRes6MrywIoqaG9VEmHdHXNkglsXJA/LzX8KSlx+OQVHm9ggZpagtIZhxWyFHyXWfpuTNBdP56Vg/QAO4o98uD7EFwfcxebZYsR62tl09Tuq1oEigmUoxVCQ3cV2B9ZnPPfnOzTqqeaaZ5Wplf9l5I6CIfgppaoYhp3MyDn702zKN5Bad2Arvqz2z/Ic/OI5on5PY/00l+DfvkDc4c8OT+NP4M/7ObzAHRZGRxvEURmvOcLeN1dbSIfA59ZFIBqCDqKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFjiLfMyhNW3bgd3vvg0ZVOs/BYoBQTYyFObF9zZL4s=;
 b=FHEzGx8iYYYImlrMe1eJPA9jCr0IKNRPef5UTNSlw9SZtum5ye6hjtdd08ZYq67Qa2Pyd9VX7BNY2Fwc3g7qOp5zgDXMtJeKW+RDo4eE4zro2mw5SRnh9E6Si3P/95eo+XKqBuXIjn+rVnbVmk4RLrINh7ocztFlIgpd3BtVO30OpVFzF/bZLCo3a366R4ztLLI2Sm2LpbKukcVb+W/oPdurQRHl4/LWcuySgttSV9yamKB7xFRaXXuMDf/DNv0HX0g0UCj+Sj55fsWAQv6V3ZsPDQjXiwroTqTfpk/6gC6Wy4X958LhVClEqrXCPIkySy4XAwhkkT8Oq9vPxMeJ3A==
Received: from PH0PR07CA0031.namprd07.prod.outlook.com (2603:10b6:510:e::6) by
 CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.21; Mon, 24 Jun 2024 17:53:00 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::cf) by PH0PR07CA0031.outlook.office365.com
 (2603:10b6:510:e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 17:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 17:53:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 10:52:45 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 10:52:39 -0700
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
Subject: [PATCH net-next v7 4/9] ethtool: Add flashing transceiver modules' firmware notifications ability
Date: Mon, 24 Jun 2024 20:51:54 +0300
Message-ID: <20240624175201.130522-5-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624175201.130522-1-danieller@nvidia.com>
References: <20240624175201.130522-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df83e5f-94a8-49ef-1c05-08dc94767d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cllpeTFSRENlWERYWWxCbjFOWWJNWjJDTk1sejh5ekVhcGxUSnJMR2pYUWdJ?=
 =?utf-8?B?d29JOTNPbmVrdjVLQUJRTjJjUTJXZzFJUXE2TzkvUlJXRE5lNUMxaFFXNDFj?=
 =?utf-8?B?dTdJUUl5QjgwN256TnE5eVJxdG5lUUI4d2xwNDMyREJpKy9HRE9xS1RMVDJ1?=
 =?utf-8?B?U0cwcU5KcFEvQzVDTTdBRzZTdEllR1pSZy8rUnFsd2IrdHVkYVYvcll2bHlU?=
 =?utf-8?B?bkhaQklOaXY2RWFMaTNnbmpPUi9yMGZjWXdGcVo3L243VUdPSGZJUHczL3Qx?=
 =?utf-8?B?aGhCdU5IOHdTUlREazBSOHhLMEsxNTRHYU8yNHVxQ1g2dkxoQVV4TGo3TWRq?=
 =?utf-8?B?VDFwSTgrSTVSS1Z5amd4MzREUndxeDR6Y2JUSkNPOVQ2ZFRYUGRySlB4M1lx?=
 =?utf-8?B?ZGVOZFlRZWs5VnF2NFhwL2ZFNE93UGlsREpSS3RjMDQvSDR6Q1ltQWMyTjJW?=
 =?utf-8?B?cTE4WEJya1dVWHlxV2NVeDJRaURHUnp3MXJWbXhUdUx1T0ZiOVBQQnNLM0Vk?=
 =?utf-8?B?cVluSXAvMllqUzYxendvSlZOMFI2THVhcStXa2EzVHlXNUhLZUV4cllTWGQx?=
 =?utf-8?B?NG1HbWFaQWkxa1RjQXloUStab1FES0hTSDVmYUVFMTNROExuSVErVXdKNENR?=
 =?utf-8?B?ekhHZXpjUWZodXNZWnl4NlNWWDRVNlk4TEQ4ZjJsVHlkS3hFRGp6YWR1bENk?=
 =?utf-8?B?dlR0YkZzZGpnU21jRFdCNStyaTZUcC8zbmc4NDFVRDFQcjQ3SnNOSnByZUJk?=
 =?utf-8?B?b2lWTEVibzRUQ2R5bnloY2pJR2U1UDBDVXpQQWtZUnBpKzM5UE5CRUlnU3lo?=
 =?utf-8?B?V0h1ZlM4b3FSSW9DaWZ3QW5TM3p6aklubjBmeUVsUWtJdnpsZU1GYjdCemtI?=
 =?utf-8?B?TCtFc3V0cGFsVHZaQWdXdUZyNGx3R0liSW1BcUlORWhBK0xyN2cxUEZkQXJn?=
 =?utf-8?B?VEt3TVJlVlJNTkREeWhibjVYdGdycWpUdzFjRXUxTWVJaStsOHJWRVdtS0xC?=
 =?utf-8?B?QXpMSmd5RWFKa2dTalpTVmtDclVKTExib2dQMTV5YzV5WkNyWEc4VnVFRWdO?=
 =?utf-8?B?ZDgyMG13Q0t3aWpWUXJLa09RcVpIa25xNmRCY0FwYThCbmh6UnVtekxiSVg1?=
 =?utf-8?B?THprSFRDYUc2OHFZcEpwVTVqYXZCUFFxcnpGcU1WYnJOT2F5b25xWGJvUUZS?=
 =?utf-8?B?TGw4TkU0R2p0b2J3UEVMczFTNVJWQVlEdC80VTdCb0ZqMmZWbkFJcWY2aHhh?=
 =?utf-8?B?d0lLWGIyd0V3c0lhSWlOdEgyWVBTdkVYM0l3aHVhWFJHOVZLNHRsempLSmUx?=
 =?utf-8?B?UU1CMmg0bnJ4N1dXZlVkMDA4TDI0Y1pBNUpCeEl0WjlES0JNalNGb0Q1OWJR?=
 =?utf-8?B?VkovdTd1UnVlNGhOZjlneWEyd1l4cDh0eXdIT3VhRTVUcWpLOGVCK0hjeit6?=
 =?utf-8?B?aDZoMzMvQ2ZjR2RrU2dLRUdNaFV4a0x0b1hCS2tpSVI5Q2hoVVc4M3BMY2J3?=
 =?utf-8?B?TUpkL3dGYmxpY2Jpck9pT3dneHZDK3J4d2NkMFlIejFtSEd6UTYvUVhMVU8z?=
 =?utf-8?B?RHk2dFVLa2VQdHVGUGxvbGN4SXNFaHR6R3pwNjlzS2Zldlc2NjJ2OWZ1RDAy?=
 =?utf-8?B?M0ZBdm1ndmNFVGZBNkF0SDNMNGljc09UdHV3a1JXTHR5QU5WQXFnWXFPREdN?=
 =?utf-8?B?R04vVkpWVmZkWHVWUWxhV1RUcW1JV2hNa2hhNXFFMGs5dDBZd2hwSTBDVit2?=
 =?utf-8?B?aDlucTUzTVhnOHhrVkUvWXJTQzdYUUtOdWF0VFZHSXA2Z3BFSUtjdVdiUE5l?=
 =?utf-8?B?Q1BFR0wvMTNKc09ZZ1ZPWWo5N0NtNklGVXZsOHNEU2NqS3pNVENpTUc5NFFU?=
 =?utf-8?B?ODc1MmpkZ05MUFdNZUMyaU91OVlPc280SHg1Z3B1KzEzNkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:53:00.4236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df83e5f-94a8-49ef-1c05-08dc94767d17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053

Add progress notifications ability to user space while flashing modules'
firmware by implementing the interface between the user space and the
kernel.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
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


