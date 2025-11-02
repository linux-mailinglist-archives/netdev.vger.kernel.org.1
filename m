Return-Path: <netdev+bounces-234902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 911FCC29138
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 16:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D4644E3392
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3EA1C8606;
	Sun,  2 Nov 2025 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WtFJQ013"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8C15530C;
	Sun,  2 Nov 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762098230; cv=none; b=D1wJekdXOUyA8ix/Ct0b2mTWOU24mAgT6iAAtqPNJLn7euzCujyDsseyf1/dQ4RK7mstfEOIxnbCLYN3+Pyab9OZNilB7dfTNZ6weUSFa5+hkYIdj3pslp5kdW7OhDoWlEr8xb7NOh01LeTYRqXt4jezC1GlfVtqjC95FvYBo5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762098230; c=relaxed/simple;
	bh=h6BasVFeFtaTtDB9pbkGSHGESYZ1kkemXHKVJlVIXXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZiBXgc483UDLVsbUkLjtI02wSPBQxKj350CpaWxqsBUq0KGUfNuZbDEJNu6Q6GmU1/5blCZpJisv5HOFIGSxs+tpbdLP1w2urKszTG6HD6aTbQ8NqBEQuTP6r95Hfe7HSrtFkAKP92a4P1w4//3Pt5BI/6kkODkmwVwvowSa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WtFJQ013; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TubJHecaX/LVXn2pAIeTV1oOK2OKy0C5can0RUDE4LI=; b=WtFJQ0131AWJKD033Yy39aCiDo
	OIfTEyLDPun8tfX4ICFGFzh1LRXi0QJS7TFjCDCLzGi4HJImlagMSPLMZVC7Db57MZwEkHCxJm6v0
	UuP/X3qC0jt+ZIBPcjg5afnmsXkgZ2wECpwAo5uXA3fbi7G7JKWmiZOeLgiiOBELSh/M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vFaF0-00ChwK-1B; Sun, 02 Nov 2025 16:43:38 +0100
Date: Sun, 2 Nov 2025 16:43:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michael@fossekall.de, daniel.braunwarth@kuka.com,
	rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jianhui Zhao <zhaojh329@gmail.com>
Subject: Re: [PATCH net-next] net: phy: realtek: add interrupt support for
 RTL8221B
Message-ID: <c9df0c51-5233-44ab-aa79-a765115615d9@lunn.ch>
References: <20251102152644.1676482-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102152644.1676482-1-olek2@wp.pl>

On Sun, Nov 02, 2025 at 04:26:37PM +0100, Aleksander Jan Bajkowski wrote:
> From: Jianhui Zhao <zhaojh329@gmail.com>
> 
> This commit introduces interrupt support for RTL8221B (C45 mode).
> Interrupts are mapped on the VEND2 page. VEND2 registers are only
> accessible via C45 reads and cannot be accessed by C45 over C22.
> 
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> [Enable only link state change interrupts]
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

