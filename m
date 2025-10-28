Return-Path: <netdev+bounces-233624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584AAC166C0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 19:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7188C3B35FF
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84D634C142;
	Tue, 28 Oct 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hos7kiH1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABC6EAE7
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675314; cv=none; b=XjSM4BFyKjKAvckMzYphN7IZ41miwJ/L2z5qQxmFAiSKe0b+8+uHa2nY8CrBVyg+0tV+Xo52lhDXaXghrPeVNNfylIlAU/KrXDEL9f5QqLZVR4+GZ0vT//Bli5rWPMjCpvAVgukLyN/u5J7SEOo6duDBtdeG/ZFRhL7BMCn5SZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675314; c=relaxed/simple;
	bh=IdoA2Hsz3DXflOJ/uWb+OTuJMtFaS4jo6XzpS3PQUeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sf857JnFfyfgXrMoUaV6i8pl3caPgF2V0yJYjrLG53Kco6zlA2NNsXraBtw7ByqQxm0dYXZ+PXrlrzc36th8Gkc6SRXwbsqRXBLiYOcAWeYpu/pmKK9eCB0VzphMP/IlcMwTbazvqGcZ5gzId+E5Z2uTSDaL8N6UdeqsbsYnmuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hos7kiH1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eeafd4882so30495ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761675313; x=1762280113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdoA2Hsz3DXflOJ/uWb+OTuJMtFaS4jo6XzpS3PQUeQ=;
        b=hos7kiH1QkxP5Yn+Mr7DeH8J/uhebmsARHUY36bT4jEhsJsW1ZLZUMQocC2fUFLn7G
         CYQEjpBNMWxnWRJ14kJiv4ReQjDVydfTYiWoAI8zyQR/BfwJ3TxkAHXVEfkHt6kaXLiw
         b6nudCd2hwD5KAG0IddF0HpHsDHN4sMhrzG6I8PfYbJu9ffE4mSIVfq1hDz4LqlC5cYV
         exyNic+sSo8c08Uy9Kg+n9VqB9bibtOw7DrK/97ycbx/0NyI1Nv+XrVVSA0QCDj5y/nB
         dW2fKXGCjiELmy6dzxoNmoY9oQnX6PUcxTCXcB8VOon5uHioFilht5+IlmdemcJQbfLa
         nJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675313; x=1762280113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdoA2Hsz3DXflOJ/uWb+OTuJMtFaS4jo6XzpS3PQUeQ=;
        b=i6HRRVkWYfxMbvXnjlZcGdBqB4fY2ER5MxTzYMLwk56ccB34mAzWoQwLyib8V+4Qd4
         d4vO45msBCGNo8Uew/REqlAaX2WbRpRm8Xt0rdSTOpetDSspInEeRlAyQ8WKDIvEkWkt
         H9kB0ckYLKoDHqMXqa62LkVj7WpMx1yDgR7cz4FQHCe2hvjXNTf22IBLZu/IMHm9uJJF
         oa6SBTDt9Ju83HX6BnZiO44EozqXmXsSziImtY2t/Qe5ASup8gYKfBqCWxnjr7B9GuEm
         wRZjovBpOvkX0o1ogKTw17qQsPShMWXds1HVnzxgYVvod0p5VTSGtFkjqqQ23ZP+biew
         9ucg==
X-Forwarded-Encrypted: i=1; AJvYcCV0fdjvAls6m3glJKFj3e+ciKmt3Mi2TLZ/p5EAmr91sKjPkahA7W7hapTzxSJLTJaLY5LlxrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/828xZ0GzFk8qasC5k7bqwcVpvVHbdWApSQZ/Mq3tkksav+7
	2gtr+MFIUTYAt6B39xwLucuc/j0Bhn4jM3xPhqCellonCIITUOagwdL6cEMbpA5n31Fk+BzA2ow
	OlNpYN/jh4bz87i+mh3FCtegNFra2Bo5DkfJ0xKNl
X-Gm-Gg: ASbGncuCq/XHQhCqvWFHZasj+7KKx1fc230HXQdiORQCJ4MnnypSLlVJ26nDNn7JdeB
	finzv0GFWHHBI7k6Yy6JLrzbESzeMXkbcH9zlzJN6KVlDba4fW1y+C7HNKP+AZaMwZIahrCVCyK
	gDse9ohh+h6NSAtBJZTphGJ4lx3gr/4UVJpezvL2bvFd4p7ijrd+kzokTH3TRa9JFbhDM00NROK
	cT9HrIJa4nefMo196QQqJfNNeoRcnAC1l9YP9AfDR0Sfo337eoT9uqYEA==
X-Google-Smtp-Source: AGHT+IERGgSXUSFxn2JeNfQ2C86EuHjvzEyZOaIycK2W0jkA78IAxEYdTtDG+mA9d+7pqLJIChA0NWObPqGrobS4WTk=
X-Received: by 2002:a17:903:22c3:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-294de36e83fmr559985ad.4.1761675312071; Tue, 28 Oct 2025
 11:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
 <20251025-idpf-fix-arm-kcfi-build-error-v1-2-ec57221153ae@kernel.org>
 <CABCJKuesdSH2xhm_NZOjxHWpt5M866EL_RUBdQNZ54ov7ObH-Q@mail.gmail.com>
 <CACRpkdaeOYEcK9w1oy59WBqjNrK7q5zT2rzg8pHgDdZdKWVKZg@mail.gmail.com> <20251028175243.GB1548965@ax162>
In-Reply-To: <20251028175243.GB1548965@ax162>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 28 Oct 2025 11:14:35 -0700
X-Gm-Features: AWmQ_bnDLfsfNIG5--yjR8bWyBut4gyt9iExhd25ip84kUhmdr4d3xv1vPYI1-Q
Message-ID: <CABCJKudsbd6=8B+fkzbw6TkL-dVvSoT3Co=fW+jWOnuBtxsLKg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: Select ARCH_USES_CFI_GENERIC_LLVM_PASS
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kees Cook <kees@kernel.org>, 
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

On Tue, Oct 28, 2025 at 10:52=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On Mon, Oct 27, 2025 at 11:56:21PM +0100, Linus Walleij wrote:
> > On Mon, Oct 27, 2025 at 4:54=E2=80=AFPM Sami Tolvanen <samitolvanen@goo=
gle.com> wrote:
> > > Instead of working around issues with the generic pass, would it make
> > > more sense to just disable arm32 CFI with older Clang versions
> > > entirely? Linus, any thoughts?
> >
> > We have people using this with the default compilers that come with
> > Debiand and Fedora. I would say as soon as the latest release of
> > the major distributions supports this, we can drop support for older
> > compilers.
>
> Okay, I think that is reasonable enough. This is not a very large
> workaround and I do not expect these type of workarounds to be necessary
> frequently so I think it is worth keeping this working if people are
> actually using it. That means we could mandate the backend version of
> kCFI for ARM with Debian Forky in 2027.

Yeah, it's a bit unfortunate, but I agree that we shouldn't break
existing users until newer Clang is actually available in distros.

Sami

