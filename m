Return-Path: <netdev+bounces-158688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2840A12FF6
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 01:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F1F3A6E9D
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 00:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF207080E;
	Thu, 16 Jan 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="BmTAg03x"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7D2F509
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987408; cv=fail; b=p/JqMpU6kU9kj4QXcYLVNDsqASN7i9KkIAQqB7njUDPAbrvo0W7zFffD0vE6yUEhCzmfAXpTXRwY/ymUUeAz6VclMRhSmzcIuqaHngsyUD13ePed+6/9Yqdz1IbzeDBw0MQuXjoTTFwXZ1QwELVNmPovz8LhGAHE7sno/DhrFAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987408; c=relaxed/simple;
	bh=S5g5kaa0Wc0lF11y4BLjt/ot171nmICgF4BRzLziiXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hzWs2/PfQbEUw7RBggpY8dSlrZR6wrLDH4fKJiwYDOAHhIqZ+hN8UUb774NNGCZRRYTtbd8X2JKel5NpfKQ3yaiVkXnBo4QhiMKi561+GibmOq6cSxvQW2yx00asSER/VsVQu7wvX4JXzQPm4m1T2UIYAy1y9JO0A0sn13pBKus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=BmTAg03x; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1736987405; x=1768523405;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S5g5kaa0Wc0lF11y4BLjt/ot171nmICgF4BRzLziiXI=;
  b=BmTAg03xN3kRXPok9etmTur4/rXQCkHZ96sltXZZ1bB2UnzNCWGhG4f1
   tfTCmJjoR0fiqq5D56pc/Opk8fE9F5MxqYtJKqeAJANcCKnxwarpue0c7
   mV8gbMQ9umnV+c1PIjbXfglJSr65igGcY7HiCyWZLv8/ADjpGFQWAanz5
   o=;
X-CSE-ConnectionGUID: YlLinLFWTFik4HF1rzVhCw==
X-CSE-MsgGUID: G+T97K4KTQqktR8fQcvVwA==
X-Talos-CUID: =?us-ascii?q?9a23=3Aqkp0AGtquGr7Cymo87+LDlf16IsUdlncylP+HHO?=
 =?us-ascii?q?WCGU1aJPMU02u+Ih7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AST3LdA/sh4tAwLhaR3/ZDOSQf+gr3/XxKxwuraw?=
 =?us-ascii?q?fuNW+ZSJJMCmjkx3iFw=3D=3D?=
Received: from mail-canadacentralazlp17011049.outbound.protection.outlook.com (HELO YT5PR01CU002.outbound.protection.outlook.com) ([40.93.18.49])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 19:28:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eoz8jhZiaC6Bn+0HV7sV20mLPQLs9h7cz204Zs8+XlygvC9Mhz27JkkNGPAWIL1SL2J7wY6cU+bsVTBqhXGzbKIl6KE7a5tBu0OnbsTf5gb9pWkySnP0tzQaRoNFpO68X8rKdLmR4PY1Mo/r81Vh3d0Kcyr9AZgfcCneA85BVKU5bCscHePRLt1+IpMr5nIL9yjQRNUIQ6FcuZYQWPK4noxryCGl1IcNGBhkOFJjYGMS32MnQZIneeR4ocIMssxel80UYQy6P/ymCFdDzzkJLyhPMFmLxVv9q7TvZQDUMGBwaiMLVd7k4lzQ1E1j9Qkfy/Sey+i2NmzNCE23i2WX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+46kFbRk1v7CwqCTUsTJ7SjkJa+lTTo+B9pI66/BDnE=;
 b=QSVykTAHD89+07bi7u7NuWuIuEQ0Gi7KSP8azXgoPiEkfoP/t4CKSBqGzfrNSWRocnvcDu9iwkEu0RX6cgWPSTDnyddo2p0P68/kUeyh9ocLXzSUmDWq7/AuZg8KGcF9IFw5cEPWBJBCvAyNTgDDhIo9+EK1aE74suzvgm3gMM0T/xusCdFvjpdXPoBU4e/S1voDnfX3TdCHXLdUXiuu4g46DNJq1jXHQDUdh9g2m8Z8KWr+6Y4p/CGHm0jz99cC32v7VcVibaZo/z8TfUdChTGb4SQo/6Z/R71EMMj7wkCXONHITfq929kyA6WEas3egrNHYLQq2Ik1vK0hBEvjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT1PPF96A4222AF.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::567) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 00:28:55 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 00:28:55 +0000
Message-ID: <8edf6313-a329-4431-a44e-d903d801c771@uwaterloo.ca>
Date: Wed, 15 Jan 2025 19:28:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20250102191227.2084046-1-skhawaja@google.com>
 <20250102164714.0d849aaf@kernel.org> <Z37RFvD03cctrtTO@LQ3V64L9R2>
 <CAAywjhTAvT+LPT8_saw41vV6SE+EWd-2gzCH1iP_0HOvdi=yEg@mail.gmail.com>
 <5971d10c-c8a3-43e7-88e3-674808ae39a3@uwaterloo.ca>
 <CAAywjhQwNJuHE6T6caq9Y6DfDqrZo6CTP5ToSDHrcE4wZH_7YQ@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhQwNJuHE6T6caq9Y6DfDqrZo6CTP5ToSDHrcE4wZH_7YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::22) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT1PPF96A4222AF:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fef53a-0a4a-4517-3bf7-08dd35c4c287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enNOU2l6eVZuZGFqV0MwQjFOa0pJWGxVTWtQbHZMZkZCMDVWTWtGVGl0T1FY?=
 =?utf-8?B?Sjg5bEswWnJtY1RpVG5GREtFajdzblZQUU5udHBmNGhjSWxTYzJ2aWJRYnhE?=
 =?utf-8?B?d1p0SmdkU1BmaUpCdEM2b1dWL1VmaUtEZEp4NHozMGh2aXkvc0lFZEJodjQ1?=
 =?utf-8?B?Vi8xcjNERHNIc0tKKzd6WmVYKzRaUlI4V3NBSmg2cUxJeG9ERGVzemhld2Ir?=
 =?utf-8?B?bFZrbFI0Mm1KVCtNSXJEZjNKMFN5MnNhN2VNMXliSmVFTzU0QVFVZ0xmWm1R?=
 =?utf-8?B?dGJYMVF1UERoemNOSGpEakd0VVlQS3dZQ1FaRWpON2hCd0JOaytHS2pEaHd0?=
 =?utf-8?B?T2NtcXpBQnFyVFozSDBkVXVqZW1nYlQ0MU5oSTFseUgrOVZzdlRHV3kwQ0Ju?=
 =?utf-8?B?WGFLNFhaNVJ0b0NXK3B0MWRKa0NacmJrSmFHczlvYUFScHRENDhydTVhOXNa?=
 =?utf-8?B?d1JqSGtoNE1lWEFCQTBFWDlkeHRHSEtFQndhRGNWYVIvVC96SHByTWJLeGth?=
 =?utf-8?B?QUhlaFlKTmdWNUhYQ1dNY2s3ZE1mZlFacXlRZWkzTXZTUUtnZTBhRHhadWFJ?=
 =?utf-8?B?R3dRbEpRdTBKamllRHpMak5MYXR0K1VwTnQ3WEdjbGpHWWI1N1UwVVpOSmRO?=
 =?utf-8?B?WGtzTWxWQ0pkTkNyRnpYWmxnMy9Sc1RCRzdab3RaT2JaY1lqSmk3WE1DNFB3?=
 =?utf-8?B?S3FvcnYrakp3S3JyUEVObkpqN2Ivak1oQVZILzlncVA0M0hCR0ZtYlhWTjlh?=
 =?utf-8?B?ems2VE1WQWV6cTdQYXZ3WkpGZ1hnMXNOS2xpMkZjbEF2T3RxMk5wQVdVR2Jr?=
 =?utf-8?B?YWlLT2RHanBXeDJOcVk5VGNMaTVLbFB3QjlsOHZTUG0ybHViOW53T20zemxk?=
 =?utf-8?B?NGN1aGg2bGhvMEw0UG84V1dISWlCME1NcTFnOW9mVUs5Sk5aRktKYmUxdnQx?=
 =?utf-8?B?NktvYnVGNEZLWER0ejNXQ1Q1cHVRMEIyNkNCVXVoMkprNlFhNmJhdE9QUkFE?=
 =?utf-8?B?Vnh4ZXlpOUt5Qjd0TFpLeHNFVXdKdUNwWXdBQWZLRURXT0o1N0V6OWlUMDJ6?=
 =?utf-8?B?YnJmdlBDdlN5WHpFMklhMVVBNUNMdCtnSWlYTExrR1UyNGhXd0ljRkZtMEpn?=
 =?utf-8?B?ZHcvQzBFcHRteEZ2d084bGwzUy9SR1lqdmNQUy8xTzJsekhpUTU5UWRwTVRh?=
 =?utf-8?B?eXNaUXlTYURVSXA5VmhxaVNtaGhRVXFQa3RhdEhudVZ2RzNyRlRjS05ubXdB?=
 =?utf-8?B?SXZVaDZ2ZXl5SE0xQ0Y0SXlUR05kZWNwQ3Z6UzFlYjhnSEdRYnZxazFjeFhj?=
 =?utf-8?B?Wk9MVXI3RXpjb01zbVVtZW1QMUNvNm5rNTNreGhGK2hnbUtGMzBLb3RlYVBJ?=
 =?utf-8?B?R3F3VVRReGIyNW52SXpVMjNXbHFEMmtHQ0g4MFlwRCtjeDNPdXFlcEs2OEVK?=
 =?utf-8?B?ak5EK2IvU1RVb1RpSE1NK3RRQkM4ajIwdC9RZVc0NHhlcGNtaWg4eStFR2Y4?=
 =?utf-8?B?RXZrWGg1OWwzcEd3bEJ4TnFTUElTVVlYalp4RXpFdTZLb0s3RHQxdUp5RzFp?=
 =?utf-8?B?WURkZy9TcGFuV3cwQ2FrWTdIRktYM3lKTUI3dFlZOFlVbEN5YTd4UnUzcVhs?=
 =?utf-8?B?SU1ldk9XcXZxelBBbkE1NWx2N3o4UkdveUF0aWlqODEyUVJ4OGJCbC82ZG5G?=
 =?utf-8?B?MUJoNHFOa25WTmF6d3h3NngyYnpJanJ0RTB3d3VTSnM1TVJ4WHAvOUdpVnEv?=
 =?utf-8?B?ZW0yVXZwQ2llWVJsb0xvZnBrM1JaanlGeEJiM0xYKzhqMU0xMzQ1OUtya3cv?=
 =?utf-8?B?azNGWlJPREdBSGFoNURFdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG1QZ3E2YWhvbGR5cTMrT0o0NUtldGRQQi94N2V0V1pmbWFHQk5SajZkMzUv?=
 =?utf-8?B?OXBjWCt4ZEsrKzFHMWNkRE54cFlmYkgzcmN1dWRJRk1uN2hOSk9TRTQzMXBj?=
 =?utf-8?B?K21SM0VLalE0dGJUZFd3Y00vNTAvRkMwU1R5cDlZQWttcVg1UzFNelVBeXZF?=
 =?utf-8?B?a2VMTEh2WnNZTFJCL1JtMUpJb0MvcXRQN0lXbjhmbmZjam5VcjJSRTkwTlpY?=
 =?utf-8?B?b29KaGRNalVhdzA1dkthelFrTnN2NzBUT0I3VnVNMHFXTFV0U2Zock5aRmtq?=
 =?utf-8?B?cUdjUnkxOENlZjkwKzVOb1JNYS9rZHZTeHNKRFJqWVI1SFZrem51UWJYTkVD?=
 =?utf-8?B?VUpubzNzZytEMHFUSGxJQ1VjWVFhNXJScEhxUmRqTXVUVWtlaXRxMmI1Z2FK?=
 =?utf-8?B?Q2FoVnR5YUtQRzlVUkRVTnorRW1ZSm1TcFN3enFQV25KWi9WTHlFZFE4SG14?=
 =?utf-8?B?c0RGSVNNdkJ3QndTY1BYVnhYdVpVaVhqYUYxcWVaTTlZMFFGWUlJTElEcFVs?=
 =?utf-8?B?Z1VBRzIzTTEvdDVGOXozays4d1JtcVZwc2h1YWtHYlZHZE4rMDU5MFF0V1Nj?=
 =?utf-8?B?Qjlpd2lqZDlnZVlNMzRLbUpGV1ROQStESnFUVE9CTWhpbFpheXRnZVN6U1FI?=
 =?utf-8?B?czg3dkkrVm9xUW9rZU9XNE5TYmFBNDdEb0MvRmw2SDJyQytOUDlrNnVpN3I0?=
 =?utf-8?B?Tk9ITUFtSEFkSWJNTHBYTWRFTDRKckpYSGtDdmNzaFpYTWtURWhhdmpWbjU4?=
 =?utf-8?B?Y1o0TG8yd3Y3b0ViVGI1bm93Z1FORGNkYUlSUGdXbTVGOElTMGJXRE1oWjZQ?=
 =?utf-8?B?S0gwZEJIVFl3T3BQMmExenpES3FPSUFsTGo3dFExRVlNWGFxSXlmL0Y2OHdv?=
 =?utf-8?B?Y1pNaWlJa1d6dU10ck1jQWh2S1JSRmFRZnl5dUlwSmZSYVBubHU1UXZQQTFZ?=
 =?utf-8?B?VmlvVFVteTk5SVlDdklhcVZqOW9BMlhVcXQ3bWJvTlNscjZaaVhvYjR2cGxz?=
 =?utf-8?B?WGpPaTd4VGpvZTBYVzQxYzFSYXBWYVFDcW5QVEhZRUEycUFZZytUcC9lWFoz?=
 =?utf-8?B?bElQazFnVVIwVTJia1lIaEZuVHhFQXQrNnVyVFZxcXpzN203T3prK1NqcnQy?=
 =?utf-8?B?VW5qNjJMTWRBWm1yVlpMb2hrTGg0a1M0bzJWd1lzc0dlc214Q0F4VkdoTlds?=
 =?utf-8?B?eThzT3JkbXg4QWErS2N1S1pJZzE5SjJxeTlsdUI4aEhQRWNYdFl5b2hHa2Zq?=
 =?utf-8?B?SWZoT2h5WnRzbU9kV0Q1SVJTNWVDM0ZRNlEyYWtSN3A4bWg4aldhZExDbXNM?=
 =?utf-8?B?SFhtdjc3M3N5STdheGxJQk1RZUFJMlord1Z4K3ptVTJKaXlKcVphM0tCdzhF?=
 =?utf-8?B?K3hidXFFUWswNDU1VStWQWcwcDBCdFllT3FMVkZadEh1cUJrMUJZN1IybzlJ?=
 =?utf-8?B?eXhMMjdJZE04ZkEyUTFxY3FZdlJBT1cwK0VoanFqR1VBVGY2c3pPYk5LcTZy?=
 =?utf-8?B?Zk1qN0ZMd0xlUkFIUEV6Q0hhYUhuRjdMTG9vU0FLSXpCTkNWV1RzaEQyZUhV?=
 =?utf-8?B?QzZKUUs5YnFFdWJYVjhLbzZKMm53V2lxUFJRQUhXQ29sbXZYOEUxdmk2SXlP?=
 =?utf-8?B?QUllQU1SM1ZNU2pMMUZPWG9LZTNBcS85QkU4U1gzck9lZWlUTlpVRjlabDNw?=
 =?utf-8?B?bkI5NnhMd2VmWm5kYnJKL3FrWmY3b0VjWjBmV0xFd2N0SE5xMmtvWjVscXBh?=
 =?utf-8?B?UjJCdTdRL3draVZrOGxtdnNETDhHN1Bxb0tVOEd1cllvRjVmWVhKMEM0U0ly?=
 =?utf-8?B?dElrZ2dnNFFZOEZOK3J0RmkwYTFDRFJCK2tjeHcrWFBreVFWaUxZcjVUaEJi?=
 =?utf-8?B?TEFtOGMrdU1LT0Q4NGZkcTlnYTUzemROMURWbGhyQ2lva1BRYkw5WTFyemR3?=
 =?utf-8?B?aEpJZ0FLQkdFelFhTjJlOWZqS29FY2RIanJrS3daSnFoVURTYkorcHhWU3I3?=
 =?utf-8?B?a3k1c1ZGZmIxc0x6QnU0Zkhpa2NhWFhYQ1NOQ3drOWI5eGhvdHRqQWlud1lN?=
 =?utf-8?B?N05GREdtZHhZMVB5M1hGL2pLYTVDWXBDeXhDT3hHems0NUdheVdFNWlEWGVG?=
 =?utf-8?Q?0CsD4wEkFYT2vxeZs6eZ2/7/Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yPg5k/Fg4xtAHsebqv3DyU4aVX99ksPvUWqeS8SPyIS5jV3ZyiWTc+WI6mLAwRMNxceZPnhXZy+7neMmDHhfEYh/YQYT0oQnSIoioI3YcWN/8mQNK1kdvWQMTrBWEgtvumfsnP9Wp2T2Iwy3lIjJKf4O+R8wH4BjZrX/o6J8hMqEeHb2QxXgwiGImafxGAhyXLfT4kBU+0zORbyRxOBVHsg1x6h5uF7WCp0Ud08pD0DxpI5fiqLAdyora4mcorRAV49Ut1ijqQ+7B8F8l0RHQFHVxqmRXLBAFoEM0dbVp1C8LS4fiMhu+v/lJaeF3WWOsE4Wvz0jrVNqld2pzeNCTzfRjckwJdBZapsf/S8WtMGnMVxC12aN368icja6upuO3J8d11NG8Gz0KXFfnb5hVVnLFhLl4MEJR1vdPRv45A1oR2EKoTpH474NlYGXoFL2UmpMGLTbDiumKnRl0xPs8U8P0YnKkV8Av7OghXhCodxK28XT2iiCcHpCZhb3ezUN0DDNoiOuoYncrMVdpSMjN9fGZX3gI7Oav4j/6foM6oWPP+tbHk99tMyQIn2HklUro9MCroRtiZdFo1TDwc6+sdTmpLsrqDbggvcWNhSlnHPQ5apFPl7I4gxdf5j4lt+n
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fef53a-0a4a-4517-3bf7-08dd35c4c287
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 00:28:55.1135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0QFIevJfVUpoOYf53kJlZV575Ab/LHBPeB/HKQuw+Ucoirw7GSx91lyY+mqYq2Tmx7N/vH4kDQPc5NotlFEbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF96A4222AF

On 2025-01-15 17:35, Samiullah Khawaja wrote:
> On Wed, Jan 8, 2025 at 1:54 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2025-01-08 16:18, Samiullah Khawaja wrote:
>>> On Wed, Jan 8, 2025 at 11:25 AM Joe Damato <jdamato@fastly.com> wrote:
>>>>
>>>> On Thu, Jan 02, 2025 at 04:47:14PM -0800, Jakub Kicinski wrote:
>>>>> On Thu,  2 Jan 2025 19:12:24 +0000 Samiullah Khawaja wrote:
>>>>>> Extend the already existing support of threaded napi poll to do continuous
>>>>>> busypolling.
>>>>>>
>>>>>> This is used for doing continuous polling of napi to fetch descriptors from
>>>>>> backing RX/TX queues for low latency applications. Allow enabling of threaded
>>>>>> busypoll using netlink so this can be enabled on a set of dedicated napis for
>>>>>> low latency applications.
>>>>>
>>>>> This is lacking clear justification and experimental results
>>>>> vs doing the same thing from user space.
>>> Thanks for the response.
>>>
>>> The major benefit is that this is a one common way to enable busy
>>> polling of descriptors on a particular napi. It is basically
>>> independent of the userspace API and allows for enabling busy polling
>>> on a subset, out of the complete list, of napi instances in a device
>>> that can be shared among multiple processes/applications that have low
>>> latency requirements. This allows for a dedicated subset of napi
>>> instances that are configured for busy polling on a machine and
>>> workload/jobs can target these napi instances.
>>>
>>> Once enabled, the relevant kthread can be queried using netlink
>>> `get-napi` op. The thread priority, scheduler and any thread core
>>> affinity can also be set. Any userspace application using a variety of
>>> interfaces (AF_XDP, io_uring, xsk, epoll etc) can run on top of it
>>> without any further complexity. For userspace driven napi busy
>>> polling, one has to either use sysctls to setup busypolling that are
>>> done at device level or use different interfaces depending on the use
>>> cases,
>>> - epoll params (or a sysctl that is system wide) for epoll based interface
>>> - socket option (or sysctl that is system wide) for sk_recvmsg
>>> - io_uring (I believe SQPOLL can be configured with it)
>>>
>>> Our application for this feature uses a userspace implementation of
>>> TCP (https://github.com/Xilinx-CNS/onload) that interfaces with AF_XDP
>>> to send/receive packets. We use neper (running with AF_XDP + userspace
>>> TCP library) to measure latency improvements with and without napi
>>> threaded busy poll. Our target application sends packets with a well
>>> defined frequency with a couple of 100 bytes of RPC style
>>> request/response.
>>
>> Let me also apologize for being late to the party. I am not always
>> paying close attention to the list and did not see this until Joe
>> flagged it for me.
> Thanks for the reply.
>>
>> I have a couple of questions about your experiments. In general, I find
>> this level of experiment description not sufficient for reproducibility.
>> Ideally you point to complete scripts.
>>
>> A canonical problem with using network benchmarks like neper to assess
>> network stack processing is that it typically inflates the relative
>> importance of network stack processing, because there is not application
>> processing involved
> Agreed on your assessment and I went back to get some more info before
> I could reply to this. Basically our use case is a very low latency, a
> solid 14us RPCs with very small messages around 200 bytes with minimum
> application processing. We have well defined traffic patterns for this
> use case with a defined maximum number of packets per second to make
> sure the latency is guaranteed. So to measure the performance of such
> a use case, we basically picked up neper and used it to generate our
> traffic pattern. While we are using neper, this does represent our
> real world use case. Also In my experimentation, I am using neper with
> the onload library that I mentioned earlier to interface with the NIC
> using AF_XDP. In short we do want to get the maximum network stack
> optimization where the packets are pulled off the descriptor queue
> quickly..
>>
>> Were the experiments below run single-threaded?
> Since we are waiting on some of the other features in our environment,
> we are working with only 1 RX queue that has multiple flows running.
> Both experiments have the same interrupt configuration, Also the
> userspace process has affinity set to be closer to the core getting
> the interrupts.
>>
>>> Test Environment:
>>> Google C3 VMs running netdev-net/main kernel with idpf driver
>>>
>>> Without napi threaded busy poll (p50 at around 44us)
>>> num_transactions=47918
>>> latency_min=0.000018838
>>> latency_max=0.333912365
>>> latency_mean=0.000189570
>>> latency_stddev=0.005859874
>>> latency_p50=0.000043510
>>> latency_p90=0.000053750
>>> latency_p99=0.000058230
>>> latency_p99.9=0.000184310
>>
>> What was the interrupt routing in the above base case?
>>
>>> With napi threaded busy poll (p50 around 14us)
>>> latency_min=0.000012271
>>> latency_max=0.209365389
>>> latency_mean=0.000021611
>>> latency_stddev=0.001166541
>>> latency_p50=0.000013590
>>> latency_p90=0.000019990
>>> latency_p99=0.000023670
>>> latency_p99.9=0.000027830
>>
>> How many cores are in play in this case?
> Same in userspace. But napi has its own dedicated core polling on it
> inside the kernel. Since napi is polled continuously, we don't enable
> interrupts for this case as implemented in the patch. This is one of
> the major reasons we cannot drive this from userspace and want napi
> driven in a separate core independent of the application processing
> logic. We don't want the latency drop while the thread that is driving
> the napi goes back to userspace and handles some application logic or
> packet processing that might be happening in onload.
>>
>> I am wondering whether your baseline effectively uses only one core, but
>> your "threaded busy poll" case uses two? Then I am wondering whether a
>> similar effect could be achieved by suitable interrupt and thread affinity?
> We tried doing this in earlier experiments by setting up proper
> interrupt and thread affinity to make them closer and the 44us latency
> is achieved using that. With non AF_XDP tests by enabling busypolling
> at socket level using socketopt, we are only able to achieve around
> 20us, but P99 still suffers. This is mostly because the thread that is
> driving the napi goes back to userspace to do application work. This
> netlink based mechanism basically solves that and provides a UAPI
> independent mechanism to enable busypolling for a napi. One can choose
> to configure the napi thread core affinity and priority to share cores
> with userspace processes if desired.

Thanks for your explanations. I have a better sense now for your 
motivation. However, I can think of several follow-up questions and 
what-ifs about your experiments, but rather than going back and forth on 
the list, I would find it extremely helpful to see your actual and 
complete experiment setups, ideally in script(s), so that one can 
reproduce your observations and tinker with variations and what-ifs.

But I'm just a bit of a tourist here, so you might get away with 
ignoring me. :-)

Best,
Martin


