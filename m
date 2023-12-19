Return-Path: <netdev+bounces-58999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB43818E3C
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514CCB228D9
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 17:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E77249F8;
	Tue, 19 Dec 2023 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mnpqfAN+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF899225D9
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fv3/MSp68gzGJITZE5OcuQYP365+c45xBYBplAi4faFWpztsVbWlEHaUB6Th7L4YLUpi+XvJeZyR8AVSr+/Luhyqdm+6lXoaZo8Up8Lrt5DimV8HYLHQY/WcMaE2QcoEm24KyI6jhj8MY7g2NhNDnXPo+cG6N8QBu5Nyd60Uw7V/uqxJVfyn9zuRzseT+oFTwa1S4RAzry3eRiznblBsUeMCDYfuxQtfyUNdRTho5ueg5/UxlxaYmFOLUw4KBUSInuEc4KtlNF2XzvfvRrNuEl4SSyDfQw7WK1iUoG9vVD8+qGeMaF+jK4Zoll8R2Wius4L1Tn7iM8j12ArzB5uBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1jo43KTftsaOLk5JdI6rzZSlOQAjAM1fuGRGg+3+gs=;
 b=Lo2NKeW1fr6bzOCrb7J/ZDsOzUi2YICKbiBCKRZlfpTOsfSi4eYKH/kbh6MnoCdmdmX8rjfYE8WpfwiPGAFHs723mUbhf3Ee+Yjh/WuJ+b2IGVrhQG7765y1KmWuS1it7Us8L8o4Qrjz+IjVspSUAu0prY2lXJQAEjCrTHP/kY+934lAqkU8YTwxY85xz9cvgFin8I70gsFSc98F2l5ZSzH11rYiFTfimCmuDASdbv2yzFMsknNj7N5RDD9miqJTs3DHg/m5KjQl1RKP5RK0OSTJJVrXN3ONcCSglwatFwmO4ntBPvK1Ti+xqTTw9AT47HKv9I1ZeWWpWik1sZYpyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1jo43KTftsaOLk5JdI6rzZSlOQAjAM1fuGRGg+3+gs=;
 b=mnpqfAN+ALeGD3F+ZjBFlVcmzi9kbopatQ1ezh60Q56jXM5nV3/kO4ZS+doVfzOTBvq5tPyKHjBPtpL/N3ANEcKC1WPk4NfzfQLSA9tZOLwc7yPNSLK3nyEvm88P5kFpP/m4EN1ka13C/fSE8DvGj8Y92PLcwCeF8qeFzWMeCj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 17:35:35 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bec4:77b3:e1d1:5615]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bec4:77b3:e1d1:5615%5]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 17:35:35 +0000
Message-ID: <693fb63e-8369-9cf7-4b41-7afc00b30618@amd.com>
Date: Tue, 19 Dec 2023 09:35:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH iwl-next v3 2/2] ice: Implement 'flow-type ether' rules
Content-Language: en-US
To: Lukasz Plachno <lukasz.plachno@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Jakub Buchocki <jakubx.buchocki@intel.com>,
 Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231214043449.15835-1-lukasz.plachno@intel.com>
 <20231214043449.15835-3-lukasz.plachno@intel.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20231214043449.15835-3-lukasz.plachno@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::6) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: a655204b-26ab-47d3-bf5c-08dc00b8e826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F9/BBqJVXpSzTz9RZl/4dpZ9k6tw6BCCCE59qMb+EBobNxlz9hyX20zWCYvftRkvxxumwA6DNns+H5Po2zjc3yg+nB6SoMa0GwtR/Bn80zlv7DOF/HLkhkjfUIQc69qrQ8fD9js8UcCSB4+gSEWPWorRSLAUybJ5QBv1IKjoMDY/vp7RpgadQOpQhGOJq0bVnqhnlW4JHA7tDQHzXbC7sWUnaMBF6a2eJrXDN1WZsg+P/7s8GvToVd5uW+/dZSpWPOc1IugEQrhZg4y96TVv4MuprO+L43q79vZ9wjGVRVXUfsUjNRzwU09WgnJ/qa+eUQ7F7mSXV9OMUxcVrBAT+Vkn5Y6ppjWlGkeP6EMUrP7Uju4poAcqQLfSCHiSqsOvIIR5PzE7/NuHw5Fk0bAq8n66jjzkK5PSL2ZhixB9+I5BDe02aZqc0YejZdj44bfASsMdEsxnuCI4lgsXEhTuioOa4i4t3doIYs0HJE83MwfsYwsJPCthy9Aj8OU0poQ7jfIwDWg9ymzm3Gsb8VL7WAZ9qZKmj9NlHYFDdM9YXrpGVgTOpoPchefsU4rQ/tQdegc/QuI6zkVMJJw4c8dOc6MwZCFR4V3UYKHFpCwWBal+pWBkEwvEva6JL8ZQKjELQTw+6n2mXGLh6/JYnMWPydlGVFdsPd3OxQnQZM/4yUbOkd7tf9MX7Dk2oGYhDSAy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66946007)(2616005)(41300700001)(83380400001)(38100700002)(4326008)(8676002)(5660300002)(316002)(54906003)(2906002)(8936002)(478600001)(6506007)(6512007)(53546011)(66556008)(6486002)(66476007)(6666004)(26005)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHAxVlladTRKNGJNalROVXBzUWRWSU1PV2syTDN5TkRrTzM3KzlDcmtFYjg3?=
 =?utf-8?B?REtZeUs2dmpXOVBNVDZaMXJIOUJGMTJmYlFTaitadDZob0JYOThZdUFNZVRR?=
 =?utf-8?B?QjFFVDdiL0pRaWw0ZURyM1Bya1RmYkg0SWJrV2tZN3dzODE3S1QyNVZQbGNn?=
 =?utf-8?B?TjR2RXlabGZkUUV1ZjFFcUZ3cDZlSXNMOW9DRWdKYjBJWWZpQW81Rk02ejQ3?=
 =?utf-8?B?ek4zYmh2Rll4d1hwb3VObUpkQTRQNTNaSzdiRHYvditOcEc1Q0NubEFUekg1?=
 =?utf-8?B?d1hMRVllRlJ3VnhuNUFWNFVOYVlQaU1vR05FbTJ6YXg4L2IzckxybkN3MGNG?=
 =?utf-8?B?dmcva3NvKzkvYm13UDlFY3I2WnV5d0RLL0tkclkvZGtYV25WVjBHNFpSVVFI?=
 =?utf-8?B?azB5TEFlQk92MFlHaEJIZVVqcUp0UUgxVHV0OFpUbWVyTHdqRUxNQ3luU1NP?=
 =?utf-8?B?UVZncEZQc3ZWSyt5ejM2aU9ZSHRwSjlrVEorMU42ZVVUVk5rdUY2S1NmTXhU?=
 =?utf-8?B?NTVjTXNLODdJNWZpcFI5RnFXd0pXc3hNL0tHcVdWanVmL3g0N2NjN1FiNENJ?=
 =?utf-8?B?djA5NytTUzduWlBMdGY3WWRMeU1oNUVCbEtjRDBpeGRtcUlhN2d5bWo0SmdL?=
 =?utf-8?B?ZzJGWE5JTFU0WXVqa0k0Mzc3NFBXRTI4MklUMkRtRE1vdkQ0dUJLVDlnd1ZY?=
 =?utf-8?B?TVorcFBkbjljNDIra0pUN1BaejZMQUpWdUw3Uk5Vd0JhdUVDOGg5NEhRZTl6?=
 =?utf-8?B?VDVUejdmSXBWemNXVElHeEk2U091cHJMeXZWL1pYSnV5ZjlHRWZzaXlxU1Fp?=
 =?utf-8?B?aEZaK0pBaE45ZWVOeUE4M242YlNkNVF0ckw5akdHRU1NSWtCLzAzK2FQbk5S?=
 =?utf-8?B?UWM5UGlya1N2SlZ5eTJYdzhwM2Y1NzUyNjJ1dkR5VDRNRm5aQkFaTGtnYVR6?=
 =?utf-8?B?MnJlbmNRQlVLMGZlRW95WFNobkhkS1pTeUwrWHZtR3NNRHk2WlhTMDBoSHFQ?=
 =?utf-8?B?UVRsUDkxMzhhNG5CTXM4YkZySCtMOElNaFE3NHJCNytzaUN5b3NpYzBycVF6?=
 =?utf-8?B?eEFVV2Y0WmtVaHQ2VDBBRVp6VFRZLzAzTkpveDltdDdiVEwzS2xhTWJuSkxZ?=
 =?utf-8?B?THlGckdSVjQyUHY2SG1DWjVjL2pra0pVSlFFV3ZVNzJOR20yZWt1OUd5Z1lL?=
 =?utf-8?B?QUJVV0swdDlnNHZuY3hVLzdtUkxnWlZoV2dyc09kR09LTzhRbmZSeXJmZVB6?=
 =?utf-8?B?ckREZWQwdXFGOVcwWlZLTDZSeGpxY0paRnFXS0UxcGxsNVVGOGhncTBOK2w4?=
 =?utf-8?B?dzVhN201WlVjdjVPeGZKbUY4SmN4S3hWa1pXMUNyRjhMSnUzeGp4c1Qvbk9C?=
 =?utf-8?B?VjRuODV2bytVR1dlbEZjbjhydWZwajgrbXFMVklWZTRQM0JqeHMvZVZpRTBN?=
 =?utf-8?B?bUVCZVJFc0o1SHlGWnl5azFHZjBrNWpuaUg1eWtMUXZTV3hzOThld3lyZjBs?=
 =?utf-8?B?R1l4MkdsaDlXcDZ6S2ZuM3NzcUNQVHhPM3JWblc5RTFwYXIxRkRQTVE4aUlV?=
 =?utf-8?B?UXBKNWEvTFFmQUg5eStXMjBlVFNDSDAySWVXR2h1NEo2WmhQQnBpYmt0cUc3?=
 =?utf-8?B?UncrOGZQSFI1WjVUb2dwRU5OM1Q5dlY3NHplaGZUZnM2RFV0OFNtNjFwWFJF?=
 =?utf-8?B?d28wUUJTSU04YXZDRTc2NGR3K3RzZDQzRldlekFEQUhPT2FGMjNEUzZZa2t1?=
 =?utf-8?B?aXZNOEhmRStYbUdvcUJCU0pzZEtXU1VXQzVyRFVNQXJHb3RWL1RVQU5MaGUr?=
 =?utf-8?B?TTRIYUtnMzhVSHBUaTk4ZWpjaThaK2IweFZVa2dYUzRPcXFmYURqdjZGdHN4?=
 =?utf-8?B?Vk1YanJRNFJNeXpiUXBwS2M3Rk55b2RuNG9Zb3p2QXNYbW5Ua25mTFpoWFk4?=
 =?utf-8?B?bkkzc2V0d3JVUEhQUFEybCtNdW10WGI4cE5wWTczaTVpTHllRW9lRlZObnc0?=
 =?utf-8?B?VlpNRElNSGJ2d01MNDlYelFPT3kyTEhTUEFWWUFDQjdjQWdDOHdYLytqbko5?=
 =?utf-8?B?VEt6N01RQllya2ZERmhOem1XMlRPS2JlTU5LK21uWm5NUzNHdVJBRUpyc2FN?=
 =?utf-8?Q?vpnAV6G0BVPAFrrN4wyNNcPBi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a655204b-26ab-47d3-bf5c-08dc00b8e826
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 17:35:35.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18gCHcJ0OIVigN5sjpysZr6NXwEoc2FquPOy3UShX8vAtYTtBX/IBIaPz4IoHfyZyJXM7KQqQJuxgzmVBnutyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199



On 12/13/2023 8:34 PM, Lukasz Plachno wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Jakub Buchocki <jakubx.buchocki@intel.com>
> 
> Add support for 'flow-type ether' Flow Director rules via ethtool.
> 
> Rules not containing masks are processed by the Flow Director,
> and support the following set of input parameters in all combinations:
> src, dst, proto, vlan-etype, vlan, action.
> 
> It is possible to specify address mask in ethtool parameters but only
> 00:00:00:00:00 and FF:FF:FF:FF:FF are valid.
> The same applies to proto, vlan-etype and vlan masks:
> only 0x0000 and 0xffff masks are valid.

Would it be useful to have user facing error messages for invalid masks 
stating what the valid masks are?

> 
> Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
> Co-developed-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>
> ---
>   .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 128 +++++++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_fdir.c     |  27 ++++
>   drivers/net/ethernet/intel/ice/ice_fdir.h     |  11 ++
>   drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>   4 files changed, 166 insertions(+), 1 deletion(-)
> 

[...]

