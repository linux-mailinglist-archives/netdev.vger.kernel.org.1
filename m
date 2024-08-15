Return-Path: <netdev+bounces-118914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A870495380A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05E11C20F60
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5991A17C9B2;
	Thu, 15 Aug 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XMhRTuAh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724372AF12
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738430; cv=fail; b=CgcipB5FsU1Pgs+pLI+DQ0r7Rcx8GnHT92ZZkfGVfmRpZgq/Yls7ADyxzIB+Nmg0ZGpYXPxqpVDtxF5xrVXdgCBbXeQnMmz/vmrKWuZOE1Z45ozOrjASVp5Fmg8ibcKwblmd4q04oa/fJCl+Qkp1/Z8/EtI9nld87WfsHgP9bTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738430; c=relaxed/simple;
	bh=/0uIAUaZrrxDWGRYo+pTG9tggDK2Gq2NgvmWrriKLbQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YmNwZD2dHJdPyluFyo0t0DIIF7VWY2EKd+sheuYWZ97L1x1e1WmupEcvPgJB3OI3KmhhR/9aunsLENP0NvfSMtwofrMmebqB7jLnM8NCNgZCWxfJt2XIE3RAw5e7lfRV+NzzpwUiVHpneUJXLF4jhMt60imdh+SfwVM17IuWv3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XMhRTuAh; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUpBrRGM9FipTKNaQGBpYbmx5rWpYtzt1dwlWotjepf0UMUDmcgeaqqqImHi5Ynb3aVb1ujCXcZWGoLQqveQIQ7b2l4bujCZlbB5P0tTtKCn0BUxq2vsNBsYPcshnVX9JlBfvvC0YIU5iy9+EhMuWx9iHS2IjEY5kqDkQwuLQNd4sS7zHhJLQFbemnPzjV7uItAKpuQMpjV2eRkULwSGX7tllrPuj2Z1t2ecloZ6FEIivcSCOVHqCSHZkFUdR4FpQU3cke8TyTiiLS2VjzgY/huxIk957g841UwyMjZVzshPCaey55qOB2I4hJUmS4A75zCGoUt+CeSfyBiPSE/o6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyoUyEg1qDwcu+OHPXlSr5cPeY6LV0CeF6x9hvE9ynU=;
 b=RjVTprfcPE2k/e+jhyo4lR45vUuoOhEuZKm9MAohf39WbNSR00whQZoNP8j/rwp+eboxdyCTt/Kej+ztLSY5J5dfXwhbk53N6ghYRugTfRixl36nq8Rcn1S9evmpK2bUto/yDLL0yDq6ZtwoNMaamJlfjFbmtmWz4295Bc1Qf89VkEQIqRdGUbNYykNnTE66SUSXgesKACw0XoqwfScwkDrjCfnIRQNqDedP3YI/Jg9rsOF181MbCUsTnN7+rRlcOiqfPr9dcahxJpjkx5qdHduLEU9amBajh4+14z5iNswJY+0RwUQ1wM9kVHKV/tsurlP6ZwrPzML9IiUk4y2U1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyoUyEg1qDwcu+OHPXlSr5cPeY6LV0CeF6x9hvE9ynU=;
 b=XMhRTuAh67M7BfWUz2xUn4UaWPxDv/UOnLrbuFGLsMcrW4sRRBDI2fegJIKcMc8eaJy1tZq/M8d1YucP7BBBGwqHmYwE388T/m129Xe0NCY7MrQSGcvhgyaIbtV61WqDnap2tDFWx/3y6QE7domzmvzqYZdEs39y4h+Zzou29RM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Thu, 15 Aug 2024 16:13:42 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%3]) with mapi id 15.20.7849.021; Thu, 15 Aug 2024
 16:13:42 +0000
Message-ID: <a4f73bac-12dd-4fbf-ac56-0c704563d0c1@amd.com>
Date: Thu, 15 Aug 2024 09:13:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: add tunable api to disable various
 firmware offloads
Content-Language: en-US
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Yuyang Huang <yuyanghuang@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20240813223325.3522113-1-maze@google.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240813223325.3522113-1-maze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 005818d3-b31b-4d20-7ce5-08dcbd453b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qll6VDE0cFZFNExpd09BZFZySVJGZ2FWcVlZK29GSnRuNVRoY1k3QVFQSlZR?=
 =?utf-8?B?UE5BYlpDMXlraDhiUkIvRWJSQ0V4K3lybGxvYW0wS2UxVmN5ODZlOGJ4Yk1W?=
 =?utf-8?B?bVJiL2F6K1VWSW9DN044czBOSDNsWnM2azd0dUZwR3hrU084ak9XRm1yekRl?=
 =?utf-8?B?V1BaWDJBZ0RRS3o5YWV4Vi9XUE1USmxyV3p5bFpWRUxpTWZ6OVVnZ1BsdlJE?=
 =?utf-8?B?SlpIYU9hZWdzMzNYNmsybGJSUnUrYy9zbHB6T3VEYXNZdWN6TDFoaGRzUlp6?=
 =?utf-8?B?UXVWZmsxK3JIeDFyTFJPbkpEenN1dzJ2Uzl1N3VGSWxhVGpkc3NkZEt3NlNZ?=
 =?utf-8?B?WWpWQUNqbGIyS1FjVng1YVYyYkFmSXk3Ym1TbjdQNXNBeTM3Rm85L041TGEx?=
 =?utf-8?B?Nk9lK2oxWFFsZWthZ2xZQ09abXdkYU8xKzU0VjZiR2tTb3VKMk5tZ0lHL25h?=
 =?utf-8?B?eHAvc1dxNTdjY2dzQ2ZWOHR4c1JYTUJWNFNyV0tNS0RxZGI0ZGVtNEptT3ZW?=
 =?utf-8?B?ci9jbFlsSDMwOVVTUUdKaWJEeGlOcDVSYjc0cEVXb2xhcitMRU4yYlV2bFZS?=
 =?utf-8?B?dTY1VjVzaTRkRno4QjdjUVNZdFlDOWlseXJkOHkzR1h6TEwvUmtvVVNkc3Jv?=
 =?utf-8?B?MFdJcndtMVg5citoUWVYc2JKekhncjJ5TWpnTWt5RTA5QTNtN0VlTXlVbE1G?=
 =?utf-8?B?b2cvOXBvVzJTY3BHUmFVRTRxdE5Yc1V4L2o0R1V4Q3N0QXpGbU9BQUJOaXJu?=
 =?utf-8?B?eUlmd29OU21NSklwd2xVQ2dxdGtrbHFSNkx4Sk1mZ3Y5MWZaUmZrRUJpdE5Z?=
 =?utf-8?B?VERZSEdMVXpPWkE1VkszL01vYXEzMXpvejcrbXc3V2NyaFBLVjl2cThhcFNV?=
 =?utf-8?B?RUFHd1Yyc3NORDJIZFpSaWZQOW5wVHB0YnFaRS80NzdyV3d1V1FHVlVyWEFv?=
 =?utf-8?B?cVFGQS82U3lpQkROclA3bGs5akxGVDZOUDF2RHZEOStuUTNKczloS0pFWGZZ?=
 =?utf-8?B?NDVWeXJuTDRaRlFrSWJVWXVpRk5TOUNsejZ5eGJ2TFpHWVdFOEsySGVRNi9O?=
 =?utf-8?B?T0JoLzFXNWdLNFJXUFRXT2JXdFJTS2VuTnlYNEhNT05Pczh6UWw4RlpIbHA1?=
 =?utf-8?B?aUhJaTBBbHRDMTUrT1c4UXB3aGt0NkN1akpPMnVuMzJzd2FFbEkzS3RsS3pn?=
 =?utf-8?B?aWJaWEhwb2d5ZmcvcFFmdXhJMWxORGlmcldEL1I4UmxlWmtPQWdhck9kS1Z5?=
 =?utf-8?B?cUNHVGplcHdsZVlpY0JCVjFqYTNsSnpwMldGSXkrcXM1Y25BL2xaVWI1ZkFE?=
 =?utf-8?B?ZmZhTGdIQkJqdjhRQktaY0lZTE01Q1VBd2l4S2RzSThheTljdFljcFY3anVu?=
 =?utf-8?B?Q2JRZS9PZGJMMEF0NlllbFp6WUNweTFhL0xEOFdxYkI2MDJ2V1JFUVlEdjVO?=
 =?utf-8?B?R291SStSUFlNQTlqTE11bUE5djBNd28xRnh0UERJMFd4di9lZlVLOEhuQ0I3?=
 =?utf-8?B?cHRWVE50Y0ROd2I4a0NDMWYyRFJjRlIyTHUxSmdweGhzaGVZUDUzdUNxK2xx?=
 =?utf-8?B?SVVKcHpEb3BXS2hUemlkb0xtRHhIaWhlVEFoSnVHRzdVUUxBNDNoazNBMUN3?=
 =?utf-8?B?V3JXR1kxVlJhYVZtSWRMMGtjRVc4c09wSTRnQjF6TWwvcHd2SW8xRldtWFA3?=
 =?utf-8?B?WU5kMXJTTHNTMytHdFdEa2NGMEJqd1ZVODF0anU2blY0VE1ScVRBK1FsbU04?=
 =?utf-8?B?YkZlNTlkd3pXQkdSbTIwWnFNZlQvcGI5dWo0dG5oSk1WNjBuTGNnbTBNK0pN?=
 =?utf-8?B?bDBrTkRDbjY5L0VlYnI3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUFSckxpNkxjMzZoQWQ4bEVDck01Sk5IbzJpMjBPcnpYcndiVTR6aTBnTEdw?=
 =?utf-8?B?Um0rN1pGcnZZaDA5elVPYWREU3BQZHRacDlHTTNXbld1QWdaUWtKcENhcTNE?=
 =?utf-8?B?Sm5leHJVZnhRTFAreFhCQVFXak1tb3Y3TXNjWGlyOXZ5SnVRRERkTWxpL3BL?=
 =?utf-8?B?ajhaZDlOeWVMa1c3YXdYeEo1bzkvNXFLQWRVNkozWFVKbkh6Nk1EMTZqUmRx?=
 =?utf-8?B?YkVVbWZLL3E2d2J4TnB6QjNiZnhXZUR6ZjlOQzRMNzJRd0ZkK0hyWFpLUUMz?=
 =?utf-8?B?bkl3bGNqQUpQM1BHc3pIU3FEMXZxQVQ3REJQVEFBRnR4UTNHUFVUSmQvckJt?=
 =?utf-8?B?NGpsTHZrZHlicDZDRDkvOFN2YTlPNEVKbStvYUhZYzNvVTN5S0lTYkErSVc5?=
 =?utf-8?B?U24zSVB0cENBUzJKL3dDTjUzTDI4cVhmVW9JUnlkRi9aTkEzRmZrR0RPNm5o?=
 =?utf-8?B?RGZrWG1aT2FaWGdET0NmMzNJOVZnSXdtQktDLytUUlJUL2x3QjMycmdqWEI4?=
 =?utf-8?B?U24yb3hpNEF0OVh5TytpRXU0ZlpTVEhCVzBEbjFXaFg0c1dnaDJkL0pxRDRX?=
 =?utf-8?B?ZUcyTVVIY3JMd1c3TDhaWjdLUWUxdlBLMEZiUk80Mk42UWdLQks5eEg1d2Nw?=
 =?utf-8?B?bXJ0QkQ0UTNPUENUenJCSy9KQ0tMRXpraFp4YW1RanU3YkhvOHpaeU9yV0My?=
 =?utf-8?B?eVdHZGg3bEtyNjBQT3JYZSt5TnlXYXozcmRjYitSRzMxSndwN1RSc2VPaEJM?=
 =?utf-8?B?cEZYbEtxVEdtYVk3S05xRFlUTDVCbjFBVCtWTW90NDVuVlByMG1nOHBGMXFJ?=
 =?utf-8?B?dDl2QWwxbHBwdWhsRk96RFQ1WmYvRzZxZUM0RWhvbW01eko4MFcxUDlPUTFx?=
 =?utf-8?B?UElzS3VTZ3ZVQ2xiNlFlQU9pOU4yT0FiSGZ6ak1FU2w0aG1GV01ZZzVCRHRE?=
 =?utf-8?B?RFd4RlNLRWo3Y2tVbWUzLzhkRWMwS1pHdjRPcFdYSVRmVjZ2YzB6VDdvTGRP?=
 =?utf-8?B?eUJVMG51SUJCdEJjL3ZINmM0SFRWc0NuY1l6cEtkZFFrQzdsbURxRUdsdi9t?=
 =?utf-8?B?VzQ2TEtXM1Q5eWppeVlSNzlnU2N0Qk1PcjhLaSttZjRxTGQzNUkxanhDbjhU?=
 =?utf-8?B?eUQzNWxGYTUyT2Z2ODZwcng2NTBKMU83Y1dyY1U3UGZNSC8yMFB3cCtaNmZu?=
 =?utf-8?B?RFAxTzcrdzlqOG9jSzZkK29leHRRMlNrckJDTmR0TG43UC96RTVSSUxrRG8w?=
 =?utf-8?B?QW9RMUJsQ3VsdHh4K3lNRTRzRWJ3QnNKREtFakJ4ZUNpaFBxakNYVHBhdXNv?=
 =?utf-8?B?b3RSZmRQeHJBeXBINlRmS3FTQ3hkTGl6MXluRnM5UCtxQU1YYXZnOU9PalI0?=
 =?utf-8?B?MW1mVktYa1U4blpiQVdsZUJrYXlERUovVnBrUE03Sm1WRHpUQ1RvNEZaR0pZ?=
 =?utf-8?B?SkNOKzFaZUZHeVNTSDVIa2NFeHpRNFJFbEMvakdTeWJOYThxaDdQVCtTS1JH?=
 =?utf-8?B?dkpwcnhMZDhaelNaUU1IblByNkMvOHRWYVNCM1NwT0Q0d1I0NmJxVTIwUytv?=
 =?utf-8?B?RmIwTXZwNzZ6c0pWVzZSKzBsc0NzUEdmL1lCSkRoYTlwc216TWxRdnBKc2J0?=
 =?utf-8?B?Vm53Y0w4WDV5MklXdWF2VDFMQVF2OWhVbkhDdlBVSGpXRXZNNFlRcENJb3VC?=
 =?utf-8?B?K0prY2N6NWhTV1NLNzlGRHRZc0puSTJBa2pMSzVLRm4wWms2RmtxSTRVK2ZY?=
 =?utf-8?B?TE1IalZQcnJrVzU0RkFRU3MzNWFmUEZqaElBQUErYjhhUjUyWHRFUVczMUZQ?=
 =?utf-8?B?WFAvemtONm1ZSlRESGlKdDJCSHhrVEJZRFdyOHV5d0NPUTFnUWdiQU15c2p3?=
 =?utf-8?B?TDFsNXZ6cmlWRXhOUnpnQ1YyalhSS3ZWRnp4WEZxMDlMZ1V0bWIwUFRxYXNv?=
 =?utf-8?B?d0sxNS9RL1FLOFQwQUZZRTdMQW1seE8xd292K3JxUjIyYmdWVE9XZWl2ZGdi?=
 =?utf-8?B?Q1Bkd2ZzREZ1eUFSN3c3NjlabUxTc09mTGNGdnA1VlJhbEdKeU9URlJiZnZK?=
 =?utf-8?B?QzVsM0VXbEZYMVZMTWNGRnViRFN3T043VjlrMmF4ZG95dDV2RTB5WHB5KzI3?=
 =?utf-8?Q?Xab7ziZntftpXXhIiQ9L+hsnc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005818d3-b31b-4d20-7ce5-08dcbd453b15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 16:13:42.2866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF5h/ncgofLG9QZpJAM8MQsH+mXxR6W5pqnRqVpGaifrcDGUcCsY7Q8FxFPOkfkOybDMAzFnZt77KbQ5Q1GMjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

On 8/13/2024 3:33 PM, Maciej Żenczykowski wrote:
> 
> In order to save power (battery), most network hardware
> designed for low power environments (ie. battery powered
> devices) supports varying types of hardware/firmware offload
> (filtering and/or generating replies) of incoming packets.
> 
> The goal being to prevent device wakeups caused by ingress 'spam'.
> 
> This is particularly true for wifi (especially phones/tablets),
> but isn't actually wifi specific.  It can also be implemented
> in wired nics (TV) or usb ethernet dongles.
> 
> For examples TVs require this to keep power consumption
> under (the EU mandated) 2 Watts while idle (display off),
> while still being discoverable on the network.
> 
> This may include things like: ARP/IPv6 ND, IGMP/MLD, ping, mdns,
> but various other possibilities are also possible,
> for example:
>    ethertype filtering (discarding non-IP ethertypes),
>    nat-t keepalive (discarding ingress, automating periodic egress),
>    tcp keepalive (generation/processing/filtering),
>    tethering (forwarding) offload
> 
> In many ways, in its goals, it is somewhat similar to the
> relatively standard destination mac filtering most wired nics
> have supported for ages: reduce the amount of traffic the host
> must handle.
> 
> While working on Android we've discovered that there is
> no device/driver agnostic way to disable these offloads.
> 
> This patch is an attempt to rectify this.
> 
> It does not add an API to configure these offloads, as usually
> this isn't needed as the driver will just fetch the required
> configuration information straight from the kernel.
> 
> What it does do is add a simple API to allow disabling (masking)
> them, either for debugging or for test purposes.

I can see how this would be useful for test/debug, but it seems to me it 
is only half of a solution.  Wouldn't there also be a need to re-enable 
the offloads without having to reboot/restart the gizmo being tested? 
Or even query the current status?

sln

> 
> Cc: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> Cc: Edward Cree <ecree.xilinx@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Yuyang Huang <yuyanghuang@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Maciej Żenczykowski <maze@google.com>
> ---
>   include/uapi/linux/ethtool.h | 15 +++++++++++++++
>   net/ethtool/common.c         |  1 +
>   net/ethtool/ioctl.c          |  5 +++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 4a0a6e703483..7b58860c3731 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -224,12 +224,27 @@ struct ethtool_value {
>   #define PFC_STORM_PREVENTION_AUTO      0xffff
>   #define PFC_STORM_PREVENTION_DISABLE   0
> 
> +/* For power/wakeup (*not* performance) related offloads */
> +enum tunable_fw_offload_disable {
> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_ALL,
> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_ARP,
> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_ND,
> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_PING,
> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_PING,
> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_IGMP,
> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_MLD,
> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_MDNS,
> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_MDNS,
> +       /* 55 bits remaining for future use */
> +};
> +
>   enum tunable_id {
>          ETHTOOL_ID_UNSPEC,
>          ETHTOOL_RX_COPYBREAK,
>          ETHTOOL_TX_COPYBREAK,
>          ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
>          ETHTOOL_TX_COPYBREAK_BUF_SIZE,
> +       ETHTOOL_FW_OFFLOAD_DISABLE, /* u64 bits numbered from LSB per tunable_fw_offload_disable */
>          /*
>           * Add your fresh new tunable attribute above and remember to update
>           * tunable_strings[] in net/ethtool/common.c
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 7257ae272296..8dc0c084fce5 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -91,6 +91,7 @@ tunable_strings[__ETHTOOL_TUNABLE_COUNT][ETH_GSTRING_LEN] = {
>          [ETHTOOL_TX_COPYBREAK]  = "tx-copybreak",
>          [ETHTOOL_PFC_PREVENTION_TOUT] = "pfc-prevention-tout",
>          [ETHTOOL_TX_COPYBREAK_BUF_SIZE] = "tx-copybreak-buf-size",
> +       [ETHTOOL_FW_OFFLOAD_DISABLE] = "fw-offload-disable",
>   };
> 
>   const char
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 18cf9fa32ae3..31318ded17a7 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -2733,6 +2733,11 @@ static int ethtool_get_module_eeprom(struct net_device *dev,
>   static int ethtool_tunable_valid(const struct ethtool_tunable *tuna)
>   {
>          switch (tuna->id) {
> +       case ETHTOOL_FW_OFFLOAD_DISABLE:
> +               if (tuna->len != sizeof(u64) ||
> +                   tuna->type_id != ETHTOOL_TUNABLE_U64)
> +                       return -EINVAL;
> +               break;
>          case ETHTOOL_RX_COPYBREAK:
>          case ETHTOOL_TX_COPYBREAK:
>          case ETHTOOL_TX_COPYBREAK_BUF_SIZE:
> --
> 2.46.0.76.ge559c4bf1a-goog
> 
> 

