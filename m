Return-Path: <netdev+bounces-146380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B73D9D32F4
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 05:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78EB3B22867
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 04:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20FF6026A;
	Wed, 20 Nov 2024 04:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LDURYvZ9"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F32E3FE;
	Wed, 20 Nov 2024 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732077807; cv=none; b=iwK0RhgdQOaoh6krsgNBm8jn7ox1GRW49Jwh0heGw995qxbucOE+BYponv2w7q+qPzxzgraPk9v23G+FJ86/4sbjFg6v2B5UUZehcBXVpDZmn2HAaC27Q7nHzxcGrCQGk5uvUcEzWIGf5jFntD79cxu7xNkpr0XhGLaPXGw2LJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732077807; c=relaxed/simple;
	bh=22Pb0xyAbFBgiBPWl6KARML2Z6bek2t466sfMUumy1I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H0zJj5BhdH5N1AenGQscQzI8Qt/J0PH299GegPEmJcuFyxdIP8cFyIAZdXTCkBxAWWxxw3WDf6G6sdDRpibnGjxaR9t10mIbKp7tZrD1C1vIb5OveGErLX0kUSYVRi7kSM/PeZvZWowxsXiv0ppj4zV62WoHQoUrN6dg1o1Kr1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LDURYvZ9; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1732077797;
	bh=22Pb0xyAbFBgiBPWl6KARML2Z6bek2t466sfMUumy1I=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=LDURYvZ9kRvVIXv7xCSSyCxOM5f3lAAm1Q4B/2z3fwKU4kB2xIPyNVb1VgLSOpML1
	 D3RrL9Rp3w6bFh05vQRMeclYwfWjWSzKc4xvEw+Vc0ZDX8gdnlK7jaqSpOBvTFnrBW
	 GH5BRw9Eh/CG7U4rpzFRlzEu4lVSBQgZjjlxwgjONXKXNZu82oiHQ3xvU400zrTHBk
	 KGZj2FIcwA2AYSrcP1AeUm3KMIh8GRLcUhA6t6p/7oD4xMmCh5xzj/F9FZbMNxLC7I
	 tkIl4ekrG0ai4V/jKlANbGJtp+Cj7Mh+miwIpfnMCwPq6ed12BqiCvH7++7H3YgiiE
	 5+Bl7XNiRKjoQ==
Received: from [192.168.68.112] (ppp118-210-181-13.adl-adc-lon-bras34.tpg.internode.on.net [118.210.181.13])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 398DA66403;
	Wed, 20 Nov 2024 12:43:12 +0800 (AWST)
Message-ID: <d28177c9152408d77840992f2b76efe3cb675b7a.camel@codeconstruct.com.au>
Subject: Re: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire
 control
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jacky Chou <jacky_chou@aspeedtech.com>, andrew@lunn.ch, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, joel@jms.id.au, 
	f.fainelli@gmail.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 20 Nov 2024 15:13:11 +1030
In-Reply-To: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
References: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-19 at 17:51 +0800, Jacky Chou wrote:
> When the command bus is sometimes busy, it may cause the command is
> not
> arrived to MDIO controller immediately. On software, the driver
> issues a
> write command to the command bus does not wait for command complete
> and
> it returned back to code immediately. But a read command will wait
> for
> the data back, once a read command was back indicates the previous
> write
> command had arrived to controller.
> Add a dummy read to ensure triggering mdio controller before starting
> polling the status of mdio controller to avoid polling unexpected
> timeout.

Why use the explicit dummy read rather than adjust the poll interval or
duration? I still don't think that's been adequately explained given
the hardware-clear of the fire bit on completion, which is what we're
polling for.

Andrew

