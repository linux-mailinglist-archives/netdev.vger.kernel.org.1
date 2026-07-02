Return-Path: <netdev+bounces-304030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uCkLMkMgRmqtKQsAu9opvQ
	(envelope-from <netdev+bounces-304030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:24:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A176F4C1A
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:24:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=nzBi+pTz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304030-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304030-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6EDB3002FBA
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 08:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DF82C21E8;
	Thu,  2 Jul 2026 08:19:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC326F2B0
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 08:19:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980359; cv=none; b=sJMimHhMIZJWCa6Ru7MQEs9Ba5U+aB4jn0tnnV6PvB9uR3cFvdwJ9BStZzE0Bh5D0pyEfvX7qRuLwyzNKU1ZNK/Bl9Y42nEBUwZVqbW87GddAsVYO8t5ZLgWCKfOTuCWk5D84OvcMSZIn6qs75G5ozefbcLgZCcRX64rL5w+E0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980359; c=relaxed/simple;
	bh=LTcoPOEiw4rlHi1sMzQp9TpXpMC0Qga5gAG/6qfa/Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWRWy1KVp0R106UQd5sL19Ts+YfJLDdksMXZQ354/Vr84Izk/41VII7HrA5CWJynIX8f/vTmXRHMM/H5xiCpsBXZ92rkJIjVZ/xCVmEo2xN25g9m851wq470zsszVhXO6aLI7wS/yaJOozqY4YsJeDhIzcKN5ClJDLxOrsACN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nzBi+pTz; arc=none smtp.client-ip=91.218.175.177
Message-ID: <166370f4-0b8c-4af4-9fb7-6967828a99bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782980354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/qjIx9DBZ+vWShiSSveQa8m5i8Lw7dPrnCxeEDpsmg=;
	b=nzBi+pTzw3tABsaisQYDrLls5eENT4LbOxbTC1S9EqLDJYKV7IefLUKCOcqz6tXU5T/FyN
	uormnWxDbXfrNMg3vh9b075QGiO/NKed1XLmR3op3HYHbpHOYq2lv9o0PPeybt8VnrKkGM
	DUIJxr96gpwVXAd9trT9gl0FZlFTjyU=
Date: Thu, 2 Jul 2026 16:19:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
To: Norbert Szetei <norbert@doyensec.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Breno Leitao <leitao@debian.org>, Taegu Ha <hataegu0826@gmail.com>,
 Kees Cook <kees@kernel.org>, linux-ppp@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
 netdev@vger.kernel.org
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304030-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:norbert@doyensec.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bigeasy@linutronix.de,m:leitao@debian.org,m:hataegu0826@gmail.com,m:kees@kernel.org,m:linux-ppp@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gnault@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,debian.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5A176F4C1A

Add: Guillaume

On 2026/7/2 at 2:12, Norbert Szetei wrote:
> pppol2tp_recv() runs in the L2TP UDP-encap softirq RX path:
>
>   l2tp_udp_encap_recv() -> l2tp_recv_common() -> pppol2tp_recv()
>     -> ppp_input(&po->chan)
>
> It runs under rcu_read_lock() holding only an l2tp_session reference and
> takes NO reference on the internal PPP channel (struct channel,
> chan->ppp) that ppp_input() dereferences.
>
> The pppox socket is SOCK_RCU_FREE, so 'po' and the embedded ppp_channel
> are RCU-safe.  But the internal struct channel is a separate allocation
> that ppp_release_channel() frees with a plain kfree():
>
>   close(data socket) -> pppol2tp_release() -> pppox_unbind_sock()
>     -> ppp_unregister_channel() -> ppp_release_channel() -> kfree(pch)
>
> For a channel that is bound (PPPIOCGCHAN) but not attached to a ppp unit
> (no PPPIOCCONNECT, pch->ppp == NULL) and not bridged, teardown skips
> both ppp_disconnect_channel()'s synchronize_net() and
> ppp_unbridge_channels()'s synchronize_rcu(), so the kfree() has no grace
> period.  rcu_read_lock() in pppol2tp_recv() does not protect against a
> plain kfree(), so an in-flight ppp_input() on one CPU can dereference
> the channel just freed by close() on another CPU.
>
> The bug is reachable by an unprivileged user.
>
> Defer the channel free to an RCU callback via call_rcu() so the grace
> period fences any in-flight ppp_input(). The disconnect and unbridge
> teardown paths already fence with synchronize_net()/synchronize_rcu();
> call_rcu() does the same here without stalling the close() path.
>
> Fixes: ee40fb2e1eb5 ("l2tp: protect sock pointer of struct pppol2tp_session with RCU")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
> v2:
> - Moved skb_queue_purge() to a dedicated RCU callback to prevent leaking
>    skbs added by an in-flight ppp_input() during the grace period (Sebastian).
> - Retained call_rcu() to avoid introducing synchronous multi-millisecond
>    latency into the teardown path.
> v1: https://lore.kernel.org/netdev/C954A7EA-AA98-4E3C-80B5-42C34B3183A3@doyensec.com/
>
>   drivers/net/ppp/ppp_generic.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 57c68efa5ff8..2d57de77780f 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -184,6 +184,7 @@ struct channel {
>   	struct list_head clist;		/* link in list of channels per unit */
>   	spinlock_t	upl;		/* protects `ppp' and 'bridge' */
>   	struct channel __rcu *bridge;	/* "bridged" ppp channel */
> +	struct rcu_head rcu;		/* for RCU-deferred free of the channel */
>   #ifdef CONFIG_PPP_MULTILINK
>   	u8		avail;		/* flag used in multilink stuff */
>   	u8		had_frag;	/* >= 1 fragments have been sent */
> @@ -3562,6 +3563,18 @@ ppp_disconnect_channel(struct channel *pch)
>   	return err;
>   }
>   
> +/* Purge after the grace period: a late ppp_input() may still queue an
> + * skb on pch->file.rq before the last RCU reader drains.
> + */
> +static void ppp_release_channel_free(struct rcu_head *rcu)
> +{
> +	struct channel *pch = container_of(rcu, struct channel, rcu);
> +
> +	skb_queue_purge(&pch->file.xq);
> +	skb_queue_purge(&pch->file.rq);
> +	kfree(pch);
> +}
> +
>   /*
>    * Drop a reference to a ppp channel and free its memory if the refcount reaches
>    * zero.
> @@ -3581,9 +3594,7 @@ static void ppp_release_channel(struct channel *pch)
>   		pr_err("ppp: destroying undead channel %p !\n", pch);
>   		return;
>   	}
> -	skb_queue_purge(&pch->file.xq);
> -	skb_queue_purge(&pch->file.rq);
> -	kfree(pch);
> +	call_rcu(&pch->rcu, ppp_release_channel_free);
>   }
>   
>   static void __exit ppp_cleanup(void)

Reviewed-by: Qingfang Deng <qingfang.deng@linux.dev>

FYI, I attempted to merge the two channel structs and AI-review found a 
UAF [1], so this patch addresses the issue.

[1] 
https://lore.kernel.org/netdev/590d7931-02b0-45d6-8f43-ef909c9bde89@redhat.com/

Best regards,

Qingfang


