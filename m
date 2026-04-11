Return-Path: <netdev+bounces-277667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INFwAgnb2WlOtwgAu9opvQ
	(envelope-from <netdev+bounces-277667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:24:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB4B3DE6C2
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AB9A3015738
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313402E2DF3;
	Sat, 11 Apr 2026 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4DfcXhL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5C17B425
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884841; cv=none; b=u4xbMR6+PcSUe/uM8BnfJf2pfFFjeJRZyw0EwrnYcaaoAulSs3Kz1hcrRaa4no0qJ6tCFMDzKN0ie3ynzUbf1jfCGbrrjcHixEF9H2/m/X4CG1PDE8YCTwTRzgr4vI1jLzEuObDoZCUuwvYVH9GrHuppAxGJZ9UVB3vKMwe2/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884841; c=relaxed/simple;
	bh=dEI8KgnxMpcND2cz4rgkT0UqCpVPs7EN2ADeUdIkbqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A9M0Kst8/cIndwdsQyKHT9Qa/sylvBTpVJsRZG4kvfP9jCvkFGtKDQCyJ35xmp3adYVcfLBJ7IvYA0103C70yPBrc3cGgO20kYEtVMbJ/XyLGFtA7lidEZoZA2YRg2XwzOYLbw2g9FMgFQ6F+IU2YNZV8X2TTy9dYW76KX6A+2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v4DfcXhL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da86144daso3372007a91.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775884839; x=1776489639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xN+2eW0fGvh2zhHI+wBBjFJBKYXrYij0/HarBXfBFqk=;
        b=v4DfcXhLhXdInt+GnCSzw4V/APSGo+krC/uNTWGEIK7AocNzUKZCIgQcjlB6VMleTc
         ssTnvnf9cLBlGdqOTtUxUyOKDe2pJkJ0E7ZcVAX7AB/wu13XgQKVbBWC2IpaqCCAiSxW
         Sm2YW3An6FHjjUICfzGjS8RbCRWhO680RJ4yOSGktANzCQYE99Vs8DQXo4Nsu6Sjm0fj
         r0Sy4Ot0nwOEBFSu/GWJ9k+QyHQYXuqKDK+Z1sbNDboHOcbRBRM3CecH5AGCUyHaGidx
         vfCh9o1pWhTZSC7878Y5VAPcETiNpyLjcZAMzFP4mwB4gr2GLJrgtmOYTKOLIC3xh4p+
         kcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884839; x=1776489639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xN+2eW0fGvh2zhHI+wBBjFJBKYXrYij0/HarBXfBFqk=;
        b=aeHLqWfxRplHCmrASTo7mANNJ4frI7+OlO7WAbH/wgq1ASi5FC9fy+cQ0zzu5ggkUO
         umMrtAi7WzGzO35bHkT9iD26eEs+gUEiKF1sayjv4YxsUfyUyUjrWh2z8EosKKgBC9J6
         9AmD3FQ4di64+eAncPFdYzTL9k79C8KxvmiP557sU++h87Y5KDPiDqb6YIX27HgwHOyY
         xYR9+7NCi0jAUDWjHOh9qcZfZpsAnLZhChbdSVZr2QAU51vrXyXUVrVrQzdZVRKYUnFP
         N7hdTT01U5JwB5HnAf9lenJtpm5ufMFGm+7LCPUg8lFklvTi6uzKwt+b0/5NAlHhOvmw
         C93g==
X-Forwarded-Encrypted: i=1; AJvYcCWUA5iwMqju7G82yoUI/vyYvhojRaPWQw1TV1zEMmHGrZHzGtlm9Jg5IuTe0UDdW31um8Lr+Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIPSn0mQao9w28c53i7sRd7qKrdKw1oWpL00HZM2OjCQXlYqZ
	pB5+/ssCQON3kydztXvi+0/HppYU7anAJ8NYVb6cxE8IlO/a6oLqMkIvU804rXjyATZR7k6Mm/+
	gkmOCUA==
X-Received: from pgbca12.prod.google.com ([2002:a05:6a02:68c:b0:c73:9919:c4f8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d07:b0:35d:a3b4:2f0d
 with SMTP id 98e67ed59e1d1-35e4274e1damr5634715a91.6.1775884839107; Fri, 10
 Apr 2026 22:20:39 -0700 (PDT)
Date: Sat, 11 Apr 2026 05:19:35 +0000
In-Reply-To: <adkMqgP6QeBPgqP9@p100>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adkMqgP6QeBPgqP9@p100>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411052037.2013228-1-kuniyu@google.com>
Subject: Re: [PATCH] net: Optimize flush calculation in inet_gro_receive()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: deller@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, linux-kernel@vger.kernel.org, 
	linux-parisc@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277667-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,gmx.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AB4B3DE6C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Helge Deller <deller@kernel.org>
Date: Fri, 10 Apr 2026 16:43:54 +0200
> For the calculation of the flush variable, use the get_unaligned_xxx() helpers
> to access only relevant bits of the IP header.
> 
> Note: Since I don't know the network details, I'm not sure if "& ~IP_DF"
> (& ~0x4000) is correct, or if "& IP_OFFSET" (& 0x1FFF) should be used instead

~IP_DF is correct (MF bit needs to be checked), see

commit db8caf3dbc77599dc90f4ea0a803cd1d97116f30
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri May 31 11:18:10 2013

    gro: should aggregate frames without DF


> (which I believe would be more correct). Instead of possibly breaking things I
> left it as is, but maybe some expert can check?
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index c7731e300a44..58cad2687c2c 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1479,7 +1479,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
>  	struct sk_buff *p;
>  	unsigned int hlen;
>  	unsigned int off;
> -	int flush = 1;
> +	u16 flush = 1;
>  	int proto;
>  
>  	off = skb_gro_offset(skb);
> @@ -1504,7 +1504,8 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
>  		goto out;
>  
>  	NAPI_GRO_CB(skb)->proto = proto;
> -	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
> +	flush = (get_unaligned_be16(&iph->tot_len) ^ skb_gro_len(skb)) |
> +	        (get_unaligned_be16(&iph->frag_off) & ~IP_DF);

I think here we intentionally use 32-bit loads:

commit 1075f3f65d0e0f49351b7d4310e9f94483972a51
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue May 26 18:50:29 2009

    ipv4: Use 32-bit loads for ID and length in GRO


Before your patch, 32-bit load + bswap are used while
16-bit load + rol 8 after the change.

I feel the 4-byte aligned load + bswap is faster than
misaligned access + 8 times shift (Is this internally
optimised like xchg for a single word size ?)

Do you have some numbers ?


Before:
	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb))
mov    edx,DWORD PTR [rcx]
bswap  edx
	return skb->len - NAPI_GRO_CB(skb)->data_offset;
mov    r8d,DWORD PTR [rsi+0x38]
mov    r9d,DWORD PTR [rsi+0x70]
sub    r9d,r8d
xor    r9d,edx
	| (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
mov    ebp,0xffbfffff
and    ebp,DWORD PTR [rcx+0x4]
bswap  ebp
or     ebp,r9d


After:
	flush = (get_unaligned_be16(&iph->tot_len) ^ skb_gro_len(skb))
movzx  edx,WORD PTR [rcx+0x2]
rol    dx,0x8
	return skb->len - NAPI_GRO_CB(skb)->data_offset;
mov    r8d,DWORD PTR [rsi+0x38]
mov    r9d,DWORD PTR [rsi+0x70]
sub    r9d,r8d
xor    r9d,edx
	| (get_unaligned_be16(&iph->frag_off) & ~IP_DF);
movzx  ebp,WORD PTR [rcx+0x6]
and    ebp,0xffffffbf
rol    bp,0x8
or     ebp,r9d

