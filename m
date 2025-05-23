Return-Path: <netdev+bounces-193152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D4AC2AB7
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 22:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0751B9E31F4
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 20:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1891CEAA3;
	Fri, 23 May 2025 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0jjTD3NL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C961A315A;
	Fri, 23 May 2025 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748030864; cv=none; b=cQdm0C0cO+3eo60EchQo8NaOxycklt4H90iVjuS59+IJxLd++dOhWPfRAJsCtAHOREHQaoZ06Lk0HvUFvDwSJEWNzIfbgz3UOYc4VBV9XCBD9jPozJFebGmQvAh7UjvmfcJKxKOK2zm1Z4VcYCGZMzleGEGZ/mpBWOdUl5B6oZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748030864; c=relaxed/simple;
	bh=D2mgw63jXUUEJoMo9HaShlPKpHm/ZIDplyAHvQbmZ5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYopumg0tBfQ3wUdrss3ADQcKv4hsWvXgZQFGOYRIKDYkpxrsSvQu8Nspl5hgtZxRR8onSZw/Sh6PqPhSfJM1f6dxyhrjZKEpa3HLZrJb8svS+bx1v8iUHOnpLzT/NaMgPTaypA+hU9cwRT9eWvhSHcvjPxUsS1aA3UzVJlqN8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0jjTD3NL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gAyIsHp9u9c/VEO2is/zAGA5jdT02MlM2owOkmGGNvU=; b=0jjTD3NL0TcmCPZnxEvUKOqa7w
	ycdSvlaL8MppjWbq75socO16PkXQwrcJ6QkPCIPTEvLR4mPrzy84t2O+Lzc61zHDA++zbQl8aaAS+
	i+Je8eLO6aa7GMBXcJ7HKb1xw5q+rhWLkzcYTEp6mGxCnjpeWeJNisnlBycr3dy7SjXk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIYfR-00De9m-9e; Fri, 23 May 2025 22:06:57 +0200
Date: Fri, 23 May 2025 22:06:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: Alex Elder <elder@ieee.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Silicon Labs Kernel Team <linux-devel@silabs.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
Message-ID: <db54fe16-ae7d-410c-817b-edb4faa6656c@lunn.ch>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
 <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
 <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
 <D9W93CSVNNM0.F14YDBPZP64O@silabs.com>
 <65cc6196-7ebe-453f-8148-ecb93e5b69fd@ieee.org>
 <DA3STV21NQE0.23SODSDP37DI7@silabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA3STV21NQE0.23SODSDP37DI7@silabs.com>

> I don't really know about UniPro and I'm learning about it as the
> discussion goes, but one of the point listed on Wikipedia is
> "reliability - data errors detected and correctable via retransmission"
> 
> This is where CPC could come in, probably with a different name and a
> reduced scope, as a way to implement reliable transmission over UART,
> SPI, SDIO, by ensuring data errors are detected and packets
> retransmitted if necessary, and be limited to that.

You mentioned HDLC in the past. What is interesting is that HDLC is
actually used in Greybus:

https://elixir.bootlin.com/linux/v6.15-rc7/source/drivers/greybus/gb-beagleplay.c#L581

I've no idea if its just for framing, or if there is also retries on
errors, S-frames with flow and error control etc. There might be code
you can reuse here.

	Andrew

