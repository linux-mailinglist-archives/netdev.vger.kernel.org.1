Return-Path: <netdev+bounces-17488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA3751C7F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA29280A73
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1434FF9DF;
	Thu, 13 Jul 2023 09:01:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F33DDC4
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:01:54 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC5D1BF2
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:01:36 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R1pSd0M3LzLnhR;
	Thu, 13 Jul 2023 16:59:13 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 17:01:33 +0800
Message-ID: <ad9f6b6d-fed6-a033-21af-899a149d5de6@huawei.com>
Date: Thu, 13 Jul 2023 17:01:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net v3 2/4] selftests: tc-testing: add tests for qfq mtu
 sanity check
To: Pedro Tammela <pctammela@mojatatu.com>, <netdev@vger.kernel.org>
CC: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <victor@mojatatu.com>,
	<simon.horman@corigine.com>, <paolo.valente@unimore.it>
References: <20230711210103.597831-1-pctammela@mojatatu.com>
 <20230711210103.597831-3-pctammela@mojatatu.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20230711210103.597831-3-pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/12 5:01, Pedro Tammela wrote:
> QFQ only supports a certain bound of MTU size so make sure
> we check for this requirement in the tests.
> 
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>   .../tc-testing/tc-tests/qdiscs/qfq.json       | 48 +++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
> index 147899a868d3..965da7622dac 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
> @@ -213,5 +213,53 @@
>               "$TC qdisc del dev $DUMMY handle 1: root",
>               "$IP link del dev $DUMMY type dummy"
>           ]
> +    },
> +    {
> +        "id": "85ee",
> +        "name": "QFQ with big MTU",
> +        "category": [
> +            "qdisc",
> +            "qfq"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$IP link add dev $DUMMY type dummy || /bin/true",
> +            "$IP link set dev $DUMMY mtu 2147483647 || /bin/true",
> +            "$TC qdisc add dev $DUMMY handle 1: root qfq"
> +        ],
> +        "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 100",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC class show dev $DUMMY",
> +        "matchPattern": "class qfq 1:",
> +        "matchCount": "0",
> +        "teardown": [
> +            "$IP link del dev $DUMMY type dummy"
> +        ]
> +    },
> +    {
> +        "id": "ddfa",
> +        "name": "QFQ with small MTU",
> +        "category": [
> +            "qdisc",
> +            "qfq"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$IP link add dev $DUMMY type dummy || /bin/true",
> +            "$IP link set dev $DUMMY mtu 256 || /bin/true",
> +            "$TC qdisc add dev $DUMMY handle 1: root qfq"
> +        ],
> +        "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 100",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC class show dev $DUMMY",
> +        "matchPattern": "class qfq 1:",
> +        "matchCount": "0",
> +        "teardown": [
> +            "$IP link del dev $DUMMY type dummy"
> +        ]
>       }
>   ]

Tested-by: Zhengchao Shao <shaozhengchao@huawei.com>

