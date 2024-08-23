Return-Path: <netdev+bounces-121247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C849C95C57C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31972B2097B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 06:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AACC42A90;
	Fri, 23 Aug 2024 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YdDZWnsq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F521B948
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394694; cv=none; b=aHqkRo9uPoD1WKJEtvvSWjfY6SBp6oIZu7rY4EE2glG8cFuUE4K1VOlhLbVZQ+h2nUgymRX0SbENiUi0zxTFqxrZGnuJl4PsLrCf1cTTJtLaQkCObAYv/SqBWEIIe0baDJESzagQ94u4JV1YarWTaYUiX8UND1AkivsIZhvJ0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394694; c=relaxed/simple;
	bh=snRWj9dyQ/xM6V4vYhJwvsd0HWEeRLCTbY3G5A7OaYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJxKFfQmkjQf60eDsJhxB5BarrjbOU1A4snPVXjZUi+R43/KQeIKI0Yx7940sm9YcqORTkuhPIOjbbJTPLuvUERCfFh8/UFs3F4+0rSbUVhL6/Cp6+Cj0rL855lO/yl4ejv5PI2hDgsZzETWZJRhXHyhHnJ1PImIFSi8KCvwzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YdDZWnsq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8679f534c3so198520266b.0
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 23:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724394691; x=1724999491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tkee8m8QVsogixOHAl2BjCgw2AqwFb4cXExKpthTnkc=;
        b=YdDZWnsqY78ThzgWozXtQ0c0Q58+LfgMFM3IvFmg078E6sXqClSTnCLy++F0Yh5XeE
         GP4Ej6etMl/JI6sPjqvgLPE2FUdxNn4OfH1BqEJZhtq4yEblhca1no1G68Zqv9lorwyn
         GzujxOOGEQvSmaLkaM+2vDBYzyyc3hxorW4HmK8oYLucu3ywoMOtlLr4wjtOmFvd9GrH
         NYO7OMKe4O9CJ779Bn30GIYWpgVVfr3BKrekeV4frIUvNUYkm5FGA1GCy1b26CCyMqSF
         5tT8D5QaZaAyzEVja4VmjGPH/7KtIa7YAC8LXEX51YGRuIlrwgNJ0BdK4HSZIJR0ieya
         GMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724394691; x=1724999491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tkee8m8QVsogixOHAl2BjCgw2AqwFb4cXExKpthTnkc=;
        b=YkJMuyDLy991cL3Wghk1BgikV22pGAkpjrFvPQgls/o2zX85bxVIBSiNBBrytWZrif
         6RdZDermX8S/bjrdT1kTO/XqaGEoGTko3TryFo7uZv41h9++WE7Uro92n3nsXw28Zpi7
         xS95MzZPWAkyjzvVFI0oqi8v4lTY2s+UlWo/G4ny74Aoh1BeBKnFM/kGE8+5ZBo+AW8T
         LZdix1qiZCyoWdkjzShH5k4947IVN/EZblJfds/8tqTH1WHWI7oI5UW1gfW8/dFJPx6G
         gvLnhsoi7htKCTU1Ny/TVMcW3JU4AwMrinooEd7Cqoy5WBuWQERXRgsA1L9aW9itWCj0
         nX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoZxIwwDbIW7e1x3Y0LPgFEPl+l4vakrpgM0fkcwrtPUJAkr/O3yBeB+o+b8iN00F9UVicJGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn2wKfplLZBh0IeM94dP+Mjv7xNkNTVqMWvzyzOkjVPXIDjoAZ
	ERWQBJr0NOc/D+F0lHylztgmTcI1fWPRWedeYjjt1bhpz+xO/xxD7xWwyAQhumkC6K/iCj3pw8Z
	sRv95/SApz1CuetD9NgajfEuLVU1R1nFHhcL0
X-Google-Smtp-Source: AGHT+IHAJmeHku3700sY/0vYhfhGUc1fJ70u+a9oA2vtrGXnoX7MlT/0hZxx2e8ldMJHTBQvhNxcs56rVM02PnyX6YA=
X-Received: by 2002:a17:906:dc95:b0:a86:8097:fdf2 with SMTP id
 a640c23a62f3a-a86a54f19fcmr77246866b.60.1724394689938; Thu, 22 Aug 2024
 23:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823001152.31004-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240823001152.31004-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Aug 2024 08:31:18 +0200
Message-ID: <CANn89iKkg6FtrcugffcWTixmbiXcZRJyvM9JcBjF46mXjkGbvA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] tcp: avoid reusing FIN_WAIT2 when trying to
 find port in connect() process
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Jade Dong <jadedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 2:12=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> We found that one close-wait socket was reset by the other side
> due to a new connection reusing the same port which is beyond our
> expectation, so we have to investigate the underlying reason.
>
> The following experiment is conducted in the test environment. We
> limit the port range from 40000 to 40010 and delay the time to close()
> after receiving a fin from the active close side, which can help us
> easily reproduce like what happened in production.
>
> Here are three connections captured by tcpdump:
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965525191
> 127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 2769915070
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [F.], seq 1, ack 1
> // a few seconds later, within 60 seconds
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
> 127.0.0.1.9999 > 127.0.0.1.40002: Flags [.], ack 2
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [R], seq 2965525193
> // later, very quickly
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
> 127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 3120990805
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
>
> As we can see, the first flow is reset because:
> 1) client starts a new connection, I mean, the second one
> 2) client tries to find a suitable port which is a timewait socket
>    (its state is timewait, substate is fin_wait2)
> 3) client occupies that timewait port to send a SYN
> 4) server finds a corresponding close-wait socket in ehash table,
>    then replies with a challenge ack
> 5) client sends an RST to terminate this old close-wait socket.
>
> I don't think the port selection algo can choose a FIN_WAIT2 socket
> when we turn on tcp_tw_reuse because on the server side there
> remain unread data. In some cases, if one side haven't call close() yet,
> we should not consider it as expendable and treat it at will.
>
> Even though, sometimes, the server isn't able to call close() as soon
> as possible like what we expect, it can not be terminated easily,
> especially due to a second unrelated connection happening.
>
> After this patch, we can see the expected failure if we start a
> connection when all the ports are occupied in fin_wait2 state:
> "Ncat: Cannot assign requested address."
>
> Reported-by: Jade Dong <jadedong@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

