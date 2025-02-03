Return-Path: <netdev+bounces-162253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D4EA26583
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9B918854FA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468EE20FA9E;
	Mon,  3 Feb 2025 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgTjVF/Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB751D5166
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738617921; cv=none; b=DCMv/qZ7SHlh7HpeQTMoCqClHRI+DHXK5IiG1C3yBzhzP5Xg6uD4IZlm+Zumo/J93YJRv4P8kgpX6L8i2uZZ29J3t7DYcBVKCE0TxxsjYQj3BPL2TB3wD3QEu2upsC75ujmSzsTc7RcxkdBMM3dRT4GvUacXQlbxvgJTyxJl1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738617921; c=relaxed/simple;
	bh=B0mp+Zb7khdj3li84klT/6rafRnZnhW/ZTDJrQ+53mc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+zTd1SI2R0xl9DJT9u5QoHf8w5UsZ+sBRGJ6vBmGQ/c/2WfE4GawIYIuxUCtGqWd19JNSjF5j3x8l+BkcDeLZKwHyx8gXJatkM5EKB8iGvtE20+4LO/UH1ON2OseS4nhWhn342WRBr4oEgg4/iDScswPc+BGSDA30+kEJecitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgTjVF/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AED7C4CED2;
	Mon,  3 Feb 2025 21:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738617920;
	bh=B0mp+Zb7khdj3li84klT/6rafRnZnhW/ZTDJrQ+53mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RgTjVF/YstXv+I1J1JZuetVxZ6ZnYjcsD9LBPCRwOoXv6VO6qOI8UC0lWgeiDT8nN
	 hWcZG/eZ0/xkZ2B0E2i7/eCoZurfWstI1prZdv6S0Q6mP8cnjvTEuvIZLILx8ruwjA
	 AZEjciPp3gufIiKiBWYxVoT2coTgx3dGUCkEglE6ZNFcmdiJ+9WvUl0EqFN17C3Vrr
	 ZmttnSaMEpiScxwbHaxIaKnWbDrm5Z5pL1V6qb4z3QBgvIGxBzf1g+jhlxAa3sZiSq
	 tZSIOscsBvDcEL+wFd86BwyJ4DHW7KlmTIXlXkmF25+aeJ473pw+WNWyPBBBbv3OhM
	 9ljupB7wu6a8A==
Date: Mon, 3 Feb 2025 13:25:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, ecree.xilinx@gmail.com, gal@nvidia.com,
 przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net 2/4] ethtool: ntuple: fix rss + ring_cookie check
Message-ID: <20250203132519.67f97123@kernel.org>
In-Reply-To: <Z6EyPtp4rrCYSCTb@LQ3V64L9R2>
References: <20250201013040.725123-1-kuba@kernel.org>
	<20250201013040.725123-3-kuba@kernel.org>
	<Z6EyPtp4rrCYSCTb@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Feb 2025 13:16:46 -0800 Joe Damato wrote:
> On Fri, Jan 31, 2025 at 05:30:38PM -0800, Jakub Kicinski wrote:
> > The info.flow_type is for RXFH commands, ntuple flow_type is inside
> > the flow spec. The check currently does nothing, as info.flow_type
> > is 0 for ETHTOOL_SRXCLSRLINS.  
> 
> Agree with Gal; I think ethtool's stack allocated ethtool_rxnfc
> could result in some garbage value being passed in for
> info.flow_type.

I admit I haven't dug into the user space side, but in the kernel
my reading is that the entire struct ethtool_rxnfc, which includes
_both_ flow_type fields gets copied in. IOW struct ethtool_rxnfc
has two flow_type fields, one directly in the struct and one inside 
the fs member.

