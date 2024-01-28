Return-Path: <netdev+bounces-66548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E1183FB1C
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 00:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEB7282242
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 23:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA045943;
	Sun, 28 Jan 2024 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vBXq/YUy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E23446C7
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706486269; cv=none; b=fRV+uos7vxSWeVyNt8cmkv8NTwdKKMFekfU9/tNTARpxEWAFi/TQWHCX3SX+Wt2c1y/wkrfZqkKGPxy0LhPM9BmoXKcl8B8VEq9U8Q93ZR4E17xLR3ImhlztdtP2unbog0Yd7Ml4KEW+BXlKBTTWFAemTrmb/bvPZtH7+xgrei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706486269; c=relaxed/simple;
	bh=GgfTdAi3orc+MhB0WklFiJQ1Zkz93gqp3bh+41F7vmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPv9wj/IJ13y1o61Vp+uUfWQSJZgcgmaZEkrI6voYFDLN+SWw0QRLUUIyUTiYpW8TrKHlyVAy6E9IxFilu6G6r8hWjEF1MaUyNPLbvxFP5gdHMJ2ib5bMLWbGIuNMYYNOm4/hHeFW8WXLsizurfJHh29FuEqks51zc5qzS8q32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vBXq/YUy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SZrQ8M4xYRf5tnOyatWPbvmA7pvaaiL/5prcPHJ3gYk=; b=vBXq/YUySTzKjOEh+DufFa4CIx
	cCXD9RDqcBgKi5jd89s+5U53gQLBJOi0NtnQY+HDLISm+JXoriFlQsanfsXzEnzC5rxK8f6AtDfUT
	xmUSMAha3ElaymrezeVMnVB8wRVoZmZKysiuo8GwAV9YM2vwa7Der1VwFA7NDzqQ7zUI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUF1u-006Kkq-Up; Mon, 29 Jan 2024 00:57:38 +0100
Date: Mon, 29 Jan 2024 00:57:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/6] ethtool: switch back from ethtool_keee
 to ethtool_eee for ioctl
Message-ID: <cf1fcc0d-d749-4474-a659-6ae11510ffd3@lunn.ch>
References: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
 <23d684d4-7e3a-4b3f-8b73-11d954b1a375@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d684d4-7e3a-4b3f-8b73-11d954b1a375@gmail.com>

On Sat, Jan 27, 2024 at 02:26:06PM +0100, Heiner Kallweit wrote:
> In order to later extend struct ethtool_keee, we have to decouple it
> from the userspace format represented by struct ethtool_eee.
> Therefore switch back to struct ethtool_eee, representing the userspace
> format, and add conversion between ethtool_eee and ethtool_keee.
> Struct ethtool_keee will be changed in follow-up patches, therefore
> don't do a *keee = *eee here.
> Member cmd isn't copied, because it's not used, and we'll remove
> it in the next patch of this series. In addition omit setting cmd
> to ETHTOOL_GEEE in the ioctl response, userspace ethtool isn't
> interested in it.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

