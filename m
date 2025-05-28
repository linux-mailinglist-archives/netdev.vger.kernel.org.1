Return-Path: <netdev+bounces-194042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8B5AC711B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD3D1C04351
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 18:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB428DF58;
	Wed, 28 May 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaV/jORS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD8286880;
	Wed, 28 May 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457772; cv=none; b=gZvJmG9JdCwaXnRzW+Iibd8xqZUVWomGAOv5tm1KWWxPbeF6EsGH00En7vYx0O2EB27K8tYIT5lMKx+LBIExa/c/SVO02NqDHzIWLftlZvdJHsrZB2A59QXn8iTvkRWdXQeTaqn0L9HRhj4/FMkdj8m8/72vh/k+VuomNIglj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457772; c=relaxed/simple;
	bh=CsxNqFukGanLgNMaiPSeubBk+ogMH6fMig49d0VA+Ws=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=j9xqz2wf/FtVv+4xwD9dRI/AHQEAjpDsPQi66ilw6NELQEcVgCcrwaiRoz+8lTrORLdjBAYsl7f7SO1Kqi/a7Ku7VtVigSbu8JfFy5DDEM3DAAB0v6UfHPxXxWXZnEJUF8Bk2H/ugZ3MFmgEtNSV5WhIxiR1/mKBj1EUm27kxaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaV/jORS; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c597760323so5395885a.3;
        Wed, 28 May 2025 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748457769; x=1749062569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3JLOGedtiwvYsvN6Ed7QCXqOisH9oT8ihdwmOFgFGA=;
        b=AaV/jORSqGB+vNwn1p3aLg3RMPRQOHOD4hN9NmTQivCE+HuKucxPvyjheV/ZiFxTv0
         60gzygwiKP6pUv9DkxlXKB9SpjndB1aKa611vE/NfJaG6O2QDk3/tDx7fxxn3sncUcg7
         Ss/O5wEP+NtPZXELJwNEhWQGpIbIPuDWaO2KHmowUzQr5ET7F9duydCP+NvSfXTLZhPH
         21Qzz0yBoI7vXOe703LRsXz2IJgbxeJkTk9XD+mqddoX8sefXyBOO5rU3a/0J1qPmVNA
         mcO0W0lznxuE2VBaWoWLk7D1LXK3cTX7xoxX5fj0JEC9Wwfw4/qUUWpY4IY9gwrxC25s
         wO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748457769; x=1749062569;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m3JLOGedtiwvYsvN6Ed7QCXqOisH9oT8ihdwmOFgFGA=;
        b=nrqHIpih9ByCL7J6Aj70Dqh6mMTlYNrBP2jDEHhszcgW9G/+obDeuai2GZ3sz0paVV
         uQUlV2plto7eZWQnA4Qdo5Xx5HH7dRhco/zt50nzw/KnAAlZBhY3Yk2jzp6O+938y02a
         nNE9XotnXuB+1Cc3MuL/8C1UlexVnqZo7NvwadhSD6JMfP3A9UeH14skE+LBqrKw9Qy+
         XishP2oiIV5k6xIEDdKTl8DVY91wQS32ceaeG5KZ7pZ7s4XXHm6IVsxhTnzQUe1ZEXFd
         1tRfjl2jul38aNH2F5FthvdKVIemaudmwhJ6gMNZVq6JT13jZnOfmeGIriaoHejwHmga
         T97A==
X-Forwarded-Encrypted: i=1; AJvYcCUM5MgLuRc9PtYm+bsCwXuzg0zBwtgt9ObeVIdx5zuV/vo8nNQslJlxTdLFS8FIwg1GO8VoXtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Gqocn9GY4BnF7JZVqv0uV0IVBo5AtNChL7vvMIJnYdOzPcW0
	KwWxkzW4ayre29SyQUzwk3aC5miC4gr+N6QCQ/cS3mHB4KileS20XYVQ
X-Gm-Gg: ASbGncvtBBRUcYHeE5dcE153KI9xeJa02AaQ0iFW+i9k/QQ1SvN5tnEgpng1ArsoPIN
	ThMAZyEmKYAwjBow4SRqwz2Qw4fGfm+OCHbOSDzhrSCK2DCQfvjmhV8Rz/dYKlEzKKG/kLWhQ2+
	gxeWqylnmFtTEesnKokqsCrKI/j5Z0Tj/yuTWmlEB+gsAi8X2QC6LJFBeqk9He1mBhVSWvjK7HA
	TqEMhydXKicFlzB2a2NguVEvMHpQWFpowrRGl4fKPhqji6zMYuVfaGNsCVR+m/kLbywXlTDZdx1
	Upyg9w9k3z2b0+ZsVz+urk6ow+zbPhtgeyxavG5hSvfi8QmB6Bixgd4GaleQJ+Z1GbFhqQffI7m
	Nb2/zKt9WiC0ytXTH/lDArCI=
X-Google-Smtp-Source: AGHT+IH6pxdMi9plb++lnmF+/wSOYMbx6yme09+SeQwUruZknMe48DheUQEJ7q1GG4PN1rXTSeq11w==
X-Received: by 2002:ad4:5cce:0:b0:6fa:ac51:bbda with SMTP id 6a1803df08f44-6faac51bd64mr152847226d6.26.1748457769379;
        Wed, 28 May 2025 11:42:49 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fac0b22465sm9630846d6.18.2025.05.28.11.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 11:42:48 -0700 (PDT)
Date: Wed, 28 May 2025 14:42:48 -0400
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
Message-ID: <683759284c3a9_38477c2943e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250528054715.32063-1-shiming.cheng@mediatek.com>
References: <20250528054715.32063-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH net v4] net: fix udp gso skb_segment after pull from
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

Code LGTM thanks. Let's make sure that the commit message matches.

> Detect invalid geometry due to pull from frag_list, and pass to
> regular skb_segment. 

This is a leftover from copying from my patch, and does not really
capture what the commit does.

How about something like

Commit a1e40ac5b5e9 ("net: gso: fix udp gso fraglist segmentation
after pull from frag_list") detected invalid geometry in frag_list
skbs and redirects them from skb_segment_list to more robust
skb_segment.

But some packets with modified geometry can also hit bugs in that
code. We don't know how many such cases exist. Addressing each one by
one also requires touching the complex skb_segment code, which risks
introducing bugs for other types of skbs.

Instead, linearize all these packets that fail the basic invariants on
gso fraglist skbs. That is more robust.


> If only part of the fraglist payload is pulled
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
>  net/ipv4/udp_offload.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index a5be6e4ed326..59ddb85c858c 100644
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
> @@ -301,6 +302,10 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
>  			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
>  
> +		ret = __skb_linearize(gso_skb);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
>  		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
>  		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
>  		gso_skb->csum_offset = offsetof(struct udphdr, check);
> -- 
> 2.45.2
> 



