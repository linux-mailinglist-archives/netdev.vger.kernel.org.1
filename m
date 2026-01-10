Return-Path: <netdev+bounces-248719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 036BBD0DA42
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F0D73015953
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC2F260565;
	Sat, 10 Jan 2026 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vC7ZFFWn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016042050
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768068505; cv=none; b=VPa/bcQqiARv967WWkceQiKBsEpyVRCQZZSY657ElApSsAPBv/A6dFEQe4S3Wf0uH2Pk/QEQ5ikdST1j2xY6e9IItfqf9ryFWEsVeAzTNwL+cF5HEkYfIeE0uVGab7BlfUrITDpjQV1WbR/3QngjqrCp8eu9tdyDHxKf1bsYrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768068505; c=relaxed/simple;
	bh=72iudfIsfbCaQ7EJ07I4gFH6rb9La5ZqrkVfbWojiY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZinjfPg4ibNcwpLTp8FH8EB9fH9C3DLXKs/dASZ8Zc+tenmkc23kwHn6sx2H1tm9+AM2/K9mCk57Xl3mhggptROrw9feoHVTsBNlk2MIqIrUSY/iqjMqvpxo1AZ3oxSYlNmFETmyv+KTyWDoCwgP5z8FiArSnG6uvPzwNb98niA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vC7ZFFWn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tHzBEOgdpbslEAF6TNiUX8MvHeowxiy+4xBuPmiT3mg=; b=vC7ZFFWnFZujOnhhbdKkMitxfA
	8eRTaad8gTbdrmqgbLjwFXrdIqqcNmoDFUDNcIUKZU9Nr8VrU6JBeXnoGCWAIPUulvp/OZDMx1FW/
	UYCHpqCl0pxplnZ6Sf7tVTXs8QpTT45mvIICPn+7BmN4cfXBRM2O8TyI7b5Leoq5uf90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vedNs-002EDq-Fc; Sat, 10 Jan 2026 19:08:20 +0100
Date: Sat, 10 Jan 2026 19:08:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: netdev@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <jv@jvosburgh.net>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RESEND net-next v2 5/5] net: thunderbolt: Allow reading
 link settings
Message-ID: <3b37414b-d0f1-4e65-9248-29987e145eae@lunn.ch>
References: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
 <20260109122606.3586895-6-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109122606.3586895-6-mika.westerberg@linux.intel.com>

On Fri, Jan 09, 2026 at 01:26:06PM +0100, Mika Westerberg wrote:
> From: Ian MacDonald <ian@netstatz.com>
> 
> In order to use Thunderbolt networking as part of bonding device it
> needs to support ->get_link_ksettings() ethtool operation, so that the
> bonding driver can read the link speed and the related attributes. Add
> support for this to the driver.
> 
> Signed-off-by: Ian MacDonald <ian@netstatz.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

