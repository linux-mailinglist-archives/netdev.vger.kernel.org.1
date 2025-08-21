Return-Path: <netdev+bounces-215516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A11B2EECD
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6FD1C868F7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6317926E16E;
	Thu, 21 Aug 2025 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tockeKHP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D397E2E62B1
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759215; cv=none; b=u/SB7YwsgF3YjUe7lxj59C9tccW+iV2A+kL1MWwMbY7JwttqpnRGJdqab/77GXMprgMRcHzDTeOJ00WuQzcvi7khVN3KSCeLbyrVU4nND4Hg0rUmuuvY27b4FHrloNVJyXcXPZRSXYV73yjmb3U/g2kraphl74VJHagta3I3jWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759215; c=relaxed/simple;
	bh=M7J9IAnoMXRjoeXr4Z5fAXxG4ZY1i5d4Ds3d/5zfOl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGNRRlmg0GhTlxcBrM4F2j+eyi8m3Tyno7wESLUXoFG/Ub3794VFPYb2QQfknZqJ1U26OTtxdwyomNLdkDQzyreyov/XGT968AGIYbTOQHw7m4kqzedX22RK2sUM1l0Qp3f0zD7v8rzpl/JlfFdfYwpa9yo91u5IbQF6rPYXqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tockeKHP; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b113500aebso5001681cf.0
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755759212; x=1756364012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7J9IAnoMXRjoeXr4Z5fAXxG4ZY1i5d4Ds3d/5zfOl0=;
        b=tockeKHPvMASn+HWRp69GUiPRachkK8OtEOiRmM3a05/6tKzT0AmP1gSAEJeruJA6g
         G4+pRMwpg2psF8uZB902To5zqa94sgHj3sHGBH+kOFWL0xXif4QOxaJFxIzqjCCzKHSM
         3F0x8GC/KWOZmcREQ26iRVu6SWkeuAPvTj/JwyMVL+8caT5QkUMDwusIbYkOaPkAdSQA
         0V73Dqj6qgy+umXWldH8Wv3pANdFI1aWLUK6AOR3cgWLwlYSXgNc1YCN52UPNC5PuyQY
         eB01fgAxvCauQtN35Nb20Yfxmey2tWgPN4wTkKgONZLMMTMMomXJG/NvEJ1uUd29BeQw
         O3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755759212; x=1756364012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7J9IAnoMXRjoeXr4Z5fAXxG4ZY1i5d4Ds3d/5zfOl0=;
        b=YeO4RS/8GR8vBzRZ1P3Yj5gtE7XWN7SKZe3/B6wMa688RxtHhTLNCX5pa+Suy0H8Bf
         J4o+ti3Dc3bO8fXRc4GdGemJNCo8mN7fIGk9m2iKpzbA4b1O9Mu+winurB1poymX+H8i
         raj9k6IpMk72OT4bkVxZMPqHv/eR6Bz/HZFp6UjmpTvCfgcbbf7h7UTRnuYwQN+8lMfK
         Lol9k954tLKtjqDrevTpKT8aOK/dzP6sKKG9dvTY88MyDzkT/8lcBlCEM0ZwmD0BhBvR
         VYGxUk6/H3W0ct4PRDI9XAIfLpGUtsSC29pKqjqrPOe4Gy2VtvUaS2MvP6AoJ0LRfSjH
         UXFw==
X-Forwarded-Encrypted: i=1; AJvYcCVP0sBz8oTENnf0teb5QOlA6gFGBGXtL4QlhiovNCP9cuLhnW7c/IEqa02c3dKPUHujSsFkXoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyEgD3i39sK7rA4cFRE7Jp8cAJVJo6CH20+217FEck43MwCAMA
	cl7Upe5VS5KNXm8/6s7UXNnVJKHZqtFFh+diUAzQHI9CNhT9llS+IgIWkMItCJmfIY058ugnJyK
	ytwHGAOVkkLyGqDrVEWQ/t2+emqzZDSTM7u3/XS5D
X-Gm-Gg: ASbGnct0XGiQ4kKwg0QGe21plwurG1n3bEe9o5IxYAINpYl+ac4fqTdRUNy+9ndM2eY
	NP8+tP/rIwI332CCgp7+xLYzFxZJlrGGh5vELbgl2rqFGmkmKDmMi80BwPidbMr5oF7QiHCBaGf
	NNnVarcmwRyoJyFwSLgeO8rPJS7zi6ZDd5UpDUOEzPZtBFHtv0KEulB7nnQD91K1at67YTaqmV+
	cqvV6htxBiMhLlsVoAvJgi3vw==
X-Google-Smtp-Source: AGHT+IHX6jO/7aubGACdT2nVn9oWenUXLW62GgG0eJ1FiEkE4kacYkpf/tktLGMqYovCMaWd5b/0d3FyjwDbPAn3QJw=
X-Received: by 2002:ac8:5d14:0:b0:4b2:8e41:1aed with SMTP id
 d75a77b69052e-4b29fe8aab0mr16086531cf.50.1755759212281; Wed, 20 Aug 2025
 23:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com> <20250821061540.2876953-4-kuniyu@google.com>
In-Reply-To: <20250821061540.2876953-4-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Aug 2025 23:53:20 -0700
X-Gm-Features: Ac12FXxz1xRu71mnZAomU1JltNm1GgGVxNWhXmjb77SkUIkcDsooI4eeUT32uY0
Message-ID: <CANn89iJyTbBdCnM+NJ6TWmO50=fcunvZHBFWwOpmf2n1FCm9kg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/7] tcp: Remove timewait_sock_ops.twsk_destructor().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@amazon.com>

Please fix ?

git commit --amend --author "Kuniyuki Iwashima <kuniyu@google.com>"

Other than that:

Reviewed-by: Eric Dumazet <edumazet@google.com>

>
> Since DCCP has been removed, sk->sk_prot->twsk_prot->twsk_destructor
> is always tcp_twsk_destructor().
>
> Let's call tcp_twsk_destructor() directly in inet_twsk_free() and
> remove ->twsk_destructor().
>
> While at it, tcp_twsk_destructor() is un-exported.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

