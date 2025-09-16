Return-Path: <netdev+bounces-223673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5FDB59EFA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8B01C004BD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C981F2F5A1D;
	Tue, 16 Sep 2025 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jmm2Uq2/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A9223328;
	Tue, 16 Sep 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042752; cv=none; b=CJp6vUVqDWijMGX7uxf1XvLtCKPj+MUHesKno5dG+j+wV3PXo7Tu3pEhWjdghz4R71Qm2+nZex0okLwk6uUkytuqjj57PtJmSjEJ1e6Nl/Uv3WcVGy2p32SxfnidOZKtS8d7aD+WKN4O4nRFPRxep7Y4wyHAQDtdKQ+FUKAN7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042752; c=relaxed/simple;
	bh=fnlfDfZtqmIVuZ//O0Nfi0Qv7CGmZdGdonyO+3DVtb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKZMQpQZpeYUY7mYuU4V4pn1gQKeoK5eswl7Di7aMSMEeITvdlsYdNGCfRbqb/6E7prmQmJI45K0G+R+cIsjmYy272YUljMj6n2hLIOBs9+4MQVTpGsoAznunO34BTy/07/l/5pBzh9Lcss/9Y/L4p+aWlWFsa/GCg0dq0Xq1pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Jmm2Uq2/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ut9M6RTqc8zU7KLrbNDazxHB0nUVfwBz9xjKDDYCBuE=; b=Jmm2Uq2/7P0YLvgtCyEdJptVCL
	9Q6rT0g5/3sR2hygk9F2DTxvPRz5NeDTjdIiCNKzj9H/gTd3+8sHMRk445UEaae2xGhaF0UtivBri
	KLjJoGHYkBjyingS+jF8sulQo7KA0N6c4P1P5qOFztnExJ8n4VCB2ZVJucYVjYzlJtv0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyZE6-008asu-CW; Tue, 16 Sep 2025 19:12:22 +0200
Date: Tue, 16 Sep 2025 19:12:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: Konrad Leszczynski <konrad.leszczynski@intel.com>, davem@davemloft.net,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
	sebastian.basierski@intel.com
Subject: Re: [PATCH net v4 1/2] net: stmmac: replace memcpy with ethtool_puts
 in ethtool
Message-ID: <8cc527bc-41cd-48ae-a40a-05c69b2c4ac3@lunn.ch>
References: <20250916120932.217547-1-konrad.leszczynski@intel.com>
 <20250916120932.217547-2-konrad.leszczynski@intel.com>
 <20250916164530.GM224143@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916164530.GM224143@horms.kernel.org>

On Tue, Sep 16, 2025 at 05:45:30PM +0100, Simon Horman wrote:
> On Tue, Sep 16, 2025 at 02:09:31PM +0200, Konrad Leszczynski wrote:
> > Fix kernel exception by replacing memcpy with ethtool_puts when used with
> > safety feature strings in ethtool logic.
> > 
> > [  +0.000023] BUG: KASAN: global-out-of-bounds in stmmac_get_strings+0x17d/0x520 [stmmac]
> > [  +0.000115] Read of size 32 at addr ffffffffc0cfab20 by task ethtool/2571
> > 
> > [  +0.000005] Call Trace:
> > [  +0.000004]  <TASK>
> > [  +0.000003]  dump_stack_lvl+0x6c/0x90
> > [  +0.000016]  print_report+0xce/0x610
> > [  +0.000011]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
> > [  +0.000108]  ? kasan_addr_to_slab+0xd/0xa0
> > [  +0.000008]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
> > [  +0.000101]  kasan_report+0xd4/0x110
> > [  +0.000010]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
> > [  +0.000102]  kasan_check_range+0x3a/0x1c0
> > [  +0.000010]  __asan_memcpy+0x24/0x70
> > [  +0.000008]  stmmac_get_strings+0x17d/0x520 [stmmac]
> > 
> > Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> > Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> > Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
> 
> As per my comment on v3 (sorry, I missed that you had already posted v4):
> 
> I think it would be good to explain why using memcpy() is a problem here.
> 
> I looked and it seems to me that one reason is that the strings may be
> too long.

I actually think the strings are too short. But i could be wrong.

In general, stmmac uses:

struct stmmac_stats {
        char stat_string[ETH_GSTRING_LEN] __nonstring;
        int sizeof_stat;
        int stat_offset;
};

so the string is guaranteed to be long enough. However, these 'safety'
features make use of

struct dwmac5_error_desc {
        bool valid;
        const char *desc;
        const char *detailed_desc;
};

where desc can be any length, ironically making
dwmac5_safety_feat_dump() unsafe. This is why i asked that this be
changed to be the same stmmac_stats, so [ETH_GSTRING_LEN]
__nonstring. But that seems to of fallen on deaf ears.

	Andrew

