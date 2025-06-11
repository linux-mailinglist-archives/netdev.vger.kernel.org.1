Return-Path: <netdev+bounces-196658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F2AD5C5E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9346C3AAC14
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71821C8632;
	Wed, 11 Jun 2025 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FdoOiz1D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF51BD01F
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659676; cv=fail; b=LmWUigf86BsQ0VuaXT7gclIedgCUF5J9MABRkdC8j3DSIvYJxbQXly12jpdKp+G2t6IYNdrnHuY1qvmt3YcT9iUdlyMGLRNMoETwqVtCmN0cApCyMZdRLXfn8Be1QQchY5GrD35dM5CrtOxh5LItnl9cSxrIqDEVGbmhqkZbesU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659676; c=relaxed/simple;
	bh=/B/eNvHpCMZ0AOWnvnm4GSdFeZPfuaUNXdQABuaCybU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DCablfY6E/Yu1vy+2nX9HKQMX9t2wvqwQrtkDVYkDxEKgfm/cHXUIvCqgAVvWftAmVg53NvCTnqVR0aVLy60C91r5mTkfEpaezDdPm3tmHBzr4iwzufp68BlZZ+l2GnE+uHM2mwRKF+H4VYkoatWK6liumC9z6x4hOiRRuaLFFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FdoOiz1D; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F68GzEhs4BU6DY+TuVt90cSkmTmKxuGEEPoEt5uc3f9fI72dmiXOZb7dNjqfBjp5W1BN8zljhR2qSGfphhhXo97sMDxgF5mRi3Inm6nkLl8j8cw3PUVagVH1AXJZ4T4euP1fAm6DcD+KzDtseqNoMZH1H/GzM2X9SQYxWtvMrZH96WiX4Q7o9SgnlOd9b+piD5Q5DX4WOI0jtb6KuVhsMty6slF0qpY+yGB4XjUuzYtdaMRu9l5PG6yul1P3SUKd/E0Mrfsh714yixTCxl5qdTnHyg4id46/vHktq/y45tQA1oiennEyCd/AlRRFO6Uy+AevZ/Cukp4bxxDUGKpGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCRk51OKVu9YsOexi0WhltYtTxtZAs6b0Qd6nAN4eWs=;
 b=NcXvupr4Z/fseoJgPSI8vApR1DiTIvy16XwV2+PWltxskAKidQ1qR+W71pFFasQVaxXv7TRc2wqaUTByXgqV4K2bpWvNLLfJH5Eiyr+XZ2X9pFgyd71SY7MHJrrxzGH9tFt7HZSZhTwMV0dbtEPVyS9BwoUgY7x1xLw1FDR6dT2ORWMetZRoeSKNAbut1iASHj5QMv90yQtJPgNRL6HuxOUSB/AT5404Oq8ArtYEdANRAUFO2YJhj+/+7QLiTypA5MytWWPa9UeuerW/kUCaVnDyKgZ1UCSl1k0JgL5QtXrTIHUNP66lgEm95FE2hexVwhTVgDMCA7nW9hSKOv4zcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCRk51OKVu9YsOexi0WhltYtTxtZAs6b0Qd6nAN4eWs=;
 b=FdoOiz1DUQIkfA8kdR9qEBUj/9Y+73RS3xPorfXR2l6/dh5znboq09YuxgnBInOaqQoLz8ckHi5jxNxbdkUBfADW+0Xz3y3I//8q2vtONZPgAwjk+hdp0I+jYRLTn9tJf1jvJhM6niCSpsngxGMB1z5W0WboQjFl1sXW3aOiXHgKHXiCW+miXW2+FJO150jNUJshyOXt8f8NdYR+3Vre4AP4RCtd3QRgLdGF0qzAZw2+TdiDrMfNoQ+NfXfZYKnFF5qqRl6YaAtkhEBiwhSEcyniaj6XjJwYp2ZMUYtarLjd7ajNGWfN6f7xT8pEmyW1J9pNVJy/gutYENpMt4KuJA==
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 16:34:30 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::20) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Wed,
 11 Jun 2025 16:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 16:34:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Jun
 2025 09:34:13 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 11 Jun
 2025 09:34:08 -0700
References: <cover.1749499963.git.petrm@nvidia.com>
 <20250610055856.5ca1558a@kernel.org> <87wm9jeo3n.fsf@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David
 Ahern" <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/14] ipmr, ip6mr: Allow MC-routing
 locally-generated MC packets
Date: Wed, 11 Jun 2025 17:30:15 +0200
In-Reply-To: <87wm9jeo3n.fsf@nvidia.com>
Message-ID: <87o6uui6f7.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 12148431-9fe3-44db-f00f-08dda905d6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uFusgM/PjObZd7KVO/UjTpOTAyuorIl3tOxyeougGNDH9ihi2j6OCEU4mW6p?=
 =?us-ascii?Q?Y7/SBW24icsj/myqyZtAID9ze9SOfA4SvEKLHHOVmTShsBS2Z34sDXCzkyL2?=
 =?us-ascii?Q?BZYdbU31UphvGl2Krxcb/T1aLkib/lRgD0lAJud7Y3CmHqH3x7t9VzzoAumZ?=
 =?us-ascii?Q?KRwfhkOR6q3ooSRog6nM8O8SCR6IJTed1G2r5fyW8iwBRh1u+l5AQQqREOjO?=
 =?us-ascii?Q?HbBU908j7oBEfCnY2DdfhYdEJuboIeZv0SBoT7/uLDPmzIZTLVXkpgtvDqad?=
 =?us-ascii?Q?cnu0b0il1ao1EaV7109XiMFWw7j8UYFVQaGeUCr11TIb8h/06lHX93mBBuyy?=
 =?us-ascii?Q?K7O/pUkmyVsZ64Pu6otgH2M29IJQ4Ax8JZ5YtZgeCM4h0VVUaYlBaVVoyyY6?=
 =?us-ascii?Q?hS5zkmguciPhoP/46aWUJBlikykAOukzQ1sEG+191JjtUnBPo2IKRCNoFzbT?=
 =?us-ascii?Q?rSXpDFJ4I6oK9bSLt00RE1aIenTiE+rCuhMGWO1aBG4Im7xZ1T9DsOUfZNfU?=
 =?us-ascii?Q?LxdK0RIDehwCsQ/x/rgxP5kNxOcd0f60zDyIUGtGPKLghElPqldshv1tqT7W?=
 =?us-ascii?Q?t19RMIO918M+LCcyezGwEUkWC0yWxtkbAZotRV4m8QQsxC8vbAEcLCtjgxbG?=
 =?us-ascii?Q?HKisfkKLD8dRGHwFjp9SghfE1Ri3bo4POls/n2eASRRI2Vq7u9BgekgpuuYj?=
 =?us-ascii?Q?h4Md8BkLQFLUH+Dbcp6qTqZVBi1zopkindavVS+LPn8uTw0RlaCvj+L0P6nB?=
 =?us-ascii?Q?DLyF/t89SSthN0AdiqILcjVklSB6lEEkAQS5pN3oldSm2Sy6hud3piS2xr5l?=
 =?us-ascii?Q?1Wzom90rLK0OxmJfk4oB9FUxIZdbVEljk4CCEoMcJTOItBOrG4ztfZvUfJ66?=
 =?us-ascii?Q?Xl771sLcI9WbskYQYMqhlarKoK2/g59jKTtJb5n8S7EUjJqRVf+FCIwKTDjm?=
 =?us-ascii?Q?jIfeVqATdOARYjqVBRU5Jkby9chd0OAScpeCax4o424knyfohjFGxK+FQUZv?=
 =?us-ascii?Q?Au6BHfPpWegeiywn1+7xmqVYHzsfgnPjyHKyeOhVSJBMTyZv+zZTuUbW0uA3?=
 =?us-ascii?Q?E1/D0AleWR2cb/uMuqlHoVY9qwXv08vVEuZwmiyr3y8mXOklupRyE8iJxHuL?=
 =?us-ascii?Q?mMHjMHKAXSJsXkKk8hvnPCR5zRyTZvlbjG4B3VtV2oKO4CfdIHF1TeFjunBO?=
 =?us-ascii?Q?HovjsVvKpIseTEe0e8RNzudDIKsijLMFtzAs5oy9lZqQQ9RSimSkOy7VNYWm?=
 =?us-ascii?Q?R/kDKSu447ko3s/mZ7cmyo32yUgenOJ/VaxTf9vmu9IS8T7UpGTrDR0RseV+?=
 =?us-ascii?Q?I/z5izBk4llw0hDpkHvGiOy+aO5dDqRyoNduROKCqF7I0cOTA3JXkcPZMLeu?=
 =?us-ascii?Q?rUQHNCIDVhtwoDcC6dJmIIr08Fn+2LmZ+nHzhPUGCZ64tMehJrfQDf30+m/p?=
 =?us-ascii?Q?SJRp7IpJk98BqkfpysH2711//JB/Ee0XrYPF3P4DID7v88bnkKrKVmm2+z1z?=
 =?us-ascii?Q?v+Zu9SWm2qujdjIs1DHpsunvfnX2JS8Vwz53?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 16:34:29.8736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12148431-9fe3-44db-f00f-08dda905d6c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026


Petr Machata <petrm@nvidia.com> writes:

> Jakub Kicinski <kuba@kernel.org> writes:
>
>> On Mon, 9 Jun 2025 22:50:16 +0200 Petr Machata wrote:
>>> Multicast routing is today handled in the input path. Locally generated MC
>>> packets don't hit the IPMR code. Thus if a VXLAN remote address is
>>> multicast, the driver needs to set an OIF during route lookup. In practice
>>> that means that MC routing configuration needs to be kept in sync with the
>>> VXLAN FDB and MDB. Ideally, the VXLAN packets would be routed by the MC
>>> routing code instead.
>>
>> I think this leads to kmemleaks:
>> [...]
>> hit by netdevsim udp_tunnel_nic.sh
>
> Thanks, I'll take a look.

Hmm, I can't reproduce this :-| I'm using the following incantation to
build the kernel:

    vng --build --config tools/testing/selftests/net/forwarding/config \
                --config tools/testing/selftests/drivers/net/config \
                --config tools/testing/selftests/drivers/net/netdevsim/config \
                --config kernel/configs/debug.config

And run the test like so:

    vng -v --run . --user root --cpus 4 -- \
        make -C tools/testing/selftests TARGETS=drivers/net/netdevsim \
                TEST_PROGS=udp_tunnel_nic.sh TEST_GEN_PROGS="" run_tests

vng -v --run . --user root --cpus 4 -- \
        bash -c 'make -C tools/testing/selftests TARGETS=drivers/net/netdevsim \
                        TEST_PROGS=udp_tunnel_nic.sh TEST_GEN_PROGS="" run_tests; \
                 echo scan > /sys/kernel/debug/kmemleak; \
                 cat /sys/kernel/debug/kmemleak'

Anything I'm missing, or is this what the CI is doing, more or less?

Could it actually have been caused by another test? The howto page
mentions that the CI is running the tests one at a time, so I don't
suppose that's a possibility.

I'll try to run a more fuller suite tomorrow and star at the code a bit
to see if I might be missing an error branch or something.

