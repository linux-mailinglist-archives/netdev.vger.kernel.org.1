Return-Path: <netdev+bounces-213955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6D4B277A2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 06:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBE1722F32
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340481CD215;
	Fri, 15 Aug 2025 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JU8/sim9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B013FEE;
	Fri, 15 Aug 2025 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755230887; cv=none; b=WQjiqEa30Y8/T/GLiLZuruS8JdSIOMiuBCLu3cc+2Ra33cxVZnSk0GnOHN4/+WBFIpDC+56kSjNgdE+tmy49TQLQy3qnpo1z9wV5SUyRnwbq56TOzSD/KZ364F1t40hTrqF72AT8FNR8LdGKXXSMDNoj9zVd0cdkG3tU/RHHuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755230887; c=relaxed/simple;
	bh=D+6W3XJNV1CjXkDZdn6IEYlQBJoxfn7zvGJ+fWx4njk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1qUHqgOkbBTzqdxiXYuoSTMNjPXLrynp1uJk+RAzqFn3zUC6vIXrXgbnz/6348DOTkM+jO2Np7vsGf7MIhV1KfvglwjLDIoxrpjwfw2u5WeyFUjbeN9dcYk/wa50baDtyN9S//tLLi9JrpSwKGwdy5a58lImZpwi+G2+Tf6I1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JU8/sim9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZRd3lPF/jp54o/xsDfYASXzAEXV60quLPJGLeCwcw8w=; b=JU8/sim9ZhE2nGPIG7n4He5hVz
	aEoTPYAXqiF34y9V4el955qI5AqX0lzE2/xDlzo9tIj1urZ/V7A3oRn+vFPit6OaDKTqEzkRO2Udp
	M0L4vlgSQ3eryqI56N0hUaglsXvC5qJo6SDxQQBQ81+hhqYl9bXLsVwamRoxG4E+Y5Hk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umlix-004mhq-O1; Fri, 15 Aug 2025 06:07:27 +0200
Date: Fri, 15 Aug 2025 06:07:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <4be8e875-d8a0-4f3c-8305-5b0787039826@lunn.ch>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-4-dong100@mucse.com>
 <a0cd145c-c02e-40da-b180-a8ca041f2ca3@lunn.ch>
 <D19BDA0A798B918F+20250815013153.GA1129045@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D19BDA0A798B918F+20250815013153.GA1129045@nic-Precision-5820-Tower>

> By the way, how long should I wait before sending the new version? If it
> is too frequent, it might cause reviewers to check old versions and miss
> feedback, link what happened with this mail. And if it is too long, it
> is easy to miss the 'open window'....

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Says at least 24 hours.

But i have been away from emails for a few days, so i was slower than
usual.

Most patches get reviewed in 3 work days. So i would probably not wait
much longer than that. But also wait for any discussion about a patch
to come to an end.

Also, different subsystems work are different speed. 3 days would be
way to fast for USB for example, that would be more like 2 weeks.

	Andrew

