Return-Path: <netdev+bounces-175839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333BA67AB3
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 18:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47B9176552
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88408209F48;
	Tue, 18 Mar 2025 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gf3bZ5VZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B438211494
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318436; cv=fail; b=WwG9/ogoLKv+tkojo8I1qxKdIIyFooxO94ekOQO/pXC5ZvsUMO/yXJnNbIwrnT2kunTLeXA5oVn8ynjeMAxPxD4r/JXufbRwFzaZDZB8GYZAUNWMFZxb7qEetfAaKhoyvjZCQIi91hghVJQnUku1VwFqnn3bT5TKttuxfknbNp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318436; c=relaxed/simple;
	bh=WDtsXBrnQoxISfEfhVstgKuKFyKsFXQ++HZm6qihE60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RxJasWXQeHNtiZpwlTsvesvU2iqZC5LKMsh7eaJlSzjGsxak916SI+CLypTTN+YspXc4zlnaTCAMiXUA4U1ZzhUYm2cHTQzGkOJdDGVrEsxChI328uHXjh2IvD2EUa03UT/T0vIF6iMxLHX4L+IFWNmuLqrAPj1q+iiK2RRq+GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gf3bZ5VZ; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pi/kAyU+EhpRY+1IS/Yn14bwQ2MQ+o9sbg2akvcSItl7ECqvp6RDVORmpxNAJ7dv2MNoqknHGpodIC810y7ETxHe3puC2/C5OeKpRUFMBOaM3j3L5IHGcEPLSZ0OYIpMl0AJ/plZMDC0WSHkkyhH5lSjYXPSL29FgoxYdMMUyHu3wC5r+9yaz7E0e9qoJjC8N4huAZszxIP11Xz2Tal7cLSGbcjNmtZ3toFUmz3g9NQeUJP48LP1yJLnTFzCCTyFZiB3NalzwU9iVOAsI0bUKb3jy13YlZTO+nhazWKSMzIfc5Dv8Pq25JsPkO/EguuF/v6wrZfzScllWV+tlpByHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDtsXBrnQoxISfEfhVstgKuKFyKsFXQ++HZm6qihE60=;
 b=tPoPtUk1iEONSnoUn6sW5nLD1X8LL0DMBpTqvoZLOUgiJxSUNOC+F/C/KnWexC11lBxkI+tWkgq24Eom6rMzRxGh0RTft1AcIPFdyxuW/j5L/anCDpOtz/3Ho9iGfq4W5141CuUNKm3jVXJ14E25vE5TzOL/QrIC2HRP4V7AdL9aeKvvXtPBX5QdQycrhHCjuQBhoklnC7C/e+sI/0F1j6dNS6r30Ard0dL9kz2CPDp6zSevt6BZSZc21qUAUkIXVenKfWfXI4bvbWVlD3qSpPLKfRb0OCgf0nWk8fQ8cShkrLf+RRwVYMnkaiXGtB64nNDj4AD5mBIB5XICzEGySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDtsXBrnQoxISfEfhVstgKuKFyKsFXQ++HZm6qihE60=;
 b=Gf3bZ5VZmWUm9hwDmGxWM+1HXmBYvrtfb2Cvf4Uia+FZxZSOkHMtODKIZQQrirra73tOTLtrlOgaV41mUNJUba7pXAc5mGyeAicCpNVQGM7M6lvRdjksfqxySqLukFSLc3kbLCev5UIKlsjNGuYLEh2q7MzFmAhvi9+pmn3WPgqx0EowDcnuogJ9MoxRBWxnuTG/Bt0UfqjvT+GWCHbgQgcspY5PSI8Lq2b7SYDspsOIlnnt6nqhuAtBfeaD0fjlEuRESuM/oHY/enYKnOzXML8rrkK2FqvkZqgNAn3unHUIdsJ8GDEZd9wlYEi3m0iEG8E1Qow632d1QV47z8Kp7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 17:20:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 17:20:27 +0000
Date: Tue, 18 Mar 2025 14:20:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	"Ertman, David M" <david.m.ertman@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [iwl-next v4 1/1] iidc/ice/irdma: Update IDC
 to support multiple consumers
Message-ID: <20250318172026.GA9311@nvidia.com>
References: <20250225075530.GD53094@unreal>
 <IA1PR11MB61944C74491DECA111E84021DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
 <20250226185022.GM53094@unreal>
 <IA1PR11MB6194C8F265D13FE65EA006C2DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
 <20250302082623.GN53094@unreal>
 <07e75573-9fd0-4de1-ac44-1f6a5461a6b8@intel.com>
 <20250314181230.GP1322339@unreal>
 <8b4868dd-f615-4049-a885-f2f95a3e7a54@intel.com>
 <20250317115728.GT1322339@unreal>
 <dc96e73c-391a-4d54-84db-ece96939d45d@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc96e73c-391a-4d54-84db-ece96939d45d@intel.com>
X-ClientProxiedBy: BN0PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:408:142::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da7a275-12bf-46ce-51b0-08dd66412d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OSzLXRtHJTh0FegCHBVj5Mm9RtyJ7gKuJAMBZs9kZBc1o16FU/C/FAxKU/jZ?=
 =?us-ascii?Q?v0IdENQcmHvj45Lc2PBG8vhShTsVkUVtAS1+0YZ1BXk+7n5LTCDJWst/2NYO?=
 =?us-ascii?Q?Q+rvqL58wePUnf7PcyYkAM2hn7IdHb53EilHduhYFXqYQtebpGyMzfitDho3?=
 =?us-ascii?Q?hZxcLuaqY8r4dKBvD+6ru/ux13zWaav83PrqxdyVAdeUqcfj1CAyhh2CAIRZ?=
 =?us-ascii?Q?riIFJzUEVbmoP37mPpl0WaIqD74z76dT3favycyNtezG1uj013OBwmDxmhyC?=
 =?us-ascii?Q?8WyDy/S68KAjUpHX/64tcemGPJGf8bzVyqLo7cTcWAsrRSNQ3nYrD0i1756i?=
 =?us-ascii?Q?+BxTQV14Zgdj/4vYyTMydWIoUwb4F4ZK3nHBRtmutL58uD6hm3UFKE4IgpRQ?=
 =?us-ascii?Q?e6k7YlgzR7alHEprO368Z065OnULtANi+09madY99aK3eToBPSp8nihEenW4?=
 =?us-ascii?Q?dJ8xE9wF+M1xoUSjzcIDkmVdlIYvnkKWcf3IvQPKCaon0lQXfVEcyR6n/KOm?=
 =?us-ascii?Q?zujGfGMf7qeab40PasW+IQ6DNHrdZap5vIclql08m1AGMzbyDNoZwUYKyBvq?=
 =?us-ascii?Q?aUzPSLfQEMBQCS2OfqEr2UN98h63g+UKYvkp4mNQUoOm9iY2yI/Rw2XbPJhA?=
 =?us-ascii?Q?b3+S/LjKcCt2G5hWS6jgOZGmyWetBq+tSNgO0cGMNooIuvsICmMyEjMCFDeb?=
 =?us-ascii?Q?FpBzl4aDvfIvfSHywqJfWhRo6dHAdm/ykuBq3t8YD0lHaM+jLKtCwNwbc7xC?=
 =?us-ascii?Q?57MMgI6X4S6VRTJTeGEq/s+NbMs0+PGSKAenjaR6U6fDO/CCnapdWrYOMg+6?=
 =?us-ascii?Q?tsMDI92x4QrlNrtF/cXzSEkEyXztntqy7Bo2e1UYCNI2d1a/gkrG010uq7YX?=
 =?us-ascii?Q?7N8+AYs1wQQB9YOQbtg50f6KCNi8xqoM4qNObaboiqmVLlZxtMSTkcvoB7Fy?=
 =?us-ascii?Q?mXAYSo1tP7ai2DE/sEjg4e5BfUhwq+8AqRGTBiDcMotUIaIbDd193hRGiKOf?=
 =?us-ascii?Q?0Njzs2/gceLxEcw7gJNrWfxPO/42k/kAkXZUlvCvhX0ykcZWFfACpAXYqxOd?=
 =?us-ascii?Q?Xe68MzKyYgVA2LeUfgNEOLs2WQFDgNhoYNXiQSX//QDwvU88EB9C3R6Pui2E?=
 =?us-ascii?Q?O6JVkmyg69+6yrO9kSt4Q/sCWVfyf0q7EINmDLpNG1WHNSqCrF2tqChkMupG?=
 =?us-ascii?Q?45xEW093+EM2ZUGC06Yw9nsp6x5/ivN5mKWZ89EhkK52XPaziuzU+UuW+Mp3?=
 =?us-ascii?Q?tMGtPTHevnvwXX3TuA4wgi6yZzlRvpFBjE1IY2ZsKseuwIhkE+b9uNsJvKlJ?=
 =?us-ascii?Q?JFKU3K4WJ7V2RgRcgzfr8C0PUahZOhYGp/UvSKQNQ6I8HuNkrsNYOhb0J5kw?=
 =?us-ascii?Q?k17FRwAVtZ0U7gWatMMyyP5mA49k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0RiMYTOdwl9B2X2StU4E/M5Wb5NmayovdFQe2Hk00MUGy/rjUYhnACaDgnRs?=
 =?us-ascii?Q?ipSRggnwccQtk/FO75Aunx09RlaDlug5YMQUMm59D3O1TFtMekhoqV3+hrdX?=
 =?us-ascii?Q?WQcAFu1wLsv097elgbljpC0ftKGCRFowqPwkFyYDyNhquiuvInrMImYebOCN?=
 =?us-ascii?Q?a3uIha7mMGd3gkG4w8vBfaY6dDlBHxk8HShcRlr/DoU59cIAaWmuKfUuqRzc?=
 =?us-ascii?Q?In4KzD5O3RgUjej2g/GtPP/9DbSz4Ycwh9W5u+9s424IWwjFC8ZzyuIeJAU7?=
 =?us-ascii?Q?sZ7Iqz7NkJEV7otv0nl1RfLdosjNm/YneV7rCTyTiuy6JN2/3SMeYiCJAxA1?=
 =?us-ascii?Q?jKKLUvAqQJu77TV/tD4RlMlwwirJhZKTSAn4fAdcWgeOf9AIssjbOjAglw8U?=
 =?us-ascii?Q?pAp1+hQgbWncL3j3XIXguWb5Oe/gUYogaWVN23dDz2n56d5ttafP3541Cl5L?=
 =?us-ascii?Q?oZhfcqI1Jss3h1n4zLE9rGA3caUgSS8vybh/aDIVTsOV2MSWu0lb3LSWsujZ?=
 =?us-ascii?Q?QI868O3mrZcsCjglDFV4UeAjCvjdUft3t8haqeiXXNq7g9fWuQYkRkOf4OrC?=
 =?us-ascii?Q?/NjQqwXAYp8QtivmUAZ9kaaRvBsP8lg5+vgcOaF9NV7nExDTegtJWBTcJv6n?=
 =?us-ascii?Q?bRpu7tPUQ0a3HiTTnvPQ0dDBA//2o3IU7Bo7DSqd5Qxu5Zly7ml90+Y7mVhI?=
 =?us-ascii?Q?Z0Y4fBLvuuzg3gu64ZkBKYdEQoPWXXcjVUGaVuYkmx3AqdYJGanRkkpOLjjE?=
 =?us-ascii?Q?l5Z1K58YhcKQIV4jkbfKMUUrf1DwH3aISgfN4GasL9ovdYQ2l/ASG2p/773A?=
 =?us-ascii?Q?U5ZQ05R15dE3e36lOKisrW+d4FYdlOZt54UmYBNgGKUxDNaaijfDWC8fa1Jo?=
 =?us-ascii?Q?af+8S9GE0dTukJVjV704rlCVlDTvRseGerOoVh8dOpik4GWG8Mp3XbYfcHOY?=
 =?us-ascii?Q?YSudGrkigsfiPyIcDKZJPQT43F4f0vlXA58DFt/PzUv+qMym0WPzDOU0cR5W?=
 =?us-ascii?Q?dSj4/2X3pdO4m5937ixzP9I0SbTsHdPvqRL3P9/xF8Y/OPB04aL2hCrVW+Sq?=
 =?us-ascii?Q?c3KV6wWcKetm4OW3y8rD7odZkYehubLpzZfK6i7u7cEbfJRid0ZSn+MrDpd4?=
 =?us-ascii?Q?7aiDLbhE5hZWZDW9olenE0qB2b6coXYLBmiQLhkwYUz8+o2CwpR2AGhHGw1g?=
 =?us-ascii?Q?W+3I/oGMnuYZVUTeOUcHdxm8O11UxYcvBB9abER+xkBKoiohcBkj8UOf1AY3?=
 =?us-ascii?Q?vGG4HHYvM0uIOb4OzUX2InNmYmLpKMRr5Gb4+VZzPwVvS59VBAJU/SVC2+z2?=
 =?us-ascii?Q?ygddoN5sTCUNBb4THWUL3DHe8UU7vLBDg2gzAH1vEYGPHmccT+FT4O8hV4Ew?=
 =?us-ascii?Q?2hy3cvk/U0ls5cDJX5ooT7+apRrJfFQ0EHr+vOwHBZ0jKbG07FyjxObI4hH0?=
 =?us-ascii?Q?f5MK6zRGnNBueQkT5eQbhYfw9RqKyf5SDlQg7M52qBy9Vhd1W17PB4O8sbkz?=
 =?us-ascii?Q?HlX2CDqjrp2yEvSwIMvkeynRx1JyqraTfYz1BoY228NdqOOO+bgZyLoQhwSH?=
 =?us-ascii?Q?tJSdK5pTFDhAjmGDcgNAE5xu1m3VuJgzJ5PE0d68?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da7a275-12bf-46ce-51b0-08dd66412d55
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 17:20:27.7815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/xG2lhE+yXy6XLV5d85ARpG1Uh2X9tGraRUvW+ha3a7Smj5p7yFf2BfCSCO5Nrx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049

On Tue, Mar 18, 2025 at 10:01:36AM -0700, Samudrala, Sridhar wrote:

> Yes. Today irdma uses exported symbols from i40e and ice and loading irdma
> results in both modules to be loaded even when only type of NIC is present
> on a system. This series is trying to remove that dependency by using
> callbacks.

If you really have two different core drivers that can provide the
same API then I think you are stuck with function pointers :\

It is really weird though, why are their two core drivers that can
provide the same API? Is this because intel keeps rewriting their
driver stack every few years?

Jason

