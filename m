Return-Path: <netdev+bounces-143588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3809C322C
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 14:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9D71C20841
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4594210A3E;
	Sun, 10 Nov 2024 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIO3FtlP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69A15AF6;
	Sun, 10 Nov 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731245732; cv=none; b=MtiM1lALb4PJbacYT89NJjcWxrrWOOQbDKGD+HylBkV17jmn0OYE0M8kwxFtYD1guIOAdm0qaJup3zWhZlbvZIKYuA/wU+grJ4LVeB9aWLcmZBIsK4AJQLiR+x5uyrH1djmw+lHgp2D/4vLOPlLmzrkn+1aO3X48Vh6qXRzVT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731245732; c=relaxed/simple;
	bh=wAosZbIeN6i75DZ5IsgZbec7MRK0ROPy5XUoDy34nVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZvlRaxV00dDOt3IVC5Pvf/XJ40bDE47c5Qx3sBhACPVJEBk90H6vZ0iWF0y56mF91bAXqwVTRtvsSd8q6c80G5WY9JO+fDgu2z4rASjjNisiRNCzJ0LEq0B9z+8eEgN9S+G8FZhZ/qUDOVU9Vi80D/WrtkA64NkwSJhXkJcmDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIO3FtlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76D3C4CECD;
	Sun, 10 Nov 2024 13:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731245731;
	bh=wAosZbIeN6i75DZ5IsgZbec7MRK0ROPy5XUoDy34nVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIO3FtlPwBtQzNX8Fv2NF3KEdJX2RtwjTu39d03m+uljJkRn7OH+k8RZPnmgcFxMq
	 M1hfjVXujTHfJMX6lffuBSc8ENpI9wWnC8D1P+N2fAl6cIfO5oFJWQf2nFUwflwlmL
	 /VvhI0PQt2tZFZSh8kZSsoBd5wg4ztRHl8IYNgyS6BeVTkAjQHaVPQaucIJzGtoSP/
	 mWbEIo81hX6927L4OIw99CG6RUamy+stIDIhQLrIwM1tAM0bN2srXhHy9M6ReiR5m8
	 wQl6pdNj/YHmNLRs5mWa3Upps1A/nSV1Ib5q4B22FH1jDr7DxiLz6gPRdDumu8JDoI
	 AO8UytdIltBRA==
Date: Sun, 10 Nov 2024 13:35:24 +0000
From: Simon Horman <horms@kernel.org>
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC
 mask and shift macros
Message-ID: <20241110133524.GO4507@kernel.org>
References: <20241107063637.2122726-1-leyfoon.tan@starfivetech.com>
 <20241107063637.2122726-2-leyfoon.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107063637.2122726-2-leyfoon.tan@starfivetech.com>

On Thu, Nov 07, 2024 at 02:36:34PM +0800, Ley Foon Tan wrote:
> RTC fields are located in bits [1:0]. Correct the _MASK and _SHIFT
> macros to use the appropriate mask and shift.
> 
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Reviewed-by: Simon Horman <horms@kernel.org>


