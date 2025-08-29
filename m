Return-Path: <netdev+bounces-218366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 443A8B3C35F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 21:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3ECAA61A91
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 19:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9CB23C8C5;
	Fri, 29 Aug 2025 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zwZhqTHR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903E194A73;
	Fri, 29 Aug 2025 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497155; cv=none; b=lPrnZUKdwYtkrWo20vD8gurnqz+BuNJs0f7tW5G6PolXwuji0x3DjGjt9dvEKKZOzN6dHUYMkg66AikZR+eJUwnlJBx+SCIHNi2Ynggd8tG07Bif5YIjC9+dFRg/92NKvxyKAVGwe1kg0F5AMNRJs3GLt6ig9PuL7yucpeVkfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497155; c=relaxed/simple;
	bh=ChvIJWKEC6s+3LK+FLtopre8G36jlo5cLmYZ/FGqvnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvQtGKt4G3af5FvWystI8/w4cucnXIgRWt0RMMuIw4QNiFJhbPAzqOvLA0g/+R02uDbyFcHlRFlylzG41EUpIExMa4291E5aA0Nu0VFgLzMUoyAemGLW2qmYrPg2rZwjqsOrFTltTJhtP4fuXfNEjRGZqJrg1wCknTPTQjfbJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zwZhqTHR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y4KVxJHmhDFWTR5pXvw/TwXvMqcEZJZ+w1kiLOpENJA=; b=zwZhqTHRqhRyEwB03s3U0aPZQK
	6AgKhCpSMnzB0f70EYuDnshBkt1bCHvxsPKq/ao7Ej/0132XXGYwOkqKTZjX59f5Zytspns4nq8lt
	pESVQPmmTdErX/IWHu4NcoXjyK8lLE2ZSsCZpKogYBCz+Ov47zDnBWmnhTFncs6NsukE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1us58f-006WHG-Im; Fri, 29 Aug 2025 21:51:57 +0200
Date: Fri, 29 Aug 2025 21:51:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v9 5/5] net: rnpgbe: Add register_netdev
Message-ID: <6768f943-e226-4d57-b3a8-692aff4cc430@lunn.ch>
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-6-dong100@mucse.com>
 <e0f71a7d-1288-4971-804d-123e3e8a153f@lunn.ch>
 <A5B215AE5EB4FE9D+20250829023648.GB904254@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A5B215AE5EB4FE9D+20250829023648.GB904254@nic-Precision-5820-Tower>

> > Back to the ^C handling. This could be interrupted before the firmware
> > is told the driver is loaded. That EINTR is thrown away here, so the
> > driver thinks everything is O.K, but the firmware still thinks there
> > is no MAC driver. What happens then?
> > 
> 
> The performance will be very poor since low working frequency,
> that is not we want.
> 
> > And this is the same problem i pointed out before, you ignore EINTR in
> > a void function. Rather than fix one instance, you should of reviewed
> > the whole driver and fixed them all. You cannot expect the Reviewers
> > to do this for you.
> 
> I see, I will change 'void' to 'int' in order to handle err, and try to check
> other functions.

Also, consider, do you really want ^C handling? How many other drivers
do this? How much time and effort is it going to take you to fix up
all the calls which might return -EINTR and your code is currently
broken?

	Andrew

