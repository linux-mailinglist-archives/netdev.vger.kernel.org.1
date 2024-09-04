Return-Path: <netdev+bounces-125203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A096C3F1
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6CA1F26B8F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A171DFE15;
	Wed,  4 Sep 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtCKcSeK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0C1DCB09;
	Wed,  4 Sep 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466817; cv=none; b=FhlW4xRrDJfn5BtHPlBCHCUkD3DYs0w9ZqBJQzPoYb+2JvBNTYoQkxBGfaWqZbSxtlTJVV+9AmWBAFBmKvtpV9NePYKE4LrmtkxC6vho2U8HoDkjZiiPaYq2QRQVfbJfS0GYWdBhXykwUzUj7wS3biqa+Cq9HAL4uaSA+Rf2Lto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466817; c=relaxed/simple;
	bh=nGf+pNjQ5puzOey9IMvvQdemMH3jjfu3wqPtUcje0cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDNFALQ2LlalsVDMRz/7T0a6wa6nXUGsl2b2LVSV5+TbPZSOM9Y6RIRNFrmaozQd8wzKrc+yG8EKoe8mZc6vYbIFt4e54CBgLTnRyhMsgnIya4lH2YACjhLClXs4jIpLpoqnohlBTw8WZPw6MUBZOuJ6JGpxO3CuPbyL8PMuChM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtCKcSeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B488AC4CEC2;
	Wed,  4 Sep 2024 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725466817;
	bh=nGf+pNjQ5puzOey9IMvvQdemMH3jjfu3wqPtUcje0cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtCKcSeKlQtKNVk4VhNNp05B8uCuoeXp+S1+bQCl35z8SEanl7bgmXoS5N7J2xjo2
	 hnSxeo99482Aycyi+cY3YAZkZO2qU2HPb5soygKqvdk3Z9+xj29TV8Cq9kgcnEOw65
	 3ATLGAJFRPBSVuWwEbpk70VY0bDyxb+1/rI9SY0fuabB0uki8fpA3nsj9H0qn20Sji
	 QxRYMswI+sI9izDntI9zA/3pmj/y9mBkh0mY7+pKyojj8JDKCuCbBcJYW2dnuMe9Uh
	 NlB5MG6hDA3+5LM69oy2LvFQfxz6pMazMBvaezL93V+SCoGb2t7HQSQNhu+8Romn5K
	 oJjDUP3vHPRwQ==
Date: Wed, 4 Sep 2024 17:20:13 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net: xilinx: axienet: Enable NETIF_F_HW_CSUM for
 partial tx checksumming
Message-ID: <20240904162013.GZ4792@kernel.org>
References: <20240903184334.4150843-1-sean.anderson@linux.dev>
 <20240903184334.4150843-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903184334.4150843-3-sean.anderson@linux.dev>

On Tue, Sep 03, 2024 at 02:43:33PM -0400, Sean Anderson wrote:
> Partial tx chechsumming is completely generic and does not depend on the
> L3/L4 protocol. Signal this to the net subsystem by enabling the
> more-generic offload feature (instead of restricting ourselves to
> TCP/UDP over IPv4 checksumming only like is necessary with full
> checksumming).
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


