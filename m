Return-Path: <netdev+bounces-150476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E9E9EA624
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F701656E0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EE4198A37;
	Tue, 10 Dec 2024 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oDWwRKtK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665B5208A7
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733799789; cv=none; b=j7ujNVyRhseS8rDby57jQLq06lQN6Y72sdgb84dN0rshn8H7xgloSJNkXhPdnH5KhodGjaWW8tqZ7n0VuPp/b0a0JeFpl4sQk8UtidpigF+nh05lQO0207XJIf4rSdjPMiLuWIriK7UWVL13j4KEh7vb6aOiAmCbHkTD4mzXgiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733799789; c=relaxed/simple;
	bh=aZxk0knTY2TfucKcQlcet4dL5ciS0SPfcSJOsSSgQo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4yuILqQgqEM7bO80cv5U/k6SH7JxbLO0qShXTns2Q2sqbZq6Xto3JJUkNPdj7c+eys8RUgaEowmFVeszOeDcUFKgAR3BdtYFCz+q+WrGJZYnf4L0aDcqA4s4KLn/dZ0i8yQ2V2Zj58apZ4q/Aj5jyPTe5BfzuBD+dtstrqhSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oDWwRKtK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2TYTs0Y5X3+cd9w3pHEMeOYB8irsj7v/dD8tzDE8pJM=; b=oDWwRKtKIhQ/JBugoCeseJ44Hf
	T2kWSwxokJAEOiUHzFWQnm8G8RaRz/9C0IEiaOyFDqbMcJq/IUAn7BMtIKX69SnvsHjt0SUbf0eXs
	1S0wUkwifQh5An+1pwXBACbbOJebp44ctKgGMilRgPUOD3dLs7hiS/+Q3hythd6as/Fk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKqWb-00FkSE-AS; Tue, 10 Dec 2024 04:03:01 +0100
Date: Tue, 10 Dec 2024 04:03:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 03/10] net: phy: add configuration of rx clock
 stop mode
Message-ID: <7e0713e6-9039-4d1b-bb85-c2cbe6ddb499@lunn.ch>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefY-006SMd-Af@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKefY-006SMd-Af@rmk-PC.armlinux.org.uk>

On Mon, Dec 09, 2024 at 02:23:28PM +0000, Russell King (Oracle) wrote:
> Add a function to allow configuration of the PCS's clock stop enable
> bit, used to configure whether the xMII receive clock can be stopped
> during LPI mode.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

