Return-Path: <netdev+bounces-64266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87B3831F85
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4411F2897C
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A14B2E3FB;
	Thu, 18 Jan 2024 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gdc4hF/0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB462E3E8
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605522; cv=fail; b=FP6SlmmzaUozR39pEs7y42vbw8bR2SZ3WEWEIzuXKWM2ZjGRRmagtHhq6gnbQxCqmdD6dKHcJ4LowLPR+qxLJbw1Je2XCNxz6jxJmUFXdQ+gLGY56t/e50RHVgk+0aBZro9sucB9ZpNO2O0u2UwYMsSerhk/hsEbBCEZ5w3BaoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605522; c=relaxed/simple;
	bh=zeVgtvPLzXNUtMtJK+4JQzzvJbc+tNMeJ7y9nT9I2LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H9n6bjQf/f2I4x+ZzH0oR+Vb7qdkf9rt7zjKxjEIvx6/Ujj5l+RJZrxEhJYotZAYW62FOShm9RsPe4VaHaG27rBhstyunL3nY8pL7CkuHLYuCFsjgDxTAKQHgY/Khw5PUi3LaaIp3phzvD3l+wxyrsGYbuOXQGM+XF89T6YpFb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gdc4hF/0; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7HvFXvTtl9KvSYXMr3GYWbBjGjQgDL6t8qR68sjrDOjAbfhrFEmyrfXDTR1Y8Aabkp9rNz55GSL6nrMN/bmxpLHNKQHOkrwPAPoTiKZh668iqBBXXxmMTT57eQ3VAdxpnYuSGxqI7I6i6o89OHww97eumgpTji6qv4rQ6IH/7Hjl879E48CC2usjYlJ5IWLOXJud9TuTz4XTNYaEjasxs8IgqWjeoe4mXh1GeiIp3kLLTMUFLw1Zw3a3+uh6LcVJN/QZLj8m2ijkhGphAXdqQL4MMZ9+Q8FJb9qgXjZGsfaBlWNYYdkI0iJKdCevB8U55vXap+Z+kzgTFIMRJvlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWaLB18e0ztZKXTVBTwkWQfJHQnJQYxwx/68czOiy0M=;
 b=kTE9Q5MK5B6hXBwSsVuQsI6zT9mEhg2N0PbgkXMnE7QqlEngpQUxOBBLDvzjeG9/9/SxLLFcf43oTMhNIjzMIr25WjD3qqi8aPx7gRapsbon14eZ80Vy00QiZOzWoCapowgCaLRLl0KZUBwdSOs/EmaQRQpRLxtEJ0y1cMxzdnMKEhIde/rKCdpl/AO8tZIIMo3brMojyhd2s05vAd4ieiJylVvQyWmSe66g41IsxpaEKp/W1Xa0OH8JJ9ROyVltuk1yz0DY4ZG9/c3mUW3ldpk5tCwSMV1efGC9bQ8pHK73n5YgdME5WON+zxxPeUwzRwzNcJLte9Jn15dEMJ2/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWaLB18e0ztZKXTVBTwkWQfJHQnJQYxwx/68czOiy0M=;
 b=Gdc4hF/0UpzFuAA239tADc1IurnXHZuHt+/zEAqObjnQNrQ7ZNrxRsoImKfLFQvbprXuYuk73XT6yZrsh3eiwFKHfER/tuCzBa9aLkdW3jP4xwcVtMDYNpJjqz4Jpz/WYMYnuOczQ3OyO5CO23SqHVBQH2kGg6wnKWo5GJ4rD7xVLkDpRguu4nX4fuU+RVaYRlpv1bIL/WfTKWJgpKpFP1ZJii0OhnvffrEHM4KWYJcefonalhB9Fabf6Mz1w18x2NRaWqa9HI7VkZ0NhpTf+IlYqBfPRJCPsoFt2kMGz6Hj0T2QQWH93LCUvisBp4zJVGE4FA7Ue9IZlMKPIeplsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.24; Thu, 18 Jan
 2024 19:18:33 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 19:18:33 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net v2 1/2] Revert "net: macsec: use skb_ensure_writable_head_tail to expand the skb"
Date: Thu, 18 Jan 2024 11:18:06 -0800
Message-ID: <20240118191811.50271-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::16) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8d227c-bdb7-4e54-2894-08dc185a42e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	azE6d985eVbv3NpwrMBqHjCk0bi1sw6kcSkP2OtqzFgnwZ9+n3H5AJlDcfUN+3oHg54LvNxBbaH93DzY96vFvyWA9O7v31wP1kIEgnaWdrIk6KUnA6CQD86Mz+6ttxynrTtBgUDT7k4Jg2+sNf9F32BxX2Bp2JWeWW13Cjv+qI3imE6Q9HqPcu1marR9id58+wq2wQwJJRgAVsscVT9X2Uh8XqrUqQXXExU8SMEGVAS6rJySxwziU2ZLC2FyeiVqneDNeXsMMG75kTMQgSfJnbsZgFVkGhgEeca/WwEgvHlt9xZTWOVEpSasTb0zl8uGuzIpUPUTELIoCRGfUd32d1RT2TlusG/Suyv/yt1ggTI4F9pCbimb+8cJJe712eHsjMc4FRUyG9Ed67ZxBKjqiIw2OXjZOWi92SEb7McOUswNW/Z6CX6kXyHIMMDBtZeMT7mp3I3Uw/XJtk0TEvNnkkOYEckmj+TckQQdmcF667ZJiZtlA+B7VR71/W4i2DBLGDpggmtXetuaQ2bCxxeGZ+CfLNR/Z1FgdKVDm5IpD/BzYRW5xWKE9MyHtqSCmOq8R8PkcO3ci/JrisVH7TgsPtvjPiBPF2CRA/MEoB+QZZtuXcUyWYu1wWVsfjDNgFG0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(2906002)(8676002)(4326008)(8936002)(6512007)(36756003)(86362001)(6506007)(45080400002)(66556008)(26005)(6486002)(478600001)(38100700002)(6666004)(66946007)(83380400001)(54906003)(41300700001)(66476007)(6916009)(2616005)(1076003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yY8p+fBbxlqBajq9+Wju86e3QnEd/oji5FJYqOp/mYRTAKqmVb7MrVfslDQ+?=
 =?us-ascii?Q?1/yIvxPjOZ5nzveqYknVHkDMGj1WImdS4ltlYNf6hKDBSbvzm6KURg2q71k1?=
 =?us-ascii?Q?79QRbgx9aovirfy6UeOSOEqY6SnU0WvsptQ1Ab91LmB0PhYZmlnJOZpOF0Aw?=
 =?us-ascii?Q?TZKQ/RnRrK7FJC9VvPZHMijclgFlOmBaB73oBA7IM2q6aJFUMeP5iQSnKVjs?=
 =?us-ascii?Q?jV1s0et9DZBdtbcXg+pVWJztQHn0Tk+8PVj+EpGTnQb+7zGm4FgFEwwwriwy?=
 =?us-ascii?Q?OGmwMwU2ot1qfxTjGjCq42lNbEMyii5CztuK11jdmoa3q8acKyGutz/YcKOm?=
 =?us-ascii?Q?LGkrcoduvWEJhyUtXRHEg1u4cm1hT3+wZ58OZf4O/elTr5tqFX2GQrxwBBnI?=
 =?us-ascii?Q?IwkdeDkwF2gFHyXbvAS9NqWVPFHPDW1IWgk4L06AIpEwGC03HfLEgZCgdIEv?=
 =?us-ascii?Q?iIuSWzFJDZtxUF15hTYSIEE6ql16anv4weJzp2J0Rt1GfmqtK9NIHmGgBbs9?=
 =?us-ascii?Q?JtAYVYAbsN3Y44ZsXTwel47E6F2YSscnmrmNWROIhvRvEEHMymuxxeIHbvVf?=
 =?us-ascii?Q?uW1sEEq+9mWVOGIKeI4+B9SLHRvGcIFazmeUtC1yToFWlP0TiKP5/rh7edH/?=
 =?us-ascii?Q?6Ty7/nOAUy2Z86wPqVtU7/V9BmY8t63oKHbe/Ez1y6aomdpW8loKVMLaXhKs?=
 =?us-ascii?Q?4FZyCSlAaSWWywsDYEqEmWj0TsMI3FuWWB2UP7mCPKTAHMX7lq2h+aNQujO5?=
 =?us-ascii?Q?mWVro4vpbwbpquSueNM98Yao8wM94okUxkL702LKeg22w9KP1ow8lo/D4NHu?=
 =?us-ascii?Q?eHvGNU0wY+4YYXGvZDfC4NeyI17enKBdG3S11c/xTUwohB+5NLlDwDMPoWzx?=
 =?us-ascii?Q?hUrjCXWL/NE5reNWwhU+I8iT57/kLl0bShO9nrZ53MYJmodacCsinZfeQTYP?=
 =?us-ascii?Q?idlcV+KM8sw3ZPCL08X/y5DrQ2fC+Fj7WnqQhoUj+qX3NhKDyToftxGgwMfw?=
 =?us-ascii?Q?HBc/iOaLnIerPNHBPt43QwgdA+xgWVbbYmSN3BoLm7yKP7ZpRAaZW3C3SeNP?=
 =?us-ascii?Q?4wt9/6tJzvI0WvTD5To4/y6+1RYaIZvY7CZT7s7jpJFGp6EtnaLkoYN2aTND?=
 =?us-ascii?Q?LMzAuzZNrUwK+FGV1umt9nDb9eVtEZ51ZLzhKRRKBsS2ZkLtcCC5KHqig4T5?=
 =?us-ascii?Q?lvTnLq3Uu1pY0Gim1eWFnocGWppbtOBZFgZZsPTrQ8m7AH2bGsI9FjCxbCyN?=
 =?us-ascii?Q?pXo1sttrsd72sdnyC9FJFzKlIhEmWXkaM8P2JsfjVpie5nnEUJiz8I/MDCvS?=
 =?us-ascii?Q?kXkpjqOkkMjl7uWxtMR168mGJ2WGaFLTn9Q3VjRBFuQB++WnPdNQiLrvjgJ+?=
 =?us-ascii?Q?U0AmSij4VdNFB791MCDfI8rMs0+xE9hu31Zor6RKpEohVNeELNBKGpJHje0h?=
 =?us-ascii?Q?Qur0pgUzZpW0T97U73BtMfpemKQdjOUZ3YUo4rARgMTc67PUlywvHU0Mvu4h?=
 =?us-ascii?Q?jrt/J0aDZiVYEmztclBw8+GHyz/3QjeUwrAdb5Rwgs7o5uQwfc30Vdsvkshb?=
 =?us-ascii?Q?yO8PpafM+Ca3xV5oUnki8AtdFZg2GhEYyoYzCxWqWn2szco5Tndi/bdjTWWF?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8d227c-bdb7-4e54-2894-08dc185a42e0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:18:32.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EuZdfyJ5tO5jEoXmY2k1CZCl+d/McIsCqHg2Z1xFg/bvzezEmTHPPp/yTcFQUR0Dp+3L2C4h6O773wOTTmY8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001

This reverts commit b34ab3527b9622ca4910df24ff5beed5aa66c6b5.

Using skb_ensure_writable_head_tail without a call to skb_unshare causes
the MACsec stack to operate on the original skb rather than a copy in the
macsec_encrypt path. This causes the buffer to be exceeded in space, and
leads to warnings generated by skb_put operations. Opting to revert this
change since skb_copy_expand is more efficient than
skb_ensure_writable_head_tail followed by a call to skb_unshare.

Log:
  ------------[ cut here ]------------
  kernel BUG at net/core/skbuff.c:2464!
  invalid opcode: 0000 [#1] SMP KASAN
  CPU: 21 PID: 61997 Comm: iperf3 Not tainted 6.7.0-rc8_for_upstream_debug_2024_01_07_17_05 #1
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
  RIP: 0010:skb_put+0x113/0x190
  Code: 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 70 3b 9d bc 00 00 00 77 0e 48 83 c4 08 4c 89 e8 5b 5d 41 5d c3 <0f> 0b 4c 8b 6c 24 20 89 74 24 04 e8 6d b7 f0 fe 8b 74 24 04 48 c7
  RSP: 0018:ffff8882694e7278 EFLAGS: 00010202
  RAX: 0000000000000025 RBX: 0000000000000100 RCX: 0000000000000001
  RDX: 0000000000000000 RSI: 0000000000000010 RDI: ffff88816ae0bad4
  RBP: ffff88816ae0ba60 R08: 0000000000000004 R09: 0000000000000004
  R10: 0000000000000001 R11: 0000000000000001 R12: ffff88811ba5abfa
  R13: ffff8882bdecc100 R14: ffff88816ae0ba60 R15: ffff8882bdecc0ae
  FS:  00007fe54df02740(0000) GS:ffff88881f080000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fe54d92e320 CR3: 000000010a345003 CR4: 0000000000370eb0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   ? die+0x33/0x90
   ? skb_put+0x113/0x190
   ? do_trap+0x1b4/0x3b0
   ? skb_put+0x113/0x190
   ? do_error_trap+0xb6/0x180
   ? skb_put+0x113/0x190
   ? handle_invalid_op+0x2c/0x30
   ? skb_put+0x113/0x190
   ? exc_invalid_op+0x2b/0x40
   ? asm_exc_invalid_op+0x16/0x20
   ? skb_put+0x113/0x190
   ? macsec_start_xmit+0x4e9/0x21d0
   macsec_start_xmit+0x830/0x21d0
   ? get_txsa_from_nl+0x400/0x400
   ? lock_downgrade+0x690/0x690
   ? dev_queue_xmit_nit+0x78b/0xae0
   dev_hard_start_xmit+0x151/0x560
   __dev_queue_xmit+0x1580/0x28f0
   ? check_chain_key+0x1c5/0x490
   ? netdev_core_pick_tx+0x2d0/0x2d0
   ? __ip_queue_xmit+0x798/0x1e00
   ? lock_downgrade+0x690/0x690
   ? mark_held_locks+0x9f/0xe0
   ip_finish_output2+0x11e4/0x2050
   ? ip_mc_finish_output+0x520/0x520
   ? ip_fragment.constprop.0+0x230/0x230
   ? __ip_queue_xmit+0x798/0x1e00
   __ip_queue_xmit+0x798/0x1e00
   ? __skb_clone+0x57a/0x760
   __tcp_transmit_skb+0x169d/0x3490
   ? lock_downgrade+0x690/0x690
   ? __tcp_select_window+0x1320/0x1320
   ? mark_held_locks+0x9f/0xe0
   ? lockdep_hardirqs_on_prepare+0x286/0x400
   ? tcp_small_queue_check.isra.0+0x120/0x3d0
   tcp_write_xmit+0x12b6/0x7100
   ? skb_page_frag_refill+0x1e8/0x460
   __tcp_push_pending_frames+0x92/0x320
   tcp_sendmsg_locked+0x1ed4/0x3190
   ? tcp_sendmsg_fastopen+0x650/0x650
   ? tcp_sendmsg+0x1a/0x40
   ? mark_held_locks+0x9f/0xe0
   ? lockdep_hardirqs_on_prepare+0x286/0x400
   tcp_sendmsg+0x28/0x40
   ? inet_send_prepare+0x1b0/0x1b0
   __sock_sendmsg+0xc5/0x190
   sock_write_iter+0x222/0x380
   ? __sock_sendmsg+0x190/0x190
   ? kfree+0x96/0x130
   vfs_write+0x842/0xbd0
   ? kernel_write+0x530/0x530
   ? __fget_light+0x51/0x220
   ? __fget_light+0x51/0x220
   ksys_write+0x172/0x1d0
   ? update_socket_protocol+0x10/0x10
   ? __x64_sys_read+0xb0/0xb0
   ? lockdep_hardirqs_on_prepare+0x286/0x400
   do_syscall_64+0x40/0xe0
   entry_SYSCALL_64_after_hwframe+0x46/0x4e
  RIP: 0033:0x7fe54d9018b7
  Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
  RSP: 002b:00007ffdbd4191d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 0000000000000025 RCX: 00007fe54d9018b7
  RDX: 0000000000000025 RSI: 0000000000d9859c RDI: 0000000000000004
  RBP: 0000000000d9859c R08: 0000000000000004 R09: 0000000000000000
  R10: 00007fe54d80afe0 R11: 0000000000000246 R12: 0000000000000004
  R13: 0000000000000025 R14: 00007fe54e00ec00 R15: 0000000000d982a0
   </TASK>
  Modules linked in: 8021q garp mrp iptable_raw bonding vfio_pci rdma_ucm ib_umad mlx5_vfio_pci mlx5_ib vfio_pci_core vfio_iommu_type1 ib_uverbs vfio mlx5_core ip_gre nf_tables ipip tunnel4 ib_ipoib ip6_gre gre ip6_tunnel tunnel6 geneve openvswitch nsh xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core zram zsmalloc fuse [last unloaded: ib_uverbs]
  ---[ end trace 0000000000000000 ]---

Cc: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---

Notes:
    Testing:
    
      This revert is needed even if commit a73d8779d61a ("net: macsec:
      introduce mdo_insert_tx_tag") is fully reverted as well, meaning
      resolving the headroom/tailroom issues in that commit is not enough and a
      fresh sk_buff is needed.

 drivers/net/macsec.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index e34816638569..7f5426285c61 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -607,11 +607,26 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 		return ERR_PTR(-EINVAL);
 	}
 
-	ret = skb_ensure_writable_head_tail(skb, dev);
-	if (unlikely(ret < 0)) {
-		macsec_txsa_put(tx_sa);
-		kfree_skb(skb);
-		return ERR_PTR(ret);
+	if (unlikely(skb_headroom(skb) < MACSEC_NEEDED_HEADROOM ||
+		     skb_tailroom(skb) < MACSEC_NEEDED_TAILROOM)) {
+		struct sk_buff *nskb = skb_copy_expand(skb,
+						       MACSEC_NEEDED_HEADROOM,
+						       MACSEC_NEEDED_TAILROOM,
+						       GFP_ATOMIC);
+		if (likely(nskb)) {
+			consume_skb(skb);
+			skb = nskb;
+		} else {
+			macsec_txsa_put(tx_sa);
+			kfree_skb(skb);
+			return ERR_PTR(-ENOMEM);
+		}
+	} else {
+		skb = skb_unshare(skb, GFP_ATOMIC);
+		if (!skb) {
+			macsec_txsa_put(tx_sa);
+			return ERR_PTR(-ENOMEM);
+		}
 	}
 
 	unprotected_len = skb->len;
-- 
2.42.0


