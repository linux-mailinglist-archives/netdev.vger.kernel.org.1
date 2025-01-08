Return-Path: <netdev+bounces-156202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F923A057B0
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060AF188203B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3A71F0E33;
	Wed,  8 Jan 2025 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSYzvAZl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52471AB511
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331061; cv=none; b=Zg4XMcPnU3UIHOltCrzRd7ak4rlvWbsuaq1du8vh3TynjoYYtK/J/X7B8nLhVpnYPxJX69i7np0cYZdfnPG4ZZpF53VRKFjkyCEoO3vjd5lKSZizRfJdNgh8D2sGOfhLvmTPZKrJl/NvRnBwlse5NZ3XlJtEvKmxM7qbTieqHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331061; c=relaxed/simple;
	bh=ZAOvCmQtAkYPaOMmqXIxilcjMsbJEBo9S7TbBj2iB7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orD41W/bbRHGURuQXiWAJsIWPyrjpo6pDwmFwXTQ7HEmMVr0L6g2fSS4N+IQ0C3hnVgcAl2YBHUtVh6X6o6IMnhHhf6fPDIHDeGjZ1Kjkji/YdySmghCWUokmwb0EXy0/wJQSyMUd0rslX7tMxQ+/vIMl7T5/eT1ysyp5zlaQ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSYzvAZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91504C4CEE1;
	Wed,  8 Jan 2025 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736331061;
	bh=ZAOvCmQtAkYPaOMmqXIxilcjMsbJEBo9S7TbBj2iB7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSYzvAZlwLRamAE26BsRm51HQXveJ4MnFFNKVCnpyhZORRvxcNdfE2EzoYfPX78Fn
	 9eD88AukwzOmZ798c+wW0/YXJTRfwrIoLdvAW9ryKPbHe5tzNaUY8njTdya7Xx9v1C
	 mfq0RrKUVoT4SKPgrJh81bbqGsrl1+9YYIfLQX/IcetSuqWDSY2NbkSEaXXcphgxvg
	 mTHZAuSUfHJHSIaLANiMJDM9dYxS53dHciS87qqmmNe4QklC0uM6OcSxcTue94v929
	 Jw4drEvlia9a0C29yRKywXhMiVn2Qj1qcu25x/Zm5L7LC+1fn8k1rMyju/41hRpJCZ
	 zSfqDbT32fDdA==
Date: Wed, 8 Jan 2025 10:10:56 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 04/18] net: stmmac: use unsigned int for
 eee_timer
Message-ID: <20250108101056.GH2772@kernel.org>
References: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
 <E1tVCRj-007Y3H-Hm@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tVCRj-007Y3H-Hm@rmk-PC.armlinux.org.uk>

On Tue, Jan 07, 2025 at 04:28:47PM +0000, Russell King (Oracle) wrote:
> Since eee_timer is used to initialise priv->tx_lpi_timer, this also
> should be unsigned to avoid a negative number being interpreted as a
> very large positive number. Note that this makes the check for negative
> numbers passed in as a module parameter redundant, and passing a
> negative number will now produce a large delay rather than the
> default. Since the default is used without an argument, passing a
> negative number would be quite obscure. However, if users do, then
> this will need to be revisited.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


