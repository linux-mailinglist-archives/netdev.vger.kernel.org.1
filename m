Return-Path: <netdev+bounces-118881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2695367D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CBD0B2168C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D2C19D891;
	Thu, 15 Aug 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtzfgbKt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026B1AC8BD;
	Thu, 15 Aug 2024 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734106; cv=none; b=TBd3VbNOw0DmRLxGEVp2qW7GrWOkMMvgbXuVrzd67IagQb0iHCzvkhPmC+PIeMg+kZfVUzCjOFo3PeS1g+rZnudyMIe95h9uHBz2OgE5S0kfbHfJbeuIwZRULTu4kYoIoPUhg3M679/LW0OmP9IxGHm+0U47chTPR7uqLBhMdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734106; c=relaxed/simple;
	bh=SIMVmW2qh8ylk9G0lbsLI1DSUFgdGBw/2NoON+Fzt4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgVyqjeIeArZfaxNEktBX8APR4g6CwRYe87t2ml628SAsOaByBAcPEDPvWlKn/isI/KyoyZ6QGbgHRy8CC5Se2Nftj1iXTEPZV5KGZPG3TDVMgAiPhGwR7zySGRqEP9587nb9Y7V+yxGz3HdWkGA7J941yUYBJaprluLea8A1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtzfgbKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D268BC32786;
	Thu, 15 Aug 2024 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723734106;
	bh=SIMVmW2qh8ylk9G0lbsLI1DSUFgdGBw/2NoON+Fzt4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtzfgbKtDyI8Fopf4YmsLqat8qzVoMGKzaCstZUu0jofiSL1UBnCgansBTmGmjD4i
	 TFN67FLxnXbBnEk3qs281EjS+x8Gxue9IbJZXeAESDpi+3+1FfYa4fPlkpb3S0QldA
	 JEBqar1MYdiplUeY0NySXO+sLjZjmCFrlbdAp8fgdDqyLUCsZsJ1rPfJFHOEyLpxF5
	 pB2zObjbB3Pvek0imOB+DOtPJ35y47BtDBTX3cHL8yBjixkQA1OFGSwalv4M7VCb4P
	 4VAqaB0aQSSBjlWa5r1ouYt7aBzN653A2w8Ps6SXdWdYiUG/jpYkzkqvd7B5Pep8P8
	 SxCPDpe4wRcBQ==
Date: Thu, 15 Aug 2024 16:01:41 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>
Subject: Re: [PATCH net-next 2/4] net: xilinx: axienet: Fix dangling
 multicast addresses
Message-ID: <20240815150141.GI632411@kernel.org>
References: <20240812200437.3581990-1-sean.anderson@linux.dev>
 <20240812200437.3581990-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812200437.3581990-3-sean.anderson@linux.dev>

On Mon, Aug 12, 2024 at 04:04:35PM -0400, Sean Anderson wrote:
> If a multicast address is removed but there are still some multicast
> addresses, that address would remain programmed into the frame filter.
> Fix this by explicitly setting the enable bit for each filter.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


