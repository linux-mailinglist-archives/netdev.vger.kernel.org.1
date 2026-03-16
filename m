Return-Path: <netdev+bounces-268189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB6sM84juGk8ZgEAu9opvQ
	(envelope-from <netdev+bounces-268189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:37:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6942429C8B9
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88CA931E6DA6
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305063A3E62;
	Mon, 16 Mar 2026 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DjnbIenJ"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446F3A0B3F;
	Mon, 16 Mar 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674803; cv=fail; b=I36uH3dWagEVO6CmTqedJGun6dZggdSIQOVPP+r8Y80V36r5h1v/CdAVnKfDaf+/+TGYA/2feaQY3nPeGMO2ud7q88jiQ7WPRUCENlCvwuWASTYbTThEPv0A9XlMk5UVJugr1KrGRy9HfmBGe6PfWYNK6JrU52ooibZO8KrEYR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674803; c=relaxed/simple;
	bh=CQBi017Mp/GGqr9WhE0vkqAj8MGB83moEvvFwvjdAks=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iq77Ca2aIbE2W4AdgylfKxFZ7Kaqe/YnUD8QEJwbFksPfk+LYhfNhViUDga2hLEPMGzKhpxl61WrDOfwN32YLt99VEvu/BGH5L7ccHVJYliGJVKKEavb10QC5zKvApp/kkB9g8ZMM/XCnuXt9SzsEFdVw7MSoTvrDfzs8bFu0Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DjnbIenJ; arc=fail smtp.client-ip=52.101.193.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdq6GbuB7vNJK2XW6l2zX3QFLDAUJa3QPw/EMLXaOuEOp3/cAcCfnzP/LOBPopzQPjkOTD86hC/ll8c/fKjpjol6Gq43JOQx9jj0Q/AvuLVh23jCPBQeWtojukUZMggvimCMy514lLvPdcWmuyDHKq6KMNkqDnarpa/GawXv5omM1oByDYFPHFPv51d0StYWeA9FmJwNcOEyG3Kjn+DPi1TV7DqeElaE6Gc3mv4zZ1sIHXr6wVfRSZ1hX9PW9vYu62tlyAac//z5HJl9FCSN2GZttVGrEwKwTy/ZBT9nqpHeBV5H9siSdKHovQiso6WppCSiz2uc7/uKqKisd7KD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4Z7VEhTR7xoPwUCCgZWKZ6xIRvKqE4fb+IJ3DW7vvY=;
 b=hc7+2/S4x56P1UEHFAXlqErBHIAfXZLV/Zdigrq5Iyhm/UoTQzEsW8NmVA23GJhojCetPJv/s3jejSOsXIoyQI0LZS759t05L7tl0e409mxhMb3uW2tGwxkV4wgha+N7hgdyMFxOXx4ZcH3WAP1Gi/hZJUGRm6zwxnLS0POPrh6hyxjytvJFD8rdn9myYFkJKbGYaUCYEijm8CEGGdyYub7/nuqwd0Hgv2+J5lPDwYguZfON5t+YCQvFffKh9u71DjDBP/ooJN0IuiOpnI19vb5YRPmjb8TtU3ZY7oUEOiAL1hN1h2MvuXRfCXBcHbxJIShYsMBx0DVeCb6yhdVwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4Z7VEhTR7xoPwUCCgZWKZ6xIRvKqE4fb+IJ3DW7vvY=;
 b=DjnbIenJnFRYgCjZvyrPj+4SnPyZ2QXni45ZlBh1MaE2vvSBaeZLWNK1gdchu3wG53ThbAMgx8C+JuyhLGq2rXppXesBsKsMSCugHc2/z8cbvnCg5mavT4S+t+6tYAj+Jbm6dM2Sw/EHNMcccCOL6nXAZE4GPjlHREuaX9cUSuLmEholg7FjpcNvT8XNvAXLQ2mH7uic/viZw7LdreU9lvZGbXnTqcNFum+vTMAkmLmgew+q4KfL9rcDhpIF1x4G93H0GwRuxuZ0mds8S9dz0WxDdERqCsG55B4H6LNwvCOxvRVMHLQG7ZECWqIjuzioZTYJ2eRbUDGKsnx6MISKJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 15:26:35 +0000
Received: from SN7PR12MB6791.namprd12.prod.outlook.com
 ([fe80::887b:66df:644:a748]) by SN7PR12MB6791.namprd12.prod.outlook.com
 ([fe80::887b:66df:644:a748%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:26:35 +0000
Message-ID: <7254438b-d013-4452-8a92-c3e15502aee7@nvidia.com>
Date: Mon, 16 Mar 2026 17:25:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: py: give bpftrace more time to
 start
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, petrm@nvidia.com, leitao@debian.org, gal@nvidia.com,
 linux-kselftest@vger.kernel.org
References: <20260315160038.3187730-1-kuba@kernel.org>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20260315160038.3187730-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To SN7PR12MB6791.namprd12.prod.outlook.com
 (2603:10b6:806:268::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6791:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: aab77bfb-0254-428c-9ff2-08de83706890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	gsUOEVR6mwYMSFDcyyV5GwntFmlxDj3wsIMzA3S5GAOZCHlx/vsIHhIMogDIAdtQ6C+d7lZuj31h+u8LNnCYa3G4RuMKKpd6AzU717bOos8j7b6i/0UZ67JXSPy890/moQA4a3lWM+LXzv7LZeAgZpwNWe/LcF4wb4lyFdQ5C83o3v0T1Oz7qYshXmFKKwnn6/hzbQI+H5SNRqpXM1slxVSYZ0QfkPWyvMttYO8lncpJIAbSbbGVz6W0er4m9T75VSU0Acf/AGfz2u5BKbhamhjGm4tGGvqAh625TDDao/vS6zheKxlNIIy12pUpVzv401BVLZk5+NOPdtrz4EYqi6jQGZx24g8MlgDVQl5zFcmLKx6vi3g/xJ46D39AMxcMnw1u3FHbCvMkkarL5/2rqy12CEXhDLe6tkAW600kPsg9KOc09CZ8OvPudwATfsry7/sfByasTA4Icv6ROjVU8i2JtUu2Y1U7YIAFULGZB2kEC5QSkn4ODmXh69Oym/rekzubGj+jmM0zMyNRf3+irYII9PFyhThl4rCUfGIUjcPedOPRx+yI1KxRl6vT1gIWjbsV0o6OJxrT2QmkwSs8sZMaEq8/xfeH4sE4FWYWA74LcHvvB8ZPf+lx6k9u6yyKMIcCjUEw49iMHwxBUvep0GosW9m2Oy1QeQodQbZMPr7UvgMiBJjaCLZbICkTX+CtVyMDgV6RFa/0st2726uhp0HTXlGyLGogoQc5xrVs92I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzlNM0hWblBidEZQem8wenZlNTEySFdDUHh2WTNRVkxSRlpaTHVIRGxtbWkv?=
 =?utf-8?B?S1kzSGRDZG15VXZ5MldrSC9wRmJIU05MRkJ6U3V1V0JCODdBSVJadjA4Smlh?=
 =?utf-8?B?SkErTGYzSUZjVUNVUjdYandDb0ZrZFZHRkNHVHk4RE9xaHRvdzJiYWY2OTBN?=
 =?utf-8?B?QmxuUGFPbVU0cnpPd1IwY21DQVBaQzdZeXBhVFdNbmRsU1VKVGRBTE1xeXhw?=
 =?utf-8?B?L3ZrbVJqeTltejRaMzhvOVBnTitVcXZLRVpFeFVQZXg1YU11V0Z2bi9obDVO?=
 =?utf-8?B?THl4SjYraTk2ZGl2MEtZcHF2M2xQbS9IQ0MzS0JIUEV5cHZLVkoyMFVGSExR?=
 =?utf-8?B?MzI0MzNJUWVHK2VLUzhZdE1WQU1VbmdqbkxMSVZ1eEgrck5WV1Q0MFpnVzQ2?=
 =?utf-8?B?MGwwMURCNDRsOXpUV3IwdWdqaVpTT1ZwSHZ5RTQyamtQN1NZeVBmVkU0T2JH?=
 =?utf-8?B?b2poWHRtR1RFejNWcERvdWhORzBwcm5GODNZWGt6VDYxc0Q2dmVVNFZKcUJp?=
 =?utf-8?B?NlFpbDNybDBOanl2OFJhbkdCNDc2TExSWXhBcEFwRzhyNDE0bllLSnV0K0Rv?=
 =?utf-8?B?SXU2UWxKU0M2V1h0bkFsZjlKNGFyNkV6MkVlNk8weThsK25ycERmT1UvWEky?=
 =?utf-8?B?RFZPNkl3bXVUSFNWZm5PZFhtRGFsOGZTK0dPMExwNU5MMytkby9ZbGlZSTY4?=
 =?utf-8?B?NW94LzFhK21YWnhTMFBFdzdnU0p0VzhDL2JXR2pIdzhYeVd1THFtMkd1b1Jl?=
 =?utf-8?B?bDI2anhOVVIrTGpVcEI0TTlkSmhVUysveVFha1R2eldFN1BlQlVtc2g4Wnla?=
 =?utf-8?B?OWVxTWJ6ZGFLQnh6NFIrYnR5bmtlTjhRMXZPWHQrVzgyb2RzazJPdnlLUmNV?=
 =?utf-8?B?NHdOSmVXYnZaOExsZzlPcGFxUVpmaXEwWldkQzdrVkJYSzJsMC8ybHJ1eUpM?=
 =?utf-8?B?VWYyY0RNVHZmNm1yNlZ0YzhGRmpueitTRlpaTm5valRlbmhRVVdrdlBrdUFS?=
 =?utf-8?B?OVk1QU15YTM4YmJYclhJMU1NcFlabGtjT2RQUk9wMGp3Q2pIRFVFUmNvTHlE?=
 =?utf-8?B?N2VwK2tuZmNWY2xWbThNenZEanNkUWdmZzdlaDNDR0l5ZnhicERXZExxWWZ6?=
 =?utf-8?B?RmtIZ0E0b2ZCWXBMN3FqclBMUHVFTnBkd1hZMTJ5N0p1OEtYdmZPVnpXVUhp?=
 =?utf-8?B?TWI0aEVtTUswbzJwa0xObXB0UFhVOWR1bDl4VHpWV21aeEdHMHVvako4WW1m?=
 =?utf-8?B?RGU3THhLWklONFRDVDJlbDFaUWc3SEdrWXZsbU1SRjdhc1d1d2pLYnk1bkQ3?=
 =?utf-8?B?T3lDWVpOUGpEVzRHb0pBQ0V1QkI5VzdMa3dFTjFsMWFOemErbmlxc0Jyamx2?=
 =?utf-8?B?VWdYelA1QmhpZi9VT29kejZubzRYWDkrV3h0bmFiZVVZWndtWDh4RkhnVzlr?=
 =?utf-8?B?YTVYMVdubFFEY0lybmMyK2lqdmJWd2hORzFzU2hEaDRJUVZ6Y29Xd3pWUk0r?=
 =?utf-8?B?eC9xNHQ0T1R6VmhCcDFqL2JNaWdpK0JNUnVvZjZoSzROVllSSGRRY1kwZWo3?=
 =?utf-8?B?ZzV0dGNsY24ySVdkK3ZKQW9rVlU4MEp3TmFMSTlNTmNtK2tqNXRQRjN2TDRi?=
 =?utf-8?B?dVJxNlFlT2RUdkt5TytBcnZyMkhKUDI1Y2taR1FuN2ZURXlaTDRjdWhDTURD?=
 =?utf-8?B?Q0FMcG0yQVpwVGEzVUJFMzdRTGUxNFlJYlJGcXFSUllzV2dKKy9RS0I0UGMx?=
 =?utf-8?B?T2lqTU5sSWx0K2FoekkvVmRiRzV0T0huRzZncG1aTS80djlQTkltZG1xWS9G?=
 =?utf-8?B?WlhYQzkzZXpncU5BeFJxSkMrV3N0V213cEJXUHNud0tYUEp0QTR1VThmN2U3?=
 =?utf-8?B?NTBhZy9waWtXMzJ2R0ttaTcrb0hTa2EvR2MxamZLWHpEbGtSMXp6aXkrL2JI?=
 =?utf-8?B?amhOZkVIRW5lQ09LQWwzS3crM0dJNkFVV056UnhSdU1sdzBQd25rM3kxNG9q?=
 =?utf-8?B?ajlOUDQvbktVYWxDY2E3Q0t0V2ZYdUxKdGRNTGhBSXVtZUFXSUI2UXZMQWRM?=
 =?utf-8?B?V1h1TFdTeU1QSTFsd2NtbktNZW1BMlVmZWFzSm0vdEpTZ1hDMUdzcTN3Vkx6?=
 =?utf-8?B?ZUh2UEdLT3RaZ1hianlQK0NTSEdnWlVYNnJKMnBMNHFVQlV2WldvSDUvbFBm?=
 =?utf-8?B?d09VTnlzL3ByMjR1dE5MVUREN0VCbEg5V2F4WVpLbk1XOFhsUFhZSkFXaGNQ?=
 =?utf-8?B?NjRWYlA1VjhZcVhSNTE1UTVpeWlJSGpDd21kZ1pmV3ZieE1yT0piTFIzWW9K?=
 =?utf-8?B?eUlpTlkyWnZqMEw4SmJuaVhDeHF3Nnp6N2RqMmFJY0FHL1FLNEtUQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab77bfb-0254-428c-9ff2-08de83706890
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:26:35.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4I8AJP72hbcNIDf8XrP9b0eanL/eScK3ME91ruGsyN+HhyEIISrkRCE/ChHBHRZgrjH/7CuseVdE8ii86h11g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-268189-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netpoll_basic.py:url]
X-Rspamd-Queue-Id: 6942429C8B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 15/03/2026 18:00, Jakub Kicinski wrote:
> After commit under Fixes debug runners in the CI hit the following:
> 
>   # subprocess.TimeoutExpired: Command '['bpftrace', '-f', 'json', '-q', '-e', 'kprobe:netpoll_poll_dev { @hits = count(); } interval:s:10 { exit(); }']' timed out after 15 seconds
>   # # Exception| net.lib.py.ksft.KsftFailEx: bpftrace failed to run!?: {}
> 
> in netpoll_basic.py >10% of the time. Let's give bpftool more time
> to start, it can take a while on a debug kernel.
> 
> Fixes: 82562972b854 ("selftests: net: pass bpftrace timeout to cmd()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Nimrod Oren <noren@nvidia.com>

