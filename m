Return-Path: <netdev+bounces-246371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D9ECEA2E5
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 17:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D275E301787D
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3912D878D;
	Tue, 30 Dec 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk1mDZW/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E71E572F
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112302; cv=none; b=ulqTBqd8w2jToHQITPQ1633q8Si6h+bLsm8VChgZxLypf5JhwuEDFC7lAmNMf1o7Xcob8KFtt4EMaJsEGLvUlrB/MCJHkPDyiHd+g5sl/aeal5U+eV30iH7pnjAvsGS/zlO7KGFtH3KxmPig6ChZWIfh9SxxO9W+QknIS/iah/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112302; c=relaxed/simple;
	bh=Y8RZU5d6lIZmaHofQqr+vmPHvJdl64Cmo4166dAgXrQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Dr5SxT9Pa1B63dxb5ns9FeOvEBgUTbZEdKyQYuSUxHCUdkw3Y4JM/DqwYjOIoh1s0vu3DUi4wkpc/qIaYYhpxQSUI3cTWi3edFRyriqv9U7J0/AKCvq8mUOvYj7ONuRn6uR88EHDENzy/9ih0U9HvI3bsOC8ybx0YJXEs6n3tCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk1mDZW/; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-787eb2d8663so129081007b3.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767112299; x=1767717099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on+gq2R8tsrRlsmf8QVhviZCXTes9OWH3XXjR5+jNpU=;
        b=lk1mDZW/ZX/oFFJ8GdsBSZ4GAZUmj2OmrA8h7ftO+MabBw5mRnnd/EtHbrhVQwRcHz
         G9hkdngXK2BVZD2PbxyWwt1sXyA+0XZCtaNYfdI1GwvPhbnNPnCBPbQANpPsGqi9+tf4
         Eb8rb88fojZ8teceCjXMEABs5/MArTu5jtdY08XZ8xiLZH6oQmHelx6oIdDWgV7lhZYW
         U7Lt+Hg/vd0+d3WSvqoagf0qdOAOqjKYawNxixZUy1gT1jlL12j1jNfY99gqIhAjVP/D
         RxGOx4OdPeP2I7CErQ4iWLc7MjQPAhniqWWs46I+/ia2KgsZAzjxgL9EB7ydyB3QjACc
         usyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767112299; x=1767717099;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=on+gq2R8tsrRlsmf8QVhviZCXTes9OWH3XXjR5+jNpU=;
        b=Fockkl5yX7khuM++LoWyz+aU9o6kzq99somZSje42JPM599XXXOwpENsBImhMZKMRL
         xH13MtLAu47lZzQe0PfZygCw7fVv/bq/KUIHiFy9vMVwlG8jY9KjXWD8RZfhVkBv5+vf
         24TnCYHxX/0vum931Y0RTayNL2PjswqJvFw+HRTQPFNgC2BPitrw5cXZUiegcLIdznWV
         Kc5A9LxqmtFuowkV4skRvbc+uM/Mx3dC+/edFE+FarVKAc3JxTvWc5MG8c2XXB0W5T+J
         BQ+tTfIYXch8715B43fzotTat3gVx1lTwwpSFgMND4UCdPRfJpR+OrGSOOdXIjB+xwhd
         rQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCXVmYM2md50ABTDLN0kpwrfMCaOiVONW4P7jNhcTyqBPWR3YuowPqNqdnkMwjkHyxPQiEhOAWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTmhWXDkfKPYhxNJAEHnx0Wsy5xhzYr2YNQQAw9RDxO/ib/UqU
	7CDTbv7maZrQ5MdpbcogmxhEyRAg38LGB6SSk6hSxBgNdjGaGETOIFNp
X-Gm-Gg: AY/fxX62MLD14evwpofv9UKgOmPC2Bg1msaObjOtZM+7kq4JPlx12Pu02i/nvCQ06Kr
	3PtNJGJKMBh9MrhL93ttC6kQ3tv+vutgEommPRCANysGKAd4Onrc7X6z62gZWHPGzcraybqLmsB
	39+ObM0Dqn26vpACOdAaR2A0zj8uTEKPJ9a/UiHNmI8XuEerHmjIlWoVeB6rbOIKaN7SbOlr7h3
	zPC2QGGT7CgBq73r7wQgMtXFReGYy8zIb3FXzk23qeZXIUGjBweNBsjGo8qGg3d8vLlBkxuL0pO
	jY4y1jDzPj9hUasBEVOK4svAihxPdHHAPLqx+6Smh4+wACDBxqy9LDf6Mj8/+HB90TWVGs2QL4A
	vyBSXlxShvZZua9SyDb9lVmRyZEVRfTF2z+lPw2YYIyGCN8B5ZJ6OPJNWbwVy+iQYPR2gS7tD1C
	JMWDKrMXX0ECB8hp6T3S4S+cLu9YOI/OrVK43QPmGaO5WjVej1Oz6a3WMDZCpDqsQvo2eElA==
X-Google-Smtp-Source: AGHT+IEjZu6mjcJcT4uNKe3nRUv5B3/LQQpt7ip4UKVcDHnnb1HmgiSEEa3Fv+8kaAGbrpLFD8eAAw==
X-Received: by 2002:a05:690c:c513:b0:78f:a003:ad66 with SMTP id 00721157ae682-78fa5a5d938mr312034447b3.7.1767112299128;
        Tue, 30 Dec 2025 08:31:39 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78fb44f0dcdsm127595867b3.30.2025.12.30.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:31:38 -0800 (PST)
Date: Tue, 30 Dec 2025 11:31:37 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: mheib@redhat.com, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 kernelxing@tencent.com, 
 kuniyu@google.com, 
 Mohammad Heib <mheib@redhat.com>, 
 steffen.klassert@secunet.com, 
 atenart@kernel.org
Message-ID: <willemdebruijn.kernel.2dac63d32f3d9@gmail.com>
In-Reply-To: <20251230091107.120038-1-mheib@redhat.com>
References: <20251230091107.120038-1-mheib@redhat.com>
Subject: Re: [PATCH net] net: skbuff: fix truesize and head state corruption
 in skb_segment_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

mheib@ wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> When skb_segment_list is called during packet forwarding through
> a bridge or VXLAN, it assumes that every fragment in a frag_list
> carries its own socket ownership and head state. While this is true for
> GSO packets created by the transmit path (via __ip_append_data), it is
> not true for packets built by the GRO receive path.

We have to separate packets that use frag_list, a broader category,
from those that use fraglist gso chaining. This code path is only
exercised by the latter.

> In the GRO path, fragments are "orphans" (skb->sk == NULL) and were
> never charged to a socket. However, the current logic in
> skb_segment_list unconditionally adds every fragment's truesize to
> delta_truesize and subsequently subtracts this from the parent SKB.

This was not present in the original fraglist chaining patch cited in
the Fixes tag. It was added in commit ed4cccef64c1 ("gro: fix
ownership transfer"). Which was a follow-on to commit 5e10da5385d2
("skbuff: allow 'slow_gro' for skb carring sock reference") removing
the skb->destructor reference.
 
> This results a memory accounting leak, Since GRO fragments were never
> charged to the socket in the first place, the "refund" results in the
> parent SKB returning less memory than originally charged when it is
> finally freed. This leads to a permanent leak in sk_wmem_alloc, which
> prevents the socket from being destroyed, resulting in a persistent memory
> leak of the socket object and its related metadata.
> 
> The leak can be observed via KMEMLEAK when tearing down the networking
> environment:
> 
> unreferenced object 0xffff8881e6eb9100 (size 2048):
>   comm "ping", pid 6720, jiffies 4295492526
>   backtrace:
>     kmem_cache_alloc_noprof+0x5c6/0x800
>     sk_prot_alloc+0x5b/0x220
>     sk_alloc+0x35/0xa00
>     inet6_create.part.0+0x303/0x10d0
>     __sock_create+0x248/0x640
>     __sys_socket+0x11b/0x1d0
> 
> This patch modifies skb_segment_list to only perform head state release
> and truesize subtraction if the fragment explicitly owns a socket
> reference. For GRO-forwarded packets where fragments are not owners,
> the parent maintains the full truesize and acts as the single anchor for
> the memory refund upon destruction.

Thanks for the report and fix. It can probably be simplified a bit
based on knowledge that only fraglist chaining skbs reach this path.
And the Fixes tag should reflect the patch that changed this
accounting in the GRO patch. Matching that in the GSO path makes
sense.

> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>  net/core/skbuff.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a00808f7be6a..aee9be42409b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4641,6 +4641,7 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>  	struct sk_buff *tail = NULL;
>  	struct sk_buff *nskb, *tmp;
>  	int len_diff, err;
> +	bool is_flist = !!(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST);

This is guaranteed when entering skb_segment_list.

>  
>  	skb_push(skb, -skb_network_offset(skb) + offset);
>  
> @@ -4656,7 +4657,15 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>  		list_skb = list_skb->next;
>  
>  		err = 0;
> -		delta_truesize += nskb->truesize;
> +
> +		/* Only track truesize delta if the fragment is being orphaned.
> +		 * In the GRO path, fragments don't have a socket owner (sk=NULL),
> +		 * so the parent must maintain the total truesize to prevent
> +		 * memory accounting leaks.
> +		 */
> +		if (!is_flist || nskb->sk)
> +			delta_truesize += nskb->truesize;
> +
>  		if (skb_shared(nskb)) {
>  			tmp = skb_clone(nskb, GFP_ATOMIC);
>  			if (tmp) {
> @@ -4684,7 +4693,12 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>  
>  		skb_push(nskb, -skb_network_offset(nskb) + offset);
>  
> -		skb_release_head_state(nskb);
> +		/* For GRO-forwarded packets, fragments have no head state
> +		 * (no sk/destructor) to release. Skip this.
> +		 */
> +		if (!is_flist || nskb->sk)
> +			skb_release_head_state(nskb);
> +
>  		len_diff = skb_network_header_len(nskb) - skb_network_header_len(skb);
>  		__copy_skb_header(nskb, skb);
>  
> -- 
> 2.52.0
> 



