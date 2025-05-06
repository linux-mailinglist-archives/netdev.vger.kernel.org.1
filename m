Return-Path: <netdev+bounces-188385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4923FAAC9C9
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600E93BFAFD
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C760283159;
	Tue,  6 May 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NqD+LPfy"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013057.outbound.protection.outlook.com [52.101.72.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267725B69F;
	Tue,  6 May 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546400; cv=fail; b=aHNgjS/bhmYy7K/EglKrkJwgq3HteNsgSbixX7Da/bc6hcfKX+SKo4rJ9dt1LSwOkWGgqYPNKplXEagGQRx8iNB9aLTQmTAURiFweaC/v8GJwkmENWxV0MjdoeYN0+GajbuXxg03PXCf4UFNnKYg5fRA1/W1O5GtxOKyUZG6Ar0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546400; c=relaxed/simple;
	bh=+gSwcoRCeIeqy2hlEsBXR+p8xCSZp4CrQ9V1Oq9loGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gtBxOgh4l1bCac/qzAHmrJrac76CX5ggNnn4A++cw5DPWKQ6wDa6HoFQ+s44TY1S2dGBVbh7RcfsM0RxgMJy8mcQjXrsJCXJEBuLcrXkiWca0aErhLDoKsR7O8inOCJP8g76WZQe4c4rNyH4ir3U86v30anTI9QumTICzzfF4wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NqD+LPfy; arc=fail smtp.client-ip=52.101.72.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mueLXWL+mfWLOAHkORUaMv61rQebqtf49QKOCGnim48e+DI2dUk4QCBj869gwUiyw6Q9kVfow70og9kFA2Fa5aWgMd7UDO0WqEF9YKeylX4fOXUNI2i+XvsUzkMNwEK7GIUySnos7gNjj8h+e/SOdGIsCLQ1tdVxeSVF/Lcb9s5f31gGhpNAptqcX+L1mStK/AOxizv01OAdRxzJm/vwu43QrvGw+ViglXPFr0oGbtmEGqjYUU3rkqXApfduhKEhZza3zgK9455ESNUOoWk/8dHRoj5E5+XJzEB1IxK98T+6mXc8cxuBIWVx8HW/5ZWwWLOhENo/+XSeEUvyyu4yhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqW/zm8O1cZ94t3/d/nkkPXPOwbOPmcfD2HxjaVJJIk=;
 b=Q0maXNft21ZO+SwLJQSLFPofarEO4krEhDZigq7gf1/nFiz4Od3XtsbpNAug+e15dkozXrPBp07XRPTo0Y9qY41Qpf26Du8+wk1X8aRCDWlm3P8DX7c7i+DlZaZ7gZUv027VxaFDJG17pknkU2RpwUxnhQId+A5kNwQPlXNdZhv5+2NZI3mCygngi6Mb0lkBSUc8rEvNeRr9PN2fecM5Aqq6G+0F5HBPONmCRqwPKTZHF1Ur+Aopj1PeSYmRDuUB+oqau3Z61r9P7/qI7+cstxLtBrkD0qJqf6984ceZQNgPOdvKF3jtFGifloE0z/9jW9/dXxmq0df8SrxXbtKRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqW/zm8O1cZ94t3/d/nkkPXPOwbOPmcfD2HxjaVJJIk=;
 b=NqD+LPfyFa83Y8JGGygjRKefyK37FH915a2i05xB36Y4SjQgUiWwpRXOb65w4jJT+i3tmvTBqJHtX+kqrO6HMnGRv+4nPIAPxvnk0Nti/4RAlAEE0tkcFFouVJVYdLYWeXXvarQCBjzLZD18wDxtQEQLwGogibUSJ6HyrgRqIRozdOEq3FAdzYBRnxr3tW5X2JFkV3c8/X4Yn9K22ZRoVsJBaXAR6d9QCCQDoCcDNgAEHDhTk39gZjpKXqUIkeR+NnHrzhhPPZPoprtVkBbFpzyGPP2n3GhwfHAaPgma+0d2bUkHXEwK3yiYuCTx9KmcTpF144coX4E4u3KLP/5KRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10191.eurprd04.prod.outlook.com (2603:10a6:800:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 15:46:34 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 15:46:34 +0000
Date: Tue, 6 May 2025 18:46:31 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Meghana Malladi <m-malladi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Simon Horman <horms@kernel.org>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v10] net: ti: icssg-prueth: add TAPRIO offload
 support
Message-ID: <20250506154631.gvzt75gl2saqdpqj@skbuf>
References: <20250502104235.492896-1-danishanwar@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502104235.492896-1-danishanwar@ti.com>
X-ClientProxiedBy: VE1PR03CA0037.eurprd03.prod.outlook.com
 (2603:10a6:803:118::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10191:EE_
X-MS-Office365-Filtering-Correlation-Id: f65633ee-8973-4789-4cfe-08dd8cb52dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HaO/wSGbBBIPksv6nKDN8NKjTnCLFw+FkQVdNrNKVsl2QwX9wkLPhnW01obV?=
 =?us-ascii?Q?KrZxlaETWFXKdhBAwkNC8wYkH+vhBmkYA4bfe77+9dsSQLyB2SZjze+cSTxI?=
 =?us-ascii?Q?uPPkOnFdnA1z3OZJBB0KLCL/sxrKsfmq0kcdQ3cO4ssr/QMs4oDvSb8jWQl0?=
 =?us-ascii?Q?IutsIhrwSI6UE4kgTZI44jeaspB5Nt1o8kX57h5NVhtrzmEEcgPGJEtOm4qo?=
 =?us-ascii?Q?5mlNRPfu9ywtx7Akg++3SxSixf5EjBwpqLbEZtN14LMyWmTaDvJ2aHWzfSNu?=
 =?us-ascii?Q?AIslL6UZBpGrAPScHnUXWwrR0cVH2hhQEd/LHStYkeiyxtWSc1HgA3Fj08aG?=
 =?us-ascii?Q?TmxqhZD9PoRHAGoQc/p5eCu8aPDbXykMYRPDl2dM7bDOoWZG6z/rT47HiE9W?=
 =?us-ascii?Q?nBM69+Vb7wnPZLnHqMnZQbZAg8xZnb7ys5E598XruUB0Ho+WFL/cUYKP34aP?=
 =?us-ascii?Q?/AtSBPoXnc1ekiRf1rXWppTeww07fRSSbmmXoPzmYq22RVWqXYcb+6mpNKb/?=
 =?us-ascii?Q?yK2AKtYytRGYSvOAbB8UxfpLBpcy8LsnLfj+pTz+V2dZsrCwgASE+z4YPc//?=
 =?us-ascii?Q?o7tktwQDgYzHYLRHACkG1a9AiUqyvPFwdw57sAay8yYgsUoprIk1VjDcNSwj?=
 =?us-ascii?Q?jxNbyhB6f1EOkDC/ZORIVRpfgtspoJnbMNQTnxa8tcXVMpFSQl3BjyWFjTto?=
 =?us-ascii?Q?Q7HsSraIps1i3LSTC+feZ5YEhHm70oCPePo8fcuzW3FJpDiiC5tyvOzf5kvt?=
 =?us-ascii?Q?/hxSCxxUvLXsanFPkf5hJxHAVc/zqZFPPMKqerOzJLzgFwSAfEFN5WSNG6ie?=
 =?us-ascii?Q?Vxhd7O+eZ/4OVn4qQNZwEIBeN1qs6OYXiowsQq+A4zYxhGBwkqokHwT8NdMw?=
 =?us-ascii?Q?I5I7N74q9KO50G4gC+O90AbltdZIZV8SHGEk6aEATw8/KUnZLgWHYh25XbKm?=
 =?us-ascii?Q?jj/GUbVfW2Vx+5ufaAwPkOeuuige8EgfR5G4hetkAPAaG6XjMIxBZo08bEuy?=
 =?us-ascii?Q?0WPQjxizkujNu+diqeY0FE8pbltKV5FB75XnMPbyhcuwpabEa0G/1Yj6jqFH?=
 =?us-ascii?Q?MNg2cRpDR9G0g8bl5eHyLmDlZ6IqwNJOycWeAU9J52ZTJzREXUDaP9SoAE03?=
 =?us-ascii?Q?OTVAy5N760xAsabALBv0bQjHAab+And+9eFbiCKmP4pPUOWzkmYwzivdnARy?=
 =?us-ascii?Q?dG7iEzi9LOIP1r+2WX9qWbaNz9D5R48vv6Q0HWMq+cmDQHvTW9BdtPwxaoiY?=
 =?us-ascii?Q?cvVPdR2RzMl6+2sjytN7iVBvCObHD/y0H8wiTVRjazpZvul5NX9CyheIYMA9?=
 =?us-ascii?Q?+CXjYRoPO8G5UztYx+iUbIuWYAmMsJXajVTg/rpPxMnrHGcGefG/B//mO1KF?=
 =?us-ascii?Q?JPAyZPX9XRydsSYf83mkBufSsoFciSeZpncNdjgz95VYg1RO5eGUm6Woal0Z?=
 =?us-ascii?Q?OBjsRAjATMU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wn3jOfmSx+0vvI735bGOg5uivD6dzPD2DvqCLKxassW7uE4knhVvGAOtfrC+?=
 =?us-ascii?Q?lC3p9xg8wIge01G1NHy6Z7APrpGo468Q/bJ7sxcP8ImNwAtdgxJLPBxNZuh0?=
 =?us-ascii?Q?tnrPqNfnkYD9lqTv8wTDKldINwmbblTDr6wQdg3GnOgP1HhR84p0bjgoADYL?=
 =?us-ascii?Q?jxKqisqubgY5dnjHGORoLBxLGeO+u/dEzwZrDcQtrI2gX8X4veZyLUjagJ2V?=
 =?us-ascii?Q?oDvog7SA7nWu+N9m8Ut/rdNMNcP9AL/yfj/e/PspT9eNDbActPtDvKrP0Wrb?=
 =?us-ascii?Q?uDM/Gh3ti11JZQOfuoz/Yl+CXWrm2T9vH1bxMQ6i7f6WV6eeQ4MYHjvIAl+M?=
 =?us-ascii?Q?rhxxubcoTAt5nA/5FCJdwVq5iT/AWplNMinVtR+KkaxBmour495Br/cA6vle?=
 =?us-ascii?Q?Of7Om6EI4aGO/hTa7wkhkNdOzEsctdTWdRT6ZpYLMjQD9xdHcSussuoZSHDx?=
 =?us-ascii?Q?sSkPyOh4EFZUYWk9IKldvHOadYaXEf4gEt+LPXWIh9ZWxm5SvWpYjDhF20lc?=
 =?us-ascii?Q?j2Zut6+KPTr0Z/fTBArPl08OFhhGexdF0oP21dHwoiefZBYocHdWlBf5lKqJ?=
 =?us-ascii?Q?pqbB6KuDumUgHJXptxnhG6IyQgWmYdBdAPEUUuZ87swB1F4bmta0y1w0U29m?=
 =?us-ascii?Q?wRWyDXKG6u2zGzbKUiBNeXM9NREh5zfSV9LxNyC5wAd6qlr0oA7tOYyN6Q4g?=
 =?us-ascii?Q?ekQywaCMcopajAY827rQR8WGhSLmNkDNnnQMUlWmMehcyjgYMhgIcHFV+P85?=
 =?us-ascii?Q?UkqDrHTgow5QD2FhqK/a8g9uAXTrV8Xj67/5L63Eb5lW3cmEAKFCUoUpJ+pq?=
 =?us-ascii?Q?xomgjyYLQLvPWdGukSlwBpafTa/rau8+NJXapt+zDdEXj6yCindQVYDiq2o1?=
 =?us-ascii?Q?E022NHxwM7zn2pEItsPXh9Om5G6oJQ14PFwa2yVtN8M24woA8Ilz9072nhpp?=
 =?us-ascii?Q?nzZeHQ3nsMz4nkA9vA3SGSKBQq6K0+kAFRhEnaDiwAOAZsSDugl+69U9rKtl?=
 =?us-ascii?Q?itBIJ9nGLnzOh1j5aRHKHqnY8+4anUdPSWct5LG4IcxY526knx51oY1FVL2Y?=
 =?us-ascii?Q?NOD+7njUEOJZ2KkE7liQ3Z815YWR6nQTHPWOLwNp4VCDHdAwbG7+OaPh28xk?=
 =?us-ascii?Q?zk4e4ocy6kuFRhTctML1kummi/6Ol7rCB/BNyWl3eDZU5fyIAw+MuOmpSvs4?=
 =?us-ascii?Q?hGdm3xB1OU30mX6X1Ft5c6DnUFfwXsIO8HBGWfZL+RGJk+W4crMuCaR1VYYR?=
 =?us-ascii?Q?redvJ3obT8nn41v4gaoEbXRzyJxe+96bmNrbBDSB1PH13+1/dTuE7LZX99Nn?=
 =?us-ascii?Q?OixtChYsEASaCCh76PYpJ+WqzSaVtzc7F66Od9m0uWDNQfVR+vhZGXpWBZyk?=
 =?us-ascii?Q?b/6nBngULXkX886pNmA2i73uOpZqchm4Glz2Pj6xW+qGTRwejngRrLu9FXLC?=
 =?us-ascii?Q?VOnXunvTSiTiL2AaMj69QRi1hd3E0BpnDoogpCDSNvcfnK86Hv7s6aFX/mtH?=
 =?us-ascii?Q?fUn04jFWFQrmq3rduRBIci/mbU11LPWm7C2QJbhtgLVhvcgCuPR5OqCUo2V3?=
 =?us-ascii?Q?REr6muqNyiSxch8IVkYaAygO+MTTb6e7mFQbFGxLFvrcTKxX8tGpmmH5qLJL?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65633ee-8973-4789-4cfe-08dd8cb52dc7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:46:34.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXqyGqm2wL+pv0Tl3s3JiCI5XOsJWGRh45iA7gKXnhb2K6rrSrjIW1acSHts3P7Kx7MRcRP7nnqoKYSsPxe5ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10191

It has been a long time since the last posting, everything has been
swapped out from my memory. Sorry if some comments are repeated.

On Fri, May 02, 2025 at 04:12:35PM +0530, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> The Time-Aware Shaper (TAS) is a key feature of the Enhanced Scheduled
> Traffic (EST) mechanism defined in IEEE 802.1Q-2018. This patch adds TAS
> support for the ICSSG driver by interacting with the ICSSG firmware to
> manage gate control lists, cycle times, and other TAS parameters.
> 
> The firmware maintains active and shadow lists. The driver updates the
> operating list using API `tas_update_oper_list()` which,
> - Updates firmware list pointers via `tas_update_fw_list_pointers`.
> - Writes gate masks, window end times, and clears unused entries in the
>   shadow list.
> - Updates gate close times and Max SDU values for each queue.
> - Triggers list changes using `tas_set_trigger_list_change`, which
>   - Computes cycle count (base-time % cycle-time) and extend (base-time %
>     cycle-time)

Please define the "cycle count" concept (local invention, not IEEE
standard). Also, cross-checking with the code, base-time % cycle-time is
incorrect here, that's not how you calculate it.

I'm afraid you also need to define the "extend" concept. It is not at
all clear what it does and how it does it. Does it have any relationship
with the CycleTimeExtension variables as documented by IEEE 802.1Q annex
Q.5 definitions?

A very compressed summary of the standard variable is this:
the CycleTimeExtension applies when:
- an Open schedule exists
- an Admin schedule is pending
- the AdminBaseTime is not an integer multiple of OperBaseTime + (N *
  OperCycleTime) - i.o.w. the admin schedule does not "line up" with the
  end of the oper schedule

The misalignment of the oper vs admin schedules might cause the very
last oper cycle to be truncated to an undesirably short value. The
OperCycleTimeExtension variable exists to prevent this, as such:

- If the length of the last oper cycle is < OperCycleTimeExtension,
  then this cycle does not execute at all. The gate states from the end
  of the next-to-last oper cycle remain in place (that cycle is extended)
  until the activation of the admin schedule at AdminBaseTime.

- If the length of the last oper cycle is >= OperCycleTimeExtension,
  this last cycle is left to execute until AdminBaseTime, and is
  potentially truncated during the switchover event (unless it perfectly
  lines up). Extension of the next-to-last oper cycle does not take
  place.

Is this the same functionality as the "extend" feature of the PRU
firmware - should I be reading the code and the commit message in this
key, in order to understand what it achieves?

>   - Writes cycle time, cycle count, and extend values to firmware memory.
>   - base-time being in past or base-time not being a multiple of
>     cycle-time is taken care by the firmware. Driver just writes these
>     variable for firmware and firmware takes care of the scheduling.

"base-time not being a multiple of cycle-time is taken care by the firmware":
To what extent is this true? You don't actually pass the base-time to
the firmware, so how would it know that it's not a multiple of cycle-time?

>   - If base-time is not a multiple of cycle-time, the value of extend
>     (base-time % cycle-time) is used by the firmware to extend the last
>     cycle.

I'm surprised to read this. Why does the firmware expect the base time
to be a multiple of the cycle time?

Also, I don't understand what the workaround achieves. If the "extend"
feature is similar to CycleTimeExtension, then it applies at the _end_
of the cycle. I.o.w. if you never change the cycle, it never applies.
How does that help address a problem which exists since the very first
cycle of the schedule (that it may be shifted relative to integer
multiples of the cycle time)?

And even assuming that a schedule change will take place - what's the
math that would suggest the "extend" feature does anything at all to
address the request to apply a phase-shifted schedule? The last cycle of
the oper schedule passes, the admin schedule becomes the new oper, and
then what? It still runs phase-aligned with its own cycle-time, but
misaligned with the user-provided base time, no?

The expectation is for all cycles to be shifted relative to N *
base-time, not just the first or last one. It doesn't "sound" like you
can achieve that using CycleTimeExtension (assuming that's what this
is), so better refuse those schedules which don't have the base-time you
need.

>   - Sets `config_change` and `config_pending` flags to notify firmware of
>     the new shadow list and its readiness for activation.
>   - Sends the `ICSSG_EMAC_PORT_TAS_TRIGGER` r30 command to ask firmware to
>     swap active and shadow lists.
> - Waits for the firmware to clear the `config_change` flag before
>   completing the update and returning successfully.
> 
> This implementation ensures seamless TAS functionality by offloading
> scheduling complexities to the firmware.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> v9 - v10:
> There has been significant changes since v9. I have tried to address all
> the comments given by Vladimir Oltean <vladimir.oltean@nxp.com> on v9
> *) Made the driver depend on NET_SCH_TAPRIO || NET_SCH_TAPRIO=n for TAS
> *) Used MACRO for max sdu size instead of magic number
> *) Kept `tas->state = state` outside of the switch case in `tas_set_state`
> *) Implemented TC_QUERY_CAPS case in `icssg_qos_ndo_setup_tc`
> *) Calling `tas_update_fw_list_pointers` only once in
>    `tas_update_oper_list` as the second call as unnecessary.
> *) Moved the check for TAS_MAX_CYCLE_TIME to beginning of
>    `emac_taprio_replace`
> *) Added `__packed` to structures in `icssg_qos.h`
> *) Modified implementation of `tas_set_trigger_list_change` to handle
>    cases where base-time isn't a multiple of cycle-time. For this a new
>    variable extend has to be calculated as base-time % cycle-time. This
>    variable is used by firmware to extend the last cycle.
> *) The API prueth_iep_gettime() and prueth_iep_settime() also needs to be
>    adjusted according to the cycle time extension. These changes are also
>    taken care in this patch.

Why? Given the explanation of CycleTimeExtension above, it makes no
sense to me why you would alter the gettime() and settime() values.

> 
> v9 https://lore.kernel.org/all/20240531044512.981587-3-danishanwar@ti.com/
> 
>  drivers/net/ethernet/ti/Kconfig               |   1 +
>  drivers/net/ethernet/ti/Makefile              |   2 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   7 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   2 +
>  drivers/net/ethernet/ti/icssg/icssg_qos.c     | 310 ++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icssg_qos.h     | 112 +++++++
>  .../net/ethernet/ti/icssg/icssg_switch_map.h  |   6 +
>  7 files changed, 439 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
> 
> +static int emac_taprio_replace(struct net_device *ndev,
> +			       struct tc_taprio_qopt_offload *taprio)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	int ret;
> +
> +	if (taprio->cycle_time_extension) {
> +		NL_SET_ERR_MSG_MOD(taprio->extack, "Cycle time extension not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (taprio->cycle_time > TAS_MAX_CYCLE_TIME) {
> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is more than max supported cycle_time",
> +				       taprio->cycle_time);

It would be better to also print here TAS_MAX_CYCLE_TIME, like TAS_MIN_CYCLE_TIME below.
Also, looping back a user-supplied value (taprio->cycle_time) is IMO not needed.

> +		return -EINVAL;
> +	}
> +
> +	if (taprio->cycle_time < TAS_MIN_CYCLE_TIME) {
> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is less than min supported cycle_time %d",
> +				       taprio->cycle_time, TAS_MIN_CYCLE_TIME);
> +		return -EINVAL;
> +	}
> +
> +	if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %lu is more than max supported entries %d",
> +				       taprio->num_entries, TAS_MAX_CMD_LISTS);
> +		return -EINVAL;
> +	}
> +
> +	if (emac->qos.tas.taprio_admin)
> +		taprio_offload_free(emac->qos.tas.taprio_admin);
> +
> +	emac->qos.tas.taprio_admin = taprio_offload_get(taprio);
> +	ret = tas_update_oper_list(emac);
> +	if (ret)
> +		goto clear_taprio;
> +
> +	ret = tas_set_state(emac, TAS_STATE_ENABLE);
> +	if (ret)
> +		goto clear_taprio;
> +
> +	return 0;
> +
> +clear_taprio:
> +	emac->qos.tas.taprio_admin = NULL;
> +	taprio_offload_free(taprio);
> +
> +	return ret;
> +}

