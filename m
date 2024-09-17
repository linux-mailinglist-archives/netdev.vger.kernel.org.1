Return-Path: <netdev+bounces-128729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49D597B31B
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 18:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA09285316
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A717A5B5;
	Tue, 17 Sep 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TvUg1HVp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E2E175D5D
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726591358; cv=fail; b=CjFxlBsyiTTYK0aGzUYuj3QXHqa1uadDpretwrKQWme+tUjVcecpJZ0Vb3FwywlvJ7YzLuMbjELNnMeqgJwznJlNCPwVnUMq5FIyrxT/w/XG7njuGbdMw6hMEk6ryT+DOYPGXtCgudmAKxLretBL35492kF/hXvUlpLIWEbrS88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726591358; c=relaxed/simple;
	bh=qEZhv7Mn1OyZb+6pt7dL6OgZS2o6e2nXNuMkcWFfDkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IHn+hUzPuk9ez7xSPW7Whcz7jCzTHjpLJQs0DJdUU0vwfIxGeoJ5sPU1CJHRbBysBwFS/k3eUbLxUUlsxqtWF92+DV/AYDO5Z79bv3HYoudosSpKtlaXfeXeqpsCJS/Q/IDhceWH0xnHFBgRUVeEoQdk6Hz13Qe9vgHbZZfkxYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TvUg1HVp; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNWkGa6EB3wyKntziDr6at9jQ1GO5KAOQkqSNTOCKnuePGOBX2NHjzGlNtdLmP2bdO1xf6zg97oyAFSej9vHuWt5YxV9ADFPSeQDdBNHep/TVayoIUtdZ96tOWDaA2dgbnSf5UwRrRuaWBV1dRIQjwrO/KaUuLrI0XLwguerFfL6qlQwKECOSnVByZDMaA1xlqNwcMuC/YjW2D0kIuPzl6QkJF4TAQ5tltLEC+Us0afxZr6GgbTcEkIDmnGci840DU5fsjkI6S8TlqKDyK8UbsFNpK7LHzC0wTYWVgacUm4YzmeC8z1nJ7eLnDPk/MiwcJztIncIFic0mrgIWVab0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKw+6S7SzqON/bK+GxEyJcna+fdmcTcNSLZYUOnesQI=;
 b=TM4I5o68GlFc44FDRQhm3kdOwGUlQTSzIkQ8phQPZ1MGEO5Qi0YmUG6g2K2EJO2o9rGY5S9cC6YlxApDRs+UjDs3fUu1FlR97hxt2xNpPGlwaDmo0eVeuOJh11zTau24NCSCPzqVh+S3wtRhAIdpp6EYQTA8CUqUicFIejq/9lXr7xnMuwI26C5rpFM9JScOiwtLIwuu+M/XmGAXJq52Whi6X3lPFkOLNGr5eSYz2ROswKpNlb1ZY/9HqNm8ajn7pnbIDAjTHmMuICC1g609qKUu40XzKVLbr2K/9htMKz7rOWOBPpL7O8cS2x2GmF7alvSKC/ZQrOePy9DQjBmmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKw+6S7SzqON/bK+GxEyJcna+fdmcTcNSLZYUOnesQI=;
 b=TvUg1HVpr6f48zhmxb9XzfmQDr1Eu+KV9cY0l5/FwFzqLyaRV+VL2B55FYUsy1Oa4+P6495ZWb1CKuHR8UmC74IWTGWvrDmilddwjB77nWVpCzYch5tTxHtazp6HwAGoRgmJ9Wf0vwaYIBXs5dRfO4hWkjdFYArbyZTyxOLV4h5iLKTx3VvRPc+qEU8vjSM4O3As6q3Anm0/7P7zjzdkPAxcq3f5SZ8oOHar47+rDEUAD0AbGoSe/OvbZZe5GizulCjkPhmoRg/O0N2wSA0CAa9qwKFL7c30VXT69UtDhGlgpyGkvm1htNl6SwfOSokL7jJ8VbpOTZIfd7D5RIVWVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GVXPR04MB10633.eurprd04.prod.outlook.com (2603:10a6:150:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 16:42:33 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%3]) with mapi id 15.20.7939.022; Tue, 17 Sep 2024
 16:42:33 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Wong Vee Khee <vee.khee.wong@intel.com>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Chuah Kim Tatt <kim.tatt.chuah@intel.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-imx@nxp.com,
	Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH net] net: stmmac: dwmac4: extend timeout for VLAN Tag register busy bit check
Date: Tue, 17 Sep 2024 11:42:06 -0500
Message-Id: <20240917164206.414714-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0031.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::44) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|GVXPR04MB10633:EE_
X-MS-Office365-Filtering-Correlation-Id: db4d92bd-cc18-4fcc-131a-08dcd737ba4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nmh2R1dhSkRRNFcxS3dNZVhFV1E3a2FVbnV0a21melZkYTZSUEhwYzl0Z1BW?=
 =?utf-8?B?TlpVdzFlbzBiNmwwNFIzWEs5WVJaSFFQdUI2bGZiQ3lGNHpRTEtyY0FoVjg2?=
 =?utf-8?B?akY5UnZUMUpBVkUzTC94Q1RsVkFraUxGLzF3bnU1dmhCMG5Lb3d0WGdTYWlK?=
 =?utf-8?B?RXh6cjNnTE9VWC93ak1ucEhoSzJRTUxtYVJzVVdFNGRPRGduNVltTkpVaXZJ?=
 =?utf-8?B?QzI2Ti9BbVVLVWIyRWJHY2FyRjlaTE1hS2UraG83cXM2dDZXNzdlbjNXM09V?=
 =?utf-8?B?SGZTWkdVZGJFY1YrUnNPcy9namVTZ2ZtTFNMOXBBQ2pqMVNuQUxRcHB5VitY?=
 =?utf-8?B?KytUbVBoSVhzdDFxVHhEaDB6aXp2ZFZKR0pxa1k5cWNkSFVGUXlUT3dVbmlM?=
 =?utf-8?B?YW91TmRtNW81QlNsazExbUpXdFJUK09LanU4eTRXdzRqK2pLRE5sZlNEeWdC?=
 =?utf-8?B?eWJNdFRVODB0aXNwL0l2eSsvSFl1MnZESnN0YkN1MktUMFRNdjd5ZGxRN0Ja?=
 =?utf-8?B?citVb0drUTNmaHlsVjJnZ0d6bGU3MGhHRHlqZ1NDWEZ2bFlNMTl1MTYzTHBS?=
 =?utf-8?B?VjNxbS9aMkVoTXdvZFNpQUVqdDZlV2MxUnBjNEhvTDRmdm5wSDBsUTdXbThF?=
 =?utf-8?B?OTN6UXlJU0wyckJiL3VRSVMrckZzdEdxejIvanBHVVZFM0ZWWksyMXdOeTh0?=
 =?utf-8?B?bHg3VGFyM1NHK0UwZ2dIQ05hL1YweUJtSnduWjI5MkViclJwODYxOGZOSG1K?=
 =?utf-8?B?SDdtQVBTU25kcEFSWm5HbGszdHdyK1pNTlluR2FpWDFFbHF5U0M3Ukg3YzQx?=
 =?utf-8?B?dzdFRFFGMzhVVVdkQklIOVdzWi94WDB0UHdiY0xNeUNVaEl0c3hHbTZ6dEcw?=
 =?utf-8?B?Q3I3SU9FMnhDNmhObEpsQmRhS2JhVjY3Yk5ra1hXM0RFaExNRXh0T0RKSitP?=
 =?utf-8?B?TWdpQ3NSbm9tT3FqQzl0aDBud1htdmVyRERVY2V2YmZBcmw5OFlFRVJBYTlF?=
 =?utf-8?B?eW9QdnFIdElhckpWbkpwZElqZjBCdFFOMHdjUjNISlhBMnVDT3E4UHZKVlcx?=
 =?utf-8?B?RlVqN0E1RXQyY0tGZ01RM1hpVnFKc3NHN2ZHK2N0WXdQNVYzcDlVdXVrSFFD?=
 =?utf-8?B?UklLYjRSY2xCMHU5NVFXQjJrcGpnTWJDQnRaZjJzZlZieFAvRHgrbVIydjI4?=
 =?utf-8?B?VFpYN3JZaUQ1aDA4S3MvbU8yQlQ0aUc4aGhQZnZycGV1TFZJQ0JDMmN3d3FB?=
 =?utf-8?B?bG01b3JnUkJmRTYwb3BhTGQyYXM2aEJHekJBMzdrVXBTVXp5VjlpU05FbUpC?=
 =?utf-8?B?RThNM3BmbFlNV0ZEbXE3RDdIbm5iNkhKeitOVWdlaE5xUXJXblBRdHRMSXND?=
 =?utf-8?B?dDM3YW1HbGVsQm5lQkVZSXlLSjhCYkhjdHNyUGhpdThubm9JcWtoN2xWOVhI?=
 =?utf-8?B?SmtETEZCc2VXeG5ubTNpcVBZcEUxNWFrSHJrL1NBMEJ3K08wNm9SYTVRclZ4?=
 =?utf-8?B?QU5VSVNlTEE4T2hUMVVxNzZLUm1wVm9IbkJvdENJWDJ5NDZWRTVvd2dPcWxO?=
 =?utf-8?B?TjFpVE0yVFRabHJVYXExdkdlTWFZRGg2MVVsS2NvM2RZd2sreUpRWmlaZ3JX?=
 =?utf-8?B?bndLeDQrdkhhZDczR1ZBc0FqV3JOV0JtWVg1cFc4R0U3NHNmU2E5UG9NeFNL?=
 =?utf-8?B?aGdocGtoaW5MQlA0cC9JcHlZVkdDRzh5WlBjUUl3OFp1aVhHc2NMVHo1c0Rw?=
 =?utf-8?B?UGVOSjljWkN5VmdnTmwwaW8wYlowbWFFZUllczQ4UUZ6RGtBMzZ3K0s0UTB5?=
 =?utf-8?B?R3NESjdNZUt3emlSWHhlb3E0NFFOeWRvUGwxVjF1dy9XRE5wc1pTQUpTYWRi?=
 =?utf-8?B?Q0FNQTJESCtrTTExLytwZmxsMFgrMVNxWWkrVmtLMzFsVEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0o2eVJnakN3b1U3ODdoY3prdi8vVnNiYndnM083QVJUMzJ5WDdLNVlINXA0?=
 =?utf-8?B?T3pTa1FhZjgxU3BWd3k3bHdqbmpOVjlFUTJ1QUgvQ04zYk5jS0xXcnlJaFNk?=
 =?utf-8?B?ZThIUXN5anZ2eFNDVVd2Sm1TaEI2WmtYZUNhd0I0bnBYSk55cGQ3UHJ0cG9k?=
 =?utf-8?B?T3ZlL0wvdElWZzg3Q3ZVRHpybmVzSm9XQm9QR0N1alBBN0l2T3BtazQ0L1VX?=
 =?utf-8?B?RWhLRzUvUk0zRW4yVmxpaEdMWmM4amxzaXJqSndOS0h5TnBJc1pOVTc0c0x6?=
 =?utf-8?B?Z0tNdFBENlkxR3VhcENZSEhXalk5dUo2Zmg1ZWpEc0Q4WFZLUEFKN0x6VVZD?=
 =?utf-8?B?V2dpS2J2aC9nUnlFVGpXOUVnNkkwRmJ0UXdwZ2piTysxNEtZZVNDM2FQY3NQ?=
 =?utf-8?B?NzdhdENHWFlKSStRU0ZYeHVSM3cwdjdSMm4ySW5tT25JTllRU0Y2MTc4eHU4?=
 =?utf-8?B?S0tzNVZZelZLYXJEZFFXTXpyQ3kzVFZGazdqV2RpRWJlUWdNUTBlWE5GVWx3?=
 =?utf-8?B?MHpWQm1PQWVuY0N5VXdVaVlkNEhlWTFvelhmdDFLVk9KU0lLZmFQdjJxOWxV?=
 =?utf-8?B?SFdSd2ZieklHaTdTNnN3VTVpLzloZ2V0Z2xHU0hUdWZvRDBFWDNyK01KMlBB?=
 =?utf-8?B?QUVVZk9BaG43ajJSWTlzaGo2SVI3TWc2MHZza09IdkJUcGdTUTdHQkVqcXR1?=
 =?utf-8?B?WkJUN3ZjUzRBdFlQanZSK0xUdElaMDhlRUU3SVVteHNaQzdPaFE3RFZZdjB2?=
 =?utf-8?B?NTRQNno5SEpxWTRPcmlTRW5QYjd6cXQ4UUJwdGxJZHUwSUUyZFl2TE5Ed21k?=
 =?utf-8?B?MFBoVUlYbllqaEpBc1hhSGI3cXV5QU1CbUc2S0NqVEFaOW1XMEpTQ1VFSk02?=
 =?utf-8?B?L2JQbENJdThpTUw3ZENhZXZSN0t1eGRHSSsvOCsrbjd4aWRyR004a0d3cEJ4?=
 =?utf-8?B?WUxwalBjR3dBcXF4YWRjMVIySllCdmhLdkZZMFNSSFJ5Mmg3aytFVldMeUtR?=
 =?utf-8?B?MjBFS1IrbnVZNXJZalVDaWZUdWRNcTZudVV6VzNlY2dOY21PVEppRlRRNmdB?=
 =?utf-8?B?dEx0ZXVteFVwejRDTDlmMG11TmNvSDJQdzRxK1hZSUJmOXFBenMxQm9DNjE0?=
 =?utf-8?B?bGpYZTR6dGx0VHl4a0pRZzcvbit0NnhjanU3a1dxL1RNYlBhWHpxa2xoOGZC?=
 =?utf-8?B?ajdjaXdQWEwwQ1hTSWIwUVFWUldlZ3pjQkV3RUswTVJabk85cml6TXJOK2tY?=
 =?utf-8?B?RXZadzgwNVBJeXc1ME55NkRWT1RUcHdYYTB1TEJUWTNVLzNZMUE3U3BCNlJq?=
 =?utf-8?B?WW9GN2JTUVgyK042eVpIcnJkVndkTlRBaTAvUVNEUVZpQU56WkFES3FkaE53?=
 =?utf-8?B?ejBBbmlOV1JzdWNGZXFaQnRlbU9JU3NUeEpyZ2F1enZMRk9jZ3dxOTdCMncx?=
 =?utf-8?B?cGpCUkdGREgrSVIzekIzSHRYQW1LeTUyZ01KNmtDeFRxUGUyOWZUZWZLNHBM?=
 =?utf-8?B?ZEpuMmhzMUtSaW5pQk11cTR0ajJoVTJiZFVxMkFLQ3pXNkJScS9hTzhjQzla?=
 =?utf-8?B?S0xOYXdpakU3L2RINjI5VU1zWHg3b0kwQ3RVQ0UvYVFmaUpUVVRUUStlL1R5?=
 =?utf-8?B?WHNNMDYwMHdHQ3lWWFA2cXBRRnQ1cWVZTkhDTlJpb2lpUlNFNSttQytVQ3hN?=
 =?utf-8?B?MHlvSVMyVC9oYW0rN3NKUU1ySnF3VjRSRHNrc0hhSEdFekdheTlhWmN3alpR?=
 =?utf-8?B?QW0zR2ZPMlFqUmRKMzZ5Z0t1T1NRUE01RGxxcnc0MVA0cFNvakg2aHlNblJu?=
 =?utf-8?B?V0FHQ0E4VE00aURMei92OG1TVVhsTWxJcFJsT3hHZWxxbTBVUGprRm8zaFc5?=
 =?utf-8?B?N3VFNEY1Vk56c2NoN3FvNWprZ0tOVkhyQTZLeWdoSjZFTnR1dHRMeWpvUzRS?=
 =?utf-8?B?a0cxMklpMzJpN3RnZUU3V2tHb3ZHUWxYVDJqaDZiZ0NzKzdrNHNJK3pxVXdy?=
 =?utf-8?B?SytKSlNpVnNOYSttRUhldXpOWXpOdFFmUzI0Y29ZOUZMdXo2Mlg1OWJnam9M?=
 =?utf-8?B?aHBETmpDc2VGekVtNWRkUndPSzJ0cEtkNTE2YXB2Q24vK29MMDhRSFM1Y2gr?=
 =?utf-8?Q?dHNhxcu1GI2JrXUaPstaqQrbI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4d92bd-cc18-4fcc-131a-08dcd737ba4b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 16:42:33.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTlOjNmO9ayg9cmbmJe3UPw1Vv60nD+1zrsyavdG3oFjm2Ev0dxyiAB6ktYpl99F888scrCHYy0WKzqvN3NHbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10633

Increase the timeout for checking the busy bit of the VLAN Tag register
from 10µs to 500ms. This change is necessary to accommodate scenarios
where Energy Efficient Ethernet (EEE) is enabled.

Overnight testing revealed that when EEE is active, the busy bit can
remain set for up to approximately 300ms. The new 500ms timeout provides
a safety margin.

This modification does not impact normal success path, as the function
typically returns within 1µs in non-EEE scenarios. The extended timeout
only affects the failure path.

Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index a1858f083eef..cd5e5434ac52 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -471,7 +471,7 @@ static int dwmac4_write_vlan_filter(struct net_device *dev,
 				    u8 index, u32 data)
 {
 	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
-	int i, timeout = 10;
+	int i, timeout = 500000;
 	u32 val;
 
 	if (index >= hw->num_vlan)
-- 
2.34.1


