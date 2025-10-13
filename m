Return-Path: <netdev+bounces-228691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E14D1BD252D
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CBD188BA66
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA8B2FDC3E;
	Mon, 13 Oct 2025 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6NvnqAC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CDC2FD7D3
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348218; cv=none; b=aM7TUiO2YYPN4aFywQWu2K5tseogeE9Y5JmcVhyRnjJjEwrq/fEmFcH6MjifnFkH7E6KXPaP3ESRthEFUT+C6dBIAGox+uSJkKUJlMTW8+Nn6aEqynMIRrYF8+Th2F6A/y5xZjlY66juTETDXUngqUbw6/DMVTQ7OJ8frlIXfcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348218; c=relaxed/simple;
	bh=Yn7TjBfBuD0cTKnd++PHp7G1b/Ur34AI7puSNAOld80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYeJjuSANxmT8B/Po1oaV4zJ1CEae1ysERdyQR7NSBtF0qMA6q7vEVJ/eVqHyEfhobIMlp3g7xlMwLSIJrkzzPQQk7z8yINj/2MKwb3JecSl7nym3G5P/P+NowUKOYMwHKPmI7nhHZfVYV4CL3oBQS2CHgIpnYaW02Va9r9F09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6NvnqAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E215EC4CEFE;
	Mon, 13 Oct 2025 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348217;
	bh=Yn7TjBfBuD0cTKnd++PHp7G1b/Ur34AI7puSNAOld80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6NvnqACa97Q5EohDysILSyqPs2pPG8bBTEgVxKXb7GRMJFkAK4Tvs2H3jAQMmOxo
	 5QETZF33oLTnRK2QXovE7gy6jQY5BFwrK2v15NpwI1jalM9WXNOAAZrdApBmWga8B/
	 47REY+apf591ZtewkgH4WjoA7hvR/5pzeX1XLXEUKHMDzcjzTmHLz38KNscoednQJq
	 8M7fN5eJCcZKsIY9zrAOeDcepo2hnEI3nCO2PvCbSCXdxToNoE3SyOw3exEuD7mAz/
	 +rZJp0VeQ9avfdO19WODybyFrwk7faBRvxR1lPVbz3TKbjpOx4dg+xduOXvjX93ysz
	 VWTr63UmwYmrA==
Date: Mon, 13 Oct 2025 10:36:53 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: Take into account out-of-order tx
 completions in airoha_dev_xmit()
Message-ID: <aOzINXtv-gu50mJ7@horms.kernel.org>
References: <20251012-airoha-tx-busy-queue-v2-1-a600b08bab2d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012-airoha-tx-busy-queue-v2-1-a600b08bab2d@kernel.org>

On Sun, Oct 12, 2025 at 11:19:44AM +0200, Lorenzo Bianconi wrote:
> Completion napi can free out-of-order tx descriptors if hw QoS is
> enabled and packets with different priority are queued to same DMA ring.
> Take into account possible out-of-order reports checking if the tx queue
> is full using circular buffer head/tail pointer instead of the number of
> queued packets.
> 
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Fix corner case when the queue is full
> - Link to v1: https://lore.kernel.org/r/20251010-airoha-tx-busy-queue-v1-1-9e1af5d06104@kernel.org

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

