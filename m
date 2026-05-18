Return-Path: <netdev+bounces-289136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNacGXZIC2o7FQUAu9opvQ
	(envelope-from <netdev+bounces-289136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:12:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C81A57178C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 625773019A23
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900A376490;
	Mon, 18 May 2026 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZZdRf3A9"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2CC382284
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124293; cv=fail; b=WzfQY49rb0c25RPLScsisdk+vs0uJcaXNPY0WVOpbLTY9KDCAiOQ9BXcp/A8M7+8AlQ6jWTTH9yMI53fD7en+7J0qWoNAlsVDQW4F9OA9KU1WmEiEmV1jUoNIQNd+eF4EFq9lP8r1PaD1cZ59J6O5pIqrDZ9kj0wgYB3YXOlZZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124293; c=relaxed/simple;
	bh=H8Aub50MnlCFiPmpoU3puEsIZUFOyGP7TzjS53Azf0M=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ERY8H72ceeATxioD6GTkBDcD/+feqF771ISFhIyZ9M8HsGIdd1CSt7Qs28WRV5py/QUVYfdpP54IiWWmnf1GOL/I9638rr8H60XMBAqfOhFZ4XYebnBn1CRvQ7yrGNN0HNIFdjz7uSSK6abG+kOMjuO9SpY1EyNWeXaSYbn9J1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZZdRf3A9; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2DhJAxp9lGj7+LpDwJFg53/p6z5Qb9dSgF86UWxV3VEj7Q0j2BCPUf1URb9Auyby2Zmki80nrGNpHjMr0yNDB6GG7k40wOSv7tPdfA3ahIL6tkVGIGp44DwKoyhdiEX+E8XW0YKbYvwBSuyyFKLwDrRRi8cPV1ZMPkox78B+WqVZoANXaNNLM8IPFxCHrfzEV/f+6ROUEXUALs1ZHZI25qMhiYjBiJ6Z28HVLidxh6peR0dV9Uv5NtkYGy4xpzK92kVW6jt5y/L5eK5oi4euQA5/dkE+rrG0d/G/6xeATmBD4LZTZl9D4EIaei7TsgzQeI2CjYVZNapTPUiioJC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ3fg12nh0e/INWBzXuh4mKYU+m5hB6FtB4PQsTlsoA=;
 b=QJOqnO/tX0eGlvs+GNjXi1+kUcWxlKBoTExPpxOwgSuraZEHhMjEdlRSlt/s9Uw1SNvOb4UFYY9Gqy3nPBi1AbEspCrsXObLPM22lW2yVAK7DY50G08WoXoBF8G8SN1Ss0mdwI62vKgXkEOr9C3F0tLAnU5R59wY+AQL140BKYH9Y4nII0SjLfF4XSv56NrHtNH5TGmlqepjZzqvAKs0UbiCGKz009iofIf1PmiQwL5GDBHpILQFclmDAJ12q0bmm/ZurLOQP8j5MDc+dtvaT7+wx8AJZrkCGYtZDyVBCUCNDBkDvk4l4hQSmupUNmsSCs7syZmWLU4A0AtT0zjsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ3fg12nh0e/INWBzXuh4mKYU+m5hB6FtB4PQsTlsoA=;
 b=ZZdRf3A90od/I04qHLXp3BXjGXdQZI35vQ4k9J9NuJd494uzR490guZrjplxM1Z7LMFyjcrw8qsufXl1ippeFGG7RKFQMbvc/bpvaXzJoZwh6uGLKimuV7RVsmKGwKgBPyr9t7qA9H1vpI1x+9Cyaf5mAt0eDIr3zXIPl2VzuYdF2TH3W5xLjhrqyMnQgq7MYp1Lp8rrfWISayNqlDaY+eKXvOr3McFql9gfi3AoPtjrYSG005RUdScBObyIc8cOgPofA/yKx7bMiKZZsG95KjRKi1N/peXK+FxgdfTL+Iczc0wbyilIiuFxpuBAysfFX1CHZkAZXLT2haL+oMrt+w==
Received: from PH7PR17CA0031.namprd17.prod.outlook.com (2603:10b6:510:323::14)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 17:11:27 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:510:323:cafe::f4) by PH7PR17CA0031.outlook.office365.com
 (2603:10b6:510:323::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 17:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 17:11:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 10:11:03 -0700
Received: from fedora (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 10:11:00 -0700
References: <CABV8kRzn=oewDQcv-_-WzktpxAuLBPiTgMdfcpyOYAnz=0kiDA@mail.gmail.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Keno Fischer <keno@juliahub.com>
CC: <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [BUG] mlxsw: Driver/Firmware disagreement about max headroom size
Date: Mon, 18 May 2026 18:09:22 +0200
In-Reply-To: <CABV8kRzn=oewDQcv-_-WzktpxAuLBPiTgMdfcpyOYAnz=0kiDA@mail.gmail.com>
Message-ID: <87qzn8myn4.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9c5d2d-3ea0-4274-f337-08deb5007f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|11063799003|22082099003|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ONGZmNnl+W49qZkggJBmgwwQ4rxVLVEM9thsGnijqshE/i8IvQ18rhcHr4uAEmpSQf0VO0WyFmIwFStmEzBZY1MqbQucsWOemQIhOAN+ih+E6vMHhZojUi2VZ63lA1lWEioLCbc8g4APZm78wrO03CXwRsIZiKyWo8a07aGHoA4F0w9k3yNJVal71feJEUzcxcHKswFmIu/UtcB7tCiU6Bu9uGpRnMDeWSjH5lNtGX+8J/ZoPGr6ly679e5L/Pbm50JGQGd19sDYjjw80vj0aZuX19qYBeu5r3W+2fBP5ZeLAJYuJF1671uUOFv5JY7JOKeP84MZxuGY+0r3GWJzeu+d1bJSmm5pRPFjm8VYEdQ2no95NoMCX2zZaBCaPq60f2pZGJUnldfqvlzGlwxnmgIJN3cQAPSYZ3rkHztUumxfKsn1QRch1TF+RZFYbnZt9GreDVudIMZ7ZF5lAxDDlYyQXO0STqTM+LFgydGyk1AokCJcixz7UtmPaAv6uKr8R5MZwxcO/3Tf3OpcUZXWZewWz1gQbKiutzZ6d4sENPT9FS93DnX040A3aIa7cWacquFIBb9huuCx8JHWGlW036jO2w+UkRjcd6NvbNlIN7ve2WZrbSHoef0O9X9XG8MsSwcayeFkOF/rQ/S7IsLXFSpn7wMzuR8yv9VnOvWN+2smYTHS8sRWyfcOZd1iX27HpI6RTepfmhhbXMU8obcHwSXdw2SLd35/72yAyh/WSFA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799003)(22082099003)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N3DxVhmWw3XCEUgKUZ3FQV0x+hEx4XxYcL/G++AgnSdCGpEFK2Xf+uV+CgCaxo3r+vBEw/8/um5sM+26q67Qq+NzLqu0LxFLQaiRCg/C7Z/YapZC6Abq2Ii76VIDswghfxBoZHtDfeARySPO94TkaXhkfol8aQ+RAbUqxepyZ8SC+udslHxcKeJf8VE5bvRNsfaR9p4Eenoo9Ru+atPNtRR4zb7zsZtb4UFjxvMfEBEC8X7q7UNtGklm1j5IpWR8aP71SFS7xMkTjOUdzKAX1D0U1eBOcc6pH28KZm/ZNggVpyJipUDYvItGwUk+9CkxtUP7vPJDy7REbN1ZOgM3uSXED2cofukZcAY3rDcvvLLyYh4a0j7NG18Egl6/gC5rvPIcZW05tb/y1IH/o+ODnuNhxfLU5O0JAX0hZ0E8HQZTVY0YzEakgxWJVOVhwqbt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 17:11:26.9916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9c5d2d-3ea0-4274-f337-08deb5007f29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289136-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8C81A57178C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Keno Fischer <keno@juliahub.com> writes:

> Hello mlxsw maintainers,
>
> I don't think this bug is particularly consequential, but there appears to be a
> disagreement between the driver and the firmware regarding the proper max
> headroom size. On my SN3800, I see the following:
>
>  ```
> $ tc qdisc replace dev swp1 root handle 1: prio bands 8 priomap 0 1 2 3 4 5 6 7
> $ tc qdisc replace dev swp2 root handle 1: prio bands 8 priomap 0 1 2 3 4 5 6 7
> $ dcb buffer set dev swp1 \
>       buffer-size all:0 0:1219K \
>       prio-buffer 0:0 1:0 2:0 3:0 4:0 5:0 6:0 7:0
> Attribute write: No buffer space available
> $ dcb buffer set dev swp2 \
>       buffer-size all:0 0:1219K \
>       prio-buffer 0:0 1:0 2:0 3:0 4:0 5:0 6:0 7:0
> [78711.680961] mlxsw_spectrum2 0000:07:00.0: EMAD reg access failed
> (tid=43b7c51f003ef26e,reg_id=500c(pbmc),type=write,status=7(bad
> parameter))
> Attribute write: I/O error
> ```
>
> I don't know why this differs between the two switch ports, but since
> the driver goes through a lot of effort to calculate the max value
> and return a nice error (as shown in the first command), it seems
> like a bug that it wouldn't do so on the second port.

The driver is making the assumption that the headroom is allocated per
port, but in fact it's allocated per a higher-level "port cluster".
There's a separate HW resource to query how many ports are shared like
this, and then the ports are allocated into clusters linearly by their
local_port number.

I have something sketched up that might as well work, but I need to test
it a bit and see if it survives regression.

> As an aside, as a novice to this area, it wasn't clear to me from the
> docs (https://github.com/Mellanox/mlxsw/wiki/Quality-of-Service),
> whether the headroom buffer is a separate piece of memory or
> whether it steals part of the shared buffer memory space, which

My understanding is that the headroom space that is configured at a PG
cannot be used for other PG's and other ports' traffic. In that sense it
subtracts from the shared buffer -- when there is traffic from other
ports that is considered for admission into the shared buffer, it will
not be admitted if the only available space is in "foreign" headrooms.

> is what prompted me to just try various values here. It also wasn't
> clear to me whether the headroom config did anything for lossy PGs.
> Hope my naive view can help improve the page :).

It's been a while since I touched this stuff, so maybe I'm missing
something, but I think that configuring anything above MTU is only
really relevant for lossless flows. One other use case from the top of
my head is egress mirror, but the driver should account for that
automatically.

