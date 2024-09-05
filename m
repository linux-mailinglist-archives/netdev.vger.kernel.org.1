Return-Path: <netdev+bounces-125712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A92B896E50A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 23:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AC81F2493B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708DD1A76AF;
	Thu,  5 Sep 2024 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DRM5altY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0294DE56E;
	Thu,  5 Sep 2024 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571636; cv=none; b=u/YRg5WLPYi2EE5tCuKAsXslbXnFnoN1CNVGry9yaGO7niOyrkdObiXTsjzer0T7hvpBVeiLqfKJMMoU9djdbNyhezEF6btlPYF9kVGBan5Y8e+41rH7wyaHRr+orUOXKnqbbQzdsi3YNhGhh23Vji5tqktIgAmrOwJYkhXJFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571636; c=relaxed/simple;
	bh=2yJYk80olJikI9RhXfxl7UJju/OvIf7+jGER5phR23I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIe44i7dp/CO8FIh2QHodh6RyQeIduAXOfZT1p0/Q9c7TrV1JowfHM0KkHqKx3oONishmdOdZnTVDZaTutIl3C6TL+veerjr1PeMzaEnv8R/xfbgrz/2TExQXg2c3Dqz3+NpR3z2Pm12sGpmJBeuk/GLssD0a2WGz9LkpEkNapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DRM5altY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1IDJyE3CoweG7L6Ur1m4xmZTumLGUNUIGp48IZ4Ot8I=; b=DRM5altYDwJlIlS0GArfDSNkN8
	rIkFonwT8cko2r2qn+9pfSfXGPTLTxjC48JBqMiS0UZF2wpMGgbU9vitpNvnAjI1sG6bxCk6+3iJs
	5fOK5gFweLcxFlhz/Xk9g2XSLbk2X+ukb+NSHLBqnM/D5TtMZUrHgKqWj7hxM2v3l6aw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smK0S-006iwW-RE; Thu, 05 Sep 2024 23:27:08 +0200
Date: Thu, 5 Sep 2024 23:27:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCHv3 net-next 9/9] net: ibm: emac: get rid of wol_irq
Message-ID: <15728806-c4cf-4e66-928e-b1dc7b487419@lunn.ch>
References: <20240905201506.12679-1-rosenp@gmail.com>
 <20240905201506.12679-10-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905201506.12679-10-rosenp@gmail.com>

On Thu, Sep 05, 2024 at 01:15:06PM -0700, Rosen Penev wrote:
> This is completely unused.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Seems reasonable, since there does not appear to be any WoL
support.

However, it might be possible to wire it up? You might then need the
interrupt? This patch could then be reverted if it is actually needed.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

