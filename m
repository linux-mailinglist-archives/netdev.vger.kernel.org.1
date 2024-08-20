Return-Path: <netdev+bounces-120323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C9958F29
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678761C20F83
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A21BBBF0;
	Tue, 20 Aug 2024 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gBjE2KGj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B90154C15;
	Tue, 20 Aug 2024 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724185400; cv=none; b=UdsBjsvWXpPc1w23nP/0+njvpbkPpTYI9Fbidw+4ylo56HL6LEIm6vbRHC9MK6CbStYMUhlqcKUCLW6NVAgQu1IPPxgdIAr6ZxQlI9Rp6GzppJmMmEdecwU1eX4AtuBDKJAFZNn+jYx/ssDgv/R6HJLPzYy75UCdGWtoEtGWZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724185400; c=relaxed/simple;
	bh=N0kVamxQdbaq3r2k8x+FouJskbpisdpD1nQK/n9DuAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV4ZF0hjqzpQArGtekDHhfYx1qd/Qw3s1d53lYKxhdJquiiyRoKlvpdbQBfaSh4jN+KYh2Os8BjlGZI6SQpCFEQNgq3Oo4MpBJLWJjebI3zhgd/8NN+Cmd5EKc5+07wFlRqL0vfodylUUUba/9MD+SEQiLTm7wEqTVSJqjxrBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gBjE2KGj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ALmsTdvvNrRc81t5o913qxK+GrVh4ybAsT1NnrRbgNc=; b=gBjE2KGjUbnVfn7FlCW3130nbN
	JeEloYKiTn8iicp6goLGNEWSwKSZRRc+NGIUYTlxlRTTZ2v1tAItcKujWf9ktvatuQyaj3t11qn72
	UB+s0EiVr3MdjwdQnTdzqBCdiQv3hllAq4X1iK9xlMjADDProveHYXzhAA3Qb3cvWEf0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgVNo-005G29-Uj; Tue, 20 Aug 2024 22:23:12 +0200
Date: Tue, 20 Aug 2024 22:23:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net-next v4 2/2] net: xilinx: axienet: Add statistics
 support
Message-ID: <98441cee-193d-404c-8dc5-9cf2061ce2e4@lunn.ch>
References: <20240820175343.760389-1-sean.anderson@linux.dev>
 <20240820175343.760389-3-sean.anderson@linux.dev>
 <MN0PR12MB5953C46BA150B0382F222534B78D2@MN0PR12MB5953.namprd12.prod.outlook.com>
 <b7f66966-f97a-4890-b452-2a8a5e20b953@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f66966-f97a-4890-b452-2a8a5e20b953@linux.dev>

> > Is that a standard convention to retain/persist counter values across 
> > link up/down?
> 
> IEEE 802.3 section 30.2.1 says
> 
> | All counters defined in this specification are assumed to be
> | wrap-around counters. Wrap-around counters are those that
> | automatically go from their maximum value (or final value) to zero and
> | continue to operate. These unsigned counters do not provide for any
> | explicit means to return them to their minimum (zero), i.e., reset.
> 
> And get_eth_mac_stats implements these counters for Linux. So I would
> say that resetting the counters on link up/down would be non-conformant.
> 
> Other drivers also preserve stats across link up/down. For example,
> MACB/GEM doesn't reset it stats either. And keeping the stats is also
> more friendly for users and monitoring tools.

Agreed.

Some driver get this wrong, and clear them. But as a reviewer, it try
to spot this.

   Andrew

