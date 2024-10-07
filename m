Return-Path: <netdev+bounces-132773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4209931E4
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A0C283710
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB1D1DA0E3;
	Mon,  7 Oct 2024 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fspEXU0c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B21D9586;
	Mon,  7 Oct 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315965; cv=none; b=TrzVxtA8B8bZmzo+T+hTjqQ+LaXE39MvTPKtbMywLiDvIIk/vLSKFE6lHA4KLQ1bYxozIxo2tYuUVvBpA0oIIrB+MBbci5Gd/uFuJI5rMkjCeRgjrME9Rf5zsmU//5LbGIJbit7kUG7o0xNQCOWp5X7IWbJv4uXc/2LvRQuFevk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315965; c=relaxed/simple;
	bh=YF2quWFfUxbOrdhVM7of8Em3TPYeDZiF/j8pa4mXDek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMNo/if3/fufAHH4KjRj8LKA/YX1I+gKTR9QNwdSVJDIyxMY3TyEdQBP9+4z5apaUCwKGSV0Z0b9A8awlEQVPvFLBg15XPHurKW3sjZmLpy/1f/5LkgJcj+Z0f6Ol5tBAsDoD0mOFdRHZltQkDkD7hw2TPa0QIHRNdoXCJUyEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fspEXU0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852ECC4CEC6;
	Mon,  7 Oct 2024 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728315964;
	bh=YF2quWFfUxbOrdhVM7of8Em3TPYeDZiF/j8pa4mXDek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fspEXU0c388pwr2EOSeCw0NAENjD5s0jyPIPf/QqmL8O3E0ZTpQDFkdFOy/xkMSsa
	 JWrT2wIpNqnkP3tdllbHQzoLW/QCKxRYvcki8DYSO4kIWLtMo5awHJZu/r8H6VyVBZ
	 dl1D/7dM8Upv6++EprLBkvD9rI9LAJpnmuukM6Q7G+FdYJs1UnAYLAiwVuEINKEINF
	 ZblExvqFYQWWWTFghbKBJd8jPT1sEcnSEjpdoyMH2IYXaFdHRkhPyWNJbDDgW6dZSt
	 3JSzrIFWUCnARlDmDlxwut+WR9Et5zihcF9bplqsUrNEUVO23qwoAzP3GETwQxB+PL
	 w822gcFLC8YDA==
Date: Mon, 7 Oct 2024 16:46:00 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Lennart Franzen <lennart@lfdomain.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: Fix some error
 handling path in adin1110_read_fifo()
Message-ID: <20241007154600.GH32733@kernel.org>
References: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr>
 <63dbd539-2f94-4b68-ab4e-c49e7b9d2ddd@stanley.mountain>
 <20241004110952.545402d0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004110952.545402d0@kernel.org>

On Fri, Oct 04, 2024 at 11:09:52AM -0700, Jakub Kicinski wrote:
> On Fri, 4 Oct 2024 14:47:22 +0300 Dan Carpenter wrote:
> > It's a pity that deliberately doing a "return ret;" when ret is zero is so
> > common.  Someone explained to me that it was "done deliberately to express that
> > we were propagating the success from frob_whatever()".  No no no!
> 
> FWIW I pitched to Linus that we should have a err_t of some sort for
> int variables which must never be returned with value of 0.
> He wasn't impressed, but I still think it would be useful :)

FWIIW, I think something like that would be quite nice.

