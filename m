Return-Path: <netdev+bounces-78572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2947875C54
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 03:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A95B21787
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 02:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88AC23741;
	Fri,  8 Mar 2024 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JzlhCx7n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810E291E
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709864767; cv=none; b=KFYTNuzR8xszHeQ9QkNKz2U+vMz6DBRc60JmndR+R+neYOA3ypmzRNGsK5pQg8N/GCXiYjfBxILUV66+tnm21thTRP1k/KAPOkv4ksSFseJiqjwXjBenwSMvMNBd1XztZ0fRjEGUdLHXymZxCJ0aQ9DqKreOOir46snq4LElRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709864767; c=relaxed/simple;
	bh=s1JLAc4PAH9aBjrYgWwuOyG8veSxIbIMfdhTLKrMVvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpy+z+Pe80DDIiWYJyJlFWEchbYeYYUewBNPrFmrnAPUL9BFxkc+fM20JVyB7YnVcRXNNcC95Ef38y4kj5ZhIggQ8C/nc1cI5tayYLHxn4/jm2abw054AXE2CA96aA58XFmv8zpi7bTsS6/FlbFMSt5E8rutisGIE1vrONiTcso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JzlhCx7n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=21em1o6JMKTCjR7VeeXTTJJgpGTlfCTqkKqH0pvx56A=; b=JzlhCx7nUzkZB7eHE2s9TRfroC
	03Dkp5rys2khFjIYn5c+K0onYFALAjfkVXh+HzudFyYOOQqplVq0mBwZRSZb2Kmlb75/5yLGqdk5s
	sIILKIFXY3RXb7L7DPBzxGP3gLubh8ah1mdJP6MiU+qvzuFlN/F4DcyfK+A/NI7xm77g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riPwM-009irS-La; Fri, 08 Mar 2024 03:26:30 +0100
Date: Fri, 8 Mar 2024 03:26:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 02/18] net: move netdev_budget and netdev_budget
 to net_hotdata
Message-ID: <4b5e06a4-6263-4bf5-ae73-53210d8822e6@lunn.ch>
References: <20240305160413.2231423-1-edumazet@google.com>
 <20240305160413.2231423-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305160413.2231423-3-edumazet@google.com>

On Tue, Mar 05, 2024 at 04:03:57PM +0000, Eric Dumazet wrote:
> netdev_budget and netdev_budget are used in rx path (net_rx_action())

I think one of these is missing _usecs ?

  Andrew

