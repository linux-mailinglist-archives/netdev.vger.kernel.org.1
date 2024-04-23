Return-Path: <netdev+bounces-90682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9FB8AF8CD
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 23:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C4290BAE
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 21:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C323143860;
	Tue, 23 Apr 2024 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ves3E2I0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497B5142624;
	Tue, 23 Apr 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713906998; cv=none; b=iNqFXy+wq3RaDbydIK7Qv1k+efn9YvZOajIRsoGldJNjIhHKM8PkFUdh2zJyj3AUda3ftpcphriUzueXf4sUo0A/isWcZWqFIyVJk+TCS0/fOxM51eHDYXoBChR4YPgFdK0YY88e7DQ+4kthXeKufuxVsHg8/V7ZqpuYWns3P+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713906998; c=relaxed/simple;
	bh=JGQEPIZaHXeikM4Tk76pEXGRiC7713fWE7+iNxo/Jyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKLuDRyN7ejboFh4sKJ61rbvOO+NPpSgM4bxYrQ77WCFYiw8q7fGQt5U5D0qf9xuvIoXyhk88PzjTzNZXvnz0TO2KCzxe4G42r8gRennZjDzUw77/qRjv21HCXdMhLoMNK/9oBQrv6evy/YH3/7k80pqJ0RC0JRqLZ/y8Q1vBZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ves3E2I0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y5R12QiV7DpuvpeduE378DEur4+YnhQS9T1MG7wqbfY=; b=Ves3E2I0CjNh6iW9kvNwds/a8j
	hEnafItIzpsovcojZIOxJCubSbfkOwl5SvdYWMLNa96pETZ6f60BconY0GBBiJor+HDYnxv3DaOpU
	bcaWe9uLzDEon1Z+p/2RBXGzP6CeA+Eh/pV3uEayARWnwvtUULbO9f7LUbTDfRwHh7CaAkzWNqLhl
	CaLtXtNOS7bNxEZiRW24xHcg6DuzxuQtNrE5ru7pgezvlXdHk63nPoCAfNkOx3KhO15szNQEXZvjo
	22+A5Y2FSB3C4IHvkXkx1Xiuhncin4W0oBCTz6ZYTZUciZUd0mIJGciwcOqOzkJ9H6OUbo0FlOJPn
	ikGj9rEA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46130)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rzNV6-00056m-1x;
	Tue, 23 Apr 2024 22:16:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rzNV5-0003gl-8X; Tue, 23 Apr 2024 22:16:27 +0100
Date: Tue, 23 Apr 2024 22:16:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/8] net: dsa: b53: Remove adjust_link
Message-ID: <ZiglK1pD9ZBzBflo@shell.armlinux.org.uk>
References: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
 <ZigIkdr/FEmBZRLP@shell.armlinux.org.uk>
 <9df504be-e907-437f-8f26-6e2cbb3997a2@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df504be-e907-437f-8f26-6e2cbb3997a2@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 23, 2024 at 12:15:49PM -0700, Florian Fainelli wrote:
> And thank you for the reminder this needed to be done, once this lands I
> will submit the removal of the adjust_link within net/dsa/, unless you have
> that queued up already ready to go?

I don't have that queued up, but it would be great to get that done as
well. I think it would get rid of a reasonable amount of code in
net/dsa?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

