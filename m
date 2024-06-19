Return-Path: <netdev+bounces-104851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD59590EACA
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FAB1C23F7F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFC214D435;
	Wed, 19 Jun 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WsHaaITK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7714C584;
	Wed, 19 Jun 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799501; cv=fail; b=YI4m1B1TWSnAU9ixN7LCAljpk1QthBLO8iyX2IoTMQ6gfJeGJvXPF7T5RU1j8QRnEBcxHHE6e0RAvDsM0zW2DpD0IlpWCY61p1qO6O1iQksZ1aCAfdiMXn70KlnP8PbaW/D3zUBjMm1zaatnfiI8BnppX/1wFp6DqqQw4Y/v1yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799501; c=relaxed/simple;
	bh=vEJ0cHPwb/e+yK8ajINYHlqInwybPhqjO5TOD3lF5Hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXHoeIsTtwVpDZTB0ePwm0MdV2FtVm5ppajVROJAeJo4pGeq+TBu8Arly0eG4A93kEN0b2t0DK2JxNxtdgp5KEXvQeioUDvXe8QTR30ZQqPmjCMEjYNoAAaDjUaIlQDVkcdc6gI2eCZqjYPh/AJ/bWBTVHTGAwk6pDEf/dzHiGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WsHaaITK; arc=fail smtp.client-ip=40.107.102.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILv7htKBIErZPgyRc2kVkwWgQAGP41JiDxj5k50ySSdxEYGmpyDNLtY1XC+1QdXnVwksnb0vDBqbeteQHN4SNcIAoGCmBtjEkLVkz26QT6CUDFAOqRL1w2VdKG53zLERmGKNQ9tI8YboXfKaE1VJrgZlhBaSqbmURLLQtIFRkNpJDcIWUMpHkuWsC4n+gF7iGzTshvPHkdvJ4t3YPR6wY3aDjyAjFmC2F4A+MhgdyR+eTXqAo2ugaFkTPDLJpbRBK8SidIkeJBBSJgjlsjdhm3ldJ5HlysNSmIBc2DGYKr8wpZfBuR8nn95tBOh0DsLBtfvMj8ixDT8SdHCcrkVGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH3p/KzwSk9Fu+AWpOXUSDR2tS4/eobAh9DJgknkP4E=;
 b=MTNKf5K5DdQgFitVmiolSipDt3Oa9wuCZu24F8TQvsJ9KgMovEZqDts3TFrJYl1OL/XInUFjDZ68LJjHvBXfsRax1ez+76i+9dbklEhEARIgr2zqudxvDglOqy3HvXzeIKjRhnF/L+nKMyU81KTx86TYXBoABYERvVCj5kFnljAvCXXKliGYepLIV0DaG1pOwdgfe3Rfa7BRDTW/ribN/B6GX/52/66P4mh91kjlF7gRgPBZt4dz5O1OWmbZRQfXcyizBOUoP37r8PmR/2vsRiQIMGhVMgSUy9D9vss12PQl18P73qXZsvY2t4hBjKCeflNTiel7u+1ozLtTXbuv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fH3p/KzwSk9Fu+AWpOXUSDR2tS4/eobAh9DJgknkP4E=;
 b=WsHaaITKZ0RaPPnCewMOUup4GJTxBK4zWACarepwBrTaFqU3O4yMrDOtc+eTzWpRBlbpF18dZcFlXpodQhj7M82U2ZZl0iDZulpm9+fTMwbPGpKKy2CSgHHvg3KkcTwQO5rqghnIjD6WIGPrH+wqEmnIT2XpiDPCPysnXlpuh1pkJcIK/XwaFpNZ63v48oaXRUfIKvU5zj5EhoRrQUMs3JL6fCuku9QzvJuArFiLjLYrDM5IGepFfDfKJMkIwhZfabX+dlnjAsbxZaATz7pMRWzzWbBkY8aRubW8FLtg3BlxZ13xCyX2ouv23+rxZB9fJ/1TfAtTz8AlZXwklMwKFQ==
Received: from BYAPR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:40::32)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 12:18:16 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::af) by BYAPR04CA0019.outlook.office365.com
 (2603:10b6:a03:40::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 12:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 12:18:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 05:18:10 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 05:18:04 -0700
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
Subject: [PATCH net-next v6 4/9] ethtool: Add flashing transceiver modules' firmware notifications ability
Date: Wed, 19 Jun 2024 15:17:22 +0300
Message-ID: <20240619121727.3643161-5-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619121727.3643161-1-danieller@nvidia.com>
References: <20240619121727.3643161-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cf7c59-14c8-49c6-e268-08dc9059e5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kSePOF2oIq5RZjgpLJWDJAgzklrziE4maROSEcfeGO4XtxLylNx1sRfTff/I?=
 =?us-ascii?Q?6siWPpy51AORgWbu5JiKC2lL/Xja8aerbLqKYFLaEjrdm2Kxowe0XSqVakTT?=
 =?us-ascii?Q?dvv+NI/jx7FAFj0kIS8Wfw8onCVE3sAcSBxb0TpYWX8vKwf3nXSoTJtRtSoU?=
 =?us-ascii?Q?3xcBffyKN01n/pMK9fP0dTqWmzJhcoT1YN20sWvk2POgglQEJTOnD7Y6eFqG?=
 =?us-ascii?Q?SnN2AAVuW4iozz4RSh5873qAb4Z9xxBxWlLmJTa5zbAradgXaE0g/3ga8RbU?=
 =?us-ascii?Q?CpNsiLaQaxxQVNzQh9UOK0wDpmefY2/i6JxZcsd8TY7fPGgWnps/kdH9qirW?=
 =?us-ascii?Q?Ujt+hG1f8MhsfaVWiv7Dgu/KaUUa0qSD86VWykOox/NJDB49oawS/IgX1tcC?=
 =?us-ascii?Q?PSF1BXBT+u/3N899DU6tx5b91gHSEJ76cFtD8spmRT1NS4EowK/KK3nzCIFp?=
 =?us-ascii?Q?V//Wcb+l7CzWze+AqHnMqc0S2jhH+2BJ7obUxEUO6o+lLJoOfBsR+uxe+o4Y?=
 =?us-ascii?Q?IJimIxTsZVDDHIXqVVQ6cVCZB0qRhvDEXoje7fXTDbrDJx+w5JWHTY+Mjjvp?=
 =?us-ascii?Q?5UTo0x+Qtmm4a9bYYWp7VkgJN+UIBSHrD6hEUK8spbPyAXc7j1vUERrqGCsy?=
 =?us-ascii?Q?urzPov3lQrrsVBSqzwAyjar1K+uvLmmUcf+qRjUyz3oOT7UtFoMT3MzRXRbI?=
 =?us-ascii?Q?2z4iBOJsqaPmapIip6nFK6MZml2H4y8kDO0DV2h2CTLM5LfwNCQXCL+R03OY?=
 =?us-ascii?Q?haG4QDCxZdmXS5VmaVA8aibAQ4A8uzpK3p5n5VIWBg43ptKBaeQxJuuySIVN?=
 =?us-ascii?Q?LU3qJ2obHMNESiCM/OaZ/ITA4fZPF1rRQmIh3CuVuhqCWZbfbukN0RsZPWkd?=
 =?us-ascii?Q?NASmfbYAbKHYPDEocjRBEoDPTsA62VXqOcTVtU7vJIwHhBVQH0JPbyB4ZAbq?=
 =?us-ascii?Q?fck1gibI/rcsUVAPaCOR8MLJ94zc+PpD6kRz93dXc2jqYfABnNb2YObV0DtX?=
 =?us-ascii?Q?cjuGBAA9pp2c2dpv69oQYgmrvE1T5d1wnT+ndPBHcnoFeJivaK1NnG9p1RW7?=
 =?us-ascii?Q?dP1Wx9AyhXMTHrbFYEFX90a4y/rpOxeNeYznsFH09N+Kg93Vj/j0hFDPIwzt?=
 =?us-ascii?Q?nOINOyvOMM8ymFEZqzd5VI6LuJhvJkgDiqKh3U8EE2G1dW8497+cMhBuE14T?=
 =?us-ascii?Q?QWemFgdimxs2rd7EuosEOlsaBEWV8cjP629JUjkVVINl0vHK1nbRV91Jl11G?=
 =?us-ascii?Q?lXV8WmkbLyA6b24BMZmHohUkxVP0XQZQI2gaenJ+9IzoB/asvMeNrq3SJkWJ?=
 =?us-ascii?Q?bRWQeS+cWaTDZ+8fsk+yjlff+b5oKol+GVSO3V1moAubs5viqNquNq1pP99g?=
 =?us-ascii?Q?UeSL4aD9gtqc7ii0kVpEBliZIJqqLw5wdMts1LE6Ack/CI4LYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 12:18:15.8757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cf7c59-14c8-49c6-e268-08dc9059e5a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862

Add progress notifications ability to user space while flashing modules'
firmware by implementing the interface between the user space and the
kernel.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---

Notes:
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
index ceb575efc290..932415bd44c6 100644
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
+		return PTR_ERR(attr);
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


