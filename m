Return-Path: <netdev+bounces-75471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9F286A0EE
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 21:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5F628C0D7
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 20:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A1E14DFE0;
	Tue, 27 Feb 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZgHnISo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5065614D425
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066326; cv=none; b=QNGleWK6kvHf+z6u7PsXFVXdjxmWKkYpk74clZLjObbu9dmbHHeOc3RC7UYzH5DeF/McRvutB0xuAp2ilCQxX7jXyJStExLlCagp6MJ34q2uRB63Rl7d5+dIA9WaP1Cb7ihR/x9aSfGEVlZ28okPuuK6FB8rfaQ8i/KcwDbhCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066326; c=relaxed/simple;
	bh=CkZepzpM/VosvywX+NgP8wDx4GMNVToGsSybSS8jHno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDZJ7RdQYnxADjm14czmlVdlu2reVYfL7xfqhWtgnY/cDTAU7yjp8+xIPPtY6To6IwnKXtUTnsI5lx1ng2c2HJo6DS300skhmKKd06O3veAJ+ym0+J2IsdoRXfOgss6PX89rjh3feZ0HzGR+mr1+AJAadgz+c9RidTLgflsPapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KZgHnISo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso2982a12.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709066324; x=1709671124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKmzJcorTXGx6YBSA/lEZ9Y4CRB9OUfazxwO3lY1Y2E=;
        b=KZgHnISojW2BlMgKm7qNZjDdp/wxYhhEvuk68jHOpq4Kin2bmWyiikK/Ab/jLj7jbo
         ASNj5/PBC961wlRJMH+TbmQMVUGx690aTkwK8CPmk3TgF64e2rFRC+BTqcxe+ZBDFsNd
         u2nzIl7GoLn5BLnOvVJXfdex0BjFjLiPr5XibEcGV13XFKSPgEZe5kcL07Gyod6LnKcc
         qDrNQIsYXlyY17tGKb5YoCdhREMaIdTTfxtHByWuHMXbkK1Hn68Lfx2kAF01SK2eWSqt
         hZ2ZtHgWEWswvdi/rCS4pyDPH1uK7XW7H3CNhfJIEqMye6VzIUijBU0greS4wUcWSjhu
         Fw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066324; x=1709671124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKmzJcorTXGx6YBSA/lEZ9Y4CRB9OUfazxwO3lY1Y2E=;
        b=PmvXG1bCWE3CVIeHGPURFc0m2R53ETL21keK3v9pbtE9fqSjq0ZSFBFHP1qXFO5soj
         Itix+gAbUj9DasZpprG6l2TZDC1jOvL5MIGd8YA+63Ksp5LZLx1EGFODY4UbfNidF3Ee
         K8+Kj12PzzvKGFcxlUboBuZ/W39DJgK/lfCRkXKIFGJALA1aDTxUkuQX0zG0t8sWtVcI
         WuU1KgVu+OCx9An7GXdnl9+VaatSjl0X2Un500N0r/KjFgx4Q/WOy1coRooEFFGdEL04
         08LwMGNguPSZEZ+CoUmKM/209CkOKWYy59grRd7emhRYW9NDqcl46lSb17X0Xj66fcLO
         5fYw==
X-Forwarded-Encrypted: i=1; AJvYcCVjWjj/67Jz2b3hcVZYMYO8UyaEtfUlZ/MegeNJG/4HmfXDi3NCGtcXQECLfDd1XvKlt3M/yOV7GfjWp1rszM5au7wzPd6v
X-Gm-Message-State: AOJu0YxmAGFzn2H+YP88qbJN4hu2H+XAHnkOazQmg6ZeZgdCw3YzGAh3
	PRmykd6Y2W0Qce1tdSjXLVbB4JR6P8SUKl9JFfWx95u6ZNFmcyO4uXFN3oWuA94fQexNpKuq3mv
	uh4IV4l82j9V1pf/FDX8IQhqbpuiFReBVElNM
X-Google-Smtp-Source: AGHT+IGDJH8gnZSClW/CxZ9poeP9c5CGVKgIi1nVGctIXngEUbUoLI/1USJmcsUnG9KZ8K+rqBZefiL7ZjbT0rn04Io=
X-Received: by 2002:a50:8711:0:b0:565:4b98:758c with SMTP id
 i17-20020a508711000000b005654b98758cmr353143edb.4.1709066323359; Tue, 27 Feb
 2024 12:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226022452.20558-1-adamli@os.amperecomputing.com>
In-Reply-To: <20240226022452.20558-1-adamli@os.amperecomputing.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Feb 2024 21:38:29 +0100
Message-ID: <CANn89iLbA4_YdQrF+9Rmv2uVSb1HLhu0qXqCm923FCut1E78FA@mail.gmail.com>
Subject: Re: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
To: Adam Li <adamli@os.amperecomputing.com>
Cc: corbet@lwn.net, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, yangtiezhu@loongson.cn, atenart@kernel.org, 
	kuniyu@amazon.com, wuyun.abel@bytedance.com, leitao@debian.org, 
	alexander@mihalicyn.com, dhowells@redhat.com, paulmck@kernel.org, 
	joel.granados@gmail.com, urezki@gmail.com, joel@joelfernandes.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, patches@amperecomputing.com, 
	cl@os.amperecomputing.com, shijie@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 3:25=E2=80=AFAM Adam Li <adamli@os.amperecomputing.=
com> wrote:
>
> This patch adds /proc/sys/net/core/mem_pcpu_rsv sysctl file,
> to make SK_MEMORY_PCPU_RESERV tunable.
>
> Commit 3cd3399dd7a8 ("net: implement per-cpu reserves for
> memory_allocated") introduced per-cpu forward alloc cache:
>
> "Implement a per-cpu cache of +1/-1 MB, to reduce number
> of changes to sk->sk_prot->memory_allocated, which
> would otherwise be cause of false sharing."
>
> sk_prot->memory_allocated points to global atomic variable:
> atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;
>
> If increasing the per-cpu cache size from 1MB to e.g. 16MB,
> changes to sk->sk_prot->memory_allocated can be further reduced.
> Performance may be improved on system with many cores.

This looks good, do you have any performance numbers to share ?

On a host with 384 threads, 384*16 ->  6 GB of memory.

With this kind of use, we might need a shrinker...

