Return-Path: <netdev+bounces-115333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F9945E4E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAF91C210F2
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ABB1E3CB1;
	Fri,  2 Aug 2024 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZPF2CJ1e"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AF61BE87A;
	Fri,  2 Aug 2024 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603814; cv=none; b=oXHmjTt7f6mzO16P1Y6xXBitsrJFSFhjp29Cscu8S3dhlxGvYdXLJsXGpHjeMud0CWHWaHygMlMiVWbY5awMpxKBfkHJAxpBQLBZOkwuFhsjansFnwuNE1KAHLqWRdasM7eGJD6ptm2ZlUyn7w6bsMCL13jR9YpLzf39NnLJyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603814; c=relaxed/simple;
	bh=1sJEV4onMpCVNzcqhtUpkeyeGTA6x8K9PSLJHxhXT1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9n/Av8uKzWcZ9wQEHrYFyKl0ygnR9TEBn8wKj+1eXsVL+wdiJwZh6kTlgYh+D8fsFAcbLcs5Ex/zTp1XdU4QKGEXQZDJsZllVNTiL2HXaJjWViaqHTBg2aBDO7TOXQY7jkM+U11xhwWK8EyNA1LjwCKEz8NpiJyy62eOIWOzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZPF2CJ1e; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7RVA83cU8ESLcHxZ5wTxJamaEhxTh4YMiATBaCEo3x4=; b=ZPF2CJ1eeSYPYnq2geji0OKabR
	/73LaSgEF+hK1YWCOJ6Y2poRmQ33o+K361ECAEDNo1fvzgdTg9v2QOGuO1a1Eu1s5nL+eud0MbLGW
	8RcRJEG8DygewSKGVjPTW+KK0TlrXehnk98YOJcEi8RUiTk/QHV1RZnHOZEtdZ8epg8heDJ0i+Xnj
	IP+sgrWDeD4OYQ+ciimeDYUXQyzvG3XNOw1FgnRk8KYCGS9qTu19uKrWy0GJIEf2wpmcvKVipESE5
	I8JgWKbUxiwRkLMfl9End2b9+6gD8j5p+IdSUoH3c6CEIa418xr+gmO8AGp7JdMZRUWfyBhvxp+ai
	8aPRAb+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40470)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZrwJ-0006lN-0N;
	Fri, 02 Aug 2024 14:03:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZrwN-00083M-Hk; Fri, 02 Aug 2024 14:03:27 +0100
Date: Fri, 2 Aug 2024 14:03:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 6/6] net: phy: vitesse: repair vsc73xx autonegotiation
Message-ID: <ZqzZH4QB5NhPYDF3@shell.armlinux.org.uk>
References: <20240802080403.739509-1-paweldembicki@gmail.com>
 <20240802080403.739509-7-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802080403.739509-7-paweldembicki@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 02, 2024 at 10:04:03AM +0200, Pawel Dembicki wrote:
> When the vsc73xx mdio bus work properly, the generic autonegotiation
> configuration works well.
> 
> Vsc73xx have auto MDI-X disabled by default in forced mode. This commit
> enables it.

Why not implement proper MDI(-X) configuration support so that the user
can configure it as desired?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

