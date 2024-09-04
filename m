Return-Path: <netdev+bounces-125021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B81696B999
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDBB1C2152C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577741CF7BC;
	Wed,  4 Sep 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiYkkAXU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D5126C01;
	Wed,  4 Sep 2024 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447885; cv=none; b=WUsn86XhhSRM4E3ESLvrkUeQjz35idsYwGQ0tzF+Rkt51lVk3UBuueSzWGUkS7WJe+/qr9yoNavikpV/zNe/K2xanm4Dfgh2XXrPzA1b2lFzaB6n6TCXB/x5ssW3TTBjt+qgrlEimOhLPuFDff8WFqXfSu7mikA3LlM5j7pudxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447885; c=relaxed/simple;
	bh=hq/QhjTFUlxTurh/9Hd2Paruzo6RnLrRAoVgA1juCY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoOufZc+xTgLne3+ul64d0ZhqGTc+5TWvPRY1i1bimEynMK3YYUXkxiaujGMOhIJk8Mcj+boFnh+ZDL0juVT3U3qNNVS/Bg9gmvqHKGQF/dd0U74t+rGh/A/pN4TaTYyCyBSdedBvnSwAjOX3eGK7ljcTalUamG0J4W0txNjQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiYkkAXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D793C4CEC6;
	Wed,  4 Sep 2024 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447884;
	bh=hq/QhjTFUlxTurh/9Hd2Paruzo6RnLrRAoVgA1juCY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiYkkAXURl0d156oNYolkvSi4PojvF+3vl5JC03yY6bv438H77fmmlP4wMF6XzbGh
	 DQWAwpHsdtehgdOHstwNRKsqGXVApYfdeDEOPVyM2vWcwIXAfFsaEVPeHPJHXrNdFz
	 rY5M2YETj6syODE7iNNGEUNlIo7vdKCOhL/Z8vXbZ0IWPV93ZEkZFpTMg5xYZ35lVZ
	 P4cSCfCHUgx5dDVls0blHmywbuyeJOBaZ4qoiqt74MpMlzGD9mL3CrBqHtaxbLIQ7a
	 3y8kNiNMUrjSqD0PU55lq89oRxpRfArdfTZsUwzfR3ZjSZpCDiPIQiO3vHHLe6EsHZ
	 SLj03kME6wGLg==
Date: Wed, 4 Sep 2024 12:04:40 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	thevlad@meta.com, max@kutsevol.com
Subject: Re: [PATCH net-next 5/9] net: netconsole: introduce variable to
 track body length
Message-ID: <20240904110440.GS4792@kernel.org>
References: <20240903140757.2802765-1-leitao@debian.org>
 <20240903140757.2802765-6-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903140757.2802765-6-leitao@debian.org>

On Tue, Sep 03, 2024 at 07:07:48AM -0700, Breno Leitao wrote:
> This new variable tracks the total length of the data to be sent,
> encompassing both the message body (msgbody) and userdata, which is
> collectively called body.
> 
> By explicitly defining body_len, the code becomes clearer and easier to
> reason about, simplifying offset calculations and improving overall
> readability of the function.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks,

I agree that this improves the clarify of the code.

Reviewed-by: Simon Horman <horms@kernel.org>

