Return-Path: <netdev+bounces-120185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0295882E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB331F2300D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99270189F3F;
	Tue, 20 Aug 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KT4sLJxf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778F617557E;
	Tue, 20 Aug 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161577; cv=none; b=TQciFQiNE4o4KVpYsPt93yBrJvmtkwCgitDUDpMEMBk7SKphWP5hfupNjw6dxksZibIbJzf93kIlkg6HDrB/PZB5etwolBUq8anr/hInSG+NCIO2hlKssZpk2pGZV4+L1NILsr9BQ0CVUmbFs3MKQFNErP3LeFIFRvj21AbRTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161577; c=relaxed/simple;
	bh=nw9dGn0eCjC0mjmiSOVdSWfX/cHuHSXyIKTyut7Yfz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+FKDYGev2FPpoHaq9jB2xsy/E2n4Rpb107s0fZdtXjUrvSVaLBreFaYzj64aOPmjj5L7Ep31k6jWOrprhGvXJg8SEZwZmpd9sBtpMxdlgzbeD5NuJu6bZZxqtqos2jlCNXJHCswhKznGhVGXi9ijWASsuQsZQX8l6TMpSLLvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KT4sLJxf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SwvzyDocEWp1csi0DKUVdJMiBrm+Lb26EA4HjpmmBfI=; b=KT4sLJxfZWzCJYWFMZMylejVo3
	Ovi6xOdkg4dxPDBjPAXFjRF7gsMa5s/iXxZs9fmtT5hyw3M1BtduMRIIYdapy3Y1LxW/ZjK/Zv/tQ
	hVG/Jp5WuIAHcoKfqPiLOLZ8Cd2ZusyMbA1WMs6TrjN371URrpHbO82of+f8LNcpfjAE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgPBU-005E7B-9m; Tue, 20 Aug 2024 15:46:04 +0200
Date: Tue, 20 Aug 2024 15:46:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/1] net: dsa: mv88e6xxx: Fix out-of-bound access
Message-ID: <a3859770-353b-4594-acd6-4a6dbedecbc1@lunn.ch>
References: <20240819235251.1331763-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819235251.1331763-1-Joseph.Huang@garmin.com>

On Mon, Aug 19, 2024 at 07:52:50PM -0400, Joseph Huang wrote:
> If an ATU violation was caused by a CPU Load operation, the SPID could
> be larger than DSA_MAX_PORTS (the size of mv88e6xxx_chip.ports[] array).
> 
> Fixes: 75c05a74e745 ("net: dsa: mv88e6xxx: Fix counting of ATU violations")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

