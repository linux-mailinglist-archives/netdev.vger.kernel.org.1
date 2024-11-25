Return-Path: <netdev+bounces-147255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7CC9D8BFD
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D692B28474B
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0371B4146;
	Mon, 25 Nov 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nLv0fnS3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30DDEED6;
	Mon, 25 Nov 2024 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558229; cv=none; b=B/2bVZqs3NQviNG9ZgryBBZQkHV6MzlSSKQouUjd+/5+yUd0IzZMn/vvjSrrOJ5tBdDgjhLMkNW7N20G2j7/TJ7QZqCnNxBgawASuGFDkU8td0MY0CraeVb7X3K7qoh5j2wnT1TWch/QjA1Z0r30leO4t6e6lRICh60oTFVfsw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558229; c=relaxed/simple;
	bh=wJ2KOXAGbvj5+BSWG5kc3Hj4oNXJEnFaIClYWDTF3DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBkO1wt0TeX1iMvF9dTKqCfdxAIeVE89py1g5DheUvwWW8IY2LLSa16iOiHuj/QecmLjqERQFUGvoizKvpUsFZ89Eu9beJtItBP0g834QZNcK6SNs+1ppj429EgN1fGmFmHh9CuAyViodZcoQpzXFt+kPyZA7fwTk77hg8I3o24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nLv0fnS3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RjenwW3rN7/Sf1SgRlSuB0fbToLqYiHg0XFzxv88ukY=; b=nLv0fnS3cyW0YAlC7J8yarWZk3
	oNcH+GbJXns04y1qqwCPOEpZFPsLygd1aG+4FhyazcsJSi7fvBPeCo+40G/bhtTMLxRrlEqBALNwg
	o2qJYPNvFXLx6WRtf+JVXxB8Uh0PsTHDLAKzjAqFPHylu7bKOQ1FNi4qqjWtMDIxQrEM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tFdXE-00EPtw-Km; Mon, 25 Nov 2024 19:10:08 +0100
Date: Mon, 25 Nov 2024 19:10:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: zhangheng <zhangheng@kylinos.cn>
Cc: joyce.ooi@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	chris.snook@gmail.com, f.fainelli@gmail.com, horms@kernel.org,
	shannon.nelson@amd.com, jacob.e.keller@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: Use dma_set_mask_and_coherent to set DMA
 mask
Message-ID: <f3a7d89c-43b4-4d5a-ac70-6b14c77b4cd4@lunn.ch>
References: <20241125033446.3290936-1-zhangheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125033446.3290936-1-zhangheng@kylinos.cn>

On Mon, Nov 25, 2024 at 11:34:46AM +0800, zhangheng wrote:
> Many drivers still have two explicit calls of dma_set_mask() and
> dma_set_coherent_mask().
> 
> Let's simplify with dma_set_mask_and_coherent().

Is simplification a sufficient justification?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#clean-up-patches

1.6.6. Clean-up patches

  Netdev discourages patches which perform simple clean-ups, which are
  not in the context of other work. For example:

  Addressing checkpatch.pl warnings

  Addressing Local variable ordering issues

  Conversions to device-managed APIs (devm_ helpers)

  This is because it is felt that the churn that such changes produce
  comes at a greater cost than the value of such clean-ups.

What is the value of this simplification? What is the likelihood you
have actually broken something? The problem with these sorts of
patches is that they are often made blindly without understanding the
code and a small percentage actually break things. As a result,
Maintainers need to look at these patches and spend the time to
actually understand them. I would prefer to spend that time on new
drivers, rather than old code which works and does not really benefit
from simplification.

	Andrew

