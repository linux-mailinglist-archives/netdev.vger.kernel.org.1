Return-Path: <netdev+bounces-111860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27B9933B46
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 12:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8D21F22A68
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDD217F511;
	Wed, 17 Jul 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMVi5BS3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01D14AD20
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212835; cv=none; b=XQRQUBW2NGj74y+Xu4K4lQKwbR+5/6Tp5LCd70yIjHfoSu+boiOrIOns4EJv3booZl4vKb8z+3X54/FUhI8y+A5Q6sLlsQQTgy+CAoj5xO1zttu4hWbTW1pBQk03ATwGV/2Bd/qLkVdDMiJMCQbtHJvIPLKWXW/SButmKmnAOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212835; c=relaxed/simple;
	bh=f4QTDJ/98bjwtE4iNzhNPLwgyjpQJs6s0kCqNM7Tmgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3Neeeb1XR0DrcvrG2ULxCTC3mQq+7gOwMM/BT1Qv13Q7GYcV/puKu/uOM/zXfpdD7XiMaNQlQ10dg5uBAuVKoOGSubNlaOzSqBjt8LIdFu/HdUxX1LyXNFkZWixRC7wcJTaJ43+mqOB19anEu4LzxfMboBYdnlNZqckleGGXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMVi5BS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC61DC32782;
	Wed, 17 Jul 2024 10:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721212835;
	bh=f4QTDJ/98bjwtE4iNzhNPLwgyjpQJs6s0kCqNM7Tmgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMVi5BS3WUgFHjRurxYBd/JLcA6UrxmzE1cJaFQE55On4GmBfKQIHmKQcsPAN1qmY
	 ijjvScowH1myNYumQ1WcIZ2CdlYxs3hPRASc4w12NotCyXWbiDi7X/BzwMyOIRPoxt
	 ol2L7qDCuZ8CJmYsZ5L47Q2wn/Duu5yY51so3p0zmuBAE6XcskHrAxbcRhKyTxyAVL
	 OzqxPQYNkGuI6cIljgIspFBFbRNSpSFyjZJ+4yxAapx6PD85gdkUTlMnlJHetuy9EW
	 uiNMxosOde4pCX+shmCCqUq6bkGcAxjUJnkw4SXhJ0mdh1MEDJgoudYQbzXgGkcSLh
	 p1ivBFadfFyMw==
Date: Wed, 17 Jul 2024 11:40:30 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [PATCH net] net: airoha: Fix NULL pointer dereference in
 airoha_qdma_cleanup_rx_queue()
Message-ID: <20240717104030.GJ249423@kernel.org>
References: <7330a41bba720c33abc039955f6172457a3a34f0.1721205981.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7330a41bba720c33abc039955f6172457a3a34f0.1721205981.git.lorenzo@kernel.org>

On Wed, Jul 17, 2024 at 10:47:19AM +0200, Lorenzo Bianconi wrote:
> Move page_pool_get_dma_dir() inside the while loop of
> airoha_qdma_cleanup_rx_queue routine in order to avoid possible NULL
> pointer dereference if airoha_qdma_init_rx_queue() fails before
> properly allocating the page_pool pointer.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


