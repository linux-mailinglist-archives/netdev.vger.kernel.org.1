Return-Path: <netdev+bounces-293804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFYaLkikHWr5cgkAu9opvQ
	(envelope-from <netdev+bounces-293804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:24:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 156DF621A1F
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B826302B092
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A633D9028;
	Mon,  1 Jun 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="y0Vbt2pO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D23D905D
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326917; cv=none; b=RTRVXdMOUOIRW5n3tZ4eJ7T39OIBJLEefIpRNduPMjVyKOyj5Kaiq8Ua8kxOLX+VAn+c2r+eeAUhs4xKrSeSV9dbxBXcFXmScv/+NF0x3/LSHZz3jLoisjXDKJqh9h0vXJX04g/aJXZ/dR4wssfR6lQd7SE+5ICWFS16ite/jEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326917; c=relaxed/simple;
	bh=2MXUrqP50B7XcVz861ZemOFtYgIly9nH4PrO6Ic6ym8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGM0LOz8wVpc4ewXbzkJcxO+F+XoAv0uUYi0OKNxSfFm2NllLqfYkF8Q8vCFYyCmT+QDPfZ4EPveHCFJFC5OoAiWPxoz690GfBT7cSCOa+A4r434Icy6r1f5iy4GSKmy248brrjQbQ1iX69yY8B6GNwnmliG0GxrPTrQXDujzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=y0Vbt2pO; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9638d15f871so1529366241.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780326912; x=1780931712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPTNIzliAheYDBgMd3OesTJXCtynKcxw/qSbdwpq3CA=;
        b=y0Vbt2pOvxdqxpI+hzyaT9AZasgy+TKjH8r12s8uerDzhO+lzRltZ0dkteH2qOx64s
         /U2JSGMSm27D+7eh9g9xVQVpD5zXYzrkEamKzDVjQy42jwV3Nh1JhRBI7oylGbVOlh9E
         WCb6GFs4aayoqoNDvINj7sGSJdSGwH42rqTY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780326912; x=1780931712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPTNIzliAheYDBgMd3OesTJXCtynKcxw/qSbdwpq3CA=;
        b=lPCETnDXZw0AOf6VT/o4nUswWrLERaGs3Ia20ZWFaN8uNB5i7UZ93uOpCnvWHRH7KE
         J8GNpB+jnOgizuUAPBR/gLhyJqjyYhHItPuyCavVKXwcgS1MNUx8zQgbdVduV2miOaxi
         ah0bqoTj2TTSt+QuMAqPg7BssRTJoJUcpSaJyMwjHiKOoYvcG9CA408KhKtVjYrskpGd
         0sgwoOmUJoP+4x5RXcbf9vxb9atU7X15DSWKYSRY6j/xDYaAq26Wt+IQn5/TZmBmLQnY
         WmGfCBcKi1AgoBfQVwTCap5EBGmFjR7Ueu9OYmTH7xab8zeZ93AYKEfMigP8HuMi5mZW
         ExHw==
X-Forwarded-Encrypted: i=1; AFNElJ+BQJxKaOC6z3qIF92uVCmdK/MhagNVCNwADX4Ykibw8ihF57OFWhgOp7xU60y/foPshwHPUeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5FEGEHMhFpcM9jPxLe+UjnBk6EiZuaoZJhP/XXeja0AEdUYO4
	EZmgRaurqujJhBiM24QGdSSt0lEzlk0596uAS6Vh3yET8rLsAeyON20xPzR2BZo4aw==
X-Gm-Gg: Acq92OGGW189DEkKKcCDB30Zj+vDCNsFX/slpf40iatUTFvuOubdyALxcks8vdp7VYS
	OYSS+1ImFeSGmePLxd7EIYqpK5UIU8wBddQiYfiYtGJPpRVDF+6SbXAPrUtZggRaa4brvBFmlrc
	cxpRRsgkaCBC1FdHKAjco+epHv5G+LorKmP7qBTWiqyio04BYLT6vXobj1KnzlajKED6H8E0EsJ
	AWElkOQkyDQZEZGowO8v3/JQSG8jTFoEu6h5MJWcAo7LZ2QWaaYhVJJaht2n5FXdH+KYqT4W0hP
	MSQAEJKcBo8WC92yB4wGyoQRVHboVvIdtE+bHDExT1xTOYPaxP7EJnWLqp9nIliZFgp7cslzysF
	Ly/Z9DfqMa8/pQc9Do9doVSjL/D8FFFzqWZS9xORfaSd5DtPjyGq4wYZA66vf5BhTY0NXazlgEd
	TjKpfyepXofaexm0Zipudn3s0pNN17F4bDnCtnF/b9fw==
X-Received: by 2002:a05:6122:489a:b0:575:36c4:8900 with SMTP id 71dfb90a1353d-59bf56cc72dmr5061994e0c.14.1780326912250;
        Mon, 01 Jun 2026 08:15:12 -0700 (PDT)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-599d4754259sm7314403e0c.7.2026.06.01.08.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 08:15:11 -0700 (PDT)
Message-ID: <b56d8b37-1267-47f4-a254-66726560ca05@mojatatu.com>
Date: Mon, 1 Jun 2026 12:15:04 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net/sched: act_api: use RCU with deferred
 freeing for action lifecycle
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, victor@mojatatu.com,
 kylebot@openai.com, jiri@resnulli.us, vladbu@nvidia.com,
 linux-kernel@vger.kernel.org, security@kernel.org, stable@kernel.org,
 syzbot@syzkaller.appspotmail.com
References: <20260531160812.68020-1-jhs@mojatatu.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20260531160812.68020-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-293804-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pctammela@mojatatu.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:dkim]
X-Rspamd-Queue-Id: 156DF621A1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 31/05/2026 13:08, Jamal Hadi Salim wrote:
> When NEWTFILTER and DELFILTER are run concurrently it is possible to create a
> race with an associated action.
> 
> Let's illustrate with CPU0 running NEWTFILTER and CPU1 running DELFILTER:
> 
>   0: mutex_lock() <-- holds the idr lock
>   0: rcu_read_lock()
>   0: p = idr_find(idr, index) <-- action p is valid (RCU protects IDR)
>   0: mutex_unlock() <-- releases the idr lock
>   1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
>   1: idr_remove(idr, index) <-- Action removed from IDR
>   1: mutex_unlock() <-- mutex released allowing us to delete the action
>   1: tcf_action_cleanup(p); kfree(p) <-- Kfrees p immediately, no deferral
>   0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- ouch, UAF p points to freed memory
> 
> This patch fixes the race condition between NEWTFILTER and DELFILTER by
> adding struct rcu_head to tc_action used in the deferral and introducing a
> call_rcu() in the delete path to defer the final kfree().
> 
> Note: this is a revert of commit d7fb60b9cafb ("net_sched: get rid of tcfa_rcu")
> but also modernization/simplification to directly use kfree_rcu().
> 
> Let's illustrate the new restored code path:
> 
>   0: rcu_read_lock()
>   1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
>   1: idr_remove(idr, index)
>   1: mutex_unlock()
>   1: call_rcu(&p->tcfa_rcu, tcf_action_rcu_free) <-- defer kfree after grace period
>   0: p = idr_find(idr, index)
>   0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- fails, refcnt already 0
>   1: rcu_read_unlock() <-- release so freeing can run after grace period
> 
> After CPU1 calls idr_remove(), the object is no longer reachable through the IDR.
> CPU0's subsequent idr_find() will return NULL, and even if it still held a
> stale pointer, the immediate kfree() is now deferred until after the RCU grace
> period, so no UAF can occur.
> 
> Fixes: d7fb60b9cafb ("net_sched: get rid of tcfa_rcu")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>


Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
> v1->v2
> 1) syzbot ci found revealed that the cleanup code could be called under
>     softirq/atomic context. Because tcf_action_cleanup() calls  __tcf_chain_put()
>     which grabs a mutex (which can sleep). Fix is to move tcf_action_cleanup()
>     to be invoked before call to rcu.
> 2) And while looking closely i noticed a bad comment on action code which
>     claims that "actions are always connected to filters" ;-> Tracing back
>     on git i noticed that infact we did have exactly this new change circa 2017
>     that was erronously removed by commit d7fb60b9cafb. Well, at least I
>     am certain what the "Fixes" tag should be now ;->
> 3) Patch is much much simpler now than it was in v1
> ---
>   include/net/act_api.h | 1 +
>   net/sched/act_api.c   | 7 +------
>   2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index d11b79107930..fd2967ee08f7 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -45,6 +45,7 @@ struct tc_action {
>   	struct tc_cookie	__rcu *user_cookie;
>   	struct tcf_chain	__rcu *goto_chain;
>   	u32			tcfa_flags;
> +	struct rcu_head         tcfa_rcu;
>   	u8			hw_stats;
>   	u8			used_hw_stats;
>   	bool			used_hw_stats_valid;
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 332fd9695e54..04ea11c90e03 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -112,11 +112,6 @@ struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action,
>   }
>   EXPORT_SYMBOL(tcf_action_set_ctrlact);
>   
> -/* XXX: For standalone actions, we don't need a RCU grace period either, because
> - * actions are always connected to filters and filters are already destroyed in
> - * RCU callbacks, so after a RCU grace period actions are already disconnected
> - * from filters. Readers later can not find us.
> - */
>   static void free_tcf(struct tc_action *p)
>   {
>   	struct tcf_chain *chain = rcu_dereference_protected(p->goto_chain, 1);
> @@ -129,7 +124,7 @@ static void free_tcf(struct tc_action *p)
>   	if (chain)
>   		tcf_chain_put_by_act(chain);
>   
> -	kfree(p);
> +	kfree_rcu(p, tcfa_rcu);
>   }
>   
>   static void offload_action_hw_count_set(struct tc_action *act,


