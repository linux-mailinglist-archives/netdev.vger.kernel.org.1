Return-Path: <netdev+bounces-195961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C2AD2E8A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A23C18911BC
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7928027A908;
	Tue, 10 Jun 2025 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IcITebRt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8A1F874F
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540179; cv=fail; b=om8Usb/7A7xxOF+pjChpr97/SWeHUmzpwad29A1SLBCHmPp3hbZxLdRGEiF+AJcXGIMgtg59c++Xh7cknEz69LuA8cMrHavH8WOhUA1f/CL1K54m39TpUNiJull5HmmK5TVd9svle3Skj+Msn3X+fbGsDcARG7CayIa223GzOMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540179; c=relaxed/simple;
	bh=heE+bh6klqysbJmhB5rZC8UYZllE5NFIheY+3C8kUK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LbpXEdpEeUxiW4Pii8nBTBX7fIPI8tUB5hrogCTFv3FsPoo07wJ0x1GAzFVAfI9dqSLnylhPkdaS9heecvyITasyGOwTxOzKUsv6GLjTpQs/jFYXY/n6GSWy4ofwX8yYNSPh8/baQ+3OxmSvmlE+raEaRDjgVlAjjcukdv4KTUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IcITebRt; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6Nk0JHYS+T09T3qvjKzdN1zu9ciF2zJRd6M0vyCFyoXeMdiEaYB7wQLSo+Dp8HyW2HNsFKsql0CFFIgRxL5veKHzr3uxKg5xuFM4KEkDyoD5L5JtSnBuTLjvuuOo/P/sm+LMms8YfeGNE5e5KMkl9h170eadFXLLTjuvuFoS5GnKPX+f6+NaMiSIbtV0Z3GVGSV6J4cdWKKKqTCXoH/Prt8nxPYBxNIQSZzC7I7KZGHJj5bNgKrU0dkUxp/TVIIdLgUTJKb3QeCp2IpNKvP30ra6jBASzoPeGZArGCNvNBf+tOHSXaWkMJ9/RpBxI+JQ9albzgJ+VMKIy9UkZ11SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/X1mKRaQOgS9g8721DT0I0MlzwDWgglqf4CEnXS5BE=;
 b=xbMUthypMKvuVpr+CSMkxa2Qr+PU7SrclmzUDIqJJ62jkKO8SdtfY9gl+gK/OOEXKxwl3594dl/ub/qvkNx8cQFRahbJ7I+gWCmEDtsRa18V6sJb6PowiNUdlUBTZmRtshhw3KYvHZpV5197eLgn8cBJ2t2/DNVSK1ZiVIv931F2AXk8bySRj9/6CUgpSHWHEDzsfOcbal+CgeBjgi9h7plgemwHWyZ1ztrIKAS/o3oSM5SRXhh/VtOTrVYH1fbbkwU3Cxk0787EaH9dGmC3XFpWuuUiEndxM1M28qLw66ANMUN2/1krMTdVhFOmx8GRmfyCrNg7VZ/+SJnavsQ/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/X1mKRaQOgS9g8721DT0I0MlzwDWgglqf4CEnXS5BE=;
 b=IcITebRtAUjCKcDpxmE8CDkYG5369Et9cPwRjghbpBNW3+qbanzJeR6eXjs486izjS1qItscknfqLkcmqW90oLEl75Nehf3gSTP3bIrvgYeOKNcvCE6GoUyCcB1fkOzBFwtTjMc2jE0/40p8NkbPzz/316dxHTxfvTS5haG4gj1oaFtpZNXoH8vFkwbMaFbBIojWWfw0WxW7M/me3Ggl/AhUtmHndOxoAgxqIF6GPypeHn0hegJeETm4o7d+IsLjDF7U02Rv89fRkz7UHb3xW8nP7B9i6P93YWSSQbw74Aq28RDDXIBi/wq95QWugKnGfuXowjaS4Zz4SkwcTmE1DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Tue, 10 Jun
 2025 07:22:51 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 07:22:51 +0000
Date: Tue, 10 Jun 2025 10:22:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux-foundation.org
Subject: Re: [PATCH iproute2-next v2 4/4] ip: iplink_bridge: Support bridge
 VLAN stats in `ip stats'
Message-ID: <aEfdQMWuDHu_lJaA@shredder>
References: <cover.1749484902.git.petrm@nvidia.com>
 <c0d97a28464afeb3c123f73b656e5e5532893726.1749484902.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d97a28464afeb3c123f73b656e5e5532893726.1749484902.git.petrm@nvidia.com>
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3b5664-fd46-439a-384f-08dda7ef9bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WMDBVybMypFKglVgPm76korZDjorPO7xsH/XA6mVPkzw3SGF0iQg6Ob7k4FC?=
 =?us-ascii?Q?FKywej+Vg1Mxzj3yGDofpSOQ1LJZZOAkLEbxr8ZdtN4vcqialXn4BmDsuVhy?=
 =?us-ascii?Q?G7NvXkTFOZBMRZYSgwO6Cnfi4KEoL3B8Jro8TqUfetraC9hwU1CAllqwyy/J?=
 =?us-ascii?Q?U3OxmDNWMuZKjfciJXvKRc1PcmL5w4ed/9v3Ao6qarBwepNj6xB2r2DxCGxE?=
 =?us-ascii?Q?UqiAcSlvm+CmmgXKSFJOoh9zF8dNR1VlCruFOw7C5jPmP5IqqPMlnomySkhc?=
 =?us-ascii?Q?oURvWUxXA12W9J6dHHAq8zxsH7sea/l89TA4eDxry6hY0a6DY/NHH5S8DWDg?=
 =?us-ascii?Q?/NEjzQUoQ+QVicB/ZE+BF2SjDTsJous3m8BA6/7xlc+/MJeWFq3SgELvAMAX?=
 =?us-ascii?Q?THlnjVOWJRKO/aw2sOPL05NTQeOtWEuh9RCrhT4kVrypzCOSRuxQJX9UfzBw?=
 =?us-ascii?Q?tad3EoyibQWGBOkxEcMpWnjK/s8YHTpA73W+/9pwu1v3dmcWqcTKoYDEkxG2?=
 =?us-ascii?Q?oeqxzdXX6VYhzsjU+rtapX4jW1DHH4uhS6ubVL0ikPJCfJ5kOWFIRv8RryQr?=
 =?us-ascii?Q?PXV9roCfI0yKvA2qxvu09c/Yu7p6s7VGM5329/w1a4/b9/Tvfyr1sADxx1W0?=
 =?us-ascii?Q?G4R8960+1tdLTTeJ1qwnp05aJkBW5P01wluX/mf9Q6ZIC/F26j3IZwTGTVfN?=
 =?us-ascii?Q?paiy3fJYghh3cVR7OjIMKUhyl2Yd3zKUbaj5hkGtH1skW+bsj+OdxY3/OkEO?=
 =?us-ascii?Q?mP9yYyd+68Iq9qh1tmPGn1BCBD417VVy7EftMeSlqNgZinXAN7Wl4qdKSBC9?=
 =?us-ascii?Q?qBttNGCvlyFWNyvSnILUGQdUiNqM3K+iqOqAa7xukPAMEzK8C4A6wprLjh5M?=
 =?us-ascii?Q?IxQRw63aurqUXuVgKRhsDtfRU8jEjmUbHJ4GPt6VuS1y7AB6SA3kkHrySwU/?=
 =?us-ascii?Q?8iGB6XJN+T+SAHt/55LmHpslRblXFkzcwDW9zc4gUP9qBt6fJId/Kndqj6x7?=
 =?us-ascii?Q?SheqCWJUyDomiCWxhiFsCjAkSnktIDiefkgkFBURYjtrSsPqgWeMl7rvpzA8?=
 =?us-ascii?Q?hcdS74qSf+BQVvPIVvC/a4mlFOg7/UzFOm7YjIiK1QiTYLZw5dxbXxfrEJx2?=
 =?us-ascii?Q?0oZOoxMEm016IPhl46GNQQJR9s1aru9iyawPuaw+H2WoeCbVnTWKND0hgpjc?=
 =?us-ascii?Q?vyRC3U3gnVJaFIeP/nOzV63A0CP7GlSs2yDuCrzs95Xygx9guAdsVOfGEdHi?=
 =?us-ascii?Q?RwQKfvwNtc8ccrIKGq9WcZ3loJV6rRRjW0CUSeWpFn/9n0gDw7Qb5R/wp0I/?=
 =?us-ascii?Q?6DLFDtsCGUYvI0CkohfZedLtBDQsP5Rl3vdUN889DKzpwP1YvdTuYcpERVcW?=
 =?us-ascii?Q?uXeOgwQoDSrnHFl9CcErc3lzkoNTztoJOV5AVYwTdo2HzNMOLAf9II/uYkfD?=
 =?us-ascii?Q?zDOT82u5NQU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zKmYrN6N05cqaWIl4AnlMDPHjqcO+7dWjF2JQxn8qfBN4DBp2ZZbldCncm2X?=
 =?us-ascii?Q?8dQtUeiycGf4SZKGr7b5QhpwkythyZ+4KpvVUbCQXURbFTt2nlywhPAApZlB?=
 =?us-ascii?Q?i8Rnzp69FQmxi8YSW+tjQHmXKmq08V+dN3fee3eXsFk/2dgJpceH81vgw0h5?=
 =?us-ascii?Q?35yRZ1TAgloDSqYOBJWLDuxWpOfpZl1Hkt+P1TYwqyJa259XsZ9JwhlvUP78?=
 =?us-ascii?Q?ej33X/mIY7LC4Kftpbqa2cKQ7+ck3hKsddr7tlt4JHoquY4StJi4ZDcPVtda?=
 =?us-ascii?Q?tw+/ZvnwiKsR+AhH5n8WW9AAXJU3dcWsNEqSynfvvqipchaja2m0cEJQYpeg?=
 =?us-ascii?Q?hQXTbiP3q8wS6gqJK8ne21X/CzzPK6FXBtiD+nl/Cz6nrfiHZorschuutYNN?=
 =?us-ascii?Q?7juyJFAyjYcsFZx1VIOzL9iOUmBFCXwZwgt5SemPCF4ZBgcrcn8/jTU0WdUt?=
 =?us-ascii?Q?WrR9bI9DHRtrdntrmmbZJKzhkdxVTJ7yxKEhKp0bnfoVELOeDkNmu/50QISz?=
 =?us-ascii?Q?HOzIbEaRTH1zEQtusUbsXPwVqdpG6cEkZaHl48B3XjnSjcz6gVP+flt29ueN?=
 =?us-ascii?Q?7HumN70IAphlkpOmubbVXLYK/U8PQKbxA/+pHA9S/jy6QZizg1CNvrgBXB2/?=
 =?us-ascii?Q?/TvyhZosQGDtR0yD2Z15HRWOXKa3+ttVaAQhjobfVjEoU29SIe3VLjlnBCXn?=
 =?us-ascii?Q?/avEpZAOVLcXyDaIJM8LLzudmLsPq55RAI2wCzus9wFux8Cz+yP7nedLdObZ?=
 =?us-ascii?Q?dmglTiklo2VmbDIeNymcVbTZQpoHZsi74Jyda09QHQg67UhZDTw+r5V7wTO9?=
 =?us-ascii?Q?80I8lP6u3UDUVRDGZVITUPEQauwqmJyXfnx8UUlp9kYyl9NcKga7ULlUOLHC?=
 =?us-ascii?Q?1NoU57BL8VlK0Ov+T2OfLx5HFTkHM0AgODCcrGujdmhECPD3NYz8Dc1UTDJn?=
 =?us-ascii?Q?C5TIbKbqF+tXe6BK1SsKyrYB54aTLAGU6V+n+LMlPPL/8CB4PD2KPYlQfTJV?=
 =?us-ascii?Q?ctasDqezbyNrVq582/Av2oiEybgaS/9gpyCLIWuYJXI3/EdpNXkEwPN7sUFj?=
 =?us-ascii?Q?cLWH1AMEMVLrMi3/ORri+cZIE4zaL2e81Hnm71gPQIjdMyoi8BhDztD23o3K?=
 =?us-ascii?Q?yHoyiwS3f3OtC8llMQyaMOViyP7G8FOay5voXwt2X2rXCYHD+X6DVhkjT94n?=
 =?us-ascii?Q?EE6cOnsrf5hfJyMeo4T6K/MIsMTwb3KE5GIDPCToL2eBVz+mudaI9+dcmFJA?=
 =?us-ascii?Q?v5iT5w/0s4GM2yvugoA5ugmuOsCfb+UzNGcDEZoSW8L9AKSRcT/uY0sCx0BQ?=
 =?us-ascii?Q?RfoEoRf8EBFusgvrrmP6ZhpVsirem1cmOFJkEGNKGJwk3+i5bmAS1WYR7omF?=
 =?us-ascii?Q?5g/v/kJdf5R8q2yB/IU0i7US4cjU7k2bQsfnKtJqFaKT+cPwlGxx3dSehFFV?=
 =?us-ascii?Q?v/+k2HGNb7mycfHRcwO94MasHoooZ92CO+virs0sTLYqzJ7iWSPjB0bC3ZKs?=
 =?us-ascii?Q?OY7u3uf/uiSxPKcr34p+Q9Ekswzxiym2979MPs1IPWP3PGGNhSnDb0ft7qV/?=
 =?us-ascii?Q?FW3zGEL7Tae3lnhS+hhhVFW7aV07ohRwusJL4jWv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3b5664-fd46-439a-384f-08dda7ef9bf1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:22:51.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdFV8IbJBMqks+Fm0ICn2eXkqrpHHAEpvUKLN2q0h282o5goO5Sg/SnAfDefMC+2ZPQgI0JnymANWjvGMO+TLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152

On Mon, Jun 09, 2025 at 06:05:12PM +0200, Petr Machata wrote:
>  ip/iplink_bridge.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Code LGTM, but I just realized that the new vlan suite needs to be added
to the ip-stats man page

