Return-Path: <netdev+bounces-183184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A26ADA8B4F7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430FA7A83DB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DA8235342;
	Wed, 16 Apr 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hvZG7Py+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14442233D7B;
	Wed, 16 Apr 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794886; cv=fail; b=V4wDlOn6jNG4sXTxUpQadiDqNW94ApO4775CVur2eT3eQX7tigK4Oa7jqm04yOkdg7vnSx4QKdXEET2McCF3triZJ/fcmnCYFRtZ8xvSmSc9m3zJ4xjXGgvvt7o3KJMDE6Fm7zXYbVe+RghpSShkQ/C/MI7THB39svAG/6UOpJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794886; c=relaxed/simple;
	bh=y4/Z5MF3iVp/Hr2RTMkwL1W7fk2XjvCTuAkug8i65so=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=sacWtUmhDCLRIlAGMEoqxFoBHnivXft0w7Ja/CKB/0cjS0W+hFLozPoXJ/aBbNPy+BV/yltyy7cpkhW6/BJuV7wCYUSvdprUte/Rmw/dOuQHhM42zoAYym3FGL4l7rkdE1V43mqJJz0FA+K+SEJazZYLErXLaPyzoVHgO1GNQno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hvZG7Py+; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvKe6l/p8KKfZJQzu1pyG51fkOWJf+/TfNyeqqWZ53vFkuq4DHTouDvCFpWbPKeWGkM1elpUgKBeyeSttpL/fc+cTFJepuRdDNKP9Gry0JtVh5ug+UCnZdFuvy6KKAmPEEUQWW7jnam5H7MkRNA7fA63X+UL82ZkkYDrA7X+YY80EaaHSFmkBuUjlSpgg+SLtbvdnn5eadwwNbOJ7DoZisgAd02RyBHFw+euaHKG8+t/s9Onw3HA4B2FvjKSOnfAG/du5qyJH+fPgstTAD/th/nLTmSUcYpScWGoREEYILeafuC1TAqVYxUxjpe/HzIzBKPhinnll7PtAwkLuklR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk9PGgfOtu94j5OcKo0DWr17MjPll5iaiddo3FnLpWM=;
 b=JorJMz1SimWApaliqad1SxtvUxiKVkyc2K/7yKCa4Ug5xuFf/Anmhyl573cS5JIfGH6xfagegRPc7AjuNaPIR84+b8Dpzt1MEWc6y+kinmSxFckWAupun/6IWt+fN8yAyDLJ3/HWidypx0wxf9GsG+QCsG79djfcora+hdg0DESiaJjh+oJFO5/bRob/xY2xh22UApr8btewVU7bzbzqEuKhMvDuDksy11QXizeXdKNW8kAfK54VjVuNR82PadFuwnR+GmDvGS/Af0DUZDQYmcoASE0/uLsYEiG7n8SLoy2LWB4u89eMYYzCJze7s3h3BDK4lLecquG5Kfl6sSbv/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk9PGgfOtu94j5OcKo0DWr17MjPll5iaiddo3FnLpWM=;
 b=hvZG7Py+H7TdLA5QXBIJPIY4Xnu+L/GZ+8Xj1eUeBtk45LPRSk+uUVLLRMlZzHHnRXBTUdHEYpIpPvkuM/beA3fJaAR4AoW0WM+AWxBc+idtO96/x2XknQaNRV04KPoddyUgB5AH85vqbtL/Kgfulmc+COmOCVSiJGnA8NUUJ+5/HcOldfZ+ZdMvzTDWCHCpXTB7bi92iyOqn38lOYJXyIUVsDjYJ+xcHBwnm2HoTnSFQZ6nwST4DVS/sx44lllSMRVhE/1g0M/BUpizxhU7NwR2xx89lGoz7FMiksfUmF6youusawtLa/jPFRv1KXyYzFJAkHoxKjePplZ09pVEWw==
Received: from BN9PR03CA0742.namprd03.prod.outlook.com (2603:10b6:408:110::27)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 09:14:40 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::83) by BN9PR03CA0742.outlook.office365.com
 (2603:10b6:408:110::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Wed,
 16 Apr 2025 09:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 09:14:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Apr
 2025 02:14:21 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Apr
 2025 02:14:07 -0700
References: <20250416010210.work.904-kees@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Kees Cook <kees@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>, Geoff Levand <geoff@infradead.org>, Wolfram
 Sang <wsa+renesas@sang-engineering.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Praveen Kaligineedi
	<pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, "Joshua
 Washington" <joshwash@google.com>, Furong Xu <0x1207@gmail.com>, "Russell
 King (Oracle)" <rmk+kernel@armlinux.org.uk>, Jisheng Zhang
	<jszhang@kernel.org>, Petr Tesarik <petr@tesarici.cz>,
	<netdev@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, Richard Cochran
	<richardcochran@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>, "Shannon
 Nelson" <shannon.nelson@amd.com>, Ziwei Xiao <ziweixiao@google.com>,
	"Shailend Chand" <shailend@google.com>, Choong Yong Liang
	<yong.liang.choong@linux.intel.com>, Andrew Halaney <ahalaney@redhat.com>,
	Kory Maincent <kory.maincent@bootlin.com>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] net: ethtool: Adjust exactly ETH_GSTRING_LEN-long stats
 to use memcpy
Date: Wed, 16 Apr 2025 11:09:43 +0200
In-Reply-To: <20250416010210.work.904-kees@kernel.org>
Message-ID: <87ecxswjs4.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 300d342e-1bfd-4e03-32c0-08dd7cc71e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j7IgJbEdesxIdWEYyXpqUrAtgUraiDFgEetdgiKxehUy2vSABUctMFwNZlf2?=
 =?us-ascii?Q?gzXdRMTIGveOZ94zE0JH3BO9Vyt6l37NHF9leljHHfURP4y6ydMvmpu5RGeb?=
 =?us-ascii?Q?6n0hNEV5+oyKqUTW4jWXjBg5bvCWgKaAOX5bIBznE9YN/80R1jVng9mJ2rWp?=
 =?us-ascii?Q?X3JWKkbaBa3Nl3ggOgIElrrc+gsDmJo+7rjvJlW8Lu83GwJe6QPc06rriS+u?=
 =?us-ascii?Q?iypv2Xa+dKj0MofYDNOwaO+eAA8+5lGjL/2ulXpi897P6BJMg3PsuyA7OFCP?=
 =?us-ascii?Q?l6Eg0tTzGKUOe1XXbWA0zJe6qyUB8+GnTlkVW+prUPYw/x33+exPT3fvFxJZ?=
 =?us-ascii?Q?VvM2Hfsw4MQIP+TBn4ikKmukqf/ANfTJ8Jh1tQRITDU/HSQP1xjte3glnfLg?=
 =?us-ascii?Q?0oJ2bV/6eUF1SeFa0LWsRGUhAntXWL1t7RyGwqHfiUFnJ/m/XLYqhslZlWhH?=
 =?us-ascii?Q?FvSe3zunouSc6/PjsnJuiC3Mb40TX3Kq5j9pZ8mTETh/fsw96xCwa1ewjai9?=
 =?us-ascii?Q?04+irs6FTKd+uU8AFzwwq8N7tMgUE3Es1t7pTHrDaleCKmnaivew9/sCd+Bz?=
 =?us-ascii?Q?bx+OP5K8KnCA2JGEF8a+vIuAwxxrNWrsIdIRBtg/httCV8qpuLMTCeiMchWX?=
 =?us-ascii?Q?M4F8cO0DKyobU376zMNa9dzma+CeGOr4jDun2LLEnr2twq52TlsWy313ESIh?=
 =?us-ascii?Q?b7A+W6OnwDI6D1Cz1jJOVG1XDQ25y2YbMvSQWLpMat3eTkVcMs+hXWTQdaqu?=
 =?us-ascii?Q?aV8Fl3IEzwV5ISBS4bLDOgovQVCEpWfhSlwEAbTW8oG5PcwoRXSUUqqYxZT4?=
 =?us-ascii?Q?eRXuvrxF0SKZOQ2fiVtn3tfA5ITt8Wi9sFSLncZ/QsOvX906mT5x4uEzUVHy?=
 =?us-ascii?Q?1fMF+L6ZpCbtSHNZNsZz8kK6NxQdGdicYDZlpHyKliIwtZD4F8rH9vvn2J70?=
 =?us-ascii?Q?f+fSFqkiaEotoJoajiAhPCL63aV5JDm1kgnKCFKB8p4sCUtqCxJ+hT1nB9Ga?=
 =?us-ascii?Q?rawCxiaKwo6TimXmDlg0BDHDD0mW8argYA/ShGGfFJ7sb/awFVCWaGsPqReN?=
 =?us-ascii?Q?biJpTUrn2Tvvxlrf87aafLRzB29OpVvEooLMXAjoChGLAZy2gssIzBltqAqc?=
 =?us-ascii?Q?+GRI7hY9exe/VE9QNRYIN6bLtONDvKa/Hpb8OvvtxYCWkobEa5GpO0NfvnvU?=
 =?us-ascii?Q?vHEMOGXvfGTiyedgVjplY4N8y8myclyeMjCRZZF2lp+LWb/l/JF14EEtj2gZ?=
 =?us-ascii?Q?/1hJBoNZY93KinjF+Wb2OOzJmWAO0b7Qp7EEOM1+F1iM4UOUzhBYsibTTkzo?=
 =?us-ascii?Q?umNFcgTzvBRuQLC7G65Bq5zfZQRZbzBz+JJcd++bqORIJXaA8ITDU1bf67lV?=
 =?us-ascii?Q?j1T6+mGBGtHBZIIvHAViHb5mh4tjQx9qcg5oULOXK/y6FzKIu0NeCBpLGQ5D?=
 =?us-ascii?Q?7lmwnrcfygX6HlM+0dz7OTXiqMotpkYd+SUJa9LLBj+R2rg4Alq9TYOYwTrc?=
 =?us-ascii?Q?3Lsinw0Lw4JaMAs9GA7ISsNRP7qHrqM5ezgx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 09:14:40.2423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300d342e-1bfd-4e03-32c0-08dd7cc71e3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881


Kees Cook <kees@kernel.org> writes:

> Many drivers populate the stats buffer using C-String based APIs (e.g.
> ethtool_sprintf() and ethtool_puts()), usually when building up the
> list of stats individually (i.e. with a for() loop). This, however,
> requires that the source strings be populated in such a way as to have
> a terminating NUL byte in the source.
>
> Other drivers populate the stats buffer directly using one big memcpy()
> of an entire array of strings. No NUL termination is needed here, as the
> bytes are being directly passed through. Yet others will build up the
> stats buffer individually, but also use memcpy(). This, too, does not
> need NUL termination of the source strings.
>
> However, there are cases where the strings that populate the
> source stats strings are exactly ETH_GSTRING_LEN long, and GCC
> 15's -Wunterminated-string-initialization option complains that the
> trailing NUL byte has been truncated. This situation is fine only if the
> driver is using the memcpy() approach. If the C-String APIs are used,
> the destination string name will have its final byte truncated by the
> required trailing NUL byte applied by the C-string API.
>
> For drivers that are already using memcpy() but have initializers that
> truncate the NUL terminator, mark their source strings as __nonstring to
> silence the GCC warnings.

> Specifically the following warnings were investigated and addressed:
>
> ../drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c:328:24: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (33 chars into 32 available) [-Wunterminated-string-initialization]
>   328 |                 .str = "a_mac_control_frames_transmitted",
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c:340:24: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (33 chars into 32 available) [-Wunterminated-string-initialization]
>   340 |                 .str = "a_pause_mac_ctrl_frames_received",
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
> index 3f64cdbabfa3..0a8fb9c842d3 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
> @@ -262,7 +262,7 @@ static int mlxsw_sp_port_set_pauseparam(struct net_device *dev,
>  }
>  
>  struct mlxsw_sp_port_hw_stats {
> -	char str[ETH_GSTRING_LEN];
> +	char str[ETH_GSTRING_LEN] __nonstring;
>  	u64 (*getter)(const char *payload);
>  	bool cells_bytes;
>  };

Reviewed-by: Petr Machata <petrm@nvidia.com> # for mlxsw

