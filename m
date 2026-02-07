Return-Path: <netdev+bounces-257702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ILuIIynhmnHPgQAu9opvQ
	(envelope-from <netdev+bounces-257702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:46:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C31104B35
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DEF630166C4
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 02:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB5222652D;
	Sat,  7 Feb 2026 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxprUjBO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF9810F2;
	Sat,  7 Feb 2026 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770432390; cv=none; b=JYBJNkr33RH5stGiMYoxSoNL/Y5Xtcv3IAR3tT5/QIu7IoH/g0vU1JKF0/+RCqe4Kn0amyZKVZ3DilUWPx+0DmM2I3rPR7bpp668ZkQWs499j2JlxC8+psx245O30S0lVBdswRbE8/M6/4Md2bDQwP4RTIUZtN4mXSlJmcyJCK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770432390; c=relaxed/simple;
	bh=xnF3gvr+u8cVAyLNPYF6UOsQb077Z+bSPbEA8ISaEFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAxcPSrhDpfLW7uADarCr4WFKZ71otmKMg7sLXH2rxx40juvssnnClc5SpKfgsPhKamuAC2bhcf2Bzjx0E9X5YhO0XnGS1UeqdCRYOdI/xGxykcFZ9igxllkqrqV4yio7unM+T/gwHlwThZsQ+77dUll8rkc4Yh0Tc7oyVaGN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxprUjBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16F2C116C6;
	Sat,  7 Feb 2026 02:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770432390;
	bh=xnF3gvr+u8cVAyLNPYF6UOsQb077Z+bSPbEA8ISaEFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sxprUjBOpShFZ0sR6SCvTQpIn7ujdUYmL72naq04s29FhkQw9EYwtINZxIiQps7QW
	 qMpQtbGGaP2+JoSKZ3k+ZL8yM6IVm3wU9awSCYNjdG1dLeWo0Aiy1qJ2xI3ohsDbjd
	 stRQOV3HtER8a4ESCZV/mp6LREA8F6JMnk3BPERWdcLqblXwsjEiqrkiSpeMH5dccM
	 WweHXOjJqeF7NUnAA2JPG7wWKPtNDsPkigh66RLirmo/2msgqS548dDv/9zNjMsDIH
	 snR5WpJ6ciQFmYCHIKZJdDPxHzONIoEdnOH8G8pWNk3XBiGHXBZ5nWEXE3/OC6TwaG
	 zQniMfrvdvopw==
Date: Fri, 6 Feb 2026 18:46:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 conor+dt@kernel.org, krzk+dt@kernel.org, chad@monroe.io,
 devicetree@vger.kernel.org, lxu@maxlinear.com, frankwu@gmx.de,
 linux@armlinux.org.uk, john@phrozen.org, robh@kernel.org,
 cezary.wilmanski@adtran.com, hkallweit1@gmail.com, horms@kernel.org,
 edumazet@google.com, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 olteanv@gmail.com
Subject: Re: [net-next,v13,2/4] net: dsa: add tag format for MxL862xx
 switches
Message-ID: <20260206184627.774c7f71@kernel.org>
In-Reply-To: <aYVgVgf3nemHNSEF@makrotopia.org>
References: <82706bbd489b5c68699060630ec6577f9aefb849.1770211259.git.daniel@makrotopia.org>
	<20260206022134.3185316-1-kuba@kernel.org>
	<aYVgVgf3nemHNSEF@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257702-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,kernel.org,monroe.io,maxlinear.com,gmx.de,armlinux.org.uk,phrozen.org,adtran.com,gmail.com,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6C31104B35
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 03:30:30 +0000 Daniel Golle wrote:
> > > +
> > > +	/* provide additional space 'MXL862_HEADER_LEN' bytes */
> > > +	skb_push(skb, MXL862_HEADER_LEN);  
> > 
> > [ ... ]
> >   
> > > +	dsa_alloc_etype_header(skb, MXL862_HEADER_LEN);
> > > +
> > > +	/* special tag ingress */  
> >                       ^^^^^^^
> > 
> > This comment says "ingress" but mxl862_tag_xmit() is the TX/egress path.
> > Should this say "egress" instead?  
> 
> "ingress" is the perspective of the switch, and how the tag to be used
> to send frames from the host to the switch is called in the datasheet[1]

Maybe expand on the comment a bit? Or remove it?
Cause reading the code I was also consued why this is called ingress

