Return-Path: <netdev+bounces-193652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F64AC4FA1
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA3D1884DFC
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A1E26FD95;
	Tue, 27 May 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzi5+BPd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E91ACED9;
	Tue, 27 May 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352194; cv=none; b=Ky57xmQD86qVEUZmFNy1lTI1flOdweoPd8oN8avfIdc0louQCOWI1bG8NKXa2/pvV7FKvQWXZ9Zzf6VEeZfByMtQ/hrvjCLxdBJEyFMuQh+bPLF6+qROwuNsXmSKl6hme1blSfMqLZfvKZlxBh8WlYrpC52ox+HvXzOV75JsWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352194; c=relaxed/simple;
	bh=h0DL/AGIdziEpeFiWfPVPsC1wN7HZqtnJ+wMeLBNJxg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XmRm7F17krm/jjklkoJ5WusA1UxUgBEoAeUPTTQ3J8C2+OWBJ01E1BqfnfZl03hu6u/xo216B/3JvLzGOOzmKXr5KcYDZ5GpMOxe4mz+YNLpo/U4TXhs11dZv1lY0XDS3UZ57bS9POLQYTcQEDfBMnWEUOS4TpE3qU/AQqX8614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mzi5+BPd; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f2b04a6169so35856566d6.1;
        Tue, 27 May 2025 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748352192; x=1748956992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yI1bMw/GLZSoRPfm20HgX0oWcQXo3H3TFC+iv7JCbc=;
        b=Mzi5+BPdOfuMS43V2uvShjCzGHHj5suA6F0oK8UnSZrCO/RsZmE1hc8QNzUJFI9V21
         RvDXDS8+JQQZlSgdFWvKAokM9k8Fa+lR/hFpm1p23YVy3381n7VWojke8jctqZ++WYwn
         vJMh1VTYjGyi00XHDwwssstmHoI8XNT1WGxcPtnvV5FEy1aPevHcrgPjK/vZ9LEvJOPl
         E7Mq8GMbP+5pw1YoGX3kd2nTd4nfDjgla9KnuGpQr1RW2XC9EqePr4FM8NSMJuEH+O6S
         xpbRJG7wF0PfVf+fjMDnDyvS1THcUzy4UmbGH2zlrpN3LXW/yRRqsbmhb4dl3Ru5Akib
         Bc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352192; x=1748956992;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0yI1bMw/GLZSoRPfm20HgX0oWcQXo3H3TFC+iv7JCbc=;
        b=I3VcnPWXRYmLyDjwy+gbnCiYqVNnyi5g0iGYHXYT3bxK5kPeoSG/mTSmy8pJP6TVBI
         nuC0IaxgsFKhd4RyGeng39OxkXjHq96JuCsa2WXeNOmL9uoUN/2rbFeFNxu+XQUwZ21O
         fRMCWHRIsYm946vlQU462TIuWikBvcBY4atfxoSRsldR57piGTDG68nxczdxEIignQM5
         hIwZEOmTsqctFqR/0D5tzmkiUL9p0PTrkELy8ir/eCdA6oLAJiQ0w3JcSKwu2Sgh5mhG
         cFlKmz7hwqCJMePYZqdBU/TLCv1X8+fENOKIBdZV0Q1fTI76rcJHI2Oqr4GSU6EmwkPG
         c5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWardZ/bXEgmEO/niZ2uSmPtwBigwIW0cILUO/k6sHfKE8UTCoIH5B8wE68BAZ+0DW9GnYI3xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpgBTj3APtW2cxpFJmJJyXUMK+8fPIwwwMH3g4NcMtKDjek3kr
	W7JMugA1VZM6LjRqAhMH6Cw53/qub8I8Pku82AuYWHCmnFEbnESXyGZE
X-Gm-Gg: ASbGncuA/mjrhqoADx1ZhmGI3UJZzxxZWxl/udeeWFFEyuELNaWjTN6z6iUQFSbCSyR
	tgpjwxQeKg1jn4NTnnLXzGrewAo/ybeRvghAgt4Wcr/uf8n3AnuZO4npjXfQIJOVyWhUWELYJ8X
	jkwZ8qnV6NKxv+tCQ+eoI3TwYTWHCxUmS9oyUj9/4DYe32z82V1lR8Q6+iyN6YwlkV1GODCq1Lq
	kzZRttLlNQj31nyCATCIZiw90EGQirN4Qw/aJfMUo4W14gzmY3o0j/BXYDp7SS0jGxdSkhaqgFU
	yIKnE/kS310V/Fk1STCCllnR75C5UMrV3BaVEr7Klum7kHRpz5IXgJ90xzfJmeCilISYocINu2w
	S9bgpEHbcYPZ2YvcIWQ93jAQ=
X-Google-Smtp-Source: AGHT+IHlcCGqkSt/zLCLC5ILzdqnCfFCKOBfxe6SO6C+uCdBjEog76nihA3C2T7YwE5XaHs+Xh4+ig==
X-Received: by 2002:a05:6214:2b0d:b0:6e8:9394:cbbe with SMTP id 6a1803df08f44-6fa9d138d11mr202519706d6.20.1748352191759;
        Tue, 27 May 2025 06:23:11 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6faa3704157sm42904666d6.36.2025.05.27.06.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:23:11 -0700 (PDT)
Date: Tue, 27 May 2025 09:23:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 matthias.bgg@gmail.com
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 shiming.cheng@mediatek.com, 
 lena.wang@mediatek.com
Message-ID: <6835bcbee689a_2e302129482@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250527021611.23846-1-shiming.cheng@mediatek.com>
References: <20250527021611.23846-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH net v3] t: fix udp gso skb_segment after pull from
 frag_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Shiming Cheng wrote:

still subject line: s/t/net/

> Detect invalid geometry due to pull from frag_list, and pass to
> regular skb_segment. If only part of the fraglist payload is pulled
> into head_skb, it will always cause exception when splitting
> skbs by skb_segment. For detailed call stack information, see below.
> 
> Valid SKB_GSO_FRAGLIST skbs
> - consist of two or more segments
> - the head_skb holds the protocol headers plus first gso_size
> - one or more frag_list skbs hold exactly one segment
> - all but the last must be gso_size
> 
> Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> modify fraglist skbs, breaking these invariants.
> 
> In extreme cases they pull one part of data into skb linear. For UDP,
> this  causes three payloads with lengths of (11,11,10) bytes were
> pulled tail to become (12,10,10) bytes.
> 
> The skbs no longer meets the above SKB_GSO_FRAGLIST conditions because
> payload was pulled into head_skb, it needs to be linearized before pass
> to regular skb_segment.
> 
>     skb_segment+0xcd0/0xd14
>     __udp_gso_segment+0x334/0x5f4
>     udp4_ufo_fragment+0x118/0x15c
>     inet_gso_segment+0x164/0x338
>     skb_mac_gso_segment+0xc4/0x13c
>     __skb_gso_segment+0xc4/0x124
>     validate_xmit_skb+0x9c/0x2c0
>     validate_xmit_skb_list+0x4c/0x80
>     sch_direct_xmit+0x70/0x404
>     __dev_queue_xmit+0x64c/0xe5c
>     neigh_resolve_output+0x178/0x1c4
>     ip_finish_output2+0x37c/0x47c
>     __ip_finish_output+0x194/0x240
>     ip_finish_output+0x20/0xf4
>     ip_output+0x100/0x1a0
>     NF_HOOK+0xc4/0x16c
>     ip_forward+0x314/0x32c
>     ip_rcv+0x90/0x118
>     __netif_receive_skb+0x74/0x124
>     process_backlog+0xe8/0x1a4
>     __napi_poll+0x5c/0x1f8
>     net_rx_action+0x154/0x314
>     handle_softirqs+0x154/0x4b8
> 
>     [118.376811] [C201134] rxq0_pus: [name:bug&]kernel BUG at net/core/skbuff.c:4278!
>     [118.376829] [C201134] rxq0_pus: [name:traps&]Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>     [118.470774] [C201134] rxq0_pus: [name:mrdump&]Kernel Offset: 0x178cc00000 from 0xffffffc008000000
>     [118.470810] [C201134] rxq0_pus: [name:mrdump&]PHYS_OFFSET: 0x40000000
>     [118.470827] [C201134] rxq0_pus: [name:mrdump&]pstate: 60400005 (nZCv daif +PAN -UAO)
>     [118.470848] [C201134] rxq0_pus: [name:mrdump&]pc : [0xffffffd79598aefc] skb_segment+0xcd0/0xd14
>     [118.470900] [C201134] rxq0_pus: [name:mrdump&]lr : [0xffffffd79598a5e8] skb_segment+0x3bc/0xd14
>     [118.470928] [C201134] rxq0_pus: [name:mrdump&]sp : ffffffc008013770
> 
> Fixes: a1e40ac5b5e9 ("net: gso: fix udp gso fraglist segmentation after pull from frag_list")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> ---
>  net/ipv4/udp_offload.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index a5be6e4ed326..ec05bb7d1e22 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -273,6 +273,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  	bool copy_dtor;
>  	__sum16 check;
>  	__be16 newlen;
> +	int ret = 0;
>  
>  	mss = skb_shinfo(gso_skb)->gso_size;
>  	if (gso_skb->len <= sizeof(*uh) + mss)
> @@ -301,6 +302,9 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
>  			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
>  
> +		ret = __skb_linearize(gso_skb);
> +		if (ret)
> +			return ERR_PTR(ret);

since respin is needed, please add an empty line before this comment

>  		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
>  		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
>  		gso_skb->csum_offset = offsetof(struct udphdr, check);
> -- 
> 2.45.2
> 



