Return-Path: <netdev+bounces-39430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0F67BF2A7
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 08:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1401C20A71
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 06:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA319449;
	Tue, 10 Oct 2023 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kjaij1CK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A363CF;
	Tue, 10 Oct 2023 06:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CBAC433C9;
	Tue, 10 Oct 2023 06:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696917616;
	bh=gQXf/DuKE3gdQ2bmNkAQyrlr4ASiicMGR3NvmU6Ghj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjaij1CKbBcWr5w+jLQM24tkojhInog/OnyxdeL0kg/slP8FbEbkGncR/r9nYxeqW
	 ysMPNeBz5JXnRjPWZdGt+aTOt31YPue6ncmY0qwFC8LXR6MQsnGYSNFkSnCSfjanZh
	 HHCFIloNqqwiFhP7RA/f/p89E1Cr3jR58uNLd18I=
Date: Tue, 10 Oct 2023 08:00:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Peter Korsgaard <peter@korsgaard.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: dm9601: fix uninitialized variable use in
 dm9601_mdio_read
Message-ID: <2023101036-fleshy-dude-aec0@gregkh>
References: <20231009-topic-dm9601_uninit_mdio_read-v2-1-f2fe39739b6c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-topic-dm9601_uninit_mdio_read-v2-1-f2fe39739b6c@gmail.com>

On Tue, Oct 10, 2023 at 12:26:14AM +0200, Javier Carrasco wrote:
> syzbot has found an uninit-value bug triggered by the dm9601 driver [1].
> 
> This error happens because the variable res is not updated if the call
> to dm_read_shared_word returns an error. In this particular case -EPROTO
> was returned and res stayed uninitialized.
> 
> This can be avoided by checking the return value of dm_read_shared_word
> and propagating the error if the read operation failed.
> 
> [1] https://syzkaller.appspot.com/bug?extid=1f53a30781af65d2c955
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Reported-and-tested-by: syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com
> ---
> Changes in v2:
> - Remove unnecessary 'err == 0' case
> - Link to v1: https://lore.kernel.org/r/20231009-topic-dm9601_uninit_mdio_read-v1-1-d4d775e24e3b@gmail.com
> ---
>  drivers/net/usb/dm9601.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

What commit id does this fix?

thanks,

greg k-h

