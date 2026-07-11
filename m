Return-Path: <netdev+bounces-306891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jHGXMdN1UmpzQAMAu9opvQ
	(envelope-from <netdev+bounces-306891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 18:56:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D57424D4
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 18:56:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ojxgGIxc;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306891-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306891-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90962300909A
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149023CB90F;
	Sat, 11 Jul 2026 16:56:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66E3C7E13
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 16:56:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783789007; cv=none; b=p2oWvZ4kxcfjZ4h+jAvKQEJRI8obeVMBiCjSxZAKEmGOQ8Dn9oTK3NLwzWC4aZoowsfPorubZF2xPtYAGk+zJ1gwttHitmzi7iSYHy9kLpRewL/18s1crWjJN+bJS8qy+Cne/rYsJC662PEefT6ue7h0wWMj/nr2jVpnIe1UKjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783789007; c=relaxed/simple;
	bh=yRNexKuURdoGnE8+/ijduYiw/wIId9GpmrNXVT3HAao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rxz7NqbBqJAOVce9iOeKqIMk7ZmGcW1UB49a82awcO1DW0wQfiF+WxXrhNVWLs+8JF5mFWqNMZV0bbFK1IDXam+1fwdBdKr7so1fnINJ6hh+0WI+GLZxJ0fClaFVmEknjMbkm8bGaMa4MsIuwASdkh/7sEuI0UOGNQlleC0LTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojxgGIxc; arc=none smtp.client-ip=209.85.210.42
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb787dec99so1172771a34.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783789004; x=1784393804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PUPiYSrT17qhTQ8MbXJ3f9k/JMiAtFPLGBry1sQcxdg=;
        b=ojxgGIxcHJmBeVzYgU/vbarufsnad6jQroiPgIK4GF1UydmMtPvgFYq2DvfWhNKG4x
         UQMoKPnVqpbv2hH75CFugSX5QK0PaZFEU0hHHmFlsrjIV/BPfT5sO6Sd05vPLKoB0zWt
         /JwEaUOXg65oe3rLJUTukDh1s3VyWLvTSYrvPbJwx6wwaBIGuC7niQHWcxZvu8MkvYja
         B0MJLejzWTStK71EEY8uZajj4FQfsVmQgcAROItmiieEPu3NY/dJyrkd9a9fM203vhoJ
         gKcPkl5b7fwcSxGw4qfanmp192g/LG+LvKFzADqdrslBt3jXUQJB6k85c9y/Q3MXA84i
         pe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783789004; x=1784393804;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUPiYSrT17qhTQ8MbXJ3f9k/JMiAtFPLGBry1sQcxdg=;
        b=Emc4AX89iM4B3q8dursIvJyO/lvpziZJjLwUAmp3CaVu825GXeTZgAq1QaTCsir+7+
         csB2/BCP9Rf+Deslqj6OBvnvnmrzZS0KoFa/VeDhM3/3O02HXTms2n293aQERYpxdG36
         SASVrBSDrU830TTnXpODQdk8wYDwAX/jsq3+I7mN7Ab3jzIRHYaRa5rnsgjNWc4P/N+P
         ZVjP/yGcXc5RVPnIw+vsQB53R8TBDC/Alrs1l/Y20zfGlbOtcCfInzwsLlHaPkkGL/uH
         IsEWYLFqBav6QhO+lpO8Cp9iFc3xyOYGAsryZWeaREvAI52yCFvezIp2eTNaxq4EuZp8
         JQew==
X-Forwarded-Encrypted: i=1; AFNElJ9LBkfaoYjUZOpdJt9sfhGL5FJ1tScGXAYTgxQNKKfuNNC35vWEPNbAZOXwtKmdOU6QHkKB/oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbpqDTcGgQ3bo9rgtvpQH9rEOYH0hVLuul9zs7qWD11rwQ/Tl
	6zG3WfQsSvDiRBkfgRXW9LLt15KNMfAnTlXn4SW6Q0NPrBdJQd4a+YJ/
X-Gm-Gg: AfdE7ckm8mtEiz/pk7jtoLn6sPOX651rrGKbgu6gbFy/uUgTE/Mend98/PNp+7ao5ex
	euX9yx1+0/VEEYCEontaz9mfXTwRA7sBlVCN/LF66CsmDtf5/90OB72JTSQi/XJ/n3wkaRxxrp+
	uBzaUEvjjicj38XNQw+dUhQkPV6pwiVgtseyXtDiPCAOomIogzZIYGTX6aH4KSj2aRJJEJIT0L6
	OmSAM8+CNKau0XZ67DQ0iua5TUGb4snj7BJwaZhper8Ai0lP18rBBZP2kAOQu2T5TCh31qQj46N
	H2eRXa95nXXKoKJOLg/Mt0stFN/Tt0vJevIyb2Ssmwxcobc4FbCU+3MYhnenI3xI3BXKLGNj45x
	SMARUEt9g3B/saO2xKsKQBAewTxIaDItezkKe75WHYCHHgJ7PMGT1lNwikmGyaSf3yV9S8NvK/N
	xyKjamnAGxsPa8qZk+pTbLMqZsg8VYOL8/gprWpSlIJkufxMeH1Y1NnFjwOwpxA/LaqGFtK1/BO
	B5AV0s=
X-Received: by 2002:a05:6830:3497:b0:7e9:e860:6ee with SMTP id 46e09a7af769-7ec0983e380mr2113298a34.31.1783789003871;
        Sat, 11 Jul 2026 09:56:43 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:c495:5538:b9fc:6fc5? ([2601:282:1e02:1040:c495:5538:b9fc:6fc5])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7ebcb2b79c9sm8973682a34.22.2026.07.11.09.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 09:56:43 -0700 (PDT)
Message-ID: <5cf2d4ee-376f-4baa-baf1-fd7bf7500251@gmail.com>
Date: Sat, 11 Jul 2026 10:56:42 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mpls: fix NULL deref in mpls_valid_fib_dump_req() on
 CONFIG_INET=n
Content-Language: en-US
To: Weiming Shi <bestswngs@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: kuniyu@google.com, gnault@redhat.com, xmei5@asu.edu,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260711114958.1009619-3-bestswngs@gmail.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260711114958.1009619-3-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306891-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:gnault@redhat.com,m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dsahern@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B8D57424D4

On 7/11/26 5:50 AM, Weiming Shi wrote:
> On CONFIG_INET=n builds, mpls_valid_fib_dump_req() walks the parsed
> attribute table itself instead of calling ip_valid_fib_dump_req(). The
> RTA_OIF arm passes tb[RTA_OIF] to nla_get_u32() without checking it is
> present, so an RTM_GETROUTE dump for AF_MPLS with strict checking and no
> RTA_OIF hits a NULL dereference.
> 
> RTM_GETROUTE is RTNL_KIND_GET, which rtnetlink_rcv_msg() permits without
> CAP_NET_ADMIN, so an unprivileged user can trigger it.
> 
>   Oops: general protection fault, probably for non-canonical address
>         0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:mpls_valid_fib_dump_req (net/mpls/af_mpls.c:2189)
>   Call Trace:
>    mpls_dump_routes (net/mpls/af_mpls.c:2236)
>    netlink_dump (net/netlink/af_netlink.c:2331)
>    __netlink_dump_start (net/netlink/af_netlink.c:2446)
>    rtnetlink_rcv_msg (net/core/rtnetlink.c:7033)
>    netlink_rcv_skb (net/netlink/af_netlink.c:2556)
>    netlink_unicast (net/netlink/af_netlink.c:1345)
>    netlink_sendmsg (net/netlink/af_netlink.c:1900)
>    __sock_sendmsg (net/socket.c:790)
>    ____sys_sendmsg (net/socket.c:2684)
>    ___sys_sendmsg (net/socket.c:2738)
>    __sys_sendmsg (net/socket.c:2770)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> 
> Skip unset attributes, as ip_valid_fib_dump_req() does.
> 
> Fixes: 196cfebf8972 ("net/mpls: Handle kernel side filtering of route dumps")
> Assisted-by: Claude:claude-opus-4-8
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/mpls/af_mpls.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index ca504d9626cf..318cb7e2ac5f 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -2186,6 +2186,9 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
>  		int ifindex;
>  
>  		if (i == RTA_OIF) {
> +			if (!tb[i])
> +				continue;
> +
>  			ifindex = nla_get_u32(tb[i]);
>  			filter->dev = dev_get_by_index_rcu(net, ifindex);
>  			if (!filter->dev)

Reviewed-by: David Ahern <dsahern@kernel.org>


