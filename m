Return-Path: <netdev+bounces-209007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FE5B0DFBA
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4F37B835E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320A2E9EAF;
	Tue, 22 Jul 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uapqRshc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C12E2DFA46
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196294; cv=none; b=Idl3lJ3XuQiNaLaTe0YXYQ6FG800BgUyrer4cPa2lo19xy8fX1nDRGFRqa9XxSLvlmBDfRpPd/itS5Yc2A9YhrbLTQODBjNdmBa0Pnlc4qsRT4MXJQZweCOtbyEGDNCSn5tSmusWXN/pKEAbp8QFirEa3b3upn/eD2Bj36M7w+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196294; c=relaxed/simple;
	bh=NB1BVYhS+7MybxuCFsZv3QiZHTdAuScy85Aimnn5Du0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvdrdTd1ainjcAQ96WEWaamn5ScKstpybGfKTH7w+/mO/SXSt/9byo1/k0pFWnEq0dHq2HF9T5hy4MBC+S8efqqlAnGLNbfkyeVoBiLofaiTSpx4uKbbQhapJBt5uw0CqMpTCK2GkUpXhXaP/bHXMEIXcYaId+MfXMoDd4TILfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uapqRshc; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4abc0a296f5so48951661cf.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196292; x=1753801092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB1BVYhS+7MybxuCFsZv3QiZHTdAuScy85Aimnn5Du0=;
        b=uapqRshcyhtRKuXIKnEOy4fZ1kvKq7wWaYlB+W3sszOu1Tj35mf/6ocW2c6eKPC19f
         MCxHRKUYjjuM9MEc4GyZbpEKKqn+lGKfXwYGvU3gVY+85S8xF6zoa9ay/47EmmBx8fEg
         jbc4uc523PvnT1jpFmA+Plc46XzbL0JbcD2/KYZvD9FJbZnzvln1LlBnKmiKOG/jI9h3
         n2ti/O+4Hy3S+x25Bim7DRGE1AnrQBUVaVoyO20VOd176i7Ta3aB9wTLKOn2/zFnmf1w
         9RC9xocPFUIuFn8ur+3K8OT0IchYSE8gfku1DaS2UxsXz3HV8Nc4fkCC3pqAcSdWyoXo
         v5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196292; x=1753801092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NB1BVYhS+7MybxuCFsZv3QiZHTdAuScy85Aimnn5Du0=;
        b=xKzlvNvxVtQ6JOuhkUUy4aPmmjLg2c5bcI75TNZvAsW0QrlpyBJMdL47u9Od+Jc2jh
         Lw+nGQk2WZaQ1nsgKeKNrEwHwCDOx/pDFENJlM4YfUPNuBAUyFCpGU6zHMurwKIM4fIx
         jaxnvOEpvFQUpPiUjiNjwWVK4JeRS9u4ip5hw+xQbnebQliTbc/5Yo4n35UQ7Bn24oqO
         KaYAURFtlicl8Zv9YJAm38xkROyG6Dy4YmDmFTeLbNAsodONKr4TQTN2eqTlzch73/tI
         RzlerKTDUOYQtXWm+P15yO8n96MnM6vl8Eo0eAb0PloQgMQBNoyyOOddMeDG6COjbpHY
         mJuA==
X-Forwarded-Encrypted: i=1; AJvYcCUeMzg3yvyzjmJqHdkrqiMM8EcyApGMjJ4wDbBzUFq/TlSQB4y4QnwwOnUzkvyWaYXeSzlxMKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkgfajhwIF7ex7WLSVJwN10cwAx3VXH6i+CONS57QHAG1RxBNv
	oVtChpE3nFKFO6MuiaOJVozHzs05Z2m/B/7Vj6c4qUTvBmWJ7mSlLNsEfPDxJ19d3XX/BIZRzKQ
	pBVQwd1cZCkibhKtNxzd+aSNlRRcsZSabHNJcb+Ft
X-Gm-Gg: ASbGncvumerAt0+apILmIWDDhzBa9pwGp2tEdm8s47EfuMD06Wc2sQJu0B8by8fsjQX
	CsHtDOwwetOYNEC/XSGEJ9noXXTWnJ1G1DBPDE8ehRFfGOGB/ID85g5c0AvfRL6uMdRacvbH54K
	On5KZkJ7mAxfEjk+FeiQ5dexwonC/1zDAThbJlhY+714fZtbNrDbrlQQudQRiAfbvUY8yI1hmqI
	BBpIw==
X-Google-Smtp-Source: AGHT+IHbvsTmXoMJ90OlEJkh3KhkwboNSzW3FyySqD4AsNrmtWHLtCL62ueTgeIousB3XPBSsSCTtP6ho6CBB51apSk=
X-Received: by 2002:a05:622a:1999:b0:4ab:4d30:564f with SMTP id
 d75a77b69052e-4ab93df21dcmr375890231cf.47.1753196291532; Tue, 22 Jul 2025
 07:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-10-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-10-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:58:00 -0700
X-Gm-Features: Ac12FXyjA2hCizSwjNeIJfXQ3m0aOkPNJ6whPVh_v503OAB4UKe5n9M4BBBTIQU
Message-ID: <CANn89iJckRO1b6_pdgq1dY+wE_6M1SBgzenR4wtggiykv9B3FQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 09/13] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
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
> We will store a flag in the lowest bit of sk->sk_memcg.
>
> Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure(=
).
>
> Let's pass struct sock to it and rename the function to match other
> functions starting with mem_cgroup_sk_.
>
> Note that the helper is moved to sock.h to use mem_cgroup_from_sk().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

