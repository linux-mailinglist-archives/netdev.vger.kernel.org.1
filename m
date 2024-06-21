Return-Path: <netdev+bounces-105747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659AC912952
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B7E280F6A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727D24EB51;
	Fri, 21 Jun 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RkImYVMW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586412C697;
	Fri, 21 Jun 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983240; cv=none; b=CoT3GL/+MSPXcz3K/AR/9B1M4F0Qvv0C1p30lF41vLFhQevfDyqd3Chk3YqnH4KQjMXT0Rj/L38mnAECnFmhmjAr8yM1HTvz9rzlq4lNmWcdY+IEp+zzIBc8oSQoDJTS6n5/wjegaW3z/xPzMxD+yRM1CZ1igy78Um+m0zlu9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983240; c=relaxed/simple;
	bh=J+pmRh594N2ZDH0OhN6RJjJZNLlXPj4I3k5v+SRt1zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBE3k1xjuJTENGRciEvZAXtTG8P43UckklbX8llrTBl0rQdOnwyFmUdazLp035jwl6lGECqGZeI/rod/jMZokreWboH5UOM4rCF0NdNpr1ut/Nk68j11pZXDaGakhetz3RxBxU8yLnhBLWw/TdFR6uDe5S2aijx0hvzAPDqtdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RkImYVMW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1rN6ZtuZ5WiYgM8LdZtjJXv4iNlUIE3YjUW4O8w3ias=; b=RkImYVMW0MqdSdKN1Vaf402F4p
	RxZPvDc2tmKVj+XeuspgLNAU2CLSd2MW+IrKN2TWrrxkvV9uRyi1SGUWR1ahrci0UMhlTEUqc5+u+
	3SDJP/EJzlUmIUmDCJFcCfXaAF1GrQJnZi4HdHjGe1r/35ZJB5qxGFT2yovc8nf/b6E8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKg3d-000gGX-89; Fri, 21 Jun 2024 17:20:09 +0200
Date: Fri, 21 Jun 2024 17:20:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: WangYuli <wangyuli@uniontech.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	Wang Zhimin <wangzhimin1179@phytium.com.cn>,
	Li Wencheng <liwencheng@phytium.com.cn>,
	Chen Baozi <chenbaozi@phytium.com.cn>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>
Subject: Re: [PATCH] net: stmmac: Add a barrier to make sure all access
 coherent
Message-ID: <3f36c1c1-b561-49a7-82a7-a0aaef60cf83@lunn.ch>
References: <F19E93E071D95714+20240621101836.167600-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F19E93E071D95714+20240621101836.167600-1-wangyuli@uniontech.com>

On Fri, Jun 21, 2024 at 06:18:36PM +0800, WangYuli wrote:
> Add a memory barrier to sync TX descriptor to avoid data error.
> Besides, increase the ring buffer size to avoid buffer overflow.

This sounds to do two things. Two patches please, each with a good
commit message.

> Signed-off-by: Wang Zhimin <wangzhimin1179@phytium.com.cn>
> Signed-off-by: Li Wencheng <liwencheng@phytium.com.cn>
> Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
> Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Five developers for a 25 line patch? Should some of these be
Suggested-by:, Tested-by: Reported-by:?

    Andrew

---
pw-bot: cr

