Return-Path: <netdev+bounces-287842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPhlMLNxBWoTXAIAu9opvQ
	(envelope-from <netdev+bounces-287842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 08:54:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FAB53E925
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 08:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC8E300821A
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 06:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66723ACF13;
	Thu, 14 May 2026 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c05/YUqp"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC4C3AC0F1
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741680; cv=fail; b=Gmp/pcnFuxy1WagpwYNeTVzgdr+aKTCPXvnXchI/g6J9PylYObGiNt3L77cJWU8uMTDgkvOUK57+A2o8pejfwS/Vtn6svCtkNc5bhnSLBiNAzSWdwEfiELznL0bB82LpYf/EiGhpsW/ZGwjs0++2t6iakEdpw2/towqDYdCFZeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741680; c=relaxed/simple;
	bh=yLpkX30otojO1rWGOp9qEGxgO7Fu+z+/Div8pVtz+rQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lRRZsuxLNPl9Oy9m0yOHJYQRWqed+9Km+K4LbY+Mg1iq6ZwejJ6BOCirh8xuA/wgvwvYKYCTZ/qUpbABbLl3h0QooYvfWaxMohXrD0VzZLMvGEuvy9tTqpzVJfTdmbFdS5ensaLO4GI3qRnEL7WqQF7u4lk4GL2H4c9wf4yUnzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c05/YUqp; arc=fail smtp.client-ip=52.101.53.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyXgd5DOEVne0Uv5apFXDoNeUn/yBYZNdQMkwCuj7lH54pN8LQCUI96nwphy4EF/sZgoncncwJbDB5RGLYPMhnhNKYHna5i5rPTNLegYVxQNKLNz30Y7e8osk4qL0f2LJRo2M9Cwp118IuS6r1nxA2UQW1nC3x0YPggiW5b5ujAikQSESxLlKFtk+DPEYP+BemqueQNNrgD//L+INS6v8dbi/oXhY/hxRuvpa1S28o4S335aAORM6pucFG7h9m8mNSmdyxII+XiE91S+OqHOAFAaBMsdc+fUuEenau4bzx+9fztYK7K+9iyHhRSiXI5NMaJyZNoF3iCYhvmvJxRugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLb6ivu3z9LFyDHwHsASIFChvas8NLbpSuY9JbZz5kk=;
 b=pDOh9fQEh8fEz4IMdPyzVrszilJVOnBfKbzbiZm0gs57R2FAHqhThnyrdvrc8ZXDH2ROwP8YBW2jWJ0Kee1x14TtgXTwndiQemraSs/Q03Hc1d55FGj3STXJBMNKQwNMhZakEsv8Fe+wa9ObMwLYE2GAN+qN92LHhywSLnkg7M0jXNLbqxTFClqntfckbJUXIieRcaYdCG6YLQS/p92gg/FuTyYxvreC7fdseLa2p2mpvTFfZ07yfFDgq4qZsuH973mMXYWw7/pkSrgiJnNKFkeStv2u0phbK92SRedzs++1pawdFVeEmKekten1R+wWx5k4uG5GaP/9pGkiFMrYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLb6ivu3z9LFyDHwHsASIFChvas8NLbpSuY9JbZz5kk=;
 b=c05/YUqpQLvdb161bFqNCGN7bw5i65ZZuz6I+8Rrk7763RcVh5kO1PRV34GAJ+Ys6smKDwoEcufnXFG/S0MtOo0FFlN4gwC0dqsBuG1NgGfPKVJBVqmRs5jRMNzQcJ1yT2DVFqS3TkpCiJ40z0wNohnVd5QLfQOslOXiCfoKoxGLsH7EfxG0aS5v/yLsYESz+sMTprE9Y9S6uc/J3lz/Nnc1MtIVPa7ypVMgQyqud4nk/OkaeTd5nf3zsd1kqXTw3GOAKYZJ/3cxJn3ZCk/j1+4GHJzYPFLQRMLeQX37/7l2esM0RTLLNAoZ5uoEgDG+mcUW9wCUd5mDCnx8Lwi9mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by IA0PPF6483BC7EA.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 06:54:35 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 06:54:35 +0000
Message-ID: <518733bb-e2f5-470b-ba90-711b917020e8@nvidia.com>
Date: Thu, 14 May 2026 08:54:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] octeontx2-pf: persist netdev stats across
 routine operations
To: Anshumali Gaur <agaur@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
References: <20260511094205.1422268-1-agaur@marvell.com>
 <bf626b44-efad-43f2-b8b4-509934f4befa@nvidia.com>
 <agVtNvSM4eE7tOvK@hyd1lab5-269YN24>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <agVtNvSM4eE7tOvK@hyd1lab5-269YN24>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::14) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|IA0PPF6483BC7EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1801e4-3e5f-4683-52b7-08deb185a8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|4143699003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	QwL+LafWsIaCWPk0TBVO28Uz+z5U8OsHMsIGnS5IvMrqJ2bmuCXTD5oUAz2SodB1ddeZvioOfsoWqUNuLYC6Gj2fqI5xrB6ehd1DiJu0esKyyII7PL9c/IbtXFCL8VT6td4F+7pTfZwpbNweeGe8OEni9aPGiZrJ7vvRdCl4zEdc1GQzZuMy9uyXATXPe/+9Y78vLljZbpjjzpRvDuFRwVeOvgtG8XQnHFa26+jAhkaiTlZ+kUCXSpOfozwMJSkzKXhuGOIuTT8SRX8g+VM7L1hyKQjYYkDfgWrn1B/N1nx+vOvWLMCyZWRBwkgKSEpLIlWt1SptQ9xfR6sCzlY2F6dffhWADc2JifbJzOF5rClaVw3FHdmiTtvLHwk00aIDBJlq8ArkDg66v/sROPVRqNPPbDTeB6vJDjk3oyp4gU4PyKdTH6L0lIG3DyVa8g43ZtMWzBh6peDxMligZnvXhO6fY1AzFK/48oQLSzfMKN3GnaXGmJlG4Tw8jtkgEyB+EuNJn+UAPL6p9+ifA2IbDyfKiIhcGhpTmN/OgBLz64UbQVpp24QvQvTf2c5DKuxvm/jzkdZnNZQIrDpu03n/7Qc33Ofe4LeBjUBadi4H8NZStLphi6FPS+LvQ8mgHfko7a/9STELLOXXvn8CR/R1vSaIfHy7mrtgDa/S/BseB68/fhGmZi52NRKvKmZeLd4n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eElicTljMEgwNlpRdGtQbUdNd05OVmRVUTlRWWhFV2poU3RyWmJGa1lOYm5S?=
 =?utf-8?B?N25BMkxtdDBwcU9WTm9qUm1DT2JJYzduT2RLUXd4aXY4L252ZlB5dEMrQy9H?=
 =?utf-8?B?WFJxUDNpUlVyQWttdm9zcWhsV2pvWmV1SUZzdXBEYURWazVjV1VuczdmR2tX?=
 =?utf-8?B?alZWeWxteVU5VWZiSWNFZFNJdlFvUm5VYittSFQ2ZFFJR25PWjE2MFllNDlS?=
 =?utf-8?B?VHpsVU1KSi80NyttUWRvMEMvSlpGN1NPZkM0TlJHTUpycjR0WmNWcFNqdUlm?=
 =?utf-8?B?Y21EZXBJL1ZZQ2tacDZjUnp0YjRhYnBNVzBiYndyRDl5Y0JlcitCWFkxeXp0?=
 =?utf-8?B?a0lFYjlvcWE3ZlV5K3ZiNmVrU2xHSzJQaUZFa2ZBWlI0Ky9RdGxGancybCtq?=
 =?utf-8?B?Vlc5UFNZeGZwNGlVSUZIbzZSL2tTeDZETnBZQU05L1RlOEFGajMwRUtZamJv?=
 =?utf-8?B?REVLMG5ja2Fibk1yUE95Z3RPU0lsTW9ZeGI2RE9LNGhyQTNJdjVRQUZnQmZT?=
 =?utf-8?B?QUd6cFdCaGkwVGRUWThBOGpaSzJ0VUluRmxrRzdIc1RVMkthQzVsaGVDU013?=
 =?utf-8?B?VlBDckorSHJubGcyMHhNOFBqSFhQeUpzQ3Eyc2RMak4zMGtWMXNRRjNkR2VR?=
 =?utf-8?B?Ym8rNVZKMVNrZ01MemFsVURqcWtWSEZobUtYVGlBNVdxQWJpU0ZpNXFsZFl6?=
 =?utf-8?B?UUtNTGwxU2lzdTlGVW50TDlkVzdFN0t5OHd1aVlNZFNxdFExcFJLeCt6QmVS?=
 =?utf-8?B?aHZEMjVTQ1hPakxxSzBXT2Q3VGJwK0VHcVM5dlhrSXc5eEtSa01CT0NrNkxX?=
 =?utf-8?B?RHNxTTBrcHYvZm80UHA3UnEyeE1TbG1mZEtJaU12QTBUSXUzSksrYS9nUVZw?=
 =?utf-8?B?bXVlWXpZTVZNTVM0eWNpaWVwSWV4cTNDd2ZmT1R0cHpWU0hxUU5yREx3aEdw?=
 =?utf-8?B?Z3hpVDh5aVQybXNkNzIrNVZiUzB0NC92ZFZYeHIyOFk0YitoNURKbnM3RHEx?=
 =?utf-8?B?QWJvdUpTTHF5MkV4SGQ5TjY5SWw4VGZyLzlzSml5VkdRQ2t1RzRkV2grWWdU?=
 =?utf-8?B?RTFrNjdSRWgxYW00NC92TlRYVEwzZi9uRWp1aFFHS3R2R2gvcFlETlppZ2xy?=
 =?utf-8?B?SVhkZGMwVVdMaGNNNWJqRnpmelJTcWZzSW4zandiT1BiS3owSktUZjdnMDBC?=
 =?utf-8?B?UVhQY041cEs4OGphZ29wRDcyZWtTcm5Hd2RqNFlWcHJjU0htWU0xWUZVTkNH?=
 =?utf-8?B?U3dEUTZzeTAvakI3LzF6Nk1NUUgxUVBYTVpmbXlDTno5TVozQjc4REg3cVVm?=
 =?utf-8?B?L2tIS2Jnd3c2NDZPbys3WkE0ekVOU3Z3TjlmV2JMY0xNQlJXeE9JL1NCTEV6?=
 =?utf-8?B?YWg1Ynd5QlNUbktqcW5WLzVOOW1Vamk2R04vQ0lGZ3hSYjZ3V044QmRXN21u?=
 =?utf-8?B?YjNvN2F3TFVFeXpaTGdKcDkyWGFzWURJV21BSDE4MUcvaWs1VnRtYVltUnFx?=
 =?utf-8?B?MzJWQUNVVWFic3FTNEtlM0dySW4yV2psNWcvWHZ3WkNMVzVVWGl4Z0RhbzBo?=
 =?utf-8?B?dUw4eFd0OU96M0kwa2RRNkJJd00yNUFzWjdzUlpVeVoyL3lENHJTZ1dwQmdl?=
 =?utf-8?B?ZTNiTDNrcWlsMXNrZVdtWHR3bFdseDh0MHR1TUhPN1FnL0FyTk1hTGtVNFI1?=
 =?utf-8?B?R1h3U0x0c0MrZ3QwNFV3SklXeEh2NVFpdVBCNjNPQnZ0S1k5Y0loUForbU51?=
 =?utf-8?B?ektFdzJOMnlOVjlwTDBsL1NQTU5XSkhKN2JCNGpicllXUmZzYzJ3dzVXRnpx?=
 =?utf-8?B?bUZsWkxGVEpTV1lzQTQ2N3gwWWM2L000bTZTYjd4eEoyRnptTGdQK0VDK202?=
 =?utf-8?B?TEgrTFRZVmRGWTNzb2dGaDdac2kxcXArY0MvaTRjYkJCamN1SVRsRVVITm0z?=
 =?utf-8?B?QWwxL3Q0a3NSK1RoT1lSSTlxVUtwTExISzFlVnFDdXJmbjZMLzgvaHpOUUI1?=
 =?utf-8?B?R1plblJqMkJ2STkrSDk5WjNQelI2ZFNxOGh4VUI4TE1rM1FESkROR0JjdEEw?=
 =?utf-8?B?MTUyRmttVitsUlhMdDlHU3Zkc21Ha3YxcUREcWpXdVBnOVZVNCt4dFJuVXpy?=
 =?utf-8?B?NlJabXgxcnluNmhvKzVSM2IzOFlqMkYwdkxaSWIwUkxIV1ZuYzhCcE1OcGdx?=
 =?utf-8?B?WUNhb3I2L3hFZU5LbnRTSTY1a1piREowTFo1eUtJQk5jVHRyUzNSQWNVKy9i?=
 =?utf-8?B?ZncxZ2dMaHlPdThZWkYxOHBubEJOY0JCU1ZVVFhDR2x4RC9LN0szNXRLSnlC?=
 =?utf-8?B?NGJTbDJIdzlneEE3RjBleTQ2VUFXNXlvWTNvN3lUVXJsRlJvQStGdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1801e4-3e5f-4683-52b7-08deb185a8ae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 06:54:35.3223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0pw47vIdwV+LfyyeNR1bLMQOgFZOEZPJslEm6ggY+jzNSOdEwBXpmXPHRPtPmByxAf3uk5GLio+W4g8OUeFWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6483BC7EA
X-Rspamd-Queue-Id: 27FAB53E925
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287842-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action



On 14.05.26 08:35, Anshumali Gaur wrote:
> On Mon, May 11, 2026 at 12:03:32PM +0200, Dragos Tatulea wrote:
>>
>>
>> [...]
>> I don't quite understand why the additional old_stats is required.
>> Why not accumulate dev_stats in place? Either directly in
>> otx2_get_dev_stats() or pass a local struct otx2_dev_stats var
>> and then accumulate that into dev_stats?
>>
>> Thanks,
>> Dragos
>>
> Hi Dragos,
> Thanks for the review.
> otx2_get_dev_stats() reads absolute HW counter values from
> NIX LF stats registers and does direct assignment to dev_stats 
> (e.g., dev_stats->rx_bytes = OTX2_GET_RX_STATS(RX_OCTS)).
> These HW counters reset to zero when the interface goes down.
> Since they report absolute values, not deltas,
> accumulating in-place with += would double-count on every stats query.
>
I see. That makes sense.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index ee623476e5ff..9606c8cb8c82 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2158,10 +2158,28 @@ int otx2_stop(struct net_device *netdev)
>  	struct otx2_qset *qset = &pf->qset;
>  	int qidx, vec, wrk;
>  
> +	struct otx2_dev_stats *dev = &pf->hw.dev_stats;
> +	struct otx2_dev_stats *old_stats = &pf->hw.old_stats;
> +
>  	/* If the DOWN flag is set resources are already freed */
>  	if (pf->flags & OTX2_FLAG_INTF_DOWN)
>  		return 0;
>  
> +	/* Accumulate old stats */
> +	old_stats->rx_bytes     += dev->rx_bytes;
> +	old_stats->rx_drops     += dev->rx_drops;
> +	old_stats->rx_bcast_frames      += dev->rx_bcast_frames;
> +	old_stats->rx_mcast_frames      += dev->rx_mcast_frames;
> +	old_stats->rx_ucast_frames      += dev->rx_ucast_frames;
> +	old_stats->rx_frames            += dev->rx_frames;
> +
> +	old_stats->tx_bytes             += dev->tx_bytes;
> +	old_stats->tx_drops             += dev->tx_drops;
> +	old_stats->tx_bcast_frames      += dev->tx_bcast_frames;
> +	old_stats->tx_mcast_frames      += dev->tx_mcast_frames;
> +	old_stats->tx_ucast_frames      += dev->tx_ucast_frames;
> +	old_stats->tx_frames            += dev->tx_frames;
> +
>  	netif_carrier_off(netdev);
>  	netif_tx_stop_all_queues(netdev);
>  
It would be more accurate to read the counters from HW after disabling
tx/rx instead of saving the old values.

Sashiko agrees:
https://sashiko.dev/#/patchset/20260511094205.1422268-1-agaur%40marvell.com

Thanks,
Dragos

