Return-Path: <netdev+bounces-200788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D779AE6E89
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E563A6B7E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9C82D5C92;
	Tue, 24 Jun 2025 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+qYUGA+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C27230278;
	Tue, 24 Jun 2025 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789371; cv=none; b=L74e+Q5ETJLmG+boOLvf8f7pOtLDL+/ve9I74y3HjiwvSC6c9RDrt82J6LJSDxMtwUoWFkYXiJNJ9vm9BSXSZerQUuxUXIeNivxIiFl4GnNuPZZ923/OAIX1C5s86pT1ec2UWf2kG9R/25aR2flhughGb5C5wTCS/SA/0XTaGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789371; c=relaxed/simple;
	bh=eVWpEXHQdav4ChERly61RSkZyJPHAcKHpR3tWIvmyJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4hHN0JkkSsFGR3Y62F8DiOuYl4xi3qBEO7oOr5V5tVawCMfENpIMgAylN9cArhECObW+/FmTG+wwVmgdEoOPKujIouwQa1ypeVpByg7ntT+Q/f8iC/HtPwS9jojM506yZItbn/NtowE8unNL5oKJEjY8ywfJFuS+okvEsegmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+qYUGA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91F6C4CEE3;
	Tue, 24 Jun 2025 18:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750789371;
	bh=eVWpEXHQdav4ChERly61RSkZyJPHAcKHpR3tWIvmyJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+qYUGA+RCcSWopIngwIzzdzocS0VGCHqRj6lkrho+t9ecqBLtJfI9ZsW0gO2tNpO
	 bMF0ixOFtV6rqvek2DMq9nY9zX3BZUJ4XGXptMZFBOC8AHyu7ecrSqP1IwvCJtvBVX
	 gP6N/HX6N/8yDj4Y7LGZGwz+fdPOu+Kfi9IUBw5QQ6CMikjkP0aUn0E2JCVOp2iFpT
	 Uuegj895syteu2D+4XtvvNhp6cPEQEjEPpIMsTxstjJD1KaO8roNjLUtXgQrYwqMzL
	 ObWmYImH/a4ubeSC7gy20CdVTOs890eBImb7YnLYMJeF9/fP/usHWeH56XjxDuHVMU
	 BpaIEfBQ3OYIA==
Date: Tue, 24 Jun 2025 19:22:46 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] ethernet: atl1: Add missing DMA mapping error
 checks
Message-ID: <20250624182246.GB1562@horms.kernel.org>
References: <20250623092047.71769-1-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623092047.71769-1-fourier.thomas@gmail.com>

On Mon, Jun 23, 2025 at 11:20:41AM +0200, Thomas Fourier wrote:
> The `dma_map_XXX()` functions can fail and must be checked using
> `dma_mapping_error()`.  This patch adds proper error handling for all
> DMA mapping calls.
> 
> In `atl1_alloc_rx_buffers()`, if DMA mapping fails, the buffer is
> deallocated and marked accordingly.
> 
> In `atl1_tx_map()`, previously mapped buffers are unmapped and the
> packet is dropped on failure.
> 
> Fixes: f3cc28c79760 ("Add Attansic L1 ethernet driver.")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


