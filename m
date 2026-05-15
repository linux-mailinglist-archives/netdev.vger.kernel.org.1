Return-Path: <netdev+bounces-288434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODmgDLRuB2rY2gIAu9opvQ
	(envelope-from <netdev+bounces-288434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:06:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92372556963
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5333C300A381
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8749386C25;
	Fri, 15 May 2026 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VxTxOfJY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28C38655D;
	Fri, 15 May 2026 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871985; cv=none; b=jrL30qQnRHnVYg66r2TX93tTmyK3O6eOfQTqd9NsE3yn6Q/WCeeZPaBAOCvUIfqaYplgMdlmLq/yZTSCXtUgIl+b6UNhNZcg0ufgDfejTs8+HE94s8Db17lWLjFsicsF574FLDwoal2xUPnVOiQWHnYG9CBqgHDGVgjNkfzr26g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871985; c=relaxed/simple;
	bh=EPY8zYOqAlTEnqJKpT4mqc0U11ogRduEGaX/D5nsvqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAOg3lhRoLom0x6nne+3dLfhAgB/NuGP23QwoIXR0cFA0YRd8dB/ikroc+Jc6TVIC7Lbf3F1S7QrK66rYCkUk40JpEgnwR24r//VOhf+oOy+mMsM1T2srtnBmAEj5YzEPA64oAni+0qa2bkrvobvifyfQI34flTwQ6S2iG4HHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VxTxOfJY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PXRTL93tCwxTfMqDqmJOAdd3CPOzU+5xdtwwN+gTQV8=; b=VxTxOfJYZHCfAky6/9pzbBz1HF
	G2npnoX1bk45dlsrGAC0MGW/gmq5KiosuDuwUvlQRIH0eDTSLsqveFjbsLsDPAWJb1UbiZWSGDvRw
	/Z3B0yUZlSdpJFmVGrVxja81E1SiZ1MsNPr6NZaBKY4R4nj9hUIEuG/yvtFyS5Ot9mnQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNxrM-0037QM-49; Fri, 15 May 2026 21:06:08 +0200
Date: Fri, 15 May 2026 21:06:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
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
Subject: Re: [PATCH net 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Message-ID: <50e77863-4445-406a-a535-eb620d6fc1b2@lunn.ch>
References: <CY8PR02MB924916514D414B698DEB9A1883042@CY8PR02MB9249.namprd02.prod.outlook.com>
 <ab821805-49dd-4b55-a77d-0f25e0247bff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab821805-49dd-4b55-a77d-0f25e0247bff@kernel.org>
X-Rspamd-Queue-Id: 92372556963
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288434-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 06:15:50PM +0200, Krzysztof Kozlowski wrote:
> On 15/05/2026 18:13, Selvamani Rajagopal wrote:
> > According to OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6)
> > specification, interrupt type is active low, level triggered interrupt.
> > 
> > Fixes: ac49b950bea9 ("dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY")
> 
> Drop, there is no bug here. That is only an example. Otherwise explain
> how does this bug affect anything.

There is a tendency for DT developers to just copy/paste the example,
and not really engage brain. So if the example is wrong, the .dts file
will be wrong.

The thing about edge interrupts when level should be used is that they
mostly work. So quick smoke testing is not going to see any problems,
it is only when some condition comes along which causes two interrupts
in quick succession will the interface grind to a halt due to a missed
interrupt.

So i think it is a useful fix to have in stable.

	Andrew

