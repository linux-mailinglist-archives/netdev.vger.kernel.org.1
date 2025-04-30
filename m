Return-Path: <netdev+bounces-186951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2CDAA42F5
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42431BC3740
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 06:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28FC1E5B60;
	Wed, 30 Apr 2025 06:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="wYZ8EB20"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81421DF98B;
	Wed, 30 Apr 2025 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745993624; cv=fail; b=WLH6tASkyaMPe05mY7ZX69GNYdaRJzEd61oJgWPLCUKNb3L+dzFdiqBfaxbH+5sEE5z5xWBUatAcNgK/vSJECrR4B2q12wQflpaPpH+9mBa9e8YW1j1+22hVU8Thf0m2FCFSxWDD1Lr7Xk8Iz9z8Su1X0a9N/G2EXuM65qtovag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745993624; c=relaxed/simple;
	bh=Oed2qUEmOY/Ong6Ma6SY4oBtRaaHvxecnDlLJASCqzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHCA7BkWBQgwDPpWDwjLpSBbH+xc5JQTAI+siY/npUuUiAnOMynB2QbwBbqTHaKPzYrsNB6PeEkQlj+hW8W6J1K0cVDmeFRy+kUBm5Gkw1gcqtiscS9Q2Gl6J6foN/i150rXmEDHPFkTivShtD/JoqB4KfwTN86CrsrKtN76OFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=wYZ8EB20; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUgmKx88F9GDBPAea1a0IX0uN4d+BEuM6lNaahbW7U+vmUOhffKv79Ca6rn3j167F88DO9YKJ4jPAUACIB2f5H2XaFcHlvXRsVQC88kHYy7vRZM0XvKntj7j3kl+8AK5BZGQ8Fjxnqzw7twlCiCMxSyj0ZeYoS3/4dP7m/k1lwrCegb/amsKIKPvxJZFWsHkY+JJdiKCsd74XgwZ9puvbryxR4dXZ36jKnZd7KYTJpHz7qLmMsQwz2/wHvubLwV58OkCn+tv15V1ViX6DWGHJGPI0uK8OAvnUaQWRbV8QYZjpROlwt1DbNxp32jytOB6j5K7N2lLyy3xYWNCCqgCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeCyw32QqhEy6rLUjCRZJ8l6PfDyWm0B67y/uXdaVro=;
 b=fRZX47Y9rKWVklPfXk/UcQeuNeeaVcfJPssQTiN7o1kfxYTml3ksYlePHLEzzSXKHfiLXHty/jBnNXLwnXeo27bZTNwxAy7EL01OTllHNDTY5eCHDWbN4T1suXYpYN0bqgISpCOza7dULte0cyzcPm80QYqSv8P6LLU71WVXs99Cn7rzi96pdbj/LeJHp2i7egF8x/An9Bft+55sSUQywPeWDceSCQsQJdOywQ/NFfGarDft8qH4dx8YQMUDUqXxik7oF18S/swMDbqocQVm3oeJqhqtsvUo7mAf3Jxqx0DHxXeBzUv2bEYYPdqNToCzTBENhb6sM459QFisKsrF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeCyw32QqhEy6rLUjCRZJ8l6PfDyWm0B67y/uXdaVro=;
 b=wYZ8EB20vAkgIaKw4U4bSQ8lXA/JH95PiWdabI6sv4R4G5uKVjDtDy4FFbvsBSf+wmPIcF34u8hFs1/3bpWbOxYy1HWrvrWkg+7kqieHXz1tPnjoOxLUy5eRH4j+iFnxIzyzNUd9IBbKiqVgoMGc5FR5SUjaYqSFCxrkLxavT9liWuBxDmugpCGc/u9UgRpVJWLbkq7dfZMASrJGpz3ruIYq83GJXrogBn+eVp6mgNwCNJh/GTLlX3NTZ6T1SJPAqk50Cybdg9u4hdyN/yWTeaSPVKFpYoYevYqJHefV+oFlQ8ZzDiSQ0zCQ45Q3kRJCRQzLGGWyIlfVmKu4tY3qbQ==
Received: from PH8PR15CA0015.namprd15.prod.outlook.com (2603:10b6:510:2d2::23)
 by SN7PR22MB4026.namprd22.prod.outlook.com (2603:10b6:806:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 06:13:38 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::6e) by PH8PR15CA0015.outlook.office365.com
 (2603:10b6:510:2d2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Wed,
 30 Apr 2025 06:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 06:13:38 +0000
Received: from 0ec9f3ddc3bf (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id BB28FCFB78;
	Wed, 30 Apr 2025 09:13:34 +0300 (EEST)
Date: Wed, 30 Apr 2025 09:13:34 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	brian.ruley@gehealthcare.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	ian.ray@gehealthcare.com
Subject: Re: [PATCH] igb: Fix watchdog_task race with shutdown
Message-ID: <aBG_jm62ngj0Mqq-@0ec9f3ddc3bf>
References: <20250428115450.639-1-ian.ray@gehealthcare.com>
 <20250429152021.GP3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429152021.GP3339421@horms.kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SN7PR22MB4026:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a368ce-baa0-49e7-90ff-08dd87ae25c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T6HKDHg5n2OMH0MhPiuE6WxmraM0+pzlajnHdUDHqCQab+ixwe0VOiQzIeOC?=
 =?us-ascii?Q?2tpejVJor5dFSLUquMSjvMwuKRGwR2hUIf9YY/tdk+5ABYMkNrENtdEBN39z?=
 =?us-ascii?Q?i0W1Fled53SeUvigbqVnQAvbx+icW75mboKet+3KmQKcQGJZfRZdbid4aq04?=
 =?us-ascii?Q?VD9ZQNal0oUO61vT9Ljo3fI5T5eVDX/YHtkkYYanmgyGqjy9GamKWqGOUi1e?=
 =?us-ascii?Q?ehG+c4uV6VG5S5/+Am4QL5zEuVhSV+6OBbyvEkW4dbCtTCR+JY6Tyt+Re6gZ?=
 =?us-ascii?Q?npcbua8tpLUeoYCBakeeLj7be5bzRBOfpG4KDsBbG1gR7Tu0S3qfjAvK0Wl1?=
 =?us-ascii?Q?awwGTk3As8UieVa1b9VAHeRHGTpY9N06Ezw+xR4uEooh+gsKJqzksCH+1GWt?=
 =?us-ascii?Q?MSYhZEtkLxVQaCpdASmbBFdp7a5AKBhw3KbSo19HQs4ydeKCiOcMdo8lQVRq?=
 =?us-ascii?Q?CO/qEKBqqQY0PfsY3pDnAdkXi/La2x22zCdeWZ3+FnGHACs4Kci6r7lfqN2z?=
 =?us-ascii?Q?gO1ftlKDHd9L6CDvdQnT7x/5aaSUCtdu6mwGAgB77wNRpoSqiHcv2I0ttIhy?=
 =?us-ascii?Q?c3mTqIHEea/PDYxgI1mVEfIjnPvub+Vu4q5qdurMq4gaaOjYWTICH5H5BeVd?=
 =?us-ascii?Q?bs5pmasLFy3fuokapOMDLK7WJmf0yeMl1dstfyqSy/iCVQZTCZpfLPeqQi0O?=
 =?us-ascii?Q?nWgkDFNm8sR8VEAJ0c9pqZ/bAZ2zto2PbhjlLRx0PyOZfmxXD8rLhnukt8H+?=
 =?us-ascii?Q?4SitzxFo+4OOwGd9AGoYwxtEIv48lB/blBGXHL2n84Iwp4eerJKY8Gf19arI?=
 =?us-ascii?Q?27E13b0mQ8JkGDchX9MuczG7/fmXiX7av6KA08V41xwLlKJSaKhXGZ+inJVe?=
 =?us-ascii?Q?nakfiHTFIoNFznyhFX2pgpDi0PB3UYPTb76Sq6mPiK5SvNYeMfBV1BMeG/FX?=
 =?us-ascii?Q?hytJDrxdqDK7P/ljRTlGjbuMQnvW6AuauNGyhMHRWWtOd1huVuSNsDHa3dEJ?=
 =?us-ascii?Q?9M9ccsJcj/qV9qIDH158kuX1I+Ew/rYfciQ+6OWIoO9ixGiMRK+sZEe1h5bv?=
 =?us-ascii?Q?ZDbW3Z08akKrDZ9Iz4VzSAKdySi32xMkSzYbBpwLfa+hUvOHw41bXvlQLHSu?=
 =?us-ascii?Q?lDy3UJbT/a7DaDAFG/k9iqAn0585FzU8MdMDWCnd/0wCoe19mUynDMw+Xm8Z?=
 =?us-ascii?Q?qI8QmjKxULzVHIjNTtJgVI321ZPKe/iAjkPR9KcRphKKTvoOclF32/c/YS13?=
 =?us-ascii?Q?lFse01+wGnW/Zls2t+OjLf5OOQS/aqsfq6mAMSIBSHywc8A41GgHn6QBAvuQ?=
 =?us-ascii?Q?LUZUiuA/dnlOFC1X5cyuXvVZiK9idT9FUbmHbA9+8MctYUSimHixk+qEcoEa?=
 =?us-ascii?Q?RNZBep4bXco30xXy4rS+BWyPOs1QzGj0P2J/c9DPHc1qbX7e9tJvV2E+kBL3?=
 =?us-ascii?Q?q0nCXor/g+2RIhEujTgUYxcpBaRiMt6wAe0hLliHa6rvoGXlC4k9aWozexUJ?=
 =?us-ascii?Q?AG6qNIIrG1JRLccxJoBTb6gl/xZORkEj9P9Z?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 06:13:38.1014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a368ce-baa0-49e7-90ff-08dd87ae25c4
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR22MB4026

On Tue, Apr 29, 2025 at 04:20:21PM +0100, Simon Horman wrote:
> + Toke
> 
> On Mon, Apr 28, 2025 at 02:54:49PM +0300, Ian Ray wrote:
> > A rare [1] race condition is observed between the igb_watchdog_task and
> > shutdown on a dual-core i.MX6 based system with two I210 controllers.
> >
> > Using printk, the igb_watchdog_task is hung in igb_read_phy_reg because
> > __igb_shutdown has already called __igb_close.
> >
> > Fix this by locking in igb_watchdog_task (in the same way as is done in
> > igb_reset_task).
> >
> > reboot             kworker
> >
> > __igb_shutdown
> >   rtnl_lock
> >   __igb_close
> >   :                igb_watchdog_task
> >   :                :
> >   :                igb_read_phy_reg (hung)
> >   rtnl_unlock
> >
> > [1] Note that this is easier to reproduce with 'initcall_debug' logging
> > and additional and printk logging in igb_main.
> >
> > Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> 
> Hi Ian,
> 
> Thanks for your patch.
> 
> While I think that the simplicity of this approach may well be appropriate
> as a fix for the problem described I do have a concern.
> 
> I am worried that taking RTNL each time the watchdog tasks will create
> unnecessary lock contention. That may manifest in weird and wonderful ways
> in future.  Maybe this patch doesn't make things materially worse in that
> regard.  But it would be nice to have a plan to move away from using RTNL,
> as is happening elsewhere.
> 
> ...

Hi Simon,

Many thanks for the review.  I've been reflecting on the patch (and
discussing internally) and I think it would be better to model the
behaviour on igb_remove instead of igb_reset_task.  Meaning that the
timer should be deleted, and the work cancelled, after setting bit
IGB_DOWN.  This would mirror igb_up.  (And has the advantage of not
using the RTNL.)

(As you can probably tell) I am not very familiar with this subsystem,
but the modified proposal, below, works well in my testing.  I will
happily send a V2 if you think this is a better direction.

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 291348505868..d4b905469cc2 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2173,10 +2173,14 @@ void igb_down(struct igb_adapter *adapter)
        u32 tctl, rctl;
        int i;

-       /* signal that we're down so the interrupt handler does not
-        * reschedule our watchdog timer
+       /* The watchdog timer may be rescheduled, so explicitly
+        * disable watchdog from being rescheduled.
         */
        set_bit(__IGB_DOWN, &adapter->state);
+       del_timer_sync(&adapter->watchdog_timer);
+       del_timer_sync(&adapter->phy_info_timer);
+
+       cancel_work_sync(&adapter->watchdog_task);

        /* disable receives in the hardware */
        rctl = rd32(E1000_RCTL);
@@ -2207,11 +2211,6 @@ void igb_down(struct igb_adapter *adapter)
                }
        }

-       del_timer_sync(&adapter->watchdog_timer);
-       del_timer_sync(&adapter->phy_info_timer);
-
-       cancel_work_sync(&adapter->watchdog_task);
-
        /* record the stats before reset*/
        spin_lock(&adapter->stats64_lock);
        igb_update_stats(adapter);

