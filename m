Return-Path: <netdev+bounces-217802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DA8B39DC7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4F93A9DB8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B17B30EF7B;
	Thu, 28 Aug 2025 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QsCM4JPK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B572DCF50;
	Thu, 28 Aug 2025 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385509; cv=none; b=BjxYjgUuDF6OO1LUBvX9SU25LuUfzLInC6iLmBNGGevuGnab7RKqj3gSokVl3SoWFM4ljUrKmvGeO4wnHHIxz/b6DcNKhi+lYUR5U258k79vg1351XThyV9ljbFwG0zhlemFH2bfHWJTtSGYlOs1IIBG8goLMGva8n5mg00bfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385509; c=relaxed/simple;
	bh=9418zqZYZtxnCCORrvWR/yr9hAQKIu+EwWQNz8tJrIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfM7MnNQcZjPcwNYToFIvtpnkh8t5JrRkg4uvt5GzYkIlYuyCejnFxuqqi4HAhQWkLtNJMuNEjQoZSf53hunOtTCHXpMaOE5yi0NWgHEErrztvBBBjbvroSYQEmr6NrkJFe4S3E2P4pGoBZOxX+dzWZpIQbY8ZY+q4ge3ZgAlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QsCM4JPK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vp7UH176j0vvYVH0MZv0RPu1C2f1mlKvujNwk3Icvfs=; b=QsCM4JPKzKMcsGr5BD54w7gbew
	+SkbgfJhxW7+ugmm/EVg6i/YM12BP3pwFIv3u+NsAannmCxnRWSGqzji9iyCY9N2BPvV86HwbxBx5
	pLsN/b3yoUnUUp+ljlAzTR6qT+1OtvxyCgQux4lEWWBOjy3he9gFmAJQqGM1kUiZQswM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urc5r-006LkO-5j; Thu, 28 Aug 2025 14:51:07 +0200
Date: Thu, 28 Aug 2025 14:51:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v9 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <dcfb395d-1582-4531-98e4-8e80add5dea9@lunn.ch>
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-2-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828025547.568563-2-dong100@mucse.com>

On Thu, Aug 28, 2025 at 10:55:43AM +0800, Dong Yibo wrote:
> Add build options and doc for mucse.
> Initialize pci device access for MUCSE devices.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

