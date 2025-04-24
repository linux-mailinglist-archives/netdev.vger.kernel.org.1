Return-Path: <netdev+bounces-185716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE62A9B850
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 21:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776C54A7AEA
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6E28B507;
	Thu, 24 Apr 2025 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0c45kd5t"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC8E27BF78;
	Thu, 24 Apr 2025 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522993; cv=none; b=uZJjzsebVaTFYAqW9tMvA5fJO9S4q+wGK0Wpbsu25VhDBNsDM1Bz/txSAwfOrFWex8WP98lVyWFPWqB4BFC2M8zri5m1zjti5Y1HXARZg4nsZy6q/hKbWxIiBpVFL25kzsbyYuSE42M8ypTZJ/FsKWDwR8H8ndcaeXlk8f+1/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522993; c=relaxed/simple;
	bh=0KxV1oiJarlARRrwUoiF+qGQ6NtwTYlVWfuv378HTIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwk/D2SUDZKv7sYACuuYuEOBWuLHtkRsNAFYha9f4Nzx6rj7wlQ3Q5YQ4g5v2oW1qxN1KKveQyLG9S8Cj7pES6tSz6fo+8xcHtG5xlVvVgg3V8FmQOPvkgOJixro5tjn6A+HQphYD5rc/VzBKgXYjvAgmAuyjOJMJv9+Bz/4RMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0c45kd5t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9jzZQl76R84Oa8XlcWJ7QPYpDqaWeqxNenpTzRG2+nA=; b=0c45kd5tR44F2awOml2K6LyJhl
	aHfAeuVHMTMdo+ql7LRy2yAmCtXSqPpPh8oDmKwpoEMYQRvTfjx5YmAgXOJ4aMbZnlVnTA5z6n9dA
	//WAp2wxjRNIaCaqH7yQ0GmbupUZoKwAVzrfbAU4AFoCA6Y7RpsVZPZ2+4Q6whpGYZBo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u82GP-00AVOe-1p; Thu, 24 Apr 2025 21:29:37 +0200
Date: Thu, 24 Apr 2025 21:29:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
Message-ID: <98ae9365-423c-4c7e-8b76-dcea3762ce79@lunn.ch>
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-6-ivecera@redhat.com>
 <5094e051-5504-48a5-b411-ed1a0d949eeb@lunn.ch>
 <bd645425-b9cb-454d-8971-646501704697@redhat.com>
 <d36c34f8-f67a-40ac-a317-3b4e717724ce@lunn.ch>
 <458254c7-da05-4b27-870d-08458eb89ba6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458254c7-da05-4b27-870d-08458eb89ba6@redhat.com>

> Yes, PHC (PTP) sub-driver is using mailboxes as well. Gpio as well for some
> initial configuration.

O.K, so the mailbox code needs sharing. The question is, where do you
put it.

> > The mutex needs to be shared, but that could be in the common data
> > structure.
> 
> Do you mean that sub-device would access mutexes placed in zl3073x_dev which
> is parent (mfd) driver structure?

Yes.

	Andrew

