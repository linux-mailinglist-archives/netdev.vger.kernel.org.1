Return-Path: <netdev+bounces-155588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0909A031CA
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4768C3A16DA
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484E11DF27D;
	Mon,  6 Jan 2025 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l15TCnYv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83F4207A
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197552; cv=none; b=YOmlgiFnWKBSMIOgXGtTMvgV/H2wTdnvVG/f79EyEB8rkYFNavm8jK4wwJeZp/s7IPu/2Bo2PAUk8sC1ZG9azGttB0tyZFCEsWw38i8DdkHFqKHZjm9lGoHwM+sm7A0w5rTh5hFB7jAfBNv4QRbulyWNqfF51P453bne784ZQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197552; c=relaxed/simple;
	bh=uKHnyOXk7wD8FtwwnrBzNMWxwHLUrF376sBjm1EypTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBHOxLlS7MyZBU5q2jH+9/B/StMCaF8pEjN2aTcPtR4AJA+mqAW8orRuEWRK8ZeVBywxet+651InpGmFCRvXNRrgzedWSeqdc5Nw3M87hVuo7Gsja35XLdVoJjirykLFRJx9gt57aVKNObl7wfV8CyyfKFG/yXREP5bjQ7tuQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l15TCnYv; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4678c9310afso7931cf.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 13:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736197549; x=1736802349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zGtaGM5b77ucuwk4fm3XKPCVJDSSeM6AGivjpZB2h8=;
        b=l15TCnYvF+uq/oIG4NyHI5eqUdr8z8t/sNwwGH2X87h3dqs7bTCiazWzs14j3+EQe3
         928/iBVyEzWSu2y6iXBOm+bWpwUIEakwOIiJvoT9aGD2kqtfgJ/lKEw12jx8IJFbtgWI
         7m/fWKQmMwmdWNgSCXDHSuDfRRItxKLO50WM4f5sY9ZT5JA+J6/q4kYTmfV55Odh+5yh
         2CKO9XTBy83zd4P5CXf9UUKfv585nzHFloMhtrPrRmrjLJxQvc5bZUmQNhmGIvatL3HV
         JLCVcCVTTYLSD7wSnJ4K1e8nMu8FOLLg6YixRtaad5o8floZethgZPhmA8DPmIdveF0m
         zV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736197549; x=1736802349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zGtaGM5b77ucuwk4fm3XKPCVJDSSeM6AGivjpZB2h8=;
        b=tcrkMwFKo/O6Z89+ivA/VI4RnHXFyrqhT2D1R53fdX4ucHrsXN0q37g8ah2T/RXeGm
         EISpErqu0xcdwpZJ2oDB5AHqVCxDPLF+rhbiKOLwEh5JR6N8hljN+wbc/lztC7AwazoQ
         HprRj85CCYDDwkeMn4QkkmrwRM4CPFyMbfs1AIX4hMv1FEdajYbN3IQ6rfZrBzHUdBFr
         gtHflBrFmLqrtE73yJMddKdGsg6bARziQc4kaepM4ifQMMrhmn4k5r+dI/8QN4nl8Sz/
         KKc3Ozv4cIkXFX1k46TYWnc9DbMPEq2NXsovEaDD99DmaBBQL52bliSJwqW8CDbqkRp5
         QFkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3CrFBAP/LW8H2jUTMlLU3iyjxYy3lTRDFqcmmmINBJBzNgEAuv92HMPwdbY+IkIg6eWR/6Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5r/XSIHAzXX00tGFuVbuLhDX47Im4F4f8VavvwioVjtLmVXA
	t7Z7huGWfe1TwWP00FB718SC4TN53U8EdQm1T4XfqbeXGJNcwA8zsBLUI+JVFLS4xbDGUBl6vIF
	xMWHAjCrnQLQTbBM7iNlDQ1DFfgkk2/V6ef3O
X-Gm-Gg: ASbGncswu2zlya+ztf/FqUNtuegHfYTC17AbtoMFP7E78W2+IGnQPbkmNdFg4xGniWV
	ajFbYiSKLfKKsHN/lRJcKcIqD93Xvrq4Q2WGHXeM2QrkUp1/6iZUwpIco3dqpIjogXygO
X-Google-Smtp-Source: AGHT+IHrF0oxvJGZXa6WSjedcmibAP0mg1RtPP75+yRfY+ePfiGO95mMyuKHR6rYJslO5zFufUYDUyzRuDcrR72tkFU=
X-Received: by 2002:a05:622a:1991:b0:467:7c30:3446 with SMTP id
 d75a77b69052e-46b3ba3ae7amr466791cf.25.1736197549366; Mon, 06 Jan 2025
 13:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218003748.796939-1-dw@davidwei.uk> <20241218003748.796939-4-dw@davidwei.uk>
In-Reply-To: <20241218003748.796939-4-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 6 Jan 2025 13:05:37 -0800
Message-ID: <CAHS8izM4yJGat4BrKDQW8cV83vxa0ZS5n5zX-o64Rh0PnETTDg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 03/20] net: generalise net_iov chunk owners
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 4:37=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> From: Pavel Begunkov <asml.silence@gmail.com>
>
> Currently net_iov stores a pointer to struct dmabuf_genpool_chunk_owner,
> which serves as a useful abstraction to share data and provide a
> context. However, it's too devmem specific, and we want to reuse it for
> other memory providers, and for that we need to decouple net_iov from
> devmem. Make net_iov to point to a new base structure called
> net_iov_area, which dmabuf_genpool_chunk_owner extends.
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  include/net/netmem.h | 21 ++++++++++++++++++++-
>  net/core/devmem.c    | 25 +++++++++++++------------
>  net/core/devmem.h    | 25 +++++++++----------------
>  3 files changed, 42 insertions(+), 29 deletions(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 1b58faa4f20f..c61d5b21e7b4 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -24,11 +24,20 @@ struct net_iov {
>         unsigned long __unused_padding;
>         unsigned long pp_magic;
>         struct page_pool *pp;
> -       struct dmabuf_genpool_chunk_owner *owner;
> +       struct net_iov_area *owner;
>         unsigned long dma_addr;
>         atomic_long_t pp_ref_count;
>  };
>
> +struct net_iov_area {
> +       /* Array of net_iovs for this area. */
> +       struct net_iov *niovs;
> +       size_t num_niovs;
> +
> +       /* Offset into the dma-buf where this chunk starts.  */

Probably could use a rewriting of the comment. I think net_iov_area is
meant to be a memory-type agnostic struct, so it shouldn't refer to
dma-bufs here.

But on second thought I'm not sure base_virtual belongs in the common
struct because i'm not sure yet how it applies to other memory
providers. for dmabuf, each 'chunk' is physically and virtually
contiguous, and the virtual address is well-defined to be the offset
in bytes into the dmabuf, but that is very dmabuf specific.

Consider keeping this in dmabuf_genpool_chunk_owner if we don't plan
to use this same field with the same semantics for other memory
providers, or re-write the comment.

--=20
Thanks,
Mina

