Return-Path: <netdev+bounces-97231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811718CA2F5
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 21:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 012C0B20945
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 19:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C744D54735;
	Mon, 20 May 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEt6XTyl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4612E6A
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234887; cv=none; b=o/c6brl0reayJ+3xSz+13UHllWd5bUkqv+jzSW5QbmAUiXHqnPn1GUWblX9ai60kMd8ljrEppH6LpvKw2UVr3mCVLUhMS1VVGC2gWiX3oFWKczAOtaLYEqRzOhXe8TyxWQX/AW3RUnyKc2tm/G2ILdOfrIdIKdCgNN6bad0iY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234887; c=relaxed/simple;
	bh=9osvqlE1aB7apFS2SaGNuyyUxltnIevasCooMDYcVrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0zxs/W83wu1BstYn7wvQGhdNiQGynUL36k/QNtzg2Gc22ecXz7KUrQvhc33Zt8C45rhJQJbl9pohXjN76ZbAs8NDWirPs/bM4dLWJMJcxCrd9ff6F2Etfh9kNo+HfJUkWxAKX595Vksx8ryljegF4ok/3l6nmgmNTAMupV/46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEt6XTyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512FCC2BD10;
	Mon, 20 May 2024 19:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716234887;
	bh=9osvqlE1aB7apFS2SaGNuyyUxltnIevasCooMDYcVrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEt6XTylgXzYOiHMxlQ4oT2abgJL72w++oTcASYlT2zX5+7VYUMqVp+v4bwpjUdsj
	 iU/P0nCDzmDcJa9r3uEmJHD+uZ82vrAScc/HSS2f230rYzxKu3q92NH4QSyn/3xwA/
	 D2w5QzwXTw+gWtjU/rgGr698Ofe2ij7E5XGxjPhApdOKfZMj6DWK84MNt8YpHrPITd
	 mf9Dou1rLIXRdHq8R4eRebyK1YJ6m7Pt4dxk/dn6ee7m3Sl37JsfYU5E8iGf4QZU0d
	 Qe7sceiUQ6/QzmsI/C5c1i8FrKRG80Ms6NjK7wZ/DtIzuEnT1fkCVasLJJn/sIvkxa
	 lm/UnPaG2IZqA==
Date: Mon, 20 May 2024 20:54:42 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Ken Milmore <ken.milmore@gmail.com>
Subject: Re: [PATCH net] Revert "r8169: don't try to disable interrupts if
 NAPI is, scheduled already"
Message-ID: <20240520195442.GC764145@kernel.org>
References: <9b5b6f4c-4f54-4b90-b0b3-8d8023c2e780@gmail.com>
 <af817788-d933-4cde-8bea-942397fd26fe@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af817788-d933-4cde-8bea-942397fd26fe@gmail.com>

On Mon, May 20, 2024 at 03:50:11PM +0200, Heiner Kallweit wrote:
> On 15.05.2024 08:18, Heiner Kallweit wrote:
> > This reverts commit 7274c4147afbf46f45b8501edbdad6da8cd013b9.
> > 
> > Ken reported that RTL8125b can lock up if gro_flush_timeout has the
> > default value of 20000 and napi_defer_hard_irqs is set to 0.
> > In this scenario device interrupts aren't disabled, what seems to
> > trigger some silicon bug under heavy load. I was able to reproduce this
> > behavior on RTL8168h. Fix this by reverting 7274c4147afb.
> > 
> > Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI is scheduled already")
> > Cc: stable@vger.kernel.org
> > Reported-by: Ken Milmore <ken.milmore@gmail.com>
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> 
> This patch was mistakenly set to "changes requested".
> The replies from Ken provide additional details on how interrupt mask
> and status register behave on these chips. However the patch itself
> is correct and should be applied.

I guess someone hit the wrong button by mistake.
Let's see if this puts things back on track.

pw-bot: under-review

