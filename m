Return-Path: <netdev+bounces-166696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E54A36FBD
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 18:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1937A4425
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAFD1E5B94;
	Sat, 15 Feb 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxV2AH4u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FED1C7011;
	Sat, 15 Feb 2025 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739640284; cv=none; b=dLgFcwizYLWq/1V9dY40lDqesnkIvs8Ffm5bQFkXmXLnppBSe4bL9QXJW8eF08TB7PefE+HeAeUPAwWDLYx1kO4+nBeLK8yfP9kb105kKZ+VuL+Wr9e5HDT6eNBFw+xeqYlPd4acg8uoZwa880fFZC5wdA21eQDQLCjcV0skOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739640284; c=relaxed/simple;
	bh=9xux18qx9ubVkdev0TOvJT7zo+/EGQTZgqk+KXMRMYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkOODaSRpChbphJ+ya2+c4Qb6rjMNOrHrzP89P2BgsJQLUIMnpPOK/KbdSPazSZoOX/sk4eYzpp0uH1213qfUOgDWybbH/wj7k195GwQ1PoexkzTkIwQslxHVmPuXelGrM/rYZljcvz9yHR12fAUv/8UjbRbQn4AUT4QSW9F+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxV2AH4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58453C4CEDF;
	Sat, 15 Feb 2025 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739640284;
	bh=9xux18qx9ubVkdev0TOvJT7zo+/EGQTZgqk+KXMRMYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxV2AH4uovLSS1POfDAWHYffP3cNZ4M+Gn0RWnrVzIWIMzwtOPcUVqqutZwCzYJwE
	 B8pNNyQZhVpnzhyq8C9s+IXkxiNJMbl7iG22pBop0ScpmFB+JDMU1THxBeP1T6PK0e
	 sBrs4uR2cQNc/yxB8i0IB/om8gSM8BH5LtixtwDh1lwyYHVXH8PI9iYR9fUbv6gX5w
	 q/JtDs5UQeskIsRXFN2bEv5bMP85abNbsbFfkOK8c+iRyG0RQqzeVjpwT7mSAKausk
	 9tvpYVAg8EBgFPHJVWeuCR1SaP/qM7R7WSCuKx7wTFVXkfQx/YYiVeKj4BaI2fD+b/
	 8gzKavLMUjFcw==
Date: Sat, 15 Feb 2025 17:24:40 +0000
From: Simon Horman <horms@kernel.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	skhan@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next v2] af_unix: Fix undefined 'other' error
Message-ID: <20250215172440.GS1615191@kernel.org>
References: <20250210075006.9126-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210075006.9126-1-purvayeshi550@gmail.com>

+ Iwashima-san, Dan

On Mon, Feb 10, 2025 at 01:20:06PM +0530, Purva Yeshi wrote:
> Fix issue detected by smatch tool:
> An "undefined 'other'" error occur in __releases() annotation.
> 
> Fix an undefined 'other' error in unix_wait_for_peer() caused by  
> __releases(&unix_sk(other)->lock) being placed before 'other' is in  
> scope. Since AF_UNIX does not use Sparse annotations, remove it to fix  
> the issue.  
> 
> Eliminate the error without affecting functionality.  
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
> V1 - https://lore.kernel.org/lkml/20250209184355.16257-1-purvayeshi550@gmail.com/
> V2 - Remove __releases() annotation as AF_UNIX does not use Sparse annotations.

Hi Iwashima-san, all,

in v1 of this change you commented that:

  Tweaking an annotation with a comment for a static analyzer to fix
  a warning for yet another static analyzer is too much.

  Please remove sparse annotation instead.

  Here's the only place where sparse is used in AF_UNIX code, and we
  don't use sparse even for /proc/net/unix.

And I do understand entirely that we don't want to overly tweak
things to keep static analysis tools happy. But I don't think the
patch description describes the situation completely. So I'd like
to provide a bit more information.

My understanding is that the two static analysis tools under discussion
are Smatch and Sparse, where AFAIK Smatch is a fork of Sparse.

Without this patch, when checking af_unix.c, both Smatch and Sparse report
(only):

 .../af_unix.c:1511:9: error: undefined identifier 'other'
 .../af_unix.c:1511:9: error: undefined identifier 'other'
 .../af_unix.c:1511:9: error: undefined identifier 'other'
 .../af_unix.c:1511:9: error: undefined identifier 'other'

And with either v1 or v2 of this patch applied Smatch reports nothing.
While Sparse reports:

 .../af_unix.c:234:13: warning: context imbalance in 'unix_table_double_lock' - wrong count at exit
 .../af_unix.c:253:28: warning: context imbalance in 'unix_table_double_unlock' - unexpected unlock
 .../af_unix.c:1386:13: warning: context imbalance in 'unix_state_double_lock' - wrong count at exit
 .../af_unix.c:1403:17: warning: context imbalance in 'unix_state_double_unlock' - unexpected unlock
 .../af_unix.c:2089:25: warning: context imbalance in 'unix_dgram_sendmsg' - unexpected unlock
 .../af_unix.c:3335:20: warning: context imbalance in 'unix_get_first' - wrong count at exit
 .../af_unix.c:3366:34: warning: context imbalance in 'unix_get_next' - unexpected unlock
 .../af_unix.c:3396:42: warning: context imbalance in 'unix_seq_stop' - unexpected unlock
 .../af_unix.c:3499:34: warning: context imbalance in 'bpf_iter_unix_hold_batch' - unexpected unlock

TBH, I'm unsure which is worse. Nor how to improve things.

