Return-Path: <netdev+bounces-99648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043D08D5A7C
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9E21F241BD
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB297E101;
	Fri, 31 May 2024 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HdqPBe9p"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB34653C;
	Fri, 31 May 2024 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136579; cv=fail; b=eOkkpO7vMYnCTE2lc6FpdPygW4l4v6KNFrmcr2Hg+WKcaPOu+E4Mypm3iXsCUmFao1zVOUfKYXAOlCdSZo9XrA5PJIkB9VUTOG3unoIF4G1OyBglpy/azTan9H6NmS4Nc8r8A5NTP+VOPA3LKn8EF4i19LgFPDo6Ax233d6M8zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136579; c=relaxed/simple;
	bh=9HLlDmJzgdfzMePmXe2BpPxVIrZTT996YKwj0B0wVjs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gdnYJ4CThYaX2EAy/BMKMtDHDBTsjuoXSZy+tvtHqtSfSVuZhP+ciX9bmNdfT1yvtWcmeODCh3m1CMgbeoCcRWQcu5p1oPfFGpetL/c1m2CnOI9DxyqmrMzU7tSm8RAdrQ9181Bzja3xUMaG81PW4/jU+2e9aKpgamKRnV3g9+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HdqPBe9p; arc=fail smtp.client-ip=40.107.8.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK2qfpEhmnLPliR54qJRRIZOgsgWTpmorx7jam2LRNl47P8R/irnamwcR+mNcfmT4sOlb54Calna1ekhRQZ6EJ2CCihWal7Lfj0CCLkwaX9h1hzv7d0EI6BGD7u6k/IU7FqMGOpfXQJOHXuk5M78HLtU88/ZhejFSt1g3WhSj4Z80CP+MN9iMUo23rD8y1Q7DUTJFPMgRQq7CYqrkZF8xDO6aNsjC9aistwoE7EOCrq9mS7SHVXLRZWkueyLGdRv9/y54h3RrxQiSobgU2+E06m3af2nzDjtlEkYYUaYNTscNw34ZdsPmBzVdtQTGYPQGr+iOBKzH7uvYKfoOKTwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMxGNyPcDF3I3Ped5F1rezSNAzbigPcp6cqmz6ItibI=;
 b=RfpC4uWEGFIwCL1CvaZxZGtiqXexd7sFHdsPxGDLVsB+tc2Q/j5cgNuX+mu3Cg8o+1BnVsIpb9sfC3pDeGMCnNEtK1RVZZXyX6AogPvwNwfTNkzREI9nw4tgUaSHbj0ZwzLlfdMhMiMjU9nrQxIhf5y4FbsOTYUAbHqGfBZKxVG+z12G2j4I/C0oPccTs3IGhTbwkVOcLCyzISHN3HV0pxCmSP1zRdyWMu4oFDlN2Xd1geGGlV6pVXg6cI2ymQvXyZ26hWJbqhh0L4yamDAoiz0RXBfwla3rdJFW4ZrBzNxeJWfdtFL1SwPo6at044s2S6IeZ0lElcC1IIfJWDBBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMxGNyPcDF3I3Ped5F1rezSNAzbigPcp6cqmz6ItibI=;
 b=HdqPBe9pYyuB2FEFd41zlXThfls3+VkdP90aQp4ZbVfHeGlv6mlcJIB01uq1FbVnzQ0NsazP6k+4EltUN83FKYLOAhj6mP9OWb2l2BbsOa2eIc2H+bUl8rm8nZ5LF4FeXLtXLKhfz0NRD9D/qB6VT5TU+w8evZ9WPZfYWuwoKFbye41g6H33wrFSI11qCUN4YfGozKTS6NC7wIdmGgXlGNO2PM9LHmY0WUA5mIrRocmFgn2B+foY5K+00fVrsEdlAFZbf3YrNP+Kr1WWe/QkqgZXB9gglGYKHFdh4cDb/6R6qZSOJpTwhpLBs+v5kIk6ezUIdFiGYPzePsMwJaFiAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7854.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 06:22:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 06:22:52 +0000
Message-ID: <9f7737a7-3e1d-4d6a-abf9-88d855fd0c9c@siemens.com>
Date: Fri, 31 May 2024 08:22:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Enable PTP timestamping/PPS for AM65x SR1.0 devices
To: Diogo Ivo <diogo.ivo@siemens.com>, MD Danish Anwar <danishanwar@ti.com>,
 Roger Quadros <rogerq@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Suman Anna <s-anna@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240529-iep-v1-0-7273c07592d3@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240529-iep-v1-0-7273c07592d3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 8340e9da-44da-41e2-45aa-08dc813a19fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|366007|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTR3aFJHZ2gzOXdpczBVWUFuV2pDVERaZ2M2ZFJtZjVxbDhWNWR6U3drL2kr?=
 =?utf-8?B?S2cxV09UZUt0dm9BSFppU05lQ0U1NDdTT0tyM1FhV2RyWEhCUVEvZU1VZVM0?=
 =?utf-8?B?djVnSjJaL3VndGVIOU1YVDI3NnJVTmFrZnJYWllhNlZIOU5GSjZJMFUrdWR5?=
 =?utf-8?B?M0lHWE5BTUp6UXExRW1WN3FzNy85RGFPaDlJdHVXQ3BzeVlURlZNT3VCYUFO?=
 =?utf-8?B?RjUvalJYbXRPbzY3bytKeG1lY1RMdWJ3a3NWQzJ5OWhnazRDOE5xZTYzTlZh?=
 =?utf-8?B?RlZMTUlpQjFJUHJvT25iajFGNDZ3RU40VXkrZzlyQlRnSmUxNEN5TXJFUHhQ?=
 =?utf-8?B?ZDdaN0xDT0cxWjNjV3FyRHZIU1MzZFY5eXZSaGtUK0hJQ1J1ZGMxODllSUxV?=
 =?utf-8?B?bUhRU3VEVHhJWTlGbG1LdkFqZlFPVmY4Q2tlaUhkaWo0Ym1kb0lQS0ZpRXVt?=
 =?utf-8?B?VHBJNDdEaWxYMnYyVTBnRXYzUWNVYzl4K0VPbi9RaTB2QlZYNnlidm5jSjRl?=
 =?utf-8?B?ZkMwNUlRWkFJOWJxUmxzRGUzdmxiYi9DbDhkNjJUa0JucCsrV0VmY0RlUXYz?=
 =?utf-8?B?azE4TUhWek1kaXNtOGFKanVsNjNRbk8wWi9XcmZOV1JWZC9xTGg1UitEK3V2?=
 =?utf-8?B?Y0tqd2E3MTQxeExmNE1qNENzV2hQVXV4cTVpTDRQTm50M3hYeFZuSHl6NHNF?=
 =?utf-8?B?cGF1bGR5US8wcjRjQWFESlArcUV4RnQ4QWF1RDB3MlZuTVcxNkczazRsb1lS?=
 =?utf-8?B?cUhLV1g1UVdCTzhOOVI1N0daNURyaWF1VklGcm9iam82MWFoZ2dkQ0NQaXFs?=
 =?utf-8?B?bEpTWVFOUTM1YzZOZ2FaaGRGN0VsSHhVWk5QVEw0ZkhZVytGL3R1ZHA4eVQw?=
 =?utf-8?B?ell3RktQNm5NTWdJN0pjMkZKWkMzRzBTWjRNdVZJNldIUDJtTnRHb0RwNmZ5?=
 =?utf-8?B?OUU0eXIzeU1jS043a1p1M29hcGRQNlVQcXlaWXFHYlMvc1JVdW12anlSdDdV?=
 =?utf-8?B?K3JaZDdBWUl1NjYzcGZOVCtKUWJWTXg3OGdoZXVVbVFOUGlSbzRJMEJLY1dQ?=
 =?utf-8?B?M2tSNVhQWjRqelpjR2RTbmxZYksyTytvMWp6YlZNOGxyTkVoRTUzc2cyYmJH?=
 =?utf-8?B?L1JnT1ZSSkh2RGJkcFN3cjlQaGNCRWlqNjdQbldIN1EvL1FDdnVWc3hpZHVh?=
 =?utf-8?B?NG50eFRzZjFLTmNjWmNyd0ZlOCs3S3VDZlpOeEk0TDJObTU5bE4rMXplMUI5?=
 =?utf-8?B?NnJkZW9NRnllb1VEdWxyOWhhT2FBS2ZpNG53YTRPNGJQTlJYMk01aklCZFpD?=
 =?utf-8?B?RGxjTWNVQjlaU0pZNGp1UXdCbFZrZXc5VVdLS1d0Z1NOOVVUMWhSSTFtSlRI?=
 =?utf-8?B?SGtMQ1VmZVEzMjlEZ0dVYlBzektoS3gyTmhqOXF0OUxjdE9tMWQyVHZrZWdW?=
 =?utf-8?B?ZUtkK1JncGk1TzRzdU1DKzV5ZFZoZGkvRjFvcFpVcFFCWFJVeVAwVFpTZFZl?=
 =?utf-8?B?M1FyUWZaUFFPZDJBQ2t0bzFiZlJIL1lqMEpidWw5NzFQR3pFczU0N0M4YVYr?=
 =?utf-8?B?Qzl0OXpuQzF0SzhqOWdiTEtnV0pra1gzbnlUVGxJemhMSzYzdVlVY01HSnhS?=
 =?utf-8?B?T0ZSOC84b0lIZURXQ2l6cVZRdmZSYUEwS2EvSVJkR1NRRC9tQWNEbk1RT29L?=
 =?utf-8?Q?PPbp940QMBCB4bzIa/iY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEN4bUR1YzFHcFEyazJGZ0k3c2VpMGo1N29ucjhvVm1uc3orcXJkNUoxSjMz?=
 =?utf-8?B?TVVrSng2VEV5RlBaL3VSRzd0cDF5cUFwMVhweEdJUUJTQ3B4VkNuVnQwajJv?=
 =?utf-8?B?NERrWnRBOE5DTkdqRUoxa3dKU3QrTUlnNzhXMzkyOWFPNkxIMVRkVk1kaE1n?=
 =?utf-8?B?TXBJa1JuT2RsQmtTcitRN1Z5YjdHeFNGMWt0aHJ4RWxRbDhDcHlDVEtadUNT?=
 =?utf-8?B?VWhjeEMrRndydGphSEdybEdJVlVFNC90dmlackJucFpqdCs2cWprUDJmNlR2?=
 =?utf-8?B?N2NCaXZ4elBuYWh2TFhJd2xuVTUyZjgyRUd5Z1JQNjlwd3ZXT1Y2YUJudmJL?=
 =?utf-8?B?VFBOOEh0NHFpK3UwbEpNeDlvU052NGhmZ1U1a3lXeDBicy9MZERBV3VPaDFX?=
 =?utf-8?B?YTZhMUhDTVdBOG1KQjNBNVVpMVgrWE9xOGZrdzdQL3hmQXM0cVN2ZFplTWNp?=
 =?utf-8?B?c21Ka1Z2ZjZELzBPRUtqbHAwbUxzRTluTWErV0lsU0pXZWljYWJpVjVXTGIx?=
 =?utf-8?B?RTZHY2Z2U3ovYUtRYXVzbXZVK293QjVJU3NONWhiTUdhd0hDSGptYW1TZmVh?=
 =?utf-8?B?bitHNmk4YnJrUWdZTGlrMC9CTWNKVFlvTXRIQlhya0YzVkFhYUUzanRuaXUy?=
 =?utf-8?B?SERRWUFTNnFqZHRHTTEwM3oyY0NPbnVyYTFBMGttNWNFdHJIbW5JaW5iZ1Qx?=
 =?utf-8?B?M25nTHFMMVgvQnVDSUE4ODcxMzdVNUw3NnNENjFSSnYzanhwVDRGN0ErVjdi?=
 =?utf-8?B?NFJMNGxyWnVMSTEwcHQ0MWtGcGI4RnRSUWRVb3dVbnZnWmw2bnBhd29wNGIr?=
 =?utf-8?B?SVhmamZlMnd5dnl6TG9QdG9GNGtRSFllZnRMYk9OQStpMnNFMTk3U3NXTzM1?=
 =?utf-8?B?dUxDTVFJZzRsdDdRRnpPWUx0SlVoRklVY1dBL3FuNnNSaERCOW1jZ3BUTkYx?=
 =?utf-8?B?UzJ0ZmduZ0V6ekJWWmM1ZTY4TGJrUnlmWXhLeG5lWSt6aUZQWHY1OC9MaWNx?=
 =?utf-8?B?a1JXa3pPcy9uNzg1YU56d2xhSG04MFRHbWkxazVRQ1NhblI4aEJkNmhwaUFO?=
 =?utf-8?B?NWRLb1lvaW9ITGNwU3FJdmF3MUpCM0lkNXU3WW14c3NrazlMek1KOEhUY2g3?=
 =?utf-8?B?TTZVdDBNcmpGVFZqeVY5QjlaWWV4OVp0RUg0bzZHSW9kWWJ5SjY5MmlBNEN5?=
 =?utf-8?B?RVBWL3NNanlJdUtsaW1uQUYva1puaERMZnplQ1hNSXBXc2NKNWx1SGpaWHc4?=
 =?utf-8?B?YUFKS1dqeVdSZTNOTVZ3S3FKeS9YNWdLSmFiV3RaZVd6c2RYbE9HQ0EwMHNr?=
 =?utf-8?B?NDJMZHl0NGI2VHJLWnhRMndORVYxRm8raXFuZ1hxc01QUmtYaGVyekV1RU1x?=
 =?utf-8?B?TElpeGlEMithRTl6RldQb2NkcEZHM0hJTENsRHZFNnNBRUR2cDNncnl2dnhH?=
 =?utf-8?B?RWZaT1N3REZ5RDlSMXNXQ2NBdytwaUUyaEhrWGtGaTAxMEZaeTc3NFIyeFVi?=
 =?utf-8?B?QlR3ZGovcW1GSEVPSDJuejhmMGwyRkR0UTNWUE9vdVhQeEpER0tQWHh3SWtW?=
 =?utf-8?B?VXEydGVLVW5HZkNqMk1UV1FiTnRKQmhqYU1lc3NLUTRGVFV1bjFRdmZsa3lG?=
 =?utf-8?B?SmtMWDBheXFJSzcvMVBXRUpzSDVhdzl2NXpua1EzWmpGRDJ5SXhrbTZOb1Ro?=
 =?utf-8?B?QXY5aFRWTC9iTGYyVXlBZU81b1pDbFRpVm9ObUM2NTk2UXpzTVliK0YxMVJH?=
 =?utf-8?B?TFFMZjgxbnY3U3ZtUGp3cVIxL3NJUW5XcjBBZkVraGxUWG9xcjUrVTJZMU5O?=
 =?utf-8?B?bDR4eWZ2ZTJtQTJSSE5Sc05nZkU4WkxSaW1ic2lQbis2djFYNEczTUV3V3Jt?=
 =?utf-8?B?R3YxeXpadkgxSTV1bDZqdEM3VmdCYlhFdHg5cThFMU1mcFVBSjZhV01OOVl6?=
 =?utf-8?B?RFhySURGOThhZVpYQVdSdjNYUXN2M1o5blBQWjZBZGZlZDl1U2E1SFYxL0hy?=
 =?utf-8?B?QkhIcWlwRDI3c1ZTclYwQTcwMS9ySjJQRlNzRElKbGEzRWFYazJ2bzJGdm9K?=
 =?utf-8?B?dktncVFxalB2bFdxNkZxcC93Z1lMeEYvU0Vzeis2aDdpK3UvY005cWFITEU3?=
 =?utf-8?Q?OntCjIDYtCn7YZl0EbzfsALcR?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8340e9da-44da-41e2-45aa-08dc813a19fb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:22:52.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AN7vL9uVDXTFSl2eYaOnVg2QJbglhNd6qtV+/jZef5OR/j+0tg4xZkVH2bCwZ8sBrowNqYU2iN4pA0o9n+oJZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7854

On 29.05.24 18:05, Diogo Ivo wrote:
> This patch series enables support for PTP in AM65x SR1.0 devices.
> 
> This feature relies heavily on the Industrial Ethernet Peripheral
> (IEP) hardware module, which implements a hardware counter through
> which time is kept. This hardware block is the basis for exposing
> a PTP hardware clock to userspace and for issuing timestamps for
> incoming/outgoing packets, allowing for time synchronization.
> 
> The IEP also has compare registers that fire an interrupt when the
> counter reaches the value stored in a compare register. This feature
> allows us to support PPS events in the kernel.
> 
> The changes are separated into three patches:
>  - PATCH 01/03: Register SR1.0 devices with the IEP infrastructure to
> 		expose a PHC clock to userspace, allowing time to be
> 		adjusted using standard PTP tools. The code for issuing/
> 		collecting packet timestamps is already present in the
> 		current state of the driver, so only this needs to be
> 		done.
>  - PATCH 02/03: Add support for IEP compare event/interrupt handling
> 		to enable PPS events.
>  - PATCH 03/03: Add the interrupts to the IOT2050 device tree.
> 
> Currently every compare event generates two interrupts, the first
> corresponding to the actual event and the second being a spurious
> but otherwise harmless interrupt. The root cause of this has been
> identified and has been solved in the platform's SDK. A forward port
> of the SDK's patches also fixes the problem in upstream but is not
> included here since it's upstreaming is out of the scope of this
> series. If someone from TI would be willing to chime in and help
> get the interrupt changes upstream that would be great!
> 

IIRC, we are talking about this downstream patch:

https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-5.10.y&id=bbe0ff82f922d368cb7e00c5905f6d4a51635c47

Jan

> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
> Diogo Ivo (3):
>       net: ti: icssg-prueth: Enable PTP timestamping support for SR1.0 devices
>       net: ti: icss-iep: Enable compare events
>       arm64: dts: ti: iot2050: Add IEP interrupts for SR1.0 devices
> 
>  .../boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 12 ++++
>  drivers/net/ethernet/ti/icssg/icss_iep.c           | 71 ++++++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   | 49 ++++++++++++++-
>  3 files changed, 131 insertions(+), 1 deletion(-)
> ---
> base-commit: 2f0e3f6a6824dfda2759225326d9c69203c06bc8
> change-id: 20240529-iep-8bb4a3cb9068
> 
> Best regards,

-- 
Siemens AG, Technology
Linux Expert Center


