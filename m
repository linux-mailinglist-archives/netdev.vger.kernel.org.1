Return-Path: <netdev+bounces-241964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A741C8B10C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59DEA4E131E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B751430EF8C;
	Wed, 26 Nov 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gZXa79Wm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4A3043AF
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175916; cv=none; b=TfMmYPdO0CvQTOTFWgOrNnvfJXC9VGCr+FcbFNGMr2AKAj9ja4UH5HpqsY8cdT4xn1NO46W9QZX7u58QYKDbFKPLQTAQVOnpKuH5S9McDYd/hGSvCH6dyS/XUB1NDK4KL6KnV6S6fGXhcQ4Sin8g0OgbpcHJXFAvp0m0F8MPZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175916; c=relaxed/simple;
	bh=JWiv9GUAi3pxwnCES8vgmto4Vt9mGRrMhXaU0XHLp+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgJqxY8dhCsRSfZwEEI+7pW9LWGZ7cSnlxrwXiQjm5Wxsy5IatVJ8dIuSWAyw4GsNaxi/Ckk9vTxkhGp1M6m5U8LAbrFzbfgqQXyVQcI2KBrkCsPks0wYZT+ESmSGvxW85QEwFa/QVEEcy8gNQa/W/MWWqSqmto97w2GLjXftKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gZXa79Wm; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-94900d3ef9bso287820639f.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764175913; x=1764780713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6o6rvThCpAXrqoEfGloDnW/XDixoz0N5zTrIyfzn8cQ=;
        b=gZXa79WmQWkZOisKdeQhPVyMiJEzJhSIDcD465qh9Y5Hrt79JyMc0Z0uAXvKZP+eNQ
         m4zznGjeLjT7nOwkvi/InnIl+KD2uGZF8/OZ+64ShasL6BdQOrlXUxvt7JLzheKEJRaS
         jpsdjD3AvJW6Jaa/COtWIX58da2ZaxhLE49V/8t08SD7sq//CzZmI2z5IrvvAuXpYm3T
         pogDcvSun2QmutEAnIttju7Mrw1hFAi+5wVxExiPcIX29k+P/kYyNOpzg+eV4wvqZhaB
         utyeqZuugBsNey8NfQ6jPDI6PSJ7TZknxD3RdIaOPFufsnaXoNwU8Vi3ISkeMhlVeMQG
         RDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764175913; x=1764780713;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o6rvThCpAXrqoEfGloDnW/XDixoz0N5zTrIyfzn8cQ=;
        b=pCXZ/diQ8Y6OG2p/h4AW/or4+xyntSc0BnwkKQqnBORGYQdMeDe0JOSuHB0sYm4COW
         OR64pvd2w9AuhqyFquVGXcxTHYgkFYPwr5ybjH2+NxtIhAhvYnEmcXSL2CBqErC7+U+F
         RJ8n5CBgqy98d81vb/ai17/T5rpxIBT+QPpu95cRZQMuRYVy4pJs6p3c7ko+pbKacaAQ
         ggWD1MBgM9pNq5GKZSAhSUoXuYo8p07vwX4JPl38XMLc3uMmAzNnw9pXNQGrGd9jNHww
         wHLnKM1l7UTlNsohSDlghnD8r2eJF792BAhmHyA4nuOj2AqSgHVTOEEOlu+ZQMK6WX4R
         xqPA==
X-Gm-Message-State: AOJu0YxAiN6WRz+pKLF0myd5UqbzTsxHmT0b2H0kuzakYvo1I+KbwA+y
	FMWGGua4dlji0hRkBeJNEHvc6mTPtTx6mBlBu2YQ0sZiKUluw6d87B2GpWTy5DCkG4o=
X-Gm-Gg: ASbGncuuuFoQuFGUUrMLge72XKjYRFqIMFsCPg64XFzFgMhXwFc3BqCIreaJwnvoNh4
	aAptRLLhpbTsd8gpMvIQ08DxaanB9wlJXH4Y2qyxRfYUtviDNz/w6qK0CyBC4myDGgVO+vg+rzF
	1H2ao8tsI6Jl1pB6T2Fyy+5jTuhBLQSNP2Oe470efe1CGAfNysDKlYmRLZ+n35gAYH5lPbl/9qo
	1CCDoJKysXuh7W9Bg4ewDX3iO7HlFlnTDqdWoYPKJfkbCgWZCY2n5KCKqnbLHgaM0yuOlOTNDJM
	6TetNIPhfMvwcWahGxjXDZpPV8JOqyw8jqoJZplTPwKZqN/iLRudQhJAZgzFd0+msJsOfwRueVH
	wTpdxoxZ8pDi1KT1/fx1NGHU3R7ibGvzYtrrDMa2ANWOS+Xa/6TGQjL+YYGXw856PTjfqmkUm+A
	kLP3OMzg==
X-Google-Smtp-Source: AGHT+IHj8vbygkLIHNIW+NNuQ8p1emK06owuHOj/3Qh+CKsf7lwUDqZEF5Zmk8DbFPim0ayVzFJniA==
X-Received: by 2002:a05:6638:1354:b0:5ad:1e7e:45a4 with SMTP id 8926c6da1cb9f-5b967a01ce0mr16606472173.3.1764175913156;
        Wed, 26 Nov 2025 08:51:53 -0800 (PST)
Received: from [192.168.1.99] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954a0ee3dsm8636352173.11.2025.11.26.08.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 08:51:52 -0800 (PST)
Message-ID: <4e08b49c-a0e3-4e17-bfdd-a58182b900d9@kernel.dk>
Date: Wed, 26 Nov 2025 09:51:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] io_uring: Introduce getsockname io_uring cmd
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: netdev@vger.kernel.org, io-uring@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>
References: <20251125211806.2673912-1-krisman@suse.de>
 <20251125211806.2673912-4-krisman@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20251125211806.2673912-4-krisman@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 2:18 PM, Gabriel Krisman Bertazi wrote:
> +static int io_uring_cmd_getsockname(struct socket *sock,
> +				    struct io_uring_cmd *cmd,
> +				    unsigned int issue_flags)
> +{
> +	const struct io_uring_sqe *sqe = cmd->sqe;
> +	struct sockaddr __user *uaddr;
> +	unsigned int peer;
> +	int __user *ulen;
> +
> +	if (sqe->ioprio || sqe->__pad1 || sqe->len || sqe->rw_flags)
> +		return -EINVAL;
> +
> +	uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
> +	ulen = u64_to_user_ptr(sqe->addr3);

Missing READ_ONCE() for this one. But I can just amend that, pretty
trivial.

Outside of that, this looks good to me. Bigger question is how to stage
this, in terms of the two networking patches. Jakub?

-- 
Jens Axboe

