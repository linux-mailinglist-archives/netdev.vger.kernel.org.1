Return-Path: <netdev+bounces-92823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FF28B902D
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 21:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00B5B2169A
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 19:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B752A16132E;
	Wed,  1 May 2024 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rWqhFCCY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428616089A
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714592788; cv=none; b=QOAO3D3gSYcrZXnJq9amrKtS3sQxEdnOepBkXCMjQyUwkXDw2EaWdiDlpW3AloEM7u4IwgxNivOky5MSfzOOAl4vANPJPPkb2vFzWyHE7BW11UgMXCw0/wXIFg9T1j16tmRNfYKb8VnFsClqd6TvMbbfj7b/Kle7oBjNhxVjU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714592788; c=relaxed/simple;
	bh=ZIBI5kLefG9bWEKpMznNdRzHVOSHnHUzgAF/AnU1pAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLiVDxAdUnwQXxL4AbbPOY5HJxfKIkcZ6Jl2THLRWc5S3kbwQUamM7QNXUrCTX3KXMNvqshz/9qSy1K0ell6GPA34ewRHs7axSYIaBqvgiEl8ZesMPp67d44/XMEyB5BeeRlRDw7Fjg7beaogfELqWU8lnTmDIagfLDk4hw1X2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rWqhFCCY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=stEYPycKhAlVuQd6Ln1cWGI2smQMHj2v3fXhsIbRrYg=; b=rWqhFCCYAMU4ngC+s0qIVu5o9s
	jlKVQ15BTGg02uRI3PloKEBhNM5/waTnRSqAc9f0ANyKhJiTgOkYud96a6ztWpT13B6Wn4MrQ0gcG
	9B8sHfElp7hdiWowS5fN9RD2hblVxD3lVLFfbLVKMrc1cYsnTN5SGDhhI5D8ER7mXEdY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s2FuB-00ERuR-1U; Wed, 01 May 2024 21:46:15 +0200
Date: Wed, 1 May 2024 21:46:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] octeontx2-pf: Treat truncation of IRQ name as
 an error
Message-ID: <e2578f7a-7020-4ae4-94d7-69e828a523d5@lunn.ch>
References: <20240501-octeon2-pf-irq_name-truncation-v1-1-5fbd7f9bb305@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501-octeon2-pf-irq_name-truncation-v1-1-5fbd7f9bb305@kernel.org>

On Wed, May 01, 2024 at 07:27:09PM +0100, Simon Horman wrote:
> According to GCC, the constriction of irq_name in otx2_open()
> may, theoretically, be truncated.
> 
> This patch takes the approach of treating such a situation as an error
> which it detects by making use of the return value of snprintf, which is
> the total number of bytes, including the trailing '\0', that would have
> been written.
> +		name_len = snprintf(irq_name, NAME_SIZE, "%s-rxtx-%d",
> +				    pf->netdev->name, qidx);
> +		if (name_len >= NAME_SIZE) {

You say name_len includes the trailing \0. So you should be able to
get NAME_SIZE bytes into an NAME_SIZE length array? So i think this
can be >, not >= ?

     Andrew

