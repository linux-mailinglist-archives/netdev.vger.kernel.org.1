Return-Path: <netdev+bounces-66155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE3D83D881
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 11:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49DB1F28719
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244F134A9;
	Fri, 26 Jan 2024 10:54:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from torres.zugschlus.de (torres.zugschlus.de [85.214.160.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7700713AC9
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.160.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266472; cv=none; b=ZY9ESMyNO7AfDrBms+NBwZLZRrodEKO2i8u1sm6/pMKOq/dCyrK3h2UNr2gsUzIJJm9Tj2mQDMJ0jhIfQeNt+oWXJudWcCqvY0b2/0rRjci90Q5gvKc8EIJnmAah5wsCJrJ7SpCTGkJrZtOSso3w0/OPMjz09qFTBMK4EUDsftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266472; c=relaxed/simple;
	bh=GYp8mOFv3Y7lroQXDbo/yKwrPnUi0bxeRCA+pBoxK8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfU+YphVrQfXbpopsHNqT6/YnImaMXrr0+VW/I9Ru/+1orHo3RdmhhEHUJa7VIfWzY0z8JCfyQX2tegZZFvVzkwXfNqqzYp3ZoBWAqPR/Bo9khmnZZiuWAPI1vOG/48NeiX+Q4lwMCYUINsMLGm9amIfgwGc97Ewfn1h1Pz2kCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de; spf=none smtp.mailfrom=zugschlus.de; arc=none smtp.client-ip=85.214.160.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
	(envelope-from <mh+netdev@zugschlus.de>)
	id 1rTJqm-000tgw-1K;
	Fri, 26 Jan 2024 11:54:20 +0100
Date: Fri, 26 Jan 2024 11:54:20 +0100
From: Marc Haber <mh+netdev@zugschlus.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jisheng Zhang <jszhang@kernel.org>, netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <ZbOPXAFfWujlk20q@torres.zugschlus.de>
References: <Za173PhviYg-1qIn@torres.zugschlus.de>
 <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
 <ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
 <229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch>
 <99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
 <20240126085122.21e0a8a2@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240126085122.21e0a8a2@meshulam.tesarici.cz>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Fri, Jan 26, 2024 at 08:51:22AM +0100, Petr Tesařík wrote:
> On Thu, 25 Jan 2024 12:00:46 -0800
> Florian Fainelli <f.fainelli@gmail.com> wrote:
> > Did not Petr try to address the same problem essentially:
> > 
> > https://lore.kernel.org/netdev/20240105091556.15516-1-petr@tesarici.cz/
> > 
> > this was not deemed the proper solution and I don't think one has been 
> > posted since then, but it looks about your issue here Marc.
> 
> Yes, it looks like the same issue I ran into on my NanoPi. I'm sorry
> I've been busy with other things lately, so I could not test and submit
> my changes.

Is it worth trying your patch from the message cited above, knowing that
is not the final solution?

> I hope I can find some time for this bug again during the coming weekend
> (it's not for my day job). It's motivating to know that I'm not the
> only affected person on the planet. ;-)

I am ready to test if you want me to ;-)

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421

