Return-Path: <netdev+bounces-92220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EBA8B600C
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 19:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C4C1C216DD
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB938664B;
	Mon, 29 Apr 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB7gpnuC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8E811F2
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411790; cv=none; b=qUzLGkYahGZP4X7SOg2F7gUpj3NLqXGUu+acVBV7C720qKMEBpjN7yUT8cOSVlRb/ELdGRCekt3ogbTUcjwPMwbhsz11K09aIj0fuaCj9YHOUEXCgL9dJuS+fLQXoKnyn2d6/OObPMPTNqPs/IufWDQM3zCGZCbsuD8mEEjbCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411790; c=relaxed/simple;
	bh=OkMyUPjC8fLBFCaC8zqtSzOcRuENFV37nhJ/fROhKkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APvCxR41xy175IGfws/rmd/tIbotScKLrSibKSqAzBrylBAsNFrl2iSesyBbAcQN7EH0aNTFSZjgVMciiS2uZktx/GUKsx4Cau0E9vJXg+pjxtNxxHOyMTsYPSHf8c+ea1rNqHgN2Yhemelb88ewExSY7kxQztir3cr8nzIaaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB7gpnuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A372C113CD;
	Mon, 29 Apr 2024 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714411790;
	bh=OkMyUPjC8fLBFCaC8zqtSzOcRuENFV37nhJ/fROhKkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eB7gpnuCSNK5W7yRInrk+g0MjoPAfXT0dls5iCdo+PNoVRyD6hVf9lPHQnxfmF0L6
	 w+JDwqLGXmKwm0bfgdoywrPwJF1hZgXP+19Bs2Xvnw5K7Tp8bRk3bXtbGqjhBPN6BB
	 lI4O9tF6RUkYnz/oa+0faZ/qT6mDkPk2ySYtr4kD4rkQFocUNGJewRC5DryIJvGVIa
	 O3qgCtA3AC2kSC6bcLPCSDPaDMNg9R3vwZozNSKWM9nlkCEBSFMZLhPtduq5Z6UOKR
	 CAD4R3fE+mnAB5rwdYzxJyhBtghd4gFnVE6WSU0nt+nWHMfSKUfAD16r2g87paL3Sr
	 1V7QtDHs+Gf+g==
Date: Mon, 29 Apr 2024 18:29:46 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvneta: use phylink_pcs_change() to report
 PCS link change events
Message-ID: <20240429172946.GD516117@kernel.org>
References: <E1s0OGs-009hgl-Jg@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1s0OGs-009hgl-Jg@rmk-PC.armlinux.org.uk>

On Fri, Apr 26, 2024 at 05:17:58PM +0100, Russell King (Oracle) wrote:
> Use phylink_pcs_change() when reporting changes in PCS link state to
> phylink as the interrupts are informing us about changes to the PCS
> state.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


