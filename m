Return-Path: <netdev+bounces-233618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD61DC1650C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D8E1A2638E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64BA34B1A1;
	Tue, 28 Oct 2025 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcqim24v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B120330B30;
	Tue, 28 Oct 2025 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673970; cv=none; b=ANZyKPbo2JBtarUbnzf1ihzwEKbznHlMHcj8sp+sctqQmfATtgkAVU4tITkylwMc/5/rCnbhI8mCthPCDXiV13wzVwvS4Q9szrQQOLr+yZnifR2ISV9hermbPyVOZbLZAhCRhvpj6+gAKjv1yc6KhNYekhiNMX+hTu9gRoiOKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673970; c=relaxed/simple;
	bh=Moq064DwQdSS6qTOYeb42y6SY5Kr7+VDV6iVv9m8xBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+tkhPbNb/iOAonXoj+tJJyonWWKKSwqtFT5VNwTM9FXzyAkaxOBIepvPQB0tTZkWcdRuaTcGWNHmnjmCcabK1mDuiikuKg6Uxk0Lu42cDlBV65XkgK2qczX85t08iPbFsGHZa/h/HmRwcyukiYud5ZR9TGiyUBFPOSTXrGN66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcqim24v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F24AC4CEE7;
	Tue, 28 Oct 2025 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761673970;
	bh=Moq064DwQdSS6qTOYeb42y6SY5Kr7+VDV6iVv9m8xBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcqim24vkU/lNUAwQO+ySvG//0jPahaWXHXgAox1AfcfBdPxJPT3NTHoljAfIQYGt
	 MaBdO4/AgJqqdZ1woP/x1NfOVWC8yunhevd9di6JM/iv1H0gJ6eqPQxFXzoUHGJ04D
	 scy+VnPKywP5ILoZhGpWVOIRAO5XcBMvpBvKhPZDzpq2NhBpAuqqbUUowFnp8a96KC
	 4rlVUHFdp71lSRoL2i/I5XpYnhYsLp/3LnWR1D0bbTjC0rcdQNHh9Sjo+1WtXiSX0P
	 yVN+0IeIxy/79PMPodDKBtZBZNCwUeLSgW2NbN9RZOlwk167bZu+8Er41Ugle2BBsI
	 Z3n/fBO32uYAA==
Date: Tue, 28 Oct 2025 10:52:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
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
Message-ID: <20251028175243.GB1548965@ax162>
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
> > Instead of working around issues with the generic pass, would it make
> > more sense to just disable arm32 CFI with older Clang versions
> > entirely? Linus, any thoughts?
> 
> We have people using this with the default compilers that come with
> Debiand and Fedora. I would say as soon as the latest release of
> the major distributions supports this, we can drop support for older
> compilers.

Okay, I think that is reasonable enough. This is not a very large
workaround and I do not expect these type of workarounds to be necessary
frequently so I think it is worth keeping this working if people are
actually using it. That means we could mandate the backend version of
kCFI for ARM with Debian Forky in 2027.

Cheers,
Nathan

