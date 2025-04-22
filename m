Return-Path: <netdev+bounces-184597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 196E9A96519
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D6F189CDD4
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071BB204840;
	Tue, 22 Apr 2025 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuMA3zqL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3C2036FA;
	Tue, 22 Apr 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315634; cv=none; b=oLN/vLJweNqcawsObJ9Qbst4LhDXRoUPnCnYyW0Uo74jmMEJkkEWOroyjaHKdr79ru90FZ9HCj+u5PxIep/ZCDa2ym5tjQR16usS+oBW+yt2CkRXOPIXVwStLGh0GfdGLIMHssvYrDEwvLWTt41bENi6eMTq8x6BoX81k5nYE68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315634; c=relaxed/simple;
	bh=ySKMSkrIS5UBCBVk88j0POeM8roaqOEmuYFZtWLGqU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZ9B9yrKrmZmKzCFnOeEay/eJKrrx/b3srrRFqJ7bZ+fJ7uT2QePLqv23U/S+ZCXlFmY+QqvvCJJTyzUm85Gnabs1yhm7+YRyXkz/FJYrR+habWYLP3UKjMFS5hZjeR5bf92PAGjDvgip63lIeSzl1EdUN2gauSe5LFy+uCxvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuMA3zqL; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so63884906d6.3;
        Tue, 22 Apr 2025 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745315632; x=1745920432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0G2OWmv8qsevAHVUIIqr2yeTiHy6nsSa+1pBiw4pUU=;
        b=SuMA3zqL8gG0/cORYJqJFojoMC9dHX10tHI50QAbVcaxsOLkGk7Xs5kk2aLEvGmdTA
         eyEfvZVulxXuTlon5sAnPiNZ33u+ncSIz00SiDdbMptF4W8K9EEsX58RM7kzd4E/LMlE
         giwY+94yWDDqy78T2sN9IbWKsKE+cpZeKbWLH+usVaRjoSxmZynY/6OkjP7/2M6ZFfXv
         A4/htoNesf8+gdy0qEARl6YyrMhI5wS26sefE4GKZzJHfc+WOiVCv+wQo/a7l4h7o4aZ
         G7FuW9IGuyNRlpUGhAo87gxLvVYxPBkBK4YnATlAYBafBUJCYvJtNS+SuhkI3AXr1Ri9
         UDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745315632; x=1745920432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0G2OWmv8qsevAHVUIIqr2yeTiHy6nsSa+1pBiw4pUU=;
        b=gpnkUVRNO0zrMgxfStiwbybiGTx21BlgqHVzAhvmuKdn8iBy+dorFpenTbxcD6pKLB
         bUEs5jpYVBdOFKNPQyrog2LVRVGPMcAWhkD/jHWUZY2zb7U4X6bza7H+5rlwQq+v4wrH
         LLKtziV/HxvmsEd63c3+cwdJraj27DJcvn4rLnBUiPCVwGozLZT3vI054dCkePEgrdtL
         x9kH+r2L6f2coVPoyxMjNUy7dobuQydjZNaQlwKc/Mxb1AMUsHBzWJ1uHC2lcZs4CATO
         Ey10hkUlNIud8q1gq/fAEJzH/hXHxzswNhhKgDNNZ87Xu3BrB7HmOU48A6fVkNlOQiLF
         0AIA==
X-Forwarded-Encrypted: i=1; AJvYcCVdLknJL0fjNEKNLUw+N+fIUDbGLgcBQhX4/ybJyvprp4UJKODG9XMGllM57KuDQcYVay/MB3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHv39Zxph7yGTU60cDwncS9hf48eJp1lK9IqrKQKbKHJflzDU8
	omLYe6E4GkgPGVPLXaYE07PPIDkS7aVgqArp1W7y9jt9tVN6aKPvakscjb6pny6bkmmqtI8G/q6
	x9WmbforRQDpczsMfoJKStTBFJkE=
X-Gm-Gg: ASbGnctordZWWlSucFxzYD/HcBDAHsU55ax9iM8JsyZ4LCYGZRgJhRFHNM/ZCfEGwe7
	j5EQqEb0aszH+cGQLaHtj0yyVyvlEzkDiO4QG0OWNWdFgYD3tdC0a9BpfMBELdXOtDWZbVXbBXx
	x08N7E6HN6jDQu4bD/e2mCxuRS
X-Google-Smtp-Source: AGHT+IF2kbV637t41R0U6O0XJd1XJku4C/6T+8vcK4+/ZZnvIjBc4NIgIHR2hkL/ZGg8lNLjnI68+X3YMQRGXRxfrew=
X-Received: by 2002:a05:6214:29cc:b0:6ec:f76f:64fa with SMTP id
 6a1803df08f44-6f2c4683f29mr224259676d6.44.1745315632160; Tue, 22 Apr 2025
 02:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250416112956eucas1p1977ffda6af7fa81c3e46cadc93c30de3@eucas1p1.samsung.com>
 <20250416112925.7501-1-e.kubanski@partner.samsung.com>
In-Reply-To: <20250416112925.7501-1-e.kubanski@partner.samsung.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 22 Apr 2025 11:53:41 +0200
X-Gm-Features: ATxdqUGeGexXPQNbBHXhABOXWUtYqP3rdff7_3EsnWnFB1h9f4orOGqGxnkroMM
Message-ID: <CAJ8uoz0W1KzYxDzbRk1U3JDr1dgqyS5Da+EFgVrn64-sMeQrJw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] xsk: Fix offset calculation in unaligned mode
To: "e.kubanski" <e.kubanski@partner.samsung.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 13:30, e.kubanski <e.kubanski@partner.samsung.com> wrote:
>
> Bring back previous offset calculation behaviour
> in AF_XDP unaligned umem mode.
>
> In unaligned mode, upper 16 bits should contain
> data offset, lower 48 bits should contain
> only specific chunk location without offset.
>
> Remove pool->headroom duplication into 48bit address.

Thanks Eryk.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Signed-off-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Fixes: bea14124bacb ("xsk: Get rid of xdp_buff_xsk::orig_addr")
> ---
>  include/net/xsk_buff_pool.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 7f0a75d6563d..b3699a848844 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -232,8 +232,8 @@ static inline u64 xp_get_handle(struct xdp_buff_xsk *xskb,
>                 return orig_addr;
>
>         offset = xskb->xdp.data - xskb->xdp.data_hard_start;
> -       orig_addr -= offset;
>         offset += pool->headroom;
> +       orig_addr -= offset;
>         return orig_addr + (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
>  }
>
> --
> 2.34.1
>
>

