Return-Path: <netdev+bounces-208617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929FAB0C5AB
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FA44E487B
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4132BE059;
	Mon, 21 Jul 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KQ8zrKMG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7D52D9ED8;
	Mon, 21 Jul 2025 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106291; cv=none; b=MxCwArxpa0SVVDa8Rp0ofwRjMrQi89M6ezaxkF++OaXlip7ZV99XtwWSP3XulIjf6PNOm344wk3mJ8BsoSCRNNm+huCKFri/0t7ccLzJEe81x1IwCFfj7w/5x551DTeZqkANFHG4rD3gIgAvFwFGGeZYwk0Wf233BfRBTP7tfow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106291; c=relaxed/simple;
	bh=2jBz8CylOvELe8ozbV/ez47Z0mO+TqztKtifDy9Hi38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hya9hIZs89GlwfUbZHH8cXnyRmhd1mw9HnGntPiLlK+C1nUuxnsDV8QiTksHE8W4ccG+lz4xa1Xa4JkFpW+8TBs77gF7ty90Gix7HdnVQ8fQNUAm6JfY/uJ75dlKS/+JIl+w6xrug3VBtU2+1Gm4oFSt/Q/GuJkxDWsiWzAYdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KQ8zrKMG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KYlJZVLHfzDqLw2kYuZX6yJqfwg0LropsjetUaQn8F8=; b=KQ8zrKMGpuBlFz+WMEfRMzdEqq
	gUA5lJjzG/cEAND5yIj71yMhJcLzflCoCSBv7OmF/4ZOVgXgeVaYIi8d0N12Nl0KfYVll6WBnxXRQ
	GeP7cmI0KyLGx2zVkcnwWFOrruJw1LcIlqepalTfNAGvKVO/lAXRRW/b3its/+OhmkGw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udr1p-002MYa-PK; Mon, 21 Jul 2025 15:58:05 +0200
Date: Mon, 21 Jul 2025 15:58:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tomasz Duszynski <tduszynski@marvell.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [net PatchV3] Octeontx2-vf: Fix max packet length errors
Message-ID: <316e5fb7-7f45-4564-9354-e50305f6f3fd@lunn.ch>
References: <20250721085815.1720485-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721085815.1720485-1-hkelam@marvell.com>

On Mon, Jul 21, 2025 at 02:28:15PM +0530, Hariprasad Kelam wrote:
> Implement packet length validation before submitting packets to
> the hardware to prevent MAXLEN_ERR. Increment tx_dropped counter
> on failure.

Sorry, i did not look at previous versions of this patch, so i might
be asking a question some other Reviewer already asked.

How expensive is MAXLEN_ERR? What do you need to do when it happens?

I would _guess_ that if ndev->mtu is set correctly, and any change to
it validated, you are going to get very few packets which are too big.

Is it better to introduce this test on the hot path which effects
every single packet, or just deal with MAXLEN_ERR if it ever actually
happens, so leaving the hot path optimised for the common case?

Maybe you could include something about this in the commit message?

	Andrew

