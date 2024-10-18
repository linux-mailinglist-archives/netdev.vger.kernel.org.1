Return-Path: <netdev+bounces-136772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB199A31A2
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89601F23DA3
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 00:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462312A1CF;
	Fri, 18 Oct 2024 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lQRSf1Qp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08C20E338;
	Fri, 18 Oct 2024 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729210768; cv=none; b=OGnOZMuUc8qpbsx6UWvv4FyjBZim4xkPIle/kNKkTXyxwdleVaec+RSjlbfe8j9I3BjcBFWyal1Pj4dmMuBec9ouUoCdce5f7g6YQl3Z5bdtN62P231FCqxJuvJQa91WLTroJme6TmnC7s2fv8br/hawvGT7BaXjAWDguepHLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729210768; c=relaxed/simple;
	bh=rTqcUNGVnfj9W6FUophQNbie137j2/eeYAwVzYg9QPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGhefjO47btiwfi4TFdE4vMUdyCGVZP3JLE9prAFQR9pHxHSBFppyH4I7aQMt/73v74WFm2h1UPA8f6XfjBecoTAkXv3wOWQexzcttCfKq/GzZ6JcUeg4JVCRSonDEBbHqeUvRCNj2F7MkhsgYQY0Ybc4mUgW96OxJSwnwteX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lQRSf1Qp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y0dnA1gSsLh5bqvzMpUelAFboX+XZi2X6NulmPdY1Oo=; b=lQRSf1Qp0P/y5rcbkZGEChUJ/l
	1Uc9j4cwA2TslWBh1lY9Ay6vPbSK/+uQOeUk14RnyNLXMxEba1X+p24kmKef7z1NCst8z7XwuYtgw
	wfGIOqhNBRe4yrnLhlK6nHaocP9N3+cK0gKpmZlTQoiGZ1P4joeCoIX0nOGTkjT+JoEs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1ahv-00AI3Z-BN; Fri, 18 Oct 2024 02:19:07 +0200
Date: Fri, 18 Oct 2024 02:19:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Davey <Paul.Davey@alliedtelesis.co.nz>
Cc: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: aquantia: Add mdix config and
 reporting
Message-ID: <ec453754-3474-4824-b4e3-e26603e2e1d8@lunn.ch>
References: <20241017015407.256737-1-paul.davey@alliedtelesis.co.nz>
 <ZxD69GqiPcqOZK2w@makrotopia.org>
 <4e8d02f84d1ae996f6492f9c53bf90a6cc6ad32e.camel@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e8d02f84d1ae996f6492f9c53bf90a6cc6ad32e.camel@alliedtelesis.co.nz>

> Due to this I wonder whether the mdix configuration should reject
> ETH_TP_MDI_AUTO if auto-negotiation is disabled?

How does MDIX actually work? Is there anything in 802.3?

For 10BaseT, one pair Rx, one pair Tx, i guess you can find out by
just looking at the signal. But for 4 pairs?

    Andrew

---
pw-bot: cr

