Return-Path: <netdev+bounces-111255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE3A9306F2
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 20:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799C61F2208E
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4538113D28D;
	Sat, 13 Jul 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wx/Xo1eG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8449225D6;
	Sat, 13 Jul 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720894886; cv=none; b=gyEABnjbGCZUG+Qk733+MpcSXXEc9RqyBqdFIHwkhiFb2Oz70ugs6s9cdd2RU23NTcNNsTLYJMqqkiICwwkR8HMhWOO98j3bqO+4yY8PkCNsZX3nmHrfGAmzVB+/y5g06Y5/S/1d2wg9tWGfxXhzQ0Thk1hNjBclQB7RcmJqCeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720894886; c=relaxed/simple;
	bh=vYEdltbR4U8YAbKwXM7W+6clX5ZwwgQUpXml7t5O/Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsKEa/rZ2E7V4mwxqNlu28WzTNQKkeyypVM1oUBA0kKTEoauHi7w+gdZK3ItU8mLXqougZqb/sk3bQzQ6Lak7nHQR/BGKg/ZFfekktwx+rnuRsGN47EsiOX9TqkCKknBi1NzscdryvcgdK75c+YMln7FVg6QFZqSP2rgoRjBI2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wx/Xo1eG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=m2NaNmLqT/6EHd9wxh3t3AYqOXhEw0WYZ2q3dGsPebU=; b=wx
	/Xo1eGx9B8tv18UvDAYIjryXT7JVjG5qrbnXm6Gk+qdvdf6dzAUX7pxnoq9L6jxQMrkU5zUgTdNTi
	enVeVg6nYwL7Q1hVJnz+zrcdjSkZHArUHcKw+NbV17GFeKPOkJasRxO2MICpZZTlYiZS+DdtaWXXK
	hpFPD5Xxzl7r8NU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sShMt-002TBM-50; Sat, 13 Jul 2024 20:21:11 +0200
Date: Sat, 13 Jul 2024 20:21:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	f.fainelli@gmail.com, kory.maincent@bootlin.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/4] net: phy: bcm54811: Add LRE registers definitions
Message-ID: <0f903235-ebd9-4c1c-b32a-6b79e9a18fa6@lunn.ch>
References: <20240712150709.3134474-1-kamilh@axis.com>
 <20240712150709.3134474-3-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240712150709.3134474-3-kamilh@axis.com>

On Fri, Jul 12, 2024 at 05:07:07PM +0200, Kamil Horák (2N) wrote:
> Add the definitions of LRE registers for Broadcom BCM5481x PHY
> 
> Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

