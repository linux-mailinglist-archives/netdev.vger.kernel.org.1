Return-Path: <netdev+bounces-133733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE73F996D17
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A691F2578A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824DC199FAC;
	Wed,  9 Oct 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE0ZyA1F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D338DC8;
	Wed,  9 Oct 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482488; cv=none; b=O7GBrxFJIdP1tgW7kTbCBAKpiphIWDYqMRLt6fxulr8ORJBnC9LoQASad00D90+3/M3WWJB/xyPp7w6NwQ3pNCVQ6l2FnDNl1zKs+eqnsEIwhYDTl9uV8CImn2lnp2f2W88xBrhErmAyaXpKs8spbw7Ncs2NrJd6LvhmES3Ty7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482488; c=relaxed/simple;
	bh=2JbLa20JN/3ywK6IVx4oCdQ05OVI4F87l8ogZWYm4b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewRzx1XIAqKnm3k51WgpQvIE/wEyANrVSDiWVldoVChW7yA+sDurqr7b1IqZFhunrynyrlL/zfZVp6CN0Abty9yfJq6KQzfOiQsgcRSGu29pxw6jkHjSVzs86nsb+BSL/DslHNUFWZi3qr7z2p6o+dGBN/yzdJK+MiyP13p2psU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE0ZyA1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988B8C4CEC3;
	Wed,  9 Oct 2024 14:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728482487;
	bh=2JbLa20JN/3ywK6IVx4oCdQ05OVI4F87l8ogZWYm4b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WE0ZyA1FKozwqrzhRTUbwsoHEoDe/V4nqQsAYDl4Sjg/M2hsCLi2UxgSJ46HKdR2X
	 MCNy9HoWCH5g23SBcYbtLWfR49guY+tXkN0wTcdQxEowBgjFLEd9xpsgqHiPb+sEwu
	 x/BH5Uk8qHRTqDkITI53DsX8ptgRZCNmGW+aIySnuig/05u0C4D823o+l9OrUp9aTj
	 VfsUetTdUzYCnGiPV/LQHGWv4aAZFpayRDvPXR34HoiMPPw5LKm2bTsfTCtDwNXDEY
	 gyO9yoL2xXruXJf9LmJ7hpBNJ0W5R3UuRz6VcQ35gkz7e+jOKekKsgQuEo8K6pFTTe
	 abZCif0mdttHQ==
Date: Wed, 9 Oct 2024 15:01:23 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: sparx5: fix source port register when mirroring
Message-ID: <20241009140123.GB99782@kernel.org>
References: <20241009-mirroring-fix-v1-1-9ec962301989@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-mirroring-fix-v1-1-9ec962301989@microchip.com>

On Wed, Oct 09, 2024 at 02:49:56PM +0200, Daniel Machon wrote:
> When port mirroring is added to a port, the bit position of the source
> port, needs to be written to the register ANA_AC_PROBE_PORT_CFG.  This
> register is replicated for n_ports > 32, and therefore we need to derive
> the correct register from the port number.
> 
> Before this patch, we wrongly calculate the register from portno /
> BITS_PER_BYTE, where the divisor ought to be 32, causing any port >=8 to
> be written to the wrong register. We fix this, by using do_div(), where
> the dividend is the register, the remainder is the bit position and the
> divisor is now 32.
> 
> Fixes: 4e50d72b3b95 ("net: sparx5: add port mirroring implementation")
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

