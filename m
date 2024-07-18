Return-Path: <netdev+bounces-111983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F72D9345F7
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 04:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD931C2164F
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 02:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE1F382;
	Thu, 18 Jul 2024 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KkOnNxyT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F2175A5
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721268114; cv=none; b=L8QKhlRYLmCzL6UFoJE8DMaW2kyFGEM7N3MS6hUjA/ORE/8eNPCzHKbH1OIL9baqMaZ99ajOkfpB2WzSbnjORT8KEpD8ceCo0adym7Y6jNPoD27BK7a+X6cPc0CMX6GV42mRwk0sjP3JCNxghsNX2fnbhI88G3m/ZybdPbdc75w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721268114; c=relaxed/simple;
	bh=KrPcq4/hLH5P9M6AaYrkpFo5h/XmWoGxiZd1Dz1MQm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c20qeKHR+PaS1/NxjJGaXfVlAFqgkt4dZlu+FLoxngVnjXlNACMXNrVKlqRK5XfNkACpQfNNX3WVd9z9bhM4+lZs8BpNUPdcrdv5gA+4Mz7C17/dCvWC+3Nimkadz8BmvJ3Ap64V6cPK5SsFbwdBVIR51z+9bkp/1CTS9CFdq+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KkOnNxyT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FvMTCdTuCrvmP1JH8uqoSuaXn+BwqRHQ/vvcRRPc4Sg=; b=KkOnNxyTRLxs3LD3AqN5wuZtpL
	LlHNYprsy0MHBgumO8VozBwGzqHtN+6fZMMREQEl+kybBSyfLjyik2siSRw0iep4toIqbSgknHxdx
	iQykIN4WbS/4tsgdqMJDFWKgoRcPyuvYC2zOOwZsFS00voVWzxa3wzbxbFD4PHNMPvHA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUGSp-002kXw-JM; Thu, 18 Jul 2024 04:01:47 +0200
Date: Thu, 18 Jul 2024 04:01:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	kuba@kernel.org, ryazanov.s.a@gmail.com, pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [PATCH net-next v5 17/25] ovpn: implement keepalive mechanism
Message-ID: <69bab34d-2bf2-48b8-94f7-748ed71c07d3@lunn.ch>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-18-antonio@openvpn.net>
 <ZpU15_ZNAV5ysnCC@hog>
 <73a305c5-57c1-40d9-825e-9e8390e093db@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a305c5-57c1-40d9-825e-9e8390e093db@openvpn.net>

> > > +		if (ovpn_is_keepalive(skb)) {
> > > +			netdev_dbg(peer->ovpn->dev,
> > > +				   "ping received from peer %u\n", peer->id);
> > 
> > That should probably be _ratelimited, but it seems we don't have
> > _ratelimited variants for the netdev_* helpers.
> 
> Right.
> I have used the net_*_ratelimited() variants when needed.
> Too bad we don't have those.

If you think netdev_dbg_ratelimited() would be useful, i don't see why
you cannot add it.

I just did an search and found something interesting in the history:

https://lore.kernel.org/all/20190809002941.15341-1-liuhangbin@gmail.com/T/#u

Maybe limit it to netdev_dbg_ratelimited() to avoid the potential
abuse DaveM was worried about.

    Andrew

