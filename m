Return-Path: <netdev+bounces-190948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B850FAB9691
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418F916A924
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 07:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E46E224223;
	Fri, 16 May 2025 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="v4Y+gQUv"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022113.outbound.protection.outlook.com [52.101.126.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9402C9A;
	Fri, 16 May 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747380662; cv=fail; b=u9tYaIfNG2AETzRpuacgGLjImgDqzNhNm9C+Xmu+ivXkelaoE/T6zFvwfL3ZiTKYIDy82FQkzfHYYng8UqVT/9cLGGprjNjZqtnUlfzJo06Qv40n6c6toGbtm9OHLdQTA735Y9vzzztJXhtXU3+RVlZx7elJ5CB07GP2aztNI3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747380662; c=relaxed/simple;
	bh=Ptc8EzBRSluU0Pjj49UvdaaQ2cVaMLRwJpn7NuXWqqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XpWcYHWRdYKgVXskpHRMyn2jSycUk/BhlIoreOQNLNLI1DrDkN9F6iXCOuxhV2pI3m7XTFROKGI8PxiufRkGL7UUunpD/RuLl8ma78lfH2oZ5kFiA9GisGo07oIjieY4n/HVmu4nEU1SawxNMts4RP7doPWpjgcOawC9y5N4fkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=v4Y+gQUv; arc=fail smtp.client-ip=52.101.126.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spkrQPyBMRqS8Vl+5V9RWQxNOmHt8jumLWW4oGPagvmRCm1jTEZAkAUS4XSqGSu2OsN8y+gPEsAdj/YIWcoW0P99DIIjOJdXvjcFEroYhr3/fvY9z36jJ7Zh51vInoffTRTLYQN7CpHcLZ1I2oqqxnE0Sb6FdrDhjRgkHB5ftrkjh0gzYssJ7f+73va7Pa5Ag2EKyjYY/N1cAV1+BT/NGLCmtol364g74+n/HM/X6O8R99j1cS7loXaTj3gI7Enej/isCbwVMWrn+VoL6lYkY8T+HppsKHKgQ8FJdfp4zfV9kkKtclbGGo37h3L19ZYipb2JHmnrPWXBV2TAuPUxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH04AcPUq/K8MnElCpiV9Bq9ATRB6A3kg08SBjFjQ04=;
 b=tp0+TbVxwXzctVvqiFcvBoNz256p6ZjSE9Rnug4TGoSwHjr03hIjNEoHhYeQPXog2CeN5ZlfLIiHE87spI4FU6rOYO+/30hxm6z4Mr58Vplb8U33ao70X88aBYscwN6+lV7uQJHbidW1pzh8uUAZVeTDGBce/GO2KjmW/R2pa9Tjf/rRhRKY1EP5a7fdE7LVQj4AdzdrgQgESb945MbH0sxVsFw/y6JyS08Ire/Tsp2FLqELJ6KC0RXNjc4O2dO2hDnlyqqr21ZL4azqOyk0m0PNcrtHMPFrBEAMNbIJM1YJggK6L1d+CeOT04N0/78rAFoyaBc3O2FF+O3SyMmZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH04AcPUq/K8MnElCpiV9Bq9ATRB6A3kg08SBjFjQ04=;
 b=v4Y+gQUvv4oQMKvQGusaTBlOCIyOVRKnyQl+BJP3m2ev1jJ5pO9GcL+XCyU9l42MF1Mn5dsV4rv3xXSJFG7fN8JRTA4inQBxoWROjBN1BlwZpNCRmcw8R8tkxNVOdckUkarvPh+xuxKV4NFn15teM7HN/a0ylrtCrWeYXTD0cMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEZPR02MB6177.apcprd02.prod.outlook.com (2603:1096:101:a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 07:30:52 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 07:30:52 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	helgaas@kernel.org,
	horms@kernel.org,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com
Subject: Re: [net v1] net: wwan: t7xx: Fix napi rx poll issue
Date: Fri, 16 May 2025 15:30:38 +0800
Message-Id: <20250515175251.58b5123f@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515031743.246178-1-jinjian.song@fibocom.com>
References: <20250515031743.246178-1-jinjian.song@fibocom.com>
Precedence: bulk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SEZPR02MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be273a2-c0f3-4007-3bc3-08dd944b95fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|4022899009|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ivhm4e4qZX33036nO2TfwBO3Fom6ILt3m8yf+9ZLB7eVK3ydQf6BuE3gkFv8?=
 =?us-ascii?Q?w5nwZvx3Iw4+xfJjHO2Z5Kb/Zlf8S3dQTvErxi/mqwlrXSPvNZr/sekaO9dY?=
 =?us-ascii?Q?twTcGY/wGn7X9wVV2a9NCmLysxht4W34poiTx3oO/ShR2ZJWtqg9ENdVCrZo?=
 =?us-ascii?Q?O3ZWE+40r34Y7NK4HokZDLvhy8Sp22qJWPbHTuVw6mBanQ3PKZeGjSkqA/OQ?=
 =?us-ascii?Q?hFqWCcog2T7n+Zog05YnTXjmLvxRGCVNgoWSp7Pe/ENGZJpMNiBqHxSJbe7B?=
 =?us-ascii?Q?tr1rp+imVrJseuypO9rlNC3/wuf70E9QZ7Dfa+ErBj0+k1o3aDbHoJZA97R2?=
 =?us-ascii?Q?9m6HpRQcs3nBgeYLxicCoTZpGPUHVlb7CRHUT5GPF4HQg52pk7W2QjeLSlB3?=
 =?us-ascii?Q?u/jxm1pEPs74gJMiQAPwIXAryIDbzWKcrxqOuWnqXEGPxD35b6TJalxhdW7L?=
 =?us-ascii?Q?Yxzwt+OSI9NjhTiXVyK6GWkpUBA+zC/6tR9nIUnJkN1mkFPv/ExHt/egOJJZ?=
 =?us-ascii?Q?peDUqyHImw5btUCkeC0MZPlMm9c+SLvHPAPzAsyRJf0FMIrBF58dr+wxdoWC?=
 =?us-ascii?Q?XuHZPeCiemWbQRR3LuNkSQ7UhpHM1mqNwP/v5iap4ARqL1hmefxPmtVeSb+l?=
 =?us-ascii?Q?BYdJvHuEQDEm8XDDKv9vQKIz8X7nkIeb1mxSQyomROguLac3qG+pcpQCQtAA?=
 =?us-ascii?Q?pinGq2SpJJHpMJnGgBEb5PsQqKaFRG5gMjtiKbCQPDPo7xlTNrALRfVNtbMq?=
 =?us-ascii?Q?hhWgOA/uiLdhIqx8PgIEZCoOER1Dwwt2zu/Aunbql/V+gwe3CfPYBHLI1uSP?=
 =?us-ascii?Q?/R/dMrtOmMfebJ99PRj6lw/dy36ceNXKHF2ptqDzczWIKjIUK8ZZT973T2FL?=
 =?us-ascii?Q?lApJWwI1FNsmrPcP9kUHhqlJihsG6DI2dIQNZCEANySQ1k+WbUXpxTB+R9wN?=
 =?us-ascii?Q?ELXvKvYiGpcjlEvD65ejWLLwrqNW9kz8Vb3cwx2IHxodMLWOHEJK75r1EVGL?=
 =?us-ascii?Q?ugd4JiwPzkTiFZwVZEip99R8RBybRcMo9wSQWoyq4yrBayKOcUddfTm2ABZB?=
 =?us-ascii?Q?ATLkUFaxLRNxkHeSC6WY3wstuY7gTwyfBbSgVIvy898JG3Yy7mdP1ez8ejQH?=
 =?us-ascii?Q?6f5Ln1R1YFVc73UM4EHYz4UgvudAhW31N6CG4AfVaazUGcbWuIMQnq84PMFJ?=
 =?us-ascii?Q?44Mh1sGePqK+OD0qc4wQfm7gz3NWL7FpORw2UudsjojOYZOByUeyw7VJqf97?=
 =?us-ascii?Q?YuoyHyWd+04/3kYVYMCKV4ubyMdrLBDa/ZOinK5I7ppUpG6EJD3D5AZblDhE?=
 =?us-ascii?Q?QLB0pd9rE1fkMPU9VoUKkcsW922UhU1F6j37YJ+sdKi5dbmFtaw+G/xyakAf?=
 =?us-ascii?Q?LpiWYV9m2E1X+iZSPXj0vAww9C9sdjawOQ4bR6GyyyYrm72LugjoPduA1otS?=
 =?us-ascii?Q?/6H7e7f3eIN+y4p3J0dVHrLwBoFEUryBhiq7BsF87Hnr83Sl+mYtlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BTpwpAyVvyUkXGz9YcLxu1se7yMmrRZ/uqrdnQKn80e08x5UoXrnFbRXPxP5?=
 =?us-ascii?Q?NF2qkX18tZwe62lQeg6XS9sdLw6Z8x8ZyCkHmbZM9q5SVgSasTDgkvUX1X12?=
 =?us-ascii?Q?9iMkanPZdRkHvhO5SzyYDRMKa1qDHvFgFpXxduCzKouElX+x7crMlnDbLd6b?=
 =?us-ascii?Q?3OaHcdy//4SLmyx+VX+CMBNW5T3edN82xZvOOeE/jl18peWAMb1pbQgebczm?=
 =?us-ascii?Q?t/A8aRYfxL8mo0B8yOyjeuISisLQkbey08Lt/L0Yt4KL9jAgodcDn6x0Yhp3?=
 =?us-ascii?Q?sn21/hh66EaYF+9f/ReBoyCX6zJMkZCrdTxJ2ovOkvHhVeBDxibw7V1j/QtB?=
 =?us-ascii?Q?tskQy1/fCNkQwaLDG9WNuL38lcwrG8hCL2V89u77J0RBdAfHlVpC+QzDcMpi?=
 =?us-ascii?Q?gUtwKU9i07aRVgreRo3mlZlVk4NeX0kV8b77oOG9SChrUVHmGOMPcl7I8Mty?=
 =?us-ascii?Q?m2JXe9cELhT4Cvq3+vL/jMTJjr3afqOqF7srLcibBV918o/5rvRFnaUxqc/v?=
 =?us-ascii?Q?sc9/zXItyJmbtC+cds96rDNAbYHi0iqy3dr0hq5r5mqQKJphPsXf7kju1PmF?=
 =?us-ascii?Q?PDSCq245Y/CvznCnzEWaOBm3EiQK0uE/cnlD7Qud+I2ezbsY1TqIZhsLQUCf?=
 =?us-ascii?Q?r6bRLx4NzDuqQGiZatpnVgFKL5nQRgDQMNMntRHiYxMCZcaqhT8I0tZQRf6a?=
 =?us-ascii?Q?po2+/wwnq+P3Efb2cA0IYs6Q6vPP488XIl6GaJ4rfX/uO3PwthQHrfktdPsm?=
 =?us-ascii?Q?MGBT3/NgerjqA+K9IfIaJzzrlvXwlnUkpjzdEPrp79GwAmPPAlMpFdzb/fjk?=
 =?us-ascii?Q?7MAVjt32aVebryeSUsVd+oDlF8XsKMx3wFo+o1izI5H2wAYBpJ7tmOh18vPV?=
 =?us-ascii?Q?wSL41iGxpODGUz1NiJb88yDqh904b4mZQZpSGRFHVj9E8u6oPIV663A62vRr?=
 =?us-ascii?Q?cMo7pnkDdHBvpfTT0Gn7ee4ecb9CtYSIa+g2Kf0J6pZbbN/qiqkltkLkrEqD?=
 =?us-ascii?Q?VWOlRmE4xgrknX2fb91qSy5/7KBkNJ4iYsSgBGGzRxgdY8YKORMnRB/HKPje?=
 =?us-ascii?Q?HVDw7GvgnLvxWfSXD+deUxbGHht7/hEGRXEmY+vPtBk/FzTBMUDq1xpAOa2H?=
 =?us-ascii?Q?gMzb1kI1NMgXFSeLntX1jAEmGVgi3FhPu0fHD+TOwZiHVVRc0JW1DZpcTxnF?=
 =?us-ascii?Q?ze78IVHIRJF2nJgkkrpJ3uH2g2kdHSPvDnjpP9LbaphTKNJRTZZyVQ8BYEZG?=
 =?us-ascii?Q?WBb+rVhF0JAhFgYgHR2qjax4tRAfZYfMCxdErCzjKxdImYZULyic5a6kYmxd?=
 =?us-ascii?Q?0bvwvzIIDnPxxP1ya70/ewsGSunmx7D/XGTVaj5k5Q6zenB8uh0tkGuN6McD?=
 =?us-ascii?Q?3jPnuppe/g5MHu20CEMt0VCNtO1etxg1ueqPRzTFAW09RtXxm1kBsQ1yhXnD?=
 =?us-ascii?Q?cT5aqZQknqa/ol4oOm0/0DYCYXiRBoNgtrNBRarpPwlWjtG3fL85RIs3cVNq?=
 =?us-ascii?Q?XWpmNjbaEh1PK2d/NtcIJwVEadP5AsIrXFI4FdJWT/UFBdI7LCROHej198KE?=
 =?us-ascii?Q?ZJVMQrEhOm0aSLMLiLwDkg1+DbNZiwEZ0RXU/2Npj0n/oFbMNiZGTjdAdYKb?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be273a2-c0f3-4007-3bc3-08dd944b95fc
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 07:30:52.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFA5RvA1kFhVEztvAGpJxJDGhR3vogXaB4N1BpYNxE2FJ+5qhGC7xS18qjmHlAlOxBLuNDLTZTAp2tqc9HjVSj8ZVUfV7ZpZNQNru3Ez0Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6177

>On Thu, 15 May 2025 11:17:42 +0800 Jinjian Song wrote:
>> diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
>> index 91fa082e9cab..2116ff81728b 100644
>> --- a/drivers/net/wwan/t7xx/t7xx_netdev.c
>> +++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
>> @@ -324,6 +324,7 @@ static void t7xx_ccmni_wwan_dellink(void *ctxt, struct net_device *dev, struct l
>>  	if (WARN_ON(ctlb->ccmni_inst[if_id] != ccmni))
>>  		return;
>>  
>> +	ctlb->ccmni_inst[if_id] = NULL;
>>  	unregister_netdevice(dev);
>
>I don't see any synchronization between this write and NAPI processing.
>Is this safe? NAPI can be at any point of processing as we set the ptr
>to NULL

This panic occured in the scenario where there are frequent disconnect
and connect WWAN cellular on UI.
I debug the panic with gdb and found it as caused by an invalid net_device
during this process:
1.-> t7xx_dpmaif_napi_rx_poll
2.-> t7xx_ccmni_recv_skb 
3.-> napi_gro_receive
4.-> dev_gro_receive
5.-> netif_elide_gro
One way, the net_device using in step 5 is valid, so "dev->features .." panic,
this net_device pass from t7xx_ccmni_recv_skb:
void t7xx_ccmni_recv_skb(...) {
  [...]
  
  ccmni = ccmni_ctlb->ccmni_inst[netif_id];
  if (!ccmni) {
    dev_kfree_skb(skb);
    return;
  }
  
  net_dev = ccmni->dev;
  skb->dev = net_dev;
  [...]
  napi_gro_receive(napi, skb);
  [...]
}

Another way, WWAN disconnect -> wwan_ops.dellink -> t7xx_ccmni_wwan_dellink
-> unregister_netdevice(dev).
netdevice has been invalid, so t7xx_dpmaif_napi_rx_poll can't use it any more.
I mark ccmni_inst[if_id] = NULL with netdevice invalid at the same time.
It seems that a judgment is made every time ccmni_inst[x] is used in the driver,
and the synchronization on the 2 way might have been done when NAPI triggers
polling by napi_schedule and when WWAN trigger dellink. 
So this should be safe.

Jinjian,
Best Regards.



