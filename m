Return-Path: <netdev+bounces-215856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8CBB30A80
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 02:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44505A7C2F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 00:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA3D74040;
	Fri, 22 Aug 2025 00:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlW8bTyS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303C322A;
	Fri, 22 Aug 2025 00:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755824056; cv=none; b=L6ygSlOP9q2tDMiD7GAKOEiHLTlWiWeyyQAxaDdV98OMDwN/RTfYV6Ki1N/30rVbbQIkz9ehiqyqjB7buYFGzoEHAmmUQmevV9iwNPyAlPMGdsViUEsTVElpA1IiOyTekaJXVMA4LXotQCuBM1jqztF35aA1cjEy6CY2oFmoYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755824056; c=relaxed/simple;
	bh=qvBMaix31tj3okHWqTG9RDFc/IO2BW7m6zc19Y2m2TE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJN13jUbQ+ApPeYULnqUSuBHxhusMh/DXFSYcl1cU+mW6cVF+bgDX6xks/rlk9YiaWJFvzOk8xD7OEDR6NXQrv1M67JuviEEEXnosoh9aPJWyDkrdhStSVZueL16vE1WaoGUHqQJ6KLV+kEeyOcKWy+OskFwPvLKTKgdJbDisRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlW8bTyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C38C4CEEB;
	Fri, 22 Aug 2025 00:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755824056;
	bh=qvBMaix31tj3okHWqTG9RDFc/IO2BW7m6zc19Y2m2TE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jlW8bTyS4wZ55fnUxsVRmhYpITvgkMdRCsSdgk/JFpJjAyEce5h+ynr00zU2g99Ba
	 FZmZFww9Dbzp6Cptzpjg3Wf2tafAeixcbJhNw4O0/ePKgTIavz4FjJq/lp542+Tw03
	 hB7QrgaFlJvDKRnoNxrXWSqZZWvnn2hw+S/CptEyWE3k8Uiz9s1KBdgiQoWdAGj4lg
	 cF93H7CsMMLz9Umw3NwGqroDGqzEMPbqxM+Rs4BYUjqAWIlYSmwzHuJ8hYYEGBGFPn
	 7uhU9Sov9HYmNbBQT6BzaKouW5I6tKs1rbhKIBc0D4hSJetVR+cbtXttPSO+ySX2wJ
	 /MauTDMfMHxOg==
Date: Thu, 21 Aug 2025 17:54:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net v1 1/1] net: phy: Clear link-specific data on link
 down
Message-ID: <20250821175414.291ccc95@kernel.org>
In-Reply-To: <20250818121159.2904967-1-o.rempel@pengutronix.de>
References: <20250818121159.2904967-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 14:11:59 +0200 Oleksij Rempel wrote:
> When a network interface is brought down, the associated PHY is stopped.
> However, several link-specific parameters within the phy_device struct
> are not cleared. This leads to userspace tools like ethtool reporting
> stale information from the last active connection, which is misleading
> as the link is no longer active.

Makes sense but unless you can point at a commit which brought this
behavior in I'm slightly worried about regressions. Not that I can
think of an exact scenario..

Could you please repost for net-next and let's see if we can attract
any PHY maintainer acks?
-- 
pw-bot: cr

