Return-Path: <netdev+bounces-303283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3CfCAN/kQ2qelAoAu9opvQ
	(envelope-from <netdev+bounces-303283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:46:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 391CF6E614F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:46:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=wsH55Dpi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303283-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303283-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F0BF3088662
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13E3450911;
	Tue, 30 Jun 2026 15:43:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF9450903
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:43:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834201; cv=none; b=LRS1+hTwRjtLtLoy2ohod1WdoY2iRW55uLNbSnZSTt+19exVJkwg3F7TBgIV3TlTKsSA/GIJJFM04JyQGf6A/e3kgg1doO6eTKwLzq1lFzAuPIgyT3DcWqEQ9AjO9w/oRvwe+1kgL4yPUOrpjoehvWEFsjIwHUEQZXfbCjwsiSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834201; c=relaxed/simple;
	bh=IAVQMCi1/fFjxLpADvnYeio4zLATRTbVkN021DowHBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2KO8qbYwu9qc31Omp0BHQNHgfMb0EljClJWF1WTdNQFOrg/7S5o+F4ze0+ggKmIWZ7IoDHYTp/H5QH8BhSEBwW1/nfU++PgmPvEJaK/pcG2dKdYOcwSYT0m9VBLm4uhgnxOR+Uv+9ePqbJ5Iqqn/tJkNlk/bPwO1UWsPaA8xtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=wsH55Dpi; arc=none smtp.client-ip=74.125.82.180
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30eac9abd79so4325339eec.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782834199; x=1783438999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jb7J3F2qP76lahUI0HH3EDvBc9kZ/r/cnr59nYn5stk=;
        b=wsH55DpiMwTEfumBqcZPHbuldesLJDO0DaBT6A9DyahF8V0dhft0wSUM4tnt2nAJh/
         nPnAlUgWMVuhPi7Stc1EXgodiYSzdMlkCmkNLvQt+EaPvyWb48KcIizLdyd11QjdSz/E
         Hm1zeErOWoh8cYcWxx55HD9tlXzHS6rkcGmBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834199; x=1783438999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jb7J3F2qP76lahUI0HH3EDvBc9kZ/r/cnr59nYn5stk=;
        b=UT8bGLvvwv+wimO9BDfG6/uPjcSAdp+8ywiKvtKXP1geXoNa3UzGgHD1Nn1XHYR5bW
         XlGVU3jSIXAedwtdILcXcthBWt3I6KH9Rq2xayUqDAguTRF6xemlhdlX4I9CVbbAuTSV
         xSfSpSmZIKb6ipBaCui3DhKm7iNLObv10A/99FkXp4P0XcIm4ysF+g0V8H3hvRDS/ix/
         4ocIEwzoNhCw6mjZ7BUK+yjlsV/nOqqCBTZM10azU9lIiJUde9UARe4LGVHjgdVfKDml
         4Q3uZH1fegwv1/aOf+k613ejWFhxtDjuj54c5ErG0gqHKP7LKeJ6EoEuKfmADkbPfq1C
         8UqQ==
X-Gm-Message-State: AOJu0Yz2fTRfoaSq2u/up4Gb+6zNnZmC9DG5hoOVgwR0Mf9EcVqo0+IT
	JJJ4g5RNWFAcReBErVn9FBsftIQX1qqyob4yufBAl4DL69z+/hruxzU1k4GM8qowUQ==
X-Gm-Gg: AfdE7cnxChxHHyqwb1TjMqSHFJ6XvRfbkgtmPrUv+6alO5Msw8rk91EX4XNibvdzi8x
	yf0HQy8m7yu+JwehVyrJOzT31Ui7aRuBlynUFGbUtPWxFtvy7Ymsm/de9TAKFVTSuCK2UPHTA71
	hM1MW7M52lsztB0E4fl3vrdon7vxAlSsP4ttdY194WJyq/Bf4phy5yhk8CiNTMc+VqJhEKc4IVE
	P24F65dD90aY3r6lysB7yhNGVyI7RQ3xGhL3+bdL4p5iIVPssUIkS64O/4dZkBK9SKcyTjFdnOB
	1zId+qf8ZeVR8pfcyJPV3n3p2L1cI8/fVDidx2C3IG18cSqOxhAnPEl3N7/RY5P8vpEANSB1TPn
	kGP/44TYNNWC5ubFEugeqxsg7YkqsvjAEkESHeUHeb0Ts7AGfsUvGE16wpIInm/aaM94VdzmEDv
	64v0uK50ylMsR9SB6d/W4=
X-Received: by 2002:a05:7301:578a:b0:30b:f73f:ff6e with SMTP id 5a478bee46e88-30ee11fc7c0mr2697252eec.11.1782834199324;
        Tue, 30 Jun 2026 08:43:19 -0700 (PDT)
Received: from [192.168.50.25] ([186.205.7.134])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee31da9f3sm7883212eec.22.2026.06.30.08.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:43:18 -0700 (PDT)
Message-ID: <1a1d2226-913d-470e-aa1a-1a2eaee97325@mojatatu.com>
Date: Tue, 30 Jun 2026 12:43:14 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests/tc-testing: Add tests that force multiq and
 taprio to enqueue to child's gso_skb
To: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 jiri@resnulli.us
Cc: netdev@vger.kernel.org, hexlabsecurity@proton.me
References: <20260630153651.249752-1-victor@mojatatu.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20260630153651.249752-1-victor@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[pctammela@mojatatu.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303283-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:victor@mojatatu.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:hexlabsecurity@proton.me,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pctammela@mojatatu.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 391CF6E614F

On 30/06/2026 12:36, Victor Nogueira wrote:
> Add test cases to reproduce scenarios fixed recently [1] where
> multiqueue and taprio forced their children into enqueueing an skb to
> gso_skb (during peek), but failed to dequeue from gso_skb because they
> called the child's dequeue callback directly. This causes a desync in the
> child's qlen/backlog and results in an eventual null-ptr-deref (with a
> qfq or dualpi2 child).
> 
> Test cases are the following:
> 
> - Force multiq to dequeue from its child's gso_skb with qfq leaf (fb6c)
> - Force multiq to dequeue from its child's gso_skb with dualpi2 leaf (1922)
> - Force taprio to dequeue from its child's gso_skb with qfq leaf (476f)
> - Force taprio to dequeue from its child's gso_skb with dualpi2 leaf (0235)
> 
> [1] https://lore.kernel.org/netdev/20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me/
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
>   .../tc-testing/tc-tests/infra/qdiscs.json     | 164 ++++++++++++++++++
>   1 file changed, 164 insertions(+)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> index a1f97a4b606e..0cf12c50fb74 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> @@ -1540,5 +1540,169 @@
>               "$TC qdisc del dev $DUMMY root",
>               "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
>           ]
> +    },
> +    {
> +        "id": "fb6c",
> +        "name": "Force multiq to dequeue from its child's gso_skb with qfq leaf",
> +        "category": [
> +            "qdisc",
> +            "tbf",
> +            "multiq",
> +            "qfq"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
> +            "$IP link set dev $ETH up || true",
> +            "$IP l set addr 01:02:03:04:05:06 dev $ETH || true",
> +            "$IP n add dev $ETH 10.10.11.1 lladdr 01:02:03:04:05:06 dev $ETH || true",
> +            "$IP addr add 10.10.11.10/24 dev $ETH || true",
> +            "$TC qdisc add dev $ETH root handle 1: tbf rate 88bit burst 1661b peakrate 2257333 minburst 1024 limit 7b",
> +            "$TC qdisc add dev $ETH parent 1: handle 2: multiq",
> +            "$TC qdisc add dev $ETH parent 2:1 handle 3: qfq",
> +            "$TC class add dev $ETH classid 3:1 parent 3: qfq maxpkt 512 weight 1",
> +            "$TC filter add dev $ETH parent 2: protocol all prio 1 matchall action skbedit queue_mapping 0",
> +            "$TC filter add dev $ETH parent 3: protocol all prio 1 matchall classid 3:1 action ok"
> +        ],
> +        "cmdUnderTest": "ping -c 1 10.10.11.1 -W0.01 -I$ETH || true",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -s -j qdisc ls dev $ETH parent 1:",
> +        "matchJSON": [
> +            {
> +                "kind": "multiq",
> +                "handle": "2:",
> +                "bytes": 98,
> +                "packets": 1,
> +                "backlog": 0,
> +                "qlen": 0
> +            }
> +        ],
> +        "teardown": [
> +            "$TC qdisc del dev $ETH handle 1: root",
> +            "echo \"1\" > /sys/bus/netdevsim/del_device"
> +        ]
> +    },
> +    {
> +        "id": "1922",
> +        "name": "Force multiq to dequeue from its child's gso_skb with dualpi2 leaf",
> +        "category": [
> +            "qdisc",
> +            "tbf",
> +            "multiq",
> +            "dualpi2"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
> +            "$IP link set dev $ETH up || true",
> +            "$IP l set addr 01:02:03:04:05:06 dev $ETH || true",
> +            "$IP n add dev $ETH 10.10.11.1 lladdr 01:02:03:04:05:06 dev $ETH || true",
> +            "$IP addr add 10.10.11.10/24 dev $ETH || true",
> +            "$TC qdisc add dev $ETH root handle 1: tbf rate 88bit burst 1661b peakrate 2257333 minburst 1024 limit 7b",
> +            "$TC qdisc add dev $ETH parent 1: handle 2: multiq",
> +            "$TC qdisc add dev $ETH parent 2:1 handle 3: dualpi2",
> +            "$TC filter add dev $ETH parent 2: protocol ip prio 1 u32 match ip dst 10.10.11.1 action skbedit queue_mapping 0",
> +            "$TC filter add dev $ETH parent 3: protocol ip prio 1 u32 match ip dst 10.10.11.1 classid 3:1 action ok"
> +        ],
> +        "cmdUnderTest": "ping -c 1 10.10.11.1 -W0.01 -I$ETH || true",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -j -s qdisc ls dev $ETH handle 3:",
> +        "matchJSON": [
> +            {
> +                "kind": "dualpi2",
> +                "handle": "3:",
> +                "bytes": 98,
> +                "packets": 1,
> +                "backlog": 0,
> +                "qlen": 0
> +            }
> +        ],
> +        "teardown": [
> +            "$TC qdisc del dev $ETH handle 1: root",
> +            "echo \"1\" > /sys/bus/netdevsim/del_device"
> +        ]
> +    },
> +    {
> +        "id": "476f",
> +        "name": "Force taprio to dequeue from its child's gso_skb with qfq leaf",
> +        "category": [
> +            "qdisc",
> +            "tbf",
> +            "multiq",
> +            "qfq"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
> +            "$IP link set dev $ETH up || true",
> +            "$IP l set addr 01:02:03:04:05:06 dev $ETH || true",
> +            "$IP n add dev $ETH 10.10.11.1 lladdr 01:02:03:04:05:06 dev $ETH || true",
> +            "$TC qdisc add dev $ETH root handle 1: taprio num_tc 2 map 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 queues 1@0 1@1 base-time 9000000000000000000 sched-entry S 03 200000 flags 0x0 clockid CLOCK_TAI",
> +            "$TC qdisc add dev $ETH parent 1:1 handle 3: qfq",
> +            "$TC class add dev $ETH classid 3:1 parent 3: qfq maxpkt 512 weight 1",
> +            "$TC filter add dev $ETH parent 3: protocol all prio 1 matchall classid 3:1 action ok"
> +        ],
> +        "cmdUnderTest": "ping -c 1 10.10.11.1 -W0.01 -I$ETH || true",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -s -j qdisc ls dev $ETH",
> +        "matchJSON": [
> +            {
> +                "kind": "taprio",
> +                "handle": "1:",
> +                "bytes": 98,
> +                "packets": 1,
> +                "backlog": 0,
> +                "qlen": 0
> +            }
> +        ],
> +        "teardown": [
> +            "$TC qdisc del dev $ETH handle 1: root",
> +            "echo \"1\" > /sys/bus/netdevsim/del_device"
> +        ]
> +    },
> +    {
> +        "id": "0235",
> +        "name": "Force taprio to dequeue from its child's gso_skb with dualpi2 leaf",
> +        "category": [
> +            "qdisc",
> +            "tbf",
> +            "taprio",
> +            "dualpi2"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
> +            "$IP link set dev $ETH up || true",
> +            "$IP l set addr 01:02:03:04:05:06 dev $ETH || true",
> +            "$IP n add dev $ETH 10.10.11.1 lladdr 01:02:03:04:05:06 dev $ETH || true",
> +            "$TC qdisc add dev $ETH root handle 1: taprio num_tc 2 map 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 queues 1@0 1@1 base-time 9000000000000000000 sched-entry S 03 200000 flags 0x0 clockid CLOCK_TAI",
> +            "$TC qdisc replace dev $ETH parent 1:1 handle 3: dualpi2",
> +            "$TC filter add dev $ETH parent 3: protocol ip prio 1 u32 match ip dst 10.10.11.1 classid 3:1 action ok"
> +        ],
> +        "cmdUnderTest": "ping -c 1 10.10.11.1 -W0.01 -I$ETH || true",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -j -s qdisc ls dev $ETH handle 3:",
> +        "matchJSON": [
> +            {
> +                "kind": "dualpi2",
> +                "handle": "3:",
> +                "bytes": 98,
> +                "packets": 1,
> +                "backlog": 0,
> +                "qlen": 0
> +            }
> +        ],
> +        "teardown": [
> +            "$TC qdisc del dev $ETH handle 1: root",
> +            "echo \"1\" > /sys/bus/netdevsim/del_device"
> +        ]
>       }
>   ]


