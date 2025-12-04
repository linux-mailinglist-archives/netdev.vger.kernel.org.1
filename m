Return-Path: <netdev+bounces-243573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12460CA3E19
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 301313126484
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA34A34251D;
	Thu,  4 Dec 2025 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MnqPnWcL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEFB33ADB2;
	Thu,  4 Dec 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855745; cv=none; b=L1y6eqcyCzrdgU9+GnOHCaxCZFLHGAvT1T5bAwChnflpXQRqaxyYPpcx876MM13E3AhyhXJ0nfFMxFocrGQ4khkMUX3P6aTHNG20qlAM50oRUR/Q7FVGNBGS5WF1fawEL4Scoch5I5ILUnGjcRCymoVMOjYw7wgB4o+2bU87qgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855745; c=relaxed/simple;
	bh=0QBIxkornRAYl1QNH+6I9sOdWSDJjkgjCRwRR8R3Ins=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMM5OT+QEKVsKTkhMQaNtHs3TmO0fPz9Vwf9R6WKO2Ee/vMaKpuhbkzU7D8RmUYAoAcfLzhl8xJa+dvYYMWXIzrj9q6fuFAWgILbINwTxlvgQuv++qkXdGTv8AWtwnQIulOU55gCtQvyPButWO99T0sejf5OnKhngUiILEb9Ofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MnqPnWcL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GxyximWtzVRSV0MiEQri65zT5T31mjqG9SdGu/HuZGs=; b=MnqPnWcLRdXTqSJtfPfW/Tsq0n
	cx+gGlKkAMJA5bCbH0Sc2quPHtfAfmjCR3/vhuYfmsV0q/5jxO7ulYTHQaIxnLjwG8w/fgTouEEYU
	VbiWEclAqzpHlAbA04dsPede3qQmeOvR4VITOFad7ERzpSmUtk2A98lPvnNmfb6JGxPU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vR9b5-00FyQJ-4W; Thu, 04 Dec 2025 14:42:15 +0100
Date: Thu, 4 Dec 2025 14:42:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Buesch <mb@bu3sch.de>,
	"John W. Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net] broadcom: b44: prevent uninitialized value usage
Message-ID: <fddbad2c-8274-43c7-9b9f-e4b304a1b77b@lunn.ch>
References: <20251204052243.5824-1-bigalex934@gmail.com>
 <a5236fe2-4e9b-49ef-9734-f3b60746896d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5236fe2-4e9b-49ef-9734-f3b60746896d@gmail.com>

> > +++ b/drivers/net/ethernet/broadcom/b44.c
> > @@ -1789,6 +1789,9 @@ static int b44_nway_reset(struct net_device *dev)
> >  	u32 bmcr;
> >  	int r;
> >  
> > +	if (bp->flags & B44_FLAG_EXTERNAL_PHY)
> > +		return 0;
> 
> Wouldn't the right fix here to call phy_ethtool_nway_reset(dev->phydev); instead
> of just returning 0? That way it properly restarts auto-negotiation even in this
> case.

Actually, yes. ksettings_set() etc do exactly that. Let me change my
Reviewed by into a Change Request.

Thanks
    Andrew

---
pw-bot: cr

