Return-Path: <netdev+bounces-208155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3E4B0A513
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 15:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5574E179DE2
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD1A2DC339;
	Fri, 18 Jul 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M1Yc/9m4"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8EA2DC32A;
	Fri, 18 Jul 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845111; cv=fail; b=VEs1CTiapZC/MXGUKIA5O1HEVrm1l8CvJWlmyQqhoJwouZTWXqb/Uvoqunpbw4rITHf+tERBoXJ5QbJodTdQBJTlSWu2ob/u4ukHzXSsEzGRH64N1ZX/3ojoTjnZLm2j4yDk7dCqC7caAvcJYCtE+NBu0JLoNFMhDq57iyHJd4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845111; c=relaxed/simple;
	bh=gTcWo26ZMLtGy3y2TG1+aycHVw9USbfwGZX9GH+jkng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A3EE47Pc91crSyf+/+lQYh/K2esMWgymy84Os3a2zV4qyZppshfhivzRajc+EjNw08Ac7YDutnFP87YhO2+4SbBIEEX/ue/wti6beD9AOKUYxow/PepFMfpxPyYLVgwa3RCeKwAiGGinhYaUlW2X7zRK0Vd1mqquo53LWnk9KR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M1Yc/9m4; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwZtZ2kgX/85T4mCeOnJnRPAgsszj1nNi5mLy1vfJtVdEYSqowYmKeyTn0sC7NWpTA2gcYXdd85otYJ0wgfgpqGTj7MORVbg4F0fFIP4zRP5Q5jzoNcYmkqMNIwm910CcKO+L5gcqhB8MDwJOYGbmOXvXLwa2z+R2jzVmzVXZOOY+osOmdMVOv1CKLAHT17G8d25S0kjVOWuSX1pIy+9uN/a0ZmixePUdi5hWfXlOFBsBOcUw6XRljMA1dU5vdIjsA1p22C0BYeQHGairluSvmuq2PsOfrtmS3Yrb3pxGNEGN9JbC/xZF/pVTfczx3AAbd6lVj5vgJDuqb3Zat0+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsea532QEjDQ2OMaHx5HzZ66KIccH7eaFNKGV4dzsvQ=;
 b=aVM4QsbCQ5BLpJFSqxAVzrxv82RUmC2AYaxVmo3J/VkEQdxVwjLBuLwN9D/a1Nqkt2Z8w39qaIEJ2F+2L9/3/MxO8UFIpmg2P667wU/Ttyun8rkRrUamzGoZxnHSRjsAEIMB9oaj4VVWPQRwHCNwFTOlO6IBZBVPK9W9tzLW0eJu/yCbWe8CnUPdkgDVSzjyx5+df0gieNkTLOZrLELydlWsP3VtYRvGVwkffBKwyO2MR1aLFLFGn1cl96P3YcE/2g5JAJav2AytoUcts958hcPJ2GL3wT41O+Y6uhKHQVuwKDIxvCYJI5LJ2PeCPAeP5LcLRBw8LtZ8TBgBbzA9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsea532QEjDQ2OMaHx5HzZ66KIccH7eaFNKGV4dzsvQ=;
 b=M1Yc/9m4nAnFrbiQ2v0hiEuub1frIyhnzV2nhaP2WeVwLDnq6CVinNRfyC1ebay6uN//hoa8cTRWIiMXp+WDbImvCQNAxdYBy5kMSSe475KsUhjNqJAHm41rZnV9ThqDFcCwGzOEShAa97cNQwi4Qhqs5XMRnk+iV3ceQOYlc78wM7Es1qeEUgiOJUWPN58bFTt2fYr5TL7NwbYwtmIznw1J/rAx814efk8Vu0WI/38NqoQlbQzCswhbgj9g4Sa3Di88nCxV5gCwVo/IoPRhtfwJXYEuVRsbqxZ07/lmhunRCsUijUIiY8F0YoOxngq+K0y8ag3mG1y8s5q6A+WDkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8368.eurprd04.prod.outlook.com (2603:10a6:102:1bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 13:25:04 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%5]) with mapi id 15.20.8943.027; Fri, 18 Jul 2025
 13:25:03 +0000
Date: Fri, 18 Jul 2025 16:25:00 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	yangbo.lu@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] ptp: prevent possible ABBA deadlock in
 ptp_clock_freerun()
Message-ID: <20250718132500.wq4ahdbiwk2dwwnw@skbuf>
References: <20250718114958.1473199-1-aha310510@gmail.com>
 <20250718114958.1473199-1-aha310510@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718114958.1473199-1-aha310510@gmail.com>
 <20250718114958.1473199-1-aha310510@gmail.com>
X-ClientProxiedBy: VI1PR03CA0076.eurprd03.prod.outlook.com
 (2603:10a6:803:50::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: c68140b4-5415-4478-4021-08ddc5fe8141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|19092799006|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ENSJ9dwbo+EVXXDp22gQ0eC561b9mmpc/AQEuwMC44WxBkbmFTXDp24L3Dea?=
 =?us-ascii?Q?zzcQbHa5dNmpNdztXbNCDM052tqMGaliA0dVnpU2CkXsUuFsLx8zQN0AkEW2?=
 =?us-ascii?Q?5THnr1Wj32e8k2tMvt/6ma70TvDzBbaemB44XVNKtnHj2pMgrHAl9WkzYL8N?=
 =?us-ascii?Q?CYb66Z+SH+qvau55wVfGi7dKGXR95AW95QpajQ2l6jh59Yd4rLfuYEHaIOD2?=
 =?us-ascii?Q?VMDlXIHvoLhwzHoNzaMlRkcC8JfahRZqb7Y/y5CYdBbrB9WuxjCZ5+9pWvKo?=
 =?us-ascii?Q?fD0959xIEVrBvckchcB3ktV1bCGNMwWHxjMBLeYjYKX/2k+HZKdb9+FcQuQD?=
 =?us-ascii?Q?vCPU25cMxALptHs8TgH12NgGviDnQjhDXuQwODWZm2w6T3AHGJON2TIokshA?=
 =?us-ascii?Q?Ers6hyjlfAIEXxPkGurbiGkZAdPqm2lZvTRwm09R1iCxHfcwhaw8jmU1+rXQ?=
 =?us-ascii?Q?xUi0m9KAQIwbK88OX96BPE1Zsa2V2mrTOOoXmDOrY7yRNRnanyw8VbFYVVEy?=
 =?us-ascii?Q?FlylYQVq7WYrBGCHV2JTWKSv69x2q/Oq75N214fzpBONXoiN1i4Z3HxRGByn?=
 =?us-ascii?Q?0WwyB6ygUH0b+LYdvtvgLSvKd6F3CYCA3qJrF3VpnFUp3PPI9GqW8kXMjoj6?=
 =?us-ascii?Q?JA5AGdJg+227ILb4ki6pxf6qgMCY0s0pH/g4qMtf/iODo705V1prxH9n0MDL?=
 =?us-ascii?Q?E/5N8nhYsA7IRuERzJwv6IcCJZO/wZGv3WN9lPqBKOrBbqmpGhPfHEZJoeKW?=
 =?us-ascii?Q?BavSFydOUA4nEGH0Rsm2MIYnhxX5yyUlX6QAMuUOby4lB+Oc+wuUi92/2Grx?=
 =?us-ascii?Q?zeiXgzqXnBHL7wTr/67WFZvip7ro8FzQn1NjwJ8TQ38fZQ/TrHozJKFU8V5i?=
 =?us-ascii?Q?kIWCBgmvZ2LIfHwKfKGTe0li5rWb8Ch4T1UrEVm73iaSJcoQaPoh7sFIiZ7k?=
 =?us-ascii?Q?9P0z6Nu9O2jcY40j7S3NXzZCKt6/0vAfP0uu+N3QYGe4tFJzZgQQEmNAYhRm?=
 =?us-ascii?Q?fk7L79rPtaH01jtdpkSestcD+cy6Ozqt6Z6m2UoYy4ykJEA8/X1OBFtUCkU4?=
 =?us-ascii?Q?y1pBXsHlN1EAzqQHVRCsd2E+ICkZp3iN51R8klZPaZtu3x3aupyRUFbUYfyJ?=
 =?us-ascii?Q?qJAD5wjSTcDwlaajbhRoAjqNNl8RjTQW1SIli4pVr0dxEFSS3JzkyJiiFIJa?=
 =?us-ascii?Q?wXi81VzJ8qCPNJPAYq3gtqr3/St1L1piCNynZGE7PgRnNJAw0/MUHQNT1MLs?=
 =?us-ascii?Q?/ICx4taX2bWIFGH7elNqx3s1udirlfaV9Fvh1kamNMptVFT5YLOD6/yObwYs?=
 =?us-ascii?Q?UjY1rMgzCQiQH8SEbcIDuVsahYcKMCFrP0ckFR/Fjl9T4SUO+gp0QryXRvim?=
 =?us-ascii?Q?1zqfSBEe59q+D/UumpOH6gdYc6iMSUiql1FawtR3S45BPXzEVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(19092799006)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8HG9BYxeN6nkKXkycAdvPfyss1GJQ6KzCduVFzCMJRt2g3z+Tznw5h55VjQx?=
 =?us-ascii?Q?f7ztBVGhSvKwFNYkF6OAtlX3rik0oKui0lfA0TMyRdjK8OFuEW61eAaXQOrJ?=
 =?us-ascii?Q?6Vv7jz7JsH+Q4+6XYuqq5LJ5nEjijwPJEYY3Snd6PikON3bKGJ+Nr2lUnS19?=
 =?us-ascii?Q?M6/RFJBdr8CzRngUvNgyAWZ2h3HkEz2yJ/38ev54aUAzSURdfksxCFKqp6Qa?=
 =?us-ascii?Q?GEUbs5hhjMS2cXlFSlp0g16dUJl1HjF1HjLzrI+vWv555ajEVEc3GIIPto0K?=
 =?us-ascii?Q?y4xSYdeggD+F8nlxQa/bwvIALz7CnQhdL0e+MQbvOEsddzH7Zr7H57E1JiuH?=
 =?us-ascii?Q?CScbC+BMtCLaE1tFD9WlwLFzKIBm3AO2oX/5+IeT4VoBSOhOBfz/ySnbTaFk?=
 =?us-ascii?Q?jEeMELnoAjSQB9Bs7ITqntvNFbQkjEj9TCHvbmOqWJNhzirUimgRZaRhfy48?=
 =?us-ascii?Q?/q8IwOi/iAxka6JaxkWiMn3aj2fqenzObx62dJ0jHskUnlQBWBgVZZCjpIhV?=
 =?us-ascii?Q?00CxZVmSL0VvDw+O7znDtShspPJzIfeSDf6jCtPS17mnCiCtgoF8Ma2xYkta?=
 =?us-ascii?Q?4u6HJoMHjh4lp9Kk1Qf7jZAIfc7apvtHq8p9xqFTX/rO+0OzoWNyPsfr77zJ?=
 =?us-ascii?Q?7Jc0wqelgrfud8klt4hrWSelX5nKq9QKV2pwATQ6epLq4JWQHpoJaY3tX8tF?=
 =?us-ascii?Q?Si7OIyClnDjFe336XlHHh3wGH8XwiuBxBOPMyIOrhd0r/mi6SnMQvM9Hzr15?=
 =?us-ascii?Q?97SrcAj5E+NBBA9tDi1j5T8JYN3cfClrkCQZle9aOrUPTbNPuemNoyuAGvYd?=
 =?us-ascii?Q?84dm6hJVvHkCiDcDwgkMXHLk+EUI6Wz+6R9wDxy0DZVHu6CekYCR0LkolGZV?=
 =?us-ascii?Q?NgT4WXtpmbE8MsZ7DgH3YelM8OlkeSyP6XGcN82xJJf5FPHAIXkt8SAY0UKa?=
 =?us-ascii?Q?KG6MVoF8yEHmJHW9Zf7SKKuWTBvz5P5EX2L/1uxZ5Ils8EfWU0QY0bv5kR6K?=
 =?us-ascii?Q?Mq+xNQjdjK3XzPOSHPSqv4SvcPqTCroM9fJVrfLGju4KmlijxBUIFsNJE1AE?=
 =?us-ascii?Q?4Xh/G94J5hjjk9qwoC91+8MEH2rTKvG5Go+3ZAsJaKS8DR0gBUB3gGOK5pxL?=
 =?us-ascii?Q?E0dRGLFU2G3yhX+K8wBxai7OVBp9kIEH0+WhY0n0kU62tlJrNT3HjpJr/F7f?=
 =?us-ascii?Q?BiLwRd/nzmyFcJfBDuOK9hK3/bn1weAByFT4bpig8WBa/RDcpMXXjJQpu4/B?=
 =?us-ascii?Q?3Pml03Qh0yfrrIeG2Ec66qe3w321M1l+kLuqdVlvvD/lBdyz1yMy/zKJWm2T?=
 =?us-ascii?Q?H4FS1aERbsa7hq91exJpAL1Uj1g/04+mjR8PQeI5VSXbZhqGeaY5LGx8x1Tn?=
 =?us-ascii?Q?hfZOj2rNWMhmMRNse8rEkO0ZDACCpsYhTxdUx1+H4IeO/kuokOeMzRiJKbcn?=
 =?us-ascii?Q?l1k28OBohWlZuoKVjA9tHUTcAA/nw8MSyEjoIWj5uOpbOE0cbv0U5mavT3ox?=
 =?us-ascii?Q?D9KV/N8YfXa5AGIZDi70UwYwcwunX8e+wzO8+CpRFRizASb6QE6Hp0OkQGa7?=
 =?us-ascii?Q?z2K3qpe864yNHSW0OpR8s82Zjjp9NHA/W/MHPXV/d1wUMxpTe/e+b/gL9ZI0?=
 =?us-ascii?Q?5283PXlg0ZYZ0Id64BFs5pZfdE9DK+M0cO9bDr67xAesvfQMxTLxHtJh26uz?=
 =?us-ascii?Q?ez+cFA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68140b4-5415-4478-4021-08ddc5fe8141
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:25:03.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afSmkMHJ1EykUAkpZtxy5wCeFhhjHL5r8fc0VpQtAcOVT/m1lYpUO1lyl3EPYrVapwkqGdrhrKceMgWkRQBCtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8368

On Fri, Jul 18, 2025 at 08:49:58PM +0900, Jeongjun Park wrote:
> ABBA deadlock occurs in the following scenario:
> 
>        CPU0                           CPU1
>        ----                           ----
>   n_vclocks_store()
>     lock(&ptp->n_vclocks_mux) [1]
>                                      pc_clock_adjtime()
>                                        lock(&clk->rwsem) [2]
>                                        ...
>                                        ptp_clock_freerun()
>                                          ptp_vclock_in_use()
>                                            lock(&ptp->n_vclocks_mux) [3]
>     ptp_clock_unregister()
>       posix_clock_unregister()
>         lock(&clk->rwsem) [4]
> 
> To solve this with minimal patches, we should change ptp_clock_freerun()
> to briefly release the read lock before calling ptp_vclock_in_use() and
> then re-lock it when we're done.

The most important part of solving a problem is understanding the problem
that there is to solve. It appears that you've jumped over that step.

The n_vclocks sysfs is exposed for a physical clock, and acquires the
physical clock's n_vclocks_mux, as shown in your diagram at step [1].

Another process calls pc_clock_adjtime(), acquires &clk->rwsem at step [2],
and calls ptp_clock_adjtime(). This further tests ptp_clock_freerun() ->
ptp_vclock_in_use(), and the fact that ptp_vclock_in_use() gets to acquire
n_vclocks_mux at step [3] means, as per its implementation modified in
commit 5ab73b010cad ("ptp: fix breakage after ptp_vclock_in_use() rework"),
that the PTP clock modified by pc_clock_adjtime() could have only been a
physical clock (ptp->is_virtual_clock == false). This is because we do
not acquire n_vclocks_mux on virtual clocks.

Back to the CPU0 code path, where we iterate over the physical PTP
clock's virtual clocks, and call device_for_each_child_reverse(...,
unregister_vclock) -> ptp_vclock_unregister() -> ptp_clock_unregister() ->
posix_clock_unregister() on them. During the unregister procedure,
posix_clock_unregister() acquires the virtual clock's &clk->rwsem as
shown in your final step [4].

It is clear that the clock which CPU0 unregisters cannot be the same as
the clock which CPU1 adjusts, because the unregistering CPU0 clock is
virtual, and the adjusted CPU1 clock is physical.

The crucial bit of information from lockdep's message "WARNING: possible
circular locking dependency detected" is the word "possible".

See Documentation/locking/lockdep-design.rst section "Lock-class" to
understand that lockdep does not operate on individual locks, but
instead on "classes". Therefore, simply put, it does not see, in lack of
any extra annotations, that the &clk->rwsem of the physical clock is
different than the &clk->rwsem of a child virtual clock. They have the
same class.

Therefore, there is no AB/BA ordering between locks themselves, because
the first "A" is the &clk->rwsem of a physical clock, and the second "A"
is the &clk->rwsem of a virtual clock. The "B" lock may be the same: the
&ptp->n_vclocks_mux of the physical clock.

Of course, having lockdep be able to validate locking using its
class-based algorithm is still important, and a patch is still needed.
The solution here is at your choice, but the problem space that needs to
be explored in order to fulfill that is extremely different from the
patch that you've proposed, to the point that I don't even think I need
to mention that a patch that makes an unsafe funtional change (drops a
lock and reacquires it), when alternatives having to do with annotating
lock subclasses are available and sufficient, is going to get a well
justified NACK from maintainers.

