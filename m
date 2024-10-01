Return-Path: <netdev+bounces-130860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF3398BC5E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962D6B2353E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26111C2456;
	Tue,  1 Oct 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xNnSuqpF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D261C2307
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786374; cv=none; b=Ek+LU1ac0q1QeEqrfPIoi8RYGf8GV0plKX4hMlqW12q3bhJ/FQIY/4mBv2hhmUdWbJOKHztjP0AKbMZdGHngjPHq+eSaU+JNHO9IkwQOIQHddMizacCjYkVWlDwOAoNJ2mnacdYlFDRHEI1cur/CUbhv6fjWhI6GzuqW8QUEjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786374; c=relaxed/simple;
	bh=+wCquij2ikQTLmIYV4DmEeGFVTOqwI///+IsadgGwyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkQ3xPkUs2GiHMjSREwU0yGWYl5M0eC8IWY7Numo1FAAdEOYpBFv2IyBK30gcbb1aqU8//ItZRP+Jai8ucNdN4rz5SHhTihw+LusJfp/3qBsa0D7k3dZ9WsERiwC/vHEPYl4Xp6xmDERuEn14eqyoerzycy5btbh8cq0tppo7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xNnSuqpF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a837cec81so446864466b.2
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727786371; x=1728391171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wCquij2ikQTLmIYV4DmEeGFVTOqwI///+IsadgGwyY=;
        b=xNnSuqpFmelLHr6mtGMUbW6u2ci8VU61P3rsfrExrebVrRs5Lw/JfE1sem12/+r5RX
         sPQXqEhflfhwJmH1ienCu6OTTYNcDxasKi/d9iRm8eA/JUc1Wv1TvD2ra6vT6YU2/kyG
         6vQBsJ8020XjhgXhCbHprT5uuNZq8vlNek1jwAoyYlMFDyKGamjbpflhDueGB0eHWF2X
         GP+kHf5eGZrEf/lX0DexA/NEa9WMfPneYGnEHulN7FKVLVN1NuHogROMkuSwkWmXtE5S
         11JiyIfFacWBY/0kVA58rv8UKEI8B3Fy1FL5k6P8YZ6bWyH69ykhhHUfcS1QB4Nd9A/+
         CCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786371; x=1728391171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wCquij2ikQTLmIYV4DmEeGFVTOqwI///+IsadgGwyY=;
        b=M/qk+pNtdUQvAU2ftYif4fr+TS0aQMj+vIVIUj1kR+/koQ1esc+65ty6SHss58byUa
         lPUKwqrRvf2cZ8rTiII0j03HXv59gdT5C0QHdsliBF2JyQK2mNzUXcK+xKiKizxnYk2s
         k7+baM3KyuUkyZnzM9mg0nEV8p5lmrokTsdhxy+CjSzUQxPNLiLlmhopui/S0pLBcDol
         /bklin5cngKdxJ0UUoU6MR+fIo/zxBF9NWplXFqkR4ZowJ1A6MRKgdeTG246IVw/FYGR
         4U2Tr6yYOwkAK+r0Aq9JdcCWVaeOdzLEyO0sdXAhiMQ7Mjb4R3dnilkoJE5aaCbvFMVT
         dyPg==
X-Forwarded-Encrypted: i=1; AJvYcCUCj58xGhvUCVRzNhEHxuemHTuO75q2MHQZtXG6F7Cfi4Bb93p5QIzBjOzcKce+qMLPZZQPfvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIkvCyh+O+3bv/ClTbUfKx67dvOXBGdULJO3pB+1CmSTwmfJJ
	3QNtn94gMIkJEOiwn0FKcDRD2xn8VkdpIUNUJjAU3kp6qsXDVbb1cc6pLop0ElYo0N/KGpfsye/
	jFZ3nlV30oZKmC+2xZLO+m9xPVjJfLaM4TEIa
X-Google-Smtp-Source: AGHT+IGBEK2SqyhwLIN+ecvTY4CV4QMehHLAYxxMHnyKF0m1a+wtcXegNomYWs7yjw+dKz/SLHK23YGA5vcZ5nxyhPo=
X-Received: by 2002:a05:6402:13cb:b0:5c8:9696:bae2 with SMTP id
 4fb4d7f45d1cf-5c89696be95mr12444278a12.32.1727786370926; Tue, 01 Oct 2024
 05:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001024837.96425-1-kuniyu@amazon.com> <20241001024837.96425-3-kuniyu@amazon.com>
In-Reply-To: <20241001024837.96425-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 14:39:19 +0200
Message-ID: <CANn89i+07CVyG6Cmg1stJZmBoCKNUCo+XdfkfOGThntP8G5pzg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/5] ipv4: Use per-net hash table in inet_lookup_ifaddr_rcu().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:50=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> Now, all IPv4 addresses are put in the per-net hash table.
>
> Let's use it in inet_lookup_ifaddr_rcu().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

