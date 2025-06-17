Return-Path: <netdev+bounces-198577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8E9ADCBDC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CD93B3374
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9AA28BAB3;
	Tue, 17 Jun 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kd/gmc7z"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694D728BA8C
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750164535; cv=fail; b=dtaOb7uZwawe1+b66DKZ5Gajx82XqEu/bOCb+TgBQLbGLH+fdwjhCg6r+QVRMC8XWRxAG7zNHYA874mLKko9C+YfqAW0Cn5AqpeL1ANJHHfnntcFgOP+lQUHNlS01h0PISSHNSqkRdSKPmi+0WY4PsJ/hgdnH2sqZ2Ng+4vU8w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750164535; c=relaxed/simple;
	bh=9X57tD985uvJQ9p+HTBtBZ2NCACcjAY6vuWnz4xrpto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LKfDQqLpe+wfrKWC245zdd6o8v27ug9D7YjIWqlvYw5RRgzEUfg4uW3d42M8QGOpjwfYD58EHwhSOGTOlwy6VpKGZkDdGxju8Ru7mUWTPlNP6GMsCdqrI29ka5uSrwy3peab9fPxpo5gQ26mzp5e3dlzE1jOGgHBnnWBKiw2W/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kd/gmc7z; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nz4U96OGmV6e8q7PCM6hAhdyRWa0X9YwHZo3Qe6Pv7f69y8LNlOedAcInBmHjnOCzVJv+vhdPwb7Mlh0/SzIaUlpUDoY+W4M+TkqZ9DTU6tb7pqhIvhIpS/ZOC9Yq87G6jCPpD/fjg2tv+UoZ9ryCDNwxy2FwHbJWVvdKGmB4e/SuwYSTV33hoY+nHXpfkxCQJvIRrRutjmJytm1PxQ2xw9MBwx/DCDEDrCS1hRlCWJ9x5hUctARWUHFQjnsOu7ymdV2FGQtpifFfyZCEg105k0NmopfuSmPJXkp+uMxXgMn0I7ccHLlQYrCFcgKxSq2UKMVsiH6QhpxMHD48p36kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPyxbdsWM3Y4AVntCdgluzQXPTVgwaFYNW6G7qGhFak=;
 b=EGp8+3rCTqI+FS0YeVtdQ8rv3YECkmTrDEVKqhX4rhX1rnfQ76Lmvz8m2jgLA0tM0FbHTcBW6gDsJdRH1MVtVHyEFSkdyWriK2TiXeP0b7Uk+qKtclxu7Z+7nYLHLbZY/9AAssqVdUqCiMaoV3ie1VmuvONyNE/7R9hH2HfcgCvJa1/3m86mtTXZamXWc+RKux+jKSl8ICXlRXo8/3eaLX+tm3zH4CthcqsRWUPvIEDiUBuUevwM7SG05ZGYFWBw6xbDrm/Dew/3sVbcRatwlfnvAU7ZGOLd3ucnmpn1AElWFP6v/m5QOLg+UCdpg++gU5tWoanRa5yH59NytHTUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPyxbdsWM3Y4AVntCdgluzQXPTVgwaFYNW6G7qGhFak=;
 b=kd/gmc7zaeXL1FnxmJihrEiJr23ZpfDG9XJ1D95EDmVSe3KyOeFSiKLvAYmeGDp1WQAEAlnMaaDhr1KUibB/DwfVib3ejby0pP3mR/fbGgnOoDB2kil4is7/e5OGOqPT7GdO9j12/QoNxXrWACN3g5Xr048jCJ57x8mI+apG8WyewKmaLD4R+3o4PJdzB+0k6BmttPvGrUUPLT6Y6nFmDdAWc1P/fL11wdaIi6uSB0HeQY5zaFMAjvedc+3jBLPhbvjoEmsE3UqhWPqCJMVXXkljiAgwBv2orL0V3EWg3e4tHH3/D4FlenFh7oWKKQvqzai/Qq6WwHbcDoLzU96AZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10540.eurprd04.prod.outlook.com (2603:10a6:150:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 12:48:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 12:48:50 +0000
Date: Tue, 17 Jun 2025 15:48:47 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	faizal.abdul.rahim@intel.com, chwee.lin.choong@intel.com,
	horms@kernel.org, vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com, Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
	netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next 5/7] igc: add private flag to reverse TX queue
 priority in TSN mode
Message-ID: <20250617124847.a77nrtqlylrrxxwi@skbuf>
References: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
 <20250611180314.2059166-6-anthony.l.nguyen@intel.com>
 <26b0a6cd-9f2c-487a-bb7a-d648993b8725@redhat.com>
 <20250617121742.64no35fvb2bbnppf@skbuf>
 <61c54e7b-9ffd-45c4-b37f-c570e310ea45@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61c54e7b-9ffd-45c4-b37f-c570e310ea45@redhat.com>
X-ClientProxiedBy: VI1P190CA0038.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10540:EE_
X-MS-Office365-Filtering-Correlation-Id: 9518ac52-0cf8-45ec-3697-08ddad9d4ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9FIL38DZcUPLvv+dB93VcRb0/iCO0dWJDU9YMCvUdY6fbYHnOkaQSUk9Hmp6?=
 =?us-ascii?Q?u/zG1kckzTQ89XmoYE/EDBW4H35u/FnqjKhOAc0ha78PbZeHVJwKTVlqgPOu?=
 =?us-ascii?Q?8jdr+99W42d1xh1rfRNhGvmphxatS0Wc/IkAJzRVz5Lt82vSR64QgzOOjC3v?=
 =?us-ascii?Q?+EW/1Z8BkpBmPA1uoBOKRdeV4Z1y/2TyOepGLsd3uJq27p6Euy9HKeywHIZm?=
 =?us-ascii?Q?INBu57w6nLODdZLF/A+hK1oonMWcGADcjhDNa2L0V2b64Eq/sUXnr4VCLIy+?=
 =?us-ascii?Q?+Rs4uHulj5MqMGaY0rNcWo3w5JCPOJ2knFUjJCshd5BxEmZrv+ZFIz+Y71ty?=
 =?us-ascii?Q?UJLufBh2aRlaKfJBSCijt95mcRpqYHuZo0rb4nbh8MAw0mGG2g7kdOe9JY3B?=
 =?us-ascii?Q?1HG4icADAW9B3toFqn2QLCxZ2cuny1a68B0XN2tW2lCXBDmwUT3ndyoTg5gu?=
 =?us-ascii?Q?eulX4GpAOtY7RMhSBeynpTNjtYAwJhPeK9DXA7eOfDjLVyp9kuNPy5WbsEiX?=
 =?us-ascii?Q?YuPezBQBcFM771ZDL6BsnWq4eVfaL+E1MeWTTXNNrd+ltRgjnpGAE9+YSpYg?=
 =?us-ascii?Q?1rWSsm2ycI0eTm/Eis/SsffczFStE7YfhJAsU0ExplgY5tjHeG3OXNai6fo9?=
 =?us-ascii?Q?ovciPAQyLZBGb1CEAulbYie64RwJqHfGhfIhaELD4GQim6UdGtIpBsfd92mX?=
 =?us-ascii?Q?LrsbaKkGRmkCRnPlihBbZC1/75mT/xjgDUnvhFm1LFCCPjpPwGdCibqmwmgM?=
 =?us-ascii?Q?ZkyOILMwIbj7gkBL52Tvk72b+MCJvb0GxmcbS1POnNDZiHOzIWE/xvdp0QC5?=
 =?us-ascii?Q?YZODZPAavuIrgc/Xel0Og+w/Qjryl5el2pAjEto8XSOGqsJllSxBlW5bbO7i?=
 =?us-ascii?Q?D0FWwdpZMNMSwpHbmYDIs5MCQYFd+8Cz2eXyIJmLJHU09iHIkIHcmFolpQIf?=
 =?us-ascii?Q?Jg6dSwH2JN/e6DXdHdgZ3eWC1YzIGNKGguhwl79HWfLO5VkbD7sGoni10ID2?=
 =?us-ascii?Q?hO90cGhb8E+YQomtoejHZqWJbCjB+KWjh2rjC2iQhpIgqXRz9lqAQnkQ9OxW?=
 =?us-ascii?Q?95OQc/WYfsXvB+vcEIMoNFJctyxWKAesXXtzaBO+TrskGrULMxfEcAj7KxJ2?=
 =?us-ascii?Q?CqA8Z4usl3/Y0v0z33KBSqceWktzVCY8+2djpYxtDfqlXdidVRjRkn3HFnZi?=
 =?us-ascii?Q?INKJA4+xz/LiQIEWUBFC7Co5y2t+eY3Z/9ZfQQuCXrBHrB5Nyv5zUyRiDBD1?=
 =?us-ascii?Q?puHxr1cqUoRxACgE4tdueirOhCKEBTnTBVje0axAi8P5ktwOYoRi6LXu/Xew?=
 =?us-ascii?Q?GQivlKJ9QqUtAb+UVIU0q0MLt+oRjfftmLm7UHHCCm4mudm0Kb1UwDaxcnbT?=
 =?us-ascii?Q?i2/ICadB9P9hAC+8lTdLnGBQIy16+Gvl23yBdKm15Yq9LaGKNcOFjoyZiXUv?=
 =?us-ascii?Q?0riK+4VYkl8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dg+dr2SZO/jzOMxLJ0CXX1HwurRj7/81J0qGzpxs1Ix58qH5RTYAqVqfCoJC?=
 =?us-ascii?Q?iYCfpGaIfY9MigTw8AAlu4EnSKCv3Ts0MyCtlQkt/SZXkTNWxVJwNXUlPjv6?=
 =?us-ascii?Q?guDnpSqUJqwvMONm7pRfI/BKEUArO1PnbMmEH9+aNUw6AZkamXFece/s7Dkh?=
 =?us-ascii?Q?w6PntEmRSjb3kB0XwPsOhfWLReTE3HqFgAv74b3xT4JWNc1D/SFOoQ/lip6U?=
 =?us-ascii?Q?4uZN8/XVLamoAkEeB83wAgxnbU8+AxfjMaQ1uDuaxjpUKeYKlqieNb1clt+J?=
 =?us-ascii?Q?nf3cnc0fV+Ip2kq4VLTnH9ayD5NpwNixC6nrMxzeVYNcavWeMn02Knujrafd?=
 =?us-ascii?Q?T28NMz92GoZCZbLHtFBtsTXZHSAdVLRcJcLcvccRcFmna3VdYHBwhgubyzyJ?=
 =?us-ascii?Q?UxjJBLs/FKoSIDXwMNH1o21W4hSFU/3xIfVNgn72N3q7PD3yg0/EZAQgspeL?=
 =?us-ascii?Q?rJzPw1tMGRJ9owq8GfxApwZBt+E7/h8bxsquQs0cNQYJHU+Q5CIuyO+H+kvm?=
 =?us-ascii?Q?vpDdMbbHa1gtex6NGr2Wq7KnXfY4OKEaxwMWDPr5uIJVbQTdoGJtPOrETZfW?=
 =?us-ascii?Q?C73GREDswQWuNyvKFOxDsBAiGf/MxBSpc88YJFMV/Ylf20CeDVCNPR0xw2D3?=
 =?us-ascii?Q?tvZI5G0cWiy7as8Ds0+SrjpZa7mp7cxj8fCYECdBPoJFc8RAs/txElYBRSmy?=
 =?us-ascii?Q?y4Gy7kxbhvhf2Dm2q3Zu1ka/AzGKvEFIBHjamSMTtKppMgR0E1HK+zIagbWQ?=
 =?us-ascii?Q?pn/c8xhsHNlH0/VIpX/jC2LGN98XWVlB2WS78TMWwpbYEoufWJ/0BcLKf/28?=
 =?us-ascii?Q?I7gBkEAkyz1s7+0Z1l1JeGhymBSya+Cq4TGXxR/9U78xvAbK3avzxBiSrV/b?=
 =?us-ascii?Q?2tVNUIOuEMeTqKuTklBB+tqG91yYRMHhVhhHRW+BFOpeTOTB6HjNMEN5mfpx?=
 =?us-ascii?Q?Fjejp2Z1leIz/P9IOt5LOAZHJktPn287OjLCJ8z89EpwDj61++KbBkFspP0O?=
 =?us-ascii?Q?626Q/Np2XfjJ0z/K8QQFcILR0VmeO9kLVcZ6KcAbV0YgVDETt11D+Oej3njR?=
 =?us-ascii?Q?YCRWRiXQOVSY174XBmfiRsXHOKOS+SXXjiZiwzaOLnj7o6T3TAXXtid30BJo?=
 =?us-ascii?Q?MWLYUAdFQy55Y4A/7WmUKKYQSRfHOrQIaEMpCOG9SZwVBiLLfh4ff/lGJD0C?=
 =?us-ascii?Q?utUPqrRFOPudT8JPwE07Esosrhyo3sdhnr1zcXwXmOT0/tkSwar3iJGBEtHl?=
 =?us-ascii?Q?YheMzEE6NuVWxeCp4wMIxGS55jbMdKxDPYGgYEO0yFgd9W/EGYFdPL0aM8RB?=
 =?us-ascii?Q?WrBdbcfq1IelzJ1g8edBTrR3cwIN6RJYdj+kOGWNh9IS2KnUqZ3S9n6WXsCC?=
 =?us-ascii?Q?1baePBlcU7KIC3Zpv5VP24azdYddbEinLEAyOsCAEvBLUQkouLylRuSHFh5G?=
 =?us-ascii?Q?qG26uMn1FSQQpxzxVlKt2aBFyXulmzEFcqkxG5MoTNpr8VOvkIA5wIGyJ/n2?=
 =?us-ascii?Q?WU1OJCAvdGE2OmdkLnSC6TmG3heHh27DrY7N+IUgWIg8K02M28SW4iprTK+H?=
 =?us-ascii?Q?2auTZjFqQQB0UMsd9/4eeLgNiL4Paw5Ra2fxABlJyl5F9gtOk3yGs1WA4UDI?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9518ac52-0cf8-45ec-3697-08ddad9d4ec8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 12:48:50.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lj2c8cgSOdILjc2WyXQ5xMatAm2viA7CVZfvKtquQ5dtKhBrZOw/nX/sqCqvvXaRT4y13PrJ/uYIVcqrovHqjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10540

On Tue, Jun 17, 2025 at 02:45:50PM +0200, Paolo Abeni wrote:
> > Is there something I'm missing? It feels like it.
> 
> I misread your original comment as a request to make the 'standard'
> priority the default, and the current one reachable only enabling the
> priv flag.
> 
> I see you are fine with the current status, so the answer to your
> question is 'no' ;)
> 
> Paolo

No, that would be a breaking change to their current documentation which
is all over the web. I just don't want that operating mode to continue
as such in combination with frame preemption.

