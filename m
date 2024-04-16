Return-Path: <netdev+bounces-88319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68F78A6AE5
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351831F21705
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787D12A17F;
	Tue, 16 Apr 2024 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TY0rwblV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2541292D7
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270540; cv=fail; b=WNtFJosgezHRAUC3L52kZAg2+kAKlmApfoF5J6QKTGZkqG5vR3d9aHYfxt3LgHghNvynbFwT1iRhCwHo8MHvRBTLB4PJsS8kvkL77gFiGEiCPyACsoiwypYWf3gqEsP9sy+5tKWl76vyou6MyXZP6PTPNI48MdaDs9Ejyv2irlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270540; c=relaxed/simple;
	bh=7UhxP5bAq0+9j40PX9tld+XiLddDrc4yxg6ny0IQP/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PP7YLe9EdW/kyHHr5I60CVC4HP2HuLgpe/Veo60qZsnKcKjRwXPiHTfPcgVgtQj0NoOBb6bQ6lsJmVUEdwsa3K88JvM+zEGau1KTZm9r5sOU4k6vKfkHm8KVpyFodtdmEers3Jv7PHTRROv9dsf4tgD3Exk7dy+/1yagRbIRvT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TY0rwblV; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUvpnmZ4+afoXxpqUekTEt1tBMwK9TfrqFqksEUusZMOPESjmuQYb+aHJsnfpmaE0M6iVP8bK+gwlO7Q0yZHU7VVuBQjudd+FVAMOfDomK7ceQRbIqyhjwMNyYeOKBQjlkQMjwUJXa/XBG9vWC47gJNpp+APnb0+m+3yHpzJEXcwkc8OI1nX2E9dyoaz/jVqL2a8j1hJzE1Mn7cHjuz6mlYLpActhE6WJ7pjGCXmYKml5lFyr6Uq1ZGzXR17UCrL2GWO7x6tKubEySykOqbSZ59xmc/4wuN8D1psP0G/ED8lLcEq7Hf7IfkZ8FwPNE3GuadvUiqyMoT8Nx/4U1NCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk+gTYtkCMfq7pz9TFvCAlmtHrtVTe4mfEAqb204I0k=;
 b=fWo9jj7ipnCpLnU+VwKBQg8tS86g9xDZ55ctQVQBr89sIPcKMjwHhJQdc51Aq75FlcPcTSWuoyKQ2O8QK/WbEz7P00I92S1C5ZcVjH3xsBrbitMt1kXdL+trIvKFdpSLtLiEbRRl7L1EfzEBXr2H1U4vfvzeiG/dMEH3u9/mIDQj/5A5ioFHTID1xG0SpL8vmj1pwZLNfW89JJwV780tsW0pIv+iZzzbxPauNSMOW76FLUCMxk2IEk4v09l3GefUHCMvB2CVCmWV3pgxySUDJMlRVcDTknJc6NBBepv99IS+4ciTLltjXTkrXpCpr0TYKjUq/e+oIEUWKosi9woR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk+gTYtkCMfq7pz9TFvCAlmtHrtVTe4mfEAqb204I0k=;
 b=TY0rwblV5EPdE2CLLIQ6cyhurxOR4ilMdzvE0/fe29M7O46Vi/BcBM8H8Kz+L2yOPUYqIn/D/nECnp/O6PeiC6aa+f9xR4PTBAQcznj5oPfilZQuHpCpntQTldybYUkaqhA8fpRnU4jzKnIEI5uaWVLFpZz3P0gCv2dp4tbvv1RFChQqgEicxUMlTwds3q4JcsXKG3UOhn8egx4CuYR9FUzzfwRn/D7HpXmFiaLHVlVgRPDY/jtI+fORG9QHjN7fFRE52w5UpCHYvr/1yjCYqYzwyMlu0yd7qyIxsB5HhdT2YP9l2KakKIiCk5WbjkjW7Lw8Y2eIqqFELCPsY8E3FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 12:28:55 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::10e2:bf63:7796:ba08]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::10e2:bf63:7796:ba08%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:28:55 +0000
Message-ID: <6e722b57-7fd9-40ea-8dc5-0ecf62dcfb66@nvidia.com>
Date: Tue, 16 Apr 2024 15:28:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: mlx5 and gre tunneling
To: Jason Baron <jbaron@akamai.com>, saeedm@nvidia.com
Cc: netdev@vger.kernel.org
References: <c42961cb-50b9-4a9a-bd43-87fe48d88d29@akamai.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <c42961cb-50b9-4a9a-bd43-87fe48d88d29@akamai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0034.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::21) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c001f22-c793-47fe-b7b1-08dc5e10c83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EjbqYCjnMsGoGcYvQuRSktSQzPiqp31jXcgcIstxmHQpOFqtW4gfVHba9lgbXbZQO0y9bwytr5nG6vBJN25mF/zkgLR2AzVSXbDuPeansLV6Uz5+d3hScmphvViSLdnOiK8kZ7TmKYSsHsGBnCRQ3H8aVKI12wfcWPqvvGvro5y6ajttYEvlfvVMzxgkXAW7vgtrWt+b0W9AIL7YaS1fvf+iijbQ1Ufn1ZwKHM0KE/5Wb15t3FS2wIdxjsUkPkNg7wa82sodYuWJscXNMfuo4Jw8eUytmD297yy8i03aHtk/evC1N/6bdj/UCjQZB8est9B3x2fCHUM8qZUqK4Opp4NMZiwHBwx380YAghzQw3uphk3elktbLv+lTJkHNfUunld43iQxkpJKnLSwRRT1EBXiFKuhohDtot5BepCQ/7eiyaVgrt6pZqe+CrwtYrCZBXXIow4Qd3MsXt+Kj0Ly8Ka8NZRHoqCMPco3ZsW5YOXVhmmoV3qPqNobUH9GS5AYT2Djcak2kYh0r+vt0Pkc9LeQiiG3bcJ2hNL739G8piFQxxnyyzYLL7xwMhPHW/Ecl4KkjvXULx+rYZ1PXwDaFa9RxyYzc4VQEmA7TGtfOwsXMu4xaRUTwxNjCwUQp9FpVEvBNSxqtGlbHw/23NIu7mu45nFIhbeesKLKIcBMIf4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTF3Z1VIWncwTGRlZ2I3YWN6NFFFNDJHMzRodmNXTWxTSVNmanRrbzdzV2d3?=
 =?utf-8?B?emx5ZTJGMkdGUzRIS1lzUGE2ZTZkQVMrMnZ5QzJkSkZSNzBvSUxaNFZXV3Np?=
 =?utf-8?B?bkd5anhlSTVkcklTYXVzV2dTN3lxVDR5VVM4UkpxYzdnZ1pCQ21sb2tEYjg4?=
 =?utf-8?B?MC9XQ0U4VXFoUlpOVVlEZnR2T3BpRWoxQk1lWXh2OWNkMTlEZWdtT0sxUDlM?=
 =?utf-8?B?dlVQaWVmdzRVMGwvOFA3NDkxZVJNMHZSZ2JBUHEwaTRpMVBFN0l4VTFQVjlr?=
 =?utf-8?B?V0RDMm5hSDNJaXV2T1hFVkovNURyQ0RwL2xMWU1HR2pFZUxYLzh3OEZiWmVH?=
 =?utf-8?B?UXF6OTBGSTJvakZNR1AwdHRpL3BlcTNsczkycWsvTm9CTUZXVmtqRFo1Zmxk?=
 =?utf-8?B?VUZ3T1hHejRCdUtOaWlwTUQ1bDhsd0M1QlNqb3haN0xFOUE0ZVJVamJBWWVC?=
 =?utf-8?B?TjN2cURnbEJRR1R6RXJSemExcnI3aUFDQ2hyTHNFSmVZWVlKRjRPVVcvbTFM?=
 =?utf-8?B?cWVBUUJxMDFnUS9DM1ZkSjQzL0VDRk44TVRXRE5CdnN4UjJiREpRUTRyWXli?=
 =?utf-8?B?S0pZSXZUUFBXNVlDNXoxL3Rjd3BRNE16aW9PZ0g4Nm1RWUR1WU1NbmFLOUpk?=
 =?utf-8?B?ckR0ZXRnd01MT1dDOG4rMldrejY3VlpMQnpZdzEzU2lRbEtNai9FcHBYZXQ3?=
 =?utf-8?B?MUt2SHMwV1FmQ1MyMm5SOGswTjJ3Y0JWNFlnQ1czb0ZuM0ZTcmQwcXg2aXpj?=
 =?utf-8?B?azF1MjNQV2FzbXZ5U1haN3pVY2JXTUxId2piKzVtL2Q1L3kra2lWK3BkWHpU?=
 =?utf-8?B?Ri95THZDU1dtb085TGQyeHN4S29pZUQrbnR0NlgwQUVhdGN1WXdaVExCOVFB?=
 =?utf-8?B?dkwwQ3k3VGdFMXRwOVBRU3BMdWFrMGk1dlZGbDV1K1VVbjlMNWtlc2FZNnV0?=
 =?utf-8?B?azdZcGdac2c3c3ZORFoxc3ZpV3BhcFJLYXR6YldZdkNYMzRFejNJR0Z5TFJS?=
 =?utf-8?B?UlRLVTZvSXN6WTEzMlpocUpKQTZDbXRORTB4ZjljcmlDTU9HV2FzNk04WTl5?=
 =?utf-8?B?RzBnWVpJOEJpWHpQSTZTY2lhQnVYTDBpUDZienhhOTFXV1VFTzZDVERYVDVH?=
 =?utf-8?B?TlFTWkNmc056RmE5b25ESzAvVTdKdU45Rjh0akdZOU9hcDN4WWQzMzRNZUZj?=
 =?utf-8?B?NGRTMGh2WFJQeEdxKytaRi9vdnpSOGpFUjBkZ3crVzBSa1M5UFMyZlR3ZFox?=
 =?utf-8?B?UGpYdWVzYTJFNk9kYndtRlBmNEZvT0RHYk81WXBCNUF0aGRvcnI5YU1sUjdQ?=
 =?utf-8?B?NG5nR3ZTYU16aG9oYmZtVW9pT2ZiYTVqZTlrNkY1VlFmVHF3elhCU0wxelRC?=
 =?utf-8?B?OGI4RzdhWU93cnlmVlJOb3l0Ly9WK2dLcjN1dzZsWldOZzlodTh5eDBxQ3Yw?=
 =?utf-8?B?WGxqTVMzM0E0MVppTEZUbFh4OGt2Z1F3Nit5V1hrRFhZZ09OVEtqMUs5dEg1?=
 =?utf-8?B?Wm1CendhdGxSU2xXOWtDUUlIS0tlTi9kVHE5V2g4UCsxMENiOFRZYUNGTy9s?=
 =?utf-8?B?b1BzRnpHbThGdXUraWJGVzY2RjV0eU9EeUc2RnJwK1lvT2p6TStKNGtLa2Fl?=
 =?utf-8?B?YURsRFlIWVNQcjZCZ2VyQjZTNTVHZDFaN1BtRW84NWtIdndpSXhEek5MaDl4?=
 =?utf-8?B?YklCSUd0VUo2cmNNU3BlU05odnNVUXF3NXpHZHdReGJuSWd5VHg5MUZkMXZ6?=
 =?utf-8?B?MXdQdlVSQXBFUERzVjUwc0Z5KzI2UWw5K0pZT2xoeUFKaHZvVDJSalpGYlpp?=
 =?utf-8?B?eWEwL3hOd0svS2dRUEcrMFhaZEVjcHMwZkpBNElkS0lzR2lxYnJjSWY1RmF5?=
 =?utf-8?B?czlJT0xwOTM3VXYyOU1FQ1VTazNpN283VlUwKzdiMjJBVit4QzRMbVRIcE5H?=
 =?utf-8?B?NmNHMG5DczVSczNhRTJFZTN3YVV5MEFtejdGSGhDMFpLV3ZDNXp3NE9Ra1JE?=
 =?utf-8?B?elJ3eUQyNU9FWVkwMWdMc3orZEJBUERSQXc3aDZTUlpaVnlBOEE1Sm1ZaGZy?=
 =?utf-8?B?bXFFVDBNanVHL3QwT2RvK1lLb0IwQnN4TXVKdSs1eXQ4VmNPUk16eUxGRVdt?=
 =?utf-8?Q?CvLHRTWKBNNj6vDbTT7+K+u/B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c001f22-c793-47fe-b7b1-08dc5e10c83d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:28:55.3985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efs9VPpC5pjpdqoVlXTP7dUlAUGfK3N2K2/FaZwAsR+zfJU0+ng87oohPLV83ljm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109

On 08/04/2024 16:41, Jason Baron wrote:
> Hi,
> 
> I recently found an issue where if I send udp traffic in a GRE tunnel
> over a mellanox 5 NIC where tx-gre-segmentation is enbalbed on the NIC,
> then packets on the receive side are corrupted to a point that they are
> never passed up to the user receive socket. I took a look at the
> received traffic and the inner ip headers appear corrupted as well as
> the payloads. This reproduces every time for me on both AMD and Intel
> based x86 systems.
> 
> The reproducer is quite simple. For example something like this will work:
> 
> https://github.com/rom1v/udp-segmentation
> 
> It just needs to be modified to actually pass the traffic through the
> NIC (ie not localhost). As long as the original UDP packet needs to be
> segmented I see the corruption. That is if it all fits in one packet, I
> don't see the corruption. Turning off tx-gre-segmentation on the
> mellanox NIC makes the problem go away (as it gets segmented first in
> software). Also, I've successfully run this test with other NICs. So
> this appears to be something specific to the Mellanox NIC.
> 
> Here's an example one that fails, with the latest upstream (6.8) kernel,
> for example:
> 
> driver: mlx5_core
> version: 6.8.0+
> firmware-version: 16.35.3502 (MT_0000000242)
> 
> Let me know if I can fill in any more details.
> 
> Thanks!
> 
> -Jason
> 

Hi Jason, thanks for the report!

I have managed to reproduce the issue on our side, let me see what went
wrong.

