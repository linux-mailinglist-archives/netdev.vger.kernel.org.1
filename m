Return-Path: <netdev+bounces-146804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D1F9D5F6D
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 14:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE28282166
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7433F1DE882;
	Fri, 22 Nov 2024 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2Yh0XAoU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080579FE
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280397; cv=none; b=gVLQhfbdlRtwkpfSOTum/OeFcucCEQPkyEPjxSQt2tiw4qpyaam3TnlfneA/+W+ADeCmQNHZQKg9dPARFDB2yeiEszCZFi58e2E/1pPmaf6ueqVTzNooY1zDt+jvpl9uEvn+CtIgE2gfCArOJMpwMPzryQW1085g5+Pd0gawe0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280397; c=relaxed/simple;
	bh=3sUel7FvA94u9JP8Ds4+wBLQyu6tgRKqOarwmdilsxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH6cymN85GRSuSDf9x/XrrhdfMXCGShAWJwE7B++txMmDBeYfYbe/d1u7WlsEBIhVjpdHVf8YL6IVLGvKxy2kiZYPhPc0WazMqnlHTK9r3PAX1nYXo5aq0kT6hF5LWZ5nglMjVKcQzaM5Qe4ks6Yus1rkekrWU8AUePFyXtUC60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2Yh0XAoU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SOMm7NVLGYwIMHlwfMfVM3VY1V5sj0f7y3kmnH8B9U0=; b=2Yh0XAoUHWuduR6CGJOG/mat7s
	vhYi1tGOTDAdFLIld5d+Innc5zgP005lX08jRCt6h0jvxUr7Wpo+iDr/UomodEkJm26fqzSC9fPqi
	OrpDwlYL87tTGU8DO3l8VXTEXAxFgUjNi01rJptxe0HnBht2a68PgoCCvozg0/cMxbZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tETGC-00E8cx-UI; Fri, 22 Nov 2024 13:59:44 +0100
Date: Fri, 22 Nov 2024 13:59:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: fix phy_ethtool_set_eee() incorrectly
 enabling LPI
Message-ID: <a33d5425-3ec4-4fcd-a555-b4c91ef0d42e@lunn.ch>
References: <E1tERjL-004Wax-En@rmk-PC.armlinux.org.uk>
 <Z0BpoCMcCQxTpbEb@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0BpoCMcCQxTpbEb@shell.armlinux.org.uk>

> Scrub that... this is inverted!

    Andrew

---
pw-bot: cr

