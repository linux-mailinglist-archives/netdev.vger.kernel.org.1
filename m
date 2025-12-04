Return-Path: <netdev+bounces-243564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF42CA3BB9
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CDD53007654
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7C9338597;
	Thu,  4 Dec 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdbHbA+k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F7E13B293;
	Thu,  4 Dec 2025 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853906; cv=none; b=A39ZigZ3YiHFYABRfuofIgaBMJJGO+Vaygx/HnscNCzL9MStyJDdHMeOhXLCYj396OpgRAoVl7ewnNvS5B2nvBC+fNgJ3+acI2+2wucWsOk2kvPTym9IZ3iox1/3I42tnmLy7jAYVctKmqLLOE8RQU66g3Q/mecvMU05TR8y9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853906; c=relaxed/simple;
	bh=+j/Dyt2kX1KcZTxk4BFPDXWyhzYkXuFwe5a7yW2SXhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg9PJsy7jUxwbnOAz+wqhkGKeR6rd2HI9vEf5XKN9Y8RaRoKt57eTxe5joBtkQB86awx6++QNil6mJTWw+Uu68rAGvqZjapwttH5qU/CxBu9e2BuHVqevFY6gaKFyCDw9uCziYWQjM7m31W/6y71B/ET7jwk5IlZEMrRQYgoqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdbHbA+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793D7C4CEFB;
	Thu,  4 Dec 2025 13:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764853905;
	bh=+j/Dyt2kX1KcZTxk4BFPDXWyhzYkXuFwe5a7yW2SXhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdbHbA+kiUZDRXwApyFbS8/kSEPio8MVHsoe7cCdxa4qu0+SShbA9HZKQRO5XVT5M
	 5pI/eDL1skHttyIeVy3WtGPUeYg9ma4iCDaDGFbV/hHsELYZ6xKXAQTFN2x75BO3uw
	 v5o9Z0DnZveASsbZZBDggo5nC2DeJR+QXmB3UuPGz9OH4u7iKiFvp4+xmQqBZJNihd
	 XONQn+wZMmKFlPwFfZrQps4Bu1zFOsrtKKmLu2IyGDp57xbbiJrog6Io6NB4CBZdjk
	 weHtGtAYyjKQ5pcvbggaYAAkFNWVi8mbhf0/eZRPzvILRbkw0hnmLfrklFx2Wgwhij
	 krCwcXhQ2ut9A==
Date: Thu, 4 Dec 2025 13:11:40 +0000
From: Simon Horman <horms@kernel.org>
To: Jie Zhang <jzhang918@gmail.com>
Cc: netdev@vger.kernel.org, Jie Zhang <jie.zhang@analog.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: fix oops when split header is enabled
Message-ID: <aTGIjNiHhWHd_RkN@horms.kernel.org>
References: <20251202025421.4560-1-jie.zhang@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202025421.4560-1-jie.zhang@analog.com>

On Mon, Dec 01, 2025 at 09:54:16PM -0500, Jie Zhang wrote:
> For GMAC4, when split header is enabled, in some rare cases, the
> hardware does not fill buf2 of the first descriptor with payload.
> Thus we cannot assume buf2 is always fully filled if it is not
> the last descriptor. Otherwise, the length of buf2 of the second
> descriptor will be calculated wrong and cause an oops:

...

As a bug fix this should have a Fixes tag here
(no blank line between it and your Signed-off-by line).
As a rule of thumb, it should cite the patch where
the bug was introduced.

Perhaps in this case the following is appropriate:

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")

> Signed-off-by: Jie Zhang <jie.zhang@analog.com>

