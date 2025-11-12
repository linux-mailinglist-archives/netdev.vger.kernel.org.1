Return-Path: <netdev+bounces-237907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B3C514F2
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB6D189B980
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EC72FF658;
	Wed, 12 Nov 2025 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dczRcECB"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064892F998D;
	Wed, 12 Nov 2025 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939134; cv=fail; b=fRLomhSPmAQcjuJ25eXFyA8RXgQNyrlAyBabQu/z7p3isGBaxnbUFkjrz5C+hMaa7BUHX1cxWzdAxUZRU/90LXhIx6FaQSpAXrmrnJA34zzSYDfABzRXpd4Z0xNyPG7A8CCgdKBxrjghkA0kL/oPxEnhKllSkcH7/kFzaa3SiGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939134; c=relaxed/simple;
	bh=jEVRZKOB6F38hWUJ1YtDJTusda7R8RTHUuYvDh7W6YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hZZb8S43ds6X9+W21a+o/TOmSCSGtTafLuV8sDg41ZLH0a6rRjCmcOacvtInNAyXT4JlE26ggPtKn/8kkrhIPQ7fLQk1JWsEFqZqXQjQl4nN9UNhmyyc1O/ZSi2McQ8YysoqIntVJt6bSgCT5Bay5LNipdHTeKEa41AKU5yj96o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dczRcECB; arc=fail smtp.client-ip=52.101.62.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/ZhSSPjc9ea/r7hdCsLoMo+xAt+o+4FwVbM+ozFDc/BblaXns7Hy6vRdhXQ9NQtMp/++Q6VVZRiwIc8WwlVBRl4lDoARx5HKUnVrnESVpHza02UclQYhxsDBRRIHOomxFt465qHQyA3k3K+t0X1nDb1rx9eSO8L8131sYmcnYt9flISIq2QcEmSMU8s6VQyRAiXOFmqhstQJvKIE+UkIIhQCmm6A9whbqQ5fTy30s9EpvL/M2uxO42/t/rTEn0w1p4KbZ/QZFZIoEoHh1CiCFfDmw+chkyx1REQ+2IbKFFIsXniQG70pP2tD4RDl0ccM5puS6yaNX9BgdJ5VXaY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFFZmk0Zut+SEpQt3vr1FGlS3xQCoekrs9AfFuZbap4=;
 b=PEn+uTJ6Dq5CWD7z+1LzHBeOHBRQfpolB9xOcrjYDI/yTiMM22sLTQpSdvwpgw2ZMw839cM0EhN2tVFziblXElSAWyoUliL1UlIqfRrfBbxUI789tGTEqY3WjQ3ERT5by4kLlLbdy0LEF+epZtvMPqICW5T1S8OVGqJ0vawbPGHkGkc8OBQlXJWfxeV+Coi7t/GeCZdpZEN+YCot56jopjo9/2POvS6LoQQVbXcrwYZ4Q2BI+yfeErFtUjfN194/gxDQvOWIRfzNiciwQnDUlwAls1r5PCtJvc7laSDt65lk0bGk+0SPJj6ZePMud9reMXxAUYX45Ew4VdRkIPwLAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFFZmk0Zut+SEpQt3vr1FGlS3xQCoekrs9AfFuZbap4=;
 b=dczRcECBrZ2j35TMUPMjbgkNlMZAD2O1unzCsQlxwsHbvLvAooTl66bMs10sRXrLbjbqUM4jdUQ5onS8663wJZ5n3LqKTyg/JLAYbyq2FeA904NqNnF+LMZHJvVX0mjXo159y5fVV47ogwVzxGF3HXImR7BirFdQb2MOWIut7z/HHxA3X4mVndIO4BuXftL2Hiqatyp51Ch07Fgf4rBcQFNVscl4tFzNGNSkcdWb6c8zeKQlNtSkZ0GhtgvuE/BcMWftdH2W2xSs02NBmKilaqjneyu1TpKzBmpKAe5HPMOmZoG59IEW+qf87mVolLa38l7ndUBO9u5Pyzc/11vg5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by BN7PPF08EEA05B5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 09:18:49 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 09:18:49 +0000
Date: Wed, 12 Nov 2025 11:18:39 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, razor@blackwall.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vxlan: Remove unused declarations
 eth_vni_hash() and fdb_head_index()
Message-ID: <aRRQ78_GoSytFyIo@shredder>
References: <20251112092055.3546703-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112092055.3546703-1-yuehaibing@huawei.com>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|BN7PPF08EEA05B5:EE_
X-MS-Office365-Filtering-Correlation-Id: e4372a78-65fa-43eb-93ee-08de21cc7d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9mTPtK5fhHCGso4xYFiXud81blO7boJLl/XvB0673upR9i6VB3QDIxvL1B7G?=
 =?us-ascii?Q?cCYiUn3JvqQUVr5Xl10kGo+ElQx5d1+HMLVuQgJkt1KP3xkAjHPm1ooeJn+K?=
 =?us-ascii?Q?qcy98AKx9ZoW/TofNYOIVXOd8BiyvRek/7tBJQ+vQH+kmzoWHDZ8Of3e/Ah/?=
 =?us-ascii?Q?mOT0Q95Q591RtKBFslBMiRnzhbuQZ5s8UYuGfJlgU8wabnj2AvGnqM/3B2dp?=
 =?us-ascii?Q?msCbsadfhJE97UhmH8e5Sx1pSMbZVl2lmHQVGrV3sviH7eV7doXvfN1mR71L?=
 =?us-ascii?Q?lrStgqTcCCwo2ZywGa3NYTDiTr0eDbMHzQGY/Sg6cM8qMY7OxdagriH1Ne7c?=
 =?us-ascii?Q?eivFlCYOURY6bP2znYOVtWohFUDShbQxZHw32sElrUFmj2k8MdY7O9WEgHfn?=
 =?us-ascii?Q?zAGJzXRI4hsRDbwbm2Gqhv6OTj9GB++qM+ArZ+dddNnp6Xf+kodstOI2EI/2?=
 =?us-ascii?Q?oKDcNjmcIWB0vZjiuDakFOPy3CxLjIwHv0r2Ro8eCcRJ7s8Qb1mtVSpTQCRX?=
 =?us-ascii?Q?ivQAdyXn4lr8BZehHKOy8d7WzyBxkSvMVAKo/9V1f2xY9ONcZH42m1jXCaUI?=
 =?us-ascii?Q?6lviQlLsC6uAqkPH2iMyGKob3ezaP9I5JPP1/tHopDiK+TCFHwgCyRn90buW?=
 =?us-ascii?Q?2CXhX1/RuayHbReg5rSMpGMfjK92uZCiz8uzSa+vL56pI2N1iue9ubZyZDNO?=
 =?us-ascii?Q?GoaHm1p3Zc6L/uEs73GIaufHL1MNEHYu5dpB9+g/kSFhlvQcwfo/zrRn/J2p?=
 =?us-ascii?Q?M/NAK1vbzETdhx1g9etSesuFq7VRb+EmiSnYfuJR94DAOdFFgn06e8cH1xCM?=
 =?us-ascii?Q?Eu3AAffE1U8HUs2t9QZDtuWXRn2il0kdLxk0BYz0UFXsbWNjRUWPaNhvp9O3?=
 =?us-ascii?Q?xhEwAS3SnlWIS3vjcdVCiHAjZxeg4iWOfPDQMgMfiH2A0yLzHLYp52EIeYBL?=
 =?us-ascii?Q?DK0GPAuX2V1i8KO7rQrg0GWtxGvb+e5tz/udssQagGOqDP3o0Tvld9m0IZ27?=
 =?us-ascii?Q?qWMLOL0oaDc6qCsxIR/7eB7gjTkWsUOF6mSlVTKqYtWiPSLcJj/TC/LU9uVi?=
 =?us-ascii?Q?ywJNC/wpi8+ByCeUX7zbLOLR8gjAD6O9D8ZIK9s/qfZ6zM1rwVljQDxaTpGm?=
 =?us-ascii?Q?C3BVGAV8O46tFk0hU5+7MasZRrbiq/LXDVk2Nn9YZcS5u9fy/FpmfQvnO/xW?=
 =?us-ascii?Q?zrokpXKsY2I12uX4yYKok5Gjho2kFaZUEDD/HbYW9/cwbYluPy3gfiq0Q8jy?=
 =?us-ascii?Q?dcGtiKdlDQjK/q/XfM65PzIIqwTtt8qYpffLyqoPzXi1OXNwhRi8vyhZql0L?=
 =?us-ascii?Q?lqkaEHhnEYKRxn7oJF6LB6zwZnM4UImzO+SJ3b+vpQVyaucFIHT2rWVPtqce?=
 =?us-ascii?Q?kLpbVa15pjnHbHGBFAA2ANLjdxtldJ2olnFb7ydxTAczB/wEjADu4US0JXRM?=
 =?us-ascii?Q?Y/b1QaRSkzbJL3LFrxCVvC62UuENLpBA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F1VZtJIsJ2ptMKwyBjjidp78VjKhebuXPHOw+9gNqc3I56EJIqoH9Zqo42gN?=
 =?us-ascii?Q?0+z85DWYs4XfaEGpQ8mZgpIeiwiWMmjR/Z255ajSaOJo3UK6mrzk0JgzxUkv?=
 =?us-ascii?Q?BG6GAr0ol1sQIHK+97a/TFhMTnChAvQFLDWKbNs0EdPXyd8pxHlbdC+Ds1aa?=
 =?us-ascii?Q?x2Rm/5Dy51jTG+JofPlkgxMrGqQhTV4Um+QKxaZEaShlmRXtac++XK4zIZyK?=
 =?us-ascii?Q?d8uzTANQH0A27aq7OUWWVZMnobMHkEU5ehWBrVuexYzHDo5kohzKDQ8ZfftS?=
 =?us-ascii?Q?vvLfURrFkF8qq5nQZfrPx/vbUvxfrLcJ+zDQk/z9s7d/dURmEut+98j0+CT9?=
 =?us-ascii?Q?ZUesKt9p81g0q4MrKyfWXQ2qS6S9/oHx1CWuBFyMKb3vV6iYp2z80hrQ6gMx?=
 =?us-ascii?Q?669dt5mWjgiY2s3OdWPNqyUDr/YOTeFjpceuCW5VfZ0yxjxiHlTq7J9GSOW3?=
 =?us-ascii?Q?XHqkcTy8AT0PTx66JXfbYIczceExCaBfUT5fJ9RHfqRooJiQUxeJ89o/MtdE?=
 =?us-ascii?Q?SI3T/4aKheSxfr8H4W5V+oROmPiPBWz0zn9NbXyzCUX4Vnse3e3hdyt2X+Xl?=
 =?us-ascii?Q?eUtPm99WDmo6/Q/kdQ6rgwyw8W/j7K2tomg9cssvhFJqNs/lqcYpSj8VtSkP?=
 =?us-ascii?Q?iX+BRArIRigRmgvRXTa6kvX+FQBih4d9p5LWqHlmWN7jyVaBpO95X6L7rLMH?=
 =?us-ascii?Q?rcneMYvN1m3Mv6975JMbsLw2piehRtaKhOy6W2gw0qGFDiQLfcK9B64toXU4?=
 =?us-ascii?Q?i2U2x5uu8yNFxDpZN7fzKhTbnqaJqLQVzQMkeSnMMP8U0S1IFe/UgIILt0k+?=
 =?us-ascii?Q?ODMmNA/DDtRumkAhQSGKR3D/mZPiBVa+gHqzpy4my8KXV8mJZlb1JqTj+ng9?=
 =?us-ascii?Q?YsYyg6byghkK+sr1z1+CLXYu4beD1dnrCQzgcmhDHyjet8vJrJCr9avunPCQ?=
 =?us-ascii?Q?gGBv5GQNvGqlfgT+Ih1WTDJpU2fT3InZ18h62LwaYE6dXx+ridIXtextMxsE?=
 =?us-ascii?Q?d2AAHhXMckhJGa3tR9vZlT2HQe3s50ZFA8xHy6JrlwbvU2txcIrxVX6EDGl+?=
 =?us-ascii?Q?pZRRwgtJl1Z/ivA1fofHk5a2PU/8Y+9FBIPses1UOv/bs6akLT50Iy3IS0fH?=
 =?us-ascii?Q?4KJk3pN1oBthrni08RoIl6x27YTgMUwLX61upFXcJ5P5RPT5LMp1MgRXPy44?=
 =?us-ascii?Q?m0DrbqevYxXX/D9BUaFyA3VHATa7CLjNb3POO4k1ZqaHsS0unWZqSxkpkpy1?=
 =?us-ascii?Q?8DZ4z17f2V2detHjP7TvoEqWDehxbB+H4VefJdMHQBvTQsIoQaEl4VsJOF8+?=
 =?us-ascii?Q?Pph2OsR3lVbb5421Ya8zXXyFZeHdrjeRQmdftBv4/ws7RMHifQQLA8mv+e+7?=
 =?us-ascii?Q?YOsTjyWFq8qdA9jDKqhrWF1f+ApA62eDQ7eM+9SiIKi7vhVFViGkL+rKtlvP?=
 =?us-ascii?Q?MwJKMOd1/6HW00kVMHsAsLDUvvjNIT86a8D2z7B20EidbELQQ0sdbUh8WS62?=
 =?us-ascii?Q?RVBFN5wz4HCApNcMUVsF29nktPjLI5n2/yCEXL9u3YVNaQU9pePl7paaE91f?=
 =?us-ascii?Q?dBQflvWVibZ3uu2LDgBrSKZ8jfBl5Dwm87yuEPgw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4372a78-65fa-43eb-93ee-08de21cc7d25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:18:49.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkde1iykWr03xZwit4i4iHu/J1kKNDzOdQ5EpvpUflcfhDBA3wEDhDSd7ZkjDMnJLhtI41GAGfCQC1BMGrUgww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF08EEA05B5

On Wed, Nov 12, 2025 at 05:20:55PM +0800, Yue Haibing wrote:
> Commit 1f763fa808e9 ("vxlan: Convert FDB table to rhashtable") removed the
> implementations but leave declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

