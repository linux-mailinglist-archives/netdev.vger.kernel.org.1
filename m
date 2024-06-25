Return-Path: <netdev+bounces-106431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF299164FF
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4461F21DD4
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F901494A8;
	Tue, 25 Jun 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XoE8sI8l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3629148319
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310210; cv=fail; b=XvPaSaKiJjf8JGwc0OZCObpYP/tK4cxZVbtSScKlagKK9i5gBtK6etESQQj4wY8qsu7oV4D32G0snG7R/nLAW0uu+/WeNr1e5KZ25SZW170iYyWSyOJqMBfJ3i47hhuF0Bz3KOmQGdU/ZyqNpL08HDPhtL6YJBi/01KG7ustZbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310210; c=relaxed/simple;
	bh=KGLTxWdPlHHOrPLFb5QlUTvMFxjVgnp3Kz1A4PwbouE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DEMcs47RIWbWVVl7T3SIgflz1LLyJDK7FA2QkaNwPtDiiwHbmzb8HzdVMfQOpm3wAp5qUHMrEc5Ic8cOp4bLZMsH1/tq01T3s26uqyxUjmdEWzVTuNFDyMg8o3trO5qfEW20L25mu5fcGGbLbJZqtwvURMNyH2pGmR4N0LmTLSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XoE8sI8l; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDTEhT3di5EUh4losrTAgGFA5Cx+6sa8fi7o3sqh7fzKKd2J+vOmk8cJjU6NMbxVrf+oiwDfXVypVSNtbuNBgL5i81z/L08ZiVGGeEyaP/WepjuMga2eCzu3p0xGx1XJYPEXFvC3cmF+sFp5O3ZDBo5n4dC+lZSWrzsq8eQYnALn15txg+D2Dg4+KZBVqLE2LhxMAYEnx01yoL48lCuXmkRhymAwpcIV1KQY0+h2yz99e33kduC8WX+VneY51to4k8RNi6FT3vw1zOw3m5/YVYfOLYoGx5amU/bs3E8ARgGtjhPn1ZrIBvwwe86t8HxRJTXZhTGhJBpHYkjorPMyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qt4yhexQPwY5xKHQkygs+bAq6dmSuisx8KvwmfF/Njg=;
 b=oI3pBW6qmMSMwn+ASGPxXURTAYKR6jzCuSNu65CSbC/nu0aftdGYqmmkvCohlJs6PJVUZCr+IWA3sXmkZFVxv0MakOmnA/Ntmpu/cr+yXJFGjzcutfmgRfrD7+nrJHZ8TkkbEQrY/gf3eKD7Y/wtmngYl/fguX6m5GfOS607TZ9BGyfFR/qfyPzL7w989d7SRksm7MLd5VDbmzG/GDg9K01NPmQ1QoC+o8nBXSzrOqgEXqvDIzSbN/E6tusmNoyfxig+QZITlTibQ+FXgr/EuAyd9NlXcYLD1m8WP3y7RYDc/vfDJL2wBO7JQPXfV0Ax6xwN4qMe3XvUHhNXDUtbrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qt4yhexQPwY5xKHQkygs+bAq6dmSuisx8KvwmfF/Njg=;
 b=XoE8sI8lcKuyrElmulgKZwt96ecyADAHehOU+I2ZXd2XqWVz3iM0ZRRoMnw+X3qY+leX72isavK+F4OF4nmHed7kv2vcn/AXwP8FcwesLFSq8tQQFQSn7wcKDJg2LGETXj95CJgKgaicbv5ksFKlbqQJf1rOxOmHKJ8BxQsW2v7RrIQK9DBwiWCH7fkssg0AKEmg44QzMIk4Tym48u13AlxdUHpNGbo2CDcCq26eXKpQQxSlzV6URV0j0yVI2jM+MaOyMuph8kp9ps0Z80S/muFVyBHrcQDOYCnEOVim6cwv9xcD5I4BYrPcDMN3koj0qTxSk1/damTPtQn2nMD9fA==
Received: from SN4PR0501CA0065.namprd05.prod.outlook.com
 (2603:10b6:803:41::42) by SA3PR12MB9091.namprd12.prod.outlook.com
 (2603:10b6:806:395::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 10:10:05 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:803:41:cafe::7f) by SN4PR0501CA0065.outlook.office365.com
 (2603:10b6:803:41::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.18 via Frontend
 Transport; Tue, 25 Jun 2024 10:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 10:10:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 03:09:54 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 03:09:49 -0700
References: <20240625010210.2002310-1-kuba@kernel.org>
 <20240625010210.2002310-3-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>,
	<ecree.xilinx@gmail.com>, <dw@davidwei.uk>, <przemyslaw.kitszel@intel.com>,
	<michael.chan@broadcom.com>, <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next v2 2/4] selftests: drv-net: add helper to wait
 for HW stats to sync
Date: Tue, 25 Jun 2024 12:04:24 +0200
In-Reply-To: <20240625010210.2002310-3-kuba@kernel.org>
Message-ID: <87bk3pbafq.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fc4ab4-2c3b-40c3-7a8e-08dc94fefc3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|1800799021|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Um4etnWU434/OxhoN9G99jO4+dg07hVhvsserEVM0BVdBFxIINTRdyGtUkCu?=
 =?us-ascii?Q?feQ2GGqv39Gmk67qYUNWWmWfpd0e2xJYitDgR8QJ0X9tSJRVAOdHGkf/A7Lx?=
 =?us-ascii?Q?a/XiuNz/RuPnfMeTkEn0W3GjWXZHy0bBY899oUM0Kb8ijaD1BwEthHVBUXK9?=
 =?us-ascii?Q?1LiQcvNHLEark1UJ45i9lUcOB+IImv6arO+KiPkxPnt3layx+yiROnH4+fiS?=
 =?us-ascii?Q?Hc3gEiN2SStKicnUXUE7cOOQkWFNLdMkrnzZkhLKlQ6bFEZLUuu2Y69jIzvA?=
 =?us-ascii?Q?q5LhOUiA6jZo3qe4jTjOMz/IbB21Aeeeze9WSkbQ4CK+rwPWawqCnLZAXMBk?=
 =?us-ascii?Q?M3e6wCblZV+Hn8QlaQxOfTzTwUFhpeK+qBNJ4oZZZ2rjyTk+TZbrDqz29QfF?=
 =?us-ascii?Q?LlgDwnLvDqzz+iqX1LbJ8v396dybieq33IBSlpr4PFOGFUM4VJHc5aC+yzyj?=
 =?us-ascii?Q?ODm+QafqVE0PfQZQq/H6IrskUX2x4LaIhbG+84febzj9zflAl3yeQ1YJkovr?=
 =?us-ascii?Q?AaYRiONB0X/yHXQTRAsrxVpY3wE7VLd9gOJ68C/rz29nrZRNJzXAYmgAuf7c?=
 =?us-ascii?Q?uMR5Mo6NeKlCss7YSn9kTyWWfPRL/YvxfRoTBQ0lRMBsC7aieYrAkqqlo5Ou?=
 =?us-ascii?Q?VA8S8Sw59vfhMAW/Ls0tX1W7hveoP9sDaFnJho3zz/xpGzGPnWM/fpQEUGj4?=
 =?us-ascii?Q?a2XxmU+Ednb2d6uiVHBEv6zMaSj5znbC3McfT2f20TcqZNQ4IP3jdimUKdl7?=
 =?us-ascii?Q?k5vZsMzXbu51MLyVFDmFW/9AEEB2ovuZkCzTmxcs5bTSVD1O/sE4vlyAkBIh?=
 =?us-ascii?Q?cu0NHGzg29XpjCsqQEf8sjYeOjZ2kodyoiBWvD+i5Xrtt0Xri6DwRRa+AQTx?=
 =?us-ascii?Q?jjZIZEos/cV/QSqG5gNEq42/P5i+FX4TuRtinStUeqZj68ZvEU7TcJ279Rlw?=
 =?us-ascii?Q?qj2+Q2dry+v1/IL/3tUgw7bQUzK4LNI36JjpcLE3NMxeZAAGLGllQI7u67FJ?=
 =?us-ascii?Q?wOPicq48BHf07LajpyE8ieXB0NSdy7sR6bKrLijHU5elrxku7LbW18cBbuWX?=
 =?us-ascii?Q?CwKvV52FUMUlhZmmuMHkmSD3evALkBKcYDvaDHjeeTDVzxvZQUCD3uF5Y2hW?=
 =?us-ascii?Q?TTEcOlG+kYAajrvGN0yuy/KtzX5kvdrNBnKcLF6rzGc84QZMiNv6EtQZRzkZ?=
 =?us-ascii?Q?bc+deTeGv0wTVlxE6VRqefW9CL20pGYqce3mZuOivxB0eNZppx/2gUjhE8BJ?=
 =?us-ascii?Q?NdiLpKBSyq80hzXw5hR4EzQ9uLL6iCllO2ZKYRE+384JSwLwIORs1coWkS2g?=
 =?us-ascii?Q?sUJDyJQfuwT5Ubcs112MZt3p1K++cNmYXBs0zG5hjSfYf0bg/baBKN+rG2tT?=
 =?us-ascii?Q?cgHNbyTJaIQPNL0LIrRAQTlFJ2iiaYvXkWKCgn3AH9I5/Je5Sg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(1800799021)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 10:10:05.2722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fc4ab4-2c3b-40c3-7a8e-08dc94fefc3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091


Jakub Kicinski <kuba@kernel.org> writes:

> Some devices DMA stats to the host periodically. Add a helper
> which can wait for that to happen, based on frequency reported
> by the driver in ethtool.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - sleep for 25ms on top of the driver DMA period
>    (and remove confusing comment)
> ---
>  .../selftests/drivers/net/lib/py/env.py       | 20 ++++++++++++++++++-
>  tools/testing/selftests/net/lib/py/utils.py   |  4 ++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index edcedd7bffab..16d24fe7107d 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -1,9 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  import os
> +import time
>  from pathlib import Path
>  from lib.py import KsftSkipEx, KsftXfailEx
> -from lib.py import cmd, ip
> +from lib.py import cmd, ethtool, ip
>  from lib.py import NetNS, NetdevSimDev
>  from .remote import Remote
>  
> @@ -82,6 +83,8 @@ from .remote import Remote
>  
>          self.env = _load_env_file(src_path)
>  
> +        self._stats_settle_time = None
> +
>          # Things we try to destroy
>          self.remote = None
>          # These are for local testing state
> @@ -222,3 +225,18 @@ from .remote import Remote
>          if remote:
>              if not self._require_cmd(comm, "remote"):
>                  raise KsftSkipEx("Test requires (remote) command: " + comm)
> +
> +    def wait_hw_stats_settle(self):
> +        """
> +        Wait for HW stats to become consistent, some devices DMA HW stats
> +        periodically so events won't be reflected until next sync.
> +        Good drivers will tell us via ethtool what their sync period is.
> +        """
> +        if self._stats_settle_time is None:
> +            self._stats_settle_time = 0.025
> +
> +            data = ethtool("-c " + self.ifname, json=True)[0]
> +            if 'stats-block-usecs' in data:
> +                self._stats_settle_time += data['stats-block-usecs'] / 1000 / 1000

If there's a v3, this dual check-then-access could be folded into a
.get() and the whole expression then gets a bit simpler:

            data = ethtool("-c " + self.ifname, json=True)[0]
            self._stats_settle_time = 0.25 + \
                    data.get('stats-block-usecs', 0) / 1000 / 1000

> +
> +        time.sleep(self._stats_settle_time)
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 16907b51e034..11dbdd3b7612 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -78,6 +78,10 @@ import time
>      return tool('ip', args, json=json, host=host)
>  
>  
> +def ethtool(args, json=None, ns=None, host=None):
> +    return tool('ethtool', args,  json=json, ns=ns, host=host)

Double space here.

> +
> +
>  def rand_port():
>      """
>      Get a random unprivileged port, try to make sure it's not already used.


