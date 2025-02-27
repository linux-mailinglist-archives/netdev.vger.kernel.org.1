Return-Path: <netdev+bounces-170117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142C3A47562
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 06:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C601A16F41B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65F215172;
	Thu, 27 Feb 2025 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Rwrrw04R"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2040.outbound.protection.outlook.com [40.107.117.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01BA1E8325;
	Thu, 27 Feb 2025 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635459; cv=fail; b=hWA7RNJlMIZxysjbe0GpqfHUpwiHGkTBcFhkq3RcXy3mknScblDzVziQz4Ujt1kR7zwi8iyveOVpPo5Sb1Kvdy17ilL3H+1a1KVL0Q2P60RncHV4hv+5McMiAXliEdpQOnNxJ+8W+ygB9SzJGxOxLGGEfcUXi2S339ilaOHAC3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635459; c=relaxed/simple;
	bh=5RzdfXAVeseL+j/RDjWwWa0sFp78Ikq8LZ2/+isUTYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cpXVpQYkUl5KBJ6m/oJlkEJK6oFx7/F2FCP4vJlu4wXFU08uQvAfKbBzklDpQCnh/jLZkkyfxjuAcWMjnJyWA2pxXX4ZdEOmBH+iqyruaJuznlBD10ehZMpRaNc94LJv/33RIGBkaXorTFjfSMMcPszsFZcLDxEd8rZvunKeiOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Rwrrw04R; arc=fail smtp.client-ip=40.107.117.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OU1kDalkjOkqV84G/+W05GJBTs0u58oyft2za9iy4n0eYntBSCarV7ULstKj93Kb+nSctEWGyOCu4qwRvb4Isyfy4yGMCcDLt/sdBgg5ejK+/MqnVNBy6/KC9ZDMLIL2Sgasgbmj3x1TQJ0tyGamIkw5IjzgXXWW3qQeYI2YA3nwIl4PF7TRNrg4UaEn0FJ30Wpwa6ygXo1/084PmtEgCtLzQyV5+98jQ550rGgyFV1zRJXDJNrDOKHuXhKUq6juLVpanFI0Nl26lrpkCdKScB3l8l7cmrGIk/+MFfAqJlBZFq2P39mrMYi7tSSiSbMbSqwovcwSD2Q+x5MPCnmnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Al4bc5cSUvmGbOxtZx8pnieQTZxXF7Zr8RZRpbIEOqE=;
 b=BmESsrxHWdJfGo2w2ju+e5OEQX4lMePO32LEw8fmw+NDDWvfvL6aN/xu7MezwzXU9h3NEf+RVge6a+69OMqfe5TsoM94LSQeDnLTnYOAO4enkGEVaSsW8x96GUIsz6YTfFNHgU8tmyWPYMREu1E4y0poFP9FuAeU2r9uvd30AWurHDqpiiifh8HZ5ULHNvQr94dlOffmdkd8813oP2TlvwTv5ThVNKBUxf+oR0tfk9Yozrb4JYUn8s18qqa8EMpTt5fRna7RioDhXSP6KzWEPgdUfiKiMBEffQ9PRlUATpcYURi6M1N7WoUOkkVWgJpwvKbv5SwLTuQmS53FHZzz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al4bc5cSUvmGbOxtZx8pnieQTZxXF7Zr8RZRpbIEOqE=;
 b=Rwrrw04RCNWCsRbLVpgk7+H78cg3wqznmU5Q8p/FU38pcLhL8GFnP05m13+SVSPDjc2tLnUrYyhr8bdVs16X2ggndRXsUfs17c9CmJ9w9vA8xKcCrxCFCxstQczUM1TuWx4Pgwr7Y/BkCcq+849G1xcukY1beg7ffdM8e/0z+Evww2RIbVX+IXTY8YpTakGTz4q1M3A3miQHbMWi6q2sWPlunKJAp5TnABhWER1J8PI5gnJWwBqUeIfmrE99xnwOWQTKrasthGH8hDH1PeIHOx2opo4SHyavTMOc1OijaD7TZfekonLeflFcIiZTo9AY3/YcSUQyO0TfWvzDJMxl5Q==
Received: from SL2P216CA0135.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::14) by
 OSQPR04MB8042.apcprd04.prod.outlook.com (2603:1096:604:295::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Thu, 27 Feb 2025 05:50:49 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:101:1:cafe::68) by SL2P216CA0135.outlook.office365.com
 (2603:1096:101:1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Thu,
 27 Feb 2025 05:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 05:50:48
 +0000
From: Jerry C Chen <Jerry_C_Chen@wiwynn.com>
To: patrick@stwcx.xyz,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Jerry C Chen <Jerry_C_Chen@wiwynn.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] net/ncsi: fix buffer overflow in getting version id
Date: Thu, 27 Feb 2025 13:50:44 +0800
Message-Id: <20250227055044.3878374-1-Jerry_C_Chen@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|OSQPR04MB8042:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0f362cd4-20cb-4a8d-e26b-08dd56f2afc5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PWsQkMhPWLN8dzstM9+dlz0ZkQwteWqqU+ExFKBlWxEoF262fqGhnd/gUs/o?=
 =?us-ascii?Q?p+uGNOitNw3ISQhnqN4/WMh6fzqfGjdTCyE6L0z2cOX67SQ0domQL4w7/Hgp?=
 =?us-ascii?Q?KcjLMwfVKH/goj0bzb4cF9v8Nq7J0btTtbgC3Zp2pS4KRWuFdvEqDOqvJbyV?=
 =?us-ascii?Q?SZop/3dg4wc4V4Xh17Jkai5vU0ol0BUkRGJPOUe//DKbSU+Rs4YqhDFX8XuZ?=
 =?us-ascii?Q?yrkw+S897s+vTgy98JPMjSGNE6SelOkKzJzVIc2KwNKASZxTCHEsNW854f2J?=
 =?us-ascii?Q?KT6cjqToHg0upAKnj7hOUqs3slVjmRyzX7hLqu2VUgeVIyB90DrIEEJgyUZd?=
 =?us-ascii?Q?z4CVWgYKE9oHMfA5mCjjnSj77T7gHgzBjnKilV3f1aqdKsY3E7k4GZvN0e8P?=
 =?us-ascii?Q?r8XY+9P5AQryCdnCEzkEhWOWlggSGd9ICFnz6W41YXUrmk5yrnHTSzc+Xd+i?=
 =?us-ascii?Q?pCOfr109Zc+E31zVwHmd86ls/+aGPHZaxjRmsxR0Cho71BOA6BGJYF9rullG?=
 =?us-ascii?Q?yBUrENvDYAFWOdwSz3G48aEZRe42UoHPhPVOwUDm0eiFBJ4MNFMDRRbPP7Vd?=
 =?us-ascii?Q?KJ5ckmNXc1lENTiLNw553kBero2gvhFcxQ1OUW4nDiJaY78jtT217RElVoF7?=
 =?us-ascii?Q?BgJcl+kymNCge0bRQth8ywfFTimxNjJWYlSB0f08VFqR7LJzlsobLA3sbQGm?=
 =?us-ascii?Q?B7e65n6dmMjGSAHRWLFJd26aPngDeSSEgFCdQnBC9uVMe+jICYQs0ZnDXLnu?=
 =?us-ascii?Q?Jiu60Om10S38h4FEzX4DZSANL9ZFhqOrpxaF9jXtsP7bXV3sE4vaCqE1YctW?=
 =?us-ascii?Q?JAODeQis9quQjBKPWSBX3rbghkgX8U/O9gh5/WGzxS7C9jfejN/Y5U+LcYkH?=
 =?us-ascii?Q?+64fmP0Yy9nyElZ0S9jyzAgC1ok5IBlTBg840Hcdwtt5BBFU8lMhuxMr7vNn?=
 =?us-ascii?Q?aOOC5TfrRCBA+1jn+2tefeuoRYL/NEP1aQ5uImwclhGuDXI2QYj6oc99sgPh?=
 =?us-ascii?Q?0oTUqmma55fG5/d8rmyE7bPO4h6Ckt6Kk/YvFDu4VLaljm3rj48PJQT6PHc4?=
 =?us-ascii?Q?1n62z0yv7YLNRIDGH4sy3MICdLSq9+7Si3gb9WeR+RIdf/rSeZJKKYHT01qE?=
 =?us-ascii?Q?JPp/UM/Q+eGEJx0Gpt98xywNq5VSJSx63HEiXE6wq1aD2B18jxkFScw5+OFX?=
 =?us-ascii?Q?S95hGMAdusgaksz5iq6TdGkVk0a6GephxU5CRgJbxpNH2hsvVo8kjzPn0ghZ?=
 =?us-ascii?Q?ccZZqxRLDqoDHt6pit8Zs+0jZJGrxQmEuLit6CkoJD3hozGPBSx/3me5OJf4?=
 =?us-ascii?Q?Z2JBSIc60Cv1VLDWyoMvHW1ICwqtHWEmg2QirulOUng/1VJ4GhhDwQXujOV8?=
 =?us-ascii?Q?KhbFRbSNA+vok/WzkICEK5NyBN2+goB8o5P/J1GZ6aCKi3Ubhiqv7GoIBYfu?=
 =?us-ascii?Q?BqpG80NZokCQnsp9NqE0CrIk/htaW6t2cB+1zg1x+MN7rFgi/0i5uw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 05:50:48.5190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f362cd4-20cb-4a8d-e26b-08dd56f2afc5
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB8042

In NC-SI spec v1.2 section 8.4.44.2, the firmware name doesn't
need to be null terminated while its size occupies the full size
of the field. Fix the buffer overflow issue by adding one
additional byte for null terminator.

Signed-off-by: Jerry C Chen <Jerry_C_Chen@wiwynn.com>
---
 net/ncsi/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 4e0842df5234..fb918af74521 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -110,7 +110,7 @@ struct ncsi_channel_version {
        u8   update;            /* NCSI version update */
        char alpha1;            /* NCSI version alpha1 */
        char alpha2;            /* NCSI version alpha2 */
-       u8  fw_name[12];        /* Firmware name string                */
+       u8  fw_name[12+1];      /* Firmware name string               */
        u32 fw_version;         /* Firmware version                   */
        u16 pci_ids[4];         /* PCI identification                 */
        u32 mf_id;              /* Manufacture ID                     */
--
2.25.1

WIWYNN PROPRIETARY
This email (and any attachments) contains proprietary or confidential infor=
mation and is for the sole use of its intended recipient. Any unauthorized =
review, use, copying or distribution of this email or the content of this e=
mail is strictly prohibited. If you are not the intended recipient, please =
notify the sender and delete this email immediately.

