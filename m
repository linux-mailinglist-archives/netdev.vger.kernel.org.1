Return-Path: <netdev+bounces-247186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9FECF5657
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 20:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06426302BABF
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 19:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D51299A8A;
	Mon,  5 Jan 2026 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtpZNuJG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F841F4168
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767641651; cv=none; b=CIVjfA1MGJDRrVuAP1QnKmf7xX9WTnF+0yKPn6T3EbS2NLlUrjfXvBBOB8vi3gCD7QZPpN3rhWUjpDcrhjA8+Ez2PpEgYdpsvSH/IfmFAK0yE7BorzrRMWiWtw7gOGmI+CosdztOpqyj3VHsxpscL5OScSXychbuntu+Zx7y6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767641651; c=relaxed/simple;
	bh=b/DVtALM7hX3+sECeiMav8/yKPk3npjk8Ip98WMK4Wc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VgoHaSCIXayydZ9lZwQdK5EWLutxAldB3gNMRJQDXvgq9bIgJfwphVbua2MWl4W2orCVlzIX0d3601ju+2dfU/oDZ5utCaRptSWb0E3FWSkynfjmxhJXXS8fZP4OtNYNdDMtlWNpWmeB1am0iEm1q6xcPhicmYnX3wGl/DQtkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtpZNuJG; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so281096d50.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 11:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767641649; x=1768246449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgVa71PQ1WP9velHjabA6G0QKtolpuoNMChnmfq34co=;
        b=TtpZNuJGTzvDW3gvaoaCUZxU9/9z/4yDDjHzsIqmIAWhNIntdIdemWxDvFchDJ4pq7
         r5wZ/KBtkMHXZ41lJN1t4VjrJRhT7bim/kQd5eR9phIiTPBMNkH7wryrS/gyvfCHy/kP
         HNh3u2S3VCFAZxdhUmLuKlvg8EqO/BSmOmV/qc16v+QqH1gXtinkDSgK8Twrnxp41FqR
         9DM1PmJS3I06p/q/wxH3c/fQJnG0fZGOp2G5cBfdWvN+Ovftn5Pakd0ZK/XS5gvDAIpD
         7p8buj7RlH2K7KsdD4MXqXKg09MJHmmUygEWD5Cuqt6zb6xNpLFHlU1flxBKx5pUUFWN
         i08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767641649; x=1768246449;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgVa71PQ1WP9velHjabA6G0QKtolpuoNMChnmfq34co=;
        b=VHbypLwQH+Gtv5XPO2f3/GDVY5TIjxQUy7EQVQDugRyR7nm7MCbJ+WjTHqx+Gx6gxt
         D5NJUuQ8lfNflFtFOSNV0RvVPWb8U9/CsqVLrD3ABILy3J8lV261DGP9X5eZPuDgsWEJ
         IHgcyRRyPF29/dn1ZkhDQ/2j85f362L/dCLrIJIWPse5JBvx3Pko/JP1F0HAIg8hV6hP
         XrxJfJNQLLMBse/fVzAo9TnpNghQ41RBQcoXgfxWGVisdCF8u8DvI9PsflsgkxHmT53R
         yo7Fb31WT4FhFX/7FOWlUKncEpZw2BV5RuCc/jjHoh6kwljk4Z/EDPeFUhK4GJx07jeS
         wNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6/Q9l77mMqqm0N+vsP6dHXitBUUJOJM+MN0YVI7JgK5ADBTz93JEBQOfgkzZcvb89eMGCDPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgS+DhGp8JAiNzgBZPVXzTf7eLZIfKAfU3kdeA0qFOG4IIWNzU
	CrlQqxnxDCHp2tJnwVO+lYnMsd1dTSdCrLFFit/5UTJaQ1COqZVcRwSI
X-Gm-Gg: AY/fxX4nbNNBBTMkRsfeJ2S9a0sz8WeivkTPmovJLJYOmUCHW81E6EtVYpZXbowbRrw
	nF55PUm/YVgBMb5efVvUnIe4sd7KdE5pFxlFPbJXdF2oX2ieQmiCopCalWqXFCx8XiukPUUxw+x
	3PsqyJePqcCbNQ3QaEJ2RXr8vWm/wkkh+1JQ1dJGyC89Za02RqjIl21wppp1Cz+ExdtynRm0zQ4
	MwhwbUbz6rVUwx+mkpNAuBp6c/vnyhQ8/L96gRPWyHuvDCyiAndxvyW8eKM3+rxxqzHJ20MaQfs
	HF7YyzLPQkTzRy92NvgCs0vZbVyjXlkolfsrhcYuQnFEd/NXkml1njx8Eop2Z4lo07rExlCu6p4
	p0SaHdrJRm/Kru9EOxCB9lwJ0Te+/Lx/kEivfZIbFHmRzzLv57kwzUgX+woooQLzCK5B/FYw3M2
	EARUE48dhzjnHqX6pg8kCThew500/Sl28IYEKwMrfdKVFFv3wUweTaC0I63ok=
X-Google-Smtp-Source: AGHT+IF/wtsB6tcG0jmTC27/FvVvbBF3+bkdNnesn0b68+/o+v24PDh8WZpB5mMeGWXFdMfQRIcLkQ==
X-Received: by 2002:a05:690e:118e:b0:63f:b3aa:d9e with SMTP id 956f58d0204a3-6470c8533b5mr532220d50.23.1767641648978;
        Mon, 05 Jan 2026 11:34:08 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d7f81bdsm11212d50.1.2026.01.05.11.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 11:34:08 -0800 (PST)
Date: Mon, 05 Jan 2026 14:34:08 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: mheib@redhat.com, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 kernelxing@tencent.com, 
 kuniyu@google.com, 
 atenart@kernel.org, 
 aleksander.lobakin@intel.com, 
 Mohammad Heib <mheib@redhat.com>
Message-ID: <willemdebruijn.kernel.7b8203e93a89@gmail.com>
In-Reply-To: <20260104213101.352887-1-mheib@redhat.com>
References: <20260104213101.352887-1-mheib@redhat.com>
Subject: Re: [PATCH net v3] net: fix memory leak in skb_segment_list for GRO
 packets
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
> When skb_segment_list() is called during packet forwarding, it handles
> packets that were aggregated by the GRO engine.
> 
> Historically, the segmentation logic in skb_segment_list assumes that
> individual segments are split from a parent SKB and may need to carry
> their own socket memory accounting. Accordingly, the code transfers
> truesize from the parent to the newly created segments.
> 
> Prior to commit ed4cccef64c1 ("gro: fix ownership transfer"), this
> truesize subtraction in skb_segment_list() was valid because fragments
> still carry a reference to the original socket.
> 
> However, commit ed4cccef64c1 ("gro: fix ownership transfer") changed
> this behavior by ensuring that fraglist entries are explicitly
> orphaned (skb->sk = NULL) to prevent illegal orphaning later in the
> stack. This change meant that the entire socket memory charge remained
> with the head SKB, but the corresponding accounting logic in
> skb_segment_list() was never updated.
> 
> As a result, the current code unconditionally adds each fragment's
> truesize to delta_truesize and subtracts it from the parent SKB. Since
> the fragments are no longer charged to the socket, this subtraction
> results in an effective under-count of memory when the head is freed.
> This causes sk_wmem_alloc to remain non-zero, preventing socket
> destruction and leading to a persistent memory leak.
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
> Since skb_segment_list() is exclusively used for SKB_GSO_FRAGLIST
> packets constructed by GRO, the truesize adjustment is removed.
> 
> The call to skb_release_head_state() must be preserved. As documented in
> commit cf673ed0e057 ("net: fix fraglist segmentation reference count
> leak"), it is still required to correctly drop references to SKB
> extensions that may be overwritten during __copy_skb_header().
> 
> Fixes: ed4cccef64c1 ("gro: fix ownership transfer")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

