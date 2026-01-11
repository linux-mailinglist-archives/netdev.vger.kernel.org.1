Return-Path: <netdev+bounces-248800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B13AED0ECFA
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEE8A30274FC
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 12:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B68F318BAB;
	Sun, 11 Jan 2026 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UmIQTE+2"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013039.outbound.protection.outlook.com [40.107.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63272AD20
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133338; cv=fail; b=SpPK4Iz+A//IgBRg2GeUAJHINUv/hv+ypHMvEafRYrDwLXT7r3IDuoTo4+ZFBj7KyFhzNSmeTFG2/eSP7KY9eugCvnYbp3Os42ppBBjxchjoYAtTm9bgJjB13qVuZxrHrOKs2rxxoxcg6awDvRQhXaF/Os2IgBEuhJKJ2e3fkw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133338; c=relaxed/simple;
	bh=36ClsgeQw6jcTOGj7/c0MiruXnpakmq+YImUgZVRSu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kVi2ik9AL9W+BVGeP3cBiVolKt3artwnj++JG6KG/PjbXMRYDolBGILSHtKpMHB7Rrf/ZcWu7agecFYo4r2u1Pu4RetlttpPO0YUZ0s9+S/7phEUg3cB9S1yFhEucCNg8JI14h+i2TWCvYyT/sBNds8S1ogk+M/CUe0UoQ9tQ9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UmIQTE+2; arc=fail smtp.client-ip=40.107.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNzznf2ST6vqPYlCf13vaD7qHgBeXSaBfyut1wLLqHOP3FiaKXTCtz9H/LDgMD576aJEEvAgL1IC1PXX8bUbvVjUhBFyZcZetIOHdOc4QFBgeeBq45i7+rWnqk2A9aLrdGFfRXpCYDpQNPsAfvfZs6TCAAVH7lzhlVZk7CHBrNUMTZq2t+DoDiW+/fKXYxvsl+5uX9y+6XL6iIvl3B0hMn2qIJRjW3cvXnhS8ivP4WF3ZFP7Plild3s/uK3jeu9uMY/YNq3l1PE8un2t920zLajSmEZGViCONjGtqeYJGsB4KfgdjNEdmHWHcE0PF+W6tk6LJGbmFPqkwoFUo71p/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pvrAvZNv8Sg3+P6qGj3Qk8phtUsRoD4x9hGlpTmr+8=;
 b=UcKH8w+ejgja8uxwYcyRBdYD8w8WLR6IxjHCAo1KZ4UceD3E4X0cpZUkJl0/zeIMCsIAyO2zLYz0mPhxDxNxZkbEZTU6n7Q6q4qg6EvNzUfOxPrBq6USGiM40osn1oYLX5LLmQpw3d/b4CIKVie2Y0UtEq43ej+7L2eHMnLwOSI5NsLhfR8lc45EzboYEz7DtOBulkJqT9zP+qQZ0ZWsJjW9oXae5eq+Q5o0h6aLak5mlc2rXTkA19j1s5u+KYYTiNL+q26fwtGA+U4spyNcRGiPibKcQ9NvzG40vRXzdidO7yL4o56sybx/GwtBnoEFft8hMOE8g1djX67B3XeQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pvrAvZNv8Sg3+P6qGj3Qk8phtUsRoD4x9hGlpTmr+8=;
 b=UmIQTE+2heF1VXzKzWANn3aLrcCSG9n2KCrVk5ctE0Fs8oy6bWiGFr3BNdPm4wE0Udq9a2HEJOtI23CD1nm+K1/hdot6ZDK/PyGTt63ZqfPLOvWK/o22kseoEWp80IHpgnt1Iai0KkbeVjgCZhFK5o5R9BlbKgnL827H/u+yRONe+i33/lFxMCE0+X4gb50xP0p+lSR6vZt5Vs6y6H1hHoGSIpOkFd+fUQ+H4KDLzr0WNEKliVEjrwY2XD6hauhoM3pi06to0DHIJTDl0AMzEd2VgD/dSJOAXOytZSKCjQU0oVMIa9bUodxh75Lv1eIJi6i5+L3QeyFk8tIJ1PODrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 12:08:54 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 12:08:54 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/5] selftests: fib-onlink: Remove "wrong nexthop device" IPv4 tests
Date: Sun, 11 Jan 2026 14:08:09 +0200
Message-ID: <20260111120813.159799-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260111120813.159799-1-idosch@nvidia.com>
References: <20260111120813.159799-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: eac0a830-cad5-4615-53ea-08de510a308e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zeni+oIJnxCwDZdjXhCgWfoazE66NqNTHutsp/OWLEkYVWygygYkjAHxMutI?=
 =?us-ascii?Q?xsXfdr30kc6P1Dx4mcV9yHd+GokEn7xLQxUHfo4NiIgjzKLNHxQ7q4OnmqOJ?=
 =?us-ascii?Q?W2TA0FF4Mw9xyMFT4C8Sk9TEz0F942OfmH3Ip9HZ4n4kUoVMP96txzoV3qjE?=
 =?us-ascii?Q?3VTdxG87sxGthQibwRTFOkYeOMqElFAcgNhGJCDfuRYFkCavCeissPZdkgC0?=
 =?us-ascii?Q?QHuKreiw1gFlB7zwa5Fzan5xopOkLQJYrFA9gZSyL+nUQ1QDkcIln2XertBl?=
 =?us-ascii?Q?+yByKgqLiqSvjVXBVO1g8rjjQav0DSt3VK+9Jz9IuZxeFi/xBzn2l4S1w2rc?=
 =?us-ascii?Q?pefM1PaHhfNT6yzQiVEP9nzfbrqMToreHhaYWBT8SH2Ps1+d2qpsACl3spT9?=
 =?us-ascii?Q?x7g5Snj1X9d8Z+gJLPRxsrkmM/V9qeua6ATXuqYIMb94ZSJpqpUzK2+PrH0O?=
 =?us-ascii?Q?mvEAW6B9f11H9uQcZttwUbfHmejdvsL+Y701FwospvRZlwwNwuTrsvhTF+yh?=
 =?us-ascii?Q?+NiNruvbyfuRVZ02OnPnwL9gyCMjkSdJJ/5VIdsd+96/R4fMz/K5uHhtjLsa?=
 =?us-ascii?Q?n0ZfA5gpFuNRE1vN8tVCMYmzqJVHTya08whQlqUeHycEAGoVLRIUZHIY+WZw?=
 =?us-ascii?Q?WP9TU9sB0na2aI5JSUDNpMupStexB6qbdeHaR7t1ZKU9GIaqHSsnJoYYLvhv?=
 =?us-ascii?Q?ftyCbCI2WSOG4R7d9ELJ7zB58GzYRKIw62gV3vrtoItncol+tJhvzL+xOFvz?=
 =?us-ascii?Q?mmBug59aoOeWsBmfwiFYxR3VkeV7mwDw2PWvjnFENg7k33GmGt5i+hE/KYzU?=
 =?us-ascii?Q?1XvgbJfUU5GXgXEqsE6MFryaMdVkyhe4rOxAcTS1IqyLH3PTjDV9Uihkclkn?=
 =?us-ascii?Q?TVhF/8LHUFc7aM8+npErwofkjc6va/qwuq1bZaSjwmFZfIRHQmGy58SLKGf3?=
 =?us-ascii?Q?GvCVVMgw9rIRmxa4D62lrIo7BL1k9oJPiBRFpA/Y27xhr64QzF+vkA+JpOfJ?=
 =?us-ascii?Q?iplxXnp2fWx2/a87jyrYxZTVuCLdE9XUtGdwft3S1PzW5cTrso1zI/0N3GN7?=
 =?us-ascii?Q?Coaw4GZXt7DLYvtHpYga0c7cud6a04FlFGqiTK5wWPR0oDCL/Y9bxGSNLMiU?=
 =?us-ascii?Q?R2m1i4chJQOuVvw5mk/Wai/UPG2u8ZpYDglV8xdTY9PQaJ/SIhPqRpRDLG6/?=
 =?us-ascii?Q?lDL0qytBofUU2Ny/ImJlgauyRm0l50RyVC68xcB053HUUsoZUsSWLAI4iATX?=
 =?us-ascii?Q?U0aRrEJ18R8VFV3SVjS4O14JRbYMrIxFBpZSdv2PkJvIDbQN0E9r2SQ2gVvS?=
 =?us-ascii?Q?a9IeVq6VGcRrkMGHEqpe8l/8ti0tpNry0eFRQntWiFvptxMaY92y0RExIPFK?=
 =?us-ascii?Q?BrBC9cOVZ7VfixYcxr+C2TXsoXJI5uXOiMqXyfpzkLCFuQ7B2k3HkfHwIzmp?=
 =?us-ascii?Q?9WLavGkG+8wtCJgi8O/UeYmMjOz25MTo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HmDxbQl6Ewj0Mkuf763R10ziRtXFcOB+qukGFOA0cNy+zzqJkageK9Gwg42x?=
 =?us-ascii?Q?qLm0ynYft0+9tBC3ZjKu4k0CNdjRrZWx72lnIFt26ePkudRQNb6QYHVNugmI?=
 =?us-ascii?Q?MG/AMfB5F2WpoK4kxgCOTX56FzAUMsT/iEfRriWgGOCpvo47i00z8ALVygym?=
 =?us-ascii?Q?p/DJbsgSxzqQn/w/QjF8jmseq1B1k48/hTIbAgDzAuxa+1JicvaCtkMsrvF+?=
 =?us-ascii?Q?81HHQ+MZBOpftgC6wqHVrDKSG434qEDJK/7angwbVnV1fzqV2slUl0aR5C//?=
 =?us-ascii?Q?84eWZzMFzE3yzi4SJ0wrxfXQJPXYFO84iFIuirl34kcQ7dZDqQwPsu5g6eJZ?=
 =?us-ascii?Q?1P9F24JljfanEuiDGYOTvY+rfNDbAru04oHy+zR2rdY0Ixqbfg7HtzQFfXVJ?=
 =?us-ascii?Q?CRZtHx2lbGRoDnQHcF2n0Kid8BTpwZgo5Ame6LdNnzOFRMWekjshzeAd131i?=
 =?us-ascii?Q?I+TPVRhFDk3gsnE9iBZEKsFXX17avIm/Hdlc+trqMkm7HtMcYAuI1r23I3OP?=
 =?us-ascii?Q?bNquu3HuJlz6AWis0rMl/ZYxlbRgo4qWK+mUhnayvPeZiHjriq0lUWEr1zkH?=
 =?us-ascii?Q?bkw4Arx3QvFw4U55lvXLudfiMxATWO1GLsV8zyP1dYO3DnITrrE3Zll4sUVW?=
 =?us-ascii?Q?IvbGcrHZ2A6/J+CGxsTvIRHtgaaxL/p21bOnFS89OQXMhKjPM9cCo0j9MjuK?=
 =?us-ascii?Q?gsDH9bCJKUjGBodZbiwSoeYfs9KYsSwbIE4LY+FSAcVsCfLqUX9W/VojSsOD?=
 =?us-ascii?Q?+SCfqWMR2zFamZY7QixMJdgdykj4f1HTp4pL8qWx3djlvADV5oz6OZY5m3S9?=
 =?us-ascii?Q?mvCZ4QWBpHJdUVYklpq3REFvHG72eNloTkhkYEnXOhzwgRsUZEhUMUQB+7Bi?=
 =?us-ascii?Q?nhK0BRuXiAS6goaDoFreIEi1Z1sL93JJBLYNdCznQooEpJepnj8sl8RY90nb?=
 =?us-ascii?Q?3Dh+metCixPcB6rzEcro+7e5QMTMVYmvWg+LvzPQL+XpawRm5COu+YdV2D/N?=
 =?us-ascii?Q?0rMl6VsQ32wP1d9R18mV/JK0l9KgCHkEtmRXMzFQtdtyYPaZYCG4C9zYS1VU?=
 =?us-ascii?Q?PpgvJADAb5xN2ek224sXdXMRFc7PIlMDiQ3OJqYDW4zsDeOXpTtjo0dD7qpC?=
 =?us-ascii?Q?vFRbaLlCznzViWPLw8dbBFdZG8NcxkwtPWVnkUc+oxjFOguuKQPMgYZ/bQhZ?=
 =?us-ascii?Q?dKZUaEsdj6uC34F3FwWleb9YapxS43rZy6dXuRt2UWjvHI0DqnlEX56gCcdH?=
 =?us-ascii?Q?OGcv7RcvL67N4Uf4zQKNTkH6n89AIjzk3CKDCjnV9ABb9xlBsGlYu06IlhND?=
 =?us-ascii?Q?LJXfU5rQug/oUl5uPKGScqbqpJM2d/uMjOhkuoDiametRW2vMQ6j5GOgWR/+?=
 =?us-ascii?Q?ZGJyVXL3vZrJK8E3f4WcyQEbeSNHVkTaEYhK0Z+tfWl1xR5u1FL/V3+PcAQs?=
 =?us-ascii?Q?g5ARD5HryIXujjNc1kKpZfKKMO2gnVHiMiGWYQOWqfp3foT0mU637DifgG+J?=
 =?us-ascii?Q?RHk79OLRoZrCP9Teg6zQhvGYCJRCoQXsv80XwQ3Z73nJm6MTMAffZFaG3Wb8?=
 =?us-ascii?Q?y8ZCZyf2Ct9siIzrB1VlVicyVQwn6gDilSE/r/ybBGTquk5ACFc2uf+m3DuL?=
 =?us-ascii?Q?9gOcQPiCgIbWSimRDR/6zdiCUyG2thgdAixi7yWiykGOEK3h5IfB0GnPXQYt?=
 =?us-ascii?Q?R4LdwMUGo5rXysuyXVq0HLcOSUz1SVEgX/JTPFpD0229MsX/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac0a830-cad5-4615-53ea-08de510a308e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 12:08:54.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiQRWouayERxlVRs15YruVMYHPErPc7oG6KC53g88FsMbBO+x/++z7n9ZEBmbOrxRAUEK4X8P/Jp2I5BjzDxcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B

According to the test description, these tests fail because of a wrong
nexthop device:

 # ./fib-onlink-tests.sh -v
 [...]
 COMMAND: ip ro add table 254 169.254.101.102/32 via 169.254.3.1 dev veth1 onlink
 Error: Nexthop has invalid gateway.

 TEST: Gateway resolves to wrong nexthop device            [ OK ]
 COMMAND: ip ro add table 1101 169.254.102.103/32 via 169.254.7.1 dev veth5 onlink
 Error: Nexthop has invalid gateway.

 TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
 [...]

But this is incorrect. They fail because the gateway addresses are local
addresses:

 # ip -4 address show
 [...]
 28: veth3@if27: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000 link-netns peer_ns-Urqh3o
     inet 169.254.3.1/24 scope global veth3
 [...]
 32: veth7@if31: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master lisa state UP group default qlen 1000 link-netns peer_ns-Urqh3o
     inet 169.254.7.1/24 scope global veth7

Therefore, using a local address that matches the nexthop device fails
as well:

 # ip ro add table 254 169.254.101.102/32 via 169.254.3.1 dev veth3 onlink
 Error: Nexthop has invalid gateway.

Using a gateway address with a "wrong" nexthop device is actually valid
and allowed:

 # ip route get 169.254.1.2
 169.254.1.2 dev veth1 src 169.254.1.1 uid 0
 # ip ro add table 254 169.254.101.102/32 via 169.254.1.2 dev veth3 onlink
 # echo $?
 0

Remove these tests given that their output is confusing and that the
scenario that they are testing is already covered by other tests.

A subsequent patch will add tests for the nexthop device mismatch
scenario.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib-onlink-tests.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
index ec2d6ceb1f08..1bb1c2289650 100755
--- a/tools/testing/selftests/net/fib-onlink-tests.sh
+++ b/tools/testing/selftests/net/fib-onlink-tests.sh
@@ -315,12 +315,6 @@ invalid_onlink_ipv4()
 		"Invalid gw - local unicast address, VRF"
 
 	run_ip 254 ${TEST_NET4[1]}.101 ${V4ADDRS[p1]} "" 2 "No nexthop device given"
-
-	run_ip 254 ${TEST_NET4[1]}.102 ${V4ADDRS[p3]} ${NETIFS[p1]} 2 \
-		"Gateway resolves to wrong nexthop device"
-
-	run_ip ${VRF_TABLE} ${TEST_NET4[2]}.103 ${V4ADDRS[p7]} ${NETIFS[p5]} 2 \
-		"Gateway resolves to wrong nexthop device - VRF"
 }
 
 ################################################################################
-- 
2.52.0


