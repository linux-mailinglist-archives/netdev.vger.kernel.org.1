Return-Path: <netdev+bounces-247444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7430ECFA87D
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F4BA30142F3
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67783587CC;
	Tue,  6 Jan 2026 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEFNLcuI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27373587C3
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726924; cv=none; b=tEtLjDiG0M98CIVMfRDtnkQ1bymaX5sy+m/HUDUMAjbVWtLpTByN+IYhrI/AZEr2DCZKbpx1A0GX5z8l+ftfU56XudHwvMfjshXq6+qUmckKfIC1uKfm1R1Hl/T5Tj+LLSNSXwUY4nIyBOzwONCBj6Ozjb1L0aYggSA7u68scPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726924; c=relaxed/simple;
	bh=34M3xsxC7nh8PzZnN6kX09wxQ/poyYxd1/oVtFwHAKw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AjuapBA4LXJ+psNb3+HMfMwEc5qGNN1SHQV8C/h+xKv0dcF6D24ltdFJAhELa+v50ElE+Qd5jjfV4e23oAQpCFGf2L3zQl0ghHSBaOjd6WMEc1YBvd2tOWKhtGkDUozCDJJp10hCwmrgNK7J/8P0Qhq9d+npgiEwUeCOlA/rejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEFNLcuI; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-790884840baso15466527b3.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 11:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767726922; x=1768331722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ/e6izPxQHwxC+lNp3AoZhVvSqsi4MF9yHjwicIQ0s=;
        b=hEFNLcuIr/Y0FOPT5aiy/BBZtMwkUjqLXCfhqZkEJzIbAWSllY/fyRqbOMjY8G9ukj
         2nlF+sXyTy0yie2McqqipiscZ8sn76TLIazB1DbU1PvANVw1Ppu/7uoelUIr8O8ZBruV
         R6nfK/kuLnXu4kf7eX1g71C7blyqYQ8OSMdFYzqwZq57JsuhDQA3BrF74HY0cjtNcgwJ
         aD3yiRI8ZnWcQ+js5VJsbwMjDpDFSbOzZ4xlWtlM6mmC294n0r8u4VF+97n952PVGK/W
         EeMDVkFLPOHh6twtmZ+pmvj6TkGPKCeVsNWwY+GSTcV8Ut27W15M0tRa1WtukS2QfmOf
         XLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767726922; x=1768331722;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQ/e6izPxQHwxC+lNp3AoZhVvSqsi4MF9yHjwicIQ0s=;
        b=VxmVqDBoMmM7JCdbF1+ukcBW74IgDeWuELs0hiIwcHaX3HRmVFmHUUUnL1maXIhu2F
         TaXR10oc9275HA4WuVZGnyGp83ezib1q49wuxuNRtd4Ias/r1ACcxwMQVP26ERYF31dV
         /l7/4wcYImdn1KOGDeJY2EiOxUy3uFrnn8Zs3SHb2MdFZAZmYDpzoDdk51szgmj9gcBv
         gLm5LGRubUuM55lODGmRWS9kGz+V69InVatJZJjYd42vfYuexonJ0zDdIbVlx2Ts5f/o
         zOdGqxENxe/xcSmFLPpoRN6UfLaSsAi9hYZP6T1jUzxdb7CuAYKr+iAL+jDXK8PsHcBj
         LBpw==
X-Forwarded-Encrypted: i=1; AJvYcCVwCH+3Ovr5B3iUocBML+6TecHMQLs6zfzSGrBmCQS4GK7N9k5078cnWwpjrTjoZhAUHdRGDts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLRVCnYYjXG4n8ZQm/A4q4a7IIFTGehtVlY5dpmHD2lM313XJ
	GP+ns/kyppJu2FJvOyO5UTfB9sXTkv35DCFmD0miLAk9hrQVcmc0Yawj
X-Gm-Gg: AY/fxX7/AjBZVbwpeSCN4GINjFozklKkfkhETQzqgs0hev6edx4VL0ahLSEbwze9Vtp
	QIXhApddX+2u8Pjs+pW+MCaRcOtGM51ifHewyIJNniY0x/7HJQZkVnjSwWEOKBPvL6xrQ2yCGw2
	Rj+9hDeaMb2UZ8r1TFeMA+qmk+iG0G0ybqkRiJHP4sUS9VJoT4+/cy4NoVdrugfSDj0WFb6a+aZ
	gZL69khCOXko1wga1fuVsIu2tiiaO4B9Vbf+LPDTMFbLvG3DuCSirYnHEkHCPVcI/yNCG0a+CTx
	14Azc7+kRwVHmHEjBlhUn20aZXoEgKvQgVYpi/irgnjDMZuAqk3M0s3cJ/bEW+3Q+T3ivtgGJgI
	ffggTeJF1Du4a/W9Q16C4GyQ0XF3oCz4G3nv5mGo2qkc3uZwDS9R71JdLjdmUd7lffU/0GJf10j
	GxKYjAz/mg3m+l5CaxIY2acYxPSi2/zQ1Wy+pcLkeA+hZYeGlxs41QAUexUNQ=
X-Google-Smtp-Source: AGHT+IGB1tS0qJzFpUhufdx8unuKe6HK0Ft4zNjjKJBzFMNZTcVLoe39s4DLZGfJCAzt/B6yXb0EeQ==
X-Received: by 2002:a05:690c:620e:b0:788:b84:d509 with SMTP id 00721157ae682-790b58002b1mr1810647b3.34.1767726921521;
        Tue, 06 Jan 2026 11:15:21 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790b14df5e7sm4840557b3.7.2026.01.06.11.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 11:15:20 -0800 (PST)
Date: Tue, 06 Jan 2026 14:15:20 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 matthias.bgg@gmail.com, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Lena.Wang@mediatek.com, 
 Shiming Cheng <shiming.cheng@mediatek.com>
Message-ID: <willemdebruijn.kernel.f3b2fe8186f4@gmail.com>
In-Reply-To: <20260106020208.7520-1-shiming.cheng@mediatek.com>
References: <20260106020208.7520-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH] net: fix udp gso skb_segment after pull from frag_list
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
> Commit 3382a1ed7f77 ("net: fix udp gso skb_segment after  pull from
> frag_list")
> if gso_type is not SKB_GSO_FRAGLIST but skb->head_frag is zero,

What codepath triggers this scenario?

We should make sure that the fix covers all such instances. Likely
instances of where some module in the datapath, like a BPF program,
modifies a valid skb into one that is not safe to pass to skb_segment.

I don't fully understand yet that skb->head_frag == 0 is the only
such condition in scope.

> then detected invalid geometry in frag_list skbs and call
> skb_segment. But some packets with modified geometry can also hit
> bugs in that code. Instead, linearize all these packets that fail
> the basic invariants on gso fraglist skbs. That is more robust.
> call stack information, see below.
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

Most of this commit message duplicates the text in commit 3382a1ed7f77
("net: fix udp gso skb_segment after  pull from frag_list"). And
somewhat garbles it, as in the first sentence.

But this is a different datapath, not related to SKB_GSO_FRAGLIST.
So the fixes tag is also incorrect. The blamed commit fixes an issue
with fraglist GRO. This new issue is with skbs that have a fraglist,
but not one created with that feature. (the naming is confusing, but
fraglist-gro is only one use of the skb frag_list).

>   skb_segment+0xcd0/0xd14
>   __udp_gso_segment+0x334/0x5f4
>   udp4_ufo_fragment+0x118/0x15c
>   inet_gso_segment+0x164/0x338
>   skb_mac_gso_segment+0xc4/0x13c
>   __skb_gso_segment+0xc4/0x124
>   validate_xmit_skb+0x9c/0x2c0
>   validate_xmit_skb_list+0x4c/0x80
>   sch_direct_xmit+0x70/0x404
>   __dev_queue_xmit+0x64c/0xe5c
>   neigh_resolve_output+0x178/0x1c4
>   ip_finish_output2+0x37c/0x47c
>   __ip_finish_output+0x194/0x240
>   ip_finish_output+0x20/0xf4
>   ip_output+0x100/0x1a0
>   NF_HOOK+0xc4/0x16c
>   ip_forward+0x314/0x32c
>   ip_rcv+0x90/0x118
>   __netif_receive_skb+0x74/0x124
>   process_backlog+0xe8/0x1a4
>   __napi_poll+0x5c/0x1f8
>   net_rx_action+0x154/0x314
>   handle_softirqs+0x154/0x4b8
> 
>   [118.376811] [C201134] rxq0_pus: [name:bug&]kernel BUG at net/core/skbuff.c:4278!
>   [118.376829] [C201134] rxq0_pus: [name:traps&]Internal error: Oops - BUG: 00000000f2000800 [#1]
>   [118.470774] [C201134] rxq0_pus: [name:mrdump&]Kernel Offset: 0x178cc00000 from 0xffffffc008000000
>   [118.470810] [C201134] rxq0_pus: [name:mrdump&]PHYS_OFFSET: 0x40000000
>   [118.470827] [C201134] rxq0_pus: [name:mrdump&]pstate: 60400005 (nZCv daif +PAN -UAO)
>   [118.470848] [C201134] rxq0_pus: [name:mrdump&]pc : [0xffffffd79598aefc] skb_segment+0xcd0/0xd14
>   [118.470900] [C201134] rxq0_pus: [name:mrdump&]lr : [0xffffffd79598a5e8] skb_segment+0x3bc/0xd14
>   [118.470928] [C201134] rxq0_pus: [name:mrdump&]sp : ffffffc008013770
> 
> Fixes: 3382a1ed7f77 ("net: fix udp gso skb_segment after pull from frag_list")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> ---
>  net/ipv4/udp_offload.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 19d0b5b09ffa..606d9ce8c98e 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -535,6 +535,12 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  			uh->check = ~udp_v4_check(gso_skb->len,
>  						  ip_hdr(gso_skb)->saddr,
>  						  ip_hdr(gso_skb)->daddr, 0);
> +	} else if (skb_shinfo(gso_skb)->frag_list && gso_skb->head_frag == 0) {
> +		if (skb_pagelen(gso_skb) - sizeof(*uh) != skb_shinfo(gso_skb)->gso_size) {
> +			ret = __skb_linearize(gso_skb);
> +			if (ret)
> +				return ERR_PTR(ret);
> +		}
>  	}
>  
>  	skb_pull(gso_skb, sizeof(*uh));
> -- 
> 2.45.2
> 



