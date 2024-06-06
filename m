Return-Path: <netdev+bounces-101484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DB68FF0A8
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91D41F24A9D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE4196457;
	Thu,  6 Jun 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udZ46Thb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89E1E880;
	Thu,  6 Jun 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687712; cv=none; b=E91URKEMSukNVfjZPWIf8Kz3HBPToNFn48Mbmd22/dQ7ch5K1uoa2qjMdsa5dvIvJE6tJd497Ovs1nQI3ou0JCD1dFRs8w0oRsKZumUVG+PFwvgBtYSaKs4FV1cvu2Dq5tIJh6zj2h3Be3kzonGQCtjN+pgMBemMuEma9InPX6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687712; c=relaxed/simple;
	bh=y3sWSfcVKzKXwM82BXYfEwhQOQElKVzrlpuOvAbuufw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXMS030TcBO8K6HoKqQE3JpomcC2LHo5ZM88CEIZyTyUAqczeaoriwbg7pyxZKH9jqV1A1DtaIwewNlflnsxeLcDnEcZg6R124Fwm9qjE+Q1+pGwmuv+zvJSDHPwJD8jOQXJ1mIhUzT84jWqCXoeeXX5/gDCHTdTkp9++unYK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udZ46Thb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB9DC2BD10;
	Thu,  6 Jun 2024 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717687711;
	bh=y3sWSfcVKzKXwM82BXYfEwhQOQElKVzrlpuOvAbuufw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=udZ46Thb5WE0MeVGRuLkcnO36E4gxuFkIgmEiESX8Qp6j6+nIZzVbN2xG4kv15Rov
	 oAX6d5DNjOsSFHI9156WEkbFv1ZWMKW79fgbioPlvAEKAc8L1sglHDOOfI7tjiVQvh
	 ANycJw9HUGAJEl/8WECUio3WkIDWDIvYJBdf7lagWEoRfA0A8zr5LE1A45GZKpreyy
	 4bbbaZMQosaZAtmyVXf0LiHKWHlY2iqacEiB3BJK4sBIa0DkW03WLYVxF8P3tOPOGF
	 9WNFtdfM8gNHGiBugTcxt3NffTWlQF9NarlkCWxlSAidjlOPNqtLu/kz7S2EZoiN93
	 HGlEJT2GHIUMg==
Date: Thu, 6 Jun 2024 08:28:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "=?UTF-8?B?Q3PDs2vDoXMsXA==?=" Bence <csokas.bence@prolan.hu>, Russell
 King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Heiner
 Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: sfp: Always call `sfp_sm_mod_remove()` on remove
Message-ID: <20240606082830.30e3a294@kernel.org>
In-Reply-To: <24a48e5a-efb3-4066-af6f-69f4a254b9c3@lunn.ch>
References: <20240605084251.63502-1-csokas.bence@prolan.hu>
	<24a48e5a-efb3-4066-af6f-69f4a254b9c3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Jun 2024 17:21:45 +0200 Andrew Lunn wrote:
> I was expecting Russell to review this. Maybe he missed it.

While it's fresh in your mind - does it look like a fix to you?
=46rom a quick look - we're failing to unregister a device?

