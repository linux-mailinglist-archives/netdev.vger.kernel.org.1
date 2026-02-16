Return-Path: <netdev+bounces-258928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMN9HEhLk2mi3AEAu9opvQ
	(envelope-from <netdev+bounces-258928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:52:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C68FB1466E1
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ED233011F1F
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF626D4F7;
	Mon, 16 Feb 2026 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L/DaVLyx"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B22745C
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771260430; cv=none; b=ARQYC9HiilnSI27Q9RXevq2/xnij/QQwuq1qEVfxM7rOX3w4193nlP2SHJmJZP/qxe3A2oDnQaT4tJPl2XW7BT0Wtd20J/nkKQwlIqMIQqzKfhdHH1yc5qaAQTY/P5BrCeL1u7zkydVlOzMBRD/yITaocBTHpBbzOYL5crctWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771260430; c=relaxed/simple;
	bh=NH/ORJafKqE8Xjp3t2HlIiuhSD7/F+nvBpnBzTFb+CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njNBKRkjZ8K2efo28a1V/znZNcadhxYCkkDViChYG+M2HX/qZucvDv/wkjwyXEP3Wq/cnz0iJxhEc2Mf4BMBG3jNlmsSxPoeFw8gVlzZTm0Dm/d0UtD4Gg/unEiuPWMu+PY5qoK92aI7nlHDyY3L9tjhHteVGunGYzvY4bJZHB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L/DaVLyx; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9130dfca-1e85-4975-8df9-4de8bd9e8f5e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771260426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdD9pE/0fZQNJ5xfjtc3+mrxoWY1xNG6YmN6rfiNq24=;
	b=L/DaVLyxMipunBp5K9rLeAs7p7+V3lAQTWAUc9UpDudA6SbpauO7O99c2qpYHhelZYpdXQ
	X3GC3OH4XyHMBCqFIvn3vJYuuO8EiDmCN8t0zSIqC5ij7BH1IOKdrDlJBLlv3t+z29AKzO
	VNxanF+Mk4Mkniay4RcuRnLD/3eEXTk=
Date: Mon, 16 Feb 2026 16:47:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: Drop the lock in skb_may_tx_timestamp()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Kurt Kanzenbach <kurt@linutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
References: <20260214232456.A37oV4KQ@linutronix.de>
 <willemdebruijn.kernel.1682a93525c87@gmail.com>
 <20260215184608.8dk4hemG@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260215184608.8dk4hemG@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258928-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: C68FB1466E1
X-Rspamd-Action: no action

On 15/02/2026 18:46, Sebastian Andrzej Siewior wrote:
> On 2026-02-14 23:05:27 [-0500], Willem de Bruijn wrote:
>>> --- a/net/core/skbuff.c
>>> +++ b/net/core/skbuff.c
>>> @@ -5555,16 +5555,25 @@ static void __skb_complete_tx_timestamp(struct sk_buff *skb,
>>>   
>>>   static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
>>>   {
>>> -	bool ret;
>>> +	struct socket *sock;
>>> +	struct file *file;
>>>   
>>>   	if (likely(tsonly || READ_ONCE(sock_net(sk)->core.sysctl_tstamp_allow_data)))
>>>   		return true;
>>>   
>>> -	read_lock_bh(&sk->sk_callback_lock);
>>> -	ret = sk->sk_socket && sk->sk_socket->file &&
>>> -	      file_ns_capable(sk->sk_socket->file, &init_user_ns, CAP_NET_RAW);
>>> -	read_unlock_bh(&sk->sk_callback_lock);
>>> -	return ret;
>>> +	/* The sk pointer remains valid as long as the skb is. The sk_socket and
>>> +	 * file pointer may become NULL if the socket is closed. Both structures
>>> +	 * (including file->cred) are RCU freed which means they can be accessed
>>> +	 * within a RCU read section.
>>
>> The fields are not __rcu annotated. Is this common knowledge or is
>> there clear documentation of this behavior? Not disputing it, just not
>> familiar with the rules around these fields.
> 
> The pointer is not RCU annotated because normally, within a syscall, the
> file descriptor does not vanish and so the pointer remains valid. The
> interrupt callback is an exception because we don't hold a reference on
> the fd. But since the underlying data structures have a RCU lifetime we
> could use it.
> 
> sock_alloc() allocates a struct socket_alloc which contains the struct
> socket and struct inode (sock_alloc_inode()). This the sk_socket in
> struct sock. Once you close the socket via the close syscall and the
> last reference is gone then you end up in __fput(). The invoked
> ->release() callback is sock_close(). Here socket::file gets NULLed and
> proto::release should sock_orphan() the sock where sock::sk_socket gets
> NULLed (I don't see where else and packet_release() does so). The
> "struct sock" remains around because the skb has a reference on.
> Otherwise it would go, too.
> 
> Once that is done __fput() does dput() -> __dentry_kill() -> iput() ->
> destroy_inode() which does RCU free the inode.
> That means if we observe the pointer non-NULL we can use it under the
> RCU rules because the inode is released via RCU.
> 
> ->file. At the end of __fput() there is file_free() which releases the
> pointer. file goes to filp_cachep which is SLAB_TYPESAFE_BY_RCU. There
> is a put_cred for file::f_cred before that and it does call_rcu() at the
> end, too.
> 
> This is me reading the code on FRI/ SAT and double checking it with
> ptp4l. I might have missed something but so far, it makes sense.
> 
>> It does seem that updates to sk_socket, in sock_orphan and
>> sock_graft, are protected by sk_callback_lock.
>>> +	 */
>>> +	lockdep_assert_in_rcu_reader();
>>
>> This function can be called from process context outside an RCU read
>> side section, I think.
>>
>> Such as a packet socket sending and hitting the __skb_tstamp_tx
>> SCM_TSTAMP_SCHED at the top of __dev_queue_xmit.
> 
> If that is the case, then we could create a RCU read section here.

well, __dev_queue_xmit() grabs rcu_read_lock_bh() already, we just have
to move it right before timestamping check:

iff --git a/net/core/dev.c b/net/core/dev.c
index ac6bcb2a0784..e9a72da5a214 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4744,15 +4744,15 @@ int __dev_queue_xmit(struct sk_buff *skb, struct 
net_device *sb_dev)
         skb_reset_mac_header(skb);
         skb_assert_len(skb);

-       if (unlikely(skb_shinfo(skb)->tx_flags &
-                    (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
-               __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
-
         /* Disable soft irqs for various locks below. Also
          * stops preemption for RCU.
          */
         rcu_read_lock_bh();

+       if (unlikely(skb_shinfo(skb)->tx_flags &
+                    (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
+               __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
+
         skb_update_prio(skb);

         qdisc_pkt_len_segs_init(skb);

> 
>>> +	sock = READ_ONCE(sk->sk_socket);
>>> +	if (!sock)
>>> +		return false;
>>> +	file = READ_ONCE(sock->file);
>>> +	if (!file)
>>> +		return false;
>>> +	return file_ns_capable(file, &init_user_ns, CAP_NET_RAW);
>>>   }
>>>   
>>>   void skb_complete_tx_timestamp(struct sk_buff *skb,
> 
> Sebastian


