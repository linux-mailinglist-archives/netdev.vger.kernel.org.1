Return-Path: <netdev+bounces-51932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C41887FCBBC
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 01:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49BA6B20E81
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67884641;
	Wed, 29 Nov 2023 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FATAqp4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B65219A7
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 16:48:05 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a011e9bf336so848785666b.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 16:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701218884; x=1701823684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iaa+Dox3hT8QcVOg/pT6Q2EDMDBwckjrJyfcKus7y+g=;
        b=FATAqp4wm7I98eBUsuNxMflqiSfo4Gx+SjYfp97aT3A0D4s8ykHesP22iS2eZRee5+
         Fd7GcVbl5cmyYBdjHrHZ64V7ZYQagRtbyrth2B7zQzF9CS0KmQnRwMvwc6q1Q0FVUVwv
         L8zIyVNuOIxGo/6cZOzvpe8c9rujL6ZQhCbggwZNX2sMyTJZaeMCUJNxasgcoueb7a9L
         gO2L50Lbx1LonvtCX9TpTihOFusKmVyJBzvi1gEZhco7qfwsr8NYiC+AtDJjsDOW9MFl
         DAr/p/3BiJlSAnu/tLbzNEnsqREWaowp88b9Bu1vqV7FPAbr90wD7o8QvcDkZBurFpDe
         2bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701218884; x=1701823684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iaa+Dox3hT8QcVOg/pT6Q2EDMDBwckjrJyfcKus7y+g=;
        b=Zw680svBWGS89UhLpKhpchEkspQoeOIwDTGRTCB8gwwk2EARag7C+IW47kChOm4qMN
         MbZ9VsI/sLZr5a9PGoCOsYOJxQBJgtmFsoaUR9skINxdvfX0lxaV0WDG8uDRDYjZKpzq
         v3KjmJSythUOIbdUvzk5B7fKkuQhIsFsHR9/Iaq3z2RTpOJ2CuFfkmEod7y6SWZNbLGE
         aWThvR/lm1m4Ee978WlUVd3yIXzoaLAIK32jHA3TR4byDRyQFuGbLBtwdxbb60z+7gA/
         ZZ+yjVjdYxYKjnxyAP+xnpKQ0TaXhV4U+yxSy2bw4vfXXd57mabAfgL88xg5BZfbFngD
         vRPA==
X-Gm-Message-State: AOJu0YyRxkzjNl0SaqN5sAZcxxxjeFGj7WLtvOxxBf6KtbzUPTQlyk4p
	jbdBTDuTy3+nGlhjjz16jk6OLJOklR/0xFJhpowL3Q==
X-Google-Smtp-Source: AGHT+IFG8fUBMR0v96CCXIzn8hCmnUS2wpmK2clfM5T5+t1eW7K8bhuSM66eS0Nc0lzUbM4rK2mDWEurezmTYUrxPjE=
X-Received: by 2002:a17:906:41b:b0:9b2:982e:339a with SMTP id
 d27-20020a170906041b00b009b2982e339amr12791640eja.22.1701218883905; Tue, 28
 Nov 2023 16:48:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123014747.66063-1-kuniyu@amazon.com>
In-Reply-To: <20231123014747.66063-1-kuniyu@amazon.com>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Tue, 28 Nov 2023 16:47:52 -0800
Message-ID: <CABWYdi2SEatfsR7ZeL=iOvqyhcae3b3NPp1+=mQySNoa671KvQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/4] af_unix: Random improvements for GC.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 5:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> If more than 16000 inflight AF_UNIX sockets exist on a host, each
> sendmsg() will be forced to wait for unix_gc() even if a process
> is not sending any FD.
>
> This series tries not to impose such a penalty on sane users.
>
>
> Changes:
>   v2:
>     Patch 4: Fix build error when CONFIG_UNIX=3Dn (kernel test robot)
>
>   v1: https://lore.kernel.org/netdev/20231122013629.28554-1-kuniyu@amazon=
.com/
>
>
> Kuniyuki Iwashima (4):
>   af_unix: Do not use atomic ops for unix_sk(sk)->inflight.
>   af_unix: Return struct unix_sock from unix_get_socket().
>   af_unix: Run GC on only one CPU.
>   af_unix: Try to run GC async.
>
>  include/linux/io_uring.h |  4 +-
>  include/net/af_unix.h    |  6 +--
>  include/net/scm.h        |  1 +
>  io_uring/io_uring.c      |  5 ++-
>  net/core/scm.c           |  5 +++
>  net/unix/af_unix.c       | 10 +++--
>  net/unix/garbage.c       | 84 ++++++++++++++++++----------------------
>  net/unix/scm.c           | 34 ++++++++--------
>  8 files changed, 74 insertions(+), 75 deletions(-)
>
> --
> 2.30.2
>

LGTM. Not sure if reviewed-by is warranted from me, but you can at
least take tested-by.

Tested-by: Ivan Babrou <ivan@cloudflare.com>

Thank you for working on it.

