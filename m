Return-Path: <netdev+bounces-180206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E2A807A5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18FB1B67857
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5F626B0AB;
	Tue,  8 Apr 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vB6OLyX1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA381FCFF3;
	Tue,  8 Apr 2025 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115475; cv=none; b=oXwktML1xmehUJDdL353jwDvpD4FLNkuMZiv53mvNsT+EdZzo2W+I94TdXFPMjWM6cW0yCqJ18/+f6BB6vE5VXPyDo7AKsBllDDjpKk9UyZSrKgVSQ/z5x00iNkZbsFNVff7ii9zZ6DBFArPQdbP3eRXx+k2sz5eIMXb2Uwla98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115475; c=relaxed/simple;
	bh=p/ghdSD5tRFmRQ+/B1cU8r3YGNwZDGKF8u+VK+HD/qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnsYlToIr7qdFIwoyDWefjnefQD9BmhJLsfINtjHrzF0HazPhwUCxM5CtNRxd6qnMOyqtbUDJx1UiDECOEjGamgSt3odMbBaHhENDdinHFI+6W3kGlG92Q7/cyln8Dqf1ZUALZLFGzz/P0nRqVHVLZRzzTQStz3bxZndg+d5B5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vB6OLyX1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=osiFeAtYNvhZjK7QOjAMMpzXXsbIfZXhPXa+bj8kr3w=; b=vB
	6OLyX1gTzigGZ/wYoCqqnf6mt3xE5hk81buFo0dqBcwZ88yB1Ld4zmAJ+7hRwIZNzlRqDpvcHU5Mq
	ZXBYs9BbpqoLocUD6NlYIzh+tUpbhhHIH+3yrv+Sclyvf+ExKYUdnmJcwT0V3hx9GFjv9tcu0LR5L
	j7Tkk7mAY4TS71w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u286a-008O03-9n; Tue, 08 Apr 2025 14:31:04 +0200
Date: Tue, 8 Apr 2025 14:31:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] net: dlink: add support for reporting stats
 via `ethtool -S` and `ip -s -s link show`
Message-ID: <66d0e7c7-c881-4d70-affc-4f97d485b249@lunn.ch>
References: <20250407134930.124307-1-yyyynoom@gmail.com>
 <122f35a6-a8b6-446a-a76d-9b761c716dfe@lunn.ch>
 <Z_RNtOY5PPS5A9v4@mythos-cloud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_RNtOY5PPS5A9v4@mythos-cloud>

On Tue, Apr 08, 2025 at 07:12:04AM +0900, Moon Yeounsu wrote:
> On Mon, Apr 07, 2025 at 10:43:41PM +0200, Andrew Lunn wrote:
> 
> > That is an odd way of doing it. It would be better to repeat the
> > static const struct dlink_stats.
> 
> Oh, I see — sorry about that. I wasn’t aware it might be considered an odd approach.
> If you don’t mind, could you please explain a bit more about why it seems problematic to you?

How many other drivers do you see doing this?

> Let me briefly share my reasoning behind the current design:
> Each ethtool stats function (e.g., get_ethtool_XXX) gathers a specific group of related statistics.
> You can see this grouping in action in my patch.
> So, I thought managing each stat group in that way would make the code more intuitive,
> and help simplify the logic for developers who use or extend it.

Just to be clear. Using tables is fine. It is just the way you have
declared the tables. You have basically done

unsigned int x, y, z.

If everything is on one line, the , syntax is fine. But you have x, y
and z spread over multiple pages. In such a situation, you would
repeat the unsigned int for each of x and y and z.

> I'm still new to kernel development, so there are many things I don't fully understand yet.
> I'd appreciate it if you could feel free to point out anything.

Take a look at other merged drivers. If you are doing something which
other drivers don't do, maybe ask yourself, is what you are doing a
good idea. In order to keep maintenance simpler, we ideally want all
drivers to look similar. So rather than inventing new code, just find
a driver which is roughly doing what you want and copy/paste it as a
starting point.

	Andrew

