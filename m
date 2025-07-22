Return-Path: <netdev+bounces-209006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86687B0DFDA
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD9E1881482
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA0D2EBB88;
	Tue, 22 Jul 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TL/+QEoQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D952EAD1B
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196230; cv=none; b=M9i7nlda7XpaGSxXXqIXapTzczsYwhfC4sc5lxHpMmP0ciCdl6wYBxaGCAPvEtPhleEiONHDELep0FQBO6jVlrrZrMWfhcj+qAVCU2TpcVjIB4gl2Q7uXCINPfpgETyo/mmhCumuMpRs6bkwqGMK9ciTOPYLPfK/1uTPA5xqlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196230; c=relaxed/simple;
	bh=m0AktCLJK+ZUuWGfQ+iSpRiQx815PM7rgLaWcjzgcEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODK/3hDhOPyUmK0bmp+Tt1fggfeKnDoqqKy6uqA9oM0XRlspcpbC8pIwU/qD+qp9fuYn+WnzxYhBmQtBpiYtSZLlNWQyHLB67TvVhH1lGC5vLilAsKqOJEQefuPg4YG5rvcauxiqKJ3bH/1afETG7S3o2d0IjmIFS3oQmWGqHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TL/+QEoQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab554fd8fbso52775501cf.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196228; x=1753801028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0AktCLJK+ZUuWGfQ+iSpRiQx815PM7rgLaWcjzgcEA=;
        b=TL/+QEoQTvHHTqKVfsSawckKOBexZe9Hm20dESlfmBCYMNKoc+izJ5Dcexnj8J4BUm
         oP5bmepRZYfBwVlnMGPiTS0pKI7x0ZJr7TduCEiDphuFrJTrSqXLIPijcHb+qocD4Apb
         pRmW660zRre7Q8aNXWY14fz17dxwKK033KFUOyNZZcp8g3PCjtQt45FMnHyZXdizVbhw
         KrzNu3p+5QlWCasb1KI7U0A6a4u22NQkwuNKNl2W2jWunxsE8yI8UhQcnUn1Z5F5iQCl
         NepgOc8XRLf/oJfDRYLVlnKyylq861+vSIoE4QMT6NdLnrLpd7skz8E86WzZIhu+s+zj
         y7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196228; x=1753801028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0AktCLJK+ZUuWGfQ+iSpRiQx815PM7rgLaWcjzgcEA=;
        b=o2N3VUGGuBOQB6RmoWNco8srCLid8zg1d1BJ/i2jdRA0lx+RmD/FxoovjJlN/68sCI
         X73NbliSBSE9+omQAXjPO1qwYuNGEdoqUIJE7NY/9OFZBxNBR7DUJYMpNDxmo6+dhHgK
         jsFzvC6KTPzlgWqwuo7lHQi/h5ID4wPu1ttcnENYbAN+xToWOOAJvl/lqTtEv8Q4xmkl
         +r5umLlYqghdMymSqbj0MwfR5Ch0+ov12p+ofL5iIjCejk0wlw4AwbOLbo4QyhLbjpTC
         cU4pA7nLinhkaCXS1g8bi7m1J/3R1dU+HS90zww27yhOMeyQvyEhLZEqQzhQebDNaWaw
         s50w==
X-Forwarded-Encrypted: i=1; AJvYcCUqbNKd3IKEYKlTsCmH0Cp4HFWcJqNXoLEa4Yt3YwxUHaYHRlv3c2YUjGf7YkNjbsshTASt1Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnXxrm609WB8HotxOnXof8U+6zVcSMLcBRgnuW1wvYxgzRKDhq
	Kgam7iuIPT3VWy8ESaJvqgHBbryNbiVPAUwFLwOX9DZuysiqYEiwcCby0rpQPviJSkyw4SppwM2
	NhTyxQIwbTWa8/prYWl1zN6uHj4sKMSazq4fzHfz4
X-Gm-Gg: ASbGncvgLcpNqzutPQcHPevqTtb6xgH2oQgnHWK9OPUUvpHeoS/cv72vlXxoHVIZMGV
	qg+V6ew0ciDdIao1UG0h0JKLo/jYB+iL61WEcWOzBTbxAp9cMvw9TxUstTaf3z6DIpU+XzjrfsA
	WFZ/p6hMs8BgaygMMc7yW9dHoMllWrmXvteWOt2+Fd0Eyrf/CvEsz4BgWudObQ2dHxBGNWKG0W9
	jyjGA==
X-Google-Smtp-Source: AGHT+IEsEV3GGTDTdmiKaik3AqH1VA1TZx7fA6+/n168ze76wf/ZMKc7syZqUWj6LZzqN2/qXmVi5AZltoQwXWaeFfU=
X-Received: by 2002:a05:622a:5514:b0:4ab:6e3d:49b4 with SMTP id
 d75a77b69052e-4ae5b776852mr47163651cf.7.1753196227557; Tue, 22 Jul 2025
 07:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-9-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-9-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:56:56 -0700
X-Gm-Features: Ac12FXzomuVijK6Zq5KT2dKkSJnghXUcZpgHafRcifrYJKvhd0CQdjVZBQvvh-E
Message-ID: <CANn89iKC-RJg8Xi1o6Ks4iCgrrwhvYFxDGwtXN0q0KM6HqAs6w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 08/13] net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
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
> Then, we cannot pass the raw pointer to mem_cgroup_charge_skmem()
> and mem_cgroup_uncharge_skmem().
>
> Let's pass struct sock to the functions.
>
> While at it, they are renamed to match other functions starting
> with mem_cgroup_sk_.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

