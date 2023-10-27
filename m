Return-Path: <netdev+bounces-44685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A33D7D9333
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEDD28224F
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AA7156EB;
	Fri, 27 Oct 2023 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fWUmkTTi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF953B7
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 09:11:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E61187
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8rffgWcaVkpBldlpDqC2/oKzczfhu8Tv/ZmZzag2r4G3RoZD5evjVUsiLj0oiEgU0+R7foEADPIXLaXDsyvKzzgAzfPlvqpvhzsOMD8cfvqfqkSWHvqVR8fKzTdbUiAfVXab1X56iSqaMzgBCCqmWq0Smp1P64r2FDr0k2lamXv1cLyuVSyYt0TwCltBHxYCYzfaXtFDFFD7piddyKXuU+LRxo/sZhXODkiMqpe9TCzmkN4L/pRhKsltAE0/3iUX2JMgF5m2t2ZKDxzi8t1l52+ofUG5EQPYQIlc33T3u449TKnVwHYzlRLvt2NHrCWoyFK84CAqB1/M+JU3UOSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6AgpUOCIJDPsyq7WHaVsX95MxCup1epUt8W3CjkadQ=;
 b=nw4VTti2Kd+GL1nj1TH06qjo74Dhkq1AiOzTAJh6w5wucZ//h72108Ham76+cTfGvGgir4vABFNxpDvQ9eiYpS177l0O5ZLJZJpNKmXGcZeRiOTeoPzFCMp2zcTuY4VUmc6dOByuN9zWYynhvuvwPcanUp1gamGhgch253jUBcAo9uGQ0+PYL+RHQI4s3hFKEyae6qVfxpc69O+p4GNXtlU6xAw3w07I8zgXmLSXlt709u7tGnf/KufYtDB/1a6eXiTaacw3vuieyl/cgIBoIGoYp0t0sx0aVxVEiKSQTqqBMn7m5ZUdJO//P8JNlqNlwYLE0MNfAiVinfQVipQKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6AgpUOCIJDPsyq7WHaVsX95MxCup1epUt8W3CjkadQ=;
 b=fWUmkTTiyqbPq8vgDEH1K8jRnl/DMDGdyPrWJhBf4fLRhFILrVUuKNJM3TnOPWPVN5kMbJ7LHXaP6Sfyv2bPtK7c0bZ4MkajCinFEcBCeGM1VMZFKgaOp0HplBKbjGnwfY5iAFsWmbL+2QotvAyQAkCFcAhYl8r3wQxzRWkXOzymSmxK9NxEvLXj3PtVYllsifeAmiMRHAF+ZxwXfwgHuKcLSs5vcMPcOmUfEFVGHMMU+vfhkBEgHI4q+UCs8LyPahG4Lz97/3OYN8os6c93hg6l+1lyQyC/tP0+XN/fomaEQPHqjyVg03+mX5X81nzS1y12kw/nlo1YD+7ffJrBAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 09:11:23 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 09:11:23 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
 pabeni@redhat.com, imagedong@tencent.com
Subject: Re: [PATCH v17 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
In-Reply-To: <ZTfNfvtZz7F1up6u@nanopsycho>
References: <20231024125445.2632-1-aaptel@nvidia.com>
 <20231024125445.2632-3-aaptel@nvidia.com> <ZTfNfvtZz7F1up6u@nanopsycho>
Date: Fri, 27 Oct 2023 12:11:19 +0300
Message-ID: <253h6mcjuq0.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BN9PR12MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9e1f27-b93e-4ef7-ae89-08dbd6ccb0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ckpPTGYtrdQxJmLH0rpZjpuV7yLH/eKHe+x4as5BIm+PGZM2PwtrQ/fFE8ZmlrStQiSvNpyRL9Cn8R3Vw9dHqfoVwZwMM+JO2/PYxFcN4G7dPZ5uGOOLbFTPkKSx8PWG7LnDOZVeFjmUbzDPZ1kIjEjjtYKbzv/sVmvNtv2Qj4KgDInf/GYrdqj0wMtY2ku7XY9xCGnjOF2dTIxcR1sznKBDwe9Dnws3O1cECYPzr/slVbQP0Xrq635LklveVNCKbZDs5frX/DO3+mRhs/7JLQrYhgImtCNtc5D+TKiRjCe91VDV7yZwP9FAjckZXMmWSFNwtQ51KdhgYMJMM68eQw4eLgxBQq7oppcOpAvQAwzhRsQPJ21Q1C4NTmtzaF5dhP4nH20yGk61WqbWLCMI+tABIA3jgIgA/Di19CTPp6gcVo87U9QzyrPkvHqoYRBfzBC7LN1tvW+9ggKAWaGZ8vvoTshydBLWjxSKbFa72MNWNLLmOmOO5ALG1BieKEJ2DXw9qvbCkSPyaEmD8W39iuBlD5fQVi3jXrP3ByHjNS/wO1Vx4PYAqUfjjbYFA6SRMLmiQ5AtCY85L1GaMV7/XE7QQ7PnOUcMKu/LZ6pGJtGGMlXxppChVKfiEjZXU9YM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(4326008)(6916009)(83380400001)(8936002)(66476007)(8676002)(66946007)(66556008)(7416002)(6666004)(2906002)(6486002)(478600001)(5660300002)(316002)(41300700001)(6506007)(2616005)(26005)(86362001)(38100700002)(36756003)(6512007)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tWxdi/hylpV3mhW2mN7pH6lmN+sLVvCXkGBZ/VU6QSXdEAOOUrqQDX+lgW7i?=
 =?us-ascii?Q?TXfxo/OcEYBU2+biYCQBp9JISniMuKS6F9emPxNrUyQZ2JwoFTrHZz46UtBt?=
 =?us-ascii?Q?ONTGynYIgKkLU57QjFSmUz24z+MMjS8RD9f7GtQxjvXr6nYpVaSpFdPls3vc?=
 =?us-ascii?Q?FJ9h88KhGYbmC3TTPUONt5hen+h8Kp8L/SCxawZMHpu2c4IuzUy24y/e0DAV?=
 =?us-ascii?Q?f+C+rWr0RujlI9m4zMf61YQi03rHIPTH0MI+2rrB3VCX6FkZ4wirozIrJR+D?=
 =?us-ascii?Q?SYin+mAoHFkOYlhaUVd2IdH/f8bCJq2J7lswuDAvIs8RWEs+vj1aedgF+xLP?=
 =?us-ascii?Q?Txgv8vMsA1Sg9SQGuqsHFeD1XQPynqrJ6Javi34YF28EdSfJRFMIGPb3X9rG?=
 =?us-ascii?Q?sMB8V/J6ILQi+wn29vrfQADmE/AT4bwsqqD3tq8Uo+Ikaovh9mAUvaRFobWr?=
 =?us-ascii?Q?AhjxWYRTkfWLnucRAhQg26ayg3+ZCz0BWqdrERi98fCL71qeeU7HC56ichsL?=
 =?us-ascii?Q?o6m+G6pb6qLOzPvz7zhpCHls+yYwGXhgseWHSirwBseKBFHjn6a72GMZZTY+?=
 =?us-ascii?Q?p1OJSl/VpZN/txT9FC8DiNVr4wiWEfbyZrK2pK2wXpXTn/KkDKH6UGFuT1xD?=
 =?us-ascii?Q?NXF1FmMp6pZ1uTz/LfI1VtQvPPM7tTj6N2/H8//FHdmDUrs3XS1D7IqhFU04?=
 =?us-ascii?Q?M3nAw5T/4afDfR1zXAsSaHmQC44T8cZLe5D9IPZuvSsT4ZIjhiJ+dt+SU3YF?=
 =?us-ascii?Q?S+tMeLQW/Zj2ggodr8nXZ6IoPSILRNmphm/cOZItB+YOiPw65NeyQsLfb+AE?=
 =?us-ascii?Q?7urtwzfDfMqaDqFToWcr3lx/zno2lQvFgGU4tb8KtCARsutsvR1+KAeTj/7n?=
 =?us-ascii?Q?TTgjgOmSdDBfeJm85KVGj/2apt8F0BX7M9tfeVS6uFMPqwDcpDK2lcEe/555?=
 =?us-ascii?Q?pMeU9uKMa21xA74Hu8RW9fNUvXKU0Evbrm3z4SMwRZwJ0ILdxVdMVdT1IL1X?=
 =?us-ascii?Q?ZZ4rhV4YcZYgNXW4cI8fKezmKz2KdCXsWoBl4wsH/+Ui0f2EhPYH8weF9P/j?=
 =?us-ascii?Q?DzjQTdUW9dj2Uo47+65jV+So9PnsSlTEjm5v193lD3M30wR/cGxZdT+S1/2i?=
 =?us-ascii?Q?/rOHJZ277nLZNTY1+pKSfUCf1rwwBWTaWzqZfgGeijMI60VATO9APQguZ3e2?=
 =?us-ascii?Q?LqqhnsosIBWUlu1Uc3ZV3ZbrZ5kMfdjq1EYd8FcTWukBBddVzCkE/2FQgsx1?=
 =?us-ascii?Q?nR98uYNVwM8olW0vs0m7AYMY4tu0czDOtk3I4DStIUumtesKAcldoDcUxWxU?=
 =?us-ascii?Q?NekMO53lDzQwI6C0pvK4WGL/HZ3P0jxqu01HUWmA8zLXgU9CgfFJxpLXTpRl?=
 =?us-ascii?Q?ZwikDNrSX4abgdNEKOC6QzCA/QDpQibqvjerA6B5StvlV4yJtMp3DZQHXKo4?=
 =?us-ascii?Q?NGKo/2WH9fEyJMKpBV/i82iEYLjosAo2uJCxE2QAH3Gc3mjiHHC9ahRgMr+8?=
 =?us-ascii?Q?HYrBH4xTwDGtOcWoh6Wiki+2X2Pxvqo8cbLuacNWFyvQvjLi9wiS9t5wab1H?=
 =?us-ascii?Q?YRd80DS1wc6xFFI0Wtj4NpMi1dWEGPh7xusl4agx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9e1f27-b93e-4ef7-ae89-08dbd6ccb0b8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 09:11:23.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxuVHPM0Nrg6dnSF00OVdVrTWkbTTxccW6ySHa4XR2wKkvzPZNtBhiKPYfJiaBGvH9v4CDwMlgOmNCvaIdcDEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145

Hi Jiri,

Jiri Pirko <jiri@resnulli.us> writes:
>>+definitions:
>>+  -
>>+    type: enum
>>+    name: cap
>>+    entries:
>>+      - nvme-tcp
>>+      - nvme-tcp-ddgst-rx
>>+
>>+uapi-header: linux/ulp_ddp_nl.h
>
> Not needed.
> Hmm, Jakub, why this is not only allowed in genetlink-legacy?

Ok, we will remove it and use the default location.

>>+
>>+attribute-sets:
>>+  -
>>+    name: stat
>
> "stats"?

Sure.

>>+    attributes:
>>+      -
>>+        name: ifindex
>>+        doc: interface index of the net device.
>>+        type: u32
>>+      -
>>+        name: pad
>>+        type: pad
>>+      -
>>+        name: rx-nvmeotcp-sk-add
>>+        doc: Sockets successfully configured for NVMeTCP offloading.
>>+        type: u64
>>+      -
>>+        name: rx-nvmeotcp-sk-add-fail
>
> "nvmeotcp" should stand for "nvme over tcp"? Why not to name it just
> "rx-nvem-tcp-x"?

Ok, we will rename them.

>>+  -
>>+    name: dev
>
> If this is attribute set for "caps-get"/"caps-set" only, why it is not
> called "caps"?

Ok, we will rename it.

>>+    attributes:
>>+      -
>>+        name: ifindex
>>+        doc: interface index of the net device.
>>+        type: u32
>>+      -
>>+        name: hw
>>+        doc: bitmask of the capabilities supported by the device.
>>+        type: u64
>>+        enum: cap
>>+        enum-as-flags: true
>>+      -
>>+        name: active
>>+        doc: bitmask of the capabilities currently enabled on the device.
>>+        type: u64
>>+        enum: cap
>>+        enum-as-flags: true
>>+      -
>>+        name: wanted
>
> For all caps related attrs, either put "caps" into the name or do that
> and put it in a caps nest

We will rename the attribute-set to "caps" and leave hw, active, wanted as-is.

>>+operations:
>>+  list:
>>+    -
>>+      name: get
>>+      doc: Get ULP DDP capabilities.
>
> This is for capabalities only, nothing else?
> If yes, why not to name the op "caps-get"/"caps-set"?
> If not and this is related to "dev", name it perhaps "dev-get"?
> I mean, you should be able to align the op name and attribute set name.

Yes it is for capabilities. We will rename the operations to caps-get/caps-set.

>>+      attribute-set: dev
>>+      do:
>>+        request:
>>+          attributes:
>>+            - ifindex
>>+        reply: &dev-all
>>+          attributes:
>>+            - ifindex
>>+            - hw
>>+            - active
>>+        pre: ulp_ddp_get_netdev
>>+        post: ulp_ddp_put_netdev
>>+      dump:
>>+        reply: *dev-all
>>+    -
>>+      name: stats
>
> "stats-get" ?

Ok

>>+++ b/net/core/ulp_ddp_nl.c
>>@@ -0,0 +1,388 @@
>>+// SPDX-License-Identifier: GPL-2.0
>>+/*
>>+ * ulp_ddp.c
>>+ *    Author: Aurelien Aptel <aaptel@nvidia.com>
>>+ *    Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
>>+ */
>>+#include <net/ulp_ddp.h>
>>+#include "ulp_ddp_gen_nl.h"
>>+
>>+#define ULP_DDP_STATS_CNT (sizeof(struct netlink_ulp_ddp_stats) / sizeof(u64))
>>+
>>+struct reply_data {
>
> Some sane prefix for structs and fuctions would be nice. That applies to
> the whole code.

Sure, we will add ulp_ddp prefix to all symbols. 

> What's "data"? Reading the code, this sounds very vague. Try to be more
> precise in struct and functions naming.

It's the data used to write the response message.
We will rename it to ulp_ddp_reply_context.

>>+
>>+/* pre_doit */
>>+int ulp_ddp_get_netdev(const struct genl_split_ops *ops,
>>+                     struct sk_buff *skb, struct genl_info *info)
>
> Could you perhaps check ulp_ddp_caps here instead of doing it on multiple
> places over and over. Of course fill-up a proper extack message in case
> the check fails.

Sounds good.

>>+      if (!data->dev) {
>>+              kfree(data);
>>+              NL_SET_BAD_ATTR(info->extack,
>>+                              info->attrs[ULP_DDP_A_DEV_IFINDEX]);
>
> Fill-up a meaningful extack message as well please using
> NL_SET_ERR_MSG()

Ok

>>+              return -ENOENT;
>
>                 return -ENODEV;
> Maybe?

Ok

>>+      struct reply_data *data = info->user_ptr[0];
>>+
>>+      if (data) {
>
> How "data" could be NULL here?
>
>>+              if (data->dev)
>
> How "data->dev" could be NULL here?

It can't, we will remove all the checks.

>>+              for (i = 0; i < ULP_DDP_STATS_CNT; i++, attr++)
>>+                      if (nla_put_u64_64bit(rsp, attr, val[i],
>
> This rely on a struct layout is dangerous and may easily lead in future
> to put attrs which are not define in enum. Please properly put each stat
> by using attr enum value.

Sure, we will explicitely set all stats attributes.

>>+
>>+      /* if (req_mask & ~all_bits) */
>>+      bitmap_fill(all_bits, ULP_DDP_C_COUNT);
>>+      bitmap_andnot(tmp, req_mask, all_bits, ULP_DDP_C_COUNT);
>>+      if (!bitmap_empty(tmp, ULP_DDP_C_COUNT))
>
> Please make sure you always fillup a proper extack message, always.

Noted. This check was redundant so we removed it (bits beyond
ULP_DDP_C_COUNT are not checked).

>>+      notify = !!ret;
>>+      ret = prepare_data(data, ULP_DDP_CMD_SET);
>
> Why you send it back for set? (leaving notify aside)

We send back the final caps so userspace can see and compare what was
requested vs the result of what the driver could enable.
This is following the convention of ethtool features.

>>+int ulp_ddp_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>>+{
>>+      struct net *net = sock_net(skb->sk);
>>+      struct net_device *netdev;
>>+      struct reply_data data;
>>+      int err = 0;
>>+
>>+      rtnl_lock();
>>+      for_each_netdev_dump(net, netdev, cb->args[0]) {
>
> Is this function necessary? I mean, do you have usecase to dump the
> the caps for all devices in the netns? If no, remove this dump op.
> If yes, could you please do it without holding rtnl? You don't need rtnl
> for do ops either.

This is not necessary, we will remove the dump ops.

>>+static int __init ulp_ddp_init(void)
>>+{
>>+      int err;
>>+
>>+      err = genl_register_family(&ulp_ddp_nl_family);
>>+      if (err)
>>+              return err;
>>+
>>+      return 0;
>
> The whole function reduces just to:
>         return genl_register_family(&ulp_ddp_nl_family);

Ok

Thanks

