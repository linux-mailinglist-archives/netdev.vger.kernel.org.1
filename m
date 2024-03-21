Return-Path: <netdev+bounces-81083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61383885B50
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 16:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A4228357C
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BF28595C;
	Thu, 21 Mar 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYmnoFWl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311955792
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033317; cv=none; b=ebeDtV1QAM2ZAQwG+2z5TyVKEbNoVaD6tCYOoNBhFbQ/rrhpXjd7m0+49yMHjMCBm8zPLwGmtCzpo2yDJK1bwg+0xbZH+7qAdIJNvQIiVZakCdWWfGwZeu9DFRzj99+7Dge8KmVGR8IZW6gTLGutmmTmYrTxxQjYKM0dQOm+ERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033317; c=relaxed/simple;
	bh=Wkn1o0i2kPmxfaGYBiqEVREzYFZcOyRDCO5VJWgwcCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCdNUfTgHeQJQnhbBT0usm3qTRotr89m8Prh5qlyf67NK/UpKiynIB9kMrfl1+DOojE31N4nguJhynEdZjK8r4khkW1QzZsuvdV5oY5Ca87U1oud1J+DIa5kqZpayUb1KFzYZARfrLjDoy9BbS58C+pz+F0U7v4pIM11fJTE3KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYmnoFWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CCAC433F1;
	Thu, 21 Mar 2024 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711033316;
	bh=Wkn1o0i2kPmxfaGYBiqEVREzYFZcOyRDCO5VJWgwcCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZYmnoFWlQHVGOCcyJjdSwxMPe5RdinU+b5k5BIpe39u+7LogQ6is7/dXUsMT72RFp
	 XQBosAjIn5OWZkBnpvg7WbbwkVp59BMnrE9TV+/ZzAQa6oINdqkE9v4mK2xVk/CdfJ
	 14Mc5RdbqHpEMgwZs87/kC9au04mBgfzLENYGTdxMgbeBwlsflth5695rTfu6XvrGI
	 6bRUWPvIJzN30rHBvL0rZ+bQ4+4yZbRAzaBuBvx8h5cx/pDmbxjqs/uABrJzyJlEZM
	 GHJBaP4HOPXYDd8a+tsZVRiJj3UPXBQSQlqUIHqz1/BbdYnxJkwrH+34Hv1IhmMHIW
	 9DngizN/m5Icg==
Date: Thu, 21 Mar 2024 08:01:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH RFC 2/7] net: Add helpers for netdev LEDs
Message-ID: <20240321080155.1352b481@kernel.org>
In-Reply-To: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-2-80a4e6c6293e@lunn.ch>
References: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch>
	<20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-2-80a4e6c6293e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Mar 2024 16:45:15 -0500 Andrew Lunn wrote:
> +	struct device *dev = &ndev->dev;
> +	struct netdev_led *netdev_led;
> +	struct led_classdev *cdev;
> +	u32 index;
> +	int err;
> +
> +	netdev_led = devm_kzalloc(dev, sizeof(*netdev_led), GFP_KERNEL);
> +	if (!netdev_led)
> +		return -ENOMEM;

Are we guaranteed to have a real bus device under ndev->dev ?
I'm not aware of any use of devres in netdev core today.

