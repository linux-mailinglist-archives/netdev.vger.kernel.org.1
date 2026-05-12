Return-Path: <netdev+bounces-287187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLV2FHA+A2qr2AEAu9opvQ
	(envelope-from <netdev+bounces-287187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:51:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F1522F58
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 658323232F21
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5D63A71A1;
	Tue, 12 May 2026 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pJcZuYlK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA63A5984;
	Tue, 12 May 2026 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594554; cv=none; b=j1wnERF6JYKf/RYktos3z15PVQI4m/h0Wxraax+KLdOzgTIvpZQOOmIQzicPl82Nv74eifziPvwRTLzCDehH+aSmYVdo8bv1mHtSLt0wkThLL10etCmBWgVPcbwL9i7u+tPpBSsVVtpJXMME6KKyra9uucKrRb3vasTOw/E+2Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594554; c=relaxed/simple;
	bh=r4LhqCDOXCOIgOMtRFWNsqidjd2CmAB3hcLb7o5BO04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUYmfeNms1Mw16NCfH4qsS/a4RRSXzHSbR6wGQQPfO7kjkMnezTaKadxouoGJyfaRKjDx834tJ7oMkBMY/j2a7HRYp2PFnAdzXq1esL4DjnfYLKJNDNYb4QSjyLOA1Kn3EaItD4bay7j0xlkCTsAXQIo1A3NLSf5d5aTwrMFO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pJcZuYlK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9ct6ivuY+SOQDy0tlA0NuuDqdOfuD2l2mBFU84wV/1c=; b=pJcZuYlK8h/8RGhlQOWRkZhfgY
	wcso++R/MZaToJ7YfLbc3b8fu9l2WCB5cH6wD11muNqqg1AF2WNUIv+Y58RLAcJXmNFl8NefaiDUC
	7tEg1VqG7Ga7/olh3z65QXt8tEsEdCMk+1b5KKDJNZVdCz23XWLly2stMsDtQJetzZzY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMngf-002Z1I-2v; Tue, 12 May 2026 16:02:17 +0200
Date: Tue, 12 May 2026 16:02:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 5/9] net: ethernet: oa_tc6: Adding vendor
 specific MMS
Message-ID: <758c0984-c9a5-4eba-ac1d-a0d165328e5e@lunn.ch>
References: <CY8PR02MB924967FCDC5FE1A541D4DDC683382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <066bf036-715c-45d3-a817-f2719eb5d9d6@lunn.ch>
 <CY8PR02MB92490ED7D572EB0C124E4C1F83392@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92490ED7D572EB0C124E4C1F83392@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: DD2F1522F58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287187-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 04:57:01AM +0000, Selvamani Rajagopal wrote:
> [..]
> 
> > 
> > > -static int oa_tc6_get_phy_c45_mms(int devnum)
> > > +static int oa_tc6_get_phy_c45_mms(struct oa_tc6 *tc6, int devnum)
> > > {
> > > switch (devnum) {
> > > case MDIO_MMD_PCS:
> > > @@ -456,6 +470,8 @@ static int oa_tc6_get_phy_c45_mms(int devnum)
> > > return OA_TC6_PHY_C45_AUTO_NEG_MMS5;
> > > case MDIO_MMD_POWER_UNIT:
> > > return OA_TC6_PHY_C45_POWER_UNIT_MMS6;
> > > + case MDIO_MMD_VEND1:
> > > + return tc6->vend1_mms;
> > 
> > MMS 0 would be against the specification. So i would do
> > 
> > case MDIO_MMD_VEND1:
> > if (!tc6->vend1_mms)
> > return -EOPNOTSUPP;
> > return tc6->vend1_mms;
> > 
> > That should catch uses of VEND1 without first defining the mapping to
> > the MMS.
> 
> 
> vend1_mms is initialized to -EOPNOTSUPP in oa_tc6_init. So, it won't be 0 by default.

Ah, missed that. So this is O.K.

    Andrew

