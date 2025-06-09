Return-Path: <netdev+bounces-195632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BE9AD1897
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 08:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3467A2DD3
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 06:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF6521639B;
	Mon,  9 Jun 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="gosGOGoX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A831C36D;
	Mon,  9 Jun 2025 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749450787; cv=fail; b=OuvOeYhYYV5uyvp1rr1WquDHJoG+QaE3eEadKiHVj6/mrdkMvXfOdCPWQLgnOcblj4DLPCby9v1XTfv5QQf5525BgyU+ea0z1bKrS6eDc8V1tKrwnDVzUxtaL5iUrjcd9eRztuo+57lhWlLrj6niI7jOdlTRzOhrhJ5sxrV8ZoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749450787; c=relaxed/simple;
	bh=oN26JRD8/7RilE9b9TpKmV8PxolVGqqJCwg0ONz8aK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDJeNAU7n/NjGYmqf+FinadJh6qX6rbIdthTlYnC8HrTmL1D71edRw+EPxLCUB3SUnUEweRARbOlxe2WN+Ze3w7XwHMJqdIJjlljpRpMkcQZqVNRjb886TlicmOZWKsJm9JtTblUaQwGw3qNWguaxpUfB/dQpuWyDY7v3LPl0hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=gosGOGoX; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuz7zrOGJh84hyDz6/gcWV/93Oapw8hvi2Y1pbgH3EuoPnmatA8H0BT8NRJ8gN6wG14rP4W9m7DYZsFYty6rO7pewPDIazUhaEvspUTxxOTK1FJ6GAFm65Lj/vsy0YGjdUIdKsf0WX3g2BDYbStXKf4MMLxsstHDUfrMgvTq6iZljFRXrn+d75qkr6eNjK+jAPQ5UNC5/XnOFOzyxogYS2uHcMT6Ub0lieGlL9xOi1ycPSEBam9jrRAlKU6xquLKKVHS0VG2sP0CoWZo6nassS6D7VCB+Bv/V1L7v/3/tGkR9T6dDSBCIzd8nJIvf41UFW0tmVKKDL9HuMjy78TiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmAYUg7O6dkTdkIiBtg/5kdLBbcYIVSTeEcnUEGi/DI=;
 b=QGJ6uddIn9eihynipaVxlsuQ9lC/Xdf+DcuQywY+VmxxM2Ft70UKtnwLyhCubgFvea7NdciQQoW/y4Ur+XxuiO3Esbej5i653/VtUTP5VE1aNjT6VISf9GGWO+L3pJGmVPUOcPWHcnYokT1V0tToFFO6W3vgfocAEPHbtcm+375mdv0NsAD+j6B8Z7v6s7HKvM+m6dk/ahPPGNwdp+VQSPQmUSs9D6Vv8eCwWsAC3u5UU1ZOV3yh1NbmcX/ZxGo098tYHeKw3FaELOQo2CWgRlQjwvPfQLCYfFGVFyNPkoWASBMCyLWqkJghq3C9MrT1s8GbbIcisoTWgh31djS/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmAYUg7O6dkTdkIiBtg/5kdLBbcYIVSTeEcnUEGi/DI=;
 b=gosGOGoXoBO6EFKSYJ7BLzdxI/HVgSxGIoekTpHZVDjT7XYqX5FhEiNcxi/kRSkMki5i2CmOIGi0cZTTtoWlaczV9vfq77CCxj72YuPScUdfdyDbVvszTuFQPeuuwhcokYmXac8EeXkie4PalmhFJYScIEgrGA+IjM0vaKwgugA6wjjEH8hPIvIjEOCQehW3PsHocbEnKBcVIxAmJms/29AQmZc+D+foXSn0C5tPEskCX9EFjCU4QSh2NNj1S2IKA7W3+6GwxctMT5hCu49PIWJXwvKzaEsd6BIvPK6BZa0k39DxV/8xkCxhsw3JCVlia8HA8E0Gw5NKuZLcrrartQ==
Received: from BL1PR13CA0334.namprd13.prod.outlook.com (2603:10b6:208:2c6::9)
 by LV8PR22MB5098.namprd22.prod.outlook.com (2603:10b6:408:1c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 06:33:02 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::af) by BL1PR13CA0334.outlook.office365.com
 (2603:10b6:208:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.12 via Frontend Transport; Mon,
 9 Jun 2025 06:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 06:33:02 +0000
Received: from 50995b80b0f4 (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 61CCDCFB78;
	Mon,  9 Jun 2025 09:32:59 +0300 (EEST)
Date: Mon, 9 Jun 2025 09:32:58 +0300
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
Message-ID: <aEaAGqP-KtcYCMs-@50995b80b0f4>
References: <20250603080949.1681-1-ian.ray@gehealthcare.com>
 <20250605184339.7a4e0f96@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605184339.7a4e0f96@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|LV8PR22MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: be6ed8f8-ab88-4b1b-10d1-08dda71f7c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B0pY2SqHHhH7HwKh9QXuGolM+IJmMuxaruupTLMUXVOkQXkkyyVUS4v40+xf?=
 =?us-ascii?Q?l8XcCwO5JPxVr4/6giovfGywVRPbH+1cE8s6EC4gYVK5VM3sOaQS+ChNji4F?=
 =?us-ascii?Q?Yx+FVlALSeRVFy//XVBh18I1iOcdwF0YweF+YnJ/5GXcgUu+MBp+ztRoN96B?=
 =?us-ascii?Q?Pb863SOWn+HWpJ7s9MNwe0tYut8vKwJ/6AKxqCvhBZ+rrKCTdDQuxKc/MBQV?=
 =?us-ascii?Q?E+w056Z9x9AoE5tk4B6s2SCj820N8S2Ln0gOa7xmAcCapF7u5304IzoT8Hzt?=
 =?us-ascii?Q?8956RKBapH2wGx3UOD4lZYM1FROsbAHTP8RHFufanWoh7paUp8mR2pVfSes7?=
 =?us-ascii?Q?yvD4lJ0CZOnaUfkV7u0V7kkg2rEk9MHV34qUFB1ig6BTgR9Ex42bnW/kgiLx?=
 =?us-ascii?Q?ImHmnBi16rXDmPPjotxhnXLFMNcsUrgzl9uliYd7aZxdtrCalz6LIFkmG6Ql?=
 =?us-ascii?Q?982BRtrDHHkCQtiJwraAFpUpjrVJK9x1C3M+z/Ig7SUK5RKjiHxb6W6fFt8f?=
 =?us-ascii?Q?9DCcvQtmDz8rhFMul1XDwKXVBzb6mZ9q7jonKhabPZUCrHyHdsT6IKaoUgDs?=
 =?us-ascii?Q?Ua3wQoct2vtwjJYtCL7gyX0ao8Mbpf6AzbHGqna1udRpwwqRvS8s4jIPD1mS?=
 =?us-ascii?Q?su3BLLCK/pWu/uh/TNu4c3MiQFp2FtdaCReBJjRzqcqT/qToPdMWe1TMk2xC?=
 =?us-ascii?Q?U+AwQa/4+Kr0ALVRZjPqvgTEu1Yh2HFCy7zU6G8EYwwl+/Bi/Pnqdbz1agPN?=
 =?us-ascii?Q?7aKOD4YIFezCsCxCRKzml6x0ljimco1yxkxV8AUkQs65M5pT/sgv8BKtlygt?=
 =?us-ascii?Q?/E/ZOENy9BLO5dPfx4shDAsnmlFhHjD/DmNrv564g8aZgHjVxSJUVUi7JmfT?=
 =?us-ascii?Q?lKSbp2/4Cf81ymlYYM1h0flhTntjfk8Yhf+ra/v8/4tTcMiqL9jvSDEyfueU?=
 =?us-ascii?Q?Wxu/sAxB3nPNguZnKAbSuC/29ESawYVrm6SmClmcyWuPk/Mwr/rtTgyy2Itt?=
 =?us-ascii?Q?OzDkJnccqHhDdlzDxjpzjOW9JatTukyw4d5pUV4Jjw0sdmdogl3Z5daa7xWl?=
 =?us-ascii?Q?BylO6JGsX8dDMSORLaOldEe41xDwWUC+RhTIMUHVxivlZ8d2eEZxuBlFHYmT?=
 =?us-ascii?Q?Cj66EbM3YIf6vhNiaiUaMpV5BqeGVDiHHTG7kgd33Vf+kGh07WgAuPNQSKu+?=
 =?us-ascii?Q?w8OCyIzPdt/dSiUjOAYsSVz5DjRrJ3sSwgVjTHqIF2K3Znor6Ycq5bFizyOW?=
 =?us-ascii?Q?F1+QapysmIzfrJbE8LML/WKiQh8IiUZC+GeDchgvocwYBRYRRkRAWTBXvZc3?=
 =?us-ascii?Q?/dLD70K6Tc8CFLNyCxz3fSdwjqYOpPdD3UBZadiU7vO1mqyY+g7C8PP1X8bZ?=
 =?us-ascii?Q?YcUM/0dpYFvx6GyNqQZXwfWihoYs8O/O0gRVWVjMatZPCrMcKMM5+QVn+m2I?=
 =?us-ascii?Q?kKk+/KoYUQT9w20fPTkXBYKAOFb8rajgwnDwgXEs3+DH1wpKR2ovlOtVEx7S?=
 =?us-ascii?Q?vDjWJsUymtP/1cPrZStQGETlIFakpG7NogCo?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay2.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 06:33:02.2108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be6ed8f8-ab88-4b1b-10d1-08dda71f7c1b
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5098

On Thu, Jun 05, 2025 at 06:43:39PM -0700, Jakub Kicinski wrote:
> On Tue,  3 Jun 2025 11:09:49 +0300 Ian Ray wrote:
> >       set_bit(__IGB_DOWN, &adapter->state);
> > +     timer_delete_sync(&adapter->watchdog_timer);
> > +     timer_delete_sync(&adapter->phy_info_timer);
> > +
> > +     cancel_work_sync(&adapter->watchdog_task);
> 
> This doesn't look very race-proof as watchdog_task
> can schedule the timer as its last operation?

Thanks for the reply.  __IGB_DOWN is the key to this design.

If watchdog_task runs *before* __IGB_DOWN is set, then the
timer is stopped (by this patch) as required.

However, if watchdog_task runs *after* __IGB_DOWN is set,
then the timer will not even be started (by watchdog_task).

Regards,
Ian

