Return-Path: <netdev+bounces-116666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB9E94B559
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0801C20E8A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB4328A0;
	Thu,  8 Aug 2024 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfox24/U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DDA1119A;
	Thu,  8 Aug 2024 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086595; cv=none; b=TAErWGvpcVToInkkeZ+DaUDzy3TXRDlgk9XLaYV+pqndCzWEXQSnIlXQ7gc8nZJAXm5AQXLXNMfzJwBxJyHm01vM1kuWrBORHCVvn660ik7a6LYA4bdNg8e+/htYUEXfQ0Q7TKuMn825gzXKrWopykNvh2j2g/VKo0gQwJ8DfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086595; c=relaxed/simple;
	bh=JRdcuOHRDqsTG0zDnpn/gEpfCPaC7incYxMvey+kaic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYDBo59td3Ykiunl5eOHKdHa9P3baEnIB1ncmXlabU9ltBSV7bvT9XG4o+VhSwobZ2db3a3CR3LhMknOeG6ZkVzLYSGb1y2ggfuMSuS4dnqigsj9dwjY0sisgrpvYn3uo9enyIDHE0+oBsptb46ooKhSLCs7rj7Z/4ewx91oejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfox24/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD03DC32781;
	Thu,  8 Aug 2024 03:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723086595;
	bh=JRdcuOHRDqsTG0zDnpn/gEpfCPaC7incYxMvey+kaic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sfox24/USzMvEXEQEq2EvKyu3ivzbE7K8LGAdBA+IfASu1uKlgLNUiYu9NQEy4sds
	 CMgKKRQHEfyIQxuLB3YalK42BQBWIc8hqxBU5Xhuv42TijCSyn1I5ORUv4QH0LoztW
	 Fn8Lx52WESlfE0otdgjpJFP0MfB1HvVt6cbDfYuILoNmTxwTAWJEAol0byq8GYGEK0
	 wXXX3NiXGGgIDhtx/u6gzFLhGrUwouH3FgA5ukmHeQTjtpIwEhc2BEu6eaAFZTaNaU
	 lyPvOSYOsvjst2rCW4k590Llqq9BISgL64yNbGja28bHp2q4seAZBcQmsxGNu97RWW
	 +A6oEU9DCga2w==
Date: Wed, 7 Aug 2024 20:09:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 5/5] net: phy: vitesse: repair vsc73xx
 autonegotiation
Message-ID: <20240807200954.43a8db19@kernel.org>
In-Reply-To: <20240805211031.1689134-6-paweldembicki@gmail.com>
References: <20240805211031.1689134-1-paweldembicki@gmail.com>
	<20240805211031.1689134-6-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 23:10:31 +0200 Pawel Dembicki wrote:
> When the vsc73xx mdio bus work properly, the generic autonegotiation
> configuration works well.
> 
> Vsc73xx have auto MDI-X disabled by default in forced mode. This commit
> enables it.

This feels a bit like net-next material.
Never worked, so it's more new feature than a fix.

