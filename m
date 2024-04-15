Return-Path: <netdev+bounces-87994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB4A8A525D
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C3A1F22A86
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971C6FE0D;
	Mon, 15 Apr 2024 13:54:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D215F54D
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189254; cv=none; b=pDIkL+09huKTAxZe71x7veFK+BjxP7rg2IaWJeCkUQfoYCTLxbfIezngSdqxsI0VotVYqld7bieiCnAXdhpGZI5Fjz+yJI+mxIFCsGK76qt+AoFm8PT6Bkq6m4Oi0+jU/Ojgi7SpBThzhmvZbsVSNEO0GBjUA+ECAB3NI0pkPR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189254; c=relaxed/simple;
	bh=s64tPzEuAURs1JoCSR9aaBZd5lR6ij2bp/d83+dXio0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWXn/40/1ftNdzIQhXnz2GECp2RCQLksU0IYUIkDyG/QM4KBv1bvMR0pbWsrhiwsoRJzXpaqN56dwAs2G7wR2T4rlFxcEkxDNwRP3euV1fjz96X0/co5pZ/lEhGPzJFdLQxzV39M/3AsSwFBAKPvWwVHD0UJ41vRXHR42CGenQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5801A300037E5;
	Mon, 15 Apr 2024 15:54:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 32D6E1BD9B; Mon, 15 Apr 2024 15:54:10 +0200 (CEST)
Date: Mon, 15 Apr 2024 15:54:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Roman Lozko <lozko.roma@gmail.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Sasha Neftin <sasha.neftin@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] igc: Fix deadlock on module removal
Message-ID: <Zh0xguaCQB-V8ckO@wunner.de>
References: <20240411-igc_led_deadlock-v1-1-0da98a3c68c5@linutronix.de>
 <Zhubjkscu9HPgUcA@wunner.de>
 <877ch0b901.fsf@kurt.kurt.home>
 <87zftukhxl.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zftukhxl.fsf@kurt.kurt.home>

On Mon, Apr 15, 2024 at 01:02:14PM +0200, Kurt Kanzenbach wrote:
> > > I would have been happy to submit a patch myself, I was waiting
> > > for a Tested-by from Roman or you.
> >
> > Perfect. I was wondering why you are not submitting the patch
> > yourself. Then, please go ahead and submit the patch. Feel free to add
> > my Tested-by.
> 
> Scratch that. I've sent v2 with your SoB. PTAL, because your original
> code snippet didn't have a SoB.
> 
> https://lore.kernel.org/netdev/20240411-igc_led_deadlock-v2-1-b758c0c88b2b@linutronix.de/

I created a patch yesterday, as you've requested, then waited for 0-day
to crunch through it and report success.  Which it just did, so here's
my proposal and I guess maintainers now have more than enough options
to choose from:

https://lore.kernel.org/netdev/2f1be6b1cf2b3346929b0049f2ac7d7d79acb5c9.1713188539.git.lukas@wunner.de/

Thanks,

Lukas

