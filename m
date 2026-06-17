Return-Path: <netdev+bounces-300259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IptlN2EhM2o69wUAu9opvQ
	(envelope-from <netdev+bounces-300259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:36:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5537269CAFF
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:36:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GmIj67xG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300259-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300259-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B13AE30CC7CD
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFD939EF20;
	Wed, 17 Jun 2026 22:36:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95F34A791
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 22:36:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735774; cv=none; b=KplnD1B23CTJJShM48+WvxyZFsM4yQBpOAd2i8TYOct9qZEPCwYEKGD+LRwozsr0DbEvaIsSyTzdxET6fW2/ZpEMSyoP25MOm0y4bc67U3XwH10j98Y2n/iJApF5LAmF+FqUAPxRaVkVzlNjgzO4JkYmI9BzmkL2llCnWNMx5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735774; c=relaxed/simple;
	bh=XSYMRQH32F/uJP3xw7iXXHgT1MTNlHZM4pqtPNnSFw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaqD8Y4f/XtprZRojrmUM13amKjyJe4Uh41L/HjmmheQ8UjFNFhiu9kxMrE6bMuiNJWrI8pDm1lZJyPsPVFlw33DSgE1pIu1IF3Rcyx4q3WPlnrC51CLA2B4inRX3tjHPwqArNY0RDCtctOHR69t0/QzBmCuIJPROQjQf6J6/BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmIj67xG; arc=none smtp.client-ip=209.85.210.51
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6dcad6018so243389a34.3
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781735772; x=1782340572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BbZx62gInfdUQ9qJT2MwuFY2u0tYb8N/NOScZmlg1w=;
        b=GmIj67xG2iEkGEObMj3pRobNUgRHnAtLzWunb92JWrJnSE1SDMVOGN58YBARRlKWXP
         cItZfhg0NB/QWEeU6FcZUMP0PfrWs1HRwcM4JCH9qvza2BLuEWxOWOk1RcXBzeUCX+Q/
         aEi29uZIllAsyddV8F49BiFe0/VPUk/eICXBk9aJs9YMdPDC6McwNJJ4tCIzwHBje6JT
         f2kfV2getYsX009nLGe2VPoO9vAqZN0WUYv2CWXiiLL7i3s0Zo5KWZKeC8qG4ET1oq9r
         Amdf0+flIusaTXU2oDsd7qCWeROJSXwI88nSPGtbA9Ut1aGZ74beu6x+RAKfeEtk3A0C
         a86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781735772; x=1782340572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BbZx62gInfdUQ9qJT2MwuFY2u0tYb8N/NOScZmlg1w=;
        b=rls/L+Z7XUdWSIwcWlUu8ldPlvCYO2u7OSo7aoS3Ybebys4mwTFqlrzASOhLWE5kgo
         yF7DqxW1oTocDxrfZkhAeiOf0S8j+niNAOUq+FYPQ5qsIdVQCHUMQqF5FbtIN7+FCGfa
         +aag+wKyuoXNPyYwXEaKaZFJPPXG7yJLw8k6GJ6AT+fYQL1HRgjCY4MJ8qHEEXESjiqa
         rul8AEO3jM8X/KZHt6VDqqwD5spFYCW9RXEi6yj2dAGsYb0YMnxAESRCjoFsCLc33B8j
         xawqKGQGgyd41eu1+xbhkvyhsxCtYW7DCeqUlFk0m7ATgPRraXEMwEZL/Q/60cKCI7Nz
         JraA==
X-Forwarded-Encrypted: i=1; AFNElJ9YYHXaYm8NJqiu21Mm6+DXHnBXKVedgm4C5aG5Igbi/5IrxLZuWcShQPMW068ATqzizUFgPbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgOF2HJcrGwlQokYABA2rBF3ZZJcgX8ifnNxvyj3gBlDjY65I
	mhkKbUtbBlSNzLnvipAfNcnX7VdUbd7slAr+6gtmCe4d+ZxnUvAw2jkV
X-Gm-Gg: Acq92OFGMjKdO+PxVxnBH8fiEq57Ez+cHfSPOAiMrIPZ4FW9FHsR61QeI68dBD24oJU
	70hokN9KASu7SkJyor80kYK4NrLZDNQZ8Ku5v4FtXwIgE2YDWzvnx6gJmZW5i2wEowqEiliaaz8
	d7rVxMABb7ryYiLJCCkPlmZx+M0ZJh5Q+k7VHs/RmpUxlpJ4PQ5BI6mwGwYY4aMLEIChWrcRjEz
	0ICK14FgC+TjvvXWjk+h8Oekx31/dvY4azCsDPCwRd/Kactj8FfklHE8WDgRztqtnzgnWe7ufOe
	7jSBdC+0Og+1sfOBWQefIkGcLjChk/PnqBNr8YlK8RnJgUmNVzx0LLEy70tNpr2R8Lx1Ln8Rxym
	Ew6NeqWIwOZSTBpSgLL5KACosNC3fnDTJvDZwR82OZ1N5k6OVkvVnfYwadYDGGOy70DfywV6Fn3
	X/rBr+cy86/0M2N2ddEGC26hnPX/SfDs2ScmZNVaj1Ieg=
X-Received: by 2002:a05:6808:1526:b0:479:f9df:ab35 with SMTP id 5614622812f47-489570fb68dmr1054405b6e.42.1781735771665;
        Wed, 17 Jun 2026 15:36:11 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dda5f7csm7043629b6e.1.2026.06.17.15.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 15:36:10 -0700 (PDT)
Date: Wed, 17 Jun 2026 15:36:07 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf, sockmap: fix use-after-free when the stream
 parser resizes the skb
Message-ID: <ajMhV7O5YfYbwQzE@devvm29614.prn0.facebook.com>
References: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300259-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5537269CAFF

On Fri, Jun 12, 2026 at 12:35:51PM +0000, Sechang Lim wrote:
> sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
> to find the length of the next message. strparser assembles a message out
> of several received skbs by chaining them onto the head's frag_list and
> recording where to append the next one in strp->skb_nextp:
> 
> 	*strp->skb_nextp = skb;
> 	strp->skb_nextp = &skb->next;
> 
> and then calls the parser on the head:
> 
> 	len = (*strp->cb.parse_msg)(strp, head);
> 
> The parser is only meant to inspect the skb, but the program may call
> bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
> bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB.
> Once the head carries a frag_list these go
> 
> 	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail
> 
> and __pskb_pull_tail() frees the frag_list skbs that strparser still
> tracks through skb_nextp:
> 
> 	while ((list = skb_shinfo(skb)->frag_list) != insp) {
> 		skb_shinfo(skb)->frag_list = list->next;
> 		consume_skb(list);
> 	}
> 
> strp->skb_nextp now points into a freed sk_buff. The next segment of
> the same message arrives in __strp_recv(), which links it with
> *strp->skb_nextp = skb, an 8-byte write into the freed skb. The free
> and the write happen in different __strp_recv() calls, so the message
> has to span at least three segments before it triggers.
> 
>   BUG: KASAN: slab-use-after-free in __strp_recv+0x447/0xda0
>   Write of size 8 at addr ffff88810db86140 by task repro/349
> 
>   Call Trace:
>    <IRQ>
>    __strp_recv+0x447/0xda0
>    __tcp_read_sock+0x13d/0x590
>    tcp_bpf_strp_read_sock+0x195/0x320
>    strp_data_ready+0x267/0x340
>    sk_psock_strp_data_ready+0x1ce/0x350
>    tcp_data_queue+0x1364/0x2fd0
>    tcp_rcv_established+0xe07/0x1640
>    [...]
> 
>   Allocated by task 349:
>    skb_clone+0x17b/0x210
>    __strp_recv+0x2c3/0xda0
>    __tcp_read_sock+0x13d/0x590
>    [...]
> 
>   Freed by task 349:
>    kmem_cache_free+0x150/0x570
>    __pskb_pull_tail+0x57b/0xc20
>    skb_ensure_writable+0x236/0x260
>    __bpf_skb_change_tail+0x1d4/0x590
>    sk_skb_change_tail+0x2a/0x40
>    bpf_prog_1b285dcd6c41373e+0x27/0x30
>    bpf_prog_run_pin_on_cpu+0xf3/0x260
>    sk_psock_strp_parse+0x118/0x1e0
>    __strp_recv+0x4f6/0xda0
>    [...]
> 
> The same resize also leaves the head's length inconsistent with its
> frags, so a later __pskb_pull_tail() can instead hit the
> BUG_ON(skb_copy_bits(...)) in net/core/skbuff.c.
> 
> Run the parser on a private clone of the head when the message spans more
> than one skb and the program can modify the packet
> (prog->aux->changes_pkt_data), so a resizing helper can only touch the
> clone and strparser's head and skb_nextp stay valid. Single-skb messages
> have no frag_list and read-only parsers cannot resize, so both are still
> parsed in place. If the clone cannot be allocated, return 0 so the caller
> retries on the next read rather than failing the parser.
> 
> Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
> v2:
>  - clone only when prog->aux->changes_pkt_data (Bobby Eshleman)
>  - return 0 on clone failure instead of -ENOMEM (Bobby Eshleman)
>  - free the clone with consume_skb() instead of kfree_skb()
>  - drop the unrelated guard(rcu)() change (Bobby Eshleman)
> 
> v1:
>  - https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/
> 
>  net/core/skmsg.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index e1850caf1a71..97e5bc5f38c3 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1149,9 +1149,29 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
>  	rcu_read_lock();
>  	prog = READ_ONCE(psock->progs.stream_parser);
>  	if (likely(prog)) {
> -		skb->sk = psock->sk;
> -		ret = bpf_prog_run_pin_on_cpu(prog, skb);
> -		skb->sk = NULL;
> +		struct sk_buff *parse_skb = skb;
> +
> +		/*
> +		 * strparser chains the message skbs through skb->frag_list and
> +		 * keeps a pointer into that list in strp->skb_nextp.  The parser
> +		 * program may call bpf_skb_change_tail() and friends, which go
> +		 * through __pskb_pull_tail() and free the frag_list skbs that
> +		 * strparser still tracks.  Run the program on a clone when the head
> +		 * has a frag_list and the program can modify the packet, so it
> +		 * cannot drop frags strparser owns.
> +		 */
> +		if (skb_has_frag_list(skb) && prog->aux->changes_pkt_data) {
> +			parse_skb = skb_clone(skb, GFP_ATOMIC);
> +			if (!parse_skb) {
> +				rcu_read_unlock();
> +				return 0;
> +			}
> +		}
> +		parse_skb->sk = psock->sk;
> +		ret = bpf_prog_run_pin_on_cpu(prog, parse_skb);
> +		parse_skb->sk = NULL;
> +		if (parse_skb != skb)
> +			consume_skb(parse_skb);
>  	}
>  	rcu_read_unlock();
>  	return ret;
> -- 
> 2.43.0
> 

Hey Sechang,

I'm still on the fence about "return 0" vs ENOMEM. I hate to flip-flop
on you here, but now I'm not sure if it is worth the complication to
return 0 since we're really only buying a single timer interval in which
we need 1) suddenly more memory to alloc the clone, and 2) another data
ready event to cause the stream parsing to pick up again. If any one
doesn't happen, the end result is the same. Not sure its a good
trade-off for the complexity of basically tricking the caller with the
zero return. Maybe let's go back to ENOMEM?

BTW, based on the comm name "repro", it sounds like you have a decent
reproducer for this. I wonder if it is possible to add something to the
selftests to catch this?

Best,
Bobby

