Return-Path: <netdev+bounces-285266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPcULhZ1/GmMQQAAu9opvQ
	(envelope-from <netdev+bounces-285266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:18:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2404B4E7526
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 890723004F6E
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAA237188B;
	Thu,  7 May 2026 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kQka9eWH"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126183B637E;
	Thu,  7 May 2026 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152709; cv=fail; b=i9SZyJIdxJv6m1Wxxdok96WlDFGgoK1Bpl1JDn7tEKmLY7gp2QYVv9S3svdDJtEXjqihub8K5eM9bItkJ680ngVWwG/9p0yZMMEAPaARBj0deyUqu6leAHcd+Kc9EfnGlkF7pjdxYgiIf4e4FzhlKbztjPkFzcDIHEg1De5oYEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152709; c=relaxed/simple;
	bh=b+TqY1fFDhtI4sPevtV0vyAkdvtjk8k/hok463gPJvk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o7q09T26KPCASox5hmkB9xzbvzokwuiEEUcRbwQ3LYg4xCJFHu4ntiem9P3wTuRnSvNToVLbxXxgpU9w5qggsowcapobcI2JcpBe9uFIGCMCjFL1ytK0YDzGJr/SxWzazHtYUTyIqDEg0+GsvCLu1soVzO1cfuL+3YaUPNmKIUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kQka9eWH; arc=fail smtp.client-ip=52.101.52.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcacl0pRKFvR+8Pt5CVi8zHdXuYRGMAiu/tjrQd+urdNkooAIXOKTbohA8b9EwN+RsXnUa860Lx9Pq5hWFnncB8dMhUVwAdzbQfMUB6ecT6ssoA6z085/Og0kbDukoTjIRGuQKLeCtnae6T1FjEZYrfQ6fXBBypC32P8Kqt6hyr3MzOIAL8SWC3Ymmy3NyerWx8S1qemkXTfxLtPir76+6Ok7yXl4tL3y1YDBvNqdMWB8BuScNJI6AYfKRDbiZJBEUvX3I0ABs6RFuJL56DulxwViJIxF12GUOjYEZyNdElkLT3WsI/N/iVskuSh0TGoh3cUXRv9sgw7WKh+N/bLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGT5ZIR3v4oeJCHQtWV05ipRmAWsEdJ9yXcMJWTCwq4=;
 b=VZxsYrYXzAoTMesloQ3epg9wyezkePhtuihv0x9hHkMwJRCbfYxH1mbz7Yk/ldAzwfOrtKK8O6Bzu12Xkvs9IPkFS+EIH7AaixDM/eXPumMKbKvz6uND/rW0hAIVlQClMlW3/3pa+dmW26m+B9e8zGsiu/isD+MuceDENFVHaX2u0HpyH5WNsMo1xcvnCzEOiPTRwYCk6n1h5VG+C1Mxvzj0TOpS5B7YdeJN7zxmmn+ljwXedaJBTxDem8a5un9XWcvhOHpE/xJH2RsTgkYi7j/LzCi7EeYDCiyWGrwih6aBqwtk5DhxeuppVQ4v6KUgASQ5JN2+ptCozxL6AZV1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGT5ZIR3v4oeJCHQtWV05ipRmAWsEdJ9yXcMJWTCwq4=;
 b=kQka9eWHtOHwLGlf+RhJgyPyqHpbnaeI8sWeBGT5aHXwJ7PpLV85r6i10O4ZNIZkWEsVA5HS0Ql0imHbjJrRLlnyFLgzlB2cwJRnGYCVu86OgmiE0ThBjZWDOD/u08IJrltL4TJICNumuRTaiNjVvOkfyJLHg6ghA7c6ru9jjD1ynAixaWbXevjIKMLump3dDyn/3v2g0c6wqBw/Lwy+CwFz2hKCbZ+/C1p8hndM0HaT8JvBbpxRG6esCPw7y/FUUWadG83r3i5DUs0sB4JAjyh0KFFqvRK8r76aMIj1tMtDyQrKCP2+cjQwdbR8WaNtjI9YHuUj/ftCsEVTBfWYuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS5PPFF2923D4C1.namprd12.prod.outlook.com (2603:10b6:f:fc00::669) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 11:18:14 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 11:18:14 +0000
Message-ID: <c593bdc9-d9fe-4bf2-bb9a-e05ac8bc3c66@nvidia.com>
Date: Thu, 7 May 2026 14:18:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/mlx5e: Fix PTP TX SQ cleanup on metadata DB
 failure
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Tariq Toukan <tariqt@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260504223018.49556-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260504223018.49556-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::16) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS5PPFF2923D4C1:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b57176-dd15-4f35-f494-08deac2a54bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XMTEHv7oJgDnUuCm/GpNo1SGG+j45ryvDl/Jop6T1L2NAkH+NKGWBQyhhwNeoiXdGeanbsnkzPZWlW6S0FH9idh+XQFenEvWf4j8UGlMmbPW02GNaLwCcixP2WDz3ccuuoOGUbVQCkIUTdQ6owUs0fdI7yS5kwLu44w2b9R6w7nlKKI8alDOXROSk1CR5w2cAzHmTDipFcb1NNsFGU9LWlXnN2lqzfwWVIzMZjHtjb362AluaX8lBz18BsAV7Dejrc9ZUVjsl8hAOXvIrSdPtYEyO8whVpREs2bXF20xC4FLDx864HPXJJ02HaJMEuI8aiOxsTKTTckirZouVgrVckyc++cUuAKslWyMR/lctPYnk6IdEVZzmz2vr1f7dg7f5/7pS9gSlznV4kBTg6L+gmW87+VjpgkwUU97SPmeRODx9RWk8Bb25J2iVrs9a1wXVwecB9HDSw8M/ezaKMw113PRTB15Aw6FeW9Xzsyz2aUZpOL7+aWI+t3tWTFPUzpO6Rqf9tNC4QDV888G2+/wjrL8lIGUj+WuU+8MQLjAAjYGr2NVUVS3Vc0YxJ59IolHpRGfS0C+q4WZnw9StgQoQ5Q4AtcprHOmjAIqFE36tRAjSkyewpeO9F0xWn9VBSnEPVjxMBasvvopAgBvqSR9Q72ZvBi4mIeCMEPARobmNr0WlgX/h0mEMhL04oNxCzuU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTVrWkxkU3BpMWxrM0U3TUVoRmhscXNtYU8zQTRXUUJRVkZhSUxiRXQ2Wkhz?=
 =?utf-8?B?dzErejZXYngyeEhxTmE0MTIyRC9BN1U1dks3OTRDdlZyK3ZBYkk2N2oxSXpv?=
 =?utf-8?B?bHAvMEE2SUQ2d3pYbXNET3dONVI4Q2dHSXNKQXNLdEZZR1lQMTY1cUt0Y1c0?=
 =?utf-8?B?eFVqUm9mZUkyZDJjM3llTmJGUEEzeDU1bGFKRlNuWlUwMi9Hd2YzQ2FqVCth?=
 =?utf-8?B?SWRrSm0rMmpqUDM0Nm50YzA5MHhnS1F5NW5NVWFlMXVIUzRCZmF5SDlHaGxa?=
 =?utf-8?B?OTVQUTh6MHltQk00d2lpcHJhYnZXd2VNNExETXh1YkNYWTVKMm1lc0ExaU5p?=
 =?utf-8?B?Y3NVeHNGYTIwY00ybHVmS2l5WUhkUFNZZkJqZ2V2dWxlZ2VUT2xISFZFL2Vi?=
 =?utf-8?B?eENZZTR3cEFoYTNkblcvcHliQzk2SnBzR2tFSWNWRFZYZDZ5dTFkL2Z2TzY2?=
 =?utf-8?B?UVRJMVhMVFgrR2VEamxmM0d1QkxSVnJyeU5HdW5QaUJMMzVKRVNTSnhUbktw?=
 =?utf-8?B?cDRMWG96a1M4dnVVREFraDZtbmRaeE9FVTFBa2NzTGIwQ3o3czVlYXc0WjRD?=
 =?utf-8?B?dHVKSlpNbEsxMlc3VG9DMVZucFIwQ0V2b29EQ0pCa2RFNkdDaTF4UUE0ekdD?=
 =?utf-8?B?QVU0cTRtNEJ2RmwrcHRhL3gydXU1SFBLVU5hK296OVhXRm5wUHdwMVhYU01D?=
 =?utf-8?B?NSsrOGo3WDZjU1JVTlBVdmk2MkhuZkRCbTh1LzRSd1RiaWxjR3lpbXh2WG83?=
 =?utf-8?B?WlIwYXRUYTYxSXNqZ3B4a3lMQko1c0doMThvR0dtMFdvU1RRbzBrV2pFdlY0?=
 =?utf-8?B?U0R0Q0JsT0RISzV4UGtuVXpWaWxjNjdwRDlnMDNZT3FGWW1HOXZJTTlyRG50?=
 =?utf-8?B?SkNuRDk4R3JlaVZIbVlUZ2Yzd09hMFZ6Uk1SclptSkhqUEM3S0hEMnZ6WXd3?=
 =?utf-8?B?TkxYRWkrQnQ5VFBNV3FZaVpPbjV6bjBpbTlUT1RxYkdQeXRBckFtc3RvdmEv?=
 =?utf-8?B?R2tDZHVRNWYwN1FYNkhmWGJ1dVE3SU1xcGRHNDg3NlNpYkhLNjJFT1FwVG1S?=
 =?utf-8?B?SC94V1ZBWXA4NmVWc2tqRTI0S1hZL0U2UjJ6REc0Kzl3cXBKQkZPRjZZdEpG?=
 =?utf-8?B?Qm4yc0lTSHQrdnliUmkyOGYrQlFwYm5rZzBpbzExckt5bWl1cmk5TTA1c3cz?=
 =?utf-8?B?a3Q0NVVMdXpkT21TTVdQdWZpd2F4TFlUNERvbDgybWI3VHYybFBTMVBWZUU1?=
 =?utf-8?B?ajdFT3ZRNjlPZWpzc1NTNEk4LzJCSkRKYnZtZkNXSkFDOTYyNjVZdklqcVBp?=
 =?utf-8?B?V2U5M3dhMzBqVkl0TTIva0ROaFNhalFFZEFBQXNzalJiemNwZjZhYjFlbXZ1?=
 =?utf-8?B?TVpaSnJOaENTYkI1eDI0M28yVnJmbnR2d1pwd09aMUJRVGRKeGVjeEhGOWto?=
 =?utf-8?B?T011anVVaUhCQkQ2VzFRRTRERzhVN0x6N0NSbjIweTYwdWc3RWJmYjBPZ1hl?=
 =?utf-8?B?K2FBRUVlQy9SZ3grQllvT3dKY3pvMEowUUlVU1M3TlNHcitnVjZuNjJFZTlF?=
 =?utf-8?B?YUdsemVweFI0ZEFOYTFteDE2UDFoK2h3Q3Zhdnh1UTMvTkcxeUtybGZJYVh0?=
 =?utf-8?B?N1VSZXNZR1BwNmlqRDZXTVphbFpHWnJWZ04zdU1zRXdpaFdBRTVublo4Tmpi?=
 =?utf-8?B?eU5xb1Fpdkt6Y1I4TlRHRGhPNVJ3RFdjeFR3OUF4NGEwWGpkbGdiRjZhdnVK?=
 =?utf-8?B?NTlRYW9UZkFBZG9KeGNkdTE0TEtoOHA5MkJPQkF5SjdrYll5SWxNNzJUejdO?=
 =?utf-8?B?ekIxS2VWMjE0bUF2YUFFYnVpRUwwVENpVHBGZ0ttK0NkM0dTQkFsRUxlbG1S?=
 =?utf-8?B?VGVXWTN2cDVhdGdPZFhTcVBvMU54cyt4NzhMYisrdVpReklyVjF0MW5Kallo?=
 =?utf-8?B?bEswaHZ6b21QZW9MVm1pUWFDelRjU204MDRxMTJyTHUwOGJVRTZ1WTZoOERj?=
 =?utf-8?B?K2NVY0R4MWN3TkpXMHd1ck5YVEh2a29EMDZIVjFkQTFwOG1XSHdhWDJzTHdU?=
 =?utf-8?B?RUlReGkvekJxcXo0WmNacEkwaldUM21xQzJER2UvdzRjLzlCeE50RUFTRlZH?=
 =?utf-8?B?M2szZ2xPTm01UHdqRW1SdGNuTmlnSmdrbXB5eEJONitvRTdFQ3dQdndNYXNU?=
 =?utf-8?B?V1VhSVVOMFBFTzhIeUtSYVZaQzZ2bHZHZE1WeisrdXg5U0czN2tEdXJ2aDVK?=
 =?utf-8?B?NVh2M3JUYWl1eUpFbEw2L09LVmJ2QmZvVHI4MnJWT1dVZFJXT1Riam12Vldw?=
 =?utf-8?B?VmoyRG5LenNZNVZvTVgyd3RkbUxWWWNWcWNVdzhTM2ZtbTVNRTFBQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b57176-dd15-4f35-f494-08deac2a54bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:18:14.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXD3+abG2hLDXqOzcyoL2j0ZKo6oVH9h89O6ejMSPA8QkOF12U9yuhIkF67/iMTUBQoFpZjiokSIwOMofWMjPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF2923D4C1
X-Rspamd-Queue-Id: 2404B4E7526
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285266-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: no action



On 05/05/2026 1:30, Prathamesh Deshpande wrote:
> mlx5e_ptp_open_txqsq() creates the hardware SQ before allocating the PTP
> traffic metadata database.
> 
> If mlx5e_ptp_alloc_traffic_db() fails, the error path frees the software
> TX queue state but skips destroying the already-created hardware SQ.
> 
> Add a dedicated unwind label that destroys the SQ before freeing the TXQ
> state.
> 
> Fixes: 1880bc4e4a96 ("net/mlx5e: Add TX port timestamp support")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> index 723f66a6bd63..45db2dd7408d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> @@ -489,12 +489,14 @@ static int mlx5e_ptp_open_txqsq(struct mlx5e_ptp *c, u32 tisn,
>   
>   	err = mlx5e_ptp_alloc_traffic_db(ptpsq, dev_to_node(mlx5_core_dma_dev(c->mdev)));
>   	if (err)
> -		goto err_free_txqsq;
> +		goto err_destroy_sq;
>   
>   	INIT_WORK(&ptpsq->report_unhealthy_work, mlx5e_ptpsq_unhealthy_work);
>   
>   	return 0;
>   
> +err_destroy_sq:
> +	mlx5e_ptp_destroy_sq(c->mdev, txqsq->sqn);
>   err_free_txqsq:
>   	mlx5e_free_txqsq(txqsq);
>   

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

