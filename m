Return-Path: <netdev+bounces-34554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B27A49DB
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41FD281403
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2A71C6B1;
	Mon, 18 Sep 2023 12:39:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD26156F5
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:39:33 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3B8A0
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:39:31 -0700 (PDT)
Received: from kwepemm600019.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rq45l454TzMlcK;
	Mon, 18 Sep 2023 20:35:55 +0800 (CST)
Received: from [10.136.112.228] (10.136.112.228) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 20:39:27 +0800
Subject: Re: The call trace occurs during the VRF fault injection test
To: hanhuihui <hanhuihui5@huawei.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "pablo@netfilter.org"
	<pablo@netfilter.org>, <stephen@networkplumber.org>, <jhs@mojatatu.com>,
	<xiyou.wangcong@gmail.com>, <kuba@kernel.org>
CC: "Yanan (Euler)" <yanan@huawei.com>, Caowangbao <caowangbao@huawei.com>,
	liaichun <liaichun@huawei.com>
References: <1c353f53578e48faa9b254394b42b391@huawei.com>
From: "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>
Message-ID: <cc39ec95-e1d7-bfa0-9e61-6496c58e388c@huawei.com>
Date: Mon, 18 Sep 2023 20:39:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1c353f53578e48faa9b254394b42b391@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.112.228]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,
I am analyzing the issue, and I am very happy for any replies.

Setting netem in physical device does not matter, remove the following step will still hit problem.
"tc qdisc add dev enp4s0 root netem delay 1000ms 500ms"

When we set netem with delay in vrf device, commit 5a308f40bfe27(netem: refine early skb orphaning)
will do early skb orphaning, and set skb->destructor to sock_efree. But when skb propagate to the second
round and back to L3, we need do fragment again. In quick path of ip_do_fragment, frag->destructor is been
setting to sock_wfree again(commit 2fdba6b085eb7).
In the end, start_xmit(virtio_net) call skb_orphan will lead to having negative socket sk_wmem_alloc counter.

I am know little about netem, I am confused for the early skb orphaning, which is not exist in other qdiscs.
Seems that if we do early skb orphaning, skb back to L3 and do ip fragment again, something unexpected.

After testing the following code, everything seems fine.
---
 net/sched/sch_netem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index cd5d821..04d5e22 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -578,6 +578,11 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,

                cb->time_to_send = now + delay;
                ++q->counter;
+               if (skb->sk) {
+                        skb->destructor = sock_wfree;
+                        skb_set_hash_from_sk(skb, skb->sk);
+                        refcount_add(skb->truesize, &(skb->sk->sk_wmem_alloc));
+                }
                tfifo_enqueue(skb, sch);
        } else {
                /*
--


Cheers,
t.feng

.

On 2023/9/8 18:05, hanhuihui wrote:
> Hello, I found a problem in the VRF fault injection test scenario. When the size of the sent data packet exceeds the MTU, the call trace is triggered. The test script and detailed error information are as follows:
> "ip link add name vrf-blue type vrf table 10
> ip link set dev vrf-blue up
> ip route add table 10 unreachable default
> ip link set dev enp4s0 master vrf-blue
> ip address add 192.168.255.250/16 dev enp4s0
> tc qdisc add dev enp4s0 root netem delay 1000ms 500ms
> tc qdisc add dev vrf-blue root netem delay 1000ms 500ms
> ip vrf exec vrf-blue ping "192.168.162.184" -s 6000 -I "enp4s0" -c 3
> tc qdisc del dev "enp4s0" root
> tc qdisc del dev vrf-blue root
> ip address del 192.168.255.250/16 dev enp4s0
> ip link set dev enp4s0 nomaster"
> 
> 
> "[  284.613866] refcount_t: underflow; use-after-free.
> [  284.613906] WARNING: CPU: 0 PID: 0 at lib/refcount.c:28 refcount_warn_saturate+0xd1/0x120
> [  284.614192] Call Trace:
> [  284.614195]  <IRQ>
> [  284.614207]  ? refcount_warn_saturate+0xd1/0x120
> [  284.614257]  ? refcount_warn_saturate+0xd1/0x120
> [  284.614262]  sock_wfree+0x303/0x310
> [  284.614273]  skb_orphan_partial+0x1f3/0x250
> [  284.614299]  netem_enqueue+0xda/0x1160 [sch_netem]
> [  284.614325]  dev_qdisc_enqueue+0x30/0xe0
> [  284.614333]  __dev_xmit_skb+0x410/0x8a0
> [  284.614352]  __dev_queue_xmit+0x620/0xde0
> [  284.614421]  __neigh_update+0x2ef/0xf10
> [  284.614429]  arp_process+0x4af/0xd50
> [  284.614455]  arp_rcv.part.0+0x1e6/0x2d0
> [  284.614493]  __netif_receive_skb_list_core+0x489/0x500
> [  284.614522]  __netif_receive_skb_list+0x1cc/0x2d0
> [  284.614564]  netif_receive_skb_list_internal+0x234/0x380
> [  284.614616]  napi_complete_done+0x128/0x390
> [  284.614640]  virtnet_poll+0x1e3/0x340 [virtio_net]
> [  284.614683]  __napi_poll+0x59/0x2c0
> [  284.614689]  net_rx_action+0x55a/0x6a0
> [  284.614712]  __do_softirq+0xf5/0x38d
> [  284.614718]  __irq_exit_rcu+0xdd/0x100
> [  284.614725]  common_interrupt+0x81/0xa0



