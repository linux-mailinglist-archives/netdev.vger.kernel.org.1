Return-Path: <netdev+bounces-239282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39899C66A05
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E86B424269
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994F13C8E8;
	Tue, 18 Nov 2025 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzh/VTBk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA7915278E
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763424757; cv=none; b=hoWy5biiiweEDkG6wKEAJOSFYNegW0l0JZp5u2HIe1mwK9SifUGQYr5mFBo0AGfenoHq9NeivtdreaPKOfGSg4v7YVDKRBgB1ATG+oON9chyCmzzIoMj+MyNMku4w/mqilRZlMzXxkeu7onHPOzhakZVQ5di9enNqI88sJgmCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763424757; c=relaxed/simple;
	bh=62k18Es4eUtWC2jPgswY+O0FImJuDuN/Mnh3422V7OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sABXFHD2d8QpPByxHzsEq4VsQuBRll6DIm2iFZc4PIkC0w6D6OY89dcJnZIKvWSjbOkZaMpvHANO2iFl7PkEhFuvL4ML8sVhQYfe7eurn3Xy3tJtEUoATn7XioqWzo4HJmwO/d+8iUaiDrnH7Qcely92ZiRXr/5e7Ex1WcXm0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzh/VTBk; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4336f492d75so25482565ab.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763424755; x=1764029555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62k18Es4eUtWC2jPgswY+O0FImJuDuN/Mnh3422V7OA=;
        b=mzh/VTBkxMDCB51v6GJ2Ua2z/LfAftSRVpHxqBZIwTJbkqFv+iH56/vqRvAJ9lNbFj
         40YpxEn6MgwfuDj2YtTK3i1W/yAE/S54u/MoN0ZIoaR0AFnDTBk7/ptIUWV9YPLuUmfl
         SD99fv0WyeJXM9DrjpEADKuBX6b+M8cFA5QCpJoDCozS6LFgQSOqYJ+CvJJpdz9e036N
         D/SkO6BTWhzQnxHEDyowz/C9Ldtq/IhAV1m7TRxtsaY3uKS7c60ixik+98g1zUceUDnv
         1c/JK2a/kH4XipuhOv3CxR5H1OYvZ+v9BLSqaNJJNRW0qD1OMZueuq8PO4qGT4IyZE/j
         z4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763424755; x=1764029555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62k18Es4eUtWC2jPgswY+O0FImJuDuN/Mnh3422V7OA=;
        b=LuwNLtnamdbrL5KZDy9cp2uYMUI18h5Wi1z+RgIv4VHYn9XPOkgwmyXO1FKfvuP04b
         qqfYcRqKRJdwE/H8dmDaIOIVbagjOrZcNlK0+6tVNdLZoSzydwAKGt79DSmynu8g+dH8
         KTLsU8i526Tvkr89ENzhk7GZf1VN7vCf58yRLHpih0Rr6nBYlRHzENcxan+rC7rLjSoO
         pcEGRd8LkT3Uh2sZCPfSrI+54gKA2mPQ7LMay94JkSJorSHVXdI6cpLmZ3NdJ9oNJhwn
         Gk6lmvG7RAdf7zD/M61sOyegcN9916Mu3dKdCe5/z5cj7LftjAzF9f6MgmylLEDtgeyi
         bAKA==
X-Forwarded-Encrypted: i=1; AJvYcCWEENOG/1qJBJ8fwosREUFR4R8Pbb7pAYUgobQmMMgk92ExBc3bjFm1BxlJRJYafFGAk2HhiHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YygRLSgGb/rbvy5+HY5zVL2uLmQMDOh/aUIWAMFT4xzZcbzGAlB
	4v7TPa8HraRorwRtJDbsDdPbxWSpZ2HJWdNlzPeyRHHvnIHbovzP/G+EToAb8VVFQEaVFxt1Ddw
	BWg5ai25cD/1NGNz6uK75Uk9YuThK5EhhCudvpNE=
X-Gm-Gg: ASbGncujsW/4j4uimpE2R5tCs9NWbVq9+B6n3V8UbwSAZS1Cv0PJEJWqe7IyTOSNHhj
	f9vrg9mni+PIcxFDs3tFCrNpcRl3A6TW+RmDtwmoER3es/262wLkXlUm4Sad1eP0wZgEa99b2HF
	kdMIVZjT9i5kl+liLmoEjM4H4lCAJY7J9AyYcEFhvQCaQurxqBXJhAPD466lPg+AAYdwZvN8V2j
	203saF9gSXXwXb7vwTvtB6ULLV5vwhOIN7t7nVkJF3AkajprQicwdyek7ix7JkDmfUWQw==
X-Google-Smtp-Source: AGHT+IG8R79z1aVtTPL/xdv+U9Ez2QUoCUWG7nFqFgNKdsihKR2A1m6Fv7sVh+OvXRRkFuSkg89jBOTjaj1NOOcu6Ns=
X-Received: by 2002:a05:6e02:3113:b0:42e:7273:a370 with SMTP id
 e9e14a558f8ab-4348c87af71mr165061275ab.5.1763424755027; Mon, 17 Nov 2025
 16:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118000445.4091280-1-kuniyu@google.com>
In-Reply-To: <20251118000445.4091280-1-kuniyu@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 18 Nov 2025 08:11:58 +0800
X-Gm-Features: AWmQ_blQLPwAElnfDqqy9sxVQZARmhFgn9sc_xrWwkaDAC3nQb2LvBGdakma_I4
Message-ID: <CAL+tcoBcKtiD5Q8sx5jB+h14KdYcEntjznEoh7+OpMbdpDsX+w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] tcp: Don't reinitialise tw->tw_transparent in tcp_time_wait().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 8:05=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> tw->tw_transparent is initialised twice in inet_twsk_alloc()
> and tcp_time_wait().
>
> Let's remove the latter.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

