Return-Path: <netdev+bounces-145602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD859D0093
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 20:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA128B22883
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7EE18E361;
	Sat, 16 Nov 2024 19:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zdYYMNir"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA6184;
	Sat, 16 Nov 2024 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731783890; cv=none; b=GJO64aNWJyq8iq1SFm6217vUpOoVn4CNkKDCMyM2qBCN0QDZx3GPuy9uVQCgfWj4vcUvzsdodkz2JCik+4EMvk7y+QIYKhwJ7CB34v5S14AfGKxVHV0siWV2++nxCLwsCEhmb5QyjKkB26KOIQvHQGa0husaL0JwrS1/B9tBuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731783890; c=relaxed/simple;
	bh=lGay5KwpX9eOYcO4i4uTrLWE4bMAIdNWXbcgOfVAJV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6DzE7r9LmQrwItkHWlpHzRvCfRVEhmAiPH5Q3/LQ0rAasEGs97VTztXhUIzd/sr2p/+4U43KUOna/b6huVA5Y1Pj5b3+HGU88Hb2rxr9LH0Pi7+Z4TUoAROZvZwRMhGHNXkr7XUYGTRDBKawJp87sEuRMbpEN8xf3O9Ib25Sn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zdYYMNir; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UswJf2Dkm0aY9UHYIo8swOnK8INhX+9W3eNK1dWGpvM=; b=zdYYMNirogdaJQlvauxeGKzu6I
	315elCXsIU9fLyPF2/AcI7Dvx19V6/wm7T7xF7mTDCnqO5lkoeByA24U8tH8S2u6Hp4pypZqU+RsF
	X0Yy8pvk5ZmoG+VHvK5TiBCh/aFSaI0dTXHH30tIdzqFovcx1/XwS2h3tpCf3m1UNn08=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tCO68-00DXUr-DY; Sat, 16 Nov 2024 20:04:44 +0100
Date: Sat, 16 Nov 2024 20:04:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net v2 4/5] rtase: Corrects error handling of the
 rtase_check_mac_version_valid()
Message-ID: <d850865e-6f78-4366-b94c-d34b56e5df77@lunn.ch>
References: <20241115095429.399029-1-justinlai0215@realtek.com>
 <20241115095429.399029-5-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115095429.399029-5-justinlai0215@realtek.com>

On Fri, Nov 15, 2024 at 05:54:28PM +0800, Justin Lai wrote:
> Corrects error handling of the rtase_check_mac_version_valid().
> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

