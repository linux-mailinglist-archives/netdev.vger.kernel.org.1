Return-Path: <netdev+bounces-166916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B351EA37DAD
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433F93B01AD
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05E81A8403;
	Mon, 17 Feb 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kXDG27F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138341A23AE
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782580; cv=none; b=G2OxMGQCIOViYGdwRY8kkIil9bKuKKMkKRAdw/TnufyonEcSpuYNByY3zyVuGo4cwTab6vWifs0jS4iQYm37tP+aPS/6Z5tMG6LlSlE1Zve4+6rQE4zddhlX8cXbkqoCd1gO/EP76NjEbdZhKNRYBwd14mRaaLISAECZy4MVEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782580; c=relaxed/simple;
	bh=rSMNGwh035t1vgisSjnlcCCc7am/GET8bwd1o2yn6sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLJkrIsjqM8RxYs4KCsWHfkd+2v1fla+jHRuP7CrioWwRHNqn5UyvR4No4Ho7mEd98fMDfLxbM3IM/p573szMvkiFg+nb8l6MQOzpnPPaMWoW09gw7Bxjc+NMIwcTwOpevwWsyiQOrdtzbU40ujd9M2jw6g9GW9fGD6A69mS04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3kXDG27F; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb86beea8cso233469966b.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 00:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739782577; x=1740387377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9fzVMy3EuccpMQqhxoX/SOE/CZjtz9LlygVskmK9lA=;
        b=3kXDG27FWhT01M9JuWjMzmHn/xX5xJ1D35SOGgD/Qt2sXLqcz78n06P2+dRPzNKLU4
         KCwi8wdqZwuCB8T5U4hfc8YMt17moYxzPBFwFqX/wra+TCbrNidcB2yFQKjr4UISVbYx
         HTXBbWPOWAMmSvpTl8n4U6n0YhyXB7qv3e4gHj1clb7+OuLPMC07aulYbi2ZMJGZZnS9
         ocR3Cr84l5dp0qBzLXGYt2iKIUhaOyPMTatqJX9WFZuYio2sw+X6TbWmZwY0R5P9me5H
         3BfRDl3KEtnyqGR7SN1rkpnGvyDbZ8QiJp8nH/mYVBGJc3oyo66HnA9FbLlwoCShxVZu
         kfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782577; x=1740387377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9fzVMy3EuccpMQqhxoX/SOE/CZjtz9LlygVskmK9lA=;
        b=Jp8NnHgc7jvfrQROurevhEIMEc60QnFiz2RcPLzW2q8HMT0F+509eMcMYeEexTVB3i
         uCohDtXMCFkrwIzlcVEMB9l5HNIg/fQLG8m/YR57f3EBaUblzS0bxYNnxZU7cQsFA7tD
         He7TQuL5tAbIvUVx7eNzL0HG0xlYw/olxx74R9CYnr9xXCIqtYhz6CJeD+n4kgeIJve0
         7HOp1A8ZmuPQnXgZfbWykhAi5dMj0pUGJlZfcu59cLgmmcYIARwIRSu3aTgjy9PNascH
         wJSvOpaEA9EgrJ1Q542Hlle/RpBnfJHDuJtp5ZojPVMYWV+UjzMrafhOmgfqfYb1lCZC
         h+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpYBqVGrfOqjrNU4hhKbRyi+ZTtxXuyzghFENXYDvMOoRNkcjUmXoUI78i6Iq87SqAfFtYso8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4RC18dvyVZz0r/LShhxcKeX3fjtwlDYMuo8mDRq6PIE7fYXwQ
	rdhXr2cfqwcfsI6lm3l056f6mhua2zpBx/ISFZHVq3qcgH6Qe9amiDRUSwSfNjl7i9VAljpTyJS
	0Y7QY6hAR2n9qR9UdRqpKxUZrgcgUqgym3QT0
X-Gm-Gg: ASbGnctG/Ypip/q5o8Vs1a6imr9Dp+84gY4Uuj7wpuZ4IqVZHEHXfkNnFIdR6LA/2gz
	mf9Jh5kJj6mBkWRAm2S1tnOI/rkNIemMcOHHkVWYSyKYOb2LNsvb8RLp7lrH7/knTH1A3hLuj0w
	==
X-Google-Smtp-Source: AGHT+IHWt5SAAYDeYXdUcNKwcxZAqv+io1rowGJTMwarJM+W2ClYHlji61lLGs7htKHDg+kp7YH72yhKYU7FCuLtiYE=
X-Received: by 2002:a17:906:da07:b0:ab7:c43f:8382 with SMTP id
 a640c23a62f3a-abb70dd3789mr751029266b.31.1739782577285; Mon, 17 Feb 2025
 00:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216163016.57444-1-enjuk@amazon.com> <20250216190642.31169-1-kuniyu@amazon.com>
In-Reply-To: <20250216190642.31169-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Feb 2025 09:56:06 +0100
X-Gm-Features: AWEUYZkLYy697Q1BcHQ0_hIbyfhdXPfDJNufGWgNEXRfNDqTFi2VIYf4X2t432o
Message-ID: <CANn89i+ap-8BB_XKfcjMnXLR0ae+XV+6s_jacPLUd8rqSgyayA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] neighbour: Replace kvzalloc() with kzalloc()
 when GFP_ATOMIC is specified
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: enjuk@amazon.com, davem@davemloft.net, gnaaman@drivenets.com, 
	horms@kernel.org, joel.granados@kernel.org, kohei.enju@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, lizetao1@huawei.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 8:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Kohei Enju <enjuk@amazon.com>
> Date: Mon, 17 Feb 2025 01:30:16 +0900
> > Replace kvzalloc()/kvfree() with kzalloc()/kfree() when GFP_ATOMIC is
> > specified, since kvzalloc() doesn't support non-sleeping allocations su=
ch
> > as GFP_ATOMIC.
> >
> > With incompatible gfp flags, kvzalloc() never falls back to the vmalloc
> > path and returns immediately after the kmalloc path fails.
> > Therefore, using kzalloc() is sufficient in this case.
> >
> > Fixes: 41b3caa7c076 ("neighbour: Add hlist_node to struct neighbour")
>
> This commit followed the old hash_buckets allocation, so I'd add
>
>   Fixes: ab101c553bc1 ("neighbour: use kvzalloc()/kvfree()")
>
> too.
>
> Both commits were introduced in v6.13, so there's no difference in terms
> of backporting though.
>
> Also, it would be nice to CC mm maintainers in case they have some
> comments.

Oh well, we need to trigger neigh_hash_grow() from a process context,
or convert net/core/neighbour.c to modern rhashtable.

