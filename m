Return-Path: <netdev+bounces-251102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D454BD3AB49
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4748F30ACEBE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DA8376BFB;
	Mon, 19 Jan 2026 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xL/NCr+q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259831AA99;
	Mon, 19 Jan 2026 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831569; cv=none; b=Q86xOGvpmbtyUfeGnm+/N+JeAyhMhgkJJllthO+FvfO4b/yYpzmvctYFaPFmM7j4YgtgJve7NT1qSUP7iwy9oOVYBOGxgrYhaB35o7vgfgBOY9BaDoOxpH2PhgQ5s7MS+CfZrsMqHU79VoBebUWc0vaLIIPUqQwGIcwZMYa68h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831569; c=relaxed/simple;
	bh=/gYH8ybKG/bCguWXbdqTmW2fic574CdQvI+oEFCQ7L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVpX098EJs6dGgcpUlXJq0i3RHXst+12Rwzrop4a1T8zFirN0Mv2QxfvQL5jcWAGg4JnKh7f/hMo4mds1CwD6J8ngrD8yj1O+rwmmZ9LYtnVkeJF1QnlAHayLFX7z05jg5BiQnHuR9SDclF9TwJ/MeCsoU9R2uzPD+4ZH0nWID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xL/NCr+q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=10vagt5cgGAlzJjUUvCuX7Uw8+UEfleG+ruBtfWbklE=; b=xL/NCr+qvv5x4ff9x0xDYA3cBc
	9NH99qPfB+2J7vgRVWn3rUwYUBSZnnc6RBYF+7d7P88eR7K4VQVxpkLOBbrRKKO4Y6iKe+kf38U6/
	Xs7fgnjB7st4g/lEKFjFimiJb6GujqrJSEtZB47QAyxjsPpwpUr6fz46MVM0wACR15ds=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhptC-003VGL-0r; Mon, 19 Jan 2026 15:05:54 +0100
Date: Mon, 19 Jan 2026 15:05:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: intel-xway: fix OF node refcount leakage
Message-ID: <02a2c8a3-3310-4e12-aba2-0dbb3fc780a5@lunn.ch>
References: <b6fe8f6a1c7cf190b899d99e0e3a1e1370f50496.1768708538.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6fe8f6a1c7cf190b899d99e0e3a1e1370f50496.1768708538.git.daniel@makrotopia.org>

On Sun, Jan 18, 2026 at 03:57:04AM +0000, Daniel Golle wrote:
> Automated review spotted an OF node reference count when checking if the
> 'leds' child node exists. Call of_put_node() to maintain the refcount.
> 
> Link: https://netdev-ai.bots.linux.dev/ai-review.html?id=20f173ba-0c64-422b-a663-fea4b4ad01d0
> Fixes: ("1758af47b98c1 net: phy: intel-xway: add support for PHY LEDs")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

