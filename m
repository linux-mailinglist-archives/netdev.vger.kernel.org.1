Return-Path: <netdev+bounces-208990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 147EBB0DF33
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619723A553B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183912E11C0;
	Tue, 22 Jul 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mB3eQuE7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2242E8E16
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195162; cv=none; b=Myr9HAyErxJzcuRtHjBnG0bYcTFD15nw8YYfNAjR6nrK5yf1hhXva1MzyGtR0Zi7vbVgyjZHvxKV4NIK9igKVCHS1r8zHR16uiPK6UWiJS3AsLOp+JPb/5jWpKI1RGwDpsUIb/sgKd4as07go4MtcNJKna5NCBvBKajh5P8kGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195162; c=relaxed/simple;
	bh=TfOWjAAjxzaPD6O6dTqgvPQKFnlN87Rl+iS0j68i0zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X93jOAoxnC/162nt89WsLdWcR07V2CpRpAvdiJmHYosrYM8th0ajPhHsRYk/aeZ9acivTfCxz/gtQzLzC0T3acADMgvZbBewQ/st82NAhv1FkQBpomhRIL9lOg+jQXIDr8K2toyDt5phgIcD8yJvzhbP/g1aD0yLJZ7Cb9a1++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mB3eQuE7; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4aba19f4398so71542331cf.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195159; x=1753799959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfOWjAAjxzaPD6O6dTqgvPQKFnlN87Rl+iS0j68i0zQ=;
        b=mB3eQuE7lXCB+C7RLxifwxwxsK0e+6hdHNESvYza9jzHlFqE9d1rBD68Ln98rXCZFU
         1krkC0Vr8d8IdkLWK8EZaWG85CuieL/5cGOcerOmrPX0Kh69oHI5CLEGAmwu38SCxHF5
         fJRAms0KdSZErVwAoRGEkNc5P2JHi7XIqgx1HypuuWMYYgnhUyAkH/IewGWgtm4AXCU9
         6SJ0PznkhZd6AvE3Rp8nw3xRlQVRe/zEklSF+zswZSMsIYzNnG5xKOzBnTbWh2czQQKR
         +IJ+c80g5nxvlb3dh6oTVx0wIsK+AJmi79H/ENVIK969pOToTwrNM6CmiwEfg+gRCnAe
         hQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195159; x=1753799959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfOWjAAjxzaPD6O6dTqgvPQKFnlN87Rl+iS0j68i0zQ=;
        b=hC+upsYXm71NTCLQvnIZJhzTC0Sy6G5Xov/0T4vqlNDfF8fzJvFIZIL4f+mgEJq3b0
         nPsXrNkWNIGN5NlpDxUMAFqgCawyfR3J8iBVb4UmkGLfsousn0DdCywGD9556oa4iHHo
         IyYwirqNoE1FjYgyOM8aXAomKN/Rfccqx6IgLLbqznanMaA7QOodYZT/KtNUruC2HmyR
         kRcms+CV0bLn1yRjgyMJkw4RVehHJFsZM0ikCzrTDUSGWCtW+3eyrAEPKJGJC9gzqhPy
         SkiwAdJgb360nr4JKSm6662OvCewj0p90AeDbF7YKpqDI4IBmfrn4+uukLCztYRb7S+g
         YU4g==
X-Forwarded-Encrypted: i=1; AJvYcCWmZp+epfp0B4FjwQD0Et9ljSosNmmCgQmKRhnIEi6yw+lgZecB1PV6/9fwuefE34z608cPCfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwW9zCM7LfYZ1Fugx9EVTWlwINaNU0DcZ4THriB1h2BPfCYL3
	MY6/y7IpTRF8N8p9qGQfSR6Ud4OlLusrCkMckL29VKwS1m2XCZdNdjRujmFqvld99wtRgSgce1S
	hh/+qWvRSgFPpx+hA582NZWDTwxL+SJTeC89mSMD+
X-Gm-Gg: ASbGncscTdJvIFZ9E3nEJgbemNXwtti5fd+ipboQ/0MOePmpT4MMtutx927R5GSi3CH
	bH41kcZ6zr10Rrd2uQKHH3Nd33TX8zornvSaXsFolOy0+/mYtvZAMNVLTRt/R0DJwH5rUK2JYC6
	h15xP8kH7QErbKXhn4UowRiI8hOKIqgqWLxFzYRHLFfPP8b0evJ8CogSDwTr5DVUxTwcAUH26iw
	0DQCTjK6b986qhH
X-Google-Smtp-Source: AGHT+IF/6P41Pb82F2ptVRkEzRWcH/wqc08aOFULaIn2GgGXH6mVUvBywwrKZk8BZMD9A0/6nMaxFzoslrPlJkLFRIo=
X-Received: by 2002:a05:622a:2303:b0:494:b1f9:d683 with SMTP id
 d75a77b69052e-4ab90cb6a40mr389467931cf.49.1753195158828; Tue, 22 Jul 2025
 07:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-7-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-7-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:39:07 -0700
X-Gm-Features: Ac12FXzzmBrUziOnhdn3RLzTJezLALGw-_Gmb0DoUXsN9KTiXNdnxPTcE5y2_MU
Message-ID: <CANn89i+qss82KMGJHKf-uMgrwFHXap9fs67+2azrNeBVpsVodA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 06/13] net-memcg: Introduce mem_cgroup_from_sk().
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
> Then, directly dereferencing sk->sk_memcg will be illegal, and we
> do not want to allow touching the raw sk->sk_memcg in many places.
>
> Let's introduce mem_cgroup_from_sk().
>
> Other places accessing the raw sk->sk_memcg will be converted later.
>
> Note that we cannot define the helper as an inline function in
> memcontrol.h as we cannot access any fields of struct sock there
> due to circular dependency, so it is placed in sock.h.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

