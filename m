Return-Path: <netdev+bounces-232338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D013CC0434C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 05:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884D93B67AA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CA61D5CEA;
	Fri, 24 Oct 2025 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="AYMfmZX1"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F30146D53;
	Fri, 24 Oct 2025 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275015; cv=fail; b=EJSV9fRB6gQwILrDNozcP492pz88wmT72ksUzMMVtvyeKUNH4SNMedo5XYGXIa0Cxh17L+uBbJ6RBHxBvIL3fdheR5vFIlFkU/A79+xRZlgLyK9N4kj7YGrdsgysUygmQY2V66zotKgXNCQc6KqI5jczKzn+QBmw7Jc9ksGXJZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275015; c=relaxed/simple;
	bh=OeuPMww4UNv5SqeewH4dbnEv1HwB9xAzgF7ws+3QAF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MUNTMku1lO/ccq3jWfAMVPe4WTET8cHqNAPlbgDiw8NG2MjEuGTldbPW1O9sJXfALbG+7gAOVviPOcv7qJd6c3NFNWDs0JWMHP8hRkw7O+TTbQsb4LpKwg4uQY3CaC2i9n2fJPYoLMKLKUTduyigJ3SaAHEhX1c5HSljpMXO0UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=AYMfmZX1; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZyso59T3HjcCBMtvFSMoZD/UaLuGe3aU5LrA9Ir2SuiiZOmLgqRKeT34GWbh7me3ISnEDOFlUOfTsELqrHWsXNYccOWRyQhpGsa+iFyB6i5y1bUCFAqxoh19Om10nssa0ca4EVuViDVRAfn4lI5O7NACnZ+K78sKGiCHNCGxRvS2mkgNet5M6KmwxETK+fi65u1QxqzrHt4hzNQBOBzIiGlWnQJQkSex3lhFqBgtx6Hm9UFyL1OXj1cK/owZ1FOW5z9mWcjN+PKXNAhKTrdS9f+G3tQiDJzucyc8DJOZF11kQAxr/Ly3sstfSNaXkeTRSdFwgURdIqVH6ffq45lYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjflppvYtpVdjqfddYua0zLtAmdtGv+i7XvnBLTp1BY=;
 b=Io1bWKZ/jgACvvmeQsAxjo9pF/4fa14+ujNl1nCsGa8/633wiyeOx0ryCd2Hho49y8NJwS3M7hszA347r0gjCRQWETYaPlHC+XSRZXMN0fu5uBSVu6ZdE36EF/M1R77DPIClbCvcbuAfOanvmSd+pPAG1wFgJwbkE7xUq5hY1V+RgPd1ywsO3H/SsCUPBkgL73L+YXazm0Vg0jNYRubmBikU/eILSlBtcBMzujPwXeZkishk8UlVb16kFxYvZdDlVm1R44Idh5O5HDYIxgYatnmL5VnLrD4SklNDkvToIaiC7hrjyQhUFvsoQVqpdlE6e8VjzrkLM5QI9V4mW+Zokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjflppvYtpVdjqfddYua0zLtAmdtGv+i7XvnBLTp1BY=;
 b=AYMfmZX1a+4Qumfke7w0L9u4hYYnRuXPk67bJBo/eS10Pv0ZbHnLreprf7lAIjG4TUdC28cYv1m3MY5svk6oV3q2RQuPzxy4eXAN4+nnPYMn6/xGavBmPsW2DmmX5BB6G0x/UW6hTc4j7EYZtNFj999G3SZuA9WDwJ7BUvRM36D8tFnQm05utb0+axIxaPfump2cgaHtVduSSVN+dZNg4KnpB+DO9NZAKcIGSG5ffqVx4IeKoMouhDlp4OwNe0djxZp0prpKTkCe1C3dwX3SJEaxF1ULspu3QaJd195bhfCTtgrcOXEPcoTm3zJ6rik75/UtMBCV59yoKDpLwKN9gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by LV3PR03MB7453.namprd03.prod.outlook.com (2603:10b6:408:1a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 03:03:30 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9228.014; Fri, 24 Oct 2025
 03:03:30 +0000
Message-ID: <12fa7c65-c257-4013-baf9-695ff4c2a4bd@altera.com>
Date: Fri, 24 Oct 2025 08:33:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net: stmmac: vlan: Disable 802.1AD tag
 insertion offload
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-1-d3a42e32646a@altera.com>
 <aPI5pBXnh5X7OXtG@shell.armlinux.org.uk>
 <e45a8124-ace8-40bf-b55f-56dc8fbe6987@altera.com>
 <1abbcd93-6144-440c-90d9-439d0f18383b@altera.com>
 <aPoJVOUe-ASx1GmV@shell.armlinux.org.uk>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <aPoJVOUe-ASx1GmV@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0148.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::18) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|LV3PR03MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: dc298d12-a793-41fa-3dc0-08de12a9e920
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mm1xQWU1czJzQUdhdENldmFlcnRPRXQ4VHYxN1o4Z0p3RmdoSVdGOUhRTjE1?=
 =?utf-8?B?c1hFYXdJQkV6OGp4ZEV5VkFwMkxETDUrQzZSK2pWdk94R2l6NlI3aU5Ua2E3?=
 =?utf-8?B?dDg1RUxLQ2d4WkUzYWZubzloTVBiTVVJUEdNeGhhUHYxaVFOYXQwUU83dDFQ?=
 =?utf-8?B?QXllSDFIRnh6MHk4bVVoQTZ5MzQvWjYremFQTjFNblpYRGQzRWdSbXg0UHFM?=
 =?utf-8?B?Z2Y2eE01OVRnSnk1Y2RUOXVIblAzcTJldXp2dHZjUWJUamJ2RU52S21ZRzYy?=
 =?utf-8?B?WUpVNHRXN3Y5Qmk2bUhabmgzQXZyTzBPWnBhT0hra0UvanVud25kTlVBWXNz?=
 =?utf-8?B?YjZuRUl6QjhSeWZUcG84WUdHeFd0VC9OZGtWUklWZFBZcTdERlp3NFpldmh6?=
 =?utf-8?B?WWFlenFpRzh5aG5BeFZVM0w4YnN0U2JUZWwvSlVOSC9VM3F6SnBFRVF4QWNy?=
 =?utf-8?B?RjZ2T3dubVA3NjUzd3VtSGFlNVRoYkpTcnpyQkhGazd6b0xDS0U0Q25WTUZ3?=
 =?utf-8?B?cmZuN2xmOW1iTG5PU3pCU3UyMUdJSXhmZkExZUtyT1ZKa1lpRHJOa0ZWT1Yy?=
 =?utf-8?B?MHQxRE12V250Vjl4UXFvM3dPdDlEenZTdDg1WW1hRWVHY0JUTExCYWJuWWE4?=
 =?utf-8?B?SkhhZHV6NlJ0RVRuMjU0SXNBNzVvWnF6a1V2VDg4ZTZwVjZlUXpEUGp2SmZJ?=
 =?utf-8?B?MDlGWGZWdWRWNjg0NG9yR2xyaWg5ZUZLa2lKVENKUkJGYVJTMzBIejBsYUdx?=
 =?utf-8?B?RStEY2c1eGh0MGV2ZkdWRXVNbGdBZEt6cGEyUUdqVTBqeXAzQjZraW5FbHVQ?=
 =?utf-8?B?UlIwQXhLa3lES2xBNXpVUGFiZ01oLzc5dWdvbitXV2xFNkp1NnVzdzdsWFhT?=
 =?utf-8?B?RHE1TnRuazFoZTZWVHJiYXBoYjNMd2xvRzhKRmVXb0tzaUFYNTB3dzJySXJO?=
 =?utf-8?B?UDB1cmFQMW1JUkRkdEkyUElyMTNKWURCcTFwM1B0aldWN1BFZnhiTzY5VTZq?=
 =?utf-8?B?VnVuemhjcTZ6c29ENUh3bE9DSGpiWVQ4SDhOc21xbW96QzBqaXNrekZEMXBa?=
 =?utf-8?B?QmNITzh3dEdETGxNTm9lMFBCY29BemtrVUZRMFZBRkZOaG5FNjBEZlA5bmg4?=
 =?utf-8?B?dWVBUytHZnBmd3BHNHRmT25vUUtVVlBkcW8vVmpnSG5TdWgrc1FuVFp6Nm9j?=
 =?utf-8?B?Zmc4K3djbkhNczJCRUY4bStJdTNqcGVQa3VHenkyUlVPTTBlQS9GTko2eUpQ?=
 =?utf-8?B?TjVoK0NSOGc5OEMrd2dnMDRYeTd5NWxtUmZUblVHb2xRYzRYYzVoZmo0SEVp?=
 =?utf-8?B?MEVBM1M2ZmhkOStOUkpaS3Y3WHkxeEpabGVHeXBCM1JnZ1pXczlXSjB2VEZw?=
 =?utf-8?B?R20xalpNTndHMmIwK01BbUZwdzlsUDB1VG1IUlUxQU9YVHkycUtRdGdyUDQ2?=
 =?utf-8?B?RXUzMGNzZVl6MENubkZrVkcvZjBIVnFVaWFCb1pxWlFESWR2VXF5MHlYM0Fx?=
 =?utf-8?B?WDBwc1RyMGFTWk9ObGRzb0xuRXpTSFVaRWJlL2Q4REFGazJsalhtL2JicnBs?=
 =?utf-8?B?UUtPM3FJT1dOOFowVU9VMFFLMFpjakpVWkszVG01a1pLRU5zM2s4OENzbnhi?=
 =?utf-8?B?MmRGc2JPSXNTaVUrSDRFNnV2UmZkL1JoK1A4a3kycmFGQ0JvWms1RlNBZUo2?=
 =?utf-8?B?QUNJanZka1dKWkVoeDU5N3RQRUJLemVqQTJwd3Y5TUZpRmgrVHFrQ0NrcTky?=
 =?utf-8?B?YkdaTDNtUE56eEFxTW92OHltL2JBcXppUHJEdXFhaHVCNlowYms4c2g5KzJz?=
 =?utf-8?B?cWhoUERvZkhRNnd0QW56ME9mcG4rZ2RuMmRlNFlhQ0I2cDlyWk5qNk5sZVJ1?=
 =?utf-8?B?dEdtUFJsRWhGdnNlZlVpWUROVmFZaU52KzhsQyt4SG04RnJndG00TURHcmQ1?=
 =?utf-8?B?Mk5VVThtSU82SUhqeURIbHlWNm85TU9ab0FUckR1WEpUbWVsOU1jbEQxZyti?=
 =?utf-8?B?c2k0V3dqcjd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmZla0VHN0tRZnJuMy9pRlIya2NSQjlPYm5XZ25wNTR1aGRLYWZnWTdoSkxB?=
 =?utf-8?B?WEhsNmprV3NDQXVNQm9HNER5N05RUSs2cThXL09Ja1pUejcwdmd4bWNsb2d5?=
 =?utf-8?B?Qk9BVUpnQkNBZ1BWWDQxQ1JlMTN6enRzcmd0ZUdHUjJpSTE4QURjTkhpTnhz?=
 =?utf-8?B?bVRKYkxzSlZMU25icEhIaTd0YUZIbDNCRytVckNNcUpiaUJVdHpXMUZMdTBS?=
 =?utf-8?B?TE5pYSt3ZGROSVhvcmF0YlMwMElVd0lYTk5GWUsxMnhoQm81WGFPTWFvaEx2?=
 =?utf-8?B?eTFtQ0wwUTVLNmFDN2d5blp1Ym50SW00K1kvZThtNHZZdnJUcDhxaS8zNi80?=
 =?utf-8?B?Wk9xQUdwaTA5MW83Q0pFbHdqNkQ1TkxhelRKNFlCemdUK3dUTENMcnJaNkZZ?=
 =?utf-8?B?ZVFiU0VZR2cvcWxZUHh2aW9Qa0YyMzR0bi9lcVMzMFluYTVZMmhjWVVrT3pP?=
 =?utf-8?B?VlBrbFhIVUNiNTd5L0F3Z1ZoeGloS3pmRmwwUkI5a2JtckxjM1lqZUg2cUtI?=
 =?utf-8?B?VmJPM0xYbUh1Qmx3dDdLMlVtbktCcjVnMkZnUUVaL0JKVi9US1FVbFRNU3dp?=
 =?utf-8?B?dUw1dFVreGlhcXdaQUkrR3NoRjF5Ympwem1veVhpeld3VG05cmoxZ0taeFha?=
 =?utf-8?B?ZkJMcm5DK2d3dkJhUkNhZ1JQOTZZV0FydzlHWjExV3BtSW1tbk96K0xvZGdF?=
 =?utf-8?B?WUc3alQwS3NmdnUzNW1HbVJqczRYNnpXQWRuQUxySElVdlFmZHhtbExmZlFQ?=
 =?utf-8?B?WjE3ZHVRYzlSd2k0Tjk5Q0pwYmhlejlQTkZmQ2o2cUF2d3V0S3FBbXN4bG8x?=
 =?utf-8?B?N0o2RVBzUmdjQTZHNjRFMzQ3dDQ2NDNjZWE1dnMzeWlhcm44NG5CL3hFOVJ2?=
 =?utf-8?B?RVJFQmpLSkk2ZUx0OCtjbnJnN0ltcjhLSmdjNWJMZldwSk0rMWR4MS9KQjgv?=
 =?utf-8?B?S0EvVHM1RmJGODJBcERoL041b0JUU2Q0emdyUzhyQ09RTXErVG5FYkthMG41?=
 =?utf-8?B?WEw0dVhXbkg4THBkbkFtTXduZUVnWm5sQmxwNVlYdjZseERtSnVHZ2FrdUNp?=
 =?utf-8?B?ckNvM0cwYnVwVlBlTGZML09ucnJJRG9KQmJKYmJLeHNBNWo5aDFwYnpHSnpy?=
 =?utf-8?B?MU0vSEE2V0pIUWpUTEZXdDdLSTYyNVA3dHp3OTFoZFdvR1V4cFFIWkR4Nnlr?=
 =?utf-8?B?WHA1cDR5b1BFNStpa09jVzY2QjE4VFJDYzd6MUExV0VDTWNMSjIyaEFLZVZo?=
 =?utf-8?B?UHM5cFZrZmxPZ29JVUxqbjNGUFNLRyt5VTNXcWR6MXdNL043K1NrZzRqUTNR?=
 =?utf-8?B?RDZHdXdnWmdPQ3F6VUcrZU9saHh2QisreHhnOE95TmwzeHdma2wzREg1SHBH?=
 =?utf-8?B?T0Y1VEZ1aEgrZlJkcklINjJ3QUw5SHJ5d0FzYlEzNmtiOFlGdzd0Nld2SzFn?=
 =?utf-8?B?TGZzazFBVDBYbDBQQ0M4Y1NJNGlQV1VGMENKRkFxaEN6SWZKOUZYa3Bod3pB?=
 =?utf-8?B?R3RwZm81a2tCeGd0U3czNC9VUHpQdnRKSGR1ZW95Q2FjbVBOOXo0blFwemYy?=
 =?utf-8?B?bW9hS0hqUlRiVVNRcDZQSlVCK2xXRHYrNG1kcGtERHFBektKSllHMXVYTzhB?=
 =?utf-8?B?R1EvNXZyS3A0K2dnUXJMR3Y3WjdYYjRiS2lXZ2tyeHNaMVdpaVNNN2RLc05z?=
 =?utf-8?B?TklUelZBSjF4QVlVVmJZRUp4cS93TDhPYjNabVVMeTFBbzkzT0JQbm44MEk5?=
 =?utf-8?B?NW5LNkpWQVpjdGVxSjZjRkN4eklaaFdGQkQ4bXVNUlRNN3JERHpMd0lESTdm?=
 =?utf-8?B?Ri90UUUveG01MHlLeWVHNVZkWEI4VTBqMmlIL28zVEFrMElMQ2xIOG1hdnVY?=
 =?utf-8?B?YkF4cXJ1ajZ5aWhrKzZEcVdYRmxSMWhLRllKVzIwYXhRKy80N2lMYjkxY2Fh?=
 =?utf-8?B?YThTVi85RjkrdWw1UEplcTMzQUc4aklKQTRiN3NUZUdNM0xsOUg0SHpqWlRo?=
 =?utf-8?B?eXd1d3VvdTNDWERyZFhPQ3ZzZSt2VHhlUzhPMENXa1JXejdqZXdDMWpYQjNW?=
 =?utf-8?B?UlRLQUMwTjVlN0VDczNpa0libFBqUyt4cW5ONFBybnFxWlJQT2l2SStIUjhM?=
 =?utf-8?B?OElubzE5eXdsemNGUHlGcXRuUzhsTGE4ZWJCTmswaXIvbW90Ky9TaU5MS0ZH?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc298d12-a793-41fa-3dc0-08de12a9e920
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 03:03:30.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fayfnmCrJDDvQYaK3T3enRAeIlZjBHCzbHa/mpRFW3KrXAuyqKp7Dzq2wDmBJzAEclHIBRw3WW7qwi5vN37ENRPTM+gc9eRZe/SWCJ5/Vuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7453

Hi Russell,

On 10/23/2025 4:24 PM, Russell King (Oracle) wrote:
> On Thu, Oct 23, 2025 at 09:01:20AM +0530, G Thomas, Rohan wrote:
>> Hi Russell,
>>
>> On 10/18/2025 7:26 AM, G Thomas, Rohan wrote:
>>> Hi Russell,
>>>
>>> On 10/17/2025 6:12 PM, Russell King (Oracle) wrote:
>>>> On Fri, Oct 17, 2025 at 02:11:19PM +0800, Rohan G Thomas via B4 Relay wrote:
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>> index 650d75b73e0b0ecd02d35dd5d6a8742d45188c47..dedaaef3208bfadc105961029f79d0d26c3289d8 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>> @@ -4089,18 +4089,11 @@ static int stmmac_release(struct net_device *dev)
>>>>>     static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
>>>>>     			       struct stmmac_tx_queue *tx_q)
>>>>>     {
>>>>> -	u16 tag = 0x0, inner_tag = 0x0;
>>>>> -	u32 inner_type = 0x0;
>>>>> +	u16 tag = 0x0;
>>>>>     	struct dma_desc *p;
>>>>
>>>> #include <stdnetdevcodeformat.h> - Please maintain reverse christmas-
>>>> tree order.
>>>
>>> Thanks for pointing this out. I'll fix the declaration order in the next
>>> revision.
>>>
>>>>
>>>> I haven't yet referred to the databook, so there may be more comments
>>>> coming next week.
>>>>
>>>
>>> Sure! Will wait for your feedback before sending the next revision.
>>
>> Just checking in — have you had a chance to review the patch further? Or
>> would it be okay for me to go ahead and send the next revision for
>> review?
> 
> I've checked my version of the databook, and the core version that has
> VLINS/DVLAN and my databook doesn't cover this. So I'm afraid I can't
> review further.
> 

Thanks for checking. Understood.

Following public document appears to include the DWMAC QoS IP databook.
Section 44 of the following user manual might be a useful reference.
https://www.infineon.com/row/public/documents/10/44/infineon-aurix-tc3xx-part2-usermanual-en.pdf

Best Regards,
Rohan

