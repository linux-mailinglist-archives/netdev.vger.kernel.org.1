Return-Path: <netdev+bounces-299571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mTWhOqlMMGpPRAUAu9opvQ
	(envelope-from <netdev+bounces-299571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:04:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 853D76895B6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:04:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=s9VDGSAr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299571-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299571-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA84C3010901
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816938D3E3;
	Mon, 15 Jun 2026 19:04:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012051.outbound.protection.outlook.com [40.93.195.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6AC30D3F3
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:04:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550247; cv=fail; b=AnK2Fzseztd3zStZg1Bc3CaNV1kmFy9t0Ryl+jgg1dY83X1uvjK1afFxdB2wKya7oC/Pf9Eq6YeMYuwH/N+gkodElUoEq9TSOytA5b7bg0mJFZCpyMMVCwKs02Y5UfLgJ1IgA+YHJmFjUDyVM3l5noA58X/lqxCFiXMtoH3PCFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550247; c=relaxed/simple;
	bh=yILiCoNGa27IwW78Hq2b++ui6vNySYsk2lIceFxzocs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mOf9ug98hM8nIk82xhQlsIBfdkg4OIM543i3K4tKdiCOzTEOKazI2gdEdvDcVL/unL9PLkW48Lugl4m2jdLY2ZNhFJMx5H68lCa/kJrUVu8ovE80baSnHw59FC6m9pemt+Cw+kyy/ec/yHNIXZmkbRBsjsqCJlFXaQW5cB2w8wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s9VDGSAr; arc=fail smtp.client-ip=40.93.195.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrNqqZ/y5G8PSBd2AdT8zKPPWq6EL3MAPeZBz0Y1kSCNN3mBipfKnxKyVaTLJztinEsAwOqvvWKpOGkowVnSj4GKZBZD2SEcv/BXLQPseoBMWo0B4RhKiEn3g7C8qDZgPB91DSth2qChTeNoTxFNpLK/gk8Li3IQZSAMnsR38n1ISSuvlKF49EgtvRouNYyoU/vDOtvCw8jTxbit+k91DxId9wvCc3o7lis4F94uiCJeJubPstE0ym0mCcki8M/oKCKWRnuofV86BTWXzW+YA4/9T2t8NRFniWFHj72kOdRsiRr6QB5HspMuCVCj1MXv/IqX0387D0eLy7PJOjS+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE7vpkVXbhYY5cXXTyD2+D8vvConWWfYgZ8ETJGxO5Y=;
 b=dMiMAWnM3kzNfAmC7KGVv4AuwOdirjToZzLMtqWjvTbxq6IgH9qrD0msNVv1VdymY16wT3OLvBaGCYZTlm/zfmYKPOkgIiH963G2s8ILkuKHTeufBIiOX+cvE55q5X8wVDJxHFJsI/DxrHaG2eG7dKCBaWyA29YgA/sHl83bjVvtrqjwMjyhZh1pbTRzLGUaJaSJ6hu1B/idOMSoJJp+gnBHTsogkBNfC7mUbcaVSQ5dbWroGVB9mfiCuIDGW7/Yg6zPhUU0ZklZd4J+adecpcctHKtreRCP3cWtfBvh7+A7ywGJraW4bZxGFDFYp1AukK5R8S/1uFD9/Z4OwVEc6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE7vpkVXbhYY5cXXTyD2+D8vvConWWfYgZ8ETJGxO5Y=;
 b=s9VDGSArMKJyL6kwzdiaQrGzMXqMi5/ZP5psPDeY1UyRSWh+27AjdbQe0lFXrcVVBd/a4E5q40+ONTHcyjQkFXFiaulKxz8cza5F+RxQq0I2FFVrDQpsK1IE3j3fUleSZsPH71C7PeE4Jn+LrSNkVf4Fn/3LiXoHaN4YCEKEJXY=
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 19:04:02 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 19:04:02 +0000
Message-ID: <c94b0e52-886b-4a96-94d0-53bb6020d06b@amd.com>
Date: Mon, 15 Jun 2026 12:04:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] pds_core: add PLDM firmware update support via
 devlink flash
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, eric.joyner@amd.com, nikhil.rao@amd.com
References: <20260614050052.1048328-4-nikhil.rao@amd.com>
 <20260615153620.775599-1-horms@kernel.org>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260615153620.775599-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3fc757-b7db-4b87-9be8-08decb10dd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|11063799006|4143699003|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2Qc8kZ+0EVkNmWL+aA0o7SukF/mBL3FhmyZSy2mWgzPr0NS4bMVqyTebdc8sUUluB7rT8DbGvhBP8MqWPabrhKQFa1OptQDYBkXyLeFR7GZ9ho6kLrEiGpjMnjNAE8CXXfJ5QeLcsK5dsBs06Fc2ty71wNP+axKkiCZJ1DryV1CseX93rpg7xDSwzioM+xGRLNQmY24SAJcAlF7slNt6VQqpUikjiGZZ6t9ZwjnFwHMHhNTIp9mZ8wOGIPGuEIoJj2JvN62DjMcDKTboX4YIz+TCQiMdnfneYbzyr7cPMGoQRzbztlxx1c2JtGujvgETs2sNfKUgvfdyKThaOYGDgF2gKlhJh7OzAU2odVB/lw7mOuBMAcdPTbzSB+TtYkVCH8641SuB6tUSXGA1yPwvg6IjjOtUBif/9tNOfrvJg+ZmIS9POiYXlaLZiwE+UTvOtC4Xnn/8kBJH2ixmiy957XfoQS5gvLRsTTfGWnksttP9pQonduxrnvgpOm0c4WcS6nZA8i6PXL1g/Bs82MP/U/y8y15rbV6Uk82AYpF0eMrTpDJRUwKFleZhURoibs+npHt3z7MYBBhN74ft4qQ2FzLOJpRMGN5VVx4lyZFbVAc4oaJy3nwVyCQuZtf6G3Qjb+wJOMIG7NsrkRdEvYRmjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z05MeW5JYllNNTRienYxRitEKzdCYnJ6M2lPbk5tYUUyUVdBdFZoQkE5TmZn?=
 =?utf-8?B?eTcrQm9FWktuMUtuWDN1bTk1TXBqOXFOVUx6dGwyaXJFK2ZkYis3cURxSHhI?=
 =?utf-8?B?TFB4c1BWV0c5MTU4VlFrR1FST0pMOXBVSlkwd0dLRHJxMnovMkxRbnZwcStQ?=
 =?utf-8?B?TUk4TGNreWlEb2dTOXVSelVLNG5pTGNlVEFySkdZRk4yUU1yU0dua0FjZXdG?=
 =?utf-8?B?cy83TlQrSVBhWGd4dUFuQmZyZHUxVWZlVFk5R1BycG9PSFQvMTRuZkpUbkY2?=
 =?utf-8?B?Y2tIQk14VjhDUWdyOWs4Um9abmtGNmpQT3lySXM2RTVndjN1ZjdHMU1HSEdh?=
 =?utf-8?B?R1pXeWgrS3BwZllGc0ZWWThzbk5qME1ZTmkycWpVR21nb3k3bExWcjIxRXIy?=
 =?utf-8?B?ZzltTEE2RWZlNDBOeXBoaGsvVDB1RHlWOWdSSHdUSXRBWFdacUxOOTR3dUU4?=
 =?utf-8?B?R0hRVFNRaGxpTGVURzgrZFdCZk10bU5pVVVCL2xwZ2kwL0oxbFNUY05RL2Np?=
 =?utf-8?B?ODJ5cUNGeXRDaHNSM3VoVFVIQmJtelRyYnNWVTdVUCtVdnYvdXhia05IVzJP?=
 =?utf-8?B?Ritpdm4vdit3THZodktWaWIxOVlRZEhXUG1nU0VRMjdQRUZVb3Y5Q3NvWCtq?=
 =?utf-8?B?b1c2dVZEYUZ4TFA3RlIxK0lCMkMrU2lvalBpS20rMldQRktEKzAyVnlmcEZ2?=
 =?utf-8?B?WUdFRytIQVVCcWhhZHRGTlhkQWgvYStKNHJXWUwzQ1BYZ3pNTVNBTTBLRlZt?=
 =?utf-8?B?Sm5nT1ZHcDQ1eTBDZndWV1JPaG5YdDVvYVJoeVRpWGdRZXVZQ0tPd1pHZXl5?=
 =?utf-8?B?T1ZhMnFBVHk2ODJLdU9lZlo2U1RaTmp3SVFXVFN2cjhCcTFuclI1VlVLRGRx?=
 =?utf-8?B?cVhaWldpTWVpT0FqcnRJdk95REdZR3lHbm9mNWFEUUNXamU3WEZCeEp4eExx?=
 =?utf-8?B?L2c3YzVlOVQzTnBQZCtKcDY3YmgzVjI2SWZTMWF1eTJqeEZSSlhKNHFtRDBT?=
 =?utf-8?B?S2tMd01zTmZmVFlFZnI0UGJtYkRkSXRTSjFCeC8yZk9YUDB3VWRxOTdzL1Fr?=
 =?utf-8?B?YTJDd2tmelNCTU1JY2dwOFo0dlYzUksvV2ErWlNJVXBOUWFnamY2M093Rkp1?=
 =?utf-8?B?bERjVDI3WFJYUUdBaVlRdkUyM3VvUGY5c1p2QkVWRE14UUErNDhpQzd5ckdk?=
 =?utf-8?B?TFpjVDQySUtEQ0ZOQ2M3UnMyY2lsSmxjTkVEMi8rTm5Wc041RzdvQ3dEQWtY?=
 =?utf-8?B?bTlIUVZHVVUyRkIwZCsvUllzOGZqVW1XRlVTTTRrU0pZTWJhZGNGdmpNRE9v?=
 =?utf-8?B?OE1iSHlVd1NNazVqZjVhZGYwQWE3Y2RjaHJ0WnliU1UyQkRlamhoTU1CN0lY?=
 =?utf-8?B?SThwS3FxTFlUMEFZNjBUaDdpMzFqNXFZK0xJZGR3VG1acEk1MUZ0RE5QTWdR?=
 =?utf-8?B?N2l3Z0MvWGlUVUhmaHZUbFBob2JuSENOOFI2bTNzWU9pRkhNejlOMVhRczhu?=
 =?utf-8?B?dWQwTmErR252eVJTeEovL21Jc21RU0NlbWR4WjlId0U2K21RQ2M5UWFPbmtD?=
 =?utf-8?B?bXQwWjVLRWJwU3NCVTVDVjh6MDZ6Y0FVNytBTlpSYmswSllSUVJyQUQrMkpW?=
 =?utf-8?B?WmNyL0lyYmZaRnpvbGZMa1AyVFNvUmZNUDlVVkxVYjZMaGNZdGhKbyt5a212?=
 =?utf-8?B?dkxMdG9BQXBEN29UZkNrS1piM3puMjZ4LzZnYjZLOXJoOHlUMGFoNEpVZVlU?=
 =?utf-8?B?T3AyZzRkUFk3a0laZFo3RVVvTVVPRFJqRW1EcEViSnozUnIvLzZFNE02d3Y5?=
 =?utf-8?B?U1MwTVY0OGJGR3VFQXpsU25MOEppVzloUVdrVjFRRnRBWWxPRU5tVGpWcVdu?=
 =?utf-8?B?OGE1R2FIa001V0lJdC96MlRER3RKR2cyWjRTVEdpZFJmSHVLYjNBOGttUEZT?=
 =?utf-8?B?cXQzNmJzRnZkZXdDVVJUSWxOTUNQakF3d2lzZklPRHUwQW9QOSt5UFBvMWhU?=
 =?utf-8?B?SzBtcFpSTTJ5UmN2QlQ1dkZraFRRZVdEZEtyamJoYjVSZXRwd1F0bllvT0VH?=
 =?utf-8?B?SU5CSmI5cTc5RlNEaXA4LzN4cWZTbTNoOGNibndPa3lidnlpZHp0cTFiWHJU?=
 =?utf-8?B?YkpNMjdCbWk3RlQ2NHFmSUpmdHM2WXlyWTZRMmJubjAzdEZwWG5PTTc2WWFq?=
 =?utf-8?B?bGFjOHlRWUhzMmpIc2pKYlYrWDRzSnp6d3RJZ1I2Rm5ZOFlxSlk1SE1COUxl?=
 =?utf-8?B?OTZja21tYmJPZTc0di9FMk1jV2UrMmF0V2dReFJjTlpGcG9jaHY5NFhZRW96?=
 =?utf-8?B?emFmd2RteGJYMzl1eHFNNmpkb1M4ZFNSOGlHYXM5SEFTR1lFZTFqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3fc757-b7db-4b87-9be8-08decb10dd4b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 19:04:02.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5Go6BqTuqdiDCBpa4IC4F1AfMopAhPWJeiegNvzh3NqZvyKHMeSZ3+QW6YQcR+NO0Cb+vIkzD/qMVpCE0hXKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299571-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,amd.com:dkim,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 853D76895B6


On 6/15/2026 8:36 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at:https://sashiko.dev
> ---
> pds_core: add PLDM firmware update support via devlink flash
> 
> Implement PLDM FW Update in the pds_core driver using the upstream
> pldmfw API. This allows updating an entire PLDM FW package at once
> or updating specific firmware components by name.
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
>> --- a/drivers/net/ethernet/amd/pds_core/fw.c
>> +++ b/drivers/net/ethernet/amd/pds_core/fw.c
>> [ ... ]
>> @@ -195,3 +239,720 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
>> [ ... ]
>> +static int pdsc_flash_component_chunk(struct pdsc *pdsc, struct device *dev,
>> [ ... ]
>> +     err = pdsc_devcmd_send_component(pdsc, info, info_sz, dma_addr,
>> +                                      copy_sz, offset, slot_id, comp);
>> +     if (err == -ETIMEDOUT || err == -EAGAIN) {
>> +             pdsc_deferred_dma_add(pdsc, deferred, dma_addr,
>> +                                   component_data, copy_sz, DMA_TO_DEVICE);
>> +             return err;
>> +     }
> [Severity: High]
> Can this lead to a race condition that leaks the DMA mapping and memory?
> 
> If pdsc_devcmd_send_component() encounters a timeout in the lower level
> __pdsc_devcmd_locked() function, it will queue pdsc->health_work. The wrapper
> function __pdsc_devcmd_with_data_nomsg() will then release the devcmd_lock
> before returning the timeout error back here.
> 
> If the scheduled health_work runs and acquires devcmd_lock before this code
> reaches pdsc_deferred_dma_add(), it could execute a recovery devcmd and
> call pdsc_deferred_dma_free() on an empty list. When this thread resumes,
> it adds the timed-out buffer to the deferred DMA list, but its cleanup
> trigger has already fired, leaving the buffer leaked.
> 
>> [ ... ]
>> +int pdsc_firmware_update(struct pdsc *pdsc,
>> +                      struct devlink_flash_update_params *params,
>> +                      struct netlink_ext_ack *extack)
>> +{
>> +     int err;
>> +
>> +     if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2 &&
>> +         pdsc->dev_ident.capabilities &
>> +             cpu_to_le64(PDS_CORE_DEV_CAP_PLDM_FW_UPDATE))
>> +             err = pdsc_pldm_firmware_update(pdsc, params, extack,
>> +                                             params->fw);
>> +     else
>> +             err = pdsc_legacy_firmware_update(pdsc, params->fw, extack);

The race scenario is technically possible but does not cause a leak.

The deferred DMA cleanup is guaranteed by explicit calls in teardown paths:

1. pdsc_reset_prepare() calls pdsc_fw_down() then explicitly calls
    pdsc_deferred_dma_free() afterward
2. pdsc_remove() explicitly calls pdsc_deferred_dma_free() at the end

Even if health_work runs on an empty list, the deferred cleanup will
happen either on the next successful devcmd or in the explicit teardown 
paths.

> [Severity: High]
> Does this fallback path ignore the requested component name?
> 
> If the device does not support PLDM, the driver falls back to
> pdsc_legacy_firmware_update() which only takes the params->fw pointer.
> If a user requested a targeted component update using devlink, this would
> ignore the component filter and flash the entire monolithic image onto
> the device.
> 
> Should this explicitly check if params->component is set before falling
> back, and return -EOPNOTSUPP if a component is specified on legacy
> firmware?
> 

Yes, this is a valid bug - but it's pre-existing, not introduced by this
series. Before this patch, pdsc_dl_flash_update() already ignored
params->component. I'll submit a fix to -net as a standalone patch.

Thanks,
Nikhil

