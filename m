Return-Path: <netdev+bounces-105948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D1913CF6
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 19:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96F01F21CB6
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B0A18307F;
	Sun, 23 Jun 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W5oLUbDV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B6146D43
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719162368; cv=none; b=hZSAbGmzeF1Es3e+ySHD+y7dsa5N7+f8NRK1P32zjrsP7tBVwc3ZvlIPsiILPGNxrYMCTs/h3FL3fkzRRODC/DcpOKRXc6h1TIR8UqWfbFa3dLPAOZXIiYRHg6te9aOXFbJ4GIbosTrXqCVaZBvYMsXIhcXfuAgdFuwVRuyKswc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719162368; c=relaxed/simple;
	bh=45LdDu3bOcCKbhXgg4h83UgXbR3JletssymwhGumCDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPfSJKwvjS7eHLKs+dus/dnHyb9O3nwy/ztrdQ496DDakjLW66oDWFbY0ZgIT1Be4M3pyaAN0RHRw7xP0iBtpAAkDkl1N1yys7vZH7KxNy6PFVQuu3/NIsEThen8guKBhiNTUM6KAr4xGOujOn4Ohrkb9Me+8KMjNoU6aTugDYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W5oLUbDV; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso38438861fa.3
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719162364; x=1719767164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J2lcMIrHytzsqZNd1SmlAzfYjjTDrAQdmPKhyqoEJj8=;
        b=W5oLUbDVh3wovUuBF+X2/FZY26o26llkDpqq2xKh3AwPT0r3sZxX/wtx5kOaU6oYPA
         RsXmb/t52aB+L7n+bH9edUWqQoiAkyDuByYlRUyP2R66f0s7fbQXmRohkQNepqJdOy5G
         cwMvciR6Yvrt6JkN4DYOuwczwSvGW/wOtfuqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719162364; x=1719767164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2lcMIrHytzsqZNd1SmlAzfYjjTDrAQdmPKhyqoEJj8=;
        b=fb9ewYJZmEiMIGGemAYUaYaH68DxMglRl1wo9BVQ+h+FAozU1KqaRy2fPxqWJEMgSP
         MTx4BGMeFFQt9sjPEeKHBOtxVgvxk/GI4nw1i2OTxD5y4fRLXmsELmk8MPeYEMCsqiqb
         9bH7ATPhUaakW7gunm11a9eKrPtvxzzv8RiMmGH0nS6CNON8b2k2ut4tBm9gQHWTUH3N
         Bh6ZcUIZRxX/LcUM121w607DGvpTEzpBlAgiMXCTYOP8lD4jrfAEr0fV8gPOvGoc+hDa
         CSNhBgvml8JL+QHcHAvos+TiY7BAaz2ziRRGFjYwwh1TumRjwNq809wUt22yUDzB5DKS
         a8fA==
X-Forwarded-Encrypted: i=1; AJvYcCXlH0i9C/HfjnyJb3FaHlAYiad2AG+c5GW28Jnyi2shADFBiFb+3PHEyGzL4MP1/rZu6W8MsXs8dB3CbXpY2AdHoeJIb1Xt
X-Gm-Message-State: AOJu0Yx5x6J7T7ZMdEUUbnllonRXdpS4rwLyidoV6ijlWVJNiwMru6ka
	3Svb9yUQvn7HXj+KaSdLucNA6FmDI6pboJ0s1N/SXj/MRnTSq4Hn4V53SB/6racnTLIY/cLj76w
	ZqXwvHg==
X-Google-Smtp-Source: AGHT+IF0IEw+igdTakt2v1rue18LWa4DxD6X/2mObPz87QLQSraqyOvsR8g8LwgMgxLF/K1zgh4uSw==
X-Received: by 2002:a2e:b054:0:b0:2ec:5277:e5ab with SMTP id 38308e7fff4ca-2ec59587e06mr18131721fa.52.1719162364453;
        Sun, 23 Jun 2024 10:06:04 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d7090f2sm7537391fa.56.2024.06.23.10.06.03
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 10:06:03 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso38099271fa.1
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 10:06:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1WAR53hssuPOjM0gQrF6W+vYSyD72bXATc/o8fr8UpxQbaCKjWD1bzwZHO54jrrAX7haZXKSVZ3UXCgaGkxCNJMt7CjBP
X-Received: by 2002:a2e:3101:0:b0:2ec:1cf1:b74c with SMTP id
 38308e7fff4ca-2ec594cfe8fmr16692871fa.32.1719162363025; Sun, 23 Jun 2024
 10:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620181736.1270455-1-yabinc@google.com> <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
 <ZnVe5JBIBGoOrk5w@gondor.apana.org.au> <CAHk-=wgubtUrE=YcvHvRkUX7ii8QHPNCJ_0Gc+3tQOw+rL1DSg@mail.gmail.com>
In-Reply-To: <CAHk-=wgubtUrE=YcvHvRkUX7ii8QHPNCJ_0Gc+3tQOw+rL1DSg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Jun 2024 13:05:46 -0400
X-Gmail-Original-Message-ID: <CAHk-=wiBbJLWOJxoz7srMPtKcN7+9cEh79fzf8GKXTJyRdk=tw@mail.gmail.com>
Message-ID: <CAHk-=wiBbJLWOJxoz7srMPtKcN7+9cEh79fzf8GKXTJyRdk=tw@mail.gmail.com>
Subject: Re: [PATCH] Fix initializing a static union variable
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Yabin Cui <yabinc@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Jun 2024 at 12:51, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I *hope* this is some unreleased clang version that has this bug.
> Because at least the clang version I have access to (clang 17.0.6)
> does not seem to exhibit this issue.

Hmm. Strange. godbolt says that it happens with clang 17.0.1 (and
earlier) with a plain -O2.

It just doesn't happen for me. Either this got fixed already and my
17.0.6 has the fix, or there's some subtle flag that my test-case uses
(some config file - I just use "-O2" for local testing like the
godbolt page did).

But clearly godbolt does  think this happens with released clang versions too.

            Linus

