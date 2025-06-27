Return-Path: <netdev+bounces-201952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A6AEB8E8
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4D416C4B1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FCA2D97BF;
	Fri, 27 Jun 2025 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="rY6u5fxh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F9202990;
	Fri, 27 Jun 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751030946; cv=fail; b=nsM+aaiDw+99C+kSokqY5WNeXsXk7QPebETnVbie4ZkvvAcuqoI5wFxIXoBmC7Bi3PeY6tVOoJmIEMpYjzBVqIfVrR2my/8wP3bcPufsNPPAVM9CuruM0BJR3GivvrFRcmSHYLvOKxVtBzbiKFwDRdD3nmPaYYUbCSH8VVqrJjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751030946; c=relaxed/simple;
	bh=g5a/g3j5islOZk8iLEJ+5ZbigB9MToMdp98OnLGEpN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsLlcNrjfErsjVv/N1g+VEKGkDGZaSqnQ0l92Oaj/uAkHyf2Fyd69Iyz43hoZsKyJgCUMBfOPlZXjRnbNEo4zKtbc5HGd2dtJOhzZlM5r2JQn+5pf9r8PUrPX3M+fmGLAsoS7s625SHtdm4t7W7MUz4gL+/HavxATwGfK3hZwXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=rY6u5fxh; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/I+8RlvOQ1TFioC7MSPhr72b1m6BBSx49Q+MupQApjYfFTYg++XcdzWicNOe+2nJAvf22AGb95Uw6WBAlYvr9ecBIJF6JXfTFPnGHlz9Q7Q23CQvDERBGC6kqxuJA1oyVmBe0f0BKPPwUXSskRWLuYickXkJCUYsmHHRLlfGQUOMwNR7eHvrE4O5Qvu2TzNVtNmWhyA/tO7+ITFaQHmRNxLzztI+ISHzV2ItKsZt2V/RkH1zA7mn7TRz4Fhfv5bD5sd/fvjoGt6qMM6vCi5Oh4RVtXImS349/QtFufWjbI9em+kl6RDKtflVDWczhCGS6tJtgz4xdyQcEY7tx6MYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eF3N9Hs4FL4yAT9TCiuvGagJDX1oMXKdzIIQJEohH5g=;
 b=RFqACo3T6eo983XGYO+69TgGdHndPDu/M3HiUHx+drVyR0wm2qmSQO7Gp0Z0+W5wY8gEtidKtcrGTATQ58O66ie142yXXiWO1eDi/iB72mqtim8n6mpcsNO4FvBidx5x+K+OO6HGEdCDBuZZa5UCyNvDP14sQaaaAnmkXG7g9PCv1PAn+2zpVr/3D8ap4lpMnacWkTSVBJ+UHnbDVhCAvXPcw5lN/mpAHW87+j5ZCV0YBQjxAiu2Hr8mOKnAGzVzKjymRBBKtPLD4D9POpFxVo1ou7p4HcYn1eEqsvNQt3vvNaTkcWF7HpKR2SaSB7w56LR+h7wASGrpuMlPfYHEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF3N9Hs4FL4yAT9TCiuvGagJDX1oMXKdzIIQJEohH5g=;
 b=rY6u5fxhTkwRVJpIjnSo5+kzu+VhZpbZWDJK2nUKhSRML+kZb7SaXJK0tP2fQJtJWhg6PLBL63exa7PocxQzbmdop+uuhuGs8puNGrb1cOBpBp1/ltljIouOLcqhIA+Eh5Y9qvPLRP3MzpAf+6WnDMz5UsMblDJ8xvXHgsDMAvXL7NaVjPeh52zCoyu33+WmOqJZ4N9qy4zyhQjQiSLJ9O9AQyLsJVILiRwuO2SwVn9D+Cm4JPuLqdvPD5U+GfKSnH3C6wEoPVrNcbo4kfMxwUJPWd1bBzBmAcJW2gz2SiFW7mzhILlcIjWKhRv5jhKCLa+nymb+x9HWnT7c821xIw==
Received: from BN9PR03CA0713.namprd03.prod.outlook.com (2603:10b6:408:ef::28)
 by SJ4PPF1419DF580.namprd22.prod.outlook.com (2603:10b6:a0f:fc02::f8c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 27 Jun
 2025 13:29:00 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::9a) by BN9PR03CA0713.outlook.office365.com
 (2603:10b6:408:ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 13:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 13:29:00 +0000
Received: from b3410ffb93c4 (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 26113D04CB;
	Fri, 27 Jun 2025 16:28:57 +0300 (EEST)
Date: Fri, 27 Jun 2025 16:28:56 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	brian.ruley@gehealthcare.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH v2] igb: Fix watchdog_task race with
 shutdown
Message-ID: <aF6cmKkrJSV_AWBN@b3410ffb93c4>
References: <20250603080949.1681-1-ian.ray@gehealthcare.com>
 <20250605184339.7a4e0f96@kernel.org>
 <aEaAGqP-KtcYCMs-@50995b80b0f4>
 <20250609161039.00c73103@kernel.org>
 <aEgokTyzDrZ6p4aL@21d8f0102f10>
 <3504878c-6b3f-4d5f-bcfd-2e7e4a912570@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3504878c-6b3f-4d5f-bcfd-2e7e4a912570@intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SJ4PPF1419DF580:EE_
X-MS-Office365-Filtering-Correlation-Id: 87785b0e-7fc2-4728-80c9-08ddb57e93ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LlOMpj2wl6MHqXIohAaBt/14vdhU5MeMTR9HDwx2dT35z4dXcMCgkmmjh0/W?=
 =?us-ascii?Q?fy8v84ZwiO7eZ0x6kb6gvPPGXRZ2XV4nhFCqxVvAZ2Lruq4705jeApiq96zI?=
 =?us-ascii?Q?uSQ1OS1YH18n0PbdIMvsnQrIr+fGTSwEcbmAds/8/f8GHG4syHb8xlj/Yoqp?=
 =?us-ascii?Q?5JJitnP0G98I3LuHUn3lZ0g2mTHnXA4pn4nZFEJwfudHoWLykZqn/O3o8uWh?=
 =?us-ascii?Q?jSrFc9aVcp32v4DDnFQJNK+Z0j5JXR8N4vgmtVIRWn5FEFqoA9CbySLa7M53?=
 =?us-ascii?Q?v5l2gMZiINnM8R+TcjB+QFaAH26B3wGVyHawjj+6h7Ig7cGlsxc/aT7kJk/u?=
 =?us-ascii?Q?HmZHDBxBw+cNT9k6aZWTIzbXjlmQpASANfjUDzGJSiKKBkZCVnyVt0yI7OGG?=
 =?us-ascii?Q?SzbsDgmS2AxU7yDHkvaTpmqs5JWAQPhaA74u3gmkxDRIPPA+1T43N2PGWgqb?=
 =?us-ascii?Q?2QEYe6Yy+AomoDnemWe2RGkhynGR5iMVA5Diva5/NxrKZIq0tJ9E4I0bALw7?=
 =?us-ascii?Q?UDBP22CypDDYbJJD7syakXacLqPkQsnqIO/l+rj7CPluPOY1CjI9+HXxTW9X?=
 =?us-ascii?Q?S0WWobIOK18CZE+BBdRXjDgosG9axsurMaOYKOl2KMhkdEeQVUIdeheZN9Ep?=
 =?us-ascii?Q?PxH8qER7Cew44ii2vLHNdZz/U8Zxci/5uxezlXOXtebDQe87lqGsTrtWCLty?=
 =?us-ascii?Q?HalTyN+cjP6CyGrX46NPIYx4TthGfUriYxpLbQsDyBjf+Mzn3sGjMur0RHlL?=
 =?us-ascii?Q?giQH8kKT35hVt+YBDxfUTMxh7oPushHai+XsDaXZrVECQ29Un1XLk8KOKM6O?=
 =?us-ascii?Q?VH6sOO2i1+qvj+HVTBhtKv5a5GVgZoeHX/Sk3bzYGvoPtobHYEzwJfxXDVsF?=
 =?us-ascii?Q?GrmL6GTE3qJlOi3d0eo/FhxzjWt30VZ58wzCodyQRdTabQnDZwtJKX+HivSZ?=
 =?us-ascii?Q?tWhFKwo6BYKLYkaMiJDcE0JmUSX9JFgSOeRgbTBSMgFbKwPttmcZej9gR02x?=
 =?us-ascii?Q?cxB0LfhlHmb/J+V/tgrfWenOqOOFVSmOico3Drb2jHTLYYNBp6/oN0AY/PAS?=
 =?us-ascii?Q?5lnChSfQBhegXP/JBrh+KFFme4SgLcSphNQiboqYljtczACrvKxKaLmLX442?=
 =?us-ascii?Q?4ByG2SYngfVirA/Gx8kxWdN/+MmF1MAIdu+omBYXiVjIB5GKqqCRbwDnxH7Y?=
 =?us-ascii?Q?nQQXwtZPXRz1ZeXw/wPljQioc/nd0a8c01uXwlbOFFasjN9LLKb54f2KHBu1?=
 =?us-ascii?Q?cb2k5UDFH0oTn/N8+umEpMtbNHZMtTJGYpyQE2bcoxIfxIyR6IQvhC7Sk5nC?=
 =?us-ascii?Q?f+cJBBJpDF31acM0Et+m+SmIdXPyuAsxGq5sIdRDChIy9gfRZw/MrV0KO7J4?=
 =?us-ascii?Q?pJsHVfa7T7PyWOYTYaH2yuCLLH188tBwD86pUErDt04azVGL2tg9SKglx4y4?=
 =?us-ascii?Q?2lkt654fkdGf3hQlKetg+nRW365Z6XaQc1DllW56t1TZu5zUJASCVWGh2FMK?=
 =?us-ascii?Q?9XqOp1Ta2eV/gBOuS9SPuZzhfWShMcALAqe0?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay2.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 13:29:00.1638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87785b0e-7fc2-4728-80c9-08ddb57e93ab
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF1419DF580

On Mon, Jun 16, 2025 at 02:47:29PM -0700, Jacob Keller wrote:
> On 6/10/2025 5:44 AM, Ian Ray wrote:
> > On Mon, Jun 09, 2025 at 04:10:39PM -0700, Jakub Kicinski wrote:
:
> > IIUC set_bit() is an atomic operation (via bitops.h), and so
> > my previous comment still stands.
> >
> > (Sorry if I have misunderstood your question.)
> >
> > Either watchdog_task runs just before __IGB_DOWN is set (and
> > the timer is stopped by this patch) -- or watchdog_task runs
> > just after __IGB_DOWN is set (and thus the timer will not be
> > restarted).
> >
> > In both cases, the final cancel_work_sync ensures that the
> > watchdog_task completes before igb_down() continues.
> >
> > Regards,
> > Ian
> 
> Hmm. Well set_bit is atomic, but I don't think it has ordering
> guarantees on its own. Wouldn't we need to be using a barrier here to
> guarantee ordering here?
> 
> Perhaps cancel_work_sync has barriers implied and that makes this work
> properly?

Ah, I see.  I checked the cancel_work_documentation and implementation
and I am not sure we can make any assumptions about barriers.

Would two additional calls to smp_mb__after_atomic() be acceptable?
Something like this (on top of this series v2).

-- >8 --
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a65ae7925ae8..9b63dc594454 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2179,6 +2179,7 @@ void igb_down(struct igb_adapter *adapter)
         * disable watchdog from being rescheduled.
         */
        set_bit(__IGB_DOWN, &adapter->state);
+       smp_mb__after_atomic();
        timer_delete_sync(&adapter->watchdog_timer);
        timer_delete_sync(&adapter->phy_info_timer);

@@ -3886,6 +3887,7 @@ static void igb_remove(struct pci_dev *pdev)
         * disable watchdog from being rescheduled.
         */
        set_bit(__IGB_DOWN, &adapter->state);
+       smp_mb__after_atomic();
        timer_delete_sync(&adapter->watchdog_timer);
        timer_delete_sync(&adapter->phy_info_timer);
-- >8 --

Thanks,
Ian

> 
> > ORDERING
> > --------
> >
> > Like with atomic_t, the rule of thumb is:
> >
> >  - non-RMW operations are unordered;
> >
> >  - RMW operations that have no return value are unordered;
> >
> >  - RMW operations that have a return value are fully ordered.
> >
> >  - RMW operations that are conditional are fully ordered.
> >
> > Except for a successful test_and_set_bit_lock() which has ACQUIRE semantics,
> > clear_bit_unlock() which has RELEASE semantics and test_bit_acquire which has
> > ACQUIRE semantics.
> >
> 
> set_bit is listed as a RMW without a return value, so its unordered.
> That makes me think we'd want clear_bit_unlock() if the cancel_work_sync
> itself doesn't provide the barriers we need.
> 
> Thanks,
> Jake

