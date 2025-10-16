Return-Path: <netdev+bounces-229995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB0BE2DCE
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E7C1899C9A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FAA2DCF47;
	Thu, 16 Oct 2025 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PO+XTFf3"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035332861A;
	Thu, 16 Oct 2025 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611338; cv=fail; b=Z8Vb1MCn+6q3IPdII99Ihb5M9GrTqZ5stW0jUECd0bCIMrmMN19oY8pZmA5kEffpKQQAp6nZYBvo6Bvm6mlT3mdhekV/ARs0lbHZlieHjolZMpRgOvlCtVXvMLoht9wQ4eyW8y58Zhk5Qq6bqcJGeWMg0LXSXQiNfatVRrTY0Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611338; c=relaxed/simple;
	bh=TfRmwny1GUy2Cnyo5ueQaq91S6NN3VJ4N+6QEyexZvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qelEeaaiwRz8ncWz51P76TF4m8JoB2j1DmCj6mni+CPL1JYGg70+QlCGSGxvKHaQgickaPW3KnZMvDL9D/23pMD82Ne8/CiR1LcOCCXryMIDLrkbeAjjagIMvxkEHGPeitwnchRwLXu702naXhwLNdf7a39jyaNgg97ewgHLSXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PO+XTFf3; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EE7C7KqP0/553z9T0+2G3JevE5HUsKbSsJVRYrqgZXcazIValeKjAh0W3nHnc5bit/+W3cvxCIl68cxfgL3/2iQRaZeq/3eZOb1lHozUfwZYleVOy0JE/5aygbOj7gq3yLWhE5osXEulGmzeQ4Q6cO5xVWVmv1tazdl9vDPq1PmYSIq+48wjHmiQSO2eMnXpMEmjTsADFXiaGzb7KuOTi+hhl6Kh2nIFREqHoPAF4vtmLnk5JraC6bR+VWuGgK0LWZDcuQYSQZ50bmToKJm2uuVvf9Hx41ldAz77VsdROgUtWEqVet+Grxa6NNW9cZrx6g50drTCAeZQnaPCtkxpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6Zj1FS6eN9yTFTIVuOlVcSYnFmDW8J+Pd+FZEOA1Qo=;
 b=nCoyrygHaLUXzB7rKfX28SzJ8LJY588fkFk6F91hIccszyM43rENeSKwONZ8E6/Zsl8CrAC9VP8andgc5Rt6LDeN5yAzWJATM7SqdT7dUTCCcLSXFTk5fFfyWhubS+dAtQXW1yvRi94oe/x23R0Jypgbj13kDQMXWvH7i9w8gUbFE9bLiN6uyioN8TymIfwr61kjRjVW8cGheF+pQ5ZT5rQdlw559DDcbaHBHMcvTSQ24RYSi8PTk7GK4+g5TVtsrGFkAIcDaIpmrSi/hWRT6RprxsnUvHxPcAkYj7eiov1HGcuwFgfvS5x4ux+hRUIOIyxqkcSUNVS1OfKlwrtbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6Zj1FS6eN9yTFTIVuOlVcSYnFmDW8J+Pd+FZEOA1Qo=;
 b=PO+XTFf3xdozK6Ea6sLDeMZrAHSrfAGyi9EuNGYgr1GgUM+EtX2ZlLDqQPFuN8uuuHOA0I13wrVKAFktaQhPGQpQWF42RrXPxho9Mg/tJyCbwXsKT4cgnr31SlMXav/JJgqe/dQsWJZtxUQzMyKAHSCmtuRWWkW5+mOPHQDeEdIKHA1aMum0JD4IxSLkLueQFHPKdTNQe42ObfkgOFUBYHtKPVBgxwxMMXFwSufRD+MaUplNUnTN+7AGI7rrPvUaXViuAVKXZCnf8BzNPUIQhjCBTXquZ1uJajo2ysn5PhPONp1f9wu7YMmr39o4CStWCnZPmjM45kmCCceaXjM8iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 10:42:12 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b7fe:6ce2:5e14:27dc]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b7fe:6ce2:5e14:27dc%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 10:42:12 +0000
Date: Thu, 16 Oct 2025 13:42:09 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Mathew McBride <matt@traverse.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpaa2-eth: treat skb with exact headroom as
 scatter/gather frames
Message-ID: <5wmhc3jppqydhiumyzj3jsthyygzb75f6iazyzetdnfah7rsly@p6qj3licv7t4>
References: <20251015-fix-dpaa2-vhost-net-v1-1-26ea2d33e5c3@traverse.com.au>
 <xl3227oc7kfa6swgaxoew7g2jzgy2ksgnpqo4qvz2nzbuludnh@ti6h25vfp4ft>
 <9beeb68d-2973-4d40-b48b-ee9cc984b9db@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9beeb68d-2973-4d40-b48b-ee9cc984b9db@app.fastmail.com>
X-ClientProxiedBy: AS4P195CA0020.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::7) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|DBBPR04MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 26cfbd1a-5c71-49a3-b14e-08de0ca0a9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bbF4RKZc6PPeuwN66vbRxzEGDrj5hiRY/FCFUhg53mI89K0ziOhJzDRbCyc/?=
 =?us-ascii?Q?6l1vKkCnVMzcvofOdpcJrrYjLizCcKF8+lmh+40Hafvq9k2qwpZF1iLcHqt4?=
 =?us-ascii?Q?w0JVDSoP2ZGhqDR6dr6qO4zXku9/pVsDyCLYhESXyQz+YPOtY4uoA0gm8kAn?=
 =?us-ascii?Q?nOHYV8imD6Ron0dHPGahGFYgS7Md3Ztw3hLRIkO3AxSJ27z+PCA4obxd+KHF?=
 =?us-ascii?Q?lyhDft8p8ats5HDfvRDikk4TwXdhfS3qQ3K2CP49tPWNb21Da1/ivBqik2mP?=
 =?us-ascii?Q?+R4hXV7Kei6lY8LyCPblECnLTe6Z/z0ip1AY81xgkIO2Wxsw7i0AmIBEb8+m?=
 =?us-ascii?Q?2sLWHv+7eU51j5qKdDuprQDk0MiKXGS45oSnktImx8WGAv44oLbymRPmYUhq?=
 =?us-ascii?Q?ERgBMEVNhd8dkqGpV/szfdbXvE+Lcg714SRgs69YFQ5s5jmDsfcMuMFuMKdu?=
 =?us-ascii?Q?sT1jLjsmAkdWw3ffGPbBwStM9SrPz1AAFH9p4EceQPo3+BVeGG5XcZlMtrSn?=
 =?us-ascii?Q?qn5NudCAsXyONni9+tPDaKUjy6hzO/jGc4kKKzuzD912SlxbK8bEsPALyJas?=
 =?us-ascii?Q?RYqnbQhs1R+p6E9dLH0ItGA6vylJX2RoEo5bQwcb6H2x3hm+e+RCTYUlKz8w?=
 =?us-ascii?Q?AVJ1ifL277SEH8W7pYFxcVI0siZclhf0X5fN0jBtZwkBJW+wb9t/sN7rZKL9?=
 =?us-ascii?Q?EOzRIAKhQxK7OXwU93S5h8MZm2BiVF2HNqMJlN0/57+NdgVMk6IWSHRVGDV3?=
 =?us-ascii?Q?1NXjEPEfvRF6MjZZ6aW4gC9/Sr+03w06nt9/QXo0aYriF2HYii01MEFgW2/b?=
 =?us-ascii?Q?7dzap6tFYv8WVx0xh/3DPyjuCYzVMewqLd9ZOCf+v6nYTr2O1kW63VhMiIgE?=
 =?us-ascii?Q?vDPXNH0RDkxMlhxz/BUm/mIdIUGxo6XDAPlB5F6Nq2pUKxec5/TFGbX0kamv?=
 =?us-ascii?Q?KOLkXViL6e8b6FgzJD3UpELs0hdXF/6ESlZwPbSZ36h+CGWXpzBHs6SxcSgb?=
 =?us-ascii?Q?86yf5NyVay7qScMcMz160ofZCnD4YkZ6i57PzbSovXDbx+w72tQ5dfNMwp61?=
 =?us-ascii?Q?ZiJ+12Frm2RAAUWr7tbjvGvBpF2SdwiyCtB51gaxJDodFOcbYx58xJK4Rhj3?=
 =?us-ascii?Q?YIZTiQfLMsH0oI4RZzoIjJcePruv72rxxvc0h0Go//IVP/7aPbBie/ktORvh?=
 =?us-ascii?Q?vXqEOB2OqzLqgaliZWvnvLu5bRWQqdokO55DO/N4nflsmSjRTnZKF9frmcBK?=
 =?us-ascii?Q?dmrOf4MktWOGJGLmmczJBc6JwzrVyLfL5jH/M8aQFnJx/PFIU4l2WhY+5rcV?=
 =?us-ascii?Q?zwEb0o+4vS2bOwYlcguHUwu5nBGYWQTspFKmB4ft9gNr5kFH/yGDbqBUTK0e?=
 =?us-ascii?Q?GAQuwOIIxHzNhsPwRQumXUs/RDHos2x8P4S+qqbelDnKGc6DKP2oNGUgfpkD?=
 =?us-ascii?Q?loWGVP7gHx3Jr/ro1QQxrh/MEL05UNJc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DaaKpCku7hMEj+xOPjJxi6SFSGL7N+ISR5D3hbYolk8wTh+2Ed+Db42v+SqE?=
 =?us-ascii?Q?K25T9GxlhS/pNzWjM2SSmB+FG51aSfvwhTQ8ozMFFYOOaMKZryj83qexR/6I?=
 =?us-ascii?Q?OLD5YSeBzWSBHrPphVgNXxcICM+HSj8DIL1b2HzFMxV7wypngos/qppDKtLD?=
 =?us-ascii?Q?xCvqPpJLQA7DvKThjPptnNAVSxk/pV0F25sESCeXoMAmR7kkMfLnJ1s6XBvd?=
 =?us-ascii?Q?YJm2l6lkKMC2q5QYj9iINn9iFa7o8AGIDSTDrpjf0j6T7CPgM88E3VHainR2?=
 =?us-ascii?Q?LBUvROkS3MuA03SotwtgDDnaYjTRep9kiB8Zg+05MZ51+das966vwby2qIwm?=
 =?us-ascii?Q?CT+HIdf+G/ymDvzD/NKLL/QAgUv1pcCotYRZOouSXNWKIvgFU4aoeQeKn65N?=
 =?us-ascii?Q?iA4sP3KA0Ho+yRUiiM0hVq67GvqDFIdbPs2pqLZlS/1H8idXsxCiFWiKOLQK?=
 =?us-ascii?Q?5wb5anHjnb+ZEs7qh9kxkdfnzW+fjOe5HyKRdtJ4/Rt/AYh2Fn4jVXt88frP?=
 =?us-ascii?Q?zCxrYz88dmdtbQzPZKb1S4dA6yvct87/LQRiTIOfZpg1naCoRASUtq2NPzuv?=
 =?us-ascii?Q?LxRlN76ud0eVSsKYh7sjqnj9PiwcbG+jFPmcAaSDa5RtaxzSUriRDjhL/7RG?=
 =?us-ascii?Q?MN2Pkx/Y8t8hBiqc20uVfNWSAhgRwRN7cdJbfR41s4od/atxpiTcROfyFaKS?=
 =?us-ascii?Q?J3HQidTolu9TzSom71wMpk2By+xge47M0iVNvRqdGAZZuIXeYDCTiOqfJpnV?=
 =?us-ascii?Q?sMCPKRUJWYqjwscqvfdbm/HxiVSOUd83fggeEvnKCKX1vzb2bGPWoihaYIml?=
 =?us-ascii?Q?p7a6nQFed+FlXgaBU6wN0+8ChuYQx+iNEAQrugC9RHijr3wkO+ZD0ECmBkN4?=
 =?us-ascii?Q?2CdontVOCgZvrlp1XIRXgbZj0O5PuQ0Abriaawdxwl1lNpOWJbbIXTxmGRKu?=
 =?us-ascii?Q?Clb6GN9swGhjtKbSdjwZG2c4ABgA4WGr31IYPWscwHggO6LGgpL8RLF40i90?=
 =?us-ascii?Q?hHnVyl8xzPMJY9aH4YnzLX9YCW3wihlSdcewXjTiRN1PipNR8X7REA7fkVle?=
 =?us-ascii?Q?B4fLiJ18RAG/WdaI1alyXHEu/JUwaNeCeoboWWIxTx3VkZSfi+ssyDOIdxVx?=
 =?us-ascii?Q?DA7lhOr8p8Kr8aCZ/z4O4eJOp5pXxQ2XxbAHFR8/E834jgYxxEOd0fVxD0xB?=
 =?us-ascii?Q?NPstBBePgW/ySvkRG2gizMH7JN4s2shIv7BBR4SbLIcMe6fVFbMMNUZ6d0iI?=
 =?us-ascii?Q?oVLc43o+VC1xMABRI2L88XYUSoIPalTjuXiCBgViKA6VyCAeXqLqHUP2hbpr?=
 =?us-ascii?Q?9HiZI8hamFUxul5+JPL657LKtShqaXvdncdeunwWTwHr/wvNRjekizR2I9KJ?=
 =?us-ascii?Q?DJKHTQKfqeyCJWKeArcWN4hozn7Mukz4DYB6vOIMGytG0TZAd6QtyPylJ1aH?=
 =?us-ascii?Q?SkIyRvEj9LSJLajanewqtXTIYOCVVr9WC0BUoI2JX95HRuMvCbZIJq03IQMD?=
 =?us-ascii?Q?5dyRc1Y1bcsW2ogJchCy/LmcZBEVoSnp7tuSCVJjOLIA+b4DC8gdRzu3rWvJ?=
 =?us-ascii?Q?rsqAfFmj0rXgXl/EihnKWMi5XyYH8MYN/bHP4IrA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cfbd1a-5c71-49a3-b14e-08de0ca0a9ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:11.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNe7NG8oo/ci59uzl5Y9ouZjnapiUwNhIiLaLf9r8FVV/LZuPB5MLEjIOoSWLhqYIaFJ7sqJB/olp/kdEe4rCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930

On Thu, Oct 16, 2025 at 08:33:27PM +1100, Mathew McBride wrote:
> 
> 
> On Wed, Oct 15, 2025, at 9:18 PM, Ioana Ciornei wrote:
> > On Wed, Oct 15, 2025 at 03:01:24PM +1100, Mathew McBride wrote:
> [snip]
> > Hi Mathew,
> > 
> > First of all, sorry for missing your initial message.
> > 
> No problem. I had a revert patch in my tree and mostly forgot about
> the problem until a customer of ours reminded me recently. The S/G
> "solution" looked easy enough to try.
> 
> > While I was trying to understand how the 'aligned_start >= skb->head'
> > check ends up failing while you have the necessary 128bytes of headroom,
> > I think I discovered that this is not some kind of off-by-one issue.
> > 
> > The below snippet is from your original message.
> > fsl_dpaa2_eth dpni.9: dpaa2_eth_build_single_fd alignment issue, aligned_start=ffff008002e09140 skb->head=ffff008002e09180
> > fsl_dpaa2_eth dpni.9: dpaa2_eth_build_single_fd data=ffff008002e09200
> > fsl_dpaa2_eth dpni.9: dpaa2_eth_build_single_fd is cloned=0
> > dpaa2_eth_build_single_fdskb len=150 headroom=128 headlen=150 tailroom=42
> > 
> > If my understanding is correct skb->data=ffff008002e09200.
> > Following the dpaa2_eth_build_single_fd() logic, this means that
> > buffer_start = 0xffff008002e09200 - 0x80
> > buffer_start = 0xFFFF008002E09180
> > 
> > Now buffer_start is already pointing to the start of the skb's memory
> > and I don't think the extra 'buffer_start - DPAA2_ETH_TX_BUF_ALIGN'
> > adjustment is correct.
> > 
> > What I think happened is that I did not take into consideration that by
> > adding the DPAA2_ETH_TX_BUF_ALIGN inside the dpaa2_eth_needed_headroom()
> > function I also need to remove it from the manual adjustment.
> > 
> > Could you please try with the following diff and let me know how it does
> > in your setup?
> > 
> 
> It looks good to me! I've tested across two different kernel series
> (6.6 and 6.18) with two different host userlands (Debian and OpenWrt).
> Both VM (vhost-net) and normal system traffic are OK.
> 

Great to hear that.

I will prepare a patch targetting the net tree. If you don't mind I will
add a formal Tested-by tag when I am sending out the patch.

Ioana

