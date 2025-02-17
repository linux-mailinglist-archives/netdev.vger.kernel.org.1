Return-Path: <netdev+bounces-167112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1395DA38F22
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 23:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD723AE473
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB1B1A8F7A;
	Mon, 17 Feb 2025 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dTnXJaKi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B11A83E2
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831747; cv=none; b=QR4BUCZHAxuakJdzo/+vHuyj7ojnYZneqGFQ19IIMRts3SIW4yYYzeStDYZbwgBGw2SpNLdUYqFLGayqB2707TVAtKPWB27pZiDUxsSAPtw9PFpcc1RjkW0zsUMi17VwNUNIzf1VTG6IR4Iq7HFs/qmrpjoLd2SC5vFLNlzAs+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831747; c=relaxed/simple;
	bh=UwXls6ySwtXeD3hb7gHOkhfFPWGMyREO4LxhObV+pRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISPl5Yv3E15y09ZvrDIntRRlwO4P0mJn1jbA8HHDk85N1EDiI5Qyxm2w9z6iwWoAhbjxaFVN1XAx2MCmM31fo0yliDSp3Wm7z22t5G72lePi+kQ0GSJuRSJ1QklVeCehvcY61kJtKp65DoMYOngjINmlZIr5XuwCozMwNotSiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dTnXJaKi; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fb6c36ba25so13997167b3.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 14:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1739831743; x=1740436543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqYyGhzk31i7EtcJzCpVKAEo9lj0ASerutNYM4GWtfk=;
        b=dTnXJaKiFVF9ZN96H5U/9fAv+BfyXLOj6G36WPf6p/TQXzEORT5Pp7NGXH0HGOhrSA
         qMF19QpHOj0E7iMG9fPTysfJb3GFJ8dJWE8OQe/ezS1jPzb01i8evQ/qzNXiRhCfSzo+
         pdxet0kEmiXFqyQAsP7tmePxQ6lqWCOXPlQwAgNLDnE2OMGSf544axLSqJZmbTthhaGO
         gdjYMslXqAc0mvSgZtFcwjZgpBqPycRyoaVY+J0LZznHeXFIbRULGm+SLDFoyNLD+nqY
         nChtLeMiS8rS5pngnCd4bcAtO72aWTKnjjPUMwCC6gBzWLrDloASyB4T3YcY6L3fuP4D
         cFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739831743; x=1740436543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqYyGhzk31i7EtcJzCpVKAEo9lj0ASerutNYM4GWtfk=;
        b=tPHI7APegBxIFHOxw24kDwjGnmJ9Lg2C6BrIPCPTpbvXpA+dj1310OTlewRphzQnLC
         GLrdhY/AlyWtssRdwjhBEvxRKo25C0SCwyQhdXupzrYTu/Pluuuj8hHhbzdN+y//BWeM
         OX1jsznuWXqDsNi7Cbi2zWEEGGt14uTz+Mqz3/rjb1n1mg2qcXS/0ymtNzqy6bKliwJL
         MV9mFkx/ooT3V9NCPKbEAtu6Cydf90R1Q1SE92hYA6HeX/kN5vakNIDmIcUnmnsVyvnw
         AEsSaHxcfbZbxzCbChyw/c6+DDkbV/PG5YdentDhtnTxm8CrzHav9N8QY3udZ/BvJ89C
         qoJA==
X-Gm-Message-State: AOJu0Ywbn5Z4UfBH4HKzj9Pkad/Qy1+aexGBNXr2nQSfgxXCqV3Oa/M0
	UjiO9dt44Chpwg0HKIWa39F66UdYvsCUx40ZlyuJmrg0Ik8N/EzMaYDNQNfhAJVHOGCZmR9dBzV
	cA+ewhIRN1bdWoSAZmqBl3EaD8g7Iw8OJzx4g
X-Gm-Gg: ASbGncv7P+nh5bq2TrRm75nvqqhZ1XG6TCym+/q4zgsYN9nIWXQlKGQkG4XwkHKt+Sx
	Ssg34l2XWb/qystPDXDj9vdpE5OMB5WLKWzQHv/wVSDnwXS3KsZRkWQe+CKwhJXqxuKh6fBot
X-Google-Smtp-Source: AGHT+IHpsxN9S4c30Ho3Vi/yxu7FCXu/W7yH8ysF1Clj1ylsTLtWwccZRSvUrpMVGg/0RIndZsDLME/X1NTo3fbZ+yY=
X-Received: by 2002:a05:690c:9a8e:b0:6f9:47ad:f5f1 with SMTP id
 00721157ae682-6fb58c0107cmr88168237b3.17.1739831743071; Mon, 17 Feb 2025
 14:35:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5055ba8f8f72bdcb602faa299faca73c280b7735.1739743613.git.sd@queasysnail.net>
In-Reply-To: <5055ba8f8f72bdcb602faa299faca73c280b7735.1739743613.git.sd@queasysnail.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 17 Feb 2025 17:35:32 -0500
X-Gm-Features: AWEUYZkjwPmHQlt_hlO183_Os4qzr7t4C7oPuhUfOxe1gZ9BOFd1ZjdQSwgsGmM
Message-ID: <CAHC9VhT2YnbCKcAz5ff+CCnBkSwWijC4r7-meLE7wPW6iK2FUQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: drop secpath at the same time as we currently
 drop dst
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	David Ahern <dsahern@kernel.org>, linux-security-module@vger.kernel.org, 
	Xiumei Mu <xmu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 5:23=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
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
> secpath, so it should not be needed anymore.

I don't recall seeing any follow up in the v1 patchset regarding
IP_CMSG_PASSSEC/security_socket_getpeersec_dgram(), can you confirm
that the secpath is preserved for that code path?

https://lore.kernel.org/linux-security-module/CAHC9VhQZ+k1J0UidJ-bgdBGBuVX9=
M18tQ+a+fuqXQM_L-PFvzA@mail.gmail.com

> However, in some of those
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
>
>  include/net/tcp.h       | 14 ++++++++++++++
>  net/ipv4/tcp_fastopen.c |  4 ++--
>  net/ipv4/tcp_input.c    |  8 ++++----
>  net/ipv4/tcp_ipv4.c     |  2 +-
>  4 files changed, 21 insertions(+), 7 deletions(-)

--=20
paul-moore.com

