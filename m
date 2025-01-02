Return-Path: <netdev+bounces-154740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 289719FFA49
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2160C3A1D9E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FED1A9B53;
	Thu,  2 Jan 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y7FTpKHA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49E1ABEAC
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827202; cv=none; b=VJbNt2us5aLZ4KSAm4MbYRNX0p5dNYZbbFZD+vVsiXhz5EGst/tLIrU5ZPgRkPZ3OeFDhzDGxtVTx1MKTTxsaBD3wUdbErP4QvO/PJz7djwNSiJPrMxQkt2FKVb8IZy3Ja9/DVZ2afrjLCUu/74INxg2C8TLdUlEYXxxLUpSx4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827202; c=relaxed/simple;
	bh=fITeMT9fqxUZqou58LTcPZPuUuLldyOrCAcXBH5XkHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDs8CZTavWbl0qrBmYVuzMIAqwjftMEHX3+v5kXLimOF297419oRCB8OcuvNWUKInllTV3nOjiCqiiws30GbUKxf63O1hMxkDKjIvltQMZrVbFgk3U+xRo+62MN0VUBDdSHuaQJ0eGzmqKNldU72Lm7WiZr7wdtXxbOsaHxuV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y7FTpKHA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NgTabLLSEsVC+79FFkPuZFAOPeLfz0fSbmTvURBUA50=; b=y7FTpKHA7XkF5JvcICSz04D0hh
	CmHhk9G36E3Zd+7t9WHs10ScrSRl5ycIRcgfFBfXEaYhJf3/jA0IkfGjLvtIkAFNRb/6vAsNCPiEH
	V+lYqw9IJtl3nXB7VK6lLNoAiEH4VelJ9kHFDUSoxGAOxgnyHoG1+5CrqX1khp28QNcs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTLwf-000kzb-H0; Thu, 02 Jan 2025 15:13:05 +0100
Date: Thu, 2 Jan 2025 15:13:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	linux@armlinux.org.uk, horms@kernel.org, jacob.e.keller@intel.com,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
Message-ID: <ab140807-2e49-4782-a58c-2b8d60da5556@lunn.ch>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
 <20250102103026.1982137-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102103026.1982137-2-jiawenwu@trustnetic.com>

> +static int wx_tx_map(struct wx_ring *tx_ring,
> +		     struct wx_tx_buffer *first,
> +		     const u8 hdr_len)
>  {
>  	struct sk_buff *skb = first->skb;
>  	struct wx_tx_buffer *tx_buffer;
> @@ -1013,6 +1023,8 @@ static void wx_tx_map(struct wx_ring *tx_ring,
>  
>  	netdev_tx_sent_queue(wx_txring_txq(tx_ring), first->bytecount);
>  
> +	/* set the timestamp */
> +	first->time_stamp = jiffies;
>  	skb_tx_timestamp(skb);
>  
>  	/* Force memory writes to complete before letting h/w know there
> @@ -1038,7 +1050,7 @@ static void wx_tx_map(struct wx_ring *tx_ring,
>  	if (netif_xmit_stopped(wx_txring_txq(tx_ring)) || !netdev_xmit_more())
>  		writel(i, tx_ring->tail);
>  
> -	return;
> +	return 0;
>  dma_error:
>  	dev_err(tx_ring->dev, "TX DMA map failed\n");
>  
> @@ -1062,6 +1074,8 @@ static void wx_tx_map(struct wx_ring *tx_ring,
>  	first->skb = NULL;
>  
>  	tx_ring->next_to_use = i;
> +
> +	return -EPERM;

       EPERM           Operation not permitted (POSIX.1-2001).

This is normally about restricted access because of security
settings. So i don't think this is the correct error code here. What
is the reason the function is exiting with an error? Once we
understand that, maybe we can suggest a better error code.

> +static int wx_ptp_adjfine(struct ptp_clock_info *ptp, long ppb)
> +{
> +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> +	u64 incval, mask;
> +
> +	smp_mb(); /* Force any pending update before accessing. */
> +	incval = READ_ONCE(wx->base_incval);
> +	incval = adjust_by_scaled_ppm(incval, ppb);
> +
> +	mask = (wx->mac.type == wx_mac_em) ? 0x7FFFFFF : 0xFFFFFF;
> +	if (incval > mask)
> +		dev_warn(&wx->pdev->dev,
> +			 "PTP ppb adjusted SYSTIME rate overflowed!\n");

There is no return here, you just keep going. What happens if there is
an overflow?

> +/**
> + * wx_ptp_tx_hwtstamp_work
> + * @work: pointer to the work struct
> + *
> + * This work item polls TSYNCTXCTL valid bit to determine when a Tx hardware
> + * timestamp has been taken for the current skb. It is necessary, because the
> + * descriptor's "done" bit does not correlate with the timestamp event.
> + */

Are you saying the "done" bit can be set, but the timestamp is not yet
in place? I've not read the whole patch, but do you start polling once
"done" is set, or as soon at the skbuff is queues for transmission?

>  static void ngbe_mac_link_down(struct phylink_config *config,
>  			       unsigned int mode, phy_interface_t interface)
>  {
> +	struct wx *wx = phylink_to_wx(config);
> +
> +	wx->speed = SPEED_UNKNOWN;
> +	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
> +		wx_ptp_start_cyclecounter(wx);

This is probably a naming issue, but it seems odd to call a _start_
function on link down. 

	Andrew

