Return-Path: <netdev+bounces-119488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EAE955D69
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 18:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6304AB209A3
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DE0140E30;
	Sun, 18 Aug 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RXj7JlI1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4E22F2B;
	Sun, 18 Aug 2024 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723997797; cv=none; b=Ka8+AvzXmM35KLTuUZ27aULIh+7R/KyupAw5o4L4uNgJkCicKPeIPyVuQUmUjr5In0e4a340dVxDPa1U+TEyKwZXuHZKuogStWJP01wIggM4/7XQILiZaPNDRf/Y88b48b3ejYAHg9dBuuPBDX9uMbvvjQVH8ZdVfkQVav2qyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723997797; c=relaxed/simple;
	bh=FUyqW4rGJkqafGJCHxsTUuVhA48tTX/yRTmswYPeNOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kfx1wCwUQY3mWOx+UX1BfZRstQAcPxnAfm5mpDZgUtPEprTiyezPRiZowusrEBcP9uqdmu0FvjzzUr0H8Fhr9LRY+Y18h6ZLWMuKtt0KxDAN7Ec55RBtUjZazaRF68UXqRxQ6vWaog83oMaHjtuqMfA8gw8yc02lZiq+02gcuvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RXj7JlI1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8wTskSxIv0wLSkZTeiQD4Avh7+NVQ94NFj3FUOxRKaA=; b=RXj7JlI1UHWjJMKxd3D7uepPL/
	EYpNsX/bUOnsZX/x7j08EIdBQ6SSKnXCZT3cp6xLcg0h7Usz6eEbcpYlnGb0zyTcJ8Im/s4JMBwLJ
	L3zQ6N9LebSELNMkSP6K5TrUctgAqfB8+Cc5SBtn2NRXqeXX3oEAy4nupCehq9z61X2s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sfia0-0052jA-GK; Sun, 18 Aug 2024 18:16:32 +0200
Date: Sun, 18 Aug 2024 18:16:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 3/6] rust: net::phy implement
 AsRef<kernel::device::Device> trait
Message-ID: <cbb9e253-499d-4b11-93ae-63ea7cb9cfa3@lunn.ch>
References: <a8284afb-d01f-47c7-835f-49097708a53e@proton.me>
 <20240818.021341.1481957326827323675.fujita.tomonori@gmail.com>
 <9127c46d-688c-41ea-8f6c-2ca6bdcdd2cd@proton.me>
 <20240818.073603.398833722324231598.fujita.tomonori@gmail.com>
 <f480eb03-78f5-497e-a71d-57ba4f596153@proton.me>
 <1afb6d69-f850-455f-97e2-361d490a2637@lunn.ch>
 <2024081809-scoff-uncross-5061@gregkh>
 <fa0534e5-a4e9-45e5-a202-e4647c99c514@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa0534e5-a4e9-45e5-a202-e4647c99c514@proton.me>

> Thanks that's good to know.
> 
> >> So i have to wounder if you are solving this at the correct
> >> level. This should be generic to any device, so the Rust concept of a
> >> device should be stating these guarantees, not each specific type of
> >> device.
> > 
> > It should, why isn't it using the rust binding to Device that we already
> > have:
> > 	https://rust.docs.kernel.org/kernel/device/struct.Device.html
> > or is it?  I'm confused now...
> 
> It is using that one.
> I wanted to verify that we can use that one, since using this
> implementation users can freely increment the refcount of the device
> (without decrementing it before control is given back to PHYLIB). Since
> that seems to be the case, all is fine.

Any driver which is not using the device core is broken, and no amount
of SAFETY is going to fix it.

	Andrew

