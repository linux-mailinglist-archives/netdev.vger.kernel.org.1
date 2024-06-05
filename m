Return-Path: <netdev+bounces-100864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 541598FC50C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23C8B23CB5
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741D21C17F;
	Wed,  5 Jun 2024 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zo0OKjyH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE1D191485
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573798; cv=none; b=RzzWJxW9rQ/QzBKGGBWvfEHN7ETGlN82A0sd0lSD+YAb0vXi1Q5qnbNZrN1GeNfp/znXqD87pfeNjgD+a8mX9mX8VkS3Pdgk/DKqG1XpISLJ36EK6nSYFfu7fx2hh+rpLa66ux2Hf/3rShw/A/eXMUeS8HTlD4gB5GOLQEUFkLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573798; c=relaxed/simple;
	bh=FE42yrx9mX2aAvYx08lkJboDb101vHDGkEUhaTj4lJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMvkLHVluCWhW/FN97mmZmZTpyY5v6QQUEO50fuJdUHq2qOI5LwBVThs5rxoMthYe9nKb5JWmW9GWBCS1daRTBO2OvswAhDCNCIhXBBhuwh5NFtyfpes1/U5tlKiV9Z9WnLou+YVOJH7tf7vFDPm/d3luWzEFX1vq48QSiQkmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zo0OKjyH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so9524a12.0
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 00:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717573794; x=1718178594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE42yrx9mX2aAvYx08lkJboDb101vHDGkEUhaTj4lJ0=;
        b=Zo0OKjyHOWyak4iKzhzb/hikUeH+VVrIsCk5lH8dHes06k36NykNFew7GCgzLAp3wB
         w11ve/gH0LYcDQnSox6EtBUj0Q4d/aYWoGJSuZaj7DSkZdc0vFApY55WyYPAJp/dQ/rd
         MXq6y4L1qDelhx+oot7lb3Fz/g0sd2jNOl0pn//WD870oKsO75ZaQ1/tpihCyeUiqph1
         rfoqh3M55m+rEsj+2tg6Z2JmnjrkM8WDm/PFrNcyrCS44dHdylE2Gs600Lyz3Oa2FZiU
         DMMXP7TP8i0Ba1hgUTnNrIZFmuXyqjnpOrdX6B2bxatxN13Dsj02m7+yX5iVngEcSdJk
         whJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573794; x=1718178594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE42yrx9mX2aAvYx08lkJboDb101vHDGkEUhaTj4lJ0=;
        b=ac7RpyrUjMK1Kz9zxAd5X+slUQUUxTlHJ6Vs1f26p8oBRqEybp5s5rThotHGF1JQKh
         8Z7cKt5kBgpFgFVjPXhd7zQTkrUQ+1IUQNw7bKUrzmXNV7h+eGdi/bq+XKGryJHZKZIO
         PAvIYX4AkRkeU+kxa+NEOLcqHb9y6gJO1kGbnckidvFo0mR86wRJ3RCfqp1vmMyEKfF1
         nmICffQbYvX6Y7gHr+zv0IY2BYd1A1ptpRczboLyggAe6aAi7yR5/ODDPdT5gZe8VHU/
         k37hLy4P5g6EjLsF1c9ZZI7kzuDXrFL9FqDfQfC6KFgHaykAV0es6uvjhSIluPJZaP1E
         F7bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl4Y9lKvUvbPcAc5e7DyRpGwj1dDUVeJAcdUGE7PFnLZqZr7POzYphEzmlhmK702jBjEuIWc7Z7h6YM5bLPzb4EYIpSxr6
X-Gm-Message-State: AOJu0YyYOMLpfykADeTGTVQ2d1FG3qDPQJhODgw4h218wRqbroCZHYpF
	kOBfnTUlNIHmuK78qIbIznNvBJvNkKfRXQ5scZcr6LBInZoElEzjTPOh3lzS2Q7wThXTcf+IzwK
	xZ42koHCW7GlM7W9Bj2/2/jqsTPKQNfJ8nyfX
X-Google-Smtp-Source: AGHT+IGik7WgbEwjTVgo9/fdJG7UMvJVLbNXpxM0I5UfVI/IX9afeT3W28dWzu7Du/gl9ewBx6vSxtl2TQVra+z+mLE=
X-Received: by 2002:a05:6402:288:b0:57a:22c8:2d3c with SMTP id
 4fb4d7f45d1cf-57a8d8de8bamr135300a12.0.1717573793552; Wed, 05 Jun 2024
 00:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com> <20240605-tcp_ao-tracepoints-v2-1-e91e161282ef@gmail.com>
In-Reply-To: <20240605-tcp_ao-tracepoints-v2-1-e91e161282ef@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Jun 2024 09:49:39 +0200
Message-ID: <CANn89i+BB1oZD-NScsfm-Stt7ykMNGij0b0dJYvit=PxyFOV8A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] net/tcp: Use static_branch_tcp_{md5,ao}
 to drop ifdefs
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:20=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> It's possible to clean-up some ifdefs by hiding that
> tcp_{md5,ao}_needed static branch is defined and compiled only
> under related configs, since commit 4c8530dc7d7d ("net/tcp: Only produce
> AO/MD5 logs if there are any keys").
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

