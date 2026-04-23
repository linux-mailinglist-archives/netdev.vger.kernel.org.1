Return-Path: <netdev+bounces-280623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v6nwJSO+6WkXjQIAu9opvQ
	(envelope-from <netdev+bounces-280623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:37:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1C844DA53
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A8823018D51
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC3F38422E;
	Thu, 23 Apr 2026 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o4eodkz3"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DA5382F1C
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926240; cv=fail; b=huIq0m1r/Nmb89XGfuhC4ScBauExUA69R/qBNmUMGtO2FLWxw2Xsm64esTuTK/TTXQYmHxWzTk5fg6Lv/LA+uqpcg/PUe3x2Nbm0nrE2k3gXC8wwNIpyizYU6HvQ3D15fZ5EZX2+5e6QMqEIXX6SmS0ZxMGGNC8jGr8ch1VZTAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926240; c=relaxed/simple;
	bh=3Yn6br1tWadrYwS8XNMxCZIiXztRJSmM+CS2gPzoIdM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oSNzgSv4Mv2ZtAoRJCtLbqV0h1B8RsemQY37Fuguh/TNbjD6cr19V8YeDxroZLa2F0GK+Y6deMBu1hR4Pn6gY1UqXKDz2PfRjZWU+F/6EwIs8sd3n9h4JM6+91dHUDMkeKYGN4YAy/cxyctjOi7gUlN5rd87kSH2a4x/U7hBj54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o4eodkz3; arc=fail smtp.client-ip=52.101.85.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=looXLVAPu7hBQ/j5QxVS9CklCs1zPgUWVIuGv/vk+l60J/PQ4r6oLdUKAsniueGwgsFkNlreLPy5WvfiFYTHsSLHUrBwaXTPJzXve4SyAvuWMvhFZ5Qo+XSBnWOy7UyAeAyRYqEW0dk3/isp+uQpoapAIXjNXJm7YW73RPXXHhAYiDkKw2f/dMPjTHLHiH3cZMA2kFFnU9uF5uMfnmGX2ulTe4ol7sTKk6P3iuSEgyahkL326LdUQFyyKJz72mmaRzgWGj50k39aBE3I94f5kVpUHgHvy4WqVlLFDV7m9ZAdPvNIF3uXNV9g2oCU59Ctoj1mf3WBlUlKPndZDJt97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkiwqV+DA/cpGH7t6XHDsPe0jlDpyhtywkwlQDAQwrE=;
 b=LFy8AYAwzRNn2m4NO5X/ordk0w/GGUeb3mAnmSsNIsdIQP+cH9avvJnI4GoVqP062hPfpwGF+sIpK9e/N/EgHUErAvrQtrwdF3+xt8xgKxRYuN168XCiyQ9I7jMmVgV7E6tr/LlInUx26surfP6qNy9CbyGejzy4Fq4FFqFtZI6htXgCbXZGss7C6o/1UmmrFj1EpT60DOn8PrXKzoD7qtOgA2LNcJjDihLhbSMrJWV20MnHJvNAn7CsTRNLkcPJDHf8JK+HPj7nrFXFC17GeM/T+rDbmZpmMddJEJpO/eG8wOjXftx5iVQUbeFkkGS49S7t47Ej+gfSKpTwLFwfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkiwqV+DA/cpGH7t6XHDsPe0jlDpyhtywkwlQDAQwrE=;
 b=o4eodkz3jRt4UA6g/+aS417VxLAnXJTgh9VpqYcvQrV0cOfuS80+IhT3DiNMFMHzGYtJ0qTvkjj4NUSr/B0EuCgIvF1t3Uvq6Dq4yTEr7l9ln8E4H43ArJ8vJoArH1Ri3qhCxOGAO36hbNPMOt6U9OAA6yiwzmgJPOtUp1e9bgBE8dkzaq658gO3dxOIUwePiDfIs8j5YFQhHQTiBfFZzr7/2xagcaSoFrYmbC7yXM6N9i1ryxfVi6vUBjU5ii1oHQL0hGFno5L/YV8JNPhyyMpPTV9UU3UnBl14u9suJfUQ0qQQGAh2sCN56oSSiZXgUZTj1zjJQ0eGLHks7gF+dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 06:37:12 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 06:37:12 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	royenheart@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] vrf: Fix a potential NPD when removing a port from a VRF
Date: Thu, 23 Apr 2026 09:36:07 +0300
Message-ID: <20260423063607.1208202-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::16) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d6b26a-6b98-4fdf-1323-08dea102bfd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	K+iqyq/SXaHIdV1rjKYUcyNEN1eE1cXvf7eop+/bByGwb5yKXZ1ShMDKh5aDJyBenHgLn1lSvBBqD1wuNzGxokXWfXrgLu+SKhKZtZ6zxpI0Yc9EEZZ7dgQ8TuVXrbWMzUeTK/7xy/dBUdCzJIUENwMWpBvlrgEluqoZAwQ+2Cs+inMme9fEStkSlNXoJOQfuSrsH6xshTqypSV7cJL9yw1ed9PMlLgs3HU6TvMvhLetTtuhe2uzeCiuCQbW+OpNEFT78S6N6SEr1w4A0IDGi8L1qRoQh3xoQ2AJREHHVLSVRGSU+Urw99zrAXdxgZOCMx1FcwsbfNtPZhmVGw0IjL92s9P+ESze4PEiUHZDkIZrt5GLdCmy1D7wHpyQ5se1ozksZZHR7uCDnDwiNbPuavpOZVPghtrVnks8wY5D6vgG/iA52Yzip9Bu1IxLzfUkXsR0GRv0tZDREFV0ljlL8HGCclYD1zHk2KCR2ixjNPhg7E2ColfOXP9czHlkryWvcS3sItd/KySsRlmbJQLNfKieYHQK33wmZBtp1UObV17saOX1JS70htAfBJKJ9+Q6n0EEvp0R6vd9fpqKYCS+pnSl8GrLPDiHqBETKgjtIGCjD5IuDZIV1lHihjcnXvCFRyLEE/YR9molQUPDjzUx8DT7mjnyPaT5C2pAlwXf8W4VS9lNvKWA4Dyr78Vwm3cbAf52nvHh5E1LC7PvAv2dG84GdRTTKPxL4UzgsuDQCPc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sS8uc28ZAG4VzjWkfiMxmD7uEvYVyxpHNsIOjqVuqiA/xqqdELG4KRuS0qLD?=
 =?us-ascii?Q?KDyx3TXETaYOo5YtbURmwqQLiS49Pc92jXxl9gv8vy2p0n/DBy1df4ZzLUN7?=
 =?us-ascii?Q?Cv9f46VliNMf+ZYgIBqTl/ADvvUedZk8NBwb80VRt5vMOEaaC0E4JVnMU1Ro?=
 =?us-ascii?Q?Rx40nWG2kEg6ISk/xXP4x7Oydpipx0ngbChEBOdZj7ObXLPOzYrpIbmEkOBL?=
 =?us-ascii?Q?CGMhsIK+Yk3cpvdhhMUbsQIAn2fzs1F2Mj1I4HzKXeyRizA4Ckx+O4ujMeRU?=
 =?us-ascii?Q?dzkP71WdX8wPRUOQcki230bAlcSQIA/i2qzVYr3Iddo/XvojraALZnzmU3Qf?=
 =?us-ascii?Q?0VnpUmPN62i9uPZ6H3Awa1K0riMqDR9v8P7Foyb0hdDiJ99rCwsFs1CGO0DU?=
 =?us-ascii?Q?/uRWb6yir3pr2UVtdGU1rFlHWNEFYxBKLm+zQLr1XgPykojpk71Q4VgIYrDy?=
 =?us-ascii?Q?4O6pZbwAYw7LWVNwbTNAuTav06rkpc4g8aoRMr3m7IQVEgcqoZgLen9aluYt?=
 =?us-ascii?Q?XlmJP1Oq3e0RR5hHGw08PUXEJ1+gJTZnA4sVH2k+IJMyWGKRDIncWesh4TB9?=
 =?us-ascii?Q?jJ8uNh/b0M46GBZRtuTFu5b73npDf2rSRWH98x6RK9Uyj5I/SRZX/ayKxO5P?=
 =?us-ascii?Q?+T3jfIFYegnpS+uOBji8N64EPusrRmam04fCFRk3aoLc0NptJtNlNBrb8A3w?=
 =?us-ascii?Q?ccbPNEx91GpDasnt3KeiXv2uzM8t8vjDC6KhoMVR8H5HsD8ro6mG2Ij1aNEy?=
 =?us-ascii?Q?amG7ltYRwyhwxUlePp5uhyCR3dSCw5vkotWws9J2JeDZJ7PgbYqAwe0uKNbt?=
 =?us-ascii?Q?Ct31ml8HMYp/URjifZNnqvwLscx4r58ec5dR3lccjyL7KHijnSQR0ogHqoWq?=
 =?us-ascii?Q?y+nqlWGS1/Uwc4B+QxE1EGUIo0j65uskUKids7ejxKQT7LbTTtrHLm8seDAu?=
 =?us-ascii?Q?0ZHd2phgrMEqX2FkmvwAI2hR6u1lcp2auhKw368B1Dw7oNRgt7xGd9AH8AsW?=
 =?us-ascii?Q?iRO2zLYXaMITrkztOr8Iz0bP58NwyW2SoGnuRKgoC4FRFWuNvr9ussOgdDb7?=
 =?us-ascii?Q?6H/lFvq8JvjMx0JDwQdM+QktvB4DUfYLtwTOqG5kj8DdVGbPgvMvVtSyELgE?=
 =?us-ascii?Q?TKEqw1YeLeMoCmI1jNIHc7WFnBb4iA9r2aBME0UX58HZMh+WEy7wDvWgBPGR?=
 =?us-ascii?Q?JtfNMjq9aeQO6xoUIBA1pyfFjF8IAkOOau/K3Z4htLVx1wMhOZdDKQCU5CqF?=
 =?us-ascii?Q?wHMCF6wK76RSfmlw0qjuB8NLatGDZysqK5KAyVIPyPFPrrxjhCyjrS0HHKbT?=
 =?us-ascii?Q?emoHJFohG86AGHOArLUr/KbtM0xO1JRP4NwJh6426lLLXAr1iA+hsw6rHuBf?=
 =?us-ascii?Q?Z9WlGQyq9liugv0ePm6UpLQxstaRyxurKlFS7f4g83yYPnG3Hu+I9yl3HEbN?=
 =?us-ascii?Q?K3NA+ggLA11Va/7qptBCopxyMkhNh57lVUkpp3+WYmx5zCZWTg7S8rElTTjc?=
 =?us-ascii?Q?d1FrNdB6fRdwDqPfU5040t5VTlj+LYMs+OaamgMWlyvapK4RUrnMuw8WFH4F?=
 =?us-ascii?Q?IS4lEmF+WHj+W3Ougn/F/k8tbap8dFJV2BzBLbti9kJ7w7vt7+nkBAWnFPUB?=
 =?us-ascii?Q?syMWFcqAlWOmRcGl34NrxhGPeWjb+2yslGsUAYGEGpkzisZmwe/+TqvmwCmS?=
 =?us-ascii?Q?J6AT90qnighG0fKk/hOGnlvMCIqizEgtg7gmVDZu/2qRtU5D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d6b26a-6b98-4fdf-1323-08dea102bfd8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 06:37:11.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMxExMvMns3nbyo6p7SxeeXajo7c6pgF/2yWuW86P8r9UK/PdaIzhpUiU9nMw4FIqlFRGkMCFtC2JF3kLnCihQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,resnulli.us,lunn.ch,gmail.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280623-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: CF1C844DA53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RCU readers that identified a net device as a VRF port using
netif_is_l3_slave() assume that a subsequent call to
netdev_master_upper_dev_get_rcu() will return a VRF device. They then
continue to dereference its l3mdev operations.

This assumption is not always correct and can result in a NPD [1]. There
is no RCU synchronization when removing a port from a VRF, so it is
possible for an RCU reader to see a new master device (e.g., a bridge)
that does not have l3mdev operations.

Fix by adding RCU synchronization after clearing the IFF_L3MDEV_SLAVE
flag. Skip this synchronization when a net device is removed from a VRF
as part of its deletion and when the VRF device itself is deleted. In
the latter case an RCU grace period will pass by the time RTNL is
released.

[1]
BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
RIP: 0010:l3mdev_fib_table_rcu (net/l3mdev/l3mdev.c:181)
[...]
Call Trace:
<TASK>
l3mdev_fib_table_by_index (net/l3mdev/l3mdev.c:201 net/l3mdev/l3mdev.c:189)
__inet_bind (net/ipv4/af_inet.c:499 (discriminator 3))
inet_bind_sk (net/ipv4/af_inet.c:469)
__sys_bind (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) net/socket.c:1951 (discriminator 1))
__x64_sys_bind (net/socket.c:1969 (discriminator 1) net/socket.c:1967 (discriminator 1) net/socket.c:1967 (discriminator 1))
do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Fixes: fdeea7be88b1 ("net: vrf: Set slave's private flag before linking")
Reported-by: Haoze Xie <royenheart@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Closes: https://lore.kernel.org/netdev/20260419145332.3988923-1-n05ec@lzu.edu.cn/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vrf.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 2cf2dbd1c12f..46209917ae4d 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1034,6 +1034,7 @@ static int do_vrf_add_slave(struct net_device *dev, struct net_device *port_dev,
 
 err:
 	port_dev->priv_flags &= ~IFF_L3MDEV_SLAVE;
+	synchronize_net();
 	return ret;
 }
 
@@ -1053,10 +1054,16 @@ static int vrf_add_slave(struct net_device *dev, struct net_device *port_dev,
 }
 
 /* inverse of do_vrf_add_slave */
-static int do_vrf_del_slave(struct net_device *dev, struct net_device *port_dev)
+static int do_vrf_del_slave(struct net_device *dev, struct net_device *port_dev,
+			    bool needs_sync)
 {
 	netdev_upper_dev_unlink(port_dev, dev);
 	port_dev->priv_flags &= ~IFF_L3MDEV_SLAVE;
+	/* Make sure that concurrent RCU readers that identified the device
+	 * as a VRF port see a VRF master or no master at all.
+	 */
+	if (needs_sync)
+		synchronize_net();
 
 	cycle_netdev(port_dev, NULL);
 
@@ -1065,7 +1072,7 @@ static int do_vrf_del_slave(struct net_device *dev, struct net_device *port_dev)
 
 static int vrf_del_slave(struct net_device *dev, struct net_device *port_dev)
 {
-	return do_vrf_del_slave(dev, port_dev);
+	return do_vrf_del_slave(dev, port_dev, true);
 }
 
 static void vrf_dev_uninit(struct net_device *dev)
@@ -1619,7 +1626,7 @@ static void vrf_dellink(struct net_device *dev, struct list_head *head)
 	struct list_head *iter;
 
 	netdev_for_each_lower_dev(dev, port_dev, iter)
-		vrf_del_slave(dev, port_dev);
+		do_vrf_del_slave(dev, port_dev, false);
 
 	vrf_map_unregister_dev(dev);
 
@@ -1751,7 +1758,7 @@ static int vrf_device_event(struct notifier_block *unused,
 			goto out;
 
 		vrf_dev = netdev_master_upper_dev_get(dev);
-		vrf_del_slave(vrf_dev, dev);
+		do_vrf_del_slave(vrf_dev, dev, false);
 	}
 out:
 	return NOTIFY_DONE;
-- 
2.53.0


