Return-Path: <netdev+bounces-213885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D37B27409
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9185916FA42
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F40F9CB;
	Fri, 15 Aug 2025 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhezOpL1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7714191;
	Fri, 15 Aug 2025 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218087; cv=none; b=ge4kL0a//QHL/wYcT6gRY4JeUVsMchL3n07fawa6oBihWmsBkGg0EID8xGcE5ypH0UTq6NCsZmfJBqzO6B1zTZSIgYvIOmJM++9bASiClyYFxbj6nSdVnFsoARpRQ4ShFrAp+egWzaoVAlcL2B7gvmOJukJKQCmM5rjuQaONkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218087; c=relaxed/simple;
	bh=exoJ5TjOCyb/sHGSwDeRxqMEr2yHZ0ClQXoLDWjt2RY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuhqTsy5y6M/zuSEtsRZYN3vvWC0Snfwk3b5TeMwSoMWMm0/O3DotC3Xv+kFsLo+9mP6suJS++oAeHPiTinvlKp0Ues/13PuUwSXgnf2lq+kRg20t8MwblxuaTvd050vqHolbAtfM4Rw5xqao5UNaBdug8WNZeP1Ly/fVtkwffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhezOpL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B06C4CEED;
	Fri, 15 Aug 2025 00:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755218087;
	bh=exoJ5TjOCyb/sHGSwDeRxqMEr2yHZ0ClQXoLDWjt2RY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FhezOpL1f1xXAWWa03D+vTNB/eNMg+i9QdUJBL+/sPByC9Qb9o1+BFDnnPKLvIZRZ
	 MYvnWL8D8N0ygDJAMpwtUPgdm7KUZLqN1ahKtbYII4oqSQfp24s+3L/2tF12STiYHo
	 1gBWqchiGc5uaIVlhAgsYK1vG/3KRrFYaHBruarJgbMgBwdbC3y1bgey90LGQoos5/
	 mximlyNdk36U8CQmO41Um2kW7tS/xqPqZxkASS5+it5wevzsk+Udntw9T5NP3gH822
	 iRYNHhdbMdpGWNKEp6YPeoEibjLmAkbekKuQFtRUvc2NNn0sUgcKk/RvYhkfODAuiV
	 +sIGOw1LwmwqQ==
Date: Thu, 14 Aug 2025 17:34:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kory Maincent
 <kory.maincent@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nishanth Menon <nm@ti.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk
 <roan@protonic.nl>
Subject: Re: [PATCH net-next v1 0/5] ethtool: introduce PHY MSE diagnostics
 UAPI and drivers
Message-ID: <20250814173445.63cf56c2@kernel.org>
In-Reply-To: <20250813081453.3567604-1-o.rempel@pengutronix.de>
References: <20250813081453.3567604-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 10:14:48 +0200 Oleksij Rempel wrote:
> This series introduces a generic kernel-userspace API for retrieving PHY
> Mean Square Error (MSE) diagnostics, together with netlink integration,
> a fast-path reporting hook in LINKSTATE_GET, and initial driver
> implementations for the KSZ9477 and DP83TD510E PHYs.

Hi Oleksij, the series doesn't apply, could you respin?
I haven't had a chance to look at the code unfortunately
-- 
pw-bot: cr

