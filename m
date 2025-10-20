Return-Path: <netdev+bounces-230978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AA7BF2B09
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 19:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C05324E9C19
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5053F32F74C;
	Mon, 20 Oct 2025 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="TfJ3fnt3"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020083.outbound.protection.outlook.com [52.101.61.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3997B2D77F7;
	Mon, 20 Oct 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980957; cv=fail; b=HqxyzHu3eq2ILih8m++2l1iLe+TVDcuFcUB3gzbaxJJ+0hw8rDQynakrkQxVfOtg6e//0FSQeUBRVLk0DWkNHRPT0Wm3u6uigrzI3E28b/C99tz7ufcibBfyLLi59fn/yeTHKVw0V3aU6SWSMk9n/fuWyxyyQngKDCMXFsrcTEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980957; c=relaxed/simple;
	bh=J8nEYsiA79SLCuCgqckebbwA6n91fIzX60Zs2seEh1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n0/j3caaEbQ6b9OtUq90r3Sgn9ylwq8F5PLy7OS3NJ3NEkrFBl5mwL4OCbt9TP7imA43lcnr0FUhoyb67qIfxJdLYflRTdOCATgJ05gpQCgRr/hG3bivZKNTbJmNvsRz20sK96rtpH4KxbNGYF0yct+SMkLNaRxkxh0Jb+fGAA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=TfJ3fnt3 reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.61.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnjt69IM2fNlv57k8KEx6k8dfc+JRVFT0GviYlOJE1gH34JFyJ7d1oUaZvk7LN9p4gCP3Fe2X8tYf2741MjTmCPlLvOj0r5d9oaW4kewP/KW+vC3f+ASp4rVx5xXZmzzS4DNdx/Ik7+D+UUuw4LoWCCo5p39c4xvntYS0yZpFk58k6rblO2E+EltuqTdDHvS2WkTLuez3I5NZNXmOgJXO68ZnXfz3s21YegQ5PZ+orHqVBdNmPTrSgUPUA+YO3Fh6fwYmS0cZjgpIeBwXu6sInkzCbzChU9MlgcpLO+CqeNOunkEwmT9iOF3BSPeWKn+CJE6Jdk7Njc6XHaxrV/4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF+41/+SimiCJieqEdC063dV45P4gKpJ2/e4/2fIgTc=;
 b=xwbhznIeIMzh8sJSy7015bwSbqaPXdGGd9CWMAf36Y/sVoltGbcbIvRb+3NpUuFy80KmxTTcW06SbNTsk9/FU7o5u4FzjKES10bqLNjJ4LVWXbyWjtviQ4MgIDeQhQF1XD8s7+S/DqzYYvbJ6sicWvhJyH/JPEjt9uajFFaxd4G9mHiYQPKpL58kToxYM5mmexgOf4qWqy1OatDubHS8Qcuo7hsoLOC7G3U08aEkBhJYak1Rq6D/5pE6WK75XaxtMSLXFXEw8peW1xjod6cX/n1HnCERzFqlE1+7YtmejBW4d/MdmcTqLxl3HEw8SsHQGsCydBxVCGEjiMjaaGaarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF+41/+SimiCJieqEdC063dV45P4gKpJ2/e4/2fIgTc=;
 b=TfJ3fnt3gqXtXVQZKHMKyOVhdDLD+XSvaLyrZMYznW+hkUWw9sMkFAghgBYIKBJq5T+Rw3D+VBV7Vx/NC7pkbvzDa6j2a+bv0//ZDEckh679o1xvw161HfHamUnaRLmDwjD9KnPG6L+ERPLvwFbdPrOMPfBrk55NE6lxJyDmOYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH5PR01MB8959.prod.exchangelabs.com (2603:10b6:610:213::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Mon, 20 Oct 2025 17:22:30 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 17:22:29 +0000
Message-ID: <78c30517-4b16-4929-b10b-917da68ff01c@amperemail.onmicrosoft.com>
Date: Mon, 20 Oct 2025 13:22:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 2/3] mailbox: pcc: functions for reading and writing
 PCC extended data
To: Sudeep Holla <sudeep.holla@arm.com>,
 Adam Young <admiyo@os.amperecomputing.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
 <20251016210225.612639-3-admiyo@os.amperecomputing.com>
 <20251020-honored-cat-of-elevation-59b6c4@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20251020-honored-cat-of-elevation-59b6c4@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR02CA0095.namprd02.prod.outlook.com
 (2603:10b6:930:ce::24) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH5PR01MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 0105f25e-9ecf-45ed-d2af-08de0ffd3ebf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0kyZ1I5cUU0U2FMUjYwWlJpSkRHNzNKc0dOZ3dFcy9vSStZVGl1V0NJSjk1?=
 =?utf-8?B?MmdhM2hXVTJzYmkyWHdwOHR0aUkxTjY3NHVqK25JSWlzWXJ4QWgzQlhqTmxp?=
 =?utf-8?B?SW1YQW5jdXA0UWhwUmhuR0ZrYm1hM2ZCbUg1RjFpbXVOcjhXYlZsT2RmZTNy?=
 =?utf-8?B?VnV4Z3ZoLzhoWHJJc2xtRmdaOFJLSExoaEQ5Y1RvdUgrV09hMTU2WWd6N3Zi?=
 =?utf-8?B?ZVMyWEJBNFFHZG5FQjJqUlJMQ3oyb2U4c1g3SjNBT1NYOGMzL2JPM1RUSXpM?=
 =?utf-8?B?eURqZTVZYmt3d1VEOU52U3hsOFVRa2gydEVNL2FyZFlob1hiM1JRWHJEcUlM?=
 =?utf-8?B?U1ZnZFY4LzBGd1oxNGdoMzdvRDcxOFdJcDZMQW9IRFA1em9qUi9vYmZTb0Qw?=
 =?utf-8?B?emJuWjFIZExhemhwWGFxRitZUjNzMDVIdDhnWEJKZ1QwVWNCSG0zcVVieFM0?=
 =?utf-8?B?NTJMb0hKZll2UkhTSkdWaTk4a3g5dTJmN0wyRmNRN1hOdFhIRUcybXJEQW1Y?=
 =?utf-8?B?WTVvQkhFR2ZBRWN6SjVmRzBRN2V4S3NWYmpUYnVJaEtMUk5hSjc2OWNhTEhF?=
 =?utf-8?B?YkVmMlVHNlpacHBuRFRsak1FZkVkSWpmMDJSZmRQbzJBV0FIT3NmWEN2bkNY?=
 =?utf-8?B?OUpOTmhPUTErVXlDTDI5dmxxcHhNSDZUTjUxbmhDbm5CdlRRbDFndWxOU2V3?=
 =?utf-8?B?Qi9HZDhHVUppbHNjckxSSG5sZ2dSRmlqMzdqYmlDdWN0VnFWVzBnTW5oS25p?=
 =?utf-8?B?OUdlNHR6d0tpTWNGUTB4Q1gwS3pEYzE0V3FWSUtYMENacng1ci9QbXdJV2ZX?=
 =?utf-8?B?bm4ycFRyQTg0Q25QRUh0cGVtRVc0U3NBZHVCOWt6MCtNdkhlU2l4ODZFVC96?=
 =?utf-8?B?UVdQSkFJck5rZk85T0pENnBaQ0NXVnREQ3lOREE3V0dpS0ZTYWlabVJncTRU?=
 =?utf-8?B?WWQzd2hzNzlOT0lXUnc3QzRGWm9NcGd5dFhRdDJBQWhxT0d0Y2pqakFiak9l?=
 =?utf-8?B?b2NLWHNrN2FIUGxYYm1CT2UrUk1Eckc1cktuN1BtOU4rZ3l1MVVmTHBHU3V1?=
 =?utf-8?B?UitGWGhRYk9jTG4rYzJVb3ZxUDQ0Y3Z4Y2pGV2JKQ3JSc3I0QWhUeG5NbFRM?=
 =?utf-8?B?cjhuNnJ1Q1lPTU1WWFhxZVZ1Smc1cFNXaGdGWnhqRWVlTVAxVXZVS0pLYTZt?=
 =?utf-8?B?UFp3SHNob0NMVEt4MTVSQVBUVlNCckt0TUJURjhsM0VJODF2OFNJOWVKdVFZ?=
 =?utf-8?B?N0F2N0VkeE84VFQ1c0VVa2ZCVEpIUFd1dmh4MjdZTVU2aDVzY1JqYTNpUWJ1?=
 =?utf-8?B?NGZzeWRkM1RsektlbDJWZGNrT1hDdjlmb3A5am93RGtQTGJYRytwM25kY2JG?=
 =?utf-8?B?TXVCY0p4b1dROEJKSi9JRTh0WTVKNHFaazQ2ZzRMWlNVR1F1N0ZPa3U1ejZ1?=
 =?utf-8?B?Rm9lc0lLMGxYWFM3TG9IdVZNdkJpeFdWVkVJVllkVVBzUy85UGdMVSsxMHpE?=
 =?utf-8?B?RzVYekQ4bjFZdVY4K1BxaWU2bjRTUm9NV2RPRENpOHhjdXhFOUxIbjF1N1Q2?=
 =?utf-8?B?NVZUYWhVbE9jQmRvcytHRjZWSUY3Z1B4MzdiemZRVFVZRVBIZ28vdVBGbDhX?=
 =?utf-8?B?Q29obE9rbkxmUTgxWXZDV3NkU1FkVTh5QmJRcEJ5TGhQVkZiUERQQmFKUWdl?=
 =?utf-8?B?YjNlTlhQaHVUV2dEM1hLbmZJVGZVUk1JRFdsb2d3dnMvblg3RFNQQXJ6eS9i?=
 =?utf-8?B?c0JkOHVlb2pXVThxcEpqTi9pTGtCM2lvT3lPdUQ1QUYrYlhqaEpmV0RCdVdk?=
 =?utf-8?B?YTBWdkpDTVRKd1M5WGhOcWNjMjAreXR4U0YwTGwrN0RBWHVGaG1TWUJiWUFp?=
 =?utf-8?B?VUxRNXVoWm5DczJvMFFkUGV4Y1ZMTUJkelpoYnhvOGJQRWkvTDRrbDBkd0tk?=
 =?utf-8?B?U1dCS2JzdFEyZUw5OG41cWZ4Mk11Y05oSjQ0VkpzMExQNmY1cWNValRKM1N5?=
 =?utf-8?B?RnhrL2VLZ0R3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzB4bUNOdE5sSTFpRm9iZitEN3J3Smt0dENVSTM2c0NhYk1sM2xaUTdSOWZH?=
 =?utf-8?B?TUVQRnVXN1NxZFdtSzY1U3dlblJEanExWDZzT3dHSEh2VWVxQlZLU2tYc3Jt?=
 =?utf-8?B?WE5IZHI0TDQ1QWYwdDJFZ1A3WFRTTUxTRlN3RE4xZk1UMnRaMnVPZ3BOcElI?=
 =?utf-8?B?Yi9wMjRGY0tWQ2JsMnEvYTJiMFp4b2M5bHhaRnQ4ZWZlV3N5U3RlUnNxNktM?=
 =?utf-8?B?MGxUMnkxT3k1eTFHQ2VMdG93c0xBejVLOFlJUlZkOHNoSjRUcG9wTHBrVFl1?=
 =?utf-8?B?b0R3WEV4SzRIYkhjeEJ1TDZSbVFoaEgzWm5JQTFMdmw3am9yQlVXcHU5QjhV?=
 =?utf-8?B?OFdmdnhDT3lzWnhFSmtYYXZvMENvVml5ZG5DL2YvSXNHOHBCWlQ5bTJ2MlV5?=
 =?utf-8?B?M2FKOVVpckxmbWp0VWVzL093R0U0dlJVYU5OaEtOdzYra2Q1djhhdmtkcU9n?=
 =?utf-8?B?YzNSeXIyOVpWck9ibEUzTTFUVlZYY09XV1IwdGd3dDgrSjRTZXZ2em5lMWc2?=
 =?utf-8?B?OXgwTjZjN2kvZDJtTTdtQU1ncmRUSTM1R0k5KzU2VGZIMTU3Yk9rK1lwRUdL?=
 =?utf-8?B?cG5Kd2dlTE8yN1pVYWx1M0kzaE9paTNvMVdIL0swMktZelZLeGhFMjVnSWtk?=
 =?utf-8?B?ZDJIWjB2NkVuQWdiNVFUWVE1NklYZUgySThMSGUvZHhCZ0NhczlvL3RyYXI0?=
 =?utf-8?B?QUpEYkk5ZnhuQ0RTUzY4VVNsTEtsdlRFa1F4NlFPRWVuWWw0N3lQU29UM0VN?=
 =?utf-8?B?OGlhTE5YN091TmZLYllvdEgvMG9Md1c4ZTltQ3lnYjhDWFd5SGVXSnlIaHMx?=
 =?utf-8?B?M3dYK1d4OTBkRENwOHpKa2ZoekpLWG9ReXdvZGY4akZPNjBUWEptbUNsMktt?=
 =?utf-8?B?Slp6OEtjR0xEOXkvZGFqQmRBRE1FZlowK3dVT09ydC93Z0wxdXFFbzlpZmJq?=
 =?utf-8?B?ZGpRdHI5UzNUU2ZtMG9kNitVaHRLbHF2a1dRbGlJTTFWeU14WXoxbzIyZDZT?=
 =?utf-8?B?bjJFVTZtQythRnk0OU9FYlA3dnRjOGQ3MWVNM2VsYVh3aDAvR0txdXIrSXU2?=
 =?utf-8?B?cjNXM3BFektKS2Vja0lvVGVCK3JKWksvY0lydDgya2h3b3lydFEybzh0YkVX?=
 =?utf-8?B?ME5WSHFKc1lHZFZ1VTNURXRNZ1BoYVk1R2FVY0hDd2xpVVlGQlFydGVhTzFs?=
 =?utf-8?B?bUs3THJRaEJhNi9QVVpKTlFoU3lDYko3NUpOeUlhb3JGditRVjJMdi84a1NP?=
 =?utf-8?B?NVVHbWpJREpsTkpWbE9IKzlMendVdGRhb2xWWmlxaVpHcFd3dG82Sk9LaXlT?=
 =?utf-8?B?K0xwdWcxVEFweEdhcms3RWhCWjk2OUU5SlVqWEhjS0Y0V2JWMldnNjgwTHB6?=
 =?utf-8?B?cm9VSzF6NFhtZmtBSHYxMUg0OE1pc2pJdkVadk01Z09BZW5sYlZwV3dCclZK?=
 =?utf-8?B?NjFsbUsvU1JBeVlnNk00NXFlZHE0ZE1YNkJJdDMrdHRKOGJ0WWhwN05xdysz?=
 =?utf-8?B?bXVnVmphS0k0NWMvMzU3dHVWSFdPUzZQeGFaY24wUEFmd2EzYXRDUWk5WWxJ?=
 =?utf-8?B?Skd0U3ZKUFNzTEZ6TVlkd3NBMVJtY21iNDBENk5uNmU1ckwzaHZxbDZteGFm?=
 =?utf-8?B?TUpkdXo5NFY1RDhKQVpVQzhaSkVNc1V2SzlqMUExUFdtTXFCTndYOWlUMnU2?=
 =?utf-8?B?emFjYVlmNUNYYWFSRmp4ZmRzR091cUtTQlpwYmdDTnQzNVVjNiszM3diU3B1?=
 =?utf-8?B?d3Zjck5VZUhqK0xRdVVtZDZqSXlTV0dZNHd2SHBqblgrRkF2dGl4K2hodFlM?=
 =?utf-8?B?dlhWTERPUFlNVW5HaDA4TUlkTVV5ZmQ4OTVaT3VOcWM0OTQzMTRqdjlTRnoz?=
 =?utf-8?B?d2NqZXFJTi9TdkNqM3RvdzlCV2hFM0ViQkM5cEJqLzNOL1I1M2o4Tk5JTC9z?=
 =?utf-8?B?eEJKanEvWDFMa2E2TDA2RzZ1N0FKZVJhNFB5R3dDdmRqUTM5Z3pHT2E5Ykxk?=
 =?utf-8?B?bU5IM0t0T3EzUG13WGlrWlJneTdBUlVpcis4bFIyK09HeEtsWkYxTkk2Qi9V?=
 =?utf-8?B?ZWMrRUd2UkRkaklINVN4bWdUQnRYcHBKTVc5eXVvV2ExQlFtL29GL2ZVSEsx?=
 =?utf-8?B?V0F4ejBBMU01YkY2OEt2YjNnYzFBMlBtUWRReTNER3J4QjBIQkV2RXMwaHRn?=
 =?utf-8?B?a3J4bjlBNFVXazk3N1RTRzZxbThGMUgyTlFoMjBYSDVkVk5rK2pGMEdIOFpo?=
 =?utf-8?Q?buGhpYmkB6bLW3CCkyicm7+gOJLBwiL93ZU3jf3cbY=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0105f25e-9ecf-45ed-d2af-08de0ffd3ebf
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 17:22:28.9405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhFF03jIkzY+t1EymQQjsqTo+I76ONuezIm2YZ9fepx0Is6zfgf+ar5bngLmMoq0mMOpwGBjckuxeOYY3CczAEHfh2xIOOfOdzxoL63tDzRHFojSeyh7KejHhPjCCvCj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8959

Answers inline.  Thanks for the review.

On 10/20/25 08:52, Sudeep Holla wrote:
> On Thu, Oct 16, 2025 at 05:02:20PM -0400, Adam Young wrote:
>> Adds functions that aid in compliance with the PCC protocol by
>> checking the command complete flag status.
>>
>> Adds a function that exposes the size of the shared buffer without
>> activating the channel.
>>
>> Adds a function that allows a client to query the number of bytes
>> avaialbel to read in order to preallocate buffers for reading.
>>
>> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
>> ---
>>   drivers/mailbox/pcc.c | 129 ++++++++++++++++++++++++++++++++++++++++++
>>   include/acpi/pcc.h    |  38 +++++++++++++
>>   2 files changed, 167 insertions(+)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 978a7b674946..653897d61db5 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -367,6 +367,46 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> +static
>> +struct pcc_chan_info *lookup_channel_info(int subspace_id)
>> +{
>> +	struct pcc_chan_info *pchan;
>> +	struct mbox_chan *chan;
>> +
>> +	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
>> +		return ERR_PTR(-ENOENT);
>> +
>> +	pchan = chan_info + subspace_id;
>> +	chan = pchan->chan.mchan;
>> +	if (IS_ERR(chan) || chan->cl) {
>> +		pr_err("Channel not found for idx: %d\n", subspace_id);
>> +		return ERR_PTR(-EBUSY);
>> +	}
>> +	return pchan;
>> +}
>> +
>> +/**
>> + * pcc_mbox_buffer_size - PCC clients call this function to
>> + *		request the size of the shared buffer in cases
>> + *              where requesting the channel would prematurely
>> + *              trigger channel activation and message delivery.
>> + * @subspace_id: The PCC Subspace index as parsed in the PCC client
>> + *		ACPI package. This is used to lookup the array of PCC
>> + *		subspaces as parsed by the PCC Mailbox controller.
>> + *
>> + * Return: The size of the shared buffer.
>> + */
>> +int pcc_mbox_buffer_size(int index)
>> +{
>> +	struct pcc_chan_info *pchan = lookup_channel_info(index);
>> +
>> +	if (IS_ERR(pchan))
>> +		return -1;
>> +	return pchan->chan.shmem_size;
>> +}
>> +EXPORT_SYMBOL_GPL(pcc_mbox_buffer_size);
>> +
> Why do you need to export this when you can grab this from
> struct pcc_mbox_chan which is returned from pcc_mbox_request_channel().
>
> Please drop the above 2 functions completely.\

This is required by the Network driver. Specifically, the network driver 
needs to tell the OS what the Max MTU size  is before the network is 
active.  If I have to call pcc_mbox_request_channel I then activate the 
channel for message delivery, and we have a race condition.

One alternative I did consider was to return all of the data that you 
get from  request channel is a non-active format.  For the type 2 
drivers, this information is available outside of  the mailbox 
interface.  The key effect is that the size of the shared message buffer 
be available without activating the channel.


>
>> +
>>   /**
>>    * pcc_mbox_request_channel - PCC clients call this function to
>>    *		request a pointer to their PCC subspace, from which they
>> @@ -437,6 +477,95 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>>   }
>>   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>>   
>> +/**
>> + * pcc_mbox_query_bytes_available
>> + *
>> + * @pchan pointer to channel associated with buffer
>> + * Return: the number of bytes available to read from the shared buffer
>> + */
>> +int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan)
>> +{
>> +	struct pcc_extended_header pcc_header;
>> +	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
>> +	int data_len;
>> +	u64 val;
>> +
>> +	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
>> +	if (val) {
>> +		pr_info("%s Buffer not enabled for reading", __func__);
>> +		return -1;
>> +	}
> Why would you call pcc_mbox_query_bytes_available() if the transfer is
> not complete ?

Because I need to  allocate a buffer to read the bytes in to.  In the 
driver, it is called this way.

+       size = pcc_mbox_query_bytes_available(inbox->chan);
+       if (size == 0)
+               return;
+       skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+       if (!skb) {
+               dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+               return;
+       }
+       skb_put(skb, size);
+       skb->protocol = htons(ETH_P_MCTP);
+       pcc_mbox_read_from_buffer(inbox->chan, size, skb->data);

While we could pre-allocate a sk_buff that is MTU size, that is likely 
to be wasteful for many messages.


>
>> +	memcpy_fromio(&pcc_header, pchan->shmem,
>> +		      sizeof(pcc_header));
>> +	data_len = pcc_header.length - sizeof(u32) + sizeof(pcc_header);
> Why are you adding the header size to the length above ?

Because the PCC spec is wonky.
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html#extended-pcc-subspace-shared-memory-region

"Length of payload being transmitted including command field."  Thus in 
order to copy all of the data, including  the PCC header, I need to drop 
the length (- sizeof(u32) ) and then add the entire header. Having all 
the PCC data in the buffer allows us to see it in networking tools. It 
is also parallel with how the messages are sent, where the PCC header is 
written by the driver and then the whole message is mem-copies in one 
io/read or write.

>
>> +	return data_len;
>> +}
>> +EXPORT_SYMBOL_GPL(pcc_mbox_query_bytes_available);
>> +
>> +/**
>> + * pcc_mbox_read_from_buffer - Copy bytes from shared buffer into data
>> + *
>> + * @pchan - channel associated with the shared buffer
>> + * @len - number of bytes to read
>> + * @data - pointer to memory in which to write the data from the
>> + *         shared buffer
>> + *
>> + * Return: number of bytes read and written into daa
>> + */
>> +int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
>> +{
>> +	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
>> +	int data_len;
>> +	u64 val;
>> +
>> +	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
>> +	if (val) {
>> +		pr_info("%s buffer not enabled for reading", __func__);
>> +		return -1;
>> +	}
> Ditto as above, why is this check necessary ?

Possibly just paranoia. I think this is vestige of older code that did 
polling instead of getting an interrupt.  But it seems correct in 
keeping with the letter of the PCC protocol.


>
>> +	data_len  = pcc_mbox_query_bytes_available(pchan);
>> +	if (len < data_len)
>> +		data_len = len;
>> +	memcpy_fromio(data, pchan->shmem, len);
>> +	return len;
>> +}
>> +EXPORT_SYMBOL_GPL(pcc_mbox_read_from_buffer);
>> +
>> +/**
>> + * pcc_mbox_write_to_buffer, copy the contents of the data
>> + * pointer to the shared buffer.  Confirms that the command
>> + * flag has been set prior to writing.  Data should be a
>> + * properly formatted extended data buffer.
>> + * pcc_mbox_write_to_buffer
>> + * @pchan: channel
>> + * @len: Length of the overall buffer passed in, including the
>> + *       Entire header. The length value in the shared buffer header
>> + *       Will be calculated from len.
>> + * @data: Client specific data to be written to the shared buffer.
>> + * Return: number of bytes written to the buffer.
>> + */
>> +int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
>> +{
>> +	struct pcc_extended_header *pcc_header = data;
>> +	struct mbox_chan *mbox_chan = pchan->mchan;
>> +
>> +	/*
>> +	 * The PCC header length includes the command field
>> +	 * but not the other values from the header.
>> +	 */
>> +	pcc_header->length = len - sizeof(struct pcc_extended_header) + sizeof(u32);
>> +
>> +	if (!pcc_last_tx_done(mbox_chan)) {
>> +		pr_info("%s pchan->cmd_complete not set.", __func__);
>> +		return 0;
>> +	}
> The mailbox moves to next message only if the last tx is done. Why is
> this check necessary ?

I think you are  right, and  these three checks are redundant now.


>
>> +	memcpy_toio(pchan->shmem,  data, len);
>> +
>> +	return len;
>> +}
>> +EXPORT_SYMBOL_GPL(pcc_mbox_write_to_buffer);
>> +
>>
> I am thinking if reading and writing to shmem can be made inline helper.
> Let me try to hack up something add see how that would look like.

That would be a good optimization.


>
>>   /**
>>    * pcc_send_data - Called from Mailbox Controller code. Used
>>    *		here only to ring the channel doorbell. The PCC client
>> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
>> index 840bfc95bae3..96a6f85fc1ba 100644
>> --- a/include/acpi/pcc.h
>> +++ b/include/acpi/pcc.h
>> @@ -19,6 +19,13 @@ struct pcc_mbox_chan {
>>   	u16 min_turnaround_time;
>>   };
>>   
>> +struct pcc_extended_header {
>> +	u32 signature;
>> +	u32 flags;
>> +	u32 length;
>> +	u32 command;
>> +};
>> +
> This again is a duplicate of struct acpi_pcct_ext_pcc_shared_memory.
> It can be dropped.

Will do.



>

