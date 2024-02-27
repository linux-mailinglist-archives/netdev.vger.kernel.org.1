Return-Path: <netdev+bounces-75260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C5868DD0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D41F1F23315
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864813958D;
	Tue, 27 Feb 2024 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zkpd+iLa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC788139579
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030313; cv=none; b=SvtkxId0DVwPOoy3pLnB7OaXsZ7uyr1plGTT7QQvXLYcJzpbKFLwA8NkyhTRX5eLKHfXM+/TaSOFf/hZSeBJ5LplRb0clAeSNFM3YnrMVeV8ka5nNPq7vvBqlgIkDgAXmyu/Exd4cM30grl++nw1onikGMzvrUafAPNGu5EoaiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030313; c=relaxed/simple;
	bh=gDlLNQSYlqqwvxxz3w5RwFPbPAPXK8H1RZHeSjflhHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un5F8YMswTu+SUjF/Kb+vBGc/9rRJCOyj+r7Vphzm2nqHttr2fyTMg5ykTz1pCkV8dBbONV091zjX/LwN84Qcfvy8nPOKizQ6WGUKL4Px2oGYnUsrKumk/Y4Roga3xTs5QQqIG5FZWse1bDzfoESTy2jspyjAorb+bYjsUu+6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zkpd+iLa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GSgJv8giFtMpGQa80dmIaJqV7I/A0OnWw6edcYlSQJs=; b=zkpd+iLaP/v30OXDpWRyqG/ORi
	u/W3YxE5Tl0WQ481jLW/qqF5C05Nm7pqlqEA/HQwq4tQ6XiGzCw6hyagupBekNKy3U/Pg2aQ3HpsR
	T3sdzyOVFx0U6PTgHFxA2bJ0X/Xki9dPML6k5va8b1MaIi9xdJEhddtTb/yTqUCFyeeC2XnDgdaiD
	tcu4wPOpAZ8T1ZP0oEdCOfuBKW52sAg5+MZHSC2v79h3NUz7aEBZ+EXkBnM2wthTTGOGXklXMOWI6
	af465pkolT7IUWMiNkDcbAq5UKSzkQ7/LqyFh78UgF+RvjbOGILjq4OSd6X6TKybB19A8S8aclzRN
	4xqDNTKA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38748)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reuqu-0007o1-0L;
	Tue, 27 Feb 2024 10:38:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reuqt-0007Jo-Eg; Tue, 27 Feb 2024 10:38:23 +0000
Date: Tue, 27 Feb 2024 10:38:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/6] net: phy: realtek: rtlgen_get_speed():
 Pass register value as argument
Message-ID: <Zd27n3Yq4HSF6t0d@shell.armlinux.org.uk>
References: <20240227075151.793496-1-ericwouds@gmail.com>
 <20240227075151.793496-4-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227075151.793496-4-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 27, 2024 at 08:51:48AM +0100, Eric Woudstra wrote:
> The value of the register to determine the speed, is retrieved
> differently when using Clause 45 only.
> 
> To use the rtlgen_get_speed() function in this case, pass the value of the
> register as argument to rtlgen_get_speed().

Nit: I'd suggest something like rtlgen_decode_speed() as it's decoding
the register value to a speed.

> The function would then always return 0, so change it to void.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

