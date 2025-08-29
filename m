Return-Path: <netdev+bounces-218354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA9B3C23E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D975CA0824D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1DD33EB1B;
	Fri, 29 Aug 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="CIG5ngbV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7021019E
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490918; cv=fail; b=lSLbaHE9zzXUDV1gebM3vTxLrj0oflpBy3+mmA5lRDaWv5MyDqjZfUlHerI+kRmwvtB18CdCutux1bM+mymfVFpxZP4G6/FIy9iu738P82zkniyDYgxOYN1BnNGYSvzioAq3Ia+aIq1xUzAoFvF6T27t42V0zY15C8eeVEaUHqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490918; c=relaxed/simple;
	bh=T+nvyWCGp9WiCdjxLqpz1LYN8XBMCJH2URKSpOvM9ZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mA4hMpYbVQlp78S9lKDv5+x6R/j29AjHmPa7wlRLRh7Vn75zRFy4ntOWdaog96yfunVbXj04yuYaqjukXLBdJpUx8WiIqcWVIeMcRi52GuwHfId78zVCzfRUDvM6EyzQQWQ6HReSGDg6Th7RzQdxjvGKlx0ddq9IfozP+FgWK7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=CIG5ngbV; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1756490916; x=1788026916;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T+nvyWCGp9WiCdjxLqpz1LYN8XBMCJH2URKSpOvM9ZA=;
  b=CIG5ngbVfguCad4wgkFzv9zErekumSR8fR4U/zYQJnWROK4UUavRUka6
   fqQIECZL1jpqZo9BkF3zyRcmTUtWLiX2pBHW1Xpi71QhSZzKcyaOXMs8A
   iB4Rct1mmWnMokpxlzuWEIFPFUPaDOD4kt111Sjn6v/jMFIYDwQi0aoSD
   o=;
X-CSE-ConnectionGUID: jUP8Zxf/Rz64bD+a1PnZWg==
X-CSE-MsgGUID: 0vDd6wXNT1+2xyLYPMMwuQ==
X-Talos-CUID: 9a23:nQvbtG9BMUt8tYaSCXqVv0wpIpAXYnOa9mWOf0WUSm8wcLundlDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A+cG3fQ8RpAAuWPpfa/pmGb+Qf592z6jwF3Arrcx?=
 =?us-ascii?q?F4dmVER1IHhKCkQ3iFw=3D=3D?=
Received: from mail-yt3can01on2125.outbound.protection.outlook.com (HELO CAN01-YT3-obe.outbound.protection.outlook.com) ([40.107.115.125])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:08:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O28ZoQyhxhkRFq5t5zNMvaTfDUuERdZV3pkP73M8hZ6ZGOvLaxhyT5KJ2vJbvEu/NHBcxhdXYLPBWq0at/Ou+i39TZ4vPpIB5qa0s+P02d5JISUr2Hhvqv8IGH9oJ1kwb0pBUCK6s6E6pUiKOt1NrrQO+GETNVM6FUOBO2csaJJ6QnKQop4zDh6k2iasQ19easCsFqhFVxhNRyC9GRwCdLg40O4BwXuug8sDmQoSdheqLboOkiMNZBeUZ7buEnlKOdqTVVBSJRjruy0+k2gZ8yUMOTaQKqV2EGtPj3hG+pBziGMRqoCtJ73J4PY+RQWBnvKyKuPW2iYcRm8Vl3zcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSOxmqc4qOXLJXIpvhUxJx8BM9xJ+jXWLVhqMp+E90A=;
 b=qH7zdVkIIHAK0Kj2w3weaY6ef5m9oTh8P2qrUk+9BnXxXtji00Oa9lCAnZi1gu8eOSKd0ROoGZdzV8PkeK2KAQ9GhscSg1YXuI+RCSBWTCvxwBVspqXqLhOr6SUkqgcbNEF/ZCbajpBipJ+xQB46eo/3pWa8RTK/iBSfRL8MQl4u9gynDKJfkqZmn3Ytx+N+0+93f7LyRZ7JWarmV3E+0ykGe8d87CmkiFOfa4smyZjxKAKfIhRa4bJ+HFYTnYLN5aXQD+XKLi55keIv0rNtkN8JNOpxIue1FvZ/IszD4Y2TrNF1O3XFvb0ViD68FNXEUtVK1OQ9lv/kaQdkYvUNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT6PR01MB11120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 18:08:31 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 18:08:31 +0000
Message-ID: <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca>
Date: Fri, 29 Aug 2025 14:08:29 -0400
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
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhTx7v8fNiimqU7OiBv-8F23k2efXMTsRbXCi0iF3SDQKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::8) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT6PR01MB11120:EE_
X-MS-Office365-Filtering-Correlation-Id: cdba93e6-688f-4a48-f34e-08dde7270f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dyt1OU9zTmdrbmFncDhVOHZaNSt4M2NYN2JxR1pERVBvRW5pMnk5V01IRWhh?=
 =?utf-8?B?ekZ0b2hDMzJBTkhvd3IybW43YTlqQUpKVERZekluYTR6bC9xMTFCVkFzT1hv?=
 =?utf-8?B?NkF2MVlhRU5wK1BWblBMSXBOc1RiTGFUaU52WVdPUFVKVjJ5bjkrZDBRTm0x?=
 =?utf-8?B?Wmt6VU9OQW53a0ZlQkxsd3JVdmxqNWJKY2RubjlKbmNoaG00NFlNdmR6b01w?=
 =?utf-8?B?M2NCaW5Kbk9iZFZiU2hvcjBhTG96dEZlcXlkMmFrL29USGNzQXFSV2owY3Iz?=
 =?utf-8?B?RzFHcjhUOGdCL3ExUDRQS0FQaWZhY2YrcWQycjgwbEQyaDdEckJjL25ORFRM?=
 =?utf-8?B?Y3dLWGpRbmtvL3ZWeDlBbVlXSTRKaFVTaGcrUE9LenNGU1l4dGhLaEpxbWRk?=
 =?utf-8?B?aEpvQzBkVnNXeEUyOCtVZTJva0d5NGtFc083dE9GUDBhNXdLaGJOTFR6YUxr?=
 =?utf-8?B?RVNXWXRPNE0zekJFZm12MGpjVWptZXRHM0Fkc2RYUVM0NFRxcUsvTUEvdURn?=
 =?utf-8?B?N0RjaENBK2lxZWhDc3JnbU1BVVJZM3dpS3E0L0lMbkduL2djK3FjYkx3QjFk?=
 =?utf-8?B?M3hidmJSL2ZFanp5ZUViYVNLWVlhbWdiSTFtUmJMbHROTzlVU1g4OFcwSlVJ?=
 =?utf-8?B?R0ZPSkJnNWRWa1FaOEFGZEtpZ0FZUDBRV09Lb2sxaFVUNllqY3Y4VmxpMmFj?=
 =?utf-8?B?T0lZek1reXFqUkxJL1VnVFBMMk5QbkYxbFgxNjRJL0dJVHE3Q01LeVFYOExw?=
 =?utf-8?B?VE8zclRFQmkzdG9kcnJYRGo3a21HRnp3ZUdNTnRjMVlnUHp6MUM2K0VNTGJv?=
 =?utf-8?B?YU5KRENMK0RkUmNXRk1DWkkwT2VOcnhCcUZvcThnRC9jL3FKSCtHQk53dW5Q?=
 =?utf-8?B?dk5jb0x5cFYvR3ZPNXZ5WGhPVzNMcFRnNmpzNDRvdTBwV0J2SnlNRTZqdVRr?=
 =?utf-8?B?WWczOWw0UkF4d0RoN3BNeDFWZGxleWNCb0RUK2xCR3hDU1l5ajZOZjA3T0tw?=
 =?utf-8?B?T1lEUFRxTGpXRERYaFkrU0NYbUxqNjJBK1lydkdrVHJtY3NXMUpRNVc0S0Jo?=
 =?utf-8?B?VldtWkM2dlFYK09hOUw3TVlLYVVLb044NWZ1enowRDdBUzJ1Y3J6Syt5KzJ3?=
 =?utf-8?B?dHgxMzFBMEN6OE1kQzljSTVIK3Bxak9BK3U5QzkrV3lWRGM3MjczOUs1eDVX?=
 =?utf-8?B?eHh5OWMySGdhOW5NKzZ5OElOcUROU1l3aHZvbTIwRHlhVHorcFhFc2NDM3VL?=
 =?utf-8?B?RjNsUThPU1VhWjJNR3F0RlVESWwwZHlyeWtsbDJwa3Frb0trRTlSb0gzeUhZ?=
 =?utf-8?B?bXh0OGoyTmVaODlSWVJNWEtpM0tmWlJYYjlPZEJZdnZwQ0xnT3NnODc5REN1?=
 =?utf-8?B?WFhZN1c5SWhmUG5FS0RvdVlhL0xnUU5CdUFVaDllQTlMYjI5bFQrN0dBRUp0?=
 =?utf-8?B?Ulc2TEpvZDBRRy9Fa3l4L1kyVGJCdUoya2xKc3NENzhrZ2srcDAzYVR2clRh?=
 =?utf-8?B?dHBKbW0yS0Fua3hVdGIyNDdlR0pJQkRBUy9POGRsUlpRNHJDbzRZNlRpbUpC?=
 =?utf-8?B?RTg0dElRalErVnhqbldxNCtKTThWc2lrdWNqNnVpamJCQzBYblhLSUpqVDF4?=
 =?utf-8?B?UUovdGorSnNmd3kyVnRxYWRYK3BjbFVoa1VuMVl1ZzNoTzNnV1lpUWdyTFNW?=
 =?utf-8?B?cXlVUmpYdzdsZ3hqR2dvdlRRczVvOG5vaHBwRGlSc2IrTmkrSWsvRk9pcVI3?=
 =?utf-8?B?UXBVRnpURFBxLyt2SWVkaDNHUy8vYTlwU2R2cG1jdlRCWjRiSFVPdkZXMFd3?=
 =?utf-8?B?YkpabFhpRVJYSjJqeTY1R3kwWWQ4T29SNkcyYWVxRnJLSHF4Si9CcUR1d0F1?=
 =?utf-8?B?MXpsUERWNytNS2piaVNwL1FyVldBSXdSSEtrVFp6UEFlWnlNd3l0aWJVSHFQ?=
 =?utf-8?Q?ycwhlDvXB1Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nmx3WVFWdnBkRm1EbW1EOTRvZmk0Y05IYXplM3ZMbVZKZDZGbTRxYXdkRzI5?=
 =?utf-8?B?UVRmMHQyZXR5Q3dkWmtidnNYYVN5Z25zcjYzSWJzSE05a2tWWi8zZW9pSjhQ?=
 =?utf-8?B?UzRvdFNoNTRaeGJpTzNLbDBqazFTQkZybjlyZWpSU1hyUXlLS3Z3MXRJNUhM?=
 =?utf-8?B?S1AxbGlRdHF3TmpsbU9IaXB3VElkeGVqRm5DeWN3NFV0aVgzRGZDY3pZd1lq?=
 =?utf-8?B?N05YN0xzVUloUGQ3THRuSEtLVmwwMjdDK21XRGRsQ3BMdXdpd3NRbmlvWDRC?=
 =?utf-8?B?SmcySHhpZ2RDd2duVCtRang0amtNSTVnUGJTc1hhOUM0RnZEVkg3cHEvZy9j?=
 =?utf-8?B?eUxxdnVjK0RMYUVoRlgvWHBBMnlYS2FvemNNSW9hdldWS0xiVHN0VUNlSkk0?=
 =?utf-8?B?Vk5zVHJoUkhVTnlhem1GVTVDaGJ4ZlI1TEh5UDIyRnFNQy94azc3bDlwOFZ1?=
 =?utf-8?B?Qy8zK2VwVzlJNzBBZDlPUGY3Rno4clFReXlsdzFadndEdXdUMDNtZXNUZTZr?=
 =?utf-8?B?cEpRS2kza2ZXcHNQZmZIOVV2Mk5mb3VvTFZ2N0YxTlVEbXRqL0M4aVFzSHhj?=
 =?utf-8?B?YUtHQUMwb1B4TVpCeHRCazdPSm13RUs2dEZTU0hQTllwNFBoSEdKMHBnTS9V?=
 =?utf-8?B?eWlOVEJQeUdKRUtNWTJReVA5NkVrTndqMUFEb09KWTRsN3RuVUw4RzVrUkdI?=
 =?utf-8?B?MGpDaFA5dEkvdm1TbGhOYzRmTUc5RHRhbXdUNzhUVWtPMzdoSWhKWjJxWUVR?=
 =?utf-8?B?ZXBUaktZbERJcTdwdUxqNHpZYXV3dDY1aWpWWVIzWFFMWnROd1pkM1FNeExh?=
 =?utf-8?B?UXlEZStyeUNJWWZDdnZrRzBQd1FoWDl1cGx6UDBuOVcyNVJ5OHB6RVdxZTFI?=
 =?utf-8?B?WGNyVnc0QnJMWVRxbDJMK1N4S20zc0dYMlhQVzJxckZEUE14d0tieTUrNkZi?=
 =?utf-8?B?ZVdDelVCRDl4T0tYakhrMTdQNVltdGJhbFlVWHE4Z0YrRWRtb1NkemhJNnBP?=
 =?utf-8?B?UklVUHQ0OFlqVWhTOGxXWmpoaHA4NHlIRklSajNQSWxuZGdMakd0VjNnb3Qv?=
 =?utf-8?B?YURZSUltRGs1em9xVGdQc3AwMVRRY1ZJMENhaUhCOXNxTmZkd1dydDUwS0Jt?=
 =?utf-8?B?MDJsSFJPMEMwenV6eFVsNTlWaDQ0SXN6akE3UFloakxnRFV5MXp2UlNWUDNE?=
 =?utf-8?B?MlZ6YmtyZFJxcCtIMUtkOFIvL2YxQjM2bTI1Q3JEL25pVnhsQTFXL1pJbkhi?=
 =?utf-8?B?RFBuNXVNMGw1Zk1wckswMGU0QjZlSzZmZ2lmc1lTbnUwM0s1QUpqS2NrVW5L?=
 =?utf-8?B?U1dobVV3WkNGUXpOblMwZXdhNjBRcTRYRVdEVllVdkVYVlpsOFl0WlhoWm9N?=
 =?utf-8?B?NXpEVlhLa3Mrc0ZBTzVyZllhenp4WEhXSWZ0bUpQekxZRzRFQjJhZllzYTEy?=
 =?utf-8?B?cVZ5RTlhTitKSjdnU2pIbXdGZmJFZXY5eFJQSEV1RzVubnJZSzNPUkJuaVN2?=
 =?utf-8?B?TkRITTZ2amd2VFBkNEttYy9jRmZOci9Qb3BTcGxUeWY5V0pkdi9WS05Mb0FC?=
 =?utf-8?B?dFpZaHdReFVpMVhOTS9tU0tVOE1mb3lCY2t0cFpoZE9NMnMvL3hta21tWVpj?=
 =?utf-8?B?ZGlLdFpMYXhtRFFpc3c4YkdBR0k3T013NnY1V3U4SWx1WmVydTQ0Q29OZGt4?=
 =?utf-8?B?eVI5M0w2SU1tbGNPRUR2OGkwTEkwSzBPSFcwb3VST29tT3BUWElLVVB5UDUv?=
 =?utf-8?B?cUpraUMxa2dQRzlQdnpDY2ZNMFFaMnloYmZsN0lsY0JGMFZiL1lpdm5WQVNo?=
 =?utf-8?B?YzZEUStEL01uc3lFOXJQa08rWEZ0amFMUlBnUjRITzc3OSthZmswaFQzRFIr?=
 =?utf-8?B?dUxtamg2SWJYYjM1ekJ5Q3gyUkMxVHRUZUtwUExHd3ZPbWJUZlZGMy9JNVhh?=
 =?utf-8?B?RTJOeFdiSmowU3RwWHp1TmFWeFJMeHZUR2c0NDFnRHk0Y2M4c2JmeDZVTUVN?=
 =?utf-8?B?dm4wUGNpSDl2ZjlHVkYzVzgyRmNYbmZnaWQvWTBMNTZyTk1sZms3ano4RGFU?=
 =?utf-8?B?ZjIyZk5GcU51cmltNkw3RDR5UVU4b1Zhc3JSQUxOL0ZMVUtaNjdWdnVveFdK?=
 =?utf-8?Q?plp7OMEQmZJJbeKQ0MBm+Jfvv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J98oFvk3uuLD5wGec75uCNsUdl/PdnIJ4I26Nbzkg6nqnuNTOjLJfvIzUa/HtZYfD5Uc0VX6zCeVesMYCTUPTV22Qxy7k+H9znCQe8s8+XOpGFjdf76UyGd+26gTZxgeuTNdvdw4hBv0PGJoPWIs3sNGJpdlgwBmI7upjI79upBG0WQG2bfxjHDqpaF/jkzMr0KE6S1W+Goq7fsL2tqZ2lnm2H34COqbmi70TlyR/XwD4WAgFoyOnZ6Ze6n5GCY1K0kbP/So9DDAJgBPeFoa5kuGS8yMwjCYnP3HoskytqWALK/cY6H0Wbs77hkIwAuyuO5kN+S/LGODz+KCs+drbr0Z17FPxShfKgUSM+FJKgkxjWP5HeihWrw8iNkGs65xJZ4raVP3R618LEmJBtx2HQJw2M7+AaVRC0D48JT3VlpXyaKBozxnMspoe41VzFpHehsKKFY0nP3vGiGPFL0uQC6en00V0oWK1W/E7yLzHTBDSuh/C6R6ZZS8Um5u9s4ACZhReY2XGn9KkdUxzgeeTc93XqxzcCl93e4b+15pUjJB3zZJ881asS8Tzf4gk8oG4+918whLQ7M4kcrA/o7XwEBUNcJrgSgGHRE+5tljijKvdAKNdZy3wOYJTi9VfDrf
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: cdba93e6-688f-4a48-f34e-08dde7270f5c
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 18:08:31.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdgjFi3HBiqLYDkT3DPLwg0hMxEKIkdeczK3jd0uhpW02RB1YlUuCnpjABNUKRh+MiusUzsZczoAwt7Aw9JPeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11120

On 2025-08-29 13:50, Samiullah Khawaja wrote:
> On Thu, Aug 28, 2025 at 8:15 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2025-08-28 21:16, Samiullah Khawaja wrote:
>>> Extend the already existing support of threaded napi poll to do continuous
>>> busy polling.
>>>
>>> This is used for doing continuous polling of napi to fetch descriptors
>>> from backing RX/TX queues for low latency applications. Allow enabling
>>> of threaded busypoll using netlink so this can be enabled on a set of
>>> dedicated napis for low latency applications.
>>>
>>> Once enabled user can fetch the PID of the kthread doing NAPI polling
>>> and set affinity, priority and scheduler for it depending on the
>>> low-latency requirements.
>>>
>>> Extend the netlink interface to allow enabling/disabling threaded
>>> busypolling at individual napi level.
>>>
>>> We use this for our AF_XDP based hard low-latency usecase with usecs
>>> level latency requirement. For our usecase we want low jitter and stable
>>> latency at P99.
>>>
>>> Following is an analysis and comparison of available (and compatible)
>>> busy poll interfaces for a low latency usecase with stable P99. This can
>>> be suitable for applications that want very low latency at the expense
>>> of cpu usage and efficiency.
>>>
>>> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a NAPI
>>> backing a socket, but the missing piece is a mechanism to busy poll a
>>> NAPI instance in a dedicated thread while ignoring available events or
>>> packets, regardless of the userspace API. Most existing mechanisms are
>>> designed to work in a pattern where you poll until new packets or events
>>> are received, after which userspace is expected to handle them.
>>>
>>> As a result, one has to hack together a solution using a mechanism
>>> intended to receive packets or events, not to simply NAPI poll. NAPI
>>> threaded busy polling, on the other hand, provides this capability
>>> natively, independent of any userspace API. This makes it really easy to
>>> setup and manage.
>>>
>>> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
>>> description of the tool and how it tries to simulate the real workload
>>> is following,
>>>
>>> - It sends UDP packets between 2 machines.
>>> - The client machine sends packets at a fixed frequency. To maintain the
>>>     frequency of the packet being sent, we use open-loop sampling. That is
>>>     the packets are sent in a separate thread.
>>> - The server replies to the packet inline by reading the pkt from the
>>>     recv ring and replies using the tx ring.
>>> - To simulate the application processing time, we use a configurable
>>>     delay in usecs on the client side after a reply is received from the
>>>     server.
>>>
>>> The xsk_rr tool is posted separately as an RFC for tools/testing/selftest.
>>>
>>> We use this tool with following napi polling configurations,
>>>
>>> - Interrupts only
>>> - SO_BUSYPOLL (inline in the same thread where the client receives the
>>>     packet).
>>> - SO_BUSYPOLL (separate thread and separate core)
>>> - Threaded NAPI busypoll
>>>
>>> System is configured using following script in all 4 cases,
>>>
>>> ```
>>> echo 0 | sudo tee /sys/class/net/eth0/threaded
>>> echo 0 | sudo tee /proc/sys/kernel/timer_migration
>>> echo off | sudo tee  /sys/devices/system/cpu/smt/control
>>>
>>> sudo ethtool -L eth0 rx 1 tx 1
>>> sudo ethtool -G eth0 rx 1024
>>>
>>> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
>>> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
>>>
>>>    # pin IRQs on CPU 2
>>> IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
>>>                                print arr[0]}' < /proc/interrupts)"
>>> for irq in "${IRQS}"; \
>>>        do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
>>>
>>> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
>>>
>>> for i in /sys/devices/virtual/workqueue/*/cpumask; \
>>>                        do echo $i; echo 1,2,3,4,5,6 > $i; done
>>>
>>> if [[ -z "$1" ]]; then
>>>     echo 400 | sudo tee /proc/sys/net/core/busy_read
>>>     echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>     echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>> fi
>>>
>>> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-usecs 0
>>>
>>> if [[ "$1" == "enable_threaded" ]]; then
>>>     echo 0 | sudo tee /proc/sys/net/core/busy_poll
>>>     echo 0 | sudo tee /proc/sys/net/core/busy_read
>>>     echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>     echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>     echo 2 | sudo tee /sys/class/net/eth0/threaded
>>>     NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
>>>     sudo chrt -f  -p 50 $NAPI_T
>>>
>>>     # pin threaded poll thread to CPU 2
>>>     sudo taskset -pc 2 $NAPI_T
>>> fi
>>>
>>> if [[ "$1" == "enable_interrupt" ]]; then
>>>     echo 0 | sudo tee /proc/sys/net/core/busy_read
>>>     echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>     echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>> fi
>>> ```
>>
>> The experiment script above does not work, because the sysfs parameter
>> does not exist anymore in this version.
>>
>>> To enable various configurations, script can be run as following,
>>>
>>> - Interrupt Only
>>>     ```
>>>     <script> enable_interrupt
>>>     ```
>>>
>>> - SO_BUSYPOLL (no arguments to script)
>>>     ```
>>>     <script>
>>>     ```
>>>
>>> - NAPI threaded busypoll
>>>     ```
>>>     <script> enable_threaded
>>>     ```
>>>
>>> If using idpf, the script needs to be run again after launching the
>>> workload just to make sure that the configurations are not reverted. As
>>> idpf reverts some configurations on software reset when AF_XDP program
>>> is attached.
>>>
>>> Once configured, the workload is run with various configurations using
>>> following commands. Set period (1/frequency) and delay in usecs to
>>> produce results for packet frequency and application processing delay.
>>>
>>>    ## Interrupt Only and SO_BUSYPOLL (inline)
>>>
>>> - Server
>>> ```
>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -h -v
>>> ```
>>>
>>> - Client
>>> ```
>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
>>> ```
>>>
>>>    ## SO_BUSYPOLL(done in separate core using recvfrom)
>>>
>>> Argument -t spawns a seprate thread and continuously calls recvfrom.
>>>
>>> - Server
>>> ```
>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
>>>        -h -v -t
>>> ```
>>>
>>> - Client
>>> ```
>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
>>> ```
>>>
>>>    ## NAPI Threaded Busy Poll
>>>
>>> Argument -n skips the recvfrom call as there is no recv kick needed.
>>>
>>> - Server
>>> ```
>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
>>>        -h -v -n
>>> ```
>>>
>>> - Client
>>> ```
>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
>>> ```
>>
>> I believe there's a bug when disabling busy-polled napi threading after
>> an experiment. My system hangs and needs a hard reset.
>>
>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
>>> |---|---|---|---|---|
>>> | 12 Kpkt/s + 0us delay | | | | |
>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
>>> | 32 Kpkt/s + 30us delay | | | | |
>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
>>> | 125 Kpkt/s + 6us delay | | | | |
>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
>>> | 12 Kpkt/s + 78us delay | | | | |
>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
>>> | 25 Kpkt/s + 38us delay | | | | |
>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
>>
>> On my system, routing the irq to same core where xsk_rr runs results in
>> lower latency than routing the irq to a different core. To me that makes
>> sense in a low-rate latency-sensitive scenario where interrupts are not
>> causing much trouble, but the resulting locality might be beneficial. I
>> think you should test this as well.
>>
>> The experiments reported above (except for the first one) are
>> cherry-picking parameter combinations that result in a near-100% load
>> and ignore anything else. Near-100% load is a highly unlikely scenario
>> for a latency-sensitive workload.
>>
>> When combining the above two paragraphs, I believe other interesting
>> setups are missing from the experiments, such as comparing to two pairs
>> of xsk_rr under high load (as mentioned in my previous emails).
> This is to support an existing real workload. We cannot easily modify
> its threading model. The two xsk_rr model would be a different
> workload.

That's fine, but:

- In principle I don't think it's a good justification for a kernel 
change that an application cannot be rewritten.

- I believe it is your responsibility to more comprehensively document 
the impact of your proposed changes beyond your one particular workload.

Also, I do believe there's a bug as mentioned before. I can't quite pin 
it down, but every time after running a "NAPI threaded" experiment, my 
servers enters a funny state and eventually becomes largely unresponsive 
without much useful output and needs a hard reset. For example:

1) Run "NAPI threaded" experiment
2) Disabled "threaded" parameter in NAPI config
3) Run IRQ experiment -> xsk_rr hangs and apparently holds a lock, 
because other services stop working successively.

Do you not have this problem?

Thanks,
Martin


