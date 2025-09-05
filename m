Return-Path: <netdev+bounces-220480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16421B464A0
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 22:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6061BC4A78
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 20:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1049F2874F7;
	Fri,  5 Sep 2025 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="TQ4tKYW/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2113.outbound.protection.outlook.com [40.107.212.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB11F4262;
	Fri,  5 Sep 2025 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104546; cv=fail; b=hCPzBsT1cG5jzTGPGVhAKb69T4rqBhIYOlpkG8Deaj+eb3S6vT3vZq+TgMGQI1aCvmIUekQmS8xX1nOOSubLBm3z7YeJuxMyyXWqPW5tKaGvDTQsLTWaDE/SFk7QBK+9Pv4lGz6mAqIK5Rb6yiJjO7FWRln6VHmN2usb0VwN8Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104546; c=relaxed/simple;
	bh=LU3GUmOZdboDxMiWEYdy54W9yKJCM04yAtKwWg1p6x4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jR5BljzVfGcPv5elVQqDA/aM0Dp5SdmP/TQZejuCunvATZP48iUcmiSSEhzvoOO01gBxzpc2vBJBTdm/4S2wsLyzILO/fVCirdLO9kimfZWHavjZp2jZVPpNDzhr36yO8KHJWxE2CJV6rwQUR9QKraLVgNHeB10YSfROmpB483g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=TQ4tKYW/ reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.212.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj3dx71c6e25oZktEevAdacjpHP1DTnLS/1XQmLZBDji7BOStxIE0q21f81otuRXuAjXRvqjdssw4CV1PGggc2SRZtmV/iToEC3EzbG5KFqm4x6wjpw799ZAqNS20tox7+fGCdaNoK+XOEW8V5Ozz3ZmHyZrzznYGHXHuY2Z94rEkJovbMjmsHyoroICb03DA4p7GJYTGRBhx8K91gyQnfZE7LwKDmg2VG9oE3nB1Gb2A1Keb38laigmzVJ/YsTg5off10NuDJWWWtfBPUDpL3W+ucjfzxxvMQH5CS/41BcaJVYNw28DuVX4l4fDX2hTlMXQf2IbBLJ/CcKqyo2ClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J82AFN4wSluTO6cjgplo3yAjhlBvvaZ4MNT05G3P4pw=;
 b=x/gm9DZYmLw1dgJcKBk5eJeRvuArTx9k+wgN7JeIxPAfYLT+RvGOXzvA94Dc0mslbNjWQFU5ZZ7C8tyAb6jObaLIr6SFl/yYEOpYvhU/yuZ9+jt9kKzDxitUU5ytp6CVTB94NqWm583v7BHUJZ1lWwYeWodDzCOI3PN0BopC8mXRQQcnTte9exV1xC/0knfcDnkdWpHCjy3MH6cuoGVzBKwE+VM3L4yH/+BVA5uk3bVBsmXP376zJ7KR+XWKDKQM8zlorm7MEnBwggeI8tO+o6AoarFZvL4JXqi2ApBsR72ooNrm3lJXQg8ozkwpfW0VQg6v3/OdxKtjwm7HjEA66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J82AFN4wSluTO6cjgplo3yAjhlBvvaZ4MNT05G3P4pw=;
 b=TQ4tKYW/mfgehj64fmw4CNyip5t/IfJtHPZmNJ+kTmmswlLGES8i/yTp7CwTfcgeXXlRBKhonIvqLwaCdtRdi1ZuFMwBhDeq2jCujhsyvfN5CIXC6Y67WcERSDCOT0/kv5vCiCM4dvcuO8jwOrKA1/JizQmQ32eB1yiAAzkVGbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CO1PR01MB6550.prod.exchangelabs.com (2603:10b6:303:f9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.18; Fri, 5 Sep 2025 20:35:42 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 20:35:42 +0000
Message-ID: <a9c7d124-f757-4b2a-8add-aefba7b82280@amperemail.onmicrosoft.com>
Date: Fri, 5 Sep 2025 16:35:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the
 shared buffer
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: admiyo@os.amperecomputing.com, Jassi Brar <jassisinghbrar@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
 <20250904-expert-invaluable-moose-eb5b7b@sudeepholla>
 <2456ece8-0490-4d57-b882-6d4646edc86d@amperemail.onmicrosoft.com>
 <20250905-speedy-giga-puma-1fede6@sudeepholla>
 <b7808a42-aa11-45d5-8c8b-b8ec4fd81b1f@amperemail.onmicrosoft.com>
Content-Language: en-US
In-Reply-To: <b7808a42-aa11-45d5-8c8b-b8ec4fd81b1f@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CO1PR01MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 951be2e9-e8a7-46ca-3684-08ddecbbc832
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ymh5SXdVM3JhOW1FSWI4WlhKYkljUXlMVXNOeCtnMFQwZ0NDczJUZDljblo4?=
 =?utf-8?B?U0lIc0J1Q1pjK3FhM2VNOUYvNmRnRnBPMFFFU1ZTQTJtbFdUTm1RNVFFUVh0?=
 =?utf-8?B?a2RkZDN6RGhZb1EwN0JhYVhDeTVYVGVhTWFaZU5OT3BwdjdZcWFhRFNtdlV2?=
 =?utf-8?B?a3JlZkM5eFJUOUdQM0hDaVJycmRUQWorQjFrMzJYNklOaGNucDhXOXpQUm5k?=
 =?utf-8?B?cmU1OHQrUEY0TEdKUUR5MHM0ajdoS3VIQ1IxL01IWEVlYnZ2OU5FUDdZZzA4?=
 =?utf-8?B?eWZGckxRQnhkL1FZdXdLRGlhMWdYT3FxbHk5N3FkdUFpMmJybi9pMnhVMGdJ?=
 =?utf-8?B?ZGRVNjhKSG1LazlSQTVkUkdTT0F4djc1cHgxUnY3UWFRSmlVMmNpWGR0QVdj?=
 =?utf-8?B?aWZMUzRYYk1JOGxNSTA5cjdDMGpPeTJBWnYzem1WK1piTmRtMDRwTXd5amhu?=
 =?utf-8?B?U1I4d0JZK3gzTFZzNm9DUUEzVnN3a3JyajhvSG00OG9iY1B5NWdUbmJxUWYx?=
 =?utf-8?B?dDI1M1BKeTYrd080SnJ5L3RlVG1kTW5ZRXBTanhzQ25oVXJLZ01IRjZvVW9D?=
 =?utf-8?B?c2NkVDA3TURHRlNRK1ZTa1FZN2VYb1BKWWI5aUJFczV0WFluQ3h6My84OTF6?=
 =?utf-8?B?OWhSdUxBVDQyTlhiU3Y0YnRYWHRHQ1dTN2hsWDZ2b0tQVk1RWGgrazQ0ZmlX?=
 =?utf-8?B?NGUySVh5M0FpQjVpMXJocC9zVWFpUmdwK0lrQldlK3ZLSm5kRjdQaXJpelA0?=
 =?utf-8?B?OUExb1Rsaks1Z0JZMWZIcW5vd2FHSjdtaGhZSlBuZ295UHEyQWFSeGp6V2tH?=
 =?utf-8?B?SUcvWUlPeklIeXlVaWRvakpyTGN0YUwyZzl2bkpSV1dKMldWU0JvaXRDeE5m?=
 =?utf-8?B?N21FeFhRYlZjbWVxaHZKekNNTHU3RGRaZzZJbFd3VFF4UGhSQm9GWG9mWXFV?=
 =?utf-8?B?bTlvbVFEUG5kdFFQRXIweWYrV3VyNVo0NmNxU0w5MjE1dFRVajdZQ0xDaHVU?=
 =?utf-8?B?Rkl1alNlcGZiQTQwbWUyZnpDVWRuLzEzOWErV2dqMzRZMEpZbTc5SDV5NTZx?=
 =?utf-8?B?SUFMSHVocERpSWt2eG9HYU9PZXkrMEFzbjArZTczelJDaWhYNlhIYjUyYkRk?=
 =?utf-8?B?TG9JNFZoNFBZdzY0QmU0dm00b1U0dlY3d0VEYzJVaW9ZK0hRcjlnU1pUems5?=
 =?utf-8?B?UWpRczk3OTIwY3dwWTVzNW5LU0ozMEttZ3hzcEpwd082Rkd4MEltamNQZnQz?=
 =?utf-8?B?T0twVU1xZENTUzlOTTN2K3QwNWpKWXhsU2NZcVJnTzN4R1JkUk15dE9SRDNX?=
 =?utf-8?B?WVJqZ2x1OWFKd0QrZHdnZGxOUytKSDlpZ2FQclhOdUhsNGtYZmVqSTFsL3k1?=
 =?utf-8?B?dkQ0OXZKM0paK3VPbWVmQjllL0JCWldxM1pTT3paSlNSN1RmazZPOEc0TEli?=
 =?utf-8?B?cDdtS3VaYjB5SHlJdlFzNEdkQ2s3SkVKdm5UWUVYU29pV2tBdmFCRmc5VlRr?=
 =?utf-8?B?bnJwSUxxdE5zYmp5Wm1YaFZOVE11NXlkMUdvaWw0NFZGejRhNnZIVmc1ci9i?=
 =?utf-8?B?WDRMc0NYeXRkMUJIdC93MjdHazk1R3dybjUvemhiVFhnUHpzRUZQSGVFeTBo?=
 =?utf-8?B?UnBCK0EwNlRZSXNRTW0vQndUL1ZZREFJSExoN2tOMUhkSGxZM3RFZUVodnNr?=
 =?utf-8?B?dUlRZ0VPd0t3QzUxalBQbTRucWYrazlMK1Y3dWl4MW1nZzd1SmFwN3BrVDB6?=
 =?utf-8?B?Um9qMGE1WmQwTUV2cGZHWTljeGVjSTJmRVBpSXUrWk52V3RWZCsyL041SXl2?=
 =?utf-8?B?bkJDZFVoTWxEZ0NxY29iSmVYRVljTmVyL2VpUkZINXJuSkNYVkYzcWE1d0p1?=
 =?utf-8?B?a3lESjFkWDhucWRDNHRtVis0ajJCdzdVUjVUdDc0Y1VBeUlxdkNSUlBUT3Ez?=
 =?utf-8?Q?quEtUEwGpog=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWQzdE42RFNmaUx0cmlwNmVuZ1hodFRrVjVwSDMyejhuTmo1RVNNcVVMRFkz?=
 =?utf-8?B?OVg0Vlo4N2xHcW9KZy84bGpyVGF2R0RVUkJIRFpiREN3eVgwbURKdDFjRkkx?=
 =?utf-8?B?UDFWQ0h1Y0tQSHpvMVhhSitCZHEzR1gvUFJQVGU4MHJtNFBWb0FwVU51YmFr?=
 =?utf-8?B?dVQzRzlyMlQ2YkZ5eHZJOWpvR0NLQzlxMW1HN2ZycCtacGRUbVFKYjVydVNt?=
 =?utf-8?B?L0sxQVJSbGF5dDdyUjJEK0ExS3RFTGNGb280VE54NGl4K1JkQTdpU2dnNFh5?=
 =?utf-8?B?czNDSFczTXJoM252RktvczlkZWFEdmd4WXY3ZlZlR1phdE8xTzFvUko4bG1O?=
 =?utf-8?B?SjV0K1RHWHZYK1pBWDUvWmZVZ2V6Mm9SK08xTGF1NXlnVmQ4anR6QnFoenha?=
 =?utf-8?B?Tk82ZVdnRFgvVW5FZyt4VjZieERLNDQ1bTRoQzFSYmxMN1NVRFlpb0tyMCtr?=
 =?utf-8?B?UDdpbGEyc2wrRU1MT2h5NnFXd01CRit3RUpTOTgveXpxRjlDZ0djZ1hVdmZO?=
 =?utf-8?B?K2hHbDUwWUNlU2k3L1NnV0lITzJNSXkzSmpBT1JsN2RiamZzRWNxNitweWQ5?=
 =?utf-8?B?UFdsb3JNRk5xRzFjYitNNDZ0Wi9oVStsekh2WU9NbTlHbkRoMGFLYmRJQktp?=
 =?utf-8?B?YmlhRmpobHh5bzhWV1J3aFY4eFg4aWY3ZVhGVDZtOHlsd2xubTNSVGUrckZJ?=
 =?utf-8?B?MURlTU8vVFF2NlRhOHlpNDFoODNrVm9zUElsZWJwTGt3RFM1bzUwYUI5TC96?=
 =?utf-8?B?dGgvRytTVjBKbWhPTlhNbmoyMmdQK050aHJtcXdYVSs2UzN0Sm05M0o4cUQx?=
 =?utf-8?B?bjN6K2dabFVLZitGNkc5Um9SZDdxQlVSVHRjZ2ZjTUtMOEVVVkloM3lZNllL?=
 =?utf-8?B?aklpYVBjRE1NM2hFYkdCbEVBSUJ6NFVzQ2dtSm5lUklGVm9BejJoaDhaeUcz?=
 =?utf-8?B?K3lhQW1RMDg5Q0FEWVNrcHBvYWo4MjJWSzJJamZOQWxDUC9nbWZLNVFLRmxW?=
 =?utf-8?B?eitMMTh4UEhxMkN5TlZ0ZHJ3OGJ6N2c0blhNWUYzQXZmQTRaSCswTzI0cjBL?=
 =?utf-8?B?VUF2d1hiZWpCUmhlNkQ5ejcrME5XTG9majA1T3JRUUtnSHRkbEpsZUJmaUNB?=
 =?utf-8?B?VlJjcExFSTdGNkpJZ2xhelozY3JMdzJrL2FINFBFTzlLRmdKamZIbk0rTXhz?=
 =?utf-8?B?NDhQRFlMTnFUM3RRQTBULzRDWndEZEdVa0VOSGZua3VaNHZCWG05eGt5VkF3?=
 =?utf-8?B?KzVYWVpSMkRxV0crYit4U3JqVElrZmZSb21jUnhFQkE5RG1MZmJsVzFhVFhN?=
 =?utf-8?B?SjhRbWtaTUFWV1Bwd1NKcU01b1NibHcxL1Q0RjU3UUltQzcxN2lkOU03UWVs?=
 =?utf-8?B?YVZleWloTHpWbFRZQnl5dzZWWkRpT0s4cUpCbVkzOXBYUkMyeGVIc0hkRkRj?=
 =?utf-8?B?WlBzUGJpWHV5bXVNQzBMTHBkeDJyS0xNZEJyZ2pjMmRFdlZTaytPdkxBOUJL?=
 =?utf-8?B?bFlOeGwrVVp4OXB4YjVUS2U0YmNFbVh4OTJQc2Q2UHc0b1gxcm9CbjRWQjVu?=
 =?utf-8?B?c1MwRlY4RWswYkdIY3ovQkkvSkpEV2VKTmRWaW5CMHRWb25wa01BOEoyOHQy?=
 =?utf-8?B?dVVsbGpFYVozWnVra1JlcDJIb09MWTljWG8yUmlIQ2V5TEpPRUdZOFJrNWNr?=
 =?utf-8?B?Q1p3ZExINUFvVzd3TEVJMVA4U3R1Q3BXY1FTTFloTDZXUytSTWxRN0xIZlZN?=
 =?utf-8?B?UmwvNkNDT0cyNnhVcDNaMUR4b212VkhiUDQ1QjYwb25PZG1lc3pka2tDQy8y?=
 =?utf-8?B?Y041c1RKdy82M0k2RFFsV1l6V2tVK1dsd09TSXE0QXRidW9TaHNLUGF1T2lE?=
 =?utf-8?B?aE8yckVjME02N2ZRS1UzTG1kSnhhbU9GQjQ4T1BWenFLbStjVGUzK2Y5Y2la?=
 =?utf-8?B?bHA4ajdEUjcvdGRiMDZrNy8yY1Uzc1hjcXFPYkxqZFNYYTJUeFNJL0c1MmFX?=
 =?utf-8?B?Nm84T2UybGRTSWZkOTVWZ3ZianVZeEpBdGdqbW9DckVqNGFPMk1RWHZQVzQ0?=
 =?utf-8?B?VWxGSjBzTEJlQklLaDc5YkFTa2pNOUZObVpML2xpcGRKR0ZRZEM2MU8wa2xa?=
 =?utf-8?B?ekRwenNaeUE3NWl6bzFVS3A4MjdBWnZNM0VFRVcxUHJYbFRtMnNGeDhRamVV?=
 =?utf-8?B?VG1ORWl1Vi9VZGJ1TjJRRmxYWHk2U25TRWIzWm01YVNybEo3Tm1qMGR3dXJo?=
 =?utf-8?Q?tY/u6iZmPLxNZZOCO8g6CJz3xgm6laRmaaU5Bv6nuo=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951be2e9-e8a7-46ca-3684-08ddecbbc832
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 20:35:41.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9xaeOFC9EUIc/6jHfPyCKgCMA2SX4452q8bb4cLoGfuquq3vhXvR5TllmKsRzO67LbnLkCa3X2dy8iWY5KPzUAUYkc1b2LngnfZfhtVUCeBl9tLtLyIaaVg4LjfFmRH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6550


On 9/5/25 12:57, Adam Young wrote:
>>>> Who will change this value as it is fixed to false always.
>>>> That makes the whole pcc_write_to_buffer() reduntant. It must go away.
>>>> Also why can't you use tx_prepare callback here. I don't like these 
>>>> changes
>>>> at all as I find these redundant. Sorry for not reviewing it in time.
>>>> I was totally confused with your versioning and didn't spot the 
>>>> mailbox/pcc
>>>> changes in between and assumed it is just MCTP net driver changes. 
>>>> My mistake.
>>> This was a case of leaving the default as is to not-break the existing
>>> mailbox clients.
>>>
>>> The maibox client can over ride it in its driver setup.
>>>
>> What if driver changes in the middle of an ongoing transaction ? That
>> doesn't sound like a good idea to me.
> It would not be a good idea.  This should be setup only.  Is there a 
> cleaner way to pass an initialization value like this in the mailbox API? 

My initial idea was that we should use the mssg pointer to dictate 
whether or not the mailbox should attempt the write.  If the client 
passes in a NULL pointer (and they all should, with the exception of new 
ones) then there is nothing to try to write.

But at lease one of the clients seem to set the message, and I don't 
think there is any really good reason for it.

These are  the drivers that explicitly call pcc_mbox_request_channel.  
There might be other drivers that use the mailbox and request the 
channel through the mailbox API, but lets start with these

drivers/acpi/cppc_acpi.c

drivers/hwmon/xgene-hwmon.c

drivers/i2c/busses/i2c-xgene-slimpro.c

drivers/soc/hisilicon/kunpeng_hccs.c

drivers/devfreq/hisi_uncore_freq.c


For example, the last driver calls:          rc = 
mbox_send_message(pchan->mchan, &cmd);

There is actually no reason to assume that the doorbell will be rung at 
that point:  the cmd object is not null, and thus gets added to the 
ring_buffer.  They then have to poll.  The poll may timeout, but the cmd 
pointer may still be in the ring buffer, and get sent on the next 
message.  But there is no benefit to sending the cmd object here, as the 
ring buffer pointer is not read.

slimpro_i2c_send_msg same thing.  The message is a 32bit value. None of 
these calls actually make use of  the PCC buffer: there is no PCC header 
written etc.  You could argue they don't actually meet the protocol 
definition.

Here is drivers/acpi/cppc_acpi.c

         /* Flip CMD COMPLETE bit */
         writew_relaxed(0, &generic_comm_base->status);

         pcc_ss_data->platform_owns_pcc = true;

         /* Ring doorbell */
         ret = mbox_send_message(pcc_ss_data->pcc_channel->mchan, &cmd);

If, instead, these drivers did

         ret = mbox_send_message(pcc_ss_data->pcc_channel->mchan,  NULL);

You would have proper functioning, and the void * mssg parameter could 
be used for the drivers that actually need it.

All of these drivers would have a simpler code path if they called the 
function pcc_send_data directly, without putting values on the ring 
buffer.  That was how I originally wrote my driver, but I actually want 
to make use of  the mailbox abstraction, and can use the ring buffer as 
rate limiter etc.

So, instead of going an changing the other drivers, I provided a default 
that left the existing behavior alone, and only performs the 
mailbox-assisted-write if the flag is set.







