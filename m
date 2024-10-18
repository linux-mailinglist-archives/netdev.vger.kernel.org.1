Return-Path: <netdev+bounces-137031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0049A40EA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B111F2458B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048913C80E;
	Fri, 18 Oct 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLSuyBJN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2153720E30F;
	Fri, 18 Oct 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261036; cv=none; b=god4njQFRXETTet/03/GrzgpTEM9c3LVx+RUDbqstQ/+ZHxF34XUkxilo7J24HIrdhdx6WGqMrBJ2AYknMJo96IppA4bbWWBnfwxDVPIDrRdhqOkLzPHQEOEPWEL6VECleRMT69N2FcHLqi8wycfLd3CYM5nrQb6DcQmXTVokDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261036; c=relaxed/simple;
	bh=8QatYD1USeo6p/RJYPbJf7AP0z42xV4gcApBL5SbZ+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOlTfbnIJGY0gObpgqjzljArNg+78QvInzRA5MA3WfIBxhs6wh8VP/oUxu3kg8TErwzrgauICHbYgCTFKC1rvzhYHi6Dc6wvE3tk8CxdaqbV4mANxbqzXaDUUIEUwSUaJ6HSxdtDfj9FdC5VlqzY9cj2NDEIgYbtFNx03CNZAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLSuyBJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5559C4CEC3;
	Fri, 18 Oct 2024 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729261035;
	bh=8QatYD1USeo6p/RJYPbJf7AP0z42xV4gcApBL5SbZ+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLSuyBJNXDfagM/lJPbLxv8sJlcpChxg1Qk8Vc9uWjYH18XRNoggUVr4S1EaJAZWj
	 cWk6u/wTcktXZIEFtnmYmf/kZ8rr+wMF2JF+VjFI7PfFyIMMsdsIWBW6jQV40x3ot7
	 sH1Iw5GovHw+FypHDriLG5uvv8xVXoODUlQ7qDF5t7bHVPYmaZplb1NrQYuNB8R1R2
	 HwpP9WuULN+Ly+vmld7j5ID8El8Xp0hm6efWgiX8p5PKWFBAvvTeJ8zeaT+NTaxxZg
	 P45Roc7sBHF8Rr1cpiKLZNDQsdU0D93ty05mP9UKuYvWw6m6eG2kMu1149h/lFpKPn
	 +pQxueFC+fZ3A==
Date: Fri, 18 Oct 2024 15:17:10 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Vlad Buslov <vladbu@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Baowen Zheng <baowen.zheng@corigine.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: act_api: deny mismatched skip_sw/skip_hw
 flags for actions created by classifiers
Message-ID: <20241018141710.GO1697@kernel.org>
References: <20241017161049.3570037-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017161049.3570037-1-vladimir.oltean@nxp.com>

On Thu, Oct 17, 2024 at 07:10:48PM +0300, Vladimir Oltean wrote:
> tcf_action_init() has logic for checking mismatches between action and
> filter offload flags (skip_sw/skip_hw). AFAIU, this is intended to run
> on the transition between the new tc_act_bind(flags) returning true (aka
> now gets bound to classifier) and tc_act_bind(act->tcfa_flags) returning
> false (aka action was not bound to classifier before). Otherwise, the
> check is skipped.
> 
> For the case where an action is not standalone, but rather it was
> created by a classifier and is bound to it, tcf_action_init() skips the
> check entirely, and this means it allows mismatched flags to occur.
> 
> Taking the matchall classifier code path as an example (with mirred as
> an action), the reason is the following:
> 
>  1 | mall_change()
>  2 | -> mall_replace_hw_filter()
>  3 |   -> tcf_exts_validate_ex()
>  4 |      -> flags |= TCA_ACT_FLAGS_BIND;
>  5 |      -> tcf_action_init()
>  6 |         -> tcf_action_init_1()
>  7 |            -> a_o->init()
>  8 |               -> tcf_mirred_init()
>  9 |                  -> tcf_idr_create_from_flags()
> 10 |                     -> tcf_idr_create()
> 11 |                        -> p->tcfa_flags = flags;
> 12 |         -> tc_act_bind(flags))
> 13 |         -> tc_act_bind(act->tcfa_flags)
> 
> When invoked from tcf_exts_validate_ex() like matchall does (but other
> classifiers validate their extensions as well), tcf_action_init() runs
> in a call path where "flags" always contains TCA_ACT_FLAGS_BIND (set by
> line 4). So line 12 is always true, and line 13 is always true as well.
> No transition ever takes place, and the check is skipped.
> 
> The code was added in this form in commit c86e0209dc77 ("flow_offload:
> validate flags of filter and actions"), but I'm attributing the blame
> even earlier in that series, to when TCA_ACT_FLAGS_SKIP_HW and
> TCA_ACT_FLAGS_SKIP_SW were added to the UAPI.
> 
> Following the development process of this change, the check did not
> always exist in this form. A change took place between v3 [1] and v4 [2],
> AFAIU due to review feedback that it doesn't make sense for action flags
> to be different than classifier flags. I think I agree with that
> feedback, but it was translated into code that omits enforcing this for
> "classic" actions created at the same time with the filters themselves.
> 
> There are 3 more important cases to discuss. First there is this command:
> 
> $ tc qdisc add dev eth0 clasct
> $ tc filter add dev eth0 ingress matchall skip_sw \
> 	action mirred ingress mirror dev eth1
> 
> which should be allowed, because prior to the concept of dedicated
> action flags, it used to work and it used to mean the action inherited
> the skip_sw/skip_hw flags from the classifier. It's not a mismatch.
> 
> Then we have this command:
> 
> $ tc qdisc add dev eth0 clasct
> $ tc filter add dev eth0 ingress matchall skip_sw \
> 	action mirred ingress mirror dev eth1 skip_hw
> 
> where there is a mismatch and it should be rejected.
> 
> Finally, we have:
> 
> $ tc qdisc add dev eth0 clasct
> $ tc filter add dev eth0 ingress matchall skip_sw \
> 	action mirred ingress mirror dev eth1 skip_sw
> 
> where the offload flags coincide, and this should be treated the same as
> the first command based on inheritance, and accepted.
> 
> [1]: https://lore.kernel.org/netdev/20211028110646.13791-9-simon.horman@corigine.com/
> [2]: https://lore.kernel.org/netdev/20211118130805.23897-10-simon.horman@corigine.com/
> Fixes: 7adc57651211 ("flow_offload: add skip_hw and skip_sw to control if offload the action")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks Vladimir,

This looks like an oversight to me.

Reviewed-by: Simon Horman <horms@kernel.org>

