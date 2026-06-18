Return-Path: <netdev+bounces-300455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sp2XOSz5M2rqJwYAu9opvQ
	(envelope-from <netdev+bounces-300455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:57:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8B26A0BE6
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:56:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=ZrdX6Buj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300455-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300455-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8EC6300D743
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17933EB106;
	Thu, 18 Jun 2026 13:56:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC803BB670;
	Thu, 18 Jun 2026 13:56:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791017; cv=fail; b=Y/xxSmngNvBjJiqDQ7go3XLHEl5WpAH6yV3O2T0qRlhDnQQocg0BHmmwaHruwkOIYAtt8QWH92haBjW1NegPFKMokKOS6iMu0KKWYLA2k3WiF/2oi2fxTIkjdienLEbplCPV1O65KGKQTpPf14k/nF8128iVvDhmDxtOg8vDXl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791017; c=relaxed/simple;
	bh=vyz9idvwwDKYgbGT1XamsaQKVYAV9318JmQmBJql7Jg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f5pHsT1LbpIP/UG8xAGzQhETwVuaw06LoDXfaMRpPmedPREs0W6oeGl150ExOCcnNkOTSgDKtAJXCFpF7c2OCdI+eJ6sbp2gWyAnJKr1fEY+NCSJgvOyUJ0ogaS2B0ntjg8zOz+wqcZQYtUAyP8mT/OGygkcxHb4OeJ9BdUJLZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ZrdX6Buj; arc=fail smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ICq4VD022674;
	Thu, 18 Jun 2026 13:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=88FOVkk3acMkQWxMULZIjJSxmuslMgh50zNetlbjrrQ=; b=
	ZrdX6Buj6W6giRZKiQADxkfawzrg4rgijUmXO5Y4Lt1WfmCQjivc5UPG/7nQMjf9
	Hq760iQrD8Ru6qrm2EttUFdKYjK0o2jYtqVB1kpF5oZphDc6toJ89EVm2vLO/1SK
	Vw91zTNP0095RL5BRQ0Or5C4WJ7lAj/NNoC00x9IyeC68nNKoj3F5TVRx0fwRsdY
	bzX5pov3+ADKAVEJgfsgWbwDXeogLDs0C+9CRlwWggx1AMqr83K54qd7PYmyrlQ7
	XWHEi48jGxltkL4lrlD45xmr5unfVav1xtxWXgqT/Q56GU5WL66LwRRIuD5QAZ/c
	L5Yf5GpBEMTJDCzPyaY33w==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefc2mvs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 13:56:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qofcmsx1hzoc78dFitrAwE4bNG6LTXL4Wxbnh3KBQWGxgoHBzpxUt3+M5nrXndD7fK+6jhoIot2DapiC22iGvCi/NsWGHAePmyspI1tuJ+I1m/jx/fYh5BtU1P0PHa6SOk1T2fU6vO0osMH74W6kcLCShFL3zybTz543uiW9DZbaGa9wmX4Di8nLQuJ8pXWThvyTmqqmZ5Q+WCYiJ46tdgn5i+XT0UtP+yHyfnzjLtFwRIF9yiUO1WJ5eTNZmXvPIw/etBgbEPtNx3C4xPm4G/xBJPOTTnfoAlr+MfEE/xD8Lvh7Cw0+E7q8eJqElPluj/Vhi0laKJQcVhgKna1jzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88FOVkk3acMkQWxMULZIjJSxmuslMgh50zNetlbjrrQ=;
 b=RuwowFMCGQ/AzvQAh8JZ+jTKDm83jTScIdovOpxCK2w82rdZ+glCy2bjrn6wkyVw9S8BfuODSnyct8Ok+ffi3qUQDQSz+3MYBkdJU09S5wkhRaiKYGFO4LMmJ3wRL0oh/r+XX6PFIRXnoPliqF/JnSIkRdoRRLWd9CsS6Zz5mybtRuiZNcLS4YR6eBUVUNLaA2FtgiK/Vc9hz5t5NzNzujEiebrfo6ryBVtka2/nBqD+r7ZnI4RWtGdVpKUodxdVtJ6PUW4cyr4O6EJ4S9iavHgcvipkZ/ZPxE3AVztJZC977vol2INTbzLB7EJkMkhyrOD+yyFeGY3qg0Q68Q70nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 13:56:24 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 13:56:23 +0000
Message-ID: <06d0158e-bf4c-4ad1-8ad3-c8176003ab11@windriver.com>
Date: Thu, 18 Jun 2026 21:56:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: mvneta: re-enable percpu interrupt on resume
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yun.zhou@windriver.com
References: <20260618104351.3456161-1-yun.zhou@windriver.com>
 <20260618125128.h5g-StPH@linutronix.de>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260618125128.h5g-StPH@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0087.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::6) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|IA1PR11MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad98fb1-a415-47a6-54da-08decd416228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|22082099003|18002099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FtaWE2ZYyI3eXHuzbfrenNMZsxEnsAtlsBOaTToWO19kGpTs3kX5QUCG9Vh/VnBJX3ZY6UTNliKEQN9ApgB3Q2VFpmVu+LS7jKp5+tfDugXlqKBQCMKK5/xvbWK5S85cMR2Dwlx1P6BEd2RJPIK4r2ZHm3hmvoKKkXm7BvGzPapLcdnegbX2FWqORm3JydHdU/1ARdbH2Lv9kxK4V6BGYc6kl336xYmBOhd1SdmTVVCAkGxtQsvPE9aUAtnXfuCCZWeY4v+XDhFCtx3kRDHVhIhI9Hb2oZLpZIJsmW5bBV+cHpKf4eFFG89aByfC1oUcmAM316oNwnBDFzZvZTX03VhSkhgSWsDwi5uEtHQoOFIbmZ8OsrRmg3NWphn2vHa9lgcFY/ZdLt93YJb0xTQNHxQkhivfzR9kEhm42A9M191atrfGSQSUqvMhDpmVAar1mm2qM2mxZTe/+a4GTF1xVyOpUexPw7RLnM+7XXAwT3/Y+WdZQSHRTzBVzMr51L3xAWa3jjcXvyJGSaPk6c1pTK+JVhnvJ7GZ5orZ0rf3U2QIQ4UPHjx9h3hIUNglrLzgpOqqwLIBFFKmdBkhldkzoMpbDqdTX6jyytbPc7VIURTpuznQNfVd0BYKsNr5xOamvCIhojmB4E3db4e6zAenk9PNlFaMuOp5FHdLJJey3f+yjtVbirkeMdIPVOK60Gq5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1NwMHRucDU4SU9pNllEOFpVVFY3K2FqZ1QvRmVLaFhCa1ZHbXNGekUvRFdh?=
 =?utf-8?B?YXBhUTNHMHFPU0p5OFRZbElRWUNBaWdnV282STI2aEF6U3dCK1hjZHE2cDVJ?=
 =?utf-8?B?TUhHTW9pTW5uWHFMc25LZitIclZjNWRPOGpuSEZCdkRSSjFEK0lRUkFqd2dD?=
 =?utf-8?B?SGlUdjVqYktDT0M4cGFmRGE2UmowQ29uM215SXVUTGNEaWc2ajdJamM2aTFl?=
 =?utf-8?B?cDY1SjBCTFlzb0s5cEtoZUI5YzhFS2FUc1lWMWZ0RWlwQkVPWEdTUldnKzlV?=
 =?utf-8?B?K0QydTZkUWtrWGhuUDhVdjhFZjV3b3NWc0l2R2R3Q25kRFRWMVhUVkNoOGEr?=
 =?utf-8?B?bzBoYkkvUTlJR1prRTQ3T295VDU5QzBkVVBheG03V1R4cVR2WTd2RVdRWlB4?=
 =?utf-8?B?WEd6bExUekVtaDQzclRkT3l4cmd2UTJGSVZad0kwOU9lUmtFeFFzaW9PM1Z2?=
 =?utf-8?B?VUwwMWRlNnd0djZIcmtLeXJYWFJNdDVOdzRSdHVSN3pvempyTnRSS25JN2wr?=
 =?utf-8?B?NHJXUmxPQnp5UmVnZ0k1SGtES0M0Q3RjZk1jZHBuNGQ4QXpNcndXZ04rQ1pT?=
 =?utf-8?B?bDVwZ1NUSTRKK01QUkJyQ0xZMTdGdVptMVM4VUJTS2FKOVZUR1YyTWVCNmky?=
 =?utf-8?B?RURCU0dYNTU2aG53OEJENHZ2d0tUUW5teGg1UWttUlpvaVg3NTlWV0lFRjZR?=
 =?utf-8?B?ajl5VkpGekxiUi9zRjhjR2IrYjdMWkluM3RwSGdrVWs2UjMrb09SYmx4ZVly?=
 =?utf-8?B?RXhYdFFkeFpROGRIRDVhNTcwWm1hUTJLZWIwcFZTcFlOaFR5T3ZWQjZNRnlX?=
 =?utf-8?B?eEtzeVVzS3FENllMVDNKTFFuR1MwS2RQZzN5eThOQVFLYjlKaDBSckZBRkNr?=
 =?utf-8?B?WGo3SktteUlxbnpiZ2lPSXBJQ0NhMTE4TURwQmRrMkdsWUlvQzMzNW9JVE03?=
 =?utf-8?B?M0FSN1ZEcmVJZUN4NFc5WUZDWDNGTzk3Y1VVQ0ZMRUlaNUVzYzdOa1FvRk9z?=
 =?utf-8?B?eXdkbnBkSUVrWHNab2VybFNsbVlYbjBGOWQwOFIwRCtYSGJkeGU5dS8yYlc4?=
 =?utf-8?B?dWtyUUxwVXIydGxqZGRKSkhsa0Y2RkJwRWlsUXAxT0R4Y0ozTURpSHRLbm9H?=
 =?utf-8?B?ZHM0b3VMSDY5Z0VDSVFCa3N6VUNFSjRVQWU0WElldE9NSksvazZ6MlpybEpz?=
 =?utf-8?B?eDhvdC92UEszQ1Q4NXNEVUxtM0Z3WEtHa1hBZkFZVlkyTzJSR3QrUTUzaHFB?=
 =?utf-8?B?QUVDUXNnRGpGRzNvOWtpZzVwOVRnMFpkM05TYThUYndzbU1TTzhOeEs3UmFT?=
 =?utf-8?B?b3dKNkFoN3lUOVhsSStpL2U1NmlzdXdYUHY0L3N1SklFMkpzeTdyNi9SczNz?=
 =?utf-8?B?UkdSaG5Sdk13elN0WmVsdjVRcC8vYmp4RU4wRGtLcG1wcWtXRGlZOGttU0Z3?=
 =?utf-8?B?Q0tDeERFbThUeEJlcDBCQTA5aDNhOHRMNlVYMWNyOUw5K1R2ZCtjU1YwOWRl?=
 =?utf-8?B?aTRWSEhWVjJQS2tpNWhqYkIxQUEyWVZiVG53Sk5aV1Mvby9ydUFTWi94MGJh?=
 =?utf-8?B?Y2pXVm0yRHJKOWNHZGF6WjI1VUc5M2E1NVNXVXZCTmYvQTZHR1JrMEJKWGxX?=
 =?utf-8?B?bXUwVUZwZWU0cUNhWVBDODVUbGcyMFd1ZG1ONFdCNENxOVFSeUlhRC9IcXlk?=
 =?utf-8?B?RnJ6bldkcVNjYVJIWkpSdXg1bWRwdlA4V1lZVEZyRHN2TFZsbzdkWHFJSFIy?=
 =?utf-8?B?OGVtLzJUNkkzYnJKSXFRMFBGNzhtWlcxNUcyNWVWcjg1cGNYSEc0Q3hiNzkx?=
 =?utf-8?B?cSsrcjZMdFM2ZGZ3SzNrbGdIcndUbXVTRlNCbDJkQmgrZS9TNzhxN3VVbU5P?=
 =?utf-8?B?RVBUMmZ3RGJHZmdLUDl4dFg0dm55MnhrdFBQVXFJd2JFUWtBcnZrcjVFZ3pm?=
 =?utf-8?B?cnNtcEJiY21va2hMRmIxVWVtMVRaekNaUE5wbG5iSmZiVHl2bGhLVXF5ZTFl?=
 =?utf-8?B?QmZDdGJJZG02d2lUU3crSGpndGVtS2MraGJ6dUp6QTU5ZGorMEZxdEJPUXcw?=
 =?utf-8?B?bXpHY21PbHExTG1Sb1JsdVBScm5EQjFtRzR6V2IxekN0Nzg4RXJDdWFFVk5p?=
 =?utf-8?B?SUNZNW1NdlEvMlVHNU9GbGhYSVVmK21SK1FTbWI3SlZxbnFhcUUwTE9WWXF0?=
 =?utf-8?B?eHZqRWlGekpMd0NVanRJd1hqUXpFaWtCL3RFRCtFbUVtZUlRQ3kxcVhDRzFY?=
 =?utf-8?B?TGEweGJqcFVxUndsclRvQ2liMERzb0IvQWtaWGo2SGYrMWxIL2ZPSjJwRG5i?=
 =?utf-8?B?b2ZheWQybWd6R0l5dnVWczN2akZ4M1hRd2ZuUldtbDFYU09iOU9mUT09?=
X-Exchange-RoutingPolicyChecked:
	qtvyDpwQJO3bsKAj3b3sW9iSp4JUk0aeZKGFlWCnhsejAZpUU/9m+7oCPtlZ3dO2MerVcUVu8FRz+5V1nCDVkSBhR15ugTTcBo+YcfSfgWtnUfMO5jbCJeSj/gXVyJnQhfEbSiCQrASoEyN6NwJuALHtSoQ78YhK5H1x80Rc0oJvxkQPbfz6ddfLEYYABwXApFnLK8p/zyxqGzyuiWEnx8hNT3KRtTV7xruopV8/LYQWDEUUxSCatVPPHlsU5lXoXPeRx0yn1s8ZEzHh0a6zmNQBYYLVwBH+ICRKHf0QfCuKb8PiHgkBFOoI0WU33dTJteB2whoCF578FSu9QjH0pA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad98fb1-a415-47a6-54da-08decd416228
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 13:56:23.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNlNYNzxvR7yukJBtZh3qpaxt0TyHFLnejViGc4gc6V9Jx+tT9HaRIC/SGvcS9O8Jm8oBgWNI/Jl33Pd8IGoeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEyOSBTYWx0ZWRfX0ij7L/A0ASPI
 +2DkbWSxOf0gJMqzXgUZHD8PpY686fRCj0YJdZ8RnNbU79V8ipux2s25K1Ez/LVYsCR4Bkgmxtf
 rH25NIjtyzkD1AeNCAFqW8/xsn5nHPa0fd1eDnVA9QBXWjg4cj2W
X-Proofpoint-GUID: tEcQRsQ5rzu4UnKBdv76KGwFInmS6GPg
X-Proofpoint-ORIG-GUID: tEcQRsQ5rzu4UnKBdv76KGwFInmS6GPg
X-Authority-Analysis: v=2.4 cv=ObGoyBTY c=1 sm=1 tr=0 ts=6a33f90d cx=c_pps
 a=7U6MwrGrMRcsJNK5547h+w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=oCmqI4EN6IL28PJB028A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEyOSBTYWx0ZWRfX63MLuuPOX1mF
 ovkt3GF49mShPuUiyDgJ6483Qs9X21AUuefc5GwyCAC62Jv/HAFaITgcsaG3gF9pDunywdqCD2u
 QJd3UeG7d54Oby+LxaFqBzV3BSyRLnCMxe1baDyinJDCazcsnrBvXWKAhdrTTcNLjMqi22ZUVx4
 dkN9SHFoZUmj4DWr9g0X19jLMrPeqXHjq/jsyXWvoIDLiaDHnEWYoLDwJ1BDVkcyvJLeiqqKLbv
 czOdTqObj+YbjdewpXWzbVJroaQE7dwMUWuCnkaRzxTmPBbnh8dX9Na9FLTVcUFZuXI4u1POn8N
 FqXEp3jzp174XGg6gm8tYptcQ9hM6ccjekXg08PWkCKtudPqu7OFitAtzMT2TPIvt5L8KH9oU9J
 wCfbYWqppXldUEfEq1Le7mlD4UqE4RsiZBmubemvWpA6SMUqxknN/5gBghncr05eZJUKk4bhixa
 I2bPNfKf92Ulc7iTaQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180129
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300455-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yun.zhou@windriver.com,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org,windriver.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:mid,windriver.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D8B26A0BE6


On 6/18/2026 8:51 PM, Sebastian Andrzej Siewior wrote:
> 
> On 2026-06-18 18:43:51 [+0800], Yun Zhou wrote:
>> --- a/drivers/net/ethernet/marvell/mvneta.c
>> +++ b/drivers/net/ethernet/marvell/mvneta.c
>> @@ -5907,6 +5907,9 @@ static int mvneta_resume(struct device *device)
>>        rtnl_unlock();
>>        mvneta_set_rx_mode(dev);
>>
>> +     if (!pp->neta_armada3700)
>> +             on_each_cpu(mvneta_percpu_enable, pp, true);
>> +
>>        return 0;
>>   }
>>   #endif
> 
> This does not look symmetrical. I wouldn't mind if mvneta_suspend()
> would have the matching disable but this isn't the case.
> But if the thread is idle then you have one enable too many, don't you?
> Well you have the NAPI callback which does disable on the local CPU and
> this resume which enables it on every CPU. So this does not look right.
> 

The enable in resume is intentionally unconditional and idempotent
(writing MPIC_INT_CLEAR_MASK on an already unmasked IRQ is a no-op).

> The interesting question is what happens to the enable_percpu_irq() from
> the mvneta_poll(). Is it lost? And if so, how/ why?
> 

The enable_percpu_irq() from mvneta_poll is not "lost" — it never
gets a chance to execute. The sequence is:

1. mvneta_percpu_isr: disable_percpu_irq() + napi_schedule()
2. PM freezes kthreads (on PREEMPT_RT, softirq runs in kthread)
3. NAPI poll cannot run → enable_percpu_irq() is never called
4. mvneta_stop_dev → napi_disable(): cancels the scheduled poll
     but does NOT execute the completion path (no enable_percpu_irq)
5. Resume → napi_enable(): resets NAPI state but MPIC stays masked

The unconditional enable in resume covers this case. When NAPI was
idle at suspend time, the extra enable is harmless.

BR,
Yun


