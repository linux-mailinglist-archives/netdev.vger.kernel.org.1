Return-Path: <netdev+bounces-233306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8568C11724
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 21:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AE83B01B2
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 20:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1852231C58A;
	Mon, 27 Oct 2025 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv7swv2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC931B812;
	Mon, 27 Oct 2025 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761598457; cv=none; b=cr5mUpjtAKcuPdrD7VfjrjLdfXCwVcB80AOE1NYviktCw7acQXkYIpjh5AGStFzLC7qBdFg5YiiOeFo/4t9A8GGb2N1NAs9ZZlVK1QRNceOZGhCRM1D9GaUsT7IazasOtKiIfgbo8zoMuJvjhS75FiCwFzRjCRSR3MhlWli3s7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761598457; c=relaxed/simple;
	bh=uUiV7M0JZyX2CSv7f9ahj+RSKvrXNw1GjFMW/sbepkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGchkfTEpV1bC5WztgYCDcG5DrNS3vAfuDnIs7EjpKbP4xnq8S/Ui/a3HWliXhZJFHDEPs1Fc81jNdPrTEWWcwF/+e6aXyxuN6sc1o+2PkPyqGBj2QbhHlZqm5Flm3/qH4/zgKgrCLMYTh5NjQqrYkUkGdLAcewmDfT/huxCedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv7swv2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7267AC4CEF1;
	Mon, 27 Oct 2025 20:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761598456;
	bh=uUiV7M0JZyX2CSv7f9ahj+RSKvrXNw1GjFMW/sbepkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bv7swv2Vy5HIoJj0IeNA/HUdm/7Tvm2TPzj5ffzqBQn3VCjiHehnp7EgYx1tQdL8X
	 Olr8Fit+1wuR5JT133eEO/hhTStqcqSeHC7xw2a3lTxD3sOPImFYH1HKDOXDAMADnX
	 04PqLJ88APKr4lZvK751n8qXcjcrMn7qiIyLND547vY+Uo93h11HmKeLYLQ6EX1ToO
	 7rm9tcb2dXSaOzzQ7rp51psaIbb/s6Fu2plViBCz1TLY5UPApAy/Hckld7+r+Mtgz/
	 2kzXgT7y0UTuneT84Wpk5n67Bees6h1/OkHwzR+WOECr978M5Y3PmdUK2NN6Vm3lHA
	 juAb69oS+a4Fw==
Date: Mon, 27 Oct 2025 13:54:09 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Kees Cook <kees@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH 3/3] libeth: xdp: Disable generic kCFI pass for
 libeth_xdp_tx_xmit_bulk()
Message-ID: <20251027205409.GB3183341@ax162>
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
 <20251025-idpf-fix-arm-kcfi-build-error-v1-3-ec57221153ae@kernel.org>
 <dfc94b21-0baa-4b1f-9261-725d8d5c66f0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc94b21-0baa-4b1f-9261-725d8d5c66f0@intel.com>

On Mon, Oct 27, 2025 at 03:59:51PM +0100, Alexander Lobakin wrote:
> Hmmm,
> 
> For this patch:
> 
> Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks a lot for taking a look, even if it seems like we might not
actually go the route of working around this.

> However,
> 
> The XSk metadata infra in the kernel relies on that when we call
> xsk_tx_metadata_request(), we pass a static const struct with our
> callbacks and then the compiler makes all these calls direct.
> This is not limited to libeth (although I realize that it triggered
> this build failure due to the way how I pass these callbacks), every
> driver which implements XSk Tx metadata and calls
> xsk_tx_metadata_request() relies on that these calls will be direct,
> otherwise there'll be such performance penalty that is unacceptable
> for XSk speeds.

Hmmmm, I am not really sure how you could guarantee that these calls are
turned direct from indirect aside from placing compile time assertions
around like this... when you say "there'll be such performance penalty
that is unacceptable for XSk speeds", does that mean that everything
will function correctly but slower than expected or does the lack of
proper speed result in functionality degredation?

> Maybe xsk_tx_metadata_request() should be __nocfi as well? Or all
> the callers of it?

I would only expect __nocfi_generic to be useful for avoiding a problem
such as this. __nocfi would be too big of a hammer because it would
cause definite problems if these calls were emitted as indirect ones, as
they would not have the CFI setup on the caller side, resulting in
problems that are now flagged by commit 894af4a1cde6 ("objtool: Validate
kCFI calls") in mainline. It sounds like it could be useful on
xsk_tx_metadata_request() if we decide to further pursue this series but
given we could just bump the version of LLVM necessary for CONFIG_CFI on
ARM, we may just go that route.

Cheers,
Nathan

