Return-Path: <netdev+bounces-16197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8FF74BC6A
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 08:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507C61C21123
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 06:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF2D10E5;
	Sat,  8 Jul 2023 06:43:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3444E15A4
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 06:43:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC7A1FEC
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 23:43:44 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QyggG2vHVzTlcn;
	Sat,  8 Jul 2023 14:42:34 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 8 Jul 2023 14:43:40 +0800
Message-ID: <71fadd96-2a2c-24d1-e5f6-6239db95d057@huawei.com>
Date: Sat, 8 Jul 2023 14:43:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net v2 4/4] selftests: tc-testing: add test for qfq with
 stab overhead
To: Pedro Tammela <pctammela@mojatatu.com>, <netdev@vger.kernel.org>
CC: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <victor@mojatatu.com>,
	<simon.horman@corigine.com>, <paolo.valente@unimore.it>
References: <20230707220000.461410-1-pctammela@mojatatu.com>
 <20230707220000.461410-5-pctammela@mojatatu.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20230707220000.461410-5-pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/8 6:00, Pedro Tammela wrote:
> A packet with stab overhead greater than QFQ_MAX_LMAX should be dropped
> by the QFQ qdisc as it can't handle such lengths.
> 
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>   .../tc-testing/tc-tests/qdiscs/qfq.json       | 38 +++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
> index 965da7622dac..6b8798f8dd04 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
> @@ -261,5 +261,43 @@
>           "teardown": [
>               "$IP link del dev $DUMMY type dummy"
>           ]
> +    },
> +    {
> +        "id": "5993",
> +        "name": "QFQ with stab overhead greater than max packet len",
> +        "category": [
> +            "qdisc",
> +            "qfq",
> +            "scapy"
> +        ],
> +        "plugins": {
> +            "requires": [
> +                "nsPlugin",
> +                "scapyPlugin"
> +            ]
> +        },
> +        "setup": [
> +            "$IP link add dev $DUMMY type dummy || /bin/true",
> +            "$IP link set dev $DUMMY up || /bin/true",
> +            "$TC qdisc add dev $DUMMY handle 1: stab mtu 2048 tsize 512 mpu 0 overhead 999999999 linklayer ethernet root qfq",
> +            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 100",
> +            "$TC qdisc add dev $DEV1 clsact",
> +            "$TC filter add dev $DEV1 ingress matchall action mirred egress mirror dev $DUMMY"
> +        ],
> +        "cmdUnderTest": "$TC filter add dev $DUMMY parent 1: matchall classid 1:1",
> +        "scapy": [
> +            {
> +                "iface": "$DEV0",
> +                "count": 22,
> +                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.10')/TCP(sport=5000,dport=10)"
> +            }
> +        ],
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -s qdisc ls dev $DUMMY",
> +        "matchPattern": "dropped 22",
Hi Pedro:
	I test this patch, but the number of dropped packets in each
test is random, but is always greater than 22. My local machine tests
are not ok. Here's my test results:
All test results:

1..1
not ok 1 5993 - QFQ with stab overhead greater than max packet len
         Could not match regex pattern. Verify command output:
qdisc qfq 1: root refcnt 2
  Sent 0 bytes 0 pkt (dropped 26, overlimits 0 requeues 0)
  backlog 0b 0p requeues 0

Zhengchao Shao

> +        "matchCount": "1",
> +        "teardown": [
> +            "$TC qdisc del dev $DUMMY handle 1: root qfq"
> +        ]
>       }
>   ]

