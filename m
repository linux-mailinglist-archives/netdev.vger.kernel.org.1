Return-Path: <netdev+bounces-50951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013D7F7AC7
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 18:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE69D2818BE
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534BE39FDD;
	Fri, 24 Nov 2023 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxXKU0ra"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FAC39FD7
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 17:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8522BC433C7;
	Fri, 24 Nov 2023 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700848716;
	bh=LY+9y5MHsF+KtKlVmFalF03dxEUBitUaShH1kcZwyMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxXKU0rap66ZevMPKcQXRiKXP8J2gYakqTq+nJirZkwzxzF7yy+Ptz6gEJhCuhj5K
	 FToDAcVdR6P/ccUFnRwU5DJkTLlJXisDEvxzZt3kO6gnYprvRQz9RPvi7grQ+lIK3o
	 pGAk9+lTCG8uHj+Yl7awdeqyWcFgmbA+zh2wBCeUocMod1Ie2g2pOgvLHh0URQfs15
	 6pVjgQLYfUd/XJndJN+AMgpWOcxaZUSm1j8yreXCKamp69v6Gmt4S/O7/0eMXLURr/
	 35gssgI/QUcy96TtBISjX1bxYBv2in8qLIivUrDLfsP7AQ4jVtmMS4+wsBYWWL26yy
	 xHIIGc6Vgf9kw==
Date: Fri, 24 Nov 2023 17:58:30 +0000
From: Simon Horman <horms@kernel.org>
To: Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] octeontx2-af: Fix possible buffer overflow
Message-ID: <20231124175830.GV50352@kernel.org>
References: <20231123173630.32919-1-elena.salomatkina.cmc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123173630.32919-1-elena.salomatkina.cmc@gmail.com>

On Thu, Nov 23, 2023 at 08:36:30PM +0300, Elena Salomatkina wrote:
> A loop in rvu_mbox_handler_nix_bandprof_free() contains
> a break if (idx == MAX_BANDPROF_PER_PFFUNC),
> but if idx may reach MAX_BANDPROF_PER_PFFUNC
> buffer '(*req->prof_idx)[layer]' overflow happens before that check.
> 
> The patch moves the break to the
> beginning of the loop.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e8e095b3b370 ("octeontx2-af: cn10k: Bandwidth profiles config support").
> Signed-off-by: Elena Salomatkina <elena.salomatkina.cmc@gmail.com>

Thanks Elena,

I agree with your analysis and that this seems to be
an appropriate fix for the problem.

As this is a fix, it should be targeted at the net, as opposed to net-next,
tree.  Please keep this in mind for future patch submissions.

	Subject: [PATCH net] ...

Link https://docs.kernel.org/process/maintainer-netdev.html

The above nit notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>

