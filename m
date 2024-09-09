Return-Path: <netdev+bounces-126560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FFF971D6F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD951C23274
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCB7C8DF;
	Mon,  9 Sep 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQN8bNBy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D818E1E;
	Mon,  9 Sep 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894226; cv=none; b=ekVNN/mlBVz4rGqQ9nyq6YTsDH5NKO6gaPJSKUQIjdbm9QzgU2bRzVpocFY9Yb2TGlunmYqahv9m2COVYqkENLGOaN2ydqi34hnfB0igUgw6mXbS1gMLMC7h2yXruoW3TC1kMUyQmNM7ZeYj+QQH30UbtNt/QLJ+SdgsKpaU8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894226; c=relaxed/simple;
	bh=tIrHvceddxIrgzjQBPeAvfyWjeMYXGXpr2nJLG+OICQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+xmsMBu0amUXONXcWC6YNmmElT409fJMYN5x+nAEeZ2u5OYRtuHUCZheeT15mHvtaw1arBeFSk4gmpd3df951ctLLH4r0bNkQHA4nyOngEdoGLt2iezGXnRm1tfaNAeCW4yvnX0YcK6kr/azRiaciQ1IHrRrZ7s+c9c1F7o+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQN8bNBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E9DC4CEC5;
	Mon,  9 Sep 2024 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725894226;
	bh=tIrHvceddxIrgzjQBPeAvfyWjeMYXGXpr2nJLG+OICQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NQN8bNBy9JNeX4VaoLCOXEt6qI5+eKt2pXH1DeMOfiJDnbFNmldamKtDzNmqITXDy
	 XY0+vQ74zGCgwDT8bgHKJONQyb1I6j/oFimp8iZ5IxWUkrU3dgFKD/0ONdUptKAuP7
	 VzsfXYkoOosXbVIpem89o+XlRq+6NHvNO9BpNOjq0dGwELVzFIN1FBNJKD/vXQ5hg5
	 FhMnWDBZscfnhmhMjAaCK+sLKVBTQ36MAtTl3m3kq/lqiKpngmyxJb13K/zSnufOyJ
	 rEMSGr09XAXq2mjLm1k8DF6nK81Y/SaK0UDeUEL3BIiqF+X3rlDSYzuc4gNJMunaI0
	 0Oo5mNySabxlg==
Message-ID: <c332e3f8-3758-43ce-87a7-f1290d9692bc@kernel.org>
Date: Mon, 9 Sep 2024 17:03:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [Patch net] mptcp: initialize sock lock with its own lockdep keys
Content-Language: en-GB
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, Cong Wang <cong.wang@bytedance.com>,
 syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20240908180620.822579-1-xiyou.wangcong@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240908180620.822579-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Cong Wang,

On 08/09/2024 20:06, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> In mptcp_pm_nl_create_listen_socket(), we already initialize mptcp sock
> lock with mptcp_slock_keys and mptcp_keys. But that is not sufficient,
> at least mptcp_init_sock() and mptcp_sk_clone_init() still miss it.
> 
> As reported by syzbot, mptcp_sk_clone_init() is challenging due to that
> sk_clone_lock() immediately locks the new sock after preliminary
> initialization. To fix that, introduce ->init_clone() for struct proto
> and call it right after the sock_lock_init(), so now mptcp sock could
> initialize the sock lock again with its own lockdep keys.

Thank you for this patch!

The fix looks good to me, but I need to double-check if we can avoid
modifying the proto structure. Here is a first review.


From what I understand, it looks like syzbot reported a lockdep false
positive issue, right? In this case, can you clearly mention that in the
commit message, to avoid misinterpretations?

> Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com

checkpatch.pl reports that "Reported-by: should be immediately followed
by Closes: with a URL to the report".

Also, even if it is a false positive, it sounds better to consider this
as a fix, to avoid having new bug reports about that. In this case, can
you please add a "Fixes: <commit>" tag and a "Cc: stable" tag here please?

> Cc: Matthieu Baerts <matttbe@kernel.org>
> Cc: Mat Martineau <martineau@kernel.org>
> Cc: Geliang Tang <geliang@kernel.org>

(If a new version is needed here, feel free to remove the Netdev ML from
the CC list, and only add the MPTCP ML: we can apply this patch on MPTCP
side first, and send it to Netdev later, when it will be ready and
validated)

> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  include/net/sock.h     |  1 +
>  net/core/sock.c        |  2 ++
>  net/mptcp/pm_netlink.c | 18 ++++++++++++------
>  net/mptcp/protocol.c   |  7 +++++++
>  net/mptcp/protocol.h   |  1 +
>  5 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index cce23ac4d514..7032009c0a94 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1226,6 +1226,7 @@ struct proto {
>  	int			(*ioctl)(struct sock *sk, int cmd,
>  					 int *karg);
>  	int			(*init)(struct sock *sk);
> +	void			(*init_clone)(struct sock *sk);
>  	void			(*destroy)(struct sock *sk);
>  	void			(*shutdown)(struct sock *sk, int how);
>  	int			(*setsockopt)(struct sock *sk, int level,
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9abc4fe25953..747d7e479d69 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2325,6 +2325,8 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
>  	}
>  	sk_node_init(&newsk->sk_node);
>  	sock_lock_init(newsk);
> +	if (prot->init_clone)
> +		prot->init_clone(newsk);

If the idea is to introduce a new ->init_clone(), should it not be
called ->lock_init() (or ->init_lock()) and replace the call to
sock_lock_init() when defined?

>  	bh_lock_sock(newsk);
>  	newsk->sk_backlog.head	= newsk->sk_backlog.tail = NULL;
>  	newsk->sk_backlog.len = 0;
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index f891bc714668..5f9f06180c67 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1052,10 +1052,20 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>  static struct lock_class_key mptcp_slock_keys[2];
>  static struct lock_class_key mptcp_keys[2];
>  
> +void mptcp_sock_lock_init(struct sock *sk)

If this helper is used by different parts in MPTCP, I think it would be
better to move it (and the associated keys) to protocol.c: such helper
is not specific to the Netlink path-manager, more to MPTCP in general.

> +{
> +	bool is_ipv6 = sk->sk_family == AF_INET6;
> +
> +	sock_lock_init_class_and_name(sk,
> +				is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
> +				&mptcp_slock_keys[is_ipv6],
> +				is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
> +				&mptcp_keys[is_ipv6]);

The alignment is not OK, and checkpatch.pl is complaining about that.
Can you keep the same indentation as it was before please?

> +}
> +
>  static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>  					    struct mptcp_pm_addr_entry *entry)
>  {
> -	bool is_ipv6 = sk->sk_family == AF_INET6;
>  	int addrlen = sizeof(struct sockaddr_in);
>  	struct sockaddr_storage addr;
>  	struct sock *newsk, *ssk;
> @@ -1077,11 +1087,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>  	 * modifiers in several places, re-init the lock class for the msk
>  	 * socket to an mptcp specific one.
>  	 */

Please also move this comment above to the new mptcp_sock_lock_init()
function.

> -	sock_lock_init_class_and_name(newsk,
> -				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
> -				      &mptcp_slock_keys[is_ipv6],
> -				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
> -				      &mptcp_keys[is_ipv6]);
> +	mptcp_sock_lock_init(newsk);
>  
>  	lock_sock(newsk);
>  	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 37ebcb7640eb..ce68ff4475d0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2839,6 +2839,7 @@ static int mptcp_init_sock(struct sock *sk)
>  	int ret;
>  
>  	__mptcp_init_sock(sk);
> +	mptcp_sock_lock_init(sk);
>  
>  	if (!mptcp_is_enabled(net))
>  		return -ENOPROTOOPT;
> @@ -2865,6 +2866,11 @@ static int mptcp_init_sock(struct sock *sk)
>  	return 0;
>  }
>  
> +static void mptcp_init_clone(struct sock *sk)
> +{
> +	mptcp_sock_lock_init(sk);
> +}
> +
>  static void __mptcp_clear_xmit(struct sock *sk)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -3801,6 +3807,7 @@ static struct proto mptcp_prot = {
>  	.name		= "MPTCP",
>  	.owner		= THIS_MODULE,
>  	.init		= mptcp_init_sock,
> +	.init_clone	= mptcp_init_clone,

If 'mptcp_sock_lock_init()' is moved in this file, and 'init_clone' is
renamed to 'lock_init', maybe directly use 'mptcp_sock_lock_init' here?

>  	.connect	= mptcp_connect,
>  	.disconnect	= mptcp_disconnect,
>  	.close		= mptcp_close,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3b22313d1b86..457c01eac25f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1135,6 +1135,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
>  
>  void __init mptcp_pm_nl_init(void);
>  void mptcp_pm_nl_work(struct mptcp_sock *msk);
> +void mptcp_sock_lock_init(struct sock *sk);

(if the definition is moved to protocol.c, please also move it elsewhere
here, e.g. around mptcp_sk_clone_init())

>  unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
>  unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
>  unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


