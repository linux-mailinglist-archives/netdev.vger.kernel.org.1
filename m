Return-Path: <netdev+bounces-177217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD470A6E4B1
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6D77A5AD4
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB68F1E0DE4;
	Mon, 24 Mar 2025 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mueHOBzl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B581C7015;
	Mon, 24 Mar 2025 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849446; cv=none; b=o1c1KE6FpuagTcMiW5hHmIzaxXHJeeUYFyoPUnOz4xiOMGSWhsRFl7o6TWS7Xd7XPu11JOQhdMwGykF8FKa1a6wl0VgBmkucdqjNYaFcnvhpnHlUR1eX2nIdbFG5eGNfFUiNwT/4txgC2KwiKrUhFHZJmAehj9zR75cPJWqmFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849446; c=relaxed/simple;
	bh=MchipAU5sBxM6kqrzJJM5frG3EbJ8KvRCbLn29uzQWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POPak3eD8KPbyLUgFEuUNBO7XdwIqRXk32azaEn5uxgs+alkxXVNDhmXxH28MJSsQrqriBjwPEiDdfCKMH9slMhhTXJytebNRiaJkmgjPigBhacfkdAJY2P3xfgOYZaUdzXaqEGHCxi8Hsgs3WZfP5heMa7US3SsTLj097Iswkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mueHOBzl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HAcr7heHKfjYqqnB0DRD0tmxyXkvWOjnx1sWFmHXfG0=; b=mueHOBzl+J4JC5t+d0W9a3FfE4
	KwhcgSL+St4ME6gir5KTdD6LAANvQKFBrlli1ptD1OPxqk9L+mHl3pwnOnBw/oSWayovllrVFs25a
	hOHy/YknptRyIovlS5eQmOo/8KUoW/YTI3l//NfqKPrH/08mjFf5cDOoCv9kYp67la6s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1twokm-006yql-DQ; Mon, 24 Mar 2025 21:50:36 +0100
Date: Mon, 24 Mar 2025 21:50:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: add a debugfs files for showing netns refcount
 tracking info
Message-ID: <59446182-8d60-40a0-975f-30069b0afe86@lunn.ch>
References: <20250324-netns-debugfs-v1-1-c75e9d5a6266@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-netns-debugfs-v1-1-c75e9d5a6266@kernel.org>

On Mon, Mar 24, 2025 at 04:24:47PM -0400, Jeff Layton wrote:
> CONFIG_NET_NS_REFCNT_TRACKER currently has no convenient way to display
> its tracking info. Add a new net_ns directory in debugfs. Have a
> directory in there for every net, with refcnt and notrefcnt files that
> show the currently tracked active and passive references.

Hi Jeff

CONFIG_NET_NS_REFCNT_TRACKER is just an instance of
CONFIG_REF_TRACKER.

It would be good to explain why you are doing it at the netdev level,
rather than part of the generic CONFIG_REF_TRACKER level. Why would
other subsystems not benefit from having their reference trackers in
debugfs?

	Andrew

