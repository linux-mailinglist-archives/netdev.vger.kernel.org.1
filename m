Return-Path: <netdev+bounces-146085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3849D1EA9
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D0B2810CF
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D9314265F;
	Tue, 19 Nov 2024 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL0USY28"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7022213DB9F;
	Tue, 19 Nov 2024 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985640; cv=none; b=gu7CU+Zb9s5yERC6SxPgQu88NWtCBVVHAiwjUCCgvUijDt+ylpWVIooWEn3nS7pqO7lE7jRDc9A6HSef75M/KrbD24ccPHHOb3zDGiPHHZ08rC0UgfAklixydfN4wnOo2MfXLMbEsHNr6i+cJSx/u0W0mPNk4fFeJXl+cF+jYbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985640; c=relaxed/simple;
	bh=z1OerjDhdhMdzdrmWmW7PkU7Q0Wsdws5PTQmIX1XcLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZn0EeoSwDTwooZrbnSzv7PTWvDQvlcsRu9t0/eeDgbhgorz6KiVifcMVemNS9dAmEyoNVE2GeKq7hn9ZqcYhm4br3CTH42gTMtFYqMe3Fd3G3mdU4Huou5kel51J147GulAP4KUMms7n8fUQpZYeNXSTzEgA9KF4dco5/aAQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL0USY28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81911C4CED0;
	Tue, 19 Nov 2024 03:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985640;
	bh=z1OerjDhdhMdzdrmWmW7PkU7Q0Wsdws5PTQmIX1XcLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QL0USY28a8GPxlgL7t9ydz6DYZBSquZ1h3oiUWJR8DgxEp9XR7rSfnC3A90Mfi01i
	 VEKzYreWxy3OzXfq4iuWGtoB74Y5q3wkBSbPygFZYFPQY1GVQXdwMkQt4tAq6f5hWH
	 7FAVgALNpOsafMOG0IZeIkQlBUERH2sO0qV80+MC7LoJhUUJquNnrkgalJEq+kHDKp
	 bA7maaVkddb5HTPxNxVurYkZBV5nLEdpOGav0e6EJkLw2LYTgp3QOT5EQURHoUs1tx
	 3kixlO+Za6J7sNlsJ1IlTwVRmft0TvjPV2ZS1gxqHXzYK1lXSZ4g1cArWNxSQZLhw1
	 ZVo3Rjl6v9AaA==
Date: Mon, 18 Nov 2024 19:07:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
 <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
 <einstein.xue@synaxg.com>, Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3] octeon_ep: add ndo ops for VFs in PF driver
Message-ID: <20241118190718.5cff1ae1@kernel.org>
In-Reply-To: <20241118141936.1235170-1-srasheed@marvell.com>
References: <20241118141936.1235170-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 06:19:35 -0800 Shinas Rasheed wrote:
> These APIs are needed to support applications that use netlink to get VF
> information from a PF driver.

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new drivers,
features, code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


