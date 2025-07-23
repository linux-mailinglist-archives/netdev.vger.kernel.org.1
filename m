Return-Path: <netdev+bounces-209331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B7B0F2A2
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F92AA4C3B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEBD2E6D1C;
	Wed, 23 Jul 2025 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tx7SheHY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A55D2FF;
	Wed, 23 Jul 2025 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275325; cv=none; b=iknyeT24W08gJ1WmWX+832p/zbZkgQGIKNkrfuGT4wEURaqbHzmIOyjhhFlw6+lGJupaamQTlnaV6BDAGPI3rLCqwCoC6AGr+uT7wNjNx6Nt/qHfKE5T0IeDIgPeLJ2NQ0/RY6/BDZ2EVr9dwSyTqDOSGCZ0869mfGD4qsSxaz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275325; c=relaxed/simple;
	bh=q6UaTmh3DUzTqX540vpF9A2/WnSH1xQl+bmrZyzGJWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOEZ6v1dcH7HzrbuPR+g1aLFOnT52ou3tbkVQv0i04Xos7NLumnKSI3DFLZxDTtW1Yo8jaQWvGN2XqRpvovSMA0LGDpKoQgQs298FTZPls+liwGYfSM7MkrTyQiOEdk0bXD8Uy202YvZlQ04GNdPD9Poi5A6zCLlJN0OvxFdn+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tx7SheHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4F2C4CEE7;
	Wed, 23 Jul 2025 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753275325;
	bh=q6UaTmh3DUzTqX540vpF9A2/WnSH1xQl+bmrZyzGJWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tx7SheHYFhejshYY11lOeIM2jstrFeP/NycPJe3aYBOWngvzkDZNZ0WzlXfZfzMlM
	 huSVlGkH+7jz0dKXHFK6U8UTm69rIU/V6qpTMtd/wPweOig6wkSboPdPkHmuv51Rxp
	 Il2Dm+5ZTN8Ax8aymSfWFiGroRlPv/bnyXRM2jU0WVao5REn5SJGvfaYiYTJKyPmiG
	 6uXr+ULn0VP4ukPTgJZVtEkStDk1sWegvKgoHi98HlKcLsBG+Dy2CiiY9qWZ6S4JgE
	 SgborqPkp3A+QCsukP0yW92UE3GoJ/rzIzJyFXVQVLxrDvOL3N931v0KlUtb71WLWB
	 qn+5goUiUZwCQ==
Date: Wed, 23 Jul 2025 13:55:21 +0100
From: Simon Horman <horms@kernel.org>
To: Maher Azzouzi <maherazz04@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Ferenc Fejes <fejes@inf.elte.hu>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net] net/sched: mqprio: fix stack out-of-bounds write in
 tc entry parsing
Message-ID: <20250723125521.GA2459@horms.kernel.org>
References: <20250722155121.440969-1-maherazz04@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722155121.440969-1-maherazz04@gmail.com>

+ Ferenc and Vladimir

On Tue, Jul 22, 2025 at 04:51:21PM +0100, Maher Azzouzi wrote:
> From: MaherAzzouzi <maherazz04@gmail.com>

nit: space between your names please

> 
> TCA_MQPRIO_TC_ENTRY_INDEX is validated using
> NLA_POLICY_MAX(NLA_U32, TC_QOPT_MAX_QUEUE), which allows the value
> TC_QOPT_MAX_QUEUE (16). This leads to a 4-byte out-of-bounds stack write in
> the fp[] array, which only has room for 16 elements (0–15).
> 
> Fix this by changing the policy to allow only up to TC_QOPT_MAX_QUEUE - 1.
> 
> Fixes: f62af20bed2d ("net/sched: mqprio: allow per-TC user input of FP adminStatus")
> Reported-by: Maher Azzouzi <maherazz04@gmail.com>

I don't think there is any need to include a Reported-by tag if
you are also the patch author.

> Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>

I agree with your analysis and that this is a good fix.

Reviewed-by: Simon Horman <horms@kernel.org>

I do think it is misleading to name this #define MAX,
but it's part of the UAPI so that ship has sailed.

It seems that taprio has a similar problem, but that it is
not a bug due to an additional check. I wonder if something
like this for net-next is appropriate to align it's implementation
wit that of maprio.

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 2b14c81a87e5..e759e43ad27e 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -998,7 +998,7 @@ static const struct nla_policy entry_policy[TCA_TAPRIO_SCHED_ENTRY_MAX + 1] = {
 
 static const struct nla_policy taprio_tc_policy[TCA_TAPRIO_TC_ENTRY_MAX + 1] = {
 	[TCA_TAPRIO_TC_ENTRY_INDEX]	   = NLA_POLICY_MAX(NLA_U32,
-							    TC_QOPT_MAX_QUEUE),
+							    TC_QOPT_MAX_QUEUE - 1),
 	[TCA_TAPRIO_TC_ENTRY_MAX_SDU]	   = { .type = NLA_U32 },
 	[TCA_TAPRIO_TC_ENTRY_FP]	   = NLA_POLICY_RANGE(NLA_U32,
 							      TC_FP_EXPRESS,
@@ -1698,19 +1698,15 @@ static int taprio_parse_tc_entry(struct Qdisc *sch,
 	if (err < 0)
 		return err;
 
-	if (!tb[TCA_TAPRIO_TC_ENTRY_INDEX]) {
+	if (NL_REQ_ATTR_CHECK(extack, opt, tb, TCA_TAPRIO_TC_ENTRY_INDEX)) {
 		NL_SET_ERR_MSG_MOD(extack, "TC entry index missing");
 		return -EINVAL;
 	}
 
 	tc = nla_get_u32(tb[TCA_TAPRIO_TC_ENTRY_INDEX]);
-	if (tc >= TC_QOPT_MAX_QUEUE) {
-		NL_SET_ERR_MSG_MOD(extack, "TC entry index out of range");
-		return -ERANGE;
-	}
-
 	if (*seen_tcs & BIT(tc)) {
-		NL_SET_ERR_MSG_MOD(extack, "Duplicate TC entry");
+		NL_SET_ERR_MSG_ATTR(extack, tb[TCA_TAPRIO_TC_ENTRY_INDEX],
+				    "Duplicate tc entry");
 		return -EINVAL;
 	}
 

> ---
>  net/sched/sch_mqprio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
> index 51d4013b6121..f3e5ef9a9592 100644
> --- a/net/sched/sch_mqprio.c
> +++ b/net/sched/sch_mqprio.c
> @@ -152,7 +152,7 @@ static int mqprio_parse_opt(struct net_device *dev, struct tc_mqprio_qopt *qopt,
>  static const struct
>  nla_policy mqprio_tc_entry_policy[TCA_MQPRIO_TC_ENTRY_MAX + 1] = {
>       [TCA_MQPRIO_TC_ENTRY_INDEX]     = NLA_POLICY_MAX(NLA_U32,
> -                                                      TC_QOPT_MAX_QUEUE),
> +                                                      TC_QOPT_MAX_QUEUE - 1),
>       [TCA_MQPRIO_TC_ENTRY_FP]        = NLA_POLICY_RANGE(NLA_U32,
>                                                          TC_FP_EXPRESS,
>                                                          TC_FP_PREEMPTIBLE),
> --
> 2.34.1
>


