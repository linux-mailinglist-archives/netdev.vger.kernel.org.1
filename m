Return-Path: <netdev+bounces-104580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1F90D7D7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BAC4B2FD87
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021D913C684;
	Tue, 18 Jun 2024 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0O/LhgeK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE3713AD04;
	Tue, 18 Jun 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722739; cv=none; b=Qn5pSQPW/fXXkyEXaNGGcKQ15XEQuT47H80ejF/mFi+mtwlOmWAjbE8HOMxwffT6/rGGzkwe6EWkVysgprGiMGTooM0iPoXj8fldLuvh+FlUHjFmGndl6ynJDSWNuV0kn2mo4B0niU3nnfRUVxj1ssQRbFC6KqE/WsQf7G0lV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722739; c=relaxed/simple;
	bh=zgleJRim5ue5MflARLo6K2lzadluugvyWKliF7w1E1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ0/+dCnMaNJOqApnP4v0aEtw6QitfGT+yQvgisJt1s4Ax/8/BdU4baZoPUZXHOoaRoLvENSSlyVjvWOuDkPZmfi22bwEs97psIA6hgrQQ2NQGduH/jGlpJEkg+QTc/PJKQLi5rHV0JQQXerEzJ4HvwCfqwJMKtWEmuwU4ObD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0O/LhgeK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E19MlYkqGa0m/nMlEgoSq9+/JQ4muSNNLLG6NbXSov0=; b=0O/LhgeKsH9Ep9q4UQ9In6qfTy
	nReupZV0d8/UsxyRqZ4kYEHrXMAfwjl8rBlfpCMFGmvkhqwfwhyfiLkDDhzRds2KTc/CsXRaFIMdD
	SUZR+4zdlH8qVV7VkkHBnxDFPaVort7x35bImb06FRTe/ClW8wsSRYxnEmUML5Es9EG0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sJaIF-000O6k-Gf; Tue, 18 Jun 2024 16:58:43 +0200
Date: Tue, 18 Jun 2024 16:58:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Woojung.Huh@microchip.com, dan.carpenter@linaro.org, olteanv@gmail.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net, o.rempel@pengutronix.de,
	Tristram.Ha@microchip.com, bigeasy@linutronix.de, horms@kernel.org,
	ricardo@marliere.net, casper.casan@gmail.com,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <6a011bd4-8494-4a6f-9ec4-723ab52c4fbf@lunn.ch>
References: <20240618130433.1111485-1-lukma@denx.de>
 <339031f6-e732-43b4-9e83-0e2098df65ef@moroto.mountain>
 <24b69bf0-03c9-414a-ac5d-ef82c2eed8f6@lunn.ch>
 <1e2529b4-41f2-4483-9b17-50c6410d8eab@moroto.mountain>
 <BL0PR11MB291397353642C808454F575CE7CE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <20240618164545.14817f7e@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618164545.14817f7e@wsk>

> For me the:
> 
> NL_SET_ERR_MSG_MOD(extack, "Cannot offload more than two ports (in
> use=0x%x)", dev->hsr_ports);
> 
> is fine - as it informs that no more HSR offloading is possible (and
> allows to SW based RedBox/HSR-SAN operation).

Does user space actually get to see it? I would expect the HSR code
sees the EOPNOTSUPP, does not consider it an fatal error, and return 0
to user space.

If userspace does see it, maybe we should make it clearer it is not an
actually error. 

"Cannot offload more than two ports, using software bridging"

so something similar.

   Andrew

