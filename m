Return-Path: <netdev+bounces-216473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E530CB33FA4
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D893A5D5E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A6C14B977;
	Mon, 25 Aug 2025 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BUnZrC40"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82A1DA21;
	Mon, 25 Aug 2025 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125406; cv=none; b=gjZfQjsztajEu41tv51vlouuKqdrq7LQVNAHSdc5DTYaN5haOATVfqCiOZ10MWjT8HyMZei5cPIEgzXwNlKzawJ2SQfJiIO98QJM19+OxSBPapH3NSfOSIkFR0Z/fDUUPRxVA4oS/xlGFRTGZYhwKpr4uq6kImHX5pxD7JPF2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125406; c=relaxed/simple;
	bh=QyxRs3mqNoI9u743Zb8CwLPaTzapStO898835kG8wnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNNm1NsY5N+y6vdBr497rPxZea/AW4OLw4zRKavjVPl0DTSZuSkexyK4n5i3K8M+vXLjuAOX84glaLRDSpteVWM36BvgBOCRiWHjeLr6q7RtVZn4x7rwj2XECblGBbSHaf8pdklHONRu4uRjN02fyBc8LVE7sng6yMRBr0h4YWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BUnZrC40; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=098EQlRrtA3I5AOqQoJ/l9UBGb4jL/E1dwqessItC8w=; b=BUnZrC40pTNnCbrVSjMXHW/tcJ
	iU/gZfmr+5O7ZnPGVxhn4eG+uLeIwvoz2P1HdTfrjEUlrYMcXmTy3dCzatZDo+UbXdlHLGu/OG6Ep
	Y9fWvhFTWCA6zanzxS4sNzjEOQOnZED3nRVirwWO17X7ohjH+twbklHwqRcdBHGt7K7Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqWR5-005wLG-T5; Mon, 25 Aug 2025 14:36:31 +0200
Date: Mon, 25 Aug 2025 14:36:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	festevam@gmail.com, fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v5 net-next 08/15] ptp: netc: add debugfs support to loop
 back pulse signal
Message-ID: <13c4fe5a-878c-4a08-87df-f5bb96f0b589@lunn.ch>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
 <20250825041532.1067315-9-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825041532.1067315-9-wei.fang@nxp.com>

On Mon, Aug 25, 2025 at 12:15:25PM +0800, Wei Fang wrote:
> The NETC Timer supports to loop back the output pulse signal of Fiper-n
> into Trigger-n input, so that we can leverage this feature to validate
> some other features without external hardware support.

This seems like it should be a common feature which more PTP clocks
will support? Did you search around and see if there are other devices
with this?

Ah:

ptp_qoriq_debugfs.c:	if (!debugfs_create_file_unsafe("fiper1-loopback", 0600, root,
ptp_qoriq_debugfs.c:	if (!debugfs_create_file_unsafe("fiper2-loopback", 0600, root,

Rather than hiding this in debugfs where each vendor will implement it
differently, i'm just think it might make sense to have an official
kernel API for it.

	Andrew

