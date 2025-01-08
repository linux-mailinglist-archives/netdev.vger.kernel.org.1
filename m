Return-Path: <netdev+bounces-156434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F1DA065EB
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 21:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C86166951
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023BF20370C;
	Wed,  8 Jan 2025 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yHWYY4bS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD4202F70;
	Wed,  8 Jan 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367457; cv=none; b=ReB3lroqwsnCXAiplGCcvqUabe26cRk8BffnFJrPwyaiOw3BtWshP6pBJ2RVVbCF0cG5SC8CZ7IHLGkBZonlkL9JdYVD18Vtjml6P9udtM2ItgbyKHJjZb1xczl00xctcbPLuDpTYa07juT0EPnveo5DL+zqpdYcYpTvVX542vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367457; c=relaxed/simple;
	bh=Gll9HLWVOOQKKC615EkdeuTyuFaraBMcTg0OQ2aFT+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2aZE2FBDQdUeaWTPFZ79lEj/A6k2D5pWpNMQ5vzvlXRb9GOI9yGgzpp3VoN//5Y9N2M1T6QnTOHh88+OIgew+jSX7CweFyOz3nf015P8SAhcGOEWzCwVaGQqRQ34rCDfigpeKaK7prWq82piHLFgnxVxtrJqG4RieNUxVuoZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yHWYY4bS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b+Hjf7gL0CKGudF4dN19V3/6KMwWFZmCJ+Cv2U2rfsQ=; b=yHWYY4bSalT2gL8z3UpH+ZLEi/
	wai17khUMCEbltTA0kvnb6fXjBq5v+YSRMg3YfdC7cEKYCdzJmBUPQykCFJpd8z5RWjq2Aaafejzj
	yjoezsV6OMjJpgvGAYR7f7eLqXjF1Sw9KJQS0mizDmRURjHYiKh0ClvjbCq2KSaa/i3k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVcUR-002g0l-Eh; Wed, 08 Jan 2025 21:17:19 +0100
Date: Wed, 8 Jan 2025 21:17:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"eajames@linux.ibm.com" <eajames@linux.ibm.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <769c47ce-3183-4730-8702-ec85245e66df@lunn.ch>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <bebbba7b-f86e-4dc4-8253-65d34cb84804@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bebbba7b-f86e-4dc4-8253-65d34cb84804@linux.ibm.com>

> I checked with out hardware team and they did not add any extra delay on the
> board.
> 
> We have normal point to point clock without any delay added by line.

Thanks for checking. Thus phy-mode must be "rgmii-id". We now need to
fix the MAC driver so it does the correct thing when passed that.

    Andrew

