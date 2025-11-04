Return-Path: <netdev+bounces-235567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A98C32736
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44EBA4E72F4
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1C0335547;
	Tue,  4 Nov 2025 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1OjqP5NZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FE0337B8A;
	Tue,  4 Nov 2025 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278767; cv=none; b=qSo5IQncRdvcNqrtdiwhmZjtt5lbcNghNkCCL8jahV2rtqJrTBIkRKXDSgghh63SG25kKGGOD/mUGW/Lfe2WVmhj4H9P4aTpXfChzu/w4XOki9+r3MA+wuHESbxUqDKqK+PHWkHXpTwYM3gndhbb/EezQiqRk4sQFBN5AD1Quf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278767; c=relaxed/simple;
	bh=eeEAvdwBf57/36NyqhyPqX1iWLcK4lwbQbogWD8Zvm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFYlh8KzNkqgNBzMZSI60aBU5H4KIpVyAL1VuqQkxQO0dpsuWlMppG3cJ6X4beniMHyGOcci3RbxMeI1UfC0OZ5CkPyGtZi9X1Jx0i4tlWdVB6M9FEXHCL61JvV7jI4/gOcO8ST3u/fPpmSv5XijNy2ZM7iHxLTbV3dTOrxWVuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1OjqP5NZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P5OGsJN0pDHcN5HfLEGaoDr6nQ112hZdoxHywNFHsX8=; b=1OjqP5NZ+WyET0LHDSPYVKszrB
	orvHs/B/vpFCaVBhtqE3UXTlh64zGvBP5ucfAPOSl0BpOGxL83PMYayXmKEytPBbDSEaAjowuXJTd
	OMH+w1yEkY0pZVZtqFQlfpla0LLGSQW+kufPNcRh4wt4nBjy9sjk0+wQ4icXPzydbVbs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vGLCz-00Cunh-Qt; Tue, 04 Nov 2025 18:52:41 +0100
Date: Tue, 4 Nov 2025 18:52:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] [PATCH] usb: rtl8150: Initialize buffers to fix KMSAN
 uninit-value in rtl8150_open
Message-ID: <ea06bbfb-d14b-4c61-8394-c536ca2a67ce@lunn.ch>
References: <20251104162717.17785-1-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104162717.17785-1-dharanitharan725@gmail.com>

On Tue, Nov 04, 2025 at 04:27:16PM +0000, Dharanitharan R wrote:
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

You are messing up the whitespace here.

Did you not read your own patch and notice this problem? checkpatch
probably also complained.

    Andrew

---
pw-bot: cr

