Return-Path: <netdev+bounces-66551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA7D83FB26
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 01:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56A91F23564
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 00:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E35F19C;
	Mon, 29 Jan 2024 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qu4Y9uBj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059218F
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706487065; cv=none; b=SKn281l2Qz+D2bTF1vPnsUqujMGz1ALZI6yMHAWDRj3AECpb4eBU3l0w1tmG3NCyPb6n+h3eDpXoB5/pLeFt8Xwu7fRSZfRLUBmtsxv+NoWw+bhlMGwKYZpDHJZuT9mndOmrCAgMcl+f3Gpmw0yAMkKL/PhvJlbAzXUs5aJIDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706487065; c=relaxed/simple;
	bh=Wy9BEbS+QfjLOM0fFEVjBSMTV/sObSTOkTxtSb76aQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To+tIGwdwS9Cr+uJnNvAyfaNcZHAwuZSNjsMvTIgFlGZR1ri0kYlsA7lLgQt5PbeVOyV0tQZMSlzho0can6D2+X7CrpyjFstHji+QfNBzW7P/WBOowQ4Fs6VuhyhDso4S2PyHU+tldNxAIajO7OeznIlTYmy9OU/GrBV0/X43ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qu4Y9uBj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fSLtR9GNiaWDMw/YGMS2bynCix2ZWA6Y5H8nlGsJeZI=; b=Qu4Y9uBjIenZZduaxhSiHdqbc7
	NBluk31RQl+N2B8d1AsZgWkEtekdcejs6thPIJNNNIUccHAfYsSvbGLd81DQXyvdMC4NJ8n0nPFpc
	MGVhCXlfgtX/YvGISsBbYkP5H9qhp/j78oVmWU4gssrrPRxjPn9vaB/mRYSqhXi2fqrY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUFEl-006KpK-Eb; Mon, 29 Jan 2024 01:10:55 +0100
Date: Mon, 29 Jan 2024 01:10:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 6/6] net: phy: c45: change
 genphy_c45_ethtool_[get|set]_eee to use EEE linkmode bitmaps
Message-ID: <3e8e2997-56d5-4f69-be25-910892033e05@lunn.ch>
References: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
 <5047dcc7-534c-4570-97d2-9ed4f4397406@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5047dcc7-534c-4570-97d2-9ed4f4397406@gmail.com>

On Sat, Jan 27, 2024 at 02:30:29PM +0100, Heiner Kallweit wrote:
> Change genphy_c45_ethtool_[get|set]_eee to use EEE linkmode bitmaps.
> This is a prerequisite for adding support for EEE modes beyond bit 31.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

