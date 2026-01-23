Return-Path: <netdev+bounces-252977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L8ZEG7rc2llzgAAu9opvQ
	(envelope-from <netdev+bounces-252977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:43:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B0A7AF62
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E983301BF44
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47032F6197;
	Fri, 23 Jan 2026 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rssnGl86"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B45256C70;
	Fri, 23 Jan 2026 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769204586; cv=none; b=fm3fm9wvdQiBdLj+INyDvbuWJOzgTyH34ippxwISBJu/hkQ+7Pjlzw+uosOZgtV2mwJ3X9D2/J34Jhb9TcGYGpb7/n9tJoEbFbkiwOmqD4UPpZd+p2JBwVfe3Cgv/sbnCsCJhoAbv5wOSAn/Mjv82U1OzAwTgjoPMM02y1tsUtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769204586; c=relaxed/simple;
	bh=KheEDbybRqccT4YssL9LzHDPm7tF5WT0v2sGWl6zBxc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J5fdSTSz0v7X933xsHgDTar9b1A6Tff6+woIdYhsIUMaX81vs7xeaT95Ye2/MzBWRMBQebBAsMRk6VALzA6vtB93/8FJh7n9hbK828cUXwu1CenKif42pTgPubv1llT94v+/Ysyd2J1dTpEtpSpfDGsVjhlbcdhtPwEyRjaMjDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rssnGl86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B97C4CEF1;
	Fri, 23 Jan 2026 21:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769204586;
	bh=KheEDbybRqccT4YssL9LzHDPm7tF5WT0v2sGWl6zBxc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=rssnGl86RvKZD83WgWSS3e0Qm1GV6iygavQHn/9Lo5jH+ybnZLtqajqv+yL/r/znc
	 iBaMgd5BRYnPqObJld6zlIzf1UtmSJm9mJhlIYivwBCQEAujrskPSLJvoAHgU00EZL
	 NH+y/P3/xP8DkfEPgCL2AxfvM/NKc/+tLI4DaLdWIapISGPduyckL64TWL1wGgRg48
	 AI6BVZkuMxH3cosb24CVfbQHBo26UN7KVsMCR7LAIh1IH1uWsAHCxPIRn9Q0txy9Vn
	 rM4bvbySyTKOuJBgsbTrE5NtVaVJk4F5p5n2WL89vxAMTTQMmzrmwak1UsaQPDC0Oc
	 sNcxOOYcJResg==
Date: Fri, 23 Jan 2026 13:43:05 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Matthieu Baerts <matttbe@kernel.org>, 
    Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, 
    netdev@vger.kernel.org, mptcp@lists.linux.dev, eric.dumazet@gmail.com, 
    syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com, 
    Eulgyu Kim <eulgyukim@snu.ac.kr>, Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH v2 net] mptcp: fix race in
 mptcp_pm_nl_flush_addrs_doit()
In-Reply-To: <20260123030327.3041148-1-edumazet@google.com>
Message-ID: <36367d05-e05f-c86b-7125-e98b529f9d0c@kernel.org>
References: <20260123030327.3041148-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252977-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,linux.dev,strlen.de,vger.kernel.org,lists.linux.dev,gmail.com,syzkaller.appspotmail.com,snu.ac.kr];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martineau@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5498a510ff9de39d37da];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 63B0A7AF62
X-Rspamd-Action: no action

On Fri, 23 Jan 2026, Eric Dumazet wrote:

> syzbot and Eulgyu Kim reported crashes in mptcp_pm_nl_get_local_id()
> and/or mptcp_pm_nl_is_backup()
>
> Root cause is list_splice_init() in mptcp_pm_nl_flush_addrs_doit()
> which is not RCU ready.
>
> list_splice_init_rcu() can not be called here while holding pernet->lock
> spinlock.
>
> Many thanks to Eulgyu Kim for providing a repro and testing our patches.
>
> Fixes: 141694df6573 ("mptcp: remove address when netlink flushes addrs")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6970a46d.a00a0220.3ad28e.5cf0.GAE@google.com/T/
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Cc: Geliang Tang <geliang@kernel.org>
> ---
> v2: Make sure the list was not empty, return early otherwise.

Thanks Eric, the v2 code changes LGTM. The netdev tooling wasn't able to 
apply the patch 
(https://patchwork.kernel.org/project/netdevbpf/patch/20260123030327.3041148-1-edumazet@google.com/), 
so Matthieu is planning to send a basically-identical v3 that 'git am' and 
the netdev CI will be happy with.

Reviewed-by: Mat Martineau <martineau@kernel.org>

> v1: https://lore.kernel.org/netdev/20260122131306.2119853-1-edumazet@google.com/
>
> net/mptcp/pm_kernel.c | 18 +++++++++++++++---
> 1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 57570a44e4185370f531047fe97ce9f9fbd1480b..af23be6658ded4860133bb9495c7738014815d28 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1294,16 +1294,28 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
> int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
> {
> 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
> -	LIST_HEAD(free_list);
> +	struct list_head free_list;
>
> 	spin_lock_bh(&pernet->lock);
> -	list_splice_init(&pernet->endp_list, &free_list);
> +
> +	free_list = pernet->endp_list;
> +	INIT_LIST_HEAD_RCU(&pernet->endp_list);
> +
> 	__reset_counters(pernet);
> 	pernet->next_id = 1;
> 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> 	spin_unlock_bh(&pernet->lock);
> -	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
> +
> +	if (free_list.next == &pernet->endp_list)
> +		return 0;
> +
> 	synchronize_rcu();
> +
> +	/* Adjust the pointers to free_list instead of pernet->endp_list */
> +	free_list.prev->next = &free_list;
> +	free_list.next->prev = &free_list;
> +
> +	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
> 	__flush_addrs(&free_list);
> 	return 0;
> }
> --
> 2.52.0.457.g6b5491de43-goog
>
>

