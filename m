Return-Path: <netdev+bounces-274969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIyLGjCJz2l1xAYAu9opvQ
	(envelope-from <netdev+bounces-274969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:32:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5C392CE0
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB16330086EE
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB1134753A;
	Fri,  3 Apr 2026 09:28:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8A3659F9;
	Fri,  3 Apr 2026 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775208499; cv=none; b=nAYqjSTwVcSYXNSdcnQLcwrU2JLjGmb0zJmYbzGzWEAHdRjajdsdyy/a/LCD7Pg4wsgLbiOMkX8uXzY9an2rABPsQHVUSXtN9808hnswmWIwplGVxj0AVjU+bttFrBQ0rrn1g1p7A9cDR1cQuoFyO7z+IMxuHRDeBn7774P8Kg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775208499; c=relaxed/simple;
	bh=eM6lPZsI9eULDa+VvkYdRZUM0w398vBs7N4n2w1aYS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u64gtD5oiK7QdX3KzsHq6L2f38LqUhE5fILodbI+y7gKzRjleP3yK5i1ZXCLZToyxFR7HMRbMfozUv6Zc+kbZnpXxhCxIy/2fd278RHLpDuXFZW3oEAHLXXmGUNg43+hXijMK+8EYClQW4R8LPllDpRwhAzB8G0TMLXHsc3WCuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p57bd9728.dip0.t-ipconnect.de [87.189.151.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E3D164C2C37D58;
	Fri, 03 Apr 2026 11:27:32 +0200 (CEST)
Message-ID: <fa0cd4e5-33f4-41db-a186-853ea39613cd@molgen.mpg.de>
Date: Fri, 3 Apr 2026 11:27:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Bluetooth: serialize accept_q access
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, yuantan098@gmail.com,
 bird@lzu.edu.cn, enjou1224z@gmail.com, wangjiexun2025@gmail.com
References: <cover.1774454568.git.wangjiexun2025@gmail.com>
 <06a6b4549acba207847ce532dedbf1c95ab22d13.1774925231.git.wangjiexun2025@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <06a6b4549acba207847ce532dedbf1c95ab22d13.1774925231.git.wangjiexun2025@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274969-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lzu.edu.cn];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.054];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0F5C392CE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Ren,


Thank you for your patch.

Am 03.04.26 um 10:05 schrieb Ren Wei:
> From: Jiexun Wang <wangjiexun2025@gmail.com>
> 
> bt_sock_poll() walks the accept queue without synchronization, while
> child teardown can unlink the same socket and drop its last reference.
> 
> Protect accept_q with a dedicated lock for queue updates and polling.
> Also rework bt_accept_dequeue() to take temporary child references under
> the queue lock before dropping it and locking the child socket.
> 
> Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> Changes in v2:
> - add Tested-by: Ren Wei <enjou1224z@gmail.com>
> - resend to the public Bluetooth/netdev lists
> 
>   include/net/bluetooth/bluetooth.h |  1 +
>   net/bluetooth/af_bluetooth.c      | 85 +++++++++++++++++++++++--------
>   2 files changed, 66 insertions(+), 20 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 69eed69f7f26..3faea66b1979 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -398,6 +398,7 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src);
>   struct bt_sock {
>   	struct sock sk;
>   	struct list_head accept_q;
> +	spinlock_t accept_q_lock; /* protects accept_q */
>   	struct sock *parent;
>   	unsigned long flags;
>   	void (*skb_msg_name)(struct sk_buff *, void *, int *);
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 2b94e2077203..f44e1ecc83d8 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -154,6 +154,7 @@ struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
>   
>   	sock_init_data(sock, sk);
>   	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
> +	spin_lock_init(&bt_sk(sk)->accept_q_lock);
>   
>   	sock_reset_flag(sk, SOCK_ZAPPED);
>   
> @@ -214,6 +215,7 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
>   {
>   	const struct cred *old_cred;
>   	struct pid *old_pid;
> +	struct bt_sock *par = bt_sk(parent);
>   
>   	BT_DBG("parent %p, sk %p", parent, sk);
>   
> @@ -224,9 +226,12 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
>   	else
>   		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>   
> -	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
>   	bt_sk(sk)->parent = parent;
>   
> +	spin_lock_bh(&par->accept_q_lock);
> +	list_add_tail(&bt_sk(sk)->accept_q, &par->accept_q);
> +	spin_unlock_bh(&par->accept_q_lock);
> +
>   	/* Copy credentials from parent since for incoming connections the
>   	 * socket is allocated by the kernel.
>   	 */
> @@ -254,45 +259,73 @@ EXPORT_SYMBOL(bt_accept_enqueue);
>    */
>   void bt_accept_unlink(struct sock *sk)
>   {
> +	struct sock *parent = bt_sk(sk)->parent;
> +
>   	BT_DBG("sk %p state %d", sk, sk->sk_state);
>   
> +	spin_lock_bh(&bt_sk(parent)->accept_q_lock);
>   	list_del_init(&bt_sk(sk)->accept_q);
> -	sk_acceptq_removed(bt_sk(sk)->parent);
> +	spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
> +
> +	sk_acceptq_removed(parent);
>   	bt_sk(sk)->parent = NULL;
>   	sock_put(sk);
>   }
>   EXPORT_SYMBOL(bt_accept_unlink);
>   
> +static struct sock *bt_accept_get(struct sock *parent, struct sock *sk)
> +{
> +	struct bt_sock *bt = bt_sk(parent);
> +	struct sock *next = NULL;
> +
> +	/* accept_q is modified from child teardown paths too, so take a
> +	 * temporary reference before dropping the queue lock.
> +	 */
> +	spin_lock_bh(&bt->accept_q_lock);
> +
> +	if (sk) {
> +		if (bt_sk(sk)->parent != parent)
> +			goto out;
> +
> +		if (!list_is_last(&bt_sk(sk)->accept_q, &bt->accept_q)) {
> +			next = &list_next_entry(bt_sk(sk), accept_q)->sk;
> +			sock_hold(next);
> +		}
> +	} else if (!list_empty(&bt->accept_q)) {
> +		next = &list_first_entry(&bt->accept_q,
> +					 struct bt_sock, accept_q)->sk;
> +		sock_hold(next);
> +	}
> +
> +out:
> +	spin_unlock_bh(&bt->accept_q_lock);
> +	return next;
> +}
> +
>   struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
>   {
> -	struct bt_sock *s, *n;
> -	struct sock *sk;
> +	struct sock *sk, *next;
>   
>   	BT_DBG("parent %p", parent);
>   
>   restart:
> -	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
> -		sk = (struct sock *)s;
> -
> +	for (sk = bt_accept_get(parent, NULL); sk; sk = next) {
>   		/* Prevent early freeing of sk due to unlink and sock_kill */
> -		sock_hold(sk);
>   		lock_sock(sk);
>   
>   		/* Check sk has not already been unlinked via
>   		 * bt_accept_unlink() due to serialisation caused by sk locking
>   		 */
> -		if (!bt_sk(sk)->parent) {
> +		if (bt_sk(sk)->parent != parent) {
>   			BT_DBG("sk %p, already unlinked", sk);
>   			release_sock(sk);
>   			sock_put(sk);
>   
> -			/* Restart the loop as sk is no longer in the list
> -			 * and also avoid a potential infinite loop because
> -			 * list_for_each_entry_safe() is not thread safe.
> -			 */
>   			goto restart;
>   		}
>   
> +		next = bt_accept_get(parent, sk);
> +
>   		/* sk is safely in the parent list so reduce reference count */
>   		sock_put(sk);
>   
> @@ -310,6 +343,8 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
>   				sock_graft(sk, newsock);
>   
>   			release_sock(sk);
> +			if (next)
> +				sock_put(next);
>   			return sk;
>   		}
>   
> @@ -518,18 +553,28 @@ EXPORT_SYMBOL(bt_sock_stream_recvmsg);
>   
>   static inline __poll_t bt_accept_poll(struct sock *parent)
>   {
> -	struct bt_sock *s, *n;
> +	struct bt_sock *bt = bt_sk(parent);
> +	struct bt_sock *s;
>   	struct sock *sk;
> +	__poll_t mask = 0;
> +
> +	spin_lock_bh(&bt->accept_q_lock);
> +	list_for_each_entry(s, &bt->accept_q, accept_q) {
> +		int state;
>   
> -	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
>   		sk = (struct sock *)s;
> -		if (sk->sk_state == BT_CONNECTED ||
> -		    (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &&
> -		     sk->sk_state == BT_CONNECT2))
> -			return EPOLLIN | EPOLLRDNORM;
> +		state = READ_ONCE(sk->sk_state);
> +
> +		if (state == BT_CONNECTED ||
> +		    (test_bit(BT_SK_DEFER_SETUP, &bt->flags) &&
> +		     state == BT_CONNECT2)) {
> +			mask = EPOLLIN | EPOLLRDNORM;
> +			break;
> +		}
>   	}
> +	spin_unlock_bh(&bt->accept_q_lock);
>   
> -	return 0;
> +	return mask;
>   }
>   
>   __poll_t bt_sock_poll(struct file *file, struct socket *sock,

Google’s Gemini review service has a comment [1]. Do you think it’s 
valid and related?


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/06a6b4549acba207847ce532dedbf1c95ab22d13.1774925231.git.wangjiexun2025%40gmail.com

