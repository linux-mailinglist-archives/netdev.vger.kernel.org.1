Return-Path: <netdev+bounces-191159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6002ABA495
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D3A175B2E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B2D27FD58;
	Fri, 16 May 2025 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC+TjSS/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669927A450;
	Fri, 16 May 2025 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426636; cv=none; b=kP1GtTKckffLi607jgyTm4K0T4c47+1QdiASCRNhipAiyk7xYpNb6YQMtCi0sW1Ao3NfbfhX5BbjmqiOGAcVz4Mqkwygtev6xJo14/T0jWJjCz2ObRdQVZv3IDwo8c+jkCSBI/B3yH9c44rlSFhC/mkR0n5n3j8BIXqWMJdQX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426636; c=relaxed/simple;
	bh=gdghEq68rS4dPfk9w/Dn9+8ctElaEIgaJKGdi8w2LsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEiaoQukLQCTyTDN/WyyqZtagq6YmPerkGp1YNKq6MRzaKzKcpqnzdi2yQRUVhHC1ROAfjVTLutFwx5QCad4xRka36BF3r0COviuG5R9edLLeji7bNd26Vfw54z3L3zP7WwDDd4lXdN+evP/BgOjD+8mSF5g60bc6j+B+gIbUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC+TjSS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9B1C4CEE4;
	Fri, 16 May 2025 20:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747426635;
	bh=gdghEq68rS4dPfk9w/Dn9+8ctElaEIgaJKGdi8w2LsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cC+TjSS/6y17tbIKaZGsUJoPoCD1aU/C16eEMGQPyvJ9FM3znQC7DENjYVkdt70Jh
	 aFOIkPu/qJkm3eWmq1rZ2IciIRicDngFiXU/dDFBxngh3y8GA6Wvms3mKF9TBmdNFZ
	 6Ip4GISVjxFV4aqS7OtJ3OWKMATh3yfxhYQfPgtaJF3bvXCNoXjFNAWo1/jWsdwbOj
	 PKDyYPwhzcuV8TMg9FkaF8jKMQ6Ph4dVqc7AAl881N/gOMY4aLKf74zn5KFQuQnZ5a
	 mlhX1lzFp+/ApepbLqGVDxBdxj0XGVweXkfe4TRVDRA5JOcUHIvUX7elCJNqi29r4C
	 fXGzduw+HA5kg==
Date: Fri, 16 May 2025 21:17:11 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/4] net: airoha: Fix an error handling path in
 airoha_alloc_gdm_port()
Message-ID: <20250516201711.GK3339421@horms.kernel.org>
References: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
 <aCZZyDvp-TZ7AFwS@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCZZyDvp-TZ7AFwS@lore-desk>

On Thu, May 15, 2025 at 11:16:56PM +0200, Lorenzo Bianconi wrote:
> > If register_netdev() fails, the error handling path of the probe will not
> > free the memory allocated by the previous airoha_metadata_dst_alloc() call
> > because port->dev->reg_state will not be NETREG_REGISTERED.
> > 
> > So, an explicit airoha_metadata_dst_free() call is needed in this case to
> > avoid a memory leak.
> > 
> > Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



