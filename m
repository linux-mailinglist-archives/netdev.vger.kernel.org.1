Return-Path: <netdev+bounces-218388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB5B3C43F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 23:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15CBF4E1338
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 21:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312628505C;
	Fri, 29 Aug 2025 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="0yjN04TR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A220B22
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502861; cv=fail; b=JH2QFGnthWD6FIOvHJLB5xe7wgBEFvFdofrgv+fOpiX/dNCtjdf8GsFgfWu7ju7LE5qZ7xck7fh7JhRYOlq63spa1+EikCjJKUK3d6QQNkuCZIuZbPC8Lk0vR50bMd09gEUI0OHI5AknsAIyS6mRe7efww/ekHD2HE/MZRrqrA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502861; c=relaxed/simple;
	bh=iXl7EnWVEIgBY7fcuHrXCJlJtAps81ulBFY8Of3N1Pw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q0zVatq8H0K6Jmjt9iUDyVSbD4Ap2e1cLDaCkQOIcNmX1dRrSdtSjpEKIRtmhKRvyPHdJ6vjHZUnSU4DHe7EwiF46ZgLw5xyWODmK62q/fzj/bHjFoezeS/Wv6XpTw7tiG8r8kv5m3yv7WnCbe4S3G5RCxFdeqEuNPEdP2FfPz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=0yjN04TR; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1756502859; x=1788038859;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iXl7EnWVEIgBY7fcuHrXCJlJtAps81ulBFY8Of3N1Pw=;
  b=0yjN04TRubrfbwDkKp/cEOt74FcDhnHprzWIuBEcX51gWS8UtpBArcSO
   E++0LikAyYxUuEMGazVoNKAobmxFRpZrGGgAfZz0VZnntx4zg8y/0rP4Y
   vQ/WO1pyZZgnAGwwNIS4CS3W54rbsolPrHAH6cgbSQTkeuI30fpXzxM3/
   Q=;
X-CSE-ConnectionGUID: PG3REoEjTwqAmBKJG5CWQA==
X-CSE-MsgGUID: Vbu/wZEKRdihzb52mCXWCA==
X-Talos-CUID: =?us-ascii?q?9a23=3A81VLA2jniXSpEFLZtmOhos5KpjJuSlKG9lrXDk2?=
 =?us-ascii?q?EFn9ATZe2a3DN05xdup87?=
X-Talos-MUID: 9a23:10a9mAmL9uaVf7JMIGw8dnpcPtov/JaDK3oBkJUUsZTeMAdABBy02WE=
Received: from mail-yqbcan01on2117.outbound.protection.outlook.com (HELO CAN01-YQB-obe.outbound.protection.outlook.com) ([40.107.116.117])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 17:27:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnbk8eK/uq4OXRtK6BLQGnGRaKs7qIHKafGJT9k8Kvz9zykXxynixcf0KETZUYf5Qu2il1SCiCkhUrWMIFjG7T3MoHV+ktp9uj5ZoKHltzNm9vh1t/w+UatbaJKO21s8QbM8eYueSjXPgQU1SatWybWxrs90Se0HF36lOVQErlc0hhm/OpCMQlvQHY4Us+x/KBSD9KntdNwEHprnq6Hl86kmGdCmGyHZHUzOUH94leGdq9iffn013xVs0qhfwzKPdDT2V2cKFqs8A+74qcbm9N5g6XgyhISwwoPwrFJn0rqJehO+sJIQnzKuzD40bsYXV5x1o49UMQGs5jqPnjWAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22fZ1GPkrnhpIN22odreWQLvmOBK2/2vG8XYqiblfzw=;
 b=nnzNgFDrF+5Qjdd/aRVVWDre0ozMLWhAxhdwtNxOgxVVFjwZ10XIKM2uAYK7g5toAAmvO5gqzIAQiSssHQOt96gPFCz5tpJnTuCfXIhPfYvAe6W7FfpYUJshI+HurufDiVag485Co6kPhshVQUPfXEy3OnGz6YBUpw+GB3DSAfndFTByuvBR6ZRE56Zw5w0ZG/3DXxVpGU0KTdC62N+Ce2JGSDd6Dxzvp1OLWFKd6S9/2Iun6c9mHeq1y1+z58bjYy1CIC5RCai/E1ATTFAMeB6ZpuSyW+6YafJ9QGX3Bwzfldk8Jf2FrEPgGQU6ONxP6lnG85DWdVsLZ3Y++ORK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT3PR01MB10233.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:8d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Fri, 29 Aug
 2025 21:27:26 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 21:27:25 +0000
Message-ID: <0d66c174-32d1-435d-9b1a-5672201dd2e0@uwaterloo.ca>
Date: Fri, 29 Aug 2025 17:27:21 -0400
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
 <CAAywjhQJHNN6MSuioJWo+siV8KDM-7BUQa3Ge+z7-V00KWJhtA@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhQJHNN6MSuioJWo+siV8KDM-7BUQa3Ge+z7-V00KWJhtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:303:6b::6) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT3PR01MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a920e4-b2e8-46c3-7662-08dde742d94e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2I0c3Y0WlZpSjl6Y3VieUVFQkJWcHVJQk9VQm5FQWNZQ2lmaWRLYjNFTlNi?=
 =?utf-8?B?THFuVnJvSXRoUnhPa1U0dEVoWlRwbS9rYXN2bGdLcWlqSEVtVWFDblFaYlhY?=
 =?utf-8?B?aG1SS0QvelBCNVlYWUpVREU2UUlIbS9ETTJmVU1HSjR0a01pQ2RaODQ4Ym93?=
 =?utf-8?B?VTYwaE5WYmtnUWhZejFqNXZidFhhemNJcWlHM0RvY0tiQXpaYmxyUXBHeWd6?=
 =?utf-8?B?QzFhRURuR3BOaEUvc2R4VXQ3OGtHZVluVVZ2eXFXelVrY2Uyd3J1OGd5dXI3?=
 =?utf-8?B?NFg1QmJQY2FEd2lEcjVGaDVlU2QzdU1FQnhXTTB2bnI1eVJTVDdwTllxblhE?=
 =?utf-8?B?WXorODdnZGNEOWdwbTNhMThTaWRkZGpPdFB4ZlMyOFFDSzd4ZWZUbVZOOTNI?=
 =?utf-8?B?SEZLNnpxSkRWbWY0YXZKSlQrYmYzK2xoU1FZSzZBdlB3YlllbDh5T0xLRHBs?=
 =?utf-8?B?SGx3THMzS0tsNUM2VytsZTJZSW9iVVIzdVRxbnZtVHpMNHM2dDRZeTFxM01n?=
 =?utf-8?B?SzJLVndxaU0xSnBleVl0aEl0R3NlWjR3SW9GNWNNN3VsNlkydnRKbmtvTy91?=
 =?utf-8?B?RGs1aDd5dWN5OTFHbHdydll5clo5T3lwVWJ3Tk9UMVRJbGtnK25GbnQ3ODNY?=
 =?utf-8?B?RGRhMSt6Z2NDUjY5ZUUydkFFQnJpUWxZeDZuTHJZOW9mU2VWZkVtR3FYT2U0?=
 =?utf-8?B?RGp0bHBPbUJGcU4vNlI0QlFoVENjWW1zMVpHb0Vhei9mWE1yM1IxOUgydXBk?=
 =?utf-8?B?djdNcWdmV2QyMGc5akx2RmQ2Q1JuUGVTOEtWeWxPbjl6eGxmT293elRHdGo0?=
 =?utf-8?B?bEUzNTl0enQ3djZDRUtRT0Q3ME9VNU1wd3pFT1N0Nm5MaTBBTzZoaTVGVnlP?=
 =?utf-8?B?UzJnMGl4dkEyRVMwTE5wMG1Ma0hJM1JraDFZZmdEU2RnL1paNGVEaHZ1cU5C?=
 =?utf-8?B?Mk1aUGlwYWN3QytObWV4cXBMM1ZGWkxZMC8wekNNWU4rWWZIUjE0Rzd1VlF0?=
 =?utf-8?B?TjljQWE2WWVFNEdzMGYyUXpqZGFQZEIzcGMwVjQ5Yms5ZGRST1RzRzhNMlMv?=
 =?utf-8?B?c0t4NXFXby9nMXhMMVhEdzh2dEo4T1AyM3JDUHZsUnVnNi9mWWQvNWxlSFpL?=
 =?utf-8?B?MjZUcjM4Rk9EZmpBMGxFdU04TkVZTEYrdUNYYWFLdUh4SE0zOWRrZk9PM0xa?=
 =?utf-8?B?dW5aUVNCQkgxTTVHUHcvWkg5ekFMSXZaRWZDOEtmVnVoR1dDMW9hRmpxdjhk?=
 =?utf-8?B?cjh3UFUwY1I4NmVYblJoc2RQVm8yZG44UkxyNm5TLyt6a21CK2h3SHM3SlNP?=
 =?utf-8?B?elBoaWY4WUhIZjBzNjdZcWRTN1JPOUVUSnBHR3J4dzRyOFRIMElLcDBCM09q?=
 =?utf-8?B?Vk51L2xPRDZEcXQwWU5JTlMxdGU3RHZNVC96WVFSLzRPam4zbkFCWWtITHFQ?=
 =?utf-8?B?MU1pcjlscVVwYUVYZ0FMQW9yUllKNWV3VWRSREdxWnVERTJGVHcvQ0NSYjZj?=
 =?utf-8?B?YU8yMWNybyt2K0ZWSUxleXdPTDdXcVBlWlhjZVpRSHJiQ0xBSVRaVno1YzhK?=
 =?utf-8?B?anlEcE94ejc1aWxaMVpvRkhTSXJHeC9nMG5nVW5nRkgvZ1E4TnlRT2ZwTHdS?=
 =?utf-8?B?SWc0YnJ5K3A0TXFDbVNSc1BoMW1CeTlEcGkxV1NWcC9SV2g0cnlaY0crRWZn?=
 =?utf-8?B?MUdTTXJHQnh0NEdNbXEvWjlVb21HczFDVDRTL2Njc29LNmExQWxGZ3czWVJ0?=
 =?utf-8?B?VDVpYnkwWGxVT0QwbllIQktvYitxeGwvMlcwOUVnbnk0ODAyclh1OGh1UEFY?=
 =?utf-8?B?NmI1YXk3WDBFbDlNZ2E4OFBmSVM3TDVQdFQzTE9obmpDc25CVmU0SjJtRG9B?=
 =?utf-8?B?ek15ZFVLMXNjWVVIMEQrWVlJOUl2NGptK2Y2SXFQVXNpeEhhYVM4T0QwdzBF?=
 =?utf-8?Q?Ycu/E3xLIZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dS9xbWg5dDNqeG9VNW5XYmNhSm9EUEdWZHRkQVV0azZjOTVZUVZIZWR3TVh2?=
 =?utf-8?B?UUJaMDhWeGhBdE15WHdKaWtiQ1NLaUVJc3VEUDQ0RnpZeExjOHVieWRwNzcx?=
 =?utf-8?B?dUxKVUg0Q3pmRnVOZEJKMG9rSE9SUm4zdzdNaE5JZWkwR0NpRlFUSUJDU2w5?=
 =?utf-8?B?cHV0Z0Z1QnlOd0NGQTM1RzFMYmQra1NZdVVNdXVkdllLK21rQllzVUg5aTBZ?=
 =?utf-8?B?ZmxqNE5QRXlPQUE1OHlmODRHUkF5OWdOTE9SN3JDa0lSdlNFMGk4c2U0NllP?=
 =?utf-8?B?L01XYys4L0RHQTlaRzBJUkZrZTAxSktPY3MydHdiTHg3MlRySTZQYmZpODd1?=
 =?utf-8?B?QnhDakhBUWpMWlRidko2UG1EUkJhdmhnNHc3L1BHUTRiVWNBdnZpd3FNQ0Rj?=
 =?utf-8?B?NzZJMnZ4UThTVUZZN2hKQUIxVS91bWUzSURMQ3pUOUZ0U2tOZVgweTFZYmFE?=
 =?utf-8?B?b2Q4MHp4SXE5UU5VSzErdVA2VkFaNU1CVXFzdWdiWVd1cXl4NjdXNUpTZGpl?=
 =?utf-8?B?akRoNmFWcU1xRzlndmpva2MzTGFzZVI4ZmtzK0s2bjhlR2RzS0VSaS8vSnRO?=
 =?utf-8?B?L3o0bHpZM1dJTHVmOW8yV0lLYmJwbW1POXhxemdBVUFVNDBvQkxFdTlNWTdN?=
 =?utf-8?B?ZzQ0ZUpuYjNVYjFPYmxDQ2h0YVVmSnZjeW9JeFRGYTA3d3RQdWIxVkEzenNB?=
 =?utf-8?B?TFBGWG9hSVNCblRlQjVPNlZsbEJxV0lvbEl1d21TT3R5QmZZeFVhNjJ2czlR?=
 =?utf-8?B?Y1p4Vi95NEF0bG5hVWZybHJmUFJQcUpYQklhc3lxcUF0OW5WY0YwWGxGbFpV?=
 =?utf-8?B?N0ptQlZoNEVMTVZmbHZPK3lkZnZzMEpxZW1jZjduSHV0cVdEcVRjZktUMjNm?=
 =?utf-8?B?Z0pVbEJBUFVLcTEzK1RvRzlkUDNLMUxBWFVuOVpEVTM1Y1l3SjJXZmhTNFJt?=
 =?utf-8?B?bUdFOERPK2NUZnJiVmZQbjkzeFZWSm9oWlFmNk1sZmJBTFBtOVpsQTU1VVpq?=
 =?utf-8?B?SDhhNzB1c2pXUFFoSDJKMTVLNGc4aTFadXQyMzJEdEJDNWhUN3pYYUVuUEVa?=
 =?utf-8?B?KzNoeFpMYUFoS240YU05M0F5TzNFYzJ5ZUxqQlY1L0N5NUVaRzF4VlJGOHBw?=
 =?utf-8?B?S29ZNU1nblVQbERtRkV4cld5a0g5bmRGV1IxZVkyS1ZCQmJyTDJ3d09GQjdN?=
 =?utf-8?B?OGdUK0haWmZsbzhVNTlaM3FjNjJ0dTUxTHFtT1FLWTYzZFNUelgwVTExeDFL?=
 =?utf-8?B?c09oNzdETGpPaWJNeUt6L0thcDhQWkhaL3dlVG9nOUc0am9FZytuVWExMlFk?=
 =?utf-8?B?am9hTDhWMDVqWlFIL1gzbnFVVGUxRUcwUENFcHRtOFpHR2FBV2s3Z2FmMENR?=
 =?utf-8?B?V2ZPYnhyNEJrc08zN3FOVmlxTHFWc3VHWCtpWTRrdDdQYUh0a3U4OEJNV0pZ?=
 =?utf-8?B?TnJSVXBYQ3hMcG1qU2xydTVSb1MxZ1oreDREbUcwRkFuU0wyYUFVVnBWd3lU?=
 =?utf-8?B?SHFPNk5qaS9TMXRybGtYbnlTVjVNMllJUGdxWmtxbkNCQlBQYkJtNG82VWcr?=
 =?utf-8?B?VGRYS1dvMkExUUxERzZzanJ2c1F2ZVVyNUFNQUQ5QWMrRTdjd3IveWpNQlQ4?=
 =?utf-8?B?YkYrb0h6OFUyNjZTbGNFbXBCMWxFckIxTXhpbE0zYUd2a3U2bk5kVW1uK1ln?=
 =?utf-8?B?THo5d0x3c29wQm9adkVuTU0xTHBSUmFFMmg1TG9DdFVIa2RGaElzSUI2SVFw?=
 =?utf-8?B?NEdGcTBaL04rdDV0dFFZTXNBRWNZdVJnM3A5Mlhnay9EZ2U3MUhTVUhhTHU1?=
 =?utf-8?B?ZUwvRGUzdm1kbXZVTCtzN3FnRTY5NzVnVEptTS95NjBuMmVyOU1BenFiOEg5?=
 =?utf-8?B?N3VUNjlKUUpGcVU5T0FaaGNqR3FTbFVWL0pDeWd3Z01uWk52VXQ0OXpZQ1dJ?=
 =?utf-8?B?WWttWlZjeVhwaDNvdWlJY1orQUszSk84NDk3VWRQN202K3pIQ2x6cThOZVZj?=
 =?utf-8?B?L3NPdHNpczJQejRQZThOcFl6LzVBQ25mVVBSc1VFN3kvWWtJNVlLVmRZYktq?=
 =?utf-8?B?eXorbXFKNnQrSzlwdkp1bkZBU3djazU2OWJGTjg3YkV0aW1CK0tOQlFmZTJZ?=
 =?utf-8?Q?Apq6j9/Bcs852XarGAz6efi9H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0vrXhLK4fzKGjcqOUxqD0uQ+3YKTJN4fZfS7C3KpIQLyjv7GycMK/Yhb+pWjkwbnInnhEYcFvM20Q8pPAnUJ9QHnm+RA97XgtjDbNeVS1sDMU8VtJiZFxhj4k/Uqcu4pVkboZ6ERoPuEHOSkvEDw9dtCfGITQMFVztN6kgRyrs9qJYJsI0iyZWzAkrecx111Rg4/KnJf6u05HPZZxm1ZU7A+3vEaC3f0IHtTiuJ8xlQv6p4JlOgzdcTxkkGYnz4Fy6dFpbMyrbi/XtNru9Rj3XChDA79JhY5mEkGVMTBBmqWSYvN0Nsxizb4BMiS62L72cngbNxPH+aVsbpB3a/Inx7qfqllNuEKgs2/Q0SJgDpp1fqUVDudrMO2ru8IGj/ej30ZZfV+nC6hfpXPcHUwufL9d20u87ZhT5FwsDqL8wE/pA0Ae4h8S3QKrpWWYi0CL+A6G6Eh28EVxkZuSOyXrSYlqz4dJx4XhKzOK6LQ0lQPrK0zQ9Bl6BBrV7nBZZ8xaA21d4AbXfjDUKgjGdLKeDNXNi8atKiaNRY1P+MUsustVz2se3KKc3knL0ms58gF+bzSUd5TKa79jI4kJJH5PEgdiNhm0HRuZcdFeP7NzcXKfij59Fnl3ym1JhTBPLgs
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a920e4-b2e8-46c3-7662-08dde742d94e
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 21:27:25.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSHY4h0Hl8vfiacBkQr0cxhuCG01xuigNJX1s7TavBrPREZQbK6PCFhTxy892OjVhD3qT0yFlAtP1idly++Xgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10233

On 2025-08-29 16:49, Samiullah Khawaja wrote:
> On Fri, Aug 29, 2025 at 11:08 AM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2025-08-29 13:50, Samiullah Khawaja wrote:
>>> On Thu, Aug 28, 2025 at 8:15 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>>>
>>>> On 2025-08-28 21:16, Samiullah Khawaja wrote:
>>>>> Extend the already existing support of threaded napi poll to do continuous
>>>>> busy polling.
>>>>>
>>>>> This is used for doing continuous polling of napi to fetch descriptors
>>>>> from backing RX/TX queues for low latency applications. Allow enabling
>>>>> of threaded busypoll using netlink so this can be enabled on a set of
>>>>> dedicated napis for low latency applications.
>>>>>
>>>>> Once enabled user can fetch the PID of the kthread doing NAPI polling
>>>>> and set affinity, priority and scheduler for it depending on the
>>>>> low-latency requirements.
>>>>>
>>>>> Extend the netlink interface to allow enabling/disabling threaded
>>>>> busypolling at individual napi level.
>>>>>
>>>>> We use this for our AF_XDP based hard low-latency usecase with usecs
>>>>> level latency requirement. For our usecase we want low jitter and stable
>>>>> latency at P99.
>>>>>
>>>>> Following is an analysis and comparison of available (and compatible)
>>>>> busy poll interfaces for a low latency usecase with stable P99. This can
>>>>> be suitable for applications that want very low latency at the expense
>>>>> of cpu usage and efficiency.
>>>>>
>>>>> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a NAPI
>>>>> backing a socket, but the missing piece is a mechanism to busy poll a
>>>>> NAPI instance in a dedicated thread while ignoring available events or
>>>>> packets, regardless of the userspace API. Most existing mechanisms are
>>>>> designed to work in a pattern where you poll until new packets or events
>>>>> are received, after which userspace is expected to handle them.
>>>>>
>>>>> As a result, one has to hack together a solution using a mechanism
>>>>> intended to receive packets or events, not to simply NAPI poll. NAPI
>>>>> threaded busy polling, on the other hand, provides this capability
>>>>> natively, independent of any userspace API. This makes it really easy to
>>>>> setup and manage.
>>>>>
>>>>> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
>>>>> description of the tool and how it tries to simulate the real workload
>>>>> is following,
>>>>>
>>>>> - It sends UDP packets between 2 machines.
>>>>> - The client machine sends packets at a fixed frequency. To maintain the
>>>>>      frequency of the packet being sent, we use open-loop sampling. That is
>>>>>      the packets are sent in a separate thread.
>>>>> - The server replies to the packet inline by reading the pkt from the
>>>>>      recv ring and replies using the tx ring.
>>>>> - To simulate the application processing time, we use a configurable
>>>>>      delay in usecs on the client side after a reply is received from the
>>>>>      server.
>>>>>
>>>>> The xsk_rr tool is posted separately as an RFC for tools/testing/selftest.
>>>>>
>>>>> We use this tool with following napi polling configurations,
>>>>>
>>>>> - Interrupts only
>>>>> - SO_BUSYPOLL (inline in the same thread where the client receives the
>>>>>      packet).
>>>>> - SO_BUSYPOLL (separate thread and separate core)
>>>>> - Threaded NAPI busypoll
>>>>>
>>>>> System is configured using following script in all 4 cases,
>>>>>
>>>>> ```
>>>>> echo 0 | sudo tee /sys/class/net/eth0/threaded
>>>>> echo 0 | sudo tee /proc/sys/kernel/timer_migration
>>>>> echo off | sudo tee  /sys/devices/system/cpu/smt/control
>>>>>
>>>>> sudo ethtool -L eth0 rx 1 tx 1
>>>>> sudo ethtool -G eth0 rx 1024
>>>>>
>>>>> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
>>>>> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
>>>>>
>>>>>     # pin IRQs on CPU 2
>>>>> IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
>>>>>                                 print arr[0]}' < /proc/interrupts)"
>>>>> for irq in "${IRQS}"; \
>>>>>         do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
>>>>>
>>>>> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
>>>>>
>>>>> for i in /sys/devices/virtual/workqueue/*/cpumask; \
>>>>>                         do echo $i; echo 1,2,3,4,5,6 > $i; done
>>>>>
>>>>> if [[ -z "$1" ]]; then
>>>>>      echo 400 | sudo tee /proc/sys/net/core/busy_read
>>>>>      echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>>      echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>> fi
>>>>>
>>>>> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-usecs 0
>>>>>
>>>>> if [[ "$1" == "enable_threaded" ]]; then
>>>>>      echo 0 | sudo tee /proc/sys/net/core/busy_poll
>>>>>      echo 0 | sudo tee /proc/sys/net/core/busy_read
>>>>>      echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>>      echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>>      echo 2 | sudo tee /sys/class/net/eth0/threaded
>>>>>      NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
>>>>>      sudo chrt -f  -p 50 $NAPI_T
>>>>>
>>>>>      # pin threaded poll thread to CPU 2
>>>>>      sudo taskset -pc 2 $NAPI_T
>>>>> fi
>>>>>
>>>>> if [[ "$1" == "enable_interrupt" ]]; then
>>>>>      echo 0 | sudo tee /proc/sys/net/core/busy_read
>>>>>      echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>>      echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>> fi
>>>>> ```
>>>>
>>>> The experiment script above does not work, because the sysfs parameter
>>>> does not exist anymore in this version.
>>>>
>>>>> To enable various configurations, script can be run as following,
>>>>>
>>>>> - Interrupt Only
>>>>>      ```
>>>>>      <script> enable_interrupt
>>>>>      ```
>>>>>
>>>>> - SO_BUSYPOLL (no arguments to script)
>>>>>      ```
>>>>>      <script>
>>>>>      ```
>>>>>
>>>>> - NAPI threaded busypoll
>>>>>      ```
>>>>>      <script> enable_threaded
>>>>>      ```
>>>>>
>>>>> If using idpf, the script needs to be run again after launching the
>>>>> workload just to make sure that the configurations are not reverted. As
>>>>> idpf reverts some configurations on software reset when AF_XDP program
>>>>> is attached.
>>>>>
>>>>> Once configured, the workload is run with various configurations using
>>>>> following commands. Set period (1/frequency) and delay in usecs to
>>>>> produce results for packet frequency and application processing delay.
>>>>>
>>>>>     ## Interrupt Only and SO_BUSYPOLL (inline)
>>>>>
>>>>> - Server
>>>>> ```
>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>         -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -h -v
>>>>> ```
>>>>>
>>>>> - Client
>>>>> ```
>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>         -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>>         -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
>>>>> ```
>>>>>
>>>>>     ## SO_BUSYPOLL(done in separate core using recvfrom)
>>>>>
>>>>> Argument -t spawns a seprate thread and continuously calls recvfrom.
>>>>>
>>>>> - Server
>>>>> ```
>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>         -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
>>>>>         -h -v -t
>>>>> ```
>>>>>
>>>>> - Client
>>>>> ```
>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>         -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>>         -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
>>>>> ```
>>>>>
>>>>>     ## NAPI Threaded Busy Poll
>>>>>
>>>>> Argument -n skips the recvfrom call as there is no recv kick needed.
>>>>>
>>>>> - Server
>>>>> ```
>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>         -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
>>>>>         -h -v -n
>>>>> ```
>>>>>
>>>>> - Client
>>>>> ```
>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>         -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>>         -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
>>>>> ```
>>>>
>>>> I believe there's a bug when disabling busy-polled napi threading after
>>>> an experiment. My system hangs and needs a hard reset.
>>>>
>>>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
>>>>> |---|---|---|---|---|
>>>>> | 12 Kpkt/s + 0us delay | | | | |
>>>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
>>>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
>>>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
>>>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
>>>>> | 32 Kpkt/s + 30us delay | | | | |
>>>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
>>>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
>>>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
>>>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
>>>>> | 125 Kpkt/s + 6us delay | | | | |
>>>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
>>>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
>>>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
>>>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
>>>>> | 12 Kpkt/s + 78us delay | | | | |
>>>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
>>>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
>>>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
>>>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
>>>>> | 25 Kpkt/s + 38us delay | | | | |
>>>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
>>>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
>>>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
>>>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
>>>>
>>>> On my system, routing the irq to same core where xsk_rr runs results in
>>>> lower latency than routing the irq to a different core. To me that makes
>>>> sense in a low-rate latency-sensitive scenario where interrupts are not
>>>> causing much trouble, but the resulting locality might be beneficial. I
>>>> think you should test this as well.
>>>>
>>>> The experiments reported above (except for the first one) are
>>>> cherry-picking parameter combinations that result in a near-100% load
>>>> and ignore anything else. Near-100% load is a highly unlikely scenario
>>>> for a latency-sensitive workload.
>>>>
>>>> When combining the above two paragraphs, I believe other interesting
>>>> setups are missing from the experiments, such as comparing to two pairs
>>>> of xsk_rr under high load (as mentioned in my previous emails).
>>> This is to support an existing real workload. We cannot easily modify
>>> its threading model. The two xsk_rr model would be a different
>>> workload.
>>
>> That's fine, but:
>>
>> - In principle I don't think it's a good justification for a kernel
>> change that an application cannot be rewritten.
>>
>> - I believe it is your responsibility to more comprehensively document
>> the impact of your proposed changes beyond your one particular workload.
>>
>> Also, I do believe there's a bug as mentioned before. I can't quite pin
>> it down, but every time after running a "NAPI threaded" experiment, my
>> servers enters a funny state and eventually becomes largely unresponsive
>> without much useful output and needs a hard reset. For example:
>>
>> 1) Run "NAPI threaded" experiment
>> 2) Disabled "threaded" parameter in NAPI config
>> 3) Run IRQ experiment -> xsk_rr hangs and apparently holds a lock,
>> because other services stop working successively.
> I just tried with this scenario and it seems to work fine.

Ok. I've reproduced it more concisely. This is after a fresh reboot:

sudo ethtool -L ens15f1np1 combined 1

sudo net-next/tools/net/ynl/pyynl/cli.py --no-schema --output-json\
  --spec net-next/Documentation/netlink/specs/netdev.yaml --do napi-set\
  --json='{"id": 8209, "threaded": "busy-poll-enabled"}'

# ping from another machine to this NIC works
# napi thread busy at 100%

sudo net-next/tools/net/ynl/pyynl/cli.py --no-schema --output-json\
  --spec net-next/Documentation/netlink/specs/netdev.yaml --do napi-set\
  --json='{"id": 8209, "threaded": "disabled"}'

# napi thread gone
# ping from another machine does not work
# tcpdump does not show incoming icmp packets
# but machine still responsive on other NIC

sudo ethtool -L ens15f1np1 combined 12

# networking hangs on all NICs
# sudo reboot on console hangs
# hard reset needed, no useful output
>> Do you not have this problem?
> Not Really. Jakub actually fixed a deadlock in napi threaded recently.
> Maybe you are hitting that? Are you using the latest base-commit that
> I have in this patch series?

Yep:
- Ubuntu 24.04.3 LTS system
- base commit before patches is c3199adbe4ffffc7b6536715e0290d1919a45cd9
- NIC driver is ice, PCI id 8086:159b.

Let me know, if you need any other information?

Best,
Martin

