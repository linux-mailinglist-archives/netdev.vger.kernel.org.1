Return-Path: <netdev+bounces-205052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61780AFCFD1
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400491C209D4
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A182E1C65;
	Tue,  8 Jul 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muGsrF0F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C812E11A5
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990177; cv=none; b=IOkOiaUic1+emAAz5UAx411oiJUWnMC8/MbMyT7YxdAiWV8SvHhS2cLbe8PP7/EwPansiuPJxqUI8pXD05Rf7z+jWZsMaAlcKECCy25v5HHkHRV5PqYRo2tMCHVZvUifVX7al4xp59FgPD7t2j03Fc44zFJ465LYLv+N7DfInFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990177; c=relaxed/simple;
	bh=lN5oQoEo6zR6gZHIeGoNzZLxg63ukYteF9ubB9vzvW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5PqmD/oJnj3XhIfOj5iZWWrM5pGKSegdf1TB2E0k6qQ2XIt8Cus9tkq0p20Qs3mIq94wUxRyp3y3DklRoySQfRnZnrVMapYxNUf1gZSQmU/6ZOf891ZXtaI377liMc5sTX89p0o4vUqFOJRhOmR7+a4rCOl2PnAq7yE0IxhrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muGsrF0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A3EC4CEED;
	Tue,  8 Jul 2025 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990176;
	bh=lN5oQoEo6zR6gZHIeGoNzZLxg63ukYteF9ubB9vzvW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=muGsrF0FdC26H9s/MaxiByHNyN8EYysveo1sMu97GCQpvcmXK3fHNeoR3tQUKkK2U
	 iGoWtxIO9yF2MzCgeYzacL3IPGTF+y6zbfZR69dmmH9O71VnHikFoOoaX0PrB5VVTJ
	 rkRmcIZQapczXhSNQhtE5K3Al+KJiDH3ZCEVVWK79x6vWobdmSoStRuMe8AlkXF/0w
	 BIM1Dq78KzvlC30fPUd35hlovtNgeehSfzkHSpZ+fMi3Dj5cB6xmu3HeP3cwUUISt+
	 FxPNoOJho/Sl5kCT1Tw+g2C9cBhcLAfKg8SEkyXdjXktcxe8RhX0I5M1rTjCJe8tfW
	 yqquej2A1Jarw==
Date: Tue, 8 Jul 2025 16:56:10 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, andrew@lunn.ch,
	przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
	leon@kernel.org, gal@nvidia.com, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v3 2/5] eth: ice: drop the dead code related to
 rss_contexts
Message-ID: <20250708155610.GO452973@horms.kernel.org>
References: <20250707184115.2285277-1-kuba@kernel.org>
 <20250707184115.2285277-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707184115.2285277-3-kuba@kernel.org>

On Mon, Jul 07, 2025 at 11:41:12AM -0700, Jakub Kicinski wrote:
> ICE appears to have some odd form of rss_context use plumbed
> in for .get_rxfh. The .set_rxfh side does not support creating
> contexts, however, so this must be dead code. For at least a year
> now (since commit 7964e7884643 ("net: ethtool: use the tracking
> array for get_rxfh on custom RSS contexts")) we have not been
> calling .get_rxfh with a non-zero rss_context. We just get
> the info from the RSS XArray under dev->ethtool.
> 
> Remove what must be dead code in the driver, clear the support flags.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


