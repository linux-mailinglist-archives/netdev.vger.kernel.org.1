Return-Path: <netdev+bounces-233985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C284C1B0C9
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DF0188CC4C
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E008D357A40;
	Wed, 29 Oct 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wj0LysYF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB3357A47
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745362; cv=none; b=fhsgQ/1YhWNc1SlBLV/3YkNO6M6K8IWzL4A9LyoqXwuwj8soFM0YOpK3pT04zbLeQWfzlrlBQeHIdw628ZIMuO37tOYqTyGX6Vm2FAq0J2zZonYffuS/+i9jIcPTh20lUj3WrflHajhBiHK1WP7+YKISFy+Y9mH1kaUFjAPPwmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745362; c=relaxed/simple;
	bh=eqmbZ6C+/pzZCLCfiQmSe/VNbkn9pwD4O5gf0205jdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snnFNBczzFXH3YQGb6PP4/28dIlLTRLNhYeDK8ZwEN2Rsiu4vfaanPGJ9AcODUsI2gnKdAY0i5ariN3a7KzrV24YweZnarfKqHZttILRL9BiZ+AWa4IOzR7nMd+d/K+IH6LB4OkCc6kq5HRvkSIvls/3qW/PEUKEBsH6m8yC4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wj0LysYF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ecfafb92bcso314911cf.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761745359; x=1762350159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwK1ndFtoZIlgGj7bI2/GfCsVHplI6VuQ2X/63o4ayg=;
        b=Wj0LysYFHZWoefmZYI0Wnmwh0LLMSciSlQGXINtm/+R3BVfZCQgwJdNJISA9RDmTHN
         CNdCsaSbPD3bPlULXqVdA1vBl+xQIys6xM9SyceIfzPbryNksHyWPdouEKaARMd13wYl
         z7IcYSXExTMMdJxMlwtAYyBAu2ASVR1JLlXenURthOtp1Fa3dGu0CtefA6ygeYeOcCFB
         Dd3I1GbNqglW/vQXewP2coy/5h4krJzAn3wY0gk/bkELNTCbJDfmO3u30jSzMb/pUBh1
         xxvwZB1tePG+YT9DvCOnhBXAnOSN3e8f1NwVfWiPKRx6/4a06Nwe5uKjTzDuGwTx8vjc
         E1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745359; x=1762350159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwK1ndFtoZIlgGj7bI2/GfCsVHplI6VuQ2X/63o4ayg=;
        b=kQkGF3wmzb0ucepi5R9EsP804mcrLYcJMRBlKnL0rZApGM82YYkfQjc0uXihK7bmDE
         lnYGLFoZuf4XQm8Vu0rKxnf8Y/lJAoq21pYlt1+1mHPqxm8skXDt9z+yYEk9taRGUtVm
         Ih0YT5CZBCWsecS5v2J1kF8HECY1YyFzC3V1vBUC+zFvZXE7VlccIsnngIynos96O/dD
         sQeFRXClddMSF3/RFZ1stLkuO0K4ZTVfWqMl/1H1URG+gmNvZdqV0PQrI+s2u/xnFLBf
         ZKg5FOSz4PZ+fMyeKzce0AAnn6yCT/CYz2F7gyTw2ePyemwsSEYOz776qeDUqnaiyopa
         XYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0Em/ojN8wUpOBNirQd+aeFJ35Q5H2D0c55TbbN9jZSLDMC73x8ct4gBl5+bXEJHJoXN0slZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMoudNqBadGRb7SGycXV/2o57CCJz8ZqQMoCq8pGPVJUsKdln
	7VV7oNarATvXQAT6Gqt9VhgeNWsCJHb2n5aEHyOTVHwBr61OrxCrjW54Rg+6lpF+HI125//L2sw
	h+w7s5Uo49kenzJYnvnR4p9Dew4+C8hi14Za/tTdG
X-Gm-Gg: ASbGnctlddBNoXq0YoXea9bxhk/p4UBiHpB+xULZvKmPl/2/HntboO6EErTAEamoYii
	dwUj3qHV/k9ZKllk+EvGK3CntTWKxVV2PkDFWTfOqeicw5QlYIJrubUJnokGJVLE3gOlO8+ywzq
	F5E4Rb7i7t2iyV3Bua/aRUTaZNzNeDX2eYJBWzN/OcJLJGLPiX5SX7SXBbskBi5D+Z7oVpHEHUN
	LWzTm/Xsj0wwxd86xeH0F3Tm/FdUa0yb305xdoV0A5urPp9eL0tj9wqhtU2eVWp/7yVsgYze2+9
	nkUNVDSjZKbsVqS5qqzxkRu+SGTjIT7+aiilUzcaGiq4uQVlkuaWUl5ANdaW
X-Google-Smtp-Source: AGHT+IGtHWfovXqfvSbcFy+Pt5rl32fTWV0d/1Y/CsEeBRhTrAlUP7rTGJeLhXDltf8/Z2wATZXHrUKI/n/m8N95X/E=
X-Received: by 2002:a05:622a:1b20:b0:4eb:7681:d90 with SMTP id
 d75a77b69052e-4ed158ac668mr7989031cf.16.1761745359037; Wed, 29 Oct 2025
 06:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org> <20251028-net-tcp-recv-autotune-v3-3-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-3-74b43ba4c84c@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 29 Oct 2025 09:42:21 -0400
X-Gm-Features: AWmQ_bmkO50WQoFAT_CZV9_dPllZDeiEg5XeCFHugo6EvwnaCcAy-NspHcjqfqc
Message-ID: <CADVnQyna1BX8y8Gw4=+4dJ_VYn=O8JMzSqh2y1i+ZH5NpfPsfA@mail.gmail.com>
Subject: Re: [PATCH net v3 3/4] tcp: add newval parameter to tcp_rcvbuf_grow()
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:58=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> This patch has no functional change, and prepares the following one.
>
> tcp_rcvbuf_grow() will need to have access to tp->rcvq_space.space
> old and new values.
>
> Change mptcp_rcvbuf_grow() in a similar way.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> [ Moved 'oldval' declaration to the next patch to avoid warnings at
>  build time. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric and Matthieu!

neal

