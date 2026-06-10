Return-Path: <netdev+bounces-297691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KpypJZhuKWo5WwMAu9opvQ
	(envelope-from <netdev+bounces-297691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:03:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8337266A0F4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:03:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=vzsMgJ5k;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297691-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297691-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A1AF33D949F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4762E92BA;
	Wed, 10 Jun 2026 13:56:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BA325A359;
	Wed, 10 Jun 2026 13:56:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099818; cv=fail; b=PLkV9PhSsFII4BqJFqb3MGtAcM39rVMYp5mKEJmUj3AeVm6bzIDnnvztwojn6LP7oQhB1/uHpYOC4vmDBWuawBoDaAFPFe/8Uz1AXo+WyTS367Xn3PK2c+5Gf6VG59UjEEmJT/oMNXzlNOiINeHYnAe3X/XeJDu76pxeNyPXdqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099818; c=relaxed/simple;
	bh=Kt9BJ51m02p7uoPmr9uCFOR786FSgZd+8z86gRvNJmg=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sw7GNRhPHJYe1QAOhnlGM5U8vB1KTnqP5B5NiW4FNDJPNz923/kkbpI+mpWxzZvjFLJEKE95rbi229N0YG/ORIrrmEiMKXVYEvFnJoF/wlY5f/lUDywkMAG8JioSk+hjxMfRiBMClTMnsylcOOYGz1qBIyPoJXfJtx7OaxvqiQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vzsMgJ5k; arc=fail smtp.client-ip=52.101.53.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHztYz5b74zwH8Rim6RvVlPK+PnI0eyRSFBXOD1PNyV588+WnxjzxsVxwfh8v+zIU6Vwi+ULiiILFdFFxMjlFEnBukN82uV5GHTNnB8c0IsJadwLVCauY68GaXZqnkRXs4gblRk6h+mR6L7fCAkU+Lo27wkM4f2kGb814lQYLSifcZKqN4mZ0N/ZCOoe/YEu9kqOETxj7H4/CCqikwPVaaeJA7Lff/7wuzP/kuyoCojb1gm9mGcRYQ4cmf/uBPsePVfRLcI0phqF4z8ysK9ake8qwQFOxlP/arP2JGhxtDRzQihL0QvG+au9sDWpTHKUxFJfmdtcZqAez8juWB9hcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wB3fNeUl3xvPStAJZIrf8G7LLrVCuuDVGyfIam83Q4I=;
 b=QE280jTdTbhLAg35SmYo+Y17FtQBl5sDraeoNopKXA4B3bCZxT3huex6EesXOre8cUUVE3peFFK5N+vwmlljMi1Y3ZG70ywqZqRxYoU3uA3B04rqDN1zV1mztQOhP2VcfKxLgDkyrLOE4KtrYpbtY30Ri1r2EAYEvB05umNvMxk0K1xwza/q9fZ5wT/XVIBpVQoaamFvIt7EOijnxa1OiQmSbRtdDR95/c+ERz1x4VLAHVianqiLd+RQ3xs0+aYwn8cxvVv+AIb/6L8wriG4yfaltHMKIDLKlwJrlQDZjU8nN+D3RhneRaHC4/Raz2HRHqKCKLp7DM1eIUqgyDPLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB3fNeUl3xvPStAJZIrf8G7LLrVCuuDVGyfIam83Q4I=;
 b=vzsMgJ5knMSvJ3ygiye0rT22/+nec1zH30vtlqv6lB4KHBIE/9QJfcqAlp6QbH5OgpiXCVvE2ftunoowXOGtVREkMIBXaY5yF5LbdmzdTRxd3r/wRtn63i/UFXGKaWnbSZ0eZHXRqjchi+y7v24F3yMV/zVWgLyt31YM8PSvDms=
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Wed, 10 Jun
 2026 13:56:53 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 13:56:53 +0000
Message-ID: <dcc502fa-1a06-465a-abab-9b039b9c2672@amd.com>
Date: Wed, 10 Jun 2026 14:56:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-5-alejandro.lucero-palau@amd.com>
 <6a28a206bf61a_4fa78100e4@djbw-dev.notmuch>
 <96ee638f-3b10-4baa-a6df-5a79efee8b8f@amd.com>
In-Reply-To: <96ee638f-3b10-4baa-a6df-5a79efee8b8f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0219.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::17) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 81224c13-149a-45c3-11b3-08dec6f8206d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|921020|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	DB19Z10vRw1JxLUkPH09e8cvkhwgaFGL59FGXmspXli3vkH1IFOuKm/1lylpT8JirtBaSOcq9K4v8niGJ2wVONZvNssQt4SSFpP43BP4YAlojL3T9FKyjGxoEpSs099dFCpdjxKve8cdx9M8GQohrruKo5gvbzQKOaA0WWQ9bQWldGKse1rIcF08cRMGuBdrArOEz7RLglRC0k47hVuYjYgC1DUeTK05td+Z9gjdpcGikwEvQg1QQ0oe6rk+Pf7JweaehmDqe9VcPNELkMcMi7FWvXaYSv+t2Fop8Yujl3zG2tTlzb1qdydXzfjH4ZJHNducS/97r9VU9xA/aNENjpR6xB0s37KGyTbhSuXCOj7vBrTu5++MtZJAbJyfHb2YIE0A7p4JATeScpMKXwGZH+AV+DAblXts/xHuG2viFy+2nfpq5/+FZZJlb+1IO6lkFxLAO7qYcFW4sjqWqj5YJ6ZL5HaqXKXYzxJqoDo7ySR43ZU7wkucrPFS7OWItPr9poT+zSnxn52zCJOqYrtS3xr7nRhCCbfY40OXt++i638wt6IJWfUNeWxH9Yp3nJrxVtydG0qbKGPr4sxbOV43BYmn9T31+tLy2lLyY+QRYORkgCQk46Y20B+xN2hLILT+YsGnLJRuPW9hQhwsxQVUr/Q/tljsAdE44wqoIhdusw0MzO7ICDCf2g/lMo61gUMB/C9chmYgwTy+9d+i8NV2Yi6EfTVaS+NHq8g7/vpVwUNgNW2Tb0NdSt4mTqQhxA66
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(921020)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkYvWkNiVWtWL2wzOWk2Q3g3U1VLT3pPT0xyd2lSMzd5ckZGc2U3Q2g4aTc0?=
 =?utf-8?B?cEtSRDNUUEZaaTlhY0F4bmhsZkNOa1BDQWVpMER2SzQyL2lPTzVMbHNsYUQy?=
 =?utf-8?B?bW9kUDBTWHRTbGx1dkkzZUVoYXR5allFSUY0alp1MXhNanZ2NnRTRlpIYXJa?=
 =?utf-8?B?NlZqRlhtVC9qMVk2ZkI1ZmRodzFkdnI2V0RUZFl2MnhsVjc2TjVHVVlFZDZN?=
 =?utf-8?B?N0h2ZnFrVUs5bGROWVg1QmNHQVZpcmR1TzhWM2JCR1I2azFtQ1o3dnE3RS9t?=
 =?utf-8?B?T21wZC9BTzUrTDdFa0kwdlp0bHhEckE4YjV5dW5xNmlwNlpXcHBNK3B5RmhM?=
 =?utf-8?B?d3RVczl4bXllcG4xK3JaeUJCYlV4VmVMMTBPWFhPcmFUV2JFTjhHZjM1TW9x?=
 =?utf-8?B?YlZPdy9xVmdOcDBBajFjQlZkL2tLMDl0bXZCVmpwTEtOTjNKWENManNleXRV?=
 =?utf-8?B?Q3I3OWd5bDd6SFUwK1BNT1NVeVEvQXpZa0hyTndENzBXQUVIMGxIQmVOMi9h?=
 =?utf-8?B?cWhQem1ud251dWJ0cHpxSHgwRXRzajJQZUdrU2xlcHJMcHVJVUE5bitZcVIx?=
 =?utf-8?B?N3ovM0REaFBYdG8xYjRSTDV4WmxZY3R1N3RoNTVXRXcyVW9uTVpuNmQ2bzVK?=
 =?utf-8?B?RCtIay9YY1AwZnF2czRlSzIwSGlwbm4zejZIQjNxYmZHYWVBZURsY21uVUt3?=
 =?utf-8?B?eE45ZHJiWCtTdFZTMXN2c2hEby9qc01FWXM5TW1Gd1lnVUJrWTc4K0U5R3h2?=
 =?utf-8?B?NXk3ejZyeVB3cVI4azV6WW9PR24wQlh1emcxcXoxSGFkUXhiYncvaURnSk9P?=
 =?utf-8?B?dXZlTmtqaXp4Y3o5YUROSmN3R0FxSzlQanBLRDNYcVM0TEpLNWF2YXhqZmg5?=
 =?utf-8?B?RGoxc2JPQVZiNkptTm1zVWRpYWdqeE1Xc0FoUWcxRzRqekNkYWllMmRKeWhE?=
 =?utf-8?B?ZENkb0lQTFFxb1hFS0hLYktRaGRaTjZCS1lZaUpTQ0VDOVRZMWptcllSSitx?=
 =?utf-8?B?dXRTWkxMRXNFTkFvSE9TK1VxK3VxK1ZhNzhrWWpKMVNNd0oyQ29CUWJ5NFVi?=
 =?utf-8?B?amFsYjFqeFlQQWowc3ZOS2ZCc1FUbzlqdC9rL3Z1dkd2ck43ODluRXl1bFpG?=
 =?utf-8?B?eHg1cEJ5MFprT2QxdUQyNFZmejFVeGphaTR3VnFwQXRVZTZiVXY1bHpKUFY2?=
 =?utf-8?B?MTA1OEtKVUFCZG1PN0JYdWY1UGEzVHNuWDZ1WXVFUWdXMUJwSDZjMm13dGlE?=
 =?utf-8?B?ajBVNVR4VU9SQ0d0MnVYM1ZrSmM3ODVQS2dpY1FXZWorcHhLbVM1U2R6Nk1W?=
 =?utf-8?B?dWtCWlNWalVWL2ErclpxYmg2MG01V2FtWFJBWTVQUGxPZWZXcmY0UG5VT2Nl?=
 =?utf-8?B?TUY1c2ZlSkUrUUp4QXdRQlRPcnJLMGVWV0VNM0lLK1pOUGxhRjhxbVdJNDRF?=
 =?utf-8?B?WUtyQ2IzQm5CYXUrQWVjK3lEaTBDUUtJc0RnOGdzTHZFaFVOaXdadzE1YW9Q?=
 =?utf-8?B?OEdDVmppbmlyR0tGYysxdmZNVGtkZjhRVUpTUHNzM0pVa0kybHovRGFkMXNs?=
 =?utf-8?B?c3RrQWdocHc3RWhETUFnMjZZME42aDJVNmdrdE9yYkpBSUlRYjgwZE5IUFVn?=
 =?utf-8?B?Q3VmTlU5WnNiMWtmSzl2enZoZTdtb3RVa2Zna0R3ZC95S3dNQ0N5bjJZZ2RW?=
 =?utf-8?B?SFFhMGE4SWpaQU1ZdnlibVlHbWtVbXFlZG4yUnVteEZDL0haNWdhZ05BSXpj?=
 =?utf-8?B?bnNOUzh5aXZvVklxOENobUMvKzFpYnJKODU3eU8xcnFyUzZmb0hmR1NyNzcw?=
 =?utf-8?B?Z2tiM2ZSWWZLWkJnQ1ZQYzVhbysyQXRFMkI3QzdxdXc3b0tyeXB0KzJualZt?=
 =?utf-8?B?TkFiZjhNVDkyZ2RFYTFsS2pNNGZGaFhCN1JHSURxSXJqVC9FWG1KNnVhWWVo?=
 =?utf-8?B?dk12R05HdVdCS3NpNWxrTGJYUlVkMTVyaUZPSVpSaUY3amU3QUM5ZGpzWTRH?=
 =?utf-8?B?NktYN2MzSzVrTjZnbHBQTnJRVzhwTFYwT1R1cEgvSHlLVno2TDc0UHJaV3Q4?=
 =?utf-8?B?U2JhY1cycXJlL21YTmY2WTlCTXVMOHBqemwvOU5aaDNROEtXUUtRcFZxbHJi?=
 =?utf-8?B?WXh1c0RlOEl3dWJuOFA2QWI2dEJBNUpHTi9iaFVBSGdNbWdHVjl3VXVYQWR1?=
 =?utf-8?B?dlpzQS8ybU1qZjV0WnVSakt6Ky9JTEtmbS92aHBzUEVGVFZZMVhoZ292WVlt?=
 =?utf-8?B?SXorcUFyaUxJVitSSk0xelNub3pxamtYR2grSERtWXF5QVByRTY4RENBMHJJ?=
 =?utf-8?B?NDlVUjgybzBGeFd6TEZUanJjNzhINDl0VlJSTzFac3NYanhQanUxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81224c13-149a-45c3-11b3-08dec6f8206d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 13:56:53.3760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BRvh0ZV+pNK7+QH+8AktnS3vOM6bHsBp4lUh5p60E0w39OEg85u1qwk1bCBO2oF5gC5iSmbyDnu75TG1Q+R4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297691-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:djbw@kernel.org,m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8337266A0F4


On 6/10/26 07:10, Alejandro Lucero Palau wrote:
>
> On 6/10/26 00:30, Dan Williams (nvidia) wrote:
>> alejandro.lucero-palau@ wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Use core API for safely obtain the CXL range linked to an HDM committed
>>> by the BIOS. Map such a range for being used as the ctpio buffer.
>>>
>>> A potential user space action through sysfs unbinding or core cxl
>>> modules remove will trigger sfc driver device detachment, with that 
>>> case
>>> not racing with this mapping as this is done during driver probe and
>>> therefore protected with device lock against those user space actions.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/net/ethernet/sfc/efx.c     |  1 +
>>>   drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
>>>   drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>>>   3 files changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/sfc/efx.c 
>>> b/drivers/net/ethernet/sfc/efx.c
>>> index 90ccbe310386..578054c21e79 100644
>>> --- a/drivers/net/ethernet/sfc/efx.c
>>> +++ b/drivers/net/ethernet/sfc/efx.c
>>> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>>>       efx_fini_io(efx);
>>>         probe_data = container_of(efx, struct efx_probe_data, efx);
>>> +    efx_cxl_exit(probe_data);
>>>         pci_dbg(efx->pci_dev, "shutdown successful\n");
>>>   diff --git a/drivers/net/ethernet/sfc/efx_cxl.c 
>>> b/drivers/net/ethernet/sfc/efx_cxl.c
>>> index 4d55c08cf2a1..d5766a40e2cf 100644
>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>   {
>>>       struct efx_nic *efx = &probe_data->efx;
>>>       struct pci_dev *pci_dev = efx->pci_dev;
>>> +    struct range cxl_pio_range;
>>>       struct efx_cxl *cxl;
>>>       u16 dvsec;
>>>       int rc;
>>> @@ -75,9 +76,32 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>           return -ENODEV;
>>>       }
>>>   +    cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
>>> +    if (IS_ERR(cxl->cxlmd)) {
>>> +        pci_err(pci_dev, "CXL accel memdev creation failed\n");
>>> +        return PTR_ERR(cxl->cxlmd);
>>> +    }
>>> +
>>> +    cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
>>> +                    range_len(&cxl_pio_range));
>>> +    if (!cxl->ctpio_cxl) {
>>> +        pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>>> +            &cxl_pio_range);
>>> +        return -ENOMEM;
>> Dave caught the iounmap leak, but another concern is since you want to
>> continue operation if efx_cxl_init() fails then you probably also want
>> to release the successful attachment to the CXL domain if this happens.
>
>
> I will do that.
>

Looking at this issue, I think an error when creating the memdev or 
during the region attach triggers the memdev removal, but ...


>
>> Minor since something else is likely to fail if ioremap is not reliable.


.. if we want to specifically do that with an unlikely (but possible) 
ioremap error something else needs to be exported like 
cxl_memdev_unregister(). Are you happy with that approach?


>>
>> Otherwise this looks good and with those fixed up the Reviewed-by still
>> stands.
>
>
> No Reviewed-by yet ... this is a new patch after your series removing 
> previous functionality.
>
>
> Thanks
>

