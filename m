Return-Path: <netdev+bounces-154362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466019FD5C3
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 16:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5414166071
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB371F2387;
	Fri, 27 Dec 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EXCIO7wJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20F1FB3
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735315195; cv=none; b=d1DjUrByFpcGlt20OhOu4I/ssd5GZmBiq3LjTIcsd1jIlJzmGchiW+MLu4A7+eEc4TeeWDyHtrRCkkg+Nt+d1vNO16nCjwVm1YSQ/3p8P1xTLXOaJ7JIrfBa3ePGoinPSefGunaVmVmfGgVO1juri+pqI1Cbjf7degmdXH3mxn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735315195; c=relaxed/simple;
	bh=edsWHuQYalxwusa+dNTf9N9wUI1NNCWDsD8Q/uNhhaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGH9YmJNlLIdxZ5DiFzKPjJWnjrU8Tak3luR5XEQYPvEFT79r75ybn4ACjmked6EGft0ZSpxsvBrfo9rO5SLxyRalwyvmRva/+pjdnHsyBpmTdCTRdUSky14SW8o8SFqMWhOgVHySu4bMqt44FO9sTtBxmGjYMrW1qYJjMSxXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EXCIO7wJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9mQJexijBETVV0nBfChdCBJVbf+nCnCstV7osj4NmNE=; b=EXCIO7wJLPdQo9l8wlqOApUc/A
	k7lvf6Qnr2GatKUc1BbPQua3c/4u88GUPfP0wru1NGrpWCs4ertRWh2r8clvuyGvR11FGUtaVf9q3
	3tpxwgjhCQyb7v0WFohc12GKYWBCNEZ7m3gEAUnpmON7kdgCeGPCZ/tcYaI+031ut1AU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tRCkY-00Gkx5-Bb; Fri, 27 Dec 2024 16:59:42 +0100
Date: Fri, 27 Dec 2024 16:59:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH net-next v2 5/5] enic: Obtain the Link speed only after
 the link comes up
Message-ID: <c476e255-586a-45e7-9b86-39c127bacd37@lunn.ch>
References: <20241227031410.25607-1-johndale@cisco.com>
 <20241227031410.25607-6-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227031410.25607-6-johndale@cisco.com>

On Thu, Dec 26, 2024 at 07:14:10PM -0800, John Daley wrote:
> The link speed that is used to index the table of minimum RX adaptive
> coalescing values is incorrect because the link speed was being checked
> before the link was up. Change the adaptive RX coalescing setup function
> to run after the Link comes up.
> 
> There could be a minor bandwidth impact when adaptive interrupts were
> enabled. The low end of the adaptive interrupt range was being set to 0
> for all packets instead of 3us for packets less the 1000 bytes and 6us
> for larger packet for link speeds greater

There are two changes here, so please break it into two patches.

> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -84,6 +84,8 @@ MODULE_AUTHOR("Scott Feldman <scofeldm@cisco.com>");
>  MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, enic_id_table);
>  
> +static void enic_set_rx_coal_setting(struct enic *enic);
> +

Please don't add forward declarations. Move the code around
instead. You can add a preparation patch which does the move, and in
the commit message say there is no functional change. That makes is
quick and easy to review.

      
    Andrew

---
pw-bot: cr

