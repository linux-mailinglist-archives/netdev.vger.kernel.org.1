Return-Path: <netdev+bounces-72981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FAF85A831
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC90282659
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76738DF2;
	Mon, 19 Feb 2024 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya/d/9Q9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD03308A
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358879; cv=none; b=MZk9RgCzECLx/qLzYNZA8evT+Z8wCS1mzG65RTY6BzYzkORP6UC8IzzxuES63Ci5VU/gAhYnYeFvFo09vJnWsfGNyWBniRxfPY2uRbK+/iYZ3Yn3Gk8U4GJYHlZEtst1fFcDQHF4NSFFyBoys4X8nbb2JptlgZj4G22UCO3dT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358879; c=relaxed/simple;
	bh=LuM9mLFIGwDaKdnRpn3DiSTV9EHQ64rg4mlk5753gek=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GWL4yLGH1mLVB5ajKDP+yWMhL/nTwozyZgoRupF3H4nAhi9XyL3drCxQ4kCOuQSlJ05fimZKjVNYHX9Kd6q0d8KNP/5MGJPWF/kI8SLds2oDqfjpePLRbUsx9DQoFWKzj9RmZ4vLZ5Dv/dlCVHZ4NZ1pHLdbjyJe1fWiRr3cP98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya/d/9Q9; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c135913200so2128699b6e.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 08:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708358877; x=1708963677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUr3953C2VynJ5aW5PrN3XkZuS+MHQ+3fnTADm5SNH8=;
        b=Ya/d/9Q9d+xuYsQ0fD5vGhaAEtsjPGgm905qO7/wn5eUr+Wu2rRo8gau2mnyUpb7FM
         yKuv5o4hoUyVj1OXoW/GvuUtFplJYcESSQ8Ffc+Jnm7jTJcQr0sL53UUqi9JgJPJHlob
         fCu3sZM8pljClHCX7zG3oJkAwu4ema2JzBYyr5RqD8hqJSKi3Bx7tGAELVyjWqaYkTfk
         CXlOWQD1FyqUSXt3UEsbtQLXnK5nXQ6yTk+1D3lPDwhSm1MrTGIMsuPMC88Li9guA30t
         dUZ0xAOhWJywuzNA7ImK6kyi5lezb3gsYTD31EbIUB78foPRg9+PJMryPOwd0Cp3GpIv
         PzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708358877; x=1708963677;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uUr3953C2VynJ5aW5PrN3XkZuS+MHQ+3fnTADm5SNH8=;
        b=afQs319cjnQadUUWw3uTqi3Qoq6xV0jARk39lR0SciuXUHSnT2WirmxBQMb9UUrAMR
         Qqkz0y672Xr2H57ez/9YLfXjSqxPcGmulwAaU5h9DSf1OwsEwV7QYthxYuunJSZNgWhA
         ngtUQnaGb9eMbnRWhUCFOnksuXUUst7vOt9RUhFL3QqMODdaPZKcmUMmpPWRI5DUrK/2
         MVUbcZGwopV4G42qHcJuHenrC92qvKUZr6V/DJRoNifmiZfZCRXcDX36e2ErrrNOcJ5c
         g8H4bAETB8vVlQ37JfkDjAh4fq/JohDnMZ5T0u7yzryjHqAkcla+YrykdxcvSF9ZzLqp
         q+ow==
X-Gm-Message-State: AOJu0YxS7LlZYZ6bRJeYFvJTzsjPw4/6OQpMktEjm9vuP86ezttEqMTL
	bWKY11nloYW3JpPEX6y687SssMd/g1fbKiSU7vDb/SNp94XEvoaI
X-Google-Smtp-Source: AGHT+IHbFrSMzr3U+S7YbFkH0wltYMBZt1er1QuU3uB3qp1KSeVW06m8nAVUtAEStcNx2QN+jZzk/A==
X-Received: by 2002:a05:6808:11ca:b0:3c1:5a37:34b8 with SMTP id p10-20020a05680811ca00b003c15a3734b8mr3802157oiv.33.1708358876900;
        Mon, 19 Feb 2024 08:07:56 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id mv9-20020a056214338900b0068ef3d21eacsm3359498qvb.52.2024.02.19.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:07:56 -0800 (PST)
Date: Mon, 19 Feb 2024 11:07:56 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <65d37cdc26e65_1f47ea29474@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240219141220.908047-1-edumazet@google.com>
References: <20240219141220.908047-1-edumazet@google.com>
Subject: Re: [PATCH net] net: implement lockless setsockopt(SO_PEEK_OFF)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> syzbot reported a lockdep violation [1] involving af_unix
> support of SO_PEEK_OFF.
> 
> Since SO_PEEK_OFF is inherently not thread safe (it uses a per-socket
> sk_peek_off field), there is really no point to enforce a pointless
> thread safety in the kernel.

Would it be sufficient to just move the setsockopt, so that the
socket lock is not taken, but iolock still is?

Agreed with the general principle that this whole interface is not
thread safe. So agreed on simplifying. Doubly so for the (lockless)
UDP path.

sk_peek_offset(), sk_peek_offset_fwd() and sk_peek_offset_bwd() calls
currently all take place inside a single iolock critical section. If
not taking iolock, perhaps it would be better if sk_peek_off is at
least only read once in that critical section, rather than reread
in sk_peek_offset_fwd() and sk_peek_offset_bwd()?

> 
> After this patch :
> 
> - setsockopt(SO_PEEK_OFF) no longer acquires the socket lock.
> 
> - skb_consume_udp() no longer has to acquire the socket lock.
> 
> - af_unix no longer needs a special version of sk_set_peek_off(),
>   because it does not lock u->iolock anymore.
> 
> As a followup, we could replace prot->set_peek_off to be a boolean
> and avoid an indirect call, since we always use sk_set_peek_off().


