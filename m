Return-Path: <netdev+bounces-77190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0191870806
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 18:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B05E28365F
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095805FDD3;
	Mon,  4 Mar 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivjnDocQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D54653C
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572148; cv=none; b=h7gYMBUdMS1+AQj4jpYxLSud5K4j+fZPunppkl48YmXPoTNa9A8WKAi/YXCdcXoOxTzDJT/jF1qbubo78UyssuIGswLMN0T3I4fmNhvu9FShK+7Ac21/UFOXMGzyLANa95NObYXK0pVXiGfxNywDHMlb37y57IWzWVQi8sbpNQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572148; c=relaxed/simple;
	bh=ClItT5vb/yODv+yWZtG/KgqYdi2+ztGpxnU+r+3SFEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEpaAmGuNY1ITByBT6CGSV2sKHa/x8jYh/F01PVm9mXxPUSbOlex8CnK7+3w3qvDJs+2umxYAiJEhHK2i3W+3TGapQF8lEnwbou5hD6QIZSDGbAcH5LI5ZvBkeLgX+XL+Y90qUUKOte+h9zQqXCOBbqWBpvAT46Ri44sspBjxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivjnDocQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49E6C433F1;
	Mon,  4 Mar 2024 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709572148;
	bh=ClItT5vb/yODv+yWZtG/KgqYdi2+ztGpxnU+r+3SFEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivjnDocQbaEGgMueGK1QG6FeNr5lq/8y4vt+2GtWY3QlHr52EGIovOV5GUeR59DsF
	 1/lhfmnaJpfimdtpQT7ICY2lbOklDEX5cEMKODobH2OL6cAPJXLn3eHlm0uuXt+nzi
	 es4b8rAqN+P6xfh8Sbl3u0EtYBKhry33/shqOopCRlyB6Tj6pluquM3EcdrHmLLwJu
	 roit+FDlDoxKsw1sLan+xxrqks8fBw+5hluO+2EeVflujsrujciKWzdnyXzd6K7BZN
	 HK6XSEA7nEnWx0WPTQFefPPLqTp/OxSTIKKLoqQE17snh7U7TR3Y2Jc0TO8GBmRlxs
	 VfxBRAXaN/g6w==
Date: Mon, 4 Mar 2024 17:09:04 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next] tcp: align tcp_sock_write_rx group
Message-ID: <20240304170904.GK403078@kernel.org>
References: <20240301171945.2958176-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301171945.2958176-1-edumazet@google.com>

On Fri, Mar 01, 2024 at 05:19:45PM +0000, Eric Dumazet wrote:
> Stephen Rothwell and kernel test robot reported that some arches
> (parisc, hexagon) and/or compilers would not like blamed commit.
> 
> Lets make sure tcp_sock_write_rx group does not start with a hole.
> 
> While we are at it, correct tcp_sock_write_tx CACHELINE_ASSERT_GROUP_SIZE()
> since after the blamed commit, we went to 105 bytes.
> 
> Fixes: 99123622050f ("tcp: remove some holes in struct tcp_sock")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/netdev/20240301121108.5d39e4f9@canb.auug.org.au/
> Closes: https://lore.kernel.org/oe-kbuild-all/202403011451.csPYOS3C-lkp@intel.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

...

