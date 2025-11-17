Return-Path: <netdev+bounces-239149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E387C648C7
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 912E134AF74
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F26730CD94;
	Mon, 17 Nov 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ckHbjgeR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E9438DF9
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387924; cv=none; b=Wxt/cthN8IydUB4Q2R402iQJE9uelPG9D/COEtCPHUoTmUzhOMI3pzH9Ml3ISwrmNA5l6C6lEp87MNSTayepEhyPqN78pPe3I2dQkJS8ilitjOSJqTTgbexiOADzDuhG94lM+9/HoASKvNjokP8wxRic4bduE+ggqOF4a6r9lME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387924; c=relaxed/simple;
	bh=F7+77cr+MWTy6fe2V6sZPwv7oxSaUooDkjOnnoK/ebo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxAg115166LS5F2VCxc+TzTskpdEkYOyCUUprljMLv+4e3gJtSccNoRdg+7Ln6+rwVvfrvm771rjg3SmFPYlXK0/vBQx80D8h1j3VCs2kRDfs+0WMyJ3KoXSi5MtcHVJVxPi8PW1OplQJKh331FqTCXcMZ4+rXuOCi5BYfjZxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ckHbjgeR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=I9cZ4veZF6BDdypEgqgpa1nLrGc8jvSYSUM7a4eCAd4=; b=ckHbjgeREZSepdgQW+qk0kBTlm
	3mJqbjd716szn3dwl3sjtsVlCeCOtGJDRbt8mjz6DeRV4gE0Vre+b4Ypg0YNEhgZMudk0KJaHSNHy
	wqNyB0eRYDCHDVOJ3QkvtvRnLMuafNNKVIJNCFdBjmdo8C21eS0UOqt0XsOtoQmX8TXk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKzkW-00EFRn-6p; Mon, 17 Nov 2025 14:58:32 +0100
Date: Mon, 17 Nov 2025 14:58:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Vadim Fedorenko' <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	'Andrew Lunn' <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	'Eric Dumazet' <edumazet@google.com>,
	'Jakub Kicinski' <kuba@kernel.org>,
	'Paolo Abeni' <pabeni@redhat.com>,
	'Russell King' <linux@armlinux.org.uk>,
	'Simon Horman' <horms@kernel.org>,
	'Jacob Keller' <jacob.e.keller@intel.com>,
	'Mengyuan Lou' <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next 5/5] net: txgbe: support getting module EEPROM
 by page
Message-ID: <d0dc3c1c-7567-4506-8d21-3e983f7742e6@lunn.ch>
References: <20251112055841.22984-1-jiawenwu@trustnetic.com>
 <20251112055841.22984-6-jiawenwu@trustnetic.com>
 <b7702efc-9994-4656-9d4e-29c2c8145ab3@linux.dev>
 <001401dc5444$3e897f60$bb9c7e20$@trustnetic.com>
 <f7d7ed12-0c52-4b82-80eb-948b77b0ddaf@lunn.ch>
 <012801dc5789$6ea20440$4be60cc0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012801dc5789$6ea20440$4be60cc0$@trustnetic.com>

On Mon, Nov 17, 2025 at 02:14:29PM +0800, Jiawen Wu wrote:
> On Fri, Nov 14, 2025 6:19 AM, Andrew Lunn wrote:
> > > For 1-byte data, wx_host_interface_command() can be used to set 'return_data'
> > > to true, then page->data = buffer->data. For other cases, I think it would be more
> > > convenient to read directly from the mailbox registers.
> > 
> > For 1-byte data, you need to careful where it is used. All the sensor
> > values are u16 and you need to read a u16 otherwise you are not
> > guaranteed to get consistent upper/lower bytes.
> > 
> > So i would not recommend 1 byte read, unless you have an SFP module
> > which is known to be broken, and only supports 1 byte reads.
> 
> Thanks for the reminder.
> 
> But when I use 'ethtool -m', .get_module_eeprom_by_page() is always
> invoked multiple times, with 'page->length = 1' in the first time.
 
What is important is that the sensors are read using multi-byte
transfers. I expect ethtool does that correctly. You can also have
your firmware do multi-byte reads by default, with word alignment, and
then just return the byte it asked for. I believe historically user
space would always ask for a 1/2 page and then just extract what it
wanted. Getting sections smaller than a 1/2 page is new.

	Andrew


