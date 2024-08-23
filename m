Return-Path: <netdev+bounces-121518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9759495D7CA
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D47F2B23E7A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB7519342E;
	Fri, 23 Aug 2024 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="jq/l940t"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F704198A20;
	Fri, 23 Aug 2024 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444495; cv=fail; b=J6JT1xXiXSMFH5i8rieMVB9mxA7MMCQwkKeTYbXPAvwQ+qVHYOb1UgbSu5AK2tGXowqEnTUVuzGCXf9fOJbgFIv9rthaZGH7e4Jez3EDT7KB0d198E/zS46ASl/iRyW15YikNDS1fj4KMv+WAiz4KSYowIUFrCIEpH+XVkLrTpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444495; c=relaxed/simple;
	bh=wIgkzTm88ulHDbfuoUFOvah2TsbcbdeQC/yv8O0aaAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BkkHzVyduL+yjPhN0JpSGIypmxe8SJk5StayIWbvH7o4hGaGPUZZKCG+zQQNpoKbr8wn6mk/HPattjHFHjjsV5sDjbFigu/XUB0KlYvmssRH/4gqBKkEtPHTgkak6oECjXrdPZaRyNuWij3CVa6XZsnLMxNL/etloDt0Ra7Xmko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=jq/l940t; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1724444493; x=1755980493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wIgkzTm88ulHDbfuoUFOvah2TsbcbdeQC/yv8O0aaAw=;
  b=jq/l940t1wWJyCIumzEgeSLffrg/qOgs83cSaqdqV3oq5a678C0P0ja3
   mujc2FIoxwooqW80eXeZu1DGhqGSxqxUAzBFDN3NRHWBlyT0u5JMb2qDt
   xVbvMjeVm5yNHxE80ZDt5j/rw/XeNAy3PIkrCira4KEnzoBdy4tvfrxLo
   A=;
X-CSE-ConnectionGUID: zA/5cjiPSliMOYizWO9frw==
X-CSE-MsgGUID: +VLeZsS5RJ+vrPqaPc+C7w==
X-Talos-CUID: 9a23:/l11yW1BrbF0X7pk+8RqerxfCOliL3bfzU/rJ06dLldoWoKyGFGK5/Yx
X-Talos-MUID: 9a23:2nfCygslIi8YXQZWHc2nxw9GOfVz2PmUKgMTi60fsvGPdgcvJGLI
Received: from mail-canadaeastazlp17010002.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([40.93.19.2])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMV6ZO4c8AhedSt0p7Iurm5pIBEjHbNBE6D+PQq1S09H2VA6NIrQ7vwFet/s00yCevNN7a5q1wpNMT7NXjpblm4DgpaRV/Sr+Y5gujLhXJqCYC2v5Ct+FJB9ziDyJIdC1BXer+RPuy1+Mi8otoqLlJXTOJTOwL35PVQ46S/mCitIxVBVDynDXrR0FwSNtD+uPIgjpMDfZvmEzyu9iaIV9NtBpXDLcq5ljLMV1dnWs92NgD3+I72FYe+h33o+qix5YYwk+s+fxkxMx8JkzGpbtIqFtaqwg7ghjPHT2e62cEyh+hi6H252Tw4573AFDdN+KnV05T+WrLtq6sT3ZM/4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IovUM0+kg1ytmfIqEyWOqEuhbvdeKthaYo+uRWhFP2U=;
 b=KmP33XXc5+jSRYzhlH52XzrqsnnScoVzk5W72zPsKU9i6Do2vl2T1rNHaC0qrCHzJD8ydfz4irFVA8y3eUo4QBypggKOM3XPc8xQg3eKy3EMq5411Ppx792zPb4ioDO26H9Td1y+UcGTyfGpgJ3n5TdbFeMq4em5Fd5hCDobH4xu3qni9/EjKIkpRHv8Tb9YlNfd4Q8K/fk5HyKDZ3x+1ukarmEQ/yATgmySW1G9sqSpQC2YqS1tHOjA89DJTAmcEZ9tOVsYtsnpAtzb1Al3LZBfK0WionDTKQ4S50SjQyeQ46czUNHNhNyf2/oWVDv3p7B3ns6RF/x3OdT00e2KGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT3PR01MB10793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:94::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 20:21:22 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%4]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 20:21:22 +0000
Message-ID: <b686e429-b46e-4190-a5b0-23b0bf185768@uwaterloo.ca>
Date: Fri, 23 Aug 2024 16:21:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] net: Add control functions for irq
 suspension
To: Eric Dumazet <edumazet@google.com>, Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
 m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
 willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com,
 kuba@kernel.org, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, open list <linux-kernel@vger.kernel.org>
References: <20240823173103.94978-1-jdamato@fastly.com>
 <20240823173103.94978-4-jdamato@fastly.com>
 <CANn89i+Ryar9QPL+PCw8P4Q9Wy8U1S1+q1J+_V4E0qYu3cLnUQ@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CANn89i+Ryar9QPL+PCw8P4Q9Wy8U1S1+q1J+_V4E0qYu3cLnUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::7) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT3PR01MB10793:EE_
X-MS-Office365-Filtering-Correlation-Id: 07571a1a-1226-4254-0b6d-08dcc3b127a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTRDOUFCSHh6RUNqSDg4SVdYd3QwNXQvV20wbVc4ekRwWHBadkRzd2Nsa2ZU?=
 =?utf-8?B?ZTdKMktoeDZ3N2Q4THdzeDcrQUZqcFdGbHp5WkE0MWx0VkxZaEtpOGNBNXhM?=
 =?utf-8?B?bWRZaXh4ZCtLcXl5UVdUZ3Q0dTRva3pkR1JyZEt0OUlYTEZOM3dkRHh6NzBS?=
 =?utf-8?B?bFdtVlg5OVFQZmJtbDQyejZlbyttTGtidUp5OTJYSmlvOWUzNU5ZdXF5Mktq?=
 =?utf-8?B?LzZoOTlZekNQa0VqU1dYc0FodTF5NXNGN016RmVrNDM1THdCNFRvUWpNdVJl?=
 =?utf-8?B?QUtEcVREaGxKeWdYVE83ay9BSkFTQWFqQlVUcHF6ZnVqQnZ6UUFDSTVDMFUz?=
 =?utf-8?B?dFc2NUwwQ2RzeU96ZGZjUDR3eEhzOTNtd0J1SklqTWdHOU5tS2NWTmlURC94?=
 =?utf-8?B?TVJubWE0UVpHd1V5R1g5blo2dGZXejRQQzZ3TkY1VnFjN3RWQUtvbTVPc3ZP?=
 =?utf-8?B?VXkxSmJYYnlGZ2Q2MEtQWTd6N2xsYUozMDdyR21WTGJxRHo2a2xaOVJjcVk5?=
 =?utf-8?B?TTMyNGQwd0NRR1JUVFRGNEdXQ2lodk5henM5UVllQTZRRlVmbzFKSU9yMnF5?=
 =?utf-8?B?YVJjK1Q5RUxONHE3N0tscWw5R3FRNWtybGVZdFRIQ3BDOGpUMmJEL2p0cjdC?=
 =?utf-8?B?aWY5Vmw3Wk1LRXNkeU04bmZiUDRpWE1uQU9VQkFFY1N3bTROL2xLYmh4Qnkw?=
 =?utf-8?B?NEJxaUNaZ2FWWjVzYlNFWURkQzZTVitlTWgvbXN1dlJXbW1MMXdNeDQ0elJM?=
 =?utf-8?B?ektsT1kvb3BxUGxQclBBbVMyRDlFd2pTc3lYRndjOGUrZXAraHgvRkhLYnha?=
 =?utf-8?B?WU1SeEovVXROL1NhRGJBNlJtVjFtRXhwR0U3b2ptOHF1akhPc0pQUWc0aFBs?=
 =?utf-8?B?ckxYWGd5ZkdJM2ZJSlh0ODNQeW53cFgwT0MraDZRbm53WGFlVExMc0U5aVVX?=
 =?utf-8?B?VFErTFV3aEpJNE9PUWo5RFlMRGJXNDZJM29MMzlYbHJNQW1aR0QyaUttajJF?=
 =?utf-8?B?SWFydS9IRHhtWUpNWHhhZlVGa3ZyNUhiT2VKQ1NhaG5vUXZYd01lR1NOZWNq?=
 =?utf-8?B?Vm1mU2FUbGFHMjdPTFFCT2s5TDBVVlRvb1RIdy9hSVNYUnRqekVCaStnakdK?=
 =?utf-8?B?MnEwWVc3SEc4eVJCRlp5d2wrdlM5UUU4QlF4V3JvYWFSUTZhMmtyVWtGWXpx?=
 =?utf-8?B?VUp1UmFKSm5aYnI2NkZMais5R2ZqWU9QQ0ZtR2Qvd1lRYVZLUWdYMkxJQnZj?=
 =?utf-8?B?Q0lIV3dwL1d4aWZ0bjE1NmFEN0c1di9KZDlpK3FONVlzREk3VDdYWnVXbnV5?=
 =?utf-8?B?d1YrL2NPSGt5eERORzR4T3BIUktoMVF1YmZ4alFUWGJVVDlHTmRQaWEwVmdi?=
 =?utf-8?B?Vm1wdlpvbzlZYUZhUFk1Nm10YjdRb0FHRzFTNS9TRGduRFd1cG12VkNPcGFh?=
 =?utf-8?B?ZWFacGdHWmo2Tk9xSDNpaXRtWkR0aG1jd3h0WG5DalAwYmdqeHo0Z2MxQ3l1?=
 =?utf-8?B?SzFCY0tSRDQ3Z1ovUG5tb1QrSEtidFZvRHdpT3NvMWVCTWZ6YUFQN040dFhQ?=
 =?utf-8?B?cU5EOGZ5d2lNN21UeVRjalVGaDVpdUlxMVl0RzdWdzkrUElhc29KSVRZSFR2?=
 =?utf-8?B?SDBDaGtHc05vd1lwT3ZZTnA4ZGQ1RUxGZjdKdktMRTk3WWcvemgvaGhkUVBm?=
 =?utf-8?B?dnVsN2FuNE92SzhNVE1RQmhHdDBXay93bUo0cGpIZXNjNXduTW9KbUdUblJK?=
 =?utf-8?B?OEV0OEZJemlXbmZFVXg0VEkrMmU1UW1XbzBKNjliNzJ2djBvdjZHS1hlQ1Vn?=
 =?utf-8?B?amxOWkNJTEJ2VlZqLzlEZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmVMUzhXT0liZFhpRXQvOXBZbURzVGlyc1l2UFVYUGZtWXcwYVVvTFhBeGRO?=
 =?utf-8?B?MDJTSjJNQ1FOR0trM2wwaWFFbHNNWEsrQk85VUczMGVyaVdIWWM4SGpqU05t?=
 =?utf-8?B?VzBNYUgra2x0eStRcHhxOUFJZ1NacEtsZ2VCelZsM01qVjFOZG9QaG5wL01p?=
 =?utf-8?B?QWRjOWJhVXhvYUF5OU9aN0RLMWlSQnh3Q0dnRFVBY0lNejVpdFhZeGZML1N6?=
 =?utf-8?B?OEtzMGRTVU1OUkkvaE5GbEFXZEI3T0xuR0pNa2RxeTNGYnhsWEtPVk5wRysy?=
 =?utf-8?B?dDkxSUl0SHF0MDdvbkEwbTVza2JCekZvaEhtbzhEUEJqWmhoSlVMWENSQmdr?=
 =?utf-8?B?UEZieEJZTEJuRktBYnVibGp4OW5hUDdyQlVySDB0TStxa3lzNE85SjlhOVVo?=
 =?utf-8?B?Y05yRHhSOVcxaVl5c05nc3IwdzA2N215L2o4OFdNd1Q2MytOYTdYcjFxUTFO?=
 =?utf-8?B?MkMwSVBlbURZU0VSZk5WVlltaGZvbVRuTEJTMVNBTEYxVHdiUDI2MTd4N2Jy?=
 =?utf-8?B?Myswc2pjZk4vRjhhbHhMMm9TVHA4MHZYSDM4Tlp3Qzl5WkRXYmw4S054UStp?=
 =?utf-8?B?czVuRXNtKytIdzk4ZHVOREhHRWoyeXpaekZHd0IxWnkybGF4VEIraU05N3o3?=
 =?utf-8?B?ODY5WkhSYlRNTG9OeWxmNk9LL0hvbkZBZE5UODFRd3I5enZlYnMyY3d2Mk1L?=
 =?utf-8?B?QklRYkpIOGxDUzlzcjM4bEZSVHltakltMFl5bzQxTlk5MGJDeEJ5c1J2b2I5?=
 =?utf-8?B?aTNFa1JMT2Vvb3E5aTh4THRObjcvU1VTTlQ3Z2ZVTHlvVS9IRXJiOXBwbzFu?=
 =?utf-8?B?QVRXSER3Um04Snh3bkZweU9MaS9McXZaaXlOL0twVEVMNUY1THJwZGgwWjFO?=
 =?utf-8?B?Y3IrZEJjN3hXNGkrYmI2Vy9Vc2JKeTNlSHVzQlpWVmxkL003R3ErYmplRzlB?=
 =?utf-8?B?R29WbGNKWWcrNkhoa2ZuZXF3L2RhU2VCZUl2bDBFRG56YVFnWEsvRitOa1RM?=
 =?utf-8?B?TUpmUHo4cVdXOWsvdXdlZzJqUE9EWStPVVREZGhGR0lLNVoya3FudG90RDM2?=
 =?utf-8?B?Rm1ueFdPajZuZS94MDJKYWJPNWhNcW9kTHpFMnArWVQrbGo5K2VDRDRIRXpt?=
 =?utf-8?B?YVJnOFFJaVFSOFJqYnhIK2NKWEcxTldwWFZnUnlRcDQ2S2Z1WkF3eXVsVWsz?=
 =?utf-8?B?VzZJRnhZNjBSWHEwN0xEODNraUlPOFp2a3dkZzZtbVgwUXVXakJvTG1ETDRu?=
 =?utf-8?B?VktTT3VGQ3l0UXZSN09uUjdteElta3Q2dDZhdWsvNUVDQjZBUkQwaVhJK2JR?=
 =?utf-8?B?UlFmcEROdFljRTZaenMzeU40d2JJMGNZdVJlU0g0YlU5TjVMZFBvalRTNHkr?=
 =?utf-8?B?R1hiQlpDRFg2WUFOVW1zdVk5KzZiL1MwS0ZXM3MyZzMzallmNXpjVlI0ZUZB?=
 =?utf-8?B?elNsbG5YaUhMOHVLenlrUkQ3SG04QVVLa2lZNHdjZnNjaEcvU2dabnRBeXJj?=
 =?utf-8?B?UG5XdXdEd3ZuOEZlRlV1TTcvUDJsU3N6dFAwazhIL3JPQ25BR3pDRTg1KzBC?=
 =?utf-8?B?M2dUWHFJMncwaWNsZldieVFTN2lCVHhpRzRMWGlpVTZRajJGY0JaQlpCcC9P?=
 =?utf-8?B?aTVwRi8yNnc1bjNiQ1JPTUVVSUlFUE1yYU5pbTUvcVRWcmxCWlJQN1V1WDMy?=
 =?utf-8?B?Qjc0bE1yaVh4NjlsMVNnVGFWOGhOMFVHUXFtSkQyK09VQzUrSExBK1ZGUVpt?=
 =?utf-8?B?V1ZTWTFZbWw5TnB1THhSWXF0TFRvcktTZG0yTFdIOXJEQjE4OWFWa29CdytX?=
 =?utf-8?B?dkxmcHVIMEpVY3JrWWZaaXJOcW1EVU1RQzVzYndkRWxvYXY0cmRFdkFNMDhV?=
 =?utf-8?B?UEZGVUwzc09RYWxHRmJ6QU9MRHFnL05hYkV2OHZ6NktlSWhLQkd1VVgzZ3Mr?=
 =?utf-8?B?VzZqWnRtaVFlVlhzZVFBU0FadFNLL2xOcFlYZ1EzUmhIdnJSdUZTSnJjd2FZ?=
 =?utf-8?B?SEVJMG4yOUdUY2xkcWFCWlVyaUQveTg3ZTZHVW5pRjZUVEZRcmZKdVBJWkpW?=
 =?utf-8?B?QTFibFdHQkhRSjZxSFkrWUVaU3A0K1ZSTFJ3U2RaMEF6anFWUGJTOEkyUk9Z?=
 =?utf-8?Q?XElnCu5fZKCDDA64nWE3RF/nx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	keDv4/Tdd7YcuKbF+5SqD4959n+RYDagmYo+TVuqH2KT8dQEw1X/z0P5FW4D9V+HCDawkxy9xLlKi1OOULOGwDp1npfMpMgO9cNPBWsdtUixGef9CuNpMNh7TmNt9npxEnh0u2bm0G5QrFc9QoOZDJ5JRC6ybHYkWvDjZZpnFQyNOYBVVUt+BqqK64TH9yG3wqDwOUWX6DE0NnPdOzvE2uiJcCUE+zpqrY7YZKv7i5SkXdXy3NlcooaljBnTQ/W0/FjnBglpQxfNu+yI0T/5JigGwKcbbGsGh2BmEUBVbRdTS7Q5XkVJcIQgndbADU8f+vB3iJR7ZE7A7sN4tTNg8VBqyaay0MCI/RIDmoqEIV1ihb2QSrcl+JKwvPT7lTtCjvoaABmRvHJE69pLGaT7XAeZDXBtntYd+n12pstcGfC9Jig5hWZHZb44/Jdsbyd1gg8+c/49SEw2XGzhllGBjN9Ae3Qesm9K/GsHZghFn7gO0wk2CANnyDhQ1tgScPSU9bQh9G5wrPPQi9Vko5tje14cADz4PSaOul9VXiShta05lby/YVfOxF2jKG3vG0/YLFIde+wLcRloMetD1TsAPOvS0c4ezyS/iCfKqeSQNBhIr7ncG5ca6G+Yb+Yh5fK4
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 07571a1a-1226-4254-0b6d-08dcc3b127a9
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:21:22.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SD8DebD1QNfFOPUiZwgldM9HiaPx7KOP6lpOMbx7abygZtBM3Vwm6EUV4LLEF15+wNc+ErwJ5vJPpC6DvYUuZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10793

On 2024-08-23 14:14, Eric Dumazet wrote:
> On Fri, Aug 23, 2024 at 7:31 PM Joe Damato <jdamato@fastly.com> wrote:
>>
>> From: Martin Karsten <mkarsten@uwaterloo.ca>
>>
>> The napi_suspend_irqs routine bootstraps irq suspension by elongating
>> the defer timeout to irq_suspend_timeout.
>>
>> The napi_resume_irqs routine effectly cancels irq suspension by forcing
>> the napi to be scheduled immediately.
>>
>> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
>> Co-developed-by: Joe Damato <jdamato@fastly.com>
>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>> Tested-by: Joe Damato <jdamato@fastly.com>
>> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
>> ---
>>   include/net/busy_poll.h |  3 +++
>>   net/core/dev.c          | 33 +++++++++++++++++++++++++++++++++
>>   2 files changed, 36 insertions(+)
>>
>> diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
>> index 9b09acac538e..f095b2bdeee1 100644
>> --- a/include/net/busy_poll.h
>> +++ b/include/net/busy_poll.h
>> @@ -52,6 +52,9 @@ void napi_busy_loop_rcu(unsigned int napi_id,
>>                          bool (*loop_end)(void *, unsigned long),
>>                          void *loop_end_arg, bool prefer_busy_poll, u16 budget);
>>
>> +void napi_suspend_irqs(unsigned int napi_id);
>> +void napi_resume_irqs(unsigned int napi_id);
>> +
>>   #else /* CONFIG_NET_RX_BUSY_POLL */
>>   static inline unsigned long net_busy_loop_on(void)
>>   {
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 74060ba866d4..4de0dfc86e21 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -6507,6 +6507,39 @@ void napi_busy_loop(unsigned int napi_id,
>>   }
>>   EXPORT_SYMBOL(napi_busy_loop);
>>
>> +void napi_suspend_irqs(unsigned int napi_id)
>> +{
>> +       struct napi_struct *napi;
>> +
>> +       rcu_read_lock();
>> +       napi = napi_by_id(napi_id);
>> +       if (napi) {
>> +               unsigned long timeout = READ_ONCE(napi->dev->irq_suspend_timeout);
>> +
>> +               if (timeout)
>> +                       hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
>> +       }
>> +       rcu_read_unlock();
>> +}
>> +EXPORT_SYMBOL(napi_suspend_irqs);
>> +
>> +void napi_resume_irqs(unsigned int napi_id)
>> +{
>> +       struct napi_struct *napi;
>> +
>> +       rcu_read_lock();
>> +       napi = napi_by_id(napi_id);
>> +       if (napi) {
>> +               if (READ_ONCE(napi->dev->irq_suspend_timeout)) {
> 
> 
> Since we'll read irq_suspend_timeout twice, we could have a situation
> where the napi_schedule() will not be done
> if another thread changes irq_suspend_timeout ?
> 
> If this is fine, a comment would be nice :)
> 
> The thing is that the kernel can not trust the user (think of syzbot)

Yes, this should be fine. Calling napi_resume_irqs is done to restart 
irq processing right away. In case irq_suspend_timeout is set to 0 
between suspend and resume, the original value of irq_suspend_timeout 
(when napi_suspend_irqs was called) determines the safety timeout as 
intended and the watchdog will restart irq processing. We will a add 
comment to make this clear.

Thanks,
Martin


