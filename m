Return-Path: <netdev+bounces-184817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E74FAA974A8
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3038B176457
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B6A29617C;
	Tue, 22 Apr 2025 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DkDK0WpZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E228541A
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347832; cv=none; b=fAaDOsHlOIvjGkZkJVPEV0b7W5Zmb3nOLgt9dfh7df9L5gQtWmpGPxZH4eBvaPsejPhjJ+E7SMao9w0i5/2BTm1g5pkXrbkXoP4OmjjVHbYUY1wHUtuc6MrTa+YddkYek6Vug4yNODGN8d1aLmWgTNO37RarV0I5kDoE0q5gHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347832; c=relaxed/simple;
	bh=Tz7KWX/ahAGTd/J1CTSrrRjRv2EOpf9kdi604b3VeJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9nqpOs9H6Z3Ylw7ol9uK8JtBl5RR4fkoyMkwjOY3mLAkxwLuFOGu9seL7EkCkUlyh8gKL3IvSxFsifG5VLtNq6bDMvZ/qnzBnpClJMnKZP+WIB0aU5B4KKte+dnM8cFqjZ9/+yuEn1/Q1hz4vINhO1dXK1oWLkYTqrlCfj9nvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DkDK0WpZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=946FFN1l6+LGBo+OoDj3047BQNW+IvIkoCOxqblskVo=; b=DkDK0WpZY0Jq55ys8TbVlzWxDo
	7FL4DoCFgctofbZeLPPS/XasSY/wOAdC7qAqRiIG4YqvbSmcl1a8nW6LhgFByQGjWtsXwFaZJmNp8
	SJyXNNC/FW26A2j7EUZ1QH/vEGDxw0zmvGlt87DYaMYt+QRGemppebe5PUMmHHuRoYVRUeFfPWGxb
	+xTVc5E4197S/KAQekc3NHpxmTZE/u9JyRQrUOmklDSZvqBvMpGVgHDULuYx4ihX9uDIWJKGQjq0x
	bBT35uvtepoSnKeAJd2XhWeYOODkHJmY6NnH91k7CNXYp2F3/QvUZhvK/f/9NXCSDZqeHr9wuncnE
	hIa94nVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52366)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7IhK-0004sA-0y;
	Tue, 22 Apr 2025 19:50:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7IhH-0007iL-27;
	Tue, 22 Apr 2025 19:50:19 +0100
Date: Tue, 22 Apr 2025 19:50:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <aAfk662jTFj4iIQD@shell.armlinux.org.uk>
References: <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
 <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
 <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
 <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org>
 <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
 <20250422082806.6224c602@kernel.org>
 <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
 <aAfSMh_kNre5mxyT@shell.armlinux.org.uk>
 <e7815c91-e047-4b3e-b3e4-371f30c9dadd@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7815c91-e047-4b3e-b3e4-371f30c9dadd@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 22, 2025 at 08:13:43PM +0200, Andrew Lunn wrote:
> > Should one host have control, or should the BMC have control? I don't
> > actually know what you're talking about w.r.t. DSP0222 or whatever it
> > was, nor NC-SI - I don't have these documents.
> 
> I gave a reference to it a few email back in the conversation:
> 
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.2.0.pdf
> 
> Linux has an implementation of the protocol in net/nsci

Hmm. I don't think I have bandwidth to read that spec any time soon,
sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

