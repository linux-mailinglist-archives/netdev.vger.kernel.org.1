Return-Path: <netdev+bounces-218417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5731B3C5A1
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 01:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4F717E78B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 23:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35346270542;
	Fri, 29 Aug 2025 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="n1QpJ4SJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F92609D9
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510646; cv=fail; b=YzqCyopKLZUqKzJlBSXOwUxrPPzrF2u1kA1Wl1C50H2vlff2RqKH+yR4RGGbUKcWRbFesn4fuK6HwUgGj5q+YLakm822GnQcmdBE0wCW3KphWGZehtBn6RgDrLoG0amtfBElR8q0joAasnf3gYYGEm9NSBxgpVdsai3ePH3YqUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510646; c=relaxed/simple;
	bh=+7hZFRtYXowy4gWGRzJ+YX82V5uB8NCE+fMh1u3bCqE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JNFWWe35jGiGduFT90QeJYnUgsK11P/VEwL5KSZqVlI11YYhih7oktJfODO9aP9GT4OT93EB14YPIlETWr70A4KN1K4KCd21Sf+DNBg1QvRqsDK7hUlXJL3IwD98Zlu+heS34AGU6MuxoERVTobmQJSQbUtkyMnHehovEnHNufE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=n1QpJ4SJ; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1756510643; x=1788046643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+7hZFRtYXowy4gWGRzJ+YX82V5uB8NCE+fMh1u3bCqE=;
  b=n1QpJ4SJSsfOthGt8roMTU+TYdTY+SnRtkhPlIgPCFb1Co/9HgkaXw97
   qOaX+e8n5vBwu3jucYqq7XoraH2VPzrjsZ/bKFzZO8iZUqVRAdsu4DT7A
   q5LM8wpuUqiepEO0m2BeUtfWAab4u8+GZOZWceVO5hqdheBrBZNvAB9Vr
   k=;
X-CSE-ConnectionGUID: HQ/r9P0vQYay+1lO1zNIKQ==
X-CSE-MsgGUID: UdbcY67STCe9yfcECM9qOQ==
X-Talos-CUID: 9a23:lYQeYG42OVTmOWwnhtss1HdTAJEdKmPk/X7BYBa8Lj97bpy2cArF
X-Talos-MUID: 9a23:p0ktUQhoul4zL0j7zLeNuMMpCcti6JXwV3sxuphXqsePGAdVai66tWHi
Received: from mail-yqbcan01on2136.outbound.protection.outlook.com (HELO CAN01-YQB-obe.outbound.protection.outlook.com) ([40.107.116.136])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 19:37:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zt47ZeCRaFGr+LUHNLUYG6H9p1yYjRtvWBTkUnJdZrnh1bELX0bwX4hXspkQ8bAMv6I3pw3ugXB2769MqcOrAwQLR7KupQUHm7nmsziSis1X2fRtpy0U0O1rcEfVI4auuLBWd+u3dR+ddLT5zC7jZoKgpq0tiUo7l6Rkd/lew8isKzCIS+gL43UmtkxzDxbMd8uBaOr8eMBiWGCyuPZ15zvwlrEQu+Kdmr500gpHrbkSNw5t4iB6LkIOS7vIEuUsuyimxUKd7DGnNVQifi/uMaIGay9S84BRApegzvrKxeyYNK0K7tm5e6BrMeXFe+DQ+9+NvYE584Zn0rmIBkWR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TI5wwSx366K5sEWi4EBsHyawj5MZNwlpRtzsFEAukKc=;
 b=uS1TzzZbk2KGGCpr1WAezJZ8wxSc+ZkXhNnPx+cU5qTqOHkQp/W6ZCSkAIhgCVlmoDDal5eAeqgtf7ftEVz+leqep5+WvmrsJ/p3GlAXLdb9uy6wbSipx2kMDMkhByucWKrlfiMV//qxyC8DL2spciVkuU0LpCs8+HmIBWAvD93kQfAPAO+o06UC4qDnDa4hBsaMjiz+3ejbURxIgcqs3XDknVt1BJGQ8orO4+Ha3ENXZAOgog1lpZuo9jKVA75Upg7zdsbe0IldW0a/KniyikGilq52Hr93Eyaq/0zH1+b6biBBIPj8xmCv9Fa9aFJOY3HTLmyVGbNkA70iqilnjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT3PR01MB5697.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:65::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Fri, 29 Aug
 2025 23:37:18 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 23:37:17 +0000
Message-ID: <f62085ff-ab39-4452-8862-7352901f1d86@uwaterloo.ca>
Date: Fri, 29 Aug 2025 19:37:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/2] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 Joe Damato <joe@dama.to>, netdev@vger.kernel.org
References: <20250829011607.396650-1-skhawaja@google.com>
 <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
 <CAAywjhTx7v8fNiimqU7OiBv-8F23k2efXMTsRbXCi0iF3SDQKQ@mail.gmail.com>
 <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca>
 <63ff1034-4fd0-46ee-ae6e-1ca2efc18b1c@uwaterloo.ca>
 <CAAywjhR_VcKZUVrHK-NFTtanQfS66Y8DhQDVMue7kPbRaspJnw@mail.gmail.com>
 <101a40d8-cd59-4cb5-8fba-a7568d4f9bb1@uwaterloo.ca>
 <CAAywjhRbk_mH16GViYqOh4mphBzQWPb+DGHAycMY4JYmkaLR=Q@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhRbk_mH16GViYqOh4mphBzQWPb+DGHAycMY4JYmkaLR=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:335::26) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT3PR01MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa32920-c545-4cfe-2b1a-08dde754fd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFN2OGNwWjF3K2s0RlNiQTlJNWFCOWdSaTc3eEs5VWF2RlFubkIyRitTcWNs?=
 =?utf-8?B?SXEvMTNKVnBWRTlHOHRyeHp1TThBOU1HU0ZZUmd2Rk1hWnhLR1Nkb1Fubit3?=
 =?utf-8?B?VUpkOS8wTGVUTDJld1JwdDVjM2NNWW1xcGF5YTdZRkRvbE1CTmMyME9lL1Zr?=
 =?utf-8?B?bmNDWTA2WWNIRDNLMHJNVzdidVkxOVkwMTJVRFQ0YUFObVdKMWlJOElPYzl4?=
 =?utf-8?B?NGFRR1haRGhPUFBoQk9ZUDI2aEhWOVdnakh2SGpFZHZxU0U0bDc4azBSWU5C?=
 =?utf-8?B?bFJiZGhNMGxVdVFBTmdzTVVBWVFHVnJUaDcvYXdZS0pScmxUMTlOUUtLOUtj?=
 =?utf-8?B?R1RCZjIxcEJRZHhJb1Framg3aElsTG96MkNWcTdUZGdZeVljSkVOSmJ6blpR?=
 =?utf-8?B?U0JiWkkrellYS0V3QnpGWlJGRXdCRThqM3MvQXY1RC9oc2RSdTJ1TCt5RjlQ?=
 =?utf-8?B?dmhQMlRwd3Y5b3FGbzE4d0EvQWx2RXBUengzM2NnSUxnM21YbEpUMlhQeEly?=
 =?utf-8?B?b0o3VU0xeXJHY1JUNlJlRENZaVJkcE5LazhGMWk2UzJMZWxQWGdLRXZRVFh5?=
 =?utf-8?B?aTdCbTNURDRQSzFUUjUxa2wvWTdSNWZIWTJrWnVwNVBNRzdZSXhCZlF4RDRP?=
 =?utf-8?B?WEJzYS9VLzhyTEQ5Zm5rbDFBeHVWd29YN25ZQnREUGlhY0FidllMUjJ0a2x2?=
 =?utf-8?B?bzh3TWhNL0lrRm4zS2E3Z2pUTEhNR2g2MlVCRWdpTmViMUpmemFZVVdKYS9x?=
 =?utf-8?B?R0FZbnJVdjJvN3lzK2VtbGtQMGtQWFR5dWRUMmI5NDlZK0Y3aFFjY0Rpd0Q2?=
 =?utf-8?B?MkhOYXA1YllTUkVyYUVhV3p1NkxUUWhUeS9IQnYzRDdxYjdFYmtWenZMN1k1?=
 =?utf-8?B?cTBmQ3lTZzBoOURZTE1nckxydjdBUE5CWUg5WUFWNmN1OWlYR2d6OWxOMU16?=
 =?utf-8?B?bzYwQUgzZDVyb2M0eHhMQ2JObUVqVjhXdWVzNExTOUVVcG4rcUdTYitlUkYz?=
 =?utf-8?B?U2FqMVhlV0M0MHZ6VmJZcnRIdnYyU3h1QWVDRW5zY3FWWVRybUVNUGN0YmRZ?=
 =?utf-8?B?TS84T3VaZzI0b2JWL1N6NTd4YmJqaklsNTdaeGJuWUVWL2V2dEpkdUdiOTBN?=
 =?utf-8?B?TWJTZ045Y1IwOWxXVUtBT1dxazdkMGZya25YWDdqV2J3SXNURjg4V2JNZTQ3?=
 =?utf-8?B?Y0cweE4waFpoakR3T1VwZ3pwQjRvY24vOEE5cmJUQXY2SExIUDdMT1k0MkMr?=
 =?utf-8?B?aW9rMUN6dnROY3hhRzAwU2J2TGxqblJqa0gwVHZxZFZsd1ViRmU0R2lUNnZN?=
 =?utf-8?B?MU1RTUtXQzNxajluVVVkSVZnS3hZWUZpTXBLYmwzdW5udzAzbnNGVkJjenJ4?=
 =?utf-8?B?bzU2MUlmQUZsanYwVUxQSFRUeGFub0VnZnBsdnpXV0ZobFpVNGlUbmtTM090?=
 =?utf-8?B?d1h6a2x1WjJ6eHN0UzRHd01zL2h6aDNhdUtqYW03NDRrbDgwWi80ZDg0Rnc1?=
 =?utf-8?B?azU0ZWF5MUhSWFJObHg3RkZGTXFoUms5NmxQS1E0eGNZS3RrUXo4WndsNE5j?=
 =?utf-8?B?ZXBlVnRXdzNSbTVIZUVjcVMvVHZmQ2ltWDBPTVlKcERqM2ZRNWIzYkZaUUNG?=
 =?utf-8?B?NHBMVGJ1bVZDY1crZHYxSTJUTURaeUJucFFSZnR4WW1sVGxPWWRuWEFtcnFW?=
 =?utf-8?B?eUhWWXprV212T2wrR0FUck1JdmdoMnRjL0w2T1hZSGV1Y3pieUxqbnBiNEd3?=
 =?utf-8?B?SWxjaGM1NGJVMnBRWEFFVzZISGlpUzdxS3paMDRZc1JuY1dXS0RGT2tFRVND?=
 =?utf-8?B?ZDdGRE5rQm1CYURqNGQwME92MzVpbDlkNzVUM0xKdDkrV0ZqQ0hRcWljaDZk?=
 =?utf-8?B?RDlGRE55OWQ1U0hnUkkyUk1YTDJvMkpXblZJY3o5d2loOFJCaUJBeENxTy9L?=
 =?utf-8?Q?ApBLDQBZC2A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1NUcmw4VlRST1hKcStoVUNRekJtdmtHODAvTHBDOTRCd0dBMXhMRHRFUFdt?=
 =?utf-8?B?VnMwMUZxNTh3Wko1bDlUR1g4Uk1vcjdmWWdpbS9Pbi90MlhucFpDZUt5cWc2?=
 =?utf-8?B?M3JSNzhBemVmT2x2SER0a1N6M2hMZnpNMk43ekM2TXJyMGFzVzl6blRhOGln?=
 =?utf-8?B?b1dCVWd6K3AreHBadmFsSFJZNnAwOXptS3YwZlpkVVVNaWNuakE4RHpEalQr?=
 =?utf-8?B?aW5HRUNUUmdJelkrR0dvUWtteTAwZVVLVFVZdmZ0VHlEMVhVZWQrdHpscU12?=
 =?utf-8?B?S042TkdnMVIxZU41OVg1bnVLbTJ6RkZiRFVKRjdmSFh5VDM1Rm1nUnBxb3hq?=
 =?utf-8?B?dUs1aWtWRkxQc3l0THdnY3BzYk9Ocjlhb0tjQlgzeXcwZE5nNityakxuSlg1?=
 =?utf-8?B?Sm5JeDFKczFQcFA3VEZRWTlmNHdiWGMyeXRnU1QwSW00VG80QlVFWTZSaWVr?=
 =?utf-8?B?b05xYUUwZm9LNTFzOVBOYXAxb0NId2ZOb2ZTbmNIWU0wY21McG43UnR6K3Vt?=
 =?utf-8?B?RWRnOUprZDJ1TFI5MGlINExIZFNIUUptMTZKcEpHM3c2eG1VSjBYSStyM0Vh?=
 =?utf-8?B?Uk9KanNWM0xXbmd4T2QxTEkxVzBXdGY3UEtKQnBhOG8vaHBiVDBxTG9KM1di?=
 =?utf-8?B?U0QzZGVORmU3QVYvQThKODRjeTVWZExkMTJ4Sy9vemZQU25xNkgxcFplQ0Z0?=
 =?utf-8?B?RUNTZUdkOHRaejc5TGIycEs0dy9OOEtsazdSbzYvVElGRVBlQldhR0UyRE9V?=
 =?utf-8?B?TVdTTEhqWHRPN1ppaFJFNktCTUJTYlkzb0dRU2hvaFFzbWZicDU5K0E3VCtN?=
 =?utf-8?B?NjRrbEJNbE0ycnhOWlZTc3psRkFVcUswZWJ2S2tVUUxOZk9ESGc0TThsUmFk?=
 =?utf-8?B?Wll5OFEzWS9JSHZobEpFRVhPdDB0S1JkWWNSTWhSYkxJbFFGS3E4VmVHeHRI?=
 =?utf-8?B?c29Ed0lYb0c5SGM1S3BNTWk1Y0RQUDFjaFFndGtaSGlwd2N5S0w0WFl1clhz?=
 =?utf-8?B?VlNIL3hzVmYxNWNVbTEzQjYvZmFCanUzYmRndXlyYXF5eUh1MmQwelpZRWdu?=
 =?utf-8?B?ejY5R0oxQ2dYRVF2c0Q2VUJyb1ppV0l6N2NYQ1lwcWJCL1dTcDNkNDBvTWhW?=
 =?utf-8?B?Ni9YOVQwbEtrVWlhcEZsRnV0YUZ4U3YwQUJxNUhZaEtkYzNtU2dNaEFibnNM?=
 =?utf-8?B?WXlqYnVPQ0pxdUdBOVgxZG00QVBSMnlFdERvMmhkdjIzZFFzMS9vazhqaWt3?=
 =?utf-8?B?aHU1aWdsWXNKMnZqREZPakUycktYS3JYY3FjY1pzWm55MlJFNC9UU1RWeCtn?=
 =?utf-8?B?bHNsQ1p0ODZjOGFVejEydW50UE41SzA4QmhZRHZ6SzdHRENXdTFYUmhOT1Ji?=
 =?utf-8?B?ejJ1c1pLeE1zRDlqM2Zub01oUWRuK0RiWUEwYjZYaUNDeWgzcS9WNnZ6QkUx?=
 =?utf-8?B?NzNNT0Vmc1hPV1hWcHZaYkhaKzNmOHJ2OEpCN1VtNGdxY1dnUnc2RmVwZXB5?=
 =?utf-8?B?QmRxdUpWbjRkZTJTT3FHK1JzdDVuSzBUeFhTRzZVdHN2c0MyTXlaNmVtaHZW?=
 =?utf-8?B?ODJCcXN0Y0dvQlA1SzNZNjBjcmgwUmVWTzBXVndFRkZkRFMwMC9heDJBVVlu?=
 =?utf-8?B?S2Zxa2IvQTlVUmlvUUh5eU1jWm1mRUxIV09ycVU4aG5FRVd6bkFEeCtTSTVM?=
 =?utf-8?B?Qys4bktHb3NlSmMxdTZqL3FGaUIzSTJXcTIzdnJ5MTNoaUN0TlVGNU1OMS93?=
 =?utf-8?B?R0kvN3RFUXZDemFCeWlaQW4xYlJhKzJGanpVRldPU2JyaENrVHp0Rll3NmlD?=
 =?utf-8?B?UDljZ0g2dWFRQlJaTWtUWnN6VWFMaUh3bjM5WGR3TisrU1hRUjVBZDNqZll1?=
 =?utf-8?B?RnROQTQzV3MvZnBzUzNRT09wb0J2Zm5ONWwyUVo0TUhpN0lGZjhFalBwY2Jn?=
 =?utf-8?B?VGZiOVJWd3AxN3FMbjlKRjQ4ckdJU2VvSkN6a28wTVZtMXFKc29DTVVpejZL?=
 =?utf-8?B?eU9zK3d5RHVWMGRzdTRGRDJoY0dOZ3h0NWdPYkJBT2ZQQ0xwOWhwbVN1Sk0y?=
 =?utf-8?B?d1FSaVowR3FMczRkU2d4YlgyNVBUSG8zSnZyY2JrVUZZQXFTT25rVHZkdUpN?=
 =?utf-8?Q?xVPQrRCL1oKFOpggpHcF8XMhT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lH0v0dTct4eMNFaXJVgsMtOe7VW5R1Zvd85Mq5C72kMPe3Es58LIVfF+yRp8d/xBAmBR+ciP/wWgtqRRz60RDMBMnZLWcOZ+1XGwt7t0f4pL0uhQy9oOC4YUUIRhFk9nxLKkVJaisSfEGr7lTayVXWKMXPTrZvg7CbasGEqzrZAAvANm4RtADYRlvKjk1Qnk48QlBDcq4XQgfNFHUcXB+pjJAl9AO+ulR5q36bHmR9yugqDGeekf1mq/AB34MwIsYYb7nE9p6CItDLG8thfgihjKL9Ayt2nH1btRU4zPTgXwrJMRLMqxy/OHCCF1hbHIL3MBjcdJPm1Re1xJKjlp/GgD4bnFDDTh+HeSu9z1KBBBs9Vt69n6EOeb4ofQh1GP6QHZJF7xuC/h3mPSV/lpyTpAS4vdhj+URe1yF1486Q1EoOQ9Clr5rCHmoyWhlhwdE4xqFEqkkyltkGkOqYGpOtiuaTN6V5fEh3hyNxEKt9tJB54cWRD4YlZY4MVNUW5uzrqJxgznpp4PhScG9kkv7nCxl2cWmgZ6RqYUQmOh8l+zHqesLNNZzwlrbgT1aNopugzHTrh1aOkY4Sos+/aQFXQF0NwOfauZslonymfrrwSvkJ7lvXRdbt6ktchoBCb4
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa32920-c545-4cfe-2b1a-08dde754fd75
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 23:37:17.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUsMcxOFKdkNCcJaSjRsI8BcnfaiocrVzWISW6h/BNw1BRbZvBgA/jzMsyDb87R4tgmT0YiNwebNuv8QZ7NByw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5697

On 2025-08-29 19:31, Samiullah Khawaja wrote:
> On Fri, Aug 29, 2025 at 3:56 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2025-08-29 18:25, Samiullah Khawaja wrote:
>>> On Fri, Aug 29, 2025 at 3:19 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>>>
>>>> On 2025-08-29 14:08, Martin Karsten wrote:
>>>>> On 2025-08-29 13:50, Samiullah Khawaja wrote:
>>>>>> On Thu, Aug 28, 2025 at 8:15 PM Martin Karsten <mkarsten@uwaterloo.ca>
>>>>>> wrote:
>>>>>>>
>>>>>>> On 2025-08-28 21:16, Samiullah Khawaja wrote:
>>>>>>>> Extend the already existing support of threaded napi poll to do
>>>>>>>> continuous
>>>>>>>> busy polling.
>>>>>>>>
>>>>>>>> This is used for doing continuous polling of napi to fetch descriptors
>>>>>>>> from backing RX/TX queues for low latency applications. Allow enabling
>>>>>>>> of threaded busypoll using netlink so this can be enabled on a set of
>>>>>>>> dedicated napis for low latency applications.
>>>>>>>>
>>>>>>>> Once enabled user can fetch the PID of the kthread doing NAPI polling
>>>>>>>> and set affinity, priority and scheduler for it depending on the
>>>>>>>> low-latency requirements.
>>>>>>>>
>>>>>>>> Extend the netlink interface to allow enabling/disabling threaded
>>>>>>>> busypolling at individual napi level.
>>>>>>>>
>>>>>>>> We use this for our AF_XDP based hard low-latency usecase with usecs
>>>>>>>> level latency requirement. For our usecase we want low jitter and
>>>>>>>> stable
>>>>>>>> latency at P99.
>>>>>>>>
>>>>>>>> Following is an analysis and comparison of available (and compatible)
>>>>>>>> busy poll interfaces for a low latency usecase with stable P99. This
>>>>>>>> can
>>>>>>>> be suitable for applications that want very low latency at the expense
>>>>>>>> of cpu usage and efficiency.
>>>>>>>>
>>>>>>>> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a NAPI
>>>>>>>> backing a socket, but the missing piece is a mechanism to busy poll a
>>>>>>>> NAPI instance in a dedicated thread while ignoring available events or
>>>>>>>> packets, regardless of the userspace API. Most existing mechanisms are
>>>>>>>> designed to work in a pattern where you poll until new packets or
>>>>>>>> events
>>>>>>>> are received, after which userspace is expected to handle them.
>>>>>>>>
>>>>>>>> As a result, one has to hack together a solution using a mechanism
>>>>>>>> intended to receive packets or events, not to simply NAPI poll. NAPI
>>>>>>>> threaded busy polling, on the other hand, provides this capability
>>>>>>>> natively, independent of any userspace API. This makes it really
>>>>>>>> easy to
>>>>>>>> setup and manage.
>>>>>>>>
>>>>>>>> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
>>>>>>>> description of the tool and how it tries to simulate the real workload
>>>>>>>> is following,
>>>>>>>>
>>>>>>>> - It sends UDP packets between 2 machines.
>>>>>>>> - The client machine sends packets at a fixed frequency. To maintain
>>>>>>>> the
>>>>>>>>       frequency of the packet being sent, we use open-loop sampling.
>>>>>>>> That is
>>>>>>>>       the packets are sent in a separate thread.
>>>>>>>> - The server replies to the packet inline by reading the pkt from the
>>>>>>>>       recv ring and replies using the tx ring.
>>>>>>>> - To simulate the application processing time, we use a configurable
>>>>>>>>       delay in usecs on the client side after a reply is received from
>>>>>>>> the
>>>>>>>>       server.
>>>>>>>>
>>>>>>>> The xsk_rr tool is posted separately as an RFC for tools/testing/
>>>>>>>> selftest.
>>>>>>>>
>>>>>>>> We use this tool with following napi polling configurations,
>>>>>>>>
>>>>>>>> - Interrupts only
>>>>>>>> - SO_BUSYPOLL (inline in the same thread where the client receives the
>>>>>>>>       packet).
>>>>>>>> - SO_BUSYPOLL (separate thread and separate core)
>>>>>>>> - Threaded NAPI busypoll
>>>>>>>>
>>>>>>>> System is configured using following script in all 4 cases,
>>>>>>>>
>>>>>>>> ```
>>>>>>>> echo 0 | sudo tee /sys/class/net/eth0/threaded
>>>>>>>> echo 0 | sudo tee /proc/sys/kernel/timer_migration
>>>>>>>> echo off | sudo tee  /sys/devices/system/cpu/smt/control
>>>>>>>>
>>>>>>>> sudo ethtool -L eth0 rx 1 tx 1
>>>>>>>> sudo ethtool -G eth0 rx 1024
>>>>>>>>
>>>>>>>> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
>>>>>>>> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
>>>>>>>>
>>>>>>>>      # pin IRQs on CPU 2
>>>>>>>> IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
>>>>>>>>                                  print arr[0]}' < /proc/interrupts)"
>>>>>>>> for irq in "${IRQS}"; \
>>>>>>>>          do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
>>>>>>>>
>>>>>>>> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
>>>>>>>>
>>>>>>>> for i in /sys/devices/virtual/workqueue/*/cpumask; \
>>>>>>>>                          do echo $i; echo 1,2,3,4,5,6 > $i; done
>>>>>>>>
>>>>>>>> if [[ -z "$1" ]]; then
>>>>>>>>       echo 400 | sudo tee /proc/sys/net/core/busy_read
>>>>>>>>       echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>>>>>       echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>>>>> fi
>>>>>>>>
>>>>>>>> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-
>>>>>>>> usecs 0
>>>>>>>>
>>>>>>>> if [[ "$1" == "enable_threaded" ]]; then
>>>>>>>>       echo 0 | sudo tee /proc/sys/net/core/busy_poll
>>>>>>>>       echo 0 | sudo tee /proc/sys/net/core/busy_read
>>>>>>>>       echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>>>>>       echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>>>>>       echo 2 | sudo tee /sys/class/net/eth0/threaded
>>>>>>>>       NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
>>>>>>>>       sudo chrt -f  -p 50 $NAPI_T
>>>>>>>>
>>>>>>>>       # pin threaded poll thread to CPU 2
>>>>>>>>       sudo taskset -pc 2 $NAPI_T
>>>>>>>> fi
>>>>>>>>
>>>>>>>> if [[ "$1" == "enable_interrupt" ]]; then
>>>>>>>>       echo 0 | sudo tee /proc/sys/net/core/busy_read
>>>>>>>>       echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>>>>>       echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>>>>> fi
>>>>>>>> ```
>>>>>>>
>>>>>>> The experiment script above does not work, because the sysfs parameter
>>>>>>> does not exist anymore in this version.
>>>>>>>
>>>>>>>> To enable various configurations, script can be run as following,
>>>>>>>>
>>>>>>>> - Interrupt Only
>>>>>>>>       ```
>>>>>>>>       <script> enable_interrupt
>>>>>>>>       ```
>>>>>>>>
>>>>>>>> - SO_BUSYPOLL (no arguments to script)
>>>>>>>>       ```
>>>>>>>>       <script>
>>>>>>>>       ```
>>>>>>>>
>>>>>>>> - NAPI threaded busypoll
>>>>>>>>       ```
>>>>>>>>       <script> enable_threaded
>>>>>>>>       ```
>>>>>>>>
>>>>>>>> If using idpf, the script needs to be run again after launching the
>>>>>>>> workload just to make sure that the configurations are not reverted. As
>>>>>>>> idpf reverts some configurations on software reset when AF_XDP program
>>>>>>>> is attached.
>>>>>>>>
>>>>>>>> Once configured, the workload is run with various configurations using
>>>>>>>> following commands. Set period (1/frequency) and delay in usecs to
>>>>>>>> produce results for packet frequency and application processing delay.
>>>>>>>>
>>>>>>>>      ## Interrupt Only and SO_BUSYPOLL (inline)
>>>>>>>>
>>>>>>>> - Server
>>>>>>>> ```
>>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>>>          -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -
>>>>>>>> h -v
>>>>>>>> ```
>>>>>>>>
>>>>>>>> - Client
>>>>>>>> ```
>>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>>>          -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>>>>>          -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
>>>>>>>> ```
>>>>>>>>
>>>>>>>>      ## SO_BUSYPOLL(done in separate core using recvfrom)
> Defines this test case clearly here.
>>>>>>>>
>>>>>>>> Argument -t spawns a seprate thread and continuously calls recvfrom.
> This defines the -t argument and clearly states that it spawns the
> separate thread.
>>>>>>>>
>>>>>>>> - Server
>>>>>>>> ```
>>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>>>          -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
>>>>>>>>          -h -v -t
>>>>>>>> ```
>>>>>>>>
>>>>>>>> - Client
>>>>>>>> ```
>>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>>>          -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>>>>>          -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
>>>>>>>> ```
>>
>> see below
>>>>>>>>      ## NAPI Threaded Busy Poll
> Section for NAPI Threaded Busy Poll scenario
>>>>>>>>
>>>>>>>> Argument -n skips the recvfrom call as there is no recv kick needed.
> States -n argument and defines it.
>>>>>>>>
>>>>>>>> - Server
>>>>>>>> ```
>>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>>>          -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
>>>>>>>>          -h -v -n
>>>>>>>> ```
>>>>>>>>
>>>>>>>> - Client
>>>>>>>> ```
>>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>>>          -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>>>>>          -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
>>>>>>>> ```
>>
>> see below
>>>>>>> I believe there's a bug when disabling busy-polled napi threading after
>>>>>>> an experiment. My system hangs and needs a hard reset.
>>>>>>>
>>>>>>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) |
>>>>>>>> NAPI threaded |
>>>>>>>> |---|---|---|---|---|
>>>>>>>> | 12 Kpkt/s + 0us delay | | | | |
>>>>>>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
>>>>>>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
>>>>>>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
>>>>>>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
>>>>>>>> | 32 Kpkt/s + 30us delay | | | | |
>>>>>>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
>>>>>>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
>>>>>>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
>>>>>>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
>>>>>>>> | 125 Kpkt/s + 6us delay | | | | |
>>>>>>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
>>>>>>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
>>>>>>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
>>>>>>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
>>>>>>>> | 12 Kpkt/s + 78us delay | | | | |
>>>>>>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
>>>>>>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
>>>>>>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
>>>>>>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
>>>>>>>> | 25 Kpkt/s + 38us delay | | | | |
>>>>>>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
>>>>>>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
>>>>>>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
>>>>>>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
>>>>>>>
>>>>>>> On my system, routing the irq to same core where xsk_rr runs results in
>>>>>>> lower latency than routing the irq to a different core. To me that makes
>>>>>>> sense in a low-rate latency-sensitive scenario where interrupts are not
>>>>>>> causing much trouble, but the resulting locality might be beneficial. I
>>>>>>> think you should test this as well.
>>>>>>>
>>>>>>> The experiments reported above (except for the first one) are
>>>>>>> cherry-picking parameter combinations that result in a near-100% load
>>>>>>> and ignore anything else. Near-100% load is a highly unlikely scenario
>>>>>>> for a latency-sensitive workload.
>>>>>>>
>>>>>>> When combining the above two paragraphs, I believe other interesting
>>>>>>> setups are missing from the experiments, such as comparing to two pairs
>>>>>>> of xsk_rr under high load (as mentioned in my previous emails).
>>>>>> This is to support an existing real workload. We cannot easily modify
>>>>>> its threading model. The two xsk_rr model would be a different
>>>>>> workload.
>>>>>
>>>>> That's fine, but:
>>>>>
>>>>> - In principle I don't think it's a good justification for a kernel
>>>>> change that an application cannot be rewritten.
>>>>>
>>>>> - I believe it is your responsibility to more comprehensively document
>>>>> the impact of your proposed changes beyond your one particular workload.>
>>>> A few more observations from my tests for the "SO_BUSYPOLL(separate)" case:
>>>>
>>>> - Using -t for the client reduces latency compared to -T.
>>> That is understandable and also it is part of the data I presented. -t
>>> means running the SO_BUSY_POLL in a separate thread. Removing -T would
>>> invalidate the workload by making the rate unpredictable.
>>
>> That's another problem with your cover letter then. The experiment as
>> described should match the data presented. See above.
> The experiments are described clearly. I have pointed out the areas in
> the cover letter where these are documented. Where is the mismatch?

Ah, I missed the -t at the end, sorry, my bad.

>>>> - Using poll instead of recvfrom in xsk_rr in rx_polling_run() also
>>>> reduces latency.
>>
>> Any thoughts on this one?
> I think we discussed this already in the previous iteration, with
> Stanislav, and how it will suffer the same way SO_BUSYPOLL suffers. As
> I have already stated, for my workload every microsecond matters and
> the CPU efficiency is not an issue.

Discussing is one thing. Testing is another. In my setup I observe a 
noticeable difference between using recvfrom and poll.

Thanks,
Martin


