Return-Path: <netdev+bounces-233771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 111E3C18191
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27503A63B6
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56E2E9EAE;
	Wed, 29 Oct 2025 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YyoAlZeZ"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13422D8771;
	Wed, 29 Oct 2025 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706275; cv=none; b=Raclevhfsd0FbXzuftJcpYjEZnpE+xAGGsb6uBDeopV75g9jMCXyWzdaKaPq2Mo3a8P8iPmHHgFYeopK6rFDQF0AM5eRA3t/5R+W4neUyDRZ6VPyd3qP+XJBmbcJJ8DdnoHYpGyCGqIfNA1iapJ7qI/m9lFcFeRjJlQR3hWLrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706275; c=relaxed/simple;
	bh=W9VoCT4gQBCMLqQaUXPnZORlOcgCbfiASlcaHQdclFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoebTC+prNoKOOB2VMzi1PXW3zycfomgbhHAa+CqVfnm31SYyYL3jD0rLf3KePfNhmf+Obg2QbmVaMO5Tm51JGXMlg3qzdKSjHWyDJKBLkGR2VwZWvZur5WKdkKgoRPqTXkXhWuJoN2zN/kMInM5tFdBuQe0Xtm/lX+Fqortmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YyoAlZeZ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4CA2925BEE;
	Wed, 29 Oct 2025 03:51:10 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id clOHwhEflVSb; Wed, 29 Oct 2025 03:51:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761706269; bh=W9VoCT4gQBCMLqQaUXPnZORlOcgCbfiASlcaHQdclFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YyoAlZeZm5c21EOABCq3ODJ1Iod3fPlMv5bzMYxcTOU+Y48qwdWYDc+ZL5IhshSuT
	 vE3u2jENFI7jbeh0QqmFqa7lt7svL84Vr8DHa4J/HF4AWME4RNlc0Sryn1g7Z9LNyU
	 WyX5X3hDFKbdDJQ8HC00Hry90gKdx0bf+QH+XsNMW0ARCYqEXYRrblbm4o4d6YJy8B
	 a62ZyPJG0O0t+EqcBfw8276QZQeqs60qIHv/VSBpx4UlfWp7YRsjo6iVuReTc9safK
	 XNXRUec+aarsC80YiYA+krgMJTJAC2Oki1JriJmzLSw4g0xEbSFmXRX9HeTP+bMcEX
	 gI1ckP8k6lqUw==
Date: Wed, 29 Oct 2025 02:50:50 +0000
From: Yao Zi <ziyao@disroot.org>
To: Yanteng Si <si.yanteng@linux.dev>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: stmmac: Add generic suspend/resume
 helper for PCI-based controllers
Message-ID: <aQGA8b5Il-U2IlJi@pie>
References: <20251028154332.59118-1-ziyao@disroot.org>
 <20251028154332.59118-2-ziyao@disroot.org>
 <aQDoZaET4D64KfQA@shell.armlinux.org.uk>
 <91de05f5-3475-45eb-bbf7-162365186297@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91de05f5-3475-45eb-bbf7-162365186297@linux.dev>

On Wed, Oct 29, 2025 at 10:27:18AM +0800, Yanteng Si wrote:
> 
> 在 2025/10/28 下午11:59, Russell King (Oracle) 写道:
> > On Tue, Oct 28, 2025 at 03:43:30PM +0000, Yao Zi wrote:
> > > Most glue driver for PCI-based DWMAC controllers utilize similar
> > > platform suspend/resume routines. Add a generic implementation to reduce
> > > duplicated code.
> > > 
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > ---
> > >   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
> > >   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++++++++
> > I would prefer not to make stmmac_main.c even larger by including bus
> > specific helpers there. We already have stmmac_pltfm.c for those which
> > use struct platform_device. The logical name would be stmmac_pci.c, but
> > that's already taken by a driver.
> > 
> > One way around that would be to rename stmmac_pci.c to dwmac-pci.c
> > (glue drivers tend to be named dwmac-foo.c) and then re-use
> > stmmac_pci.c for PCI-related stuff in the same way that stmmac_pltfm.c
> > is used.
> > 
> > Another idea would be stmmac_libpci.c.
> 
> I also don't want stmmac_main.c to grow larger, and I prefer
> 
> stmmac_libpci.c instead.

Okay, then I'll separate the code into stmmac_libpci.c instead. This
also avoids moving code around, making it easier to track git log in the
future.

> Another approach - maybe we can
> 
> keep these helper functions in stmmac_pci.c and just declare
> 
> them as extern where needed?

stmmac_pci.c is a standalone DWMAC glue driver, none of its symbols are
for external usage. I don't think it's appropriate to put these helpers
in the driver. Furthermore, this will also require PCI-based glues
making use of these helpers to depend on an unrelated driver,
introducing unnecessary code size, which doesn't sound like a good idea
to me.

I'd still like to introduce stmmac_libpci.c for these helpers.

> Thanks,
> 
> Yanteng
> 
> > 

Best regards,
Yao Zi

