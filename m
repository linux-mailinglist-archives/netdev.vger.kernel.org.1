Return-Path: <netdev+bounces-213627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2767BB25EDA
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE399E55B5
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053402E7F2F;
	Thu, 14 Aug 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpKKgtsd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE22580D7;
	Thu, 14 Aug 2025 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160188; cv=none; b=DY+hqeAJkVysTlSwNe3oO0fxf9B6kVQ4bGdRUJq7tjMfLn5TrXiMa7TLwGY1sNZjjZaBYoObHIkpduIV6hGVr/zzI/KuJporV8+ufcDIMLnimeYCb+ktpkf4R755bnGb2pWgeYwLANGr9nyqhUeuAQA76BAK8it6fMyt2iy+8UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160188; c=relaxed/simple;
	bh=czB9BQFUSwV/+y45czm/RfvfKjNZIL9R6PoXdqY73Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kjwt9uFCFU8QGShMEBsMdxCZROlp6msNJxZdQBtlQXOjxOrKKi+MpCLOAaYoCjHUbyEv05EVB1gni1mNv8lCB4XGWOHgARZ0gKsNj7mD8yVcwk7NL7Rd78iw821jdNwaZS4OxsBLZfUJX4Qx1Q9Dk8/itn8oKFc4VakFTeol2a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpKKgtsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67BBC4CEF7;
	Thu, 14 Aug 2025 08:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755160188;
	bh=czB9BQFUSwV/+y45czm/RfvfKjNZIL9R6PoXdqY73Hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpKKgtsd6bZYAKDZj6uqmdK41sXqXoT81mI+N6HfapbmEVGrDCYGUa2AQ1wiK5bwO
	 QLnzgxc4sotDIP5DfgrRGM0w2xY7sEpjzrBHuOQCWKKDq/MgeBxRDEjVMtnc+jZDsf
	 LIB7FQlpoxqZJbqVQiQJKzGAmfK8r/ub+hbFrgd62AnaFiXT+c2gV5XqEBbT6FzZrJ
	 5dPy6pz+A62BmxEjYaQrREJm4IrP2NA6D/7Y1li6F5eIT31f6m7LWyocSac6qJ1INl
	 ZBbozPIuwwMsLt5efmD7GwAvEnr+wheIvobMwpCCl+WF9icX/ZRTjtDt3e3U6b8pQZ
	 7UQUEitABmgmQ==
Date: Thu, 14 Aug 2025 10:29:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 net-next 03/15] dt-bindings: net: add an example for
 ENETC v4
Message-ID: <20250814-finicky-tall-wolverine-6a5b90@kuoka>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-4-wei.fang@nxp.com>
 <aJtR4j9+w5fVsJL4@lizhi-Precision-Tower-5810>
 <PAXPR04MB8510925387F9F72A8E99AB82882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <aJyq2h+y+KBjqmsr@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJyq2h+y+KBjqmsr@lizhi-Precision-Tower-5810>

On Wed, Aug 13, 2025 at 11:10:18AM -0400, Frank Li wrote:
> On Wed, Aug 13, 2025 at 01:38:55AM +0000, Wei Fang wrote:
> > > On Tue, Aug 12, 2025 at 05:46:22PM +0800, Wei Fang wrote:
> > > > Add a DT node example for ENETC v4 device.
> > >
> > > Not sure why need add examples here? Any big difference with existed
> > > example?
> > >
> >
> > For enetc v4, we have added clocks, and it also supports ptp-timer
> > property, these are different from enetc v1, so I think it is better to
> > add an example for v4.
> 
> If there are not big change, needn't duplicate one example at yaml file,
> the content should be in dts file already. Pass DTB_CHECK should be okay.

Two new properties is on the edge of justification of new example. I am
fine with both - having this patch and dropping it.

Best regards,
Krzysztof


