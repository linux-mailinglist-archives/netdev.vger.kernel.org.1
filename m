Return-Path: <netdev+bounces-193748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64982AC5AF5
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12DC3B7710
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E3B1DE3CA;
	Tue, 27 May 2025 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HJPt6xf+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E422DCBF0;
	Tue, 27 May 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375416; cv=none; b=OWgARn4fZtXWS6dDphopakQfbqwI76lY+xHru+CCuilT3r2s/gDaJl6fXxmF2KLyIMTJe14b95b3yT9y07MshoC0ZRgus5LREbl97aYYUsJ8EOFa2mcN7aowLdcQzyo17faaZMEF3OXaJMHJYBThzRx+DI4l4wRA4F2/l0A+W3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375416; c=relaxed/simple;
	bh=p0PVMMt8l8CmiG5kYSDEHRG0kgpk1Q+IBWoyKpHGFDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KziNd1uJhisYbNzUFkRGyOvLTB5z5n2kWutol4Gb1UYybCC0DSvxwOQIPmF+w9omCprCistaRrOfh/xlLZ/jFC1t4MqZjXKGu4fGYyicxM+AVhdirj0gf5iUwVUi/WriQ6j5K6e/LErfb04OqKFqOkEfcDy6qQpU5T34qr2Cglc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HJPt6xf+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1nVcyb7G5V8vKnNriJjpKRn7ochwYQQyPFOHqYgisEg=; b=HJPt6xf+G928vb2HuWG8C4ta/b
	vfs9ylM9NxCEx2vaYtdo+Ak5hpzCSCRU7kHv1V5Zx7r4zLklkcnLkI4LCxDer2v4/t0qw8sbr0oct
	t0kEwihW/7G+2UxwEXaC7OP7kHvisAE66V7HEciv64739k0Fq45eexCSk/p4L/e/x6Rc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uK0JG-00E6Zf-Fq; Tue, 27 May 2025 21:50:02 +0200
Date: Tue, 27 May 2025 21:50:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] [net-next] hns3: Demote load and progress messages to
 debug level
Message-ID: <93f09b85-9e11-489c-9d7e-78ce057b6437@lunn.ch>
References: <0df556d6b5208e4e5f0597c66e196775b45dac60.1748357693.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0df556d6b5208e4e5f0597c66e196775b45dac60.1748357693.git.geert+renesas@glider.be>

On Tue, May 27, 2025 at 09:30:15PM +0200, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> No driver should spam the kernel log when merely being loaded.
> The message in hclge_init() is clearly a debug message.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Alternatively, the printing in hns3_init_module() could be removed
> completely, but that would make hns3_driver_string[] and
> hns3_copyright[] unused, which HiSilicon legal may object against?

From a IANAL perspective, pr_debug() is O.K. for me.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

