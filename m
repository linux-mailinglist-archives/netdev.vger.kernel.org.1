Return-Path: <netdev+bounces-135232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D90299D14C
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA33B24A63
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D326A1AAE1D;
	Mon, 14 Oct 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="gRPNiqek"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1043AA9;
	Mon, 14 Oct 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918791; cv=fail; b=mbDexef8jmD58lq+HcckYG7abD3Y/ELbDJgQlPVSFVRf+QlIj0/KRPltr1WcSIUsw4lg8aI8zXlTD8gzO7S4n6KmxXcWyd9gQ2BdzppLy84NEFWdKkFJGCUsQteMR9ZDj5RkxJIOZ0wq3lb8oU3ZpTKVrCdNt5vdVALMDEPmsUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918791; c=relaxed/simple;
	bh=937/9VXkamDxdrn6Q7QT8mnKkprVJx22667MTFrwDKc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XM00827ZavnO7BbZOA0RtvnefKJbhAiO3PG5FwOItZN/wNdY+YHypUn+FxrHjQYwlwRzc2foe3oBBwnWHU7YPh+k3ir2oIcGQItXW2qfd6iV8v7QXqP9QdixF/01DYKKhya5r31fFpU9vUw5QPYHdj9H1jHrXcErk3Ha4G1pKPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=gRPNiqek; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQ831OXK2d1S7tCcOd4XgYP2mjoFmbklaY+7M9NIszfRX4T1xWe2tuJn0WPjonMoVznfgL8zwOunYu9v+KKMKLeFqgUcKBFAvwrORaw/NMTjAFITrlzO5c88d32R62Volr/f4Pe5mtY+NjM2224cdK/wmMwFkpJ+yd2HMWvcdv8Rw2sn0LB0GVI8/YltG10NDaKxp/J5XGLDqE8x5G06fqU/SgNOdSqYyvqsTI2vc7RTcslAAlJVtRMHzcHA3lXBndQ4dcSpl9kgHWUzJXLRE++gSotN3wNoPo0xL3+0VtdYbTpWVG18la/RT6oN4AHs0X1SkpNL7z/ho39NBgc7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOhK/xX8CP0AAV3m5L2192zI9ET4zmRmszAdmFpJljs=;
 b=LTiD9GZX8PRHPyOUzgV5q7fmD5KNsn6Hp16Vlw+XQznwb60Nvk33MOFMpccdD9AYWwX7DKEGAb+9VvPpc3zs9DJSalqCYIK7s1Q2bcHD050cmERsx4kG/CfN4bmXm84hJmP7dDynpOFcGMR8atkmvuXoBwc0x7S9nhm9MCFRhrKqDAna2I/Jo1DBLO91uge4Bc+Fpz9oHdGLpY3kByD7PfyfNbHATMbtZYa85V0KWjrXC7FrbH2oLmhH9R1yXc9fR1U1xZwWj0iqwMASTkX+yh8R0LdQmFvQXSI2HVvt5CeUVgcl0ZuI82hHu0XyLkNQ3J9lEmikDzdsTxaaKFT0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOhK/xX8CP0AAV3m5L2192zI9ET4zmRmszAdmFpJljs=;
 b=gRPNiqekdVQuXJQml+h3wDvB9S2lsEH1VSW1AagTdd3BXmJcQIz2sbf3fnWJJPpKMpbLQbROhq/o0W5lRMlI4VZjSqGUTD5gEMjbXZtALRulYhykBTNMS00SNABzqmPdH1TJfuAlpb8ghv3YirVLyPIMXdBXer58zRd+y8oFJtPsjHVmAbAOmr+ozFhsBYqlSHPmJOcXs5PQJreHJhMfzpiGSfwtVfioF4og7JqM9jNH+QSdwq55rKMXZRIBCxjj2Aq/ojQX/mBKt44r8jL0wBxrolQF8wxJBkzTXGINDkG+GVm6MZ48SS1l8S7+wMNcwtTBTuqulbyFouQPPybegw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB8905.eurprd07.prod.outlook.com (2603:10a6:10:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:13:06 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:13:06 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v5 00/10] Lock RCU before calling ip6mr_get_table()
Date: Mon, 14 Oct 2024 17:05:46 +0200
Message-ID: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DU0PR07MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 03612bd7-c728-48ec-d6c7-08dcec62b4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zu2+D/jDlgTZCJJn8W/YTdkX5ogSXz8mBZwuld/yZf0YsOVuATZg3PTwlTQc?=
 =?us-ascii?Q?/MVhO6cKNOLLsERW5Tg13bsp6e3ek9uLCG92QQZ2JIcL9HcJBtAy8gKz49eC?=
 =?us-ascii?Q?KIV3CyuCQb0ju2iaTMyHV6tdlI5XzrIs/UYW2X9sCpyAZkIkz5FYLUX/hmm9?=
 =?us-ascii?Q?kIKYVFlxgpw8IMR3SEwIGFswUMF4yI3TDSyI2Jkrm/Szav9JimJ3M1fvyy1W?=
 =?us-ascii?Q?6uyFedoQ0wDUEREnn57444sXaguTVw0QTZpM7WvXlWUCq9dd6ErJXX+cb6x8?=
 =?us-ascii?Q?SNySlcmQBuK1Mq1SeIM5MtSHA+JusuL7jZdmyub0M1Qb/ccexJvlQhkVT1Xs?=
 =?us-ascii?Q?ObzclENuPdjw/w6VImIhsyhaQXAGvmys+VlyLptK+UvT/m3dN1TgBX0UnzKU?=
 =?us-ascii?Q?3iomvFB3sltLkzuR1RFGCW+PKaA+SUlV3FBBCLA5OY8W7LndHXOQUpTQdh3u?=
 =?us-ascii?Q?AuzTeLrJRVWjv7+AAuADERunu1d1aPxsicobScVIMpTh6tRk79E08uqbogLe?=
 =?us-ascii?Q?m9uaFvocVfz0Cv28gQi8d+VDUuzuQr+EE2ROwy7Xg1W0DOponIegrSh93mYg?=
 =?us-ascii?Q?OCvnNn6qczebFhr+BiPl7BWrQycolKey43Ez4ivmidI4Z59YQ2wBWq4xyIWd?=
 =?us-ascii?Q?PPRnLPqSvsUCQcev5V+SG48UinkkUxx+ScmQGKJ1yldMLZDvegw0ROqP3X5h?=
 =?us-ascii?Q?fb0jxloV8dazBI9MarsIjb2g+wInZU+1wnV63DMmPBbFSv8FyNGqe4FdYhSE?=
 =?us-ascii?Q?eoPj6hB7B7WNA0oAVBQrtiUn4bU974NPAnvOxMGVhcXnyR5n6jd0CS/MG6Wr?=
 =?us-ascii?Q?dmVgxUf8ypXfGiDoxXleA35LNlEA10QOv9Nd15/6I7+yU5kuXrOlHuerjEQ1?=
 =?us-ascii?Q?vzg/XNvPGohFrE0Nvl/7ZffZNSWUApDYYBycU2iv5ajBigQ5qt9+cqxVkidB?=
 =?us-ascii?Q?utGXxyvgkMKGZVTHQ75SsWNSuKg2crfvH9yxzqHrYEPTzd7hWIGeiPIr4XgZ?=
 =?us-ascii?Q?e8ISKNBB5o2zMoBVhCUVR1oPtj5DHvpVGfGcFJmye8NykoybKMNX6gkwpXyg?=
 =?us-ascii?Q?uG/KACcjKha/S1FnTFZSqhE8YuLzLN0o8fZHzpVyQvyo+LLN43AGt2i7tgv8?=
 =?us-ascii?Q?8C6au09zZe5Bogf2CYn9egmqtEqUv2wwtotGEZi6fiMmxsmtQEN11FK3mlP1?=
 =?us-ascii?Q?ml/B/90VL9esZ06mRmco+xViySVHFEdR9rPAVivT0KXazPa6/yi4JyX6+xQv?=
 =?us-ascii?Q?wwndW1zsJ83ZEQqPAP2rKO2lLPT1EriRegOa6LjNrhqagrppVhVmfTaXObTZ?=
 =?us-ascii?Q?6zXqy8QvzfmTCSkdeohy4dbvk1iFhE2b1PO3YMjb0OP7zQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kARhdV5OzPjHjbpE9gXiT2AqDP372TV0CvBaFSbZYdfOdG6nhpvVMVqlSnCt?=
 =?us-ascii?Q?GdNrk1KEfMBgFp8xA2R/6I0QVsR+QfsI6fUiZxyoGzpKzK9SQVBtqfFeQOUN?=
 =?us-ascii?Q?lEQchzLhRGNraT7gxU5irDRs9vnYyKcZJloRQO0ceQrDe3h6zQ6setLXGLi1?=
 =?us-ascii?Q?efDHkYUM4NhK8mPin51y73ch9xYtoYH9QodFW6nLhYwB2PcSQpBzKl+3egBw?=
 =?us-ascii?Q?rCJJ+QBgzx6jHrls0NkIX0JAuLmFLq40+ySr5hi+VvmMuzpFh5JqtMtO6QOv?=
 =?us-ascii?Q?romwVR8362mb5R5K/iDSg1R/TnUwQMym7sYsBoes9YXdltBht/LfDCHPp1wE?=
 =?us-ascii?Q?hyLV+r1+JZ5ECoIg/Pw8j43NxziRVl10XwlNkpu0gpvnq2x5hENeuiJLTvqu?=
 =?us-ascii?Q?LEQDgNd09oSwmto1tv4tgd54Mw0jIYhNgN3YqM80z+ZReTIDVjAHzD+FdT9p?=
 =?us-ascii?Q?t63A9K14ULmrf/ghBUI1FFsxEyYzJo3Rp0YMMwEtKIKo4VulNNRCJfamqmwx?=
 =?us-ascii?Q?y07Jeav+BQFgVzjoFpzPfK0DX63ZD4ZMRZ5hZMNeeZv6m2vttD45ihOtR3Zy?=
 =?us-ascii?Q?XeGqiYiHvg14QnZSj8KUgGrNzOd95Bu5wcDJ3bZ8yt1CvUlBRGeu4fuvkfaG?=
 =?us-ascii?Q?EHGasJEB7PM+QKrc3qLx4kOdWp+0byVsW/UWNLoUdRqdU0cU9KXegy2tYfSJ?=
 =?us-ascii?Q?h1Idu8rJvS25jAacATMqMYVAFNYVFJjN1KnwEvKVhWL0OayQdkJcJ/oPV61S?=
 =?us-ascii?Q?XSLxxe3+RA3Pvchv9hHkq7h3aB2K/Bn5u56AlxPwuhHDIrFBjo2eNNoB75TC?=
 =?us-ascii?Q?6AP6+F0DakGrA/gxZ94gBhhsPouNF2+GrGVLd7hZ4BinpUjWZRFpdcEFTNcH?=
 =?us-ascii?Q?MRAJ2Qkg6Ui58JHadvtoM0bJRccHCRZYQojCh1S+QCD5yF+IFxv4vOlwq6F3?=
 =?us-ascii?Q?VZJlAs3xqNheBIyVDJnZHpWEbgPOzrMNCMC1jYn24ENtBQAkajv2J2vhukNx?=
 =?us-ascii?Q?cuV3Bd8BJyl/oOkVx9hIMKpAU4Dynhnz96BqwIT6sZgNPvOY8mny3Y5O3uQl?=
 =?us-ascii?Q?CGMzLbKetIgvAkRUQf835MiiT4jnYBsXpFhfAANhrj4nk9LjGh+Un60+cCGh?=
 =?us-ascii?Q?Xs5r1D6nFBjGG/95HhtvbYZRJLst2PgtirvJmfavQCvqObSaWCQG1YT14z/D?=
 =?us-ascii?Q?hr4+8Uc784wHrNZsYSOpWNytpxca4AggwPrgtK6LiSHS6F5BAekp7/yp0RIr?=
 =?us-ascii?Q?qomN7v7l/TfT3E61K2V+5TieinDZyKOHztskxNkJbITbixYUU7kNUKapzAUC?=
 =?us-ascii?Q?LEG94Rg30AFDSAkrnVO+4lgSpLytr+Oxv/17MTkNs98Gsxq7xWQTNd//JVfA?=
 =?us-ascii?Q?+GFJKtmkBfPc7XS61X4eiIlN0QrhFzgahH0SzXQb6WBI+7jhIesG3vuOrJNy?=
 =?us-ascii?Q?mLS1eGaO/Yte37JZDmdJjbZlg28m4SSBt3ofPHtmW7Fg7qqh6s+8TVWn/4OJ?=
 =?us-ascii?Q?iWQMYNywqoVJxfrJ78YAyDn+fy4cx+GJwWXaXFxl7qnaVYWEjBh7Ad5p0ApU?=
 =?us-ascii?Q?/321fcwuhc42a73fmRxs1iviiAwZogBVYjEAGkrt+BMOy6j9u2VslBm5RJFp?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03612bd7-c728-48ec-d6c7-08dcec62b4e2
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:13:06.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytGFTjQFYWsh6PiKJhUN2pOe1f/4gTTnowIbodqJgLBRjvq8rLPtIeI2HN3j618yx9jJnjgExXudB6pj+kxmNZ+g2kgxbXyvmZ7C7mJpaz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8905

Lock RCU before calling ip6mr_get_table() in several ip6mr functions.

v5:
  - add missing RCU locks in ip6mr_new_table(), ip6mr_mfc_seq_start(),
    ip6_mroute_setsockopt(), ip6_mroute_getsockopt() and
    ip6mr_rtm_getroute()
  - fix double RCU unlock in ip6mr_compat_ioctl()
  - always jump to out label in ip6mr_ioctl()
v4: https://patchwork.kernel.org/project/netdevbpf/cover/20241011074811.2308043-3-stefan.wiehler@nokia.com/
  - mention in commit message that ip6mr_vif_seq_stop() would be called
    in case ip6mr_vif_seq_start() returns an error
  - fix unitialised use of mrt variable
  - revert commit b6dd5acde3f1 ("ipv6: Fix suspicious RCU usage warning
    in ip6mr")
v3: https://patchwork.kernel.org/project/netdevbpf/patch/20241010090741.1980100-2-stefan.wiehler@nokia.com/
  - split into separate patches
v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241001100119.230711-2-stefan.wiehler@nokia.com/
  - rebase on top of net tree
  - add Fixes tag
  - refactor out paths
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240605195355.363936-1-oss@malat.biz/

Stefan Wiehler (10):
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_vif_seq_start()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_ioctl()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_compat_ioctl()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_get_route()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_new_table()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_mfc_seq_start()
  ip6mr: Lock RCU before ip6mr_get_table() call in
    ip6_mroute_setsockopt()
  ip6mr: Lock RCU before ip6mr_get_table() call in
    ip6_mroute_getsockopt()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_rtm_getroute()
  Revert "ipv6: Fix suspicious RCU usage warning in ip6mr"

 net/ipv6/ip6mr.c | 125 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 45 deletions(-)

-- 
2.42.0


