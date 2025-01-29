Return-Path: <netdev+bounces-161533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E33A221AB
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6401684F8
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13271DE2DF;
	Wed, 29 Jan 2025 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uM5YCzRJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB7C183CCA
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167810; cv=fail; b=gIroUUvBrEP74t0+DHyHGPp6ihpbSPHGSqCsObGYGHuM0Nvm4bVsx90npXlVsn03SbZPfSEiF0EN17iZWAHGTyG5i3qD3vGX+syCxWizOUsVjkCdZYDM5vQUYdJvmgzKZP/maHlZxg3o30NU4LuS9UMxjp/lcE/qky6mRUbHAxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167810; c=relaxed/simple;
	bh=mmu0ZRgY8LsbJHB5CKY9vwHSRyUtYDHOqxLHUrSHl1I=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dTIBeRiNdAFGSyybqOmVSAk32UF54p/jkLt5C0Xt94Xr1T8LNUaN4Yvd4FkQjI99e9ntQ+5bic8grm8szuDyWqGxpgu+i/r2EZvb7gTFgGTk+PKlqsSys0KTpiTdmIPkUatjBPaVaa3uTEHFFLEGsjQb6JFv+GE7n82278a/6CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uM5YCzRJ; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3dSRqnN8GndbG1Hy9RTgj2fPJ5lDm8RpY+VBwz5sh9N8zzPCUAx1Q3oUiGtswW2TUBn5zhqf687niHqKYCtW26EMaYDjA4LQ3IGUkNW237YVqGsPCmiaKhorHSElmmd/0GaaQcf5/2JWZQOeTGVBDB+gsWzGwL5rnxqGtnjRvy1CupOEwvIjgg0ZDCoDue50irYLGqMrUrlXoww90LZvWEDmTLrzcJbcwdkGV8/IY7I3ET4heDX4zm491moh92POA/uGN94f9NoWXxBI8ngOJbsLrjTZqKQ5E4H693NS9CMSTjvS4J/wlIpaRdN0Z934ykrgvCxljBhMQzskcPw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttPZpUvZfuDX+mIYEDt+4YMvb5SUo6soagc14Ehvuss=;
 b=UdubT38ZPmpZGsElpBbby1Q32PcT356EGYecf1W0c3zoPyq/hVrWuTCIJAQr36WmyGiiYkemBf7Z455jVKoRZo3uzxlqHlRXsmTOaFrymv/MOwg4l7Z/ApGJO5tYfOV+novWe+k9lLRotFlQbkYWPnMf6onjKvG5hhJvsce4gqSwRXvOetN8E0BorVcLvW3dFFzEAJLWw5xq3AAYewpU2nzBY7qKFB6KW4bUN0nEVTfJ4hudqRF8KA4IqiWjeXE0InN5GSK+QYf2Rdb/48ukXP0U0JbyDdM++7Od7CS/eK9Q3dyjy3oC40BlHuHjAaz7Jce6rQLqTAq2634QA5Lo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttPZpUvZfuDX+mIYEDt+4YMvb5SUo6soagc14Ehvuss=;
 b=uM5YCzRJQVwTdFISqE/BzBqQvgijZag+cN2RjD8LuRnctJ7QaxnURZmwSjKWP+a44cMPmCUm86iEEs2Nr/OP6yCXIKNOlzEvcuBHbSbL19nRaXfH6gHWYOmkIFtVBNQuKKPk+63DxwTXqkyinrPNFkrNHsxucVxUzUN+L5xa3qzNcNdIl9dMcTlpnHeUf3OcKzGSlr7kuiwZZeYYoe/jzicjVrVXB5uPfOvV2CwmdbHG++wTQFfvTNPIXHTEif3rQ8SXc/grfNY58OmqVGWOLPhJQo9mL3V6reBkDOuZQXRDxAvZh3OqBuDKMPtjxlvSlZ8Wkx/r1rAOCugAybFtXA==
Received: from CH0PR03CA0323.namprd03.prod.outlook.com (2603:10b6:610:118::6)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 16:23:24 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::6f) by CH0PR03CA0323.outlook.office365.com
 (2603:10b6:610:118::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 16:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 16:23:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 08:23:11 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Jan
 2025 08:23:07 -0800
References: <20250126115635.801935-1-danieller@nvidia.com>
 <20250126115635.801935-10-danieller@nvidia.com>
 <20250127121606.0c9ace12@kernel.org>
 <DM6PR12MB4516969F2EEE1CBF7E5E7A03D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250128141339.40ba2ae2@kernel.org>
 <5efb4e9a-6520-4a36-a946-caa545e68f15@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>, Danielle Ratson <danieller@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Date: Wed, 29 Jan 2025 17:21:30 +0100
In-Reply-To: <5efb4e9a-6520-4a36-a946-caa545e68f15@nvidia.com>
Message-ID: <87a5b9pp1z.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d9fada-7128-4842-3fc5-08dd40814035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L8M/TH60w8E24AXRxtb/y/uwE9miia+e6ZPChgukVCxvGIMdPpVmKmV0ojUL?=
 =?us-ascii?Q?ZKFFcQvnLMTpjtbDYhlQDR4DXs4ddcpVY7neDP2TMes5cHK/MCFN3jY5o2nw?=
 =?us-ascii?Q?DSRRxYsgcoxg42kRuPLZ5FohIlGs/C+N7P1Ib2BQnqk7EtsHQXhJEMlFejkC?=
 =?us-ascii?Q?OfFmotXFoumXllpxXq3n1foTCoObI05AZhnY7efjK4RPxrToi6jT6QuIZzv7?=
 =?us-ascii?Q?ftyp+paV8FwLlFO6niet4UZUXxOXZKDmq7OSHGml9qOcapX2+EWB0+Qd4b6X?=
 =?us-ascii?Q?05aI1p+LDqt9gNl5I7Ii1Hkgt6BP/3J7wYiphK7q4VXanroceSndpt5odEP7?=
 =?us-ascii?Q?vWR5zrGI41eWeqqlXSVM9tjQRE8N0jdjqkPVDLQKBGB/PE13T1lPZuG1T0iE?=
 =?us-ascii?Q?t2WjVhOvRSZglVxTj72b6BpEtrm9q83fnqC5e4RLV+rqBdQPjASAYdSM0jaE?=
 =?us-ascii?Q?zyDH/+eRd0ZckVOH2mx/IdmNcXmjm7BBlGgUVmtN65ac3egeLgfkj9K9gMP2?=
 =?us-ascii?Q?xE73Qw+j7gKbdblTf0P3/N36maSclN6iHzMjo3f3NdzzqlbjE2tR8X6x5dkp?=
 =?us-ascii?Q?6jKHKEhrv4PWVXo9P+x5MYHKh7ltJRNtD667ny2Q3gqyPTZWoZudOSmxCOuV?=
 =?us-ascii?Q?3dpVSsCt6D5OPn8TAMrJqzFvRO5P3s24rvrvGCY1jTjaGtCftlJS0ci04yl0?=
 =?us-ascii?Q?X/xIw2zNIow/wNuFNYALIKfbbyhLXkUsWI/n/3xeZihB5ffBbaXF+Zh1LWDA?=
 =?us-ascii?Q?5KijTVJZIlESHCWsT58OHLuG7C+NGAMDTbQsSYZBPSuFLCH2ao9UJ9yrvZxT?=
 =?us-ascii?Q?VVSS4qQ19v2kyONRv9zuKpEyYlmrGnXeYgrL62nddM9hLDNm7w4pV2ZENWM1?=
 =?us-ascii?Q?otw8K19m8RoZ4NW3ccLbQpeOgAIS8r7C+9Mvke/GaQ3WhgM+dvSvvPzvBNik?=
 =?us-ascii?Q?oMv0aWLFFfkgb2tDT3e+z5wDJ4K3fmP7sXdAXmg7mxOiMPH8cwOYRFfl92mp?=
 =?us-ascii?Q?LvsSyVKyuTeUD87byeJJUJ88IErft5eRPNjKDbFWAL/gmx0Ll/P4UGGdvoEl?=
 =?us-ascii?Q?fzZM/3ZMuska7l1yoaoAYU82GrRXmF9Fp9S/BgatCbUXXsHtYw3IjNIIBzlh?=
 =?us-ascii?Q?lA5BlRCkaSrL56wpqJ64AFwBuZ48lulaE/Ss6KKYm+ftnHywSso2Zcj0U0SP?=
 =?us-ascii?Q?kit+tRFhZdEwtTGObwINAxYtuvns6zga8VdRgNbZG0XIBV6H8gjPa2KWdtXv?=
 =?us-ascii?Q?7uTXd3NB38x+ScMxU8HultiUM6fKuHP30VfZV/jROnNbhW7wJOkHvUIsbfWM?=
 =?us-ascii?Q?VgtP9XrcdgX2nrE4CzuIXltDLapXpYcq0librYGaZXVnzvw/ZVLXVD6g3WY0?=
 =?us-ascii?Q?KjPkVu0Qu6Q9UZ1rcqm+COLzNY2WkrKzsGXZi2W+VGNR3ujAl52IkAytljKt?=
 =?us-ascii?Q?i3s8a3/IIX7nfg1BUDsPZqf63sKtWCaHqCQbRzqL/rOtm/IwzVgFhsNoGLy9?=
 =?us-ascii?Q?DQqmkdc56G+KqoQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:23:22.6793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d9fada-7128-4842-3fc5-08dd40814035
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547


Gal Pressman <gal@nvidia.com> writes:

> On 29/01/2025 0:13, Jakub Kicinski wrote:
>> On Tue, 28 Jan 2025 13:23:42 +0000 Danielle Ratson wrote:
>>>> On Sun, 26 Jan 2025 13:56:30 +0200 Danielle Ratson wrote:  
>>>>> +		open_json_object("extended_identifier");
>>>>> +		print_int(PRINT_JSON, "value", "0x%02x",
>>>>> +			  map->page_00h[SFF8636_EXT_ID_OFFSET]);  
>>>>
>>>> Hm, why hex here?
>>>> Priority for JSON output is to make it easy to handle in code, rather than easy
>>>> to read. Hex strings need extra manual decoding, no?  
>>>
>>> I kept the same convention as in the regular output.
>>> And as agreed in Daniel's design those hex fields remain hex fields
>>> and are followed by a description field.
>>>
>>> Do you think otherwise?  
>> 
>> I have a weak preference to never use hex strings.
>> I have regretted using hex strings in JSON multiple times but haven't
>> regretted using plain integers, yet.
>> 
>
> +1, jq won't be able to parse such json.

Curious that tonumber doesn't have a way to make it work though :-/

