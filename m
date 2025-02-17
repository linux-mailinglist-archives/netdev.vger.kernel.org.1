Return-Path: <netdev+bounces-166965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3356A38284
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98F17A19C3
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06271219A99;
	Mon, 17 Feb 2025 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTkB8PHK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FAF216607
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793539; cv=none; b=jjC86r2T7o/Q+td5kqFmDHlkOj93L+/Ern9RzwCOoDI1VBceDd5zx7Yg18jDJ/P46NC7OX4NSpvapm89dmNvzj/rIMH0s96MS5j4wGmaNmeyzPC4h4gQPIVM/1sJTFkVadull72D83KizszzPH7fQdHAEyusK8RTakJVVsjEavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793539; c=relaxed/simple;
	bh=LGHA7kSXDJ+acUeALqJkXXIxAC/7LMsVhJSunkrC0ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auMh8kAvVOAKJ9ScFfF4sZPe5jcv22sdqKWFWMoKjOvfBE5ec3G22cGoNyXB5KiCwWmRoyXUzZpWpoBqx+dW/+o5Utu1hwCh9S2vWVbGJ27XHezYh2OSGqAZ41Ah+/AAbXDPQBE4Kx44jKruJDNeUf10aF+KO0XLjZEBsLgT83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sTkB8PHK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so8262082a12.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 03:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739793535; x=1740398335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaIXPrVsnekGZ6+y+FuiHvhs8/YBKFNcBPjcA8hkexg=;
        b=sTkB8PHK2ynWPczClwn1tSPgElj4LYx+3vAXc7WrrHZBCZOOPtYtR77QXEhkyZ3dUR
         nknQ/vnCmC9DNIBNiVbvM5zfYYf56U+q3ug89YuKqluV3j6u8lvH1MjoOHVSvKhUhACZ
         FmMFM2hYkg2R/VJRwclpeCDjl4i+6EJFzMbzEKC7koKsqlSnxlV66W/Gj1deoRjrIy6e
         k2FXo+A/LlM61/MhZOHJbryRM2R6+Bwm1EnhrRSzQgeAjuS2xk6JD/cMxUq5tNEC1W1G
         trsYFTTWDw5IQAcCEJJsUy1gk4zqlYFKlSMqK/hs826L3+f2W+laZhoSPetMWa+sPWrN
         jhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739793535; x=1740398335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaIXPrVsnekGZ6+y+FuiHvhs8/YBKFNcBPjcA8hkexg=;
        b=jqzdbFrOW5ApBhs0L0r0aNESeiS+wqOWBvKA535cagzI6qcOJDBk6xT/w9IBWWNakK
         38FpmSUxncTaW7PNRuNIRrztSBMMJaz/jhRIbIWLQhNGDi+z3nB9QFWw5jNpDHu/rsiF
         42XpvzVc0r1Oe1a8RP11If4Q8cfH6Ca2q1Du9XvyyMyeDjT9NXuc2PGR90zdNDbxToMM
         vQ6cK1se8DBQ71ve2TD7ra1Ux7puqdSPxThWl+DGRZge4GgyPzaKO4rI4RmwnzrJeEOB
         EsVfm5ZsZlJyJutTDVN3FOb+kQWhnDuqcZb8ZlEBWEZ4xTaDdDC4BJdASijPOfdNycV0
         MKmg==
X-Gm-Message-State: AOJu0YwBJMofz9XtLQdKM3e+uIGM71W6dwOPVWoHZ9bJCI6xQi5mztqD
	uuknYbsJB/lFKJO/mvYZY4N8ZZRNdpInFVz4XEecnntXWqcOeUlgsMr6XoiSLHYRbpwUG3tEiLy
	G/ucey/cYg/OvR1UvHiWP9nznp1Wyg+9UtM/G
X-Gm-Gg: ASbGncuQPuL2VIzOuzdBfQ88Io0MMREMCjRqVNJ1VCbKaOWWMsE/JgYcxnKfTfWrdfr
	BD4mQHzqX/1Xwu2euyCHXDBDDCNteOOOUi8Xvzl2rugnBe8pH58gXmysrS/i0BTBkRJHnYuzuwg
	==
X-Google-Smtp-Source: AGHT+IGQTHcBd/2PvLwdIDrdzY1gITJeTXr12QGHG667SSdoKqwNmhWpZV0+hJ2mRbHEz5uu3eBkVx/QqrQsXHUlZDA=
X-Received: by 2002:a17:906:6a03:b0:ab7:9aa2:5043 with SMTP id
 a640c23a62f3a-abb70de2922mr1112341866b.46.1739793535471; Mon, 17 Feb 2025
 03:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5055ba8f8f72bdcb602faa299faca73c280b7735.1739743613.git.sd@queasysnail.net>
In-Reply-To: <5055ba8f8f72bdcb602faa299faca73c280b7735.1739743613.git.sd@queasysnail.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Feb 2025 12:58:44 +0100
X-Gm-Features: AWEUYZmGQcf2SAE7ihBT6VvEcWgoxnUVjpdPLy3YcirIjnOYyCmIfpW7akpRbaw
Message-ID: <CANn89iLZ9SuWnKD1cVu_3cvVYD9jzziq6P=AJy=nUyQUOe4T4g@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: drop secpath at the same time as we currently
 drop dst
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Xiumei Mu <xmu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 11:23=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.ne=
t> wrote:
>
> Xiumei reported hitting the WARN in xfrm6_tunnel_net_exit while
> running tests that boil down to:
>  - create a pair of netns
>  - run a basic TCP test over ipcomp6
>  - delete the pair of netns
>
> The xfrm_state found on spi_byaddr was not deleted at the time we
> delete the netns, because we still have a reference on it. This
> lingering reference comes from a secpath (which holds a ref on the
> xfrm_state), which is still attached to an skb. This skb is not
> leaked, it ends up on sk_receive_queue and then gets defer-free'd by
> skb_attempt_defer_free.
>
> The problem happens when we defer freeing an skb (push it on one CPU's
> defer_list), and don't flush that list before the netns is deleted. In
> that case, we still have a reference on the xfrm_state that we don't
> expect at this point.
>
> We already drop the skb's dst in the TCP receive path when it's no
> longer needed, so let's also drop the secpath. At this point,
> tcp_filter has already called into the LSM hooks that may require the
> secpath, so it should not be needed anymore. However, in some of those
> places, the MPTCP extension has just been attached to the skb, so we
> cannot simply drop all extensions.
>
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lis=
ts")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
> v1: drop all extensions just before calling skb_attempt_defer_free
>     https://lore.kernel.org/netdev/879a4592e4e4bd0c30dbe29ca189e224ec1739=
a5.1739201151.git.sd@queasysnail.net/
> v2: - drop only secpath, as soon as possible - per Eric's feedback
>     - add debug warns if trying to add to sk_receive_queue an skb with
>       a dst or a secpath
>
> @Eric feel free to add some tags (Suggested-by? sign-off?) for the
> code I adapted from
> https://lore.kernel.org/netdev/CANn89i+JdDukwEhZ%3D41FxY-w63eER6JVixkwL+s=
2eSOjo6aWEQ@mail.gmail.com/

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

