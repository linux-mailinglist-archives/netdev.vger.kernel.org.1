Return-Path: <netdev+bounces-233307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD66C1173F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 21:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B0764EB1B2
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C2832143F;
	Mon, 27 Oct 2025 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1yBFjqe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873C31E0E1;
	Mon, 27 Oct 2025 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761598753; cv=none; b=pek+iikVKneZ9598uwazCjqux2crAPxUCmXiwS5TYC+IjjBzJsXcWUFjtgUQP7/qwUGODM2dhb43AarPHjGClgQ906HxPs0moZ0Gox5GvylPNTfn+auyR3SejUx+ueFoHftJaI6nsXyQDylNF0bZnPY5xxVlrgZMAxFdbul47GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761598753; c=relaxed/simple;
	bh=yprLLzu/23+hltQ8hDoRSGSE9VYBXZzoi6lRcgP6GUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgksaA3gZSPPTYUOLSwNTiwneSvAucNRxO14yQx+H+Ivk5tIJ5XWBSRETQUJyevxoln0rY0teRhihgbpB1dg/8mEHC9C1H1gRcV5UBLvcOKnylyWar30UJXKCLZDI4RXw6eiMbPnX3Uj8/bqk+Vr/G758Vcz5zKFlOVdgk+sxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1yBFjqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BB8C4CEF1;
	Mon, 27 Oct 2025 20:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761598752;
	bh=yprLLzu/23+hltQ8hDoRSGSE9VYBXZzoi6lRcgP6GUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1yBFjqe7L7wiSakMaFxsykOaqlqtoXS31LKAHj3epXm3lgg8XIkT42EhxqZMwgO3
	 YE7454XpIAkuPSYsGIFN/QE3es/tu2qd9U+QkuR3owshZPsToFp83dDaCtkCVgoRzO
	 35KmyTDhGtTE2j+vKr6oONd4rMigXy3t7Mz/aWAaFUSWnkXbr3O2K/CfP3fGUjZjVR
	 ocs11llI7nRErN6nMomsXTtegUW8LQSEQwpUWBFap/NFEJuaM5hZR/g+S8dZg0YoP4
	 kMd/jISG6W4xXr1WRJwsmFiTwkZDgYkTmhOkqHuSDGeAngmyCunnKdLx+yPfkVqrjL
	 S34035HO3C3Gw==
Date: Mon, 27 Oct 2025 13:59:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kees Cook <kees@kernel.org>,
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
Message-ID: <20251027205906.GC3183341@ax162>
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
 <20251025-idpf-fix-arm-kcfi-build-error-v1-2-ec57221153ae@kernel.org>
 <CABCJKuesdSH2xhm_NZOjxHWpt5M866EL_RUBdQNZ54ov7ObH-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuesdSH2xhm_NZOjxHWpt5M866EL_RUBdQNZ54ov7ObH-Q@mail.gmail.com>

Hi Sami,

On Mon, Oct 27, 2025 at 08:53:49AM -0700, Sami Tolvanen wrote:
> Instead of working around issues with the generic pass, would it make
> more sense to just disable arm32 CFI with older Clang versions
> entirely? Linus, any thoughts?

That would certainly get to the heart of the problem. I have no real
strong opinion about keeping these older versions working, especially
since we have no idea how many people are actively using CONFIG_CFI on
ARM. I will say that this particular issue is rather exceptional (i.e.,
I don't know how often this would really come up in the future) because
this code is relying on the fact that these indirect calls will be made
direct by the compiler and checking for it, which does not seem like it
would be really common in the kernel otherwise. We would likely have to
forbid future use of the generic pass as well.

Cheers,
Nathan

