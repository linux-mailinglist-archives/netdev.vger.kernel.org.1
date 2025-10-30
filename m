Return-Path: <netdev+bounces-234258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86D0C1E2EC
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A959189F29C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ABC2D0636;
	Thu, 30 Oct 2025 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZaDyQxg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947581E86E;
	Thu, 30 Oct 2025 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793448; cv=none; b=SbqBUUW1NPg8DcUSPSXpdkRaW/mjI0epX9ZOMqGaYNSCkz9ggyWppRdmEFWMUjI/gQN81rZ7+ThQLxd+/Fj/ncpyThtyNkhAFLJsnLBcXJLzvjx1WW7J8UjH78aqorGS0pgsJjWD6p3X4aYjcK7yjwof2K3gd0L7bAxEB8XqXc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793448; c=relaxed/simple;
	bh=AxveStPh2elBDvaO3K+y6I5FgqDnSBSlQMj0Px3/aIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRL/xa7ZLAe1C0jOqgCClgKjZvuAWaNzyNUUh30/ndO7PaSoG8ugWW/fCiacNj2aSIOS+E8nR7/a05zgtFKUDazlRJy5OQdcKVfXtssyswXWc7ueWFQCkfnY5yHWEy8/t0tKaN/jIzbaFK+7o0Sim3DkKHkDt6EpS4zjfp8Ng0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZaDyQxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68BDC4CEF7;
	Thu, 30 Oct 2025 03:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761793446;
	bh=AxveStPh2elBDvaO3K+y6I5FgqDnSBSlQMj0Px3/aIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZaDyQxgEBdxypDayV4zGIOC0hSpv/dimzVnZC6eD32j8HcYuLqXdqpfemFhJ/qjE
	 fSS1UN28q2IgsCqqxMq6EZaVJTO2Xom8IuurL5aVSJ0D+E4E+9p2M8S4oyHxH0tVbc
	 sCU/iAKPoST3uSPQc9greA1oCzdhXml2aOWtEpuNmUko0B61sesPBShgY8+NWmSOn/
	 cTjD20hRAUKrV8tlMd6uLlS5oeMvsLW2W06i4CZDEamhbPZ1ZoEJo0lUJbriX9rnhF
	 yCOTw0XExmFAp14LIcsxAiAElyXWgreXbAg7nwlZIhQd5qxGigk62k+ULsEsw3a2qu
	 BvjswhKmGmznw==
Date: Wed, 29 Oct 2025 20:04:05 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Russell King <linux@armlinux.org.uk>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH 2/3] ARM: Select ARCH_USES_CFI_GENERIC_LLVM_PASS
Message-ID: <202510292002.10FDB135C3@keescook>
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
 <20251025-idpf-fix-arm-kcfi-build-error-v1-2-ec57221153ae@kernel.org>
 <CABCJKuesdSH2xhm_NZOjxHWpt5M866EL_RUBdQNZ54ov7ObH-Q@mail.gmail.com>
 <CACRpkdaeOYEcK9w1oy59WBqjNrK7q5zT2rzg8pHgDdZdKWVKZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaeOYEcK9w1oy59WBqjNrK7q5zT2rzg8pHgDdZdKWVKZg@mail.gmail.com>

On Mon, Oct 27, 2025 at 11:56:21PM +0100, Linus Walleij wrote:
> On Mon, Oct 27, 2025 at 4:54 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > On Sat, Oct 25, 2025 at 1:53 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Prior to clang 22.0.0 [1], ARM did not have an architecture specific
> > > kCFI bundle lowering in the backend, which may cause issues. Select
> > > CONFIG_ARCH_USES_CFI_GENERIC_LLVM_PASS to enable use of __nocfi_generic.
> > >
> > > Link: https://github.com/llvm/llvm-project/commit/d130f402642fba3d065aacb506cb061c899558de [1]
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/2124
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> I didn't know Kees stepped in and fixed this, christmas comes
> early this year! I had it on my TODO to do this or get someone to
> do this, but now it turns out I don't have to.
> 
> > > +       # https://github.com/llvm/llvm-project/commit/d130f402642fba3d065aacb506cb061c899558de
> > > +       select ARCH_USES_CFI_GENERIC_LLVM_PASS if CLANG_VERSION < 220000
> >
> > Instead of working around issues with the generic pass, would it make
> > more sense to just disable arm32 CFI with older Clang versions
> > entirely? Linus, any thoughts?
> 
> We have people using this with the default compilers that come with
> Debiand and Fedora. I would say as soon as the latest release of
> the major distributions supports this, we can drop support for older
> compilers.

Okay, it seems like the consensus is to take this series so we don't
break existing users, even if they are rare.

Unless someone screams, I'll take this via the hardening tree...

-- 
Kees Cook

