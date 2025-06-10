Return-Path: <netdev+bounces-195959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D314AD2E72
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB0A3A2B76
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8B25DCE3;
	Tue, 10 Jun 2025 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RXTO4noF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CFD1F874F
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749539793; cv=fail; b=TR8fv34rSUizFmTJK8pHX6vgNZB2RFrzK2SYBQ43w3vi3fBNo5JVu/Azg1gLQb7QClzCQvh7zGpFXgAtN+3ffbL6rSM6CrxXCX8HS18ik2oMp+BwiyKjLkjcBya2CzgG97ean2s8W0QyQ7pLSsofUWLzliSrmToTsMjiSHUPhsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749539793; c=relaxed/simple;
	bh=NtwM1MYPmKoY3hrx8BXRI9+sD2CU9XY3Pq3mRbZI9tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KujpINEPUKu1Ry71S2hn6ZUlpS0YF4/XPtNCD/fcIHY1UQIbf0YcFnA957P3AvXPt69XP38e0kh/MZzylFLM4cKgshAu/kE8oZHloI5HSfXkU2K6RuUI0I1Dhjf+LAPyp51aGzvxRabFZWCMJI3spg/SmQwcPPgvsrbti+DtLuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RXTO4noF; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf+ex8fOZI6PmRhzSIEHS4yyNRHYNEWc0J5tN1njMmXIbZPt61QgCRNHX6YEDJ+pgdhVAiHD8VjRdTRlSF9fnAy8ld659Os1vGupSauE1CuyqhrUmXQlhbmdRXA6bZRSryQMnG4Uqu/ZENxdywx4TjbwVGb1CPLxrOQ0UsT76W2fMTqShY2h37OtksIakUJoAx93NKf6GJQhLu8Sj6m4LMBRJQVgW/fHjaQHMU6zDx4tTXj4VL7WfoAjoLrJ2tTZZKlegyTMC+DUT+VsPb3H/l7/Jo14f4gpDynE6XhoMVPpK09cNnLlsBv5M5rcwt+y1LuQfRV6QW+DZRA5Y2ykJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bprC5n2BKn1ovaZ/EFYfVqm69aO5yDqC5Zg5qCvijbo=;
 b=wjkHqSKqMRjUU2ZI4+VUlh5On1vxTI/KpFrcO5LWZMk/2xbI9sFSyYzSnNrK/BavmxRshasYZ+9Z1Prz8Be4zGg4ZBr0AvPR5Hrf7c1C3StZIX3oNrRM9Zo/cef1t7mmZTmq4zs1gpxkShH82kZuaFMpB7Wnm7WJEiWCY2YyvmyIY+niPAK8w5M2LCNAguO2xB71uo9pQZTfU6n4q5vgiegArGsEvycBOARqmShpoGptfSMq001VSs54gbjXI1GpRBfvD5gHBxDqf8d37je4YwgeOBl8gTCU8U9QN6r5pOH/mc9sbQR1NJyyD4eN399Ys2iI95bLnEo4yvBP2lvapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bprC5n2BKn1ovaZ/EFYfVqm69aO5yDqC5Zg5qCvijbo=;
 b=RXTO4noFp0EItqt5cPXxr31wUvi/VQ80fRK58/uF85uGjqTU8xicceIX4HJWquD/zg4Bb8ET3/iDkE7pReEYy8T1axEmXREmGWba4hw2EMTBST/cRapGZL9hc9U4rOfgWbUjCM+lMEM69C4J4aiU4YdaEQQ8xH69IfnnDjoEmBCga7YlE05HzSoh3LL9nAInkYIvCl43ORbnkSSdQDOnTqN3va8MA/ycTsbrVvQBxv5i2797xEhFiErHfcboz3UG/B7jKVVRiF6lu10Y5jagq1HcdXz2qWrmZPwO08hGCpBLN4fDLVQG98nCOYtK/nwRlKruSheta0l1TH0lY7Ckcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Tue, 10 Jun
 2025 07:16:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 07:16:29 +0000
Date: Tue, 10 Jun 2025 10:16:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux-foundation.org
Subject: Re: [PATCH iproute2-next v2 3/4] lib: bridge: Add a module for
 bridge-related helpers
Message-ID: <aEfbwaWDzdetjKDO@shredder>
References: <cover.1749484902.git.petrm@nvidia.com>
 <b50c8fdb2fed1c8d47f06ee139f26fcb263472bb.1749484902.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b50c8fdb2fed1c8d47f06ee139f26fcb263472bb.1749484902.git.petrm@nvidia.com>
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: f302ef97-0e15-4d72-5fa9-08dda7eeb810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ex7o+J3/bpnQE5bvemf9aOWlX67uVa0rpSzdhe/wsSlK5U7RU0gcgHobQLXV?=
 =?us-ascii?Q?8+pW+fuRmwqBpNrbtHEC7L6mdURpB37JbRld78J27OKUQo1GP06HcWb+F9S6?=
 =?us-ascii?Q?LQJMmnIO3Smagr5QtBr2VlR+LTpEz42lm/cVKaC0rbIBEOnSIUHkVwHAQdIt?=
 =?us-ascii?Q?Za99Dsroeii0dnTBJlqkXYGNpm/xxuWf3S17YNWjaefoLadeoWW/l/lwWX2u?=
 =?us-ascii?Q?q5T66pm4aWid14r2hLfd9B9xE49Zti35G3elsLANH2XkOEOZ5P+fji9CM//w?=
 =?us-ascii?Q?YQhzguWqLZXz/kiYTxTjcem6ycB3t0BSA1BCh1vsOl/OT28979jAUs0SoMLC?=
 =?us-ascii?Q?Zy9HXa7RtvitFILfZPaIzrcxkz4QgRoSb4dUD/BocTpSZ7VlT4RXGiNWSwY3?=
 =?us-ascii?Q?e3u7f7r4U+XB7O/nbeui05EENWxgPjQt9TZ/qkBecmbW/a+o5rmz3x3gBn6u?=
 =?us-ascii?Q?cXewIYd5LoZZA29fVvqZpx0FhslwbGCQDphWMMJ2ffYF/WytNiBMm52WMSTO?=
 =?us-ascii?Q?j8xyItC1nCt1h7CSnJ6ygGP5od2ByukdJLyCIUk1ekzSvxb9FQ8vR8glGDg6?=
 =?us-ascii?Q?BhahPPVojnT23ke2TpS7kFeMNtwONGodu+8gFS49yNKXYWlvVH7VvVjfDGE/?=
 =?us-ascii?Q?1gh2niH6pzEQEDHhPftC8bB1iqT5Tnlr7J/L0elT24CRnMBh7S30U80/i1VQ?=
 =?us-ascii?Q?YrTPNXRedvzWCHOu9VnbZGJUwNdNESTF31tsCDMyrKD1cPFLzdK+Zqy4IExI?=
 =?us-ascii?Q?/LA/Qps4tu36Iwv/pnSGG5wareS4mVuonYmTKnhtOanbDHpm463YhsbC5+0C?=
 =?us-ascii?Q?QWFFkhWqq5f/vRIyGLcEhZz+UXDY8NFd5WkitBRbY3MTBuWGB7WzD2am6R6u?=
 =?us-ascii?Q?0VcbhqjOV8H1u4fsKtUzMKuY72IsXDRiDkGGVLc84fzFMqJYAs1MVwDnVqaa?=
 =?us-ascii?Q?2x4cNJPtgMgXu4b9cnZaRqDhS37J7gvCkFFIH6lpAKUi2CQi2x79drSxTNpe?=
 =?us-ascii?Q?DhSpInCU3AOd0b+Ng0ou/KA1m1WnMu2C5gOfXXiuaXN/7mjDfE9rSSnIag3g?=
 =?us-ascii?Q?7h6wnzGlCrOIY7C1Ca7/F0ifCG0/U6B+c3JZO/5loFNErF4IkuC7IxQUnTnZ?=
 =?us-ascii?Q?JHU46XFD16qervOCszDrkS056O/kz6BXpmZGm6A+xAMb0eR/hzZYjvVgnVTd?=
 =?us-ascii?Q?WmYkGSe0rxQtFq+eGyyfnaGYRuiFRtKWhtO8SWAzD1pspcztsI6TfQ9Va+RE?=
 =?us-ascii?Q?nAhi5EHr7VrZNLgS9JCvnJDxJf5AggVjzkWeoRgX3S6AxQaPX+smH15yfO2m?=
 =?us-ascii?Q?BBB6tp3i24s64lh3nLOfnDdz0xo8HHP0CSMZesqIgdvMcS99KJGQolODiQdN?=
 =?us-ascii?Q?rlYZN4IZvpzBUt5wt/vnaJpUzDjBTcgjXAdlKRWWOIIlTvhPiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kr0XgVa8I3kSY7TgTdezdMQRq98DZ3RU5fY7dXsI63HRKgR1nMPZFQC/qdUe?=
 =?us-ascii?Q?QK8Ua69AC22ooQHCeH6lI9s1CTiaM6+DvFXQkrk8002IydkYy6b+kojOOS2D?=
 =?us-ascii?Q?glOm7089Zl/5LHo9BiJfOuBDIRbw9hAlGvQoYCJsAEffF1rSHSk7Bf1/9goo?=
 =?us-ascii?Q?/RU8yQYXOSPjuybYTCpAYTXWGTCqoaq3A6xxy6u87PBgVpTTMWnIbrlobCZ+?=
 =?us-ascii?Q?ys0mzwoJgrMLSs5QLWSnFrcE+g4r7rj3HOGGEbC3a5l8k0D72IvFBoBsLXBW?=
 =?us-ascii?Q?/UBXgPYi1nOtuvNhIc1hOT2GpRcwFbE97JowfQm4jDxVhU5sxwvqhUBE34Te?=
 =?us-ascii?Q?HUiTlFNMLT0fn7pkwlmxTUYZ3KsSiKI1X2Ab+/kRWf4d3ijU/o58j5wj1tqQ?=
 =?us-ascii?Q?dAmBXtpFjVEPt55eHDn6UQM2b2jdd/aQ/5TztisI1PVgNyNjj5QIl7JNBNve?=
 =?us-ascii?Q?5/9xDP17Nr1vAL/uGx0R43oGlB5JP2Fi77701dpvGksiBPr/29WG0ZXbUXIC?=
 =?us-ascii?Q?9EJF9doPrGIDjbuazehW9nl53jYadVY2UIH+8zhOFShNQ1Mhb7kbWg8/SPPY?=
 =?us-ascii?Q?DO1G7swL+77RIb9BKZROIRzgNO7BQg0cYRwdVVdQQ9uKSRImlfaf0AkNDBXA?=
 =?us-ascii?Q?PA3M7Biu3NEqowGMQUnno4tJcHDswU7kdZPZL1/YoOuR+X7ao6MyedqmCpr+?=
 =?us-ascii?Q?uLf9cEGHPlfwiDt7TNFbSPPb6gsGN2cFX5sjR+f1hhJ7D0Q/r2vrxI4GGWCA?=
 =?us-ascii?Q?tlTWndtU67y5DlD7CgucVIoTuBcVFBOycd1YkiNqpj7Zk+iyrlmjNj0rmW09?=
 =?us-ascii?Q?ea838nhQJO6aiYOW5PsNZPKJ5jSlywG1ArBqqDJot8M1TfTSxyIwIW7RP+yC?=
 =?us-ascii?Q?v6apEepBCBKiBcGBhOEZwBjVX+mkynmjP90oOopgW8mrLFiKX07FMHe6eKy3?=
 =?us-ascii?Q?IFI2fpC0KJVRAAq4qxheRYhM6prAL8IMIaRnnCH+uf71HHXlwGMq57FyX5v2?=
 =?us-ascii?Q?wKbBLftabtC1YqfoyCAZRhoUEyM/YZVXQ0oAorDeyseoaJRheJUi8gtJ3Tv7?=
 =?us-ascii?Q?FD2yNg2PpF06F8I/53PNZdwX94BnjTRhocTbAb05IfXpKN0TJcA8Es523lHK?=
 =?us-ascii?Q?c868pSUscyeSo/HzR4xKEVDni2I61rth9bf7gacEarnJR+9E39k/QO3nMAhy?=
 =?us-ascii?Q?Tr8lLTl4oe7K8lo+FyLq6hri2mmRL2XspCNZlQ96XPRvE/waRhA0tsNzjVzk?=
 =?us-ascii?Q?XS56N88H3EeaoKqKEQaUWlATENKENrmgOUKXTbQzPQm6tko+4JcJdzJl3R5H?=
 =?us-ascii?Q?1i/zboTO7BxTcwuuJ2/7Sr3BK6gUHtZ0Yq47c//rn3VpP1AnuxzHvm+nl2RL?=
 =?us-ascii?Q?BICQzZvNr/JdxQ0uNKWqVcmS2ksLBWQEkAri3QlWl8TTW/9T2nDqzoVvxYHV?=
 =?us-ascii?Q?J9HPPEbf0DLrvgOfvS3BJLnx5GVAOrSEUExGKPwTFsIRjUgCEj1t4uv+zR84?=
 =?us-ascii?Q?IIdrKxkcbvUtTlEtt9CTn7C0dSjXR1GW8mEJBoDNYr5kdSDwdFYaRcZayLxk?=
 =?us-ascii?Q?vpzcSWJAj+DuU/+bDFDj5Ym3kw9XG1Uwm1+iy59A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f302ef97-0e15-4d72-5fa9-08dda7eeb810
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:16:28.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gxzf4EWS2t+ZfGg7rU8N164Ha/3Xs9rTuBLooFDttDP1Xo8qC6b0o+6wZjDa9NAQP7FMQUhk7C5e/KiZIdNLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152

On Mon, Jun 09, 2025 at 06:05:11PM +0200, Petr Machata wrote:
> `ip stats' displays a range of bridge_slave-related statistics, but not
> the VLAN stats. `bridge vlan' actually has code to show these. Extract the
> code to libutil so that it can be reused between the bridge and ip stats
> tools.
> 
> Rename them reasonably so as not to litter the global namespace.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

