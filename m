Return-Path: <netdev+bounces-163868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB47A2BE1D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EEC188C8D0
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C822719F111;
	Fri,  7 Feb 2025 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xGE5VvD2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123D7DA8C
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738917313; cv=none; b=pFJ9qhc4QYVFvwSvr25jLu/bhc7+TEU0WfFdmcy/97Bd++DgzJY+QSiGWdx7aO/pOrxmK40fzKPXzIAb/dU+WbK2FUGuRR6sSaxeoNSLNOYsZcp3GxsTeZu6qLQmNyLDVefVoBj1p9Ci7iyiLDnJNf1ul4eAwqXEGNpJDc540HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738917313; c=relaxed/simple;
	bh=j1KHgBQEsGIujbMVYxdEdnUFx5HCIupD/Qh5vcz1lhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0wG9AmgawuRLmbWvAz7+2SRxP7MQ9irwMUCyKQUhQeBAt8Wsxf/XCpkZhGbfMjFS2oUEgdmOWziSOIOT6+ZcU4MsG8q6ZNOtuxlTdDZXW5ASfZsCFahiNdZB8gntMBgKajd0TXKvNAqdNCbH4dINjEOB9jjK/IhLqwudRObdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xGE5VvD2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dcedee4f7bso3057124a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 00:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738917310; x=1739522110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1KHgBQEsGIujbMVYxdEdnUFx5HCIupD/Qh5vcz1lhc=;
        b=xGE5VvD2ryDYqiQ0/5XRHmtpknjCWgd5w5I9iFidsS1whvaL6eT08A0LY9Kv148H4Q
         NAjDD4iBSaPBBZstUZrLdkE7i8GEMbGFYczCM+LUnzBkpzNHJUlWKchFsPbSYZYQ5O6G
         ibb3GbYvDakJAJVENvZONy+0IiW1jPXNepSgRWN89uA2w+80dt3a5TkFCIyVz/jfFH49
         kuW7gnJnDfAnsxRrqmsxCYZNOhfr3VPQSqkABvfZ5FKSgmhF1DLSccKS7X2N2f8PHOeO
         +CFowDG17eIUXvaZ/7AQNI8hPgvDeSpgLzkgIm6tD++eExg5sZ/yBLjNRzRsxHCHMXrS
         8sRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738917310; x=1739522110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1KHgBQEsGIujbMVYxdEdnUFx5HCIupD/Qh5vcz1lhc=;
        b=mWKjolgu0NuM/i390WIYYv9MYmYRJa8qQPFIpZxct7lrwcbJ6bqfGB3pRQlfJmQMId
         6f8AGRHUWqxbY6B+TvxSb5pnt60shkxuj/IEtI8Hez0btojS5zj+ViqdHOX34RfS9xXM
         p2vdGxKqn5EbKlbG5D+Hf94FLtH8IX51u+lHJlUPnug0T0HEkRQoLi0DipJBQM1fLEFG
         i2lelheWcV/FIcToWgo9PDsEiXWHPh/o0wCMwHv8y9GYD4QB6Oq+gezX0br1HONjQ1pJ
         A+Ldp0Ax5zPkl4NDD+/Dqc7tvSRPKVZWokgs416XwnLpKcqIYMul1gEzZ1NaLbAfs66F
         aKuA==
X-Forwarded-Encrypted: i=1; AJvYcCV5paQQuC9bt/prC9TCnvYG3pl+vsWlTvWKDleaLoTZZz1xO4TOAc0IQPkf95XvvO96nClWIh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYEayQu23VqCyMrp4RcQkdCsVw8LvJZNMivuhxd8eQ9qRG0zaG
	9VIHqxM/Fj2vb5V6fHa+kETtFbTwJf4sIOdmiQMFz/aQjjxxxtLKkYQRq8mhweoAAWEgYaXvaeW
	jGzAiRF77N0hHCAVEYck5df53lZNSWS7wz2wF
X-Gm-Gg: ASbGncupA87CencLqaMNVHn8uXgbFJtsaMimQYHc6G+JfA9hntjT+KbptBz6Mw6g68X
	d1kCoOmFri/59f2tQWM3GkYa9Dx7MNaabAUhKrFo9cQptQ22UTjRNWrL4pP0982XrR8oJfBgY
X-Google-Smtp-Source: AGHT+IEru8Ft/Tmxy6kM38SqzjmAGrTc4R3JLZ1wPmwgwPh5QTt5if4/nA7a8Tc1i7qevjdbHWwuCb/ZFcR9Ui7Sgr0=
X-Received: by 2002:a05:6402:1ec2:b0:5dc:cc90:a390 with SMTP id
 4fb4d7f45d1cf-5de4508fbebmr2971410a12.32.1738917310320; Fri, 07 Feb 2025
 00:35:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207072502.87775-1-kuniyu@amazon.com> <20250207072502.87775-5-kuniyu@amazon.com>
In-Reply-To: <20250207072502.87775-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 09:34:59 +0100
X-Gm-Features: AWEUYZlpExK2MuNpUSKSHrXqSJE7lfKsVm2zXD-1MrzZZX5PLhRSwt6fzMHXQBE
Message-ID: <CANn89iK2pakFrpfRcJ5vo6T=P75uPDxDPYmc08VAqAA7_uUCng@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/8] ip: fib_rules: Fetch net from fib_rule in fib[46]_rule_configure().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 8:27=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> The following patch will not set skb->sk from VRF path.
>
> Let's fetch net from fib_rule->fr_net instead of sock_net(skb->sk)
> in fib[46]_rule_configure().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

