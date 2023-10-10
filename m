Return-Path: <netdev+bounces-39435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D23AB7BF322
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 08:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE001C208D6
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 06:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8A1391;
	Tue, 10 Oct 2023 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="18+KabpN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D7A65C;
	Tue, 10 Oct 2023 06:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C131EC433C7;
	Tue, 10 Oct 2023 06:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696919618;
	bh=M9p2Y7LB/cIXEwnNrOz2eXKKA/1TPc0wjQK8giZOwMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=18+KabpN5HcVivpxLnDaNFK21429BKXqzT8XHlySL1WbusIukZOznlgNQSnYuo3hX
	 H5m9r8/cI0WK7WahKHEx05eJB92zeOQO4X9dnOSswzDi/8Q4EGziREg8HdfhixbMYZ
	 an7bGurprT+k2u+fZ0PK4ao0LhFhTu1ii/EfU/ww=
Date: Tue, 10 Oct 2023 08:33:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Peter Korsgaard <peter@korsgaard.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: dm9601: fix uninitialized variable use in
 dm9601_mdio_read
Message-ID: <2023101018-venomous-uncured-47cf@gregkh>
References: <20231009-topic-dm9601_uninit_mdio_read-v2-1-f2fe39739b6c@gmail.com>
 <2023101036-fleshy-dude-aec0@gregkh>
 <87v8bfc83f.fsf@48ers.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8bfc83f.fsf@48ers.dk>

On Tue, Oct 10, 2023 at 08:19:48AM +0200, Peter Korsgaard wrote:
> >>>>> "Greg" == Greg KH <gregkh@linuxfoundation.org> writes:
> 
>  > On Tue, Oct 10, 2023 at 12:26:14AM +0200, Javier Carrasco wrote:
>  >> syzbot has found an uninit-value bug triggered by the dm9601 driver [1].
>  >> 
>  >> This error happens because the variable res is not updated if the call
>  >> to dm_read_shared_word returns an error. In this particular case -EPROTO
>  >> was returned and res stayed uninitialized.
>  >> 
>  >> This can be avoided by checking the return value of dm_read_shared_word
>  >> and propagating the error if the read operation failed.
>  >> 
>  >> [1] https://syzkaller.appspot.com/bug?extid=1f53a30781af65d2c955
>  >> 
>  >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>  >> Reported-and-tested-by: syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com
>  >> ---
>  >> Changes in v2:
>  >> - Remove unnecessary 'err == 0' case
>  >> - Link to v1: https://lore.kernel.org/r/20231009-topic-dm9601_uninit_mdio_read-v1-1-d4d775e24e3b@gmail.com
>  >> ---
>  >> drivers/net/usb/dm9601.c | 7 ++++++-
>  >> 1 file changed, 6 insertions(+), 1 deletion(-)
> 
>  > What commit id does this fix?
> 
> It has been there since the beginning, so:
> 
> Fixes: d0374f4f9c35cdfbee0 ("USB: Davicom DM9601 usbnet driver")
> 
> Acked-by: Peter Korsgaard <peter@korsgaard.com>

Great, can someone add a cc: stable@ tag for this too please?

thanks,

greg k-h

