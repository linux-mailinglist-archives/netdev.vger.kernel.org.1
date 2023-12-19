Return-Path: <netdev+bounces-58959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C103818B2A
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3451F240DD
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482EB1CA83;
	Tue, 19 Dec 2023 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8MIcvgE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6761CF96
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so16206a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 07:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702999499; x=1703604299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pjiy56oSom/iMHm2sE4LXBH+9WC96Qys/2cGl5n7JwA=;
        b=C8MIcvgEgwOh8ZwyqlGeT/tJMaebboH4N7YFzo7d01MQTUpbqR69otmVOMYTBc6r21
         YPVQoR6KoiEzUgRgmxwYYGVNUyeq8XnMqrKQiOXnjAp1D3q0/Rhg6uZ93bVgolJoGefO
         GeMxEnXMAdnqt5pGqw5xcZyCoVnHbdiK92rubq96RxViycJta7fdclqA1pJn2BQJ40wS
         k1WsFcgNYOYqHNEx2eP9WJ7zzsNop2yih7yYuCToGU235+2Q6VjNc/nJoTimT/Khq6ur
         wj1KWZmsSEwcKK6BpGlwchcq7JebwMQc5pbvFGQWhqcOu5Lc+TZK9z1iuzxSuq2MCLf4
         RxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999499; x=1703604299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pjiy56oSom/iMHm2sE4LXBH+9WC96Qys/2cGl5n7JwA=;
        b=rV0hNqq3CZQNGmcBa/bPcRIj63VNC+8spbdVJhOyGjKqfs4bL3tXy0iDzNFhmh43Fx
         0pK1gI0hchxDHJhBv7/LmNNFXUY1yl8J1w2HWYqgqmUajIZFJ3dFkjdzslV0uCm33ATs
         m59ImjmZElYcIx9gt7gVBPJctMMfbz6zzG4u8/Fa1MRmgsVboQAc8+o5VOsRcoNMAcXG
         G9PSu4n90iVeSBGnQAv0+aZAw6RHNMeBkM/tTc4Pub4F5lifGf2tQY4IKgOwuFJCG9tE
         ava5UHV9rjH204FlfZED8/VMx43nbRS3bMp5GP73/zui+uQQ2z+69JKocrNflNOR3TCx
         HM0w==
X-Gm-Message-State: AOJu0Yz2SEJ7RtAwWo/Hvj4g4gptArTEsUeaU2cPLB/3mYlO4XO8+XVe
	Ltt5z8aPBQAM8tzNhnpVvu+u0hWkStCEnAoj4xSaHpXYmFo3
X-Google-Smtp-Source: AGHT+IGhHMKP1ciOvkntkZerJl/tZMNFwCOwNhOz+taLmSDqsDFSJAgpy21LnL4K0ONP8hPib+v5buBr9p3rZuieKi4=
X-Received: by 2002:a50:d616:0:b0:553:5578:2fc9 with SMTP id
 x22-20020a50d616000000b0055355782fc9mr166450edi.5.1702999498786; Tue, 19 Dec
 2023 07:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219001833.10122-1-kuniyu@amazon.com> <20231219001833.10122-7-kuniyu@amazon.com>
In-Reply-To: <20231219001833.10122-7-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 16:24:47 +0100
Message-ID: <CANn89iKCKBx+pWFP8OWDz+caNmt0X45N2x+vo9AaNBLJFAwcAQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 net-next 06/12] tcp: Link bhash2 to bhash.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:21=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> bhash2 added a new member sk_bind2_node in struct sock to link
> sockets to bhash2 in addition to bhash.
>
> bhash is still needed to search conflicting sockets efficiently
> from a port for the wildcard address.  However, bhash itself need
> not have sockets.
>
> If we link each bhash2 bucket to the corresponding bhash bucket,
> we can iterate the same set of the sockets from bhash2 via bhash.
>
> This patch links bhash2 to bhash only, and the actual use will be
> in the later patches.  Finally, we will remove sk_bind2_node.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

