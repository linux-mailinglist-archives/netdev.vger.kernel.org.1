Return-Path: <netdev+bounces-106814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE1A917C5B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6671C2271E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DF21662E3;
	Wed, 26 Jun 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K0ONRdPf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E0175AA
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393869; cv=fail; b=pfQRJBqeGxErK/Zp5eoR+xpf3f4uCwvZa3PUz4cHSpfF5G0q7cWUZV47pYTUJSybLAckvLb6Ud3xhErYyxy4f4XHnYFm3uAxPt/vq2kktfGZAIOMgwW08E/Ee+4kA3cjCXzcZdsZWakH3nbQctrkvB4/lq//qpIb4x9GdXZ/hvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393869; c=relaxed/simple;
	bh=EdBKBmzV/RpvjZ4UxUdGmM9VAneIO4keC9RzrHQG9no=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=baEDWPvHVeRKHrXktHIagnVCA8uBms8nDoCobTvXGGYJLQGk8mA7YnmIRG4FhKjuoKW9jJiMK1fk3LEAybiME9U2h/RHQjYADq/DWz16/u2YU1qMkfwBPKZr8ZfbNzLh+XoXWhhbZrSgsC/5r8a+fVcvNEXDmP2Y/hTHGG7SAIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K0ONRdPf; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNTvS8ogt0AXmrcl8XxetNJP3TofifzKKlWXO1cNjtYSKAI7zxEnj977zvTAQCELqGT9O4zSahIt1ijGA2KL9X+4+6dEt42fK7ouvKxufcYrV+0Py5eNlCxNxd4PhjqdnWLF0Qv6Owly1mbW0qrrvNyCg3uGTr351xq5ht19Msoz7ypWA9Cp1HsgJfDs9ZG+KBvhZ3U126Y0bbWFCZS68HWySqmTSZC67CtqBDQl7pgb7fLCqNc9k71TNvqEI1YFOB9Uf3HnW+IdsSQGpO9fClAfYKXwHo01YFQvWUs298p6FgFd6E0+N36ChkLE0nEZVGWHmUtdc+hVsBapmUyqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYvOLX7axkenHKOuqMWHnYmtFEZhd7zs3YlOTm6TB9E=;
 b=XA9NIa7pACTHv/DTc9hW042Cazd5x3jmvsL08NdyQAkOZBogPbN7pA1CNflZh3qCS3KWuVorTQAqAmW1JkikKn/pHtqWU6csSLHz4FftLc3qC1k+PDZQLMAX+0vRx+FRg8zaE4hCbE9FaSRN4AhNeQ9XlsChvTEHuDhRw2M9967FuZYclwOK1JRFRJ55J3flICIs5u9oandQbtbT6w/CTJ4eHHfcWzAftDcZllV2W22rBa8ibpofxMg4gyI7M+PcenQ0yK/jiEiaGRF+I3vTPr8gJHth8DA1RA7oauXeDmUO2oEoKsT/cK9rbAqnGfE2HdEbfh3Z3grqeOd/qhogVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYvOLX7axkenHKOuqMWHnYmtFEZhd7zs3YlOTm6TB9E=;
 b=K0ONRdPf/ZugBYSgGi/vVOMQ9MK8hi/GmYzULzSZfynn6ejiPr+l7uAazH4QLk2yoGWJgL2Rzzp5A2Heyw1fCwRS+FbPWWxV1MNa+KT+reTS3/QDp9GTBuyLilv2gH2J3mu7w+gNb8n/mm4vGUT+PwD13f7gfi1q+5y/hkRPBiemfxCFmXr2Ckz1QL5GJhH0aqSjoTFxAIDTzooHtbApgpFnXjemmv0/UENfADOxG/fc0nd59IFwwSiq4Cm2AtnD0ABgVcMQVG25B2OlohV18t7l0veVYtrx6F7eGyZHI0HKWM9EFgT6AmynGN0r7/z8xwfdNXeQLAHExUjOuj3qTw==
Received: from DS0PR17CA0021.namprd17.prod.outlook.com (2603:10b6:8:191::16)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 09:24:24 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::e2) by DS0PR17CA0021.outlook.office365.com
 (2603:10b6:8:191::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.23 via Frontend
 Transport; Wed, 26 Jun 2024 09:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:24:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 02:24:12 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 02:24:08 -0700
References: <20240626013611.2330979-1-kuba@kernel.org>
 <20240626013611.2330979-2-kuba@kernel.org>
 <d7a8b57d-0dea-4160-8aa3-24e18cf2490e@intel.com>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>, <leitao@debian.org>, <petrm@nvidia.com>,
	<davem@davemloft.net>
Subject: Re: [RFC net-next 1/2] selftests: drv-net: add ability to schedule
 cleanup with defer()
Date: Wed, 26 Jun 2024 11:19:08 +0200
In-Reply-To: <d7a8b57d-0dea-4160-8aa3-24e18cf2490e@intel.com>
Message-ID: <87tthg9hvv.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 85487dd2-c0d2-4a6d-272a-08dc95c1c49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UpXdT1DGohouiH0LXzWyxo3m2uIvUknRbGtIrDxzQQhAgVFJENY7QCOYmT5r?=
 =?us-ascii?Q?u+Gwnq9UEDkeSJCo/wqsOkBcZ6zTezCA+5J6MIJH0i9ZqGnxBq6ExoVBJkWs?=
 =?us-ascii?Q?b8ogUYbHwvHUOrNay1vSkKFz3vS0s1PD25y/M+QfqSWNJgrgPVllMKYNJsZ+?=
 =?us-ascii?Q?ckP815PWLrI4TuBeK5VbdHn7DUYzcKZHYcIgaxsjnzn51cck16/fbiM0ASFs?=
 =?us-ascii?Q?+7CSzPx2gPX9x5jQffJpnZRTNcZgsYZkxZrZ7YiOcmW1os6eoHHh2VYFSm8c?=
 =?us-ascii?Q?Nm3u1u1tv0xrSpUoIVTwz/Do2dguvoJJ1o40qgy1TxPzDhM7vBR+Dnn7Vawu?=
 =?us-ascii?Q?+q2vTU48sxpshZimNtzFccnhnWIoazVHUs2HUVFnifeRGZCoKyRVf8hu1u7V?=
 =?us-ascii?Q?0dP6IlWkozJ8guK5AgrGrbK6NCWUmIgP+VcIknTO+KaogIkyTSoHVmFVOEzx?=
 =?us-ascii?Q?EPo276EP8P7uOGSl5j3FyyljZhow/L3FLdEiGTroyAE1DPmvufAjJD8GvUVq?=
 =?us-ascii?Q?tAMgio5U8TcIt/IjSeMwOC6/Sd8Pgs9r2ziRLagOMzGNbN/70/9pAtUPhe5I?=
 =?us-ascii?Q?9pbWc96yy3QiYk+EQQkTQaib5H7hHT0pBbJSX4j6C3OFF5En/HLLyPuj2TAS?=
 =?us-ascii?Q?Ce5bkfH5+0LKl1V1jGLGhmKW8y54+W3B7QL+v5YVCOF15IblaK6p6Nqpldv3?=
 =?us-ascii?Q?KBEhMaC0SpIr4H+k2N0aHfASdsHEwUPRPvRCs//fltbcHO6vKU551HJJb+3o?=
 =?us-ascii?Q?ayWl+OzIz/2Pztf3dVAyVDlalGtjiYjW42FGvCjjbMJj2KxWZgZPMhz69IjB?=
 =?us-ascii?Q?0NTHzPjq35b9h4NTB0xcZu9gQW0IK5LRu/sUr2Qn8WLQmLNphRRYpD28Iv40?=
 =?us-ascii?Q?/+yo7l5g+C7LfDlnea326wsvk7hzOdP3ECJ6Tu9AMFJL2dUKCSgjqmAhuskx?=
 =?us-ascii?Q?IUpqK/874zMjK0cAMpu8T2V417KyxPUrYUKQYO2qJwUxC6RltzWF3JLE1oKm?=
 =?us-ascii?Q?Zmq2LXMA9e4OiQZupNB9/Fz+Z/C4TvpO8yBL/UDVlYQuRiqWClrtX3qdVe9a?=
 =?us-ascii?Q?RLCW64gjMlqcXJWFGZ2sqm9PHQjdNlaJmSTNPo4d8LMaU3KC/Q4papDFijNv?=
 =?us-ascii?Q?lcckPeDKJu5BXxuIpKx8OJaOE7xxjBd71ibcxIbCgWl236+GbAx3wULtrc33?=
 =?us-ascii?Q?/gAW3mZdEC8uk6YbScMJrzEM/fopa/W6kzO2Ft2pL7639FTMVyuJEbFUImiZ?=
 =?us-ascii?Q?3JwL7pBvDOXdtunbsQ3LMRW8sUjTUWFfGU4R5Jr88NQ6bgLN4OU7oYiQmqQW?=
 =?us-ascii?Q?hf9g1z6RKUuEYr28JMrBBESn2gPO8o/gNOSS0wv7gL4m3zkDcW/fxB1NmUV9?=
 =?us-ascii?Q?cnO2WN7XSzXOJEWwtHYJ5BPoctprdLR4txY8CpuiCRVhcppRbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:24:23.8352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85487dd2-c0d2-4a6d-272a-08dc95c1c49f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818


Przemek Kitszel <przemyslaw.kitszel@intel.com> writes:

> On 6/26/24 03:36, Jakub Kicinski wrote:
>
>> There is a global action queue, flushed by ksft_run(). We could support
>> function level defers too, I guess, but there's no immediate need..
>
> That would be a must have for general solution, would it require some
> boilerplate code at function level?

Presumably you'd need a per-function defer pool.

Which would be naturally modeled as a context manager, but I promised
myself I'd shut up about that.

>> +    def __enter__(self):
>> +        return self
>> +
>> +    def __exit__(self, ex_type, ex_value, ex_tb):
>> +        return self.exec()
>
> why do you need __enter__ and __exit__ if this is not a context
> manager / to-be-used-via-with?

But you could use it as a context manager.

    with defer(blah blah):
        do stuff
    # blah blah runs here

IMHO makes sense.

