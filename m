Return-Path: <netdev+bounces-297448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fbCMEr/6KGqvOQMAu9opvQ
	(envelope-from <netdev+bounces-297448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:48:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C5E666005
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:48:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=tw1FmFNH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297448-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297448-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51E6B301AFD0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2A630C354;
	Wed, 10 Jun 2026 05:48:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C3B2C21D9;
	Wed, 10 Jun 2026 05:48:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781070523; cv=fail; b=k/L6Ct6eZnaakUkO49sc1bGUSBpnM++76sxNy8dYcxD034iVG+nvAiImkwCVkQE3tjs8x4u5NxMdohY1cWKmz+EW/xSZMHFKcBf2MSx00+2oApcAHPpYFsFascYmFi1W1kxVOd3aXal9SXS0SIK5YtYRnDktf/bPuNXStazmdi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781070523; c=relaxed/simple;
	bh=5gGTYGq/fiGb2Zh/n0+PR/TpcJxgtYy3U0kjueJh2uA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H+NVDysGEcE1S4xlK8akvSKWK6IdiTqc2IlXDKBMBDirPInIl97zNCuK6Z/s/dYWM3mZtG8oQH1DoelgAhycodEEGzvngmEYIYmBfGKYMUsF6gYmQv+sEHbTmn4H10yKP3JKYSI/COVH+VgjKeUsd3dyiva0cEErzKUC6uZLMtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tw1FmFNH; arc=fail smtp.client-ip=52.101.85.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjgIpRYQ974LfeKrPFA+THvTh3Zn6Vq67lbW/XJIq0JkWWRK8L1CAIzWMgNtJm65qtKtGihyrpUe245vc2WVjr/avr2XmWVx8XeIdJZN4ZIr9F480doeDXgm9nJ6Rq1QLgBcpJ55wKftabif0k0UUkntdbBXVUj/ODuhPYMoBy8gJzJY288JWBktIkbiIWxO5e80ff0U/+kD8fsYstv8o3pSeelVnYa5So/sRoE0vTy6d4pmy07qO0mxnm9FGfHcUsRUn0mTZYek78LVk2S3JkMtBG4oqHIRuQ5oBmDftdUsvI8jTv/xjGMRblLzQCrB0U1595wjsJaj+huEv3r7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19tLnWGsRQJxW/6uNRyyoDzwNZKUSP1PyfUBUF00BAI=;
 b=DFQIQugy5kffGsLoP7YtqTelDt4KOKovhzURMXXP5WLN8EVBEizTi8h4gh8EZmMxll2UilmZ8KvmhCoJDtd5kMo/lEBKupiuqVfVE3YgLvs9kG0tOqn1Zu7XeacSa4dlwZvu/T66e9OFw5mPTlNiDEzOenr7pwZmk64DJ9g7svuNFoWtPWDFvxfIAsvpFxLpbZmeBTqW3vW7t4r7GY+JtCiML/EoblO5Vhf6NEBpmYhDyhlb7wyaDkoYPgsnCPYdSNW0zna6regbCzshMYo0BP7yNMRi2Fk5IRiioBlW7d2BvcIF7WIJULMW5fWt871i1evsuHNhseYAiDXgKbAE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19tLnWGsRQJxW/6uNRyyoDzwNZKUSP1PyfUBUF00BAI=;
 b=tw1FmFNHWiMhhatlsS0nyCDfyDXEuiS7ll1xH+DfGWjCX5yaEPZgPGfRg/vo8L/cW+IQjcO4/DVESnFO9ZiNJSh7MD6X+n1E/0Z50dI38jSo8WLtYAzlN7rbXpEzJObEjboHgLa6h1/UTRgor3t300cjpI5clrfM3TrpdNLCkRA=
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 05:48:38 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 05:48:37 +0000
Message-ID: <eecfa9a7-ca27-44fc-9ee4-d492050f7d51@amd.com>
Date: Wed, 10 Jun 2026 06:48:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, djbw@kernel.org,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-5-alejandro.lucero-palau@amd.com>
 <6e42786e-fba4-48bd-ad84-e22e9d3224b8@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6e42786e-fba4-48bd-ad84-e22e9d3224b8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0476.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::13) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 01787305-b792-429c-4926-08dec6b3ead7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|921020|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lLKtSdFzsApyfgDK+/1Ab2Ko6qsGOnEfgcUc80D2NagqwbpIVfxqFqy9xV0zQwxmG0JYQG+CqggN7rPi9DFoJ49nIP2GZXLdIbov+HIzg7XnoJN1O/EaBEuA1psjBHPG/ToYVxRcSsOpoOR3bxMuGJhDvN3/rPnAtrte2f16SbZzGXKgonVng+yRZSAbyWTkWKHhB05Q5KGkjlODUdXnfeoI3WXIy7wGhZJkAy+CZFvaSiKlFziVkKl0dUPv6Hsgznm48zmzbcieKg9jnEJuCKGivbisHTsFo+asbiKUVjMHsknZyBnpHhnMam1vRSWoXhQALhzDJR4jDNywU++6oeNZqKFEJ7J5OjwG02Q3xG51e5ti30yho9/Sh53GGJqgFQGcB74qmfPtnDNqYx2cF1TqSRxYBQAbbjkrn1SO/JgotNHmnwhRufjpSvp3tg77aqLaorxuuEmuDzkiho6Vg+ir6Mb3heoko477jD8SyrzGhdZHFYCRD7MB4dmM0LxLekol1YNd3G4RkScCUOCHAfZXNHIGO+k/qG3xOkDTu2Ru5PmnSUpVW67cu/MpN0+g8OnvcM2jPQaNDgWcWJc4ZoU401b8ykvjXTRo3tf+D2dkCaehd1J2hMnBCNbqaASbT1rjGU7Y/3igExIuZZDirntOV1//vTmf9sQHaGfqAl9pTwkPLhECxheh1PeGX1mAVGn2ZRaDPMMi6Vwg014qaSsl1B8Q4yX+79xr57EfLUq/l7w9U7t7JX98S0BaB3ZX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(921020)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q043a0JQTGgyQ2psWVNuU0hjYnVMcHF6OTVIcjBOeDcvQ0JXOUJkaG9aSUF5?=
 =?utf-8?B?RkpEeHJWeDMvTzlkdStrZFdWUmJhL09jZzBPZDNwcjVVbEFXaEhDdDIyNnVF?=
 =?utf-8?B?cjlWak8rRHJQcmNrLzB3bFhKZTlseVdKSWNqVGdCRGlWLzhWcjZ0M3hxTGZZ?=
 =?utf-8?B?NjJ6bGMzN0dsU3lsczhaeFpsWkNWcFhXdjJwZWFsMXBJaHZpaU9BcDFQRWlP?=
 =?utf-8?B?VjRZbUpJWnFLK0J0aVRXRUFKSkQ5RnFnLzlqbGFMeGxIK0hDdE1NVnUvaUpi?=
 =?utf-8?B?VURYSFIzZlZGaHB1Z0tlNFpHY2JsNk5MU205Z2VEMmZiM1BhVms0RytWQkd1?=
 =?utf-8?B?NHozZC85dVlOUlMyeS9pSUwrcHA3VXYwUHZWcGdEaVBTeUg1U3F2emRMZlpM?=
 =?utf-8?B?L1FKZHF5T05jZ2ZraVI0RFZsaXU5N2ZES3RINHdoQWt5NnBtWTRqdDF2d0tl?=
 =?utf-8?B?QVBKSk55YWFIUk1vbHpIN2RqeDRYcGtxOVFtUUdkV2RNUnRFVFk0N01oQ1BF?=
 =?utf-8?B?eU96V0Yva2UwRE9oNUw2bmoyc1k2WHhUTXM4eXd0dmY5Q1pYbExHbWVScG5Q?=
 =?utf-8?B?MWMycm4zWTlOM3JoUnJtc2hhTjlwbzc0RzlNYkhnSGxtWjh5bnNwMDkvc3RV?=
 =?utf-8?B?NWU1Qi9WTnN4VDR2MVBjbVYrVGNpWGVoME5JdWpVdEJEMUVTT0VjT25uYjdT?=
 =?utf-8?B?WjZMbHdoa2RWVHJIV2g2T1V0akk2cThQYjhKT2ViczVrUkJWbFhiN3VCMFpR?=
 =?utf-8?B?YUxYaTFXMTN2NmVNbVFVUTBTV0djUHA4WE1OZ2VGREVNRFhKSUtQV1YrN0Er?=
 =?utf-8?B?U0o2UFdnRlo2RDYwT1JPdTgxd0t0Q0Y2dzUxaktSaldDbEgzV2pvTEQ2Mytw?=
 =?utf-8?B?TWFBVFZMVTVNbHhDc05vLzJtRVlnZ0s0a2ZQendWU3N1SkRick05UHRGMTB3?=
 =?utf-8?B?OU5yN3ZuMDBjbWREOGhwRXUrWjNkRDQ4a3pEZ1NNOFRDVTIwWVluOGJRVVNN?=
 =?utf-8?B?VmIwQThJM1l5TVB3SjRaZU5KS0F2N2RWRWxuVUtKNHo3cjgvWmU0ZjByUlVz?=
 =?utf-8?B?Zm9lWW5KY2ZDclhPc2NXMTV1U21xY3hkbEdOcHpESlJMbWJDbzZUOGhNdjQy?=
 =?utf-8?B?RDk3SHJsZXV3ZC9hZHZoVEZSUHNsWWpFdWFJVHYxWjBObng2RSs0cVVCblZI?=
 =?utf-8?B?ek5PdWFBZkQ2QU9FMW5DVkpiWEU3Y2JQN1piZ2hJS1lPaVlyenZMMmViakR2?=
 =?utf-8?B?WUZueGFRaWxDcFp0c1NGYzhTaG9OM2pmaGFTbnZFOUxVYXEwTW5OUktQZUFW?=
 =?utf-8?B?V2pQTklYKy9mTmFpSGxYNjRwdk9mVFBEaEN5YmVaR2tOUDBoV1p4eFhOYldF?=
 =?utf-8?B?dlpXbFZpU1cvenp0SmZFaWZqdWNYNWNKeWlVaytmK0pNc00wYkgwMDA3Njh5?=
 =?utf-8?B?RThWVWFFL1dVbHNNR2w2Wm5QTk9LM1lTT1BtYi9hMEJoeTYwamw2YnRxZmRH?=
 =?utf-8?B?bDZpMk9EbjVTRTFkYVAzUWZ1UUJpajFDaWlGMmhYSGQyeXJXTFVPZWt5UGtR?=
 =?utf-8?B?QWV5UGdUTWpvTzliOEdxaW81OC9FME9XRVhERDE4ZTUwQTVNd21KUngwZFZL?=
 =?utf-8?B?eG11NnV3TEd5YXFpelRqdWExOE5Cei85bm15M1dzU1NjbmlGdHI1NUFySHYz?=
 =?utf-8?B?akZhNFA3QmJYVlZVK0ErNG9JNjZNandwUVI3emc1WjFHRndlZ3hvMFJ3ZHRo?=
 =?utf-8?B?UkFLTGZBejlhaytCS1VCblJrekI2L3hFbEVTQjhRSGZMYWdKVUJQSEZxR0F1?=
 =?utf-8?B?bUtsNW4vTHFISi8rdThUWVFwWHZISzRMOW9OQ1c4NDhEYlpUYnVIdGtMK0ZV?=
 =?utf-8?B?ei9OK2FxbHhKcWJMcExHdnRSZHNDMlpDZUJ6dmJ6SnN5SmU0R01HMHpyc0d0?=
 =?utf-8?B?YTBlWUVGNEVSLzlxNnBpZkxtTXI1Z3NPMENKcHZ6TWFkNUJOcjRrZmtiK3RG?=
 =?utf-8?B?dzhVUFJwc3ZGc2l1SEwxWXcvT1FXRHlacWJvYXlFelExT3JUSnJnREZXaE9M?=
 =?utf-8?B?aUJDTmhuQi9aUjZwa3VoQWcwVE1obFBaai9RZHV4TXdJbzdZVjdMUC9sU2tx?=
 =?utf-8?B?Snp5TzNCUHFBMXFLS0Q5Q3JKUHg2VUtnUUs3WmU2clhrZlVYVzFwWGZCNnFJ?=
 =?utf-8?B?amJFdGxUV2kybHo0WngrMFNBYzZBYXhmT2NIck41MjdPbkl5eWlvaVQ2Ymk2?=
 =?utf-8?B?M3FMbFZrTFg1UmRaMnhjMjJ2Wk1OM29CM0k3R1FVWFBYa2hmMTloaGptMVp3?=
 =?utf-8?B?eDkxVk5QSTJWaFY0RWlZby92U0o3WE82T3ZuTXNPVXdwaUw4ZVF6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01787305-b792-429c-4926-08dec6b3ead7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 05:48:37.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3mIjLqyILfLEmzmbMgjalwX6D64z4gfZXvR4hWiZRZnqd/gNFFMc/141WERAc99nLndIlORz5xD4Jq/KLjMkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297448-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dave.jiang@intel.com,m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8C5E666005


On 6/9/26 22:58, Dave Jiang wrote:
>
> On 6/9/26 2:57 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use core API for safely obtain the CXL range linked to an HDM committed
>> by the BIOS. Map such a range for being used as the ctpio buffer.
>>
>> A potential user space action through sysfs unbinding or core cxl
>> modules remove will trigger sfc driver device detachment, with that case
>> not racing with this mapping as this is done during driver probe and
>> therefore protected with device lock against those user space actions.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx.c     |  1 +
>>   drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
>> index 90ccbe310386..578054c21e79 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>>   	efx_fini_io(efx);
>>   
>>   	probe_data = container_of(efx, struct efx_probe_data, efx);
>> +	efx_cxl_exit(probe_data);
>>   
>>   	pci_dbg(efx->pci_dev, "shutdown successful\n");
>>   
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 4d55c08cf2a1..d5766a40e2cf 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct range cxl_pio_range;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>>   	int rc;
>> @@ -75,9 +76,32 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return -ENODEV;
>>   	}
>>   
>> +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
>> +	if (IS_ERR(cxl->cxlmd)) {
>> +		pci_err(pci_dev, "CXL accel memdev creation failed\n");
>> +		return PTR_ERR(cxl->cxlmd);
>> +	}
>> +
>> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
>> +				    range_len(&cxl_pio_range));
> Should this be devm managed? I think the mapping leaks if efx_pci_probe() fails after calling efx_cxl_init().
>   


No devm under netdev ... but you are right about the leak. I need to add 
a call to efx_cxl_exit inside the error path in the caller.


>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>> +			&cxl_pio_range);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	probe_data->cxl_pio_initialised = true;
> Should this change be moved to the follow on patch that uses it?


I can do that.


Thanks!


> DJ
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>>   }
>>   
>> +void efx_cxl_exit(struct efx_probe_data *probe_data)
>> +{
>> +	if (!probe_data->cxl)
>> +		return;
>> +
>> +	iounmap(probe_data->cxl->ctpio_cxl);
>> +}
>> +
>>   MODULE_IMPORT_NS("CXL");
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
>> index 04e46278464d..3e2705cb063f 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.h
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
>> @@ -20,10 +20,13 @@ struct efx_probe_data;
>>   struct efx_cxl {
>>   	struct cxl_dev_state cxlds;
>>   	struct cxl_memdev *cxlmd;
>> +	void __iomem *ctpio_cxl;
>>   };
>>   
>>   int efx_cxl_init(struct efx_probe_data *probe_data);
>> +void efx_cxl_exit(struct efx_probe_data *probe_data);
>>   #else
>>   static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
>> +static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
>>   #endif
>>   #endif

