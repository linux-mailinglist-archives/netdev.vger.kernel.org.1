Return-Path: <netdev+bounces-54541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7023C8076BC
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63B11C20B02
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1186A031;
	Wed,  6 Dec 2023 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnKaBlV/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E8364B2
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 17:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0D2C433C9;
	Wed,  6 Dec 2023 17:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701884230;
	bh=6y9ccO/hhy8QtjUGlc2BRuPnbQHVs5kQSx0j8UwqKgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZnKaBlV/4a5bSlhwn27JJNh7hr3JEtvm7UdhcRWHX4ezAVLlmEhLbLAaxf5kfiEOL
	 oUxeAIP/wkLJxLkXgynDuRbRVPBAOB/q45tALOtifv6bCRIdqqSAU1IrBwpYIyVjVw
	 SKF32mHTEWyICh3ASiauDcnyAUOcygYPBx/OYlDYJKnFo7rGRcUtfEjo3XuqkfKiWR
	 Mz2cfvbQzDInibBzn+fbEOX1CtXy2f+9D5clhb7XU5hm/ymtbDmLRYZo7kcy8D6Bek
	 hkfpJpkQQ0KRCeZHm8hc631kCKRY7FwteCWYkARGC+FdsTSCIJRDwwmNSJYeBKCqFz
	 XXKwIReO0ScSA==
Date: Wed, 6 Dec 2023 09:37:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, andrew@lunn.ch, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 4/7] net: wangxun: add ethtool_ops for ring
 parameters
Message-ID: <20231206093708.62f91a45@kernel.org>
In-Reply-To: <20231206095355.1220086-5-jiawenwu@trustnetic.com>
References: <20231206095355.1220086-1-jiawenwu@trustnetic.com>
	<20231206095355.1220086-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 17:53:52 +0800 Jiawen Wu wrote:
> +	ngbe_down(wx);
> +
> +	err = wx_set_ring(wx, new_tx_count, new_rx_count);
> +
> +	wx_configure(wx);
> +	ngbe_up(wx);

What if it fails? We don't allow down() / up() cycles on ethtool config
changes. You have to implement some form of reconfiguration, at minimum
it needs to be resilient to memory allocation failures (in which case
the old config should be kept and the device should keep running).

