Return-Path: <netdev+bounces-289458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D4qGRtiDGpXggUAu9opvQ
	(envelope-from <netdev+bounces-289458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:14:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EB057F617
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD86730791C6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A74034040D;
	Tue, 19 May 2026 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="kwXBGbji"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1D73403FC
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195977; cv=none; b=t9XpMAJDqOuz+GoggrmJIxHY/vFhYX8LmI9Dl0WLCI6Key4DMPoPW7RYUmZfZLxT5cfwT3csvdH/DUROm+EZuNEhE90UK6TpzFBQRj8S9XCK2vNkiQGzLTbiHyWBHZXckY807E9L9+K9mYDPX8M6Kdcn20xJ/oF/C0WHfM5kY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195977; c=relaxed/simple;
	bh=cg4z7G7iNBSO9WPLaSxyK3mhnsTtEoKLiHUito40w9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhgS6friacAMzPZoSAxeD9BEi0pDbxMFkaU8JK5nZs74eyMBZSRv/YnT6CkS411kFLTGuNrwEFRnv7ZoLGgHoaAN6NlFS7jJ/77qdfcIvQ5GAGL1gN8GmjlzM5rRJ12MuQEwkGl2kilyg1lcvBNjwehb3EUjDi4Pm8iSlJYzmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=kwXBGbji; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8fbe18b1dso6017406e87.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1779195974; x=1779800774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mBDmsIRaLxU1htRPlExjpxjIYZQeUV/LcGzok6vPGGI=;
        b=kwXBGbjiqKL80cPycnq0bJj0qNvwKq+TrenGRUW0bjWmNDdZhDsHgxuYXhzEL9tZQN
         q7Liw5l6DLYZdsD4Azs/D3o4r0stvUnvR0Hgpt+rosIX+B1lIEOT/IKAW2gHwnUMRgft
         1euULnig2fCtGImNof/t+O/M+XZ23xnZ9fbNr3Z0k0olPbeFsgpWDuUW1l76AiUy+56L
         g/HDaOZu8IovYijPLhxGCfiJacQYxIK+ihL+UqPK66aeDEMpRL0/V1cUQZhj3G3krWpJ
         a6lV/S7IzdtS+Hb+gPiquLG2HAgB/jYTJIEK9sq5GmKT/o00lytsDX/rNFdemZyXYEEZ
         YjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779195974; x=1779800774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBDmsIRaLxU1htRPlExjpxjIYZQeUV/LcGzok6vPGGI=;
        b=V9wuVjzF1ndowA6GZN8CwBUI7Hv6X4zpL7+MzuJ7rYzyk2iTsZMidiSgY8kw3JfL5D
         LVK2ydwq9TXHFShT9NApPBTpMlJY8J0FXkvAO5ULUH2ZEYbqg/QA8cG49PdEUp1BN039
         +5AAqq1P/+8ipa+7woNjM0Ymyl82T77Vn6n1SmML6CcgpqiYlWK3EYz+A01FTwnaUW8S
         n0QNh91c4LQB71BKlIliu1cKehRfoorgNmdVJxz2oNu+p2cKixI5RNP7taXSgJRzSg0C
         E11kEvERHp5OjyUuPKJw5qq6vcw1LFiidc+FQw5vaCKcN0FTu6LO+U2h4QRzgNmACZl1
         /CsQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Vt0Kb0xjDzuR82rtRpCw5FMFDAkuBYlvjxbX1amAKwQRpQBGWdeAIDoBhnOGFrlIOa1YXEB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2cEl3lzk1hIdnfT9QhzBQBZ9LuUDVWO0iitdH6nG0ZPZ2Qxei
	RS2sIXzfjEg3PRSR4aVct5Bb2HkQXp2/M+3ik/ZALXMGo3IsaJjNFXZ+N3Bhh5Z/mX8mpjBIRnn
	euCoh
X-Gm-Gg: Acq92OEBV1/zKKydIEr2hk5wdtngM9WIE1rEoBAsHn5BcItkBacAjlVNYTb//Uhp7cT
	GNswWyHW+RdAgKhv86uUibevWENPGRCPGB5TgOf19Hq/MACTlBMoWN6lgXyMXAkA7Mzh5vxtrTQ
	6+XUEQBj+XrDgThWhTG54XwGV+rEqiIYnH7Q7OKUucstw+7gQepQMSYIeRcobbMlZswpMX5KO4T
	6JNPJDV7VjTERWTnoKDEJKNnJuz0W1+1oQ7iMNo3/XvcfmsvakQtAIoTzsCNxXCNohCvdSWmmln
	0FnLDykFTqWbJ/EpOwKUS6BtADeoBJ02LrxgkcN0kGrr5KFFqKPyM4Qw5A/1xYkOyEU+QqMjrVP
	M6jKq26j8lG/421FN5UbIvWX3GJDjefFSFc63nGBHuRI2AZhEwqTGzhgRw1qIigd0fGmjIkEf0F
	5cnNQf2CJKPZaGVNJO4ffj4WNNQZK/G2ki24wdLzSmLA==
X-Received: by 2002:a05:6512:1321:b0:5a8:8df1:61bf with SMTP id 2adb3069b0e04-5aa0e763a62mr5665485e87.21.1779195973589;
        Tue, 19 May 2026 06:06:13 -0700 (PDT)
Received: from localhost ([176.111.181.159])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164c5a36sm4124074e87.60.2026.05.19.06.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:06:13 -0700 (PDT)
Date: Tue, 19 May 2026 16:06:06 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next] net: bridge: remove stale rcu_barrier() in
 br_multicast_dev_del()
Message-ID: <agxgPqDGkXspLZzJ@penguin>
References: <20260519095540.2643318-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519095540.2643318-1-edumazet@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289458-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,nvidia.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,blackwall.org:email,blackwall.org:dkim]
X-Rspamd-Queue-Id: D2EB057F617
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 09:55:40AM +0000, Eric Dumazet wrote:
> This rcu_barrier() came from a time call_rcu() calls were used in
> net/bridge/br_multicast.c.
> 
> Now kfree_rcu() is there, we can remove this problematic rcu_barrier()
> which causes extreme RTNL pressure in many syzbot reports.
> 
> INFO: task syz-executor:77945 is blocked on a mutex likely owned by task kworker/u1024:5:36537.
> task:kworker/u1024:5 state:D stack:24616 pid:36537 tgid:36537 ppid:2      task_flags:0x4208060 flags:0x00080000 last_sleep:612797637337
> Workqueue: netns cleanup_net
> Call Trace:
>  <TASK>
>   [<ffffffff81914eaa>] context_switch+0xf2a/0x1730 kernel/sched/core.c:6483
>   [<ffffffff81201143>] __schedule+0x1133/0x43a0 kernel/sched/core.c:8411
>   [<ffffffff8120446b>] __schedule_loop kernel/sched/core.c:8514 [inline]
>   [<ffffffff8120446b>] schedule+0xab/0x260 kernel/sched/core.c:8529
>   [<ffffffff8121a093>] schedule_timeout+0xc3/0x2b0 kernel/time/sleep_timeout.c:75
>   [<ffffffff81205347>] do_wait_for_common kernel/sched/completion.c:100 [inline]
>   [<ffffffff81205347>] __wait_for_common kernel/sched/completion.c:121 [inline]
>   [<ffffffff81205347>] wait_for_common kernel/sched/completion.c:132 [inline]
>   [<ffffffff81205347>] wait_for_completion+0x2c7/0x5d0 kernel/sched/completion.c:153
>   [<ffffffff81b8f27f>] rcu_barrier+0x49f/0x620 kernel/rcu/tree.c:3888
>   [<ffffffff860091b3>] br_multicast_dev_del+0x303/0x350 net/bridge/br_multicast.c:4459
>   [<ffffffff85fb5dbc>] br_dev_uninit+0x1c/0x40 net/bridge/br_device.c:157
>   [<ffffffff8568058c>] unregister_netdevice_many_notify+0x1c1c/0x2300 net/core/dev.c:12599
>   [<ffffffff8562be43>] ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
>   [<ffffffff8562be43>] ops_undo_list+0x3d3/0x940 net/core/net_namespace.c:248
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 49ceea3ff9742d3043ac605d656b7fcf37dbcb96..8efa3add5d47508fb2b032ff6238ffbbabfd27ad 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4453,8 +4453,6 @@ void br_multicast_dev_del(struct net_bridge *br)
>  	br_multicast_ctx_deinit(&br->multicast_ctx);
>  	br_multicast_gc(&deleted_head);
>  	cancel_work_sync(&br->mcast_gc_work);
> -
> -	rcu_barrier();
>  }
>  
>  int br_multicast_set_router(struct net_bridge_mcast *brmctx, unsigned long val)
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

