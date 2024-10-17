Return-Path: <netdev+bounces-136576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2279A2293
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1816E1C22266
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEE61DDC33;
	Thu, 17 Oct 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9FEO4bZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984941DDA2E;
	Thu, 17 Oct 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168790; cv=none; b=KM+lhC1GObkULFwfhZ7+iJQLZ9VbFEH+PGTkC2n4fdoEcajqKSTyvzQUS4YrsSYbVsooyE14ccyXnRxCvhiE6S7hDAbmV+77aAEcjnYtw8VHEwq9/KCrFSYiRF9cJ5JZMqJWDnr4Sm7ai3iwTpCVt66/4q5z89JUVFlkrQXOohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168790; c=relaxed/simple;
	bh=2VJFmZI6FSCX02zlaODuqhA9A2jIb8f/QC1MgWo2eBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djrfM6gLa4zxV0M6mxgNGUfAZjAS2Y0m2oEW5a6NKROOqdh95h/ERZE1voSOQpHUuqd9Dj45zzp1bXnJ7emxp3mV0MqM4fvp4r1nIfv6aWxkvR3SiQYE74rgIoC+JB2E9oRSAaj9osco6fwuRV0VtgFqlumww1ty9GGc+urmRq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9FEO4bZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CD5C4CEC3;
	Thu, 17 Oct 2024 12:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729168790;
	bh=2VJFmZI6FSCX02zlaODuqhA9A2jIb8f/QC1MgWo2eBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9FEO4bZ/YPMz6NPT/Yl0wq7D2Rhq5tNdcb98IC0SBo6SvifgKYsOFWzv62tyDR3m
	 cGGaZKshEd1UbGO6KGcyg3IevhsFNtXZS5ixEFP0WTBQxCgnANCNPTXGeU43kmJRG6
	 G0DVYKpm7i4X8/S8IW1pWG3woo+ZO9ct3ldfF63nQQK3EQsd8jWfLB0k0RJweG+sy7
	 1J8oN3I5NyCgl+r6ztwtG9RqnddWQv2fyWPwuBhtsdsPRxNEGzrtKbWvKh1MFA5rnL
	 FU3CqhmFXAeJkwlb6jpX0Pwk6oXGOcgVC8qJIehBAP0d5gPxy5rABTOfBbx3yUc4cb
	 t+K71CnFJVa9Q==
Date: Thu, 17 Oct 2024 13:39:45 +0100
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1 2/5] net: stmmac: Introduce stmmac_fpe_ops
 for gmac4 and xgmac
Message-ID: <20241017123945.GH1697@kernel.org>
References: <cover.1728980110.git.0x1207@gmail.com>
 <ec781b526edb2efec7fcfdf03043c7d1d9b707f0.1728980110.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec781b526edb2efec7fcfdf03043c7d1d9b707f0.1728980110.git.0x1207@gmail.com>

On Tue, Oct 15, 2024 at 05:09:23PM +0800, Furong Xu wrote:
> By moving FPE function callbacks from stmmac_ops to stmmac_fpe_ops,
> FPE implementation becomes a separate module completely, like the
> EST implementation.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


