Return-Path: <netdev+bounces-169819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68684A45CE8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698BD16C436
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044A1AC458;
	Wed, 26 Feb 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9CULw4g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805E258CF4
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568713; cv=none; b=lbGQLU1Oq6VUOPAg22UnC3aceJ8hjP52FjbhdTs+j34dGhyiai5mMg3mFcU2uk1znKPijhC5Ffco9o8+U9XBt4JGdXHPfuHUQmxDcbfW5YZHukn2r8YLSkQkmcyJ5s7aiUHcotiWV8Y8cbPdUJRP8RLb5TL+rGiwyUelg333DfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568713; c=relaxed/simple;
	bh=p39U3Ur3EKJxGAky47WkhROS5B58D69noykiYpJ9FZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jl0g3jFW5PVwuHxZ7JcorwM+M5YEZEG87f6tZUxPvjsY/md4bROFUcg895PhBA02iraB38zvjcQe7Z5CZr+8SxevTJJeAZPtgJb0Wq+I6ulTrx5QJFuBGgEhQ6f3M34HJTXdQVo9G4Dj/w7jecHca5wc8LP35ITHDExJGJUNI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9CULw4g; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e0813bd105so11189689a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740568710; x=1741173510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p39U3Ur3EKJxGAky47WkhROS5B58D69noykiYpJ9FZw=;
        b=h9CULw4gogew8AT3KUxLoat7yqzNY50ZfgcenkHdJgc7+ZrIN7BlTXd/tLp34bfmf+
         Z1WheNAVpnnOmLfTMqRgyfAAaEv0gYIt8dQvePC3pS3wjqehDnS8TJYarBSXVtq5Xtph
         JVzc7o2rFOtqtQUDDIZeR3MuHDIiN1TtfkHi4vHCSjvEmlOkFo3m/rga/iMCXJ0A41B9
         ngmvkdB45FFO/BmBZbVsq1dNRav9FXScAEGnUDXR4sECUlncj366OKcwO4jy/NdrBb22
         OPi+nr0RTPql4tX4KjvKJGHXDFh6blLMPHBHagq/KS7pJSyn5z0gHCon8lkXKSQwe6L8
         dNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740568710; x=1741173510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p39U3Ur3EKJxGAky47WkhROS5B58D69noykiYpJ9FZw=;
        b=r84s8LQcqLDpqb1OoiD/ZmL64v+ipOn4t1thChXqeAn7jvNCXmtteWvwiXjs+gkA4/
         oy2f080YbJbsKSrhsDbdW6hCjvyOgZKCIpsEtZiBBNkzkr6VZopSzi12Lf+AXGTe7Rtv
         5Rpw10ZjGjBqMUXS01ar92QKeey1aGGxIeyPonC8uEbfg9rgfSwWLzyse9XubEMhf7eq
         8RAlMaHyg4RmqQ4gbc2UeJeIizObpG7DMut5R+AbgScpwwcDs6JJmwTadfr2Y44SaBZ0
         mPFSy3g35yCC4K0wUosXMRCmE8QLyY5sXmul086d9MZOj02GASX/FL4+w1+nASRpKH05
         mTXw==
X-Forwarded-Encrypted: i=1; AJvYcCV8KlOmNHEvITag9FY++VFHWt9xILhpxU/1BCeDmvEqTO0H9/GclFpPVEsbjF72l2NVgbYa5BY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjip82hPdDnX/LOURXjTHUx2UKEq1pZlcMawvIOeYAT+EwbIbg
	O/sM+nXiW4Im0BjgDjL5HrANUeeNsLKw6PzLqdDiIaaDb2ocl/KVbfCx8LZTZEIbxPHxA5Vje6W
	MsfuWinpprJ6c//PONqf+QXwLgNOzAcO6jcdb
X-Gm-Gg: ASbGncvc1AjKUgTjH6iOKt92PMrXd4GHiLMfhZHQ7352tNCZL9fItI8MZbQjdd4Skf3
	idclRdSOimmJLLlPJJlTRj1MfE3dacNKUvua7/A8IitAgDyCLOcpsxQBh9iQGKZhDFmGBnE6KRC
	VVq2nXuoA=
X-Google-Smtp-Source: AGHT+IFGiEW/Oh0eswhA5kVR35UF8uQfbzJEppPNyn1edAddN2U2zYYFJN0O5RxGNqIcW1iHCj1MgIWeRGFrNj7UWho=
X-Received: by 2002:a05:6402:234f:b0:5e0:9390:f0dd with SMTP id
 4fb4d7f45d1cf-5e0b722e566mr21895568a12.22.1740568708318; Wed, 26 Feb 2025
 03:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-8-kuniyu@amazon.com>
In-Reply-To: <20250225182250.74650-8-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 12:18:17 +0100
X-Gm-Features: AQ5f1JrtLkQoNQF__niQ31BpVolVIaKgbeSgn7-vQF60_japmE02VYWQfUGzzko
Message-ID: <CANn89iL030b0asmFu7VmqENG8nqcLAN6=sSaXLTzVq8g6KtH=Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 07/12] ipv4: fib: Add fib_info_hash_grow().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> When the number of struct fib_info exceeds the hash table size in
> fib_create_info(), we try to allocate a new hash table with the
> doubled size.
>
> The allocation is done in fib_create_info(), and if successful, each
> struct fib_info is moved to the new hash table by fib_info_hash_move().
>
> Let's integrate the allocation and fib_info_hash_move() as
> fib_info_hash_grow() to make the following change cleaner.
>
> While at it, fib_info_hash_grow() is placed near other hash-table-specifi=
c
> functions.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

