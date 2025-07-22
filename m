Return-Path: <netdev+bounces-208991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DE1B0DF3F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A397E5414BB
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B152EAB90;
	Tue, 22 Jul 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="thD5e4Md"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C432A2EA726
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195242; cv=none; b=Elw6SeSn6pMFTaYIei+EFb059KBpTsTGbOPmYKoBhu6+SFC8gCDld35tpYNmU8zEqZzP/D3+w7oCZL7wh0pHgtR2MV6JUHVeoXt9lNzTghMPVcg6d+trFgDIUMSTbp+rWKxDwf2W8zn4Zxq0dvJRvyiG+6+YGHUKCFm5UDNBYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195242; c=relaxed/simple;
	bh=4mYD7jOdcf5aFysRdnyjEGsG+qd6blmLlEJCLBef13Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcL1g8MLgckBB3JREnYKb997JLI+W7e4X2EPrhcepSRwZQMLoC+pSJ3TKn4N5AdmQ5cl7MdgPB7zXvEXNijzmb9kVXgrOluZlQfuWwaHsXbgYcQ5wSt8qUl0WA/aYaR22a0Ky+vlMr1TetQEF2URfPvbkfP5bjcBd14/XAfUAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=thD5e4Md; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab60e97cf8so71458461cf.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195239; x=1753800039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mYD7jOdcf5aFysRdnyjEGsG+qd6blmLlEJCLBef13Y=;
        b=thD5e4MdwcRjx418RWl/C6obm6caRo7yqimJiDXQ2UiFvzQKUCQ+TZCx9fIOdWH44e
         +1sbt5glpU7nRhWM84VLNGn3Ex2ziNzR7Fi3JLMzEPiEaV3deN1XNwWN9iDLAqAeapRc
         gvU9upP3sSUdKlaUQTU+Nw1T1Y7jxiNsk0VscY3S2fWLItw6Af7PG8NadKnt4kfR0Zpt
         ed+cyR7nSZyHDEziIT3gtX+4gDDrxmxWY6AHHxAOhczhR8lHa0hJY2i2HTdUXAlnGpeN
         jk0IKl+JMWe1SUrqnUaL77qJL7OAKMiBpzSiSRfRDdKW5s58qklEz0R0063unoH0MDFs
         Ca0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195239; x=1753800039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mYD7jOdcf5aFysRdnyjEGsG+qd6blmLlEJCLBef13Y=;
        b=BTYXmAi/xS3f1/9E9vdn/KRDmcmRwoWEGllKeixexaivDD9ECLz2dmEbFOJzaJ3MeY
         E7eWQ3+es4auuuc0rnbcFeVDCbMbNGtOVfgV0DMG8v4AffYG29wUaJKjjULK4cm19Rt9
         UHFQuATyOEyXeeSJYfsUw2tLQKPJiuNMiLDdu6qKQAqFYk483VtTocAE3/JHuMbqC8eH
         M5q1BZEa9FLYbEPrgdEWySF2WBA6IcK70ZxAtQKsnMsNrqi2X7bTHbfiK7LNfDxIFTOS
         LCxye4fERqwTpWysLsLpfzjtwFgjJQCHW9t8S6Qqkh9oJLC/u7y0atRshHLQXBBUur4D
         zF/A==
X-Forwarded-Encrypted: i=1; AJvYcCVyi5NLL0X8dxP5wZ+N0EOTvgJi+4KZ5SLfvbbnMj11gYVILJNT8UwBPQpIegyZrwvTPIU4itk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdeSZHcMfkqmj5DE5z3WDMMhvOvluoPBCPIn3jARUWqOmwjHuU
	NT4Tx20JirR7Y4dug+Z8jXMGDKsF5I20D0aSc7/gZwlK33oPlRP7oXXkWyMM86mc9aEqAoCuaIp
	X6RaXUHiWYfDuadraqLBNmYIKADLKvbCK6LzWR2Kr
X-Gm-Gg: ASbGncuA/aJtufNpnLFJbdcCEcPCUh+0xDCHjn/AJpXK1KdO6eYuWFHpMZWg5FyCNcX
	RXtpwjc8DqK35pnjvK6M0H731x9D0J7V2O4fCuuHPI4ivHNIrZyPN2PmdCULWkGm4WU5Qyo6x8K
	8Ep1ZjGNYVqPHtXVpC/fqMiw5bi8PIcqia3v9BMuyEvzYXACGoNOTE6CiyHblhQk2XiMMOgkRW5
	XDdVH1xTeYExYPf
X-Google-Smtp-Source: AGHT+IFZ5x4jrTTIZ/sGd3+42jtNM9vA9GRL20sU2/Os0v7FJS5rj0L8KeTwvfFJmKz+wiHNsfD/xtdlAAVmvq93h24=
X-Received: by 2002:a05:622a:250b:b0:4a9:a90a:7233 with SMTP id
 d75a77b69052e-4ab93c9cf1amr314039221cf.12.1753195239084; Tue, 22 Jul 2025
 07:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-8-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-8-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:40:26 -0700
X-Gm-Features: Ac12FXzTeElONnU3WaxKpa2K4YFqUCuJ6KHpalFp0jXckJ9R0eBW0R2J1Duwmhg
Message-ID: <CANn89i+XTkEfrLdJJa88n1YWPapFAc_OY7L0kAPO-z4hsqjHhA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 07/13] net-memcg: Introduce mem_cgroup_sk_enabled().
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
> The socket memcg feature is enabled by a static key and
> only works for non-root cgroup.
>
> We check both conditions in many places.
>
> Let's factorise it as a helper function.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

