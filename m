Return-Path: <netdev+bounces-216911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1643AB35F40
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5931BA0A80
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C825D31987F;
	Tue, 26 Aug 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XkUpTeyD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F4307484;
	Tue, 26 Aug 2025 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211992; cv=none; b=vFpNTNHTSrf4SVzJb9P6v81x1kyjIKXEyOYeTwrcBkMAPKGKMr9CYiXIQl95mf6vmkOtu3FxDsN8PQ7ORGzSa7TwJFipOF6WZg5OuqitBj3jAqQEGEAuutnOK5EKXhRLm3Du+kDuh2rMBwp/qAzRfnKtweRh1kSv+PxojXbxApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211992; c=relaxed/simple;
	bh=dGnNrQX6SngfoB1qpiDdPYhk6mxxMtMJBb9fvgJBWyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIiN9+OXwYXUVJCN+6v0GHPvqQE0jyCYvbRI1F/t1t/DXXSgWftlGsNRLfYcxul4A9dNPg2J9173/NsFNkmSF8Q5KE3PQRj8P61k8KgqPwc2XbLqKXf3V5y1CzSK2ftSSs4Y/F2u08CHBif/uaJMJTYb/QOZAUt7T12AoiQH3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XkUpTeyD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QkbnYSmWkM3Cx83RhzgKWrax3iNbj9sbt9f1CZxZlq0=; b=XkUpTeyDhuNXtl3P+qO3sjmTHV
	AfgkITj/OVg/BiD7malHlPDfwTI1ZRY1CFJA8Ic1Ekk//PlTLVyBWgBxUPJ13/0zQ0+cX0eYo39L5
	/8gNSuA1IsCwfpjesX8tu0OK8oPsuzwIYtksuY4mpvnyohEYwzWFDk3WjjeR2whwT1EY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqsx9-0065cW-2s; Tue, 26 Aug 2025 14:39:07 +0200
Date: Tue, 26 Aug 2025 14:39:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <bd1d77b2-c218-4dce-bbf6-1cbdecabb30b@lunn.ch>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <316f57e3-5953-4db6-84aa-df9278461d30@linux.dev>
 <82E3BE49DB4195F0+20250826013113.GA6582@nic-Precision-5820-Tower>
 <bbdabd48-61c0-46f9-bf33-c49d6d27ffb0@linux.dev>
 <8C1007761115185D+20250826110539.GA461663@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8C1007761115185D+20250826110539.GA461663@nic-Precision-5820-Tower>

> Yes. It is not safe, so I 'must wait_event_timeout before free cookie'....
> But is there a safe way to do it?
> Maybe:
> ->allocate cookie
>   -> map it to an unique id
>     ->set the id to req->cookie
>       ->receive response and check id valid? Then access cookie?

This is part of why adding cookies in a separate patch with a good
commit message is important.

Please take a step back. What is the big picture? Why do you need a
cookie? What is it used for? If you describe what your requirements
are, we might be able to suggest a better solution, or point you at a
driver you can copy code from.

	Andrew

