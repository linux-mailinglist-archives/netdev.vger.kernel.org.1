Return-Path: <netdev+bounces-71630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3380C854452
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 09:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4289285698
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 08:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6326FD5;
	Wed, 14 Feb 2024 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="go6TjQ2k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4F522E
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900669; cv=none; b=Dbz1xZQ8uY1N1Xl39f8MDVfIbuXA34T++cwl0gGMOLD3uJUYCgyGM+5RE4LVFUNy/448LGE7K0NYSRgJE6Rcr3EanmEj2WDc5A58YNdSuWjZ9g7NSOK1BHB5F/CWQkbwm16OSczkXZXUgtZEeTZzjDhw8C9R5hOewQl/eWK2QNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900669; c=relaxed/simple;
	bh=XAHBpu95F6iz76GDDF4DIp5SqFbTiT3BIYlaFgKo4zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j52osueQ5vh8TPkoZ4sdtvkCI1Fs5r7lPKsjgwGyfBW/fGMnzYCGcVGPhsia166cx5YcFJ/+VEe6G7coGgDwKUrCZ7D7S1FkXUp4PAp5HFWLB/xzyN/gBSsc7TTNfybZ4JYMAaDxewwWZxm7xXI3JEqrCIskY2+dqQu6+DqFLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=go6TjQ2k; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-511972043c3so2204544e87.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 00:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707900664; x=1708505464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mMmIs/bGngTDe4PFUgHEl5eoP7b/3dzx+s9XiukW76w=;
        b=go6TjQ2k+OHZJ5v9UAF9TsL6m7CG/oPpsoJ2/twLJ8nMIuyrjFyjcnRI2wcuL8QSlj
         c/TriQWtbc9re16nY64gVy1prQKxOQcLM/QnPV0q+uaCmXPHdmxA8RRiI0kcOBzP83Hp
         x5xNlEpbk5QZ/gTaKYJWWpjXHERPDIcEkLk/279fS9iRAQuye2QgXyTKs/J6V3DXihKX
         yKPg1xwJe1UO8qT/aV3NyGLdRISxwkNGV3bvevta5ukn3GRpuXy5xGAnQK1V7zxQ50gx
         0XcMIOC7ir4t0gZ1YplcKuZXBQ/J1+JulOuKk0uIPQpQt0CTdlm7HV4sFlojtUzJGxW5
         bNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900664; x=1708505464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMmIs/bGngTDe4PFUgHEl5eoP7b/3dzx+s9XiukW76w=;
        b=mhgdAY7NE1KX6xV5VgHqF4Rf0hdg9nMfQKmXqww4/n3Qr/c3r6Uy14OYdhNY6wflOz
         wS3nAY9YZLIhNc+uikQEuUoGt/Pi2pkBvos+NXncUDRrsZ+7HqEZBUXkzEWt75ZzkaLx
         4iYuoy6A6Og8/7zXQ0zMoOjFFUu/cc6FSsZoo2BPNCDjylA+wwyXdd/xe30lWsdUBQyP
         rchXWE5fvP0tEm0jAPSlmfGdYMIZsw99G1aK1z3VHGggfPgE8u8aMBBytMNkgPQaBsQW
         cbMFbuwjk7I6YkyvfnlyiDB3p5Q3lKP+U0Rt3Nh81WpjBuGgQLbKaNotLlWul6LVEWug
         qozg==
X-Forwarded-Encrypted: i=1; AJvYcCU1q/GWxoh1GsKWOqBUre1lNlOfmVe9x3llpidH4aAlOYI9iJT8HS/++GbMXx/kZL0uZ4Z4aNLVy4ChwGNxFBZWRr/1oBbm
X-Gm-Message-State: AOJu0YxmMPgkkNUkw6bPjp/kvrrBOwhEmvEFt1tLjYRPcNvfBe27uxju
	VQipvbmIv07w4s8wlHf1Vqzqw1csfg1iz+HBpVb4G1yNeE+36L/HCdScGCVubpg=
X-Google-Smtp-Source: AGHT+IHr30/QWHMpbLroxSpzCYVw3mwvI22CHE5fE4ZC+dKIzQ0I2nFOlA43NahVyH5NYOHerDC8iw==
X-Received: by 2002:a05:6512:32b2:b0:511:71fe:87d8 with SMTP id q18-20020a05651232b200b0051171fe87d8mr1648679lfe.38.1707900664308;
        Wed, 14 Feb 2024 00:51:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVst97FGsDaHpF2yqts0eHsfQOzOh+s5X+mpmkq+hYMx68XNyEzMj/25d/t1gGgArBcmlHq8V5f7igGP0rq4XUvmrSDierBBJaWD/5VmBYdB43i0tELCY5ZYBpf7ugpbrsMsPjmLOOcOA19M8yECCm24f9YIvL8siGsYcVkHgSXIC8k690LiQSfeaisv1fJFT3Zr1WXSAQyxM7N5Wbc2OFxKdL8rg5y3JNXXK/H3+DZ/ZUzxBrgi688aIX94WZPeU1XNlcczz5L3E6s6qOYE7RT4Cn7YSx+sI7Zk37UT5YmkudHGBO/mCu7+c2HksYO4OHtKio/cBsY
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c355400b00411e7f702e1sm1138080wmq.30.2024.02.14.00.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:51:03 -0800 (PST)
Date: Wed, 14 Feb 2024 09:51:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, shmulik.ladkani@gmail.com
Subject: Re: [PATCH net v2 1/2] net/sched: act_mirred: use the backlog for
 mirred ingress
Message-ID: <Zcx-9HkcmhDR5_r1@nanopsycho>
References: <20240214033848.981211-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214033848.981211-1-kuba@kernel.org>

Wed, Feb 14, 2024 at 04:38:47AM CET, kuba@kernel.org wrote:
>The test Davide added in commit ca22da2fbd69 ("act_mirred: use the backlog
>for nested calls to mirred ingress") hangs our testing VMs every 10 or so
>runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
>lockdep.
>
>In the past there was a concern that the backlog indirection will
>lead to loss of error reporting / less accurate stats. But the current
>workaround does not seem to address the issue.

Okay, so what the patch actually should change to fix this?


>
>Fixes: 53592b364001 ("net/sched: act_mirred: Implement ingress actions")
>Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>Suggested-by: Davide Caratti <dcaratti@redhat.com>
>Link: https://lore.kernel.org/netdev/33dc43f587ec1388ba456b4915c75f02a8aae226.1663945716.git.dcaratti@redhat.com/
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>CC: jhs@mojatatu.com
>CC: xiyou.wangcong@gmail.com
>CC: jiri@resnulli.us
>CC: shmulik.ladkani@gmail.com
>---
> net/sched/act_mirred.c                             | 14 +++++---------
> .../testing/selftests/net/forwarding/tc_actions.sh |  3 ---
> 2 files changed, 5 insertions(+), 12 deletions(-)
>
>diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>index 0a1a9e40f237..291d47c9eb69 100644
>--- a/net/sched/act_mirred.c
>+++ b/net/sched/act_mirred.c
>@@ -232,18 +232,14 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
> 	return err;
> }
> 
>-static bool is_mirred_nested(void)
>-{
>-	return unlikely(__this_cpu_read(mirred_nest_level) > 1);
>-}
>-
>-static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
>+static int
>+tcf_mirred_forward(bool at_ingress, bool want_ingress, struct sk_buff *skb)
> {
> 	int err;
> 
> 	if (!want_ingress)
> 		err = tcf_dev_queue_xmit(skb, dev_queue_xmit);
>-	else if (is_mirred_nested())
>+	else if (!at_ingress)
> 		err = netif_rx(skb);
> 	else
> 		err = netif_receive_skb(skb);
>@@ -319,9 +315,9 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
> 
> 		skb_set_redirected(skb_to_send, skb_to_send->tc_at_ingress);
> 
>-		err = tcf_mirred_forward(want_ingress, skb_to_send);
>+		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
> 	} else {
>-		err = tcf_mirred_forward(want_ingress, skb_to_send);
>+		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
> 	}
> 
> 	if (err) {
>diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
>index b0f5e55d2d0b..589629636502 100755
>--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
>+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
>@@ -235,9 +235,6 @@ mirred_egress_to_ingress_tcp_test()
> 	check_err $? "didn't mirred redirect ICMP"
> 	tc_check_packets "dev $h1 ingress" 102 10
> 	check_err $? "didn't drop mirred ICMP"
>-	local overlimits=$(tc_rule_stats_get ${h1} 101 egress .overlimits)
>-	test ${overlimits} = 10
>-	check_err $? "wrong overlimits, expected 10 got ${overlimits}"
> 
> 	tc filter del dev $h1 egress protocol ip pref 100 handle 100 flower
> 	tc filter del dev $h1 egress protocol ip pref 101 handle 101 flower
>-- 
>2.43.0
>

