Return-Path: <netdev+bounces-202057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABFBAEC220
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB027A227A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4E0289E36;
	Fri, 27 Jun 2025 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCVygikr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83A272E74
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751060152; cv=none; b=CSMVR8K1k/Cft/KKiqRUJBbpVbK3TO2a+LOcn9XRT1iC35vKHNSn4kJnRnZhTE2P5nB1lFY8PSU86kLgU8evr0ndPhKUrtPpMvuu8rIK3P9FZeOcCaQntWT+mALuBU0KlEYhbj/nBE+tKPd3DsjEAYslahqPFx82IZCey/YhYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751060152; c=relaxed/simple;
	bh=Q2IkAZ9vilSvQ6vi419VGdptbP5AYxSKpV2iK4CE/t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgV/vY14ZlGjmgJI7I/7izXhs7E9LnLnKOko4O4AeWPYmvzwmAjrqOOkOnMCWIgrPxweYMoaBlfxevreM9I+j8AcD0rblmxAuwKquT1aIuoOuZdgTWmiMQwAB7JFZZL30pwwuXGDHgKs/yJkEmACbUtHe4mu7rPAdZBIlbJkCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCVygikr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23602481460so25926985ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751060150; x=1751664950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2IkAZ9vilSvQ6vi419VGdptbP5AYxSKpV2iK4CE/t0=;
        b=aCVygikrs7UyanXHA6SfK88wWFnKJhkZROTcP7fLjO+I3l4Dh8eKZuqYNVCS+iin9Q
         MSdT4arB+s0cpRFghWVuqAHHnQ85ohuReksOSshRqhInZZXPJRnOwUhyIOtl1iDdxP+L
         7AyknWPA+xV3XPy0NxFLH1FmxtHTJS8+it+roD//8M82s2yegUm+eVTtImYznDGmYNeO
         tN/TbPHNpVeCZC8LPFH6KMjuPVCAewpDeCn98BTtjJJ+I4BwUzllpeJGWp67a3ozqefa
         BPBpnvKZnYil0ccn0p+3cGVOieili3o8Ewgc/trnNkU1YR7yJ5+hiLw4MolkB6BrSsCY
         hCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751060150; x=1751664950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2IkAZ9vilSvQ6vi419VGdptbP5AYxSKpV2iK4CE/t0=;
        b=akwVkr9t6vj0a0xHTrCIG7VmPsnKVKEM/7os8CNT7Mk4WpK2c4iAnelRoLVc6xrz2H
         ju9Uo0ZztDFuLRPocXTerx70VOV6d7URELtbTy9XG2VTKl1/oMLDQf+gIq7qh744Y2Wc
         y4J3BRzJlJKHQvJHlMyjIwEPpJ5t2UH5yqu5dhZ80B0625NtFSSncJWMWShf0gCyxnMP
         AHgcxzUzHBDV6NiUYK6moQcDZn7f8mLw07+aTQCEC6FoRWvaxUXFyVMp6kGKZGhDehUd
         L6DWgzupkUYhwr+rjyFYi9WgjG+ozK/LyiyTPrD1iSyGw6qwRDBtyZhxz//dQEnLXUFG
         nqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMNdaVriACJUlWLCDxnLSN7VPmtbeCXXuCwjUTsZJCEuLs2zEO8+J5CteWwFtEIUtnoZqqBG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmywFbu+gfWUEQpTjYCLwR0eOx8ajoayUoubEdWYAeAecnA6UB
	dHNGiB50+h0PnQI0HVnBWwIcqS7b0UIqY5gBUI42lOurviiLrONJGM0lzGvfTRpkWl706XUHSU4
	RyF44bUN30AF+4G4/uzcw4C6kHlbbSeEyz5KA/Yvl
X-Gm-Gg: ASbGnctE8b5chlVpnFbFoeIjPjgh0/bDJ7O2Slv5c06gQuzWej77WbKem87LCjajwXY
	+m4ceVjrIxU7dlbmFk9DwuNPCY6r0pTg+qbT0bi3CGTv1K3GDdgLa0fDW0a3BFbKHgnG6vFNJAP
	GWVoKe/xxlQcG8q6G592cdrLcgCxm+iQeyYfP8u4jYzdGuyCs3JBNVK5OL0rzuBZAABCjW1Pdy3
	Tv9
X-Google-Smtp-Source: AGHT+IEQLQuIvYNNe19cO2qoKCg+y+oLEb5lW6DWPu9afSbK4cJ5yqgI6bWFQNNWbfnZGahkTjloz7H26iCwbl1or6E=
X-Received: by 2002:a17:90b:2745:b0:313:27e5:7ff1 with SMTP id
 98e67ed59e1d1-318c8ebbb06mr5495765a91.1.1751060149972; Fri, 27 Jun 2025
 14:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626153017.2156274-1-edumazet@google.com> <20250626153017.2156274-3-edumazet@google.com>
In-Reply-To: <20250626153017.2156274-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 14:35:38 -0700
X-Gm-Features: Ac12FXwrTkDNJfKqlKTI-Q9uQT9nJJ7v_k_ePpXDCDrcp3HCmBlPjBzssfhvbjg
Message-ID: <CAAVpQUDnRmORL-Z=ms3UTDC7cmqbhyKrOe0QDSwzhUvxGVjY3g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: remove inet_rtx_syn_ack()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 8:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> inet_rtx_syn_ack() is a simple wrapper around tcp_rtx_synack(),
> if we move req->num_retrans update.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

