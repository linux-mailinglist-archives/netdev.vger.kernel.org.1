Return-Path: <netdev+bounces-259770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH6nJl3NmGmuMgMAu9opvQ
	(envelope-from <netdev+bounces-259770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:08:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A308F16AEAD
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2301B3002D03
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9C3309EE2;
	Fri, 20 Feb 2026 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVcFJgSw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343828632B
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771621720; cv=none; b=RQ2jN/ljawnq8XiJCDX3v9TWBHPcGCsA6aI5tn5UgP3uaIovDmnSzeoeoI5gyUVr0I26GLhurGHuOR1HrXsD5wXqTsaj3swXBF3aqtndqfCICxjx02kmRmWyuDccZynPtmoHBDBzbcbivCcLAz56xuREuVaMXAVf3J+Btm/itt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771621720; c=relaxed/simple;
	bh=/8HvE3vCxdzdWm/JsStTvcluTkDHCiHnP72zux1Mdms=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PJrMomtBDCzZNKOmSt1a2zxW8ZETmpawrVq5o9AoxH7QBeQ1q9L8zbRkfnh/YqahdZ6ciJ5MkUcFvcYkd7ydqOYge9V+/4j/Y3xhkq4iXPtBYrAVqbHAmBmAFsbTXwvAT6Q2mXnO1GZcktNnSZmqrowQKwkxna7Ph8lmdleq3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVcFJgSw; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79801df3e21so24615857b3.2
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 13:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771621718; x=1772226518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2EGZamZDx/aCj7NdoMVkEVtbfocL8KiwqS4ak9o7qI=;
        b=SVcFJgSwD8dVKLsOKQ2GlzU6hyY2vA3Dr+MDfA14NzkEYgtV1cRQ2jiou9kvrYyujH
         DT/7st1nyf5y11PW9OHis5VVZZe69M/Y7nlaMybSlx8/e2nYgdm/eC4ZTdlpKsJefGTv
         DBfl3WCWX4LV6hM6TJEIRf2ZA9ORVWLCGwmJow+VFg912EBXc33LoabjfbtIb3p9pqn/
         il0bQZMwA/s1r5ReW//szSpCGlHkH/bGitH0dPTKgox6SWwpX14xdFh42KwiqwsqX6TG
         HrjC0Z5Ga+7NN+fe8+kgQ2XskWiN84WhKojNSmW413kbi8ccIQ2exog1IkZweqSg0Lvm
         QNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771621718; x=1772226518;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2EGZamZDx/aCj7NdoMVkEVtbfocL8KiwqS4ak9o7qI=;
        b=FfoFW6aMddR61IX5n4adNhY6UOBa3SVPynUoCDF5urWG/7nQBmDnUh9AbalYImnnts
         0iLw4lwP+t5ndqZUaPWlku1tuFUzHFet/DeDesaSBm7DZaDwCK4dh8nRVyFotag/QRod
         Sx4CcilNwdldOQI6CqJBXahT7UVBC8yBt/TjieKesMgPr7rvsXuKmxZClw8ip9IxyoOd
         MC5fbguFoygIXvudgUc1sEfEGWT4ecYOnWDwOayL/ho3ViesMlMqDPCJjoqckSq1NGpn
         o+zezLnXbbxgGWhZfLr96+qB1V9CwVTRZ/LXp3/Kfzx/FUHhfCt7ivQmcZ0CI6+oZYm0
         Kr6A==
X-Forwarded-Encrypted: i=1; AJvYcCWscRJF0gDgYScUCIm9Eo46B/UjefPp7tgOq6iiTTE7Ko2QDC/4Gk+aJC7ZO0EDikhKF4uL8dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRFCi3NywzAFjgnGsny8xYOu+5xoEvibKlkMyDlp1+bjgwA6n2
	3lFTSzBz1ECOvsMMr6kCXEZZjqdiZzFuMn9QJW+quN7XXFtaDjWOTuxe
X-Gm-Gg: AZuq6aKuHzHLnkChm70W2GcOQn8iF/J9PTnRZSGG8rWM/dLLL8LA2Gv2nT8PTv0bEVZ
	KaJsZnxWEaV5cws2DlvAG9ReXuzWnM5DRRuFezDhUFLN12cDwLe5E0SAZQt5DZNhNRQr8q8swwG
	9O7JV6p9gjid9fWKFTmF7xYHQlYzF5fRBiPh1ZWF1Px/8QT6r0Xfrl/nMRKiaZYnwgIyONia5zv
	y/YyqAIzt1PYAu9XRYo6VD9ikEiPK5xZ3OsL1ZHpRxDtTcRGhfB9TGeKVTKx1GFEiocXtIlqrOW
	dgNxzvb3ZEq5GjFm/TuLtdbTZt9lNVOu3cBUCQYgqQPavIVlBJb4LfNwQXdoMOdAn/YQn4EPYeM
	/SW0yTy2YIFGImoXa7HlU9JCQh2xRayZ+k5eCAd79iAe3W3YnaduDbyoOkVYnjg3mUYpeTnd0cR
	ynJinHT5bGfHHz2tQ5JPlswXWcvpGLmyJ3X5N75U+eOxNpgQmzxjgmBEPR2WW8Cba4gwxAfBo=
X-Received: by 2002:a05:690c:4b85:b0:794:fb7:d572 with SMTP id 00721157ae682-798291813c4mr11680567b3.66.1771621718139;
        Fri, 20 Feb 2026 13:08:38 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7982de13c91sm1419477b3.47.2026.02.20.13.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 13:08:36 -0800 (PST)
Date: Fri, 20 Feb 2026 16:08:35 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Josh Hunt <johunt@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Paul Chaignon <paul.chaignon@gmail.com>, 
 Mykyta Yatsenko <yatsenko@meta.com>, 
 Tao Chen <chen.dylane@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, 
 Tobias Klauser <tklauser@distanz.ch>, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.5766d0a10c73@gmail.com>
In-Reply-To: <20260219104710.1490304-2-nhudson@akamai.com>
References: <20260219104710.1490304-1-nhudson@akamai.com>
 <20260219104710.1490304-2-nhudson@akamai.com>
Subject: Re: [RFC PATCH 1/1] bpf: Add tunnel decapsulation and GSO state
 updates per new flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259770-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,meta.com,distanz.ch,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A308F16AEAD
X-Rspamd-Action: no action

Nick Hudson wrote:
> Enable BPF programs to properly handle GSO state when decapsulating
> tunneled packets by adding selective GSO flag clearing and a trusted
> mode for GSO handling.
> 
> New decapsulation flags:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_UDP: Clear UDP tunnel GSO flags
>   (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM)
> - BPF_F_ADJ_ROOM_DECAP_L4_GRE: Clear GRE tunnel GSO flags
>   (SKB_GSO_GRE, SKB_GSO_GRE_CSUM)
> - BPF_F_ADJ_ROOM_DECAP_IPXIP4: Clear SKB_GSO_IPXIP4 flag for
>   IPv4-in-IPv4 (IPIP) and IPv6-in-IPv4 (SIT) tunnels
> - BPF_F_ADJ_ROOM_DECAP_IPXIP6: Clear SKB_GSO_IPXIP6 flag for
>   IPv6-in-IPv6 and IPv4-in-IPv6 tunnels
> - BPF_F_ADJ_ROOM_NO_DODGY: Preserve gso_segs and don't set
>   SKB_GSO_DODGY when the BPF program is trusted and modifications
>   are known to be valid
> 
> The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
> renamed to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
> Run Everywhere) lookups in BPF programs.
> 
> By default, bpf_skb_adjust_room sets SKB_GSO_DODGY and resets
> gso_segs to 0, forcing revalidation. The NO_DODGY flag bypasses this
> for trusted programs that guarantee GSO correctness.
> 
> Usage example (decapsulating UDP tunnel with IPv4 inner packet):
>   bpf_skb_adjust_room(skb, -hdr_len, BPF_ADJ_ROOM_NET,
>                       BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
>                       BPF_F_ADJ_ROOM_DECAP_L4_UDP);

This patch is doing to much in one patch.

Also not convinced of the need for the NO_DODGY flag.
 
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Josh Hunt <johunt@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>  include/uapi/linux/bpf.h       | 45 +++++++++++++++++++--
>  net/core/filter.c              | 73 ++++++++++++++++++++++++++++------
>  tools/include/uapi/linux/bpf.h | 45 +++++++++++++++++++--
>  3 files changed, 145 insertions(+), 18 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c8d400b7680a..0cb24ab70af7 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3010,8 +3010,42 @@ union bpf_attr {
>   *
>   *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
>   *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
> - *		  Indicate the new IP header version after decapsulating the outer
> - *		  IP header. Used when the inner and outer IP versions are different.
> + *		  Indicate the new IP header version after decapsulating the
> + *		  outer IP header. Used when the inner and outer IP versions
> + *		  are different. These flags only trigger a protocol change
> + *		  without clearing any tunnel-specific GSO flags.
> + *
> + *		* **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
> + *		  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
> + *		  when decapsulating a GRE tunnel.
> + *
> + *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
> + *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
> + *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
> + *
> + *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
> + *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
> + *		  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
> + *
> + *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
> + *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
> + *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
> + *		  or IPv4-in-IPv6).
> + *
> + *		When using the decapsulation flags above, the skb->encapsulation
> + *		flag is automatically cleared if all tunnel-specific GSO flags
> + *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
> + *		SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
> + *		removed from the packet. This handles cases where all tunnel
> + *		layers have been decapsulated.
> + *
> + *		* **BPF_F_ADJ_ROOM_NO_DODGY**:
> + *		  Do not mark the packet as dodgy (untrusted) and preserve
> + *		  the existing gso_segs count. By default, packet modifications
> + *		  set SKB_GSO_DODGY and reset gso_segs to 0, forcing
> + *		  revalidation. This flag is useful when decapsulating the
> + *		  tunnel, the BPF program is trusted, and the modifications
> + *		  are known to be valid.
>   *
>   * 		A call to this helper is susceptible to change the underlying
>   * 		packet buffer. Therefore, at load time, all checks on pointers
> @@ -6209,7 +6243,7 @@ enum {
>  };
>  
>  /* BPF_FUNC_skb_adjust_room flags. */
> -enum {
> +enum bpf_adj_room_flags {
>  	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
>  	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
>  	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
> @@ -6219,6 +6253,11 @@ enum {
>  	BPF_F_ADJ_ROOM_ENCAP_L2_ETH	= (1ULL << 6),
>  	BPF_F_ADJ_ROOM_DECAP_L3_IPV4	= (1ULL << 7),
>  	BPF_F_ADJ_ROOM_DECAP_L3_IPV6	= (1ULL << 8),
> +	BPF_F_ADJ_ROOM_DECAP_L4_GRE	= (1ULL << 9),
> +	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
> +	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
> +	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
> +	BPF_F_ADJ_ROOM_NO_DODGY		= (1ULL << 13),
>  };
>  
>  enum {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index ba019ded773d..681dd53ab841 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3484,14 +3484,28 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
>  #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
>  					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>  
> -#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
> -					 BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
> +#define BPF_F_ADJ_ROOM_DECAP_L4_MASK	(BPF_F_ADJ_ROOM_DECAP_L4_UDP | \
> +					 BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> +
> +#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK	(BPF_F_ADJ_ROOM_DECAP_IPXIP4 | \
> +					 BPF_F_ADJ_ROOM_DECAP_IPXIP6)
> +
> +#define BPF_F_ADJ_ROOM_ENCAP_MASK	(BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>  					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
>  					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
>  					 BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
>  					 BPF_F_ADJ_ROOM_ENCAP_L2( \
> -					  BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
> -					 BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> +					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
> +
> +#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
> +
> +#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
> +					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_MASK | \
> +					 BPF_F_ADJ_ROOM_NO_CSUM_RESET | \
> +					 BPF_F_ADJ_ROOM_NO_DODGY)
>  
>  static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  			    u64 flags)
> @@ -3503,6 +3517,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  	unsigned int gso_type = SKB_GSO_DODGY;
>  	int ret;
>  
> +	if (unlikely(flags & (BPF_F_ADJ_ROOM_DECAP_MASK |
> +			      BPF_F_ADJ_ROOM_NO_DODGY)))
> +		return -EINVAL;
> +
>  	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
>  		/* udp gso_size delineates datagrams, only allow if fixed */
>  		if (!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ||
> @@ -3588,8 +3606,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  	if (skb_is_gso(skb)) {
>  		struct skb_shared_info *shinfo = skb_shinfo(skb);
>  
> -		/* Header must be checked, and gso_segs recomputed. */
> +		/* Add tunnel GSO type flags as appropriate. */
>  		shinfo->gso_type |= gso_type;
> +
> +		/* Header must be checked, and gso_segs recomputed. */
>  		shinfo->gso_segs = 0;
>  
>  		/* Due to header growth, MSS needs to be downgraded.
> @@ -3610,11 +3630,14 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  			      u64 flags)
>  {
> +	bool no_dodgy = flags & BPF_F_ADJ_ROOM_NO_DODGY;
>  	int ret;
>  
>  	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
>  			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
> -			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
> +			       BPF_F_ADJ_ROOM_DECAP_MASK |
> +			       BPF_F_ADJ_ROOM_NO_CSUM_RESET |
> +			       BPF_F_ADJ_ROOM_NO_DODGY)))
>  		return -EINVAL;
>  
>  	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
> @@ -3647,9 +3670,36 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>  			skb_increase_gso_size(shinfo, len_diff);
>  
> -		/* Header must be checked, and gso_segs recomputed. */
> -		shinfo->gso_type |= SKB_GSO_DODGY;
> -		shinfo->gso_segs = 0;
> +		/* Selective GSO flag clearing based on decap type.
> +		 * Only clear the flags for the tunnel layer being removed.
> +		 */
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
> +			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
> +					      SKB_GSO_UDP_TUNNEL_CSUM);
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> +			shinfo->gso_type &= ~(SKB_GSO_GRE |
> +					      SKB_GSO_GRE_CSUM);
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4)
> +			shinfo->gso_type &= ~SKB_GSO_IPXIP4;
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6)
> +			shinfo->gso_type &= ~SKB_GSO_IPXIP6;
> +

Probably check that the flags were set in the first place.

And perhaps that length_diff >= the minimum length that would match
tunnel header removal.

Basically, maximize guard rails against misuse.
> +		/* Clear encapsulation flag only when no tunnel GSO flags remain */
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
> +			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +						  SKB_GSO_UDP_TUNNEL_CSUM |
> +						  SKB_GSO_GRE |
> +						  SKB_GSO_GRE_CSUM |
> +						  SKB_GSO_IPXIP4 |
> +						  SKB_GSO_IPXIP6)))
> +				skb->encapsulation = 0;
> +		}
> +
> +		/* NO_DODGY: preserve gso_segs, don't mark as dodgy. */
> +		if (!no_dodgy) {
> +			shinfo->gso_type |= SKB_GSO_DODGY;
> +			shinfo->gso_segs = 0;
> +		}
>  	}
>  
>  	return 0;
> @@ -3709,8 +3759,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>  	u32 off;
>  	int ret;
>  
> -	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_MASK |
> -			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
> +	if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
>  		return -EINVAL;
>  	if (unlikely(len_diff_abs > 0xfffU))
>  		return -EFAULT;
> @@ -3729,7 +3778,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>  		return -ENOTSUPP;
>  	}
>  
> -	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> +	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
>  		if (!shrink)
>  			return -EINVAL;
>  
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 5e38b4887de6..664bc8438186 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3010,8 +3010,42 @@ union bpf_attr {
>   *
>   *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
>   *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
> - *		  Indicate the new IP header version after decapsulating the outer
> - *		  IP header. Used when the inner and outer IP versions are different.
> + *		  Indicate the new IP header version after decapsulating the
> + *		  outer IP header. Used when the inner and outer IP versions
> + *		  are different. These flags only trigger a protocol change
> + *		  without clearing any tunnel-specific GSO flags.
> + *
> + *		* **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
> + *		  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
> + *		  when decapsulating a GRE tunnel.
> + *
> + *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
> + *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
> + *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
> + *
> + *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
> + *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
> + *		  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
> + *
> + *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
> + *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
> + *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
> + *		  or IPv4-in-IPv6).
> + *
> + *		When using the decapsulation flags above, the skb->encapsulation
> + *		flag is automatically cleared if all tunnel-specific GSO flags
> + *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
> + *		SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
> + *		removed from the packet. This handles cases where all tunnel
> + *		layers have been decapsulated.
> + *
> + *		* **BPF_F_ADJ_ROOM_NO_DODGY**:
> + *		  Do not mark the packet as dodgy (untrusted) and preserve
> + *		  the existing gso_segs count. By default, packet modifications
> + *		  set SKB_GSO_DODGY and reset gso_segs to 0, forcing
> + *		  revalidation. This flag is useful when decapsulating the
> + *		  tunnel, the BPF program is trusted, and the modifications
> + *		  are known to be valid.
>   *
>   * 		A call to this helper is susceptible to change the underlying
>   * 		packet buffer. Therefore, at load time, all checks on pointers
> @@ -6209,7 +6243,7 @@ enum {
>  };
>  
>  /* BPF_FUNC_skb_adjust_room flags. */
> -enum {
> +enum bpf_adj_room_flags {
>  	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
>  	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
>  	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
> @@ -6219,6 +6253,11 @@ enum {
>  	BPF_F_ADJ_ROOM_ENCAP_L2_ETH	= (1ULL << 6),
>  	BPF_F_ADJ_ROOM_DECAP_L3_IPV4	= (1ULL << 7),
>  	BPF_F_ADJ_ROOM_DECAP_L3_IPV6	= (1ULL << 8),
> +	BPF_F_ADJ_ROOM_DECAP_L4_GRE	= (1ULL << 9),
> +	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
> +	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
> +	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
> +	BPF_F_ADJ_ROOM_NO_DODGY		= (1ULL << 13),
>  };
>  
>  enum {
> -- 
> 2.34.1
> 



