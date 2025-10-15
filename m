Return-Path: <netdev+bounces-229443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2710BDC3F6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBFD44E8EE9
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 03:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F246F2F2;
	Wed, 15 Oct 2025 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrjBk/St"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96556610B
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497228; cv=none; b=U9p6jk/Je9tWJ/M6gVRvoeaez30o/twSC9u3xuj+BEu4+6c+enZEK7cNkTxf+Vddvh9W/jppgqSeJ3x7TgSG4IrINOjtQWrzKFwQLEk4+XG8aId7GhlPPt9RCjFxGJLSpxeU9SMci2JT7Smmsr6kGlXrMY04VscIRIj/aYQ/LIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497228; c=relaxed/simple;
	bh=9HgpQOaIl0KpCDGGUx9mTKuzi12dKVgUfglVa6ujcd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZu/quK9nuFmbIrG7hgHGjMywa2Eb+SpAECMuBHijNIcmQn7MNYAYiANkqjlC8s3mrykRSouCpGCqaDD+U6XaeuYMYOo8kCN/Kbq5GaEbprxGMvSbg1rzhXdjB/ZrsnoqTMl07YYoyeBzcXFKyAEzANuKKxRuSCBvfVpzOinMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YrjBk/St; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-273a0aeed57so7030455ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 20:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760497226; x=1761102026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HgpQOaIl0KpCDGGUx9mTKuzi12dKVgUfglVa6ujcd0=;
        b=YrjBk/StzVhvQNCieUQojA8qIfutj05/xpde5Sgga/JhqlwD3bCZ2wma0UMv5AZXOJ
         uBwHMRRjPerDAPU2/sJf8mez3M1LFC2Rj1CYyAcJ89uPB7eE4waUSZmW6ilFMV8mz7BF
         s+soC/aQBs3bb2ga8hGTu0r9uJk/WmvSz4VMQCBLaqbdpU82q2MIwcOEtZ7iGd71FBI8
         /D40jpJOFOISYbAxftyN9RiEuz1LgsYnR1MOZlyDriMdQiRAV5alAggK6w0sTLJqqUXH
         Tl//SiJdVsie951ufxms8ysUoHd77mLW0sutwdgA9HtcjJvZU6FddhZAU/IipUhTE8WI
         6yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760497226; x=1761102026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HgpQOaIl0KpCDGGUx9mTKuzi12dKVgUfglVa6ujcd0=;
        b=NzXvjasPA3Bg3e3bkmBNSqMHjSGXg94kpCTtqb6ijuxtiXinfkxjkexOaEX8zxRuMS
         qihdQueyE8I28d8e9SWfj4s13dYzyM7DdUhjbgLv15rIYcHaGF0tKKCDcvHJfG19beLu
         i9wA1D9kQvkxAL5ti+6FRFpAZNJWfTduSSnR6d0WM01HmOrljqBOxz7ZlScGVS7Rb0mg
         6tjFT/2o4K3ZgD7X3wHGaQ+BCOVvTG4HZalc5CVyjevnkSPWK5bk+9zHvVCpQ/WakbK0
         dPXDiKjNuADPdkQn3Vmg9T/ry+r+RyAUjXuefLc/k8f6IZ9HcisJfe+WiwKoJSvKuX56
         Y5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUU44X2EZ87jyVQer0o1xrlWkqsmxC3KwBXXmqr+tYMLjI/WicEwPfy4QWUDaKJHxz62ei/MkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcux3FnI1VAkGtsZArKPAKuyxYaG68XxeFA9Gd3t3Saz3vYi3L
	eXmE6kyVSLBBxEEJBHNYKqGy3Sx3uFbUEb/kG7jpBwprzYzWeZgRUgmDAHYJhVeyqTi9ALbSc97
	x2htx1Atd7c1BdUBuF5915PGnBqNOeSvFrdzCrizw
X-Gm-Gg: ASbGncsbi87NwH0AldzCTuKy1AtBgYh8E6jdiG8ndUoeDBsXm/z4MH1vOsFM/WR7Ewy
	uz4gw0Z559vv79sL4YZQpdkafvBJlv5jhQdBUKREkVHSrELZuUS0Xynn+yFBx2k9LTmK4W9rQd8
	ZMK8az4KAQNxRUIq6hb+IFfxzwQ5bfEViVUH+hTkmA0qtverdIKTVtfZDb+5IfvMcZXxM9G9pmZ
	ThBkGe8Q3jGtNJFi47eAN6WcegaacvmBRw6DVcdRivd3GnqN1vn4irPx5lvyaN+0ur6Dk+QoWo=
X-Google-Smtp-Source: AGHT+IHbyjC3tkd7t+D0Ym1B1Nlt9k4ZBbEztyW5W4g8Chd/upIFcAaikk1ReXgUGa0VRVNdl7JBEXYhnBlvVKOEfw4=
X-Received: by 2002:a17:903:1b6b:b0:26a:6d5a:944e with SMTP id
 d9443c01a7336-29027f271ecmr303284365ad.24.1760497225536; Tue, 14 Oct 2025
 20:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013152234.842065-1-edumazet@google.com> <20251013152234.842065-2-edumazet@google.com>
In-Reply-To: <20251013152234.842065-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 20:00:13 -0700
X-Gm-Features: AS18NWDL522VB6a8_N2uN79XrgodotPp4xuj-wWtwmfLr3jDUl9stz0hUQejUgI
Message-ID: <CAAVpQUCUf7LbREaUzEVK3_j=01Xfo452anr+-DF0K9UW7KbRfA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/4] net: add SK_WMEM_ALLOC_BIAS constant
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:22=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> sk->sk_wmem_alloc is initialized to 1, and sk_wmem_alloc_get()
> takes care of this initial value.
>
> Add SK_WMEM_ALLOC_BIAS define to not spread this magic value.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

