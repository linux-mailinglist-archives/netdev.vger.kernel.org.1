Return-Path: <netdev+bounces-244974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A632CC47DE
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 17:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02DE03015007
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42423195F0;
	Tue, 16 Dec 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b="BQkzvwb1"
X-Original-To: netdev@vger.kernel.org
Received: from lan.nucleusys.com (lan.nucleusys.com [92.247.61.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262B314D2C;
	Tue, 16 Dec 2025 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.247.61.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903765; cv=none; b=gWJ6mfbLxXCy7NLPMy2bpZBGJaOzaQMa/5soXIdYguuHw9J1Y0c30FvYg8Ui1hKfKnmGRt+EmnO80vYOyE6dcAJ8rEJiqNZKiw8taTQhe59LTWHfzARhxrtPoVwKuIpD+zlfxstPZyBa+2t5SUm1vFvVdn6FFk1momvq/DDNg0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903765; c=relaxed/simple;
	bh=nd7DRhk/NWABFn58+HOcFIq6zVQfmASD5DzuxYIRr3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMTMKLM8Krsmj9gxM6+npKteEwOBrkwHYqD4PZoth+CUBF4TavcFD67KniyVOmU/6Nd/Ucjz/ScM+22PfKEKpjxChEbe9aVYGSo3RZjd0+P57cNmbTHtVQIjE9ALXwYFqsWVd8NLLXK3MrP7IAwGu9pua42iP2w9G4CT/IRIoBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com; spf=pass smtp.mailfrom=nucleusys.com; dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b=BQkzvwb1; arc=none smtp.client-ip=92.247.61.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleusys.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nucleusys.com; s=xyz;
	t=1765903377; bh=nd7DRhk/NWABFn58+HOcFIq6zVQfmASD5DzuxYIRr3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQkzvwb1FOW8OsiErTq+GTKUnBuWhc6jQ1LFBXy0wueUqjKctIB/LtLO8JwvaaG4Q
	 idVStTwsNHSTkCiDxaJrUaLKktIIAvuTjkV68u3mXazkNZWtZ/Yb7tHcrFtoWgPFqW
	 8GgOhbCdUyE/MMSTaezbT1UqeVegKTsVG29tRPTH78lujq3jBnNoIoXUT3f6vQG+N6
	 reIe48MVUyAVzGY8eIp5hg5TyibAlcVeopXC9MpZkRm+VZNklHu/eCJkhGgZp/jCJo
	 IbdkbGWrDT0tDaVWY3QX74OIJ79THnfqsUOgfi1a+Tqwq8ViPfz57tN5yrhGjwi3s3
	 zaWIvlBUdy5yg==
Received: from cabron.k.g (unknown [95.111.117.177])
	by lan.nucleusys.com (Postfix) with ESMTPSA id A5E5D3FB14;
	Tue, 16 Dec 2025 18:42:57 +0200 (EET)
Date: Tue, 16 Dec 2025 18:42:55 +0200
From: Petko Manolov <petkan@nucleusys.com>
To: Deepakkumar Karn <dkarn@redhat.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+8dd915c7cb0490fc8c52@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: usb: rtl8150: fix memory leak on usb_submit_urb()
 failure
Message-ID: <20251216164255.GA4325@cabron.k.g>
References: <20251216151304.59865-2-dkarn@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216151304.59865-2-dkarn@redhat.com>

On 25-12-16 20:43:05, Deepakkumar Karn wrote:
>   In async_set_registers(), when usb_submit_urb() fails, the allocated
>   async_req structure and URB are not freed, causing a memory leak.
> 
>   The completion callback async_set_reg_cb() is responsible for freeing
>   these allocations, but it is only called after the URB is successfully
>   submitted and completes (successfully or with error). If submission
>   fails, the callback never runs and the memory is leaked.
> 
>   Fix this by freeing both the URB and the request structure in the error
>   path when usb_submit_urb() fails.
> 
> Reported-by: syzbot+8dd915c7cb0490fc8c52@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8dd915c7cb0490fc8c52
> Fixes: 4d12997a9bb3 ("drivers: net: usb: rtl8150: concurrent URB bugfix")
> Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
> ---
>  drivers/net/usb/rtl8150.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index 278e6cb6f4d9..e40b0669d9f4 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -211,6 +211,8 @@ static int async_set_registers(rtl8150_t *dev, u16 indx, u16 size, u16 reg)
>  		if (res == -ENODEV)
>  			netif_device_detach(dev->netdev);
>  		dev_err(&dev->udev->dev, "%s failed with %d\n", __func__, res);
> +		kfree(req);
> +		usb_free_urb(async_urb);
>  	}
>  	return res;
>  }
> -- 
> 2.52.0


ACK.

Nice catch.  This bug has been lurking for a very long time... :)


cheers,
Petko

