Return-Path: <netdev+bounces-106231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFDF91562F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 20:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3E61C20B10
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4BB19DF94;
	Mon, 24 Jun 2024 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1jKz14bU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277C182B2
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252308; cv=none; b=L2dktYlopQzJBwgb1RDahVVbcLWupxNcKMzEtE+Ou8RZ7FNeKbe5HzINGSjpuAwx0mimeYOv3dfJmCVVHZH6O0hv8LCxolqoGwMZBv8vWftkwZKrRzmysZIBt2QIqhdFcmmpA0J31iUO10mmsoSWPU/ja0WDcRcGfkrLuQaF0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252308; c=relaxed/simple;
	bh=25Dq88jBB2CkOkDL/JBMijQofHLFLsFy3IjegoNUwPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDMTJGfRpBo1VQUO5V5tlkJ49zCIV2m3JBcQRfEEUqbrtpma7xwpEujFTfRJPduRpQMJJ8M9bHPsos2vS5mMHRTvbADLgnLGbijwwDYQ0jbjVfuZVUMlsyS+1kyoZ1/thvjMWX+WAr5HGveMWTAetaJiEC1j52YTsm6sSqUlFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1jKz14bU; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso1530a12.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719252305; x=1719857105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iU6twMwsLTVUU1XIizoid6hKLyQKsxMvfVST/Ybsw4I=;
        b=1jKz14bUJhRtI/R7TboUJ13JcAA3zEIU0O88a/SDoKF9Q22WQeXAIsSODATi2MKDFu
         2iKvFbsRt2PI2MZj4sMwJ7Cwy7jlMVnm03ruzHC0ngiLtpew4oa/m9pzGOZpbdyymk3j
         Mu0tTLMqQXtR3RdfC6ibkXtQaPDapkZ7nmurLk/91PRLFsoBQRhmcKbNnhXxtA7Huqu8
         1n79wKefGNYHxvAoJRPDypBWu7iXMdsO1M7Ms/ZivcQUmshpO/6ifHvaqdFeD+nzOjqe
         thFuv7AIASgOFJzhdyHoxMJ7HlaV/wWnOoPJWIzdQP7lZsAFKDwmNpZMJ6LIUOq2mvQ8
         Yr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252305; x=1719857105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iU6twMwsLTVUU1XIizoid6hKLyQKsxMvfVST/Ybsw4I=;
        b=hmb3QSj6KtxBShvwZJrmRghiP8WLtZoCjuaQH/jNlctR3NCheK3gUBMJ5F2WC4sHo9
         D84/4F8cVYHa1mUGFTKYIoiCjiTvQYo+BpVeEBB6ygG7Q2MRimy57iFbGyAqda45A8pd
         RH+KbUF2Pyd5TIjUnAt0niE/P2WeXMqxjDLZGNmDB1CeW4a8TVTXHh9JeVzanfuiI+Fv
         7VszoTW7uFr49X9vx/73Xwjw8x8oeIWS6ABM5eMQfv8KbOmeG02XvzeqkZjJHYT+9urI
         Q5mwqT2MZvo1Tc+JvicTRDPuJZ9p5ye57+GF/gEkqApDSIPIExFnxsx3h8E9eRUU3/jw
         5PyA==
X-Forwarded-Encrypted: i=1; AJvYcCWcrqzW4yiQqJKFyou3AyNuq7sTbu5mupTMcachZz6wsBrPr38qd+oL0ePE16ByUB+6z0sL+agfZyFV8D5dTxxeudT5MaaB
X-Gm-Message-State: AOJu0YzIt6d4zzHlSuvK4oNRD0WEcn93PpwiI2Ll+jPZSndxx4vnUIgy
	DTYI4cEtaqDli7EwngHMoFJs/vc9tKipkl9qay7ky7UpbqbNrcaGGf6p30Y9Gl4DuzZpmQFNMfS
	MipuqMbdAB6dAnxbY+Owqi57kGYXkawfnbNo=
X-Google-Smtp-Source: AGHT+IH5Y7rUe3HGR92ggNIqhjJ6oN6APNDpcnfWRdAWF9v82nPgkswGoUuk1iuaf6Hb2+YP+rxpC7Z0nldf36iS1/E=
X-Received: by 2002:a05:6402:348d:b0:57d:6e52:fff6 with SMTP id
 4fb4d7f45d1cf-57de4b68f0bmr4244a12.5.1719252304903; Mon, 24 Jun 2024 11:05:04
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620181736.1270455-1-yabinc@google.com> <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
 <ZnVe5JBIBGoOrk5w@gondor.apana.org.au> <CAHk-=wgubtUrE=YcvHvRkUX7ii8QHPNCJ_0Gc+3tQOw+rL1DSg@mail.gmail.com>
 <CAHk-=wiBbJLWOJxoz7srMPtKcN7+9cEh79fzf8GKXTJyRdk=tw@mail.gmail.com>
In-Reply-To: <CAHk-=wiBbJLWOJxoz7srMPtKcN7+9cEh79fzf8GKXTJyRdk=tw@mail.gmail.com>
From: Yabin Cui <yabinc@google.com>
Date: Mon, 24 Jun 2024 11:04:51 -0700
Message-ID: <CALJ9ZPMHCPt-6kf-9McdKYTqs8Vrj9GLhkxObdhjyorgtZQOSg@mail.gmail.com>
Subject: Re: [PATCH] Fix initializing a static union variable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Nick Desaulniers <ndesaulniers@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> In other words, in the kernel we simply depend on initializers working
> reliably and fully. Partly because we've literally been told by
> compiler people that that is what we should do.
>
> So no, this is not about empty initializers. And this is not about
> some C standard verbiage.
>
> This is literally about "the linux kernel expects initializers to
> FULLY initialize variables". Padding, other union members, you name
> it.
>
> If clang doesn't do that, then clang is buggy as far as the kernel is
> concerned, and no amount of standards reading is relevant.
>
> And in particular, no amount of "but empty initializer" is relevant.
>

Thanks for the detailed explanation!
Sorry for limiting the problem to the empty initializer. I didn't
realize the linux
kernel also depends on zero initializing extra bytes when explicitly
initializing
one field of a union type.

> And when the union is embedded in a struct, the struct initialization
> seems to be ok from a quick test, but I might have screwed that test
> up.

I also think so. But probably we need to add tests in clang to make sure
it continues to work.

> Hmm. Strange. godbolt says that it happens with clang 17.0.1 (and
> earlier) with a plain -O2.
>
> It just doesn't happen for me. Either this got fixed already and my
> 17.0.6 has the fix, or there's some subtle flag that my test-case uses
> (some config file - I just use "-O2" for local testing like the
> godbolt page did).
>
> But clearly godbolt does  think this happens with released clang versions too.
>

Yes, I also think it happens in both clang trunk and past releases, as tested in
https://godbolt.org/z/vnGqKK43z.
Gladly in the clang bug in
https://github.com/llvm/llvm-project/issues/78034, no one
is against zero initializing the whole union type.
I feel now it's no longer important to have this patch in the kernel.
But we need to
fix this problem in clang and backport the fix to releases we care about.

Thanks,
Yabin

