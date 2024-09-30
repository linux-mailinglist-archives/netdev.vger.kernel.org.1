Return-Path: <netdev+bounces-130617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94EA98AE9E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03932815F6
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9477199E88;
	Mon, 30 Sep 2024 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x3BrvkIQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88A21373;
	Mon, 30 Sep 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729024; cv=none; b=lQHrwvEDsudHHct8m3GRVzeRORkOY8AE68R3rlSutVmkM9+MgCc5V0iz3u19NO7lFr2/4uochjDUlz5g2cJnfrJUsnMD+JUautXa7xeg0mB85eUCPkpSmxeUlFbMOThsQBE7beNHj2aWjR34TGO+H0FVcr97RrWho98JoQpD6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729024; c=relaxed/simple;
	bh=m1NKT9rfTLtbq+qUHjaMc3wUiAWVis02jasgPz1qbJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv4klMr23SUr9PVyXyN8Ee9QpmPss7FVtQ8BrLSyJo3KaMCwoU8FK8eSMN7u4PwmKsDZ+hodgnSlr1UBgrF3RDXJSJTlue9JA/NSp1MZwbftKR/j+D76Os+acUxBeY41uprRw0wPW9cHs2QXiNvSX0OP34foEb5PE+Cj2i21GYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x3BrvkIQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mjnkcoGgZ1wB89nJXHNXT+OHc282Sc+vl+fysKr9BfM=; b=x3BrvkIQmNk/QNNWddroRBboe8
	andhVdZXI+NCOtPNgcqYRY63EpSjM32i5ax6dx39fOjwSGHhz2aofSfxT/QhS/TmRHTb+wW2cvxlN
	MtKrcTyYPgk8SjUKYxV6EcQFUyXtlklPSOAa/k4DViXFHt8D1zudm1hnHS9j2zmSruXk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svNF2-008fHq-9b; Mon, 30 Sep 2024 22:43:36 +0200
Date: Mon, 30 Sep 2024 22:43:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: mv643xx: fix wrong devm_clk_get usage
Message-ID: <42965b99-5395-4a83-a782-6a79ade0396a@lunn.ch>
References: <20240930202951.297737-1-rosenp@gmail.com>
 <20240930202951.297737-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930202951.297737-3-rosenp@gmail.com>

On Mon, Sep 30, 2024 at 01:29:51PM -0700, Rosen Penev wrote:
> This clock should be optional. In addition, PTR_ERR can be -EPROBE_DEFER
> in which case it should return.
> 
> devm_clk_get_optional_enabled also allows removing explicit clock enable
> and disable calls.

mv643xx_eth was one of the early drivers to get converted to common
clock framework, and then devm. Some of the niceties of _optional, and
_enable did not exist back then. So the logic may seem a bit odd
nowadays.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

