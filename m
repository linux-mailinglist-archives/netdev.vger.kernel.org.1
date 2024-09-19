Return-Path: <netdev+bounces-128971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A677097CA82
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 15:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30187B22015
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B71319E7E2;
	Thu, 19 Sep 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3XjLe0D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F8419CD17
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726753948; cv=none; b=CscfEFA2z1xwPILI72leQGgOvQK7GKrSqCUJxLwqdxi7H619sJgmvGBAihL/CLpQYZ0jdfkekatnmFZLYwjimH0aVGS9verRORiFkwmb7yEOur0UERiPB5CoFmWPU84QT3bNzCCPkkisDmCUkYBhG8dTJp/f4TqrHvm52H3f+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726753948; c=relaxed/simple;
	bh=gP3LMpD1WBhkOoq19t4rJZisO7I+afdMCW4t9vEvs8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiAZUhEqIZGKzqnErzTuymDWiQsKWEC3zGf0sumpB/pbPj4D7r/Pt7jQDHjT03m5Gsdiwmq2CSqHZh+ymA+Pnj0/EmwDkYKzmybeAr0mysVAE6KvqPeg7M0T+9kGCNPNPoCBjt98LpNWPAa7vLc6FaMts2aXwb+np0pxJ/03r8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3XjLe0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C5DC4CEC4;
	Thu, 19 Sep 2024 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726753947;
	bh=gP3LMpD1WBhkOoq19t4rJZisO7I+afdMCW4t9vEvs8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3XjLe0DEBS2HPrqWy5Mjnqhu1yn31qz7AFiKDyvc4ERag2NTwERrtcWq8+AC+DH5
	 eNy1OiSIK9ROxY4UlGdm8dpshHvR/DLpT/PnQ7j9D3jEMTnXbWf1S+c9S542D9+E3o
	 dHZ7a6mEceYIPS18M00IEZMpDOW60bgatoJOSs4K7FUKgTsTemUY6w8OcK0ou8MWNQ
	 z3m37YI+r063wKP5BYrfaPFIZXH7Gn89zUdhWDftlg1d6B9Uw9OlFV2ihaIovoj/iq
	 T7SvvdlTnVG7RNKfi2c8w5Ia0wfornwZHYNTrotTXKuDKy5Z3tYqhOMYwDzsS0v1+4
	 yglWWSzSYh1Dg==
Date: Thu, 19 Sep 2024 14:52:22 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com, Sayantan Nandy <sayantan.nandy@airoha.com>
Subject: Re: [PATCH net] net: airoha: fix PSE memory configuration in
 airoha_fe_pse_ports_init()
Message-ID: <20240919135222.GC1571683@kernel.org>
References: <20240918-airoha-eth-pse-fix-v1-1-7b61f26cd2fd@kernel.org>
 <20240919074210.GE1044577@kernel.org>
 <Zuwf57d09WBYKtSS@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zuwf57d09WBYKtSS@lore-desk>

On Thu, Sep 19, 2024 at 02:58:15PM +0200, Lorenzo Bianconi wrote:
> > On Wed, Sep 18, 2024 at 04:37:30PM +0200, Lorenzo Bianconi wrote:
> > > Align PSE memory configuration to vendor SDK. In particular, increase
> > > initial value of PSE reserved memory in airoha_fe_pse_ports_init()
> > > routine by the value used for the second Packet Processor Engine (PPE2)
> > > and do not overwrite the default value.
> > > Moreover, store the initial value for PSE reserved memory in orig_val
> > > before running airoha_fe_set_pse_queue_rsv_pages() in
> > > airoha_fe_set_pse_oq_rsv routine.
> > 
> > Hi Lorenzo,
> 
> Hi Simon,

Hi Lorenzo,

> > 
> > This patch seems to be addressing two issues, perhaps it would be best
> > to split it into two patches?
> 
> ack, I will do.

Thanks.

> > And as a fix (or fixes) I think it would be best to describe the
> > problem, typically a user-visible bug, that is being addressed.
> 
> This is not a user-visible bug, do you think it is better to post it to
> net-next (when it is open)?

Yes, I think that would be best.

If you do so please don't included any Fixes tags.
Instead, if you want to refer to a patch, use the
following syntax within the patch description.
AFAIK, unlike Fixes tags, it may be line wrapped as appropriate.

commit 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")

> 
> Regards,
> Lorenzo
> 
> > 
> > > Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> > > Tested-by: Sayantan Nandy <sayantan.nandy@airoha.com>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > 
> > ...



