Return-Path: <netdev+bounces-249868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A76D1FDC5
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 401F9305EFAF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D74239E19A;
	Wed, 14 Jan 2026 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiwNnuf7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70337F8D5;
	Wed, 14 Jan 2026 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405281; cv=none; b=h16NrrOhoGnRwN+1ysXxGDLlADItWeymMf0YrjO2pL/ocTFqeypdg3++Glpf87LMp3lZ4WPSMro5mpPjQHNFXT+OQokrc8DuIRxslR7rW3oQDg4mR+f1Hg9nnmDyILz0iHadU7+xXX7r8cRhM6DekePPirrwkdwvrPsbn+6qCz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405281; c=relaxed/simple;
	bh=RQSRiTI5Ss+Tc8KPe8Ge/hfsHFkfRdRKZ4LXmUHadGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyjCqJqiBSaFtK6aGc+yb1q6h7mjh0yp0uwhchO9SKhJ33PteDq961TA8p+NICUB6td/DynAIsRAeWiUyF879yHJ3mdhPDKLaU/72H80wqptp+hYlLDaqEnSyVvz1TV8t28ogo+6VdlpdD9quVaSlZcLmlNI2cz0B2wD731099A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiwNnuf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD93C4CEF7;
	Wed, 14 Jan 2026 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768405279;
	bh=RQSRiTI5Ss+Tc8KPe8Ge/hfsHFkfRdRKZ4LXmUHadGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FiwNnuf7RCGJjhg58kKfW5zsBcbzbaQisBT7dpxiBPetvQ2HfDTJiDeI6FoU2SJQX
	 J3lcqcd0B/XtWGnttdT0+JE8+76rAXwMPBGesA/bGaOwV1QRJCamr8f4zdPjm7Z5ST
	 q/Haykvt4UDCAiCpDZd5fcipWHgtETVg7YVOmaTb8vNhtxT4JlXemfgzp/FRobhp8d
	 Pgd9hHiscvXr7W2ZHqmJXx/QXOnbEhWqEZc3T8/kruS9s/eHV+qgKmxWac9owjr3a/
	 OAwIL/3nSM23c6ipj+7r449GlS39xbu1Wt0rr0oBNet60cwrIknLIfruGhvS/hh3C1
	 nMb84SuuyJwPQ==
Date: Wed, 14 Jan 2026 15:41:14 +0000
From: Simon Horman <horms@kernel.org>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangfushuai@baidu.com,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v3] wireguard: allowedips: Use kfree_rcu()
 instead of call_rcu()
Message-ID: <aWe5GhgmyDkaBLwS@horms.kernel.org>
References: <20260112130633.25563-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112130633.25563-1-fushuai.wang@linux.dev>

On Mon, Jan 12, 2026 at 09:06:33PM +0800, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> Replace call_rcu() + kmem_cache_free() with kfree_rcu() to simplify
> the code and reduce function size.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Thanks,

I believe this address prior review and moreover I agree
with the approach taken here.

Reviewed-by: Simon Horman <horms@kernel.org>

...

