Return-Path: <netdev+bounces-163867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCEFA2BE1C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464573AB137
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471D719F13B;
	Fri,  7 Feb 2025 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHBiMEKw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58018BC1D
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738917294; cv=none; b=J+uYMDcBgdzmqGqbHweI3WJbDZxNs7Jme70andxLKexCQMEt7uoS2ZsaYmwWsUigXYB6mKo8HI6Yi2kbAcHvPghtS+Bk8q9Gwr0bksJsb8+HfJ9tdCrejpfCbTdsjdr22IxFGF1ffDovP+R4gjk6TeVbTJNDoWcwecdfdncJodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738917294; c=relaxed/simple;
	bh=3gOpEK1Axyb8vRiAh/giqnHyl6nfk1O1kDGj+j5yCsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQMHOknJGnbJCc84Clp32XrWFzCleiP5EPqLZDPSLmrfXoSNuQ1YizRbKzPtxGhPnaSBHI+pYx+v6jTZcVJYoS/tW1mddwCj0iN0DEBuBOr9JHJqHtW5o3jXwXK9WVtGXGQaTv7f/9hMUu0PT3Gs8WWw5kBjPYvfaCx1G1ET84Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHBiMEKw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so950909a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 00:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738917291; x=1739522091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gOpEK1Axyb8vRiAh/giqnHyl6nfk1O1kDGj+j5yCsw=;
        b=mHBiMEKwUquvWhDTg5EXVhUzBxUHydp04NW6zCe1KYIopaEeshg/a+qG0jYsAVIzQ2
         MyOkDCNdZGfFZqVAeexyFBF6j4AhtFkGxv75r4wsQSXSoPSCFfiX6VTdqq9jPlII8KzJ
         ird32Ra83KX5am/r1b0xZ9u15ZNWJpnAghoxUFsFL4AGo2W+5v1vMfCPeSFSDUVmRDIp
         AGKKLzUrWCp90/bHb+hPgtYIq0YkJl77qFRej6oYVkcN0+Xx7FqP0FNuW8OKFHB0ZkHq
         tYdZva1sjPxcwmwMa4vEzV8dexM1GfKz4qH0FoGjD93H5PgMFjdX/OnaF+1qdcWpWxbg
         Ghtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738917291; x=1739522091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gOpEK1Axyb8vRiAh/giqnHyl6nfk1O1kDGj+j5yCsw=;
        b=QmjLevvOWEnfqJjLl/tSwd1KzU6S/HmBciOHPg6h5wSl7A4mW7h11DbqP2OeUg91N1
         glvS3m3Ky0bIh9ewct/PIs0NYBbRzdNPxgl/jxs14F85FP7IocAI0SDtz/6kYnqzFkry
         lYiJRwlCD7eYDC9ReRfpgTjcDCdG9p9tNyEVHxGGbQQH4k8C2mNzurbQRelm9YmspqH9
         l0apBY1RREtRFEGPJd6w+wjzffzJ3INglbgcqppcPFO49GElZzOYfliV8McUV/7zX3eN
         qsURjU2nTPzLARu8KniHcvj5oCg5mM9cF1/WXyYDha/zz0pR2Egw0IvFreVhPQ7OBBHo
         wvFw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Yq84YZtTxlE+7oTPEqiLkU/TI1BxnpXOuaBOZmGUicTqofCp0Y6VUveN3qlE43IMJPWqFGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxitNFSjB6oFuJUYRu+4zIwaCymKlN8RJeqHtmKES7nOYfnfkNf
	0gDtoANK0p+iHcAtWFZj91LnYwi7Sta6o1N5cS3RMpsFsEqyuRfyPICdb6Nhv0PnbCgTxqn7Kjl
	HqJa5Cx+88oelYe+zhfpvwVET/ilJOxG2FX6H
X-Gm-Gg: ASbGncv5NKD+2T0gtxHwDQnqP2UeSYcrcsNbfST30cqZZ0sr1YKiI6psob4mSPeuOeT
	z7Sflbz/An2zUb+EEjWBpNXQOD3L0GtRGpHtOGWykR7sKySrwq1tzAmfal+e0YQGjw6IY4Ds0
X-Google-Smtp-Source: AGHT+IFhqcNq+UbvIIBZkp2vub8Eo8jHWqStCNN2hoBmGF5MckGcXho/quA1ZXjE/aZ5IYTCf8UVFI2melQ1l5VsFf8=
X-Received: by 2002:a05:6402:e8a:b0:5dc:a44f:6ec4 with SMTP id
 4fb4d7f45d1cf-5de45018934mr2929992a12.13.1738917290849; Fri, 07 Feb 2025
 00:34:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207072502.87775-1-kuniyu@amazon.com> <20250207072502.87775-6-kuniyu@amazon.com>
In-Reply-To: <20250207072502.87775-6-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 09:34:40 +0100
X-Gm-Features: AWEUYZl_MnI0kjfS5JmxOPZlKnLnk-n0aYA_nYs60I_3TQYaZq0MPZFU7B5TSgo
Message-ID: <CANn89iJidv66=HHWTcE+WU_HUU70SutE0EDwFR3GFsKUh9D2hA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/8] net: fib_rules: Factorise fib_newrule()
 and fib_delrule().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 8:27=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> fib_nl_newrule() / fib_nl_delrule() is the doit() handler for
> RTM_NEWRULE / RTM_DELRULE but also called from vrf_newlink().
>
> Currently, we hold RTNL on both paths but will not on the former.
>
> Also, we set dev_net(dev)->rtnl to skb->sk in vrf_fib_rule() because
> fib_nl_newrule() / fib_nl_delrule() fetch net as sock_net(skb->sk).
>
> Let's Factorise the two functions and pass net and rtnl_held flag.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Much nicer, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

