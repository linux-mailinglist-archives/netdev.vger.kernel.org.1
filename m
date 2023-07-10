Return-Path: <netdev+bounces-16409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8875A74D1A8
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 11:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04541C209DF
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B05D53E;
	Mon, 10 Jul 2023 09:34:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C8DC8D0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:34:58 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF451B1
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 02:34:57 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QzzMs1wKnzTmRF;
	Mon, 10 Jul 2023 17:33:45 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 10 Jul
 2023 17:34:54 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net 0/3] fix slab-use-after-free in decode_session6
Date: Mon, 10 Jul 2023 17:40:50 +0800
Message-ID: <20230710094053.3302181-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When net device is configured with the qdisc of the sfb type, the cb
field of the SKB is used in both enqueue and decode session of packets,
and the fields overlap. When enqueuing packets, the cb field of skb is
used as a hash array. Also it is used as the header offset when decoding
session of skb. Therefore, it will cause slab-use-after-free in
decode_session6.
The cb field in the skb should not be used when sending packets. Set the
cb field of skb to 0 before decoding skb.

Zhengchao Shao (3):
  xfrm: fix slab-use-after-free in decode_session6
  ip6_vti: fix slab-use-after-free in decode_session6
  ip_vti: fix potential slab-use-after-free in decode_session6

 net/ipv4/ip_vti.c              | 4 ++--
 net/ipv6/ip6_vti.c             | 4 ++--
 net/xfrm/xfrm_interface_core.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1


