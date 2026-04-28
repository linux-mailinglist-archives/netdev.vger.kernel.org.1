Return-Path: <netdev+bounces-281794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCd5L3CV8GnnVAEAu9opvQ
	(envelope-from <netdev+bounces-281794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:09:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5DB483590
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E1230A3D35
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9273F65EF;
	Tue, 28 Apr 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MprkDYBp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiZ1m3Ps"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF343F165A
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373969; cv=none; b=D4/GM33xsRR3mPWV7GtP2J8Q6qpvCbXTGKFJLbaTrysatCUpCduJ0ILW0yxx6qmzNWmtfdaUvANvNiW7CGOLt3q7WzBW5TygcG5dLoSWdOZccmM8RTrRxTlagYN28ElrgAJmsakEXfiTgwlmeToe5SB95sr4X7hbd8yi7Ukuw04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373969; c=relaxed/simple;
	bh=G2/rF3EEGk3k5lEdsdDKT8n233J1tCl4qTDhr0OOqe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbDPdBOUZS0+xl0dAe+MxCK9wJ+7+Ay7TYN87Q0yFeswleRPmXdF6f7zVXomJFlPOwz/Od+uxk5ttrAlj1eWazJj00uWuq/bbvJZD2ho3Lih4HHEmw+vhjFxVtCAm+7TRG9Whd8xTxyJB7X2QX8Zq11bUbwvSnPnfo+TuCgT+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MprkDYBp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiZ1m3Ps; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777373967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4U2KZSCsoWmBFIeQ+MczWaDGXp2iubZYjNi4WCkdB1M=;
	b=MprkDYBpmfqUbcVHUjJIufmykWIMC2Ta4K+MGjg5k6AFRHztoGXF4UBRbA1Z6P/TB0AAQa
	RtUkKlM2coExnbrizwe5moW8pY1EvkHELLf35Z45JklmkuRcaZLaG/A+8Z9vReIevAsZ+Q
	7+ArVFpEma9yu9vn26nv68Xu0oL1XCo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-8vZp1B2zNc-skSf9QEf_qg-1; Tue, 28 Apr 2026 06:59:25 -0400
X-MC-Unique: 8vZp1B2zNc-skSf9QEf_qg-1
X-Mimecast-MFC-AGG-ID: 8vZp1B2zNc-skSf9QEf_qg_1777373965
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8d4c2906fdfso1201939585a.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 03:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777373965; x=1777978765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4U2KZSCsoWmBFIeQ+MczWaDGXp2iubZYjNi4WCkdB1M=;
        b=SiZ1m3PssW45E64iFtaW1SyuJxjr14jlST6Zhh5+JKREk09/vafVsjQCX7n5QqO1em
         dXbd70ubv6VBE/yklN9+PlRjp50zsj6zg/bKAHkCmaN2vXLLgCC09Dv7qFE92/nMKeHE
         2C8MhOp32mvx8gKrX4sVOst6LRqIkGGO4/6RkBlk4dFCH2MXypAKEQvwBW8WK01pkBTM
         ux9V31uptZY4GsPMsfdi0Nq95hK9ZPq2p/jjRWvaLVV2E2NUG1CB1bhKMZaJS+Hwb34E
         Fitmn0Tt5Z2e9HfXW8KzL3fiAFuLAnk0SUtAjNuqpG6bBHrKTxcA+rtg7UQKLT9N0fcF
         pAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777373965; x=1777978765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4U2KZSCsoWmBFIeQ+MczWaDGXp2iubZYjNi4WCkdB1M=;
        b=YJQMNF7AOPrklnt5ryh7zJqcmjI84jfzCQWfzA0Rg0mpTt8RMTCVQvRPjaeEJ4j1ce
         GAfbcRTXjkRrHVo47jPnAk4t10O7FZRinQisdQa333rF3xLWrH+6vZTeBiHAiuXLHNzA
         BCeRrLB7x9yV8xNGUhP8pq1MIr7aBy822HGsoZBZJHQ7qXPUW5xL5PbEKX49tXtN3S+P
         X2DL5q75tEZGoAUzzcco1gFnMhtbQtXOt5WpAQbR05mqQjoq4xSkoC7ssc3OWKGC9LPr
         eu0WoVOHAWwo0SKBMmmFAOhq+cjiF7gJZy0C1xnGbfE1O6AujDSLUjLDfjV6DU3fwoXo
         wxkw==
X-Forwarded-Encrypted: i=1; AFNElJ/z8v71hPHEt3lVHTX5EKX9LCVFQqLcgCnPCE2VFwz0YZgmOohfLfIzNx3xpulws1AwiJGaKRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1DG32ByZP6u4CVOKJDErhRwdqU1uBYGqeHLpzOgb9oQF3qDH7
	cjN4vEeOnp3lGnisJcg88qbx5a1L1SeQvTJR4YOq0vO1EympX7Udc2g8Jt1fbGXCuj0fYXYhtlt
	J6ge/IvooVkUArbmFy1s3HJapurWfv7hIOJmu4P/JwIn2ARc6Q7iwGlZ5Nh1thVG8GQ==
X-Gm-Gg: AeBDietuulRH0cEpWBFl+oCdjII7LtM0nO7iFwHxvPl3WkUTjWR8C6kcTpW4ppk2trL
	7aI5ES1cZMUh04DmMm047uXsLCIMldx0kE840Cmc66panj5JG8m1Cu9KIv2J8xIG6k85qIiwNHT
	Na9aOavCr/AwcRVNtHhcRGW31LE0aA2swSinLObdC3Mjj+Eob2wR4HXApqFZSpfUFQk2kGa4FUF
	imm1MFb1AdW3grg4mK+KiomVSL8T/9sJQ81uqsTg/981eYT0Sf02or5OckoBfXPJ/oJKG/EkxFS
	7o3WM1oRzQaf31LR6hbUHA2tUjGHBa9rq/4sa2RYnfq///nEF0byGCO2jdTW2p/V0RxnUXkmqGF
	A7+DCwYOHcVuwWc/xXLah/JfAomnwiX2xk72H0++3n5eHIYWj7/FOI1ByzLLwtip+Ew==
X-Received: by 2002:a05:620a:31a4:b0:8d6:2beb:9470 with SMTP id af79cd13be357-8f7d910b295mr331469185a.40.1777373965172;
        Tue, 28 Apr 2026 03:59:25 -0700 (PDT)
X-Received: by 2002:a05:620a:31a4:b0:8d6:2beb:9470 with SMTP id af79cd13be357-8f7d910b295mr331464685a.40.1777373964645;
        Tue, 28 Apr 2026 03:59:24 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c4dbcfbdsm168341585a.12.2026.04.28.03.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 03:59:24 -0700 (PDT)
Message-ID: <d7bab1a1-6938-49aa-9fdb-fab42633c678@redhat.com>
Date: Tue, 28 Apr 2026 12:59:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ipv6: addrconf: skip ERRDAD transition when
 address already DEAD
To: Linmao Li <lilinmao@kylinos.cn>, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org
Cc: horms@kernel.org, stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260421075033.1110816-1-lilinmao@kylinos.cn>
 <20260423023216.1221731-1-lilinmao@kylinos.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260423023216.1221731-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1F5DB483590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281794-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]

On 4/23/26 4:32 AM, Linmao Li wrote:
> addrconf_dad_failure() transitions ifp->state from DAD to POSTDAD
> via addrconf_dad_end(), which drops ifp->lock on return.  The lock
> is re-acquired after net_info_ratelimited().  A concurrent
> ipv6_del_addr() can take the lock in that window, set ifp->state
> to DEAD and run list_del_rcu(&ifp->if_list).
> 
> addrconf_dad_failure() then overwrites DEAD with ERRDAD at errdad:
> and schedules a new dad_work.  The work calls ipv6_del_addr()
> again, hitting the already-poisoned list entry:
> 
>   general protection fault: 0000 [#1] SMP NOPTI
>   CPU: 4 PID: 217 Comm: kworker/4:1
>   Workqueue: ipv6_addrconf addrconf_dad_work
>   RIP: 0010:ipv6_del_addr+0xe9/0x280
>   RAX: dead000000000122
>   Call Trace:
>    addrconf_dad_stop+0x113/0x140
>    addrconf_dad_work+0x28c/0x430
>    process_one_work+0x1eb/0x3b0
>    worker_thread+0x4d/0x400
>    kthread+0x104/0x140
>    ret_from_fork+0x35/0x40
> 
> Fold the addrconf_dad_end() logic into addrconf_dad_failure()
> under a single ifp->lock critical section.  The STABLE_PRIVACY
> branch temporarily drops ifp->lock, so keep a state-is-DEAD
> bail-out at errdad: for that remaining window.
> 
> Fixes: c15b1ccadb32 ("ipv6: move DAD and addrconf_verify processing to workqueue")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  net/ipv6/addrconf.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 5476b6536eb7..c9ea0d5042d0 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2166,16 +2166,18 @@ void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp)
>  	struct net *net = dev_net(idev->dev);
>  	int max_addresses;
>  
> -	if (addrconf_dad_end(ifp)) {
> +	spin_lock_bh(&ifp->lock);
> +
> +	if (ifp->state != INET6_IFADDR_STATE_DAD) {
> +		spin_unlock_bh(&ifp->lock);
>  		in6_ifa_put(ifp);
>  		return;
>  	}
> +	ifp->state = INET6_IFADDR_STATE_POSTDAD;
>  
>  	net_info_ratelimited("%s: IPv6 duplicate address %pI6c used by %pM detected!\n",
>  			     ifp->idev->dev->name, &ifp->addr, eth_hdr(skb)->h_source);
>  
> -	spin_lock_bh(&ifp->lock);
> -
>  	if (ifp->flags & IFA_F_STABLE_PRIVACY) {
>  		struct in6_addr new_addr;
>  		struct inet6_ifaddr *ifp2;
> @@ -2227,6 +2229,11 @@ void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp)
>  
>  errdad:
>  	/* transition from _POSTDAD to _ERRDAD */
> +	if (ifp->state == INET6_IFADDR_STATE_DEAD) {
> +		spin_unlock_bh(&ifp->lock);
> +		in6_ifa_put(ifp);
> +		return;

It looks like this check is need only when the ifp->lock is released
again, i.e. just after the `lock_errdad`. Please move it there, to avoid
confusion when looking at this code in the future.

Thanks,

Paolo


