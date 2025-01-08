Return-Path: <netdev+bounces-156115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44310A04FF5
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF4D165BBF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E98C13C3F2;
	Wed,  8 Jan 2025 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAd3tS8p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3C1362;
	Wed,  8 Jan 2025 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736301902; cv=none; b=LkQYUDpRLNwYv503HtRLpnTo+mZfNY4pyh6455eUs9SzxEjf27pVJl5cg25DKjlFeeCVeUgQrBZSLkwm4rxHyzyqGSYcmxw74Yq109gp0eDmuloceBgEZFNQcrPs1Oo9qAdPySQ4eJVlP2yBUgRueaJjdgobBNRubr+jPWrlacg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736301902; c=relaxed/simple;
	bh=zOm0QRPlDsgJ3SJ52Rl5J19iHS6mxMEQN62LPtbqo/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9aSafv6AyO7Lye8dnV8nHaGSnzTyA9Ok6z6l9B0YrvELDvq7aCenG4tBciF6pJKCXEgBoXwIAlCRgLqOMw2jUX6k8ahJhuEoP7Xlnz8na3JdpLb2fJBa9r9/L/on5m/4XlGBhukui7JXCmG6K9TTEuMPH1wVB24px9kzJIdYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAd3tS8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03903C4CED6;
	Wed,  8 Jan 2025 02:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736301901;
	bh=zOm0QRPlDsgJ3SJ52Rl5J19iHS6mxMEQN62LPtbqo/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vAd3tS8pECdB5JScFXH879Fy9fzxYrNvUtZjtnzDUMOqRY6Wancws4QxClm9XnFuc
	 vPwgI5BOwSbjRFEJoSfKB2KNKgRFjd0ZGLx41P6nybVIrD2JRVrLZ5rXAg167JhDJE
	 9KCRn5hlVrfPjGNKJFT2J6CWiXVjNxVk4BMy12gDBocdX1gCHwJdOLY1ydpPDlMs++
	 KFgTJ2vfB54fF2h0jRaXg17/6DQih/dr0jbzWf5YEOv6QwE39JmHVZVyFTKoKLSn/l
	 ZBaHZCbzry+o8ob/p9XNyun+T2nAwi5gvJw/aSk9+3hCbunAp8nEaHUVGoF2mMdStv
	 ZcqbTO5qB8JAQ==
Date: Tue, 7 Jan 2025 18:05:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 6/8] ethtool: add helper to prevent invalid
 statistics exposure to userspace
Message-ID: <20250107180500.34be6ded@kernel.org>
In-Reply-To: <20250106083301.1039850-7-o.rempel@pengutronix.de>
References: <20250106083301.1039850-1-o.rempel@pengutronix.de>
	<20250106083301.1039850-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jan 2025 09:32:59 +0100 Oleksij Rempel wrote:
> Introduce a new helper function, `ethtool_stat_add`, to update 64-bit
> statistics with proper handling of the reserved value
> `ETHTOOL_STAT_NOT_SET`. This ensures that statistics remain valid and
> are always reported to userspace, even if the driver accidentally sets
> `ETHTOOL_STAT_NOT_SET` during an update.

u64 can't wrap. If it could we should be using a wider type 
to count packets/bytes. I don't see the need for this, sorry 
for missing the discussion.

