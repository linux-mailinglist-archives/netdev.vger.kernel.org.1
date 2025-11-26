Return-Path: <netdev+bounces-241713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6808C878D1
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E40134DD24
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026774A0C;
	Wed, 26 Nov 2025 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQBteJm9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41C1367
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115630; cv=none; b=k52zS7KW8JdPobAT0GSHg5SBpdWktbCGSEeUGrgZWbIdPiQlK6v0GcJA1TZglRWfsWPIfJrHcOdtBTyP4TrXYIqxqT65CEspsnN/7sHP3Pwsi9jBPy8gXRaaOyDnNciZtWPiHM0oU79QYJBog32hK/Czy5Q0WBTnW2fY4GGX6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115630; c=relaxed/simple;
	bh=iyrUd31ZWaH0i0BrytfsFgt2FTmld5q+qWNSb6jLjVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSPxmsZRkNi65M9llyA1qm0wo5G3YRg25a7vf3VY/PHBMy4KaKO1HI0mUKJaKLpUKJh3TSfQY71oDf635cdn24MNjIBsLEgxjs90cXwrKOuWyBdTZgOuBtJHDY52jXjkRVQ8+0ofXbFo1ckn3crRK31NfADop/YbfNJ4oaEXxZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQBteJm9; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11beb0a7bd6so382860c88.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764115629; x=1764720429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyrUd31ZWaH0i0BrytfsFgt2FTmld5q+qWNSb6jLjVQ=;
        b=EQBteJm9eXTJyv/P+w1UaC6aXgb8hYfdHMsy/Fyu/w1VZHgI1EPEbkUVbvJvPxhph3
         UKsfZ//9TPofaBHUyASAt93EevhcAAKQ8/oI16Fin8/Dk7M9uj2y3SvOOpnhXaRarrB9
         JWdYoctd/D9l3yZHUvEAGurcvjUciNBlYIwVKAFQGmgloxLxKxjYZUS4345IhI4PAttW
         uG94B5w6AVpM0Lvp+PTqDnL+7GeKtK9PFQqS4dj5mv7ysCsCdo0oorpmouUmLZRaOEPn
         zGOTmdBTHbumziyDd+/lQvcxpasKJWejBg5Mq4WlwYwQamhkdw7E9y8mDhUJXjUsS/AH
         ftnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764115629; x=1764720429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iyrUd31ZWaH0i0BrytfsFgt2FTmld5q+qWNSb6jLjVQ=;
        b=hcH2Vm4aVG8sSA/H09ABG/Aa+01jSgiUKfB8tHt4mbFcYsQmD4IIPFZPWONg6kCcCy
         Spk69u8zRMCByWYSM2szCnwaFQkC+4P4alDgEKqE8x1QLudx2zAlQa0kAwCiRBtxSJM0
         O6/qd1uG/M+l7TDG8Ep4mHs7YziZ0FekVwI5p3I+frXMNVb522CnjUkKoBpumUwu1kDy
         IJIyZMvAQc6rZKhUSzXo4cfXIt/nBUM0BBGeC/GHT4suLHcyVR22meyBE9LNqRlfn7ld
         AR9V+w0h4dYnyjx0bxPGrJQNvyEyYXl/9UEp/9kkcCI1gHPOrLLo+5Pn63wohPjhfWoy
         vhjw==
X-Forwarded-Encrypted: i=1; AJvYcCXzfpR5m6qzVEhnuW/bGPBfw+Jvw+xiLOpNEmhiOMx2AaH4+USBebihUkn68V7n5lBu5tLMO/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPWUwzly18yr+zwIcIObdIi5Uxm/lxf4ZAsukkiABMfnZmtRt
	NONiVTY/XrHtLcpRZf2da4fmHZZWjgROGcZQXihn7WOsF/6qJOX1y8QkqRjG8K13Fj3BdRuregz
	UbVoGbkd2DWR/CSGYtptnZ2Vh0GAs7RxSvsPRcjOj
X-Gm-Gg: ASbGnctnGoLlmqJfRj+y3BP+u2frCkTvtwwcJyxXDZRO0BL0SDk/fKfJgZgG1NTJrfT
	pjM0XuhKXzIJat+IzsXrA01Oyf5KDX3drxtvN/fRbayRWAky8iJFnRx0AYJndkQlammGMLTu5yd
	nYhfVsR8SOONaXloJW9qHHgJPTIwaqe5NrjCj8avY0/WLMdVllnw3HcfY+G7LThv4ZFd4tKKUPK
	5oOSVGoYO9lQrtmCC5o8CcHcnz88xtwrMwnN6rubqCqKke7fnoDYl+o/qg377ywT7FunaJJDHpJ
	52hkOhHfGVCmpKmJwsXvMa0EE/VBAbWKmJxJ+4uD1vavBtHLk57/NE6NIw==
X-Google-Smtp-Source: AGHT+IFlp6iB/QEeYhaNQNbarru15+QkwauOp+wd3a0e3Mq9WLfG/KWp8BKwRnTfq1hEs2TMwm0MlMli+2dZug9ZDJk=
X-Received: by 2002:a05:7022:418b:b0:11a:468a:cf9b with SMTP id
 a92af1059eb24-11c94b0b693mr12081103c88.9.1764115628227; Tue, 25 Nov 2025
 16:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124175013.1473655-1-edumazet@google.com> <20251124175013.1473655-4-edumazet@google.com>
In-Reply-To: <20251124175013.1473655-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 25 Nov 2025 16:06:57 -0800
X-Gm-Features: AWmQ_bl4BCGuGHsKm4MkgyGWV5UsjcNFLKEeXnbIcuFqdfVcQtqatRzPrGBsByA
Message-ID: <CAAVpQUBMth2wz+9E=6bVr3XwuQ42T-iR-YU0A-Ah48mLrfKN3Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] tcp: introduce icsk->icsk_keepalive_timer
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> sk->sk_timer has been used for TCP keepalives.
>
> Keepalive timers are not in fast path, we want to use sk->sk_timer
> storage for retransmit timers, for better cache locality.
>
> Create icsk->icsk_keepalive_timer and change keepalive
> code to no longer use sk->sk_timer.
>
> Added space is reclaimed in the following patch.
>
> This includes changes to MPTCP, which was also using sk_timer.
>
> Alias icsk->mptcp_tout_timer and icsk->icsk_keepalive_timer
> for inet_sk_diag_fill() sake.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

