Return-Path: <netdev+bounces-200370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61995AE4B2E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D9218878B1
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C845266EE7;
	Mon, 23 Jun 2025 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqJCfrBF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7FA945;
	Mon, 23 Jun 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696373; cv=none; b=s2RphCNNpMBQ4MR3BmZX3mHpNwUK7HZLZVCLCAaWSWu/F71PV0vRatuYNQ3C9cHA/r/qc2MO5Jlg8D6pS1d+mUTUxL+tXekWB2R4UfA11mnZvO4+ZbiKhiShLOF/jtjdMsUkQRyei3gS5QdF0tFATRCf2Na1QQcdT9ygFcXq94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696373; c=relaxed/simple;
	bh=PuxykCZHpaNKdwfuSn59kSIP62jwuhmLwmrYXRre7dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGSXa1OUIsAdOiXIbLYgj6apvmQU8TURbxv0c9dYFkOds2n4tyVqXdt16JCTVc8MJWGoJhmmW1ZJEd2KOVATgCMdIQiMQaZxrKP8ida0uRTKUoCafqbIJF32VysaJ2rxE3gfS6bmjSmdZIiHGEpyQnQkQArGuMmGGQTE6YZmW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqJCfrBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295CBC4CEEA;
	Mon, 23 Jun 2025 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750696372;
	bh=PuxykCZHpaNKdwfuSn59kSIP62jwuhmLwmrYXRre7dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqJCfrBF49v6epYhfa4vppdxC7zhSk2vRAgKm4JmZc4R1UvuqMN3iHGQWZeSawwrb
	 cqUQ03D7FtBd0SJZjAAVDd742kXjU+6X2A/sX5O7OYHMSTlfXn0e0vwgE8GroA8voB
	 Mkp4fQpdYduG99m006R36oFypj21+kZjQdyYGsZaKTDsk06AoQl8eQY6sdqXE+i4WL
	 oJPJqGZu3FANeZ/dp53v886wW1MtGFrAC5gpNvBdnrSL8Qo/HkVXsTvA2Em61yqS1x
	 9wmJ0Of3CbPYAsH9cIBdc5JBurLwLsLZ92LtyFynsVeYnj9eEYs2dF54uh1AGE6DzG
	 x3a5MLdL/8kxw==
Date: Mon, 23 Jun 2025 17:32:48 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net-next 2/3] net: enetc: separate 64-bit counters from
 enetc_port_counters
Message-ID: <20250623163248.GE506049@horms.kernel.org>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
 <20250620102140.2020008-3-wei.fang@nxp.com>
 <20250621103623.GB71935@horms.kernel.org>
 <AM9PR04MB850500D3FC24FE23DEFCEA158879A@AM9PR04MB8505.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB850500D3FC24FE23DEFCEA158879A@AM9PR04MB8505.eurprd04.prod.outlook.com>

On Mon, Jun 23, 2025 at 03:13:16AM +0000, Wei Fang wrote:
> > This patch looks fine to me, as does the following one.
> > However, they multiple sparse warnings relating
> > to endianness handling in the ioread32() version of _enetc_rd_reg64().
> > 
> > I've collected together my thoughts on that in the form of a patch.
> > And I'd appreciate it if we could resolve this one way or another.
> > 
> > From: Simon Horman <horms@kernel.org>
> > Subject: [PATCH RFC net] net: enetc: Correct endianness handling in
> >  _enetc_rd_reg64
> > 
> > enetc_hw.h provides two versions of _enetc_rd_reg64.
> > One which simply calls ioread64() when available.
> > And another that composes the 64-bit result from ioread32() calls.
> > 
> > In the second case the code appears to assume that each ioread32()
> > call returns a little-endian value. The high and the low 32 bit
> > values are then combined to make a 64-bit value which is then
> > converted to host byte order.
> > 
> > However, both the bit shift and the logical or used to combine
> > the two 32-bit values assume that they are operating on host-byte
> > order entities. This seems broken and I assume that the code
> > has only been tested on little endian systems.
> > 
> > Correct this by converting the 32-bit little endian values
> > to host byte order before operating on them.
> > 
> > Also, use little endian types to store these values, to make
> > the logic clearer and is moreover good practice.
> > 
> > Flagged by Sparse
> > 
> > Fixes: 69c663660b06 ("net: enetc: Correct endianness handling in
> > _enetc_rd_reg64")
> 
> I think the fixes tag should be:
> Fixes: 16eb4c85c964 ("enetc: Add ethtool statistics")

Yes, thanks. I did notice that too, but somehow I managed
to post the wrong tag. Oops.

> 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> > I have marked this as RFC as I am unsure that the above is correct.
> > 
> > The version of _enetc_rd_reg64() that is a trivial wrapper around
> > ioread64() assumes that the call to ioread64() returns a host byte order
> > value?
> 
> Yes, ioread64() returns a host endian value, below is the definition
> of ioread64() in include/asm-generic/io.h.
> 
> static inline u64 ioread64(const volatile void __iomem *addr)
> {
> 	return readq(addr);
> }
> 
> static inline u64 readq(const volatile void __iomem *addr)
> {
> 	u64 val;
> 
> 	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> 	__io_br();
> 	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
> 	__io_ar(val);
> 	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
> 	return val;
> }
> 
> And ioread32() is also defined similarly, so ioread32() also returns a
> host endian value.
> 
> static inline u32 ioread32(const volatile void __iomem *addr)
> {
> 	return readl(addr);
> }
> 
> static inline u32 readl(const volatile void __iomem *addr)
> {
> 	u32 val;
> 
> 	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> 	__io_br();
> 	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
> 	__io_ar(val);
> 	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
> 	return val;
> }
> > 
> > If that is the case then is it also the case that the ioread32() calls,
> > in this version of _enetc_rd_reg64() also return host byte order values.
> > And if so, it is probably sufficient for this version to keep using u32
> > as the type for low, high, and tmp.  And simply:
> > 
> > 	return high << 32 | low;
> 
> Yes, this change is enough. BTW, currently, the platforms using ENETC
> are all arm64, so ioread64() is used to read registers. Therefore, it does
> not cause any problems in actual use. However, from the driver's
> perspective, it should indeed be fixed. Thanks very much.

Thanks.

I'll send out an updated patch.

