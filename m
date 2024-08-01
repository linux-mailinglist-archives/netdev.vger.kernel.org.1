Return-Path: <netdev+bounces-115096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6F4945248
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 19:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240121F2AE17
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D31B8EA6;
	Thu,  1 Aug 2024 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnH4tzec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5081B4C2A
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534763; cv=none; b=OwTEP9y1sybcPF6DGO/iYlUIVLA8qzoJRMJLsPi3SY1vtLluNHNHbtH/DrjQnetZwb/ArnX/OUZX9ErsFjjKRRs281J8wtUO3NFb9oaB+XnGdmJdlyDbKsM7Rq9vOa7nPNFeAdUHUIjjk/CxBbC/lvHOMkiFuvx79SLEh6qAFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534763; c=relaxed/simple;
	bh=M6InQaB0T4wGw9r+y0hXi5/zJ5LG2nNysefOOnv+iAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hk+OV7kP0fZryrnrbouWd7cLgVYUTgNE/alGGGgb0+LljJXj8p34xhmetQRcxsihMD09kazB9QIy9RZeRDzERKEtk4HAXWoabQ8sbgOiBWkK7IagNguUYUeGzo+pUfmrvBrhARnwCXIkgIQB5T6E6LMjxlJtPC2I8Jrny8h+Fl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnH4tzec; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso46358a12.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 10:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722534760; x=1723139560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qly8JbOiDlnwa/iIbG3/fk35NDbFwt36/SaFwD82+4=;
        b=SnH4tzecDrlXkBbAcaxl6O8zZ9PBNLWq+CpnGQqkLQSRY4HHtXxV5oMljMv7J9E+tn
         r0Ln/A6XxDg9oUqe3eIjQrPJjpfT1dBmDLSORdGOW+Rdewz1Fh9nDwg/lfzbsl8lEo/s
         otKCGZIgefaogjqJL7AJ+nUizKbuImYCuwG/WAjq7fiX55bx8iUxhBYKyNuU0KBcvojg
         U9yKO8rip9WoT6+okQ5dGxooU0wUHavd0AQ5uec67dEkJZ9eGPXTxvXy+amGsBiDuq87
         n1CM/T9DNuAb/cB8aS0KWgghf4KszatqvWk/QSacjsa9sL2N0A3fBYvcXH//H2RFWENX
         RirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534760; x=1723139560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qly8JbOiDlnwa/iIbG3/fk35NDbFwt36/SaFwD82+4=;
        b=bqtp2r46xElI1Plle/9fJJGNdyvyyMNzDkHU511Ippjaw6LElGccnbotxWdm4sdkjk
         UlY7H+bvEFW5uMCAVLjoXMG5dWLbUsMlM9h4Vrsr26YZI3+HnzX1EqUSpNYb3qrIHWLY
         X4LCHyBGcWVJLxcYoCb/lP4ehvDM2yyvhqNtP9o8nFvYKEk+CiHtUfcuwdaQ6CcoJM3J
         1yHbjBwp9APO/bl6wr9mHwWtosaG9c12DDCKKLMlB9mpERIbDZkGgjrDlvazxpPIZtWa
         /1e6XEtJiDLYAYnPiT+dw6WZr6OfLKhW8w358K19slKt+xTww5qlhNvj+L60K8CQbiFA
         zYYw==
X-Forwarded-Encrypted: i=1; AJvYcCVrWAAmwrcORVE1THbhbU+kYX1szmB61k7HQFBnk1jvp7kTcfJM7mZNf5dbpnqrgoA+aE1nS7WZWa5AM1wlHrYl3Q5rw320
X-Gm-Message-State: AOJu0YzAzG10v+QsGAvv7LknRfo1CePUM6SIvwlfsolii/paWQgP2vvi
	MtCpgeoDmgCV9oVhrpZEoLwfaakGk2J3jSVrhd+f/JCvDh4W9/mJipFan46HONa7i2WBas/3ltS
	JPd2t8/elTChQod2DLevL8Fau3BZV84nIBfnh
X-Google-Smtp-Source: AGHT+IHB5CJxc6Tc3CjWDacX26l9/cA+t+kvTF1TdZijWQEEpgYdyhxFzFFAkvLyaqV8sqPcAn0lgEDa7UlZziEV+W4=
X-Received: by 2002:a05:6402:2689:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5b844f86d28mr690a12.5.1722534760180; Thu, 01 Aug 2024 10:52:40
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801-upstream-net-next-20240801-tcp-limit-wake-up-x-syn-v1-1-3a87f977ad5f@kernel.org>
In-Reply-To: <20240801-upstream-net-next-20240801-tcp-limit-wake-up-x-syn-v1-1-3a87f977ad5f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 19:52:26 +0200
Message-ID: <CANn89iK6PxVuPu_nwTBiHy8JLuX+RTvnNGC3m64nBN7j1eENxQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: limit wake-up for crossed SYN cases with SYN-ACK
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 6:39=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> In TCP_SYN_RECV states, sk->sk_socket will be assigned in case of
> marginal crossed SYN, but also in other cases, e.g.
>
>  - With TCP Fast Open, if the connection got accept()'ed before
>    receiving the 3rd ACK ;
>
>  - With MPTCP, when accepting additional subflows to an existing MPTCP
>    connection.
>
> In these cases, the switch to TCP_ESTABLISHED is done when receiving the
> 3rd ACK, without the SYN flag then.
>
> To properly restrict the wake-up to crossed SYN cases as expected there,
> it is then required to also limit the check to packets containing the
> SYN-ACK flags.
>
> Without this modification, it looks like the wake-up was not causing any
> visible issue with TFO and MPTCP, apart from not being needed. That's
> why this patch doesn't contain a Cc to stable, and a Fixes tag.
>
> While at it, the attached comment has also been updated: sk->sk_sleep
> has been removed in 2010, and replaced by sk->sk_wq in commit
> 43815482370c ("net: sock_def_readable() and friends RCU conversion").
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - This is the same patch as the one suggested earlier in -net as part
>     of another series, but targeting net-next (Eric), and with an
>     updated commit message. The previous version was visible there:
>     https://lore.kernel.org/20240718-upstream-net-next-20240716-tcp-3rd-a=
ck-consume-sk_socket-v2-2-d653f85639f6@kernel.org/
> ---

Note: I am not aware of any tests using FASYNC

sock_wake_async() / kill_fasync() are sending signals, not traditional wake=
ups.

Do we really want to potentially break some applications still using
pre-multi-thread era async io ?

Not that I really care, but I wonder why you care :)

