Return-Path: <netdev+bounces-114439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7502B942987
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988861C209E5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A6A1A7F79;
	Wed, 31 Jul 2024 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B1JrrZ1W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B89243169
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415722; cv=fail; b=N/GCfMl83sZWVjg/ML7I4ndukB9TIpdGDlupF2zBPaBdylcquUIywNhRaXKxDwEGMr8AJLMrfo3n2+YWRWHxzCe/6UJ/qulo8FLH+1aOzHNmNQNVZUbnpgEeT2PMQE9jvrBd/GOCGGOQe35C8jt5Gt/1lKGNJsJVPtUfrMEV4xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415722; c=relaxed/simple;
	bh=jvIEuoW9BAVOBEAPYN0ciEQHfvIa33zuAoozrLgw8m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gqqKxW9nXxreUtqzoovn9Xu7nlaWTNtX0N2lCkO07CncufW3G9Xm9CasVmvfwDd/R4IMKiq920x/94F4bXFDPoEjaqq17447dISWztptKJROR7ObwaoFUwe2VB1Qj0SNT9wDFhDwb5CyvSTNvZdz9Dt43irqt/LuJ5EpQKbkTiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B1JrrZ1W; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mf6OKUmqr4Op0I+7Co+L8nkyBhgkI0Ee/PoH77Na0S8IP7Q7xuDZgDHKz8hOmrGi+DXPqz1HyE4fV1btofBOvHzy7VPx3co+W9qBHs4516SrGm+kEeJ0gIod4Ajsq5sCWCfB4PRE9t14o6p3BGP/vtdi0lZ/+CpnaJpfTG1z8893gKjldmIrk90lrpiO6RFHNg600NNlMi6X6g6iK7ZucFxjmp7cXAEFVRPZtboHxl33PAFJZW6CD4a+DNDo4UWIXI8W5soP4LjqacYutuJ4gAulo7mNBC3rheaxmDVD3pMaZHH9/9vVbdz9u+acxHejC9AQxLifFp6ieabOPTd64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvIEuoW9BAVOBEAPYN0ciEQHfvIa33zuAoozrLgw8m4=;
 b=X5rQ//fziwZPT0xLxI4aPWyLQC3g09dhrWQ6xbIqr9GZpOVK+P5dlIl3s/R+kk9V6Bhmokdy83qfQ/KOjH6Jul8vZ3haEj373DPcCpiZBt962dxjALieJnGkJlDvIW+3KGNEVj+nFbQMeeXvuQSsArWJF/ULj/+PzPiY1uv0NsDElHIdgW/byFiEDTI0SuBAN+RpllQGTcf1CMLPOp4w//lOVxTsfWtULAQGLF7c+PICbCWvlC1ju41IcSD6uF/x60W/av4GVJXBpwqixbhoQGz+PCJG+gC/kg8RSWiFW0zlVdrj/HUcgRQ9RMW+KndYRmEXIYQkWhZ1qRjjJBNPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvIEuoW9BAVOBEAPYN0ciEQHfvIa33zuAoozrLgw8m4=;
 b=B1JrrZ1W0S1ISvh8NL5fSv8QxkdYR+BCYZoPmDE24F6C9hRvcaDlmBWo0pyD1LDxMrX65To7fKIsYqDIi5RGJ0jAMUKrkXoEj5f/GTxAuTvVyGbNLExWOey0vKWH8sir4yfazjoq991f8frmkq2KhqYZFWsptJkI5z9Sx+IwSU5yvkq9HNKMN6vg0P2kCjl+p1oAr0PSMmbbzrTLg9afGjGwrtjAW4O6IODIJsCR1ilbz6Y2Z7jJO8EIa/p5hUJwqlOrhQO5x3mrK7cCKpSQpHNUKvDE5fK3PEqmu79RQUcZoWELtJiw/WW501m5t5/NMLqinyiXyHys6N0OV17Vcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 08:48:38 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 08:48:38 +0000
Date: Wed, 31 Jul 2024 11:48:26 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
	Moshe Shemesh <moshe@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	tariqt@nvidia.com, Dan Merillat <git@dan.merillat.org>
Subject: Re: [PATCH] qsfp: Better handling of Page 03h netlink read failure
Message-ID: <Zqn6Wmobm86lfHth@shredder.mtl.com>
References: <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl>
 <Zk2vfmI7qnBMxABo@shredder>
 <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
 <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
 <de8f9536-7a00-43b2-8020-44d5370b722c@lunn.ch>
 <56384f82-6ce7-49c8-a20e-ffdf119804ae@ans.pl>
 <ZowP36I9jcRmUDkg@shredder.mtl.com>
 <df1d503f-ec6b-4fd9-9135-50241325fecf@ans.pl>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df1d503f-ec6b-4fd9-9135-50241325fecf@ans.pl>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: cb159709-1346-4f2c-04c8-08dcb13d9203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWVCNzZVcThzdFA3UTRJdlJvTnlqOFVPTlVPUUJLaUNMb1pBR2NyTzVPWFVR?=
 =?utf-8?B?Njl6VkVYL3JCVVpwWVhnNVUxdzcrbVRXV3BnY0Y2ellLR3ByQk5GR0VMVitN?=
 =?utf-8?B?Uk5MWTVYVVh2b0ZIemV5YXM0SXh3TzBmb3BTT2crY2hzWWZUdm9DWklJT0I4?=
 =?utf-8?B?bm55dkVLRDFSTlhBdmtDeVZjUzN4dXdPWUN2NjYrcll0V0dZTUhyckRjQ05s?=
 =?utf-8?B?VHUvbkM2VC83SzJBV0xacHVWNktPZllQcjNVQldhQ3YzQnRWY3JGVEpwdHNv?=
 =?utf-8?B?VEF6UVZvaXcwUVZnQlV3cGZVUG1vQnE2dUtuekZSWkJZWHU3OHkzdHpFbHV4?=
 =?utf-8?B?Y1BjZHZzak1wUVZlRVgzVGV2ZGtZNHRIZE1zMzlNTkJycmNKaDJPUU9XV2Nk?=
 =?utf-8?B?eEhNVFVmUUJOZWF6eTFFVFdiUnQxVFBWNGxwQUZVL1dKNTJHYmRWNVZNbWh2?=
 =?utf-8?B?WjV0Ly81R3FPcTNnaElDNHhzUC91SGNFTFNEQTRCSTBZYWliZlFvK2JCd3Fi?=
 =?utf-8?B?dk5PZC9kZVlyaUFGN1hTVjBGOTdNeTI5SGRKQytCb2RGMjdIWUFnTlliQ2VW?=
 =?utf-8?B?clVzdFpLVUhydFcwTVBzNE9nS2c5amhjZjhxNTFFR3hZK1BaWUV5dyt2Zjgv?=
 =?utf-8?B?ZmpzdnNuOVZ1WEoyVEl2c1ZmM05CaUo5RDdTV3JwZGFVVDZNMU95VHQ1RE5l?=
 =?utf-8?B?QjFCaUxPMnVYdmVLUmlvUUt4TFpsVlo4dVZydFNINFk5L05Ld09zMDdJdFNm?=
 =?utf-8?B?STVmZUx1SGQ1S25zYkJlclowR3FRbS9hSyswNWF1S1c2QkM1OEU3VGFKREJM?=
 =?utf-8?B?azJZcnFycTN1OGh0eUV2RU1mQVIyRFR2b2wxdFZBTDg5RWZNWjdJbXpQZjRs?=
 =?utf-8?B?S2MxeWxOeTc0OWFCdHg4VzZBcFZUTCtyNlJIcnFFZkZpMlpqeGR5b1FMV0xa?=
 =?utf-8?B?ekM1UituamIzMGllaVZTYmFJV25PVlpqdlpvRWZ1b2N6NVR4MnhqZ0pubnZS?=
 =?utf-8?B?ckxjU2QrSXY5ay9XOU5GWk9SWDl3RzRuZ0RUMDBVLzVVZUJMZy9GUENOT0hI?=
 =?utf-8?B?TkpPSFNyVkFjaWFRZVpvVWFzQ2kyK1NLMXRPdHJFMW13c0tBOUJrNzIveVhi?=
 =?utf-8?B?TjZjL2grZDMxay9CSzFqdHBoZ0pLaVpwNGFheU80R1pMUHJXc2JTeDFOeHI3?=
 =?utf-8?B?VXNTMlAwajJpTlUxZStzV25mamQrQmlJWUxmUWovcGs4WlBoM0lEK2czbHli?=
 =?utf-8?B?NkpoWUZmQzVaOE1OQ21YTGJFbXVjSkdCM283V2NOQ3BIMUd6bzBvMm42NmlB?=
 =?utf-8?B?cTFlRGpTYm5NcmhuQXVjNHV6MmJacDY2WFBqZVI1WFRyK2xPMjBKYklOa0Fz?=
 =?utf-8?B?UU5MZWtnc0xuQVFYUkFYNFFYWUpCR2xDSDlXdmZXOGZGVHdQR0hlRDF6Z3lM?=
 =?utf-8?B?OU9CbXh0S3ZhbEs4dDdZSEpmWFBQdTZNYlVqUVdEY0tscUExemRoK1VJRnBt?=
 =?utf-8?B?d0xQY1VPd1VjL0xDbEFobW5TNnFzWWNEZVJaZDFscHdsWXZSaHZHRVNzRXRE?=
 =?utf-8?B?RnFTaGk2d2xhL0hPbjdnMmNWZVY2NVgrVHovQk9rRUFlYmhPU0JvSHExeWY1?=
 =?utf-8?B?Wmx6Zzlla3RkZWZuUmd4QUJuczNveTV2dUdjV3JtUTlRN1dJb0VkdWNCUi9x?=
 =?utf-8?B?MVlSazJLQnlGYXdwdFJXRGtlTjladjNjUWQ0TjRLQ0trWHFNT29nditEMFN0?=
 =?utf-8?B?czdkcXgyeEh2U1VIQmo1b3lHa0xrajJmTkdyYTRlTlJTQUdLVHpRZkl0SHBM?=
 =?utf-8?B?bUVEa3h2NDJVZ0M4dytRdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkRXK2x6UzF3Mk9JVVF5ekVaUERhSFlQZFBxZk5DUEFIVGc5Ui9tS042SE1w?=
 =?utf-8?B?SzJyaHE3QkZRcVRiZW5kWkl1Z1dKeUk1ZCtQZnczWnd1UGJSbFRGSmlaU2hm?=
 =?utf-8?B?YkF6clFGTE4vUkNlOGRrNTJ5eG9HWGdwVkVhL3BhVEFKSWZGTlhuQ2U5cEVk?=
 =?utf-8?B?bHZKcXNWUmhqT1g5eTZlaC9qWXNiSERnSmFMV211Y2taTE9lS2NQbVNQVE1G?=
 =?utf-8?B?L1crUW9kdXZCakRabGE1SnZ5cHpQUUsvbFFhTXZucWNRNFMveUJvb0pEdWh2?=
 =?utf-8?B?WGVFL3VJcEl6MUtiR1l3N2RIQ1FDNDdEOFBoc1NkSVhKRTBYYnNNSFVsNEFU?=
 =?utf-8?B?c282UjlMY1RSNERibyt1cGRSdkN5bFordUZpNmtJS0FsQXJsTFJhRUtnNVFN?=
 =?utf-8?B?NklBVThXb2hvRno5Q1BCUDY3cG9pT0FxU3NVLzNzVEdGSXllRFpKM2ZsVkRY?=
 =?utf-8?B?YjV2NUFrLzl6T2ZtVVhoTUc3cXQrTXJNRm5va2xVQ3NQM0FLVnFnRnNsV3Nx?=
 =?utf-8?B?T1huM3dtZlZZZjFkT2NyZzVUSXprcnd4TW4wSDdiZmdIR3lIOFNVaFpsb3Zi?=
 =?utf-8?B?RjZyRWhQTzVYbFYwOWpLbHNsZklFWDBCZ2IzYWV5SnRHOEtoTCszR3l2YkU0?=
 =?utf-8?B?ektrTUtHa3RQYnhEdGxMdk5JVGRNMTd1em5kTEMvN2dZeU5Xa0dZQW5CakN2?=
 =?utf-8?B?OWo4QU1VcWJBTnNIcTU5NHYwTlY0T255S0pudXdXRjB0WkgwTnFuVWJ5WGNh?=
 =?utf-8?B?V3Jza3greUZ2S21QcGVUQjN3OTRsSklWeGIySXUyVG95dzFqTTZydjdDNytX?=
 =?utf-8?B?QUZRZlB0RzBsekJMNTEvSGQxVzdqejFmMThRY0JwWE9QWXhITFJHZVRKRGVW?=
 =?utf-8?B?Tzh2VXFmR2FCVWN5SjJBQXQzVDE0L2ZrQ1VGbUxob3p5OHg3S21saEhUM0Ez?=
 =?utf-8?B?dUY4YXhray9HQ1VESWtyOFU5cDd2YW1OUVo4ZEtQUVlFbVVUVjZZd0hmSlZv?=
 =?utf-8?B?bDZ4ZmhwZXNiKytkV0VLcldaNDBzRGJwVy9VdGN3aHRncFZiSExHaVRkMlVG?=
 =?utf-8?B?K2d1SCtVU0lQLzBJNVE2dHo1ckdsUVRwODNaRmdKbXZteWVjR29vSW9jQVo2?=
 =?utf-8?B?STg3eUdsOGRBcTBUdkg5K0xEa25GWnV1UmdKeVFwSUEzZHhuNm9iZDZBdEdv?=
 =?utf-8?B?QmQzMjBpRzBPVDBsTDRhOVNJT3FKbVErdnNyZVNaTHR5TGlnbi9XbGJqZU5k?=
 =?utf-8?B?dmdDWWUzR3IyUllRMjAyOHBzaDZkdm94dUR1MTF3ZVNhMVEwV2R6ZFNMUUNz?=
 =?utf-8?B?dlFZNUxONllNMVpZYVdVYk11Ui9XUXU4MHlJRHhmSldEakJOdEVudjBnQmNH?=
 =?utf-8?B?RzEvU3FIVlB3bTNsa05MaGdLbHM5b3Vnbm5ETlN3N2tlbDUyK2g3TGUzcmt2?=
 =?utf-8?B?NUNtaTY5V2ZjUXBUU0xZSk5CdFkzdW45SUM3dlk2RWtORUFFWEkyKzl5Sy9a?=
 =?utf-8?B?cE4wYXJ4SWxlc2o5UDVWZXg4ZnhsSnl2Z3JwZDlTb0lTdElsWnNrZW1OazVM?=
 =?utf-8?B?TmpWTVg4bkY3UE54RkxmUjBrWm1RK0ViRnNqS0pUNUNEVktjWldmcDFrWDlZ?=
 =?utf-8?B?ZUZnMDBKY1QrSlhuN2M3QTI0NWkzQlZ3V1BRUGNDMkpqL2NSQ0hFYWM0VjIw?=
 =?utf-8?B?WTRzeUVLTEtoRmtjVGJYWU9LYVlWOVJGYkhhYkdkRWwxMDh5YndPU0JKRFJJ?=
 =?utf-8?B?Y3ZGNnQrTklucW8zWTFvZVhKdWxmakNMNEltVU16czY0YTY5WlZrTDdWMElF?=
 =?utf-8?B?a05WTVZzb0lseCsrczB5SmNUQnI5NE53RWFvSVg1aEd0TEJOcjVTRE9vK0x4?=
 =?utf-8?B?Ti9CQ2VuZmNId0xUVGZHZnFqTy9WR29zblZEeDVJbzgzSk4va2hPbXZONVE1?=
 =?utf-8?B?SHZIR21jWW1DVWdFeVJpalJDMWFhUDlkdjByYkZQU0huN3Rzbkh2MTRvb3ZM?=
 =?utf-8?B?VmYvQUZzZjBua3NWR3VpWldldkRXYVZBMDRiVEczamU1NTBJcnk0eGdPWGpv?=
 =?utf-8?B?eEJnZUlad1d1NjFTQURvK3BNVkpyelA4NzRsRWFPYis2R3U4blBqVW5id0FX?=
 =?utf-8?Q?zbL9DfDpBJ/CbsDLtrhH1wLhH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb159709-1346-4f2c-04c8-08dcb13d9203
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:48:38.1168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbBjUHvI1+eR6Me6tqD6thFvQ1G9HyyIOF42WVUCKs8Amy2HJ+dOyQzvFwnM/8n5RnuS8tFQL3zy2TUmABfEhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471

On Tue, Jul 30, 2024 at 05:55:00PM -0700, Krzysztof Olędzki wrote:
> BTW: get_maintainer.pl for drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> also returned "linux-kernel@vger.kernel.org", should I be also including it
> in the future?

I never copied this list and nobody ever complained, so omitting it
should be fine

