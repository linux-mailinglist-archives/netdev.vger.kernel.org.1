Return-Path: <netdev+bounces-212572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB53B2145E
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E2D7B67D0
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ACC2E2DD8;
	Mon, 11 Aug 2025 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O9mIWlwv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C672E2850;
	Mon, 11 Aug 2025 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936356; cv=none; b=n6fII7iJzLPrR2YyA/hl4OJnt+bqqzqmp5aow8/nSLUA4yOWGYqyc2iiJPXuyWgRLfEmK4KXvJzp+jBFyYSQLap0qTi/DDDRFLERu8hY53/OEOrrxCy3UP4yYJk7ZrEkFFrNOh8u6Yj7n0KFxOqNNzqtXQihMZ/CeclP/az3krQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936356; c=relaxed/simple;
	bh=yhGz5QJMT4RWRAoalMIv5uae+oGOe9+iL/i/1ogbUPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAbksTaKPcyFgYG0xsXgRRWQEYeU2Qhyltv5qX8gmLNuCKrM1CeqV1Dl9XdrxzT0PlUSRCtUCCuE7ENNodw8KPuDbi36H22DzEf3JH+hL/QcC2yS5sFCOvaZimeCVOZ+UOIRV49xV6LgP99mEBxExHWw99IURikk5sBQ5Fi+GgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O9mIWlwv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FTHeRDCf0MufhutsoRkYMPbicO7ENdCVoH9V4nXKIzs=; b=O9mIWlwvmPXcDpG8iEhGl0IhE8
	DnHwM2rD13xgDQ/TxHn2DVmqT8B9NRwbptSZOkxCzvCxNyzCcxAUxHgCacwWRCYTMJWfbl2+y7XN5
	HoQ/SMegbFft4d8WIgtFKzPS1ovTg7FdlGoUg0f0+N7yLgmlM9tcjU+MIF8yOqByb62U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ulX6l-004MMV-3v; Mon, 11 Aug 2025 20:18:55 +0200
Date: Mon, 11 Aug 2025 20:18:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3 net] net: ethernet: oa_tc6: Handle failure of
 spi_setup
Message-ID: <babfa50d-5acc-4402-8dca-983fe8933577@lunn.ch>
References: <20250811154858.8207-1-wahrenst@gmx.net>
 <20250811154858.8207-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811154858.8207-2-wahrenst@gmx.net>

On Mon, Aug 11, 2025 at 05:48:56PM +0200, Stefan Wahren wrote:
> There is no guarantee that spi_setup succeed, so properly handle
> the error case.
> 
> Fixes: aa58bec064ab ("net: ethernet: oa_tc6: implement register write operation")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

