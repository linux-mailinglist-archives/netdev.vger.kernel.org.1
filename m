Return-Path: <netdev+bounces-58956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E26E6818B1A
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7350EB21C19
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCC81C69D;
	Tue, 19 Dec 2023 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="powZY7E0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410E1CA80
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so13541a12.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 07:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702999399; x=1703604199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QMhMMLEMRxrJl1VQtRKbGYpYC+RUR7bN0BeBRcggNQ=;
        b=powZY7E0PCPNqDOwOMdjIRslyX9f3gl+Xy6HjKy+c1pU5wJV/rO7Z6jIBGDQXITpCo
         UlUdacx6OLGjjaZ9n2ErfHrp+DdjT2/TY9qNOrOJKscmBmkbgdlOBhRZUTHMXv55u0+o
         /ProVWSP9Aa5qvoCivHsBbndmphaRsar6Kj3VkiUsZVYjkHNFxyO1J4oaMFN1QoNOg5y
         0y7FV1foS7vdu0SX2NDVgX7eLHtemqmNXotqn83TOfG2LYQBD/2N5oNPuTJl3ic6cR21
         xTUm20KKfaSOimGwd9mHqg3lkBjrkFIvEtDt++iHf712F6FIlsdjrPjLrtK1d2zvztqj
         qY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999399; x=1703604199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QMhMMLEMRxrJl1VQtRKbGYpYC+RUR7bN0BeBRcggNQ=;
        b=s6/rAL8ht3IICHPzUFUAUR5j25OXuzXdF8F2O/6zKtXHrv4Jh544K92RJQQAhESL+E
         WQvwI4wcsBQHDOD32tmHMrBPk5eghnd5gwvwqin7YCtQJXu18J5RGnpp8/8HuDta5RYp
         y94sB+ubTc/xibFeAEX2NVn2XSnRvKR8bPzwzYhnahw09hQBxRJyx0YVVh34sd927E8Q
         3kNsq9o1iYgtIfPEy2sYSeclulMovarlQYA4owAUs0442ksiqUKau4Q0JitkcVtN53IQ
         4PIj4fb1TbmYzshUGuf3QyguF8EfPeDEsVX7ycR4itCLUkTWw2UHtKaS6jsROu+ai2is
         tymw==
X-Gm-Message-State: AOJu0YwXJkHCPfquarOKLTWtAiNYrI/uASmnlRED1958VHU0wR4eRnp7
	n4cHaA8Icun3PNmCPvHPCcsVMPYinkns0G/xDTTyD75n4QYd
X-Google-Smtp-Source: AGHT+IHifYjdhptk3MBVBLO+UzlVVUrkTDR40R+GBtcLCZGrNS9pCVZcOChOWQdnNLnQTOYFaSrHdks/zFlbQ1kNruo=
X-Received: by 2002:a50:cd89:0:b0:553:6de7:43d7 with SMTP id
 p9-20020a50cd89000000b005536de743d7mr207290edi.6.1702999399406; Tue, 19 Dec
 2023 07:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219001833.10122-1-kuniyu@amazon.com> <20231219001833.10122-6-kuniyu@amazon.com>
In-Reply-To: <20231219001833.10122-6-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 16:23:05 +0100
Message-ID: <CANn89iKZhMCmPJ5BFzMGgLNv+PxGkUP6sgZVO+BBYLx4wpmEkQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 net-next 05/12] tcp: Rename tb in inet_bind2_bucket_(init|create)().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:21=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Later, we no longer link sockets to bhash.  Instead, each bhash2
> bucket is linked to the corresponding bhash bucket.
>
> Then, we pass the bhash bucket to bhash2 allocation functions as
> tb.  However, tb is already used in inet_bind2_bucket_create() and
> inet_bind2_bucket_init() as the bhash2 bucket.
>
> To make the following diff clear, let's use tb2 for the bhash2 bucket
> there.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

