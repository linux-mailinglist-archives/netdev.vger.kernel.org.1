Return-Path: <netdev+bounces-217272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2974BB38218
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B702981E9C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3051303CA8;
	Wed, 27 Aug 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bWNnc+cA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72116303CA3;
	Wed, 27 Aug 2025 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297008; cv=none; b=O0niyxQG0NFYcIhTE3LPPcLHUEjcBfNQ8FSdofeFTJWI040/OiYngYkVi66RPyP03NX+mmrnA40J5H+gitp7T0+pz3wOHj0Ozc7fpF5Gl6C0kypWCyP7pJfwPPw1w4IZJlGOWA9XVmzbTT4Vwiq64s1zXGd2Kf7EQNubXm3Trys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297008; c=relaxed/simple;
	bh=P/v+JbS6pmjeG4QK4ydCLEn9waWuXx2BFtiUZKrRi/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJyFlIYd1bcS6J+E2lP0+5AArkUbqdVq1RW5AjnEMJwKpV3aPNszFGGuk4REO3Js0Qc1h2UxpTlDn0LzPhoFbL5e2wh0QJIZyMe8UYsN2Sr+ppSlGPzVjQ6VRCyUpRD/RLTzq73Ihsvc1x3ZgV33z78AGqZD2uyIG3kGYpCo74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bWNnc+cA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VWDVmdtFDFSrN8khsolzb9JOzSZdWAexinZ3Q1xuBn8=; b=bWNnc+cArgkqmhbqFE8CGD4/HF
	Wu+2SIS3QVI9Ur8s5Ms2hrIZ4mPQAIq9FZsdN1zSr/+rqk/Ip3Y+DUcciyi7Fyi6oDr+L38RBYNfm
	tA6ErDgiICFSzFQ9H/a0a8vnZgU6rmEJ3nohf8awRIKnnSEnw9x5PiWb2LqFX1SigziQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urF4v-006CtS-79; Wed, 27 Aug 2025 14:16:37 +0200
Date: Wed, 27 Aug 2025 14:16:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jack Ping Chng <jchng@maxlinear.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Yi xin Zhu <yzhu@maxlinear.com>,
	Suresh Nagaraj <sureshnagaraj@maxlinear.com>
Subject: Re: [PATCH net-next v2 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Message-ID: <b6a3eaa9-bb44-4ceb-aecb-af7f4125aa98@lunn.ch>
References: <20250826031044.563778-1-jchng@maxlinear.com>
 <20250826031044.563778-3-jchng@maxlinear.com>
 <4a3c0158-eda0-42bc-acfe-daddf8332bf3@lunn.ch>
 <PH7PR19MB563654EF8D30DFE723775340B438A@PH7PR19MB5636.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR19MB563654EF8D30DFE723775340B438A@PH7PR19MB5636.namprd19.prod.outlook.com>

> > > +     i = 0;
> > > +     for_each_available_child_of_node(pdev->dev.of_node, np) {
> > > +             if (!of_device_is_compatible(np, "mxl,eth-mac"))
> > > +                     continue;
> > 
> > Are there going to be other devices here, with different compatibles?
> 
> Yes, other devices will be added in the next patch series.

DT describes the hardware. The hardware is not going to change, so you
might want to add the full DT binding now to describe it. That will
also help justify this compatible, which is a bit odd.

	Andrew

