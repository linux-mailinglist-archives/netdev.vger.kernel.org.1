Return-Path: <netdev+bounces-217550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A84B39049
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179291C21728
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A801A0B0E;
	Thu, 28 Aug 2025 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1zV19BfO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C343FC2;
	Thu, 28 Aug 2025 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342656; cv=none; b=gX5Kr5+q4FL2gnp8HJDaAWXDG1uqzekPA3ZoddJnn+j/1vYKdTfkNk37wCWmfKh7n8i3wObaDltnkVaPqCHt4Bd6OFR3MKa1CWRb99bOympY7XkDFmiSdkdfalS8lBomckpU6Q/1R//h07OUE/faos7+9O78FRuspHRLuOLoRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342656; c=relaxed/simple;
	bh=6mPLtQoKqpOktd+ClKqgL4/6I3IOdOTZcc8W80n9kKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnXMzbwT0K2HBJnPyYrhfUOVMl0XFuSa4lyK0gz///sRqQoZxhr0DEXu6qxLys19HrTOPb8WAYg0iXT5tSAmTXiuups9yl9SNP+5kVepdgDKLhMr7oS5pvvisxp9JCb+sgqcn5uQpctJ7r/0v48+qfsGcNfPiiJA8V5kz3g/iq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1zV19BfO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xzfvef7gPGFK4oJUVn+kGo0LXzZrJBEOwMpzo6EihUg=; b=1zV19BfOKEJmRvOVrOCbRXSH60
	o5rIulOlUj8qKpWEmx7g5iVg97SeWAdShHA7V7WMyE00+YQ9JL0yIVBYh2RX9kZaNiR3CcuyYWzwt
	ETmVULq2Xw2Bt9ruezkN276RV/LfpGKZ3BybDqE5CBkR0+ojry40imGYBY8MXFwAhyJY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urQx5-006HaH-1f; Thu, 28 Aug 2025 02:57:19 +0200
Date: Thu, 28 Aug 2025 02:57:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] net: usb: rtl8150: Fix uninit-value access in
 set_carrier().
Message-ID: <87ace089-0d1b-474b-aa9d-aed1e83062bc@lunn.ch>
References: <20250827233108.3768855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827233108.3768855-1-kuniyu@google.com>

On Wed, Aug 27, 2025 at 11:31:02PM +0000, Kuniyuki Iwashima wrote:
> syzbot reported set_carrier() accesses an uninitialised local var. [0]
> 
> get_registers() is a wrapper of usb_control_msg_recv(), which copies
> data to the passed buffer only when it returns 0.
> 
> Let's check the retval before accessing tmp in set_carrier().

	do {
		get_registers(dev, PHYCNT, 1, data);
	} while ((data[0] & PHY_GO) && (i++ < MII_TIMEOUT));

	if (i <= MII_TIMEOUT) {
		get_registers(dev, PHYDAT, 2, data);
		*reg = data[0] | (data[1] << 8);



	/* Get the CR contents. */
	get_registers(dev, CR, 1, &cr);
	/* Set the WEPROM bit (eeprom write enable). */
	cr |= 0x20;
	set_registers(dev, CR, 1, &cr);


	do {
		get_registers(dev, CR, 1, &data);
	} while ((data & 0x10) && --i);

Don't these also have the same problem?

    Andrew

---
pw-bot: cr

