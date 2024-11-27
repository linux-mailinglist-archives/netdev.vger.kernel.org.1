Return-Path: <netdev+bounces-147626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 097D49DAC97
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 18:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B5E281E46
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D3C201019;
	Wed, 27 Nov 2024 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XW0l3LaK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE04200BBA;
	Wed, 27 Nov 2024 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729066; cv=none; b=EMO73vnngIq6gNayOq2+lNj9tx47b/bcGr7fKE7Oo4RxUw+2ICAZOygSrUuDevbMCOqS68ZNObgyWRQ3Gpvz0skYH8285Y8ZDl3w2T8kYII9C7ZsNRSvmFWO/5QYDem5KBib4YwPj88Kg3cCv4cE2LNanEE3siG9eA1M2JlSJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729066; c=relaxed/simple;
	bh=3t0Wty8o3TmEheD0SKwcH6u8OAx0lepMeADNC4O2PZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s20esZaw5TLCsx5inH0d9BQDKlu0Ap3yn7HbXPfvYH0f8JsZ3p0qdieWg7N77PMpnXzZau7+8LVmfETe2EFPhYeBCj9jb7oFGdjnojSw3mTQuNop9waJKqgq3ujgA+l4DV5TB+m/eqLu9iNACFW0X13VkfG/5SvmsiUUjHUtPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XW0l3LaK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Gp03uKbGgj9n4g8SVip9GrkABU7383Qnzar2YQ/Nf3A=; b=XW
	0l3LaKx+mtdHGbaqvtS9reZ2S7yVzM1Ytdg5cjHmvccaM0cQY3JWcPyR6qW6YQrATmvq2WoP7YTA2
	CmCKbv0yORf4GC8AW2ND9/PcXVM0CS8VnZweqFLLMbBKER7hup8C/off703RQOCvjLaZOPZSV2aea
	Vye9KoIJNCyFIVM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tGLyq-00EdWw-Cy; Wed, 27 Nov 2024 18:37:36 +0100
Date: Wed, 27 Nov 2024 18:37:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: netdev <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] PHY: Fix no autoneg corner case
Message-ID: <c57a8f12-744c-4855-bd18-2197a8caf2a2@lunn.ch>
References: <m3plmhhx6d.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3plmhhx6d.fsf@t19.piap.pl>

On Wed, Nov 27, 2024 at 09:56:42AM +0100, Krzysztof Hałasa wrote:
> phydev->autoneg appears to indicate if autonegotiation is enabled or
> not.

Correct.

> Unfortunately it's initially set based on the supported capability
> rather than the actual hw setting.

We need a clear definition of 'initially', and when does it actually
matter.

Initially, things like speed, duplex and set to UNKNOWN. They don't
make any sense until the link is up. phydev->advertise is set to
phydev->supported, so that we advertise all the capabilities of the
PHY. However, at probe, this does not really matter, it is only when
phy_start() is called is the hardware actually configured with what it
should advertise, or even if it should do auto-neg or not.

In the end, this might not matter.

> While in most cases there is no
> difference (i.e., autoneg is supported and on by default), certain
> adapters (e.g. fiber optics) use fixed settings, configured in hardware.

If the hardware is not capable of supporting autoneg, why is autoneg
in phydev->supported? To me, that is the real issue here.

	Andrew

