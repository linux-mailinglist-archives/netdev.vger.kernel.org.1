Return-Path: <netdev+bounces-300287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eTgYJSA7M2ox+gUAu9opvQ
	(envelope-from <netdev+bounces-300287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 02:26:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7D69CE1F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 02:26:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GxltQFk5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300287-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300287-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C90CF301C4AB
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C51523394C;
	Thu, 18 Jun 2026 00:26:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92D15E8B
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 00:26:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742362; cv=none; b=jxTxskhoULLRCrNyNGa3In3CfMgHEmAAKDTvJH7dMAd2DZXYb1yZN4Rg9s7aNle6v++pvo1jhYt4hJnx1RWqlhxH7r5qI/NpVE+TjbXbCe9+tAlStYZHD5aGvFi2AoWC4+fg11L6vxUjsU8WxxR0bpk20iErM1igQRjuO3GWWNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742362; c=relaxed/simple;
	bh=IaxSBDr03P8BBiR/G3886M8Ma5cyVQXqRTT4MJa/o/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A3IOjp8z8lX4y8JBHbmsrm/ywGBN+Obe4iXOpeDA9MxhYhLuNoEo0ZAwTAq+/cvc51A171Ews8K6ZFpfRlN7+wCzVEyVcwPmW8UUeESN4kWbKLQvcS+sKgtwyBC2bCHHIkIhI++43STf+/3fm52n9Kuk92hrXXLA9VEjN7NEk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GxltQFk5; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8895156101so247194a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 17:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781742360; x=1782347160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCx80f7cZNUeuP+8DK2ePRZ7RWzQXES0UffqVXsTtbI=;
        b=GxltQFk5a6NNWVu5RsKwp/UXv2lQ6kSFQ1HREWUMj35NWZR3k+JrWNisZJhnoeGwPB
         BA12Saw6rAEunnZDhzwgChp5NDyMhHdHUS33ml1PZDucWLPG83akDUfTrNLzaYJmC9AZ
         VXE9/LK1Gr0oR/kCSNbRBNpNm967HRCB1k+T9e2TTE7E+Jjy1wC/hS4YNLnfhxKipC11
         MnDaFPBCvRpRHpJN5gcCRGdAqRkmZAqcBNDwfeynxFYbsFPikLAZ9cunYnlIPaDRhu1/
         +ViaX0SYieX8ArDowotXDKmw27W8BNNiLkFzwsgpVF2D+FdbfvpufNiNwNVGacr5jaV2
         Yl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742360; x=1782347160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCx80f7cZNUeuP+8DK2ePRZ7RWzQXES0UffqVXsTtbI=;
        b=pFEy4RQyO1BsFok+45cR/7C+sfCVyvtQVJvxNY3ww3gVNZ9SyFl1lJ4SGiOViSjjLL
         EeCXrGBz1+B/GrBsfkVLnJsXaF5879HJAmdkUizWBLyMkhhcB7ShZXCVUqPKZ8rnnAed
         +/zcUhc8WiORulnylIp0B08EkFKWTa7y5mqOSUlVSzMvXTXBEb9DbcufHb7W0YVzYwab
         RM1mpgtkHI/jufzw6WVNe2v23O0CLx1MPZhi3r2mBwWFICOWxOFoj4jS72rKKRXy8Vrq
         GaNNSCjb7dONfacTV+tA2QGxD2TBEjknmGG06tbDmo2EjKrLM+kB+Gjbl+sebEuYgyrg
         Xncg==
X-Forwarded-Encrypted: i=1; AFNElJ+4V2PXCg02BARrLQhiScYtm7Kf+AnmXLwMRdnYreBoZDPpBMAgdyBOV4s6BZuimB2IYB0v3Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpgRoy/7i3zleh1X0tm4Kua+h4Ap1EN7i4JeLGCMRWvaUNUFh
	mEZWBdrZh8aLZu9DvYRlfMmfAx6WZtlOZcPF8B0Jp+hgKCCbmh+6UeB9dOmVAxRSb2jmUSZkezu
	GQSXpoQ==
X-Received: from pgah15.prod.google.com ([2002:a05:6a02:4e8f:b0:c79:7757:4178])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:329e:b0:3b4:5c6f:cf30
 with SMTP id adf61e73a8af0-3b9e81f8091mr1492708637.38.1781742359992; Wed, 17
 Jun 2026 17:25:59 -0700 (PDT)
Date: Thu, 18 Jun 2026 00:25:57 +0000
In-Reply-To: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260618002559.1479884-1-kuniyu@google.com>
Subject: Re: [PATCH bpf v2] bpf, sockmap: fix use-after-free when the stream
 parser resizes the skb
From: Kuniyuki Iwashima <kuniyu@google.com>
To: rhkrqnwk98@gmail.com
Cc: bobbyeshleman@gmail.com, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jakub@cloudflare.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300287-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:bobbyeshleman@gmail.com,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cloudflare.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97A7D69CE1F

From: Sechang Lim <rhkrqnwk98@gmail.com>
Date: Fri, 12 Jun 2026 12:35:51 +0000
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

It's bpf prog's responsibility not to abuse them.

Even setting aside that, why not simply block such BPF prog ?

It cannot be done at load time, but doable at attach time.

---8<---
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 630d530782fe..4d60b77da8ef 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4556,6 +4556,12 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 
 	switch (ptype) {
 	case BPF_PROG_TYPE_SK_SKB:
+		if (attr->attach_type == BPF_SK_SKB_STREAM_PARSER &&
+		    prog->aux->changes_pkt_data) {
+			ret = -EINVAL;
+			goto out;
+		}
+		fallthrough;
 	case BPF_PROG_TYPE_SK_MSG:
 		ret = sock_map_get_from_fd(attr, prog);
 		break;
---8<---


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

