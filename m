Return-Path: <netdev+bounces-306231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wz01OTqnT2otlwIAu9opvQ
	(envelope-from <netdev+bounces-306231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:50:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D34D2731C7F
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:50:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=mPDf2jIt;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306231-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306231-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B94053029FE9
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08D82D7393;
	Thu,  9 Jul 2026 13:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486B2D6E72
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 13:37:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604246; cv=fail; b=XJogYK7FwGKpEXWyQKA18UK/BRm5yOEMFJIShPX4EIw0ohTF98ihrRlQK1AT8pCyHxehE7/DZtNKRQ3uQFQCUxdVVeJtb6ZWRw1F8n9vsNpYM9OhQQR3laFNogjoq9JzdGuV9+ohBf3xmimL4EmGfVttq3mwlUOyHymEMqFoyBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604246; c=relaxed/simple;
	bh=jkPKewb475cYdK07uUa2ISIsa1M/CuAEbPgq/3xe0t8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TllzcwBquVHOr0fGuO/EgQuQovEJIKITUJcn2sWnzlGZs2sUEXyIfZFGbA+t/CcooHSdjx8rG9NVbE5KBsc9YaENKzuLC4hslRPGM/zO6nWG4nWGPlDKXx1ETkwGRoWPf0mO/h6elHqpKicQm8G8lDGHTSFEKB2ri7tu9vAdA/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mPDf2jIt; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt1uSbvsh+BdUfW+xK/La/cklLpj6BnRsN27rcy9npCbKKC/+L84K6GEAdXOpO/K4K+1FGdCPD0ZrNcGHD825PDmfwHkL9MlWeEXvqWbFh2KsMnktASh7rIh1xEEWagmH8XIPrQVgtzyQWlDRwUJ41wv1kRLT2wyHND0LD6Q4NZyc2DtT6vQIss1wJfluuN47D564+veDAjWmkONRsMauZtfRw0f3nHNK+WnXRsd/DT50BscJMpHgClF1TIVOxS2lWTBGthbAO3CkvSKqwyg/ZkwPa7PJYamsO62jtLdA04b8RONb7PunC0PAHPFQ92d7Aq8WCxYzckPZ26BStJXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKLaCgHUQdt6CjO1zOWRqYZq5NT+6AjynAyWulwJ3RU=;
 b=VgQfoN9662m7lPsnJ+8vSMAK6/HUR/nodh8Ec115jIXRbymKC2RvXmQLv55mbn/fFUvON0bPoPIN5MOsj/vO/8x1osuWDCAiDQGvTvv1KHh2yl2wkJlwgUTligszyepilx0CdWtTX5qTZoH0w7uk9ipXq3VZp8isrhycHJCINfs2s0fa2FxLCpyGrM7w0Tc3hv/R1IGKGPInIHm1TNVLws1Bxui7ytAjYi1W9VyZxU7w1XsL3Bs6aW+DoJkvnGJBffli2nVfqBykcZYMnOiYTnpdy8KuXfFuirU0OPthddqYAxcGkiWYKQZti9UWrD8CgBPe94qEVl76H7g5s1jHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKLaCgHUQdt6CjO1zOWRqYZq5NT+6AjynAyWulwJ3RU=;
 b=mPDf2jIt+CpssMrpn/QcsmajJ9J4uBjuXPa92Y71vIKWprJ0VIeS3J8qf7UHv3986sHwatwenv0krFv0c1HneOMcQ6v+Dm7Z5OH5puGNR3ujUloVkxvGCOUgSSTjMfYNPFaNEh8e4zNDL8n28p56oamqkzHt/isj/KBpeWhQP+7NHT4dBvY9gZ/Uws4zOt+unYi+kayfSNC8zVROjt8KCZNpYH0Pv8x3U5ps+WD2Nhk1PwvL2hsxA007cPAJMGUP8Z1IbeUEA5x7JjKxGnXUlcABm46X/gDBIF/dcMsvgJxLlm13VdvPI4MoxJutYGTQpZcwr306ASRTz9/jnKrFqQ==
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 13:37:16 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:37:16 +0000
Message-ID: <a7f724e5-7648-4362-bfc0-ef4cd87211a8@nvidia.com>
Date: Thu, 9 Jul 2026 16:37:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 05/12] virtio_net: Query and set flow filter
 caps
To: "Michael S. Tsirkin" <mst@redhat.com>, Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205224707.16995-6-danielj@nvidia.com>
 <20260208063807-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <20260208063807-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e5e79b-ecd4-4e04-b7e9-08deddbf30b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|6133799003|5023799004|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	C66TnoIfCAnyfsUJFiw8vqOMdtwXvOGhH/wMCOoYe6BjSnxK01eQD/ckFHKd1nD2MX5tZlKR16GmS0gsepY+N0vC6OOdmQ5LBO3JjfIPuCNyczVfJ7Q6Ezno14dYQzdNhxsaeVAIOK5w/HJbDI66Pih1kQYU89U5hgD4OiPHkjsFZyW2T9sFdNfRN87RpEpp+OseAMJGMHVOUQzQ8BmRfwtMQ8FxondJzLTrlJaCHZGjePw0zBdzHG2FGBO3qyi3c0o2LS1mAO9roknhBDcTccx9X2N0euOXLe+xZF4lzX1M7wfvvcLU5/ZLTpk9id8HUfNddNDs+V+dmjkMr/hbLZE0Ih2+gwNiaADagQIP2DkspzN+PqZDNN9b/qMu47xAwl1VQAtbTr/BO+UeK+iv72SpMOPU+guQKjbecFu3ervXuw91/JWScSco61kqC1ZXW3K61AudXJJFbqy3hP2H8aiocuKgWdfgPXRTltUVwhgSNtIcNgwZeNr0PyhuJ6BngjHRqxBuIPZyrq+WGRccXSU8tEsx1iX44IVKFO5XttHOS+6XNtdpnjJiw7BsYXdYyIWQIeU+Af6JjhJI6C8r34W7kB89prIgSIsQebrHL3QrKlSt/iYZxDni4XilkGvezTrs/TRDX0oC9U9XinwTPNM1s2G3Pw+gB4zJv6RjhL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(6133799003)(5023799004)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnVYQ0VYb3lvVG5mMm5OMGpVWlRvUXBBQnNNQlR5T3hTUWovYnZzR2tFWVo5?=
 =?utf-8?B?Tk1QQ09UNG5QS2pIUGJtQnNVc2RtbmRnNnIxSkRHc2s2dm5mdlYzc1JaZWRz?=
 =?utf-8?B?amMxRlo0OEJianVLZDM3RytZTDJ4UndFVkJ4RUNOR0diNzZNdkp2cXN2RUZr?=
 =?utf-8?B?WE5NS2JoNlJiNWwrM09uNkxFWkpEdVRxNUxCMVVVaFhXT1pLMDRSZkVrZnZT?=
 =?utf-8?B?Yk9yeHRhVC9oTGlwclA2WmRMWTZXWHIrMkh3Q3NibmJhbFphU1BzRCtQNTF4?=
 =?utf-8?B?S1JEbjNrQi9EbTdRd3VlajdTaitWYkFDNXpxVldxb0hpRFNLUXplSWp1Wmd5?=
 =?utf-8?B?SUxMQmZDeDFqMWpMcjdPQmltWGpXbTdrMElJcHN0NU1DanNkbnFjSmRRNFFl?=
 =?utf-8?B?TVVlYUJRbHQraEpMUmNwakc4cTVLWjlyYWFZMVJIYlRzQXNOblFsSEE3bXdi?=
 =?utf-8?B?TXFydTFVMDN1Y000UXJxSHQ4OEUvaCtLNUFoRW92R3p5dHRtOWNRZS9Iemc3?=
 =?utf-8?B?WTlXOEYwOFZ2Nlc5eTlWVSthbXZTZ1kvWS9lT3hwNEEyY2tHNFVGc1JjcDU4?=
 =?utf-8?B?KzV5cDcyTWVlK3B0NnlmTG1ZQ09ZOTAzNWNBWWdINGw0eEUyc0dJSlBDYlNE?=
 =?utf-8?B?TkpzMWR3cno0blBwY0xVSFdpeVcvVS82WW52bU1hUUlzTFN2anNJOGtnUE85?=
 =?utf-8?B?ZlRXVXNIanA1Z3JqY01nMFBQbVk1SkhkR0p5SkRsT2FnL0tzYnRjZWl6QUQy?=
 =?utf-8?B?T0ltM1k0WStJZ1BBcXFqOURSZThaK2RqK1dHUS81UE9hdGNKK05BUXRlaWl2?=
 =?utf-8?B?UzJtNThLbFNVRU0yZm1YRTlpd3lvdDNlR2Nzd2RaVGtaZktoY2VLdCtwOWs4?=
 =?utf-8?B?R1NlTUt4QWdFU1JLVlZQSEM1Z0FIeFBJRGgrbmRFU0xwVWNCdVcvYkwvdEtL?=
 =?utf-8?B?c0cvaFdvR2FDa0lMZDBLMVVtckk5L1pVQzVvMGZVMlhWVXFmRGpCTlgyNXM2?=
 =?utf-8?B?Tms5K0VnK3dzNmhNeGxabnpTQVExSnhiUWJTT2tITXhaOXlQWXkrc3V1U3Ja?=
 =?utf-8?B?SFptcEhiVHdIVzZGZjM5YWxTYU9YeEJQd1padmtuN05NYmFzMjBtTVNxbGNE?=
 =?utf-8?B?dk0vRGU2K3ZFZ2xkTXJoL0VBeVE5ZGVBMzJEc3BhZ1o3YVRseDM5Z2NsbEFF?=
 =?utf-8?B?eVFDMVpCemQxZHR2N0VGRldZbkRpUGF2ZU5ZZUlrMDZvcFJPU0N1RWI3Rm1o?=
 =?utf-8?B?V0kxd0NPSFFwc2duWDd5aTUrNWJNRUNxd2g2eFFpamRRbXlsaXdrRjhWTHJ3?=
 =?utf-8?B?OUtveDF4cEJyZmg5RDZ1blZlTUwwOUVQMDNHaFBwdGdUVjYzMFdld2xOTWhh?=
 =?utf-8?B?eDZ5UWcrSDlHS0JRbW94V3owMFpXZ1NBejdxMGU5QjJEZEhzWU9BSVdwOElX?=
 =?utf-8?B?VmtidGZGYVlOWElHUnNzT0tVMU9uVzRZSlNkb0xFOUtzTmJmUzNobkRidW1E?=
 =?utf-8?B?a1hKM0dCVWFuVkJhWTBqNUJkV1A1czdLMEQ4bmhuSWdGdEw5akJSQW11QmpU?=
 =?utf-8?B?TGZ4WW03b2FKaWVXN0xDQkZhclI5OFFjbmtoQVQxTXpwWFJZME1oVmsxSTR3?=
 =?utf-8?B?Qm9Lc1gwOFNEaGJJZk1VbUJvZ2tvUk5GZmRxU0JzeEUvSFBBSEZkOW1VZGkx?=
 =?utf-8?B?VWpMdTZTWGk0RWhVQTNaWmNuVDJ2MXdsWnFLTk5pVWJpNjRMeGdRczFUVGFY?=
 =?utf-8?B?WUVKcGNJYVpybzJwcWNqZUV1aXlpZDhFd21SRy93MXNCVnF3VGxyeHYwNzdo?=
 =?utf-8?B?RDZKeUhmVDJyY3dmUFdwOVZpSmlVeTFWelNHOUlOU1N4dmZYcnZDSVlGLzdo?=
 =?utf-8?B?ajVMc1pudDVLamRWQWhrS2hVOHkxZ3FkZGNOSzRHZ0M2Yjd6MW01S1JTUWlC?=
 =?utf-8?B?ekVoVnQvTDV1eWV0c1lJUzhyV2duU3BWN3NvVzFWcEZRUnFkOE0reElPL2JG?=
 =?utf-8?B?REtUYkJZNFoyYllLWUFFTzZhTWZ5MzVYRW1hMEMyVVVRWDlDaEpMVVV6TDUx?=
 =?utf-8?B?cXRadHkzRGFrU1Z2YW13MGxIUWVJNFZIQ0FVYVNreGpmVWVaUnpMNHpodmZE?=
 =?utf-8?B?d3o4M3d6cVdRa3FVWjFqR1BZUFpoajRZMW5FUGVycUx0dTB6eTF6Nkl5VjJM?=
 =?utf-8?B?NXROYlV4ZzVZYW1wTEMxek5EVWt5L2JuN3RxZFJaeXdsRzBFc09ZYzlNU0F3?=
 =?utf-8?B?QUtFYzFMZjVxYTc5dUhrR0ZYd25aUUNCSWpoRTFrNXNuZ0g5Z0R0Um51WGpQ?=
 =?utf-8?B?Y1ZMYkJIUUVRRTRXNlU4M1UrUE55UEwvanlDQ0hxWThXMmNzZ1NRZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e5e79b-ecd4-4e04-b7e9-08deddbf30b8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:37:16.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rT3bwlk4vy/F4P52eNGdGtBnI4yiD6FgzzXaN5j8Z5Bc9GPzuieSfdar1CJnXfW9IPJqWmz+gRNe7aK4P0wdvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306231-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shshitrit@nvidia.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:danielj@nvidia.com,m:netdev@vger.kernel.org,m:jasowang@redhat.com,m:pabeni@redhat.com,m:virtualization@lists.linux.dev,m:parav@nvidia.com,m:yohadt@nvidia.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:jgg@ziepe.ca,m:kevin.tian@intel.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shshitrit@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D34D2731C7F



On 08/02/2026 13:51, Michael S. Tsirkin wrote:
> On Thu, Feb 05, 2026 at 04:47:00PM -0600, Daniel Jurgens wrote:
>> When probing a virtnet device, attempt to read the flow filter
>> capabilities. In order to use the feature the caps must also
>> be set. For now setting what was read is sufficient.
>>
>> This patch adds uapi definitions virtio_net flow filters define in
>> version 1.4 of the VirtIO spec.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>>
>> ---
>> v4:
>>     - Validate the length in the selector caps
>>     - Removed __free usage.
>>     - Removed for(int.
>> v5:
>>     - Remove unneed () after MAX_SEL_LEN macro (test bot)
>> v6:
>>     - Fix sparse warning "array of flexible structures" Jakub K/Simon H
>>     - Use new variable and validate ff_mask_size before set_cap. MST
>> v7:
>>     - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abeni
>>     - Return errors from virtnet_ff_init, -ENOTSUPP is not fatal. Xuan
>>
>> v8:
>>     - Use real_ff_mask_size when setting the selector caps. Jason Wang
>>
>> v9:
>>     - Set err after failed memory allocations. Simon Horman
>>
>> v10:
>>     - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
>>       Jason/Paolo.
>>
>> v11:
>>     - Return -EINVAL if any resource limit is 0. Simon Horman
>>     - Ensure we don't overrun alloced space of ff->ff_mask by moving the
>>       real_ff_mask_size > ff_mask_size check into the loop. Simon Horman
>>
>> v12:
>>     - Move uapi includes to virtio_net.c vs header file. MST
>>     - Remove kernel.h header in virtio_net_ff uapi. MST
>>     - WARN_ON_ONCE in error paths validating selectors. MST
>>     - Move includes from .h to .c files. MST
>>     - Add WARN_ON_ONCE if obj_destroy fails. MST
>>     - Comment cleanup in virito_net_ff.h uapi. MST
>>     - Add 2 byte pad to the end of virtio_net_ff_cap_data.
>>       https://lore.kernel.org/virtio-comment/20251119044029-mutt-send-email-mst@kernel.org/T/#m930988a5d3db316c68546d8b61f4b94f6ebda030
>>     - Cleanup and reinit in the freeze/restore path. MST
>>
>> v13:
>>     - Added /* private: */ comment before reserved field. Jakub
>>     - Change ff_mask validation to break at unkonwn selector type. This
>>       will allow compatability with newer controllers if the types of
>>       selectors is expanded. MST
>>
>> v14:
>>     - Handle err from virtnet_ff_init in virtnet_restore_up. MST
>>
>> v15:
>>     - In virtnet_restore_up only call virtnet_close in err path if
>>       netif_runnig. AI
>>
>> v16:
>>     - Return 0 from virtnet_restore_up if virtnet_init_ff return not
>>       supported. AI
>>
>> v17:
>>     - During restore freeze_down on error during ff_init. AI
>>
>> v18:
>>     - Changed selector cap validation to verify size for each type
>>       instead of just checking they weren't bigger than max size. AI
>>     - Added __count_by attribute to flexible members in uapi. Paolo A
>>
>> v19:
>>     - Fixed ;; and incorrect plural in comment. AI
>>
>> v20:
>>     - include uapi/linux/stddef.h for __counted_by. AI
> 
> AI has led you astray, sadly (
will fix in v21
> 
> 
> 
> 
>> ---
>>  drivers/net/virtio_net.c           | 231 ++++++++++++++++++++++++++++-
>>  include/uapi/linux/virtio_net_ff.h |  91 ++++++++++++
>>  2 files changed, 321 insertions(+), 1 deletion(-)
>>  create mode 100644 include/uapi/linux/virtio_net_ff.h
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index db88dcaefb20..2cfa37e2f83f 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -26,6 +26,11 @@
>>  #include <net/netdev_rx_queue.h>
>>  #include <net/netdev_queues.h>
>>  #include <net/xdp_sock_drv.h>
>> +#include <linux/virtio_admin.h>
>> +#include <net/ipv6.h>
>> +#include <net/ip.h>
>> +#include <uapi/linux/virtio_pci.h>
>> +#include <uapi/linux/virtio_net_ff.h>
>>  
>>  static int napi_weight = NAPI_POLL_WEIGHT;
>>  module_param(napi_weight, int, 0444);
>> @@ -281,6 +286,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>>  };
>>  
>> +struct virtnet_ff {
>> +	struct virtio_device *vdev;
>> +	bool ff_supported;
>> +	struct virtio_net_ff_cap_data *ff_caps;
>> +	struct virtio_net_ff_cap_mask_data *ff_mask;
>> +	struct virtio_net_ff_actions *ff_actions;
>> +};
>> +
>>  #define VIRTNET_Q_TYPE_RX 0
>>  #define VIRTNET_Q_TYPE_TX 1
>>  #define VIRTNET_Q_TYPE_CQ 2
>> @@ -488,6 +501,7 @@ struct virtnet_info {
>>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
>>  		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>>  	);
>> +	struct virtnet_ff ff;
>>  };
>>  static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
>>  	      offsetof(struct virtnet_info, rss_hash_key_data));
>> @@ -526,6 +540,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>  					       struct page *page, void *buf,
>>  					       int len, int truesize);
>>  static void virtnet_xsk_completed(struct send_queue *sq, int num);
>> +static void remove_vq_common(struct virtnet_info *vi);
>>  
>>  enum virtnet_xmit_type {
>>  	VIRTNET_XMIT_TYPE_SKB,
>> @@ -5684,6 +5699,192 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
>>  	.get_base_stats		= virtnet_get_base_stats,
>>  };
>>  
>> +static size_t get_mask_size(u16 type)
>> +{
>> +	switch (type) {
>> +	case VIRTIO_NET_FF_MASK_TYPE_ETH:
>> +		return sizeof(struct ethhdr);
>> +	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
>> +		return sizeof(struct iphdr);
>> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
>> +		return sizeof(struct ipv6hdr);
>> +	case VIRTIO_NET_FF_MASK_TYPE_TCP:
>> +		return sizeof(struct tcphdr);
>> +	case VIRTIO_NET_FF_MASK_TYPE_UDP:
>> +		return sizeof(struct udphdr);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>> +{
>> +	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>> +			      sizeof(struct virtio_net_ff_selector) *
>> +			      VIRTIO_NET_FF_MASK_TYPE_MAX;
>> +	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
>> +	struct virtio_net_ff_selector *sel;
>> +	unsigned long sel_types = 0;
>> +	size_t real_ff_mask_size;
>> +	int err;
>> +	int i;
>> +
>> +	if (!vdev->config->admin_cmd_exec)
>> +		return -EOPNOTSUPP;
>> +
>> +	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
>> +	if (!cap_id_list)
>> +		return -ENOMEM;
>> +
>> +	err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
>> +	if (err)
>> +		goto err_cap_list;
>> +
>> +	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
>> +				 VIRTIO_NET_FF_RESOURCE_CAP) &&
>> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
>> +				 VIRTIO_NET_FF_SELECTOR_CAP) &&
>> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
>> +				 VIRTIO_NET_FF_ACTION_CAP))) {
>> +		err = -EOPNOTSUPP;
>> +		goto err_cap_list;
>> +	}
>> +
>> +	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
>> +	if (!ff->ff_caps) {
>> +		err = -ENOMEM;
>> +		goto err_cap_list;
>> +	}
>> +
>> +	err = virtio_admin_cap_get(vdev,
>> +				   VIRTIO_NET_FF_RESOURCE_CAP,
>> +				   ff->ff_caps,
>> +				   sizeof(*ff->ff_caps));
>> +
>> +	if (err)
>> +		goto err_ff;
>> +
>> +	if (!ff->ff_caps->groups_limit ||
>> +	    !ff->ff_caps->classifiers_limit ||
>> +	    !ff->ff_caps->rules_limit ||
>> +	    !ff->ff_caps->rules_per_group_limit) {
>> +		err = -EINVAL;
>> +		goto err_ff;
>> +	}
>> +
>> +	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
>> +	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
>> +		ff_mask_size += get_mask_size(i);
>> +
>> +	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
>> +	if (!ff->ff_mask) {
>> +		err = -ENOMEM;
>> +		goto err_ff;
>> +	}
>> +
>> +	err = virtio_admin_cap_get(vdev,
>> +				   VIRTIO_NET_FF_SELECTOR_CAP,
>> +				   ff->ff_mask,
>> +				   ff_mask_size);
> 
> So ff_actions is from device and ff_actions->count does not seem to be checked.
> 
> If device somehow gains a larger mask down the road, can it not then overflow?
> or malicious?
see below
> 
> 
>> +
>> +	if (err)
>> +		goto err_ff_mask;
>> +
>> +	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
>> +					VIRTIO_NET_FF_ACTION_MAX,
>> +					GFP_KERNEL);
>> +	if (!ff->ff_actions) {
>> +		err = -ENOMEM;
>> +		goto err_ff_mask;
>> +	}
>> +
>> +	err = virtio_admin_cap_get(vdev,
>> +				   VIRTIO_NET_FF_ACTION_CAP,
>> +				   ff->ff_actions,
>> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
> 
> So ff_actions is from device and ff_actions->count is not checked.
> 
> If device gains a ton of actions down the road, can it not then overflow?
> or malicious?

it can't overflow, as it can write up to sizeof(*ff->ff_actions) +
VIRTIO_NET_FF_ACTION_MAX bytes. But it is a valid concern in case of
someone in the future iterates on count. Better to handle it now so it
won't be forgotten. Checking that ff_actions->count doesn't exceed
VIRTIO_NET_FF_ACTION_MAX can break backward compatibility. If this max
value is extended in a new spec/controller then this driver would fail
to load. Instead, I will assign ff->ff_actions->count with the minimum
of what we got and the max.
> 
>> +
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	err = virtio_admin_cap_set(vdev,
>> +				   VIRTIO_NET_FF_RESOURCE_CAP,
>> +				   ff->ff_caps,
>> +				   sizeof(*ff->ff_caps));
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
>> +	sel = (void *)&ff->ff_mask->selectors;
>> +
>> +	for (i = 0; i < ff->ff_mask->count; i++) {
>> +		/* If the selector type is unknown it may indicate the spec
>> +		 * has been revised to include new types of selectors
>> +		 */
>> +		if (sel->type > VIRTIO_NET_FF_MASK_TYPE_MAX)
> 
> do you want to check sel->type 0 too?
yes, will add in v21.
> 
>> +			break;
> 
> but count remains unchanged? should we not to reduce count here
> so device knows what driver can drive?

we should. will add it in v21.
> 
> 
>> +
>> +		if (sel->length != get_mask_size(sel->type) ||
>> +		    test_and_set_bit(sel->type, &sel_types)) {
>> +			WARN_ON_ONCE(true);
>> +			err = -EINVAL;
>> +			goto err_ff_action;
>> +		}
>> +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
>> +		if (real_ff_mask_size > ff_mask_size) {
>> +			WARN_ON_ONCE(true);
>> +			err = -EINVAL;
>> +			goto err_ff_action;
>> +		}
>> +		sel = (void *)sel + sizeof(*sel) + sel->length;
>> +	}
>> +
>> +	err = virtio_admin_cap_set(vdev,
>> +				   VIRTIO_NET_FF_SELECTOR_CAP,
>> +				   ff->ff_mask,
>> +				   real_ff_mask_size);
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	err = virtio_admin_cap_set(vdev,
>> +				   VIRTIO_NET_FF_ACTION_CAP,
>> +				   ff->ff_actions,
>> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	ff->vdev = vdev;
>> +	ff->ff_supported = true;
>> +
>> +	kfree(cap_id_list);
>> +
>> +	return 0;
>> +
>> +err_ff_action:
>> +	kfree(ff->ff_actions);
>> +	ff->ff_actions = NULL;
>> +err_ff_mask:
>> +	kfree(ff->ff_mask);
>> +	ff->ff_mask = NULL;
>> +err_ff:
>> +	kfree(ff->ff_caps);
>> +	ff->ff_caps = NULL;
>> +err_cap_list:
>> +	kfree(cap_id_list);
>> +
>> +	return err;
>> +}
>> +
>> +static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>> +{
>> +	if (!ff->ff_supported)
>> +		return;
>> +
>> +	kfree(ff->ff_actions);
>> +	kfree(ff->ff_mask);
>> +	kfree(ff->ff_caps);
>> +	ff->ff_supported = false;
>> +}
>> +
>>  static void virtnet_freeze_down(struct virtio_device *vdev)
>>  {
>>  	struct virtnet_info *vi = vdev->priv;
>> @@ -5702,6 +5903,10 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>>  	netif_tx_lock_bh(vi->dev);
>>  	netif_device_detach(vi->dev);
>>  	netif_tx_unlock_bh(vi->dev);
>> +
>> +	rtnl_lock();
>> +	virtnet_ff_cleanup(&vi->ff);
>> +	rtnl_unlock();
>>  }
>>  
>>  static int init_vqs(struct virtnet_info *vi);
>> @@ -5727,10 +5932,23 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>>  			return err;
>>  	}
>>  
>> +	/* Initialize flow filters. Not supported is an acceptable and common
>> +	 * return code
>> +	 */
>> +	rtnl_lock();
>> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
>> +	if (err && err != -EOPNOTSUPP) {
>> +		rtnl_unlock();
>> +		virtnet_freeze_down(vi->vdev);
>> +		remove_vq_common(vi);
>> +		return err;
>> +	}
>> +	rtnl_unlock();
>> +
>>  	netif_tx_lock_bh(vi->dev);
>>  	netif_device_attach(vi->dev);
>>  	netif_tx_unlock_bh(vi->dev);
>> -	return err;
>> +	return 0;
>>  }
>>  
>>  static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
>> @@ -7058,6 +7276,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>>  	}
>>  	vi->guest_offloads_capable = vi->guest_offloads;
>>  
>> +	/* Initialize flow filters. Not supported is an acceptable and common
>> +	 * return code
>> +	 */
>> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
>> +	if (err && err != -EOPNOTSUPP) {
>> +		rtnl_unlock();
>> +		goto free_unregister_netdev;
>> +	}
>> +
>>  	rtnl_unlock();
>>  
>>  	err = virtnet_cpu_notif_add(vi);
>> @@ -7073,6 +7300,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>  
>>  free_unregister_netdev:
>>  	unregister_netdev(dev);
>> +	virtnet_ff_cleanup(&vi->ff);
>>  free_failover:
>>  	net_failover_destroy(vi->failover);
>>  free_vqs:
>> @@ -7121,6 +7349,7 @@ static void virtnet_remove(struct virtio_device *vdev)
>>  	virtnet_free_irq_moder(vi);
>>  
>>  	unregister_netdev(vi->dev);
>> +	virtnet_ff_cleanup(&vi->ff);
>>  
>>  	net_failover_destroy(vi->failover);
>>  
>> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
>> new file mode 100644
>> index 000000000000..552a6b3a8a91
>> --- /dev/null
>> +++ b/include/uapi/linux/virtio_net_ff.h
>> @@ -0,0 +1,91 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>> + *
>> + * Header file for virtio_net flow filters
>> + */
>> +#ifndef _LINUX_VIRTIO_NET_FF_H
>> +#define _LINUX_VIRTIO_NET_FF_H
>> +
>> +#include <linux/types.h>
>> +#include <uapi/linux/stddef.h>
>> +
>> +#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
>> +#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
>> +#define VIRTIO_NET_FF_ACTION_CAP 0x802
>> +
>> +/**
>> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>> + * @groups_limit: maximum number of flow filter groups supported by the device
>> + * @classifiers_limit: maximum number of classifiers supported by the device
>> + * @rules_limit: maximum number of rules supported device-wide across all groups
>> + * @rules_per_group_limit: maximum number of rules allowed in a single group
>> + * @last_rule_priority: priority value associated with the lowest-priority rule
>> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
>> + */
>> +struct virtio_net_ff_cap_data {
>> +	__le32 groups_limit;
>> +	__le32 classifiers_limit;
>> +	__le32 rules_limit;
>> +	__le32 rules_per_group_limit;
>> +	__u8 last_rule_priority;
>> +	__u8 selectors_per_classifier_limit;
>> +	/* private: */
>> +	__u8 reserved[2];
>> +};
>> +
>> +/**
>> + * struct virtio_net_ff_selector - Selector mask descriptor
>> + * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
>> + * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @length: size in bytes of @mask
>> + * @reserved1: must be set to 0 by the driver and ignored by the device
>> + * @mask: variable-length mask payload for @type, length given by @length
>> + *
>> + * A selector describes a header mask that a classifier can apply. The format
>> + * of @mask depends on @type.
>> + */
>> +struct virtio_net_ff_selector {
>> +	__u8 type;
>> +	__u8 flags;
>> +	__u8 reserved[2];
>> +	__u8 length;
>> +	__u8 reserved1[3];
>> +	__u8 mask[] __counted_by(length);
>> +};
>> +
>> +#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
>> +#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
>> +#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
>> +#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
>> +#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
>> +#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
>> +
>> +/**
>> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
>> + * @count: number of entries in @selectors
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @selectors: packed array of struct virtio_net_ff_selector.
>> + */
>> +struct virtio_net_ff_cap_mask_data {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	__u8 selectors[] __counted_by(count);
> 
> This looks wrong to me. count is # of selectors (packed entries) not
> bytes.
right, will remove it.
> >
> 
> 
>> +};
>> +
>> +#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
>> +
>> +#define VIRTIO_NET_FF_ACTION_DROP 1
>> +#define VIRTIO_NET_FF_ACTION_RX_VQ 2
>> +#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
>> +/**
>> + * struct virtio_net_ff_actions - Supported flow actions
>> + * @count: number of supported actions in @actions
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
>> + */
>> +struct virtio_net_ff_actions {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	__u8 actions[] __counted_by(count);
> 
> 
> this too.
count directly represents the number of __u8 elements in actions[], so
the size of the flexible array is count * sizeof(__u8). Therefore, here
it is correct.
> 
>> +};
>> +#endif
>> -- 
>> 2.50.1
> 
> 


