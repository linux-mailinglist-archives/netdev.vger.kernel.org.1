Return-Path: <netdev+bounces-178307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B9A767E0
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DEB3A5AA4
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412311E231F;
	Mon, 31 Mar 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mF7uknFw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AD211A0D;
	Mon, 31 Mar 2025 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431415; cv=none; b=VJCaJlfb4oVDbT6mmiFHm5+T5u/vZhI5uJbAlwmrjEaaa0jVWp8l5gbsZrYtEdd4DMX+U03N7teQ9mPo4RBcLdFJx9pUZIazd3MsfEJZPJRiQau8v4UiSAEJJDZwNGjo9BpTv8UFKZnqQEfVbI5awp1QMOUDkYXzZwll1FOqe8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431415; c=relaxed/simple;
	bh=D29w7RaQcGFnVgpKwS2JqLdCApkCYd4nC1z1uMeWXeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mzrh5xcjB7BAuNHsXOtLMEsKHZBax/fxSg8IX7lCMO17/eUPjjCL434KAPOriVnd1CbAvOUYg1WVPYHnzMy7OdZQO2OaS5AKuoh4juEE2wwtwuvLZW1ryaEjVySG/1At+dHHN/fojHMpJke3jQYcn2Lc3/t3/TiW9bfVDYBmZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mF7uknFw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VFIvp5VniFRkYy5hkXsYY1LBxwev4K/a9oaC6jauFow=; b=mF7uknFwslSgNDplU7qtD4tjzz
	4ZbCxwXsInxKsRRYh3jjHFhaBRmV8rLkSexH5I6S3f4gNUGNcK7yzKVZZdp4KkV/szFUQzQohce//
	0A4vbN0w1lpDuN4OaFcahrXq4z+XcbRRcrYckhusHpTBDexqA/RabOa97nrElIz6Jdrc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tzG9H-007aKX-Kb; Mon, 31 Mar 2025 16:29:59 +0200
Date: Mon, 31 Mar 2025 16:29:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jacek Kowalski <jacek@jacekk.info>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: add option not to verify NVM
 checksum
Message-ID: <978d1158-c419-4a59-b0dd-ad5be9869991@lunn.ch>
References: <c0435964-44ad-4b03-b246-6db909e419df@jacekk.info>
 <9ad46cc5-0d49-8f51-52ff-05eb7691ef61@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad46cc5-0d49-8f51-52ff-05eb7691ef61@intel.com>

> From a technical perspective, your patch looks correct. However, if the
> checksum validation is skipped, there is no way to distinguish between the
> simple checksum error described above, and actual NVM corruption, which may
> result in loss of functionality and undefined behavior. This means, that if
> there is any functional issue with the network adapter on a given system,
> while checksum validation was suspended by the user, we will not be able to
> offer support

We have a similar issue with SFP, which contain a checksum. But a few
vendors are lazy, they set a serial number and don't recalculate the
checksum.

We handle this by adding quirks. We know which vendors/products have
FUBAR checksums, and allow them to be used when the checksum is
FUBAR. You could do something similar here, add a list of vendors with
known FUBAR checksums and allow them to be used, but taint the kernel,
and print a warming that the device is unsupported because the vendor
messed up the CRC.

	Andrew

