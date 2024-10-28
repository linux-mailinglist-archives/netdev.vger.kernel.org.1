Return-Path: <netdev+bounces-139563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394FF9B3146
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 14:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6AF81F223ED
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FD41DA309;
	Mon, 28 Oct 2024 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XBycRvSK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4F1DA2F6;
	Mon, 28 Oct 2024 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120611; cv=none; b=DOgq/mbq5kRGk9chhSWojE7NwgOl103fX5SzzIyelE7RBxuF4e4vYZ2AncIeDWapjc4PwRLOAmn+/efaZPfW1bzKC0L26yJHzUYx1MIvvWYLVqygkhVvqHQXuEmzMFNdQW6yvs5e4ll2LUCVvqYIIwbZF/H9YkJ3eYLA8ZV8BZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120611; c=relaxed/simple;
	bh=Oqx4YDCER89OMz0rrJpU23LZ5OKfgDPqMarLrdSlksg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsssSAnKwzftrOkF9i/tDOsh2xPZVD76udLvV83/Knqrr7nDBXf7asNh7Lopm7nfZxYvO2u7JozZOY1KExadjTTS9F2vR4+U8qob/r6JblCqBNr55guJJGhf0HljOefOiSos1rt6wOeVe09YaxR6N/5fAzjL0kp8fjDERHuqCag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XBycRvSK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6WJHuzTaZjJDzN3YDvM8wJF+MG1Ybn/TMg5TyTbr7H4=; b=XBycRvSKAm8fGZg24OEPiRE4Ni
	BLhE2plbT8KL8da9F7fiqDXSbySNaBOjrfKuN7OTQlzvTr6GOHt1kVwfLKMCmXfUMAMoWvzGxmU71
	3nCzOkIOhtsgtKTkEn/T+6DnT5JrHoNqanRe5OWHictXCENnoq+8FqJ4RkfutQpSnZOA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5POx-00BRny-TA; Mon, 28 Oct 2024 14:03:19 +0100
Date: Mon, 28 Oct 2024 14:03:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Johan Jonker <jbx6244@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, david.wu@rock-chips.com, andy.yan@rock-chips.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1 1/2] ethernet: arc: fix the device for
 dma_map_single/dma_unmap_single
Message-ID: <86192630-e09f-4392-9aca-9cc7e577107f@lunn.ch>
References: <dcb70a05-2607-47dd-8abd-f6cf1b012c51@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcb70a05-2607-47dd-8abd-f6cf1b012c51@gmail.com>

On Sun, Oct 27, 2024 at 10:41:48AM +0100, Johan Jonker wrote:
> The ndev->dev and pdev->dev aren't the same device, use ndev->dev.parent
> which has dma_mask, ndev->dev.parent is just pdev->dev.
> Or it would cause the following issue:
> 
> [   39.933526] ------------[ cut here ]------------
> [   39.938414] WARNING: CPU: 1 PID: 501 at kernel/dma/mapping.c:149 dma_map_page_attrs+0x90/0x1f8
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

A few process issues:

For a patch set please add a patch 0/X which explains the big picture
of what the patchset does. For a single patch, you don't need one.

Please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

It is not clear which tree you intend these patches to be applied
to. This one looks like it should be to net, but needs a Fixes:
tag. The MDIO patch might be for net-next? 

    Andrew

---
pw-bot: cr



