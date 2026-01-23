Return-Path: <netdev+bounces-252984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBfFBzD7c2mf0gAAu9opvQ
	(envelope-from <netdev+bounces-252984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:50:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A7A7B410
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BBC73006164
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE0D2C08BD;
	Fri, 23 Jan 2026 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qbnEgCpo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390361E7C2E;
	Fri, 23 Jan 2026 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769208621; cv=none; b=Sv3cXY+9eILNse74svUFXss7Q0+KPYvP1dcgbjQhX+N1BEMkzPqhFqdcr3F1QiCcCH2fEhCZS6rx7YBYUxfEwpWyamKzzVCBdNQwxrsn/IeA4AV2XRjLG+83L/p/Tl8Mlcc1/lCXY+z8e16gl24xonu+oputYUMjZtKe6qRBDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769208621; c=relaxed/simple;
	bh=c25JE6E90OGxTCehKloXvRktPvfs0r/GzNXgfEMjsE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djdmghv6LHetzaowCk+wxvS3pVGCb4/78pdyf3Qt5B1vfhOzEqve3PwvvPAYLi2Aww8ot174OkfuqZ7oveSyPCNtKuHTobwZYXg04zMreLPlVevA6XfLrz7O2BJwn2Lb7viv+zoYcUYIaJpC7rgKBP9d2NK9/YepF7I+tARogdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qbnEgCpo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s4Er0zT/x3JGGYtre073aj98uXZD5N/RD8sSkmVbnYs=; b=qbnEgCpoFLhFzzZcMFJUK9mDRC
	9Gnv+UqOrAOO/jjkhk/9FY0SDuoxHXxWL74ZCirhM/uHdGDV5a/MqN//c05q+2LNEAyHEUb4b4kUg
	E+YpvAqmfgcXaRLnrFCyeK+MDqKr02ND5/bNMojtrl6iq7BWL+bgyio0X2MRz6kbrGHI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjPya-004M6V-Tg; Fri, 23 Jan 2026 23:50:00 +0100
Date: Fri, 23 Jan 2026 23:50:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: phy: air_en8811h: factor out
 shareable code
Message-ID: <9743e516-20d1-4f73-a566-1fdd415d60a9@lunn.ch>
References: <20260123075817.1162068-1-bjorn@mork.no>
 <20260123075817.1162068-2-bjorn@mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123075817.1162068-2-bjorn@mork.no>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252984-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,makrotopia.org,nxp.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: B9A7A7B410
X-Rspamd-Action: no action

> -static int en8811h_read_status(struct phy_device *phydev)
> +static int en8811h_get_lpa(struct phy_device *phydev)
>  {
> -	struct en8811h_priv *priv = phydev->priv;
> -	u32 pbus_value;
> -	int ret, val;
> +	int ret;
>  
>  	ret = genphy_update_link(phydev);
>  	if (ret)

This call to genphy_update_link() means this function is doing more
than en8811h_get_lpa() would imply.

It is hard to see from just the patch, but it also seems to set the
state in phydev back to unknown defaults, and read the master/slave
status?

So i think it needs a better name.

	Andrew

