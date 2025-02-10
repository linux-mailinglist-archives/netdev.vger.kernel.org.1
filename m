Return-Path: <netdev+bounces-164585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D078FA2E5BD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42E51884F46
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63BB2F22;
	Mon, 10 Feb 2025 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hxdw8M6C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91081BBBE5
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173786; cv=none; b=AJ0WxB2GzMjK7+/n2RP6i2Hqb8s9W4NJboNZU2+oVyIDFT7Dlb/kQVTBakr8AJUmyRAfP0qSeXa7WtGbjhtsj2UZRQg57XzEoP47lZJmQtFJ+3pldaEqqDVO77dt4+OuZT1iWNfbseQJ196l+ukKTAnUBqxHOEQ7wg+jwIZMAvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173786; c=relaxed/simple;
	bh=nEqMlZ2pjVh0LdY2fkE/N4iZ0HkpQVMfXEse3Af54mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VynJwdet0cTvK4KaPojC8rNAOzi9tmfi5vp9gcFTnVnjTcTTNyho/IJK5DU7iw8SwTpHd1m98emf6YIJ7c0CwY0K6quSZ2WDwk3NE/1y9U84i1Zep1c+gBMmFtobYWnBEhovxiXcXmDhPolEoh4okrQE+NVv7BLhUGLnAGJ09IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hxdw8M6C; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5de3c29e9b3so5595488a12.3
        for <netdev@vger.kernel.org>; Sun, 09 Feb 2025 23:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739173782; x=1739778582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVa68QPgK9kaQwjfkRjiftD2eZ+FNC17cNuQB5Ss6Y0=;
        b=Hxdw8M6CQ8J9rJwHofAvkMv9WZE0xJjNoJNeo4Oaj+dizxmS3sBMBgiM8g7VxABOyT
         nnET1I0sftsl74PWKrOqTTpSbasE/5diiMtRfa8uMCMuO8H/walvICJtu6DCt8GwFta8
         6H9RSWyaewbwVyJbHd3vxbFusTX0R7I/wNGFJgDWDMffa1I2UzPq/nTkjT/fd3DKnmmI
         1o18aFFShtCYB2umd2909DlpAPUX4aLjVfjYFUllSFFvUQDeXprSAdg/ju6lYngaj0VB
         RZHJtw6+T1EChAgNqAJK9Ng264j07ybYs9Fd/KK+0hzPloA1wJTHrDZ/E2Pjhnf6yj/k
         JMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739173782; x=1739778582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVa68QPgK9kaQwjfkRjiftD2eZ+FNC17cNuQB5Ss6Y0=;
        b=uDjBFPOXnthfscP8FgJEm7U8TosN3mLy9tcW6ViSe2T9Vyq9Hg0KUKYjRSvfHhJ1Nb
         pqcpCapofEgbiGM9hadSvS38UvMxad/WN+DqXXm+HaoR2Xd/g3q8IoVYfH8AmGpPrnoN
         7LI5lAjr6YQ8pw0iui0V0pU/L3rSWGCz7UB8eRFtNTcio7gSurijUfJTt2dzGxQLeucu
         6gFqXkIvgI8VYvia85aAhiWHB3t5lMZgJbdC/SlwPJWOq8zS9EG00AF7+mgFWUsYIVsn
         gEGGQv1H9EN1+4UoFYVjtCJ9Cu+Rflqh6+dXAq1VsATd/H/VDNoR9/+nbMGQZIwWrSAB
         gI3A==
X-Gm-Message-State: AOJu0YxAONw04oBDRS1wLo9fpDOGZBUCTtYqYXhjW43U7u82C8u9lu8h
	DHPggpJWS6FPWsAr7ZIxifWiqW4t5+h4Cmu1nLp6ErKzQJ/cYEITqVfkxpQXe+fg6rtRX/FcxPE
	BUsGDpflrq5AV1E/91XJcUFls/GHlKCIf+pZQ
X-Gm-Gg: ASbGnculYkZHNp8XNqzfA2M+5rWIm2EEed+Vl9GniCHV81HnUlJ8SWevzQigy3J9jec
	KmFgYmIasz6obmK8a9cydJqZ4q/42yVVjdR9v/Oq0GlYbVasY/Uj2qGVBOz1nF9L60hDcecWI
X-Google-Smtp-Source: AGHT+IGMQXwBQLyl7JgDmAMFg4PKXcNdkLydZ1g/uWQYzDv9WOB894IjCtChTlS4uNEdlM4X/VLWREF4o2F7H8V4Tok=
X-Received: by 2002:a05:6402:3818:b0:5db:d9ac:b302 with SMTP id
 4fb4d7f45d1cf-5de450b1e67mr13168210a12.32.1739173782135; Sun, 09 Feb 2025
 23:49:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738940816.git.pabeni@redhat.com>
In-Reply-To: <cover.1738940816.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 08:49:30 +0100
X-Gm-Features: AWEUYZnJayc7VnjDglIHbWRqxjHwQ37YuSLYpNSJaiohQa_Xp9Ys6G64_mAKTvA
Message-ID: <CANn89iJGn=GPKF880yctgdxEFi4tgFsX+piGmyLr9MMUuxB0-A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] udp: avoid false sharing on sk_tsflags
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 5:24=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> While benchmarking the recently shared page frag revert, I observed a
> lot of cache misses in the UDP RX path due to false sharing between the
> sk_tsflags and the sk_forward_alloc sk fields.
>
> Here comes a solution attempt for such a problem, inspired by commit
> f796feabb9f5 ("udp: add local "peek offset enabled" flag").
>
> The first patch adds a new proto op allowing protocol specific operation
> on tsflags updates, and the 2nd one leverages such operation to cache
> the problematic field in a cache friendly manner.
>
> The need for a new operation is possibly suboptimal, hence the RFC tag,
> but I could not find other good solutions. I considered:
> - moving the sk_tsflags just before 'sk_policy', in the 'sock_read_rxtx'
>   group. It arguably belongs to such group, but the change would create
>   a couple of holes, increasing the 'struct sock' size and would have
>   side effects on other protocols
> - moving the sk_tsflags just before 'sk_stamp'; similar to the above,
>   would possibly reduce the side effects, as most of 'struct sock'
>   layout will be unchanged. Could increase the number of cacheline
>   accessed in the TX path.
>
> I opted for the present solution as it should minimize the side effects
> to other protocols.

Hmm, thanks for the analysis. I will take a look at this today.

