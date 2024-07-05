Return-Path: <netdev+bounces-109513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9F928A62
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41853B21276
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A27167D95;
	Fri,  5 Jul 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YHU1/cS7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191F14A62E;
	Fri,  5 Jul 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188478; cv=none; b=mShjfbtQ1JZHhPu6T6v3e2snTmp+myRI6ARw866VlaivL11rGRsrNsHVNPpVNL66qF+gFwRK1AtsYqZhqlLfZ9B+M5VVT0hSQcL7TlT6rLtVdMSWnkkCyKChjAwt6C5eP6UkHAiKXOoMvi+lRCl3xq+VyEI09zqGb5s0dALLFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188478; c=relaxed/simple;
	bh=Ij5M2aZ2ktOpk9h+NVMs2BRyOCI3noZ8CqMvq2npwBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBkM18JPQg4z051rvR7YwZzOYtU8BHpFPavqcA1yJW6kDw8vptLGVfSw6pDT8nh7hDSKZjEyhjyG21okhioUyIvIEaFWKK+BwEnbvQlcp1dvxQ4CGv+6IWrdZYByHP18nTuawwYRi5iWY645FH6RhP8acXf57F+YuhxDpaHfIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YHU1/cS7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=taPylzcQpWkBHWqRRKC69hZXcOlWW5p+DlQ3iefyu/g=; b=YHU1/cS7IwjFy3qmweZN1V24Oz
	27HpelKFL4U3bHIHSQYa4winpltWhPvs4UZSUmWIfFd9sLb4rmmE8izhhWqN132lG1uueGteHLzs0
	p55TR6T7ULVy2MZDUaZ+u5aAQUxFaadJwN4PGSH5/2f1aKdoyQhwCnLLgPPbk6QXYA44=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sPjb5-001the-Kb; Fri, 05 Jul 2024 16:07:35 +0200
Date: Fri, 5 Jul 2024 16:07:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1] net: stmmac: xgmac: add support for
 HW-accelerated VLAN stripping
Message-ID: <75f006b5-813e-4be9-b528-10cc6f79aa88@lunn.ch>
References: <20240705062808.805071-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705062808.805071-1-0x1207@gmail.com>

On Fri, Jul 05, 2024 at 02:28:08PM +0800, Furong Xu wrote:
> Commit 750011e239a5 ("net: stmmac: Add support for HW-accelerated VLAN
> stripping") introduced MAC level VLAN tag stripping for gmac4 core.
> This patch extend the support to xgmac core.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Please take a look at this email discussion:

https://lore.kernel.org/netdev/20240527093339.30883-1-boon.khai.ng@intel.com/T/

It would be good if you worked with Intel, rather than repeat the same
mistakes they made.

    Andrew

---
pw-bot: cr

