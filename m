Return-Path: <netdev+bounces-53044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC41680127F
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CF52814E2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981814F204;
	Fri,  1 Dec 2023 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BA5D7Scf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C713E
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:19:35 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9c39b7923so32684961fa.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701454774; x=1702059574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRNx8XSp+rNad6wmKaHqg85aiDCSXnZuwfkrOtNdpoU=;
        b=BA5D7Scf9lzSuxlprNbBwCdU81krcAXNl6a4S7VfjX6bEkPE4RcivDTvF4kaBiPjIp
         YpXdupAzMHUGLpBbJfWPlW4jKFpLEYrHvW+MaWjXbXF5jHWcC/Uim+bkrCeY0qnAUnoi
         EQuVDwgD5PreubhiE6cBNT69OJJNv4Uhk55jfms1EyLlNwRZBHglcAG2L8QIiqlSJdy6
         vfTO7dgjvhNT1gp747DE7btfYS3q4VFWxqi33pWqELXET3wOny3tcevOhH0zgeEQ4WXX
         KUPYoH961I2P4N8Va6z6I5eem7xvTx/Z7Ewm7B47EbawWyIUidRJKkaEjYcNsSMIg4yO
         kBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454774; x=1702059574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRNx8XSp+rNad6wmKaHqg85aiDCSXnZuwfkrOtNdpoU=;
        b=Ef6sQovEgIZp1LENknd16xRDyP8hRddANCZ+TfmCsgy8xckhZLlMWVo9JcRZygeUsa
         ZZIYTSeCNkcKvEVw//fwMcfU4DTv3xBf07t+JMP7LHTX2OeDD1e+yfUuCp3OVO7nS71Y
         cApykN7Em+STOa/h+zvTmOkOFy8QeK0AMG5qBeXg2b4a2hPUbqFvZgYe2Efs5vS/q602
         YqiLRkIYpjx4PGYBYw1C4bvP00gv5W+zzco69/figwVPTxJhr8monczGPU9uALXt2kSR
         3AyZqiGEb9Sae5ZqPw4WHAskep4GidoTJgCyHbJH/7I3olXScVUZ08z0fiK9K+uVEN4U
         wsgw==
X-Gm-Message-State: AOJu0YyJxqc2l3vsZXGbGaJ+B9L9/ms1LFJQq/1tU67xgiy/Bk9NuBqS
	tcYFMKilH4/Z34e+t7kB2D8xqEksc2v9SFrAG3RjrA==
X-Google-Smtp-Source: AGHT+IEOPydh3is0A9u1QqwKnUn0BBk8fQSGt66RzZiVp8poYynp8cdiZswRdYGUYlw+N0X8qb2brdkVzhIO9rAMA38=
X-Received: by 2002:a2e:b0f7:0:b0:2c9:d862:c652 with SMTP id
 h23-20020a2eb0f7000000b002c9d862c652mr1076937ljl.63.1701454774162; Fri, 01
 Dec 2023 10:19:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZWobMUp22oTpP3FW@debian.debian> <CANn89iLLnXVBvajLA-FLwBSN4uRNZKJYAvwvKEymGsvOQQJs1A@mail.gmail.com>
In-Reply-To: <CANn89iLLnXVBvajLA-FLwBSN4uRNZKJYAvwvKEymGsvOQQJs1A@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 1 Dec 2023 12:19:23 -0600
Message-ID: <CAO3-Pbq04ZphnB42bSoVDc8sgQ+GbRaqPtXOscsSMC5tXm8UdA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] packet: add a generic drop reason for receive
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Jesper Brouer <jesper@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 11:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> >         bool is_drop_n_account =3D false;
>
> Why keeping is_drop_n_account  then ?

Good catch, thanks! Will send a v3 to fix up.
Meanwhile, I noticed it is compiled with the
-Wno-unused-but-set-variable flag, is there a reason why we disable
this warning?

Yan

