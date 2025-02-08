Return-Path: <netdev+bounces-164253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCBCA2D24A
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA04169EE2
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 00:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D50FD53C;
	Sat,  8 Feb 2025 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otO0Qpwl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E861E515;
	Sat,  8 Feb 2025 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974863; cv=none; b=bTbf6DyUlGTeCJJpHb3++KnZdgCXtzm6AOQv9webZMGKbWo/ZP4+egrS+4YH0ZLiqYreMvSbQc2+lE4guGIuK3e1K53LpM7ijHbgIxqWgP5eelX0qDu+H11qComHgdKPvTzoJD2Z8fcQUrmJf3wrXp+1n9V28HaZPDvbfGRicl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974863; c=relaxed/simple;
	bh=Cwi2xTiOLhYjKvLjqh5VpLi7gdtIS8fXpHNBc1AzP/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSCW6X5MThzRYjijez+KGAqPQYLJitCZvd38t4YpQP5CNHZWNerwrJRZLD33QVf6x/78qO9gQTn2t0rSdGK9pop/66O+cgtatVxqFIz3nTk1L7LD+E76Y+Ujpkn1TBDvWkPMDAiQJc0lQW1aHpnKchrxGu0QrfMtT0YRpziUQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otO0Qpwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EB2C4CED1;
	Sat,  8 Feb 2025 00:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738974862;
	bh=Cwi2xTiOLhYjKvLjqh5VpLi7gdtIS8fXpHNBc1AzP/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=otO0QpwlN0atzV0jHHJR4nWiArSahuNQbBVUglG5ontQgC4P4w8itXhUA673fhlsX
	 +B8aOWyVlcS6w1kdcGIHsiT76iljvPfzCVVKI3UuebSDvfAwY76Ep8FUpH3T9aVQ9k
	 YGTWlSOANFJ8fG7hUkW7CvqrA5MOdArJmzDpys+8JOAa2KXlGWCuyQX5MdSp3B7EFL
	 IStyjVaFUMzqkVq1+bLB4adUMYXUeUdLMV1fxbPY4i0uF7p4eIChVatX+xMZ/ilRmY
	 Av+Z98N4n3gw0OSR/X0bctIgpL24AcmBw6kgTculAHMbIeVLbR4qfP5AZ/axzpzy0v
	 fVN3o8oM5mgwA==
Date: Fri, 7 Feb 2025 16:34:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: phy: dp83tg720: Add randomized
 polling intervals for unstable link detection
Message-ID: <20250207163421.0a1122ec@kernel.org>
In-Reply-To: <20250206093902.3331832-3-o.rempel@pengutronix.de>
References: <20250206093902.3331832-1-o.rempel@pengutronix.de>
	<20250206093902.3331832-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 10:39:02 +0100 Oleksij Rempel wrote:
> +static unsigned int dp83tg720_phy_get_next_update_time(struct phy_device *phydev)

over 80 chars, why did you decide to put the word "phy" into this
function name

> +		/* When the link is up, use a fixed 1000ms interval (in jiffies) */

comment over 80 chars

