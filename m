Return-Path: <netdev+bounces-78728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC59876473
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA73B22F79
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADE2EEA9;
	Fri,  8 Mar 2024 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5ohrh77"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFDF2263A
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901666; cv=none; b=NTDla9X97PkxWTKxB90a6ovkIFkGsCuo8Z8rqpYq8C3jWO0nrnY7waLgj64g9PyYP7LMbJJbx9ASxWpPAxaN3eAn4rzQF0HZqNd/DMaVEaGs3Jixx2BTEnxEfgUfuxdGPn+EkutzvugpqltsqxTc5da33+hKdaF1oEBESwdb9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901666; c=relaxed/simple;
	bh=3L2E7cb7SxJzmPMlm18KG2kRhH/O/FpYqVu0tRcUVbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSiQwuWSym3kcKTH9jZv73gT4vIwbszQQ08kACPZ0C5tU9SCrJ5rvK0zEhlOMyubhnl0d86LwkDlMXc+F3fztQISs5cBCi6fsdCLjLA/UlFeq5N+FteN/zuK/8j5Pxf9zGg3OOF9OHDd0SRbQSYkIX1E+9yTvLl5/AP3EGwTDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5ohrh77; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so8731a12.1
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 04:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709901663; x=1710506463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3L2E7cb7SxJzmPMlm18KG2kRhH/O/FpYqVu0tRcUVbA=;
        b=I5ohrh77LfpdUIUNm+nEizMdXp6QqEzvL7WFa0f2G4MB//3Mnt7zDiIFg4TtHCADJr
         aVnD2CCXYVHmtRi/pOYUXaVI+g+SUtLhwTpzA2gUFFC6Df566g3oil7ONANCSZ64E5xj
         g3nhth8mWrn2qmTbnSG/g3KnMhBpfGfHwdpcuxMYJjw4pqVLpy+2MhBgQYaNG7wVh5Za
         qIkR/50RoJJlh/xnd7Et5PWrcSGp4Wp/qrBzrtLVGW/lbwT8Wuubw6D84sG3OvWeABqd
         naRgpNN5WLqyDm8LQBkpZoFJ5dIEOqfO7AiUE6XNRVgIL9RwDuZ/IIV0j85rF0dgiKPO
         E2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709901663; x=1710506463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3L2E7cb7SxJzmPMlm18KG2kRhH/O/FpYqVu0tRcUVbA=;
        b=qkGnDxxauQ8So9Q6dj3zI8Juft6q/EeTUO4T3JJeTMJ1kmF+uGXE8sGdHeQOAKg3+O
         LQBKj8ADm0YNAR0c2ptQn6bs2MsF0Yo0XrWPgWPz/lX99y1JB3ZuLcN3YlADn3LfjLGY
         RYMYeJFQngvWYgbz6QtnNinqTckCpwRtpFjv0AdC1w0QG+6WyaPOGAVs7ZbSe+gQyby4
         XmDT0Y2xDf7YhMOa8NlDB8coG+B3HizNfWuTpYNMfqcSE7xype5BJ5dHi5qWEBvI8Zcz
         LT/lSmo+hlMFngikQohg2MB6qvy0Q4+Dl0ZzFPkxaAqFe5JKteQcHlg0xATJ4IWyvqmS
         MC5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7BuCpwTGA+88YXQ+iAO/9JomYVlrDVJzKY3x2ky9xa+5NQVx3zin9IyR6z0njKw0d+C1msU1A09WC2NoEZmIlpsy0y2Wi
X-Gm-Message-State: AOJu0YwXW638Qx4m/GW+GHnfv1VOguwWpwklRrr+WuP2DIIwnz7aTCCl
	zGO/qFn6fmd5iUnuJ08RlvfyX2qpD20OA7YtpGthrrrvIERZR8yADlmrHx0zcLKyPsejmHV0Ieb
	rwFtVY6Mvr6z3Es37LB4xDtqs2EpxOofgsr2gRQNzgRHSAcYtrQ==
X-Google-Smtp-Source: AGHT+IE66nwHNBaRErNjnzYdjFFXU9hNdooOVrc5iNKzyxKDu5SyyXf7ZuudoNZKUeeJgZEl3zvc7nFdUhHd1aNDhgI=
X-Received: by 2002:aa7:d5ca:0:b0:567:f451:bfb2 with SMTP id
 d10-20020aa7d5ca000000b00567f451bfb2mr440716eds.2.1709901662560; Fri, 08 Mar
 2024 04:41:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307220016.3147666-1-edumazet@google.com> <d149f4511c39f39fa6dc8e7c7324962434ae82e9.camel@redhat.com>
 <CANn89iJ+1Y9a9DmR54QUO4S1NRX_yMQaJwsVqU0dr_0c5J4_ZQ@mail.gmail.com> <3eb282be85ab035e36c80d73949c33868e698d43.camel@redhat.com>
In-Reply-To: <3eb282be85ab035e36c80d73949c33868e698d43.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 13:40:49 +0100
Message-ID: <CANn89iKzm0uf_Sy0mQ=uDWeKnU-LULUnTNS5jNoLQroqbUuBEw@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: no longer touch sk->sk_refcnt in early demux
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Martin KaFai Lau <kafai@fb.com>, Joe Stringer <joe@wand.net.nz>, 
	Alexei Starovoitov <ast@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 12:11=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
> Right, looks safe.
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Thanks !

BTW, I was thinking (for next cycle) to let users (or TCP stack with
ad-hoc heuristics )
opt-in TCP sockets to SOCK_RCU_FREE.

This would avoid the refcnt dance for their incoming packets.

