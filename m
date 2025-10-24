Return-Path: <netdev+bounces-232559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C34B0C06911
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA3884F209D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF44831619E;
	Fri, 24 Oct 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izdYmeLT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06D30FF33
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313661; cv=none; b=mOn6+JvTinzg2gUgDMzUeKkgAAiqMB4nehHD6rqsWqGtBDRiMH2vDJyW14IHfV4moty2r7XRco8LRsuUh7x1Vd8GMCPODjpL69PCuuV/AbmM5abnoEBciH/AtJEy4kqV5UxYJY0wR1L2ZxHSptJjleJuHThCrw1rq39yqqEe7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313661; c=relaxed/simple;
	bh=B9/IzzC29ADjg838vSrP4QdcRAF1D/yHkv4aULU9fKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0UMXu2MYmh+LBg1pHd4aJ8/GiczDTWTh1LrIpfKRGk2GB93mB2MD6YAW39RiKKQSZedcfMM9tXx/pvI+uXxQ6gJpRmwKIgp196CVF5rDkfjJtPOWfiQVUVA/RGYoulAGsCpEzGjDifoTfLdR0rsBj6kRfKhLvN1N/IjvS2cF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izdYmeLT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33f9aec69b6so2887538a91.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761313659; x=1761918459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx1vbl1Ez/pgI3WrRY2trbT57SZdevUOnhKO+gQlRmo=;
        b=izdYmeLTqkTRJYQ/XphS7Ewnr1Isma2QujP6doPce3vf+EcPXejm5lqALZMOdgVFS0
         ATPdDqNoXqm4Fezuh9Qoctn0OzvZL9NDk7FStJBZIma9TwfJb2YYPdlNaqPixgU5PT0g
         goUeLFe/4u7a0XeGitwSQ+mYjbZ16KymUXvRqdfkw2ahCEc1cjAKSJ/TWkVc7Zy5LS/e
         yOuZ+C7n+G1BF4WljhOg6JmVmIryx3OGIP/+6EtP8qkoC8ie3NY9XKvoMwUmhhWlNRXT
         dWbXvxjiLnD8KkR8J1J/DVghMj2O61x4tpZw/nrm+xFE7jCiYlEtRepgI6FSOzT/QZJq
         PkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761313659; x=1761918459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx1vbl1Ez/pgI3WrRY2trbT57SZdevUOnhKO+gQlRmo=;
        b=wbUv7Nop1OzgAw9zcFZckPzBTGlrh/zNssDM66N+MRJ0fz1fry53Cf3fJMMMgH3PeQ
         cbvntNyRMOACE9oUI8I4GvoAAhmBeahMcxISkrfSAr5yo0l2PWutFjQQ8sQOTnMUt0I0
         GBtnzcV8UCV5uMIhVraK3x9Y13nIV/sft7AoOVN5pXy9a7Dt+1j8kMq0qsHmqLpBesqW
         nYx7F1gpzikUzTaUAI+6GngvyuDvcWsg/RT6AHHXpldAEx+qbD6GqcHygDuZjZJRe4fs
         VUyjbx4fgI2iydcA6t1CkYO7Z+5j10qsGK1muKtQgUGj6Zh914PxCzlI0d6HVgVZKIE+
         XUHg==
X-Forwarded-Encrypted: i=1; AJvYcCUvKDJFfEZelK2o+QHvb7g1QnNg0D7qAUXb6aUvnhJN2nLUxUa5azrdw6x0Lwruc8EQPiqzvJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDKrG7l6Os2J9dNUxPrhFNL1xiry9sujUXBCq+E1drKyqxz72
	EPB4EEAZCtkejvNdXkSA4etrrTwVKrXJl19R8Wn1clS/qkdMZS0KFRs22/iG27LPy7/Qa1s3DOk
	J1fOntntVYwYO5rAPvARpEja0rPKg04jFVF5r
X-Gm-Gg: ASbGncsyW28AlKYOutM/v0JghDDApiYIyzSBd0w9ieicBblSmlkwY8Lmg86cbBeNax+
	wgBWiUNv6soNNHKF2gqS+WJlsnOCX5Iv2d5Y5F20zWTjYhKcn5oRXES6zN8lq1cQsa/Pr2m3/Su
	VlH87zbZ9ioDY2p1To2pumZ89DwnOWylXfbmF8x8c9A3QoHenJ7OzwEVP2txJlHR4pYDIY9VvYn
	SdW3580ablk8ZcsDPhUU/9NAiAPPtHCJZLYf1IWmG3DS/S/bCBCOomd0iQ2ioUq2iPugkwFHg==
X-Google-Smtp-Source: AGHT+IE7UbRuWkUv2m2tt/ayasWaU7KrRQBkfj8k1+EMhwatD5uEDT7aDID0I8p2sRDR22M3d28tUsCjOmpJf+1buho=
X-Received: by 2002:a17:90b:2ec7:b0:33b:6650:57c3 with SMTP id
 98e67ed59e1d1-33bcf8ec60dmr36743501a91.21.1761313659244; Fri, 24 Oct 2025
 06:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-2-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-2-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 09:47:27 -0400
X-Gm-Features: AWmQ_bky6eHmX1WP8yPNfQ2f2z1ZYNpNAmLJSqewTrn8LG41DWILwivDPpZrza0
Message-ID: <CADvbK_d92g+ZxyyB1QECp=ONxzsgJn-FD1HXz1NAzRGYMG-Kxw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/8] sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> SCTP_DBG_OBJCNT_INC() is called only when sctp_init_sock()
> returns 0 after successfully allocating sctp_sk(sk)->ep.
>
> OTOH, SCTP_DBG_OBJCNT_DEC() is called in sctp_close().
>
> The code seems to expect that the socket is always exposed
> to userspace once SCTP_DBG_OBJCNT_INC() is incremented, but
> there is a path where the assumption is not true.
>
> In sctp_accept(), sctp_sock_migrate() could fail after
> sctp_init_sock().
>
> Then, sk_common_release() does not call inet_release() nor
> sctp_close().  Instead, it calls sk->sk_prot->destroy().
>
> Let's move SCTP_DBG_OBJCNT_DEC() from sctp_close() to
> sctp_destroy_sock().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

