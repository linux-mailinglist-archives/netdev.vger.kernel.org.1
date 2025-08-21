Return-Path: <netdev+bounces-215504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FAEB2EE38
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256743ACE09
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CA828D83D;
	Thu, 21 Aug 2025 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBp/FLN/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21079199FD0
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757682; cv=none; b=KSCrvYfBVDBpGMAe+tM4+Ljh/6H4PTF9pgGQQm2URUFxJFtm7Ig065PPBnKR8CSWuPb6BvHNvPYFNKLO/6EYbtmpW+cO6TaZj7ZwBj0qYG/8N/MpWtu2g0k7URQiA7+v2JygE0s8RJ8oRNiFvoIcH7ZMvkq1FG4bktSFzVm3FZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757682; c=relaxed/simple;
	bh=d0XxC6BMnCTjbbCFmbQNKez8F445QZSPs4RP5qrfWvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJMu6yc7oOoYECHMNTjs5YyvowEs+DnGm0tivKNdZIvZCOIB8Oze9IWEDKO8dZ89vU9eG0vwtTYYmbzSzlDFkn5topAc+TIHKT/v4fFMowe7vTFSgZuBVTBNs52h1Ee6r4S/PvHt7qYUSfAgm0ZVASaMbuM2NltV20YNKgDID28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBp/FLN/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b1098f9ed9so5231481cf.0
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755757680; x=1756362480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeCod6hGfbpeRK5MmkXYunAC3Tc97GrDZucdiwter3o=;
        b=KBp/FLN/WdXMPnvRPcLoTBPom5FF/yir9yDofIUyocE4gb7+oa6Qn36U9x7F02tMg4
         1ZAM6fhsf7P0O4TwNeomLHC2lW0w2Y0xbpFz/2K/CtOMHEc8ev2FGW8BTF9tLEJB1z7t
         LIp/Srn5FaeHC2WSiUfFPHtl2oh8zK0JM7EoBTXjWoUF3BMNqpdiYQkQOUwswNpa62hT
         IaQMyeP9p5HiUi98x+VEw56MshdgF/ve5vxOQZCfStQGRW1p4GAVpAF9gYclpV3iYV3m
         Zhtshh+ohDu5sgmqzezcqqrRnPO2UALYL1/m6KQgTNH6pFkQQs7MULC2TkHA5raMQqfI
         hFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755757680; x=1756362480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeCod6hGfbpeRK5MmkXYunAC3Tc97GrDZucdiwter3o=;
        b=BZtjq47w9+O7tVm8yKy6ytZPrHD/RM0rbbqLDa3dNXv+XHFW2wog5GgEc4xXx9bvqg
         5ZHLgQs2uMOyhSLU9wyRRrY/QfAUKCXGzR9ovSkreTrZ3K3u0Q/FbXDkv/+X7XKFb1Cv
         WC9YiPAesF2jpjAlNUSOSbpWV1WKR0V3Trb1Z7c5JA4K+W/nX1z7Je1O4nJr48qZH8Ha
         ttp3F38YhEgEyHBzqYGhN3OYYk7J6Z0213xyPYHkR6jiDwGFZ8RcFOR28lK/3yVVr0bX
         OhYMHVk0utkhHKJrewj1BaXK7NOzCpbHP6VhJEaWbJHVo5BJ+3TUI+sHkRo8CKGbHw/y
         ybmw==
X-Forwarded-Encrypted: i=1; AJvYcCVwYOklVFZS6/WRfdJP3qKyAod36RyzAOYQd0SzasdY4g1nlECP6XkFr2OIvj1xGP6W/J6Pl+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4sJYXXQXRLAH+dEAcyHPB94CZvdCILchlB2bZEne13lSdLb/w
	wZX7yGIprVWCUth7RFMpZC5qcrOzt6VpZZ+I8rgU6zyfX4+gBCQmgXG4DJCi0i0eJODQiR7KXff
	1D/Cxs7CrCp29Ml30a6ZBiaJHNoDzqFzpO11uqEPo
X-Gm-Gg: ASbGncu4GQTMSIzDfw8LG6LCxQBG/Co5r5ry6URBdT5KLv2CvbWBUXE8TZz0kVzcmgc
	WQaY+lIGBr1dA5Q4pJLLsCnYE/cpu2brFo87V44ppd2M7rRo1MWYsUnjzTYmBk2MISGWOpzTCBo
	GqXZxE+4kX2wmS0Ik718cvpc+/ITgtR/JleVZBGa07zPhhD4a/ffY6MAZ6Eommsq5qxn3E0r1qk
	GXj73jiE6ZaUc0=
X-Google-Smtp-Source: AGHT+IHp98AEgLr9p/9SHpboSvvlmvdyKvUU0cS263J9o4AzxEUos8f2f+ejdP6K55mPabO6DtIsNWYAijATVFDhjZY=
X-Received: by 2002:a05:622a:4d43:b0:4b2:8ac4:ef99 with SMTP id
 d75a77b69052e-4b29ffba3bbmr13865831cf.84.1755757679724; Wed, 20 Aug 2025
 23:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com> <20250821061540.2876953-2-kuniyu@google.com>
In-Reply-To: <20250821061540.2876953-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Aug 2025 23:27:48 -0700
X-Gm-Features: Ac12FXxxbyzWHz7BoUufop1S45sBwuIbgDckbhdiRZwYe8om7WVu5Lj26wC_V3A
Message-ID: <CANn89iKqfPehBj+OuGDVm2VaLhLPSiYcRnUwEcPugW1FtU4QyA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/7] tcp: Remove sk_protocol test for tcp_twsk_unique().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> Commit 383eed2de529 ("tcp: get rid of twsk_unique()") added
> sk->sk_protocol test in  __inet_check_established() and
> __inet6_check_established() to remove twsk_unique() and call
> tcp_twsk_unique() directly.
>
> DCCP has gone, and the condition is always true.
>
> Let's remove the sk_protocol test.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

