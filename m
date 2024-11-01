Return-Path: <netdev+bounces-140841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD29B878E
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3731F21D2F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 00:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD30D2FA;
	Fri,  1 Nov 2024 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="QhC/7jqT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2123.outbound.protection.outlook.com [40.107.243.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC3C2F5B;
	Fri,  1 Nov 2024 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420223; cv=fail; b=K5gHMcikWqVxA+F4x4dLE91DwSF2MMP/2kTXZtxM4Fsgitspbc4lT3jibG3YQy6BOkT9YCFDRODQ+zlO/sfZwoA2gJv3yMglJR9A37WD7x/KEZTPOuJUk+k4YjeVVisXaMoKdfQQvd0fWT5aGtWtcUj7LFLYDfbAzM3kyyJZWyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420223; c=relaxed/simple;
	bh=UY5oR/QM/dKZWU5GCv9JkcKae5ymeGO98jq250Exfro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=glc0H1Vedip21UJKlE9TM2I7QdQEJ4q0rRygKgA6Q2SI1iBTIETPTOhzsvlERptt4mdKLl060SV3MV/KQbJDmeMvr7loBDERsN8KvFRye6z1M3wEEYSceFIx+t4+J5aGKiJs+iK3lFQoNdzKLIT4xSSH1i/HeCxG2Kh0NoCbsfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=QhC/7jqT reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.243.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nb4TCwuG4kcAYfWbX4md8NqxENmEKTSNmIPcCLXcke7w0EgBkHVuFzLwZgj1XiUi1hztJbUhvex7Y7NUqNakPtL1xhEt8Fzcx0itvjZDqdFoh0TKaGwpW2VPryFT65fohdD031r0dDn/rkbhLxp2Bpkyn5DZ0tDoHjxdCHMCDej8UiEu986iPO4exYTgcRVgEIzdAfWKHWz5dzVraGkrx7PgQSD8kgRFpnGiCaZIbhUzfq2bFD7QwTQQwQ0rpN7sWvXN0kiEh1Mh+A1bWJ0xCk4cC/BEtil7//+vY5/HKRIi2UdnEWNg45BzkbSP+n8uroCbAeiF5qA3164JKj7vlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YADekIEzeGHmmmeQ4HFUs28Wzkm9jhcXMC0RC75e86s=;
 b=YvHv9l0I+hK7m89YLBAsIH+kp8AjZccVk8b3s8K5NyjA7B5bfZ40FZrxBRNhZ1hsHj5pBUjlQV5HLdR/pXnv/P2j+yXh6SLh14qpYAV58DCwbKBQ6lcQN/0PzPjjrUHlcTJRtRHxdT+pYC8jAqCPhkUQA+xPsHqpeiwc+37a260F7GXn0zBWArLcMNposWPSzCPowIi4cFGg6Xpmu8po6XIdSfYMbVSnQd/gkwPWsSiOZCNPZnnSoX18cAhbWv9kGrT1FOz7ltFiohOVhsFidKLgjggm8Cdfe/KhstuoAja7BJsdH3FDN2QL2+y03K5UhVkhjhJCNvb+Ry18ENYrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YADekIEzeGHmmmeQ4HFUs28Wzkm9jhcXMC0RC75e86s=;
 b=QhC/7jqTtr2cDS+YR281FtYSay/YtqGl50xSA/c+5H477CdbsEaQq8PJpNHqjoK4JQwDB0aUuUyCvAU3rcvubQx72bS3oqAjIm7wADLrVb0OcqRiFM/k2zilQ9BYgsC4x5+R9M/+hSOlqzpv/hD0Me1JpYlnPblQNkveSeVbcng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BL3PR01MB7195.prod.exchangelabs.com (2603:10b6:208:346::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.10; Fri, 1 Nov 2024 00:16:51 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 00:16:50 +0000
Message-ID: <38fab0d5-8a31-41be-8426-6f180e6d4203@amperemail.onmicrosoft.com>
Date: Thu, 31 Oct 2024 20:16:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] mctp pcc: Check before sending MCTP PCC response
 ACK
To: "lihuisong (C)" <lihuisong@huawei.com>, admiyo@os.amperecomputing.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Robert Moore <robert.moore@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
 <20241029165414.58746-2-admiyo@os.amperecomputing.com>
 <a05fd200-c1ea-dff6-8cfa-43077c6b4a99@huawei.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <a05fd200-c1ea-dff6-8cfa-43077c6b4a99@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0364.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::9) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BL3PR01MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: caaa0d44-63ee-421a-4b64-08dcfa0a7b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGFCNHhsOWQrV2hhc1pCcUpPb1dnckFSeHY3Y05FOGpqN2FMbHQ1RnVCVmtL?=
 =?utf-8?B?T3oxYVd2QkVoWGxFZ0RWUHo4cTBuVXp6NUs3cFFsaGNaV3BvUGl0UEltYmta?=
 =?utf-8?B?aFhIL2pjT3p1V0FXbGtoSWd1SUdOVG41b2hXVHpPRkMvT1k1amdYLzA3blRH?=
 =?utf-8?B?T0Z3TGhleVA4OFM5YnVQdUJTUDMwN1NVVjZ3QkI0TG1QY04vbzhuLzIrQVpF?=
 =?utf-8?B?OTBmTFRrMnd2aS81WU9WS05nUjhQVy9SVk5pVUt0ejBaWCthVXAyRm01OVB3?=
 =?utf-8?B?QTZ6V0lkUUtUcVZtbHMxT2xiY2JMZnd3SDdTZGk5MVc1dExwR3NIMVl4WnBl?=
 =?utf-8?B?cjdRYkpLR2ZFTWllUE9xMVk4c3FTNTR2ZmpOREE2RW81Vm1zbnFRVGdzMSs5?=
 =?utf-8?B?ZlA0Q1loTVlWWUpuUEkwODhsNHRFOFRjMmg1VmdBdGF5RkppU0FSNUFkWDBl?=
 =?utf-8?B?WktGV1RjMlJDR05XN1RXdVdGNFZpRlhxSjZDTmMraS9Ud1NNZWM0blBEaEJ1?=
 =?utf-8?B?RVVsQVhMeFZnMkNOd0RMVHJhZ3EzcjVWci8xRFQyQUkzMmYrVnVZZENCRTJx?=
 =?utf-8?B?dHZjUWkrbnh3Mm0yUVc0bXFWRUxDRk41bXFsYzh6L291dUpKaXJtbFZ5Ly84?=
 =?utf-8?B?WXlRS3YwTTg2bHN6aVU2NHRFYVRYZDZ2VTNkYTl2eStsdFhlWFJqdU9CN2Qw?=
 =?utf-8?B?WS90MDlDVjNLZkozVmFMZ2YxeFVIN1NIVVV6L3hzMURFWDNNZ0h5SlIxakRl?=
 =?utf-8?B?VUcvUkpzR0JzTDE3K2ZKbFZ0QVNYTjNMUFB4WjYwZzRtSWJ6elM4OWVoNHZ2?=
 =?utf-8?B?K0tOcHkzU2o2N2d1T3djNUhjdjF1S3JTWExDZHdpVTJ1OTVxcjZxbTlnVjFB?=
 =?utf-8?B?Ykh1dG9ISHIxQnNGcGdhbUxRaWw1blQwSHBvdlAraG15bjZiSmxWNHBtWWRh?=
 =?utf-8?B?ZFFuSm1KZE55Y2JuY0tQQnNHZVNEVitSNWphZERyczUvSENrTkhqdkNldFA2?=
 =?utf-8?B?OUNFV0w1SWJ2QlJCMHpabmhlRWljMmxROE5UZHpWbWQ4OVNsY210N1d0K3lB?=
 =?utf-8?B?Q1hValFqRVVhbmdPWVdBT1BJQzY0bG40UHViRit2dFlOQVZyaFpEMnA4MG9K?=
 =?utf-8?B?VStWZWQ2ZE5iQVVMK1JqZlpkTkhSRUZLSGF6Sm5veEpEdzFyRUtQVlJVbXha?=
 =?utf-8?B?ODIwdGc1MHVVNmIrZVhLNUp1bXJURi8rOGR5ak82R25ULy9naUdjY095TzdY?=
 =?utf-8?B?MDU5WStEd0VoQnhPOXQySXhUR1J2aW8vWktpNzB2QnFrRTVhWGNnNGVYVXdo?=
 =?utf-8?B?RWZpZVByM0hMbFFLcC9LaEpzeUVIYUFCWDdrRVZuUjJQdGdsekcwQnErVXBW?=
 =?utf-8?B?M3RySGlzVUw3dUFucC8wV2ZrSGF4dDZJUk9DZ3BpK2pUa2NhTXUwZUVacUNE?=
 =?utf-8?B?ZnZVNzROWGZuM0V2dldwV2VVN3lHYjV6WVVVVkx0bWNheEVCUW9pRm9WQUJH?=
 =?utf-8?B?VlNhbGR4UVdBNDlFVzI3VnM5bEdYSjVDYzZRV205bmVFeUxHSmRPTURNUmJ2?=
 =?utf-8?B?dFBBa05NN1RmTURSMVEwZ1FPRVFhak9OK2NkTjFUUm1pNmJPcWIzRXB3T0Fj?=
 =?utf-8?B?ZjUvN3lTakNQRjg2NHczTnpZUVNyc1FURDUzQ2ExMG1DcExBOWJqU2JUOGZs?=
 =?utf-8?B?Q253c2gzckRabitVdjdrTWRxVUVuUFY2Ym55bk12QlNxTTlBUHU3U0pYYkly?=
 =?utf-8?Q?I9FBoc0rTtsuWXQb48dw7Tjcb3F2a3M3yAsrA8z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDRDWTdvcERCKzhNam5yckxuTnB4c2x3Tk1CZHFmeXcvTmZXZis5S0Z3QWVi?=
 =?utf-8?B?aEVMc01tSWxyVXhXS1dIUmFKTTVQUGRubjJGbER2V2JCb3U4MUJKT25IUjVu?=
 =?utf-8?B?a3pwQXh2OGJicG1DQWppNDgzZ0swcXlkWGNJUERFUDhzdjVFRHZUWm9JcVRr?=
 =?utf-8?B?aENyZlo1OFpBeTZWSWZDbUJLK3ZhSkwzOFpRUzloZThnMzI5SUxoMmpvQnl1?=
 =?utf-8?B?RWduU0pVdVFJMmQ2Y3NBbDVsSHBMdi9qeDF6UDBPMHpBdmY5bFVoRW9FWEhs?=
 =?utf-8?B?WDdDb3dRUXMzYklOTEIrUTdsUndtN25GMFh6WW9jcis2RGY4VnQ4OW9SKzdD?=
 =?utf-8?B?d0lkNzFKYWRZcXFCZjBKalJKTmV6TGM0bVZWUXZld0pXckd3Z1dyLy9qOTgz?=
 =?utf-8?B?LzZsTW1wUUxpSXZUdzNCRENZaEdGYzhJZy9Jc1REazdGeEdsWVFqanlyOGFq?=
 =?utf-8?B?azB3ZW5VakM2am5LRkVnems1cVg0M05hNm1RbzRraytrb0svQjI3V0FuMitR?=
 =?utf-8?B?OE0rOWlBOVErQjdleW5Rc2pRaVNQZTYrVmdIT203OTVjNHBLaDNBVlVjWWJN?=
 =?utf-8?B?QlBzSkdjbTlkdDY4em12Yy9jYkZ6STd1WU1BZXpONm9MYityelphSlR6Wk1h?=
 =?utf-8?B?YmV5ekFVZXNqV2toSEN3OW1mVFV6SzlEdVMrZEtVS2FLZkFXOW9hSTBHdEt6?=
 =?utf-8?B?ZEZFckhLcGk3MnMwYmg0OXZNcGRmV0pkRktmOWpMek1RNXVTZC9ZU1JySWFM?=
 =?utf-8?B?RUFzKzNqWjBkUmx3aVdHa0hiTVI0dHYrM3g3dm8zT2k5Y1dRT3U3Q2thZ2xM?=
 =?utf-8?B?b1RmM1dOOERSTFhXZUFxVm1HdDBzamFJZTZJWm5MVDMzcXJZdTNaN3VQQnU4?=
 =?utf-8?B?Yit6K0cxYllFYXpVK09jS3E3ZlVvRTF2QUk4UGlBdytFUWFUOGFsdlhxNW1Z?=
 =?utf-8?B?VjVaQ040L0FhYm56RXhrbDNYRmdZbHJZUkZFcmpqUDlZaE1yMlJkTUtHenRU?=
 =?utf-8?B?dkxJTTMrUDhaajE0Z0hLLzdVZmRtUjFNQWxGNGxZaW54ZWFrOUgySjZxMlFn?=
 =?utf-8?B?bzJUSUVrdE9Wc1VzYnNJS0RoZ0JacW5qTml3UTdZWnNFRFgyWXVuWmN0RDN4?=
 =?utf-8?B?QzgycUxzT1Uzd0pwSVZvVjNtdDBLRDA3VDl5U0Y3VEMxbmRCaDRrM1l3VC8z?=
 =?utf-8?B?TlRkTnBzZFJjb0hueWR5eTdLN1Q5Uk5WZVA2WmVYL1pWUmJJUStmZVppVEZo?=
 =?utf-8?B?UUIrQ2JvNGFwMGxNcngxU25XdUxNdldlYmZoaHl2NDBFZFBPM1dBM0hXL25N?=
 =?utf-8?B?Z2orSXltUkNMTlV1eDduSTRwcUVlclgvbHZyalRaMU03dEhaajJ3Z25lbHFi?=
 =?utf-8?B?alVLM0p1K0lZcGNiaHlNa3JVQm8yc1dTcTIwREI1bTMrV281clVGdGlKalFP?=
 =?utf-8?B?akhSNkpUdDZmOUZhYmNHcjA5QzBvb1l4YS80c0xia2c5V3dFK1JWdGcwYXlS?=
 =?utf-8?B?cmUrc0REZ0MvN1VpT1hQTk4wSUVCalVJVmxqUVFsWXZpRjRMY2lxeThEci9W?=
 =?utf-8?B?V3ZQYU1lVWNTdHc1anFXR1NaaHlYZFRTRzJ4TDhVV09kcE8xeWh1d0NTWXNF?=
 =?utf-8?B?ZHlId2p6MUQ1YjhTTkE0eGl2TjJpaE9SNS9kN3pibjhtcXgrN2tweWhzaE9P?=
 =?utf-8?B?Z001QnZ4cTQyaTJjUXNuMW52TnRiZ3dwbWZXcVh0dy9Vd0RkUVNtL3dDZEFM?=
 =?utf-8?B?WTJSTFdYZDBoWXEzeEcyZUt2VEdueXYyTTUzV1lpWEZRcG1zL1ZVTWtobzQ5?=
 =?utf-8?B?eXc4WWVSWWo4em9pWkRuWUVDTXJIdjZKcUdmRlhxRHVWQ1dxWEVjMnZrSmhY?=
 =?utf-8?B?UVJKMmxTQ3dFU200ZU5qYW5ldWtuUVBuZVNRZHFmaVMwNmVLZ1NsN0pJdEx5?=
 =?utf-8?B?a05XZG44eUFsSzV5akQrNVI4c2VQSk5WK0diZW8zdTlTSlI4TFVvWit1VWVL?=
 =?utf-8?B?WkdqWUV4YzNIR0gzOHVGdUZHTFEvNnRnQlg2YUVXRzNySFJjTnFoTU9GclRB?=
 =?utf-8?B?ZmtGWUhvdzVjRTNnSDBKRzl4UkJtaUdpZVZrTXIvMmljaER6Vm9vTEo2bENU?=
 =?utf-8?B?UHBhUmkxL3VXc2pZdm1tMFNMUVRuWU1pT0RkYVZoY1EzUG1vOThnZnl1NDdD?=
 =?utf-8?B?bUx1K0hlSlNacTZnQTg3UUdCa2I0Z0U4VUJpcm9pL0lXZUlLRzF6VHhQamNv?=
 =?utf-8?Q?p2TdWwJ520ffZO13kQkQ4e4Hf8dVPTyrInbo8cM1pk=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caaa0d44-63ee-421a-4b64-08dcfa0a7b5c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 00:16:50.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5d70QLYuZ84THdQYNQGAY9NVDsyAB9r/GI/09Fjz+Fzzf35+LhHn0WQTPY1hsB5of1gKdky9akV6bquGq9wDH9Dl1DYX5M4QNC5pBQoqy42Sq9QUKcvbr34hc23QOQ7k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7195


On 10/30/24 05:45, lihuisong (C) wrote:
>> + check_and_ack(pchan, chan);
>>       pchan->chan_in_use = false;
>>         return IRQ_HANDLED;
>> @@ -352,6 +368,9 @@ pcc_mbox_request_channel(struct mbox_client *cl, 
>> int subspace_id)
>>       if (rc)
>>           return ERR_PTR(rc);
>>   +    pchan->shmem_base_addr = devm_ioremap(chan->mbox->dev,
>> +                          pchan->chan.shmem_base_addr,
>> +                          pchan->chan.shmem_size);
> Currently, the PCC mbox client does ioremap after requesting PCC channel.
> Thus all current clients will ioremap twice. This is not good to me.
> How about add a new interface and give the type4 client the right to 
> decide whether to reply in rx_callback?


I do agree that is a cleaner implementation, but I don't have a way of 
testing the other drivers, and did not want to break them. I think your 
driver is the only that makes use of it, so we can certainly come up 
with a common approach.

The mailbox interface does not allow a return code from 
mbox_chan_received_data, which is what I originally wanted.  If that 
could return multiple status codes, one of them could indicate the need  
to send the interrupt back.  Otherwise, we need to query the driver to 
read the shared memory again.


