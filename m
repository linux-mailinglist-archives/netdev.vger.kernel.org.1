Return-Path: <netdev+bounces-278370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOP6KasK3mnRmQkAu9opvQ
	(envelope-from <netdev+bounces-278370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:36:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 476113F8031
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A313300D364
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519873C873B;
	Tue, 14 Apr 2026 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWhOovV/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991C3537D7
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159399; cv=none; b=IvFBg5bYix+22fWT0YsWei2GXytWpk7uMcYls69yGfYtOmEbXI+a4Na0fsgsH0G8lx4Zk4pB/OerRb0pLu1ww6tOewzATMobvBr7UPr+OcNqytyyz4YunGWfAXZtOmugMcmAM5rBfjFfnOQGkgZro0yA5H4NbnBB8aafmqErbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159399; c=relaxed/simple;
	bh=nzL0YYHEnSV/CtY6irVVvj4bmdP4UlYcFw9M5mHcvfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCqvBJ8cFNpCWheTvbxGtFdGYpz07CydaRWPVzqa9nmEZ3LgaLiCpu+2e1YqFO640uWvWvBu1kbCwhKYq3EXy8aJqrKidNbEnEb52/X5G8Gvz1P15Zw5PzJ9Pg8npOkErvZyNiggUAn8eplvTFVi4nqQrlFzVaewNPVtWg9b2zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWhOovV/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so66536215e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776159396; x=1776764196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aISHfLM92ahZPcl51zWVvDvh3fGxj28STwPGxLZW/1Q=;
        b=EWhOovV/TQkKgEEWxSOvqz9CFiuM7rfdN5wA0z654rBqxw8VIzUhAkri9Ef//u49L7
         OakEJb6fGmO8OQi+apnsRHNorA69jYoLx9dloW2RKJGt5/0mSn+fiqHXtsE+BHO26y2h
         cU+hY1nVSa8BWUgDZxCGxZ/THlSdQwLBTIIMxWwFSsHH9CXYD5HGEJvWbohKCsnMCqoB
         KRI9sK6ZysfgsgQRlgiy+6Gt24BtE79oDRHV8mOne8HH7kAezIdFl+YFFLhbJYNkFtYM
         5l0bcrLUeZbtva8vKITJ+L0xKvxAGuKN89L1z6CogxUyE9xvlt9FlP8FqX8Eh5J0NLNg
         Vs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159396; x=1776764196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aISHfLM92ahZPcl51zWVvDvh3fGxj28STwPGxLZW/1Q=;
        b=nRm19d1Oai+0PuFEOkW/ieSTYRseIvuTZnQnepOgWJXH6mazBjMUHIkFcVXoNpcvCp
         qhbw4GCrUSHJkuJs+bmld/rx+SrTeEiNR6i4jphluH9SnvxaZl7Fte90iR8O2pyqWq6V
         A1c3tVdoLx51+XHtorPdv6oBWZ6Z7mmP/9QiD/hhZr2f1+4GVoQxurE0HFIdZCAyxzhm
         wQueAyl5DkMXxOiYBcO8eQmPzVd7+TMsG/I0Yz4+MBRJGFUCZSZnFWyd9/Mpoe2tMhZU
         csohR9zCMVCfvhUX17ZMi5KINQqnlExyIckIshZV8na/1eDBGJ9usA00cqM4nGcUlFVi
         Q99g==
X-Forwarded-Encrypted: i=1; AFNElJ92lgupW+gew0pJ+WoA45km0kcuGjOdSvF9o72hDFDstRKW5R5/mqTJUP75fauTSPQH5Vw3qcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi8k4q36R8PmUMXz97eQwYMgvI9FSCkYzd91ywbjhZFW3xU8kN
	ggaS8uG0VS7WX85uFyt41i0P4tgwGf/gFgEWe1d07CQX8JdoIi4r4sV5
X-Gm-Gg: AeBDietYmMrUtIkNvtroNAtICun8oONR6nCn0Nzo9qZn7+kWgyCkYBOhrxzRLmRyXPx
	whFjbfrvgjbGMgZ8Qq4VXzG/nCI5GAzzsysA7lbECXcDnhXsB82093evFVc2j9cch/0DjBZMuoq
	QRQFNrhClHMHImhNJ9BQMyHWfdHONKzNjZfn8SpVRWL0Z5qwvQUZkcdzqFixT8QiwLHiCdkb8Mc
	ADlJCM4olqMU9/vsTY9rA8WV6O1hCcpnx58rqCHir+OVl90lzNg+/WRTZ36HuhL6MtIrX38rHIN
	EmCwMvQFRpI3E8OQmIF0YoldwXu6ZUGLsCBmh1cyN/RX9a8WSUQuGQ94Ql+AH5MrzTD0/OJCivW
	l5fLCTjcbCEoK+CpvAUn5hRFbz+n33USAtr61+HqTEVGmV1xkwSmNjXj59AgU1Ij5JofCaca1Wl
	hLgco34p30nahCeQmkS3noyJhP1t0ogsw/8rQ69XF/RzrDktVAAaDA3q/85E2p8ROfpUsHwpK68
	5g=
X-Received: by 2002:a5d:5d0b:0:b0:439:b55d:b0e5 with SMTP id ffacd0b85a97d-43d642a7a61mr25526086f8f.28.1776159395782;
        Tue, 14 Apr 2026 02:36:35 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec27fsm38828992f8f.11.2026.04.14.02.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:36:35 -0700 (PDT)
Date: Tue, 14 Apr 2026 10:36:33 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, deller@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com
Subject: Re: [PATCH] net: Optimize flush calculation in inet_gro_receive()
Message-ID: <20260414103633.4d5fe92a@pumpkin>
In-Reply-To: <49c05cd8-5ad0-4015-8f55-fed3416784bf@gmx.de>
References: <adkMqgP6QeBPgqP9@p100>
	<20260411052037.2013228-1-kuniyu@google.com>
	<20260411130958.70202bab@pumpkin>
	<49c05cd8-5ad0-4015-8f55-fed3416784bf@gmx.de>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278370-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 476113F8031
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 09:46:55 +0200
Helge Deller <deller@gmx.de> wrote:

> Hi Kikuyu and David,
...
> >>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> >>> index c7731e300a44..58cad2687c2c 100644
> >>> --- a/net/ipv4/af_inet.c
> >>> +++ b/net/ipv4/af_inet.c
> >>> @@ -1479,7 +1479,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
> >>>   	struct sk_buff *p;
> >>>   	unsigned int hlen;
> >>>   	unsigned int off;
> >>> -	int flush = 1;
> >>> +	u16 flush = 1;
> >>>   	int proto;
> >>>   
> >>>   	off = skb_gro_offset(skb);
> >>> @@ -1504,7 +1504,8 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
> >>>   		goto out;
> >>>   
> >>>   	NAPI_GRO_CB(skb)->proto = proto;
> >>> -	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
> >>> +	flush = (get_unaligned_be16(&iph->tot_len) ^ skb_gro_len(skb)) |
> >>> +	        (get_unaligned_be16(&iph->frag_off) & ~IP_DF);  
> >>
> >> I think here we intentionally use 32-bit loads:
> >>
> >> commit 
> >> Author: Herbert Xu <herbert@gondor.apana.org.au>
> >> Date:   Tue May 26 18:50:29 2009
> >>
> >>      ipv4: Use 32-bit loads for ID and length in GRO  
> 
> I see, this patch is exactly the opposite of mine.
> 
> >> Before your patch, 32-bit load + bswap are used while
> >> 16-bit load + rol 8 after the change.
> >>
> >> I feel the 4-byte aligned load + bswap is faster than
> >> misaligned access + 8 times shift (Is this internally
> >> optimised like xchg for a single word size ?)
> >>
> >> Do you have some numbers ?  
> 
> No, I don't have.
> In the end it's very platform specific anyway.
>   
> > Check on some architecture that doesn't support misaligned loads.
> > Actually, aren't the accesses aligned??  
> 
> The reason why I touched this code at all, is because I got unaligned
> accesses in that function on parisc.
> But those unaligned accesses were triggered by parisc-specific
> inline assembly, and not by this code here.

The network stack is supposed to ensure that all receive packets are
aligned to that IP header is on a 4-byte boundary.
This typically requires the ethernet receive buffer be 4n+2 aligned.
Unfortunately there is some ethernet hardware that requires 4n aligned
buffers (often on SoC devices with cpu that fault misaligned accesses).
(Just writing two bytes of garbage before the frame solves the issue.) 

> So, I believe those accesses here are aligned, and the get_unaligned_XX()
> helpers make the code more readable, but are NOT necessary.
> 
> That said, I suggest to drop my patch.
> It makes the code more readable, but probably will not improve speed.

I think the purpose of the change was to use the hardware's 32bit
byte-swapping memory loads rather than software swapping of the 
16-bit items.
That shaves off a few instructions - and they can be measurable
in some of the network paths with specific workloads.

Remember, save 0.1% 100 times and the code runs 10% faster.
Every little bit can make a difference.

	David

> 
> Thanks for your help!
> Helge
> 
> > Also on ones without 32bit byteswap (some do have byteswapping
> > memory reads).
> > 
> > Also you may not want to change 'flush' to u16.
> > On non-x86 it may force the compiler add extra masking instructions.
> > 
> > 	David
> >     
> >>
> >>
> >> Before:
> >> 	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb))
> >> mov    edx,DWORD PTR [rcx]
> >> bswap  edx
> >> 	return skb->len - NAPI_GRO_CB(skb)->data_offset;
> >> mov    r8d,DWORD PTR [rsi+0x38]
> >> mov    r9d,DWORD PTR [rsi+0x70]
> >> sub    r9d,r8d
> >> xor    r9d,edx
> >> 	| (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
> >> mov    ebp,0xffbfffff
> >> and    ebp,DWORD PTR [rcx+0x4]
> >> bswap  ebp
> >> or     ebp,r9d
> >>
> >>
> >> After:
> >> 	flush = (get_unaligned_be16(&iph->tot_len) ^ skb_gro_len(skb))
> >> movzx  edx,WORD PTR [rcx+0x2]
> >> rol    dx,0x8
> >> 	return skb->len - NAPI_GRO_CB(skb)->data_offset;
> >> mov    r8d,DWORD PTR [rsi+0x38]
> >> mov    r9d,DWORD PTR [rsi+0x70]
> >> sub    r9d,r8d
> >> xor    r9d,edx
> >> 	| (get_unaligned_be16(&iph->frag_off) & ~IP_DF);
> >> movzx  ebp,WORD PTR [rcx+0x6]
> >> and    ebp,0xffffffbf
> >> rol    bp,0x8
> >> or     ebp,r9d
> >>  
> >   
> 


