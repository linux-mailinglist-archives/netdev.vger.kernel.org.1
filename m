Return-Path: <netdev+bounces-101218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A28FDC71
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330F1B23658
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AE214AB8;
	Thu,  6 Jun 2024 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qDBkYi4l"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D319D887;
	Thu,  6 Jun 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639236; cv=none; b=WDFyO1UKKcgScr27Ks3k4sRs1VAPJHh2YDfPSDYr9iUXd5NsMgyMRP5yeb4thHJzOMT48cjd7fwDinzU8iP59OQ2Ee7tB2Nhmpj2m+3QjbifvbuKHt3sZcuZfBM/FNghjZDJFS0fVwcqOGaLc1SHIcGQwYczlHbaaRIlkxN5ing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639236; c=relaxed/simple;
	bh=GxwTof/xiEtnERAH/rdJ01OpJnhQp6zYK5BVMtizFsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLodSjSlAAIw5jVKaJ9LHNhgei2P2+wOYwPUrLCBtngaaEjNGbpXSVU9ueQ7CYRB5dXao/bsLKx3oAyYuNtaZPsXj4CPzu925VVrpcnUEUrq2KIC9pN74kgIN1xrm+K3x6ebBWZjgfCd7/s9Z/e2Cfe+4yBkB71LmmpJPgKRs9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qDBkYi4l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Gma+sWQuTLwNrfTWdXyOCOxaFEhdvQVdxotzlBsIOcc=; b=qDBkYi4lOxJYsDszvxZf+rFPY/
	wgLD1OSTyAwVojBndR2P41cRtE+O1uyVNs9PO15an9r2n+nwQwLHLwp3FSZWo/CloX+DqzaPC4Bbg
	taqOywUBQkLqP839ERHhZ1c70FNRREYPorTYcHpU4osWYA52TLnNcQGIWKdcDByyOVpw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sF2QU-00GxyC-Gp; Thu, 06 Jun 2024 04:00:26 +0200
Date: Thu, 6 Jun 2024 04:00:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v3 2/4] net: macb: Enable queue disable
Message-ID: <cb1e50ec-d67e-4fce-9710-5b3380d266a3@lunn.ch>
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
 <20240605102457.4050539-3-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605102457.4050539-3-vineeth.karumanchi@amd.com>

On Wed, Jun 05, 2024 at 03:54:55PM +0530, Vineeth Karumanchi wrote:
> Enable queue disable for Versal devices.
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

