Return-Path: <netdev+bounces-189887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECC7AB4510
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB7719E42BF
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F232989BD;
	Mon, 12 May 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGDHmDQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3BC29713A
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747078698; cv=none; b=IB3CRlnCuMWeJPS1ogkXV3+rAgJb3QyMIwVB3NI2IQHn1Ub0Qy9MS23zKGFmTVDAMjoECLpCmHeQjGzJJr3KbMEZKK8BWN3paIoULlUuyUNC5+TaJ2/nRuD0lIancyKONcY92XPBXQUYQU8tfTxUBkNmknxaoaqRRR4Bt52DS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747078698; c=relaxed/simple;
	bh=ImN1XtjlZbg3uOqwB8tulE8bfFihssF968A24x0Yoxs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CpGxB+RR85U6ZyvK5sL4GJbdc/gCGLr95J68RnA5TOqSgE5EUjY2KraY/UNmSlAIPsjKtJZbAnoY5/jZj23d2tuj3TSluJSKr4s2X0/hrUHDVnMUJB+Hxnr2bkxyq9X/W8TAKIKW9Y/Oltqn744A/FeKO8yW0LDUxdsjti2qgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGDHmDQ7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-477282401b3so53528161cf.1
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747078694; x=1747683494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJhw41fOMZ1oCk/TJKCYchLvTKe53GGxc2oUzKYtyn4=;
        b=DGDHmDQ7YtNExfy7Dcpee6Sv3M6+r519AMikXWf87s6GG3PVEYs1jGmGulv/mu7gmq
         44hgR7bwk47DdrGor1JBu6QXkzbBxRVXcgxA5hJjL5b4j5lRHFMnduTL8BYzQpxhFluV
         gl6KXWqyyNeK6lHArzq0RWwHXWfUg8swV2QpPJi3WYdoOx8tJGyuEpI2tfUklP2xTkY0
         UKeLuw1OrZ6QPL9XCl3cGoly/GwIWfvyEniMywaWGGWfUQ8AQY8LiWM2fyBGhIyv/xCY
         rs5hkqR3CXKLDU3JIwT9h4r0azNCh9omlREeqJkN+LqOPY8WqOXogePGsT8wm8dC35Af
         BwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747078694; x=1747683494;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJhw41fOMZ1oCk/TJKCYchLvTKe53GGxc2oUzKYtyn4=;
        b=qJLDPCYGRzMvGR7qPOgXeGGiCrhAiSEHp8P8PZsTYtoGy0BpXN0UggPI/0fGrN9ZQx
         jjNC8ZPyl4BTt9jZTerA/iQB7vulQjawtkTmU+Ghb36UHOjfxWEA2+NNT0M7PK1C1ilF
         Hdxu4a+Do1OgtyS2U6QMeajI+UDlVSTMK2uIap+7FyT0w366GDZw1wdCRLIRxg3cEcw1
         GdWUqlZjDIMr75JlmRqI7FP0aE1C8Vk4z1vPc9eWx8KFicb3DXSxOe6zDPmY4BcJDKKZ
         BwFQSGuKGCQunm4tQWd4/FMNtFKaNPx3ujNS5lWLKoCOMWI7FgQwnjhttUxUU9Rr5IBh
         fDOA==
X-Forwarded-Encrypted: i=1; AJvYcCXUP0b/aIRndHoTJlJ3dDZFJ4xpfpypGVPSUMpr3aB+njHqOA/wDkuIwC3yDQ6dhyuMtweh5Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb88CIqkfQva1xNjmowCNJ9bTvBeydIlJ9diTJyaUuMkFqT8Ce
	U3l+dvonvr8cuBMwZ701aWY7Q9arT4ULUrkt96fWyyKwuS8UWvAmgQK9eA==
X-Gm-Gg: ASbGncsgU63UM3WoTFiG/lnY5OvPYR3zfXOjWrBywC5By43DvJHGmvZOZJqNwxxn/9B
	qKKKutpGAObxCppTmH4Ww7Zuyp40de6mYveIejjS2Vpesfey4+m2bG4uf35u7+XstNQp4UAhu1v
	odkJ8B1p7krJ3upX+Fkc7HOwzD2ERYVW3RTYw3vIDgiBgoEBeAzd4+vjbu5d3nksP2cSwLTFU3U
	kaYsI9rsz3Ym7uzKTFs39bgsCIgR61EHv7zz8A8Pm6MBqVbVX5Xzo+Qu7n1wQXEbYmsg2GpSD+M
	IJeu5C4eMh8tNsuE/P3M+QGSdex3VJvFzYSxoJq7vdKU0y9gcmsAdeb2UxtoDTAPoxqYOJwio8x
	vCNqU8e+6aBe9oe5e5cfiXl4=
X-Google-Smtp-Source: AGHT+IEc04fSwJ5YPjm0zCZQcbU0ICl/uPmxFJ8D8mDeAIFs3JQoz3E3gp3atBJL4DcerPrGqEE/xQ==
X-Received: by 2002:ac8:7f55:0:b0:476:b7e2:385e with SMTP id d75a77b69052e-4945273b4e9mr210972221cf.17.1747078694554;
        Mon, 12 May 2025 12:38:14 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-49452583754sm54272491cf.64.2025.05.12.12.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 12:38:14 -0700 (PDT)
Date: Mon, 12 May 2025 15:38:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <68224e25b13ac_eb9592943d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250510015652.9931-8-kuniyu@amazon.com>
References: <20250510015652.9931-1-kuniyu@amazon.com>
 <20250510015652.9931-8-kuniyu@amazon.com>
Subject: Re: [PATCH v2 net-next 7/9] af_unix: Inherit sk_flags at connect().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kuniyuki Iwashima wrote:
> For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options
> are inherited from the parent listen()ing socket.
> =

> Currently, this inheritance happens at accept(), because these
> attributes were stored in sk->sk_socket->flags and the struct socket
> is not allocated until accept().
> =

> This leads to unintentional behaviour.
> =

> When a peer sends data to an embryo socket in the accept() queue,
> unix_maybe_add_creds() embeds credentials into the skb, even if
> neither the peer nor the listener has enabled these options.
> =

> If the option is enabled, the embryo socket receives the ancillary
> data after accept().  If not, the data is silently discarded.
> =

> This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but not
> for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file descriptor is
> sent, it=E2=80=99s game over.

Should this be a fix to net then?

It depends on the move of this one bit from socket to sock. So is not
a stand-alone patch. But does not need all of the previous cleanup
patches if needs to be backportable.

> =

> To avoid this, we will need to preserve SOCK_PASSRIGHTS even on embryo
> sockets.
> =

> A recent change made it possible to access the parent's flags in
> sendmsg() via unix_sk(other)->listener->sk->sk_socket->flags, but
> this introduces an unnecessary condition that is irrelevant for
> most sockets, accept()ed sockets and clients.

What is this condition and how is it irrelevant? A constraint on the
kernel having the recent change? I.e., not backportable?
 =

> Therefore, we moved SOCK_PASSXXX into struct sock.
> =

> Let=E2=80=99s inherit sk->sk_scm_recv_flags at connect() to avoid recei=
ving
> SCM_RIGHTS on embryo sockets created from a parent with SO_PASSRIGHTS=3D=
0.
> =

> Now, we can remove !other->sk_socket check in unix_maybe_add_creds()
> to avoid slow SOCK_PASS{CRED,PIDFD} handling for embryo sockets
> created from a parent with SO_PASS{CRED,PIDFD}=3D0.
> =

> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>=

