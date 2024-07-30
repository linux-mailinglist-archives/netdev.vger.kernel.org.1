Return-Path: <netdev+bounces-114170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA20B9413C6
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A201528495C
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2691A08C4;
	Tue, 30 Jul 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gcBNqxor"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C01A08A2
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347971; cv=fail; b=q56H/3X9WtpVIHMzrQh3iBujFmNGp6ATSiivQsgzbHvt4GpXIYREprA9sZpQDyT4x1QNsE1yXroOEgb9ZlELgOoDjnCQPkTvdgLjWLCmoct0NYw9IBm1x3otBEzU3jfxREoHLmtCSKUg50GRpmAi7dC0rOFtezL6XJG2ZFShJUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347971; c=relaxed/simple;
	bh=5099yaD2ENOjIU26614MtrjAdSw4RZdJOAEDbrosduw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fDvNFWgHdJSUOv0WPTonBhI+tC0YUeZq3AZV04lNehyV9edLxheM0xPiN5N87BkMnv1rikmaNNybI8/O9vqr41kvPEkLNz3h9cpJMQBGi6jrXuIjTRBN0qyzJtP9HlDM5YTsnE2zNG8iGpbyZo/hwII+g6sWocARqiQEy6kH4nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gcBNqxor; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5veUuQRZoFe5rrpO47RFfo0qHCbJ2ZFEhLAsQjGJtvSinvDtM87uwBPFUPy4GdJ2VpcQPsRbxPlcvSO0oHPmAjC9uDlGlKAQDEgAg3jvu9TXURYTqLt93ccsTUioJZLzoW5Gn32UaSfG8ahWhLkE55vo+itRwyjP2n0UGM6oBMz5tBp/SLnUbcxh+BB7faP7KEE089+rK/4idieONipVIhC5JsH1VPX/guGYtuNPLD0QTaZF1NmLoYqmQWtIGyujHvnFzTxQex5SZTkWYrlYYUO07Sgakzlmd9dPlLj4r/yEYSu2NXnftlg81bLOFeevfNkUyiDul21JLVuH9dekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a0ewk7PQbVxCDeDMFUqOdVr9xK5H7G/5tMva24t0Tg=;
 b=QcFB+k/mCKSqEiTAzsKqx/UGntHxJ+tBCozLG+2h9Dmi1BhPcQq/zRj5SA18oDeYGuPk12dxkUGXEWqTXatHx3MSShWOJVShUyZ9HYR5ukoEHv2nIFwjcj+S+cdKnhc/MgBa6Vgp1mYEc07bPjAGmSkuKmvNzRCEbfiSrDLrq4UrVLUshqfZOjtNpBwxENBwEkqOlTi1iUPgsyEI1nBcj7D7aaMW8dS7SEwQBSQIIAKkXCcn6oAd8qXovZPy9lHx0jg1P30qD94D6HyGRZBJOp9UstmXZRZwIJff22z0Wn3VgZfiqAjqoeIQdTcKNmAQxeNehLhc8XRhHKrCfNAfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a0ewk7PQbVxCDeDMFUqOdVr9xK5H7G/5tMva24t0Tg=;
 b=gcBNqxoreyC9OLyxxfKZ2UK7faFHavwOnUyquYIu+cm+aasQL+Di1PEE0Zume+fCEUbDqrWJYNtFun+yqdXsgIRcaHpIEnJWdF9CqCxTtQLaD8Ncbh0TYbELFjsGWsjqX4sxtfrxZA9DKZ8GVqJc+/SW0IRUXF8sbdA9pw/Mj0QpDWcxTxEZWTeoy6UlvZrSMsUJAt66ELLNTpHaIRKjJWNrS882faiAdYHFL889+HHRq8onhoVkz5zZBQRAnai1w3u5H2PC+UPy6ZPBykS+JIWGjGQqs3RG9i8YVSxRzritSjG43BJ+nHW5BERSm+DkjV5v7w2CmBdA9hztCu1GgQ==
Received: from PH8PR20CA0016.namprd20.prod.outlook.com (2603:10b6:510:23c::20)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 13:59:25 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::8d) by PH8PR20CA0016.outlook.office365.com
 (2603:10b6:510:23c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 13:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 13:59:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:11 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:06 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 00/10] mlxsw: core_thermal: Small cleanups
Date: Tue, 30 Jul 2024 15:58:11 +0200
Message-ID: <cover.1722345311.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bd9e4e-c58b-4caa-2346-08dcb09fd1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1hwVXlDNkdPUjNKcDZiTHdhdEhYR00yeFZVdE5weUp5SXVobDFnS1MwUkI4?=
 =?utf-8?B?WWFCckhZc1VORktKUGpIb2YxTVhhdmlRUmZvREZXVWFRaEFZMkRzVGlPVDhI?=
 =?utf-8?B?N09yd2FYOHNpOEE0bmI5aGhsNk1WT3pGVHJGZVQ3MWxJTDQ1dG5sM0Q2WVRs?=
 =?utf-8?B?ekdNakZVcUE4NnZCTjBrUHpZSnZvTFZxU1VzRWtmb2V3QXJmSEh6NXBnSkoz?=
 =?utf-8?B?Z3NIUlR3WlVrV0Y5UFJTT3ZXekc0VnZ2enlRaks3NnBXWG5oclBrYWRvcW5X?=
 =?utf-8?B?YXN6eG1hY0w1NFc2bnd2WDNuTGRCQzBmcFRvdjlMOEllTTlIc0JyaWtYMUFX?=
 =?utf-8?B?bTVrM20yb202VWQxZFZPQmJjYXVkYjIyVUZ5U1R2WXppcTBCaVpPMGpTbCtK?=
 =?utf-8?B?K0cvemh5ZUxTM0tMNE1VTlRsTWU5VUQ5NVVZRmNkMUdkcW8rMEhuME9vWE44?=
 =?utf-8?B?QjIxQnBNVi96Qzhwd0J4M05KY3hsdlRvTjlmS2JFYjUwNE4wRnVnODZ3TnRQ?=
 =?utf-8?B?TGZTdXdQeHEycElCVDV4TTNtbVJpZW5BT2JZTEY2cnlPMWV3SktOU210UDVS?=
 =?utf-8?B?OTZJQTVNZVJ4dDRHSG0wRXNWTWliYW85SnJxdk44aEpPakRQWXVUc3lFZVZ0?=
 =?utf-8?B?dk5RSStQMnNrUy9nbm0vcWphRGd3T1ExdkJQQXpKZ0lEOUl4YzRWZ3ZNcWJl?=
 =?utf-8?B?bGlURGJJcTRvNDF4VVR1YU5neEI4dGZsY2x6UzFHdUdKcml6VGRxUzRSemVN?=
 =?utf-8?B?SVpGYUR5bHJjcWduaHY5YlVSeXlscXpJYUVVdTB1TWxBSFRibk5qcmFEcjN6?=
 =?utf-8?B?MUxCZmZ0dmhlaTkxV3NDWDZ5dTNOemZLTHpKL1oyRWQrOGtzUm5DekVOc0dv?=
 =?utf-8?B?R0VTZktlRUxSaFlNekQ0YnU2RlNVNTdYTEJmOEh6RlY1Qlk0R3NQVEpHU0xx?=
 =?utf-8?B?aXc0VHJCeDhvTmpYYXAyQVFiUjlwODcvYjhEakJKaTVMdzRTRmQ3L0pqYjVY?=
 =?utf-8?B?dVlBQldjWlVYcXlCTnJqNG5kUGYrdCsvVDRDbU45UUhwdzFDZll0L01razhY?=
 =?utf-8?B?eTFnUDhPbjUwTkhFOGZDTTdvdXVkVzAyOWNNYjk3b05kYUxmMVp3Z1lFZm5E?=
 =?utf-8?B?NWVVbDR1TTRYOXdzSHYrNmRCZXdnb2Vkam1sdkg4Qy9EanZjeWdsaEZ4Wnlk?=
 =?utf-8?B?VFZNd2JQenZUYTlOYnFPMFFsc0twS252bCtxTFcxdlVMYXpkbTAySC9GaU55?=
 =?utf-8?B?bHdLQlRoQmJDYkpxVElmUllzMUhUNEFMcGo5Wm85R2t3NHl6Tml0dTRSUFMz?=
 =?utf-8?B?YVpZUlh4VWhFNllSNzl2MnkvYUtpaUtYNTc1MWE1UVA4d1Zyem5sQWtpb0NO?=
 =?utf-8?B?QVU5TnJ5OGdkN2c2M3ZMZDNHbUlTSG1OU2hydGdPQitSSW9YdHE1aE9pUlV5?=
 =?utf-8?B?eFo5T0ZPZENBdGZ2T1doZExRRHZVZ0JMRm9rdE1XTkFmZVJJSUlpZzdtcy9t?=
 =?utf-8?B?YytjYlRKYndvWlBhb2FBOTR0WFlkbEh1c01IUjFrL3lML045NFRVUDhwOGZK?=
 =?utf-8?B?ZWdTQU5uM3Q0K0ZKOEJ1YUVwTkkzZGJ5SGthQ0RPNWFkdjAveUk5ZjV5bDVl?=
 =?utf-8?B?MjJGNlcySlNCMG1sOVVnWHJrOEJ4RFlUSWhQMmRHNzZBNVhnT3ZvdU5nLzlj?=
 =?utf-8?B?OW9OdXRtTGVua3NIZXp6YjRUYmZha0RhSklRQ3E0dG5pSFhLOVVIYndzVEZa?=
 =?utf-8?B?WXBudlZJTG9QN04rYXpsdnBXYUxJdEpxK1E3NG1EQnNxTEk2L25DY1ZKWXBG?=
 =?utf-8?B?SFVYbzNqS2MrTXFoZFRrMU5nZkZMRndiS1JWZFVyR3hyVDZ6Y1RXVzhSU2l3?=
 =?utf-8?B?eWNGMTM5V0lZTXVHY1M1ZGgzeXZoWkRmRjhXMTJOUUJ6di82MjlsTzBYUnZG?=
 =?utf-8?Q?EOh7UC314a18liN4qfyngqT2400jPxvU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:59:24.3221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bd9e4e-c58b-4caa-2346-08dcb09fd1b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008

Ido Schimmel says:

Clean up various issues which I noticed while addressing feedback on a
different patchset.

Ido Schimmel (10):
  mlxsw: core_thermal: Call thermal_zone_device_unregister()
    unconditionally
  mlxsw: core_thermal: Remove unnecessary check
  mlxsw: core_thermal: Remove another unnecessary check
  mlxsw: core_thermal: Fold two loops into one
  mlxsw: core_thermal: Remove unused arguments
  mlxsw: core_thermal: Make mlxsw_thermal_module_{init, fini} symmetric
  mlxsw: core_thermal: Simplify rollback
  mlxsw: core_thermal: Remove unnecessary checks
  mlxsw: core_thermal: Remove unnecessary assignments
  mlxsw: core_thermal: Fix -Wformat-truncation warning

 .../ethernet/mellanox/mlxsw/core_thermal.c    | 43 ++++++-------------
 1 file changed, 12 insertions(+), 31 deletions(-)

-- 
2.45.0


