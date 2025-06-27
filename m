Return-Path: <netdev+bounces-201948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D4AEB895
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC9A1C241DD
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B9B2D97A5;
	Fri, 27 Jun 2025 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EKBztCp7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F071DFE1
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751029986; cv=fail; b=NFFvrm9th7YrfZgXlu3jZyKouxOWHE0spOwLQucXr0p3MVLHVYVym99zwdTiwBo1vwnnklaQxn27f2DnJtoMSDbCEzOmIE4+rHRYxVJbYCr57PhyM9qX0vOnZjOx+PrmWRr9pWafMiWiqS23CIKsLY3VV91aHcE/dAP5f+myuBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751029986; c=relaxed/simple;
	bh=zfHH2mRkGVQOKRQ4qfV7z3zTW7XKq2/pjh3VLDFEKpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lxu7dozeASc5mN1uciIPM17P7ezPTJJ43Z7FWoBgfXXFU1BB7ZbqIW2qN0kFvC5XVbLjMnoSCTcWgY5OvMMAa83Mdaw6FydktGWv/wJwpApye8TfPNp+7gGygHH1CqkxBaUbmWlF6Uee832FM9zXd9o0xseF/8zQOVY2+3HJ/2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EKBztCp7; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD9NGqB+0Eh9P6lIo6SEXxLA2DXS7MQ5cozPbHtB7jaBrODh7aKSGj4tAiMU2S/qMUZYSp/1KiUtSP6sKQPOVBV3QD1QjiTRs2YzymKUalHy5qxw8LeIAwBZYJ64Z56yT92RkYfOfTytTlIfP2BS8LhSeuQzVlhcWbAL4io2yg/oncdvVDyWl4ofs+cZx3v5/ZpgJKgXDkgrr5fUdNHuDzxDNq8iGehZtuixpNWkp0MwbIP3sGPdfe3PE0MC00/+QnFBkun3aZJYzLjWrtreXT22J4zahVUiLJo7wlwHqyUYXPMwceSHtZvARFKEaQeYNmSO9bBMGtY8zBDYUHSt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxSslmkkVHcjlT7dd3SBwzHxKo8t+StNe4gURTmhLy0=;
 b=Gq4jgz4dBfpJX+ER0Hr/Fun8sRXmPrACOIZ3p253csE9TqGkENgIDjDLUaQHiXEFRUMVi2P3sDWdX4yy606fM5XZXyurdySaOILjQ9NgOBlIyiCO4PHt92jshODViLXpganPSvEvuXHAjljfRwwGUrz70gxfHa/lG3MiVn2yVT3jUA+PpOnRkEwBaU1rcfn5KPlSLyBSzr/ZWeq3oEi+hxQNkWqXXjcDtwiWoIwJ2e1capBDwYdNlqtuInDuFK/XvHRANd0NkW0e55N+1HLrcDX/1WmqXF8tmgZ5HmfYxarNUrESh2+UIfnaOvXVXlzYL25IYwqsWHLuPEClFkttjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxSslmkkVHcjlT7dd3SBwzHxKo8t+StNe4gURTmhLy0=;
 b=EKBztCp7hLUmsr5ewYZGMBOWq/ZobRFLVhtDLYjMkIqrCYUL4wQ1V43eoZlNrF5zPO8B6nwXyk4FL6hqPKlDLMcLyLZpWjIs9JQp5KiEuuui1frDJk12jx92iZHdKu7WVaYvR7VHZlhEpmkTVhhqsZGx0N3WEqG/CdXzemetv8ojHYS4eyIFJAXJqiYXXwlp7RqBpx9LHVdTD2yLxEolZ21nLxkAVGqjsvd2Zy02PGezH1KX0kGTURTzOeZ1aZzVOdrBO0i1XR0dYjwItYE1IqWE/KURHtpcANFoIPWLRz7BVSUVeBZYBr3HbUPdny7ooWJDL1mziDCQe4iYD0ovYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 13:13:02 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 13:13:01 +0000
Message-ID: <1e9ee756-c11b-4072-b181-913255a1dc62@nvidia.com>
Date: Fri, 27 Jun 2025 16:12:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH iproute2-next] devlink: Add support for 'tc-bw'
 attribute in devlink-rate
To: David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>
References: <20250625182545.86994-1-mbloch@nvidia.com>
 <da9eb3d8-a2ce-4042-ac2f-9d0a0cb84fbe@gmail.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <da9eb3d8-a2ce-4042-ac2f-9d0a0cb84fbe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ceb189f-dedb-479c-ad83-08ddb57c57d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkhJZnoxZnlRSVVnWWMxWEo5djkwdlpwbHZ5dFNmNENzYXdpRlAvTjR2c3hM?=
 =?utf-8?B?MXc2ZTE0KzlCODlYaTBlR3F0Tk1zUmZ6SkRQNFY4eXJTY0dwWDVZdWJMTEdZ?=
 =?utf-8?B?TlNYaDRKeXZ3RXBpZkRMNFVvdkM4YXByQkk0WmxxZTcyM01WYUs0N1RtT3oy?=
 =?utf-8?B?cFBMYUh5aGJNTGVqLzJIWlo5UTdXSHQrQUlncTh5NXV6ZUI3YlVYTzBFZkNZ?=
 =?utf-8?B?QmtoYlJJZFhiTUJnVDZ0NENWMDBhcm5yMVQvVk9YVklKMlVVS3ErV2I3Nm1y?=
 =?utf-8?B?RzVIYUhMVFFzV3AwSm11S0draVE4eU4yeWpIK3JnUzVialVRdHE2V1VVams3?=
 =?utf-8?B?blR0azI1bnJnWFh1THhjMnpFVFBvdmttQ1ZuNzJJWGVxSkpwNmQ5QjRlMUhi?=
 =?utf-8?B?b0xQZEdTcU9QdHQ2WDhvMFQ4VWhuNFNMNjFuZEczb2F0b0Vxei8rQjJoRExi?=
 =?utf-8?B?R2tqa2h3ZDRpaDBwOENHajcza3pqTjAxNnIxbXQyRFk0MmFWd0lhRVBWT1B4?=
 =?utf-8?B?NjM5em51dlhHTGRBMTMyL1lvbFpzeW5XY0t4aUFYNVgza3Zqby9tcE9iREN4?=
 =?utf-8?B?ZE9SaGJKQyt0NDdTUWthaXhSTjl3Z2FsRDZyeG5RQVVHMVAxdkRWcnp5Y3Ru?=
 =?utf-8?B?ckRwanUzcWt3MmVickh6U1hMYkY1eUJVT1ZWanlZeUpDM2Q0aVRkQzVqWjhh?=
 =?utf-8?B?dGQwWVV2YlMzUFk5b2hHR2p1Mk5QYVRzWHRVbktpQjlzUzB1blFPUWg4VWtm?=
 =?utf-8?B?UWtNRVBEenRVb1d2V0RZTHplUDFybUtNSnQ4Z0U5aE1KQ2VZRHJlUFpvaG95?=
 =?utf-8?B?bTBOd2RhY0psNkdHVzFjZ0ZUVlNiNEJrd2QrQnlvOGZ2NjdLTzBCbjl6TG1x?=
 =?utf-8?B?eWs1Q2t3ZjNlN3RJR3ZJWHpyZkRQZFIxQ0FMOHpJSjEwaGpYUkNYTnFRS0U3?=
 =?utf-8?B?cENiY2NoMXZOWXZFVkhMSWF2bkFZSk5yR0NadVFZdTF0OW9zNURMTXZsMUJr?=
 =?utf-8?B?TjE2ZzBQRUJ3SjNER0l0WDRGMkpEVmMyNC9Zd0ljNGlkQmt1OXFLN2wyWHQ1?=
 =?utf-8?B?RFRZZG11THYzTktyNHhBY1JjSjBxZ1Z5YlB5cEZVSG9xa291c2taajJnSUFq?=
 =?utf-8?B?M0pOSjJ4anBnZEZ3V3J5SFhqODRpTzdDUGZqZGFmZUpDc1locVJlcFVrZTUv?=
 =?utf-8?B?WXo1aklBb3cxZUJ1K1M5UVp1ZU1rTkIvT0xQNHpORndHUzZkeVdhcmFlVi9T?=
 =?utf-8?B?MGtxeEt1aUh1ODR6TFhpYjh3aEt1VC8vdDFUaXFmNmJKb3Q3enU4MTdGbW1K?=
 =?utf-8?B?VSttVC9XTVhwUWFJeDRBei9zT2YvOS9QaW9kdjFORkhIZnd4SFNaS0p6ME9S?=
 =?utf-8?B?R3BScGVyWENmbWNhalBrUzFlSXBUYi9jbGp3UWh6ZGMrU0dsZW03T0NuOXNW?=
 =?utf-8?B?WGkxN3haLzNxTmFBRG5NSk8yeW9pRTAvak9vS2MxaFpWSU0vaFZraEJnUzBO?=
 =?utf-8?B?aUJnQVMxRS9pQUt6ZXFxSHNSTDZpZ2YxNURHZlExQnBUcHhDK3F4OGx2Y1hz?=
 =?utf-8?B?Y3YyaDdCRjhXWXVacjUreFhxZUpSSXV1MllKS3VWL01XOWR1c0FzeTRmYWJ5?=
 =?utf-8?B?UnJMSU5mdTl6WjloSWEzbTFMbVVSK212aDFDYXVLM2tiNHpsVWVaMWN0dnlS?=
 =?utf-8?B?YytaVlEwQUd2cVpPbnBMcytxMmpVYk9EdWNhU0NTRU40ak5wMHFJL1NjVWJO?=
 =?utf-8?B?RUtQLzArZU9ibGovbkJBVlh3TGxVVnZIWEFWa2QrWDh5elhsbDV6VFdPY0pN?=
 =?utf-8?B?dk02WVU3RnZCZWU5aHFhUFIwd3grUXlzeS9EbVl1MVo0WGlSS0tUcVdod29v?=
 =?utf-8?B?bHRMTmd0dnBTN08weWdmcCtRN2NkbEFadXlZeE5WU3Zsa3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUc5TlY1Y1dUOUk0OWk0SDM5eDhTZEFWYk9RaGY0R2R1ZklvT3JFbWZNQ3Zq?=
 =?utf-8?B?V1dURXo0WnJxVndaL0REMElCR24wQUFVZk90UitqdXRaUzhxdEd5TDJ1Y1hE?=
 =?utf-8?B?NmNpakxZbDRTRjdIaDZFODBPRWptUHpteW9LV29NWFN0MmZXcjVRcEw4Qko3?=
 =?utf-8?B?cVFTclhHZkdBS1F6cjVQZkpkeTJ0Yk1hbnd2TDhtWDZxOHYwTUFMSXI4ejhD?=
 =?utf-8?B?aCt0a2FTVUZ4dHE2aWJqK3hSdUdSR0lveDJqSkNNS0gvZXAvOEp0czhtT0RH?=
 =?utf-8?B?RE5qMEFlTHdicUxjVXBORVU4RW1QWmlodWZWTU5iK1NuV0c4cDdpd29saUc4?=
 =?utf-8?B?YnV1UHZ5VWxuS2laZkVGYWpNR3RRY1hlMEhDeEhReDdtTDYyL0cyTUg2czFR?=
 =?utf-8?B?WjlhY2t4SEs0Wmd2SUtIUGpueHB4WXJETDdoWVZYZ1pRZzdSRmFNRitPVjRJ?=
 =?utf-8?B?eUx4M1BtMyswcThFNEJCQ0t3Um5pZ3JkeFhPSE9jWUMyOUt3aVpabzVWbkhD?=
 =?utf-8?B?dEdFQmxXeVpsUXJOSVFyd2E5eVpkamVLSU8vUDBMdU92SUt2d3Rpb00rbUtD?=
 =?utf-8?B?OUZ0eW1YZC9nU3g5UUhVYXYwZXFnNVpiS25RU3h6Nm9MR01ZYklZTENaWlV3?=
 =?utf-8?B?OHA3UVZXekhzcERJQ0VUanR2OGxLZitHVjRzbjZyNTBEdzU4MWFmWGprT0NZ?=
 =?utf-8?B?MW9pNmoyenhWTzBsUHIyREd1dU5XZmtCMDRqdVN5Y2M5UnZIalBlb2dpMFJS?=
 =?utf-8?B?RWhiRjhwYURwU05xQWlxQ01TenpPWUxRYTYveTlUUW9yMWV6RDRjWTh5Smc3?=
 =?utf-8?B?ZFNJbnRHTjFCc0w1MlFiZXVaR2dpSVpFcURQaUFJZG1Ya1dhdVppMHVGa2tm?=
 =?utf-8?B?MXBVRTJaM09Nc1Njc0NOYzVtbFgwc1VHcTBuL0hqejBNTGk3bzdzTHdOQld0?=
 =?utf-8?B?cVVXL3FLcmxQTnlBalRvWGp2OVA3TlAyNi9GTzgxTVhPcktsSldCUEVySllM?=
 =?utf-8?B?dWRHWkVwY1hXVU0rZzhEaHpjNGFXVExpTEFuRDRubE1PNkhMekJJS3AvdDdH?=
 =?utf-8?B?SVNyM3ZDM1lDM0NBQ2FHTHZrZzEvbkIxdnlmRVZLZmw3N1R0L2U2VVNlSHBG?=
 =?utf-8?B?UnNVQ3YrV3lkY2o0bDRtcElUSmxLSXdFTUI3b0loaEdYdjUzWlVQR204cHdG?=
 =?utf-8?B?YlMxeXZQL09PZUdkRnBqK0lZMm13U1l2NGJUd2F5UkxTYlJaM0ZvWUVVWUVR?=
 =?utf-8?B?YmxZS1JIaGRFTVFzQVF3YlAvejZCb093SHYyUStEL1dpQklIK21LaG1XWlJa?=
 =?utf-8?B?T1E1Z1ByTEJqenhDbFY5SXYrSUQ0Tlg3QmM1dDZOejNvUXIwMnFvV05iS1Bt?=
 =?utf-8?B?bGJTTnJqTDF1YVRXeEdSM2RyL2s4M21SN1QyelM2SjBVTzdJNHMwUm9YczNF?=
 =?utf-8?B?MWwwalVRQjg5NFZ1OWpiaWU5bWVmLzY5c0NUOVJtcExyUGdUeHEvTVhMTnRy?=
 =?utf-8?B?ZkhoazVEcndqYWVTaS8rQlg4RWdyMkFMYzBGbDNXMFRXSnJrWXFQWGVLQlp5?=
 =?utf-8?B?dlM0Uzd6UnIwNjRIUlFqK2pHN3ZYa0cvb0grVkRZTW96aUVWQjVlNzZUR1Ir?=
 =?utf-8?B?c0gwb2tUV21QQ0d2TzlzUHM4SUhDcy9ZT3NKeTV0REM3VmZBSWlub01mTUNR?=
 =?utf-8?B?U2wrTTE1R3dxQTJ1YldaTTBXMnhIT282b1BOZE1CeXNkRW1FbWkyQ0EyYXNO?=
 =?utf-8?B?RFZZZW4zZnlramNDb3BndUtMK2R0cERWRDVNbVhvZkplNWtkaWFYcDJrQXFw?=
 =?utf-8?B?ZlExVUtMaktBZFkxbEZQMGgrTThxMWVUWmp3Nzg3cjd6SmcreDF2Ky9JUG80?=
 =?utf-8?B?bmVzeW1TYmdhcHhwVFFSSzc1K3JacldBdGx4Mk1jTzNYaDZKa0VWMW9NU2JY?=
 =?utf-8?B?MER5SzVTWGFVNGQrOFlLdkZoVWFjQ0ttbDJqclZseUhmTGZ5SWQ5TXBoc2V2?=
 =?utf-8?B?dmxCdjBYOXF4M0M4Q3hvaVZuZ3lERkRuRVUwU3hqTFpmT2NxejF5bDhVWE9a?=
 =?utf-8?B?aGtyVHpteDNnU2FTaWNtVTNPLzF0dkI0WnpNQ0x4Z1lEbkR2WEZxNXJzSFo5?=
 =?utf-8?Q?t6perBoLQxrGwqHf81m84j9D2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceb189f-dedb-479c-ad83-08ddb57c57d7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 13:13:01.4331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjR/vuHkvFQEb6lwfXJxJBAeJxKcQZsRX52DpTvu7njLt5Yj8/vAgZC3xfbW/P29gHaLtwmHtYXeSghLKM+TKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004



On 26/06/2025 4:42, David Ahern wrote:
> On 6/25/25 12:25 PM, Mark Bloch wrote:
>>
>> I've incldued the header file changes in this patch for ease of use.
> 
> uapi updates should be a separate patch.
> 

Hi David,

This was an RFC, not a final patch submission. My understanding from
Jakub's comment is that he intends to pull the iproute2 patch into NIPA
alongside the kernel series, even before it's officially accepted upstream
into iproute2. Once the kernel changes are in, we'll submit the iproute2
patch properly. Apologies for the noise!

Mark


