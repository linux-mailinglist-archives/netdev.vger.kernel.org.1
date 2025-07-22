Return-Path: <netdev+bounces-208981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B79B0DEE5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B939189E13A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E322EA492;
	Tue, 22 Jul 2025 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHMpSN1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3532E9ECC
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194886; cv=none; b=fSywd1lFORtCGbA9CilxFnDi3c+2yqb3T+qlPXHzAG8VELJQFL2ij4ROE8wXsBqr8wpbywONe56rrdN/wqTQSk9525N32USjHri42qnhesu+zWLsvlqM2AnJTSI8awABcVBVxBMpfqcl9EKF/4gNZKyychHUOdxZp4rPfJx62jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194886; c=relaxed/simple;
	bh=k1yUYuQxhxPejZAVd5Osy9ksEslSrueRAJCbWso5h7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ym/LZSrAgT5LIxdXMpba264LBXGwt/xLXNHFtkGKMmmj0LfJdf4Qr+o1tD6BlVu0xXGXLz+cx3wBK+An82z+PX9Pnj6KKiIFrhJao+UplODRg6DV2lWuIErZZIFjzd2tdeopaN+Ho1i4bh+MgxEw9/C7la02AaYZni/8bWDV4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHMpSN1X; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e32c9577ddso521749485a.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753194883; x=1753799683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1yUYuQxhxPejZAVd5Osy9ksEslSrueRAJCbWso5h7U=;
        b=fHMpSN1X+SXV4QgfglrLMmyPPc5DkwXoUrTPx2hzXGivYMkwkPJAV1d83wztaIf0FN
         xpGXqBh9f9ovNHjTcPImxd4TrWbvb47Piv6H8b4l7BwBDhb5EvIvVCCxgFMksvpLa6Sk
         kciAyA3GDXMANCtuYzOZncV/XCxl0S53HymHVJ7JeXzxH8/LQXIn+a/TkSth6MWgsv4W
         IW/+fRUH2EbT4t1wYb2ZbTulJn2ZDU39cFh6dFqrhzF5+yHh/s6e+8VKDtQqjcv2OZnW
         JEvVB6VRGy7TKMjOIp7kj7S+o+fK6Z7jqX67P8fLl0gHrNpUYCaaub2S4xB+pLXbuWTc
         jIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194883; x=1753799683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1yUYuQxhxPejZAVd5Osy9ksEslSrueRAJCbWso5h7U=;
        b=iaxIfm7ead2rzzK5l65fL0igXGtyT1z+1sHtpOLD0llXb4Bx0qw8QbbJT9r46Yt3/x
         o+XoGUHsh4lHG1ys46aHPN3ZAeLXKGhe5jWbc3kEsBueg6A4RIASfznKid+sEHovfLuI
         L4QA7pe2TWHgFPeeBSZg6+l+zHNGQRZWf7Oxj+Xer2YjJMjkf7LKnE/y+bGoFQhB8xDS
         dDuNkRokDLER5UnjUqOnk21U/k0+vNgUh6+hExeY48E+TROjZfsg8wg+U2m08PEIBZVP
         qhTgse/WYf55QrUUyrlT2mI5JTlrEKaohNvlj+dj5faB5QEHrcjRlKA6OhttyGr5CScw
         uhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV51n1ZaVNnUbaMWsAMgkDxcSyPSJKSpkAlHXHi8niTkEpY0/GinRQY7MbpUJI9Ba4eteCTijI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBUw5vKr3GmXXJ/oAbrpZ3jL6mHmhGIvU85cXUcfRBlbl+h0XJ
	5R2amGJLxrlXqN1zWz9GIAyeADytKEZEoioEPM5Rt+lNdwkGLpWkYsRlpSbext9n07svZTnE7ce
	iUYC1TIc7IEnIZS/5q+b/w+fWhgx321b+VXiwCpCU
X-Gm-Gg: ASbGncvIWev4Fwgx+CHjYKTADS+NGMe+00IdgwxytJ2HEJ3nB6pvmRemYOzbKyu8h7x
	3dDaQWjQ14JpPXVjvn67fk3zeXdn5uMH9c+1qy4+u5gWG7c3W/SvzRVJ6wO6yHqqKQJ6/RU8EJT
	ERRLxA+cPpxyYveYEcQN+KkU2FrFNPoX2w0pr0/PoeFTRXSyMFpO+4bU+tu0BafHJgBmSBFnA+U
	90LRg==
X-Google-Smtp-Source: AGHT+IFiji1w7r7AjCXlHaxfMjOrdW8jkVVGDDlvc9QhWhAg0vDKfADaHSk4qJ9skd7E3tmPFXgzgJZBnGJrSQTiafg=
X-Received: by 2002:a05:620a:28c4:b0:7e3:3ba7:f072 with SMTP id
 af79cd13be357-7e34356b85bmr3408946185a.13.1753194882975; Tue, 22 Jul 2025
 07:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-4-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-4-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:34:32 -0700
X-Gm-Features: Ac12FXzGLru6M1-g50J2KyQVjtZB32-ZEYTqBFpNaueaVx_KJKwNZF50EJpN3Ps
Message-ID: <CANn89iJkNYHLGqXCTFgG2rEp3S05VVkWi9=2HedGqqfw6YF+uQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 03/13] tcp: Simplify error path in inet_csk_accept().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> When an error occurs in inet_csk_accept(), what we should do is
> only call release_sock() and set the errno to arg->err.
>
> But the path jumps to another label, which introduces unnecessary
> initialisation and tests for newsk.
>
> Let's simplify the error path and remove the redundant NULL
> checks for newsk.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

