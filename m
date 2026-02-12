Return-Path: <netdev+bounces-258456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELxfLmfQjWnw7QAAu9opvQ
	(envelope-from <netdev+bounces-258456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 14:06:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0277512DB8D
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 14:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41A9B300E5A4
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1CE2FDC55;
	Thu, 12 Feb 2026 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l8HhaHtI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2A3EBF24;
	Thu, 12 Feb 2026 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770901603; cv=none; b=t0H8nEh2EL34U59Rr++RgvVQZzqhvkPhCsOZqO+FzudXa6uFsG6zFlK4x5wavpf+TNXmhfMYB9ljCD6HR9a1pL/gd/0gCF4ZX9an2FgiFrp9Jjmnej0+Wv/qIA0dEPHsrLPbfiTWfiTig8utG/4KwLfYUQVCMdW62ydbZytUe9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770901603; c=relaxed/simple;
	bh=DMUloXjb0y36sy3Di/uSO18uVDh/y5Xp8gF3xe62sRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqfDBRb8PonTb3sA98SxXgwLH3QbYdueOTViEGK1sxQfimSs4fgfNLInjERUP0FDOVF9xkX/jbOOv+47jjQbb0sn3C7ZYfV1SBLAlbCKsBprtcGLd4gJewD8gEgYEih294e04ff7NyArbCRZTC2XpkF6P7l0c7cqB71X9TzHzNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l8HhaHtI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Psmc30ZDAOoov5ut+1EIkPVtL/ykRMSwHnd0XHg9zvI=; b=l8HhaHtI9KrELgVO4/p/n13zFC
	gfPDIEogbwkca/x2SE9Iww+vniRnSOxvPvwHkopu3d5qHjxMjly7EQPNJHr2ezFEVD+Du/E6rfMBU
	SskMYiJu6pQQhqqMu20Nrg9temkmAG7DcpioBwVA2DnyzVPwmH6pYIZpfwrHXXm4+Of8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vqWOt-0077nc-BG; Thu, 12 Feb 2026 14:06:31 +0100
Date: Thu, 12 Feb 2026 14:06:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Meghana Malladi <m-malladi@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, linux@armlinux.org.uk, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net] net: phy: dp83869: Set auto mdix bit for forced
 100Base-Tx mode
Message-ID: <9a256949-56ee-4d10-949e-c5009852ca44@lunn.ch>
References: <20260211131033.2525617-1-m-malladi@ti.com>
 <0a9d0ec8-09c4-4029-8449-8c8f08c6dca0@lunn.ch>
 <a498b310-29f1-4775-aa65-fda027a3124b@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a498b310-29f1-4775-aa65-fda027a3124b@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258456-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,vger.kernel.org,ti.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0277512DB8D
X-Rspamd-Action: no action

> > What about when you change the configuration out of forced 100 Full?
> > Shouldn't the configuration be returned to how the user wants
> > auto-MDIX configured? Should you disable robust Auto-MDIX so that
> > "unreliable Auto-MDIX" is used?
> 
> This bit is only necessary if link partners are configured to operational
> modes that not supported by normal Auto MDI/MDIX mode (when one of that link
> partners are in Forced 100Base-TX), will fix it in v2.

Does this bit have any effect on normal Auto MDI/MDIX mode? Can this
bit be set once during probe, rather than for a specific link mode?

Is there an errata for this behaviour/fix? If there is please
reference the number/document etc.

Since this is a fix, please add a Fixes: tag.

    Andrew

