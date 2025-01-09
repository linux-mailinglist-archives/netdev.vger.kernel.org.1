Return-Path: <netdev+bounces-156723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B4BA07999
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD5A3A1631
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40B818C34B;
	Thu,  9 Jan 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mGzh0Iq+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED64754769;
	Thu,  9 Jan 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434121; cv=none; b=Q8Esqv+tuVUxch+3BubaSvdNkCPxEKMIrIFpviMUGvaSGWN1RibHWlpgpqrjiMJ0yK8RzzKoCxw7U4BwC7WiBBC4EBbRjaIpT4BGZ6un2BgmMtFVJq5OgWMV7bDZ8VYfcEgoHwGLfhlh4PM6c+Ali2tpNoT9+VT7dcdIzTJKD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434121; c=relaxed/simple;
	bh=xryaOo8GIdFhxCid8FoISNMJaosSoDnXI4TfRckteug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFyhaxgiY/S2kSphpgyd0D7QrztXE8l7SNNrzfNC7GzAynOd+8IQiUbJ6AJwl7E+lc8p5/kwgWX7NFCvS22zctEX+jmUnGFjf6JYfcBOsjYRH2J9TDoXp6BbcBVbkFvNlNoUxe4qoBSveq7cmlFg+zSJ3ORrwDZcuA9P9vrel4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mGzh0Iq+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YfjcKm0d4Vajn+h/jwMfdima+TwcpMUsitsmuyI+KwE=; b=mGzh0Iq+K5BiGQJKCYwFjh52FU
	8bznveg2/N0yjqFingSY3hMZhRhiI8vCLBYMpXXUpVkwspAxYT7Ot3r33BkECyz5qI+0WzMjqmqFc
	YzPlAj0bQp/V5Fg/nycCtFmwKyIZNH5f0qN5RcgXWY1eYQhNiuE/4nPdt9jR7lGytIio=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVtpR-002v8k-IQ; Thu, 09 Jan 2025 15:48:09 +0100
Date: Thu, 9 Jan 2025 15:48:09 +0100
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
Message-ID: <8ae7c237-abcf-4079-a4ba-ce17e401917d@lunn.ch>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <6ac77e5d-e931-494a-9777-6ed0bc4aa1e9@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac77e5d-e931-494a-9777-6ed0bc4aa1e9@linux.ibm.com>

> When does someone use rgmii-txid and rgmii-rxid?

When there is an extra long RX clock line on the PCB, but not the TX
clock line, you would use rgmii-txid. If there is an extra long TX
clock line, but not RX clock, you would use rgmii-rxid. You do not see
this very often, but it does exist:

arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts

/* RGMII delays added via PCB traces */
&enet2 {
        phy-mode = "rgmii";
        status = "okay";

	Andrew

