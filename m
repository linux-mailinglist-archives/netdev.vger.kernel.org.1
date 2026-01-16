Return-Path: <netdev+bounces-250513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7FBD308E0
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED95B30D9A90
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F473624C0;
	Fri, 16 Jan 2026 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dJ4eYup6"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6820236E464;
	Fri, 16 Jan 2026 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563540; cv=fail; b=ZiGHVfkOVnZyou5eMsECKbb08Mr3bxAUgNgeQFBULRuiQs+PVTJzxg1wpvoo2bQGnrig28ftEiDkNs0QEF8JzEU7v1gEg/EwLIw5TXlghXWXv9R8/uxJCnlflnOLQWYM5AYhiZV4vkmQe9e8s44CujcnRWaDvBJZ2EcbMVigz+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563540; c=relaxed/simple;
	bh=xjHexyL41cktR+m+HJu9dmXtRq0INGc/8AW5n/FlULQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dxOXb3Xgd4R0YVM/5wub1CxXzQ37x+VJLxF8TvFrfxLGApXJUXNYqCUtEhwfsOJWaT/5UaXLfriVchQnay2NTaA8851pFsuX8EIYrzV0BHQBwh1PFK3aet8MyICdMEOhIj9hUeNPjIPnD72KNZCyNyeh0qJLRXuTMmAOLahukN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dJ4eYup6; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqGbl4JCQUOXvqtHcoqarU/eqVfpAWdWan/OlE2lV+koafw2ko2Mxxf6nvSwCw28sm2hp4m4rQ2sjVhy99RJ/z5aKEV44qz5/HRjc722AZGiFx8klipDsNRCEXeRP+CZ21OsSCEH8oqmVKGASWWIgzovGg/N/8thk98awbt7gqntaRar1o848J1O9oMiIxZ27yUx4T9ckTkajmFIYOS47LQywdyOANFFu5w788/hTJndEGjeBDNpobSX0OudrVF1Nqy9uDXObnMFagXHeU67lO+9kckOHTKrnmngQK1np+1gJcBJfri9evnYYvaX6t3Km3QYP4aCsec8v/LZO/jTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMDClEORyRcAfUg/FCN47bRzgOzuHis24yPJGFaRY4c=;
 b=BosQITIIRxGMTySssw8BfYfh8OiPhG2l2OwgfetpJN+4PG2vEpQk0PiiK47a4QIhEB9LKjoWwMdgoX7aVEkVOfweaD0Er8jSTQHhSRg4UcPXBeDSirAbjw2IGW4A1mfdAKqQBx5MRsnhAsgxIsIHRPZuCJiym6Me5vSewj3biRCIv3kpSb/9y/m9JALFS17PcodRzsLmx3GwnYM9DtpQHD/caM3G0Ko9BVRL4b307RmP+9DqxcCjFzIY0CTscCFl7hzFp89+9NnOBLAuPD+ZjD1p48+ZMiWYGDEvqjZU77fX3TqFGnbQxSWWUtL6x+UVY923EWpCOHMtfH4N+C6NPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMDClEORyRcAfUg/FCN47bRzgOzuHis24yPJGFaRY4c=;
 b=dJ4eYup67XKmC6T16q/QNTwhu3vs4n49r9gAWfS8UihrE1aWXZpqT602dw9j5TLlpafviOLElRga8ReFEXkUkFg4XINkWmzefb/i+2bdS8oaBGWZP+JQleeo6Y/NurGUeMij+LjiATLTswaVb4rH7T3emnuCR/OJYMgSRQzAthp5HYfHfwwyMCMUEHQewy9CeYIbQb2mMoSNnnn6p0XWI3E2YroHVJI+1UNnSMwBsKC+fCMKCBbOVSZHyAyE5qHzqn2+Fgf1Ng0/eE0r9Oh1YCzKvojpO6S2S+3y+MB6s1EC8eouzmwZcAlJrCuoFJ4MNTb66yGejuDAkvq2d+BZkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 11:38:50 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 11:38:50 +0000
Date: Fri, 16 Jan 2026 13:38:47 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20260116113847.wsxdmunt3dovb7k6@skbuf>
References: <20251215155028.GF9275@google.com>
 <20251216002955.bgjy52s4stn2eo4r@skbuf>
 <20251216091831.GG9275@google.com>
 <20251216162447.erl5cuxlj7yd3ktv@skbuf>
 <20260109103105.GE1118061@google.com>
 <20260109121432.lu2o22iijd4i57qq@skbuf>
 <20260115161407.GI2842980@google.com>
 <20260115161407.GI2842980@google.com>
 <20260115185759.femufww2b6ar27lz@skbuf>
 <20260116084021.GA374466@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116084021.GA374466@google.com>
X-ClientProxiedBy: VI1P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 5093b863-c7c4-4b23-5111-08de54f3d14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWJVNHdBMHhTbUZZQ2ZVL2NWbmdoRE80S0x6MEo3Si9kN3hhSzBLLy9nRGxu?=
 =?utf-8?B?V3VoUUtCai8vZWZPNkI4cmVWc3A3ZVo1NzU0eTk5SjR2bG5sbEJ2VU14ZURv?=
 =?utf-8?B?WkJPaTkyYklNWUJ0WWVLT0FvdVZUWVRBWVczbkNFYWsyN0JCN1lzMnd1NlVt?=
 =?utf-8?B?cWZmazlJY3gzb3hiOUxHL0IrRzlia2hKUFhPQ1BHcDZ2ejZ2SUYyWFExLzVo?=
 =?utf-8?B?SUE2OHRoOFgvN0w1Z1hEYVRDaGtSSnRmOFlIVEpnMGFwTXZQbkJxYzJpSXl2?=
 =?utf-8?B?aTJoNVdIZFlGelgvM1ovQS81MmJwM2R0T2FvLzY5aU1tY2tNbW9aRllmOE44?=
 =?utf-8?B?dXhrUmZHQlBqOGdIVlFJNnc1UnV2WmdwOXIrTVptSHZMMlRac21iSlhPcHNE?=
 =?utf-8?B?U2RuZ0RqbHZhVHhnZEt3Nk1rSDg0S00wZHVrR3psMzJES2tkSkxWL09jWFlS?=
 =?utf-8?B?WU5MYzFLZytEMkxpb3h1TldiRmxFVVZLUnhmTzNjS0NKcWRNbjhPL1o1cnow?=
 =?utf-8?B?eXdRdEFsQzNMdmJnUk1vZm03YnJSbElhSEZ1all4TmRkSzJXNW5pSVF5V0dC?=
 =?utf-8?B?Z1RIblNoUDlUT0FrWUJWNWFUR1ZQTmMralRsMnZTaXFZUlQ3OUNWVUs2WDA4?=
 =?utf-8?B?Zkc2aEw3bzlzY2Z2NDR1QTVmOStxZEc2aEVtd1Fhc1htWHA1ZjdicGEzOW1k?=
 =?utf-8?B?T1lRRVpnMHRISE14cU9NTENJQWNYZXFzM0JNSW9MWkdqRU1OK0lLTDhVOGpW?=
 =?utf-8?B?aWdiaDVaMnpHb0R6NGdaKzZMeWVUVDl1dzVZWU9pOWNjMldXZHhjQVpDUHo1?=
 =?utf-8?B?V1JRbUhrWVBYalFQSzRWQklLaU9leHFTY2ZuOTlQVCtQd0pmbnVOWGhWc0t5?=
 =?utf-8?B?eXN1TmM0SXVjZERFUlhrTXdZTlRnSGVZWDNwVDRISDBHalI3RlNBOTV1N2pn?=
 =?utf-8?B?M3htZE93Vk9oOVAwbkR6bFRIcWpsUjhZNy9VakdNeW03YnczYkR0MnRtQWpC?=
 =?utf-8?B?UkNTODR6bEZFaXpsd3RhY2M3eEJNSUNOWE9HcXZOZzZMTmJKaU8vWWYwUmhC?=
 =?utf-8?B?Z3VOcWFpS245SHIrSUJwRmovQk9sUVZ2MDVEZndEbUZ5UGVFUGZZU3dROExi?=
 =?utf-8?B?YzZZcS9Ub2NaMDE3dks4VVpGNnI5OHVBd0pUVllqenZQeVMyUkxGd1ViY2ts?=
 =?utf-8?B?RGhlYzhDTU5mNnVwenh1UTJwdGExNnkwVnFWbFVQazc2eVo4T3FCRWlNTWxq?=
 =?utf-8?B?eW4wYm5kZUo0NUlsVTJwWG41VVdlcWRzWTBQZTFBbm5RalBDVGgvbnhvWGFT?=
 =?utf-8?B?L01iN013OHhUWlZCeWo0SllaWWFnUHBpT3BEWlNwM2Z6cWtoSlp6dHg5MXly?=
 =?utf-8?B?VlJEaWxSbm5ZaUs0dG5EemtxdWt0YWR6Y1MrSVpxL0RMU1hac1BoYU5RNkxL?=
 =?utf-8?B?VzQvWHhaUnNJbmtqU1RKSFNYbDN4UWtudnNHVGxweUhqS3JUd1ppQTJNSmVj?=
 =?utf-8?B?K2hWaHdvdnpucllnRzlLOS9Ma292RUhVUmdRT3NPeG9iRU5sU051eTZtMy9Q?=
 =?utf-8?B?NkRNMk9sZHQ4Ymtob2t0UG1jcmdrcENBa1dnVG9HaW5POExzY1NiQVU5QnUv?=
 =?utf-8?B?OEhCYndCSmpVSDNTQXZqN054YjBvMXNvOUdqUWxIN1dzeUxMdVljQUlWSWN0?=
 =?utf-8?B?eFplbjVtNUJBRG5jSmpFaEZvV3FWUTEzNmNnVlUzUWdQNGFlZUd2TmJLZi9a?=
 =?utf-8?B?SG5aYk9GOXRyZmFLOFV2SWNTT2FVclZudnBTVjV2bUpnYXRYSkpBSjVwdXl1?=
 =?utf-8?B?c1V2NjJqUFNFTDFVcVJqcVFZdG1rdEhYeXZGWnpLNUtad09TMDVYK1pVYmc2?=
 =?utf-8?B?REdkejNiblhSVkxUSzMxa1B2dGs4NnA5amtRMW5HVW92SmtsVWJ3WWpmaktN?=
 =?utf-8?B?WHByUGhGVDZPZ3A0aHhremRDUkZQaFBSOFVKRDVHcndack5xN1VLZ0pLcTNy?=
 =?utf-8?B?S041T2R1OVByTy9UbjY1MDZzaS80NUtXbnZlS0hrVVZCTXp0NndaOTJzRmNy?=
 =?utf-8?B?OW0wK3dzalNjNzV5TG45YzdoTEd3YWZwa3FkK3lhRVN3SnYybWJjWm9JcnRY?=
 =?utf-8?Q?et8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWFNZDFWQUI3RzZxUXBPUDIvN1lkZWdTN1lUaHE1cTZ2OGN0NnFRVUVVUjZO?=
 =?utf-8?B?WTV0OStCdW8vM0VIYm9ESno3RVBFM2F4cmIrWFVhditTUXpTTFlTVGVWdnRI?=
 =?utf-8?B?RHlMYm4xT0FoaGN1WHc0ZjROR0U0eGZDS0VzV3M2ZWFSdWlIVkJiVnpaVmVv?=
 =?utf-8?B?UVVqVnBRR3ZaRi9wVVRYREJ0bmozRTJlQjNYM0E3eGpncjFSb1JzY01Sa2FO?=
 =?utf-8?B?VFVpalZOb1FZNERsSVRYeXk5Z1BPcStuRFhSWmloeWdpWk0xR0xyVXRYOU9V?=
 =?utf-8?B?RVhEY21iUC9mSlhhdENNMkw2QnZSd01lUW9uYVc4SzNVeUtmaEh1d0pKNEln?=
 =?utf-8?B?UjhScnJTVlBFY2VFcnpTb0ZiRFNQcFRKNDdDS25xVXY5RjgvU2JPSnBTUVlL?=
 =?utf-8?B?YkJnOG5yMm1tM3JDeFJvWlBFZXBoUDBySnBHMkdDUjdkVVVKWFRkTEN1U3JE?=
 =?utf-8?B?a0JMM0lpNVhPdlRlM0xOak1udmMyMTZuY1JZRXVjYVJSeXovQ0ZsL1B5S0tL?=
 =?utf-8?B?ZG1NR0c5ZUo3WTZ4VTNkZUZQalRYcU5FTU50MkpKaG5rQUtoVGlIdE0wYkI2?=
 =?utf-8?B?Um55WTBQUU9kZndqL09aTS96Sk1odkE2NnNvWWFVdm95UFB4eXdmUXVSS3gy?=
 =?utf-8?B?NTBZenRYeDRqSEhXaGxaZVJVVUVBZHFwdElEMHZzdk1lVGtYZVlDNWlBOXdp?=
 =?utf-8?B?UkRWNGNseXRTUTY5NkRscC80eTN1VExCWENiY0gxQlZWK25KUFpiMmMrdU85?=
 =?utf-8?B?MW1hUC9sVjBuRGZmc1ZxTEtMYzVyRkRXZXVmS21aS3dzUy9ReGZ5d0dVSWpw?=
 =?utf-8?B?OUJIazVvRG0zU0dRNUo0Y3lnL3F2V0NBTGNYcDhJRzREM2RyTmFtb2lrU0Y0?=
 =?utf-8?B?cHFpNGNjbk5nUm52YTEvSlE4L05TOE1RMW9yZjc4aXZ5MzgxOWhkNm5mdXFj?=
 =?utf-8?B?V2dRbmRkUGVuRHFoSnhFWU9DY0hPWkorU1RhcVJ1eHRlMkJXYW1ETXJkbDNF?=
 =?utf-8?B?YUczcXFZL1FCZ2pDdUt2Q0E2RG5ncU0yY1pFbTNMdU1rK2ErVC9tOFlPVDVR?=
 =?utf-8?B?eEJnbXpBQng4cXFYWG90Qmw4QkJPbkF4Z2kxb01lSVJTSEZHVFhhUGs5ZnFr?=
 =?utf-8?B?VUY0alEvaXI3NXhyQ2RRVUl1Z2dKRk1jemtFMDl1TGFKQ0hmOUpyRFl4d3Ev?=
 =?utf-8?B?T0x3WXhUYXdiSVAwR3FnYWZ4VFJkZjB4RFBycEtXaDlUeW9EcHFwN3dzQXpC?=
 =?utf-8?B?ajZQSVVaZVYwVGJxVnRuQU9aQmY0YTdXbnFhWGtYdm5jTmNrWWtTM29SM2px?=
 =?utf-8?B?TVd1THVUZ3FpS1orcjVKZ1NKN1J3S1B6ZjZFc25ac0tkNDZmRHlsV0QvZnIv?=
 =?utf-8?B?aHEzYmY0dGpoRVQvLzh4WmlYam5GUlI1ZUF2WnF1UWNoTlUxQWYvNVdyeDR5?=
 =?utf-8?B?a1c5czJKcWI2a1dtOU5CaEF5YnQ3dEpkcklDaXM3VlBnZk0wYjRZNE9CZU5I?=
 =?utf-8?B?aERaOVBHQWh1OFoyeklVV3lGTmt5bS9QU1ppSHN1MDd4S2x1bjgvZmdVVG1B?=
 =?utf-8?B?OUs5MnFyK0RoRnp6M0VsMXYydWtudS9YcVJCYUlRd1g1aDBOMjRxS2ZVMmhq?=
 =?utf-8?B?VXJORWFPdHNFL3hYNGJyLzFpKzdpa1kyYlhjMzhGTWFDNnNCbTRhdkdUWi9n?=
 =?utf-8?B?bUVVbXFWaEc5UjBzRHM4NHduU1A5TjI4bzYwVGJPeXUvaWNqN3p5STRzeGNq?=
 =?utf-8?B?aTBvUE0xT1FOblMxYjJxVDlYbjFxeC9admVwY2RQUmZ2L1czM2E1QVZyZlR0?=
 =?utf-8?B?ZUlZMmxUSUxBV2RQZXBPZ1BzdjZ6ME5HQkZNMEFOaTdLa0lzMm5kanU3TUxH?=
 =?utf-8?B?RVFoa3BtWnIyM0syUDdycUxYQWcvT0cvWUJYZXZ6S0FmV1p2L2tZSitFVU5z?=
 =?utf-8?B?b3Nic1dYV1dWQU90OW9uNzlBWkdQMVgzczhaNkJpcUlFTmk4dlo0bWtBMS9P?=
 =?utf-8?B?M0QvR3BrNko1UnQxcGdTTmdnUHhvcE1CNDljQ2hYc0grY0dEVGxmb05vVTBx?=
 =?utf-8?B?VDJoK01Qd1kzU1dGSEZtcEJUUE9xaXRqaDd1UXZXdDFkQURVSHZHUFp5cDlJ?=
 =?utf-8?B?T1dKUnppSVNER2ZYOEZ1ZXRHWDVaSWJVRmxReENoQmZtSXpWRitUWHJXeHdy?=
 =?utf-8?B?K1QzOUdZR0REanFxTjFGdmNDRGtMY1RhSjVURk8xSEJGRTB1dHFoRVNGaEY3?=
 =?utf-8?B?LzFqRlFZeFpvV25HKzJOcTlqLy9GTVRlK0NacVVqdW15emtDNzZGZzF4T0tG?=
 =?utf-8?B?NzFhREpnQkZEcVB3YzFRMVZNNzNMT1B4cE1ORTR4Rm9TNmE4QkxSbFNKby8r?=
 =?utf-8?Q?b8pQFSU1zSJGG3WAuz1KTK4TYLrgmQXYrF9/FKq3cGSHE?=
X-MS-Exchange-AntiSpam-MessageData-1: hNgBMQ0X4vfprlHBr85zZCBVnu1/BohSV6s=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5093b863-c7c4-4b23-5111-08de54f3d14e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 11:38:50.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyRzdQ2BTJ+45xKZRLOUwCEyFtiNxtxelIjkjRgiO6+GlKpC9HOtkcbMN6qScDy6+xiYcR+wi0lQVZfF6s0h+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9126

On Fri, Jan 16, 2026 at 08:40:21AM +0000, Lee Jones wrote:
> On Thu, 15 Jan 2026, Vladimir Oltean wrote:
> 
> > On Thu, Jan 15, 2026 at 04:14:07PM +0000, Lee Jones wrote:
> > > > > My plan, when and if I manage to find a few spare cycles, is to remove
> > > > > MFD use from outside drivers/mfd.  That's been my rule since forever.
> > > > > Having this in place ensures that the other rules are kept and (mild)
> > > > > chaos doesn't ensue.  The MFD API is trivial to abuse.  You wouldn't
> > > > > believe some of things I've seen over the years.  Each value I have is
> > > > > there for a historical reason.
> > > > 
> > > > If you're also of the opinion that MFD is a Linux-specific
> > > > implementation detail and a figment of our imagination as developers,
> > > > then I certainly don't understand why Documentation/devicetree/bindings/mfd/
> > > > exists for this separate device class that is MFD, and why you don't
> > > > liberalize access to mfd_add_devices() instead.
> > > 
> > > The first point is a good one.  It mostly exists for historical
> > > reasons and for want of a better place to locate the documentation.
> > > 
> > > I've explained why liberalising the mfd_*() API is a bad idea.  "Clever"
> > > developers like to do some pretty crazy stuff involving the use of
> > > multiple device registration APIs simultaneously.  I've also seen some
> > > bonkers methods of dynamically populating MFD cells [*ahem* Patch 8
> > > =;-)] and various other things.  Keeping the API in-house allows me to
> > > keep things simple, easily readable and maintainable.
> > 
> > The only thing that's crazy to me is how the MFD documentation (+ my
> > intuition as engineer to fill in the gaps where the documentation was
> > lacking, aka in a lot of places) could be so far off from what you lay
> > out as your maintainer expectations here.
> 
> MFD has documentation?  =;-)
> 
> /me `find . | grep -i mfd`s
> 
> Okay, the only "MFD documentation" I can find is:
> 
>   Documentation/devicetree/bindings/mfd/mfd.txt

Exactly my point!

> The first paragraph reflects the point I've been trying to make:
> 
>  "These devices comprise a nexus for HETEROGENEOUS hardware blocks
>   containing more than one non-unique yet VARYING HARDWARE FUNCTIONALITY.
> 
> 2 MDIO controllers are homogeneous to each other and are not varying.

I get the impression you didn't look at patch 14, where I also added the
ethernet-pcs blocks to MFD children.

> How is the documentation and what I say "so far off"?

Well, it's far off because I got the genuine impression that I'm making
legitimate use of the MFD API.

> Okay, so these are the MDIO bus controllers - that's clear now, thank you.
> 
> I was confused by the t1 and tx parts.  Are these different types of
> MDIO controllers or are they the same, but vary only in support / role?
> 
> But again, if these are "both MDIO controllers", then they are _same_.

Their register map (i.e. way of accessing the underlying MDIO devices,
aka internal PHYs) is different. They have different drivers, one is
added by patch 3 and the other by patch 4.
Here is the link to the entire set:
https://lore.kernel.org/netdev/20251118190530.580267-1-vladimir.oltean@nxp.com/

> > > > Let me reframe what I think you are saying.
> > > > 
> > > > If the aesthetics of the dt-bindings of my SPI device were like this (1):
> > > > 
> > > > (...)
> > > > 
> > > > then you wouldn't have had any issue about this not being MFD, correct?
> > > 
> > > Right.  This is more in-line with what I would expect to see.
> > > 
> > > > I think this is an important base fact to establish.
> > > > It looks fairly similar to Colin Foster's bindings for VSC7512, save for
> > > > the fact that the sub-devices are slightly more varied (which is inconsequential,
> > > > as Andrew seems to agree).
> > > > 
> > > > However, the same physical reality is being described in these _actual_
> > > > dt-bindings (2):
> > > > 
> > > > (...)
> > > > 
> > > > Your issue is that, when looking at these real dt-bindings,
> > > > superficially the MDIO buses don't "look" like MFD.
> > > > 
> > > > To which, yes, I have no objection, they don't look like MFD because
> > > > they were written as additions on top of the DSA schema structure, not
> > > > according to the MFD schema.
> > > > 
> > > > In reality it doesn't matter much where the MDIO bus nodes are (they
> > > > could have been under "regs" as well, or under "mfd@0"), because DSA
> > > > ports get references to their children using phandles. It's just that
> > > > they are _already_ where they are, and moving them would be an avoidable
> > > > breaking change.
> > > 
> > > Right.  I think this is highly related to one of my previous comments.
> > > 
> > > I can't find it right now, but it was to the tune of; if a single driver
> > > provides lots of functionality that _could_ be split-up, spread across
> > > multiple different subsystems which all enumerate as completely
> > > separate device-drivers, but isn't, then it still shouldn't meet the
> > > criteria.
> > 
> > Any arbitrary set of distinct functions can be grouped into a new
> > monolithic driver. Are you saying that grouping them together is fine,
> > but never split them back up, at least not using MFD? What's the logic?
> 
> No, the opposite I think?
> 
> I'm saying that when they are grouped into a monolithic driver, they do
> not match the criteria of an MFD, but if the _varying_ functionality was
> split-up and probed individually, they would.  Take this example:
> 
> # Bad
> static struct mfd_cell cells[] = {
> 	MFD_CELL_NAME("abc-monolithic")
> };
> 
> # Bad
> static struct mfd_cell cells[] = {
> 	MFD_CELL_NAME("abc-function-a")
> 	MFD_CELL_NAME("abc-function-a")
> };
> 
> # Good
> static struct mfd_cell cells[] = {
> 	MFD_CELL_NAME("abc-function-a")
> 	MFD_CELL_NAME("abc-function-b")
> };
> 
> At the moment, from what I see in front of me, you are the middle one.

I think you are missing patch 14.
Although for SJA1105R/S, I am indeed in the middle position (it has to
do with the multi-generational aspect I was telling you about).

> > > > Exactly. DSA drivers get more developed with new each new hardware
> > > > generation, and you wouldn't want to see an MFD driver + its bindings
> > > > "just in case" new sub-devices will appear, when currently the DSA
> > > > switch is the only component supported by Linux (and maybe its internal
> > > > MDIO bus).
> > > 
> > > If only one device is currently supported, then again, it doesn't meet
> > > the criteria.  I've had a bunch of developers attempt to upstream
> > > support for a single device and insist that more sub-devices are coming
> > > which would make it an MFD, but that's not how it works.  Devices must
> > > meet the criteria _now_.  So I usually ask them go take the time to get
> > > at least one more device ready before attempting to upstream.
> > 
> > sja1105 is a multi-generational DSA driver. Gen 1 SJA1105E/T has 0
> > sub-devices, Gen 2 SJA1105R/S have 1 sub-device (XPCS) and Gen3 SJA1110
> > have 5+ sub-devices.
> > 
> > The driver was written for Gen 1, then was expanded for the later
> > generations as the silicon was released (multiple years in between these
> > events).
> > 
> > You are effectively saying:
> > - MAX77540 wouldn't have been accepted as MFD on its own, it was
> >   effectively carried in by MAX77541 support.
> > - A driver that doesn't have sufficiently varied subfunctions doesn't
> >   qualify as MFD.
> > - A monolithic driver whose subfunctions can be split up doesn't meet
> >   the MFD criteria.
> 
> If it "can", but isn't, then it doesn't, that's correct.
> 
> But if it _is_ split-up then it does.
> 
> > So in your rule system, a multi-generational driver which evolves into
> > having multiple sub-devices has no chance of ever using MFD, unless it
> > is written after the evolution has stopped, and the old generations
> > become obsolete.
> 
> I'm really not.  I'm saying that if the driver were to be spit-up, then
> it _would_ match the criteria and it would be free to use MFD to
> register those split-up sub-devices.

I don't know what you meant to say, but I quote what you actually said,
and how I interpreted it:

"if a single driver provides lots of functionality that _could_ be
split-up, (...), but isn't [ split up ], then it still shouldn't meet
the criteria [ for using the MFD API ]."

> 
> > Unless you're of the opinion that it's my fault for not predicting the
> > future and waiting until the SJA1110 came out in order to write an MFD
> > driver, I suggest you could reconsider your rules so that they're less
> > focused on your comfort as maintainer, at the expense of fairness and
> > coherency for other developers.
> 
> This isn't what I've said at all.
> 
> What I have said is that even though you've split this up, you have only
> split it up into 2 homogeneous devices / controllers, which still does
> not qualify.
> 
> If you have plans to split out another varying function, other than an
> MDIO controller, then do so and you can then easily qualify.

Ok, so we're getting close, you just need to take a look at patch 14.

> > > Is there any reason not to put mdio_cbt and mdio_cbt1 resources into the
> > > device tree
> > 
> > That ship has sailed and there are device trees in circulation with
> > existing mdio_cbtx/mdio_cbt1 bindings.
> > 
> > > or make them available somewhere else (e.g. driver.of_match_table.data)
> > > and use of_platform_populate() instead of mfd_add_devices() (I can't
> > > remember if we've suggested that before or not).
> > 
> > I never got of_platform_populate() to work for a pretty fundamental
> > reason, so I don't have enough information to know what you're on about
> > with making the mdio_cbtx/mdio_cbt1 resources available to it.
> > 
> > > Right, I think we've discussed this enough.  I've made a decision.
> > > 
> > > If the of_platform_populate() solution doesn't work for you for some
> > > reason (although I think it should),
> > 
> > Quote from the discussion on patch 8:
> > 
> > I did already explore of_platform_populate() on this thread which asked
> > for advice (to which you were also copied):
> > https://lore.kernel.org/lkml/20221222134844.lbzyx5hz7z5n763n@skbuf/
> > 
> >     It looks like of_platform_populate() would be an alternative option for
> >     this task, but that doesn't live up to the task either. It will assume
> >     that the addresses of the SoC children are in the CPU's address space
> >     (IORESOURCE_MEM), and attempt to translate them. It simply doesn't have
> >     the concept of IORESOURCE_REG. The MFD drivers which call
> >     of_platform_populate() (simple-mfd-i2c.c) simply don't have unit
> >     addresses for their children, and this is why address translation isn't
> >     a problem for them.
> > 
> >     In fact, this seems to be a rather large limitation of include/linux/of_address.h.
> >     Even something as simple as of_address_count() will end up trying to
> >     translate the address into the CPU memory space, so not even open-coding
> >     the resource creation in the SoC driver is as simple as it appears.
> > 
> >     Is there a better way than completely open-coding the parsing of the OF
> >     addresses when turning them into IORESOURCE_REG resources (or open-coding
> >     mfd_cells for each child)? Would there be a desire in creating a generic
> >     set of helpers which create platform devices with IORESOURCE_REG resources,
> >     based solely on OF addresses of children? What would be the correct
> >     scope for these helpers?
> 
> Does this all boil down that pesky empty 'mdio' "container"?

Why do you keep calling it empty?

> Or even if it doesn't: if what you have is a truly valid DT, then why
> not adapt drivers/of/platform.c to cater for your use-case?  Then you
> could take your pick from whatever works better for you out of
> of_platform_populate(), 'simple-bus' or even 'simple-mfd'.

I asked 3 years ago whether there's any interest in expanding
of_platform_populate() for IORESOURCE_REG and there wasn't any response.
It's a big task with overreaching side effects and you don't just pick
up on this on a Friday afternoon.

> > > given the points you've put forward, I would be content for you to
> > > house the child device registration (via mfd_add_devices) in
> > > drivers/mfd if you so wish.
> > 
> > Thanks! But I don't know how this helps me :)
> > 
> > Since your offer involves changing dt-bindings in order to separate the
> > MFD parent from the DSA switch (currently the DSA driver probes on the
> > spi_device, clashing with the MFD parent which wants the same thing), I
> > will have to pass.
> 
> I haven't taken a look at the DT bindings in close enough detail to
> provide a specific solution, but _perhaps_ it would be possible to match
> the MFD driver to the existing compatible, then use the MFD driver to
> register the current DSA driver.

The MFD driver and the DSA driver would compete for the same OF node.
And again, you'd still return to the problem of where to attach the DSA
switch's sub-devices in the device tree (currently to the "mdios" and
"regs" child nodes, which MFD doesn't support probing on, unless we
apply the mfd_cell.parent_of_node patch).

> However, after this most recent exchange, I am even less confident that
> using the MFD API to register only 2 MDIO controllers is the right thing
> to do.
> 
> > Not because I insist on being difficult, but because I know that when I
> > change dt-bindings, the old ones don't just disappear and will continue
> > to have to be supported, likely through a separate code path that would
> > also increase code complexity.
> 
> Right, they have to be backwardly compatible, I get that.
> 
> > > Although I still don't think modifying the core to ignore bespoke empty
> > > "container" nodes is acceptable.  It looks like this was merged without
> > > a proper DT review.  I'm surprised that this was accepted.
> > 
> > There was a debate when this was accepted, but we didn't come up with
> > anything better to fulfill the following constraints:
> > - As per mdio.yaml, the $nodename has to follow the pattern:
> >   '^mdio(-(bus|external))?(@.+|-([0-9]+))?$'
> > - There are two MDIO buses. So we have to choose the variant with a
> >   unit-address (both MDIO buses are for internal PHYs, so we can't call
> >   one "mdio" and the other "mdio-external").
> > - Nodes with a unit address can't be hierarchical neighbours with nodes
> >   with no unit address (concretely: "ethernet-ports" from
> >   Documentation/devicetree/bindings/net/ethernet-switch.yaml, the main
> >   schema that the DSA switch conforms to). This is because their parent
> >   either has #address-cells = <0>, or #address-cells = <1>. It can't
> >   simultaneously have two values.
> > 
> > Simply put, there is no good place to attach child nodes with unit
> > addresses to a DT node following the DSA (or the more general
> > ethernet-switch) schema. The "mdios" container node serves exactly that
> > adaptation purpose.
> > 
> > I am genuinely curious how you would have handled this better, so that I
> > also know better next time when I'm in a similar situation.
> > 
> > Especially since "mdios" is not the only container node with this issue.
> > The "regs" node proposed in patch 14 serves exactly the same purpose
> > (#address-cells adaptation), and needs the exact same ".parent_of_node = regs_node"
> > workaround in the mfd_cell.
> 
> Please correct me if I'm wrong, but from what I have gathered, all
> you're trying to do here is probe a couple of child devices
> (controllers, whatever) and you've chosen to use MFD for this purpose
> because the other, more generic machinery that would normally _just
> work_ for simple scenarios like this, do not because you are attempting
> to support a non-standard DT.  Or at least one that isn't supported.

Sorry, what makes the DT non-standard?

> With that in mind, some suggestions going forward in order of preference:
> 
> - Adapt the current auto-registering infrastructure to support your DT layout
>   - of_platform_populate(), simple-bus, simple-mfd, etc
> - Use fundamental / generic / flexible APIs that do not have specific rules
>   - platform_*()
> - Move the mfd_device_add() usage into drivers/mfd
>   - Although after this exchange, this is now my least preferred option

I could explore other options, but I want to be prepared to answer other
maintainers' question "why didn't you use MFD?". There is no clear
answer to that, you are not providing answers that have taken all
evidence into account, so that is why I'm being extremely pushy, sorry.

> Hope that helps.  Good luck with however you decide to proceed.
> 
> -- 
> Lee Jones [李琼斯]

