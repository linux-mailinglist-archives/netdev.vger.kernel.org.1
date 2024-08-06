Return-Path: <netdev+bounces-115954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D019948951
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 08:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65CA285ACA
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 06:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7A41BC9E8;
	Tue,  6 Aug 2024 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="SafigM5W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2104.outbound.protection.outlook.com [40.107.236.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5F1779AB
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925256; cv=fail; b=kqfuRmtwy5RAWOv9xW1jGKkffUhURZPgte1mq5/UE42YHpgyq0qxXdgYvr7jbfKHkOQikA0tKZBBYq6RpRRGPhcJJLaRU1Li+TMqCM6ITLYmgdCk0wZN+y9p2jAWQ5iVO3Y5lsKKTBXgjRxzZwiyydz0LGVd7HRe/wjI6gs7x3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925256; c=relaxed/simple;
	bh=Uu1UMppI6hYXMsS1pjWOJ2CQpDnrUiuOI5t02sIRm+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kv7mbQRuRpVXLDioNLlqMejTECCw643ZYNTSpyftqhuf+IoasBxOF1VDODrdLN9PCKxHaNm0qjkxgZrZIzFjeSVfqbX+GTL/0FkO458IVwK2CNxu8Jw0d0FVVWko9XqkG3mcTAn6hojQbaBI6KIdJ1ll2DOkfCFl7Z++Y7r8tN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=SafigM5W; arc=fail smtp.client-ip=40.107.236.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkoZLeFKR57EvjOA2VgUQZsNt4Eb6ZUCDOK2aSMw2vnpazAqgn8hesYZHRUfuQCA7NMJ28H2IgxSTMjMlwpOGFnihg0Kfm2cBa+plzhhBAt1On23SOT7t+djEJiGZ1kIpgBIa81WLvqUsr2VevN7sq/DezHhAXYESVgX85OufiW8NJ7E0cAbD5teDrjfiSxpz1+OWfTv++zRycZ2vG7eWrELiNV+p+WkXBqaAFF161sojs9MNyQjESLTLzHZbyvCllhF2UfDspnQOw0eXwTfA7wQANjRT1aXeCi1rOStRryv0gwzguI0xLXsKh6h1SSINDunrZ5GrXRVGhjP8DF7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN5hwpinST4kjI6JGooGjIpok4Ndyy+4flKxjI6zWFk=;
 b=IA/7X7MWtRExNquSLtQfUH5SXcOMhVwedjT6iDlxdNpJiL4ei2JGTxubwcXFGzglb1+/kpTi/g8YnrN1SeTjfsCERSihN7E70EINhFYGPgywhph50ooQ17qM3RV/wQhy96MzVhbYi9I5rQj99qs51opaSfcOIpWJKWCW0Sa8mf005gKAeQ5jIZFlgFML0DGAH92GRdNU6X5/S58ITJf0dcRi4r794vcbDOWZq26o7YOmW+s5Iz9RvtYldMU0nqRpn0yOAKbTdnUL56F8V+dffSk5KwcFSAkusNFS5KipyGar9vGrTXxsmNoWexDp4i5VVulDzf/Jqpdnh9lDAwppqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN5hwpinST4kjI6JGooGjIpok4Ndyy+4flKxjI6zWFk=;
 b=SafigM5WUq5ZuvnyPnQLeGjDtxz5dHtjugALRzh9RRRKwopWBNet7jgJqbdsxHsA/x+jU261d62A0HXegOJuEdy99wLZFhgAUHbbmWyoV69MlvaEMj6oZCXo11KNLLbB6ZgRV77n21SWQUHO8yVYJIbgIGzzb/gZHinLxlHuPPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by LV3PR13MB6358.namprd13.prod.outlook.com (2603:10b6:408:198::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 6 Aug
 2024 06:20:51 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 06:20:51 +0000
Date: Tue, 6 Aug 2024 08:20:39 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jason Wang <jasowang@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, eperezma@redhat.com,
	Kyle Xu <zhenbing.xu@corigine.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, oss-drivers@corigine.com
Subject: Re: [RFC net-next 3/3] drivers/vdpa: add NFP devices vDPA driver
Message-ID: <ZrHAtypv8LqNuWF8@LouisNoVo>
References: <20240802095931.24376-1-louis.peens@corigine.com>
 <20240802095931.24376-4-louis.peens@corigine.com>
 <CACGkMEuVKDv9H-OuhoaSHXppQsiLAueewccAKPQNn_YKZT4ocQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuVKDv9H-OuhoaSHXppQsiLAueewccAKPQNn_YKZT4ocQ@mail.gmail.com>
X-ClientProxiedBy: JNAP275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::7)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|LV3PR13MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 82db3c93-b39b-44dd-49c3-08dcb5dfeb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG1EOElvbmF2M3I5cU8rN3lITGZPbkdNZW0wK2VZYXdzZjdoWThNWm53T0gy?=
 =?utf-8?B?MzBtS0x1eXNpVUZVREhTM3kvVC9MQmxaSWp6VXozcjFORys5N3lMcVVITVFi?=
 =?utf-8?B?R2dNY3hIZjl3VlNLazFsU3lTZkk0ZTFLTkZzUVhtM0R4OHR6NUtzQlYyeGVq?=
 =?utf-8?B?SmFwbURid3Z0alRvaGlSb1EyRnppUnl6cFNvamxoZXYzdkp3aHBob1YrQ0lM?=
 =?utf-8?B?eVNyTWVNd3ZhVXBqMFdnTjlkdmlmVHVFRnBUZ1Jqb1R6SVl0RzFiUTRzLzVw?=
 =?utf-8?B?aTd6b09TbFk1blVlSitUYnduOVNYdHlreGhoNUI0aXYyQjhpQTMrL25HcFRq?=
 =?utf-8?B?bXhvRHNkMkExUXA2aXdVOEdQWnZWTWt3aEVrSlVQb0cxZU01NjlHVUFNcVJj?=
 =?utf-8?B?bDYvM1NSOTlBWWROUlZrYUFMWEV1Wm50aXhQUzZ4TFFzUTMwWE85U0FvTHY0?=
 =?utf-8?B?Zjlrc3dPVTVBWUpjeFdnSTg0a0F5UXE4bkhBa2MwM1NrWnk0eTNTYVR1NlBE?=
 =?utf-8?B?TTVjRDdFLzNsa3dNWUJBRW9qYUsvVVZqTGtIZDhKWGdNd244UGFGQ1RsM2ha?=
 =?utf-8?B?WDQwelVSRCtrNFZSZVdUYzFnc0VzWlZKemJUQXRwclFaMDVBeEhmcGcvakxk?=
 =?utf-8?B?ak5iYTFzQy9WTk45QU5WZllMbjkyR0NqL0R1cUE2SmVCWXd3eWNzNEhxeHgw?=
 =?utf-8?B?VTZpRkhNdkphTFI1NzFpcDUxbnVjV1NMelRNYm54eUlNcGUxS242Vm9vR0du?=
 =?utf-8?B?QzNzU2VrTzJpSkhYKzJqVkhEQlZ4YStYSHJhNjNuNVIzRlU3dXZsYVdJS3pT?=
 =?utf-8?B?Z3RPVW9jMVJVTlkrbnM1QWp4MDIzVk5JUk9CaS81VENlTGphS1IycUs4OHBF?=
 =?utf-8?B?SllER1BETVFtVUVMOHhtSWd1eWRaMmptL2pKVnc3WFRoZ0NrS05aYnZwS1NN?=
 =?utf-8?B?dUJnc2N1SDRUZ1orbnpjZThDS2toQ2VNZUMwTHE1NHBnQnV4WW9NYVM0WEVT?=
 =?utf-8?B?OENDdHJiVi94N2Nod0hWNXFkTHh0MkxmRlFaNk1WQmtlU3RKeG9wSUtvL3dY?=
 =?utf-8?B?NjREcE8wYzFrMEhobmxjQXB4bU5ha1IyekdSVSt6N1Y5SWdtb3ZhTnk4Rm9E?=
 =?utf-8?B?cGVTYkFrMlZYUmxVTVBEZnY4RTc4Ymt0YmdTcHJnRy9wQVZzYWxrbnlabmhv?=
 =?utf-8?B?L09sZko2SG95SzZWNXpqcHl4U0VwZlpYdHZ3N1dlWmdaU0xpWGtVd0FmSC9a?=
 =?utf-8?B?d2FlTkNFQVROQVpSVHliRGs1TUtRbjJXTnpZWGpqOVNFVnpjVWxOMTVmeEtj?=
 =?utf-8?B?VTk1WHV5aWs4dzRnSCtzN2tZSUo1VmxSd3NLa2FQazVxMjVPaTZ2b1VVOHo0?=
 =?utf-8?B?ekJ6Mk1rRXJmNDdQczZmV1N3ajF2RzBMWGxKVjdEU09NSy9UaVRVaGVwSGxN?=
 =?utf-8?B?VmRSbHNSMVNvbUEySTF4MkI2OWhzMFlsdDN1L3k0bE0zSmVwUXdOL1NZU2tx?=
 =?utf-8?B?YTFHM1h4ODFuUEdkM04vdjdGOFd3dE5XcFZhVTEyVVJ1em04Q1kzcmhxWjFD?=
 =?utf-8?B?aXVvZjc3SUF5Z1RDREpXNzYwUWpUU0hSaiszVndRQXZ1YzZJK0VSVEQ2OGpZ?=
 =?utf-8?B?V3JvczFSQTkrOWJUT29KNi9rZ09kRXhlL0dJM24vUlFKeTBEMSs5Tnl3MDVU?=
 =?utf-8?B?c0FWTGl5U0N2MjBxRnR0eStyOGF6ZG5mK2I5MFcyTkhhOXlnL2dJeTI2VkVY?=
 =?utf-8?B?bjNEV3M4bUJJRjhTMGwzSnd3Sm5ZaDZkRmoydlpleENwaFg4ZTd4ODVBM25u?=
 =?utf-8?B?YkwrQjA3bUM0KzY2WkNwdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjgydFBNM3h5Zk1HUFlPYzQ5a3dOenU4Q3ArVDNQNXBtVGFZT0FtckhFcWIw?=
 =?utf-8?B?T1lVWjN1NnUxSVI1S2xvV2pjUmMyRzFja3JBZXBkMCs1WUgxaEFiSnYzUXFk?=
 =?utf-8?B?Y3lDYVZ4azJlQXUzOUxCdEZUNmNOR3JLTzltK2JlWmc1OWF5TDhlcTE0S3Nh?=
 =?utf-8?B?UVEwZGxRZGk2WnduVFpzV0lqQW53Mmsxc3pkVGpFektNNkJ0TU9LUWpuVm1I?=
 =?utf-8?B?UktzWHlUZ05DclNFVFE0Y3BnZ2RhSkt5UVNHeC9pY2hlcDFRRUE0ei9MbW9i?=
 =?utf-8?B?WFhZdThISXF5OWNFZFJTbGo4czJLQ0EwYW05U2MyRUpHUWROdjlhTExnNi9k?=
 =?utf-8?B?VWRHS1lmOTl1TUl3VXltOTlMVC9OcW8vdUFBRTM2bG1jY2ErZ3diZHRRa2VW?=
 =?utf-8?B?VndlMUo1MjlRd0NQa3IwM1lNbG1EY2lrbWZFbVZab0ZlakUzSXVTMjF2WTZ2?=
 =?utf-8?B?YTQzbFpxcDR4REt6Mmpka2haMGtYZXhpSmd1VFpDUHQ3UUtzMDR1VVBpY0ZG?=
 =?utf-8?B?QWZMbys1OUs5c0k0Vy82bnR0ZEZJa2JTaGcxbWYvdnZqK1JJeE5hYWNzZG03?=
 =?utf-8?B?WWloWHVYRGJoRHFTSVlLY003Y0RGVWtBTGlCOU1zN0tUQjhlL2NuWXNBRWFG?=
 =?utf-8?B?TnpLdjFZWUFRMlVzaEVhcWVWdkpFR1V5anNCVkN5OU81bEZiRFFBY0RybXEv?=
 =?utf-8?B?dXFCbVZTSjdONWNrL1k1TnNWYks5UzQ3V3NzaGJwSytSV2xjZGxobWllZk9k?=
 =?utf-8?B?d25RaVhDeEUxQ0lKWThWc3JXczM3aDMvQ2hocnZRc25Ra3lmWURxakRmaStz?=
 =?utf-8?B?RVAxc3lJOGRFNVBnNVJiajBDRVIveHlzMkdlZWVWN0hGNmRYRU9BTUd5NWQ4?=
 =?utf-8?B?YUU3ME1XYWV0TjRJN1NmVkxvQjc1K2UzdS9IT1BSOUJjYVBrZlU3Uy83Skkr?=
 =?utf-8?B?MGVtNzZJWkJlRmoxSWMrdE8vRVBCR2d6QVFzME5FOVN0VlFrRmpYcythdUVJ?=
 =?utf-8?B?cjFGZ0JrNnRmMkFEZm9qQ1I3RG9VKzRJeER3c3F0TlkxRElVSVZGMEc4NGxU?=
 =?utf-8?B?ZDF6Z1JoM0xFUHFPZ29zdUpYR2s4NVNHcWdwdS8zNG1oK2REZ1dsRTJaUlhn?=
 =?utf-8?B?Vktta0d0KzZzS3ZYcEpXVHE4RW0yelkwajNMZUlUWFYwYXNESUF6S3lCRUpi?=
 =?utf-8?B?SDRHdWpMR3c2T3lsVjV1eWVwWWJ4dGVOejF2eXBFa0FnelBYbHpIc2ZYMyt4?=
 =?utf-8?B?TjNuSTBuRUZWNmhpRmo2TFRZNHkxNzdVck5UY2NSMkJONzhNMDNSUXlPQ0cz?=
 =?utf-8?B?SXduRE9IamVXaXRDc0RhTEg1Rkx4QTAxaHd6ajFhY1lXTDNCdFlYRGI1cTFW?=
 =?utf-8?B?RE1aR21FVjNVZjZXVXl0eGx3SUR3QVdVa0IybEx4MzB3Unk3RkE1QlQ5Nkpi?=
 =?utf-8?B?VHI1bDg5dEkzVlZxdXVFNDd5N3JPdW55SE1EOXUvUStBWkpMcWpVdW9xQ2Vv?=
 =?utf-8?B?U0gyd1lsakFtdUoxd3hpaXpnY0FPeUpkeWRhMWhZSCtyT1pmZEpmY1FRZnNy?=
 =?utf-8?B?cFJuL0YvWHBZRkRDMS9XN09yVnF3L2ttU2tjQkw1Ni92OWJxdVBQSHUveHBm?=
 =?utf-8?B?Mk8rNlVEYzFTWUNaVnpwK0xucUVDK3RUV0tUV2owb2VVNHErK0VzQUZIZ1d0?=
 =?utf-8?B?MTdtWnJJbHYrenZYbEU3RTBta2RLWVBRRU54Z0ZEZTg4TUtieFR6QVpIV002?=
 =?utf-8?B?RFNWQUZtMEM1WERLM2UremFKQVBHTXNwakUzemErZWF2bG14RlVpamRnbWdl?=
 =?utf-8?B?c1RpaE41TXpKeEtadWpGZE5TQkhMbTBtc0tidWY2NHpMSC80UDJCeXB3UDZh?=
 =?utf-8?B?eTFDMU1EWGxacTFRNTJ0Q3pSU2xrdHJudm10cUZwU0FXRXc1NGZDNzJrZ0dp?=
 =?utf-8?B?dWRsSDFoQWVWREhNa1BZSytiUHVOV2dtTmhLZXBIOTdpTGw1QTJkeXVmcVJF?=
 =?utf-8?B?OTRIUFZkby9vbE1TOUdnQ2ZDbXd5b2R4eC9PSmFncEVKWDI4SjAxaVh3K3kv?=
 =?utf-8?B?Tm83bFpXWmM4emhzeGFmZm8ydzNOTjVpSWcxS3V2R2RRWFdlMFZtaTNHbmll?=
 =?utf-8?B?aXBEZm51cCtLaE15SmlsU1hEbHFFMlVBSk5MeEc1UEZzSHZVQldtM3FWb0tX?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82db3c93-b39b-44dd-49c3-08dcb5dfeb26
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 06:20:51.1506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hafJjyvuxdB8vvCZ1bEpdiGh2Jf4y77ifiT04/g6Rq+jDDvCd0mlgvc5RZDUbLbugkB73z5GIriC2v3T5RNclBxfZZqRhQn8BKgyr0FEwz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6358

On Tue, Aug 06, 2024 at 12:35:44PM +0800, Jason Wang wrote:
> On Fri, Aug 2, 2024 at 6:00 PM Louis Peens <louis.peens@corigine.com> wrote:
> >
> > From: Kyle Xu <zhenbing.xu@corigine.com>
> >
> > Add a new kernel module ‘nfp_vdpa’ for the NFP vDPA networking driver.
> >
> > The vDPA driver initializes the necessary resources on the VF and the
> > data path will be offloaded. It also implements the ‘vdpa_config_ops’
> > and the corresponding callback interfaces according to the requirement
> > of kernel vDPA framework.
> >
> > Signed-off-by: Kyle Xu <zhenbing.xu@corigine.com>
> > Signed-off-by: Louis Peens <louis.peens@corigine.com>
> 
> Are there performance numbers for this card?
I don't think it is well-optimized yet, but I'll request to have some
data captured for interest sake.

[...]
> 
> Thanks
> 
Thanks Jason for taking the time to review, these are good questions and
suggestions, will take some time to look over this with the team. We'll
then make some updates and/or provide answers on the questions for
further discussion where needed.

Regards
Louis

