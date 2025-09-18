Return-Path: <netdev+bounces-224243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31291B82CC2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 05:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9E5325BCC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 03:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7F021FF3E;
	Thu, 18 Sep 2025 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+GFaaCf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF41DE3B7
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167211; cv=none; b=UD9K5n2Xx4gObmNRol153vSJTZbPLeI1A91aUKfYuB9kpX5FrtNyPhHlYsXpzfABlKFbR4fsOulDvb3sW45dG2aA/tK92ZxQ9mpREaiOpY2iRfLa4zSI0uvlfEr1GANwWTuE8i+7q3vkW5QZR78vZEORrG3bWqUzjo1/2ym8DNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167211; c=relaxed/simple;
	bh=ECBt2fabf4psX97EM/5MFA68dBd8PAOT/IBjkGz7N3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjaII0zW7PgqrVmMDskhDaL0gD+Ny0QEPeo2WGqgU8dkkOcnv8tMNlPUjG3ZoiHjPr2IR7Fx3r5vfCFVgSDuzkrwQ5ui0FMGCng2jLtSR3wrOEUKTyP08V2VWb+0zFx1C9D9JeDnaLDbagUyykxEIQqRZx/ih6roCegpU3GN1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+GFaaCf; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b34a3a6f64so5289171cf.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 20:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758167208; x=1758772008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECBt2fabf4psX97EM/5MFA68dBd8PAOT/IBjkGz7N3w=;
        b=E+GFaaCf5pWzcoxhOIUNBECwZHSRL89KIOzlrHxxbhYQzq9wGaPigQFxURbvNvasCK
         ODECM3EJ23VD7HHmJtPnnmQB9e1SWNn8qdnU7jigpBFkObYWzHDdiHF3PbY5X2JkqTxo
         lgVBn9ky3U7/y5Ony2R0NFleYSPPHbQHvTr20Mfu5P0AYsIsdbwfHIcgF460UO5r3FNg
         STaEQhpFjGqvh/O6jUHsjMCzeGd8Ml9FSFQ/TLZNcVsIf8Gc3w/zJ35/to+XQ3fG7d3f
         60jRN9BmJXsGOpSFbqIWyyoS2McqqVZHZr1ToKVtCaPCoUmfF+57KJKNNtJM1L5EHY0E
         i5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758167208; x=1758772008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECBt2fabf4psX97EM/5MFA68dBd8PAOT/IBjkGz7N3w=;
        b=lQLUCOlFyCEdBHhkOk2WmByyK2woYVtuB5uxstzvz9FRAlT5hMxIAQ2GvCrZJ4j1fh
         SltuMyDofqjAq6IxJFB7JXsBCdI597AIn3O7xnJG0PNbNXpnrQd29u8UPpRyYTLq4fdt
         5X3LEYAM/DNsoLLi/yae1giMAY1d+bhiiMMFmriO8DIA6q3m/TtVugQkuv3Kz4xSfoid
         4+car6mld4QOLZYqHAHSMJHNou8ErKV6r1F0LcSvG5VNAEEsrkfNsJ9g3EGLmjoWT9Pl
         NosaBkrCoySQJZsMLSt4tkm4liHrrbF5DlzGBxOSXModtOyLggju+H43twJaDVpAsgr8
         DgQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsHzawAYVc0+hdfzVKEFvV/9l6WMNjJIgHN6PBAYsq4dSinH7+KiVIDcxPkE3eJz2h0QNmRBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWXXGFumKvhV51zJkCSzHNKJbGgl79JIdUH+8xFy0pWxE9UUHx
	7Y19GiGjMYTNuEUypPcjR9Q7yx8vzpioDgl8tRNGegYWnUZnlbcigRrJRQn3oEBbkHQDE2+3BDw
	pERf6n81Q5hWlUQ3Qlxg5kTnSVutSGw4Jkh210HKg
X-Gm-Gg: ASbGncs6DkS3ShEroaVjhyMmErTfz4tGzQ9tgT4+aYpzDGwdroz24sug42PZGzaXHZq
	E0KoF0KagvufElwgLruCr2ezJNwj91A5CIyBI6jJx/SC59TDOM6xXjXuEtJoKIW1KLQXeGu+37f
	SXZ8zYw5+2FLLNUbhxcquRu4/dG+R3rFLxyuQuvlGX/7sZFMYn860wTJbPqGB4nqb94Z4qzzLyi
	ncKoW0LR7kgaCRb0tg6tWTUu5/yQat6
X-Google-Smtp-Source: AGHT+IHjYJloR48EbgDNMDSNzmGPLcgNq1Q2NlNYieva5yfz+JxT2p3K9nuOczQBI2tljbhRc++4dgtOucNlUAtIIqA=
X-Received: by 2002:a05:622a:5908:b0:4b5:f1e0:2a6 with SMTP id
 d75a77b69052e-4ba6ae973c3mr69222681cf.58.1758167207629; Wed, 17 Sep 2025
 20:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <20250917000954.859376-7-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-7-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 20:46:36 -0700
X-Gm-Features: AS18NWB_Bbgy_sbSayEMCWUY8SSEzlMFAzRmvfpC6Hr0pbfPwa-20OenunKK_mw
Message-ID: <CANn89iJi8uAcD2q72uiLhmRbmwaKogAvew3CJ+83o-w47t5CDQ@mail.gmail.com>
Subject: Re: [PATCH net-next v13 06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Kiran Kella <kiran.kella@broadcom.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:10=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> Move definition of sk_validate_xmit_skb() from net/core/sock.c to
> net/core/dev.c.
>
> This change is in preparation of the next patch, where
> sk_validate_xmit_skb() will need to cast sk to a tcp_timewait_sock *,
> and access member fields. Including linux/tcp.h from linux/sock.h
> creates a circular dependency, and dev.c is the only current call site
> of this function.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

