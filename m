Return-Path: <netdev+bounces-216539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF73B34668
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F262A45B0
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658E2FC028;
	Mon, 25 Aug 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iZt8kLGG"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FC2FCC02;
	Mon, 25 Aug 2025 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137365; cv=fail; b=pNAOufqnqQ0EM8G7VxvRgrejSEHnRwm5XBDsr8vtUrnoI8T40eZMZ+yZmzqK9Sgn3ciRTR1zfz0jdnsHYgWGZKXVxW9x1De8RfTdSiICnzfIEf9ADdlL2je+vm6Ta0Fm93M3q7TLIj+SVGSoSw1ECeNSI1ehONXnMZsmDViKmZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137365; c=relaxed/simple;
	bh=U5Fm+swSWY3TmRnBl3+HoiWlTiw9wfTXJB/Oss5/4Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lbq/7qlL0KBaCeMjzuCjUcSxI9732bfKf1tQhajp/aKqskVMdPlsvQKvGhC5rjijvmTuEBMeDwJ7kN1viTlj4CJffuSIkZx2UU46hgTTfioKqlWwU9B4IjCgdiK3KARUXpQkQeHul2UNw0L36OUjz3QO9jHcJmVojYcVkspbXs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iZt8kLGG; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cds+pnQw4ulCLnUskryRuiqXpD2G0F7Kpk/TcWtknuYA2sI5cEgxpEpdwfof+mrTF2s7sRu3Y4/qdoAMplTHr3yMIpVUu29ipdeM8EN7//vtwK12pV/WE8FlVlAEV/K28qT89AZ5j6Cip28w8NcHr56gVeUV1Qhhx2OSBUqCyEJHoW7BENmXHoGrvUdxj/IRMIQX5UDpRVbX2JZtuN4O4jyQsgtcYVkQuBEbKWBSFkTUilYWD70G4pDL4bLlrxUV3D7oxsK7LXmfUAke/irDQp3T5IqdziLVq8WHeK6arjXGhbl0msUoHu76nTcQ6PxPnVx29LjVTeJpWEXvjYcVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cy4+ZxEF2YVrvi8zCUnoWQhVNUcmuP1itsWC2dhuVuY=;
 b=Clw2dVBGiBPJ7wqWVzaUgT0HOnVDGgJpXogAFjy6NU3QMT1fgXVtwC2NLAMfXJRTsEbn32ysp2B6HVfhd1VLhTAA3aorcn6W8r+ofoGWR3K/ohmMK9fRleCvMWSfjBVD3PQMhq/CI5nc/Xwvc05bye20yi2DHkz7EZ27CCUCvOs23NQqeM9VTBaKLkj1dh/GYmtVvcSKOprxvNGb2JhvClTVahT231msYOh3u+1l09WbK9pkcJWK8hF+Lv5+wDWMSK1XiA1cXu1gN5r0gMrPAXbiS+aYSP/0mqwe2OkVXXYpwuNY+wYYESkuaN8mOJSrzi2+hnpUaV7yGvsChAY6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy4+ZxEF2YVrvi8zCUnoWQhVNUcmuP1itsWC2dhuVuY=;
 b=iZt8kLGGj2I0+U2QMPgAsH687ogHhY486Lq+ZFNnmiATlETHZ1bLYcJl5veOuO4aus5JB1zg6LQnHh5VIPnXekKDVzERj6Aoft4qa6LxDI35L1SKZ6tAsf/6/VsWWLx6ZNdpIhCTuDmxsEU629AOyZjAydKRvef3iipBg1uNxJ96X2GiKcJ/FhO0iZXLE0wo5jTdNGQT5uzcA937hE4L3cy8N+kBr/2EXxZVK9xuYWk5oZDber/fz3BLWU20uD1cyJU1YBwQbA2jPf4VdKrNCy7d64ACDqSc14ULYDfLJE8/LTZpeRgp/e4xGAbCi8PRbEuuPCZKHimHblOk5Fmg1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBBPR04MB8060.eurprd04.prod.outlook.com (2603:10a6:10:1e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Mon, 25 Aug
 2025 15:55:59 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 15:55:59 +0000
Date: Mon, 25 Aug 2025 18:55:56 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"n.zhandarovich@fintech.ru" <n.zhandarovich@fintech.ru>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>
Subject: Re: [EXT] Re: [RFC PATCH net-next] net: hsr: create an API to get
 hsr port type
Message-ID: <20250825155556.fehgly3ggkydgbgw@skbuf>
References: <20250723104754.29926-1-xiaoliang.yang_1@nxp.com>
 <20250723141451.314b9b77@wsk>
 <DB9PR04MB92591B3DA0F1CB9CBDE83C24F05EA@DB9PR04MB9259.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB92591B3DA0F1CB9CBDE83C24F05EA@DB9PR04MB9259.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::40) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBBPR04MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: ae954779-4e32-4c81-2289-08dde3efe2a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9hCRsEUuhuEbF7PXBW5c0+ByIMyzJsC+b+58E6PwXXd3da6Ul7xvId+srWOC?=
 =?us-ascii?Q?+1ggOGdNtPJtJy1Gjt8gfNxU6mgPUHBkiM4IiSs3YA/o7esnQmtiOZXE8msQ?=
 =?us-ascii?Q?1PeoRbMV1znSVof6L9VIKCC9kx7iUSk0TNoXL8wq3lQNwvJcJ0EXqRXqXDYs?=
 =?us-ascii?Q?sw9RuurIK32y9ZgzFivmMVF5N8VuE4AKQqffI1Ajpfy9hOsaScFoAzw4oAed?=
 =?us-ascii?Q?eZy/w5laiOwVV74O8FMg5OdqR8gta2oTPHfwlVoAfLeQ7I82ZiaDF0+Z7lXJ?=
 =?us-ascii?Q?o0BmfG4/MgOIdunUrYjg5QiihSmk/sUxYVxsDJoh5AgIEuou4xHBbCxdTWtc?=
 =?us-ascii?Q?Z3kJTyRA39qT8PVmc4TkK9k6rkXN8w6hd8lxGcY23QlBImDSkmt3kOsboPYQ?=
 =?us-ascii?Q?K5bHzyHOFKaVGv5s569AG6z7feYe+0a1/iFjcYKSNOYH956Oyo+7FuVgKPkT?=
 =?us-ascii?Q?UYNDToNpLBLRd3lKckmLyvOTy7PrbnxdEHMTJ96SkINbuHqY+gX1ml0TXRY1?=
 =?us-ascii?Q?JyIV/X3ijLfKe0eOc4LJ2jvIs2IoVzhGihqnnsmNaGeXjnMtLgQpZ2oj9oeW?=
 =?us-ascii?Q?e2y/2btdS7//U0/sj2+Ujytwod0LPzMvhkGLdAuse0vTtgbXyyS5045ZzSFz?=
 =?us-ascii?Q?6nBjvjBPlA7ilxXtLFgY6G/08B/9UsFDCFgOJ+KiqI4d0NY1rxeaKbCLKNul?=
 =?us-ascii?Q?xiL59RgxlRnc0mlwwFBWPTeVcn5y/jQDUuQ447laE4EUB1eMeAO9qr8duQ6I?=
 =?us-ascii?Q?YDl3YGamiWrXSXq3CX5YoWSBWfZde2WI46FkrGdHXHN+I5zZOa4izwLSMhIF?=
 =?us-ascii?Q?5YrSxg8saGQRRcrNRvii16NTNOSDSqXhM7mP+HrpfFsvG0YJhriojtaEoXTQ?=
 =?us-ascii?Q?n3YKSV8U/a91tck6K8OJKaoMeHcBHWomuQUtVMER5UxaDDTyFOfm33pPpiRh?=
 =?us-ascii?Q?8XlAEQmnHFq1zIoNifHE9EaJ2GBZP8mRjzj6ZxLxuMHy7Bhcrn0eLxvpHmCg?=
 =?us-ascii?Q?XprRBujndmje8FwZ1+kc4KkzOHTsUBAcwGWJ1yUt/D1sI4WpiW7Hm1C9LYyb?=
 =?us-ascii?Q?NpwPQ3xS44QEXTWxZfLp/SpEQOGTVLXKsy7W+q8qVzFSui5G95alxQHLGPTh?=
 =?us-ascii?Q?anK2WPiCjCUvWhD9DAWFH26wRxD7MGimXlDnd74a0DkIRYVBlMHgjBxI7v0B?=
 =?us-ascii?Q?YxSnL7/tecXTCTQF0QAxadB7w/XjNNLo2Hzo6J8eMzNE+PiAW8YFqKME/gzd?=
 =?us-ascii?Q?6DDcTfqFEUcmWwSQq5IxQQXI/PeokPXM8eUukLKlQKSH9lvzJbVzdseNR330?=
 =?us-ascii?Q?YYR+lHNtnyB4EPxarlIgRLCdeZiFpn8nkR46y57fvlvSCjaz0WroLqgc7mb1?=
 =?us-ascii?Q?+8mSurk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?npBj1yApserHBLZ5jC3iK0hDIv0eYBRdp1/x3idLTMG+Zibdyq137FPmkAg9?=
 =?us-ascii?Q?rUn7KRG7Gc6mUro1Cv+s/FlMK8t6Rl9yU7ZgvROQ7ANhmchnx09V56stLE5J?=
 =?us-ascii?Q?PCmAMjqTDLQkrGju2O5usEUlKTMeFGtBSiV/Se2vfCTzsUdm++42W+6UmgyX?=
 =?us-ascii?Q?rChZjNkQe6MHYR7kZNo9SpIIUwvYGxPVlU78B1Snk9XaQrcH56AeRmNu67n5?=
 =?us-ascii?Q?QLE7xb/WgEb4wtMOSPumBqoEcIYzQAMWfI0isr3KQPw0cU4qAcGXG/AGUyKJ?=
 =?us-ascii?Q?XDkExP0FieI8vglSfhOeSmvJWIFmIWw99HxdBO/Dp/PmQzuROURtNAOsTOqA?=
 =?us-ascii?Q?I3gHLMuPUVqMZlWBc03ULwf2zL7EJKgZyDygg9AkyllhcIXk6lPXkJwvREUA?=
 =?us-ascii?Q?nHyrqBaEGUmXRucfqkHUSOv6sWcpxpZIQ931CITvDZttpxh3Cj2q2DbeUM6O?=
 =?us-ascii?Q?f6CA/jCM0xIR5orsi8507QsGwLnNr9wZ3TYwZnduvXfiNrd4JUGiKKL6smmr?=
 =?us-ascii?Q?4j/+vJ0xM/BJKxF9WXAWPVzZ/yALU997KrADfdnN1sJQCIWSaCulFOIwlbO+?=
 =?us-ascii?Q?bKbjP4LOxPpI2Px3hhqUU2Y6ueQb0xsz2LytdDBdSW5uFSr5ami5uCuSMmX6?=
 =?us-ascii?Q?unx+Qs2n1uDQPcL01Pmt1AyhZqfpMaIqPV6AKFRjzhfbWToWXQVmX1TDqbVw?=
 =?us-ascii?Q?qP/fbkCsRWhNJ19M70xilOLgeOzJVKUk3GIMg72aBfNMLQG4+QrhIcxaD0ME?=
 =?us-ascii?Q?BazHgSxZX2tRKcdRO4GtUEm9DKTcq0mdUBkS1BSth1yVhhPpuE7hO49/Jns9?=
 =?us-ascii?Q?//9gBtPMo1AJ9Lv0xtRlIAP+gb0rv79PiSOaJTR89GLk/gasd5jlyA7gHnDI?=
 =?us-ascii?Q?OZNHQSgZZ9gMU2W8YXOOOSMmLJysV9DU0VyeYy/wABX+/5Y9+9FH695kteLd?=
 =?us-ascii?Q?aYl6qRG43xCttMiAql6roUHINR0PJULTDzrVGNQStmryyLGwPd2LL5AvFayB?=
 =?us-ascii?Q?gsYK+rr2iLufbfzVaojbqPPqO7d9aT8wUXxkl+eExig1XkE5dY3RTgeMNjEU?=
 =?us-ascii?Q?Bh6KQ+REcFTvUxk6k4uvHGtzN295qGAlRbfDNhmjzQUel8nwqYNsLJDMX0Wm?=
 =?us-ascii?Q?yOWk+BTKYvyCZIy8hr9qPYCYz8bIEe9vhU23A9OZAfv6f3quYUTIr/BNlf3P?=
 =?us-ascii?Q?IDLnXqwn0d0MjWgkBUskikXKYncSIZV0YWm5822xXZ+6STdSNbmyK4HW2T+E?=
 =?us-ascii?Q?bAtnWVsIIFx5VnqXv328Mttva5ELnegNG22A3NGw4YhWJkS+wMwZB3anUpoF?=
 =?us-ascii?Q?3GlDhvuDeTgK375n3OTVFxeuQthXXV7TOGB5ngI8ssqY25lrsspz7NLrQtzI?=
 =?us-ascii?Q?oQUlxmZcH9vB69pd2nQebvnDk+X3dKoXzGNozZ2RKJFLqafO7y0x8pe0kLWq?=
 =?us-ascii?Q?5W+KtroZwp5dz++lcW0v/H2HGlVv1iM5lxi2vvTKqmDQxVjyIzeFI1D8j463?=
 =?us-ascii?Q?4WpFdyCjDWpgHyqRI+VDxFPFpjRj2jTYBYvL+Ac/hHGu8ZvZSxsZkedNqscO?=
 =?us-ascii?Q?qGTP2RqIAa/xRSEi7wCYUcGqNJMRn7QhXKqRWCNVKYvyg4NAlFk5Mqn2W6KS?=
 =?us-ascii?Q?hogzUt/tA414AqS9bC92L/pyWFzKkQcCBKx52kfoU8UQUVEKfCdyZUblPN3I?=
 =?us-ascii?Q?2XeBqg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae954779-4e32-4c81-2289-08dde3efe2a2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:55:59.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRyEY2Og5cRgW8o7KwjUpaKW1p2msT34guTI5FsHj/HpR11QwMqa/ROCKJRH+CiOzpcq8B+h0OphIDG8XdgyUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8060

Hi Xiaoliang,

On Thu, Jul 24, 2025 at 01:54:51PM +0300, Xiaoliang Yang wrote:
> Hi Lukasz,
> 
> > 
> > Hi Xiaoliang,
> > 
> > > If a switch device has HSR hardware ability and HSR configuration
> > > offload to hardware. The device driver needs to get the HSR port type
> > > when joining the port to HSR. Different port types require different
> > > settings for the hardware, like HSR_PT_SLAVE_A, HSR_PT_SLAVE_B, and
> > > HSR_PT_INTERLINK. Create the API hsr_get_port_type() and export it.
> > >
> > 
> > Could you describe the use case in more detail - as pointed out by Vladimir?
> > 
> > In my use case - when I use the KSZ9477 switch I just provide correct arguments
> > for the iproute2 configuration:
> > 
> > # Configuration - RedBox (EVB-KSZ9477):
> > if link set lan1 down;ip link set lan2 down ip link add name hsr0 type hsr slave1
> > lan1 slave2 lan2 supervision 45
> > 	 version 1
> > ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3
> > 	supervision 45 version 1
> > ip link set lan4 up;ip link set lan5 up
> > ip link set lan3 up
> > ip addr add 192.168.0.11/24 dev hsr1
> > ip link set hsr1 up
> > 
> > # Configuration - DAN-H (EVB-KSZ9477):
> > ip link set lan1 down;ip link set lan2 down ip link add name hsr0 type hsr slave1
> > lan1 slave2 lan2 supervision 45
> > 	version 1
> > ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 supervision 45
> > 	version 1
> > ip link set lan4 up;ip link set lan5 up
> > ip addr add 192.168.0.12/24 dev hsr1
> > ip link set hsr1 up
> > 
> > More info (also regarding HSR testing with QEMU) can be found from:
> > https://lpc.events/event/18/contributions/1969/attachments/1456/3092/lpc-
> > 2024-HSR-v1.0-e26d140f6845e94afea.pdf
> > 
> > 
> > As fair as I remember - the Node Table can be read from debugfs.
> > 
> > However, such approach has been regarded as obsolete - by the community.
> > 
> > In the future development plans there was the idea to use netlink (or iproute
> > separate program) to get the data now available in debugfs and extend it to also
> > print REDBOX node info (not only DANH).
> > 
> I need to offload the NETIF_F_HW_HSR_TAG_INS and NETIF_F_HW_HSR_TAG_RM
> to hardware. The hardware needs to know which ports are slave ports, which is
> interlink port.
> 
> Hardware remove HSR tag on interlink port if it is egress port, keep the HSR tag 
> on HSR slave ports. The frames from ring network are removed HSR tag and 
> forwarded to interlink port in hardware, not received in HSR stack.
> 
> Thanks,
> Xiaoliang

Sorry for the delay, but I remembered just now that there exists an use
case for which hsr_get_port_type() can already be added to the kernel,
without the need for submitting a new driver.

The discussion is here:
https://lore.kernel.org/netdev/20240620090210.drop6jwh7e5qw556@skbuf/
the basic idea is that the xrs700x.c driver only supports offloading
HSR_PT_SLAVE_A and HSR_PT_SLAVE_B (which were the only port types at the
time the offload for this driver was written). However, the API does not
explicitly tell it what port has what role. The driver can get confused
and think that it can support a configuration which it actually can't
(see the table in the link attached, and the xrs700x_hsr_join() function).
The only way to solve that is to introduce an API for the HSR port type
and use it in the xrs700x driver.

Would you be willing to resend this patch, making xrs700x_hsr_join() the
first user?

Actually I think it can be considered a bug fix worthwile of backporting
to stable kernels (unsupported configuration fails to be rejected), with
Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")

