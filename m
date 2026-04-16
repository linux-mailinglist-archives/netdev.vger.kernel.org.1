Return-Path: <netdev+bounces-279038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MRiKhTY4GlymgAAu9opvQ
	(envelope-from <netdev+bounces-279038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:37:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E040E506
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D200B3060C81
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2981B3B9D8C;
	Thu, 16 Apr 2026 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7GJG2gO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988623B8944
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342818; cv=none; b=AQ5BHPZ1mdoiY5MCQ3cOtjngPuGud1MshzxaNKkcSIzR+jN5vcBE/A9cuIJizuJQqZN1kEgZgFD1odPPoxu2RkVwJ7jXvYhOuA/alhi8i18V80aIDylxPXwUEZ/kk9mMDyOToXbfr9cndyzUo5mx24j3oRbTMvP/pe8mMtXpOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342818; c=relaxed/simple;
	bh=CEb3cuo/uAP88ESWyuNyMkZh7DTfU9K7tpZY9polNZ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AKRv/dPIaTofbxUV6MiHNtqe4j0u1pvoyDGJssuQXysjgg7poS2XlCELIRHduNPbFYEl33h4YIwoP3q4P4pVhvbCB2wHzWF9N1eqCpOtyusmnngvOjO6cCZw37Yty+9VmR6TN5IJ5z3HrdfcODwcw9PskdNDH+XTGZNNDalM7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7GJG2gO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7b4ee3a88e1so32705437b3.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776342816; x=1776947616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LArw8lu+z3P+Njr288piMWTqVUwbnY19SMC1K2R3E/8=;
        b=V7GJG2gOVXPXgEcWQ/6GxvBr9fAZXecoBQKOmbmF6wvO2XZB8MRBS/u6R34kQ6AYbZ
         dYY6FlHa+Edmfc9f1h6SDUcullyvuyeuYEnfZKWF1TFkZpeHOVjsB/pYwL7C+TXbiUV/
         2y1TA1D4YpQ42Yg52hDz3yc+V3EQi+zt+wQGF3zaMsbW6+pdQ+CokgFzDHY20MqdzrMa
         5IUmVSMLejNWAAgnwUV/B6+awLkYCf5GatPGp/gJktsBfqABRplmATqWXgU8BtmHMTT1
         Y2h0ZQ9p5VicyI3QtbEpzwIXWSolxXkBfSEE86HvCxevq/L0s+QPS1f5AgbJS0aEJrS8
         0HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342816; x=1776947616;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LArw8lu+z3P+Njr288piMWTqVUwbnY19SMC1K2R3E/8=;
        b=WTVX32e5u0w8uEzC7CQdv1HhqVlQGpZhuQdGD/ahtX3f/HmcK6ZdT8o0kpl88NX1/D
         aqaofYWZ0bz5JVwsO2rffMizUB2nK/SXMos2hq3X1zucHgnWEnikxjeF5HD3IffDXi1c
         svcj0BGvnqjObUxwunWgRJfjSCjHHuY3C61joNtIahCiJxryF1Jz7nP5UkR7obwiGlna
         zcM7trUB1AR/qXsL2dRN1iLG4AtcKcGvDGYEWod8eDh1IF2+BsF9fXDR8PWyHrspOIZN
         Ku5yC8NSVBb/vEedo3ABwBnjsVM7ML+sdIg+DRCJu8Ty4ESLX9vgLnjf7NcOs9r6Hemq
         yJ2A==
X-Forwarded-Encrypted: i=1; AFNElJ/dh5rTX3xaN73WW+POqdCX27Zmo0yQsuGchIuKzzKpZx66Rrw3x37pvtgrFwttzJmCVDcsfqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZ3UeSRvCXAVEOOUwxSz1CQ/gzOgCl4DvXVkYp7UaEKviMnXL
	Ed7sEYuMh2kSnSH64ahQDKokhyzYfYrvj5pvEkccAwoCp7NrgPwRSCzo
X-Gm-Gg: AeBDiesP/HnAtmwjA5K8l6KPdSremUCrK54S61UBtY1xQs6yBjoXDktn+ahBy2t5xzS
	Lgz0Jg4TUrbyHiEokLidwHAN5A6gkUFTM3zph0v9nQsOQKO6QWUv/0EAVGhLcuRk6jCpGMgrdM3
	myicpmaiLCH1TsMBIcwzpBCjdj8GdvMD+nVasBWFeeG/Srg9Tl8ouHrqg43ZMtuXnGUf5d5Fez8
	aouxx1aQtvHI8dTfoZzBZZePvyaKvZg/J6PCem4IyfiqO4P16z6Vx2OxrfWMQ6tExmCwdXV0q2H
	EtDL0qYrEdnQ5rPElQL+z5cm9q6rSDxcIA3Gw9Kx42h6nyPP9oVHiVoyeNklFWBR5CDsaqqv3JY
	i3gEUukni58QSpwL4PCJ1wh6qx5Yo+yMcOBxJa1yRwI6bJ1a7XwOGe1/zBpHMOgiiyZzXooCtbf
	YVDWHFc5SWaFUhYa8A+00wJSVD9qYlxfRSfBA4wfUDuO2kqo3rXwcjcoMFoAi2EW9a4NWMmPHfX
	KX/zkbS1Sl804utfngobK6Vqg==
X-Received: by 2002:a05:690c:6e85:b0:7b8:f152:753a with SMTP id 00721157ae682-7b8f15278bfmr15108987b3.19.1776342815689;
        Thu, 16 Apr 2026 05:33:35 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b7693179a5sm21853427b3.36.2026.04.16.05.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:33:35 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:33:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2a800b32a572a@gmail.com>
In-Reply-To: <20260416075514.927101-7-nhudson@akamai.com>
References: <20260416075514.927101-1-nhudson@akamai.com>
 <20260416075514.927101-7-nhudson@akamai.com>
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: tc_tunnel validate decap
 GSO state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279038-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 265E040E506
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> Require BPF_F_ADJ_ROOM_DECAP_L4_UDP and BPF_F_ADJ_ROOM_DECAP_L4_GRE enum
> values at runtime using CO-RE enum existence checks so missing kernel
> support fails fast instead of silently proceeding.
> 
> After bpf_skb_adjust_room() decapsulation, inspect skb_shared_info and
> sk_buff state for GSO packets and assert that the expected tunnel GSO
> bits are cleared and encapsulation matches the remaining tunnel state.
> 
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>  .../selftests/bpf/progs/test_tc_tunnel.c      | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> index 7376df405a6b..74dfb694a210 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> @@ -6,6 +6,7 @@
>  
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_endian.h>
> +#include <bpf/bpf_core_read.h>
>  #include "bpf_tracing_net.h"
>  #include "bpf_compiler.h"
>  
> @@ -37,6 +38,23 @@ struct vxlanhdr___local {
>  
>  #define	EXTPROTO_VXLAN	0x1
>  
> +#define SKB_GSO_UDP_TUNNEL_MASK	(SKB_GSO_UDP_TUNNEL |			\
> +				 SKB_GSO_UDP_TUNNEL_CSUM |		\
> +				 SKB_GSO_TUNNEL_REMCSUM)

Leftover remcsum reference?

> +
> +#define SKB_GSO_TUNNEL_MASK		(SKB_GSO_UDP_TUNNEL_MASK |		\

Odd indentation?

> +				 SKB_GSO_GRE |				\
> +				 SKB_GSO_GRE_CSUM |			\
> +				 SKB_GSO_IPXIP4 |			\
> +				 SKB_GSO_IPXIP6 |			\
> +				 SKB_GSO_ESP)
> +
> +#define BPF_F_ADJ_ROOM_DECAP_L4_MASK	(BPF_F_ADJ_ROOM_DECAP_L4_UDP |	\
> +				 BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> +
> +#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK	(BPF_F_ADJ_ROOM_DECAP_IPXIP4 |	\
> +					 BPF_F_ADJ_ROOM_DECAP_IPXIP6)
> +
>  #define	VXLAN_FLAGS     bpf_htonl(1<<27)
>  #define	VNI_ID		1
>  #define	VXLAN_VNI	bpf_htonl(VNI_ID << 8)
> @@ -592,6 +610,8 @@ int __encap_ip6vxlan_eth(struct __sk_buff *skb)
>  static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
>  {
>  	__u64 flags = BPF_F_ADJ_ROOM_FIXED_GSO;
> +	struct sk_buff *kskb;
> +	struct skb_shared_info *shinfo;
>  	struct ipv6_opt_hdr ip6_opt_hdr;
>  	struct gre_hdr greh;
>  	struct udphdr udph;
> @@ -621,6 +641,11 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
>  		break;
>  	case IPPROTO_GRE:
>  		olen += sizeof(struct gre_hdr);
> +		if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
> +						BPF_F_ADJ_ROOM_DECAP_L4_GRE))
> +			return TC_ACT_SHOT;
> +		flags |= BPF_F_ADJ_ROOM_DECAP_L4_GRE;
> +
>  		if (bpf_skb_load_bytes(skb, off + len, &greh, sizeof(greh)) < 0)
>  			return TC_ACT_OK;
>  		switch (bpf_ntohs(greh.protocol)) {
> @@ -634,6 +659,10 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
>  		break;
>  	case IPPROTO_UDP:
>  		olen += sizeof(struct udphdr);
> +		if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
> +						BPF_F_ADJ_ROOM_DECAP_L4_UDP))
> +			return TC_ACT_SHOT;
> +		flags |= BPF_F_ADJ_ROOM_DECAP_L4_UDP;
>  		if (bpf_skb_load_bytes(skb, off + len, &udph, sizeof(udph)) < 0)
>  			return TC_ACT_OK;
>  		switch (bpf_ntohs(udph.dest)) {
> @@ -655,6 +684,35 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
>  	if (bpf_skb_adjust_room(skb, -olen, BPF_ADJ_ROOM_MAC, flags))
>  		return TC_ACT_SHOT;
>  
> +	kskb = bpf_cast_to_kern_ctx(skb);
> +	shinfo = bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info);
> +	if (!shinfo->gso_size)
> +		return TC_ACT_OK;
> +
> +	if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +	    (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
> +		return TC_ACT_SHOT;
> +
> +	if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> +	    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> +		return TC_ACT_SHOT;
> +
> +	if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> +	    (shinfo->gso_type & SKB_GSO_IPXIP4))
> +		return TC_ACT_SHOT;
> +
> +	if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> +	    (shinfo->gso_type & SKB_GSO_IPXIP6))
> +		return TC_ACT_SHOT;
> +
> +	if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +		     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
> +		if ((shinfo->gso_type & SKB_GSO_TUNNEL_MASK) && !kskb->encapsulation)
> +			return TC_ACT_SHOT;
> +		if (!(shinfo->gso_type & SKB_GSO_TUNNEL_MASK) && kskb->encapsulation)
> +			return TC_ACT_SHOT;
> +	}
> +
>  	return TC_ACT_OK;
>  }
>  
> -- 
> 2.34.1
> 



