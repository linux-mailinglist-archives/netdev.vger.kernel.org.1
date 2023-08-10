Return-Path: <netdev+bounces-26491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF002777F1A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8D01C21629
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775EC214E0;
	Thu, 10 Aug 2023 17:29:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E4F1E1C0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:29:05 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E82702
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzFjEQHEqAtJosGZpIaQwsp0xLeDVARNeOHjoHAo71aDD54iDIE5RbgGGcoSl++j4IsMBRxCQckKg6HIETGXykw8kMexs6Z+JoNz0UUQRJ4yPE5028ZsE8LSw8KlSehdVYC+THxS01TfpRRngo42C8PYZrdPUV7BWP83DkdkXBqbbo5YOI274906rK+b9dGI0s5QvTlmWIFy7XON6NzGNBWHT740IMjbcrDQBtxZ5+9KO0vkM/p/xPkYxvh0hWK6ssDsIePCZk0L0KplZvOc3pWZXnMNZg89Fnma3P5ui52ysv2QzPigRSqOt9bjD13uXLhxafv48lVKx7HOzAXhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNyuPTIDPMXEdLonaGAzg8k2ujShecy6Uud4UxeSZqM=;
 b=mgDaLNvtjEfpIAs21skSPy0k+1lx8s3eArgs298NYYjeC/GNXMMuopfGYjZyzoMOsHKlxl/NL7EhnuQ/VmNq75VyolUgLWU5XCZ7INz0qWJMG9nFuZNfqJUBH9JK/VwXY2P2PXsu9zTms3gA/tqXDXwICFHvH94xDUA4Qs+MCwds5A8rDo0WtQAbGLeNFrw+66uNN/zr4mHuc9OihY+M/OMQElqFuCeoKtKyagEKHX5OxvqSgAd2jT90yUy43PNwHgzW/xpdLPWGWJgOMqP/vDFkKr1XVhTI4Jc/u1u6oN3lTkxOpQFMSvATewIjtcqi6xT77RMvFKqnrHp+m3dsUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNyuPTIDPMXEdLonaGAzg8k2ujShecy6Uud4UxeSZqM=;
 b=ObQkzDGdElBUG3V9ylpMTnZRE9veVC1gbBo6BgQf03sDZVoKreuvNmoYPs5Tfsw4uet881beN0jsgJVfiwhoNTulThp55UDso5M6iHCQ5+pS39v0Fasjiks9bQ5TePvEPZRGnj1Qqb2tTfyIxbC3lLc6bH5WtVKhgkCCLfjbrYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8860.eurprd04.prod.outlook.com (2603:10a6:20b:40b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 17:29:01 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 17:29:01 +0000
Date: Thu, 10 Aug 2023 20:28:57 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com,
	razor@blackwall.org, mirsad.todorovac@alu.unizg.hr
Subject: Re: [PATCH net v2 10/17] selftests: forwarding: ethtool_mm: Skip
 when MAC Merge is not supported
Message-ID: <20230810172857.er54cbvivslc43yo@skbuf>
References: <20230808141503.4060661-1-idosch@nvidia.com>
 <20230808141503.4060661-1-idosch@nvidia.com>
 <20230808141503.4060661-11-idosch@nvidia.com>
 <20230808141503.4060661-11-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808141503.4060661-11-idosch@nvidia.com>
 <20230808141503.4060661-11-idosch@nvidia.com>
X-ClientProxiedBy: AM0PR02CA0203.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ca8cfa-5384-410a-0c63-08db99c74958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hLnaZ1hkvTXEb4Z/FGk3caCojNzeqsA042M7SmRwUuO+2J7Bvhbgkz/bk+fS75+QtdkUXIzolqXWg4EnhhAv/UMBfD9DEYKXQ6RyA1rqTjcesPHgFzuC6u6gvajztN/pY9YFML5XHxwAMmz04ifr4y8YcivJfmZanw8d/N8iwLQQ4wFNcc28uu4S1VmxmlTyBDf1qx7MyaGQ/p0cXxmnrQsDp/5jO12sCZVU5Hw0wqDajcpjfyATfR36wmw4D0+jhUwS/jILbUuYmCo46SSXO6Xc40hd1m/Ob+1PRqwfAfGeY9LLXNxjIeULkklqxq70lCFhZNwqBi1u5rzdL713xQJoGY7UD9W2ImZfVc+pmwByUDHlLo7VgexGZ3g9WfuQd0vJPkuYbF1YhZUAnfnDfPtB9x8TC3v41ECM1hDWA6w55jwhSSXAAbjxBy4T0oEKv96ovPxdTp1p3jyclDq4ViGT1iPi28eDiLCJQaeVbKTLIM39AmDzQdLPcXI9w3G7fxPNhjbQhpGGhto3kKMBgxea3bjfW6I8gw6E9M03sa4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(186006)(1800799006)(6666004)(478600001)(6506007)(66946007)(66556008)(1076003)(26005)(6916009)(66476007)(6486002)(966005)(4326008)(316002)(2906002)(41300700001)(33716001)(9686003)(44832011)(5660300002)(8676002)(38100700002)(4744005)(86362001)(8936002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ozWetTZOlFgsVzg3VYDIJJK+D7opPd5RDFv8Bk2EAeDKB27Xc7TdsIrHLfSS?=
 =?us-ascii?Q?ssZP2TnNo76ywSFyA7OkHP2h26SL45J5CtxQk7jb0OOeNUTphDPvGLgWFaTO?=
 =?us-ascii?Q?1OCriELdiVKPyeK5YjiOCpnDVnQYRfBgJ1nd7soFN2vF2Neeao6mUBNQmm3U?=
 =?us-ascii?Q?6QdR5lZSQu41x4m6FAWXA4uuGfVTneItsb1G7Um5qeLMsD7+Y2TwKMRHVWbe?=
 =?us-ascii?Q?9ReiPemFFWYFyYklH1ATTVMUqNfUjcoyJKzbulq85x88RGLowvvyPPgpKQmc?=
 =?us-ascii?Q?ubVk6ovcH596K1CeUUFI0rADtrdYP2UErLwjLBNQo9uyh8yVB/lGMsVbwNeK?=
 =?us-ascii?Q?Hx6ie1aVYgQ+86ZAluT+iDln7XX6s96VPdi/O+bPx3LQpjIuQdlLS/uopoo2?=
 =?us-ascii?Q?15o02md+axlMJ/fnk2EED2HoIs7N174t/JzZkTu+c7U+qrubTXJC38Q/jgoU?=
 =?us-ascii?Q?XAebyPJNkl8EUyZFYaM8eMbdRE2k0P4ETGFTk+JwwoGcTuouxq4Qahw9832C?=
 =?us-ascii?Q?yPV1IWdYPaKH30b97rTi307re0csobZtIbgJ0pHy03hALhTtKtvSts1cwgoN?=
 =?us-ascii?Q?8zCzWPhOl8K0lNewCEP//jo3c8aRQggpO3pyHvV2gTNo+5rPeo6bOsrkl7Oh?=
 =?us-ascii?Q?xVEeid26SzaJKvbwNCEEPn8zJOe5z08FbUiAReuCFkqHNo3a9R9RbHecfGZp?=
 =?us-ascii?Q?cUmoUeGKojliBFO7jJNM10jVvHlvdcPjFEeDYaKyOvL5nWEoMbaSEUg126J8?=
 =?us-ascii?Q?nf8X27D8VB7yo01B/wtuKG6d4y9JiTTVNpxItWp32R7/1nl5/VXcShzleCP+?=
 =?us-ascii?Q?mz+xg4W30UoBZvpAprMeiaBcBs7fBeUBCfZRqQwJPRXHikzZVwa2ow243her?=
 =?us-ascii?Q?bENmLT1AHp/w8PIqESs9MjpVjpNLipGOxTVUMbFwhjXGSC4IN585qFspNOMG?=
 =?us-ascii?Q?1W7nxiV+Afcxs+AMsfjv/D+hyPVMtCW+IJsbwm7uELE6zNCCxkSYyesZhQxT?=
 =?us-ascii?Q?+3ZRmcSkfpzpPf0OzBpx4HIRR9DzgMm7J/lsjVlowLolLMSO6UAksIa5Zvtp?=
 =?us-ascii?Q?4hwAEO5Ynn+9lFv1pWI2f58B1Yxe3y3GSHaJclDKYzr4t6mj9op+/GhPdXaP?=
 =?us-ascii?Q?BS4OPODn/I/a/rRXxS5I/HFwIU3tNZOKqlL9j1hmdks2enti5ZVjxY5nufwj?=
 =?us-ascii?Q?jSrBtikZxPuGcWVK1ol8GTnXgEAF2QNCXOumJzBv2JyGEq23tIgJ7bwwzeQd?=
 =?us-ascii?Q?rFALSrziohvCsdwH7sB31g9K4qLrMQFEsRH6DBajDS56BuLoBOIdeERJ7o1m?=
 =?us-ascii?Q?S/lfXN+P9co0roPEKZ/HSHbt9TH0JLBGpQ/AmQk0D+MYUBg629DqmfyCStY7?=
 =?us-ascii?Q?ekUw0IFtqZuw3TZ9lotgjabjzYmP8RKCB49eXwDkdgCZs7umw0K2X8VLv6/j?=
 =?us-ascii?Q?DdFVVoyv/BWOsioi9aRBK1gXwQKtv8VxRm8HxUjdmw0QsAnUQieR3NQcMMPw?=
 =?us-ascii?Q?nKj3UCJLxBQfIDzsfci9p+cMERSYB7vbyg3iqpB3LBVtg9Ivzs4PXocqEuyR?=
 =?us-ascii?Q?ONmFXiTtqFjxez7j2xVTGCDPJ1w2YKCTBP6FCODynTpXrUKH4RTvHTt21DDs?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ca8cfa-5384-410a-0c63-08db99c74958
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 17:29:01.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtfL5Qp8FHDIGRbNwR+FM/w3wYHk/vtuNIncVeh7efSj1Bdu2kYJxV6HqlSncWulUJWJM/Kq189xaJwlCZlvJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8860
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 05:14:56PM +0300, Ido Schimmel wrote:
> MAC Merge cannot be tested with veth pairs, resulting in failures:
> 
>  # ./ethtool_mm.sh
>  [...]
>  TEST: Manual configuration with verification: swp1 to swp2          [FAIL]
>          Verification did not succeed
> 
> Fix by skipping the test when the interfaces do not support MAC Merge.
> 
> Fixes: e6991384ace5 ("selftests: forwarding: add a test for MAC Merge layer")
> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> Cc: vladimir.oltean@nxp.com
> v2:
> Probe for MAC Merge support.
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

