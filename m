Return-Path: <netdev+bounces-135234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA63B99D151
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B661C210F3
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F281ADFE8;
	Mon, 14 Oct 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="FqiTNbqK"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2E1AC427;
	Mon, 14 Oct 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918796; cv=fail; b=FNOdI2n8E0MCGw9pRuKp9o2a9s7MGCMzVUCznI6B9SukoOpwvRSLaGyQu66Gi6iJA2BYO9SZ5yVfftIyIQlobQYtJ69eVjbwJKz4EBhwKSNpJjJr+jIsJjegIVq4gE/ywBic17+RBNoB9BYZ/SbgxBv+cwt54/Q5YGQ8G/BDr9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918796; c=relaxed/simple;
	bh=ZRwSxzEq/JG7RG85egQwcj7nqtw521c8nHnSOEiUfFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sjhKR8kuxZTb1H6GmINjb94N8MpieQhKgVt0ITERf6gaen7pu6N5NfhGIW494uERaQwggl7oJCzEoKfZs1lYx4mbXKOGl5xuQf31OauGBvBIKV1QQaCRqbZ3AQkkkVfMKaYz1C1uOa0IxsL3I7y9hjs2nZdUUnrytR7NlyZFeJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=FqiTNbqK; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHMuCvbItqJeEKB74hWjaZAMIu1Wo/SYuRo9TaVfXZF555qXwTwUZ1/1Pk/dYJVThEDjGJxmyFqnKuR9KYf23NTYQKwChJHcgDgBZYEAkAYHOPiJ4yBmNbg7OSUrHnYSaYxbl1IFfFLrjqgeWP6AwpzG2sUasPyKgjiVNgdLCPmS4nMOAAdvit2iHVjvlKALfhztXFFDRLoTYKQPfbuEfz4mkIYcFyvXou7y+quAIlciD1CRuTEzVZ01/dGMtoAk2XbLTVX4mLMDKYdCvH2r6Ekcwgf97W0pcHV2vzUVjHjkZbD23aTtqS4USfgSd9AiJ0F0CJ9NF6C5l+sxt+vNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvDfLSpKbVmCwX1prww8uQeglFjudRba0RVIrk/XYZA=;
 b=TUlPvG22uCc4r+K7MH7JJ52ZHoR25TlsU0DZRbUWTUwvycbsjepubo/0hoXWyVp0zK3TFb2kL7YHqGVPuh0abXie9d0xg5RFJi6ChvzFWautQQ/M0MwEJ+ovGtFdkGlFs4bE+vYAhH3nmdkiKfXr40lq1mO4dV1drvSeDDi1sdAEOYaYrAZOACi80I+nmRrB/IHBklzo9XdGA0D+V9CZGvBBRrH3jVOC6Zf21kJMpZAC3J12FYTr3TlTkJ9mrYJEiuzUF7OGl5OQ4VVA80BeSnXUY2GlCT1vjOTEhqvD2YUQT3dlct/J3Jpmf7AgWyl3xyc729LH6LDjrEX6TUxqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvDfLSpKbVmCwX1prww8uQeglFjudRba0RVIrk/XYZA=;
 b=FqiTNbqKxfI72vT1E6XQ6vYCHEQFr3CnbB2u9b9IPFnt2GYPlvzURSfhjBz7MPGe8shf86Ektr20M+dF0Q8YJx9hB4NzeuLgBXkzetGnrPVmhCUNZGCBsUpBzPmufnNAU3tpS3uZd+Tk8cyNt4Cp4VJ2KbxqDH5uJh5X0hx3LMCUUXJDSJPSToD5GNLcB1vSeuwPkEEisGxgXIYIIV5lw+hu5ZivBeNXh9KD8trfij4Am748tBiZXloxECJudHSIWVIMlz43Wq/Fu9AXm1mdKVXaaOA8jMA4f6bwRuO+bk6A9i+aVoe5CQEVKx/fWmpildbJkKoZ/dsXS+g+IniZ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB8905.eurprd07.prod.outlook.com (2603:10a6:10:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:13:09 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:13:09 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v5 02/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_ioctl()
Date: Mon, 14 Oct 2024 17:05:48 +0200
Message-ID: <20241014151247.1902637-3-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
References: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: a4265647-a31e-4609-a85a-08dcec62b68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2IwcTYabDFPdGOefU7RIbqA8Ip2Dk8QGsnTuXZE2kZNMi9zuJgBrA1zm/jH8?=
 =?us-ascii?Q?8gYujU5HRSu3ZV+Y1ePqCMEJrYlpqtQhrYDtJIf8deyf0i/BX7MfIgg1xo3u?=
 =?us-ascii?Q?m4iuVpmbGgHLVW/uaMrzWIjZVNLaF7XWdDF70SjP1KItFxnnzGJaktHapEVI?=
 =?us-ascii?Q?H5fvN6yia3Uc+EeV9QqouDFhXdcJRoW5oyz32IE9hUAOjwZPvVQVjAmFVnoc?=
 =?us-ascii?Q?VIRi7kKia4xFBz4Q8Jti5D0XEv1xU3rQm9psxMFGdP2eoP8Tr0C5ukS199N9?=
 =?us-ascii?Q?3vxIiM7Zw16scNIHRa6j0to5XIfPNTKmBwIapTQRZX1eefeQgi99fnYe9rEJ?=
 =?us-ascii?Q?XCmYXLazAD+10t+REYRMxkDNxReiIMezXiAmnkHsAwPObx5TENd7CF1KTH2X?=
 =?us-ascii?Q?NzIk6eYSx/OKY4OgnXCB07Tht283JJnbWHaNZ7d1AXzt5DKirOAIwOk+knRV?=
 =?us-ascii?Q?71GNEkbukvfZQb76maiS8WiRWZ928uJbvNZg3EtS1Z1BHIdvbm8K3ep7Fawo?=
 =?us-ascii?Q?iH/DgQQFlgti4k8riZp3n7EVuySrwRjOlw8MjP5gaJAmd5bqYoLur1Hcarmt?=
 =?us-ascii?Q?gVuJEWpPafh+1WCu6UNXdShSV8wEYLImCnrsBpbBxiVWG/Qiy/YzZ0Weg9pE?=
 =?us-ascii?Q?1RgknRzOeeXupvk2nXZNR4/GwwDYsre6ReTxQZoNiXlbzM39kf7OEH+b1LsR?=
 =?us-ascii?Q?XJ7xMpdxGfzv5Zs4a5ll7XHi5aSVzwl8raJXf4cFufb2HQHIA3jAq8BmOd1l?=
 =?us-ascii?Q?FecW6KjBK+2P/G3MP9YMrGPxlBFTDlyiTmzDgWlD2VhbQ+j46l3tbfaKzSFX?=
 =?us-ascii?Q?WTgcd5Jbt7x1FCdgheqQyF7g2Cc0EXCQrYk4jWhuEO3+myRYdMU6CpJrCDQu?=
 =?us-ascii?Q?61ZVIX3CPFddYoELRsogjr6hLeYAZtwKMFf4YejkLcLVyJu19JfWPu9xQui9?=
 =?us-ascii?Q?JeAvNSuYlu5+ms89iwqOAXrlwO+iARs3GF/ee9lTSPfZKixTjJahdXlkyi3h?=
 =?us-ascii?Q?PQoLGwaqQzRo2nFmboSmUBoGNS4J4ayRdKOy5c5GS1WjgdJBt2wk4oX3KNmt?=
 =?us-ascii?Q?GVcvweaMEvNx8tmttBLNgy3kesBYOdNFt8vJ/O2ZPSptFi3EkGVQltWtvx5g?=
 =?us-ascii?Q?OsZpyJai/Md1xvMtymbmoTXJpBoHxYwiWj8ovbIxGqNyFQo0r0+UhpiIj9NQ?=
 =?us-ascii?Q?VhojkyHIMhmnHX+T4ZPQdfC3JCWp4GgzEC3FWMtDOsXWxDDRAM00uEQGbNsI?=
 =?us-ascii?Q?LKCZRBzjGURxCSydVC+WRYIfqYo1Ynz1OUjyoFN9zIvWWnpsUFbrvXiBbH5J?=
 =?us-ascii?Q?/E2kA3PA1KD2Oh76OJvG0Hsh5DjD577ebKExiW2G5QxoUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/iI5VU05aE4xUKTSI7hdVOZwPq/8caqBtl4x7mjCxc9uyjY94pkfCdigBCEt?=
 =?us-ascii?Q?6ursWS502zjuoQPL3jFbNokR3t6N3Lm+tRtU+Ro1QXBE5t5nzuroKGgvp9I5?=
 =?us-ascii?Q?ZVOQ5ze+WwtzQIM9Y88xsnxbVOpABNDJSzOW4G4yXrXMpibUWjrPL67Xy6HV?=
 =?us-ascii?Q?pTVZdfCUyN89bCfkXZg2v+TAWQhGqTxUEXS1S5BotRXjNG/+0ygC1zlRnxwB?=
 =?us-ascii?Q?CS7+DfPViTmYDhrRup9uGmortdyGzc/NybBmcdKyFTeNS4KmsQE63vYBSJ2r?=
 =?us-ascii?Q?whLfvi58dORFi/Teny+MinShz806P27wcY9CN2u+1mJgT1JaCMGSgFOJCx7x?=
 =?us-ascii?Q?8SH07kDGD6BUHoD9NY7sua0DJtcwNcoibtTJhhQr0/DnX7euHuc/oaNgq16b?=
 =?us-ascii?Q?BHtTLbOQ/er3WSBHdHPdu5Uv+L9jB5gUPqMZGsJTQ+Qz+gUwxO20L3JhJFEF?=
 =?us-ascii?Q?B0vyKmvW/ikcSgYvpso8iKpQiS00/HuTNmrZE6fPUSJnCKFNCVI58P542Txy?=
 =?us-ascii?Q?bgXo5uklSgT6iFSfLcihK7c9Hzg8pLk9jKqlipI7nqDEFMbh11eVhy5BewbM?=
 =?us-ascii?Q?MDjrVvkUg6iUSxOefUKD0P4eCah7CGro9tholiVLod993Uy+5k55fjv/861k?=
 =?us-ascii?Q?PQqh180BtJ5ZoGtfYdAMuSYaeiCzDPOHCy1EvTibx7LoSyx9/xnL14ZqCkFo?=
 =?us-ascii?Q?1lj67Do7t2ppF8eBeQhYJXUVahK7ZRUgoPGmDV3s3xERG0shyltZqhhtXBrz?=
 =?us-ascii?Q?wke4DMDc3OyekwzVF1oTSfdL70HYpIKYBqBfn0ohvdQ1F2UuH80lS6bT6pY8?=
 =?us-ascii?Q?uIraQqrJ6H4Ubx277IF2CN4Y2kI/utxpz0mx4N2OiHNeuat505syatZOrXNo?=
 =?us-ascii?Q?dGSvIFxKnTalbPxhGj2rG59HGMZtP9s/7FFsXr/Uor1Gb5RsQQG180ngW2BL?=
 =?us-ascii?Q?vii+hCc5I0HTWvj3gQOfMQTR5QIejni1oUa3C0OMxTZ/hcI0Xt/Bse6oQYUv?=
 =?us-ascii?Q?DaLNb64LDNBJPHWd1KdgvGyK+Ncm/7Iv4veu/ni5W2nCRGACzblpaTeOaYo4?=
 =?us-ascii?Q?te/l6iBaG+yKe3wU3ESRVFXGpCWqoYYh8nR2P8t1xyike+/vbPUgPhuFdB9Z?=
 =?us-ascii?Q?vi+fz4bUF89sI3Xd7OvcSn3EipPAP5jUg+IUp3MPgljjwsJrf5AtXBscRBlT?=
 =?us-ascii?Q?+WyD70jhripTUaYkM1dWbaXcqsoZeAtx6Bt54s4hdZrf3LGaEvODSXqUETjm?=
 =?us-ascii?Q?amCYveVmgJPRSJ27k/+iPnICKqjJ1929rN1nAhtxgQimKtPSHhWeoledV9EP?=
 =?us-ascii?Q?Pf67Ss7Gyl/iW0GTVTOzHM3K2f0VKOX8hMT3GznTT1wFEg5tlqTmMfmvwEpU?=
 =?us-ascii?Q?uRzTnuS5S3pzdi6CghpiC2587lzO+PBwMTJc1GKf4/7Uhb9Ov8pVRCL4CZRE?=
 =?us-ascii?Q?90Qik9+At6SeO2X+o2S4fe9MrVfWsewZE7OwhKjCWhhoeM6urmDZttE/c5kI?=
 =?us-ascii?Q?xls9/D/OlS30FbEuXcSOkIOUJfqvlO/CUsauWTSEUFMql60IPowoWtm1gxfT?=
 =?us-ascii?Q?QmkFgOdgtasF0kbX93tzyV5uOf7/Vei7OTKVNOqeoEIguqF3QtHQ/JaSjrOx?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4265647-a31e-4609-a85a-08dcec62b68d
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:13:09.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSPYXVaXASJmzX8cKnLzijq8E1FYc/SI5i3LBtzs6KQcZW5wyBhen2CPzH+TEn4wKenOlCqVmHiVTLvEqJZemNdI5XT1IyYSz06FNxWnUFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8905

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to
ip6mr_get_table() must be done under RCU or RTNL lock.

Detected by Lockdep-RCU:

  [   48.834645] WARNING: suspicious RCU usage
  [   48.834647] 6.1.103-584209f6d5-nokia_sm_x86 #1 Tainted: G S         O
  [   48.834649] -----------------------------
  [   48.834651] /net/ipv6/ip6mr.c:132 RCU-list traversed in non-reader section!!
  [   48.834654]
                 other info that might help us debug this:

  [   48.834656]
                 rcu_scheduler_active = 2, debug_locks = 1
  [   48.834658] no locks held by radvd/5777.
  [   48.834660]
                 stack backtrace:
  [   48.834663] CPU: 0 PID: 5777 Comm: radvd Tainted: G S         O       6.1.103-584209f6d5-nokia_sm_x86 #1
  [   48.834666] Hardware name: Nokia Asil/Default string, BIOS 0ACNA113 06/07/2024
  [   48.834673] Call Trace:
  [   48.834674]  <TASK>
  [   48.834677]  dump_stack_lvl+0xb7/0xe9
  [   48.834687]  lockdep_rcu_suspicious.cold+0x2d/0x64
  [   48.834697]  ip6mr_get_table+0x9f/0xb0
  [   48.834704]  ip6mr_ioctl+0x50/0x360
  [   48.834713]  ? sk_ioctl+0x5f/0x1c0
  [   48.834719]  sk_ioctl+0x5f/0x1c0
  [   48.834723]  ? find_held_lock+0x2b/0x80
  [   48.834731]  sock_do_ioctl+0x7b/0x140
  [   48.834737]  ? proc_nr_files+0x30/0x30
  [   48.834744]  sock_ioctl+0x1f5/0x360
  [   48.834754]  __x64_sys_ioctl+0x8d/0xd0
  [   48.834760]  do_syscall_64+0x3c/0x90
  [   48.834765]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  [   48.834769] RIP: 0033:0x7fda5f56e2ac                                                                   [   48.834773] Code: 1e fa 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 1 0 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <3d> 00 f0 ff ff 89 c2 77 0b 89 d0 c3 0f 1f 84
  00 00 00 00 00 48 8b
  [   48.834776] RSP: 002b:00007fff52d4bda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  [   48.834782] RAX: ffffffffffffffda RBX: 000000000171cd80 RCX: 00007fda5f56e2ac
  [   48.834784] RDX: 00007fff52d4bdb0 RSI: 0000000000008913 RDI: 0000000000000003
  [   48.834787] RBP: 000000000171cd30 R08: 0000000000000007 R09: 000000000000003c
  [   48.834789] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000003
  [   48.834791] R13: 0000000000000000 R14: 0000000000000004 R15: 000000000040d43c
  [   48.834802]  </TASK>

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
 net/ipv6/ip6mr.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 268e77196753..2085342c1fcd 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1884,47 +1884,56 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 	struct mfc6_cache *c;
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
+	int err;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
+	if (!mrt) {
+		err = -ENOENT;
+		goto out;
+	}
 
 	switch (cmd) {
 	case SIOCGETMIFCNT_IN6:
 		vr = (struct sioc_mif_req6 *)arg;
-		if (vr->mifi >= mrt->maxvif)
-			return -EINVAL;
+		if (vr->mifi >= mrt->maxvif) {
+			err = -EINVAL;
+			goto out;
+		}
 		vr->mifi = array_index_nospec(vr->mifi, mrt->maxvif);
-		rcu_read_lock();
 		vif = &mrt->vif_table[vr->mifi];
 		if (VIF_EXISTS(mrt, vr->mifi)) {
 			vr->icount = READ_ONCE(vif->pkt_in);
 			vr->ocount = READ_ONCE(vif->pkt_out);
 			vr->ibytes = READ_ONCE(vif->bytes_in);
 			vr->obytes = READ_ONCE(vif->bytes_out);
-			rcu_read_unlock();
-			return 0;
+			err = 0;
+			goto out;
 		}
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
+		err = -EADDRNOTAVAIL;
+		goto out;
 	case SIOCGETSGCNT_IN6:
 		sr = (struct sioc_sg_req6 *)arg;
 
-		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr->src.sin6_addr,
 				     &sr->grp.sin6_addr);
 		if (c) {
 			sr->pktcnt = c->_c.mfc_un.res.pkt;
 			sr->bytecnt = c->_c.mfc_un.res.bytes;
 			sr->wrong_if = c->_c.mfc_un.res.wrong_if;
-			rcu_read_unlock();
-			return 0;
+			err = 0;
+			goto out;
 		}
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
+		err = -EADDRNOTAVAIL;
+		goto out;
 	default:
-		return -ENOIOCTLCMD;
+		err = -ENOIOCTLCMD;
+		goto out;
 	}
+
+out:
+	rcu_read_unlock();
+	return err;
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.42.0


