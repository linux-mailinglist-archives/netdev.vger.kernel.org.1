Return-Path: <netdev+bounces-189849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0B6AB3E86
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA0F7A4A49
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E41295515;
	Mon, 12 May 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs4AhFQB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E42528EF;
	Mon, 12 May 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747069027; cv=none; b=vBKu4dHCjnjy0Njgh2PHUI10GNNKCZ64DEq3NaewNwPpj9ehDzNqmTVdHoU6CpMNRzhBYBC+lw6byQ/0OHhgX9hpTY+pSiu8zqAOthpsFsR36qntYVmewuV+Jm7LtE60NE/YMJuJM7PZZKlgiKgWSfUOWs1JB+2OwLfDYBIqirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747069027; c=relaxed/simple;
	bh=WmxDSQ1DuH91G8fUJbKIVxL7Ybu6v7NF21gNiUQeylA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMI3JEC6fGqPaDpt0/j9zlr+uoabBcX44eAlFuKK2oQ8yMDvRUmvpHItyVU67ruvL3lc5zdV2DdgSUFqcEG1XoZc0bGGKH0tHU+fcLMzP3JsRdAHA0ypF7iaEjEhcaQG33NqkRLgMoDejoj3FpZlcJU4nnTwarFOAFrNilftCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs4AhFQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AE3C4CEE7;
	Mon, 12 May 2025 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747069026;
	bh=WmxDSQ1DuH91G8fUJbKIVxL7Ybu6v7NF21gNiUQeylA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gs4AhFQBIj2vEWQp8rRjwwvLgpAAGh/WTj6O92ZXoitVTrsfFYbY7bl0prdAhTW5T
	 mEYBVUjWil88JDQK+ra6MZFvNN71dsCMYcD2RXKJgHmY6F+/zZPnwm4OV3YysQ9lzU
	 cX3mGSJCU/L/p9NCG/b/qrZjsjw9BDCjz5agGxBoMGC6o9Z/yF5TmFNg2GAzEXmddm
	 3l7ZadMgnQYsJ9vBM7mWpFTaZCvXaDFBOewvCDMezzrhuQNY+4KvH2U1KL5LKdW4ME
	 cKN84WS9mFblLebPKsZH2N6AZqDSEBfud88EKlnKwmJM32YPvMDUJu4TVaw9ZMkUCG
	 vrVsq+GowB8yA==
Date: Mon, 12 May 2025 17:57:01 +0100
From: Simon Horman <horms@kernel.org>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sucheta.chakraborty@qlogic.com,
	rajesh.borundia@qlogic.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] qlcnic: fix memory leak in
 qlcnic_sriov_channel_cfg_cmd()
Message-ID: <20250512165701.GT3339421@horms.kernel.org>
References: <20250512044829.36400-1-abdun.nihaal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512044829.36400-1-abdun.nihaal@gmail.com>

On Mon, May 12, 2025 at 10:18:27AM +0530, Abdun Nihaal wrote:
> In one of the error paths in qlcnic_sriov_channel_cfg_cmd(), the memory
> allocated in qlcnic_sriov_alloc_bc_mbx_args() for mailbox arguments is
> not freed. Fix that by jumping to the error path that frees them, by
> calling qlcnic_free_mbx_args(). This was found using static analysis.
> 
> Fixes: f197a7aa6288 ("qlcnic: VF-PF communication channel implementation")
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
> This patch is only compile tested. Not tested on real hardware.
> 
> V1->V2 : Added information about how the bug was found and how the 
> patch was tested, as suggested by Simon Horman.
> 
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


