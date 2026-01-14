Return-Path: <netdev+bounces-249824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B415D1E9EF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B20D63044874
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B034396B8E;
	Wed, 14 Jan 2026 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5Fh3b9/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1338A72E
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392105; cv=none; b=JM7sob6q9j6npX4PwZFDuJJsLbazf9ul5/cV7MkZkmazzM0N30C534Mpf1XFpWgijP9s4qUEEKtUGBYRrUHvfxv3S4Wg+ACY9Eyp1DaIrPQ3ZAH5T23xDDFjT8Btyndg4DZnIcw2uO7/QzcJPKcjEaoKcdGb5ZFhipxgo70yyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392105; c=relaxed/simple;
	bh=z9jk+o4mdAYdNmtJgSJSqtJIdlOMC0fhl4qH1ZuC0+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsBO+bnK/IBULxJK52wA/0yjh1xZJZVU1MpgYgzdp7nK9b7HuhICnQjtILVXiwyFzJSoewGTlF+yV1uUpkLgESN/zYv4JjbvgX7UQn37RNhIhRABhv8nE1swshM57H2le9Gl3nlG5f6pL7/RD9NFPofqSkwIxK69m4FY8y3cU1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5Fh3b9/; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-121a0bcd376so7414705c88.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 04:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768392097; x=1768996897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9jk+o4mdAYdNmtJgSJSqtJIdlOMC0fhl4qH1ZuC0+A=;
        b=I5Fh3b9/rDe0XZ2bOy7PJ9ZvW8z3ENq4j36uYp3BxD0wyMqr4hBgEIPpEP0AbxF3XH
         yPqMJJbGNuy7Om6C6aLmU/ilSBxM6p14gkPfG7XrAaUnWTzFTvzB662XJuCignxitaOF
         rcqMUBwyF8FHf8MkUPEOXj3nfkM/cd/LL8eQLkLGFTegoKx7OQh6Q2fx5jBrNXlgSm81
         A7fA4sYsllIaNWYiR23AbzPxScETOGI69aAuEL4Fuuw9RZ9I4Fbh9hJ8PAHD0RGP/cqc
         3D6XFs/nQMkdVsMaR630ayyuHiwDaR2yW0puyJVLpDF+20wwStvS7ldlbasy28Au92zA
         lvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768392097; x=1768996897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z9jk+o4mdAYdNmtJgSJSqtJIdlOMC0fhl4qH1ZuC0+A=;
        b=qsnoDCmpLcHjA4qpdbfDqx8uDfQcfMZnT4QxYBnGuBlcr1E4NRlhcL7FwrUc3zqgCZ
         qI7LE2iGZ9mC2PhfAUg1Wv/TVYN6hRjTdg7tfhGTYMZP63K06MP53e94qGVzGBkMFmNP
         2cHbU5O8hjEBCe1oi7HcIF84Fsqxj9UDnLaVYFM4EkJl9hbCJbbergze18i3pKz4WnGz
         gA9h20wTnIEV/k6ZBsR2WX2T7jqWFy6vTEpTMf1P0eKvn+aB3NDAjCO1v57ucy6mdXB7
         H893r/yJC9uojXCIMWj4EqFHpvb7YJxggZs5/qnF+3gXE5jPTmY/bF2yYw6EmJFdDa6I
         5Svg==
X-Forwarded-Encrypted: i=1; AJvYcCUfKUH3H1dsjrUoyPcyy3Dty0IKOERr/YnPKj8mFI0fRMjKmH2egAXNNuF4EmdpF7zXfZFQplw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/aEnABzjXMsPhJHlH5lJQWuptKSZL6EQc9vUdNRXa0AKz3Ar
	HNjhKWJN4C1t+qIzl1nxUCNGNzzvizfwAN1+rh4jyJ4O95RbXy9ZW6vC9OOoENtgts2MgHOVKsN
	EpHaFGAJJoNfApZg+7iuLhsbLSKPm+fA=
X-Gm-Gg: AY/fxX7hJsip5YgHiLVGErFewiXax/oi4Jtbpt9/Rv1gTjmN3gfyroIvWtyFMPnOHek
	myNvEfFvksXskTSmJuYH5Tvlp2lIGOd38aqIMmNiZg4ZFjDQnZRwrul4lRN5M0V+2xYzog1CCux
	Qagg6bZUfRbSIG1imOa68yIZQ/jYdz5+VtwQ3oo3L8aGPnj8ZaJpp1wyorY7Nk9U8SnQ3XF89c2
	BuCY1/IWwaRzQcG4bSjiEUQtZ17l6xziubNYSFLSxOv3oJrJBVkD7b/iuEDgwGivOjTjrPRKVMZ
	wcwspxk=
X-Received: by 2002:a05:701a:c94a:b0:119:e56b:c73e with SMTP id
 a92af1059eb24-12336a15cf9mr1986570c88.3.1768392096540; Wed, 14 Jan 2026
 04:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
 <87h5so1n49.fsf@toke.dk> <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
 <87bjiw1l0v.fsf@toke.dk>
In-Reply-To: <87bjiw1l0v.fsf@toke.dk>
From: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Date: Wed, 14 Jan 2026 21:01:25 +0900
X-Gm-Features: AZwV_Qhu5tei1ty2iQZIrCW0s6ZLZofeQXrrVLB2j11oX0iZ3zsna0P7VxhCkho
Message-ID: <CAGF5Uf7FiD_RQoFx9qLeOaCMH8QC0-n=ozg631g_5QVRHLZ27Q@mail.gmail.com>
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:39=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:

> Yeah, this has been discussed as well :)
>
> See:
> https://netdevconf.info/0x19/sessions/talk/traits-rich-packet-metadata.ht=
ml
>
> Which has since evolved a bit to these series:
>
> https://lore.kernel.org/r/20260105-skb-meta-safeproof-netdevs-rx-only-v2-=
0-a21e679b5afa@cloudflare.com
>
> https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-calls-=
v1-0-1047878ed1b0@cloudflare.com
>
> (Also, please don't top-post on the mailing lists)
>
> -Toke
>

Thanks for the pointers. It is really great to see this series. One
question: Would adding queue_index to the packet traits KV store be
a useful follow-up once the core infrastructure lands?

- Sai

