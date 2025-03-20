Return-Path: <netdev+bounces-176388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F7A6A01C
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E02D462CCA
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7386F1E98FB;
	Thu, 20 Mar 2025 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yTNJK4Vt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650D1CB332
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454450; cv=none; b=EkYokGK0YxGZcOowAvsMIiWJzTkJhTU2AN+OaKvFV7XOouMx4TS45Mv0n6/bNcVroCnhYFNP8/W93ag1OTF8uWT2Bh1XUA/XSFpOsKGCIlSTJfadZ+1bU13G06VMYfD+nkZWJxv3gIR0CcG8U6mgtoeyT7rIM9SNK1ysl6D3200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454450; c=relaxed/simple;
	bh=sRbfbH+/QRkEb2HXFU9OgtvKhMejEraiR5RsY/XL3gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYG96PEIKIr8tWpbo0GVMb8fdXSve6XaayWeQgPrGCl9D06VvTH9UDeAGVjcKbirLTVD5PzXOD3XfclXh1UhwyBcha5kVx4za3k7rPdnyoJSQse86VRyWp69z/N7emQX65SohC7flmVuel1YnIV8+4r6NaZZIaw5jSdJRcfIkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yTNJK4Vt; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476ac73c76fso4876541cf.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742454448; x=1743059248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRbfbH+/QRkEb2HXFU9OgtvKhMejEraiR5RsY/XL3gI=;
        b=yTNJK4VtVL3UrKmGvmuezbGTO4ftE0wXlHi75G/QNwFQIIV4CEwjQegRqFRRLGF+ay
         eco4vI3cXAT7hrT1QFfOp1DipB0anJuBKLLMOMD8YAuUJeHER3icnuJ8SjxKriCgCzh9
         D060LnwMZGJvBRpp2kXHJDjsZK2VdkiDtAdbxHZdVQRYI4SJeOJ1zgd3QbU3shSGcY79
         aYlkmB1TLNRF6k1V5mjXdQqQeHrXBZNmMWXOvcndPUqjo9UXphyrzDZ9iDDfVqByb5R8
         hzavFU/G4ZQ9YreS0cGa2Jt9Kx1nUe5pV2uoap4unVxTdAmYWGD+DXMwZrwO0UYDnLNV
         zZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742454448; x=1743059248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRbfbH+/QRkEb2HXFU9OgtvKhMejEraiR5RsY/XL3gI=;
        b=At5nMlhj2ZtrrUTyPsygVBnaY7TwINP5Q7+ljE76wgF5Y5BuSE5jUyka9Iiz4X7SuS
         cVddGddJGji2TRW4e18srFUEKBfnbCe2L6lRPC2j8gOVtD54X2/YxYR0VYy9VTTafbdO
         c4Q3EA+JgK3wd5qCtpWVtuXDn/TUzGkS9Z5P9UEvicwt8IBd0B2BksqbwlY//hsdoEEC
         VTfpS0yFrp2D4sLgw8OTi/M+dZTl5jl5lnNXp7KxJy2DKcxY8aCTDnjO3Ph+es4+2AGS
         fPzqP7lKto3kjDMm4DGY7VT19AZhIiVEjmoNJCncFn7FdNAnEGok27TYix8tJ1+mN+lW
         Rz3g==
X-Forwarded-Encrypted: i=1; AJvYcCUhv+ASQ2FR7IAINGdZBkVZl7dolMVLYtcFEqGsJ3IaCqgAW3u42rVgiEEQCI4IrZF4mX9UM4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YymBQKfQikBWPgPoNC+VouZf2ESaxY4TKBxd8XtjifuOjyvee48
	yFUzvvuEkVNYWrh+4+JmQuFASoMRk4yeEVLhh7c6NVwdj0XlTSY1jjJratLlmF+jwLfzAbcrKTf
	/Tn9AskhJVJVg6/rC4szLGcoR/BeGenX+m6lYwaoBWXeDeENtM2nFhsA=
X-Gm-Gg: ASbGncsjQV54syDjhATUm/Qk6LZbm1DE+fUFP9swTvhewFLWcLfux47Sm9ZPS2/WvwU
	vO7DQd5p8HNJcYY6p175UByN248/9B6s0pWb/VQqKwTA8yAuThoyHgq/2YCxucwot1/DakMjvZU
	7hv6S65HzBRpNTQsW1NkhxyozL
X-Google-Smtp-Source: AGHT+IEhqy1Ld7YYNZtoIntAXPIc/BCFPFT8id43WysdJogTwwRHF9ww58ik4z2C3IvdOentVv/bysBxYrPa9AQMHPo=
X-Received: by 2002:a05:622a:1b05:b0:476:b858:1f2d with SMTP id
 d75a77b69052e-47710dc3d61mr29427281cf.42.1742454447501; Thu, 20 Mar 2025
 00:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230743.65267-1-kuniyu@amazon.com> <20250319230743.65267-5-kuniyu@amazon.com>
In-Reply-To: <20250319230743.65267-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Mar 2025 08:07:16 +0100
X-Gm-Features: AQ5f1JrXjLxqjiQEZFn70LTy29-8CGB8b6gm9rn9b2X2sCTK7t91z3cITGMylkk
Message-ID: <CANn89i+=CHm30ZHy8nRHwFAyD+Mu=pz6FPewCgMW_MWDubtdYQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/7] nexthop: Check NLM_F_REPLACE and NHA_ID
 in rtm_new_nexthop().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:09=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> nexthop_add() checks if NLM_F_REPLACE is specified without
> non-zero NHA_ID, which does not require RTNL.
>
> Let's move the check to rtm_new_nexthop().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

