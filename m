Return-Path: <netdev+bounces-283647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIyJCNOO92kEjAIAu9opvQ
	(envelope-from <netdev+bounces-283647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:07:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA854B6E9F
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EA063008A58
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 18:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7581C39A04D;
	Sun,  3 May 2026 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f0y84LCN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA57C30C601;
	Sun,  3 May 2026 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777831629; cv=none; b=a/a/9ZH4v9k0BTBUFD3sdeYGCMHsaYtY4b9U3tG/hJgsjb0vqFl6mde2JbsHBJm3m+iFy5tb83E1G7xEV8xUOk/iDkz8IIrMXvBEfp6sRaYyDlZxIUmAyYUr+rfy/sDuFiDshXjAOuFZ8JrFNqRZDj6Er0kUp8+7YNEeZdFBBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777831629; c=relaxed/simple;
	bh=z3iLtrQiFxec3Rd27LagU6TBPvQ87gSXwve6orcuQyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2aMbaN1zEsJ5YuDhc+jxkI675G1Lm1YrXOPgtHr9CHRljnHstHthdsZbml6tMrZ7pr02yszez+sYydiFQaobZrGOfX97nJ2wBq8rUbzFWzHSGF73lCRCPW6AOHipSg0kb5IZSxPH8hO5W3fi2PFdjLlL/Wui4H3H+hkrGkfqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f0y84LCN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=77l6gcNF4966OHP0ggavWkcqsBmAcYVfrKG8lXEzGEA=; b=f0y84LCNDV8m5FQ65JijiZarcF
	SmSCqre93MdkQKCjgAEcNIj4nlfNJsykqyGvZDgI4vR9yL6tvdaJg2ZEkH6hf9z2erYGa0MA63auc
	1CGxFJcr9T2hEX0R09gwAGUS59c7Jp1MAC4Z9TVeKDW4UNXJMGg+fqrI+Tqi6+YdyNp0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJbDK-0019st-TC; Sun, 03 May 2026 20:06:46 +0200
Date: Sun, 3 May 2026 20:06:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: "ciprian.regus@analog.com" <ciprian.regus@analog.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 2/5] net: ethernet: oa_tc6: Allow custom mii_bus
Message-ID: <77df32ed-3e22-4e9b-941b-3046de25b88f@lunn.ch>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-2-dd043cdd88f0@analog.com>
 <aad9cb98-8f1f-409f-8d58-0318e125210c@lunn.ch>
 <CY8PR02MB92498A398D3F05B94EEB7ED383302@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92498A398D3F05B94EEB7ED383302@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: BBA854B6E9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283647-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[analog.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> > This all seems pretty invasive and ugly. Please could you think what
> > happens if instead of passing in an mdiobus, you pass a phydev. Is the
> > change to the core simpler and cleaner?
> > 
> > Andrew
> 

> Kind of agree. Initially we were thinking about changing the
> existing code (Microchip's vendor code) to alloc mii_bus so that
> code would be same across multiple vendors. Either way, it would be
> invasive changes. So, we decide to go with minimal change to other
> vendor's code.

That would be wrong. The standard defines this, so it should be in the
core. Anything which the standard defines should be in the core, so
that drivers for hardware which actually follow the standard are
minimal. Also, we try to keep workarounds for broken hardware out of
the core, hide it in the driver. That is not always possible, but the
aim should be to make the core clean. We don't want to penalise
vendors which got the implementation correct because of vendors who
got is wrong.

> Trying to understand your suggestion. Are you suggesting to move
> entire mii_bus allocation/APIs implementation to vendor side and
> keep only phy dev usage in oa_tc6.c?

No. I'm thinking maybe extend oa_tc6_init, similar to what you
did. Add a quirks flag, and define TC6_QUIRK_BROKEN_PHY. And allow a
phydev to be passed as well.

If the quirk is set, don't call oa_tc6_mdiobus_register() or
phy_find_first(), nor oa_tc6_mdiobus_unregister().

You probably want to start with a patch which breaks oa_tc6_phy_init()
into two, since you still need the phy_connect_direct() and
phy_attached_info(). Then add the quirk, and lastly your driver making
use of the quirk.

The quirks flag could also be used for devices which have MMD 30
mapped into a vendor reserved MMS.

	Andrew


