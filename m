Return-Path: <netdev+bounces-49050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B907F0842
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 19:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4804B1F22451
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B4A1428C;
	Sun, 19 Nov 2023 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aIb6CHqk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B8210A
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 10:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LqYWZ0zybaB1kKvCfhSBpdVWRIR0wr9k4TH/vbifjIE=; b=aIb6CHqk2WsFMKPGqRReQZlfxi
	MvwgzADJZIgOp28HoNcGfNUtGcnMHWXyvnpy1AaqHDBVj/YPn/+AJ8GnsD6X2eRJu1YhkiRM9hK3C
	VWY97JW7b7aPiOmaX1buCPMXzT5zVl9pgNkWrLcr+bKsOx37retHrTT+RsM4NwAuufJw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r4mQ9-000a3s-8p; Sun, 19 Nov 2023 19:21:25 +0100
Date: Sun, 19 Nov 2023 19:21:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCH net-next 01/10] net: bridge: add document for IFLA_BR enum
Message-ID: <86124486-3290-4507-8158-57eaf5bbb8a4@lunn.ch>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-2-liuhangbin@gmail.com>
 <20231119164625.d2yzi3mpxv72t6pp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119164625.d2yzi3mpxv72t6pp@skbuf>

On Sun, Nov 19, 2023 at 06:46:25PM +0200, Vladimir Oltean wrote:
> On Fri, Nov 17, 2023 at 05:31:36PM +0800, Hangbin Liu wrote:
> > + * @IFLA_BR_MAX_AGE
> > + *   The hello packet timeout, is the time until another bridge in the
> 
> No comma between subject and predicate.
> 
> > + *   spanning tree is assumed to be dead, after reception of its last hello
> > + *   message. Only relevant if STP is enabled.
> > + *
> > + *   The valid values are between (6 * USER_HZ) and (40 * USER_HZ).
> > + *   The default value is (20 * USER_HZ).
> > + *
> > + * @IFLA_BR_GROUP_FWD_MASK
> > + *   The group forward mask. This is the bitmask that is applied to
> > + *   decide whether to forward incoming frames destined to link-local
> > + *   addresses. The addresses of the form is 01:80:C2:00:00:0X, which
> > + *   means the bridge does not forward any link-local frames coming on
> > + *   this port).
> > + *
> > + *   The default value is 0.

Where was the default value of 0 derived from?

br_handle_frame() seems to handle 01-80-C2-00-00-00 using is used for
BPDUs. 01-80-C2-00-00-01 is explicitly dropped, since its Pause, which
i doubt you want to forward. LLDP has some level of processing.

Should the default value reflect this?

       Andrew

