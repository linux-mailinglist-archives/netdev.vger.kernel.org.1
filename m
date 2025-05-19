Return-Path: <netdev+bounces-191565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673A0ABC27A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8370A7A0974
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05081286400;
	Mon, 19 May 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B/O+o1GC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CFF27CCDA
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668646; cv=fail; b=KyojHQVZpNmTw81lAfLv+JH/8QPthBYtyQ9xvZUW2T5eZgzSRyQ9WSQ/OHHh6mt0cHOdJg2+DrsvvB/UsUpKiIETFz+1ZwbeSMdGAOPRqbZu7i9g8GYF4/s/TW3rTDVDXCgU0TvN7wNseS66ogG04bWKZKpMz7Rq9OdYaEUxfyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668646; c=relaxed/simple;
	bh=Kc0FGlXslx+lrOTqxiEWIUYMT6Za3zG2QorW0cJcpus=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PARQt8XttiNt4OWSN69sK1UWeI5spvKeLd/BQM15MOMbHK8xWDz1Oje3vtL/Re+TavtSPpJBLEZ9ZQlq0cutlfE3Brx4zTwUUiW8LufcZgDuhSN0wn8fT8/xrp1ehIzLclD2BfCgWdL3M9VpHn70VtYdERrEeVwpZ8hKEcIUAPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B/O+o1GC; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egViydvlsSFTvUBP6xN/lCdEUDpKmvFYvZ6XQ7qE4CEnA20SeFYW7nrvAw8ugYrdzDye1PzkrrdR4IIm/4MFY5/oV80/sFKPTVGThNjbivbzbPHb3Rj0s+EXPMdFX9AyiwrwF1xXAu3IyntzR9t63M/RJV6jJVvLc/TER1xLNHNbSwHGT4XUGYo7UbqTK8B15go8rFjdZN8u6YMp7B1seRzxfMOu1BNgGwbJ2wCMWnO6jOnheVKAo54srMbkfZ9YbHfEpZo4EAv7XJuFpgfD/68ghg1E8YiTfiCDfWpQxQyf/wIy6PEG/0nit9J/EuOhk6mAHyOJegMryj2IVlTlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYl1s0scF1H3Ewy17ZUHIJZFVxMz5mI5FF2p3Uq9eoc=;
 b=cUFAC8fR2A+LjML4TIzF5PBeBPcNhpfPULG5kN765+6PkkP9vbU1ZIEt8vuhnqP7G9Xwc13cKZyCNpKON3leDIv44GeTpcNpV7h44/AAHu/fwpusWHtqNQq5l0MXdKlKG9pw/n9q3usvp10FD8gHyJe3tpoH97N6bM5SnFieTGBxrklIWGkBPxl+eGOyWX+VPTt14HmJwLrgc4Dde4w5LTUj6tKHjqTo5D8DVdccx+2PdbYfQ1zWWOHAPmcMSe0Iq3aeJ5DwSVkkr5Fl4vLYn8lNJtvzjsuHltEV/oAQvAyYlejJaB67p3oySL+/hz+/4hA9QM4kL57MU8FSzI6mpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYl1s0scF1H3Ewy17ZUHIJZFVxMz5mI5FF2p3Uq9eoc=;
 b=B/O+o1GCqAtptiVeE53wuif8Mf+dkpiL6a6EKgQNAkerUWV/Ev//GGOP1jwvgMlcgSdYdvxN6ACWwY71Z0baWKNQKC8ohb3m1m/hnZgoMmADq6NRzJK1iM2QnIgrM42cmsbtuPeXIXBbA3NY+IeYJDUK9y2CovfSfL/jq701ZHVd5um/4SOf2Xx49XIXbdDt+DD9AT6iQNwwP8jvirKWmD/vCJL6NPhCobHtwx5bVeCed/1L/OumwhjCso1pcf0zQ/BTcSw+WhTSVLeYBOUPWsHBpucexsOnq7CnwTF6ymlggyCy8HlsYJXMMNYefc5/U/7/MjHxG4+lUURIpnVKdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 15:30:42 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%6]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:30:41 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	andrew@lunn.ch,
	gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org,
	Wojtek Wasko <wwasko@nvidia.com>
Subject: [PATCH v2] ptp: Add sysfs attribute to show PTP device is safe to open RO
Date: Mon, 19 May 2025 18:30:32 +0300
Message-ID: <20250519153032.655953-1-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: fe574527-eb15-43b7-ab62-08dd96ea1d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KCh+6h2p0yzUtThemAJztd0Q32Ke3qTJ1InemXWhdgYKjhy4PoeWcss3am9t?=
 =?us-ascii?Q?bwhSjK6TOpyPP+XQRJJeZiH2BJWBUKAOVK3QWKwXSXaz71LD1fuG1m0eMzTn?=
 =?us-ascii?Q?ov7QNiH9JF78N5dd26j0I8ZyT3cYRx+8J172Q7PpUiGftoO+pY4b9n1GgJ3h?=
 =?us-ascii?Q?hbg71E3Nblu8lX7dTe2/SeCvG90PvXuVLp13lsMwGsS7Opof7XqQAbZejh05?=
 =?us-ascii?Q?EwGs5q7WF6yBqLus+wXDDvBNwunp/uFkMW8bepqy4S0254TWFls4pjH9LI5k?=
 =?us-ascii?Q?QX0qoi0wRjnmBj5Wg9K3XvAL0NqZc1PWB24lJ0+kXvwBGIxZOUX9PXwOLevK?=
 =?us-ascii?Q?HRkt6fEmVRj50ZLdffdfttB170HOcJP3oq+nIQIxjYl8CR3yr3W57Id47mbf?=
 =?us-ascii?Q?GFpvvMFmI14bMY4XTZ7kuwg3iUfkqMmJ/isSVk3bFsZE8fBhqsp5pY2glb82?=
 =?us-ascii?Q?B6Jg7M5KPaUqfOyHvXuY2gO+L3Ijft91XG+vQKOHEF09sLmLMu8pzW+EB3FR?=
 =?us-ascii?Q?bky82pfAqB2Ozm+/vy936Ww/adzfWyIt8qkYcVxdcMDJ9Q77VhGh0QV7uc6B?=
 =?us-ascii?Q?S6I7JFP1Mbh29o5FUGhLUM/9wcnjk0KfZxEicERiR7a+qCrarKmk9koMv2vA?=
 =?us-ascii?Q?iruCbRwDr0cQegQhg8ZFtU0lhZgR39UTRH72jWCFx6/0of4aqRX5M+XdpphC?=
 =?us-ascii?Q?t43dbScwxvdg/iAj573mwpPpr/F/9ffxu2g55WAQgU5ZnR6TCHMTqF0tFKZv?=
 =?us-ascii?Q?6mQHg4UdA3ZyehyBXzwgmigSPZgCqnjmLpxGzcfbqIOdVDbsxJih0MtH/rfN?=
 =?us-ascii?Q?SVkf1TmkS+3R9xPk6jkOruUaWifVBiD5Oc3+NzQR9/nCHypU705Al0c+PNCJ?=
 =?us-ascii?Q?5ihYQp3XqD9iiXXdzEOUPIG9ghADMkmm6fSAd/qI7PAbTRrJr52GfF/w3NkR?=
 =?us-ascii?Q?sNAU/VQIt8dL+uVKvd8/kqTvlDjfy+cDIVdaQgxG0s8sKZVShJ9fT7y4C3Xq?=
 =?us-ascii?Q?o09ws8oTwbOXP1XQOHsMkUYmkLld+H+WuvSCZ3O0dWSeiNBG7h1Ea47KRHRx?=
 =?us-ascii?Q?18pO2ct/c1KcitkOMxRAFULddeBWaQ+zetlAC3jIR80NWi/s4SU9Dgk3VDZu?=
 =?us-ascii?Q?qF4Iiy5z50Ip6PBPcQ1Y0l2BSiWbd0J7VOO12AvbpCqK0IUSMpB/qpmCpGhn?=
 =?us-ascii?Q?iEFol7Zgzwiqa5wRn8Z1MI1uPMNEccEKvLWKLtQYQMySET0QrCIaap1XzflS?=
 =?us-ascii?Q?gMvk3uz33diuL3v27qYV3FIKCbZWCqzIKKUmhun5/UNIem9y/2xz36uGiMD3?=
 =?us-ascii?Q?eUrKfnBqo03A2QiNL4mADVck8zCAsK9erKHRDiFsowgMuYUpgJ2H4yK2REBS?=
 =?us-ascii?Q?GgFZg7ahpUPF3YpQyxxxVGpU5gCs76O9Ur/fO9qlZnphU9Plw6RlQKmYiUEl?=
 =?us-ascii?Q?JoiWQxUjxmI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9oLIMAISIeIpUIA2+QwPWHh9GAIjQBNUd9iaVxJs5+Z3/Tr+G9Yk6WWOuHhT?=
 =?us-ascii?Q?pnHJHzrT7/0pi0paoKZ51BgeC+DdE3MF8NGPG+cvDl3mfc3DzRuLyS4FFoL0?=
 =?us-ascii?Q?fs8zLKiPYcfMq9VOEjNq7vKE4e/MjJxUatE+kgyhOwagM4vbhoWd+9DTpdPa?=
 =?us-ascii?Q?VoxHiqnqbkVe6VOXZcPT9zcx2vKC5I92Q5zrEYda5ppDhyLDhkKMeVOvgRUi?=
 =?us-ascii?Q?3gCi7hyUjFYCX8QhuWRzx6LLCaxLBtcOiibB6iAA73sJYX9SrdfIZ5qDqj28?=
 =?us-ascii?Q?bEcvdqYJMstugistMl+7AVoutHscL77m9wigGHeTxCb920CGLSJcbW9+mImb?=
 =?us-ascii?Q?eVXo8QkZ3bUnP7XjxK/ouYp48zepbDK6Rz7LpvxUWAJ6zAA9XBKCU8tkqBLg?=
 =?us-ascii?Q?UwEK1J+pLf6gSW1NwD4HGFTImWiNQbOVcYovWK5rp+7NWACNpOM4YvLGR4b2?=
 =?us-ascii?Q?AnJY7gZBx6u3+OOwa7IypjdtaML+f4Qa4RzkakGDx1ZzN1PliWNZ6zDBkwPf?=
 =?us-ascii?Q?zvKAv5duPmfZcQ04NPLOyx4qDSlMs+o/Yz2cF45+2isrD9q4/ddfwKRZEf2R?=
 =?us-ascii?Q?0vgrx1qDiFw/SIAcP+gj+AnbkXb6ZL1XlWiZL4uHwp6lSj6mDrvuVxrLlKr2?=
 =?us-ascii?Q?m8/raVgQl505k+NsX53Cqw4I1g+Ge1YaxxnwzkMquYjNwHmkuIiydKLm1I3i?=
 =?us-ascii?Q?eI4TuSEtnfOJHjE8E6UtKPI3SKRjPX1noJSOafOXwm1Y6oOuEHl3J48vw9iN?=
 =?us-ascii?Q?ZVlpq4IaSNx7xPRUHw//pXDhvZsZghZHOUQJVETx+5OsxkZJu/Hs5LWlNjy9?=
 =?us-ascii?Q?80RHf7mq+Bqz5p3Lh2ZxZ7paTYhae7kDB3wEw+9SkMEyNIGwvoPbb365vfta?=
 =?us-ascii?Q?8jD56o3Zwm4cfWWL0NeBRW3jGdAVnBJ1hXfm9tK8V4zGhn830iurtt9sTMew?=
 =?us-ascii?Q?1TVRKPhpJcUUgqvMMO0cH+zhLfHYsSO5XZu2gaa4iQWEeKW4+TiQTR8xt9wy?=
 =?us-ascii?Q?Cg6INlpZPuqznUnifhivOK96fng2B8/zYNulfTdcC1ptu7wcOGM9XjYOK08m?=
 =?us-ascii?Q?xDsC/fk7p4wS8BpLSRKEC25BWQHcRkJ3TxrohJAvzT485CPWsD2HXOEQMcTM?=
 =?us-ascii?Q?gmxOb7tT3LosRq4LpKDgQMs19LAwpReu11P6thmXbWnEXq633wZMM5FMQ36l?=
 =?us-ascii?Q?mpPF3mz5ZktGYi1drFoAD0K/yVs8GTQRFntzz8zHHsKow1+Bg+JYSCEbU0zB?=
 =?us-ascii?Q?8lU7Gx+SiBl9fJBU+0SaZDW5AaSil97dY4miovys8ieHQH6en2oEoIZJw0bq?=
 =?us-ascii?Q?xC4PwUiUYcPp4HVHICHcKYkAlYTSKUhcF7EqphmfohQ2eIBNn7lENqeK48Fg?=
 =?us-ascii?Q?+sukhVSX8knQ+hVtuppO7Mi+SLe5E48MCEy20+8bixXFEK/Zioa8gFnYXr9X?=
 =?us-ascii?Q?ZiNcg1ZnNvJEN4v5qXSe9WUth2ZPsGa/MDbn0Gj3qMsoWKMDHyLWv7Z/Ah4g?=
 =?us-ascii?Q?D5IbPjpz9zfpqJJi8NvpuDgcX5rUqxZqjiNXXsIeWxgfIGLripHSi4/xB3e4?=
 =?us-ascii?Q?5oCvqqnxEDxUrK1pPlSChvNzsJkxi2tbnGJd8j5B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe574527-eb15-43b7-ab62-08dd96ea1d58
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:30:41.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xokHU+f7wo/wSBBhD1xzUShfW3LGIqRrwvEsiJjVAaoyTNj0ce+8vBRUKICDbYF4MeSY/tAmJWl687G01VfseQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073

Recent patches introduced in 6.15 implement permissions checks for PTP
clocks [1]. Prior to those, a process with readonly access could modify
the state of PTP devices, in particular the generation and consumption
of PPS signals. This security hole was not widely exposed as userspace
managing the ownership and permissions of PTP device nodes (e.g. udev)
typically disabled unprivileged access entirely as a stopgap workaround.

Although the security vulnerability has been fixed in the kernel,
userspace has no reliable way to detect whether the necessary
permissions checks are actually in place. As a result, it must continue
restricting PTP device permissions, even though unprivileged users can
now be granted readonly access.

There is little precedent for fixing device permissions security hole
covered by a long-standing userspace workaround. In previous cases where
device permission checks were tightened [2-4], there were no userspace
workarounds to remove/disable and so kernel fixes were applied silently
without notifying the userspace.

A possible solution that would not require new ABI is for userspace to
check the kernel version to detect whether the fix is in place. However,
this approach is unreliable and error-prone, especially if backports are
considered [5].

Add a readonly sysfs attribute to PTP clocks, "ro_safe", backed by a
static string.

[1] https://lore.kernel.org/netdev/20250303161345.3053496-1-wwasko@nvidia.com/
[2] https://lore.kernel.org/lkml/20070723145105.01b3acc3@the-village.bc.nu/
[3] https://lore.kernel.org/linux-mtd/20200716115346.GA1667288@kroah.com/
[4] https://lore.kernel.org/linux-mtd/20210303155735.25887-1-michael@walle.cc/
[5] https://github.com/systemd/systemd/pull/37302#issuecomment-2850510329

Changes in v2:
- Document the new sysfs node

Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
---
 Documentation/ABI/testing/sysfs-ptp | 8 ++++++++
 drivers/ptp/ptp_sysfs.c             | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-ptp b/Documentation/ABI/testing/sysfs-ptp
index 9c317ac7c47a..1968199dcf1c 100644
--- a/Documentation/ABI/testing/sysfs-ptp
+++ b/Documentation/ABI/testing/sysfs-ptp
@@ -140,3 +140,11 @@ Description:
 		PPS events to the Linux PPS subsystem. To enable PPS
 		events, write a "1" into the file. To disable events,
 		write a "0" into the file.
+
+What:		/sys/class/ptp/ptp<N>/ro_safe
+Date:		May 2025
+Contact:	Wojtek Wasko <wwasko@nvidia.com>
+Description:
+        This read-only file conveys whether the kernel
+        implements necessary permissions checks to allow
+        safe readonly access to PTP devices.
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 6b1b8f57cd95..763fc54cf267 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -28,6 +28,8 @@ static ssize_t max_phase_adjustment_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(max_phase_adjustment);
 
+static DEVICE_STRING_ATTR_RO(ro_safe, 0444, "1\n");
+
 #define PTP_SHOW_INT(name, var)						\
 static ssize_t var##_show(struct device *dev,				\
 			   struct device_attribute *attr, char *page)	\
@@ -320,6 +322,7 @@ static DEVICE_ATTR_RW(max_vclocks);
 
 static struct attribute *ptp_attrs[] = {
 	&dev_attr_clock_name.attr,
+	&dev_attr_ro_safe.attr.attr,
 
 	&dev_attr_max_adjustment.attr,
 	&dev_attr_max_phase_adjustment.attr,
-- 
2.43.5


