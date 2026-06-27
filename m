Return-Path: <netdev+bounces-302359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 52zPKmdLQGo6egkAu9opvQ
	(envelope-from <netdev+bounces-302359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:15:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1826D2BEA
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:15:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TcAzT8h9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302359-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302359-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DF373012C58
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 22:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AEE36A374;
	Sat, 27 Jun 2026 22:15:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193713A3ED
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 22:14:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782598500; cv=none; b=WgxpOquu58IhWETR8mWWKDMLhqUs3+ckN4v7DtGuNIa5dMgUOyBWoZOHQ95GXAUqkCUy/pfE8KdEGGeJkQ9vFjHCjxQh9bSaEsfbO1Hjn4lnI2jfG9gV9sAMktVxAJhK4POlfIS1zYRQQcOhwwV/Gz/eHQwXAzDOQ6HP8iJXz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782598500; c=relaxed/simple;
	bh=uYkIPmrFsX+U7yRwISuAYVrXjTJyZ2+3oQ+XUoGXEZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GafICJGH/llRA8l9NSvbtiPWBwO94jF7QVpXKfDn7aPyvV4hbQqUjUEIZX5PFJDVhfVCNip6OAu3lYAqhrOY3mJz7uhl9ayBQ0ycBhT1wSzP5JMuV133mUdfFQGi+Jsw/w3hCGFy/bLfDcmpqXB8UIjSB6j7/dqApK7VKxpHcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcAzT8h9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7211F000E9;
	Sat, 27 Jun 2026 22:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782598499;
	bh=Wk/PWikZzI8tkJFohtL1a3rjzub1aBMgnTDQjwUJUEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TcAzT8h9WJy0Bf2CYpvRhJQnAtcIPj4V7fsS1g70PCmm5vlNb0gnS9zRbbtUCGBSL
	 fxl8L87do5Lwj32vwJtgH5ev0JkrAo36Sl0p+cYVfkIr8pum1vhoa29R1Bevw7j/B2
	 B4VtCNIwqBaw2xDowwhXy/vjiv2XEQMX+8yFOikJarRrbfNq8NOT7u71kQCTZeopBd
	 uJ0x3h29l10TTMiCETQl/3cGFOECLfkDpZ47YdVABFJ4GUjGXtneQbtXEjz5dt9dko
	 Dqo1ebM1MDuwhZ8yiLLrdbGs3WTjGvwotUplx51+XZ1EQt5ktVxICeBIn5Pc474fTg
	 DS/8sebogk3kQ==
Date: Sat, 27 Jun 2026 15:14:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, petrm@mellanox.com, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Subject: Re: [PATCH net v2 1/1] net: sched: ets: avoid deficit wrap and
 bound empty dequeue  rounds
Message-ID: <20260627151458.4e5822d9@kernel.org>
In-Reply-To: <0e17a0309061300d31036a6a4c139919192f6373.1782379460.git.bronzed_45_vested@icloud.com>
References: <0e17a0309061300d31036a6a4c139919192f6373.1782379460.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302359-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:petrm@mellanox.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,resnulli.us,davemloft.net,mellanox.com,gmail.com,lzu.edu.cn,icloud.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE1826D2BEA

On Fri, 26 Jun 2026 16:32:00 +0800 Ren Wei wrote:
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
> 
> ETS keeps each DRR-style deficit in a u32 and replenishes it with
> the configured quantum whenever the head packet is too large. Both
> the quantum and qdisc_pkt_len() are user-controlled inputs: a large
> quantum can wrap the deficit counter, while a tiny quantum combined
> with an inflated qdisc_pkt_len() can force billions of iterations in
> softirq context before any packet becomes eligible.

Do you mean when packet is gigabytes in size?
Where do such packets originate?

> Store the deficit in u64 so replenishment cannot wrap the counter.
> This keeps the existing dequeue logic unchanged while fixing the
> overflow condition.
> 
> Bound one dequeue attempt to at most nbands * 2 ETS rotations, as
> suggested in review. This avoids the livelock without adding heavier
> logic to the fast path.
> 
> Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> changes in v2:
>   - Instead of doing a div() in the fast path, simply bound the loop per
>     dequeue
>   - v1 Link: https://lore.kernel.org/all/20260615103759.2404228-2-n05ec@lzu.edu.cn/
> 
> 
>  net/sched/sch_ets.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index cb8cf437ce87..12a156ccb0a6 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -40,7 +40,7 @@ struct ets_class {
>  	struct list_head alist; /* In struct ets_sched.active. */
>  	struct Qdisc *qdisc;
>  	u32 quantum;
> -	u32 deficit;
> +	u64 deficit;
>  	struct gnet_stats_basic_sync bstats;
>  	struct gnet_stats_queue qstats;
>  };
> @@ -463,6 +463,8 @@ ets_qdisc_dequeue_skb(struct Qdisc *sch, struct sk_buff *skb)
>  static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
>  {
>  	struct ets_sched *q = qdisc_priv(sch);
> +	unsigned int max_loops = READ_ONCE(q->nbands) * 2;
> +	unsigned int loops = 0;
>  	struct ets_class *cl;
>  	struct sk_buff *skb;
>  	unsigned int band;
> @@ -499,6 +501,8 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
>  
>  		cl->deficit += READ_ONCE(cl->quantum);
>  		list_move_tail(&cl->alist, &q->active);
> +		if (++loops > max_loops)
> +			goto out;
>  	}
>  out:
>  	return NULL;


