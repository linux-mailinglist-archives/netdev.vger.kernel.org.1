Return-Path: <netdev+bounces-270202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H3NIICCvmnERgMAu9opvQ
	(envelope-from <netdev+bounces-270202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 12:35:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BC12E507B
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 12:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E37300C590
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8E63845AA;
	Sat, 21 Mar 2026 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="JBTxTuoq";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="MoJ/Y0Lx"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8A38239F
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774092925; cv=none; b=SIoAYKMzPc6vJ3pOSBUpAw3U/8m6d3AI9MlVWAcdC12tYSJPIbJzYlFWNjW9oSy24vQoff0DI9VC0z4hlDrrcqsSmcmfcHzBmQSerEVsmaHqZ2WLXwjRaviXdDtbZzs+jXmNwjNwo2lLojHx/V99gOFKiyfsffKN4dA6xQo/Vn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774092925; c=relaxed/simple;
	bh=vhmWNKPiB/mKO7Ru842eR+sQk7KhhlixafZmDjPR/+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgv6vUgb534oRFqZS/GBCI5ayJAEDz2hn135dPfHWxrE4iMzFaHGjXiBbQUOiT26SIGOgTznvfRKsMk8vsYMffHPw04JPfFRJgOJcSoaZ3PI8Fn4dXEB7xBprgCUHgTncO2SgCzBXsQFWTfUiWvqhyTLWFouO5G9fYiv7c4nnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=JBTxTuoq; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=MoJ/Y0Lx; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
DKIM-Signature: a=rsa-sha256; b=JBTxTuoqOC8BVZEKlNyhrXPvQfON1zb6D6yLllkXg6r5Fy/JMfLZQ8EZZZP1a7xGx7qrOBfHazvpvS4TClu4osy6abGMR/CrL9/nOSClDzKs+reL9vHdYFRpepy3R8jC47JtlVjm2nSiwHNLnZrrQ9lm99sxLvNK638TSFmTYu7D7IKmm+WwQURpn8tN8rei0KtdUojScQ+6b8I2RboN4RDd9xwUFfKqxQotvpA/b4BrxDff8uUtmG+nvlTWj8ZUAiCEKCZqVjlmoNrYqrwnhi6/mQuANvNAgLkMLdPnGp806fhyLbu3yIgT4m1gpdVKF3SZ+poeJS8ruGENErZbWw==; s=purelymail3; d=tinyisr.com; v=1; bh=vhmWNKPiB/mKO7Ru842eR+sQk7KhhlixafZmDjPR/+o=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=MoJ/Y0Lxd0jzpXV1Qfk02GJeIxCTS4izNQtW+E3BfK1+Wt2eXFL72oHiKLerLsQaoDCbNo7hATeeexbF/EubzR259gz4iCWhbWsEzGnQIob5t8MzrI00fSt0rVN1zTcnovg8p6o4QtlWGeqkL09rykm0BLDc8Gxa+g9dVDypJEQcxq5UNhYukL1MH9YxQ49pTOr3TnMS902zVBxbYCFQb+q7i2HeD2YV8vmGQZ/bdYNZL7RyR+r8Nosc6pIosSGf4WN+l9CdqF0tGhqv04KMgEe5Oqn+R/8KZN6DWX74rdOAfBM5wsNNBBKg3nDpOK7N5LoxyqPfp2G5aMqfFG3reg==; s=purelymail3; d=purelymail.com; v=1; bh=vhmWNKPiB/mKO7Ru842eR+sQk7KhhlixafZmDjPR/+o=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1307170669;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 21 Mar 2026 11:35:09 +0000 (UTC)
Date: Sat, 21 Mar 2026 13:35:02 +0200
From: Joris Vaisvila <joey@tinyisr.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com
Subject: Re: [RFC v2 1/3] net: phy: mediatek: add phy driver for MT7628
 built-in Fast Ethernet PHYs
Message-ID: <ab6AYAnJleA4bIGt@archlinux>
References: <20260314150845.653866-1-joey@tinyisr.com>
 <20260314150845.653866-2-joey@tinyisr.com>
 <6e1ef5b2-b380-47d9-99ab-5fcbe4a68ccf@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e1ef5b2-b380-47d9-99ab-5fcbe4a68ccf@lunn.ch>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-270202-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purelymail.com:dkim,tinyisr.com:dkim]
X-Rspamd-Queue-Id: D1BC12E507B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew, thanks for the feedback.

On Tue, Mar 17, 2026 at 07:03:03PM +0100, Andrew Lunn wrote:
> > +config MEDIATEK_FE_SOC_PHY
> > +	tristate "MediaTek MT7628 SoC Ethernet PHYs"
> > +	select PHY_PACKAGE
> > +	help
> > +	  Support for MediaTek MT7628 built-in Fast Ethernet PHYs.
> > +
> 
> This file is sorted by tristate string.
> 
> It might be best to change:
> 
> config MEDIATEK_GE_SOC_PHY
> -        tristate "MediaTek SoC Ethernet PHYs"
> +        tristate "MediaTek SoC Gigabit Ethernet PHYs"
> 
> And then you can add
> 
> > +config MEDIATEK_FE_SOC_PHY
> > +	tristate "MediaTek SoC Fast Ethernet PHYs"
> 
> before?
> Also, why do you have `select PHY_PACKAGE`?

Will fix naming and sorting in v3. PHY_PACKAGE is not needed, remaint
from testing.

> >  obj-$(CONFIG_MEDIATEK_2P5GE_PHY)	+= mtk-2p5ge.o
> >  obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
> >  obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
> > +obj-$(CONFIG_MEDIATEK_FE_SOC_PHY)	+= mtk-fe-soc.o
> >  obj-$(CONFIG_MTK_NET_PHYLIB)		+= mtk-phy-lib.o
> 
> Please sort alphabetically. 

will fix in v3. 

> > +static struct phy_driver mtk_soc_fe_phy_driver[] = {
> > +	{
> > +		PHY_ID_MATCH_EXACT(MTK_FPHY_ID_MT7628),
> > +		.name = "MediaTek MT7628 PHY",
> > +		.config_init = mt7628_phy_config_init,
> > +		.config_intr = genphy_no_config_intr,
> > +		.handle_interrupt = genphy_handle_interrupt_no_ack,
> 
> How do interrupts work in this device? Has this been simply
> cut/pasted, or have interrupts been tested using these functions?
> 
> 	Andrew

Misunderstood the function and copied from other drivers, will re-test
and fix or remove in v3.

