Return-Path: <netdev+bounces-71160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47648527EF
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 05:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9421F22777
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 04:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EFDA92E;
	Tue, 13 Feb 2024 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uBxmufV2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB47A923
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797438; cv=fail; b=fWmN4k6lyPBFVpJm63t7g+l/GHdoSf7l7wWbm1LJavuKYzwa7kgqWvuRCieRwqXUOyYzhLs62ZlYv2hSBuHm0iciu/TdeVytdz4X1mTNQjbetND5pIk9EwnFjEoN7ckXBlCII9AETa0gHHow+udrToN2nK4VSycznu3KzTUbR9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797438; c=relaxed/simple;
	bh=7kHJFpS+h8duTlM0bjpZ80wtD/XFzUPORbmjHe0mu7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I5H1bcopP0Q6nUFzjeHnhEcJm5ZS7UEfDiMw0EqAnqM31DUP7Vl2Xsfofzgb/Tj/0MRDpri5F26eljPtndRmTFQV2zKVS7GMQyBUSasFjR2L8btDmHQfLAEXxCB3NGXPRuSekThiuHZtAWJ4xy5uhLdtld4inoDjs5MlT3HrVc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uBxmufV2; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz7tgPsbNxAaz/p7I0sVa7DHuJ4rMwvhS40ADbgb1T0e5t5Ip6YlY3zo/7FzaOsgIbjamq9jYzya93YzCPAhW7dvao3YHOdbkXgHslq+bJrYI7vzf8cZC18qRInKnfvmod4ncLWPK6fSmz/mmdAqmPbLNaQGEEyLjPT6UB0OXXloKtddru7atviDCe5Bvobsg7JHmUJeqZW/k8NWHqoespSPF0MmVQTb/0f+G+fDgVtobKrGB/TsdWHG83+ZQrIwRB1TV8HI4y9K3DDlPOBRv5Le9JkzBe6Bw5s02INxmN6ifChS3Wwu15uB9jq57LO5VhbTqiXVc6RfZioB2cZS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQLF2shvB9+1v2kx2cxCbo1oSNDGSc5NEj9wWT1iW1U=;
 b=IuSjVJJxjngapmuPHa98SAjdwoYitrrtIn1kC073dNGfxHM19eD0FBOfUU6mBvNrCpmbZDDl6mgkKrnI0SCiwFkwT9BFD8BKwn0PE76v58ELM1nTyat28SGKZMaj49uCQarRtI8aw7TpFguLqvwHcJkHVvav+fzKaM1wvBF/ltGF1L2Rs3OKysEfRYfgw6N/NMEyRV6IdOphKszKwaVJkHYsR4zaDILDWfNroOTlCDlBI3RbP/c3/eP3811FFOmlTbPp2QzdHleh81tXA4UBQkGY3/8ju8UzkwWgjfDBWLBRSJdA7b2+by8eYehXUNaslnkzXT/vG3VlDD99wmHW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQLF2shvB9+1v2kx2cxCbo1oSNDGSc5NEj9wWT1iW1U=;
 b=uBxmufV2QzTWCLB5f4LtcFUMbz4vBKqFjaVR7GqEtHPz1kAJRObt7X1SUfCYYExOnK1SkB7np2AGhWMhmHJHxxxC9W855pIw5F2A2uQ1fwHEFJvo2hap3EXJiPMSMouaxBgbUzoV8pEJ9mq+ZiNTqJDuZ5GpADdrtYlgfsAwPpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by BY5PR12MB4855.namprd12.prod.outlook.com (2603:10b6:a03:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 04:10:32 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::dc92:cf24:9d0c:53ea]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::dc92:cf24:9d0c:53ea%6]) with mapi id 15.20.7292.010; Tue, 13 Feb 2024
 04:10:32 +0000
Message-ID: <b6bc5d27-c0e8-4292-a49b-5d5d609a5d60@amd.com>
Date: Mon, 12 Feb 2024 20:10:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ena: Remove redundant assignment
To: Kamal Heib <kheib@redhat.com>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Shay Agroskin <shayagr@amazon.com>, David Arinzon <darinzon@amazon.com>
References: <20240213031718.2270350-1-kheib@redhat.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240213031718.2270350-1-kheib@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:510:e::11) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|BY5PR12MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: 20018573-56b0-4bb5-942f-08dc2c49b879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D3OWDiVtCQmQztMG08x/3U84Vyrq5Bt84wgollI5RnSXj5oHGjKdWGo+qT6mekJnMnkxdUXRox9BAUhVBu3COqz9orhlwEXHYdmreeI4vVo9zKcS7GFrWMA7tKgSrzlPPolmo/GfNiZuWiCOhfByvI3xVawNkBRuoqP1x1+GmdtnlIfvDiGbcfEWGlGjjeP9YkYAGGHtp1Xa1o2LSzTAj8PbLVA2H+J4uUDG4lekefYVBHZ1nYVFspC0jFP+g6wuFbAH4BIpGrTz/iNojheCKrDhUJa9zVZdqY/Cc0J/WqUQxHrXCUQoc6ATCdYkLT9xVcmQnME05lcJRl5z/XBmjCJ/tiLVGoAcFRNOMdjNpqAYplIv+dmkTnGVwo/gW0Fg/y+vDT10hcz/oIGB4BJLkd6r62seXJedJDxBNh2eafT1kizOVXAdB+pGTjuM5GSApcIvlmZzXHE/8zmEGy/fa3P0JS+CjCUitMGUFBe5gGsh/bBr5eG3gr4bAsTC0mkk6iTMITk9AMbx2UVJ5u1XNS55DwQssRLmyAexDJDxNCIMf6N0LT3uMgggNKwVLLyz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(136003)(376002)(366004)(396003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31696002)(38100700002)(41300700001)(31686004)(2906002)(2616005)(26005)(6486002)(83380400001)(6506007)(53546011)(478600001)(6512007)(36756003)(5660300002)(8676002)(8936002)(316002)(110136005)(66556008)(66946007)(66476007)(54906003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUNNOTkvbUJ1MGk2WDlLTmpDTTZUVU93NXBKcUx1ajU4VS9JUjlENTc1clZq?=
 =?utf-8?B?T0pVZ0pSdWQ1elgrNGJreHlPcXlSWm4yUG5rcVllZ3MzZ200a1QzUGJJMDlR?=
 =?utf-8?B?WWtKMUdIbGYvRjVTVmJZNGY5VGFsMXArTnZoVjE2aHdwbHJmWC9XZTU2U1RJ?=
 =?utf-8?B?NlFZcjNtakRUVEFvbGhvQzVCbnQ2cVp2NStlamlRNEZCVENVSHpaem9zMkxr?=
 =?utf-8?B?T0czN1RORVNjOWp6ZWRRR1A1Rk9xM1NySFljOUlXVDdpbFgvellyOTdNTFdz?=
 =?utf-8?B?YXpaalROQzd0cTVCZGZXL0EvblNXdHk3MDY0d1p3V2Z1UDV4NlZQSzhQZmlU?=
 =?utf-8?B?U1Eza3pKRmRJSUpxNFBQQkU3cEJWb0ZHYTdQTnViOVB0d0hnM3FrcFRLZC8v?=
 =?utf-8?B?QzFoM2VzU2hLT01ZelFkWmpZN1pZSDdhZ0hYVDR4VmRaSTRoTGtpRUhjajdk?=
 =?utf-8?B?N0RnZ2Iwcm1iYktCVXo5QksvZFE5dEorMlI5WTE3QXUrZHZJY0N5UW16YWF2?=
 =?utf-8?B?Rk53dStxaW96aXBZNFNwMWhkK2w4MituQzdmOEtvdXBlRFMwRFFKT056WE1O?=
 =?utf-8?B?SjBJVmNISC90QTRLbkhGektGYW1aTUV1MjdrVFZvQzcraVRQUFhQUEl1Q3BJ?=
 =?utf-8?B?UWdCcVFtem9nWittcG94Q2hINWxOYUxYclNnY1ZYR0x1WHhFSCtJeDYzS1Yz?=
 =?utf-8?B?cUtGTEZnYUh5WXVpQUN0ank1eVEwN21acDk4ZnRaclB0aHBzM0V5V1BTWGQ5?=
 =?utf-8?B?M2ZFVkpLZUNyY0VHU2NDdGg5N1hiL21sRlFFNlMzd3o0OThPNFNIcytsTWF3?=
 =?utf-8?B?OXhCelN6dm1FMGp2Y2hkdEl1UmlHRU1yNjZOOWhjVFkzeTNROXhxUDVzRk9i?=
 =?utf-8?B?YUZ3QTk4eWJ3bWNoRHRHc0ErdEUrVjQwcFhiMjhWQWVJdEJNSWI0NVo0VTBW?=
 =?utf-8?B?YkltYzQ1MFZOaVlWOFhhdnYvajNCNWxWU3p3MHRpekR6QXpWOVRDcm5rT090?=
 =?utf-8?B?dFRJa0duUmJvZXRnVEZiT2wvNmJXeEM1V2N4VWgrYkN2WmFRUkxXN2NObG5y?=
 =?utf-8?B?SHo2YkRNbDMzV1ZKVEdmTHVUY29nY1B2MUc3OXFWUndQKzRRNFNreGZ3M3Ji?=
 =?utf-8?B?MENLZmlTbTNWTDZBRHhsZGhjVzNmYXZpS3EzQi9ueXZ5alR0YW5HQUlKN2Nq?=
 =?utf-8?B?dThDWVlWTy9wNURxcENta05DYkRRYUJyT1hGekxrc3lHVXFlclRpQ3AyditN?=
 =?utf-8?B?V0NNN1BINjJwVjNhQmdRMGZMdWJLOHZBZzVmUllYT1JDR2xUd3E3ckNUU2NI?=
 =?utf-8?B?WE16cWJtbEdIb2NpelJPd29ybG1ENjJhczE1d3pNY0NNV3FvRzVzdS94T2Fh?=
 =?utf-8?B?Y2NpUnlxRGhPNXhnUHRqMnRmQU12WlUzOUp5TVNzUzA4dE55QW5oTko2OWRi?=
 =?utf-8?B?VzQvbWlzMmRZU1lkWm9TZUdqNnZHakxOV3B5aUh1bnR6VGpvbXZKS0llYmI3?=
 =?utf-8?B?MTBkOHFxRGNpR1JkeThWS01BK0Y0YTllVGRZYzRBWmo2S2RWcXdCbmpYWVlB?=
 =?utf-8?B?NVAyQ2cwVFB2c2QyRFpLWE9aUDR5ODZCRitkRW43T29ZTDNiczhGUjI2eExm?=
 =?utf-8?B?cUpFTng5K3lUOW1XMkNWVytIMHdRS1FaRGJ0T0JCZURESUxsOS84VTFlSE1B?=
 =?utf-8?B?VVBYY1I4WE9lVmlZZlNhbXk2SWU2d2tKVjh4TEdCRE1Bb1o1OXpMWmRSVmpT?=
 =?utf-8?B?YlovUTNiSWRzSWsyYXhhek91bVZwWjdxc3pjNmRxS3Y1TVphK2RFS2ZNR2s3?=
 =?utf-8?B?cmhVMEcybTZPNWVXWWlhS3hVWXVncDdweXU2ZW1Nd3VuNUV0cldZb0JFQjRt?=
 =?utf-8?B?NWwrcHpjV2piem5DbnVmQi9FSFEydEJqK0RJbStSNWhpQmNJVTRMVmpvQm5y?=
 =?utf-8?B?MXF5ZXA2MUhCU2NEZkRXRzA1VGNXOU1SMmxrRm1MbUM2SDdVdHgzMW9vbml6?=
 =?utf-8?B?bi9Rc2wxYWQraC9XZ05EWW9hUncyL0RnSkMrcDJEZEFSZzg1a0g0cmQzQjZo?=
 =?utf-8?B?eC9MaEx0Sm01S3JKOGNEaEE1LzdMQTdmcndZcjRwVVNvVThIMEthYWovZVRv?=
 =?utf-8?Q?yc7f3qx/uNSTUImFGQLWJIYlu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20018573-56b0-4bb5-942f-08dc2c49b879
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 04:10:31.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2lV0aRbz+TEu3fmZEiA5FUDwYy+Z6Z/cMO/nYoQsK+c6O6B5dewoXoq4smICxjpOomHdsYHstYAli+G5tPXdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4855

On 2/12/2024 7:17 PM, Kamal Heib wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> There is no point in initializing an ndo to NULL, therefor the
> assignment is redundant and can be removed.
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>


Reviewed-by: Brett Creeley <brett.creeley@amd.com>

> ---
>   drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 1c0a7828d397..88d7e785e10f 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -2867,7 +2867,6 @@ static const struct net_device_ops ena_netdev_ops = {
>          .ndo_get_stats64        = ena_get_stats64,
>          .ndo_tx_timeout         = ena_tx_timeout,
>          .ndo_change_mtu         = ena_change_mtu,
> -       .ndo_set_mac_address    = NULL, >          .ndo_validate_addr      = eth_validate_addr,
>          .ndo_bpf                = ena_xdp,
>          .ndo_xdp_xmit           = ena_xdp_xmit,
> --
> 2.43.0
> 
> 

