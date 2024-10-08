Return-Path: <netdev+bounces-133311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076AD995942
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4F4281773
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9CB213EF4;
	Tue,  8 Oct 2024 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tvorQUtA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477D91C1735;
	Tue,  8 Oct 2024 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728422720; cv=none; b=E/vB1vzPcGTK+QSgDhqWG4BEm3RwQ8zs3SRRyzOn0GY5LU5/xzm9xyKc0j6Ez//GKOIxlx+FRjRGbcZRhNsNSS/XKojKAjaXkxPAnEQqu0k43oYTVlmM4kriscAH9vDfF2XNljeulrdo3+ONTEq/0tKydiko1M72CUl2vIWrWWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728422720; c=relaxed/simple;
	bh=9hkaticDIJGDR7ImjnZrpgWu+EtW+wV3emKScH6zwRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuscssSXgVweANTqVAZf2fCt30Eb6UezjmhrPoxcp1pH9Oa6ciw+tFgBi9Le4h6XQvfVs7SNSIm6t4z7j8gRzIMYfF96+ixVHbhp4eBVQcTBcADKZdwkp6bUPDE3NzfXdH9NE3saaknLy5pBbg6Rtard+1lrLdaVmsjv5IBrMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tvorQUtA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=slkkQWx1KUKvNFOJp/wydjzY24Z5K90HjCQmvodnWkg=; b=tvorQUtAHhAx9wXEaB5up/jto6
	pUiO0sFNwaDgYTs85P2x2lSg+JyHTVB1qkAR+kB9v0q6LHm78VHFUKmZFX7LEL/ASerodTp0XOsW2
	lZEIOG2a0CJE9msgeKljFnoKELUu6Cf9IuDjHXgMWXLe7OJVBRwKJrCAqV9ulvjccoVc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syHhZ-009Ppq-4n; Tue, 08 Oct 2024 23:25:05 +0200
Date: Tue, 8 Oct 2024 23:25:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add FID map cache
Message-ID: <1fd54d40-ccba-428c-b194-1e9cf697ed83@lunn.ch>
References: <20241006212905.3142976-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006212905.3142976-1-aryan.srivastava@alliedtelesis.co.nz>

On Mon, Oct 07, 2024 at 10:29:05AM +1300, Aryan Srivastava wrote:
> Add a cached FID bitmap. This mitigates the need to walk all VTU entries
> to find the next free FID.
> 
> When flushing the VTU (during init), zero the FID bitmap. Use and
> manipulate this bitmap from now on, instead of reading HW for the FID
> map.
> 
> The repeated VTU walks are costly and can take ~40 mins if ~4000 vlans
> are added. Caching the FID map reduces this time to <2 mins.
> 
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

