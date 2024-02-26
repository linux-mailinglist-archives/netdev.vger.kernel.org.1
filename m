Return-Path: <netdev+bounces-74932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C52867675
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 14:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79841F288C5
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268F8127B79;
	Mon, 26 Feb 2024 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a7SLieGQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C705127B61;
	Mon, 26 Feb 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954012; cv=none; b=WT6vIFIOGMWH9MuayJCIPJoCpOcj+ZZgXhHLFhImPX7aHJN3GVoYJG2NFuCec7VeO0gPhobFsGFbII69uijgy+Uo+SFsmOE9GO65cOBjsGzxkF1hTCNOZfYYaeupYJ6TbmtUfwwGhtL0hdrytmNSB5gQEHHVtOvLXcDpC90RZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954012; c=relaxed/simple;
	bh=IphFsRFxMVhZ61cZ8UUIX7Je4DogKb0uNFvZ10EsQLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEm4UnRcFtqbGDKi/mnC2pzmCRGrX/YRq9+3qgXHIgp1f4ZuW3FAg8UcJ5bLvC0K+nq4kKNxl5piIZb0YeqEuXmYE/oh38ceSMmMRLzJJSAGt25XZPNr7DM3VQJmGEz1oivmBUk61eF/fhqmQZB7GyOYpMIcHT4ZScxvDFYGoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a7SLieGQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=mtfy4ggJUxNso6vg9eGcQnD8vqVQf4ykVoEne4Mu/IQ=; b=a7
	SLieGQz/VMK2kw03iZ+Ma8iVcdL3xqh++eBf5Gr8BG+IC4Sad0hKnwL/VTTcCihSCudyY8UHtrilR
	MQJOblPdoWlf8A3ldXCdUH7ncRIB13ZfU1xD7Ka79FXZNJ+usAWUVCIziqi+p5YAlwe3TQhDtDVhT
	dHpU3nv3Sg5Pi+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1reb0U-008izt-Pu; Mon, 26 Feb 2024 14:26:58 +0100
Date: Mon, 26 Feb 2024 14:26:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen =?iso-8859-1?Q?B=E4tz?= <steffen@innosonix.de>
Cc: Fabio Estevam <festevam@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: mv88e6xxx: 6320/21 read cmode on
 serdes ports
Message-ID: <0235f06d-869c-49d7-ac39-38d450a243a8@lunn.ch>
References: <20240226091325.53986-1-steffen@innosonix.de>
 <20240226091325.53986-2-steffen@innosonix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226091325.53986-2-steffen@innosonix.de>

On Mon, Feb 26, 2024 at 10:13:24AM +0100, Steffen Bätz wrote:
> On the mv88e6320 and 6321 switch family, port 0/1 are serdes only ports.
> Modified the mv88e6352_get_port4_serdes_cmode function to pass a port
> number since the register set of the 6352 is equal on the 6320/21 families.
> 
> Signed-off-by: Steffen Bätz <steffen@innosonix.de>

It would be normal for a patch set to have a cover letter, patch 0/2
explaining the big picture. It might also help those doing stable
backports to see what both patches are needed and should be kept
together.

However, the patches will probably be accepted now, you don't need to
resend. Just please try to remember this for future patchsets.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

