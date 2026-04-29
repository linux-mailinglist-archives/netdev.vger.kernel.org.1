Return-Path: <netdev+bounces-282498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAUPOtRz8mkHrgEAu9opvQ
	(envelope-from <netdev+bounces-282498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:10:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B2A49A745
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34517300CC1E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D3378D94;
	Wed, 29 Apr 2026 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxHSd2Wh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6283D3264FD
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496950; cv=none; b=ZCguaHfruW8s3I4sA0C04MK9fpQ8NwQn2gjEOURUcvReXd2p4Tgke80w3ceQquQxVGy+JYoaQvQEpsMB3vdYtvC53aXkUSy5/IloDPMSWJZlyYkx6JiB2tudAixL80urtm7+PqYCYBfwkm85Gxg9bolj+YhTy5HG633yXbtHvOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496950; c=relaxed/simple;
	bh=UFpatwj302ooIoSTMCDRgNXLF0E8dLk7xu4f92YyJA4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aWdpTIh4PWyFf6zWQ7ssW+upjV5oMXnUeRn8N9Idzy8cCrQm+bvetX6sbSO/A5fBw3PA1G90MyY786yiYhf6w4u3bnVMuojVDD9ppdbN25CUGHkc1fMFr2+W39UUBL88D72g9UQ1zqsmlWAOtf96Tz93wa4y1EQ71UzVdwjKpAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxHSd2Wh; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79db5e18ac6so17693827b3.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777496948; x=1778101748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziZ3tCRGzZjxYLboYyA+tgZbUj+IJ+/nDStX2GMuYXA=;
        b=FxHSd2Wh0laWZ4g2BcL9ooeRQ4RSG3G5DDAaJeaDUnjJUOsfxb1HpcT811rsXptHK1
         s4d8B3OKzpux+Z8ujHASvYfCOCsaeOa5rienf1ajcNcGKl+ab2zrCp5cyk7I+7Vu9TkB
         L1kcekRfWFv/mD1X7FURbfa0G24M87CUXUuNXD07tNPZFXfe/rvYvmE5A0EpHeZA68Hc
         CC/NfwTRqG9dwEiNe54k2o39HIpsl3uPhg8SEuCzPupO4BMnMuiaYDRB+ymSMaLXkePu
         fQDnUdVwd7chC2XZiZLu4siRzkw7eXWhLF/C/jBvnrECkvdwkVQgbSsiyKbU3BlYyv/Z
         LkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777496948; x=1778101748;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziZ3tCRGzZjxYLboYyA+tgZbUj+IJ+/nDStX2GMuYXA=;
        b=NpIETPS/tmX1lWVznHvg2s1XX3pzJxOqF0tH56x7MoBM0O0jkVIMuFB00+gVu6OdlZ
         u8qAweCmO6r3Hawdejh76D4F7wBrFuEryGSlG7vLMqePLlcHFAnIkAnsVV4a/ZzPwDyW
         /Bmoowr79Vbe98g0at0U0tOu8L4CJqFZxn1VdjgByfzsRdjH8t8uS43fYCyfUb8vJXVI
         kNm9S7TZ54blQrPLcPZ2cIgUc9h0xSforxuE9YWIJFZe7Hk+H4Pj8m+D/R687PGfmG25
         RYET9QN34Kvi34zOwJABif2cRVhgFFy7PBkVB6TJCoxKijvXrF5+6t577S4XqY+3kQlh
         sFMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rs2Cnz9vYZXHiBQllhFcpVUg9p6bXMi2Z5YPj8R0E7JZHDu0jao44StGZEsHaA1lxorFvisM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+goRck34A7xM8gV25VLTlYcXhEGrUF3bqnzXtCwoaROqiu5RP
	tTbkKILZUkVXz4reps+M8q4rPAEo4SGArPcaXg27vVa5izNlT3J27EaF
X-Gm-Gg: AeBDieu4JH30NArjKQUIcVES6/7wsJhJlFl53Oixd7KKIM7ORWn5bAvXCkCTAF3IMba
	ZyzjrD090LZ3kXaSUtYIRe/85qsbNJDUU/fREGmBj0jdkJjBKz6UuVhpfIVcg/xtqWSN+M2bMwq
	LfRGXw0p4zgeDRPt7vsZ12vsMZbncDs5hypyxKTPE8LLGx0WveH3+R7wZZHjgG5WkLdrIFle/2/
	mSxmH+PdrR9AH8L5nqbczFajIhAIzB2gEHjO56fXPCZ5ToKEMGceFGtwdckhNsBjSxkMz21cG7H
	wQ6tPT1DtBb/d+f2WUMGAkB306SwdGTNgNViHK8hWERXqNB9SE0YSKnIYRZwdx3XLtMwmh4EG6a
	uUqKlQaRzOlKNDqnHZ5/jVpXOn4FgMNpqF3VN5NMrIRfzRmNJSAbCdr2GKZdu678W0nEkcEOBfg
	SHwnc/zdT6iyd4ih3fmw5a3ZUX5Gt0e0ZX9vDhs47EFo0MWiDo6MmQZjfqXvOeH7OOzkH6NySdH
	rDoArbumfwWERaswm7nB2ZwJA==
X-Received: by 2002:a05:690c:6610:b0:7b4:6f40:639 with SMTP id 00721157ae682-7bd26720337mr37106307b3.17.1777496948463;
        Wed, 29 Apr 2026 14:09:08 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd544702e5sm332737b3.44.2026.04.29.14.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:09:07 -0700 (PDT)
Date: Wed, 29 Apr 2026 17:09:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kohei Enju <kohei@enjuk.jp>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Gerhard Engleder <gerhard@engleder-embedded.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Kohei Enju <kohei@enjuk.jp>
Message-ID: <willemdebruijn.kernel.2345608a210cc@gmail.com>
In-Reply-To: <20260429091632.26509-4-kohei@enjuk.jp>
References: <20260429091632.26509-1-kohei@enjuk.jp>
 <20260429091632.26509-4-kohei@enjuk.jp>
Subject: Re: [PATCH net v1 3/3] tcp: use skb_get_hwtstamp() for hardware
 timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 42B2A49A745
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282498-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,engleder-embedded.com,gmail.com,enjuk.jp];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:email]

Kohei Enju wrote:
> Since commit 97dc7cd92ac6 ("ptp: Support late timestamp determination"),
> skb_shared_hwtstamps may contain netdev_data instead of hwtstamp. TCP
> receive timestamping can then interpret the stored value as a ktime_t
> and report bogus hardware timestamps to userspace.
> 
> Use skb_get_hwtstamp() instead of reading hwtstamp directly, so TCP
> sockets follow the same hardware timestamp resolution path as the socket
> layer. When coalescing SKBs, resolve late timestamps before copying them
> to the merged skb.

Why? Does this preclude supporting SOF_TIMESTAMPING_BIND_PHC for such
sockets at a later time?

It is just as easy to coalesce the cookie as the htwtstamp.

That also avoids the need to mask out SKBTX_HW_TSTAMP_NETDEV.

> Additionally, recognize SKBTX_HW_TSTAMP_NETDEV as
> indicating a receive timestamp is present.

What is the reason for this extra condition?

> Note that skb_get_hwtstamp() is called with cycles == false, since TCP
> hasn't honored SOF_TIMESTAMPING_BIND_PHC so far, and this patch doesn't
> change that behavior.
> 
> Fixes: 97dc7cd92ac6 ("ptp: Support late timestamp determination")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  include/net/tcp.h    | 2 +-
>  net/ipv4/tcp_input.c | 3 ++-
>  net/ipv4/tcp_ipv4.c  | 6 ++++--
>  net/ipv6/tcp_ipv6.c  | 3 ++-
>  4 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index ecbadcb3a744..7b5fcee97079 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -524,7 +524,7 @@ tcp_update_recv_tstamps(struct sk_buff *skb,
>  			struct scm_timestamping_internal *tss)
>  {
>  	tss->ts[0] = skb->tstamp;
> -	tss->ts[2] = skb_hwtstamps(skb)->hwtstamp;
> +	tss->ts[2] = skb_get_hwtstamp(skb, false, NULL);
>  }
>  
>  void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index d5c9e65d9760..9fd473559b58 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5237,7 +5237,8 @@ static bool tcp_try_coalesce(struct sock *sk,
>  	if (TCP_SKB_CB(from)->has_rxtstamp) {
>  		TCP_SKB_CB(to)->has_rxtstamp = true;
>  		to->tstamp = from->tstamp;
> -		skb_hwtstamps(to)->hwtstamp = skb_hwtstamps(from)->hwtstamp;
> +		skb_hwtstamps(to)->hwtstamp = skb_get_hwtstamp(from, false, NULL);
> +		skb_shinfo(to)->tx_flags &= ~SKBTX_HW_TSTAMP_NETDEV;
>  	}
>  
>  	return true;
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 8fc24c3743c5..c35d82317764 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1993,7 +1993,8 @@ enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
>  		if (TCP_SKB_CB(skb)->has_rxtstamp) {
>  			TCP_SKB_CB(tail)->has_rxtstamp = true;
>  			tail->tstamp = skb->tstamp;
> -			skb_hwtstamps(tail)->hwtstamp = skb_hwtstamps(skb)->hwtstamp;
> +			skb_hwtstamps(tail)->hwtstamp = skb_get_hwtstamp(skb, false, NULL);
> +			skb_shinfo(tail)->tx_flags &= ~SKBTX_HW_TSTAMP_NETDEV;
>  		}
>  
>  		/* Not as strict as GRO. We only need to carry mss max value */
> @@ -2062,7 +2063,8 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
>  	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
>  	TCP_SKB_CB(skb)->sacked	 = 0;
>  	TCP_SKB_CB(skb)->has_rxtstamp =
> -			skb->tstamp || skb_hwtstamps(skb)->hwtstamp;
> +			skb->tstamp || skb_hwtstamps(skb)->hwtstamp ||
> +			(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV);
>  }
>  
>  /*
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 2c3f7a739709..3361ed7f94de 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1704,7 +1704,8 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
>  	TCP_SKB_CB(skb)->ip_dsfield = ipv6_get_dsfield(hdr);
>  	TCP_SKB_CB(skb)->sacked = 0;
>  	TCP_SKB_CB(skb)->has_rxtstamp =
> -			skb->tstamp || skb_hwtstamps(skb)->hwtstamp;
> +			skb->tstamp || skb_hwtstamps(skb)->hwtstamp ||
> +			(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV);
>  }
>  
>  INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
> -- 
> 2.53.0
> 



