Return-Path: <netdev+bounces-79513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8759E879A7A
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 18:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95C71C226E8
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4F41384B4;
	Tue, 12 Mar 2024 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRiwiPAF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD51384AC;
	Tue, 12 Mar 2024 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263810; cv=none; b=YoDug9bRdXFWwNZls/4TzWXE5neQ2rhQXUPFEK4FeEar9u41oIzfAoSPI0egLGG8jJ3/SxQDZzHzPt0njrkyCJSmxpAMwmBaa0DnT9yqG4YKHQ/BZfFn/ojwoUYf4443q58+x/niWKFv3t/6hGCAkombx8CW8fpUmkKySRlEUnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263810; c=relaxed/simple;
	bh=aQeZaK+TULHgRWkvv2I+BpJx4y9OlHXVOYa9vHfBBy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvwInpcTYGYlYez6NlcE5Pwi/f8sNGPLyYzfreusnYPC2mQgYgjZmHp4rNEFe8/sri90XbeZtF6qIEIK1hZXWrlaSJBf8rr8NPSpn0eWevU2MlfJCbVsw/FOijLt0PX0wcT4JAnakJ47BaCGC2RmR13kUpe1dkwIemvrWvqp0cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRiwiPAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AA7C43399;
	Tue, 12 Mar 2024 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710263810;
	bh=aQeZaK+TULHgRWkvv2I+BpJx4y9OlHXVOYa9vHfBBy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XRiwiPAFaEGmafJCxxNLa1ivfAv5L1cEU+bXPOJhOxJ2AEqEok7LcfLwCHCcMrMpr
	 3WSX2S1lnp3wGe/W60SopIDVr2IUXu8vIy5fOq5e/9q3PBzuOvPvnKTZ4u8zKJS4VI
	 duhoG9v/4a6lz+AtB3iYSdRTrS9gLUcDeKW7ZGcBlBQnNSqUJxNfr06SWFS49kdu+8
	 nsv4m830llErNUPM5km2Uvegj8tX2xgGD8PnZ0eC6fK1KTzJpbDKdSExtAuHMdPnb8
	 AbPnOffsQXzer7x8Iux1SkXXDod8dhbgN5z1p3ZMw/Kx33PrVJm8mx5wfO1mA8nOT2
	 Sjb4yxMdXOEig==
Date: Tue, 12 Mar 2024 10:16:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Doug Berger <opendmb@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net-next] net: phy: mdio-bcm-unimac: Cast denominator to
 unsigned long to avoid overflow
Message-ID: <20240312101648.14a23b5c@kernel.org>
In-Reply-To: <20240312165358.7712-1-d.dulov@aladdin.ru>
References: <20240312165358.7712-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 19:53:58 +0300 Daniil Dulov wrote:
> The expression priv->clk_freq * 2 can lead to overflow that will cause
> a division by zero. So, let's cast it to unsigned long to avoid it.

## Form letter - net-next-closed

The merge window for v6.9 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after March 25th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

