Return-Path: <netdev+bounces-233304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00906C1167F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 21:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEF80352110
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 20:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490E93168E3;
	Mon, 27 Oct 2025 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7dndVWK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181662FE057;
	Mon, 27 Oct 2025 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597398; cv=none; b=ELowErp57h1KMnQryksX+Mkg7/+ihSJPoWG1In/z3OqGIiKfXYpvNfUNCcGch0cAHhvXkm2EVAzBrf903Dvc5YWEjKr0KOL9RPmGxLs8pMlFsB+qEVJGHOP7+zD2+NnpG/KociN0cZCjTiHrhU6/CRKaB/ULJcUEIftVqjMX14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597398; c=relaxed/simple;
	bh=7vYNu/V+yB8ESbhKG+qhmi2rqh8DEHzZMx+plWdaAhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6JOyky9vLq1UR3uLYOLOqJcm3LY9mr7lXEC3kbreZAFdRv6mnLPCUb/3GFnL7hDevcoBNTLdoFWqdUGmGVF31GOTvxmAzBvYviAUPfvGuUcBsCnEDv+QMPrFOtYL/tttbbncf7z7KAFABCshHPH+N3ycYKaBDUVFg/SebYc9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7dndVWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57184C113D0;
	Mon, 27 Oct 2025 20:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761597397;
	bh=7vYNu/V+yB8ESbhKG+qhmi2rqh8DEHzZMx+plWdaAhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7dndVWKprOCSRBJDcOURDGTFrK7JuobTF+mTzjIHZk72c4FARzR4jiOUh37UXyUp
	 /G1kAYzF29MRtsLosHiivhVYIUnVCPfYWzE8tUmrwxfizg8yY061hr7lAcWDNF42JY
	 8yDvgvY4Qw/Mnf2dHilSANLgUvWmn+g4eRVLTD4C+8g83DRqj2QXyQd8a/mwpGhZ0z
	 iWjcs7LSlcBGsu6BIyQWIBcKaq7SJc2pqvi5gzHCPAi5pKHDpbphrVZP0+thl9N3Si
	 kcQ6g2jZ50aJLx0bC1jsEePTNV73o1C+SpRJ/2HGONCGVDnTjWtF6gmKZekOYJ7hJf
	 cakXPLlCr953A==
Date: Mon, 27 Oct 2025 13:36:30 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Russell King <linux@armlinux.org.uk>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 3/3] libeth: xdp: Disable generic kCFI pass for
 libeth_xdp_tx_xmit_bulk()
Message-ID: <20251027203630.GA3183341@ax162>
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
 <20251025-idpf-fix-arm-kcfi-build-error-v1-3-ec57221153ae@kernel.org>
 <fa4487d0-a077-4582-80aa-2deeccee6270@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa4487d0-a077-4582-80aa-2deeccee6270@intel.com>

Hi Przemek,

On Mon, Oct 27, 2025 at 12:09:47PM +0100, Przemek Kitszel wrote:
> sorry, but from regular driver developer perspective, just after reading
> your commit messages, I'm unable to tell what the fix is about, and from
> that follows a bigger issue: how to write code in the future to avoid
> such issues (it would be infeasible to always wait for a LLVM specialist
> to come up with a fix ;))

Sorry about that! To be fair, I am not sure most driver developers would
write something as subtle as this code to get themselves into a
situation where I or another LLVM person would need to come along to fix
it.

> was the tricky case to call __always_inline func from another that was
> marked the same? Would it be also the case if one of the functions would
> not be marked with __always_inline attribute, but still end up inlined?

No, I think the tricky case here is that the code depends on the
compiler being able to turn all these indirect calls, as the (*xmit)()
and (*prep)() parameters in libeth_xdp_tx_xmit_bulk(), into direct calls
through inlining. I find that depending on optimizations for correctness
(i.e., passing the assertion that the result of a equality test can be
proven true or false at compile time) is risky because it can result in
flexible but performant code but it is also sensitive to interactions
with other compiler internals and optimizations, resulting in changes
such as these.

> what would be the cost of the alternative naive solution, to always add
> __nocfi_generic to functions marked __always_inline?
> (technically you would redefine __always_inline to have also
> __nocfi_generic for the config combinations that require that)

No, you would not want to do this because if any indirect call remained
in the inlining chain, there would be no caller side CFI code generation
and that indirect call would automatically fail (if I understand
correctly), which is why commit 894af4a1cde6 ("objtool: Validate kCFI
calls") now validates this rule at compile time for x86_64 (which is not
affected by this issue since it does not use the generic LLVM kCFI pass
like ARM prior to 22.0.0 does).

> sorry for my ignorance of not reading any of the attached URLs

No worries, I am not sure how much more they would help with
understanding the problem, which is subtle. If I can clarify anything
further, please me know but I am not sure it will matter too much since
we will likely just forbid using the generic kCFI pass to avoid this
issue, rather than applying __nocfi_generic.

Cheers,
Nathan

