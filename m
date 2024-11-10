Return-Path: <netdev+bounces-143590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C899C3233
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 14:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887F128138B
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58A019BBC;
	Sun, 10 Nov 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC94Dyjg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4B1E495;
	Sun, 10 Nov 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731245760; cv=none; b=R2xFtvMuruJMFbYswb0A3rGaSEhZHNJ0TwEQcYTvucPvMulPP18N8LRq824nx1M87r9j49VreEdvlZ20LWd7JuB4Lfb948DhO1KzJNivUvvifpM/8iONZPRSjc1NRBWdiS1Q2GvCTFq013zkvVb4jUG/coZnvHcw60I/uzjVwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731245760; c=relaxed/simple;
	bh=/lKfQUd/rjWnE2W48MI2heX3riS1KAnteGBZEmZPoQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLJgvuOrsdN/1pESpwsPJ5mfQJBCeay2Ft4Cx90cucqkmgl6HtXRAWDAla0HoezB7A0qyz5lPAC26NzcFAo9QzplG22zZvGK4tKjn8vEu1SluWOzVGJ/9QYxDk+IgT+GNxxcIPDd/sgVir/l9StbDROqlS2s8xEGjY6KVErvs8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC94Dyjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204EDC4CECD;
	Sun, 10 Nov 2024 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731245760;
	bh=/lKfQUd/rjWnE2W48MI2heX3riS1KAnteGBZEmZPoQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UC94Dyjg+IUAL3oeqr88LpjjvFA+XqMTD9MlOqinxd9xDIRQAd/FEYOXDjWylPI9N
	 FTjEyPu5Xhk9m2oQqaukG/9OyD/zxyQbq89FPyXmWeUBdeUkfQEBncVtC1naDrwFZ2
	 Ksbrf1MqVNUwLNLeO76zKcofTmeJ4uJ1KJbHkT3Kve5/4nI0KIRFsF2spcAJQ10UsS
	 VG8TYVyM3GgdiB7QJ4hIltVa05dLpSkZ2z3f4GbwtYr+tJIAHv5w4zP5c33hCNVb9v
	 kCB3mIN/idQAgjB6BZJjrPkl9b5oSTOkgzvdHt2d2eJGv9HFy2gW/l4GmlHImLcaHL
	 2yfK9c0/XQ38A==
Date: Sun, 10 Nov 2024 13:35:54 +0000
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
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: dwmac4: Receive Watchdog
 Timeout is not in abnormal interrupt summary
Message-ID: <20241110133554.GQ4507@kernel.org>
References: <20241107063637.2122726-1-leyfoon.tan@starfivetech.com>
 <20241107063637.2122726-4-leyfoon.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107063637.2122726-4-leyfoon.tan@starfivetech.com>

On Thu, Nov 07, 2024 at 02:36:36PM +0800, Ley Foon Tan wrote:
> The Receive Watchdog Timeout (RWT, bit[9]) is not part of Abnormal
> Interrupt Summary (AIS). Move the RWT handling out of the AIS
> condition statement.
> 
> >From databook, the AIS is the logical OR of the following interrupt bits:
> 
> - Bit 1: Transmit Process Stopped
> - Bit 7: Receive Buffer Unavailable
> - Bit 8: Receive Process Stopped
> - Bit 10: Early Transmit Interrupt
> - Bit 12: Fatal Bus Error
> - Bit 13: Context Descriptor Error
> 
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Reviewed-by: Simon Horman <horms@kernel.org>


