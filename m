Return-Path: <netdev+bounces-119482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D43955D4C
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 17:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210111C20892
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECD112B93;
	Sun, 18 Aug 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZWftPdMA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78562B674;
	Sun, 18 Aug 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723995954; cv=none; b=cm4XfB3lfqU9stMLo3LlzCh3dWaIyS4skDSTgkqrSriPC5avAigzjFozvVaxNy6NGZCyWCL1uQsjLlSEruwa2U5d1jjf3G7hkmQxfiOEzA/bmfzHRJgcWp7gv6sZDz+3zoCZxRzYCQ1uqsmcHJmoqHf+V0+Pe2g1YR+le+Xi/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723995954; c=relaxed/simple;
	bh=z9xApdF1WMxrW6YLFwWjHhD1OkHoOIrmh6OlJtErj90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgrLbJWCGHYE/08rtomYifNGv/Lfq/7sKLubqz4mniS/mbTUrTTGDYGzX3QMTpJTlWkB4zZTLwFdpfqJF1QYavlKW0SZoV6u58XRZeYfvHHMfBeVR51NEI50usYDwxd10tBPOXtHZRsh0b7jdcU4ZB33DcMm4vjrzDMTYX8ktck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZWftPdMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD23C32786;
	Sun, 18 Aug 2024 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723995954;
	bh=z9xApdF1WMxrW6YLFwWjHhD1OkHoOIrmh6OlJtErj90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWftPdMA5pK5X9LZNPBRSp2LTEMk/cIWoXcpnNp1IN2HYIVXW9bKARsQJsGA9r2gJ
	 wdwkedUc/sXZuovMfk2EOUVuALqKR7aCEee/awF67LRqIVl5fXrWna56qIgwzRv4CM
	 CWv/706cZl9qb/PGq6EGnyXRlADg+tEa9/cN+bP8=
Date: Sun, 18 Aug 2024 17:45:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Benno Lossin <benno.lossin@proton.me>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 3/6] rust: net::phy implement
 AsRef<kernel::device::Device> trait
Message-ID: <2024081809-scoff-uncross-5061@gregkh>
References: <a8284afb-d01f-47c7-835f-49097708a53e@proton.me>
 <20240818.021341.1481957326827323675.fujita.tomonori@gmail.com>
 <9127c46d-688c-41ea-8f6c-2ca6bdcdd2cd@proton.me>
 <20240818.073603.398833722324231598.fujita.tomonori@gmail.com>
 <f480eb03-78f5-497e-a71d-57ba4f596153@proton.me>
 <1afb6d69-f850-455f-97e2-361d490a2637@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1afb6d69-f850-455f-97e2-361d490a2637@lunn.ch>

On Sun, Aug 18, 2024 at 05:38:01PM +0200, Andrew Lunn wrote:
> > Just to be sure: the `phydev.mdio.dev` struct is refcounted and
> > incrementing the refcount is fine, right?
> 
> There is nothing special here. PHY devices are just normal Linux
> devices. The device core is responsible for calling .probe() and
> .remove() on a device, and these should be the first and last
> operation on a device. The device core provides refcounting of the
> struct device, so it should always be valid.
> 
> So i have to wounder if you are solving this at the correct
> level. This should be generic to any device, so the Rust concept of a
> device should be stating these guarantees, not each specific type of
> device.

It should, why isn't it using the rust binding to Device that we already
have:
	https://rust.docs.kernel.org/kernel/device/struct.Device.html
or is it?  I'm confused now...

thanks,

greg k-h

