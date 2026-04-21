Return-Path: <netdev+bounces-280204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG7OGQO152lU/wEAu9opvQ
	(envelope-from <netdev+bounces-280204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:33:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7587343E05B
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68B0D3006229
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389AF31A572;
	Tue, 21 Apr 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbmcYJb8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B22BE62E
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792818; cv=none; b=k+ZS/soOyc0AOfXkIodcfyfU3Z/Cb9pnNdgePn1v4/qQrk9zZ1shKHZnd8KZ7kvHKXVEEqQY6Q+vn1Cd9ili1JJHn7BBwXpKd3K08mViMVKAUousMgE6T+W9yrYYN606YNS8eeaO5FHFe2o0ukOIYTcTDrHh9iWmVu76tzdy9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792818; c=relaxed/simple;
	bh=/scXEeQaRN4B/NeF1PUsl2czhaClwcX6Cf0nOChKG7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsQ7m2EExC41gbGf+vyBg10tMnG3nq4VBNEe0ldsXgPAMoK3BHA8QFPRENqoLLIGMieLf05BAt5qRztOAKBdF53O6tn3prN6MrzkND8H2XfpCszQUTMLyFkYKEoawaw56VZBlRCh+xyqE1znfuBK8ihp8d88pcWviSJY2zC1Nsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbmcYJb8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9358dd7f79so797088066b.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776792815; x=1777397615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoCWrohdiik85XEdHlXUw0nj/jBXY1QzvkY+M7xyZZ4=;
        b=DbmcYJb8H7k+fsq8ScvYfPAIn69IO2kaxdhnOqw8CtGjvewOR3pEAVd14DYY4rYnPg
         2fWbGVLFu0wPXftCrPMXII+KsvOLDNI3siMK7l3FRhozP8pc06+LHD0pBH9Z2CUrzsNe
         a0Ie/zDXKXZaJnJO4gwaiG2zFJ7+k3MK/bYwO9qR40UTk9Q+bCf0Gk0pfUSITjtLGZvv
         5+/N3DDHupTOApEqOiq874Ke3CpQ7VCEw1SNEUUAQeqQOBwWpEp0JAqXd4Hgwix12CFN
         Zj/CZ1gqr5SsTacJxlCMq/4xhAWI4Fud0bYyqs4m1SKAxJLk1YH+Yie6v2oGZ1taU8t/
         lNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792815; x=1777397615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoCWrohdiik85XEdHlXUw0nj/jBXY1QzvkY+M7xyZZ4=;
        b=IWLItP+oMAWPySONi3yeLyhlECpXoY4SZ2H51VdKF620X6JugBuL+7oHUZD8ck4ev3
         BlNab/NQU2BpOls0b3yF0bUb7N3XiDke6EK9pkAwWHiSApXWe1f4U3ILUiMeN2e6sA9h
         bqVMlVBAXr5/gpw5MzEa4mwl9KdecYIo4hla361NqgqUDHhB8N80s5ZiGw+1MD0vslum
         oFzOlorp0ooXbUeOcLcQ3f+9ka90lPibWJTZhrHuabAwStszemY3+Z3e402cN7c7u2lA
         V3b04dIw/Oy8zMfI90z7d+n/rYbLPKLfcrzUMNPVCjUb/Xp1P3ezLVHhx6/ocuN2S+MM
         mo2A==
X-Forwarded-Encrypted: i=1; AFNElJ9TDK/6cWf2ef5ZF60keLvE/06pTFWzwIbdo8S4cBl4nsV7v0uhuaImL4qIDBbbrtSn1dxabp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNKs7zgf8CFkY08MYFqcJDXUdlYAKLMP7ZxcvhDUrZWJfkDpqS
	Qxcu8QCcLa6u6OItVK97PKjRrR4TKpcMu3/P42R2hTJdadUXzF09zK8C
X-Gm-Gg: AeBDiesRsIruLyVwenmfc2q0twSAQLeeGCmwo60hJOhPTM9inKyPycE0yATHbyIaqOw
	MQRjiszF0v4cQBIQeIsiH5v9uMo7ixkVZXIA0ENZkfian1ZA4SlyN6k7VeQve98DLI4kanrkrQ+
	cX3AymJ6eIRMztWTAl3vBeE0F2jJQTsn+6pDh5IHAZ0OHh5k9r7eWep2eSxK62k4Sr/thOaUikW
	Y3n8FIJYon2/FEUNE35SKz54QLJERfi+78ijuENWcs2Gz3HtebqgbwrDxnm/Et/6FEzogtQhsnF
	1Ri61NWZi+FESS4XdF+vsv/8aTDmgOx+ZcLyByxWroEcH30mo8aUEl6B2YT5mIAwEtoI+XhBG84
	+4RU/OvsKOTVs+82BHoI0/YYHrjm8+6xL43JV7OpYVhTcR82zRDh9r+miji1YPe5IMh2ZwkevA+
	r7apmV6aEuKjkvDDk4UJ4TC48LSio4PBjM2yl4K2tmlTlNw/jaS0bfk2gXPWMlGGi9ddTkXw8TL
	4Qy3Y7Th6l3mQy6lwBtjO8MWWQ=
X-Received: by 2002:a17:907:ea6:b0:b96:f6f1:e7af with SMTP id a640c23a62f3a-ba41916eb4dmr907537666b.9.1776792814542;
        Tue, 21 Apr 2026 10:33:34 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7546:18b7:2c8c:e879? ([2a02:a03f:a75e:9a00:7546:18b7:2c8c:e879])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4519ee4adsm469401966b.19.2026.04.21.10.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:33:34 -0700 (PDT)
Message-ID: <8ce64ee4-dce1-4052-9558-61c97121cc37@gmail.com>
Date: Tue, 21 Apr 2026 19:33:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
To: Andrea Mayer <andrea.mayer@uniroma2.it>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 david.lebrun@uclouvain.be, alex.aring@gmail.com,
 stefano.salsano@uniroma2.it, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280204-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,goodmis.org,uclouvain.be,gmail.com,uniroma2.it,vger.kernel.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7587343E05B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 11:47, Andrea Mayer wrote:
> seg6_input_core() and rpl_input() call ip6_route_input() which sets a
> NOREF dst on the skb, then pass it to dst_cache_set_ip6() invoking
> dst_hold() unconditionally.
> On PREEMPT_RT, ksoftirqd is preemptible and a higher-priority task can
> release the underlying pcpu_rt between the lookup and the caching
> through a concurrent FIB lookup on a shared nexthop.
> Simplified race sequence:
> 
>    ksoftirqd/X                       higher-prio task (same CPU X)
>    -----------                       --------------------------------
>    seg6_input_core(,skb)/rpl_input(skb)
>      dst_cache_get()
>        -> miss
>      ip6_route_input(skb)
>        -> ip6_pol_route(,skb,flags)
>           [RT6_LOOKUP_F_DST_NOREF in flags]
>          -> FIB lookup resolves fib6_nh
>             [nhid=N route]
>          -> rt6_make_pcpu_route()
>             [creates pcpu_rt, refcount=1]
>               pcpu_rt->sernum = fib6_sernum
>               [fib6_sernum=W]
>             -> cmpxchg(fib6_nh.rt6i_pcpu,
>                        NULL, pcpu_rt)
>                [slot was empty, store succeeds]
>        -> skb_dst_set_noref(skb, dst)
>           [dst is pcpu_rt, refcount still 1]
> 
>                                      rt_genid_bump_ipv6()
>                                        -> bumps fib6_sernum
>                                           [fib6_sernum from W to Z]
>                                      ip6_route_output()
>                                        -> ip6_pol_route()
>                                          -> FIB lookup resolves fib6_nh
>                                             [nhid=N]
>                                          -> rt6_get_pcpu_route()
>                                               pcpu_rt->sernum != fib6_sernum
>                                               [W <> Z, stale]
>                                            -> prev = xchg(rt6i_pcpu, NULL)
>                                            -> dst_release(prev)
>                                               [prev is pcpu_rt,
>                                                refcount 1->0, dead]
> 
>      dst = skb_dst(skb)
>      [dst is the dead pcpu_rt]
>      dst_cache_set_ip6(dst)
>        -> dst_hold() on dead dst
>        -> WARN / use-after-free
> 
> For the race to occur, ksoftirqd must be preemptible (PREEMPT_RT without
> PREEMPT_RT_NEEDS_BH_LOCK) and a concurrent task must be able to release
> the pcpu_rt. Shared nexthop objects provide such a path, as two routes
> pointing to the same nhid share the same fib6_nh and its rt6i_pcpu
> entry.
> 
> Fix seg6_input_core() and rpl_input() by calling skb_dst_force() after
> ip6_route_input() to force the NOREF dst into a refcounted one before
> caching.
> The output path is not affected as ip6_route_output() already returns a
> refcounted dst.
> 
> Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>   net/ipv6/rpl_iptunnel.c  | 9 +++++++++
>   net/ipv6/seg6_iptunnel.c | 9 +++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
> index c7942cf65567..4e10adcd70e8 100644
> --- a/net/ipv6/rpl_iptunnel.c
> +++ b/net/ipv6/rpl_iptunnel.c
> @@ -287,7 +287,16 @@ static int rpl_input(struct sk_buff *skb)
>   
>   	if (!dst) {
>   		ip6_route_input(skb);
> +
> +		/* ip6_route_input() sets a NOREF dst; force a refcount on it
> +		 * before caching or further use.
> +		 */
> +		skb_dst_force(skb);
>   		dst = skb_dst(skb);
> +		if (unlikely(!dst)) {
> +			err = -ENETUNREACH;
> +			goto drop;
> +		}
>   
>   		/* cache only if we don't create a dst reference loop */
>   		if (!dst->error && lwtst != dst->lwtstate) {
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 97b50d9b1365..94284b483be0 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -515,7 +515,16 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>   
>   	if (!dst) {
>   		ip6_route_input(skb);
> +
> +		/* ip6_route_input() sets a NOREF dst; force a refcount on it
> +		 * before caching or further use.
> +		 */
> +		skb_dst_force(skb);
>   		dst = skb_dst(skb);
> +		if (unlikely(!dst)) {
> +			err = -ENETUNREACH;
> +			goto drop;
> +		}
>   
>   		/* cache only if we don't create a dst reference loop */
>   		if (!dst->error && lwtst != dst->lwtstate) {

Thanks for taking care of this, Andrea! LGTM.

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

