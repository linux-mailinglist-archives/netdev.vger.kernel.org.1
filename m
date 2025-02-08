Return-Path: <netdev+bounces-164242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC38A2D1E6
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12033AD6AD
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 00:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E57363CF;
	Sat,  8 Feb 2025 00:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt4MMnXS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7E4A21
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 00:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738973776; cv=none; b=EfER6tYEEJH3K6rl44ACfOmRpNEiIJjtMzFwGkKYOPqaGzBx2mDi6d3sGTM9pOPdsF9sY8qm/ob596/RqTflo2xA0KYdE73OMDNr7ijP4MLg2txe4DvSmPpC7K3ar5dui0plVvrntDjueb5//IqRzuczv1+V9jcMC5SDZ7FiXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738973776; c=relaxed/simple;
	bh=tUcqtOogOT36D8nyLGFJGckwhoejET2PiQhWPZ9lsDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScU+hfwrCRYj6j6lWHVduu+a9vCMqNfOUvtVPmOb2Dmh+1QAbC0T/Ocd3TOmKmm9U8j22/o44mOrKkX9CqP9ISpqrNWX3yFvEVp4N+mNUD8IMuCotKZDjLfu24cCRQ1XIT2j2YQXdXPLNnckB6xAB34YkKohGa5wTuxIXWd0xeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt4MMnXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC75C4CEE2;
	Sat,  8 Feb 2025 00:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738973775;
	bh=tUcqtOogOT36D8nyLGFJGckwhoejET2PiQhWPZ9lsDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mt4MMnXSMxAbSCSSOagMzzJyPHwNEHcQXMZC1gGzX+NctMsnb+xkk5iwchs7jYMCR
	 XQh+0PGL3G0+77mqNk6ogp1jn5cxhXGYjy3IRryYZz1H16rga6KggItuJ2sT8Ub2gR
	 UzBaVb6LKf9Q6aASm+qo9wICWXPsepZBtT+30fO5CpurxLw44LdFlRE5JI79ULMTCX
	 QX1bD7POnzh2DeiVbaVaF+GViLlTF5KoW2lQzKxRp0fpCPGgYeWA4VEPngXk3SIMsr
	 ZasBC3jtt3EyiO8MLOYpG3uEUiZiCpMmjVP0kh27OHt1DvaFfbVjaKcO5SmNHzcO5r
	 LJavewo8smZJw==
Date: Fri, 7 Feb 2025 16:16:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/7] net: phy: Support speed selection for
 PHY loopback
Message-ID: <20250207161614.6a70bef6@kernel.org>
In-Reply-To: <20250205190823.23528-3-gerhard@engleder-embedded.com>
References: <20250205190823.23528-1-gerhard@engleder-embedded.com>
	<20250205190823.23528-3-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Feb 2025 20:08:18 +0100 Gerhard Engleder wrote:
> +/**
> + * phy_loopback - Configure loopback mode of PHY
> + * @phydev: target phy_device struct
> + * @enable: enable or disable loopback mode
> + * @speed: enable loopback mode with speed
> + *
> + * Configure loopback mode of PHY and signal link down and link up if speed is
> + * changing.
> + */
> +int phy_loopback(struct phy_device *phydev, bool enable, int speed)

nit: if you're adding kdoc please also document the return value.

 * Return: 0 on success, negative error code on failure.
-- 
pw-bot: cr

