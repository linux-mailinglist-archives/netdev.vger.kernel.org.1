Return-Path: <netdev+bounces-235591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E88C3333E
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2663BFCCC
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DDF2D12E2;
	Tue,  4 Nov 2025 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gysjcgRD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCDE2D12EF;
	Tue,  4 Nov 2025 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294747; cv=none; b=RV1Y/UAxAJTf1rrXTAUFgO/0Fbl8sBxJukwF3wlO08d4paQdSeTwaK5MWBWZFEFuMpWBs2s4xhxa7Za/DS+ORQc/kcQaUH3BQzeGrZDZvE5oSTXrQzN0sHHY5L/pY467Ozlc+3F7+8sQu2An7WQyapVfrUF3ZoXZsj5MYOwb1Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294747; c=relaxed/simple;
	bh=LS0mMIE5Lb/ESdIDqPOlSb6UNcRJNOOE3UsfcASavbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJH9rTd27a3fXj3pTI0Sr6E9W4Ixnea1Vz8QExIrn1fxHXqLCyblkYus/pKLydiQJHC28H7A/sgqHVkJJ97e9xfPvC9PW5UZiw4VwWsRSeakQbYb0B4mDwXhHOnNTlSAxKcFhSM39jD4hoZ3zUwyQkaMWcozmffp19Ve+QVoRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gysjcgRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC216C4CEF7;
	Tue,  4 Nov 2025 22:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762294746;
	bh=LS0mMIE5Lb/ESdIDqPOlSb6UNcRJNOOE3UsfcASavbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gysjcgRDjFXS/4n90ag5CSm1FnVv6Uyu1yhZuGxm6wIM+FoX+SatJGn49386klBwU
	 SifIEHOGMDeb8ZyKhXHKat9+OcyTc/6W1QoUj8prqVPn1W+m+BU6Ns39vn19FKqAqK
	 r2+Y66udN2BhjPfiGN95z34bKP8toPlFPy0jBOmc=
Date: Wed, 5 Nov 2025 07:19:02 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com,
	syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com
Subject: Re: [PATCH] [PATCH] usb: rtl8150: Initialize buffers to fix KMSAN
 uninit-value in rtl8150_open
Message-ID: <2025110531-replace-grass-3c41@gregkh>
References: <202508272322.b4d5d8faea6996fd@syzkaller.appspotmail.com>
 <20251104164838.17846-1-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104164838.17846-1-dharanitharan725@gmail.com>

On Tue, Nov 04, 2025 at 04:48:37PM +0000, Dharanitharan R wrote:
> KMSAN reported an uninitialized value use in rtl8150_open().
> Initialize rx_skb->data and intr_buff before submitting URBs to
> ensure memory is in a defined state.
> 
> Reported-by: syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com
> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
> ---
>  drivers/net/usb/rtl8150.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index 278e6cb6f4d9..f1a868f0032e 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -719,14 +719,15 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
>  
>  static void set_carrier(struct net_device *netdev)
>  {
> -	rtl8150_t *dev = netdev_priv(netdev);
> -	short tmp;
> +    rtl8150_t *dev = netdev_priv(netdev);
> +    short tmp;

Always run checkpatch on your changes so you don't get grumpy
maintainers asking why you didn't run checkpatch on your change :)

Please fix and send a v2.

thanks,

greg k-h

