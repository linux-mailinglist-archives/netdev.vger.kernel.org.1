Return-Path: <netdev+bounces-182159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C727CA880DB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C437B1749B7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B61F29C32A;
	Mon, 14 Apr 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OzJoXIJX"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82C2BD5A6;
	Mon, 14 Apr 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635176; cv=fail; b=BFf7MzH2DjHbwWqXyNItRyvLLccweuSgVwg8K/P9NuHCVRg682gaEnpDvHzXJx3488dsReJJxruemp5sKlvayyAl78cBGOxc7RPPjgcxNos27lW1+J9vJCNAlcAWaWtOl2RmY6wszjQO11NgQf2FWX9ctMGdH2zK/5ADjH3dlDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635176; c=relaxed/simple;
	bh=1zIyYAVsDMzg9oMuQw6tFwTJTLWVBKD33AXLSHUImBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ek5iQn8/lOFr/NVi74/5EQ2f9ehuNrYqnVYQ7z4Ycq8vyzaW1KDyY0C+2NfG2Kasp8Kq1oJk6nUsOEv0yqntMWFHPFcWJEWB9kVRi0AbsdGPMB0Q0o7VHY8AxaoWOk1O3pGdS6rkCnTfsQngiCMIvMGI1qpEKK+IOddEWJ0bmW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OzJoXIJX; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKGLeJ2ZUJugsSK+7IbU8NO4irvsZKQMmDOlmGKJBaCFhpR4k+rlHxXslwspxi9jbqilDyElwE0g0sE8851awr8LyGzznKJx5Iw/WjbptOE13NX1xyPwjdfpUlZfLQxmJpuUoQKEZk+mDQVkP7jhv7ACwYHxifLtZb6aAcu1CUp9MHpr20Sys4THLinNTxSJs204EOFVxe2Bzn+fIsksUA5UJGq5ixEZ3fmLaLUoDgMq8L6U56XRaWm3tkVjJzW5VucafI9ha50gzPsucDzxOF92zK23wvOHn1QUalJ7M0BZMc6RzMOMV0hw5i9/y0B29AbxKB67JQJ3Ym+s6nqRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuavfLqxYO5LcOrU4tQIen8hEJMS35/rJohzkF/NS4E=;
 b=GRlw9QuZcrr2PdFa9u0zmwXJj3PEOHBrVq1qPDw8PMd4Ri4OFqoSdmWABtkvTBa9sJOMxQG+BMvx67ILK9uGTF3GQzeDwzZ+m3cBdFRNF8s2FvzYlK3PvJLcSjVqC/C/9iTFo5xg6GjKu4xAVVsAuz45c5R900BTcGvmL8dKU9pwU070hGdlHD00nSXXMxWUKg03O+m5E1DI8Y7C4VwlAD+vxVRXK9mprS6Ee93N4r9U0Rm3dSPy6/ZVtNPt/QsKpqXZtKSlX/m/PaKos9vx+RfpG9uZb4/OHdQUzLJLkKpgowGig1eOI8RE1dl+LSnZsH+bE9S46UQkpVP+k/OnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuavfLqxYO5LcOrU4tQIen8hEJMS35/rJohzkF/NS4E=;
 b=OzJoXIJXqepfkyWlvLbIJ/OBDtMz8QzKiSqeUtbcmJR6/DWGgmlQJc0mO9FWHHJl9zS7oHQEySLqRN9ULCin30wWUUovufqBqFzbH0WrUMwjoyzfOZfsTz/NQL2LG64hKYRMORlvThC6xysgrlSxuQRlu4O5R2mL7Pbme8ZCPo4YnmOtA6+2fWTk7xSdW0UGMx0ft0he6UgWJW5VLwpCV1En3naHeXOBvP1eRtg5odHvEzBlNxgkVAZXbGGqDgyD6SwLHpX/C1Sn+WT0jxJ6H2VvHqXDPUwJU/QbrZXv8NyUq0hPuESN2bVzGKSL8aA+zxDpIu1VD/LMcm1ooYNUwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 12:52:51 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 12:52:51 +0000
Date: Mon, 14 Apr 2025 15:52:48 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net 2/2] net: dsa: propagate brentry flag changes
Message-ID: <20250414125248.55kdsbjfllz4jjed@skbuf>
References: <20250412122428.108029-3-jonas.gorski@gmail.com>
 <20250412122428.108029-3-jonas.gorski@gmail.com>
 <20250414124930.j435ccohw3lna4ig@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414124930.j435ccohw3lna4ig@skbuf>
X-ClientProxiedBy: VI1P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::6) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: f4577aad-8b64-4b64-d63e-08dd7b5343f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kLTjISv/k+zVV0jGKMJYDwugtk0F3nXUAdnSRO1kfMUEYAH4iLWg/qCcSCgU?=
 =?us-ascii?Q?wyn90CG2RXVSo8Ft9UbSLT8/rZzdfkQTrwjwvkIZC1ims1IqAbGqQ7MJJLHQ?=
 =?us-ascii?Q?Ui6LJnBj6D2znle+iKtxwOfUfAHhkA6pa1ItQnhWxRNEKzgyB3qpvkanJF5Z?=
 =?us-ascii?Q?APhQzdc1BUa5UNbw6a8+5Htg+STGFw1ofBimvG/o6R0BwIPsmMU0Ibz8Hafa?=
 =?us-ascii?Q?CfWLfmn9Chgjdw2FJhAmv+UYxBQ7XU5GgOHdKg8SSHvmP5hm4120zSN+dTUx?=
 =?us-ascii?Q?x885tphR/4GJ/PP7qzvmH+hB6cH7VieOAbvqXcmAf94gtnjcZRPVxIsFsD0k?=
 =?us-ascii?Q?z5LspjHm+YsPRj12XZrrVQ4w0qFzgeFI8xc3TQXKaCTF8vM0hsc29J19TWT3?=
 =?us-ascii?Q?vB8irKQ+9B96/o1MIPR9h3ChUmx4TVGl0Cc+DeU2MefSMdnM81rDLr5tt6RE?=
 =?us-ascii?Q?nhUt/ZqsUk3L1d2j+L4f6vS+pwsUGJtqeL6pZINulc/CWdnRtE/pgV2/PEEe?=
 =?us-ascii?Q?it3NRS8LlhHL7Iv7miQd2bFzHKQvyY8NdFq7Z+j+i22pOLm88zcGDg4XE+Fk?=
 =?us-ascii?Q?reKPqD5v27Rn0q+NzNlkRPDjoWRMnEp3q/dkBNdlzVNW+5cj/Y+tRf0RyVHe?=
 =?us-ascii?Q?KduMnomKtUorxOg+VCuis4aeD7K2niiBrIM5oKjof7t4qxk0rNLOVFiM5uYG?=
 =?us-ascii?Q?g5HpYYSoung3tZWHWB+EG+H2PnFBjx8UAIU8Z8OvOHRUBGn2rI09Imo7zH8+?=
 =?us-ascii?Q?PDneGemS+I2fTXPwQ8tgv8vNBXC0I8on/fxuR7QdWrUpAZ5zUxzKsQfwTY53?=
 =?us-ascii?Q?kW0nfBJSwoBhWohYRCVOz+CyikU8mhy0skkuucYAIw0zJQy6pGPRGoGnFf3+?=
 =?us-ascii?Q?OBKwLUwBlc7A/lHl2mYtpVqVjGBLk7q8T2v3ls05WUveVFoySHxgBE2sB2md?=
 =?us-ascii?Q?QmYgC8OLc8efVhE0ogQ5opGR78L7IMfyitlafgT8GA/HLe7HcAc/gVA5vGYI?=
 =?us-ascii?Q?l1K0QSOb/zOHHublsV/YegAPkgWZ5qLSNlwzfvHmhBxgzDvRMB0TlNEDTSxm?=
 =?us-ascii?Q?4eHeLPXFYpDrmjdK1VBKIn9aiBbMZNe0/7u4BCxYSR2fveTZoTrPyRmWhPek?=
 =?us-ascii?Q?phVQeFBG0RCVKHnYq5JZzhd9cYgw2CIOxzgmRWnqvXQ1/f9dNtpXZzMztLvq?=
 =?us-ascii?Q?NFdGREnDbFGzGCsXzrRyS+zt68C1dJwbqoer7WY6t/uF2iypZ9xjejpGb21L?=
 =?us-ascii?Q?0eIMLyezth35h4r4vKH+8HGFL8nKdOuUe5a2ymrvoAqlIeehi5QBoGm8LhGo?=
 =?us-ascii?Q?8FGdAp85Vqo9KzgaXYn0160x50d8RAgaJ6t4i8Shct+5L+q31YZCnFyLf0w6?=
 =?us-ascii?Q?z5KvMI7VrhwmnI/+dZMo2mY5+4vHTvZyudb32jOJ49Rvz3STyPPKafoeh1nr?=
 =?us-ascii?Q?kyq6+AQDBb8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?91lEOfbP49fFBkJKQlKoV4ye/OCpcspdrDNew/hRcicuIM/uJyJjn3nYvBRl?=
 =?us-ascii?Q?5tBGYn4NDEiHGtMAKwDPDHEV1H3LMjGZHzPkRpZa+j/SiFgQpTzlvHwybC+n?=
 =?us-ascii?Q?9sIqrxY0I36Q3a+oMhnxJu76yH8xzBMPK0yhnTYL5BuY8Z+99Gms3t+Tzz0h?=
 =?us-ascii?Q?es6zKscdczLyPo63V9a/MsAMLsWC1naeuInqyViy8D0mdVvs6vkbjKe5F005?=
 =?us-ascii?Q?bg52ilLhDwsWsaEgHN0ipr8q4l3STv3YJGuunTDBS111eapkQd7/FfeXqkuI?=
 =?us-ascii?Q?h+Y43MNv1CHrZhftmRU/USs1cjqBHH0AZtkwEYqJ6rIJW9Fy7WLKqYH3zk0i?=
 =?us-ascii?Q?e+vkEhOdTNeCrJZ+G6vio8mz+/f44Tjr4kNDflwwRqvJH+inpexRKVcWNaRy?=
 =?us-ascii?Q?OVGHdOzqkGdpkT8ndCkf3hxs2YOLWB1SaTbc0rw/it3Xg8ksxZa4QBErrHtp?=
 =?us-ascii?Q?lmD0dVBA4w+rJjiT2A0QqRJc1pKLChzOLdno/Divj6NZ8r/CBc7v04M8OWwK?=
 =?us-ascii?Q?l3EzrVBeDr0qMbKZefNJHY6HD9ODVvGJHWORbww9gG2nsaH2cGEvbAbWQEYg?=
 =?us-ascii?Q?nnYfYbgIt1M9gOyXoDW8ez9wVq6aB4FRmde7m1N/wwZkpmKdfvyA7OYsQOfY?=
 =?us-ascii?Q?QVhIcrx5bnp/N/7WQh+83Wx5DO6wRuSAKCrqYAUt+ML/5IH4+iuWsITZcbf5?=
 =?us-ascii?Q?R7aMK4lj3HglJkSNn3n3fiCI6GlUd2avk/bq7htlou1ufGLYzexUl04dpcAv?=
 =?us-ascii?Q?VHnlv00CLFBMnbibtWgsu1M2wFp4fesUfn0JJMlAbDLV8kMj32sMhCg8HekE?=
 =?us-ascii?Q?ECdIOBDr/g5Zj/jIzNLeshqB3M8qEwK+7iv+WeTPway1c2N1g0aZELR5tr9M?=
 =?us-ascii?Q?xvrXYTSGso++55UIH5wxPFYqxNIgoelyx0AAGiIy9mhLK3tgG+yVlyRJIVDm?=
 =?us-ascii?Q?dGQF89ZgDqW0ULPh/EVgL3v0PurjNdhtvR61lnoMP7sGoVsfbW857FqvBxwN?=
 =?us-ascii?Q?yrckGKQzdlagSBmSPZZHaUcj1Ccix99S6WlPV70AiHXRZqmyjxvpbKL2hjA9?=
 =?us-ascii?Q?ak1TAj5fJvG/CXR1Kfp9mAPtHfBy132cUVR5RhPKczdl6gZolMg5uPFybc4q?=
 =?us-ascii?Q?fiZPI+7Q7fMfcBjVhyf3xSIG3VlK8PV0yr4Rtjg/YNSRNuOEyKt5nz1mKBwc?=
 =?us-ascii?Q?Nx6uJHso50ZphYync3rPEVHeD5R5z/6pFWpinqulr2qOYRKWW+f7VfJa5QVl?=
 =?us-ascii?Q?jKdnSuqWLPA6bJk7aP/30ou2ACdUUredb8RpZvoM90Sai4NydqhxKjgYy3Of?=
 =?us-ascii?Q?H6ZP2o6Au13geEebg7fR8h7uno4cgCmKKE5/uftJ7E1UuPF5AdQc3iwmkNO+?=
 =?us-ascii?Q?H+fKSemsmSkL8SFxT/40edIy+BeLbrrW8hBHC62/fDseQ3dhKt9Ay2fFA1NL?=
 =?us-ascii?Q?K2aL532a4KxCgcSvPJOA/R9lWQIoKimH3HTO4tx3ppVXjQkp2aqfiA7O2gsT?=
 =?us-ascii?Q?rh2dAIWhN39EPQkrgenzfI/oUMG+2EMIoF3/6kzXd5eiecz+CQm6NzuQb1xm?=
 =?us-ascii?Q?yQprz+IAdnkB3RXZ1LoBizSt8Lp5eoV0MgHAKnx4vbP/96SnIuReZov1KgZZ?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4577aad-8b64-4b64-d63e-08dd7b5343f7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 12:52:51.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COuyRzvr6WW1Oq3p1KkU9XpAyCtl9ydj6z3EkISRK1dWEJw84ImKKIvTQgDX0J9N0VcDbupObteAzq0z6egF3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8897

+Jonas, whom I've mistakenly removed from To: :-/

On Mon, Apr 14, 2025 at 03:49:30PM +0300, Vladimir Oltean wrote:
> On Sat, Apr 12, 2025 at 02:24:28PM +0200, Jonas Gorski wrote:
> > Currently any flag changes for brentry vlans are ignored, so the
> > configured cpu port vlan will get stuck at whatever the original flags
> > were.
> > 
> > E.g.
> > 
> > $ bridge vlan add dev swbridge vid 10 self pvid untagged
> > $ bridge vlan add dev swbridge vid 10 self
> > 
> > Would cause the vlan to get "stuck" at pvid untagged in the hardware,
> > despite now being configured as tagged on the bridge.
> > 
> > Fix this by passing on changed vlans to drivers, but do not increase the
> > refcount for updates.
> > 
> > Since we should never get an update for a non-existing VLAN, add a
> > WARN_ON() in case it happens.
> > 
> > Fixes: 134ef2388e7f ("net: dsa: add explicit support for host bridge VLANs")
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> 
> I think it's important to realize that the meaning of the "flags" of
> VLANs offloaded to the CPU port is not completely defined.
> "egress-untagged" from the perspective of the hardware CPU port is the
> opposite direction compared to "egress-untagged" from the perspective of
> the bridge device (one is Linux RX, the other is Linux TX).
> 
> Additionally, we install in DSA as host VLANs also those bridge port VLANs
> which were configured by the user on foreign interfaces. It's not exactly
> clear how to reconcile the "flags" of a VLAN installed on the bridge
> itself with the "flags" of a VLAN installed on a foreign bridge port.
> 
> Example:
> ip link add br0 type bridge vlan_filtering 1 vlan_default_pvid 0
> ip link set veth0 master br0 # foreign interface, unrelated to DSA
> ip link set swp0 master br0 # DSA interface
> bridge vlan add dev br0 vid 1 self pvid untagged # leads to an "dsa_vlan_add_hw: cpu port N vid 1 untagged" trace event
> bridge vlan add dev veth0 vid 1 # still leads to an "dsa_vlan_add_bump: cpu port N vid 1 refcount 2" trace event after your change
> 
> Depending on your expectations, you might think that host VID 1 would
> also need to become egress-tagged in this case, although from the
> bridge's perspective, it hasn't "changed", because it is a VLAN from a
> different VLAN group (port veth0 vs bridge br0).
> 
> The reverse is true as well. Because the user can toggle the "pvid" flag
> of the bridge VLAN, that will make the switchdev object be notified with
> changed=true. But since DSA clears BRIDGE_VLAN_INFO_PVID, the host VLAN,
> as programmed to hardware, would be identical, yet we reprogram it anyway.
> 
> Both would seem to indicate that "changed" from the bridge perspective
> is not what matters for calling the driver, but a different "changed"
> flag, calculated by DSA from its own perspective.
> 
> I was a bit reluctant to add such complexity in dsa_port_do_vlan_add(),
> considering that many drivers treat the VLANs on the CPU port as
> always-tagged towards software (not b53 though, except for
> b53_vlan_port_needs_forced_tagged() which is only for DSA_TAG_PROTO_NONE).
> In fact, what is not entirely clear to me is what happens if they _don't_
> treat the CPU port in a special way. Because software needs to know in
> which VLAN did the hardware begin to process a packet: if the software
> bridge needs to continue the processing of that packet, it needs to do
> so _in the same VLAN_. If the accelerator sends packets as VLAN-untagged
> to software, that information is lost and VLAN hopping might take place.
> So I was hoping that nobody would notice that the change of flags on
> host VLANs isn't propagated to drivers, because none of the flags should
> be of particular relevance in the first place.
> 
> I would like to understand better, in terms of user-visible impact, what
> is the problem that you see?

