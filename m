Return-Path: <netdev+bounces-151680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B76A9F092E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF957284D46
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49CF1B415A;
	Fri, 13 Dec 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HwhcA1E/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213721ADFFB;
	Fri, 13 Dec 2024 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084710; cv=none; b=cZ21NFHszH/IDkbq6DGeG61ngIvAuWmw3ifaH84XiDCLYGWUKbute4NaOcMfmVLiOmPcvNcd/zK7Gh7DFuc8JnutKO/21n38ESm2cbDV6h77Fjy4o4znIT2stpURlJBEVXJ4bZm6Hgfcr9HZXV3fRcgagjcc/+5i8y7hrvEA4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084710; c=relaxed/simple;
	bh=FhkR2Jy2phECAawNh940FstvyZ2NMMrD1kWzsX/kbS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJuMbCEi6+an1611Nm7SJd0eFoxR7+d8AeG4VaenQJQYX4vTNOywtIduHpH6WTYR7sk3CTYccBF60SHuOgnxDfFMo0uuhMphMGr87yPKAo0XIml7r+gkdVRbj/WvvYHySZwFuT7gjx+KYx4Li2Xf+R+PTLis+n3zKKBJHdKmKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HwhcA1E/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0c63pzHVbgCDCuCZw1/2piJ3HdBSD8HKGz7PGa5awcw=; b=HwhcA1E/f/yUEA/uToLkSUXSGU
	SyDE+8R+7jCh8TDwTdEIsxNc5TF8ahtD4WMEQkV1cO4CtPGPswGle4GSwUWop9DNWflrOrjrK2QOI
	Cgs2kLRCWNCO9uIpvIy2i07Np4KFkaopqjz6uKbuoP2B44c14Ipdpe65cB1wfPzUCSsE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tM2aD-000K1U-TA; Fri, 13 Dec 2024 11:07:41 +0100
Date: Fri, 13 Dec 2024 11:07:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: dp83822: Add support
 for GPIO2 clock output
Message-ID: <c8ba4645-d3eb-4f20-b1a2-ecf160e34e85@lunn.ch>
References: <20241212-dp83822-gpio2-clk-out-v3-0-e4af23490f44@liebherr.com>
 <20241212-dp83822-gpio2-clk-out-v3-1-e4af23490f44@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-dp83822-gpio2-clk-out-v3-1-e4af23490f44@liebherr.com>

On Thu, Dec 12, 2024 at 09:44:06AM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> The GPIO2 pin on the DP83822 can be configured as clock output. Add
> binding to support this feature.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

