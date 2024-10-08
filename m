Return-Path: <netdev+bounces-133118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFBC994EDF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0481F231FC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE21DF25C;
	Tue,  8 Oct 2024 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiAg29rs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A57A1DED7D;
	Tue,  8 Oct 2024 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393696; cv=none; b=rYT6X3N4k6I1PxO5B0GlfevCHldfTK5jUnQcaE8D/0h8990wJW3sA34p8s2s74eThOeG2KCH91iPoyZg8wCYEdIMhHNGgTfVpCyzj8/R6DNZsN9SHZl2xFq+MGtXjJb1XHt9QdOeXiPez7io82H7FBey/yGH1HmNLbyQA1nTFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393696; c=relaxed/simple;
	bh=DTn/ijp9ytnREQbnaYklElJZeSLDgUs5VpSucP0DGv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYZBUjTqsrPKHK8aPCAtCW68iViyI8UKsjtMDtQRHDWnY+1TOMrpMLHFtz96HLwQ33aXG5lqqkCHKZa4Jkz6TtoNCQRI+GbsfDdPH5F6naewO5EEhKdvBO+Dy+B3+fQvEeUP7TDI87ANb6WXMX15zf+XI2yiR6CW2tLXzOvGarc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiAg29rs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E29C4CEC7;
	Tue,  8 Oct 2024 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728393696;
	bh=DTn/ijp9ytnREQbnaYklElJZeSLDgUs5VpSucP0DGv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiAg29rs+hi6bIRuIGuurb9f/LTPhPM1bwNCT/6i10E6tMnuS3SXWxxAO3JfvLpsV
	 gUYjXhnLtDwvLHTiAMsKU7ac+han2rQG0ell9kooENU8T55+rI7qfpQpQjxekjqLVE
	 L6E1qbVj1MYYcru0Uzh+M1grpLpNnZTYCzjj0DNr8WdtStWFy/TXTtj0qPQ4JPQBJn
	 ruR24vTqqy7u9pCkU80L1kX/PuXB9DnzsRh8RPOVKtC3OisRtF147i4vv6MCjKDfhe
	 TDj+J8EaFqI2ZU0xE/jH6K/7eCifkpthi88mHQUTE939RFs1dd3eiBM5k6fC+zMavK
	 /FSMxlcXtYiEw==
Date: Tue, 8 Oct 2024 14:21:31 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 4/6] octeontx2-pf: handle otx2_mbox_get_rsp errors
 in cn10k.c
Message-ID: <20241008132131.GR32733@kernel.org>
References: <20241006164506.2082-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006164506.2082-1-kdipendra88@gmail.com>

On Sun, Oct 06, 2024 at 04:45:05PM +0000, Dipendra Khadka wrote:
> Add error pointer check after calling otx2_mbox_get_rsp().
> 
> Fixes: 2ca89a2c3752 ("octeontx2-pf: TC_MATCHALL ingress ratelimiting offload")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


