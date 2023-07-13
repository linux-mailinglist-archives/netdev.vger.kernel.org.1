Return-Path: <netdev+bounces-17490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E70751CA1
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657F8281B9A
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2CDF9FB;
	Thu, 13 Jul 2023 09:05:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF0F9F7
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:05:39 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5C82697
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:05:35 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R1pbF6M0Xz18LrT;
	Thu, 13 Jul 2023 17:04:57 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 17:05:33 +0800
Message-ID: <badd35dc-4faa-6322-dcb0-990f9b58e714@huawei.com>
Date: Thu, 13 Jul 2023 17:05:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net v3 4/4] selftests: tc-testing: add test for qfq with
 stab overhead
To: Pedro Tammela <pctammela@mojatatu.com>, <netdev@vger.kernel.org>
CC: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <victor@mojatatu.com>,
	<simon.horman@corigine.com>, <paolo.valente@unimore.it>
References: <20230711210103.597831-1-pctammela@mojatatu.com>
 <20230711210103.597831-5-pctammela@mojatatu.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20230711210103.597831-5-pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/12 5:01, Pedro Tammela wrote:
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
> index 965da7622dac..976dffda4654 100644
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
> +            "$TC filter add dev $DEV1 ingress protocol ip flower dst_ip 1.3.3.7/32 action mirred egress mirror dev $DUMMY"
> +        ],
> +        "cmdUnderTest": "$TC filter add dev $DUMMY parent 1: matchall classid 1:1",
> +        "scapy": [
> +            {
> +                "iface": "$DEV0",
> +                "count": 22,
> +                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='1.3.3.7')/TCP(sport=5000,dport=10)"
> +            }
> +        ],
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -s qdisc ls dev $DUMMY",
> +        "matchPattern": "dropped 22",
> +        "matchCount": "1",
> +        "teardown": [
> +            "$TC qdisc del dev $DUMMY handle 1: root qfq"
> +        ]
>       }
>   ]
Hi Pedro:
I'm confused about whether the following output is necessary during the
test.
Sent 1 packets.
.
Sent 1 packets.
.
...
Otherwise, it looks good to me.

Tested-by: Zhengchao Shao <shaozhengchao@huawei.com>


