Return-Path: <netdev+bounces-136000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326AD99FEAA
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 04:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642EA1C21333
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA30A15ADA6;
	Wed, 16 Oct 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRDpX/Kg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939AB158A36;
	Wed, 16 Oct 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044631; cv=none; b=INtCH+BMZWEEIdFRaEllR+s4wVhMZaHs5BgQfTFttScFvDm6TNhrnsOPqVfBKeqf82yfJRlv6II31VPVXtZMSlA8GhNhfpzzTze2x7x3iv8oFiTxaoF8Mzzjj7swdjL2YWXZPqheGD1+D8D2UM1pMXGI9SUAKnfOtRfBKSdo5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044631; c=relaxed/simple;
	bh=QFEVKBp3PKfed8x/j9nO5Hzk2COKh3V0hiVyr+Nq1DY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXGBJboxRL46yNfpySGVEam7rrxHeNhUYQKHs3XDquibHWcB1t5ewwV+5qE6ypXXtz0QNpFjr8DEjjZTcvHWgS8gycMms8o3iofF0Uu808Q8xkDxavmysYurgyb/gvfn5q0Re+TLcG6GAkzQWdimUrQ6AcHYr9k/V+g7UplmfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRDpX/Kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B726CC4CEC6;
	Wed, 16 Oct 2024 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729044631;
	bh=QFEVKBp3PKfed8x/j9nO5Hzk2COKh3V0hiVyr+Nq1DY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cRDpX/KgZk1FE2Bj4Q/R7vXWRD90Aa3SvsDGZtOk3MvYrZZ3p++0ggT29twejysDy
	 3COXpXTknJeR98qXp1VTu76GdCUUSXxn/eu/X5BSS8HLw/oy9InNiYUOV45CpSWj0v
	 hWKOANYI8CtcLjv4z6RBOdA4wdjX94SM8+2BhKlwHnskSqOKWXifKoTd7DGSrcvaWM
	 xRd9JN214XhqEmeU1SW0YMNuCYvK/o44atBz8FMNrOyFxm7EXxFdAmRk7aIgI/Clsq
	 tIBxcV27+vogP1v633yDZVMLrWri7oZhxs8uOABuiaTJ98yJAmmpYfl1e1LflijMVL
	 xnUUY28F438Ng==
Date: Tue, 15 Oct 2024 19:10:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lftan.linux@gmai.com
Subject: Re: [PATCH net-next 1/4] net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC
 mask and shift macros
Message-ID: <20241015191029.23d5bfb0@kernel.org>
In-Reply-To: <20241015065708.3465151-2-leyfoon.tan@starfivetech.com>
References: <20241015065708.3465151-1-leyfoon.tan@starfivetech.com>
	<20241015065708.3465151-2-leyfoon.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 14:57:05 +0800 Ley Foon Tan wrote:
> RTC fields are located in bits [1:0]. Correct the _MASK and _SHIFT
> macros to use the appropriate mask and shift.
> 
> Fixes: 35f74c0c5dce ("stmmac: add GMAC4 DMA/CORE Header File")
> 
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

no empty line between Fixes and Signed-off-by lines, please.

Please fix and resend with [PATCH net] in the title.
All fixes which are needed in current Linus's tree need to go to net,
rather than net-next, see:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#git-trees-and-patch-flow
-- 
pw-bot: cr

