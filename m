Return-Path: <netdev+bounces-117499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 122D494E211
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 17:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C551F2144A
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D1914C59C;
	Sun, 11 Aug 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LUiCZUB5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F014C5A3;
	Sun, 11 Aug 2024 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723391858; cv=none; b=bc5f48ZYC5l9US3Fr5+bJmJ0TaJ8zsbQ0Nh1l3c527IyHR/uhXYBbi/meiqEhcFYO5+sYIam0MXOcDnyoh1ruPBomsMOrBy7/oWMFn0XxkAqzSJ7QB2NQYj0UTJx0PEBeTjBd6cnXisxQfKeIyHaSbwl9UBFZ0pBO55cEWXpbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723391858; c=relaxed/simple;
	bh=xd8+0rGS/IpL5QmyFMHqHRWvXgGXOeeiDJ09x4HaMeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqGBcJKd2xxVVDKmxd6pNQEHtoEwhdBdiHT2gUkjwGWWN0RpV6gnnsLKMGgrCT1er44ZMvtl0w00+2dcjpadKk/eZSINC5UQzMlsGAukhpvvf+1D1N4p9pybTIS7YJWTIdJG4S7/IWxEdmfob6sk3Ei+VJEuR49rPpLxkbuj5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LUiCZUB5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ht2E3EDyxFYS6r2PRNg+jQKLqI5WY8DSnKmLGz2ZhgA=; b=LUiCZUB5XQrkU06AtDpvC9GoIg
	o6fmnptwOWG4LxUKyv9lI0+P2ArpYWW8/NnsFM5dKOzvH4x+H+5BQG0E5lwwgeO5gViIpdJGV1af2
	1Xpm5kH0WWdQJrWb+L5jGgZzTn826eThK1XA5PcGC2RnB5TsMAEbKjgvX6r3TY/qErYY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdAwg-004VX8-IS; Sun, 11 Aug 2024 17:57:26 +0200
Date: Sun, 11 Aug 2024 17:57:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, masahiroy@kernel.org,
	alexanderduyck@fb.com, krzk+dt@kernel.org, robh@kernel.org,
	rdunlap@infradead.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch,
	linux@bigler.io
Subject: Re: [PATCH net-next v5 12/14] net: ethernet: oa_tc6: add helper
 function to enable zero align rx frame
Message-ID: <722fbd26-cb62-4926-9429-ed4f297d0a31@lunn.ch>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-13-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730040906.53779-13-Parthiban.Veerasooran@microchip.com>

On Tue, Jul 30, 2024 at 09:39:04AM +0530, Parthiban Veerasooran wrote:
> Zero align receive frame feature can be enabled to align all receive
> ethernet frames data to start at the beginning of any receive data chunk
> payload with a start word offset (SWO) of zero. Receive frames may begin
> anywhere within the receive data chunk payload when this feature is not
> enabled.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

