Return-Path: <netdev+bounces-277695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Md8QMiA62mn0zAgAu9opvQ
	(envelope-from <netdev+bounces-277695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 14:10:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B043DFAB7
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 14:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9808230241BE
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602323537D4;
	Sat, 11 Apr 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia8NIXWx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6067F1514F8
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775909406; cv=none; b=gyAMux+8EPWdt0VGU0djKEWpPzW7EtMf7Vsqjf+Ab0Ei+Gu72ZqTHd3cxcjvQPwuZtmDMXwfJZx89/YnL0WGhKv5GNTJJATyWu/TC64X3r7kWXuP9IoAN0U+OLtQISNRWE6loXPjTTgpyRIOIpARUEHs/XC2QD2Q7ylDETdfkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775909406; c=relaxed/simple;
	bh=4PPOUoWI/sGzynuL7aex65UKmPYBL2lt+b9RjgXNbBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXAdnTWvtnuy7IQ1nAfjB0Sat5zjYsf0FAj7f/Q0z6JuucX/RQl+vn6ZY/a4L+/UwrP/X2FWZrxvs/zSPag5M+b3CIXOvvcFmRkIK4XjEnWZcdq2ubLAR4WOsCetd7wOS6gJerK7G6bYrKA/gfq8mhkgh/A2ip8zVmhSh5/QORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia8NIXWx; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfd96354aso1744645f8f.1
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775909402; x=1776514202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOqUKvzHbOtmysCumhKJ+ed6LDXdDC4PW3MeNbU0xPE=;
        b=Ia8NIXWxzMhrLWN/g9dpcx3P8pRvNbMMBBwAK3GvrMCH2ZkS292qup0Fd9BhHXpB9k
         7Vh9Lf0O/jKmLynljLcKbFJWjA+GxRwXNEBm0lYQasBcR+NwBUjAlEZtGUBnAggyECKb
         QdiWpgBbnsGJ5HIuH6w95F6enKmSpNDe8ZNkcABzPwzo1iQnwpPJCSHoO9mUPH/bo/5R
         COud8X4jWNWOVwoNQKT2obe6jOc6/NJE00x1i0GK+phyAZyzLWOaGGiaHUpp78qbcBSi
         CRY4J2CATaSlhlMiAqPF+2aWrdXj6IKl4X1KZb2Y3Z0Lq31Iu1I4sUBYH9cq4KKLo68k
         BIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775909402; x=1776514202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nOqUKvzHbOtmysCumhKJ+ed6LDXdDC4PW3MeNbU0xPE=;
        b=qAZUwZ1mv9skGdX/Z7yL5eNjkEJYRaR6OmYgIu0dcMM+zookc8rUYKuDH+tLeYUGo1
         ezJ3bacOMkExVceUjteISjg3hw6Sq0s93sJtbr3IUFxtDztSNV0N+2l/+SQR9Sk79V+3
         BCVS+F8n0nyOBggxeGwxyJhCwOuGpdUC7U65VmA1BAzcd99PCpVY4Cz+M9TFw8bENs6b
         1a7J5u0bAdTnT+lI/5DF6lCBzrxD2D5faA1JJLS3gRQpAqQ+LL4VxTIbXMhsEnfg/fhg
         FhEQNtofJjkiE2OSkuhnJ2V/1Lx1LRU48dl7Yu/T4+xgz5EnnCVEkQo/P8ZinhgXW1U0
         yVDg==
X-Forwarded-Encrypted: i=1; AJvYcCUwURS4Zf7wccJBpM/5stXniIZs1N7YjPRzcqVmwVAqTnX/qHJN7O5oXi2sXkSK9QQ8kfBc0tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7aG9uf41PS8sa9zflhzTINbHP8hBs7iHpe0n1ZQxOpgvhOjMA
	t/IqQqhQpRvrM8I33bSaKFoVwjxyO28JaBq/ogAT7xMxk74ISUwp7f+X
X-Gm-Gg: AeBDiesEoL0IHNka9nQGWR/RCFt3+pINxmrCtUkqD6dE29dFUtxE5ImudDbXyk4QMqm
	r4kM6BIUnqtBHiu7Q3n+G1rLPHFfooXdCQKROZtIJDDsKrZ103dqyBqvNrcSnTgPZIy4sBmryag
	WzQf7b9GrFozpLC+h2vTGeHkJpStwagNLrI0KDh/48s/0K8eOi4HgpQwlN6FdP87MFmeU+00xer
	e9XhRERhy95YY7tqUKzTQcFeXfEngV1dMi8qbc9wGRw4Yr8MwizPyA06M58CiWWGZYI6hzKM3Yd
	jU9CoeFLMkXx8dWhm9kDHzOtNW1yntkVb5QD0oncZwqWRaPqkz6kvtYAHhTEH0zDIv5sjItKwaJ
	9lQO0hRjNrYFcVFICAWxELupPXKVAhk581PfRszcIdI/smzlGm4v8c+QzZs3jxdsgSuC+yxkHnE
	MnpbqRjbRSw9m4kVIzlM7vKUtDCLyNb4qQUDpC8XRAKRsf3i8+TnbcFUM4gb/LZe1HWV4Eoy6i6
	70=
X-Received: by 2002:adf:fc12:0:b0:43d:6f0f:32fe with SMTP id ffacd0b85a97d-43d6f0f3403mr253339f8f.31.1775909401550;
        Sat, 11 Apr 2026 05:10:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm16293367f8f.35.2026.04.11.05.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:10:01 -0700 (PDT)
Date: Sat, 11 Apr 2026 13:09:58 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: deller@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, edumazet@google.com
Subject: Re: [PATCH] net: Optimize flush calculation in inet_gro_receive()
Message-ID: <20260411130958.70202bab@pumpkin>
In-Reply-To: <20260411052037.2013228-1-kuniyu@google.com>
References: <adkMqgP6QeBPgqP9@p100>
	<20260411052037.2013228-1-kuniyu@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277695-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,apana.org.au:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38B043DFAB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 11 Apr 2026 05:19:35 +0000
Kuniyuki Iwashima <kuniyu@google.com> wrote:

> From: Helge Deller <deller@kernel.org>
> Date: Fri, 10 Apr 2026 16:43:54 +0200
> > For the calculation of the flush variable, use the get_unaligned_xxx() helpers
> > to access only relevant bits of the IP header.
> > 
> > Note: Since I don't know the network details, I'm not sure if "& ~IP_DF"
> > (& ~0x4000) is correct, or if "& IP_OFFSET" (& 0x1FFF) should be used instead  
> 
> ~IP_DF is correct (MF bit needs to be checked), see
> 
> commit db8caf3dbc77599dc90f4ea0a803cd1d97116f30
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Fri May 31 11:18:10 2013
> 
>     gro: should aggregate frames without DF
> 
> 
> > (which I believe would be more correct). Instead of possibly breaking things I
> > left it as is, but maybe some expert can check?
> > 
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > 
> > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > index c7731e300a44..58cad2687c2c 100644
> > --- a/net/ipv4/af_inet.c
> > +++ b/net/ipv4/af_inet.c
> > @@ -1479,7 +1479,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
> >  	struct sk_buff *p;
> >  	unsigned int hlen;
> >  	unsigned int off;
> > -	int flush = 1;
> > +	u16 flush = 1;
> >  	int proto;
> >  
> >  	off = skb_gro_offset(skb);
> > @@ -1504,7 +1504,8 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
> >  		goto out;
> >  
> >  	NAPI_GRO_CB(skb)->proto = proto;
> > -	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
> > +	flush = (get_unaligned_be16(&iph->tot_len) ^ skb_gro_len(skb)) |
> > +	        (get_unaligned_be16(&iph->frag_off) & ~IP_DF);  
> 
> I think here we intentionally use 32-bit loads:
> 
> commit 1075f3f65d0e0f49351b7d4310e9f94483972a51
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Tue May 26 18:50:29 2009
> 
>     ipv4: Use 32-bit loads for ID and length in GRO
> 
> 
> Before your patch, 32-bit load + bswap are used while
> 16-bit load + rol 8 after the change.
> 
> I feel the 4-byte aligned load + bswap is faster than
> misaligned access + 8 times shift (Is this internally
> optimised like xchg for a single word size ?)
> 
> Do you have some numbers ?

Check on some architecture that doesn't support misaligned loads.
Actually, aren't the accesses aligned??
Also on ones without 32bit byteswap (some do have byteswapping
memory reads).

Also you may not want to change 'flush' to u16.
On non-x86 it may force the compiler add extra masking instructions.

	David
 
> 
> 
> Before:
> 	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb))
> mov    edx,DWORD PTR [rcx]
> bswap  edx
> 	return skb->len - NAPI_GRO_CB(skb)->data_offset;
> mov    r8d,DWORD PTR [rsi+0x38]
> mov    r9d,DWORD PTR [rsi+0x70]
> sub    r9d,r8d
> xor    r9d,edx
> 	| (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
> mov    ebp,0xffbfffff
> and    ebp,DWORD PTR [rcx+0x4]
> bswap  ebp
> or     ebp,r9d
> 
> 
> After:
> 	flush = (get_unaligned_be16(&iph->tot_len) ^ skb_gro_len(skb))
> movzx  edx,WORD PTR [rcx+0x2]
> rol    dx,0x8
> 	return skb->len - NAPI_GRO_CB(skb)->data_offset;
> mov    r8d,DWORD PTR [rsi+0x38]
> mov    r9d,DWORD PTR [rsi+0x70]
> sub    r9d,r8d
> xor    r9d,edx
> 	| (get_unaligned_be16(&iph->frag_off) & ~IP_DF);
> movzx  ebp,WORD PTR [rcx+0x6]
> and    ebp,0xffffffbf
> rol    bp,0x8
> or     ebp,r9d
> 


