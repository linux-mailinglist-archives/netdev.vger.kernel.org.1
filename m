Return-Path: <netdev+bounces-175636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F909A66FB4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD60163D99
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178D4206F3E;
	Tue, 18 Mar 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BaKGo38Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6104205E12
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290010; cv=none; b=EN4cGY5Bl5feb6dYGn+LSFLMXaHqoGGySz1222cftFAiYQxnBm71Vqg3zGDFEfdXCvflgITR17bx7SxzhAhsTXxWkIi2DRfCPL730kYBS827/wiJMmiBdwDrt5uCZ1WydOOBvrk7M42Mtif8Z9nsI4R00KzXU6T9xvpWUdFeRwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290010; c=relaxed/simple;
	bh=K7WLujWoljwW+BQw3fQDZ4AzAIDG94uWqYgtswzzL/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbQR5qc885NFctBJ04/x/emCe8EJzmzZkp5/khfP/IjOUxfYg9kMNPTXhXJt+2brUKakOCj98R7gqlZBmRd4t2mckpxV9keunyvM2V5V+0YAnojXK8qJtYUqiFEpBYCMyv8/3FuyF32yTzB4AExhMFvoWJR34GmNssxfUPwirPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BaKGo38Y; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476ae781d21so52915141cf.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 02:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742290003; x=1742894803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rn9PiNxRwC+ayrv4Fwie8ODXaVzWtUveoky47fwvbHU=;
        b=BaKGo38Yn2pFUjOxD5C6F85e4lP8dtEBYz0XThUKLROW9iofW3rduRamEHp+dQrsUp
         Z6gBERWUApb+JvctCpNp4zjksCJU9BLWhQ1yEJ7VNZnCgjkKCZGFBdYBtZOUi9pQLULd
         I8IqL2KP6gu7nbx/4PoIlP0lpywMoEViUUlK5Nzkv+aRzpt6oCM0V7KLyMPa1dQF+N87
         mVN5FrlzlzKA409Jx1pBvA1FWa1FzkZdTYeQqpKHiZonLNCcvZeKgwp+sE7i3/iGxYiD
         LjpeyEfdOhJx+EWZVAjROCC63JoZ31A86rrGoeysgbHEAQC29pfwsM59usgmr/Kd3B9R
         XF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742290003; x=1742894803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rn9PiNxRwC+ayrv4Fwie8ODXaVzWtUveoky47fwvbHU=;
        b=O1jGqRBsB6wCXvBktOqeuzzbxvnkOYwptvyeiOsSAhNU35F1JGyvZNH+8LjCOPOCMw
         ldkSUTmncRLYxY831js5TpQTDVSKzub9+qxEa/JjlJ1O51FTW4BXLcPqhUhpZiIL+klx
         4gr4DQYcjzMGmL1d47Yp+zkQxQNsDQXXHPpFEU4HfuV3uSXSjXLd68UpwHPGZFduy+D/
         PKb1xZvG7ebq/y7ZSItCYWs7Pee0kXBFj6UWS2BqP/A0ciFJDKl1VxhXD9IyhbpyxpVP
         pFAi4s93MK8Hr659i0nEalb8A0e/cepdPC0Roa9lk85s2m76xsxqxZgA6zGf+evriysL
         Aexw==
X-Forwarded-Encrypted: i=1; AJvYcCX1SBCzHbrVhtxjV3JC91ie8QG33bqQPRTcNvH1n+0rUdyljtVdyWfxHPRbX4Gb9ztnEoQnNDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1xsWCD/zyUDdWPdihrUa+Tai/p0esl08V3TSbbiXJ2N32JUfi
	xaJdmMbOmuoJ/7Cs8igNdBRlAaRZbmaTpuEHgGY7BoAEYUnF0w2uaGAGef5lGJy9ef1vT3IDx2m
	V7FmlK/PCAy3nNWfc7H87kveBSfUCz4A5FVySdUlwIzmBFUNMiGrb
X-Gm-Gg: ASbGncvxh+iqwhaVVHmBW3+NNxzoEtEY8+SVbPNe4NRcriEL4rhLPdxrP4WhUA1Fzkw
	9lv7iAifhF+fKGl+ktUWOCWxhhvVSa+OP7TSqTEWhZ+A+qO17owxju84NVGCEPekGbmKEYQUeuN
	1QfKTU8NRkQSWAceOBTmUn76cRI6s=
X-Google-Smtp-Source: AGHT+IHPT/jGuLxKSqdTYJ+JNmk2Unq5Hze0Uutgt0oLJgrn9HeG4kCIZmoEKrjNJ/bea7VUt7gaX4XiwrLVu7M8Etw=
X-Received: by 2002:ac8:7f04:0:b0:476:b461:24a3 with SMTP id
 d75a77b69052e-476c8133f02mr277293471cf.3.1742290003408; Tue, 18 Mar 2025
 02:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318060112.3729-1-kuniyu@amazon.com>
In-Reply-To: <20250318060112.3729-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Mar 2025 10:26:32 +0100
X-Gm-Features: AQ5f1Jqa7p-zZUvy_-W0IE8BVhOjmkJEB3PD7WOEEv1viankOkk7euhF_CaAUIg
Message-ID: <CANn89iJNst-QihxX+xXRJAzoGGViQYAhTVWg93VqL8hKc8qL5g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] tcp/dccp: Remove inet_connection_sock_af_ops.addr2sockaddr().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:01=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> inet_connection_sock_af_ops.addr2sockaddr() hasn't been used at all
> in the git era.
>
>   $ git grep addr2sockaddr $(git rev-list HEAD | tail -n 1)
>
> Let's remove it.
>
> Note that there was a 4 bytes hole after sockaddr_len and now it's
> 6 bytes, so the binary layout is not changed.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

