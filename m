Return-Path: <netdev+bounces-127849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E5976DF4
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394B71C23C19
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9819F1B9B3E;
	Thu, 12 Sep 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tU6FOm+E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701D21B984E;
	Thu, 12 Sep 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155559; cv=none; b=WEDDXBpkPNcW1T0vF+VNgF0VJN78zXL4cht/k+ZJUDJVvI62cnyWaBnuQmn1/x3JjLQlMb2t5QsVeYsTUXg0CUUAikrWVU52iR6b4J+vqbZCNg6lj4UKchfTUO51K15cqrVyjfiuL0rB48VBoKUMjfYb55NT8/rKLIl0c5wFzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155559; c=relaxed/simple;
	bh=PsbP6YmUG40fnhWdGtrZKl7z1KBrwr8/1/qnLtehBvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uI45ji3ce2lpa/xBFQS0RGfSrg61Pz0leJOku39M2PvpBfrG3v70rnZ3JSnciAuXLGIId+4PBwJEQaFrFNThosxb15uQyU75WcF5e5CDVXjspQx3F7nsrSBr2RPdlpDVFrMw8KYDdMYgVNYYIRZY05h3Y5QENvsmyULNzPdUa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tU6FOm+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D59C4CEC3;
	Thu, 12 Sep 2024 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726155558;
	bh=PsbP6YmUG40fnhWdGtrZKl7z1KBrwr8/1/qnLtehBvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tU6FOm+E2UPgzTBO+hPEN0MmR61pBecN9uxcn9dW2BCy7Ye5D2HVdvmet/hdO03gK
	 xd3apWcCZNXHrlnMvA9vw0RMS5nZ7bPofqk20OFENcYhO4cQhssZD5WoyxvElnnFZp
	 F8JpDjZ4LZXdDfqnqatLPmVr4bEpqLTYPO4bSvTiXjlgrapwyx4/Dlb/On7EU4d2VX
	 Kmb8c/xhld7Iyjb0WEyWeHyKvYfIB5FmSet9B4aWu8vhOxa1qsz8gWe6FMqjt3ZeWU
	 4EfkpgaTwtPFZVubrxoZco78iZ2M5rf6Eav7lob1/eMM6j3kVrUze46g0ilumRUbVD
	 0NmIMieBI0qHg==
Date: Thu, 12 Sep 2024 16:39:13 +0100
From: Simon Horman <horms@kernel.org>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Tan Khai Wen <khai.wen.tan@intel.com>
Subject: Re: [PATCH net 1/1] net: stmmac: Fix zero-division error when
 disabling tc cbs
Message-ID: <20240912153913.GO572255@kernel.org>
References: <20240912015541.363600-1-khai.wen.tan@linux.intel.com>
 <20240912153730.GN572255@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912153730.GN572255@kernel.org>

On Thu, Sep 12, 2024 at 04:37:30PM +0100, Simon Horman wrote:
> On Thu, Sep 12, 2024 at 09:55:41AM +0800, KhaiWenTan wrote:
> > The commit b8c43360f6e4 ("net: stmmac: No need to calculate speed divider
> > when offload is disabled") allows the "port_transmit_rate_kbps" to be
> > set to a value of 0, which is then passed to the "div_s64" function when
> > tc-cbs is disabled. This leads to a zero-division error.
> > 
> > When tc-cbs is disabled, the idleslope, sendslope, and credit values the
> > credit values are not required to be configured. Therefore, adding a return
> > statement after setting the txQ mode to DCB when tc-cbs is disabled would
> > prevent a zero-division error.
> > 
> > Fixes: b8c43360f6e4 ("net: stmmac: No need to calculate speed divider when offload is disabled")
> > Cc: <stable@vger.kernel.org>
> > Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> > Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> > Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>

...

One more thing, if you do post an updated patch, please
be sure to wait until 24h after the original patch was posted.

https://docs.kernel.org/process/maintainer-netdev.html

