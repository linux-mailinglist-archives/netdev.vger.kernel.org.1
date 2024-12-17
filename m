Return-Path: <netdev+bounces-152553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0B19F48F6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809CA1891088
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5929C1E283C;
	Tue, 17 Dec 2024 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y06oQb9L"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F61DF965;
	Tue, 17 Dec 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431683; cv=none; b=U/Fk31bbfvBOBNqee19hqFdhzjiZ8uZCKW2kj8sE1i5pORa54DN2Eob7EY1QZnJqv9bFSyiXSyI9HgMJU7a9giE9NG/2Utp+I0lFBpIUKxBjthYlO2LGt77UG1AkW3H8SwCO2ysAKitd/ZSgUxSYOviPbnTf8idbI2XtinpFu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431683; c=relaxed/simple;
	bh=bsG8E+NQlQ89DExRuV4aAOE9GZbAkNyr2uTX4R1AbFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWn1HPJYc6BSN1hFGFCf7QxRm5d4T3eycYYY9IqetTvKKRdaRfLGjU2SWwbq9onX5NeROO39SJVMjQbdZ+qaTKPeL16XG/QOhSyiHzow1OlRnJBFKH7gSNx4zqRwHWEQty9SmiaA1RBxkp63v5rS6VbS+emoYk0ROwEi3hAiyg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y06oQb9L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s5x22FnseplimmyLObaPH/sHivfgRY4YDRRIuXLUvyU=; b=y06oQb9L8iIlqY5Z8w/7oE0CRR
	3+sYh+XfSBJIlMf4nuDDhn3EoDcqRKZ0XySNz1wenUD8C2z4mO91j/ZSPjA6dzJMC7vF0+/TBH5NQ
	AMLLSDNsirMZXCiqhTAMvUjxHt4wKKNzItkhUAw9SJjzgSvQ9UoNOIyzh+juBwk1eZ9k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNUuM-000v4k-7U; Tue, 17 Dec 2024 11:34:30 +0100
Date: Tue, 17 Dec 2024 11:34:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tarun.Alle@microchip.com
Cc: Arun.Ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: microchip_t1: Auto-negotiation
 support for LAN887x
Message-ID: <d04abb91-b77f-4d29-a89c-c00ffa68595c@lunn.ch>
References: <20241216155830.501596-1-Tarun.Alle@microchip.com>
 <20241216155830.501596-3-Tarun.Alle@microchip.com>
 <fb90188f-0f9d-4c6f-b5cd-800461dc4626@lunn.ch>
 <CY5PR11MB6234815EB819D321645984708B042@CY5PR11MB6234.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6234815EB819D321645984708B042@CY5PR11MB6234.namprd11.prod.outlook.com>

> We confirmed that there are no customers who are directly using the net-next. 
> Hence, we are setting this to default auto-neg which is also chip default. But if
> any regressions on T1PHYs are dependent,  we will address this default setting.

So this needs to be communicated, to avoid this sort of back and forth
with emails. It is not the first time we have changed a default like
this, after asking the early adopters if it will be an issue, but we
need to make it clear we have done our due diligence before making a
breaking change.

> > I think we also need some more details about the autoneg in the commit
> > message. When used against a standards conforming 100M PHY, negotiation
> > will fail by default, because this PHY is not conformant with 100M, or 1G
> > autoneg.
> 
> I should have given the same errata details in the commit message. Will take care.
> 
> > I don't like you are going to cause regressions, especially when you have decided
> > regressions are worth it for a half broken autoneg.
> > 
> > I actually think it should default to fixed, as it is today. Maybe with the option to
> > enable the broken autoneg. This is different to all PHYs we have today, but we try
> > hard to avoid regressions.
> > 
> > What are the plans for this PHY? Will there be a new revision soon which fixes
> > the broken autoneg? Maybe you should forget about autoneg for this revision
> > of this PHY, it is too broken, and wait for the next revision which actually
> > conforms to the standard?
> > 
> 
> I understand your point and I agree with you. We can drop this patch for this chip 
> revision as we have plans for new revision.

I would probably drop this patch if the new revision is coming soon.

	Andrew

