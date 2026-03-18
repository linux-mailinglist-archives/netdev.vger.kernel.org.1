Return-Path: <netdev+bounces-269177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAktLPYEu2kgeQIAu9opvQ
	(envelope-from <netdev+bounces-269177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:03:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C02C24FA
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41F3430244C8
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59473E6386;
	Wed, 18 Mar 2026 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbKs5NPK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A2314B6E
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864178; cv=none; b=ecAE+p0rVrEyvkV7n7a/F3JwPQtyc2dF2kFwIfTtVh+uHkrAonqM2J4+RUrZ6aoUscsCPBOoX0tz1sfvkgYnnkEGgFn9/i5fWw4GaELxUDOzsGyhTDKwG6y0vWoBVZJXTmK3r5ZJG8GZ519vZ5rRIweH4RdYJ6pJcOmgXdJ0dCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864178; c=relaxed/simple;
	bh=cMCaVXNr7qfEfiS9Zxjes22PtZsQF6QDYQ+CpJPrpvo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mmGWISvKfTJwBvLlxIEXkxzUtK1GqjVRP9/40t/sISIhOvWjWJ08XZZNRHWOMYT+rcJ3HhIV6o5g0BrTj9gSwcmiclt78EoHZ+R05q5BzLcImuRCSRfgiBqK46/C9MozItTSD/q9fXnU0PtO93rTfzUMSMIm66CjrJVDRNyHTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbKs5NPK; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ca423ad53so418904d50.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773864176; x=1774468976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BGJyg89KVjKDhlLon0g7DLh+7sfd3j1XaPbD798/2Q=;
        b=JbKs5NPKR+VmuZ5DA58w+uFYFmT/HICtg4kwVVIG0QsZDZGeFIGmFlLmt0AIqtxJiL
         MTjP4+n8mL4LCk/0Wbkcz15HidudHCX9vwXeXRYehAXKLxV7YEcU9zC3CS0DQn44Lk/f
         QDtDrYCLtdYiSy8oupHW/NDpxJjUXT+aU9Jhc5jzJt1SVETOjyRkqrrSV8xhp/E//+bE
         jg/wo1w3fUhWHWoHu1ku9nWMYv+uWdbs7m8zFNcIZMsOa/GJOS3DNlGkvhRGl+jujRUh
         95usvCWmGIVtKVTW09SRaCssrL02vKWxhkfJeHWugGkix3iUX6eHpIesrR3HMKXe/qsR
         6ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864176; x=1774468976;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BGJyg89KVjKDhlLon0g7DLh+7sfd3j1XaPbD798/2Q=;
        b=S4TgQFJTWcWjCPQYTgA5ppUNbbGmZwbZuWlp6mrwayOZ6Z14KGa64Hi9+Kbcqcv6Rf
         poUF9XMnZUL5uK/HMWCULTkSzqKVzzNQSK8K0by6gddDJK8LiNKNEV/NhA0vEbVK8Vr1
         GQiHRKWpYtvKOljwqYdyI+Hgm2U9GtM8z2h9201eloAz0CX7Vmahf2h0jdGAOytGH2N+
         a289FtTmcwIkM4CdRvRd/H26Qc5gYeWczrYt1kyItbPnsnHJAVwfgr9NdpZ03Vo7CemE
         bIcoNY0wfqIrr7wPWIubaj+u6zzTqaHTZEsrhO3TllnkJqHAKJnsEsDjlSw3OGZYgULY
         /YKA==
X-Forwarded-Encrypted: i=1; AJvYcCUaeX6DVfp7ML5lZl+laM97c2/8x6OUic4xZiDikUQek5BeQpOepjgEMjLfI9MDRReL5QQJnhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5bVSQhv9DSvmsXFbmDVAtkbhFpz3X1s2BrYyu8FuLW/7TzmqH
	G0U/DxkT4Sr+YKo6T2KDYPCB6Zh8tZo0cpOG3s6907VObayQROOnJ5YT
X-Gm-Gg: ATEYQzzxSE/qvifEMF+TdUulrk6qXI6Gca3KqvJw/FqwCuhRv/WnlJTQOGUrGMKhU8T
	kHbsTdZLABGyUFRy30UxVBqWUymeKzcpDkje5gBhdxWQvVvSJMrzvvtOQQofgu/Utnet2h/0Ebd
	F37U70rAxXY5cjbjdmdRHsx+5FI1ZIBE8ku1wOc114/6ioyQ/ZuZKsHoKTcCQq//QV+68TXWvnL
	C5AkpNGRVs3o8hnH1rSaXpO7+v469Y7uPcAOdH3oAUQ32+1IewcwsNm0OQ1HSURuRaan8XqsD7y
	S1SI/Cfem2yGVyLb3UKhZ1VHdVcHmT39fvLVPin4j7JFqMWwqOvjIfU3p3XxT9mf/lE0mwiATtp
	W2TXurNQoU1kzjke4S7rspwCDAFeRj3igLRr56vvxrvFQniKH2heYYWv2oPpZQMgFf8Df3D9Cg8
	lBzjuzLyQaheX6Bt9gxvjZ0/VmMATMZfEZgO69isV6c3qwCHK4IoEFnLd9HL9Q0iW/AzCflkuc0
	ikM
X-Received: by 2002:a05:690e:389:b0:64c:2207:52a3 with SMTP id 956f58d0204a3-64e916162camr3569426d50.64.1773864175609;
        Wed, 18 Mar 2026 13:02:55 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64e91be032asm2180679d50.14.2026.03.18.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:02:55 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:02:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.26b750d5f8926@gmail.com>
In-Reply-To: <20260318134242.2725749-5-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-5-nhudson@akamai.com>
Subject: Re: [PATCH v2 4/5] bpf: allow new DECAP flags and add guard rails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269177-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,linux.dev,iogearbox.net,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.101];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,akamai.com:email]
X-Rspamd-Queue-Id: 507C02C24FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> Add checks to require shrink-only decap, reject conflicting decap flag
> combinations, and verify removed length is sufficient for claimed header
> decapsulation.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>  net/core/filter.c | 47 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7c2871b40fe4..47aec44a9cd3 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -56,6 +56,7 @@
>  #include <net/sock_reuseport.h>
>  #include <net/busy_poll.h>
>  #include <net/tcp.h>
> +#include <net/gre.h>
>  #include <net/xfrm.h>
>  #include <net/udp.h>
>  #include <linux/bpf_trace.h>
> @@ -3496,7 +3497,9 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
>  					 BPF_F_ADJ_ROOM_ENCAP_L2( \
>  					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
>  
> -#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> +#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
>  
>  #define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
>  					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
> @@ -3743,20 +3746,44 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>  		return -ENOTSUPP;
>  	}
>  
> -	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> +	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
> +		u32 len_decap_min = 0;
> +
>  		if (!shrink)
>  			return -EINVAL;
>  
> -		switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> -		case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
> +		/* Reject mutually exclusive decap flag pairs. */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> +			return -EINVAL;
> +
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
> +			return -EINVAL;
> +
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
> +			return -EINVAL;
> +
> +		/* Reject mutually exclusive decap tunnel type flags. */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
> +		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
> +			return -EINVAL;
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
> +			len_decap_min += sizeof(struct udphdr);
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> +			len_decap_min += sizeof(struct gre_base_hdr);
> +
> +		if (len_diff_abs < len_decap_min)
> +			return -EINVAL;

Should this test come after the below IP flags?

> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
>  			len_min = sizeof(struct iphdr);
> -			break;
> -		case BPF_F_ADJ_ROOM_DECAP_L3_IPV6:
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>  			len_min = sizeof(struct ipv6hdr);
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
>  	}
>  
>  	len_cur = skb->len - skb_network_offset(skb);
> -- 
> 2.34.1
> 



