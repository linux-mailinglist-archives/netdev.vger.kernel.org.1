Return-Path: <netdev+bounces-287947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPMGHmW+BWpZaAIAu9opvQ
	(envelope-from <netdev+bounces-287947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:21:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F29541889
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15AAB300BD81
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F03D7D89;
	Thu, 14 May 2026 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B97BlKiF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A33630A4;
	Thu, 14 May 2026 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761277; cv=none; b=nklR/59USvocHsxyEOD75PwqKGsGnpV3hXeUoazRobUFHeoFjBrHt0nHPcpO0uX1G/jvzlb9kO9mnbNqUcWcUhXCx6pTlji7Q3W4qf5uuS3HHB2Rk+Ev0lk6BRAbctxSttt/Oh65wY2zDbC1Aer9fuWc4lw3yfvNCm1mZhKeVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761277; c=relaxed/simple;
	bh=khRa9McxbmLHTYp74Hoq8veFFCPgZN8lKtg5edbeejE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzmG9Q/cZGz6drptfQ3Ikn4iX479Wc348Nv87hKJ9WlRsK5IIc7bgJMAnSCY6URxCUrCpAosxQPkz/gkcD9ktzIcBjgd44Nk1bj8qHAxgeAIrIXfI90uVjoEYS2gtshO4wta7JNFPiMCjjm6A0EWYUXdsl4R8J1gRsNdzvYxloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B97BlKiF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=94Ic/9CsfFr/0ROJJfVe7Gx4bPx2TLQEhtf2mTZcMps=; b=B97BlKiF6k34mztIAQfNk/qG9I
	aqN+0LW1JPDaYz3xsxxM3YcuqGWI5IA7SKeMcqoK36g0DwIumWwpD06o6TwL6FgGHPlC2hq8S0rzV
	89lR403rrn5zNbC2TD7r9Tm2K+VdkAUOkJDlIW8pu8t5v8pa5kFu3btGpdXa0PxYDZzk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNV3o-002tvn-BL; Thu, 14 May 2026 14:21:04 +0200
Date: Thu, 14 May 2026 14:21:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/9] dt-bindings: net: add onsemi's S2500
 10BASE-T1S MACPHY
Message-ID: <785c24de-056d-42d6-b810-2656c94cfb41@lunn.ch>
References: <CY8PR02MB924920C8825C7AE5D22EFA4483382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20542d76-6f70-4c2d-9fef-0de620a8d6d1@lunn.ch>
 <CY8PR02MB924974BBC348DE4814DA3C7C83062@CY8PR02MB9249.namprd02.prod.outlook.com>
 <3c5aa072-9107-440c-820f-3f63aa3ac3e9@lunn.ch>
 <CY8PR02MB9249D14ADE162A6854C72B9783062@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249D14ADE162A6854C72B9783062@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: D2F29541889
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287947-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 11:53:07PM +0000, Selvamani Rajagopal wrote:
> 
> > > I believe this will affect the parameters passed to request_irq in oa_tc6.c. At present,
> > IRQF_TRIGGER_FALLING is used. It has to be changed to IRQF_TRIGGER_LOW.
> > > BTW, I did test with this configuration. Both edge triggered and active low, level
> > triggered seem to work, though technically it is supposed to be level triggered.
> > >
> > > My understanding is that I should submit this particular change to oa_tc6, to net, not
> > net-next as it falls under bug fix. Can you confirm?
> > 
> > Yes, this is a bug. Please submit it to net, and include a Fixes: tag.
> 
> Andrew,
> 
> I am preparing the patch for this issue.
> 
> Wondering who would fix this in the YAML file? The maintainers from the respective vendors ? The specific file in question is, microchip,lan8650.yaml.

You could use git blame to find out who added that part, and report
the issue to that person. Ask them if they have time to fix it.

Or just fix it yourself, and Cc: everybody who has touched that file.

    Andrew

