Return-Path: <netdev+bounces-57972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F5814A0D
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF6D1C23612
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56542EB13;
	Fri, 15 Dec 2023 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eq1pTRQp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C93715D
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so12646a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702649026; x=1703253826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re7EmG4dUkFMkt4ueBg1VbsxnFksGTpUK+oP1mdXSsY=;
        b=Eq1pTRQp6STrjSolGA+EHlOtSg4Q0mWub65jkZGdjuZhjn9yJljhKNqFPBUwB3SePy
         YYNANVSGR+MascuSrEt4ZBbAVUxlco4VVhOwb3dXZYmqYGosRbA03JOz7Vg0aZszmFV9
         ss9wPAHRc2qSkbbs9OrE9kWTXKnKgP6ebVQNR9yUpDiwmlyz2lcvLpyQojn7OgPa6i7D
         mv9tlPcrpjCe90ppkNuq8ajuL7NzpQ2KbL24rv0EHO9Olzzfb2xLuXghMvIIPTmm/ny/
         LQx/SRgapnFj1OyD8U4uE2/7uHL+Fdkc3mFEJG06UzPj43sQ99VHmSF+5h6kimRpw8XF
         hRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702649026; x=1703253826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Re7EmG4dUkFMkt4ueBg1VbsxnFksGTpUK+oP1mdXSsY=;
        b=PplLHmtBu1feE22KVX7U6LZotsyQWlqChCTIMn8wv57uGfaolbN54jM6XH+JMG/+QB
         4TaT6UfDAXWC/+juQSFKpIPHPOGPTX6W5e5/b+jBmfR0VlWa66MT7TdaLrijKT5PEJsa
         0PP5EuEjf2sL1yfVLqQfTPw0lTQ7S0ShGkig/DHe5raViJIRk1D71XbnH1wd+WPQIZB7
         Aj8X9UioTRMcbqb0mbR489CfdBvk2myfvhpFs/oYywfyf4CEndV5Hv0LyRnxr3Brk6jm
         8FXMlD4bAnAe6W1jmScO0X0mVclH1s/qBBJoclSqsuyjo6dyAwnQ+tGhKM4xXlo2TAqK
         VyEg==
X-Gm-Message-State: AOJu0YxWIWos8XpWj604P0ibwzeMkJbx23I0b56/BLeHZCfhaUiBSqH5
	6zl2r0rsGnuuOOPqgFbl12Ixh23StZQut6fYHspCcA==
X-Google-Smtp-Source: AGHT+IGgVEEsykRVGcS2ed7Lh5mNdaC99FmXoavQzMoeW70SohuB9gUVAGbYBy3ncmOHKz2UxKMHpAYnpGpBRzAKfEY=
X-Received: by 2002:a50:c249:0:b0:544:e2b8:ba6a with SMTP id
 t9-20020a50c249000000b00544e2b8ba6amr811234edf.3.1702649026232; Fri, 15 Dec
 2023 06:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213082029.35149-1-kuniyu@amazon.com> <20231213082029.35149-2-kuniyu@amazon.com>
In-Reply-To: <20231213082029.35149-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Dec 2023 15:03:31 +0100
Message-ID: <CANn89i+cYcR51VHU0MsVyinWV4xNEHWdHt16sJTKmGRGMiK30Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 01/12] tcp: Use bhash2 for v4-mapped-v6
 non-wildcard address.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 9:21=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> While checking port availability in bind() or listen(), we used only
> bhash for all v4-mapped-v6 addresses.  But there is no good reason not
> to use bhash2 for v4-mapped-v6 non-wildcard addresses.
>
> Let's do it by returning true in inet_use_bhash2_on_bind().  Then, we
> also need to add a test in inet_bind2_bucket_match_addr_any() so that
> ::ffff:X.X.X.X will match with 0.0.0.0.
>
> Note that sk->sk_rcv_saddr is initialised for v4-mapped-v6 sk in
> __inet6_bind().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

