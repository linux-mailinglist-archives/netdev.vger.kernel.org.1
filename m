Return-Path: <netdev+bounces-230215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C42BE5690
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25963AA428
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA6B2DA77D;
	Thu, 16 Oct 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qIQ9P0iO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB84C4409
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646867; cv=none; b=O6wufp7jX0kuYBw2liec6yDu/IulAz8qaqx/UJuBek8Axte773atn7149vdKyU0U+CcgR18IUcWZ/0QnYRLQNWYSsN261+HQco6KtAUKSiq2n9rLIm2vug3IsrMr87M/8ZCw45SC11Cmi/FwUHdIbfAvBaqdMUE3s1qoEKEBnyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646867; c=relaxed/simple;
	bh=n/8Ry0s9H8S7UovT6I83OXCXKF0S7j7o5wNL0ToxR2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lkn+5jy6RSsCeO5az9HRa9vDb2rXnxBplZDpg0vD4sFBWyL2W/bkwq1vyv35mEUA44b7ogWr/j3N5tQN1tobv8sWDCZ8ZxwMgZwZahG+gTxjTtENJNrzGe1ZIj4pkaGEH49KeyFBRCfNO0T30hhoipenB6p29kzxVpNVpKx/QhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qIQ9P0iO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2bWdEOv1Iesl7bcUGDHqYp38jpoD5b4y0oT3Yj1xpA4=; b=qIQ9P0iONwIsXWp1qmOEITVxpY
	CoBLXOoIgqljDtkA0sHwmmcDKp8d9UJ6t6pup7tzx7bOsPLzY0Kmti8iI/UVRYgu8bJ5pLhxz3MdG
	XcnZixRDkfS+n56vfhhx8XdIVy/kBq1C99giPDa+HQdehXSGnErAIwmnRudZBV76K1uY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9Ufv-00BCl8-3V; Thu, 16 Oct 2025 22:34:15 +0200
Date: Thu, 16 Oct 2025 22:34:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v7 5/5] eea: introduce ethtool support
Message-ID: <538c4dd7-5593-4f43-97b0-9e48cec00cb3@lunn.ch>
References: <20251016110617.35767-1-xuanzhuo@linux.alibaba.com>
 <20251016110617.35767-6-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016110617.35767-6-xuanzhuo@linux.alibaba.com>

On Thu, Oct 16, 2025 at 07:06:17PM +0800, Xuan Zhuo wrote:
> Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).
> 
> This commit introduces ethtool support.
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

