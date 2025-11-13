Return-Path: <netdev+bounces-238516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F3CC5A4CE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DE0B4E12AA
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3823164D0;
	Thu, 13 Nov 2025 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZsyhuHUK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B42417F2
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763072344; cv=none; b=dfMKsMd2JrarPx8XIbDA4LhvhrW2gP4TcPLNLM+Qv8EeEMIpWhElGwLv1vrQ044TmgpXWAoHQKPbL3Sdpibloun4VTXOxZ31Jo2agM67l2EWwi9iz1N3mdNzYU1G+MBFHKRd+r59KCnSy4yMBOnqoDCOYlzU5/NQ0xokCjJgxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763072344; c=relaxed/simple;
	bh=zbYjQMKPgMgHRNP55C9THhmMNhxcnwuyrR/5rf+3FPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdfreLAyxcV+6hgbovV42bGNqoDKHRxd3tav/XvytEBOjAwrUZFBaKz9AJRN73CN6WguLuVde4vA8j9clN9mzHewXNSEggjO30mgkQrxcZB0C08PVdlMgql7Y+E3VCLZJ7LFYRITWy86sOYaQJFlOxa+AhH5jUEACckC6LmlNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZsyhuHUK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RLX4AaiRsz5YIEjGWHBCLj1F8mzOYT/KlbRC/mMJXns=; b=ZsyhuHUKkmXye0UIr4VGjfBfBj
	/SWqFE0Y7ttFVZ1+JvdAiGNZsiIOLhrLFzmEhgj06ZaAhve2qWqS6RqLRLD7BQRbgMnu6jGQHNpC1
	AktX8OA4o5RocvXzQfmSN0zIC2fnDye7G+DH39PKdK7UWgk5/sDHi56aCS9GfBT5eoJk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJfeW-00DvLe-Ok; Thu, 13 Nov 2025 23:18:52 +0100
Date: Thu, 13 Nov 2025 23:18:52 +0100
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
Message-ID: <f7d7ed12-0c52-4b82-80eb-948b77b0ddaf@lunn.ch>
References: <20251112055841.22984-1-jiawenwu@trustnetic.com>
 <20251112055841.22984-6-jiawenwu@trustnetic.com>
 <b7702efc-9994-4656-9d4e-29c2c8145ab3@linux.dev>
 <001401dc5444$3e897f60$bb9c7e20$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001401dc5444$3e897f60$bb9c7e20$@trustnetic.com>

> For 1-byte data, wx_host_interface_command() can be used to set 'return_data'
> to true, then page->data = buffer->data. For other cases, I think it would be more
> convenient to read directly from the mailbox registers.

For 1-byte data, you need to careful where it is used. All the sensor
values are u16 and you need to read a u16 otherwise you are not
guaranteed to get consistent upper/lower bytes.

So i would not recommend 1 byte read, unless you have an SFP module
which is known to be broken, and only supports 1 byte reads.

      Andrew

