Return-Path: <netdev+bounces-143297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BEA9C1DCE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04B6B22AB6
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AD21EABA3;
	Fri,  8 Nov 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q3YB+sO+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6FAC8CE;
	Fri,  8 Nov 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072295; cv=none; b=UYJPgQ2Rj6NGy9ktNBuojvhncjii9WkbSVLXJTdtBvie41lYj2qOMiHUDm85K4EvzYO1VMVbACsgaXRfcmJasfLjBVj2fByIswXt58dmXEkbzuAGGtBdDPAMzNUObRNiHh/0aSJxFyOAbcSC6ZDG9uu6/ea0PRVIqa4EHLjsdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072295; c=relaxed/simple;
	bh=ni/3Cy7kPWYuIGCIJydi7FQcXqijVJBAUEa+rtreWcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGMXjF5Q01YtmWy5nYBj0ndetAcJuLQAh9gXIszvJz6dCxd9/y4tZkcvE7G2ZQt+Bf8xFM/h7zXDl4IS1bqTal8nKZAGDx54lB6pPqd+t6WUh+Fa+h1moMINyPUeyFsGJ7vGPMwc2fm47/W+TyDxeYKDVuCTKgPx7Ux2+1tXyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q3YB+sO+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vvvyONin7h/t95ubAs9xamFBdLK+MiSmvm8Jv+ehdeA=; b=q3YB+sO+hKnqZTMOjD62N6GRbK
	1huZvN1EZ4iocqZxzc173+4wvX/r1JaU2S4XTV2yXxCevMO2AuEFjdCXN/Gb3R5wyX94oi3wiQ0Ms
	cTz6PrLs8DXJES2jgM3WcxyUxWl7n203SX0n9RmdMUd+ZqYuRCGCCQkgkmnjCiECtSxE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9Oyb-00Cb5D-37; Fri, 08 Nov 2024 14:24:37 +0100
Date: Fri, 8 Nov 2024 14:24:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lei Wei <quic_leiwei@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com,
	quic_pavir@quicinc.com, quic_linchen@quicinc.com,
	quic_luoj@quicinc.com, srinivas.kandagatla@linaro.org,
	bartosz.golaszewski@linaro.org, vsmuthu@qti.qualcomm.com,
	john@phrozen.org
Subject: Re: [PATCH net-next 3/5] net: pcs: qcom-ipq: Add PCS create and
 phylink operations for IPQ9574
Message-ID: <17ae9ace-55a6-4e09-ba1a-889b5381fb0f@lunn.ch>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-3-fdef575620cf@quicinc.com>
 <d7782a5e-2f67-4f62-a594-0f52144a368f@lunn.ch>
 <9b3a4f00-59f2-48d1-8916-c7d7d65df063@quicinc.com>
 <a0826aa8-703c-448d-8849-47808f847774@lunn.ch>
 <9b7def00-e900-4c5e-ba95-671bd1ef9240@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b7def00-e900-4c5e-ba95-671bd1ef9240@quicinc.com>

> > Another artefact of not have a child-parent relationship. I wounder if
> > it makes sense to change the architecture. Have the PCS driver
> > instantiate the PCS devices as its children. They then have a device
> > structure for calls like clk_bulk_get(), and a more normal
> > consumer/provider setup.
> > 
> 
> I think you may be suggesting to drop the child node usage in the DTS, so
> that we can attach all the MII clocks to the single PCS node, to facilitate
> usage of bulk get() API to retrieve the MII clocks for that PCS.

I would keep the child nodes. They describe the cookie-cutter nature
of the hardware. The problem is with the clk_bulk API, not allowing
you to pass a device_node. of_clk_bulk_get() appears to do what you
want, but it is not exported. What we do have is:

/**
 * devm_get_clk_from_child - lookup and obtain a managed reference to a
 *                           clock producer from child node.
 * @dev: device for clock "consumer"
 * @np: pointer to clock consumer node
 * @con_id: clock consumer ID
 *
 * This function parses the clocks, and uses them to look up the
 * struct clk from the registered list of clock providers by using
 * @np and @con_id
 *
 * The clock will automatically be freed when the device is unbound
 * from the bus.
 */
struct clk *devm_get_clk_from_child(struct device *dev,
                                    struct device_node *np, const char *con_id);

So maybe a devm_get_clk_bulk_from_child() would be accepted?

However, it might not be worth the effort. Using the bulk API was just
a suggestion to make the code simpler, not a strong requirement.

	Andrew

