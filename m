Return-Path: <netdev+bounces-286584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPSwIfeqAWoMhwEAu9opvQ
	(envelope-from <netdev+bounces-286584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:09:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B4D50B996
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C85AF303AAA8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A0D34B40F;
	Mon, 11 May 2026 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZGtOWnco"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB4344DAE;
	Mon, 11 May 2026 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493823; cv=fail; b=LERTuKSS8PK7lXGGBJLVGOSG1+J4vTYN896ia7+6oSk/uGCV9V1kkALl14eEIvTiNoMcP4H2JUXw+jQU4ohui94FWsaksVhrvKqvtai0gaYKAWSfiEsjPEDSdfAzU/nwoPb9gxE8NF6MhS0InH29KheVjGF6bZ1Sd+QJi63khxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493823; c=relaxed/simple;
	bh=7T1J3wXIhUpj431Nr73+63EE7T/CZ+hPAIG2Fv9L8Co=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HKjLpTLs3L2kMQ3a+Z8BD8iNa9ZRhcfXbiISmZJCWOnDNcq9ZnTINypYdAUNi6E7QWiXHlsXCF/unPY/gS0+0GU/2HduyM5TR/YfI62tTVSAoU5eMd++N7gdT4LL2YH8LRQHzWFacyKr1Kmpn7H6N/Zc5XtlsvvyLoOq6cuVrNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZGtOWnco; arc=fail smtp.client-ip=52.101.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvcRn1LfJYLiRY+3eFPkUDFVoRPo4ph7AW6BWgEfq9g5SlFpCgfNoLXXRUmmmZMEVJYMl0nCAVOQ0tJejluqq5NtI3OLtttrVZ0r+zyArvPnK+jZLigZGm3mt4UP/tnwdnTMUlTsPkcCN2UWvwDyEUJAtM5hF9kL89+zFL3OzcIJ7OY/kYDoEDvT13rRT1qHuOQ7/MoTRFfR0i5+p0n/8rMxfCmoYMkRhE0XK8/hoYz2HPusQmI/VNI9pYpmbFBcyARZMQ4+Q7sn/BGZNjFXbqTp4BL2UmdaDcepmko7MluQwoVd+1AKFVF0CWQArzFX2YECol8vPUCf4IgOYNn/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEIaPnr7ljRaxYMB6GiRsi4mgwTNjGfWLY8K+ekGDCY=;
 b=BuH4CrB0zVcHP+CoM9j4M1mJdJVY9H0+whu+UhqEisYfDnadM3Iy1WXdxquzjSPQRnz6nfJrQlXdpGHob8waYTEEHRxXwsEAJ6tLv1uacxxlqY4h20FBntxcp2ctJBTlZdOt4tCIzjveJBVvaWcTbXJwfILVcctfAYHVdzYkHfZ2TJ5k+SlgE+0SzEELghbxFus77BA9EDEMBTMy35YuxUgKIleHQ1uRhTLHGxpUrq5UoyYf1nHIOJmTHMZ3xBZb0U+j/+Fv/34I0nkLmc9EtHNezUHfSDkJCOHWatp39Yh16PTP3le8/Iq2LluVVrjjgi5667v/I6X6mvD5JMMYsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEIaPnr7ljRaxYMB6GiRsi4mgwTNjGfWLY8K+ekGDCY=;
 b=ZGtOWncoLsyIbcZZYQzpGX1XcPHrcKv6k1fcEUqMpyEDhTlyumy0VEksNujxrAtVBAhnlzmm4Zgy8puAt4DIwiVABxohVCom7kVZ5wNC8ENj+YiFb24R2jvVeg2UMHuqyQoJ/WKWX3ThFxRGDJMNfLJ/dTT7eVYoc5bpbLjesR31uZhIHBkqD/kYQCdYOfAn+q+/BeP3jC86BYhYoWV2y1J7Qhj0jZuDxB98sWdxLMWI4wVoR6PBBVio+TF5nWilo8Wta6noM+2tAmAn9HWSfHsS9YBi+XMFC0mq1Rvk77WYLI3PWoTkEibplcVkI6gdt78O1RydiiNA8i+Qbql2dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 10:03:37 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 10:03:37 +0000
Message-ID: <bf626b44-efad-43f2-b8b4-509934f4befa@nvidia.com>
Date: Mon, 11 May 2026 12:03:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] octeontx2-pf: persist netdev stats across
 routine operations
To: Anshumali Gaur <agaur@marvell.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260511094205.1422268-1-agaur@marvell.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260511094205.1422268-1-agaur@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::20) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 793837cd-fd81-4a2b-e64e-08deaf44918c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gwY12iYfW5RxfMN1MAWB86Bau2VsquNpb7BiMvqBGyBenUlxNtKFANql2a0MRovV2SV3irOGNCZ3x/pqJWDbJa3EkXW0FS2yF/yhUAPBmCDDgb4LFg3eQcXVzFWZGtwqbiOt3gBWW8/Ae52t6KEulGSLCsSGvQeARK/0f7PxY/KFVJ3Cu3rHc3ZTTmTpPSC2PKMX9OspnOErnxHu93DgRbPuGyibEijGl+yNFkEBXziX8sYqsiMwdST41VZ26185kj2ChdPAwOmVN7fgm41Q3M+GNIl8uXLdolGZnGFdmsPUhg6SQ1ojgupl9b1cLqIUKT2F8L8GCspTYfZ8kyJmMdXKM6qcBkxqI84OBRPKnJX22s+bweP8XhNrpDMk1iosUZwlDrjrIChdbSOLR2mbepqbH9ny1g3MXL2JRCOmYMymRPMXhx/UmAs/fEIVw3eBFEkVulBvPdhxvxJcX0KQJ1z/qKF15VqvYO6it7MR376X4qnb8reMDwgW3HfL6mwUlyfDspZQ6v8VOUk70dbeIleLQsofo934usirSsvQX8HexqSsRRLhqCEqkYUY/60QergMIMMV1PEA3w17oqruXZHtTEPVvRcn9sRuqX4hF4gc5Ug626QasqkvW47Hb+/imz8nPlkbqHot/SCc/9sZuFiw7Xk1Jgo1ZdxJAbl4anOZM3v/C2PkerzFYR8BXKJ+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0ZabVFVUTZYbmNpV2FmMEF4YnFxRXBZd1JnR3hjdFdrQVFHOW5UcnhxdzFE?=
 =?utf-8?B?SVd4SC9xaENpMVRPN0NxaG9QVGZpbkhjL2JTbTlVNE1IUmhsdUlreG1WRlVS?=
 =?utf-8?B?ZkFGUDdTMWtSYjRUWENBbEY1eW84ZGF3QnVmNWxmVytkRWthdHEyd2ZvZlZT?=
 =?utf-8?B?Zi9GVnVlNkdRcTB5NFRpTU5DK2FZQjJtaE9taGpDYjZTV3BiK3hNYXhWNXNV?=
 =?utf-8?B?Lyt5UlQ3bDI3NGc3OG5MVnZ5bHN2RVlYbk1Hb2VvaHZsZ01LNmZyUU1wd1RO?=
 =?utf-8?B?T2N2M2l1WE5PS3BEWWV4a3RpUWQ3R3VWUncvQmFCL3BPU3YzYUdoZy94UGFs?=
 =?utf-8?B?WkZPbGxFN3F2S1ptLzBDOUNzVCswSHEvaU1wUCs0MXZNRlF0djBnenpPK3Z1?=
 =?utf-8?B?bis0V1dPT3pScVJDdHRqdGVlTFdxNm9KTi9TckZCWWo1aVFiV1RyRU96R1pi?=
 =?utf-8?B?UXF3eVhEKzBpaERUc1NHT2UwcVQrN2IrMjBHRmdkeDNrcjRJQ2lMb25QVy9X?=
 =?utf-8?B?aU1yZ3hQeWZyazFBMlNXNVJvbi9QbnBQZGZ2TUFJQVk3K1EwNEJ6emtYaFlo?=
 =?utf-8?B?VzVTRGR4YkFtTXZTU3ZRL3pWNmRDRTFVNGNITzNldGhpdGIxQ1JFY2JYMGtU?=
 =?utf-8?B?NlBjK1RYMFJ2d1poSGFCamlUamdTMUdYdUlSbTBOUWprTmlOZ3djeGEwaW9h?=
 =?utf-8?B?V1cxWVpVS01uQXRIYkVyeDJVeDc5QzNsUHFCQ28zaUUzbFpxSzFqN2lLWE10?=
 =?utf-8?B?dmwvRUpPN0dub05JWVE0dGtLRWNWRTZsZi95VFhtNitRQUJqREx4aFJsUnBI?=
 =?utf-8?B?Q1g5d1hmUVgraTN6YUhmOWlETXVrSXMwSnBKN1pJdnNvWFU5S21OQ1g0Y2Ur?=
 =?utf-8?B?bGdNOEhNbHBwZlRGUHJ1VHQ0VmFUdDd6ZFZRMGU5Q0JzZFJzYUdLWG84bEN1?=
 =?utf-8?B?VnlNbWlKVWpESWhXSEFVZ1V2bzBNbVIvT25PYVZJeU41cGhNRWI0ZmtWVEIz?=
 =?utf-8?B?L09NLzFldFVJT2tuWnlFSjJIVERMMjJtZmxnK1JjTjFDL2kvWVUwRUtjY0Iy?=
 =?utf-8?B?NGxPdDJndGhvY2E4bDNTOE94Y2dwZCtJZjhZMGJ5ZTg1MUpIT1JvZ21JUldG?=
 =?utf-8?B?NUU1UGVyc3I4SmxoVnVRZ1JXS1ZJUCtxSEU0VGZNWlR4dnVaUllZMUdTMVBM?=
 =?utf-8?B?RmNpR3V3Nllabm9lUm5JMUk4UTJpczRoQ09aUmp1bWpsS0NmR2JGajNmOWRj?=
 =?utf-8?B?dHB5YnpkSmljaFY1U2pCR3hQb0tZZmRZVFkwYUNwaVUva3pwQTJCTW5reThS?=
 =?utf-8?B?V01VWUU4ejB2Y25qdWR6YXVzUGJ2WlZaVVBmNlAvbDU4T0t6dTlhMFpaOFVR?=
 =?utf-8?B?UnJZYUc4UXVZMWYxcHMyWENmckU2VXJqWEFRTkoyZ2VCNG9tb1dublZ1cW4x?=
 =?utf-8?B?TGh6KzJmeWdYbGNrUXJlYWJLaUxmNU1OL1VvYWJySlJUUTY2YmtyWFg3QTZW?=
 =?utf-8?B?KzFpeVJlS2hESjVIY2ZQODVsNlY2RlJ2TXN6UlhYL1ZBbjJZUWtLK1M3R2dM?=
 =?utf-8?B?Y1ZZc2tlSDFuOHU0REorcUlQTE1xY1h0QjBZMVpvYkdzTEJXVFhwK3ZVbVNl?=
 =?utf-8?B?SmYwZTV1enNGNEdrYWpVbmkrV1QxNFA2VThRRjVHaE04aHFXOVB6a25qZjli?=
 =?utf-8?B?RjhoZEtBYyt3TFcrZFBoWHhvNzdYQzZFZGZBcm03cmFrOHp4cllkZTY0TFhO?=
 =?utf-8?B?VG1DWFIrRzB6K2dTUVBxL3o1UVRZZVhBbUluODFmN2hpV0x3WXlvOE1ZN00v?=
 =?utf-8?B?cHllVzYrR01jRmtVS3l0VGxteEhiclFwS25KejRRWXZoays3MHdDM1dRak91?=
 =?utf-8?B?VXRwQVU3OUpWRkY4dVdtRHBQM3RuZE4wQ3VCdURZUzUxMERxcjZkTzlxMnJo?=
 =?utf-8?B?alIvTUU4M0E3cS9wbmNFZ2VjWjF5YURRNFRoL0VpVWVCYThzRXVoS2t2d08x?=
 =?utf-8?B?aFhGcVZnNXVOOHFUbDJtT0lGMU00VjJWejFSY0dVTGtFZlo0R3g4YVhOZTJy?=
 =?utf-8?B?NUxzWjUzd0FnUXBWNHA1SlFHUExJVHhHU3M0ZTdUNjE4NVk5cWZkaDNGbmdw?=
 =?utf-8?B?Tkh3RmVzL2FLK1RxREFmL00zaFpaMjFtTEdlRFduaWRmMUsxTWlVSUpjSG1w?=
 =?utf-8?B?b1RCblVNWjZ6L3FLOXlkaXJqUURMb1BIZ0l0VHZFVHhzRVlvMEJPdExYelIy?=
 =?utf-8?B?UktDNUdtZ2FlQlZ5eHIvMHR5WFM0eXAxZFRjZ0trbG05b1NwN1hNZlhYUGlW?=
 =?utf-8?B?dWxqNXAydldzM1lJcWs2d1RleEFvTXFySWFWcStMd0FrN1pqUlRCZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793837cd-fd81-4a2b-e64e-08deaf44918c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:03:37.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LA/hxhV22/igwlxytUwhUS/po5hBuByPDzF5/KIWGyYf44S8kINwDqdb25VwtBh64RK2dnJa1PZ08rZZze4RVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406
X-Rspamd-Queue-Id: 24B4D50B996
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286584-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,marvell.com:email]
X-Rspamd-Action: no action



On 11.05.26 11:42, Anshumali Gaur wrote:
> Currently netdev driver is not retaining ethtool stats during
> interface up and down, as per kernel driver standard netdev driver
> must keep stats constant to avoid race conditions with user space
> trying to read them. Stats must persist across routine
> operations like bringing the interface down and up.
> 
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> ---
> v2:
>   - Fix subject prefix to target net-next
>  .../marvell/octeontx2/nic/otx2_common.c       | 20 ++++++++++---------
>  .../marvell/octeontx2/nic/otx2_common.h       |  1 +
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 18 +++++++++++++++++
>  3 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 971fcab1c248..0ffcc613a4b2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -139,19 +139,21 @@ void otx2_get_stats64(struct net_device *netdev,
>  		      struct rtnl_link_stats64 *stats)
>  {
>  	struct otx2_nic *pfvf = netdev_priv(netdev);
> -	struct otx2_dev_stats *dev_stats;
> +	struct otx2_dev_stats *dev_stats, *old_stats;
>  
>  	otx2_get_dev_stats(pfvf);
>  
>  	dev_stats = &pfvf->hw.dev_stats;
> -	stats->rx_bytes = dev_stats->rx_bytes;
> -	stats->rx_packets = dev_stats->rx_frames;
> -	stats->rx_dropped = dev_stats->rx_drops;
> -	stats->multicast = dev_stats->rx_mcast_frames;
> -
> -	stats->tx_bytes = dev_stats->tx_bytes;
> -	stats->tx_packets = dev_stats->tx_frames;
> -	stats->tx_dropped = dev_stats->tx_drops;
> +	old_stats = &pfvf->hw.old_stats;
> +
> +	stats->rx_bytes = old_stats->rx_bytes + dev_stats->rx_bytes;
> +	stats->rx_packets = old_stats->rx_frames + dev_stats->rx_frames;
> +	stats->rx_dropped = old_stats->rx_drops + dev_stats->rx_drops;
> +	stats->multicast = old_stats->rx_mcast_frames + dev_stats->rx_mcast_frames;
> +
> +	stats->tx_bytes = old_stats->tx_bytes + dev_stats->tx_bytes;
> +	stats->tx_packets = old_stats->tx_frames + dev_stats->tx_frames;
> +	stats->tx_dropped = old_stats->tx_drops + dev_stats->tx_drops;
I don't quite understand why the additional old_stats is required.
Why not accumulate dev_stats in place? Either directly in
otx2_get_dev_stats() or pass a local struct otx2_dev_stats var
and then accumulate that into dev_stats?

Thanks,
Dragos

