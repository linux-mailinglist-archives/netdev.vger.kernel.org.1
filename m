Return-Path: <netdev+bounces-175854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE0A67B60
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 18:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6E719C466D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E60212B2B;
	Tue, 18 Mar 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEtfdg4h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1824B20CCF0;
	Tue, 18 Mar 2025 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320237; cv=none; b=geVe6XbVQhU4DtvW18VKmKwmk1bF1UwxVDJKyfpF0rhr30Uu3o4h8O3UPhrlLDywaIYRjd5+Lwimznq/k7jFnXQHHnEqRHqKEGDi5JZtgmnnwT52XMAvAGkZyBS5q1GBBqAJKxRYTp6PIzZjNtzD4DS2DGa++lxF7j2Scnb7+/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320237; c=relaxed/simple;
	bh=05dV3XU+mkBc9epGa05z7Ilnv35DhfiJI5QbiveCVaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBfq54QqIyqwXDAl+zwoiWqFOU3qLN28Fe7TRDRhGikmDyYCaDQpWdnI/CyCclfq+g6Ieowbo1cd2tdyS9Yh4pZGxLxP1gC3T4fqxuNmc+9uzMqri/TBTS04eonxQ4vTHWQmgB3Vi5h0aXSd+9f3SHPpTFpgrTRiinSk0zPDVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEtfdg4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D290C4CEF0;
	Tue, 18 Mar 2025 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742320236;
	bh=05dV3XU+mkBc9epGa05z7Ilnv35DhfiJI5QbiveCVaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEtfdg4hz79B8jrpwRwn2cl9oYH73z/gds+uQ/pYSRMJOYKFTDpp8ii7283VGc1Ds
	 klTmWdF4rqn3mRKo9ZrkyE+h36AFAXZ9FtXKcrhS9cpPYyc/MvoqkUwRukqrGBLv7K
	 5RbN2ST8KQNqatL8CIBU1/tpS39nMDEJBFtiZS9O/eJhBMpaBYvZo8ftLO0J1cBDHr
	 DxpoTg6DFuEMkLw+QEeLZdA7CCIXTp5FGNqtIejpFAOJIqvIM/rnGnrGqu+4Sj+lXh
	 kfjKTaeSeSLgdxhMl4E4COs4/8WsN8dfeHy4ryy8+e669gAhnKW88hfwAoqxMa2yvX
	 jp0ZHf3aABIaQ==
Date: Tue, 18 Mar 2025 17:50:31 +0000
From: Simon Horman <horms@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Serge Semin <fancer.lancer@gmail.com>,
	Philipp Stanner <pstanner@redhat.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Clean up deprecated PCI calls
Message-ID: <20250318175031.GT688833@kernel.org>
References: <20250313161422.97174-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313161422.97174-2-phasta@kernel.org>

On Thu, Mar 13, 2025 at 05:14:20PM +0100, Philipp Stanner wrote:
> Spiritual successor of this older series, of which one patch has already
> been merged [1]
> 
> P.
> 
> [1] https://lore.kernel.org/netdev/20250226085208.97891-1-phasta@kernel.org/
> 
> Philipp Stanner (3):
>   stmmac: loongson: Remove surplus loop
>   stmmac: Remove pcim_* functions for driver detach
>   stmmac: Replace deprecated PCI functions

Hi Philipp,

Unfortunately this series did not apply cleanly to net-next when the CI ran.
Please rebase and repost, including Jacob's tags.

-- 
pw-bot: changes-requested

