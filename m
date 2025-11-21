Return-Path: <netdev+bounces-240719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBE4C787D6
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A7FFB2CD26
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDF933F8DA;
	Fri, 21 Nov 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BThbtxgb"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52130BB87
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763720605; cv=fail; b=epQU1VCvM7H0hQC2zVi1Xg7oLfNw27/ZE6a4D0pthIG4swzxRCtNe43WhlaWDHPaITSzAyKSdtEp72a6Pp2YEsGP0HGlfsP6B0EBWxqHara0ZhWBT1lwpcZ3bISni2IXKrbQUa6iQT+Wd/FHWtrje4aXFBcYa/MWDKnNKGCb7C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763720605; c=relaxed/simple;
	bh=B0xiVMQGy5ZWIfryHUbQp5tJdHLTUB/cqqphKUFowVg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SweJpofr+oWwdypGVH1j2bRzeifh2PfUXaIbvlihTtyWk+vTWqaTSgZp/zBVIFCuXQSB+YTskNqdPAaawjdqW1JfPTfUGmlKUAfkGtRtnmKhK23Sy1J9tqiQ3TMpuaLgTXj7+TiuZddkCfpNwvA3JbHc2w0ReuNOI6NilAUM9vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BThbtxgb; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq1zLvyXvmR0BJmOeTJmO9bvNzEOJhRwLGkWytiGGgNzuNrypnY+gL/XFqZIgY3AxSgmlQw8MxNCFlYbWUpsWYpeNV+H7rZuamYcpT9TTZh0ycGxHgDjfZUhryNH8+d2haYdgr/cXPBmgVkIgbsYPlb9puCXwhiYw3WxKluwM7Wu5ywYI3dr7TtlB0VSUZqZ6SvKUkMp6O0UatuHIrNJX9yZ6IuWTADlsO8opjeKO/Wsnv3QvqwkMnEKbOisycPGqFs9xrM0TgfSw3OUVt/PhSm5wIstLihRFJo6fUd3UVSnd84Ox+7q0MSZUVBMsVgcTZbx0czLQ6SSzWutedCMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPM7qXxuQGLiL0u8YruW2OnpgU426rRWLLbKHkR0bOY=;
 b=BjQS/vxbSKbeO8OoobaO0b+z/Ua7tON/1baLE6O4TkutZHhJWBGW/bmMV9wcdoFbjHZ7bpkQonrMkuIJ1LwEfJ4lGy1QVhzh/f7E0OgkntziOyqOP+MeUvKwuE4LsfJO0X7Urf4m3a2QTun+t8TmIMP35hWjBjBEk8cUooFzBw1TIJ5U3rUxowIX85dsU2rbE9nXYxBG/8B6hTaSAVSrNY6iYR23lwmqstPABW6t4WbP4EWvB3JZ1sRKVjjoZy2v9U8IgZ/R56QFS85lViFPAZw1Mh0MAyauf7FplUjYf0TB/Ua5Vk9/2CH/BM5bMcZwR/oL1rlnrEHULYard9PrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPM7qXxuQGLiL0u8YruW2OnpgU426rRWLLbKHkR0bOY=;
 b=BThbtxgbZC0yK/twwE4pbl7pLnXMRVY5xOe3YfBmZCMSaK+wSmh9K+HlHDoGF7sIKLYWUaOvsstLPxDSUKhI/NMI5qraiRlVJ9X5JPxPE/HKGxiSqV+Pkgq1bWyIdK2MqtjRxvwsbE5uX6Ef5oX/7MdlqE3BFgsNq7A1Q1LIeNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 10:23:19 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 10:23:18 +0000
Message-ID: <7dbcbe6c-d0fe-4321-b4ca-34b7b322823a@amd.com>
Date: Fri, 21 Nov 2025 15:52:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] amd-xgbe: let the MAC manage PHY PM
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251119093124.548566-1-Raju.Rangoju@amd.com>
 <0ca796b8-2add-4101-a3d5-cd7135662938@bootlin.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <0ca796b8-2add-4101-a3d5-cd7135662938@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 663d02af-9882-4fc1-dc1d-08de28e7fccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekJsK3ZXYnFqZk05T1B6VUhvcFlPSTE5a0IvWnVCUzhNbW5wTnBITGZmdENY?=
 =?utf-8?B?UWQ5bG9haDQzejNPZzhLV0g4MjFIVmhwbVRrSFJ1YUQ3Uzc3OFF6VVVRK3Qz?=
 =?utf-8?B?YkJ5cWxaMVlhZkMxWFl3NmNrNFlkaVFiaFZJQUNkWWdzM1BVYnNBY04xbEJx?=
 =?utf-8?B?dzUwa1NTNk5hRmxqNVo2NzF4Wk82RXNJQUpHUFQ1VlZ3R05aaXJxYS9YbXk1?=
 =?utf-8?B?T2hQNnAzQlR6cmh3d0d3L2g5aWpwbmJNMjMzalRpM092SkFod0ROd2prR3Y2?=
 =?utf-8?B?Vlk3M1BldDlHa1J0QXFnbVl5c1Nvc0VKUzlpWkxZVXlJQnpjK2MvclVRb3k3?=
 =?utf-8?B?NHNBdHdjdVRQOEZ0OWJVc1RTZUQvNDdnZFFnbDl6c3FHYUdtNlNiOGF2NXdV?=
 =?utf-8?B?MnNaUlU3MzQ2WU9TclF0dlkrYU1IYXZFeU5YTUdQcmlLRG4zVHd0ZWtoWExH?=
 =?utf-8?B?QmNxbmlzNUU0WFZTKzgxWE5UNEFOSkkyQ3kzclQzbTg3bnZvRkZGUGc4R2N1?=
 =?utf-8?B?Qmc1b3dNVk9PS0I1bmoyUW1HaWdoeEhFc3VrblcrVnRPbjNsMlRFZjFUSDdk?=
 =?utf-8?B?YXpvcEVGYmNGemJqb2ZQY2ErdWt4QlBIYjYvM3lrZi9qN2hmQXVDbE1FcUxa?=
 =?utf-8?B?QWdnSTBwWWlvcE9seVEvVzJnc005c2FBK3dUTUx1Q2ZKNXJuMElEMjZHVmdh?=
 =?utf-8?B?cy82bElkVHZ0WDY4Z0dnTTQweFFFT0VtMUd2cWJveE0wTTRtM2FuNVdxeWZt?=
 =?utf-8?B?S25pcFdBTlBMMVZ5dHlLY1ZSVUF5ZUZITjJRTFhqUE1ubFJmNDIvcHlFM3JQ?=
 =?utf-8?B?cm9EZ0JmK1RKeThUSG5mQWNXOW5NN2g0Sjc5VW83bU9mcnJFMjlHOE5XdTd5?=
 =?utf-8?B?TmVwaFExNHlPVzQ5S3IzUkZlUlF2R3dBUGJuTzFtOFhYK0NvdGs4NHhCajBI?=
 =?utf-8?B?N3RCK0ZLVTVRaVljc01ueE5KK1NUSEtkUy9OMGJjY1JxaVN1YnYzQlQyc2lN?=
 =?utf-8?B?RFNFaHFDMXNYL3FQNEpmNm1mUGl1YWNtZU1lMjVPcTlpNXR6ZCt2bzIvcnNL?=
 =?utf-8?B?UHZMT0FDamxIVmZIbndrNmZ3YjVxbWNqNGlDSjdxOU9YeTF0L1gwSW5jZW02?=
 =?utf-8?B?dG1rY2dDUStWamtGTzQxd3dCdWs2YzIrODFrMk5BVW5qYTBwZUtMWEp6OEtZ?=
 =?utf-8?B?MXNJdVZEK3VBdFdvUjR3NnU2c25JUDBnT3o3czVwZkd6eDd6eURaeEFpT3d6?=
 =?utf-8?B?Ui91R0gwNkNZcXBkWDdoL1RnckFRaGZ2MUx3L0pzdU5PZ0FsU2dHWmtVRmE5?=
 =?utf-8?B?RUhRWEd3UTZNVSsvcmFFL1Rrd00rVmVMS0tWVXB1b2hHSmNCbk5COVM2R0hQ?=
 =?utf-8?B?Z1Q4UVpxbkpXRE9QeVdVN2NhcjZhU0NUZEx5VlV2QWNrUkgvVmI3WVhOVDI1?=
 =?utf-8?B?QlRPTTc5Y2t6US92YmZkU1FzTS9zQkJ3dTBhL1ZPaWkzOUxWSzliSDJ0Nkwz?=
 =?utf-8?B?VUZSUXJDY0ZqaGVhcVUxQmRubEpHdXQxQ2ppemdHVkZSb1Y3MU9QVVQ1NUVJ?=
 =?utf-8?B?aStrcEFVTHFtQjNJczI1SUV0TDRaV1ljTkFJcGpMRi9WVFF1SThGaGZpUWNT?=
 =?utf-8?B?SExuVEwwckYraDA0TElZMTV3UFhlUHIraU1nb0pGMnpQS3dNVkRPaGtHRU1T?=
 =?utf-8?B?Tk94NFdkWUFqYTV6OXc3OEluQ1ZRbTBGZ0twdkZGdkdqOVZ1bzBwNTc4bzJK?=
 =?utf-8?B?bWdNcFNvbzhIcVZiSVJJTmlhU1p4NThWeTVNeU1MeHdMcCtheHVEWG9pS1U3?=
 =?utf-8?B?U2lBVDZlTHpGTDFWVDZ6L2FYcWFjSkNGaCtLU2hwWVVJMEN4b1RaUE0vL1d5?=
 =?utf-8?B?Yjl2S3ByWEl6RCttcHVVckpoZ0ZkdmxHbnV6eDYwV0xCQ0NRa1VZYzhDU1Nq?=
 =?utf-8?Q?LGealutdKPQwVuqy9yLf7RegGzud+C5I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHU1UXJoTUZwL3hhbEdJY2xoWElxL2lMWGhsSExoRWFwMklLNVdzVTBEY3do?=
 =?utf-8?B?czB4dVlLblBLZVE4MkQwcG9SVmc3M0puQjdEeDNGb1cvK1luMnVhN1RLSWk4?=
 =?utf-8?B?NnhkNXRTTzNCaXlQa2lUQm00YU1wa2Q3dzRiejF5SUxGdEJrU255V1MvM09M?=
 =?utf-8?B?MDNpQ0NzMnE0dERmdlJ3dnFvcnlUaVdiYnlnYmdXTTFtekhoL3d3RzIzVGIr?=
 =?utf-8?B?UFFFVG1rekxYOWxLL3VrVFloWWorRWcrM0JTNmg1ckdtNm54bTFnaTdlUEdh?=
 =?utf-8?B?QVJQL0Z0N25wVndVMjY3UmhDdXRTc3R4MzZtUFg4QVpxVktVYzR1TVpNdHp5?=
 =?utf-8?B?a09WeDEyYitad2d0aFN6RjJEU1ltQ0ZXSHZ1Z1dxYVNLYU9rUjlvVlhKNlJr?=
 =?utf-8?B?ek52WEdzaGlrdFc5blZlRU9ndm1hdGhudTU5aEJLRnhuVDByVDg3RkIwckc2?=
 =?utf-8?B?ZXkydG5LWFkzL2tPK291ZXF5YXUyN3duYXNSdTU3dzUrUG9IZUlIb0xFTFp1?=
 =?utf-8?B?SEFKdnlOQjVua2s1YWZoaDNnR3kvNlp3OXJmcHRYVWx6bUJHbzEwaXgwREpr?=
 =?utf-8?B?M25ldUI3NVQvTTc4ZVo2bUlmRUt5aThxSVZsTmE3V0ZVOG9EcWlGcmlHdEkx?=
 =?utf-8?B?S2Y5K0F4bEpnSmlpWWloaFloMFFFbXArVXdiTFJQL2h2NkN0SHVHcFE3VW0r?=
 =?utf-8?B?c3hMVTU1Y01CalhVOHIzTnc5Z29tZHZ4VWlDQnFpUmtXS2g4L0RvYkkxM1Iw?=
 =?utf-8?B?WFpSaW50WHVEMWVDRC8vNXVLQ0J4eUE5d29jcUU2NENJZUkrMW1rTSs4UEl1?=
 =?utf-8?B?MjVXRXdhWHpkNkN3bUxEYkp0STN1VkR6RllUSkZhQi9JTEI4VlpaM0prWVMx?=
 =?utf-8?B?T09HSndOWDJtdnQ4R0FVSDV1aUJDVnpyeWlhWVB2SlRIdFErQ0lLcStETEJp?=
 =?utf-8?B?QlorbU9kd0VyOHc1VmFVNG5HaGErNkcrWSs2YlB1cHE5YXIyNVJhRVVyREtu?=
 =?utf-8?B?U1JPcW9oK0xaMWJreG1KcXNyNkJkZ0ZDaXV2dUdYSXBkby9IemFKUS8wS24y?=
 =?utf-8?B?YUxleFZNQ0lKaGdMM0Ficm5pMExIdHN0VlpSUks4NzE4THg5RmhlelYrT05R?=
 =?utf-8?B?YVFGZ1RCdi9MTWhXT3NOOGZYNDRyamN3d2NtQnBDSkR0SXF6TDhaTUxFbys0?=
 =?utf-8?B?NlVYVGtBZkFBYlZaQTNYNWI0RDc0cDhjOHUrTEdHZXNpcjJob0NTREZqaXBY?=
 =?utf-8?B?UXVYSU91MXpuUzRMbFdDUndzTzJhUjlRV242M3VLNVhGTEQxRlRRN2V6eGJC?=
 =?utf-8?B?ZkhNL1d1SEN4M3pLUldYaEF0Q3pUM1ZPU1ZRUWZLK2JhR0gxd3crcGM5Y3c2?=
 =?utf-8?B?WGZTVllxL2hoRkE1dkhFeEFSQlJjVCtHUmtibnBVL2ZIblBXOS92bDBJRTF6?=
 =?utf-8?B?Zmlwa3ZmaUN6OEQwdUJsbVVSVnlJb0dwODRzYlh1UEtxSTdod3NyQTRLY201?=
 =?utf-8?B?TmJuVlJFR29GZVlZUFJtWW9WWWJQd2o2N2lpVE5EdithWWdHYXhTamRTdjlL?=
 =?utf-8?B?clI0SmNiVWVxNXlMdC9LeE9NM2YwL0RrWVZzVmx0TU9VUmowQmlpN2taaVBq?=
 =?utf-8?B?SncvYlNZM09sQy9MSVMySmxQVC90enp5K0tNOVJXbDA0K2R3YUVKUUtRbGRO?=
 =?utf-8?B?QVcvV0NLQmtCNEtyTGVCNHJpR3M1M2UzdkYvT1BRN2VzQ1ZTZHh0cExhYi9I?=
 =?utf-8?B?ck9hVTNGWXFCQ1JWQkxSaUJveXNUQXQxSTl6U2ZJeERmNjJuRGRrS3dtT1pJ?=
 =?utf-8?B?M081RjRrUzdXclhZeFN6K0NUNEdxSjhjelR0anlsRWxVYkxFeFRuU09IazRL?=
 =?utf-8?B?eEVWdWNmamFZV0JYWkh2RHVCcFQxdmJUWFRFUUZhRFFMYkVwaFl0SC9oSnIr?=
 =?utf-8?B?Q0F2V0dVNkEvS2NkK1BTYlcrbVR5SXlMYmFaSGl5c3VyM2cxWlh6dkZkVkFw?=
 =?utf-8?B?SzlvWFdCRFFLbSsrcHpIZkYwcEk1bGFrZzZsUkZreFhOYWl3OVlnOTREUUFE?=
 =?utf-8?B?K2VXaDlBcTE4ODZtTnhqMUtBSU9CY3A4MzJlZm5oV01ROVlDdWNWYWZlTkFF?=
 =?utf-8?Q?mQs4CmgAmqFijKnq06Bg36YLT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663d02af-9882-4fc1-dc1d-08de28e7fccf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 10:23:18.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyRTbSMLcg4hzE8iPM4x0UhZYFEOpwfeQjU2pFodMG8+ev7qZNbNy4u038ywItxf8TZNUhmIBiGaqLIQXWNbNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516



On 11/19/2025 9:27 PM, Maxime Chevallier wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Hi Raju,
> 
> On 19/11/2025 10:31, Raju Rangoju wrote:
>> Use the MAC managed PM flag to indicate that MAC driver takes care of
>> suspending/resuming the PHY, and reset it when the device is brought up.
>>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 3 +++
>>   drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
>> index f3adf29b222b..1c03fb138ce6 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
>> @@ -1266,6 +1266,9 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
>>
>>        clear_bit(XGBE_STOPPED, &pdata->dev_state);
>>
>> +     /* Reset the phy settings */
>> +     xgbe_phy_reset(pdata);
>> +
> 
> At a first glance, this looks like 2 different things, so maybe 2
> different patches ?
> 

Hi Maxime,

Patch is setting MAC managed PM flag and moving the reset to appropriate 
place. Do you see a need for separate patch for this?

> That said, with this change does it still make sense to call
> xgbe_phy_reset() in xgbe_open() ?

No, calling it in xgbe_open() isn't needed.

> 
> With this patch we have :
> 
> xgpe_open() {
> 
>    xgbe_phy_reset();
> 
>    xgbe_start() {
>      xgbe_phy_reset(); /* again */
>    }
> }
> 
> Can you remove the first call in .ndo_open ?

sure, I'll take of this in V2.

> 
> Maxime
> 


