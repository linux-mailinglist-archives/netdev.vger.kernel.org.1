Return-Path: <netdev+bounces-182686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A15A89B30
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B09189DB5B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FFE29292E;
	Tue, 15 Apr 2025 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWNidDBx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15044294A0D;
	Tue, 15 Apr 2025 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744714225; cv=fail; b=WzitYWbtWv+1ZPqKDXoezWdyR6IR0I9ef0bB6GqcGbGP/eYOBbavNdNOZ7bKpT2Jgc3336RAug77wgDCu0ZHqeSMKYyiw+wiSHtqK5vjQTASpYDFqA4EFei724AoYdpzs4PEMCzKoQcQpJZCE2iw6nG8iQRJmxue7IPOGsHrlvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744714225; c=relaxed/simple;
	bh=pJh0U+KFgY9bQqR8pz9Jzi+U+7as2AX/PSJNQHCwIZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hOauVowVTryQbfwmoxTaPhE1QsNIkYLtTaCpVysqktU3X5vGBA+M+1DJMOHkSe1bAUi9+l1/OJSZJHmIJyoczBJO26qSWp9zP2Mk5LpkeiyVcZoJJP+k9+Wku20l5kcykrVDI56+svZEBGYSxon9MXwygqGWst6xbFWzoA3VJ3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWNidDBx; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIKBHPDpfDRxkdqlYFUwbfgJJ0y/+ljOcsXr0Uwk7xjmcky+RIaeOsw8zDmAvJF+ZPrndGv9waGobrbIcTqZIGnBRo2i2vqTFfw4m4hdYDHfkNhCClIz0P0Bjla/t3ZbwjFqTJPGcH449cVBGzisSJIduAUi64z/DR8yUSPmXkohjfu5PyuPZmaw4YxkhIqrvh1zq6sjUnYjrWOf3T2B7g/9l9xMxtHG99wRfITtv2/goehAjyycSA9mq1DIqQ6jS/JVIaOD7O5eTI83iapDkj0PMHV3aA6rDStwuiHf1Xa+Q9sZl+OFfsPRPT3C22zdfBT6gyTmNLwvvU5/ZIlnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3CVh+fteM7HL52eC1DzjbfRrKKGyz1hxGJXR958rS0=;
 b=EJSv9wNLmkSh2BxWtFxULtHIRKMf8P82uH+5GGjvZV0V9lRR1OVHM/klTu8mHsMV+MTHji4P7gwzp1hLx7Zh/3oS2bZQvUfdpmfO3DaODeROwhCptaj+3xdCkhMxdHnXUNTwNkiXC820gfTjyN/1ZSjkHFVUitlCSJadRszuvN/ZrvxwxElx+ILCBHYQAXTrS7lTJOyG4BvLMnkpCtRQyi26JgAAUfULB5bjmTbeQhSEABVABd3qrCZhtmkovM1oiaS+toYrNvWz4ZG+jeeTaQ+MYxxm73IAuSm4OY49vD2g7TS0PJqoBcDmCBP66Vor4UJnPRdIAZ1qv5GFzJIGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3CVh+fteM7HL52eC1DzjbfRrKKGyz1hxGJXR958rS0=;
 b=KWNidDBxMO4o44bk13eTx4zHzqC9ovlr2if8w8n6EJ9HDSbo1+Wqd5e4rvXElb7NOjsvFX4CL0GI9q+3ZBMRs2aedPBM0JhzdhohS+YVYs/wmrsc2tL/Zf1BwLtX4NpooaR9PfbRse/UovQtxlImcPKEHAtb/oQRkKhn6byTdAb3vc5p18USfrRJNFMqaAxLqf/DM1/mjoANFIyp9LRlanaw38Qzj51CA2GSnAt3Zd1C9gMG5cgciNGpmTuatKP42gTWJTyVi6GB1GawqIbCrYAgcByHHDpRY9sFmZm44eUeTdGtSZyALRmrB1mjcMiw5ifQYVurqed0AtTxOvqaMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 10:50:21 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 10:50:21 +0000
Date: Tue, 15 Apr 2025 13:50:12 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: bridge: switchdev: do not notify new
 brentries as changed
Message-ID: <Z_455Kq1seP-KPhC@shredder>
References: <20250414200020.192715-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414200020.192715-1-jonas.gorski@gmail.com>
X-ClientProxiedBy: FR4P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db6a920-d1ad-471a-ad34-08dd7c0b517b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jtX+47gZAsdLKOP0i9+6Z14CP6hWhzPfrafbsYpWWi3MH7onV8khzU9gJZa?=
 =?us-ascii?Q?NfsNdUHk62T8eerHVt52szSMzQa4T3b/3s+TFwkwveMioN6DHrWEDosmpijP?=
 =?us-ascii?Q?M/KHovAubKuSTro3XNlteuvl7SPSz9n6DFYbCtYuPcLFtgNxp2gQerWuaz+r?=
 =?us-ascii?Q?QLcBK5NWSoycMLRhJsgA9jr2UqqmbpK/1T7vU1iqGJUfOfTeZ1cGGELEryli?=
 =?us-ascii?Q?17UdsiKWysu1SNqSMZ1zClDAN3tBF11lW7KTXsDdtCIyvoZ8ql3Pgcl3qScV?=
 =?us-ascii?Q?ceLhARXESmyqDY4p73z4tvc9y8DZot0ce6taNOKoOkxwSgwcjADFnqmsSx9Y?=
 =?us-ascii?Q?rMbvysTJ9PxmxZA5juwQafokcOYVLUzjuS0yXQH2YAC4U2oG4Gp64PjeMkAp?=
 =?us-ascii?Q?zOGBpmDiZqVDnUjAd55YE4apscA1GU56cgdxrsUbNpL4EVWWXO+7wnKKyEqD?=
 =?us-ascii?Q?Qza8KQt6C0UHMyaL70mQAgnI1YP8y4YnUyHsKs6Y6oAprtSyaIGFsDzaDCKL?=
 =?us-ascii?Q?Xcf6F1mP3HPT3pLTy0w+8inOS9F0UB33+0Gfjn27RQuGaHfByMYhtaRdYebu?=
 =?us-ascii?Q?rjFLxLZcIZRJleFj162AlRZg+XzduCWXzeSJNjw2CblvWcZ60iFAEKsWIRHl?=
 =?us-ascii?Q?BpPArSO0K7HoWHLD1oKIJW7pINAsiqSzzFgjd55xX92COMnIog5O5s7BS7OA?=
 =?us-ascii?Q?kLk3H+VkOdQ4GRrlhzj60vSalSTAhs6XtjdhBrOltaVAoNrFBSggB8wrCrOT?=
 =?us-ascii?Q?cnAkBZfgAG4W1nURfPjgS7dUn+RnxRi38HPVrWLsOiwTaJ4zjIiAnhBtiV9r?=
 =?us-ascii?Q?JKNtJ9YlG+3tN4bqGl7PiYCUVRX3IPcPJS4w7S/js4L2ytydNdcK9vzNfioQ?=
 =?us-ascii?Q?6agALUK/nbnTR+V6jjL/GTBPvh83Yikp/9wxAvOTQ6q7UYws2AqKAFMWxKd0?=
 =?us-ascii?Q?1a+rwJUdbwOFf1gwsv6ks7YUa4JIOMT26OEjSn/HF8q3wCOuX+LOwW6OFsZX?=
 =?us-ascii?Q?2qY7TYYxWJaSwTQLMlS+1EPHxMzeDiL4Ywn563m7JsFUrQUDytYOav8G1m67?=
 =?us-ascii?Q?JM9pzwU5Sh1S/I+XUMjVNdUOe48xHvt28w5akC4d0Ml50IyFd663DYfBDEnZ?=
 =?us-ascii?Q?6f0Z3LRoIgcVaLqqWlnobvUeYkkS3MATzvgGkoNXNMTqHZRDiV7+IyJmAHvl?=
 =?us-ascii?Q?rXCiR3314wvZtpTqbLXmABGpMwai8+iF3Uf97hkqpm7jjCYR8+3Bnje5hKMe?=
 =?us-ascii?Q?nmf3BwW3g7l8nmfHXKtV+BHK529QthSk7hzWMJSYHce+WW3bdOf/dONbeLi5?=
 =?us-ascii?Q?wT999rZCOX3lji8zhY5OibZb34T75Ck5WTdC9DEireydo4rnNSusx50qYTi0?=
 =?us-ascii?Q?uGPTjA0Os/xDirGJPgkoGZQlRW2paoqfUlv+I4jmJm0lsdf0XHtnKuYbKbH0?=
 =?us-ascii?Q?OqnlnLuT47E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YgI6UoStE/vgDoN4BnmWJGrMkKg9vFs3wjEAbj6juJuHXm+B6m0k21xee73C?=
 =?us-ascii?Q?KENoMRel50APDvzyKJdZJZyA270dYsZrc5K2jqfou/KIIEvheJSYZ4pMLdHj?=
 =?us-ascii?Q?LuoREcDiTW7idh9yjJFfSRP5ofmRe0CyxdKJApFvOIKFdzYbT1yQePlLdjLY?=
 =?us-ascii?Q?a9ycglqwxVDGt4tcJvM1EuVLvrtWH0YOH/P75HXfSbnjiC6jloY7AImUE5Im?=
 =?us-ascii?Q?o1XTbfn2mCoNH2aPKV4TfJH1ehJqhqVCCE8qYrLVSKh2fWOPZP9ciza3Z1s3?=
 =?us-ascii?Q?LiqF7FnDWuCAnZtS+MKrn0zlKyFq7OGjLkLKYPC/zoosgNmWhOIavf92R9Yb?=
 =?us-ascii?Q?srqo09Xna6kU7LVWOJvX41YRaUryixXPfWECDRaOuD4kfhYPyuFykKBylBIt?=
 =?us-ascii?Q?WRNu7w+b8ewT299DZTfilIx0WE3SqkryUiDgdgQ7VSlbdv3OT1qlBfNDmyJ0?=
 =?us-ascii?Q?VT06FVD3XI98/dleVYNyoA1iZ12xApunAQ8Kype6gxEeHQb7W/gdYxb2/BlD?=
 =?us-ascii?Q?qSkEj4PLQn3ZZDL3ySto8xqv7h1XH3Z5FFK+aNpqHE7SnR8o2HLOI0IuMMAA?=
 =?us-ascii?Q?jwl2nW9PkiSoRAWcdPpSMMlWabYt6/mkKzshtJxPIoDvfQenTxiK7XqJMexj?=
 =?us-ascii?Q?VQ9MTZciQX3nLlw+T5l/mGgbjGYybBLMjw6akJr+9/FAYCuLcwz5/yFA/h2q?=
 =?us-ascii?Q?yC1Y44/ve8oF4VBOmsFslyK+gOLaXKWj2cWxfJkG/qgIMpOyQQ55C9u2yJUs?=
 =?us-ascii?Q?bbCjBX3wM1cyj4zXbnbPNknLE5xWD8zLOnHlEVJC8Vd8xS7mgp5MNSd2nP+W?=
 =?us-ascii?Q?V5j3/kof4QiV+J/x84VyEtXSknCnIa+N3KJF0ZzGFr6t9Xaf4uzLtiXrQuXF?=
 =?us-ascii?Q?krsYJpfiIEYdJjduotTL+KRKghtekW/pvss+kBjHyW3T8SSkuaISGipXyRAK?=
 =?us-ascii?Q?DX9zYkLMP7vzSbayQ4y41rzQKHoy9r/cdZ700tElT2E9AXMMx1id9KZi54kW?=
 =?us-ascii?Q?68rNIk8SjbPIOjaO4/V9UJwLWvvNBqZKLJ17eIoey0NrpL+gfLfqOoRiVW9D?=
 =?us-ascii?Q?U3dj5LC7U4jg/YAMUB97fVqI8VQ40oBI9mpBgU+JMGBMZAo9Gnciia7uzCGu?=
 =?us-ascii?Q?6JEgimqpZGFNI9ns0pHzyeCp609/rYavgrLUSb/0MMnM/4vMmDjMDPB0w7nA?=
 =?us-ascii?Q?hFpxq213CFsk3wpvGDBa4X3nSdyTbzVpMnptlNKprZe0RJRbdKTHW/G8zRHr?=
 =?us-ascii?Q?FErXERprNIQAnuKV1iWyrQjE4mc6cbcEE2gCgAE3RinnuUFAE/wkXJ53m9Ot?=
 =?us-ascii?Q?hmBLo6JDTb2hj0nqfg/pHPnmqHOxAw66x3RJpW75vWCO+cM80Hw/lx8kLLQW?=
 =?us-ascii?Q?ADRJ5xppuBjNnLrSTeMNrhenSagWvxV65nBI3QJevSxdfqZc4DgYwowzeFSc?=
 =?us-ascii?Q?JLF6rGZUTxi6DZ0U8aYKUfEga5nzAYWqrSBhmq0UuLAqKUsK+oMpHRBXMIJA?=
 =?us-ascii?Q?aX96MkFdvP3QQGCEX5zYl+4QIV9q2G9x9yY02iR0M/fIY8Na4dmq4NfIfxpL?=
 =?us-ascii?Q?auiBt9x1xRXJVGHNUsaG7G4winww0s/25dpJxzpn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db6a920-d1ad-471a-ad34-08dd7c0b517b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 10:50:21.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVJcPgH6p8Dv8naZDrW6EkIAUiMF9ZyG93cSKCB+tGa8d0TO32t0phqyxBNinXJNLRYjr7RAepesy4KL9Y6L3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

On Mon, Apr 14, 2025 at 10:00:20PM +0200, Jonas Gorski wrote:
> When adding a bridge vlan that is pvid or untagged after the vlan has
> already been added to any other switchdev backed port, the vlan change
> will be propagated as changed, since the flags change.
> 
> This causes the vlan to not be added to the hardware for DSA switches,
> since the DSA handler ignores any vlans for the CPU or DSA ports that
> are changed.
> 
> E.g. the following order of operations would work:
> 
> $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 0
> $ ip link set lan1 master swbridge
> $ bridge vlan add dev swbridge vid 1 pvid untagged self
> $ bridge vlan add dev lan1 vid 1 pvid untagged
> 
> but this order would break:
> 
> $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 0
> $ ip link set lan1 master swbridge
> $ bridge vlan add dev lan1 vid 1 pvid untagged
> $ bridge vlan add dev swbridge vid 1 pvid untagged self
> 
> Additionally, the vlan on the bridge itself would become undeletable:
> 
> $ bridge vlan
> port              vlan-id
> lan1              1 PVID Egress Untagged
> swbridge          1 PVID Egress Untagged
> $ bridge vlan del dev swbridge vid 1 self
> $ bridge vlan
> port              vlan-id
> lan1              1 PVID Egress Untagged
> swbridge          1 Egress Untagged
> 
> since the vlan was never added to DSA's vlan list, so deleting it will
> cause an error, causing the bridge code to not remove it.
> 
> Fix this by checking if flags changed only for vlans that are already
> brentry and pass changed as false for those that become brentries, as
> these are a new vlan (member) from the switchdev point of view.
> 
> Since *changed is set to true for becomes_brentry = true regardless of
> would_change's value, this will not change any rtnetlink notification
> delivery, just the value passed on to switchdev in vlan->changed.
> 
> Fixes: 8d23a54f5bee ("net: bridge: switchdev: differentiate new VLANs from changed ones")
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

