Return-Path: <netdev+bounces-81095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B28885C59
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 16:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F30B1C21158
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3C38626B;
	Thu, 21 Mar 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvhRJMMA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C586263
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035803; cv=none; b=lLQlMkAnnOBN/IiP4tOrnk+f2rhMRkS4KXTcToTVPTQIpbQLJMyXTnvbb9sPSfl/wKvU2OcPVG3BpG4tLd1Na2TjBl3Ba8AP51Rj9QKEBhiBzfGyELUB6o7v5u0LAa7T0rsisaHL9PuvBDHCGNxIGoFL1V6C/dK+K6WmR3993Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035803; c=relaxed/simple;
	bh=jiJ9eqOcJAa3SAwgLp5xqGOvCh4FDcyQBoW4hn4b9do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5p8XchVWqY9Uo6YAtqtPSvyJ7goVmT4ZkRrgPxUyIBpiBlZFnCqdvqrY9ATjbwW8bLapTq49n00a24QpPh8EwzwIASY0JCypNeuFjOd54BHxMbIisyt0pgznS4nM/QO2myWOY4c6p0fqpdYXz+Ednfu/Ac/8RS5koq6WW2aRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvhRJMMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35E2C43390;
	Thu, 21 Mar 2024 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711035803;
	bh=jiJ9eqOcJAa3SAwgLp5xqGOvCh4FDcyQBoW4hn4b9do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jvhRJMMANX/6pI0KiatEfaeV8m7Ci4ZGyEwA2P636pt9z54JejdGNDQJa3eywcKwc
	 1hQrxkValTC/v4Lv+uekxznfQ3LrzgAuy7aETLROecjj3c9VO/RdL5fqu1X5ma/8Vx
	 kRb/tfuV/3JrpPcIZu2m5Yv40v8HAZG5ASrh/aGuPjGtPHhZOtuxF17rLn8gZnMM2J
	 Z5WVYYz8x4rQf2+F9ojcV9MXmfZ1c+rNn10a1Ds4nilZA7GDYyIgXZZtvfDJpzvGJT
	 LwhDo0Ef3dLZp2HZB579hqUHpE7pmcL7DvoNw4iqAp4aJvENjnUEleRH2r8TjYKDhw
	 7UggjI8XIgOoQ==
Date: Thu, 21 Mar 2024 08:43:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH RFC 2/7] net: Add helpers for netdev LEDs
Message-ID: <20240321084321.10cb669c@kernel.org>
In-Reply-To: <18007239-f555-4225-b184-46baed8b89ee@lunn.ch>
References: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch>
	<20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-2-80a4e6c6293e@lunn.ch>
	<20240321080155.1352b481@kernel.org>
	<18007239-f555-4225-b184-46baed8b89ee@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 16:35:20 +0100 Andrew Lunn wrote:
> The struct device is actually part of struct net_device. It is not a
> pointer to a bus device. We have register_netdevice() ->
> netdev_register_kobject() -> device_initialize(). So the struct device
> in struct net_device to registered to the driver core.
> 
> unregister_netdevice_many_notify() -> netdev_unregister_kobject() ->
> device_del() -> devres_release_all().

Ah, I thought it's only triggered on bus remove. I guess it must be
triggered on both.

