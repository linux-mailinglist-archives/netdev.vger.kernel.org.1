Return-Path: <netdev+bounces-199375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C68ADFF74
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB327A914F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119E725C810;
	Thu, 19 Jun 2025 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="bOw8GLlN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2119.outbound.protection.outlook.com [40.107.100.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D34229B02
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320703; cv=fail; b=tkCivB3apNa6ELWoZM25Mk23MWmmzHf2HtazLcTgnCcU/1JvweHIl/VLfp+KXOklG4wfw0S7/7nsaOcIkZfADyldw2+/CobVnBEcBV+HVzHGuNS/URoGxHRTSxbcIbImHnHMF+KvDc+FvKoViA2ikKNdTazoQqpBODDZK3Pa0tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320703; c=relaxed/simple;
	bh=a1yAJAZKkczHWQIBf8X0BdKDca/AMuA/QrNo+PcFGUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C1UEV9TKnc2lFiUyfLXCy7UGSiTBHYdZWXJDltwT5F5yP4P2zvcfSl9peXjywZManOuXuwxhQe5J9AQAS9tj+wfgMEHAsO5xGi6567bO7S8QVpeA/GrdyHo/rYyVALeYkriN3oV7nPlIkvmuUBBSYzPzhgXG9uxEhvBjCsrkQAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=bOw8GLlN; arc=fail smtp.client-ip=40.107.100.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2Tj3c6iKnsle4Hmk8x6SRtYIByhL9MMJKejfY2I6uQ95JgvI7yVUqqBOhBjj+AVM8gj0d2vl44rUp4XznwkXo1kazcTld/awM5GIoEnL29RQxgRFYu/HYr3Z/IYRMQlZyM2hbaRYgLnSZLbIACCvCeZt23XjV6fgDIrGGi7gdu9RG7BC9SFA8hKApRu5GJ6PpOLoQ2upTULkKNMy1C8HOLISAz11T2AZZWZ4LgkbPN/aWE92nzCM5LRsPCDNfjLm/0aBbpxiqqktzId7mzJHcTuVK5e1qyQuufyWik3+OP2j/PxKmqryHdrxgkFUEc8MLSsRo9s80a2POTQ0Fa6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UI/S4IjcNoPxUj2UPi1EZ3C/SLstyAV0fOLCagAyQSg=;
 b=n765vY8pnEnvAaibPiH/UToyiITkQW9aMRW3h4lLti7RPEEtIJfYuK23zkNf9jqNpq6B7ZEZ/403CJXUNr+bEwYx1lfm7PlZZBkdcyCkbiF9Ps70nqnQdqQ/Y58SqJGB0pyvnVnMimoi81A+/rC3Ow+iL8WYamiVZzxl+x7C056EFYBumcEwusZSX6SfcNxpqDYbd7iAEmoZXoEZJ10rlPFvymMwFRq8glqB0C8MtuZr6MoFSRyxaOAijjLF29T0Q/cqGCf/4Az2eKSl6FBm64L6hgb5foCLL2JgdYODAqIQPVTqvYX1JnZf0YO76PnLf3xjd6KJBWn5wGYmDdC7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI/S4IjcNoPxUj2UPi1EZ3C/SLstyAV0fOLCagAyQSg=;
 b=bOw8GLlNZqi6QqvXjWcrqONAgQEUtLjmv9A4ISlyXefH1ZITXOY/3RJ2XsEksF78ibiSD9IdDCAB6D9XwbmYHqvNYbo+RKx6M396wwGws6UZBFPu14tL/0KojUqyXh02m0nJDHCqkvcOS/u7Z5gP7gI+2+wrKOsEcDmXIJTOq5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by SJ2PR13MB6168.namprd13.prod.outlook.com (2603:10b6:a03:4fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 19 Jun
 2025 08:11:37 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%5]) with mapi id 15.20.8835.018; Thu, 19 Jun 2025
 08:11:36 +0000
Date: Thu, 19 Jun 2025 10:11:22 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com, shenjian15@huawei.com,
	salil.mehta@huawei.com, shaojijie@huawei.com, cai.huoqing@linux.dev,
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
	manishc@marvell.com, ecree.xilinx@gmail.com, joe@dama.to
Subject: Re: [PATCH net-next 07/10] eth: nfp: migrate to new RXFH callbacks
Message-ID: <aFPGKj4zoSMVQYqL@LouisNoVo>
References: <20250618203823.1336156-1-kuba@kernel.org>
 <20250618203823.1336156-8-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618203823.1336156-8-kuba@kernel.org>
X-ClientProxiedBy: JN3P275CA0055.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:cc::9)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|SJ2PR13MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: b18a5b19-de74-4adc-8336-08ddaf08e8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lovXlTMve1tEJ19cDUcXNp+EGXEbPlaOGd3PsoVv1R5/854/d3LPisBLfk3s?=
 =?us-ascii?Q?aAWfFhbP07uMH0KrJ6/ysRJ8spn5VUIW7qSgSzUpdQBiAOAnho3vCJXAD5Su?=
 =?us-ascii?Q?1jVnUlwFKNjoMcySS0pt5h4LG8ZVVLRYQm+zZ3F8qmHhcxLNhaahQK+5kP7U?=
 =?us-ascii?Q?fKUXFWPZU2TByTQd0bAiygr5tGkzeKqhjYUy7nLUCODZ6dhtMqmW62wcbVIo?=
 =?us-ascii?Q?CCBG23rgTuVc9+HdKhw6oe2hy8cUaruqO32sJYBllKgcFySiGSCOzYeJJey1?=
 =?us-ascii?Q?K8YC4UEg4osMt7sIQR0p/hGEZsFrWnZdEDqi2bdKoK/5j933pM/p08lrx2Pa?=
 =?us-ascii?Q?0gEjj11rgLNT3jW4GoeOoYQui1fImi8CQsiNK7+EvLkBiL0H81IkY9QejpwB?=
 =?us-ascii?Q?am2yA5zsRJ7QkXNdV6LoCh0GG1qvfL/8Dg5CiSUNXhqtLXZ4zn0pXPVBh0AK?=
 =?us-ascii?Q?i4VVGSyMRxZleJTs2X5eZpWsnMOYPc9lvSjJZOkgaTv/+BzD4RgqkIY5PciS?=
 =?us-ascii?Q?ZI9rEvEsQfPCUjvw8x8zVt1gH8fvYgIgkiazD7yAKN3l7Lo7AIbFPwB8UR+d?=
 =?us-ascii?Q?S4+EJk2hHQUTFezAZvqELhbyT3WlTDCFDfjKdlhXgnH/LtjCZc2GMzLz+hvF?=
 =?us-ascii?Q?/Urw+dGf/Y39nUSKgl0S7BdhUrtNykbRGmKtK4kFPJIUkeBQnI1eidtTri+C?=
 =?us-ascii?Q?QmSHViDsD3KBiXOjvcGYQ/BUEWr74BtHUfY6X13z8gHf/p3uTLYJjIWNdp3x?=
 =?us-ascii?Q?mpSDjCgAutB4dCslfE1OF1N+WEMpbbh5646YSdbIjuve8fpz89Il4MI+jmKh?=
 =?us-ascii?Q?6m+PF9hi4pt0OSxZFqhWQYwV2b2Iso6r5lyjw30lWNp2vVULpmi7ZYJVk+s1?=
 =?us-ascii?Q?qfoLIWkfr7Hje42N4YUDBuyv37a7eftbVTrHqre8eUnoG/dQ9i3JBoKe1DVK?=
 =?us-ascii?Q?L3vG126g7mZ+KXNtlE1RuanufmXAU/plX/bqv70kq0wnOmq7spqWuFAC1U3V?=
 =?us-ascii?Q?LZaTaE4dRD9wxwxE9ZDruMM7wUqFbYdLcxAd6uxL0hEhiCIzyksAr3BKG0yF?=
 =?us-ascii?Q?eJ+i8E/8gQ7xQP+TaMVTtOhuwlT+11f0TdFOCAtGFQDA/68H3IDpQHmMzkX2?=
 =?us-ascii?Q?7S9zIb+HJoC0sggaDlv0h88YhPnCe/MEosJyXrzjO1CRKcUeiklyjoI5W66h?=
 =?us-ascii?Q?NP9y8jUWGABGOFCDK69U+gTVjpDmgdOvfPUHyVyLFojRpnwozJoIVbSYZ2/A?=
 =?us-ascii?Q?E7FZMu+39GMnc0pL0oqK5r3Oh3aH8FrG6d4pmedDzafeNoUxtouXUv0uiIge?=
 =?us-ascii?Q?0ocvOaOspaeJEp95TlFPs5zJsJW7pLS24+ciLS20YxH+uiTZjTgbrS3RkTy1?=
 =?us-ascii?Q?GfJtBgBYH15NsRPvqSJZ2Of472zvYQkNztjDeKL1StHs+ox8BrMCEU4b+rLo?=
 =?us-ascii?Q?mQe2NuX/skM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?595SmE2YwOcZn2tNPE9rNbOG+70VNwKy2J93LeDmQ9c6iihG/pUNQ7ljVGvn?=
 =?us-ascii?Q?I0wGU+uDNz9oMNcqtPn1wNhq3Pws0Uy1dL/Oyxm4bbJQE5uo2vXnv8z+r+ke?=
 =?us-ascii?Q?vhK5CuVQV69b9CE3MGIMLH57TVdYPz2gtYLSnOf5eV8qRm0ZYOsaDW0+NZoH?=
 =?us-ascii?Q?wb5NErol2pjDenU+Ccl8QPp4WMrNdCAJ8eTI532HwmrxyXoInVLj5AEZlcAO?=
 =?us-ascii?Q?MsZmf+0oDQXLYfQUwVenJ4e+GoGhZIFjC55CwSxMhnjw8gkeK6DBBA96K2hk?=
 =?us-ascii?Q?9NgCGWsJJ01b0dMvyiiiC2VRN3Dr9Y3ksyo4SYi8pJjk17dGZWyxNRQd4Zrd?=
 =?us-ascii?Q?j7HsOejbZwy2deEwCqjmyZLHqProZ5QbF693Ej3v8eMcNeSd7GvEgLNPakkx?=
 =?us-ascii?Q?q7M27/7wiL+knhc43/Lvpvsd/MBrvqtNyAhidvfIHaRXs4MUkTyr+TWpzIet?=
 =?us-ascii?Q?YjbPWzTq4Wie8UXEIEDA1n37Vat9wgk65ndNCq2ssAnaUZtuI6gXLwY8LMVG?=
 =?us-ascii?Q?P3g8kmLy5VEI5IXcRJe4/6XnfB4/CtZv71MrnxVMcdnmOg+H8/IegS1bRlWn?=
 =?us-ascii?Q?TmqhxPL8ixFjL/hxfd1IzhU1d2csNmsIHN+qcLjAFcs5djH/RYngWStNmq73?=
 =?us-ascii?Q?gDzR09VY65nW7MMXtE82tok9f48fcof3QtCw/yWtU5r+OIrQ9gZ4Hjir+sXz?=
 =?us-ascii?Q?yrFnu4v7uXp6pSA2HIhBII4vLuuDZf8ueabGtg4DT6OL/nmuuVfmasZP1SnP?=
 =?us-ascii?Q?0YW31xnbwrhriIHaNo8Ai8ssB1VPlfSsnye//IEAdXxACSNPAEsO/wYcYu7z?=
 =?us-ascii?Q?x8YPvBsxrno9zNAH5DSFsV9EVa8UgJsOxxNogTsZ+/mujwEZrSAvbuqyFurd?=
 =?us-ascii?Q?GUI2VzEoHzoWlbsJ7bgXwa5igdPE5SEWED5aMzwbpqb9rfvLJiVVIrr68Mfn?=
 =?us-ascii?Q?w6gQ5ZS3oj8pjNdcNE+53lZXQfyO65dj2g00QMWL+KbJh2oQPB+iCM+i47tm?=
 =?us-ascii?Q?iJ3HDFt+v4mYzS7DPVy+BZ3XGikyLvJgSzbN+bQY96ReeznMxdSsD2SboO9o?=
 =?us-ascii?Q?dc6wW3k55zQtc0QbSn+iIQ4I9u8zWDXSjTB9F4CZ7+uWWvAlw89jQabSUMn1?=
 =?us-ascii?Q?h3y9tvXps2zG4CL2DKFTEDSW5t7SD5/PxJFCy92vl3liSSTLCgMwH8th9VdN?=
 =?us-ascii?Q?VbfNElIml00pYUk8b8NCi7Vw0KSXp+DPxiycpbCXvuNjZdtZgPe/3R0r0wWJ?=
 =?us-ascii?Q?ZtNRWmyqYuyQCimTQkb3T3RX4kt2/qrvTE6nPnAAPLWlLAEa1GiwxnrIpeO8?=
 =?us-ascii?Q?HlIOnhBkPJtkuUMSrhx2KxK1DdhbdSVAWiseKgxTVnwKj3klwaSXTPiwP5Qc?=
 =?us-ascii?Q?qYJ8vLG7iBi5usjNrz6n2L0rPVU64gFkoMLZ6uz8im+/aaXuKMLVyKoJmrN6?=
 =?us-ascii?Q?9d+OADkmGiE8vTGlYq8utfdv7BQetDct5CEg6INXyM97knHb1V3iUjbQv0Ke?=
 =?us-ascii?Q?q3Xce9dwsifmNGmL1L9dKV9B8gTV5ho7MovJ7T9CiDk6v8Ell1u499mdFVz6?=
 =?us-ascii?Q?mFbrYntHTtOG4aTyRqxVJi0JigcS/XgJ7OXDOnwPpOYKZyHZlSkVGS2EOz4e?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18a5b19-de74-4adc-8336-08ddaf08e8c4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:11:36.6582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INPVsDs6dkAECqnV9EJ9etVLdjdTv35/3qJkelw8kplDxhM2IrJZQvSkARtf8q6MrfSKhoANjgndguKuOqf1W+u05pcfHkuxWKajhegTgW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6168

On Wed, Jun 18, 2025 at 01:38:20PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../ethernet/netronome/nfp/nfp_net_ethtool.c    | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> -- 
Acked-by: Louis Peens <louis.peens@corigine.com>

