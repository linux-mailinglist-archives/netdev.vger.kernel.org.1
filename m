Return-Path: <netdev+bounces-228952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A834BD6581
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5FE18A3E1E
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5552525DAFF;
	Mon, 13 Oct 2025 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JQg7UOcP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E751A9F9B;
	Mon, 13 Oct 2025 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390307; cv=none; b=bghPMhV13/ZsnbB2AfeyJEONo1ayAUU+WRZYQKPj2QHQE4te9hrfLgbvpkQJxZRMr6zznpGCQxs77v855brwhRgaB/GTNYb8P4sTH3wcxsyjZorxTlhuKl42JPlGUlzobkHqVOj+x7GdYBmux2S/7HdWgFwPG231pxHwr56Ntxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390307; c=relaxed/simple;
	bh=uXXDGa1owQP24cyB5MLZe1wz0OCG8r5FaFOJi2R4CKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drwjuYkhYvg5M9MHKulXszqN2HGw+m3BSEE4EzHQKJT2rXSpgrx3VWfnNRmvPOJ0wpBXJcET6y0a6EvvW+0rD1XxCbn2CsQ6EuH0b498TNG7VzSdXl5oLJ9glG0RX1sI3n+OczZiEfYatFEMobh0GqjlBQ0pzFApff/dtGfgmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JQg7UOcP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=52Il5H6NJOzRW4MLc6CVrFe1BNlv8DrhxyPngZJSTT4=; b=JQ
	g7UOcP1bSPR5/N4Lr7BdxKe++6n3JhL6Nc1WUgPtrTbiz6swJdfh8wnOo5LaHn0IMncR3Q9XodtYf
	KUQbiOQ0jBm51nE+Yjq3WwnyLfDFQtduqIADALn+x8O7VWUX5dk/W50a9mCcprJkfD+Ni1bqDTbvE
	DzZ5V5Rb7AfVPz0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8Pvs-00Aq9L-65; Mon, 13 Oct 2025 23:18:16 +0200
Date: Mon, 13 Oct 2025 23:18:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: brcm,bcm54xx: add binding
 for Broadcom Ethernet PHYs
Message-ID: <6eb4e9ba-51ad-4ee4-af74-49a9bea617f0@lunn.ch>
References: <20251013202944.14575-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013202944.14575-1-zajec5@gmail.com>

On Mon, Oct 13, 2025 at 10:29:43PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Some network devices (e.g. access points) come with BCM54210E PHY that
> requires being set into master mode to work properly.
> 
> Add binding for BCM54210E as found in Luxul AP devices (600d:84a6) and
> the "brcm,master-mode" property.

Is there anything broadcom about master mode? I assume this is just
the usual prefer master:

ethtool -s eth42 [master-slave preferred-master|preferred-slave|forced-master|forced-slave]

Also, is this preferred-master or forced-master?

Humm, also how does this differ to ethernet-phy.yaml:

 timing-role:
    $ref: /schemas/types.yaml#/definitions/string
    enum:
      - forced-master
      - forced-slave
      - preferred-master
      - preferred-slave
    description: |
      Specifies the timing role of the PHY in the network link. This property is
      required for setups where the role must be explicitly assigned via the
      device tree due to limitations in hardware strapping or incorrect strap
      configurations.
      It is applicable to Single Pair Ethernet (1000/100/10Base-T1) and other
      PHY types, including 1000Base-T, where it controls whether the PHY should
      be a master (clock source) or a slave (clock receiver).

      - 'forced-master': The PHY is forced to operate as a master.
      - 'forced-slave': The PHY is forced to operate as a slave.
      - 'preferred-master': Prefer the PHY to be master but allow negotiation.
      - 'preferred-slave': Prefer the PHY to be slave but allow negotiation.

	Andrew

    Andrew

---
pw-bot: cr

