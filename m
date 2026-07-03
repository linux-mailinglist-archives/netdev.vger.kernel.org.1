Return-Path: <netdev+bounces-304546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2w13EWK3R2oFeAAAu9opvQ
	(envelope-from <netdev+bounces-304546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:21:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 425B7702CBE
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:21:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="zy OXNe7";
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304546-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304546-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D6E83010D22
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3473D566D;
	Fri,  3 Jul 2026 13:12:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FA032E729;
	Fri,  3 Jul 2026 13:12:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084332; cv=none; b=r2UAJ5l511HG9gGgxiLkdRzPWRMDmQgrjnxnHYBP3/GYmh3IK+LAGwlLdmy4N6fbXh5CAkjf+ddrnEhyFBA50BVkbdrKlhw6o2hiP4fNpK/vdL4UbQLoOWtEcZ2NMz8HzdHcvIeQyjyEhx/YMzsprHDLiitjb0HFCIZ0eWRXSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084332; c=relaxed/simple;
	bh=Z/2Hnfc9GB/OzugUkItSrufn1TDkO6pWeaSjkfUWplU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4pjAYVQctKWq+SAi6/khYVTL0Q5BsfMPCQyWFvAtQX6Lu4SClXui/YfhBKSjOGkbb6KF/g38GMnT84kpWwe6cVD/JZuKHvt4auQPLCVLbh+XOUf9qkSi5Htc1IxvOKu1Td9vuW3NC48W4UWHD9O5YrO0jQLbrB7sj3+TfW5Bp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zyOXNe7e; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Y2MPRqkyRTH14QDFfn7C5hyRL84ni46rfcjThNuG8gw=; b=zy
	OXNe7enBL7WJDeN2aiPcHmlb5eLtMLuRE/p5xz5u3N3rebEjIzZ3X5gBn9Jejpb3BQxiFtJY5vzN9
	nSl14zAnUCJz7XSx+u7QqMftzrzkCRGlbWerphQYl1Um8wFA/2fGuPXEHa+bX/2L21aBSX++LsnkE
	8sZbOQC4HlAXbB8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfdgW-00AYBV-MI; Fri, 03 Jul 2026 15:12:00 +0200
Date: Fri, 3 Jul 2026 15:12:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Nazle Asmade, Muhammad Nazim Amirul" <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: "dinguyen@kernel.org" <dinguyen@kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Message-ID: <bf7c6343-e0c0-47bd-a857-0f1881fc8659@lunn.ch>
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <edf84080-a5e0-478c-9977-af2376cb71c5@lunn.ch>
 <347c50ed-234a-4f29-b63a-1e0010c6b09d@altera.com>
 <e4cf8d95-0467-4bdc-8e19-228ced3a8bbc@lunn.ch>
 <5a0c962e-1af0-4d6a-b871-d8a0b0197ff5@altera.com>
 <d70a6795-e1a2-43e2-b523-0fc668324674@lunn.ch>
 <b8ca3bd8-af8f-43e7-904c-1ac45512296b@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8ca3bd8-af8f-43e7-904c-1ac45512296b@altera.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304546-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 425B7702CBE

> >> The delays are provided by the FPGA GMII-to-RGMII converter soft IP,
> >> which is hardcoded in the FPGA bitstream and cannot be disabled or
> >> modified from the driver side.
> >>
> >> Using phy-mode = "rgmii" is intentional here — it prevents the PHY from
> >> adding its own internal delays on top, since the FPGA converter already
> >> provides the full required delay. This is consistent with how all other
> >> Agilex5 SoCDK board variants are described, as seen in commit
> >> c5637e5ceb4b ("arm64: dts: socfpga: agilex5: Fix phy-mode to rgmii as HW
> >> provides clock delay") already in Dinh Nguyen's tree, which applies the
> >> same rationale across all Agilex5 boards.
> > 
> > I've become more insistent that designs get this correct. So i don't
> > care too much about past systems. Many vendors are having to fix up
> > their drivers and DT in order to make new boards consistent.
> > 
> > You can look at your system as the FPGA being the MAC, and the PHY is
> > the PHY. The PCB is not providing the delay, the MAC is. This exactly
> > fits the description above.
> > 
> >       Andrew
> Hi Andrew,
> 
> Thank you for the clarification. We agree with your framework in 
> principle, but would like to explain why phy-mode = "rgmii" is the 
> appropriate description for this specific case.

So you want to be different to every other system? Please extend the
text in that document to say that this device is special and has a
different definition of phy-mode to all other systems.

> After getting more information from hw team, for Agilex specific device, 
> the RGMII timing delays on this board are provided by an FPGA delay 
> chain (Input/Output Delay Chain primitives in the FPGA fabric). The 
> reason for using the FPGA rather than the PHY is that the Marvell PHY on 
> this board only supports 0ns or 2ns delay steps — too coarse to meet the 
> RGMII timing requirements. The FPGA delay chain provides up to 63 steps 
> of ~0.1ns precision, which the hardware team has tuned at design time to 
> achieve correct signal timing.

As the text says, fine tuning is different. You can have fine tuning,
in both the MAC or PHY, while using either rgmii or rgmii-id.

Also, you cannot fine tune just the MAC, tuning needs to take into
account the PCB design, the length of the clock and data tracks on the
PCB. You can however take into account the difference in timing within
the FPGA.

Or does your FPGA team produce a different bitstream per board design,
after some sort of calibration in order to determine what the PCB
characteristics are?

This however opens up a new possibility. It does sound like you can
produce a new bitstream with the delays set to just the tuning delay,
not the 2ns + tuning? You need to decide if this is simpler than
changing the MAC driver to mask the phy-mode.

> Changing to phy-mode = "rgmii-id" and having 
> the driver strip the delay before passing to the PHY would produce the 
> same hardware behaviour (PHY adds zero delay), but would add driver 
> complexity with no practical benefit, and would misrepresent the FPGA 
> delay as a driver-managed MAC delay when it is actually a fixed, 
> board-level hardware calibration.

Look at the wording again. It does not say it is driver managed.

# There are a small number of cases where the MAC has hard coded
# delays which cannot be disabled.

This exactly fits your situation.

> Could you advise if you still prefer the rgmii-id approach given this 
> constraint?

rgmii-id is the correct value for your PCB design. Please follow what
the text says.

	Andrew

	

