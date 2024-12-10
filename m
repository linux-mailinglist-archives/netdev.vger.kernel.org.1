Return-Path: <netdev+bounces-150481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2C09EA67E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A9E1662C0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF761C242C;
	Tue, 10 Dec 2024 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YxNtH+RT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB0C13AC1
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733800734; cv=none; b=hOhPs/gRe94VtVn08bhq0NrZEpkyxhKVhVzzLMiig7Rgtd013BsbC8lulObhuaN0A5t/XlJMtiEfVhBNWZlqQoEyJt60rDszSgEaaWsSjniWyG/oL3w4zu9rW6nzwB1FFp6ZOhPgObp8/jyT851gLzOp0FOjFrkEeqlBqVxDPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733800734; c=relaxed/simple;
	bh=ap/USz/I5h1mZkHq3u5w7TP4h2O1FQq+smj7xzeJzHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUXUG7tsyJiPWEVnwrTRtfFn9MpLmvwD9GTdt5AA9tIyH66oD5hiKwLyHnDuWqUFtYwKJmnWYDce43ZnEy9bDUXNbubDWx9RDzY+aGZ9snUL9JTHxUae+lAzmX0b9O4/82ygCZZhzh0/Q8UOpDlKPLJp7POVZkqr8rfssspzLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YxNtH+RT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NVWOoR1kCGl2hi3Z7O92k1fPaw1aE7AMhpdPyOY55to=; b=YxNtH+RTJITq9aFxNU9Q55+jb7
	b/didsIzkIbjnZjgDIE2yQBgmcCDT8mhwAlRbWyghNLYzGLPRjDGGTWAXJDDDQJeOd1G0ZorZdiej
	5hTKi9C7kOCaflV/gh/Pv4uHp2h2iK+lC/Tt8IbZ4NQW2tdyMIAAeWsSC0sbVrUwnnBk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKqlo-00FkWV-In; Tue, 10 Dec 2024 04:18:44 +0100
Date: Tue, 10 Dec 2024 04:18:44 +0100
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
Subject: Re: [PATCH net-next 05/10] net: phylink: add EEE management
Message-ID: <b7c4d3ba-6ba7-4eba-bb2a-c6b7e3adda16@lunn.ch>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefi-006SMp-Hw@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKefi-006SMp-Hw@rmk-PC.armlinux.org.uk>

> It will also call into the MAC driver when LPI needs to be enabled or
> disabled, with the expectation that the MAC have LPI disabled during
> probe.

How important is this expectation? I don't see it documented anywhere.

	Andrew

