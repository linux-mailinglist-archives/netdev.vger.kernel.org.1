Return-Path: <netdev+bounces-98023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8258CE9F2
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 20:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03CF1F24CB8
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACBF42ABD;
	Fri, 24 May 2024 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZBNDhN4m"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7141C85;
	Fri, 24 May 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575535; cv=none; b=m+uzyGfEmiwDN4NWtGl06CngDHXH1nEiDC7ntx609UJUTKffBDc7RCcRwst8BdGFLhl+YWr9aIBZlWTEqgdvoR/Skp2hJTZvx/RE3PUKn3pRBmM0dSttOgWsmiSj5IStrKkc4jqIij9g63i8vehDi6QpkXf2DFCf35m5IAJtfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575535; c=relaxed/simple;
	bh=ZDW6n8R+BbYSZWdXmek/HnmZttNw+oIvTXE643uclug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBB7v3MZp6cuFpgSbcwxh+lznojv0HHHE5ZNMt3mqKQa/G9hNTiyTpXJ+YBRPk+WwLCsHJWb2uXC15CqohFz0VMxLWNaRSkV3bUDJ8l8me7wnfRd4myt4Ly43tifRzH4geqvtQxdhxM8XCe88/qDlonN5fzLbtiLhv3eFePDaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZBNDhN4m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=K03GNtWVmJPKVVQMTb7a854Ol2QjAiRCHfbNxrRekzI=; b=ZBNDhN4mHvJ+uJ7Nn43x5PtElC
	zwBeXSm6fuQRM4NIbuYbs9Kl7sLYc+iR+wt45j4h7nP19aW5ivLR03hIftzsQLAEZhRvWh+1xR7iX
	PZMUtXY2lqOGXzjbZ90YrnzQ+QS4Wddd3IHXLoojOMBK5ApH7u5Y6nSWOG5axhfStUWI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sAZhp-00FyHj-J9; Fri, 24 May 2024 20:31:53 +0200
Date: Fri, 24 May 2024 20:31:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Parthiban.Veerasooran@microchip.com, Pier.Beruto@onsemi.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <7aaff08b-a770-4d93-b691-e89b4c40625e@lunn.ch>
References: <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
 <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
 <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <ZkG2Kb_1YsD8T1BF@minibuilder>
 <708d29de-b54a-40a4-8879-67f6e246f851@lunn.ch>
 <ZkIakC6ixYpRMiUV@minibuilder>
 <6e4207cd-2bd5-4f5b-821f-bc87c1296367@microchip.com>
 <ZkUtx1Pj6alRhYd6@minibuilder>
 <e75d1bbe-0902-4ee9-8fe9-e3b7fc9bf3cb@microchip.com>
 <ZlDYqoMNkb-ZieSZ@minibuilder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlDYqoMNkb-ZieSZ@minibuilder>

> After a considerable ammount of headscratching it seems that disabling collision
> detection on the macphy is the only way of getting it stable.
> When PLCA is enabled it's expected that CD causes problems, when running
> in CSMA/CD mode it was unexpected (for me at least).

Now we are back to, why is your system different? What is triggering a
collision for you, but not Parthiban?

There is nothing in the standard about reporting a collision. So this
is a Microchip extension? So the framework is not doing anything when
it happens, which will explain why it becomes a storm.... Until we do
have a mechanism to handle vendor specific interrupts, the frame work
should disable them all, to avoid this storm.

Does the datasheet document what to do on a collision? How are you
supposed to clear the condition?

       Andrew

