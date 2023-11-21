Return-Path: <netdev+bounces-49669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481587F3089
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 15:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB35B21991
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18CA54FB9;
	Tue, 21 Nov 2023 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yAoXmN/f"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52AD10C8;
	Tue, 21 Nov 2023 06:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7Vk/mqg19Y1cXv6QZAT5QkHwUasolYWNhqzl+nIhRfA=; b=yAoXmN/fVOrsqiiYvB+zhuT7Qu
	7Fb8Mz4E4IxdqTQv6B+Q/2aO/qOg5a6s57g23kwVJfwVM1q/q8tF8RSaxSRFRas/8GkC6FQ8JQyvR
	M8NuXbjTqxn77lxT9utOfNH4BY2YvE7IlU9i3xohyVo5pk7ByALlPDGnOoRq+oDhE+XA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5Rax-000lPS-QM; Tue, 21 Nov 2023 15:19:19 +0100
Date: Tue, 21 Nov 2023 15:19:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ethtool: Expand Ethernet Power Equipment
 with PoE alongside PoDL
Message-ID: <44cbe9d3-dbd2-438c-b413-af525426781a@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
 <04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
 <20231120110944.66938859@kmaincent-XPS-13-7390>
 <20231120111008.GC590719@pengutronix.de>
 <2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.ch>
 <20231121110215.07f61e55@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121110215.07f61e55@kmaincent-XPS-13-7390>

> > However, everything not PoDL PSE seems to be clause 33. So how about:
> > 
> > 	enum ethtool_podl_pse_admin_state podl_admin_control;
> > 	enum ethtool_c33_pse_admin_state c33_admin_control;  
> > 
> > At least inside the kernel we use c22, c45, c37 etc. I'm not sure they
> > are visible to userspace, but if we don't have a better name, maybe we
> > have to use c33 in userspace as well.
> > 
> > I do think naming like this makes it clear we are talking about two
> > parallel technologies, not a generic layer and then extensions for
> > podl.
> > 
> > What do you think?
> 
> If we decide to add a prefix, "c33" is precise but less easily understandable,
> why not using simply "poe" prefix?

I suspect poe has the exact opposite problem, its too imprecise. Its
too much of a marketing name, with no clear meaning. It could even be
some people call podl poe.

To some extent, this is a user space UX problem. We can be precises in
the kernel and the kAPI. What ethtool decides to show to the user
could be different. Although it basically is the same problem.

Do you have ethtool patches? What does the output look like?  Oleksij
did say a hybrid could be possible, so we probably want ethtool to
group these properties together and make it clear what is PoDL and
!PoDL.

> Maybe as POE were originally PMDI you prefer to use c33 which won't change over
> time? 
> 
> Should I also modify the content of the enum?
> ETHTOOL_PSE_ADMIN_STATE_* to ETHTOOL_C33_PSE_ADMIN_*
> ETHTOOL_PSE_PW_D_STATUS_* to ETHTOOL_C33_PSE_PW_D_STATUS_*

Yes. That will help avoid getting PODL and C33 properties missed up.

     Andrew

