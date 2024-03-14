Return-Path: <netdev+bounces-79852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7888887BC14
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 12:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43A71F243FE
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 11:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DB06CDB5;
	Thu, 14 Mar 2024 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iKJ/2upa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887E6DCF5
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416608; cv=none; b=kKUxO8Zm6N1dpW6aiLt4XQJHCFl+g/tI8OWA5LnNfyF/wpw9hoXA6zaGGunxuDlkPmuY3yu82HY6BBFx+WUpBpL5tm6LzTI+khscbPOM6iemP7tQpV7Y+E5kgA1qbEWemfOO9GY1sm6mYJmD2u+p4LMbM5gWC1oUmATKc2O5XFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416608; c=relaxed/simple;
	bh=uqQEA3v1YBIZcLKhoj1Sa3sBA3/iReVfbg6XDe6D7XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI4tCF4hXOX7MXpH2RPI1VNDEs0cJEq2By8ZNBlYliX4IYU8DUdMEre1+pWGdHzOP++GRXOp+Qbi9ItxfOrkiqwvrsa1C3tTSfZS3zRvMPzyMqRUZAYlUUybowOgOY7DXxyVedbEQ+ZD06g++jG6kAqF7l/CG9AfspNGKYLkBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iKJ/2upa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ec8aa8b6bso315924f8f.3
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710416603; x=1711021403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6Wv0GMXCCyw2lE3RTP2Um54MOrdl+GAvOWIyQ4m0gg=;
        b=iKJ/2upaRuL2gqRUI1CLNxo1ICQpofgayHRxZdLrpJx4bnM58R77C8u3K4NWfRtcf0
         WckCy5iFENFPNcfsnLF2Bvd2+G/J2XXdcSW6CA8zF3hQoMamFwL+MXnaHBlT7jxD/oDW
         xsHYDUR3mqrTVsqjwLwVfYiLMQhSdQBZm5S+p3BhyWycqG3HMCjBtI9vVVpdV15CxLhw
         3yZ/0bmHK2FbSiWO+6wYqzLX2dPVoa27L0A+zxKSWg74VQFBe+Y3GHT6LoxqHtAG/uTG
         bFfqBsQQsbj7uOftJ9CI8w2u8GkmvBKW7Pc1t5EY+eAjiwZdkpzemJCZligwMFfhiXTK
         qiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710416603; x=1711021403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6Wv0GMXCCyw2lE3RTP2Um54MOrdl+GAvOWIyQ4m0gg=;
        b=ONOhLb1au4cHVM9H9ap9J4ZTjryQ6bAYe7O8MdXEtSylxkM81DhOozg5dMrZrwGgtw
         Se055mmh/GMsJECdNehVqjVsoGL4PVjpYRPriejm8vRbVYLt9UKXSjRhe18E5yajgfpD
         PLPMoa+486jEnYOiUz7IUuFDxwgqevbXq6aYuK+DCbk/F+xnnNIDXywF1+MpmtVQ1XGy
         /MotjjCRe0fkS2VsyMmzPl+5AKLMOffgLwKvU8zV62/ayTEb0zLZt2cl0RlGJgtQUll9
         d6gEFlMJA/13zQWKe0GyKmQ+qqUvFr5/7NRD6ArLslAJk0+o7xFErOsfV2+uuTw7Cs/K
         htwg==
X-Forwarded-Encrypted: i=1; AJvYcCUkO+d93KyEe2BrJYazkogcYHDh59MUWoXkuRS3ALAkWGapIS4WVmEKsHGrryp8TGiF0LEHbcFv+seD4X5quY+dOJf1x8gK
X-Gm-Message-State: AOJu0YwS3ygjWEkNVhZ6SkCtvBcEWw+xx2KB8vFlnxPhQJKaVe7BWFkE
	V2xuX6LKEg/cJPEN1MArBfoF+dYgLsRwaAfbBFSr/vhvGxqWB8K1uDDBgoObIIA=
X-Google-Smtp-Source: AGHT+IFfu9s7FJ1G44qgeAL48S/Uo1/Hk6LprqA0p4dcJ6QcYJMntWSsFLJ+rz+oONEID6sC3ZitPA==
X-Received: by 2002:a5d:4c8f:0:b0:33e:c3fd:1442 with SMTP id z15-20020a5d4c8f000000b0033ec3fd1442mr1025719wrs.0.1710416602992;
        Thu, 14 Mar 2024 04:43:22 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k4-20020adfe3c4000000b0033e48db23bdsm566670wrm.100.2024.03.14.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 04:43:22 -0700 (PDT)
Date: Thu, 14 Mar 2024 12:43:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: renmingshuai <renmingshuai@huawei.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
	vladbu@nvidia.com, netdev@vger.kernel.org, yanan@huawei.com,
	liaichun@huawei.com, caowangbao@huawei.com
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
Message-ID: <ZfLi17TuJpcd6KFb@nanopsycho>
References: <20240314111713.5979-1-renmingshuai@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314111713.5979-1-renmingshuai@huawei.com>

Thu, Mar 14, 2024 at 12:17:13PM CET, renmingshuai@huawei.com wrote:
>As we all know the mirred action is used to mirroring or redirecting the
>packet it receives. Howerver, add mirred action to a filter attached to
>a egress qdisc might cause a deadlock. To reproduce the problem, perform
>the following steps:
>(1)tc qdisc add dev eth0 root handle 1: htb default 30 \n
>(2)tc filter add dev eth2 protocol ip prio 2 flower verbose \
>     action police rate 100mbit burst 12m conform-exceed jump 1 \
>     / pipe mirred egress redirect dev eth2 action drop
>
>The stack is show as below:
>[28848.883915]  _raw_spin_lock+0x1e/0x30
>[28848.884367]  __dev_queue_xmit+0x160/0x850
>[28848.884851]  ? 0xffffffffc031906a
>[28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
>[28848.885863]  tcf_action_exec.part.0+0x88/0x130
>[28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
>[28848.886970]  ? dequeue_entity+0x145/0x9e0
>[28848.887464]  ? newidle_balance+0x23f/0x2f0
>[28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables]
>[28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
>[28848.889137]  ? __flush_work.isra.0+0x35/0x80
>[28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_conntrack]
>[28848.890293]  ? do_select+0x637/0x870
>[28848.890735]  tcf_classify+0x52/0xf0
>[28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
>[28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
>[28848.892251]  __dev_queue_xmit+0x2d8/0x850
>[28848.892738]  ? nf_hook_slow+0x3c/0xb0
>[28848.893198]  ip_finish_output2+0x272/0x580
>[28848.893692]  __ip_queue_xmit+0x193/0x420
>[28848.894179]  __tcp_transmit_skb+0x8cc/0x970
>
>In this case, the process has hold the qdisc spin lock in __dev_queue_xmit
>before the egress packets are mirred, and it will attempt to obtain the
>spin lock again after packets are mirred, which cause a deadlock.
>
>Fix the issue by forbidding assigning mirred action to a filter attached
>to the egress.
>
>Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>

You are missing "Fixes" tag.


>---
> net/sched/act_mirred.c                        |  4 +++
> .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++++++++++++++++
> 2 files changed, 36 insertions(+)
>
>diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>index 5b3814365924..fc96705285fb 100644
>--- a/net/sched/act_mirred.c
>+++ b/net/sched/act_mirred.c
>@@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
> 		NL_SET_ERR_MSG_MOD(extack, "Mirred requires attributes to be passed");
> 		return -EINVAL;
> 	}
>+	if (tp->chain->block->q->parent != TC_H_INGRESS) {
>+		NL_SET_ERR_MSG_MOD(extack, "Mirred can only be assigned to the filter attached to ingress");

Hmm, that is quite restrictive. I'm pretty sure you would break some
valid usecases.


>+		return -EINVAL;
>+	}
> 	ret = nla_parse_nested_deprecated(tb, TCA_MIRRED_MAX, nla,
> 					  mirred_policy, extack);
> 	if (ret < 0)
>diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
>index b73bd255ea36..50c6153bf34c 100644
>--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
>+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
>@@ -1052,5 +1052,37 @@
>             "$TC qdisc del dev $DEV1 ingress_block 21 clsact",
>             "$TC actions flush action mirred"
>         ]
>+    },
>+    {
>+        "id": "fdda",
>+        "name": "Add mirred mirror to the filter which attached to engress",
>+        "category": [
>+            "actions",
>+            "mirred"
>+        ],
>+        "plugins": {
>+            "requires": "nsPlugin"
>+        },
>+        "setup": [
>+            [
>+                "$TC actions flush action mirred",
>+                0,
>+                1,
>+                255
>+            ],
>+            [
>+                "$TC qdisc add dev $DEV1 root handle 1: htb default 1",
>+                0
>+            ]
>+        ],
>+        "cmdUnderTest": "$TC filter add dev $DEV1 protocol ip u32 match ip protocol 1 0xff action mirred egress mirror dev $DEV1",
>+        "expExitCode": "2",
>+        "verifyCmd": "$TC action list action mirred",
>+        "matchPattern": "^[ \t]+index [0-9]+ ref",
>+        "matchCount": "0",
>+        "teardown": [
>+            "$TC qdisc del dev $DEV1 root handle 1: htb default 1",
>+            "$TC actions flush action mirred"
>+        ]
>     }
> ]
>-- 
>2.33.0
>
>

