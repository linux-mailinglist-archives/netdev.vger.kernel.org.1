Return-Path: <netdev+bounces-236737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE27C3F876
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 11:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 831F04E6F03
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D142DA76F;
	Fri,  7 Nov 2025 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBj2yvYC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1AB27E04C;
	Fri,  7 Nov 2025 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511916; cv=none; b=n9Sj5DO2lybIiRP5LJN6xAfVJXGGGx/7UPc9HfufgLgf+5vUyLkuofm7Cx3+THKuYkvw7nMP4z+ZrGaX/UoNLM+csT/3k/sgRlIZPZUol5z1u0m1MxI0uwfhFEYCDA3S0gsJnJa6E+L808Wp34WOvvXAFExFduBWTyQcTzfbWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511916; c=relaxed/simple;
	bh=4E50+Qj3Jfr+7f9QPJHNLQEYMFOr4mV+p23OC58+Oyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPZwh7FkJ2tRtxxvvlyv7hmdWr7CBw8BPWowMZXILWZu+Hrzmyp4RtJgrRRD13yyc4P5wWU3wf8NlLCLT3+iJXfstU01IypDobd8ndIvg6xsXvf0Bb4PtadklB/GDluInJtq232bVMPfk4fJevo6Wkz56PZ3OZUyGk86r2Ev+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBj2yvYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50369C4CEF8;
	Fri,  7 Nov 2025 10:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762511916;
	bh=4E50+Qj3Jfr+7f9QPJHNLQEYMFOr4mV+p23OC58+Oyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBj2yvYCRnwHQH5uvEmerva1XJtVWwrh3N2/eZWKFAvt9r5RpM83/OAyKWnGZdOVk
	 WJjRBy4H0uEnJl2k4mJzAyK/8+4/XlztltHkwZ6oW65lgMsUj9ugCfm8erFazyopdH
	 luxNwhzkS3iAxyy6tyR7yfTL2GBeAqpHF+4OJFbLOws6o+Dtq7LLU3uz5fhEyoQpCK
	 YO6qk0QEfhcO8fdFdJERUFtUkQMczi5h7vB2zJ1EF2uU07i3puiHc6tAQbYKJZnHCX
	 jd4h1fYp8XdkYvT73J4DxuYeRI+Dkwv4Sf8ua0rzsA2Xo0JzgSkUa5DqV4BQF42kFw
	 vpESp5tEo3SCA==
Date: Fri, 7 Nov 2025 10:38:31 +0000
From: Simon Horman <horms@kernel.org>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
	jiri@resnulli.us, kuba@kernel.org, pabeni@redhat.com,
	xiyou.wangcong@gmail.com, david.hunter.linux@gmail.com,
	khalid@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] net: sched: act_connmark: initialize struct
 tc_ife to fix kernel leak
Message-ID: <aQ3MJ3ZPTxJqYPXT@horms.kernel.org>
References: <20251106195635.2438-1-vnranganath.20@gmail.com>
 <20251106195635.2438-2-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106195635.2438-2-vnranganath.20@gmail.com>

On Fri, Nov 07, 2025 at 01:26:33AM +0530, Ranganath V N wrote:
> In tcf_connmark_dump(), the variable 'opt' was partially initialized using a
> designatied initializer. While the padding bytes are reamined
> uninitialized. nla_put() copies the entire structure into a
> netlink message, these uninitialized bytes leaked to userspace.
> 
> Initialize the structure with memset before assigning its fields
> to ensure all members and padding are cleared prior to beign copied.
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>

Hi Ranganath,

Sorry for not noticing in my review of v2, but as this series fixes bugs in
code present in net it should be targeted at net.  This is done by
including net in the subject of each email, like this:

Subject: [PATCh net v3 1/2] ...

And this patch should have a fixes tag (patch 2/2 already has one).

Fixes: 22a5dc0e5e3e ("net: sched: Introduce connmark action")

Also, when posting v4, please be sure to wait until 24h have
elapsed since the posting of v3.

For more information about the above please see
https://docs.kernel.org/process/maintainer-netdev.html

> ---
>  net/sched/act_connmark.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
> index 3e89927d7116..2aaaaee9b6bb 100644
> --- a/net/sched/act_connmark.c
> +++ b/net/sched/act_connmark.c
> @@ -195,13 +195,15 @@ static inline int tcf_connmark_dump(struct sk_buff *skb, struct tc_action *a,
>  	const struct tcf_connmark_info *ci = to_connmark(a);
>  	unsigned char *b = skb_tail_pointer(skb);
>  	const struct tcf_connmark_parms *parms;
> -	struct tc_connmark opt = {
> -		.index   = ci->tcf_index,
> -		.refcnt  = refcount_read(&ci->tcf_refcnt) - ref,
> -		.bindcnt = atomic_read(&ci->tcf_bindcnt) - bind,
> -	};
> +	struct tc_connmark opt;
>  	struct tcf_t t;
>  
> +	memset(&opt, 0, sizeof(opt));
> +
> +	index   = ci->tcf_index;
> +	refcnt  = refcount_read(&ci->tcf_refcnt) - ref;
> +	bindcnt = atomic_read(&ci->tcf_bindcnt) - bind;

I think some editing errors have crept in here,
because the above does not compile: index should be opt.index, ...

> +
>  	rcu_read_lock();
>  	parms = rcu_dereference(ci->parms);

-- 
pw-bot: changes-requested

