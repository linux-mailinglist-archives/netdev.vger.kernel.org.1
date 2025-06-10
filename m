Return-Path: <netdev+bounces-196078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E94FAD377F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCEC3BFC2F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C059293B7C;
	Tue, 10 Jun 2025 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="RuYpR94Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F740225787;
	Tue, 10 Jun 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559451; cv=fail; b=k1HXAl9dZ0TJ3AdfrTIBZL6YnSAs4uXtdE94sAM8jS2twJ0OG2jUjXz39PMxl8svkVEf2xUTZWmk02iHcadlPyCLeMex6UsuW4omWmxdm+63wjk9DwRT5A2MQz2Zl8UkdKHzBjAa7r6bwYxboVaOJjAQKXx7+e3mcYJ3nRl3IxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559451; c=relaxed/simple;
	bh=mfuysDkz9vbQ+ezfxp+GgBszNLyOzNhWJey0XqbN0F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhNCxG9MC3uX0XGxd5xhD2zu7jX69yvdF4iFk7lxmSRWKa62PlSkMAYaZUTSAPkwDMWFzXnSApXA4cczBM739DNrvcAwXYwdLJh32zDQFL9vZ5QOb4j78ZH4JW5w4pqSvM5MmUAT2cMhuow7lF+eSpqyXlw299n6bRVVeYpCSGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=RuYpR94Y; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC3N/vTu3uCjiFInxT3h/yvWSy9/HQHgB7PUOJncZDmDSAQdcrwdEsjpdb+XdKgcz/YmH0jTbGmjitB+df92GqwJfRN+PXENPZwhT/rAeHI/H9NQjAvXlxu+itfXUA/2UWU1grElJoPOWKvOtZpEBKAQtGYSrIcK4h/351QUyCq/2QnOiVtRYsHDYE8cIdEGKsaTbdChzxUsUY7gxIlXCBv/SQUMCmT0VvzzHaUwfvay5GoLG1CP5078+tKaoditWeO9jMBHPwrSBtw4UKRRjwN65UgR+kOwlHgKjOn39B+BjGUEw2EPFzheBIp8RArfNu0zutaCc+AOS3Zf5TLp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rvFG/s44dSh43jpN7X+yiaV6dbW7lt4BxMya6NDJbQ=;
 b=jWqTXEHvO0XGzjJ1xPwpfjBsYw335b4ALZNf6G8sgZVPmu9I05vQnvJXgRKncpnbbBnafsXW37qdifXjGoyDrgXiVsYLIB2Pwu7gYIsJVbzCGwagvm1nmfBBUHEjkvFkfP5DBHm2VMNCQDYutKhgESea6i4grbLcCzXsKl0tBWSg4NWNkx0ZqLo74Taq7apWhxzlbYXlQHBqnjCwg69cQDfwhm1MRpcLN10mdDAwF+qznvEPUr/gtySSMCeOEgUpx073s8L3BRzpPITO6w2Pnfygy3F0SUW8lnuvMe4x/FOuSM8GSphJKS8XiJNwnIIC2WiUnPjXxWHrei8Ysm4aXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rvFG/s44dSh43jpN7X+yiaV6dbW7lt4BxMya6NDJbQ=;
 b=RuYpR94Yx/P6q6W5Brjh1HSVdBWdMzXNIK9n25LxOLJhxXl0SwDZDGWgKvA72NkK7kIyrnsP58A+sXXQx9qbElkT70jAo2O7qeM33dwYkEiUcUHBBk+jxo3YwN4b3QCvwLRguWPEUa7ji+u+YtL+3To3BbEySwdJZ7jXNewFIiuzNT2tIo5BuSQq18/OpUvgyEV7sSfizoyMTDct9x6bgowSkwv4cnL5r6dZw1ch5Gt0MEPvMj/uiU6P1he7pQJimkc9tWP9G7SHIUX7Pt95nM5K9+g9+1Nc2xX9xXka4GKuiOGYXwdscX87nH5uLo5e7sKkwllwAjibCGbtTFYp7g==
Received: from MW4PR03CA0109.namprd03.prod.outlook.com (2603:10b6:303:b7::24)
 by LV3PR22MB5051.namprd22.prod.outlook.com (2603:10b6:408:1dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 12:44:06 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::38) by MW4PR03CA0109.outlook.office365.com
 (2603:10b6:303:b7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Tue,
 10 Jun 2025 12:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 12:44:04 +0000
Received: from 21d8f0102f10 (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id B877ECFB78;
	Tue, 10 Jun 2025 15:44:01 +0300 (EEST)
Date: Tue, 10 Jun 2025 15:44:01 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	brian.ruley@gehealthcare.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] igb: Fix watchdog_task race with shutdown
Message-ID: <aEgokTyzDrZ6p4aL@21d8f0102f10>
References: <20250603080949.1681-1-ian.ray@gehealthcare.com>
 <20250605184339.7a4e0f96@kernel.org>
 <aEaAGqP-KtcYCMs-@50995b80b0f4>
 <20250609161039.00c73103@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609161039.00c73103@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|LV3PR22MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: fc303a27-caa9-48c8-4e70-08dda81c7c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bgz3dzXpwSgSCCq9qkwmMrbNKg1eAnaliGULsQ7oB+tACwfEMx0TfbhhrV+z?=
 =?us-ascii?Q?Mt1QwMfgfBthpe5ABDah4x4hE0M6G4Gbvy1JFTjgsTVrH5A3GYq5jaxYP3CN?=
 =?us-ascii?Q?CmBrdSahLLxfEob2uR8rMY4HbTyq0MxI6hRWW+e8PA4kH9I4gkPmhA1416VN?=
 =?us-ascii?Q?8hkdok7B3m9S7bnMBq2IkF+GxVANAnRlEVMw0WiXQ1+w8plF/ERe5GhLtw3G?=
 =?us-ascii?Q?BOqKe0aY7S0s6GOka+wrC/yxE5HZJb4NzarSsqBzImUDv3A8tAKaYbxRKKxA?=
 =?us-ascii?Q?hmBkPkvW2gNOy3T/GqEqzHQuA110js9smlEDBBdedJzudeBt8ZqBiAbH5smT?=
 =?us-ascii?Q?bzzScar6pcHzpiGSm8y392QLF5XOBAuzUqhWF09AkS5mRay9D8A1sGseEgNg?=
 =?us-ascii?Q?B6y02FJQrSKYIxKNyz4/UOoigFiYw7B5KXQk6ANAdQYQ+KwLBk0AAv6T2n8H?=
 =?us-ascii?Q?ksRuaXJ88HN32t/jnXZsSrH+VBf14g6o6O4oMAdVsoNKhBjjCGlu56i5bUEM?=
 =?us-ascii?Q?UtJSoo5ibEZRSl5rAdLI0uwypPMKVMUbH4X9VlFZoUXLr6bV+kR8UOa4skl9?=
 =?us-ascii?Q?8ljLxCGeLZVTwwnKrkJHP8GY28lCpWz8H8ZvVrQFE3k68EOb6N4bZAJL63Ba?=
 =?us-ascii?Q?jRW76BFaCRMCPTvMNyJsgmPI7jaQHAoGZnlCvaSCvnVAOwCMojPYIFSk9u6p?=
 =?us-ascii?Q?cwIm/k+H1ZPeTeEIlRw5nRhz/mu2f0qFhumJjClKCxxGcCaZyfxru3QjI2hr?=
 =?us-ascii?Q?3OuxVp6ejU7kfDYwApb/7W/Al0I7hRKbD3Lx8u+QSeHKv3cGu8r+hASbBoHm?=
 =?us-ascii?Q?YgR5BpcfxJDX78vQqOHgAEaLTaF6vfXgUAKVmuOSMJmHzbBmoWFSYZ9LtBxh?=
 =?us-ascii?Q?F4uTXFYW1Zw0/5kUo4SsQI7BEokYHLGDmFlV+R2lFuuZxlJbKJ5b9b4kATmD?=
 =?us-ascii?Q?6BZHBOrVsZhZ6XxAT6/rX6uxw+IXxY+50Co7sZx6QnQoEUrCUln7LEHuKexs?=
 =?us-ascii?Q?2ZNlZU+ODpDRbHJV56qDc+qzRE/SIzAy9qCNetm/cfbhQY3WoYrNpkeE16aq?=
 =?us-ascii?Q?pjtPZCdMRKecdv0k1LbjF8yfo5q19sfY5LHXK7cJddhJs5VqlYcrC1b5A5bQ?=
 =?us-ascii?Q?XAkLKEhn/Rb8jcmeJb50eB+HhY6dCHoU9P2XrrSpPLyVUfLA/kjFlWx3qoKz?=
 =?us-ascii?Q?oIVFD8uyjbQ3iLRBkPZDtumdpZFx+GN32rEJHbba3rYBZjqLi2UK95AGiBvz?=
 =?us-ascii?Q?/gkDoqG4qJx3LWpN+QhkK7f5tVIJnAZsDOqvJKlNHK/rVbWn0D0r6AzYbRys?=
 =?us-ascii?Q?0xdzwvPep9eUhNS9tVuTf3y3DTEgy13evrRPt5IP6mRaKFwWTTyW/+XOAJFN?=
 =?us-ascii?Q?dF19oZyIUaaRN2cx1Day98o4Ldz8/kCdQPBLjGmsvtMpVgyx4UjzCVHxg6LO?=
 =?us-ascii?Q?mEI2mTXbc82HljzxmZB9poqFOh/QxAnZHZ2S92s6weAzelL7HgIAwlWaV+q/?=
 =?us-ascii?Q?3LPyiAjUFH/AE3iGLmPqT3FKNdDRrvgC8K4l?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:44:04.9210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc303a27-caa9-48c8-4e70-08dda81c7c2e
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB5051

On Mon, Jun 09, 2025 at 04:10:39PM -0700, Jakub Kicinski wrote:
> On Mon, 9 Jun 2025 09:32:58 +0300 Ian Ray wrote:
> > On Thu, Jun 05, 2025 at 06:43:39PM -0700, Jakub Kicinski wrote:
> > > On Tue,  3 Jun 2025 11:09:49 +0300 Ian Ray wrote:
> > > >       set_bit(__IGB_DOWN, &adapter->state);
> > > > +     timer_delete_sync(&adapter->watchdog_timer);
> > > > +     timer_delete_sync(&adapter->phy_info_timer);
> > > > +
> > > > +     cancel_work_sync(&adapter->watchdog_task);
> > >
> > > This doesn't look very race-proof as watchdog_task
> > > can schedule the timer as its last operation?
> >
> > Thanks for the reply.  __IGB_DOWN is the key to this design.
> >
> > If watchdog_task runs *before* __IGB_DOWN is set, then the
> > timer is stopped (by this patch) as required.
> >
> > However, if watchdog_task runs *after* __IGB_DOWN is set,
> > then the timer will not even be started (by watchdog_task).
> 
> Well, yes, but what if the two functions run *simultaneously*
> There is no mutual exclusion between these two pieces of code AFAICT

Thank you for clarifying.

IIUC set_bit() is an atomic operation (via bitops.h), and so
my previous comment still stands.

(Sorry if I have misunderstood your question.)

Either watchdog_task runs just before __IGB_DOWN is set (and
the timer is stopped by this patch) -- or watchdog_task runs
just after __IGB_DOWN is set (and thus the timer will not be
restarted).

In both cases, the final cancel_work_sync ensures that the
watchdog_task completes before igb_down() continues.

Regards,
Ian

