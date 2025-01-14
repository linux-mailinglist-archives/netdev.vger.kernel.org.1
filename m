Return-Path: <netdev+bounces-158183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA6A10D33
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 18:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760A3188B371
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9161F9AA5;
	Tue, 14 Jan 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCRYHjpb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86D11F9A91;
	Tue, 14 Jan 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874730; cv=none; b=r1kzsSvDD6gTElDpY2Un8gmUZRA4rx2LQVYUd4RWym+EDdi0uWrNt6MMGiWvEV7XH/umcosLmMYBGMwwQ/6T+Qo4+ZgMgzTAfPv/2dHHPpKhZ0/1oAvagexAiL/HXEXcElVo1VOU3P7I27gQkhFYj0Vfpn33/YmeXslqSwbhh7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874730; c=relaxed/simple;
	bh=9WG2Vvk6Mj8NyVtPI2yl8c/mPKMYBdtIvdqO0ucUMtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfgKdxzmkVHkwGuaoEoj+ktKs2fCP92+kscTwa2rIZCjy1HnzKb3lJ0daurXdJHbiEe7QlzhDn7R1YC2EsNlwmuFzMGZpt5W6spZz1e4aU1bvUGa85gfQg8sAD2fZSqm9paOXrIbQmdrOGwrHiW3N+or4ElJJxE6VqaRpheg2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCRYHjpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DABC4CEE3;
	Tue, 14 Jan 2025 17:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736874730;
	bh=9WG2Vvk6Mj8NyVtPI2yl8c/mPKMYBdtIvdqO0ucUMtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCRYHjpb2jnB5OJCc2E8Vw6aMtOWhySCNqnagDAxVQgaDxlgVn0bW6JBDtECAjpUO
	 dUR9+BuDBV/oDBd2NMfMKM5W/joI9DfvJ7qaQZtv01CTQsDRhZ0zbkmZcaKtMmo9/m
	 xgWp3Z1AbRq14nb6TF+EBQfaRpNgfnO1ArCJsG6mLpCCjP4OB1q+dILmKcR2AuUnC4
	 D8CInZPgBbR60QE+lJCHCg9jI2sCXaUxR+KmBB91PvNm2/HloLrVUlaSf6eZGu3HuS
	 Ttp6mToJKQcT/OUMRBdkdMXZJG36Nxg/uDogv2X76kVTiLo9gjnK5xicbdM6uQhjfp
	 NfXDkl1+9zcmQ==
Date: Tue, 14 Jan 2025 17:12:06 +0000
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
Message-ID: <20250114171206.GL5497@kernel.org>
References: <20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org>

On Tue, Jan 14, 2025 at 06:44:02PM +0200, Roger Quadros wrote:
> When getting the IRQ we use k3_udma_glue_rx_get_irq() which returns
> negative error value on error. So not NULL check is not sufficient
> to deteremine if IRQ is valid. Check that IRQ is greater then zero
> to ensure it is valid.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

