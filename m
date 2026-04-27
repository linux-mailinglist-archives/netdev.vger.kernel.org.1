Return-Path: <netdev+bounces-281359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCr8L8Js72kcBQEAu9opvQ
	(envelope-from <netdev+bounces-281359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:03:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D195E473F6A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63CFF30438EB
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E763B0AD4;
	Mon, 27 Apr 2026 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O+PQM80e"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC631195C
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298126; cv=fail; b=uz0pBSh/HfMin1xwo21DA80/wee5QKcbHV4xmxA3+LTmO+Ip7Do+Xt+hsApLAAQBI6QRfQPb2vA31iSpaAqMGGUmQI8NwqFMPt3/Yna1egsVrIalRHAC0hkPWgrylpAepp/Ntv5LGJPb464foSw+Pe1mPsywfWyxxyY+n4stTWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298126; c=relaxed/simple;
	bh=m38wk5DqhTsRlVY2D/k9IYecInHM7Qc7dy1+sp+YUwM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qp+lHtZbMjT0cmFcCV9pHtUuQKYOi50Yq1GVZ5YK9/rXg2s0KqcH5FQfjU9jtJTIfDQb/nA9tkDknZOcbS0tkCg24Mdaf2Y8LXE8+JuVYf3Z1D6kfQsmv3wQP+is4+EmmCFXXvAnOTzJ+TJMT06sUJD+x4taXxfiKkgxuIz5ddQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O+PQM80e; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cL5wP9t1+b0BWdjoKOTnlWwKuokQLs0VJRk9Fvmbag6trscc31IHOdKhV/DnFxUbicZbMfDNe5+hOqYjMZaqbZ8EaA8mZqTlmzwcMOcIUyW+KL5ZqektM49yjnoRy5Z1Ok7xpsfrd/R1GPYIc7nEDewxcw/lNVa9WhVG4HbwG4XgvTsPdCZ8Z0IA7kOkdra3J5k6fqjhYC4mgAkIiw3AMlWrcmtjfsIBM7/IBO9NkRIW138A9WZg75k+tMblaxhNUwbWqnSEq8uBPqIJd5SQ7JjzX9q6hZmMtlk6Aa2393YU0qzd8Xbs5zsUZI5zc07F3t0BTq/De53UeKSg9D77mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7ubS/gAq+l/nVecxQEBSpFINt09/82x1CGZhVW6BoA=;
 b=hxlwIjdudSiMcjxwxihuQzCzXJwn/yg0F6Y9NUE1a6FUXnHcVt8351K/NbTXu17B8EOYs4jvhr1wt+OLhoiDVRTjA9a6f7dhsx5omQ8qAMXEdk2d2C45+vtL4hVDvskku3xOqUbL7hCARUoJmM9AH14qSRX6oNVxZsAdAgGZ+lijRyFX9TkgnJJXlEwbfVOmyP4/9WmiO/95u8AvyRFyOGw1PyflCC2NcwnXF9s+iOYNtODSlpM47P2alPYuS2zQesuzWCCBYR8pLZN55lHW0OIPbm2nk1gCn4gIja8w5kIpJIk05kYSlfyUIcctKTGxvuQdu5uZsxlVJCw39FsIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7ubS/gAq+l/nVecxQEBSpFINt09/82x1CGZhVW6BoA=;
 b=O+PQM80epokyyQau1KhNF3pEpJxQx7MR7O1Xv6jcxbFDx50i1gdur9bj7ZTlfWM6IGuJrTuHGWpGtDOMQ7EfY/XJ0IsEySh2qHEcOFXBw9K/aU/gkUffRL+aIjyDuh1yMbSWyxAgX+/xueFE4k1eFf/N68MESJGthpqbK24lc86/mYdDF5rnqck6V5ALlDP8IJk+NAWfR70nldG+zKseaA6+1N/4uobcvtbMN3dRuNhJtPmIL9yBeQcL3FtE97Tv+FvCpI7qHt9hGh2zeJPOlF4kRPPoP4H2q4AjUkimR7F3IxCi64SggzzKZ32clGha6h1IhuPIpZFOisbiatR79A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 13:55:22 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 13:55:19 +0000
Message-ID: <1126aa35-1924-492f-8d7f-072c0dec9bde@nvidia.com>
Date: Mon, 27 Apr 2026 15:55:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] mlx5: VLAN-aware bridge drops all traffic in legacy eswitch
 mode without promiscuous
To: bryan <bpliscott@gmail.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com
References: <96b4d723ac443f3a42680fa1c8b94b929df39da3.camel@gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <96b4d723ac443f3a42680fa1c8b94b929df39da3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0446.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::12) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: f5046ac2-aeb1-46f6-5a63-08dea4649e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jFIC7EmAw1tdt1/B+SzLMrSNfV7ge3NuHcAZVUuqwbrMJOedhDny28BJgrlQTSdLwoE7TzxuLBRM/xMKQd80ZQYQLPbrrHnUCHsPPiPLJzKojmEceOwYDgKWZLeKzEcyEGkBlYAYzUa6f9cw7vus745Ld30xupVProV7w+gHbYEagiLvkrGtugwMxW5i92hsJeJ6jR4Pv9k/0vNOFJZCU5Jz2cc//MpItxlQ8bo2OjmVoolcYGIEcLlUXf+XvHGZzTWmWpkQ9S9k74Nk5cgNbJ4+r3H8HDCLwu+KWw8pskCrGIiNac3yZYTbHI1jofvNaAlm4IAxkUHuwofPZsQQKHldRA+SiXAqjW1/fDJ7VvF+/KIJl+ljjGHNEkN4HKePYXpMu6v2n+TMERHO7F8bayGzj3MnuV1s34508Zwj0EaDXYGXSIVl6EbzvSe9lkHrtnI9uDjFbahgiIKY9paac97kjLSyphAL1iyiNTTOLgJ2c/hCFiRSolLlXTk7ZZdxJu6NyPkS+QVQEmeZluSgvM+EuFzvxPHwvrOmwkApFPbcZxI+PD00aBJTiNqnEHyAsk7q0zMi7zXNsJd837ggkRm96HjZnkfiE55m3V/wZB5X60pXPAvsEkqlKsmFguXwLVKhJexzKcAcJAy+fhPKQUF1FQeChyKYjuWHvvGs07W43im1+y1MWYtGixATosBS5wZfma85fD2FjBqt19m4jLooAr+1O+pT4JWOiPwLS2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0xIc2o3T1VxMGpqTEN3WTBESU0xNkIwZHNWS3RvQnp1eTN6ek1hRThnRHJ1?=
 =?utf-8?B?SEljUlpwVHI4OFZMYUwxb1UzMEFrRFVGeTdPM3VGdU5lWnc3cS9TeVhCazRK?=
 =?utf-8?B?YVRyYytHcmZ3MEhDZ0oyd2Z2ZmU0Ty91bzRLZVhxZUdYNEtJR2Q5eWovUkVP?=
 =?utf-8?B?ZTNUbmZNb3VkaG5telVUa0JweVBBZk5seCtvNUlVZFdWNGRDUXRJem1hWno2?=
 =?utf-8?B?T1ZGYXVOUm9CVDhhK3pHMHdPb1M0MUFVUlUyNG5wWjJ4cnFwU1laVDZKM2l2?=
 =?utf-8?B?ZVd0STVuR0ZsRHZkOW8ybUs2alJNM0FVMDV1OC9SWllyM212djc2R0QzYTBu?=
 =?utf-8?B?Zm82Y05qeGJscnc2OUd4NTVhUk5wNnNwRkpaRk9aeHFOS1g4NE5sVTdFQks3?=
 =?utf-8?B?RU0vQVdwcGs1NjVpMDVkZUZWS1N3V282WitZSFY2VUJMd3ZjM1RUdTRNblBS?=
 =?utf-8?B?R2l2aTN1Ym1GeHJlZG5SQTFCbDVaRnJ2Y1Zqb3FOSHk3bGZVMHdaQXk4U3h0?=
 =?utf-8?B?WUg3eUp1aVlvbE04M2dXVlk2VmNqdi9ZejJUdjdscEJPbjNjWitZMGE0Y0RY?=
 =?utf-8?B?dEhjR05VL3YzcVg4S0Erc3hGaU5QUDRmYjlaT1BTMlRheVVSWjVDcXRiMmE5?=
 =?utf-8?B?MTVTM3AxT2ViSDh0aHVnWDhIVG9FdnZ3QXFkL2dKWHh0VmlXZFpzQVdFMVIy?=
 =?utf-8?B?N21ibHp6T0c0NXJmeU1qMzF0MEVsZ0FuVVZMYXdGMjhvTDM2MDY0THdNenVZ?=
 =?utf-8?B?NHlyYUFKeVdMQUlUL1ZEK1h6UW5NSEF1dTJ1NEpCd0c5cm52d2dQKzdZam12?=
 =?utf-8?B?aEN6ZjZ6aTRmcm1RdjVoNUs3TFFUUXREUWF5dW1ZRzEwMitKeHo2RHRnQzM1?=
 =?utf-8?B?UllWWGZJc0lyVFRIcjNDeHlham9BcFdORysxN0ZvTVZybU9OZ1Vxd0IzaitK?=
 =?utf-8?B?dXd6cXR4bzhIbG1oNHZGZis4NW1tMnZyK0I0N3A0ZEhWNk9zSC9oSHpnbmxa?=
 =?utf-8?B?cVNvQVFLZGd3TE52bEwzWG1kZlg1NGUySlBNR0QrWWpsWEFjcXppeWVZVStB?=
 =?utf-8?B?WVVOK1krci9sampua1ZMY2NZMkprd3pXTTEvMTRQL0UwU3RCWnBIRFNnV2Nz?=
 =?utf-8?B?dVlHV2F1WDI0bVVaWFRSNmg0c0lEMXdXN20wc3cvY1B2WUVyVjFYMGdaOEQ1?=
 =?utf-8?B?MnVjaHhRMmw4Q3FTNURPY0lUMGxMZmVITEpPVVViNkh4TVFsZzRhb2hkL3Fu?=
 =?utf-8?B?TGY0bEUwbVVFMzR3bTJOUUNBd0RpUlcydWtFdnoyVys3blA2T1dMQWc2QU9s?=
 =?utf-8?B?ZjgweWxMU0hGQWE1VXdBMHQ2T096TFRGVFJobHBEYWZpWnJDZkFWeEFsYkdB?=
 =?utf-8?B?akVRVGRRNHRzRXdBOFE0bEJyV3d0RVFyVE9JbU5VZFZpMEpXVlc1YVFjVnRO?=
 =?utf-8?B?NTZCQkdBZTZJRklTNnY0MmhyZGxFbTJzNGhHcXZNYUVrUmRqRk43d0RXR1cv?=
 =?utf-8?B?SzRCZzM4eExOK2dsQm1JelZMdThna1pqeU01ZU1HUUl0dlRMa1lSc2V2NEpI?=
 =?utf-8?B?V0VUbGtOZnMraDFsYUs0RDdQTzU4T0wvODJBa2c3VDNKOVhDWnNVdjd0MkVq?=
 =?utf-8?B?K09vaUduc3NpQ25ldzdvcnBORkJtNnN6Q05SWXFwbVlRVkIzc2lUa2tKa09F?=
 =?utf-8?B?SnBlZlVaSWJSZDFsRkhWdmdOSkFSZDRnbHIxbkFWRWs5ZVpheGpnZklKVVgr?=
 =?utf-8?B?TTRCRW41MUM1OVdnNVBWV29seFM4ZWxCaklXUGJOeW9HZEJxeERWVFNNVmdY?=
 =?utf-8?B?MVVSRjRsWHhCeEpROWJYRVpCRWNHTGVUMnpuM2VMSkJmMko2S2h3NDFwU0Y4?=
 =?utf-8?B?M1I1ZithVHNaL3NRNWNOWmdLYlNlOVdwUEp0bkl3blJJOHBWQVcwdGJqdEd3?=
 =?utf-8?B?RUo5ZkV3eC9ZYWZwOFZlQ20xTVZLYXNRdExlT3RGQ3lHRjB6RGRwVTFsaytm?=
 =?utf-8?B?SE5IblFjK1dNaWxPb042WmgvcXFweVg2dldYeUxSNzZXaGVIMEh1dms5MnJy?=
 =?utf-8?B?SytQZW5uRVVnS2c0SFB1c0hScE9ZOVBmRUN6WC94ekZvbUVER092QUNja0JP?=
 =?utf-8?B?QUdYQlUxY2s0Nm8va0s4SGQyZ1BRRXdzNklQMVF6S3NLS1lpTks5VW9raGZm?=
 =?utf-8?B?dkw2QlByRG45VE5LclFwZnFLeWtReTd0YWt6SWpoSlV3SzI2YjlFTnM2UC9X?=
 =?utf-8?B?empHQWd6SGY4U0FpN25QYjVnMXpQYUZqeTgvdFdMRFNoYnNOaTA1Y25zQUFw?=
 =?utf-8?B?STZlVzAvbjBEeHNMaHEyTmRtZXBCd2F2L3o5aDdWcmZwOUt4MUN4dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5046ac2-aeb1-46f6-5a63-08dea4649e35
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:55:19.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMnHkjNBw5YclIGR9aI9Up/htOY8arSUuIXXAD2QRN2TihYFI2JXLNCXi8spxp6owi9oM4Hil1s1KXxGrthweQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764
X-Rspamd-Queue-Id: D195E473F6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281359-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,apalrd.net:url,nvidia.com:mid,nvidia.com:url,proxmox.com:url]

Hi,

On 24.04.26 13:07, bryan wrote:
> Good day,
>
> I wanted to check whether there is an open bug report or known fix in
> progress for an issue that has been affecting mlx5 users (specifically
> ConnectX-4 Lx, but likely broader from what I have seen other
> reporting) since at least 2021:
>
> When an mlx5 interface is added as a port to a VLAN-aware Linux bridge
> (bridge-vlan-aware yes / vlan_filtering 1) in legacy eswitch mode, all
> traffic stops passing through the bridge. Both tagged and untagged
> traffic is affected. The same configuration works correctly with non-
> mlx5 NICs (tested Intel, Chelsio cards).
>
Is this even with one vlan? I ran a flow on a CX4LX pair with one vlan
and vlan_filtering set and traffic seems to be flowing normally.
Something like:

# IFACE=eth2
# VID=100
# ip link add br0 type bridge vlan_filtering 1
# ip link set "$IFACE" master br0
# bridge vlan add vid "$VID" dev "$IFACE"
# bridge vlan add vid "$VID" dev br0 self
# ip link add link br0 name "br0.$VID" type vlan id "$VID"
# ip addr add 10.0.0.1/24 dev br0
# ip addr add "10.0.$VID.1/24" dev "br0.$VID"
# ip link set "$IFACE" up
# ip link set br0 up
# ip link set "br0.$VID" up

From the other side where I have a similar setup I can ping
br0.100.

Tested on a CX4LX with FW version 28.48.1000 and kernel 6.18.
eth2 is a PF in legacy switchdev mode.

> [...]
> This is well documented in community forums but does not appear to have
> been formally reported to netdev that I have been able to find. My
> apologies in advance if this has been reported and I wasn't able to
> locate it. Here are a couple of forum examples where this is discussed
> among other affected users:
>
> - NVIDIA Developer Forum (opened 2021, unresolved):
>
> https://forums.developer.nvidia.com/t/vlan-aware-linux-bridging-is-not-functional-on-connectx4lx-card-unless-manually-put-in-promiscuous-mode/206083
>
> - Proxmox Forum thread (2023, ongoing):
>
> https://forum.proxmox.com/threads/mellanox-connectx-4-lx-and-brigde-vlan-aware-on-proxmox-8-0-1.130902/
>
> - Community writeup with analysis:
>   https://www.apalrd.net/posts/2023/tip_mellanox/
>
This last link seems the only one that provides some extra data. From it
I can see that the amount of VLAN ids > what the FW supports. This could
result in loss of traffic for the vlan ids > 512. Do you also see in
your dmesg these kinds of errors:

mlx5_core 0000:19:00.1: mlx5e_vport_context_update_vlans:179:(pid 13470): netdev vlans list size (4080) > (512) max vport list size, some vlans will be dropped

This is not a bug, simply a limit being reached.

> Has anyone bisected this or is there a fix already in progress that I
> did not find? This affects a fairly common hypervisor configuration
> (VLAN-aware bridge for VM networking) and the workarounds are not
> conducive to production use.
>
Could you provide a short repro script for this. Not being able to
reproduce the issue makes it hard to check :).

Thanks,
Dragos

