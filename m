Return-Path: <netdev+bounces-286251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCaaEYY9AGr8EgEAu9opvQ
	(envelope-from <netdev+bounces-286251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:10:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC45030A1
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5590300DF7B
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 08:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3AB35F172;
	Sun, 10 May 2026 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tZ59rqEw"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D188B2F8EB7;
	Sun, 10 May 2026 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778400643; cv=fail; b=hMxsN+64qpQeKpKN25ZXGZjlqXf4V4UgLiGwTW8j0l1SAha7AH2ZSSGZBKjQQnj5N1VUW5onGi9x2OdRtOAhhEbSxkHm79svToICKEAtld2Hpj1p8ev5p4Twfxkp4UqiYJH3yjS265l3gb7roS1U5pNVswz1P+qdg4Fm2IRufh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778400643; c=relaxed/simple;
	bh=p4O9ak6jHcVCrPzlO0RopgVSaxxC/ZeY9BZwNpGuP0I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mYZ9W7Cm2f934+a8spcHPEHcIVWmvaKluHZoG2XMaozU2rrKvlFxSJ12bk7+XB/yqqWB+07ZvA7H7rKv1yWHhwg2IJ96xewE2rC6I+wX0745sruzDnk/Qqtvz+8tTxNtNJ+382Ab4bhgJ9Wh/zEzu7CcAgaQa+eyJXqnpkqLo5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tZ59rqEw; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omjrHXffw8AJitpCH/CJrf7ERC5ycA7qhW2/Oksu+ZS3tNVWKS+sV8axdphkKPgrFW/Q6w9tCvUE+/iNHldJ4XIiqjnZwLRJBnRTYcIdiGgwZZI8yRvFnA5Q2tWjYnborxIGzJwqow3gKKDp51KzqIlp/WIU3B7xTDBOl+cr+ioLDfQKnf7NzxlZVgjB3NlDr2jvoOz2zbsURd7tQPmpvJ4iN/JErhE0m0gIymyIGXWV3I0XPwMX76S+mPMjbTHXzEdf4kobggQTvb3QmZtuOUtPqnJYw1UH1tADDUhLhQ7L5QpeSduMmT4HJHB6OWf19V9FVpV+JQNlpxD35i3v/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7ISBAgYOvZ3eil7OG7GglQfKE7x/vh0unPuR8MZihc=;
 b=TMM3ITMXqltJC48PixmPme9/8bEcgBVeyKyCqA0tQitk3e2B2hmozc8V7TWMYaP6h74FcbxJKpUN1ad1J4jmVnyjj3bIWE/zL1i8A9RdPURoPs4vZDZ98UwHmjoQvKFy7fDJ8MMpgCLYqPJOkjHfqLmAKWBXlxdVrVomuwCc4dU38lrynMIZrc0M5eH1hdP/PcYfdUDLOyCjCSOGUAk4b2yruyKRrn/uJA3Cu3z8R8dtqJYgKe+Evp7fWJm2uk7M8oWQsDvbu3MiYk7j7OrT3ncqbE/nSyLggphU3VxLk3irBpJwDqF4Ft9lzpQG4r57d3W5HEAXKHy5BK5C9jfJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7ISBAgYOvZ3eil7OG7GglQfKE7x/vh0unPuR8MZihc=;
 b=tZ59rqEwGahkDI4HV9FwG0Ec2myuBBlX5Es4fYyxLYeFD8VQoop0TAZGx9ZZKdFh6HIpQtOAY2VHp58Han9CIbksPmA4i3DQKQuB8t6T509Q792isRrvZS+eUx1FYVP245gNMXN482gWr+izaXDutdA/bwIys1PTGA4UBWievBOGCaj37I5X53JbCZgTsNyl8rehOrASHmGeCyfjGpnD2oGFxIVi7i1HKiuwzurAIf7OmOKRUgjKRvVAqn8yAyLhT0OWuAaZ1pAJsVAEzezLN2KrMEN5R5CP4rXK5DKdTIeBzjKVd98wy1ivYy9jxb25fR+QRssZoK2aR30sq4llCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sun, 10 May
 2026 08:10:37 +0000
Received: from BL1PR12MB5873.namprd12.prod.outlook.com
 ([fe80::e8aa:dc7d:992f:93df]) by BL1PR12MB5873.namprd12.prod.outlook.com
 ([fe80::e8aa:dc7d:992f:93df%5]) with mapi id 15.20.9891.020; Sun, 10 May 2026
 08:10:37 +0000
Message-ID: <744adbc1-ba3d-47c6-9129-439a59636f14@nvidia.com>
Date: Sun, 10 May 2026 11:10:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/mlx5: HWS: Reject unsupported remove-header
 action
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506000054.51797-1-prathameshdeshpande7@gmail.com>
 <20260509132508.GR15617@horms.kernel.org>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <20260509132508.GR15617@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To BL1PR12MB5873.namprd12.prod.outlook.com
 (2603:10b6:208:395::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5873:EE_|CY3PR12MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: 3851fab8-b03c-477a-39bf-08deae6b9e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mbGe+WwkXNPhR3M61Z0FiDmP5JKks0Rcz50hGhtVnUTalWdzeR3IoYSHdn96A9Ry0kYGn0Q4sdg2CQfwvsrpSKbSBariMEVOcm1KOEokPMFXFSpW3v9wSveULEAsmxgOx+WHNLFLn9h0JZKIDo37upKqvEmdBba66uwL4PKrbcR/7q9oLJLNJE6wpMPJZssKxKCJN02M0DpsxmmqKoMk73TETQlO3Sr5C//N37jAQUMp3dnYouWU2z6Iajv6Lll9K82RObfLpNRJEbP1ar+hPAXEJPYhdbUKY03fUlXaykMniKUg8LMUY4v1f+7V71qB+7i+tpl0G3garMEzgNSMqZ6JMVgOltIg0habt82rU9adA2I+24cIMbwi2n2aibJUHg1LzRpSbMq85h3b0OCHYDJwZiJD+ZLln430A+k7RvJGJABeE3Lg39lQx047YDHESUg35LZpU3Bib+qsYM9w7ocvqpQGHyqOzEic5MxSXF9dVqlMyLTfNYX6nSUMmhcXhwtnynSS3fhYgevoVUtRn+4wnM8iH7y9J69rFZwT/BesPQqHto+d6Y0ySoIH8/nZi/wrWA9Kprm/H5X0MwEC9DVfhqNWXvguG6cjmmZIQ0KRQ4b8dlIfgFTg01tiahM9ntOfKIB3Jthz9noxJxk0umUW0DolPbJ4hTp36qMp9nD6VSygAqwPDGEaH5Lq3ien
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?am9uZ0ZRMDJTQmVSSXZEUkVYd1RxSEdiVElMc0ZDY3JicnBzcVdUd0J3WmFu?=
 =?utf-8?B?MmJYbm5INUtBa24yWm5vMnA3Y21Eb25obXJrNEkwcWlyaHVpTDJJSXQvS0NM?=
 =?utf-8?B?clQzRDB4QW4xUERzY3dUei9XM01BaGQ3K1FZWGt3TWhseGp0SzQ0RWJPeDFO?=
 =?utf-8?B?UVgrTjlYak1uamhEV3UxZFpmZ3RKUjlwMUg3TXpsN3g0alpQT1ZFSDN6Q3ZB?=
 =?utf-8?B?MnU2UWhVdnJHeG93UEhEL21TclBRMExvQXFMRDYvSjFvdERreXFieThVMzVP?=
 =?utf-8?B?cmFjTG1xR3hLaU5EWmZtRFl3SEZCSmptRjh6TjZhUTJMWFhDSTZXSmZTdXYv?=
 =?utf-8?B?MXR2bkhQSEIyOUFaU2w4eG1Oa3ZRMjNYWmplVUloQzV0eGtOMERmSGNFck9C?=
 =?utf-8?B?WTlONjZZNVFLMllCcEVpcUJBNkpiVElEUmV4MkdJaWZRakZQZVQ1aEhpNGta?=
 =?utf-8?B?RmJZUDlWSk5vZEluUWVBTjhqTWQ3Rnh1dUdYZU5nMEQ5RVFibFcweFdqWTI5?=
 =?utf-8?B?NHVVTlJHU2t3OVd4Rk5WY1pWSDJsYjByckFEU1JVSG9QOHRLMkJsL09MQVFU?=
 =?utf-8?B?UFYzS0ZMcnBCK2hLMWx1MEZ6UXJhWFRYRUp0TFVJaEU4YkxSSzAxT1l1VGFC?=
 =?utf-8?B?K3FRU2Ntbk4yT0JjSFZBY2Jwb3ZkZW5RbXpGMVZMVEtNVUhvODlCM3VlVUY2?=
 =?utf-8?B?SEVkU2FZVGlYcGFvRGRGQVpXNHVPU0FHVUtnQStPbjMyWUE5dzZrd1g4MEN0?=
 =?utf-8?B?ZTBXSXpYdytEMElGTnY1aDhiWU9wQmR3RGsrTFYzMU11cG9aSjA5MG5sdGFa?=
 =?utf-8?B?Q2pXZmVGRitINFV1L1BvQ05FcmhUR3IvemxQWkowaVF0c0s3SC9rdFhqWXp6?=
 =?utf-8?B?RkJoY0FCWXMyUlhnM3JmR0JVaXpYL3JodXc3RjV5RXdlU0QxVStvaHBiMnRQ?=
 =?utf-8?B?VFhYVitQa3dJK21zME5hYWlpWERLaTJRYVdlVDE0di8zeUUxYktBUkFySnJs?=
 =?utf-8?B?a1VlakZOc2hINEhySkV3SjR6TWhUeGFqSXVNa0FZWWEveHE0TUZLZ2ZkTmJt?=
 =?utf-8?B?ZW9ocDBOcTNTc1FwWEFQRkF1T2s4QmZsNC9tSGxBTm5jM2h6a3VROE5lMUIx?=
 =?utf-8?B?YnFJekN4TVI3Z1hEb3hWSllMbVJqQXkvY1NZdjdnaDFyU05iOHJxMWxaR1Vo?=
 =?utf-8?B?NjhQSVAyQkdldGpXeE9Xck9tZGdEdEczcUNSa2w0T254blAzOVM0TUg4eGRn?=
 =?utf-8?B?Y2kzT05FSEZqTVhWVlcrMXUxYm1jSERvMjRrR1hya1hrN0JES0RQOUhTZHlh?=
 =?utf-8?B?VjZDVC93aW9FKzlkTVM2ZktVMTBVcjhNR0lGeWZYRWNCa0J2NThMWVlZOTI1?=
 =?utf-8?B?NE9WbUNKYSs2VmY4bVBZSGEySnZYQWhheHRvVDhFUTlnNkJHeXZmbE5HakNP?=
 =?utf-8?B?U1Zxd213TVJoc1hWTmNYRXlXTGt1MmIrbnNHcnhmK0F6N2RvMCtQNWxJT1hl?=
 =?utf-8?B?TUlRdmpLRzkycVBpSU9rMHNpcHc2NjFaRjl0aG5seDgyUzBuS211UE00TG1t?=
 =?utf-8?B?dDBYRGR3bmhieWtFY2pMR0M4S1U3QW9pVTdONWZNSXpJaUNJMGtDVE1ITHJU?=
 =?utf-8?B?SjkrejAyUTN1NFduZkNYejZaQXBiaGRXRnF6TGQwTlJoWWs4OTFPc3MrOGR4?=
 =?utf-8?B?ZUJWZ1cxSFppYnNITy9kWHprQkxTVGE2bjBuTkFodVRweVBQVW1qM3hKbVQr?=
 =?utf-8?B?Z21jODFxeTBpZFlPcmc5MmVnRHJmdEdPTFR2dmVuL05scEo5NjM3aHJ0UVNS?=
 =?utf-8?B?dDBPZWJFS2YyY05nTFVyRzJhQXdLUWNydXBHRFhFMFY0TWxydndQc3IwR0lr?=
 =?utf-8?B?MlVHeDZScXp1K1Y1Q1c1M3NhR2dFQXgwLzVKYXBWQy9Mc0JKUnY4cjNnd3VE?=
 =?utf-8?B?U0UvU2Q1REE5UjdHZzlUaFV1NlVQS3NVV0FmUndScE1YbUh2YlY1QnFWRFdN?=
 =?utf-8?B?V0RDZlQxNlZJcEtEb2d6Z002SDgzcjI3RnI3TEhQdmh4SHdlVCtuU292WlBE?=
 =?utf-8?B?NWVqL3lBL09INXdLNDhNRmF6U2E2ZkFDQmphdXVDWTA1SE5LZjRkQS9vSmxE?=
 =?utf-8?B?dksrRHErWWJYdFNYbHpYQ2NQaDV3ejM0V3k3VDZsVUZiMXNNaHZZZG53eWRl?=
 =?utf-8?B?N1JaVURjVWxoejdnME5ZcE45YmpFNm9IV2NsRHhzRWkzbFE2amdxREYyNU1W?=
 =?utf-8?B?Rk5tc0Urb05BTzBuMjRyTEdJY1JuNnRKdkpJbEhOMWtRb0ZaaGdBanExek1x?=
 =?utf-8?B?dU1zNTFVbDQ0T1lCdGJvNEdvUHhBb2laamlCM05JdXdidmtQaGtLZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3851fab8-b03c-477a-39bf-08deae6b9e02
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 08:10:37.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngh4+PhcMCC3qabQhlSG90A2wPXHzeBwpRPbbhN8ZjyE6yMVoAAT+9ztmqSGyK1Lj9PP5U/tN8dE1cd1/RtpBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608
X-Rspamd-Queue-Id: 97CC45030A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286251-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kliteyn@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 09-May-26 16:25, Simon Horman wrote:
> On Wed, May 06, 2026 at 01:00:31AM +0100, Prathamesh Deshpande wrote:
>> mlx5_cmd_hws_packet_reformat_alloc() handles
>> MLX5_REFORMAT_TYPE_REMOVE_HDR by looking up a matching HWS remove-header
>> action.
>>
>> If mlx5_fs_get_action_remove_header_vlan() returns NULL, the code only
>> logs an error and continues. The function then returns success with a NULL
>> HWS action stored in the packet-reformat object.
>>
>> Return an error when no matching remove-header action is available.
>>
>> Fixes: aecd9d1020e3 ("net/mlx5: fs, add HWS packet reformat API function")
>> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>



