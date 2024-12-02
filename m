Return-Path: <netdev+bounces-148209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F29F9E0D7E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90C8283325
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536B51DF247;
	Mon,  2 Dec 2024 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bX+qD0KI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5FA94A
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173357; cv=none; b=sFIN7qPaxrWQdKmwgCUbj3cseqNMshTXM+UsZI2InC4MUIZuwlDihvNy2OzNBie+ABKTDUNVn9ht2pE1NzuwA1GhTBWpMxhSz2Jn87IKTFQq46RY8LbYv8pwodhC0CKCpH3RR+21UH0EmWfTtxvAqV5qULGt8pGB1OwBXVqE7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173357; c=relaxed/simple;
	bh=dNOKGsFL0T1QEOzOWmj8ytCGp2dayrWPWlVCi0VcZss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ih5kvKlEc2upcw/B0MgYNQVyL9+7whpKJE2b3oHN1sBzGl598ejHWxNGPuEA8V4cyeThzWvoEf//RDgk6qBFbgm+NueobB4bsinQkofHaNPfgQ8q+83KxZpj7iP8Om/HSi0bnFG2QCxHdgKoYBT7uyl5z3aWlnG/8QHkE192KM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bX+qD0KI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so855808666b.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 13:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733173354; x=1733778154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9tR90GpAG2U+Mn3vMHyiqqhRxEHYkiUmBltlPmZwgk=;
        b=bX+qD0KI3I3KQrB3iAaSm42U42SlzhVK0CrO0E1O9zqqdLazErPIl4CpNaLMVsI9dt
         4+d4yi0dCcu89YVIS1rZyqqzU26x446ZqGqyjfuEqNgClYaD9HIEu3Oh7AW5LxmiS2dp
         GSW5s4GQnI2DPeIUEUR+X7ScOJL//opju6ImRShveEYfPkNQ998UrELvthoh/KV/uki2
         bTS0Uo840eZAexyCw/UrzcORDQl7JpdM7AY0xT3+DzwUTriRUw1rwxUfZkT2r6mRQV4O
         k/0IOHpfgqGo1b5M9NJb6rgmUCBfj9SX7I96/Zx1z90oJUJsYaVNB1TWO185Oqv6pfxC
         wqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733173354; x=1733778154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9tR90GpAG2U+Mn3vMHyiqqhRxEHYkiUmBltlPmZwgk=;
        b=JzQyLUFxnpcNJIHtKl2HHoIFhZy41fmvQNNH5dWNRHj0b0/4uz5nWoyH9MCqkjzRbA
         ixBKURoWSMlHfcHkDV+pMMvosQsyowvX+NLFzlKnWBBCh33K7WmPjA/qVQlvI+xSEMg+
         RmghSzI25lOT/HL2XDS+W1cdgQc0CWrwML5YuqAc20q5Fq6oVPT2biC5oncp/ap4T9pO
         HS+crZQJTj5WdckpGQP/EmzWuLE6rp9Rr+wvWRK8Mh/rBVvf+ylu7Fche/9CEH0tYFak
         cifQ2OYk73tUKenO4cQUlB7ESrK4YVPZOK4bv727S5gPmiF4EMQO89Pxt38aZql7syLq
         9Lrw==
X-Gm-Message-State: AOJu0YwQblcVD/1hd61DdeQ7UYJh8dXIHrP9qdNW/O7zcK/tD+ph/Bxf
	0KNlb9SrfWbVkr+lBHJxF+Ix7NHibN2gfPXvEXS2NG/u7IN0dGU1tmXgmnc1IzMDV+5Hy2Mqssi
	UzYhuzyJhH+TS5ZWREj1ze5aqkMQJwlkpkefd
X-Gm-Gg: ASbGnctDfxmLH7uufw6Y77lEVvSUoCj4xtTOO9+noEw+I3afgR2xZV/v0T5nS3u+4R5
	2PQD08O4MesmA5VsTagaDZPz/+fcR/w==
X-Google-Smtp-Source: AGHT+IFEdivTBfIhkT5HNHjueaEO+o/6m/2qG2cFkevILpOMZI7hZrLPLeixx6Rnom/h3zhNx9jMy44tkIXF498uTuI=
X-Received: by 2002:a17:907:968f:b0:a9a:6c41:50a8 with SMTP id
 a640c23a62f3a-aa5945dd00fmr2270144966b.17.1733173353746; Mon, 02 Dec 2024
 13:02:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202182103.363038-1-jdamato@fastly.com>
In-Reply-To: <20241202182103.363038-1-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Dec 2024 22:02:22 +0100
Message-ID: <CANn89iKsYhCyEOJA5gmtXAhbC=9rjALxXFe_U2J-bGyaxxSiOQ@mail.gmail.com>
Subject: Re: [net] net: Make napi_hash_lock irq safe
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, 
	mkarsten@uwaterloo.ca, stable@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 7:21=E2=80=AFPM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Make napi_hash_lock IRQ safe. It is used during the control path, and is
> taken and released in napi_hash_add and napi_hash_del, which will
> typically be called by calls to napi_enable and napi_disable.
>
> This change avoids a deadlock in pcnet32 (and other any other drivers
> which follow the same pattern):
>
>  CPU 0:
>  pcnet32_open
>     spin_lock_irqsave(&lp->lock, ...)
>       napi_enable
>         napi_hash_add <- before this executes, CPU 1 proceeds
>           spin_lock(napi_hash_lock)
>        [...]
>     spin_unlock_irqrestore(&lp->lock, flags);
>
>  CPU 1:
>    pcnet32_close
>      napi_disable
>        napi_hash_del
>          spin_lock(napi_hash_lock)
>           < INTERRUPT >
>             pcnet32_interrupt
>               spin_lock(lp->lock) <- DEADLOCK
>
> Changing the napi_hash_lock to be IRQ safe prevents the IRQ from firing
> on CPU 1 until napi_hash_lock is released, preventing the deadlock.
>
> Cc: stable@vger.kernel.org
> Fixes: 86e25f40aa1e ("net: napi: Add napi_config")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/netdev/85dd4590-ea6b-427d-876a-1d8559c7ad=
82@roeck-us.net/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

