Return-Path: <netdev+bounces-274379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDObFvQGzmnpkQYAu9opvQ
	(envelope-from <netdev+bounces-274379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:04:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D708C384446
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E110A3037F15
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 06:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35D937C917;
	Thu,  2 Apr 2026 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J4YIKq0s"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583A3264D2
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109795; cv=none; b=BGUePoJ0ZgYiKx622ejSbUw5VkDUQtK4ZaMJyG+hAbtwbdtQNjyeG3GDvwBDyJboykzVMf08XUsKgoxRV7mfyvJJGNZNjf5mT9VRdTrCldbv4gUrgYeu6vPh807dxF6l1REsaY+AQQTQIx5Xgg0On4h0vGFcp9cBeac4hH/0JgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109795; c=relaxed/simple;
	bh=5r13J6OybuNRUXFTInteQCtWxGnSgEkgkKGM9ySWNIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AB/DivoVqKRagWGbC9HnNuaSk4Ldivvo1ssR+LLtnhR7ohGk70uZ/5HpiMeat0Ijmqljr2cRUEo1WE9Mw0aAB/d4zKuHVXMKdKGQW0uhw3fN1c9dRI/zsZ9HAsH6pQMotQ/VbvWwyW79RR+oPlOIOvSK2gVXkh2yFCsXSnBo+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J4YIKq0s; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f64c57ad-c162-480e-910a-e7a5a3460104@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775109781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp2Uz55WPBdKd3AM7qNmo54xU5IrnaTOu8LTItTYIug=;
	b=J4YIKq0s4cYP92JAKqv6aRvi6n9JlpQAHEgGtKGWqKyMQ4ruZRQ+s0xty0oQsenkcyAyJm
	6Z0/2DmQL1cdqwnEtlJcvRgt7fm/OlBzPi27EC9RnFUIyJDtrmHBreVstCB54hKY7P6hX8
	XTsMvabMGofpgbRNwIF83N0FnxVPFkQ=
Date: Thu, 2 Apr 2026 14:02:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] udp_bpf: fix use-after-free in udp_bpf_recvmsg()
To: Deepanshu Kartikey <kartikey406@gmail.com>, john.fastabend@gmail.com,
 jakub@cloudflare.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: ast@kernel.org, cong.wang@bytedance.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
References: <20260402050928.32946-1-kartikey406@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260402050928.32946-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274379-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,davemloft.net,kernel.org,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,431f9a9e3f5227fbb904];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: D708C384446
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/2/26 1:09 PM, Deepanshu Kartikey wrote:
> udp_bpf_recvmsg() calls sk_msg_recvmsg() without holding lock_sock(),
> unlike tcp_bpf_recvmsg() which properly acquires lock_sock() before
> calling __sk_msg_recvmsg(). This allows concurrent tasks to race inside
> sk_msg_recvmsg() on the same psock ingress queue, where one task can
> free msg_rx via kfree_sk_msg() while another task is still reading it
> via sk_msg_elem(), causing a slab-use-after-free.
>
> Fix this by adding lock_sock()/release_sock() around the sk_msg_recvmsg()
> path in udp_bpf_recvmsg(), consistent with tcp_bpf_recvmsg(). Also make
> udp_msg_wait_data() release lock_sock() before sleeping and reacquire it
> after waking, so it can be called with the socket lock held, consistent
> with how tcp_msg_wait_data() uses sk_wait_event() which does the same
> internally.
>
> Note: syzbot testing shows a separate pre-existing warning:
>    sk->sk_forward_alloc
>    WARNING: net/ipv4/af_inet.c:162 inet_sock_destruct
> This warning triggers from the idle CPU path (pv_native_safe_halt)
> and is unrelated to this patch. It appears to be a pre-existing
> memory accounting issue in the UDP sockmap path that requires
> separate investigation.
>
>
> Reported-by: syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=431f9a9e3f5227fbb904
> Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>   net/ipv4/udp_bpf.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 9f33b07b1481..f924b255cee6 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -50,7 +50,9 @@ static int udp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
>   	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>   	ret = udp_msg_has_data(sk, psock);
>   	if (!ret) {
> +		release_sock(sk);
>   		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> +		lock_sock(sk);
>   		ret = udp_msg_has_data(sk, psock);
>   	}
>   	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> @@ -79,6 +81,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>   		goto out;
>   	}
>   
> +	lock_sock(sk);
>   msg_bytes_ready:
>   	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
>   	if (!copied) {
> @@ -90,12 +93,14 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>   		if (data) {
>   			if (psock_has_data(psock))
>   				goto msg_bytes_ready;
> +			release_sock(sk);
>   			ret = sk_udp_recvmsg(sk, msg, len, flags);
>   			goto out;
>   		}
>   		copied = -EAGAIN;
>   	}
>   	ret = copied;
> +	release_sock(sk);
>   out:
>   	sk_psock_put(sk, psock);
>   	return ret;

Kuniyuki  is already working on this. Please see the
existing discussion.

https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/



