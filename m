Return-Path: <netdev+bounces-173911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31452A5C35C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7083ABECD
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191B25B681;
	Tue, 11 Mar 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tW4RHJRG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D425B679;
	Tue, 11 Mar 2025 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702337; cv=none; b=k7YfrDHI4FJWz5X5mkCmJOR8P7Q+OacguAfmCdhXB2ugUOSj5ztZj1x7beEZAUSF+JenpoTIt23Qz5MWU4ie1pK/OEdSRloTlVfobXRIFryOqH3bLw+rRtCPUfdBLyyDvOxwAZkIFwLFdhyRP1KVZI40580R6f/dVh+kSBDkyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702337; c=relaxed/simple;
	bh=w8eR9t+kSNi0wzfPkM+g87zPzeK34aCk0R53MpiDORo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oipbk/2ydicIfqVh6YA7A00uIFgW2mZkIt117dQTwJTbG5RSoiusnu0y/BzgcSUwyY+XqRE1UGMVmW4BIb/vIjkxsi4x6M17Zc4vS4dlvflLaWquBBonVKrGeUfTnscBUBLtzAFgXoXmU8QWsATZAYnO60zwoeDQV4GBAqMJZyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tW4RHJRG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bTVp47p9x6xQNo8f20rVU5kY/vHk3lO23GWi0pFWokg=; b=tW4RHJRGmdMpbWOAq8bq2d78g+
	emyH0KDghYWssmZ9MOCU+RHqbHK+bFRueppF1fj0l/h55BaWQN74sN2NX3CQK6FdRKQvzZ6g55MlT
	89n867iSqWCbLVVks7JxxVLaEdS8Tt/8sC8IbwayaLeX9Mudidvd493m0GImmjI60nVg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ts0Ku-004MOH-Rs; Tue, 11 Mar 2025 15:12:00 +0100
Date: Tue, 11 Mar 2025 15:12:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kees Cook <kees@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: macb: Truncate TX1519CNT for trailing NUL
Message-ID: <64b35f60-2ed4-4ab0-8f4e-0dba042b4d4d@lunn.ch>
References: <20250310222415.work.815-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310222415.work.815-kees@kernel.org>

On Mon, Mar 10, 2025 at 03:24:16PM -0700, Kees Cook wrote:
> GCC 15's -Wunterminated-string-initialization saw that this string was
> being truncated. Adjust the initializer so that the needed final NUL
> character will be present.

This is where we get into the ugliness of the ethtool API for strings.
It is not actually NUL terminated. The code uses memcpy(), see:

https://elixir.bootlin.com/linux/v6.13.6/source/drivers/net/ethernet/cadence/macb_main.c#L3193

The kAPI is that userspace provides a big buffer, and the kernel then
copies these strings into the buffer at 32 byte offsets. There is no
requirement for a NUL between them since they are all 32 bytes long.

	Andrew

