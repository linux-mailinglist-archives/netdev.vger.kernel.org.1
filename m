Return-Path: <netdev+bounces-233323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2B7C11EA5
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 23:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54F51891792
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 22:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82C8261B99;
	Mon, 27 Oct 2025 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icG9QIxt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326BA2F1FD5
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605797; cv=none; b=bwRoDuGa5r3cKf9ppWi5uprqowTQdkZmnTV9IPw8CvaKf7F856N+3yUhB9rujf/I7jQnjUFtH9RryDu5UPauXAfMHFdW9zVscWpOJY1VrnqPdXGdfdv+ycxj7nAAkxPu6s8phExuDs921nx1QzSrcWx/7FZ9ICBdFpPfHgQzZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605797; c=relaxed/simple;
	bh=bON2espIER1dUwOh/hjOsA45ts5elF1x8z3D4LRtulM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3944qJZxCWeSfrPEi8Jz/hOk8ygTIph7T0GZ2QgNBBeiihwPfRj8gkCiq7AaUJKCcyU7W8YzxrwhJM4RR7zahwp7M4wk/XzhOmb+PR16xklqMzyicsHTY8JoLHrrMjbp2lG2teuSxKVaw7lMf0MsZxpcDCfBB23vKtrVmo60KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=icG9QIxt; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63e35e48a27so5266803d50.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761605795; x=1762210595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fXrczP/tH9sGyN44YbyszhSBDmNu6JorF9M9mPbTjU=;
        b=icG9QIxte4ZOWTRdm/aa3EeKyifxU7H+QfdDJPu9SYnH7yn971FG/Hgxolkx6QI1rB
         HCJDG/AkvvGt8eJgiQSO6hoF/IS6I837z+UMl1i8uLcqJ4RzaUUYAsM3b1S5pmoTiT8f
         tyeS2Xhi+EK7911Wub9AmRe4xkui624GQ/zKvQae+B7m96P4dMtXWEEe/4Ookg0OKvnE
         +cf9BclBJ0sF0tHk0haQKxmsN7Ci8v8H1Cl1eyzHlwaaH00rY5ZXxE7S4Uuqt9D/MEN7
         6pA6Af8XWc7Aitmh332a1/FcZyNsPQteuk+Tg51QrB/c6G8PJw7n2SyT8U0TMSIFHF0P
         +85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761605795; x=1762210595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fXrczP/tH9sGyN44YbyszhSBDmNu6JorF9M9mPbTjU=;
        b=tJ7OnszdJrK45ZtYo4hFMkWy5pIJhIDXL0YyOHa2XKxV9wBMwUqBO/uHN2wJakO/MB
         dI6LR24gY9N4Xz7B0ZuBww5IrXxv0v4sVJBPM6fiwuPj+vh7vC2f/Pn2RcLyf0lZEeFd
         MjEzekJVIzSs+MAEqU16vYFUYYMGYbt6mImA0tEG2Z8C9p6a172wz8oRV5u0BcLpdhlm
         aKQ645b5t770MurjgD2CtYGMUHjHxeqUknGZ3eWCBLEtAOmQ5rLRg6IBaLb9MRYjT1nE
         CLc1jmHhCwTg3cBQCgxfVdVIaW1+QNMnNazfdD4VLaAKGLIfD0IYk54zq/bBd4JXmk1F
         kt0w==
X-Forwarded-Encrypted: i=1; AJvYcCUaBxdmQfErLVm7TY9HapfRYiTm7uKrILHtx6VhpdGUTccRnNTX/xUVAhhfqclY4m3QPWPD+y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8PTkl7kOFUSZW1mdqGGglhn8aZxuCkFb6WyZx6T/gZNCWw5Ib
	AZMxL8MNmYO0DZnQ9Ff23SXBBw5pD6UnSmTPX1DKyBnMO2Faokj16TuZes+ebvtggx6uuu3UPIH
	DVDEWtLeIFvoBVsKBF6Dell/5KBOZY607TrdBEGpqyw==
X-Gm-Gg: ASbGncuCkCxcp8jUMaHD65xL69KEQPUipSrkXaGvhhsLe0VNDFjM22X9zgicigVq0v5
	q3g3gDIIljSaP7HqvjnWF7NOsPt4q1CLwTdRoSRHNQ//wzUDbwIGSSfpPwQKvoNhbtmlZtj6PJa
	66uZiHPvXm7XBv2iA/wjADxM+GxwJ+zeJ3dmNNPtEdKtAbrl1o6mCUdA3G2m/VN4vzh1YK1kZaG
	rxiNVC2vECON/D1Xubh5VjBjPdPgL+iL1RCyBnPB2useP3058XlX72tFGpY
X-Google-Smtp-Source: AGHT+IFJxZPsBn36jb9IqqtiTCDa4X0Ih3+3+W1DlxJFcn7w7OJaZooe7uHyHPMcjKs42kSUEEM7iqG3b3fxHPvN1mY=
X-Received: by 2002:a05:690e:4184:b0:63f:2b69:9a2a with SMTP id
 956f58d0204a3-63f6b8559e7mr1530051d50.0.1761605793644; Mon, 27 Oct 2025
 15:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
 <20251025-idpf-fix-arm-kcfi-build-error-v1-2-ec57221153ae@kernel.org> <CABCJKuesdSH2xhm_NZOjxHWpt5M866EL_RUBdQNZ54ov7ObH-Q@mail.gmail.com>
In-Reply-To: <CABCJKuesdSH2xhm_NZOjxHWpt5M866EL_RUBdQNZ54ov7ObH-Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:56:21 +0100
X-Gm-Features: AWmQ_bno-qx6koLOtrZwcQNDXGnT81r2Gd96qzGlQrBISAXpENMYtJk71SRHkpM
Message-ID: <CACRpkdaeOYEcK9w1oy59WBqjNrK7q5zT2rzg8pHgDdZdKWVKZg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: Select ARCH_USES_CFI_GENERIC_LLVM_PASS
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Russell King <linux@armlinux.org.uk>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Michal Kubiak <michal.kubiak@intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:54=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
> On Sat, Oct 25, 2025 at 1:53=E2=80=AFPM Nathan Chancellor <nathan@kernel.=
org> wrote:
> >
> > Prior to clang 22.0.0 [1], ARM did not have an architecture specific
> > kCFI bundle lowering in the backend, which may cause issues. Select
> > CONFIG_ARCH_USES_CFI_GENERIC_LLVM_PASS to enable use of __nocfi_generic=
.
> >
> > Link: https://github.com/llvm/llvm-project/commit/d130f402642fba3d065aa=
cb506cb061c899558de [1]
> > Link: https://github.com/ClangBuiltLinux/linux/issues/2124
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>

I didn't know Kees stepped in and fixed this, christmas comes
early this year! I had it on my TODO to do this or get someone to
do this, but now it turns out I don't have to.

> > +       # https://github.com/llvm/llvm-project/commit/d130f402642fba3d0=
65aacb506cb061c899558de
> > +       select ARCH_USES_CFI_GENERIC_LLVM_PASS if CLANG_VERSION < 22000=
0
>
> Instead of working around issues with the generic pass, would it make
> more sense to just disable arm32 CFI with older Clang versions
> entirely? Linus, any thoughts?

We have people using this with the default compilers that come with
Debiand and Fedora. I would say as soon as the latest release of
the major distributions supports this, we can drop support for older
compilers.

Yours,
Linus Walleij

