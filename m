Return-Path: <netdev+bounces-244250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BBECB2F33
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 13:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC81230DD60F
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8928126BF7;
	Wed, 10 Dec 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9Qxgdhm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC72487BE;
	Wed, 10 Dec 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371102; cv=none; b=ijkENSJXkAoQ0QVL6CFvqYlGeTKecfaWUPaiJ94qATfkGGEGEUCf9peE18mKWa6kGmGM+fJRWysUwDFzvxNwgBah7h2qGLGqe0DjMoroMPaXvbWbQ2vsiKkmw0WNtyPJt7BsTjC6Ma9HRPgWuOVeCVLL/kDV9hRhYNZ3Q3uasxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371102; c=relaxed/simple;
	bh=OrjmTRcggdMeYm0qETsEZkn143g+a+fB0M+4U/KwyiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axCYlAK0jji8lbSZ7OQJRbzYJMw49H+NslL32wiLUQrTFrdL26HJxGZgD28CoSz0R4QJmftFkBCXZCkk3x9zbYKiaBQDg8aSkD77KsPz38R5VS5DhZCMDNbrfXuIZ3Ya0btSYJvOx58gVJq2U7UnooVQxcW8ffsXIhOcyHhQ4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9Qxgdhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A8DC4CEF1;
	Wed, 10 Dec 2025 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765371102;
	bh=OrjmTRcggdMeYm0qETsEZkn143g+a+fB0M+4U/KwyiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9Qxgdhmzs4fYWOmnlbbYdnlp4DVe8ZJvPTIO78B0T+T14fAB71VXH6p45pT4OmCJ
	 tqPCSyZVxYTs5l2sHkcmSvwp1+P1pvGKoi5/ZAHjWiC4SCy8cqa0zegKrq2CSMBQgb
	 r/WrX0S3edB9NqtpJVV0qzkiiDLtHbfJMAD5GSmV+jynbjTJJNO7P5KGFnN2+R1MrZ
	 IxYwcMUlZtz2J5ZXEvn5cpx7w9nAAToFV8DxZvib/CLSI84sUu1+HtW4Bb89lscPqy
	 5HglrcXhJyFQe4E97SIUT/eW7ZOdvBijWelJOygncJi+TzE7phOe2oJ6NUWrQAPxmZ
	 UsxbT6jgNnXEg==
Date: Wed, 10 Dec 2025 12:51:39 +0000
From: Simon Horman <horms@kernel.org>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] team: fix qom_list corruption by using
 list_del_init_rcu()
Message-ID: <aTls21jR6BvTaV-k@horms.kernel.org>
References: <20251210053104.23608-2-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210053104.23608-2-dharanitharan725@gmail.com>

On Wed, Dec 10, 2025 at 05:31:05AM +0000, Dharanitharan R wrote:
> In __team_queue_override_port_del(), repeated deletion of the same port
> using list_del_rcu() could corrupt the RCU-protected qom_list. This
> happens if the function is called multiple times on the same port, for
> example during port removal or team reconfiguration.
> 
> This patch replaces list_del_rcu() with list_del_init_rcu() to:
> 
>   - Ensure safe repeated deletion of the same port
>   - Keep the RCU list consistent
>   - Avoid potential use-after-free and list corruption issues
> 
> Testing:
>   - Syzbot-reported crash is eliminated in testing.
>   - Kernel builds and runs cleanly
> 
> Fixes: 108f9405ce81 ("team: add queue override configuration mechanism")
> Reported-by: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=422806e5f4cce722a71f
> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>

Thanks for addressing my review of v1.
The commit message looks much better to me.

However, I am unable to find the cited commit in net.

And I am still curious about the cause: are you sure it is repeated deletion?

> ---
>  drivers/net/team/team_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 4d5c9ae8f221..d6d724b52dbf 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -823,7 +823,8 @@ static void __team_queue_override_port_del(struct team *team,
>  {
>  	if (!port->queue_id)
>  		return;
> -	list_del_rcu(&port->qom_list);
> +	/* Ensure safe repeated deletion */
> +	list_del_init_rcu(&port->qom_list);

When applied against net this does not compile
as list_del_init_rcu (as opposed to hlist_del_init_rcu) does
not seem to exist in that tree. Am I missing something?

>  }
>  
>  static bool team_queue_override_port_has_gt_prio_than(struct team_port *port,
> -- 
> 2.43.0

-- 
pw-bot: changes-requested

